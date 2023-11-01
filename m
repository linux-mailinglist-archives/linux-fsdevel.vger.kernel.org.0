Return-Path: <linux-fsdevel+bounces-1695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD17DDC83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1481A281A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C463B4;
	Wed,  1 Nov 2023 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KZ9rrlK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB84C9D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:17 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6D109
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bVAC0xn/T//BfwlaeunxSYF+WLil1xBRbyJlVwXrimo=; b=KZ9rrlK/37OftthbMYIHj35NVO
	U2MPqS6MfRmCHf3SS90oA4P2dasHYlacKGSjWiqiakNA78wHLNZxz7OXYOD+sU0nCoL7w7a7vgYzj
	9KXPY8QPIRkxVX75no96H/uKabr+ou1/9jpUQyAURAnMI+RhRsEolg2YJR+lNcTQILESKkrWXJLUK
	fNadKDsrjC155MW+X4zc3QWmYurd/ruv9ileL9qaD/uQBXDyN/vMya+4Slfb9SLTMWd/EDQ8kHB/+
	NxivTy9E5B1/waIWrZ5b4DxRfKxFWG8V9l3IqGjatdlb9CPRej+hpj57/UA0qQzaH+fL5NWbPrs8g
	lr/IEbdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bB-008pbI-0n;
	Wed, 01 Nov 2023 06:21:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/15] __dentry_kill(): get consistent rules for ->d_count
Date: Wed,  1 Nov 2023 06:20:55 +0000
Message-Id: <20231101062104.2104951-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently we call it with ->d_count equal to 1 when called from
dentry_kill(); all other callers have ->d_count equal to 0.

Make it always be called with zero ->d_count; on this step we
just decrement it before the calls in dentry_kill().  That is
safe, since all places that care about the value of ->d_count
either do that under ->d_lock or hold a reference to dentry
in question.  Either is sufficient to prevent observing a
dentry immediately prior to __dentry_kill() call from dentry_kill().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0114b5195535..c89337ae30ce 100644
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


