Return-Path: <linux-fsdevel+bounces-58256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4A1B2B92A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74639621D44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F845269CF0;
	Tue, 19 Aug 2025 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnH/FrUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D828265606;
	Tue, 19 Aug 2025 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583991; cv=none; b=CZP4KTpZVmf4mHRIEAUPfX19rCr8R+hfcghCBB5U+Ky2m0ZlIAAxKkuFtMILvtKrqETScO6sMLECgPG07GU6ztyPkrBbWsbBXgbuljvyOXAmGj6ojqo6Nowxrjv9WZBFp6J4YSqaGkOFlCIHo6y51CDh8b4T9OM85+tF21jKHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583991; c=relaxed/simple;
	bh=I7KmCXyl42aYn842W603tt/7xQNS3vegUK19V0pwZ1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0X6pzpyHQ2nj3mi+JQ4YQEefQi+mVYR7qewrb8c3Y9YGEoaUBXlAOeRB894qS7ur5Xjzcx2TDRARLQFBkEWRLQjXTPkEoglBP/YBjZOD81bUjmQqx1UYvCn6T3deGDNoNTUNzNmOZbEqD8GRXRurnqB2kdYegc7nTeBc+pLXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnH/FrUQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47173749dbso3340925a12.1;
        Mon, 18 Aug 2025 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755583989; x=1756188789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMm+ItPj3hUTjJZjxg/ff1pADD3fWr8FSx3pNcuiyqM=;
        b=QnH/FrUQJmJByOlQcQXCqPBj9U0lcf1TKSD7PAS1rB9bbIds0DcC258MEcLvbcJKVS
         4Hc6N+d9hFquUDBCU8gceySLbcRUFH35xFZbbN7pOz432XbP14yKLqTHDp3GY4U/7Gd6
         Y+nHHLWYG/Z53KfryMSN8nFTCSBwsQs0CM4SZb3RNiaIkWYF3T9kIkIoEm63K1GgsC5P
         eK4uU3tAOKNlHcC02T4tbrH8Ymgw6+1w0SUkJN0wuiIJukVfwmm8Sza4nqtZxmOSoDgU
         2mkMijn+6AE3ptbkZL7bhkuQQK8v1r7jj3wfl6FXa5uXkZI2q+jCYhRP/YpPwSpp31Y1
         Hj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583989; x=1756188789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMm+ItPj3hUTjJZjxg/ff1pADD3fWr8FSx3pNcuiyqM=;
        b=EtlFZ2MO0eUI+mg7YzegDkKsc4jvdsqNCIgh5hzFr1aM1aRNl8N0JVvWPqOWQ160Km
         FeU50Yj0+o93KZ2KK8E+izLrMaJiua7HDkT8iNNVxr6+p8MDQK6hgsgS6czud5KC06qX
         52JXMRgQHRq/XdoxfIML/4iKBdE1D57u8wAYes5VkksiwBItUtbjQmpxMH2bHrkk2hHi
         Llki9KxcLjANgf3NyMQ2kXMNyqjnpED/Wepywu56rRfplRgBhxjPeziioqgbeMYA6wIz
         PeZoD8bghNZemDTTcNGAVa4cpCHZA/9nqAJSW6H1/zKRgLrHUeapjoa2o20yIN7MHSUQ
         KUYA==
X-Forwarded-Encrypted: i=1; AJvYcCW2FfBehHfn+Cwo/JSMsScNWyBWL3Np3QhVSA9vOYfeNHGwBpWcdVr24/JzQRIJBkBDtQvTuXl394bP6cyDFA==@vger.kernel.org, AJvYcCXqkPjvg/t8jOfLfsV4cmyR99x6bNIsEsAaeW50GxeHIj/i5k0ZWlNzLll8NtEeHYcPiowYJKput34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtn49KnIEJss1Jza/6zydOWHklgMz4WHwV0w4nd4kfsKNTm6xF
	YK5c/qV7FZKA5ThEQ2a/Azlmp+LFluhzWkn/xAgR4oLJsn0p4kWUiby8
