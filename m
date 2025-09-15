Return-Path: <linux-fsdevel+bounces-61277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48FB56EC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 05:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D3F176D40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 03:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5DE261B76;
	Mon, 15 Sep 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="er589QUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hs2g5Evz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6125D917;
	Mon, 15 Sep 2025 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905974; cv=none; b=NpQIEbJrYbvQLpWy897jpWXQnLSkR6FR9Na931sF5O3MB3MWtXHmNRhtjKquS1RWQxMo5jBczjNjw037QnOv/LVJF7UvHr8rU9OkzE+pX2PHoG8UVHSYIt3bMzdfcKz7nQBc3v2KqHep9GaBMjthPlZ8BEe1aMJxCC4kXpgUoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905974; c=relaxed/simple;
	bh=gpP1dOjqRCJ3gNH8Nc/Z2rZu+rLGsW4zNgFN9hiHySQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRr/+lVde8mqSjQhIrf0/MDWAE3qOv6fkjbFhEEDTy7OGSnqBMKqbfwuxeJ/xy4k/r31wVTXWPEcK/ywKqo7GPQYIbUID+OMp7EHhd3SP/IPp0jRbzqskVGpRdIV6knSeGFnQf9TH1YCFqobCsH5XJhZFufDaZEXzs31iQIXEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=er589QUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hs2g5Evz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97DB77A007A;
	Sun, 14 Sep 2025 23:12:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 14 Sep 2025 23:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757905971;
	 x=1757992371; bh=kcU83f9/sJFSLx41D45jjxkDKrjkZppB/H54vBPyma0=; b=
	er589QUEYbZ2Kbwp+GDvwAL0RApDLQk5nM1UF19lFH/qoFiJZJYuTYQ8kK7HOVbH
	hwCnpG5DJ1E58OfP8PfuyQS8FoVTv+leUoZMlFw8ZuJ6/LQHk0NBhkaoPMai1E+y
	96DoBiEQB42aTctVhVv/PG0NYqN5ij+Z0l5sYq4dZZ4QZJE9Yc8rtV9fcuoF71/8
	HKeSEQb+i0VgNiJtfeXCeWdhHTjj+cykgGKkYYtpkCL5lqkOlgtBG0E36jGvStoM
	D6BjdjKO60xtJ5c42smIA1MjOf28AJUIVwosoJE0AsRhaOHlzbXqYtJHZWLL0n6E
	UYlKTlQnlLW7zc2ywdxf/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757905971; x=1757992371; bh=k
	cU83f9/sJFSLx41D45jjxkDKrjkZppB/H54vBPyma0=; b=Hs2g5EvzkOUHHRpFS
	ZVIM486xmBOPb+FW0nLiKhuXJBp1UMDWSFsdBJWmK8bhwBEgW26lVxfajd5+S3wj
	bst+B7HaH/0wZgntVVI9uSV8UpYHi7Ms3x7jxdnf6PKrl48YRX7mVMDPpDzDHqHD
	lo7nkTLO7gNhovdk8URMvoxYycii4/kqpYcy+R+2vdpQEH1LP+DehtPneh61KdSp
	+s3p6bGZ+cVVSGVgJSOxx4w4bYTegUWeaPkQcVBFNnpPBedOA240TRdIiLk01KxG
	3QtJwmHNp+aJGhq6TWnLR3PuHcfc3GHC0UVGzBWwTyhSky8Zwqnu/fEY6WY54sv2
	0tAsA==
X-ME-Sender: <xms:M4THaJBdb7aEtW_TWkKWIZGQyppbv__hVcUGIcOn8nKAVOzWbE_2hw>
    <xme:M4THaDNv4E9CgZRdYytUuMqW5mm4-EDUUfvY76avfeNe9fwuWr-Emg-1JqhuZnRhd
    it2w-DR67v9JQ>
