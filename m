Return-Path: <linux-fsdevel+bounces-2483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C507E63C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFA72816CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93C10A0A;
	Thu,  9 Nov 2023 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xr6xK9r5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE31E574
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:03 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E7D26BC
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fqgEuHsebdDpFMPtEzF/nzVbQVktYGU1hkEJxaEkZjE=; b=Xr6xK9r5kYOj73ojc91FN+5yZG
	mirO/VPTyTgtXSwxxlDhaOKi8ekNzq3J9akpgNCa0TBF3V3v+TTXWHUzMRsrsOxZXjJQImoML8Ut6
	VByJJ6e2y6/PkUJg3DjKUjoRFrarkV+BrjLmySK3b2+EmWQsRST9Ifx1sAg09uXIttzkK8MBBNc+c
	6X+tdvq38iEedN0B3OO+cAe07z+nakrGw7jwv/KEyIzYUqwcztLTkJlm5p0Pa+L5H5u7yvV/52GBD
	GhhX2cou0tEeHnRZ0TBZZIaQASZyIxL1pzA2OtLhrbufTEJ6SD975JGsu6p0pPRwy6s0NQwncSCF4
	5gMkOtqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPS-00DLk8-0h;
	Thu, 09 Nov 2023 06:20:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 13/22] __dentry_kill(): get consistent rules for victim's refcount
Date: Thu,  9 Nov 2023 06:20:47 +0000
Message-Id: <20231109062056.3181775-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently we call it with refcount equal to 1 when called from
dentry_kill(); all other callers have it equal to 0.

Make it always be called with zero refcount; on this step we
just decrement it before the calls in dentry_kill().  That is
safe, since all places that care about the value of refcount
either do that under ->d_lock or hold a reference to dentry
in question.  Either is sufficient to prevent observing a
dentry immediately prior to __dentry_kill() getting called
from dentry_kill().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1f61a5d03d5b..d9466cab4884 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -729,6 +729,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 			goto slow_positive;
 		}
 	}
+	dentry->d_lockref.count--;
 	__dentry_kill(dentry);
 	return parent;
 
@@ -741,6 +742,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	if (unlikely(dentry->d_lockref.count != 1)) {
 		dentry->d_lockref.count--;
 	} else if (likely(!retain_dentry(dentry))) {
+		dentry->d_lockref.count--;
 		__dentry_kill(dentry);
 		return parent;
 	} else {
-- 
2.39.2