X-Gm-Gg: ASbGncuOag10+8vFy3C1hEVBxOR/kXxNaVS0ZRkjDrqOFC5MRfarT5jwa7J1f3k22tf
	SN+PAbzyhvcODfI4LcnkJBaaapCln55++Qzp6mzoxhgWWArG3d9gvdcurz+V2GoeY75X7oFWnTh
	IiStNQL+Yd/fz/QjHPXhrZ3SEML1e1/Ptoi2ndzM2Cvs3sQlsuQZDd0YdEwKhZotH8GKz4qvTkz
	XaKluf/pRGfp//AcZNgaHBqgQoEBUH34LwNWoAhl9QkDOJ/b6Wlask8PvFWWiW22lQV+hTJJrBI
	RL3EWRohQoPVL9IpM3PxJnjvhCpVpKRsQygb2S0DpsQPi/UgFZWsy2Pxc1Yi3cQxgf3LYqhhe0I
	lnP5X80hKyZ2PJCdKzl4TkKBXOsU74qH3
X-Google-Smtp-Source: AGHT+IFd0BGA8T2XXal0HJWOiS1R/oNe/7plsRqUR229O+uQ6zbFJpuj840bfWx8tu9rcqKH0Xlxyg==
X-Received: by 2002:a17:902:e804:b0:240:3f3d:fd37 with SMTP id d9443c01a7336-245e05092b3mr14365495ad.27.1755583989267;
        Mon, 18 Aug 2025 23:13:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d516a30sm97749385ad.95.2025.08.18.23.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:13:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 914C342BF5D4; Tue, 19 Aug 2025 13:13:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/5] Documentation: sharedsubtree: Use proper enumerator sequence for enumerated lists
Date: Tue, 19 Aug 2025 13:12:50 +0700
Message-ID: <20250819061254.31220-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819061254.31220-1-bagasdotme@gmail.com>
References: <20250819061254.31220-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5653; i=bagasdotme@gmail.com; h=from:subject; bh=I7KmCXyl42aYn842W603tt/7xQNS3vegUK19V0pwZ1I=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlLRF68eFeyz3ragiOsuplpvLuX7X4nx5VmGSwxS0C0O eOGTun2jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExETozhf3L3nnyV13vTfSp8 qkuipTP1VzbrGO3ad7nNdbOQl86RHQz/tLUOxt65mrvlfun5d4EMHd6K+XuO3AgS4/UO5OFl9nr DBgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx does not recognize mixed-letter sequences (e.g. 2a) as enumerator
for enumerated lists. As such, lists that use such sequences end up as
definition lists instead.

Use proper enumeration sequences for this purpose.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/sharedsubtree.rst | 40 ++++++++++-----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
index 06497c4455b41d..7ad5101b4c03ad 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -39,8 +39,8 @@ precise
 	d. unbindable mount
 
 
-2a) A shared mount can be replicated to as many mountpoints and all the
-replicas continue to be exactly same.
+a) A shared mount can be replicated to as many mountpoints and all the
+   replicas continue to be exactly same.
 
 	Here is an example:
 
@@ -83,8 +83,8 @@ replicas continue to be exactly same.
 	contents will be visible under /tmp/a too.
 
 
-2b) A slave mount is like a shared mount except that mount and umount events
-	only propagate towards it.
+b) A slave mount is like a shared mount except that mount and umount events
+   only propagate towards it.
 
 	All slave mounts have a master mount which is a shared.
 
@@ -131,12 +131,12 @@ replicas continue to be exactly same.
 	/mnt
 
 
-2c) A private mount does not forward or receive propagation.
+c) A private mount does not forward or receive propagation.
 
 	This is the mount we are familiar with. Its the default type.
 
 
-2d) A unbindable mount is a unbindable private mount
+d) A unbindable mount is a unbindable private mount
 
 	let's say we have a mount at /mnt and we make it unbindable::
 
