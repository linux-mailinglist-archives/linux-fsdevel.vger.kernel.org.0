Return-Path: <linux-fsdevel+bounces-58255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27EB2B927
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A6F623218
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD45266B6F;
	Tue, 19 Aug 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfqhw3nV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430ED262FD2;
	Tue, 19 Aug 2025 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583990; cv=none; b=r0DvJ2Iulbd67NSFc5105B4189KPy1IosT5ah8gBJ5iyg2yk2nRkBwgV3O2/6jlot8Yu17DO1bQVc2/wYs17xWCO7xUbkr/F9ToAn/+zsuydGnzIwZxbgmbyAXse77yIT4rLoqhxbrQjx7GaB2Yy0BONmTYEya11UFqmqL6NlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583990; c=relaxed/simple;
	bh=WusUPjktTaFOEo5j8A4EAsYn1P0uoASZi6qPARnDqvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFEM9wgVeX/3gCQrER/wK4gqp2JixNNcbRG7RKXjgVbFwD2Pz1qDMTUeG6YZdju9uT16HVceaTlw0sFOodbjBidC417+e0brG5fiD6ePV719JAaPPkIlqxIT/Mk/FrBLOi2tqv1HsSi3kOpcvBVw1TGW9sT+cv5IY9j5LOXfzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfqhw3nV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f5b692so52325655ad.0;
        Mon, 18 Aug 2025 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755583988; x=1756188788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFwT5ZiTUuDpxS+mxykO7NbdKhzWorUx8IdTr0TGJa0=;
        b=Vfqhw3nVVfLfTxCfH9u+L8RlYKUHOg49MXdJnE8BtqM4Zn8/Ko1FofpIm2b4YIUo0f
         YiyIRhSMzLVOPqxZwyyWeNV0AUhIZbcUxbZ7cECyzya30cqSMJvzQmTAq5K4IzBP6Vdb
         AxCcjBI9GNxyFZAq+bnTDoacY0HM5mxidaoUGkkxmBCmgkh4esgMsxfN8f1Je96Kk/we
         4e9tdL07Er1/ULo1YNxm0tvB/qaYF8ZQgK4gmYzUPAQZFADe3cSODJkSLihotRBVXBxJ
         IVrlxKr0Uip/keMyLT8nvEZBEXdUJ3ePcyYYaIQqE1L83nRpys5SNECFeYQDHWQli84l
         +Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583988; x=1756188788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFwT5ZiTUuDpxS+mxykO7NbdKhzWorUx8IdTr0TGJa0=;
        b=tnQ5QquXgtVHV2JQtpU5A/HTq8+YPaTqtiz14kZA2C4XzruIY9M7h/03TMbZe6wbYH
         K9+wFZ7bPiIVQSYw6lKzZJ1KflH6/dE/gb9g4I1eWnDrUw/rbVEmgQvGFy6If2WFgSUm
         R6nYoPDXLqj41qiskmy9mfsgH36w0MelnFjCfkll4uOxVnZXrW/tQ3XiCpM4GIqGpZ2P
         m3rMjhMvlAp9RmkREzTUFtxYIZKyws+ubx/kEhPNd3JheXmyOWLzV/c2vkgpChln3/DX
         sN++1XYBbACt8sk8uoZYBxlRte/BPI8c3xU+Y8S2rEiKytn5ZSrJ2FQOg3rTnKZFb2il
         W6fw==
X-Forwarded-Encrypted: i=1; AJvYcCWLNCgb3vYPnal4UTtC+Dmviua5YZ3/MompFM1kUoGnrbJ22s22a+3XWItCkbEFNhXqBtwTW1hp/u81NDKhHw==@vger.kernel.org, AJvYcCXHzp3GyekYYKVBVF8yhHNbSBpZysbBknUfWgiSS2zxmvaiHYqnWvknMoZA+Khh1RHCklL9nmVW+uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/gHfUCBNlT9L2FaGm++2IkEiHt/8sBxkUP4MRyvgiVq9WA9L
	5c/jKaBVWk4w/PHAfgZdL8PBQ3Finkao7HpD9GVzDWocULLnSgumYoS4
