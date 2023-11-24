Return-Path: <linux-fsdevel+bounces-3606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA77F6BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29F61C20AA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5BBB661;
	Fri, 24 Nov 2023 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GEO3n6mU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37001BE;
	Thu, 23 Nov 2023 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dygXiWQj01+v+M8EqnLDmRAM15rjFqh51JbrrIY5KXg=; b=GEO3n6mUIzHm/NcIO+KXB6pvDF
	YjpRn42VkFVF2oPiXcmD95jtOpAnBkD/76OIfMA+JcOc3JTiVQfnd9AE819o1KMxoiaGq+m/jrIEz
	xl+LohwoqM6vHCxrJL5qAyZQTGntOwiZtnhU2BcUpdBB01BvckPlSu2v0Hc5kwk3i4Y9uurjqY+Nn
	YEc+6fjdoil80r2X5hKMDq4IuSKhh9VQSIaPjjv7fESvwQUS0nknbz4rH9SB3AgmZPz/KWKFNpoCO
	QT/F+jl2Olw/poIVBarWzLKbmKtpMnAG23aaiGedmvjJ/ciepTyUFywSkyGYjIGLJ4bg5c0WAiRAR
	BGQRivFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIe-002PuT-0U;
	Fri, 24 Nov 2023 06:04:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/21] __dentry_kill(): get consistent rules for victim's refcount
Date: Fri, 24 Nov 2023 06:04:12 +0000
Message-Id: <20231124060422.576198-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2e74f3f2ce2e..b527db8e5901 100644
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


