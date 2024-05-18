Return-Path: <linux-fsdevel+bounces-19701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F58C8ECF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 02:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC0BB20E25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 00:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED914804;
	Sat, 18 May 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or3oAeLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43636C;
	Sat, 18 May 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990932; cv=none; b=SpYz/csIg+ALDV5Vz5ps7N7wIpOc4W3u9bgNrmPzfYGzSz1vgcVNkQ3xIddCwoqaXMB/KhaCEPJoI9GIax1TBlMRoA3m0vYOufaBSQTXISjQTWKJO3nInIVZfBtCLBJGjqxizb8eRmt3wHbYDRL4LZ+F8NANvm+gIgwIAZEak2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990932; c=relaxed/simple;
	bh=XddRyAzMMAr6k94Cu0OG7LY8xJUwzxmDPkYByLaRnTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xqu97T/C/ukpqs/n+n3g9qfxt+gE3vTi5p7ZyDG3ApinZUmSrYgQ8qFGHS3GMPCL6PoeLJ3MswkeuMaRRu048lo0XMBLbqlzVNzNGPdtAzUWKZqz+O3wJDos913146NOH1vu7a+6i0C+zlCzA7j7HYbmVszj75DFmkEzNer7jI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or3oAeLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01863C2BD10;
	Sat, 18 May 2024 00:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715990931;
	bh=XddRyAzMMAr6k94Cu0OG7LY8xJUwzxmDPkYByLaRnTg=;
	h=From:Date:Subject:To:Cc:From;
	b=or3oAeLzyYGvqK2bwSHNdomvv5gej6h96EwXqci0YtiLsI/EZbTOC9P3VdSsxe8VK
	 vbMi0KZoqhHFdBMZAFFSsimNWyTZyGYZbtozn0KB6mHfIc2mg1dxmEf3r4Lp3xVAvC
	 fewnNf8T+rV1N1WPMrF8YQl0WTjTne+GGci2ComtAK4qzWLSx/Em5bG0AQ9Jpv48VW
	 X1/hqmkRxGA+IK2XIZnmSEVv1D4Zby976yF9nGFP7hJfsbUALh0J08BDMQB2bf8Nyh
	 ADz5SQmgbMjLA+18doCS4cBbPqyt54/vd+Mh6r76d3sJ2Xxh1jqdHcus1zF8kFQ9RR
	 KQqdJlTfptUZw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 May 2024 20:08:40 -0400
Subject: [PATCH] fs: switch timespec64 fields in inode to discrete integers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIfxR2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Nz3cTckszcVF0zi0Tz1KRkc7M0E1MloOKCotS0zAqwQdGxtbUAN6l
 2AFgAAAA=
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5022; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XddRyAzMMAr6k94Cu0OG7LY8xJUwzxmDPkYByLaRnTg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmR/GSacpvmvSsOw300J6MvHPREYisCpJmXAch9
 2z5fxKkXwuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZkfxkgAKCRAADmhBGVaC
 FR5TD/wIrMBJQ47QjlFhHhjaVRpi8yTTGDMzodUfIWqIhgzaL1o8D+OVvOxTmH3w7lnBW9tEv5i
 3z917CPfm7DdOROQLNF7i+aQtIX8qi+zFK9dkn1ErsUBxzlFgznOwcz/+KWAJf38NsGhfFSORjj
 Ycp5td4mFwNs5uW7nLEIMkevX8mtqVmTbweya0Aw0PtUOPrrtfDt/9t2SBCsWVwW7iNzzgg/vvd
 GilrljJb+SY/rvfL8M5358/bT0mteq3eVxKI+AM1gs1OQ6Qrhg0lBaK/g/xpYz4yve3iUI1MRDB
 e718nEcD4kw1kAdgtBCqeXN3+hJDRMDmA9KoW01jkYX0EJXWJpTL6G3I3pmmdEeBIinORHt7uJ+
 N9IdsfJjZPEebUPLRJcaXWG+Q33GDLXE9Ap43lDqMdysrxwSwTVYJGY2U/zFLPQ9Wv44yJBFZ0H
 r8ZODHXa4LvEWjoorPw0nybhss+zSc7w5UbaBlVjT8FVPpPxeF7LaYRRKs01S/oCq7s8XesMbel
 WRGcc35ntAwOSv21l34Gs9AYAIqecykolKPO1/m0zfabfUG88YgU1K6eWTYV3tyLMk7dwxX5UQg
 ofI61WUwo+EEN/i/7St7w0cfHwyaUYVdRTYNRqDQiAUje5W5QsDcZx4jU6da3AjtWn/pnkANUpL
 ve4FsWXdV9iOC5A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Adjacent struct timespec64's pack poorly. Switch them to discrete