X-Gm-Gg: ASbGncu0bm2MrrAxgBV7M+dcBj/MqKu9YJ6lkVJqVO+dtCWwXn8mKRA8lEUR4qvClL6
	Q+utUAH6F2PF0viilCpvg+kpWeSj6/fMf4rQikQLtezzxWjPox6BchIqQoIQm+zm3P1WwsRYVFU
	JAW8SHBHsKxfvBSJGm2qfz6tM1zisZxTzij3nNYUlQPAZoMsyLXV6lTQb5QEBB9pjWKkhiKEPFc
	GTgFym2HuEhEko+wwqznN1GaGnlal/T/ou7sZWOCXYIeZMJ2NCFXnHkdquN036no/OpeTV9dIgI
	s9BYzx1jjx2KbER0dSiqwu2YIpR2d7yTsvtZ0NfV7ylOg3e8CARKfjfc57rfHJMu/vnvAhsPs+l
	cI3dGjJ4xRON6j1aBViIDng==
X-Google-Smtp-Source: AGHT+IGbTN128iZ91t0tdqaygNrJ8ejH/QDxe5JNKjXyrpUZR0il22Tn1o3Hm5hmXmU491iA1fyCoQ==
X-Received: by 2002:a17:902:f682:b0:23f:df36:5f0c with SMTP id d9443c01a7336-245e047d995mr21331345ad.29.1755583988363;
        Mon, 18 Aug 2025 23:13:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446caf2de1sm97563715ad.45.2025.08.18.23.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:13:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C9316459631D; Tue, 19 Aug 2025 13:13:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 3/5] Documentation: sharedsubtree: Don't repeat lists with explanation
Date: Tue, 19 Aug 2025 13:12:51 +0700
Message-ID: <20250819061254.31220-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819061254.31220-1-bagasdotme@gmail.com>
References: <20250819061254.31220-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7665; i=bagasdotme@gmail.com; h=from:subject; bh=WusUPjktTaFOEo5j8A4EAsYn1P0uoASZi6qPARnDqvc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlLRF4YvN3bft7/Pvsvq84MoROZvZdvhf57UJ4wpzpQP 13s3IXejlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkiTvDfxe1LZsdXf1/N3PN CU3Jf6Dy0Tj7+sWfy9cfzTF5bfsgzpWRYaKHj+gZa06J+zOLPtZY3Z/0+bxs1Pp1sQ8rg+Vd7eW ZOQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Don't repeat lists only mentioning the items when a corresponding list
with item's explanations suffices.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/sharedsubtree.rst | 106 ++++++++------------
 1 file changed, 44 insertions(+), 62 deletions(-)

diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
index 7ad5101b4c03ad..64858ff0471b81 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -31,15 +31,10 @@ and versioned filesystem.
 -----------
 
 Shared subtree provides four different flavors of mounts; struct vfsmount to be
-precise
-
-	a. shared mount
-	b. slave mount
-	c. private mount
-	d. unbindable mount
+precise:
 
 
-a) A shared mount can be replicated to as many mountpoints and all the
+a) A **shared mount** can be replicated to as many mountpoints and all the
    replicas continue to be exactly same.
 
 	Here is an example:
@@ -83,7 +78,7 @@ a) A shared mount can be replicated to as many mountpoints and all the
 	contents will be visible under /tmp/a too.
 
 
-b) A slave mount is like a shared mount except that mount and umount events
+b) A **slave mount** is like a shared mount except that mount and umount events
    only propagate towards it.
 
 	All slave mounts have a master mount which is a shared.
@@ -131,12 +126,13 @@ b) A slave mount is like a shared mount except that mount and umount events
 	/mnt
 
 
-c) A private mount does not forward or receive propagation.
+c) A **private mount** does not forward or receive propagation.
 
 	This is the mount we are familiar with. Its the default type.
 
 
-d) A unbindable mount is a unbindable private mount
+d) An **unbindable mount** is, as the name suggests, an unbindable private
+   mount.
 
 	let's say we have a mount at /mnt and we make it unbindable::
 
@@ -252,24 +248,18 @@ d) A unbindable mount is a unbindable private mount
 
 a) Mount states
 
-	A given mount can be in one of the following states
-
-	1) shared
-	2) slave
-	3) shared and slave
-	4) private
-	5) unbindable
-
-	A 'propagation event' is defined as event generated on a vfsmount
+	A **propagation event** is defined as event generated on a vfsmount
 	that leads to mount or unmount actions in other vfsmounts.
 
-	A 'peer group' is defined as a group of vfsmounts that propagate
+	A **peer group** is defined as a group of vfsmounts that propagate
 	events to each other.
 
+	A given mount can be in one of the following states:
+
 	(1) Shared mounts
 
-		A 'shared mount' is defined as a vfsmount that belongs to a
-		'peer group'.
+		A **shared mount** is defined as a vfsmount that belongs to a
+		peer group.
 
 		For example::
 
@@ -284,7 +274,7 @@ a) Mount states
 
 	(2) Slave mounts
 