@@ -185,7 +185,7 @@ replicas continue to be exactly same.
 		namespaces.
 
 	B) A process wants its mounts invisible to any other process, but
-	still be able to see the other system mounts.
+	   still be able to see the other system mounts.
 
 	   Solution:
 
@@ -250,7 +250,7 @@ replicas continue to be exactly same.
 	Note: the word 'vfsmount' and the noun 'mount' have been used
 	to mean the same thing, throughout this document.
 
-5a) Mount states
+a) Mount states
 
 	A given mount can be in one of the following states
 
@@ -360,7 +360,7 @@ replicas continue to be exactly same.
 	the state of a mount depending on type of the destination mount. Its
 	explained in section 5d.
 
-5b) Bind semantics
+b) Bind semantics
 
 	Consider the following command::
 
@@ -437,7 +437,7 @@ replicas continue to be exactly same.
     8. 'A' is a unbindable mount and 'B' is a non-shared mount. This is a
 	invalid operation. A unbindable mount cannot be bind mounted.
 
-5c) Rbind semantics
+c) Rbind semantics
 
 	rbind is same as bind. Bind replicates the specified mount.  Rbind
 	replicates all the mounts in the tree belonging to the specified mount.
@@ -474,7 +474,7 @@ replicas continue to be exactly same.
 
 
 
-5d) Move semantics
+d) Move semantics
 
 	Consider the following command::
 
@@ -551,7 +551,7 @@ replicas continue to be exactly same.
 	'A' is mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a
 	unbindable mount.
 
-5e) Mount semantics
+e) Mount semantics
 
 	Consider the following command::
 
@@ -564,7 +564,7 @@ replicas continue to be exactly same.
 	that the source mount is always a private mount.
 
 
-5f) Unmount semantics
+f) Unmount semantics
 
 	Consider the following command::
 
@@ -598,7 +598,7 @@ replicas continue to be exactly same.
 	to be unmounted and 'C1' has some sub-mounts, the umount operation is
 	failed entirely.
 
-5g) Clone Namespace
+g) Clone Namespace
 
 	A cloned namespace contains all the mounts as that of the parent
 	namespace.
@@ -682,18 +682,18 @@ replicas continue to be exactly same.
 7) FAQ
 ------
 
-	Q1. Why is bind mount needed? How is it different from symbolic links?
+	1. Why is bind mount needed? How is it different from symbolic links?
 		symbolic links can get stale if the destination mount gets
 		unmounted or moved. Bind mounts continue to exist even if the
 		other mount is unmounted or moved.
 
-	Q2. Why can't the shared subtree be implemented using exportfs?
+	2. Why can't the shared subtree be implemented using exportfs?
 
 		exportfs is a heavyweight way of accomplishing part of what
 		shared subtree can do. I cannot imagine a way to implement the
 		semantics of slave mount using exportfs?
 
-	Q3 Why is unbindable mount needed?
+	3. Why is unbindable mount needed?
 
 		Let's say we want to replicate the mount tree at multiple
 		locations within the same subtree.
@@ -852,7 +852,7 @@ replicas continue to be exactly same.
 8) Implementation
 -----------------
 
-8A) Datastructure
+A) Datastructure
 
 	4 new fields are introduced to struct vfsmount:
 
@@ -941,7 +941,7 @@ replicas continue to be exactly same.
 
 	NOTE: The propagation tree is orthogonal to the mount tree.
 
-8B Locking:
+B) Locking:
 
 	->mnt_share, ->mnt_slave, ->mnt_slave_list, ->mnt_master are protected
 	by namespace_sem (exclusive for modifications, shared for reading).
@@ -953,7 +953,7 @@ replicas continue to be exactly same.
 	The latter holds namespace_sem and the only references to vfsmount
 	are in lists that can't be traversed without namespace_sem.
 
-8C Algorithm:
+C) Algorithm:
 
 	The crux of the implementation resides in rbind/move operation.
 
-- 
An old man doll... just what I always wanted! - Clara