integer fields for the seconds and nanoseconds. This shaves 8 bytes off
struct inode with a garden-variety Fedora Kconfig on x86_64, but that
also moves the i_lock into the previous cacheline, away from the fields
it protects.

To remedy that, move i_generation above the i_lock, which moves the new
4-byte hole to just after the i_fsnotify_mask in my setup. Amir has
plans to use that to expand the i_fsnotify_mask, so add a comment to
that effect as well.

Cc: Amir Goldstein <amir73il@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
For reference (according to pahole):

    Before:	/* size: 624, cachelines: 10, members: 53 */
    After: 	/* size: 616, cachelines: 10, members: 56 */

I've done some lightweight testing with this and it seems fine, but I
wouldn't mind seeing it sit in -next for a bit to make sure I haven't
missed anything.
---
 include/linux/fs.h | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b7b9b3b79acc..45e8766de7d8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -660,9 +660,13 @@ struct inode {
 	};
 	dev_t			i_rdev;
 	loff_t			i_size;
-	struct timespec64	__i_atime;
-	struct timespec64	__i_mtime;
-	struct timespec64	__i_ctime; /* use inode_*_ctime accessors! */
+	time64_t		i_atime_sec;
+	time64_t		i_mtime_sec;
+	time64_t		i_ctime_sec;
+	u32			i_atime_nsec;
+	u32			i_mtime_nsec;
+	u32			i_ctime_nsec;
+	u32			i_generation;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	u8			i_blkbits;
@@ -719,10 +723,10 @@ struct inode {
 		unsigned		i_dir_seq;
 	};
 
-	__u32			i_generation;
 
 #ifdef CONFIG_FSNOTIFY
 	__u32			i_fsnotify_mask; /* all events this inode cares about */
+	/* 32-bit hole reserved for expanding i_fsnotify_mask */
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
@@ -1544,23 +1548,27 @@ struct timespec64 inode_set_ctime_current(struct inode *inode);
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {
-	return inode->__i_atime.tv_sec;
+	return inode->i_atime_sec;
 }
 
 static inline long inode_get_atime_nsec(const struct inode *inode)
 {
-	return inode->__i_atime.tv_nsec;
+	return inode->i_atime_nsec;
 }
 
 static inline struct timespec64 inode_get_atime(const struct inode *inode)
 {
-	return inode->__i_atime;
+	struct timespec64 ts = { .tv_sec  = inode_get_atime_sec(inode),
+				 .tv_nsec = inode_get_atime_nsec(inode) };
+
+	return ts;
 }
 
 static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_atime = ts;
+	inode->i_atime_sec = ts.tv_sec;
+	inode->i_atime_nsec = ts.tv_nsec;
 	return ts;
 }
 
@@ -1569,28 +1577,32 @@ static inline struct timespec64 inode_set_atime(struct inode *inode,
 {
 	struct timespec64 ts = { .tv_sec  = sec,
 				 .tv_nsec = nsec };
+
 	return inode_set_atime_to_ts(inode, ts);
 }
 
 static inline time64_t inode_get_mtime_sec(const struct inode *inode)
 {
-	return inode->__i_mtime.tv_sec;
+	return inode->i_mtime_sec;
 }
 
 static inline long inode_get_mtime_nsec(const struct inode *inode)
 {
-	return inode->__i_mtime.tv_nsec;
+	return inode->i_mtime_nsec;
 }
 
 static inline struct timespec64 inode_get_mtime(const struct inode *inode)
 {
-	return inode->__i_mtime;
+	struct timespec64 ts = { .tv_sec  = inode_get_mtime_sec(inode),
+				 .tv_nsec = inode_get_mtime_nsec(inode) };
+	return ts;
 }
 
 static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_mtime = ts;
+	inode->i_mtime_sec = ts.tv_sec;
+	inode->i_mtime_nsec = ts.tv_nsec;
 	return ts;
 }
 
@@ -1604,23 +1616,27 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
-	return inode->__i_ctime.tv_sec;
+	return inode->i_ctime_sec;
 }
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->__i_ctime.tv_nsec;
+	return inode->i_ctime_nsec;
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 {
-	return inode->__i_ctime;
+	struct timespec64 ts = { .tv_sec  = inode_get_ctime_sec(inode),
+				 .tv_nsec = inode_get_ctime_nsec(inode) };
+
+	return ts;
 }
 
 static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_ctime = ts;
+	inode->i_ctime_sec = ts.tv_sec;
+	inode->i_ctime_nsec = ts.tv_nsec;
 	return ts;
 }
 

---
base-commit: 7ee332c9f12bc5b380e36919cd7d056592a7073f
change-id: 20240517-amtime-68a7ebc76f45

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