-		A 'slave mount' is defined as a vfsmount that receives
+		A **slave mount** is defined as a vfsmount that receives
 		propagation events and does not forward propagation events.
 
 		A slave mount as the name implies has a master mount from which
@@ -299,7 +289,7 @@ a) Mount states
 
 	(3) Shared and Slave
 
-		A vfsmount can be both shared as well as slave.  This state
+		A vfsmount can be both **shared** as well as **slave**.  This state
 		indicates that the mount is a slave of some vfsmount, and
 		has its own peer group too.  This vfsmount receives propagation
 		events from its master vfsmount, and also forwards propagation
@@ -318,12 +308,12 @@ a) Mount states
 
 	(4) Private mount
 
-		A 'private mount' is defined as vfsmount that does not
+		A **private mount** is defined as vfsmount that does not
 		receive or forward any propagation events.
 
 	(5) Unbindable mount
 
-		A 'unbindable mount' is defined as vfsmount that does not
+		A **unbindable mount** is defined as vfsmount that does not
 		receive or forward any propagation events and cannot
 		be bind mounted.
 
@@ -854,31 +844,26 @@ g) Clone Namespace
 
 A) Datastructure
 
-	4 new fields are introduced to struct vfsmount:
-
-	*   ->mnt_share
-	*   ->mnt_slave_list
-	*   ->mnt_slave
-	*   ->mnt_master
+	Several new fields are introduced to struct vfsmount:
 
 	->mnt_share
-		links together all the mount to/from which this vfsmount
+		Links together all the mount to/from which this vfsmount
 		send/receives propagation events.
 
 	->mnt_slave_list
-		links all the mounts to which this vfsmount propagates
+		Links all the mounts to which this vfsmount propagates
 		to.
 
 	->mnt_slave
-		links together all the slaves that its master vfsmount
+		Links together all the slaves that its master vfsmount
 		propagates to.
 
 	->mnt_master
-		points to the master vfsmount from which this vfsmount
+		Points to the master vfsmount from which this vfsmount
 		receives propagation.
 
 	->mnt_flags
-		takes two more flags to indicate the propagation status of
+		Takes two more flags to indicate the propagation status of
 		the vfsmount.  MNT_SHARE indicates that the vfsmount is a shared
 		vfsmount.  MNT_UNCLONABLE indicates that the vfsmount cannot be
 		replicated.
@@ -960,39 +945,36 @@ C) Algorithm:
 	The overall algorithm breaks the operation into 3 phases: (look at
 	attach_recursive_mnt() and propagate_mnt())
 
-	1. prepare phase.
-	2. commit phases.
-	3. abort phases.
+	1. Prepare phase.
 
-	Prepare phase:
+	   For each mount in the source tree:
 
-	for each mount in the source tree:
+	   a) Create the necessary number of mount trees to
+	      be attached to each of the mounts that receive
+	      propagation from the destination mount.
+	   b) Do not attach any of the trees to its destination.
+	      However note down its ->mnt_parent and ->mnt_mountpoint
+	   c) Link all the new mounts to form a propagation tree that
+	      is identical to the propagation tree of the destination
+	      mount.
 
-		   a) Create the necessary number of mount trees to
-		   	be attached to each of the mounts that receive
-			propagation from the destination mount.
-		   b) Do not attach any of the trees to its destination.
-		      However note down its ->mnt_parent and ->mnt_mountpoint
-		   c) Link all the new mounts to form a propagation tree that
-		      is identical to the propagation tree of the destination
-		      mount.
+	   If this phase is successful, there should be 'n' new
+           propagation trees; where 'n' is the number of mounts in the
+	   source tree.  Go to the commit phase
 
-		   If this phase is successful, there should be 'n' new
-		   propagation trees; where 'n' is the number of mounts in the
-		   source tree.  Go to the commit phase
+	   Also there should be 'm' new mount trees, where 'm' is
+	   the number of mounts to which the destination mount
+	   propagates to.
 
-		   Also there should be 'm' new mount trees, where 'm' is
-		   the number of mounts to which the destination mount
-		   propagates to.
+	   If any memory allocations fail, go to the abort phase.
 
-		   if any memory allocations fail, go to the abort phase.
+	2. Commit phase.
 
-	Commit phase
-		attach each of the mount trees to their corresponding
-		destination mounts.
+	   Attach each of the mount trees to their corresponding
+	   destination mounts.
 
-	Abort phase
-		delete all the newly created trees.
+	3. Abort phase.
+	   Delete all the newly created trees.
 
 	.. Note::
 	   all the propagation related functionality resides in the file pnode.c
-- 
An old man doll... just what I always wanted! - Clara