X-ME-Received: <xmr:M4THaBAs8JO5p1ItAFXKSY-8w-cY1rq5Ms1WVwvFfw9q7Nxx6zhZgaWkd8XhykzFyckYBsYFtNg4DnX6mFJWrb05FGodfQYg5vInD3yejhP1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhrohhnughmhieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghn
    nhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:M4THaM76tp_IJO02Tp2R5YMmjFTMCOtm1LiGJ9Bht4YMzRgLVQKgIQ>
    <xmx:M4THaD5VKBnPZl-jyvMXobQhdlrQuA6FsQNNiRlCIPYIteFvSQrHog>
    <xmx:M4THaGRoqt_Eo31g5WTi8VvtS8qGFRTUZNwHjsfyR6HKm3XU4s3VNg>
    <xmx:M4THaD9b-gv60BKfz0Dhmv2t-yvOhx3LWsfkc_XETAkcSHcIYjxUKw>
    <xmx:M4THaJogzLE0n9MPp2ovZJiEvRNwc7rUHaXhe7k9ZLDzbiC8xxXcwAoa>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 23:12:48 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	"Jan Kara" <jack@suse.cz>
Subject: [PATCH 2/2] VFS: don't call ->atomic_open on cached negative without O_CREAT
Date: Mon, 15 Sep 2025 13:01:08 +1000
Message-ID: <20250915031134.2671907-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250915031134.2671907-1-neilb@ownmail.net>
References: <20250915031134.2671907-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

If the dentry is found to be negative (not d_in_lookup() and not
positive) and if O_CREATE wasn't requested then we do not have exclusive
access the dentry.

If we pass it to ->atomic_open() the filesystem will need to ensure any
lookup+open operations are serialised so that two threads don't both try
to instantiate the dentry.  This is an unnecessary burden to put on the
filesystem.

If the filesystem wants to perform such a lookup+open operation when a
negative dentry is found, it should return 0 from ->d_revalidate in that
case (when LOOKUP_OPEN) so that the calls serialise in
d_alloc_parallel().

All filesystems with ->atomic_open() currently handle the case of a
negative dentry without O_CREAT either by returning -ENOENT or by
calling finish_no_open(), either with NULL or with the negative dentry.
All of these have the same effect.

For filesystems without ->atomic_open(), lookup_open() will, in this
case, also call finish_no_open().

So this patch removes the burden from filesystems by calling
finish_no_open() early on a negative cached dentry when O_CREAT isn't
requested.

With this change any ->atomic_open() function can be certain that it has
exclusive access to the dentry, either because an exclusive lock is held
on the parent directory or because DCACHE_PAR_LOOKUP is set implying an
exclusive lock on the dentry itself.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/vfs.rst | 4 ++++
 fs/namei.c                        | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..be7dd654f5fd 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -678,6 +678,10 @@ otherwise noted.
 	flag should be set in file->f_mode.  In case of O_EXCL the
 	method must only succeed if the file didn't exist and hence
 	FMODE_CREATED shall always be set on success.
+	atomic_open() will always have exclusive access to the dentry
+	as if O_CREAT hasn't caused the directory to be locked exclusively,
+	then the dentry will have DCACHE_PAR_LOOKUP will also
+	provides exclusivity.
 
 ``tmpfile``
 	called in the end of O_TMPFILE open().  Optional, equivalent to
diff --git a/fs/namei.c b/fs/namei.c
index ba8bf73d2f9c..5f732b9cd2db 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3647,6 +3647,14 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		/* Cached positive dentry: will open in f_op->open */
 		return dentry;
 	}
+	if ((open_flag & O_CREAT) == 0 && !d_in_lookup(dentry)) {
+		/* Cached negative dentry and no create requested.
+		 * If a filesystem wants to be called in this case
+		 * it should trigger dentry invalidation in
+		 * ->d_revalidate.
+		 */
+		return dentry;
+	}
 
 	if (open_flag & O_CREAT)
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
-- 
2.50.0.107.gf914562f5916.dirty


