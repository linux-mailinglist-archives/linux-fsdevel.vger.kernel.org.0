Return-Path: <linux-fsdevel+bounces-58260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A22B2B936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75052528501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86C283FC3;
	Tue, 19 Aug 2025 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1sBub0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5926A0B9;
	Tue, 19 Aug 2025 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583996; cv=none; b=QeRXkH+KApmGpGeBdLwQZvdSV+DxxY9cXqMgk55ltszRSa/9uX6x95FPMvmwUbRAkzQGjlUPqwF/FCJ2IjpNW3VkZ9TQy1JYOZ+lb+Y7/5MKEgrfXFd/JN3W/HG1PtgJ8wSvUY18THHJTwMtKT6j2GoHe/bXls+JkS7EaOFHQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583996; c=relaxed/simple;
	bh=aa3bA6N8HiYvZs6mfHD8e/oeMHrqjnyzOS98reYIuL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZ1ze6hqlWdyqjw2l/xCOHxMLQGv0tWNIE357jLQgRTqCK2QFLFOFpY/n53+yQZMCIUmm4PVyFIeuEhT9s9q8tiaZZZSrngi0EQvrw6dT6ro3bRdJ9jK9f1hWa6X4/oPaWKTLavMP5mu7UDs4lAuIpMx8VkSWaxn6EPm2GtSL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1sBub0c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244580523a0so43418215ad.1;
        Mon, 18 Aug 2025 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755583992; x=1756188792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFernzrG6f3CulgyvvNbb0nRHZ8JONDQG4wsxAi3bbk=;
        b=B1sBub0c5N+iUhOkqziWS6ifWCM1cRuyWA6O3hytZD/xuRTGnuVhkzrRAjqrBTucc7
         ViNBgZgEBgZJeef/dxJghiDEGXgHaaAwz0xieaqzpnJIFBiyh0Oi8VQT9Sb7gcELIi9e
         IFTRVOkZup2ai1VTt5EMt5lyRWE6DBt4jTANeM9b9Gtk5zp7Ft1wBs1smLINS98IxTyn
         JdAltSOYElOyKPUXAptx+Cum7i5Mx9S84t3O14OSWT9zECIWZfLNJq5uKR6Nw4fua4ao
         4EahGIym/pY9In/QHIyAp6btyDd9SBS9SWYG/P502Oqz3XIkuvKjUYh9H7l0EKAzJTn0
         T4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583992; x=1756188792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFernzrG6f3CulgyvvNbb0nRHZ8JONDQG4wsxAi3bbk=;
        b=wmk8Ki5iSCO/pNgUeXgQjQzboB/BMKgbJN5BXuIKzWJoaiWQ3KSyX8p8G6ABNUWbWP
         7WcPYV3CFfP/hfJb+t1oL85DUdQvy4ExdXxpWf94ZcmaLiznB0j80+EplGNjMqoi1X13
         0hqUXCyucq329s1gXsorg4BHQvUNJE4HhSCBbM+5tt8HPDI9rLjhdB4WVeVAzpniZqNF
         Px1aZpElF8xD2X8HA6x1Jursk3Nj29zmQgx37x+3c6HCJpG8a90VN7So4wRYp1dVhXv1
         r+SReOkPWibLXA6Hr2gpq2y5uuNNcXR6KI8vqOydZ2e3/LKC+nGN7aCoVa6QM40upv0j
         rZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVmx12Yp43p4P3YKNNvqEMurSk9VP43j4r/LPUX1PQFlBbc+iyHc5QEEw2A48w5Aq9Xo/uOsu/mtei1iYnOaQ==@vger.kernel.org, AJvYcCW8VakYld8Wr52XCnP+ylrqGypbLY8cqPo5dgYDricDkolp6dcWFJ1yKfSxzEP2O6KVPktIsxPnBSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zP9mxs5vw0RtoqWQ6Vx/+WYbJSNJ/bOaZpQUXF6AFRJnMT8Y
	BhdvOOO0caIJxjS/HMdgSVaMz0TWt7b4Hd3ddoYMkOzi8nv8W48FEnP7
X-Gm-Gg: ASbGncswtlpJrTKDzR355ZOFTfSUZ62OldTfzfGU8E+zxUsBNm59XnOK+7Wl5vk9HjH
	S2A0xTCZd1+Au1+yvIYXMxJ+JwfEln6qxN9hg9JCGE9gSaHdsZtsNiroiIAnMv4JKkrVQs4wJ/Q
	iBjKsqKX6/5+ggRwLfDlHiazqrgbjMHzkaecqpWSKSPVU/53lcmEkBdQZyvB28lnSrS3GrtycI0
	EQtyGvMgrahlglx9haXZl5efS6boUKqn/xM+MPoSp8u/AdNH8P5kUDbxUruXuBDVCHXICJmzvNu
	sP2C9LB1v8FnYdhdJPshcODrKJhMPkPM+OXzhSy8VVEkZA/+eN6cz2791TLeF9HKGZLorpgEGcJ
	LwWW+U1MXVfyY/z6URsgatA==
X-Google-Smtp-Source: AGHT+IH/um8BmOedGHyWwBZH2YtCb00zNnx/Qu9BmFRrR2ok8BibAmMEUCs8KfCw3Gh91sh5xAThmQ==
X-Received: by 2002:a17:903:2308:b0:242:b315:ddaf with SMTP id d9443c01a7336-245e0465fa9mr18660365ad.7.1755583991296;
        Mon, 18 Aug 2025 23:13:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm97027105ad.75.2025.08.18.23.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:13:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 16BD6462A061; Tue, 19 Aug 2025 13:13:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4/5] Documentation: sharedsubtree: Align text
Date: Tue, 19 Aug 2025 13:12:52 +0700
Message-ID: <20250819061254.31220-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819061254.31220-1-bagasdotme@gmail.com>
References: <20250819061254.31220-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=64831; i=bagasdotme@gmail.com; h=from:subject; bh=aa3bA6N8HiYvZs6mfHD8e/oeMHrqjnyzOS98reYIuL0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlLRF5WBtrWqufUnw/YUr+I52olX9KWSMkMDbcY7V2vn yUzf1rdUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIkE7GZkuP/92KT8m4KpU3P+ nv3k1LJg41T37Q2Nmet2npepWfptxVpGhsaWVKFFjzNOdE1pFr57/PbHiysvXSicc/HFsheTLQ9 t+80PAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The docs make heavy use of lists. As it is currently written, these
generate a lot of unnecessary hanging indents since these are not
semantically meant to be definition lists by accident.

Align text to trim these indents.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/sharedsubtree.rst | 1247 ++++++++++---------
 1 file changed, 624 insertions(+), 623 deletions(-)

diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
index 64858ff0471b81..b09650e285341c 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -37,947 +37,948 @@ precise:
 a) A **shared mount** can be replicated to as many mountpoints and all the
    replicas continue to be exactly same.
 
-	Here is an example:
+   Here is an example:
 
-	Let's say /mnt has a mount that is shared::
+   Let's say /mnt has a mount that is shared::
 
-	    mount --make-shared /mnt
+     # mount --make-shared /mnt
 
-	Note: mount(8) command now supports the --make-shared flag,
-	so the sample 'smount' program is no longer needed and has been
-	removed.
+   Note: mount(8) command now supports the --make-shared flag,
+   so the sample 'smount' program is no longer needed and has been
+   removed.
 
-	::
+   ::
 
-	    # mount --bind /mnt /tmp
+     # mount --bind /mnt /tmp
 
-	The above command replicates the mount at /mnt to the mountpoint /tmp
-	and the contents of both the mounts remain identical.
+   The above command replicates the mount at /mnt to the mountpoint /tmp
+   and the contents of both the mounts remain identical.
 
-	::
+   ::
 
-	    #ls /mnt
-	    a b c
+     #ls /mnt
+     a b c
 
-	    #ls /tmp
-	    a b c
+     #ls /tmp
+     a b c
 
-	Now let's say we mount a device at /tmp/a::
+   Now let's say we mount a device at /tmp/a::
 
-	    # mount /dev/sd0  /tmp/a
+     # mount /dev/sd0  /tmp/a
 
-	    #ls /tmp/a
-	    t1 t2 t3
+     # ls /tmp/a
+     t1 t2 t3
 
-	    #ls /mnt/a
-	    t1 t2 t3
+     # ls /mnt/a
+     t1 t2 t3
 
-	Note that the mount has propagated to the mount at /mnt as well.
+   Note that the mount has propagated to the mount at /mnt as well.
 
-	And the same is true even when /dev/sd0 is mounted on /mnt/a. The
-	contents will be visible under /tmp/a too.
+   And the same is true even when /dev/sd0 is mounted on /mnt/a. The
+   contents will be visible under /tmp/a too.
 
 
 b) A **slave mount** is like a shared mount except that mount and umount events
    only propagate towards it.
 
-	All slave mounts have a master mount which is a shared.
+   All slave mounts have a master mount which is a shared.
 
-	Here is an example:
+   Here is an example:
 
-	Let's say /mnt has a mount which is shared::
+   Let's say /mnt has a mount which is shared::
 
-	  # mount --make-shared /mnt
+     # mount --make-shared /mnt
 
-	Let's bind mount /mnt to /tmp::
+   Let's bind mount /mnt to /tmp::
 
-	  # mount --bind /mnt /tmp
+     # mount --bind /mnt /tmp
 
-	the new mount at /tmp becomes a shared mount and it is a replica of
-	the mount at /mnt.
+   the new mount at /tmp becomes a shared mount and it is a replica of
+   the mount at /mnt.
 
-	Now let's make the mount at /tmp; a slave of /mnt::
+   Now let's make the mount at /tmp; a slave of /mnt::
 
-	  # mount --make-slave /tmp
+     # mount --make-slave /tmp
 
-	let's mount /dev/sd0 on /mnt/a::
+   let's mount /dev/sd0 on /mnt/a::
 
-	  # mount /dev/sd0 /mnt/a
+     # mount /dev/sd0 /mnt/a
 
-	  # ls /mnt/a
-	  t1 t2 t3
+     # ls /mnt/a
+     t1 t2 t3
 
-	  # ls /tmp/a
-	  t1 t2 t3
+     # ls /tmp/a
+     t1 t2 t3
 
-	Note the mount event has propagated to the mount at /tmp
+   Note the mount event has propagated to the mount at /tmp
 
-	However let's see what happens if we mount something on the mount at
-        /tmp::
+   However let's see what happens if we mount something on the mount at
+   /tmp::
 
-	  # mount /dev/sd1 /tmp/b
+     # mount /dev/sd1 /tmp/b
 
-	  # ls /tmp/b
-	  s1 s2 s3
+     # ls /tmp/b
+     s1 s2 s3
 
-	  # ls /mnt/b
+     # ls /mnt/b
 
-	Note how the mount event has not propagated to the mount at
-	/mnt
+   Note how the mount event has not propagated to the mount at
+   /mnt
 
 
 c) A **private mount** does not forward or receive propagation.
 
-	This is the mount we are familiar with. Its the default type.
+   This is the mount we are familiar with. Its the default type.
 
 
 d) An **unbindable mount** is, as the name suggests, an unbindable private
    mount.
 
-	let's say we have a mount at /mnt and we make it unbindable::
+   let's say we have a mount at /mnt and we make it unbindable::
 
-	    # mount --make-unbindable /mnt
+     # mount --make-unbindable /mnt
 
-	Let's try to bind mount this mount somewhere else::
+   Let's try to bind mount this mount somewhere else::
 
-	    # mount --bind /mnt /tmp
-	    mount: wrong fs type, bad option, bad superblock on /mnt,
-		    or too many mounted file systems
+     # mount --bind /mnt /tmp mount: wrong fs type, bad option, bad
+     superblock on /mnt, or too many mounted file systems
 
-	Binding a unbindable mount is a invalid operation.
+   Binding a unbindable mount is a invalid operation.
 
 
 3) Setting mount states
 -----------------------
 
-	The mount command (util-linux package) can be used to set mount
-	states::
+The mount command (util-linux package) can be used to set mount
+states::
 
-	    mount --make-shared mountpoint
-	    mount --make-slave mountpoint
-	    mount --make-private mountpoint
-	    mount --make-unbindable mountpoint
+    mount --make-shared mountpoint
+    mount --make-slave mountpoint
+    mount --make-private mountpoint
+    mount --make-unbindable mountpoint
 
 
 4) Use cases
 ------------
 
-	A) A process wants to clone its own namespace, but still wants to
-	   access the CD that got mounted recently.
+A) A process wants to clone its own namespace, but still wants to
+   access the CD that got mounted recently.
 
-	   Solution:
+   Solution:
 
-		The system administrator can make the mount at /cdrom shared::
+   The system administrator can make the mount at /cdrom shared::
 
-		    mount --bind /cdrom /cdrom
-		    mount --make-shared /cdrom
+     mount --bind /cdrom /cdrom
+     mount --make-shared /cdrom
 
-		Now any process that clones off a new namespace will have a
-		mount at /cdrom which is a replica of the same mount in the
-		parent namespace.
+   Now any process that clones off a new namespace will have a
+   mount at /cdrom which is a replica of the same mount in the
+   parent namespace.
 
-		So when a CD is inserted and mounted at /cdrom that mount gets
-		propagated to the other mount at /cdrom in all the other clone
-		namespaces.
+   So when a CD is inserted and mounted at /cdrom that mount gets
+   propagated to the other mount at /cdrom in all the other clone
+   namespaces.
 
-	B) A process wants its mounts invisible to any other process, but
-	   still be able to see the other system mounts.
+B) A process wants its mounts invisible to any other process, but
+   still be able to see the other system mounts.
 
-	   Solution:
+   Solution:
 
-		To begin with, the administrator can mark the entire mount tree
-		as shareable::
+   To begin with, the administrator can mark the entire mount tree
+   as shareable::
 
-		    mount --make-rshared /
+     mount --make-rshared /
 
-		A new process can clone off a new namespace. And mark some part
-		of its namespace as slave::
+   A new process can clone off a new namespace. And mark some part
+   of its namespace as slave::
 
-		    mount --make-rslave /myprivatetree
+     mount --make-rslave /myprivatetree
 
-		Hence forth any mounts within the /myprivatetree done by the
-		process will not show up in any other namespace. However mounts
-		done in the parent namespace under /myprivatetree still shows
-		up in the process's namespace.
+   Hence forth any mounts within the /myprivatetree done by the
+   process will not show up in any other namespace. However mounts
+   done in the parent namespace under /myprivatetree still shows
+   up in the process's namespace.
 
 
-	Apart from the above semantics this feature provides the
-	building blocks to solve the following problems:
+Apart from the above semantics this feature provides the
+building blocks to solve the following problems:
 
-	C)  Per-user namespace
+C)  Per-user namespace
 
-		The above semantics allows a way to share mounts across
-		namespaces.  But namespaces are associated with processes. If
-		namespaces are made first class objects with user API to
-		associate/disassociate a namespace with userid, then each user
-		could have his/her own namespace and tailor it to his/her
-		requirements. This needs to be supported in PAM.
+    The above semantics allows a way to share mounts across
+    namespaces.  But namespaces are associated with processes. If
+    namespaces are made first class objects with user API to
+    associate/disassociate a namespace with userid, then each user
+    could have his/her own namespace and tailor it to his/her
+    requirements. This needs to be supported in PAM.
 
-	D)  Versioned files
+D)  Versioned files
 
-		If the entire mount tree is visible at multiple locations, then
-		an underlying versioning file system can return different
-		versions of the file depending on the path used to access that
-		file.
+    If the entire mount tree is visible at multiple locations, then
+    an underlying versioning file system can return different
+    versions of the file depending on the path used to access that
+    file.
 
-		An example is::
+    An example is::
 
-		    mount --make-shared /
-		    mount --rbind / /view/v1
-		    mount --rbind / /view/v2
-		    mount --rbind / /view/v3
-		    mount --rbind / /view/v4
+       mount --make-shared /
+       mount --rbind / /view/v1
+       mount --rbind / /view/v2
+       mount --rbind / /view/v3
+       mount --rbind / /view/v4
 
-		and if /usr has a versioning filesystem mounted, then that
-		mount appears at /view/v1/usr, /view/v2/usr, /view/v3/usr and
-		/view/v4/usr too
+    and if /usr has a versioning filesystem mounted, then that
+    mount appears at /view/v1/usr, /view/v2/usr, /view/v3/usr and
+    /view/v4/usr too
 
-		A user can request v3 version of the file /usr/fs/namespace.c
-		by accessing /view/v3/usr/fs/namespace.c . The underlying
-		versioning filesystem can then decipher that v3 version of the
-		filesystem is being requested and return the corresponding
-		inode.
+    A user can request v3 version of the file /usr/fs/namespace.c
+    by accessing /view/v3/usr/fs/namespace.c . The underlying
+    versioning filesystem can then decipher that v3 version of the
+    filesystem is being requested and return the corresponding
+    inode.
 
 5) Detailed semantics
 ---------------------
-	The section below explains the detailed semantics of
-	bind, rbind, move, mount, umount and clone-namespace operations.
+The section below explains the detailed semantics of
+bind, rbind, move, mount, umount and clone-namespace operations.
 
-	Note: the word 'vfsmount' and the noun 'mount' have been used
-	to mean the same thing, throughout this document.
+Note: the word 'vfsmount' and the noun 'mount' have been used
+to mean the same thing, throughout this document.
 
 a) Mount states
 
-	A **propagation event** is defined as event generated on a vfsmount
-	that leads to mount or unmount actions in other vfsmounts.
+   A **propagation event** is defined as event generated on a vfsmount
+   that leads to mount or unmount actions in other vfsmounts.
 
-	A **peer group** is defined as a group of vfsmounts that propagate
-	events to each other.
+   A **peer group** is defined as a group of vfsmounts that propagate
+   events to each other.
 
-	A given mount can be in one of the following states:
+   A given mount can be in one of the following states:
 
-	(1) Shared mounts
+   (1) Shared mounts
 
-		A **shared mount** is defined as a vfsmount that belongs to a
-		peer group.
+       A **shared mount** is defined as a vfsmount that belongs to a
+       peer group.
 
-		For example::
+       For example::
 
-			mount --make-shared /mnt
-			mount --bind /mnt /tmp
+         mount --make-shared /mnt
+         mount --bind /mnt /tmp
 
-		The mount at /mnt and that at /tmp are both shared and belong
-		to the same peer group. Anything mounted or unmounted under
-		/mnt or /tmp reflect in all the other mounts of its peer
-		group.
+       The mount at /mnt and that at /tmp are both shared and belong
+       to the same peer group. Anything mounted or unmounted under
+       /mnt or /tmp reflect in all the other mounts of its peer
+       group.
 
 
-	(2) Slave mounts
+   (2) Slave mounts
 
-		A **slave mount** is defined as a vfsmount that receives
-		propagation events and does not forward propagation events.
+       A **slave mount** is defined as a vfsmount that receives
+       propagation events and does not forward propagation events.
 
-		A slave mount as the name implies has a master mount from which
-		mount/unmount events are received. Events do not propagate from
-		the slave mount to the master.  Only a shared mount can be made
-		a slave by executing the following command::
+       A slave mount as the name implies has a master mount from which
+       mount/unmount events are received. Events do not propagate from
+       the slave mount to the master.  Only a shared mount can be made
+       a slave by executing the following command::
 
-			mount --make-slave mount
+         mount --make-slave mount
 
-		A shared mount that is made as a slave is no more shared unless
-		modified to become shared.
+       A shared mount that is made as a slave is no more shared unless
+       modified to become shared.
 
-	(3) Shared and Slave
+   (3) Shared and Slave
 
-		A vfsmount can be both **shared** as well as **slave**.  This state
-		indicates that the mount is a slave of some vfsmount, and
-		has its own peer group too.  This vfsmount receives propagation
-		events from its master vfsmount, and also forwards propagation
-		events to its 'peer group' and to its slave vfsmounts.
+       A vfsmount can be both **shared** as well as **slave**.  This state
+       indicates that the mount is a slave of some vfsmount, and
+       has its own peer group too.  This vfsmount receives propagation
+       events from its master vfsmount, and also forwards propagation
+       events to its 'peer group' and to its slave vfsmounts.
 
-		Strictly speaking, the vfsmount is shared having its own
-		peer group, and this peer-group is a slave of some other
-		peer group.
+       Strictly speaking, the vfsmount is shared having its own
+       peer group, and this peer-group is a slave of some other
+       peer group.
 
-		Only a slave vfsmount can be made as 'shared and slave' by
-		either executing the following command::
+       Only a slave vfsmount can be made as 'shared and slave' by
+       either executing the following command::
 
-			mount --make-shared mount
+         mount --make-shared mount
 
-		or by moving the slave vfsmount under a shared vfsmount.
+       or by moving the slave vfsmount under a shared vfsmount.
 
-	(4) Private mount
+   (4) Private mount
 
-		A **private mount** is defined as vfsmount that does not
-		receive or forward any propagation events.
+       A **private mount** is defined as vfsmount that does not
+       receive or forward any propagation events.
 
-	(5) Unbindable mount
+   (5) Unbindable mount
 
-		A **unbindable mount** is defined as vfsmount that does not
-		receive or forward any propagation events and cannot
-		be bind mounted.
+       A **unbindable mount** is defined as vfsmount that does not
+       receive or forward any propagation events and cannot
+       be bind mounted.
 
 
-   	State diagram:
+       State diagram:
 
-   	The state diagram below explains the state transition of a mount,
-	in response to various commands::
+       The state diagram below explains the state transition of a mount,
+       in response to various commands::
 
-	    -----------------------------------------------------------------------
-	    |             |make-shared |  make-slave  | make-private |make-unbindab|
-	    --------------|------------|--------------|--------------|-------------|
-	    |shared	  |shared      |*slave/private|   private    | unbindable  |
-	    |             |            |              |              |             |
-	    |-------------|------------|--------------|--------------|-------------|
-	    |slave	  |shared      | **slave      |    private   | unbindable  |
-	    |             |and slave   |              |              |             |
-	    |-------------|------------|--------------|--------------|-------------|
-	    |shared       |shared      | slave        |    private   | unbindable  |
-	    |and slave    |and slave   |              |              |             |
-	    |-------------|------------|--------------|--------------|-------------|
-	    |private      |shared      |  **private   |    private   | unbindable  |
-	    |-------------|------------|--------------|--------------|-------------|
-	    |unbindable   |shared      |**unbindable  |    private   | unbindable  |
-	    ------------------------------------------------------------------------
+            -----------------------------------------------------------------------
+            |             |make-shared |  make-slave  | make-private |make-unbindab|
+            --------------|------------|--------------|--------------|-------------|
+            |shared       |shared      |*slave/private|   private    | unbindable  |
+            |             |            |              |              |             |
+            |-------------|------------|--------------|--------------|-------------|
+            |slave        |shared      | **slave      |    private   | unbindable  |
+            |             |and slave   |              |              |             |
+            |-------------|------------|--------------|--------------|-------------|
+            |shared       |shared      | slave        |    private   | unbindable  |
+            |and slave    |and slave   |              |              |             |
+            |-------------|------------|--------------|--------------|-------------|
+            |private      |shared      |  **private   |    private   | unbindable  |
+            |-------------|------------|--------------|--------------|-------------|
+            |unbindable   |shared      |**unbindable  |    private   | unbindable  |
+            ------------------------------------------------------------------------
 
-	    * if the shared mount is the only mount in its peer group, making it
-	    slave, makes it private automatically. Note that there is no master to
-	    which it can be slaved to.
+            * if the shared mount is the only mount in its peer group, making it
+            slave, makes it private automatically. Note that there is no master to
+            which it can be slaved to.
 
-	    ** slaving a non-shared mount has no effect on the mount.
+            ** slaving a non-shared mount has no effect on the mount.
 
-	Apart from the commands listed below, the 'move' operation also changes
-	the state of a mount depending on type of the destination mount. Its
-	explained in section 5d.
+       Apart from the commands listed below, the 'move' operation also changes
+       the state of a mount depending on type of the destination mount. Its
+       explained in section 5d.
 
 b) Bind semantics
 
-	Consider the following command::
+   Consider the following command::
 
-	    mount --bind A/a  B/b
+     mount --bind A/a  B/b
 
-	where 'A' is the source mount, 'a' is the dentry in the mount 'A', 'B'
-	is the destination mount and 'b' is the dentry in the destination mount.
+   where 'A' is the source mount, 'a' is the dentry in the mount 'A', 'B'
+   is the destination mount and 'b' is the dentry in the destination mount.
 
-	The outcome depends on the type of mount of 'A' and 'B'. The table
-	below contains quick reference::
+   The outcome depends on the type of mount of 'A' and 'B'. The table
+   below contains quick reference::
 
-	    --------------------------------------------------------------------------
-	    |         BIND MOUNT OPERATION                                           |
-	    |************************************************************************|
-	    |source(A)->| shared      |       private  |       slave    | unbindable |
-	    | dest(B)  |              |                |                |            |
-	    |   |      |              |                |                |            |
-	    |   v      |              |                |                |            |
-	    |************************************************************************|
-	    |  shared  | shared       |     shared     | shared & slave |  invalid   |
-	    |          |              |                |                |            |
-	    |non-shared| shared       |      private   |      slave     |  invalid   |
-	    **************************************************************************
+            --------------------------------------------------------------------------
+            |         BIND MOUNT OPERATION                                           |
+            |************************************************************************|
+            |source(A)->| shared      |       private  |       slave    | unbindable |
+            | dest(B)  |              |                |                |            |
+            |   |      |              |                |                |            |
+            |   v      |              |                |                |            |
+            |************************************************************************|
+            |  shared  | shared       |     shared     | shared & slave |  invalid   |
+            |          |              |                |                |            |
+            |non-shared| shared       |      private   |      slave     |  invalid   |
+            **************************************************************************
 
-     	Details:
+   Details:
 
-    1. 'A' is a shared mount and 'B' is a shared mount. A new mount 'C'
-	which is clone of 'A', is created. Its root dentry is 'a' . 'C' is
-	mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
-	are created and mounted at the dentry 'b' on all mounts where 'B'
-	propagates to. A new propagation tree containing 'C1',..,'Cn' is
-	created. This propagation tree is identical to the propagation tree of
-	'B'.  And finally the peer-group of 'C' is merged with the peer group
-	of 'A'.
+   1. 'A' is a shared mount and 'B' is a shared mount. A new mount 'C'
+      which is clone of 'A', is created. Its root dentry is 'a' . 'C' is
+      mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
+      are created and mounted at the dentry 'b' on all mounts where 'B'
+      propagates to. A new propagation tree containing 'C1',..,'Cn' is
+      created. This propagation tree is identical to the propagation tree of
+      'B'.  And finally the peer-group of 'C' is merged with the peer group
+      of 'A'.
 
-    2. 'A' is a private mount and 'B' is a shared mount. A new mount 'C'
-	which is clone of 'A', is created. Its root dentry is 'a'. 'C' is
-	mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
-	are created and mounted at the dentry 'b' on all mounts where 'B'
-	propagates to. A new propagation tree is set containing all new mounts
-	'C', 'C1', .., 'Cn' with exactly the same configuration as the
-	propagation tree for 'B'.
+   2. 'A' is a private mount and 'B' is a shared mount. A new mount 'C'
+      which is clone of 'A', is created. Its root dentry is 'a'. 'C' is
+      mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
+      are created and mounted at the dentry 'b' on all mounts where 'B'
+      propagates to. A new propagation tree is set containing all new mounts
+      'C', 'C1', .., 'Cn' with exactly the same configuration as the
+      propagation tree for 'B'.
 
-    3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount. A new
-	mount 'C' which is clone of 'A', is created. Its root dentry is 'a' .
-	'C' is mounted on mount 'B' at dentry 'b'. Also new mounts 'C1', 'C2',
-	'C3' ... are created and mounted at the dentry 'b' on all mounts where
-	'B' propagates to. A new propagation tree containing the new mounts
-	'C','C1',..  'Cn' is created. This propagation tree is identical to the
-	propagation tree for 'B'. And finally the mount 'C' and its peer group
-	is made the slave of mount 'Z'.  In other words, mount 'C' is in the
-	state 'slave and shared'.
+   3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount. A new
+      mount 'C' which is clone of 'A', is created. Its root dentry is 'a' .
+      'C' is mounted on mount 'B' at dentry 'b'. Also new mounts 'C1', 'C2',
+      'C3' ... are created and mounted at the dentry 'b' on all mounts where
+      'B' propagates to. A new propagation tree containing the new mounts
+      'C','C1',..  'Cn' is created. This propagation tree is identical to the
+      propagation tree for 'B'. And finally the mount 'C' and its peer group
+      is made the slave of mount 'Z'.  In other words, mount 'C' is in the
+      state 'slave and shared'.
 
-    4. 'A' is a unbindable mount and 'B' is a shared mount. This is a
-	invalid operation.
+   4. 'A' is a unbindable mount and 'B' is a shared mount. This is a
+      invalid operation.
 
-    5. 'A' is a private mount and 'B' is a non-shared(private or slave or
-	unbindable) mount. A new mount 'C' which is clone of 'A', is created.
-	Its root dentry is 'a'. 'C' is mounted on mount 'B' at dentry 'b'.
+   5. 'A' is a private mount and 'B' is a non-shared(private or slave or
+      unbindable) mount. A new mount 'C' which is clone of 'A', is created.
+      Its root dentry is 'a'. 'C' is mounted on mount 'B' at dentry 'b'.
 
-    6. 'A' is a shared mount and 'B' is a non-shared mount. A new mount 'C'
-	which is a clone of 'A' is created. Its root dentry is 'a'. 'C' is
-	mounted on mount 'B' at dentry 'b'.  'C' is made a member of the
-	peer-group of 'A'.
+   6. 'A' is a shared mount and 'B' is a non-shared mount. A new mount 'C'
+      which is a clone of 'A' is created. Its root dentry is 'a'. 'C' is
+      mounted on mount 'B' at dentry 'b'.  'C' is made a member of the
+      peer-group of 'A'.
 
-    7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount. A
-	new mount 'C' which is a clone of 'A' is created. Its root dentry is
-	'a'.  'C' is mounted on mount 'B' at dentry 'b'. Also 'C' is set as a
-	slave mount of 'Z'. In other words 'A' and 'C' are both slave mounts of
-	'Z'.  All mount/unmount events on 'Z' propagates to 'A' and 'C'. But
-	mount/unmount on 'A' do not propagate anywhere else. Similarly
-	mount/unmount on 'C' do not propagate anywhere else.
+   7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount. A
+      new mount 'C' which is a clone of 'A' is created. Its root dentry is
+      'a'.  'C' is mounted on mount 'B' at dentry 'b'. Also 'C' is set as a
+      slave mount of 'Z'. In other words 'A' and 'C' are both slave mounts of
+      'Z'.  All mount/unmount events on 'Z' propagates to 'A' and 'C'. But
+      mount/unmount on 'A' do not propagate anywhere else. Similarly
+      mount/unmount on 'C' do not propagate anywhere else.
 
-    8. 'A' is a unbindable mount and 'B' is a non-shared mount. This is a
-	invalid operation. A unbindable mount cannot be bind mounted.
+   8. 'A' is a unbindable mount and 'B' is a non-shared mount. This is a
+      invalid operation. A unbindable mount cannot be bind mounted.
 
 c) Rbind semantics
 
-	rbind is same as bind. Bind replicates the specified mount.  Rbind
-	replicates all the mounts in the tree belonging to the specified mount.
-	Rbind mount is bind mount applied to all the mounts in the tree.
+   rbind is same as bind. Bind replicates the specified mount.  Rbind
+   replicates all the mounts in the tree belonging to the specified mount.
+   Rbind mount is bind mount applied to all the mounts in the tree.
 
-	If the source tree that is rbind has some unbindable mounts,
-	then the subtree under the unbindable mount is pruned in the new
-	location.
+   If the source tree that is rbind has some unbindable mounts,
+   then the subtree under the unbindable mount is pruned in the new
+   location.
 
-	eg:
+   eg:
 
-	  let's say we have the following mount tree::
+   let's say we have the following mount tree::
 
-		A
-	      /   \
-	      B   C
-	     / \ / \
-	     D E F G
+                A
+              /   \
+              B   C
+             / \ / \
+             D E F G
 
-	  Let's say all the mount except the mount C in the tree are
-	  of a type other than unbindable.
+   Let's say all the mount except the mount C in the tree are
+   of a type other than unbindable.
 
-	  If this tree is rbound to say Z
+   If this tree is rbound to say Z
 
-	  We will have the following tree at the new location::
+   We will have the following tree at the new location::
 
-		Z
-		|
-		A'
-	       /
-	      B'		Note how the tree under C is pruned
-	     / \ 		in the new location.
-	    D' E'
+                Z
+                |
+                A'
+               /
+              B'                Note how the tree under C is pruned
+             / \                in the new location.
+            D' E'
 
 
 
 d) Move semantics
 
-	Consider the following command::
+   Consider the following command::
 
-	  mount --move A  B/b
+     mount --move A  B/b
 
-	where 'A' is the source mount, 'B' is the destination mount and 'b' is
-	the dentry in the destination mount.
+   where 'A' is the source mount, 'B' is the destination mount and 'b' is
+   the dentry in the destination mount.
 
-	The outcome depends on the type of the mount of 'A' and 'B'. The table
-	below is a quick reference::
+   The outcome depends on the type of the mount of 'A' and 'B'. The table
+   below is a quick reference::
 
-	    ---------------------------------------------------------------------------
-	    |         		MOVE MOUNT OPERATION                                 |
-	    |**************************************************************************
-	    | source(A)->| shared      |       private  |       slave    | unbindable |
-	    | dest(B)  |               |                |                |            |
-	    |   |      |               |                |                |            |
-	    |   v      |               |                |                |            |
-	    |**************************************************************************
-	    |  shared  | shared        |     shared     |shared and slave|  invalid   |
-	    |          |               |                |                |            |
-	    |non-shared| shared        |      private   |    slave       | unbindable |
-	    ***************************************************************************
+            ---------------------------------------------------------------------------
+            |                   MOVE MOUNT OPERATION                                 |
+            |**************************************************************************
+            | source(A)->| shared      |       private  |       slave    | unbindable |
+            | dest(B)  |               |                |                |            |
+            |   |      |               |                |                |            |
+            |   v      |               |                |                |            |
+            |**************************************************************************
+            |  shared  | shared        |     shared     |shared and slave|  invalid   |
+            |          |               |                |                |            |
+            |non-shared| shared        |      private   |    slave       | unbindable |
+            ***************************************************************************
 
-	.. Note:: moving a mount residing under a shared mount is invalid.
+   .. Note:: moving a mount residing under a shared mount is invalid.
 
-      Details follow:
+   Details follow:
 
-    1. 'A' is a shared mount and 'B' is a shared mount.  The mount 'A' is
-	mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1', 'A2'...'An'
-	are created and mounted at dentry 'b' on all mounts that receive
-	propagation from mount 'B'. A new propagation tree is created in the
-	exact same configuration as that of 'B'. This new propagation tree
-	contains all the new mounts 'A1', 'A2'...  'An'.  And this new
-	propagation tree is appended to the already existing propagation tree
-	of 'A'.
+   1. 'A' is a shared mount and 'B' is a shared mount.  The mount 'A' is
+      mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1', 'A2'...'An'
+      are created and mounted at dentry 'b' on all mounts that receive
+      propagation from mount 'B'. A new propagation tree is created in the
+      exact same configuration as that of 'B'. This new propagation tree
+      contains all the new mounts 'A1', 'A2'...  'An'.  And this new
+      propagation tree is appended to the already existing propagation tree
+      of 'A'.
 
-    2. 'A' is a private mount and 'B' is a shared mount. The mount 'A' is
-	mounted on mount 'B' at dentry 'b'. Also new mount 'A1', 'A2'... 'An'
-	are created and mounted at dentry 'b' on all mounts that receive
-	propagation from mount 'B'. The mount 'A' becomes a shared mount and a
-	propagation tree is created which is identical to that of
-	'B'. This new propagation tree contains all the new mounts 'A1',
-	'A2'...  'An'.
+   2. 'A' is a private mount and 'B' is a shared mount. The mount 'A' is
+      mounted on mount 'B' at dentry 'b'. Also new mount 'A1', 'A2'... 'An'
+      are created and mounted at dentry 'b' on all mounts that receive
+      propagation from mount 'B'. The mount 'A' becomes a shared mount and a
+      propagation tree is created which is identical to that of
+      'B'. This new propagation tree contains all the new mounts 'A1',
+      'A2'...  'An'.
 
-    3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount.  The
-	mount 'A' is mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1',
-	'A2'... 'An' are created and mounted at dentry 'b' on all mounts that
-	receive propagation from mount 'B'. A new propagation tree is created
-	in the exact same configuration as that of 'B'. This new propagation
-	tree contains all the new mounts 'A1', 'A2'...  'An'.  And this new
-	propagation tree is appended to the already existing propagation tree of
-	'A'.  Mount 'A' continues to be the slave mount of 'Z' but it also
-	becomes 'shared'.
+   3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount.  The
+      mount 'A' is mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1',
+      'A2'... 'An' are created and mounted at dentry 'b' on all mounts that
+      receive propagation from mount 'B'. A new propagation tree is created
+      in the exact same configuration as that of 'B'. This new propagation
+      tree contains all the new mounts 'A1', 'A2'...  'An'.  And this new
+      propagation tree is appended to the already existing propagation tree of
+      'A'.  Mount 'A' continues to be the slave mount of 'Z' but it also
+      becomes 'shared'.
 
-    4. 'A' is a unbindable mount and 'B' is a shared mount. The operation
-	is invalid. Because mounting anything on the shared mount 'B' can
-	create new mounts that get mounted on the mounts that receive
-	propagation from 'B'.  And since the mount 'A' is unbindable, cloning
-	it to mount at other mountpoints is not possible.
+   4. 'A' is a unbindable mount and 'B' is a shared mount. The operation
+      is invalid. Because mounting anything on the shared mount 'B' can
+      create new mounts that get mounted on the mounts that receive
+      propagation from 'B'.  And since the mount 'A' is unbindable, cloning
+      it to mount at other mountpoints is not possible.
 
-    5. 'A' is a private mount and 'B' is a non-shared(private or slave or
-	unbindable) mount. The mount 'A' is mounted on mount 'B' at dentry 'b'.
+   5. 'A' is a private mount and 'B' is a non-shared(private or slave or
+      unbindable) mount. The mount 'A' is mounted on mount 'B' at dentry 'b'.
 
-    6. 'A' is a shared mount and 'B' is a non-shared mount.  The mount 'A'
-	is mounted on mount 'B' at dentry 'b'.  Mount 'A' continues to be a
-	shared mount.
+   6. 'A' is a shared mount and 'B' is a non-shared mount.  The mount 'A'
+      is mounted on mount 'B' at dentry 'b'.  Mount 'A' continues to be a
+      shared mount.
 
-    7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount.
-	The mount 'A' is mounted on mount 'B' at dentry 'b'.  Mount 'A'
-	continues to be a slave mount of mount 'Z'.
+   7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount.
+      The mount 'A' is mounted on mount 'B' at dentry 'b'.  Mount 'A'
+      continues to be a slave mount of mount 'Z'.
 
-    8. 'A' is a unbindable mount and 'B' is a non-shared mount. The mount
-	'A' is mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a
-	unbindable mount.
+   8. 'A' is a unbindable mount and 'B' is a non-shared mount. The mount
+      'A' is mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a
+      unbindable mount.
 
 e) Mount semantics
 
-	Consider the following command::
+   Consider the following command::
 
-	    mount device  B/b
+     mount device  B/b
 
-	'B' is the destination mount and 'b' is the dentry in the destination
-	mount.
+   'B' is the destination mount and 'b' is the dentry in the destination
+   mount.
 
-	The above operation is the same as bind operation with the exception
-	that the source mount is always a private mount.
+   The above operation is the same as bind operation with the exception
+   that the source mount is always a private mount.
 
 
 f) Unmount semantics
 
-	Consider the following command::
+   Consider the following command::
 
-	    umount A
+     umount A
 
-	where 'A' is a mount mounted on mount 'B' at dentry 'b'.
+   where 'A' is a mount mounted on mount 'B' at dentry 'b'.
 
-	If mount 'B' is shared, then all most-recently-mounted mounts at dentry
-	'b' on mounts that receive propagation from mount 'B' and does not have
-	sub-mounts within them are unmounted.
+   If mount 'B' is shared, then all most-recently-mounted mounts at dentry
+   'b' on mounts that receive propagation from mount 'B' and does not have
+   sub-mounts within them are unmounted.
 
-	Example: Let's say 'B1', 'B2', 'B3' are shared mounts that propagate to
-	each other.
+   Example: Let's say 'B1', 'B2', 'B3' are shared mounts that propagate to
+   each other.
 
-	let's say 'A1', 'A2', 'A3' are first mounted at dentry 'b' on mount
-	'B1', 'B2' and 'B3' respectively.
+   let's say 'A1', 'A2', 'A3' are first mounted at dentry 'b' on mount
+   'B1', 'B2' and 'B3' respectively.
 
-	let's say 'C1', 'C2', 'C3' are next mounted at the same dentry 'b' on
-	mount 'B1', 'B2' and 'B3' respectively.
+   let's say 'C1', 'C2', 'C3' are next mounted at the same dentry 'b' on
+   mount 'B1', 'B2' and 'B3' respectively.
 
-	if 'C1' is unmounted, all the mounts that are most-recently-mounted on
-	'B1' and on the mounts that 'B1' propagates-to are unmounted.
+   if 'C1' is unmounted, all the mounts that are most-recently-mounted on
+   'B1' and on the mounts that 'B1' propagates-to are unmounted.
 
-	'B1' propagates to 'B2' and 'B3'. And the most recently mounted mount
-	on 'B2' at dentry 'b' is 'C2', and that of mount 'B3' is 'C3'.
+   'B1' propagates to 'B2' and 'B3'. And the most recently mounted mount
+   on 'B2' at dentry 'b' is 'C2', and that of mount 'B3' is 'C3'.
 
-	So all 'C1', 'C2' and 'C3' should be unmounted.
+   So all 'C1', 'C2' and 'C3' should be unmounted.
 
-	If any of 'C2' or 'C3' has some child mounts, then that mount is not
-	unmounted, but all other mounts are unmounted. However if 'C1' is told
-	to be unmounted and 'C1' has some sub-mounts, the umount operation is
-	failed entirely.
+   If any of 'C2' or 'C3' has some child mounts, then that mount is not
+   unmounted, but all other mounts are unmounted. However if 'C1' is told
+   to be unmounted and 'C1' has some sub-mounts, the umount operation is
+   failed entirely.
 
 g) Clone Namespace
 
-	A cloned namespace contains all the mounts as that of the parent
-	namespace.
+   A cloned namespace contains all the mounts as that of the parent
+   namespace.
 
-	Let's say 'A' and 'B' are the corresponding mounts in the parent and the
-	child namespace.
+   Let's say 'A' and 'B' are the corresponding mounts in the parent and the
+   child namespace.
 
-	If 'A' is shared, then 'B' is also shared and 'A' and 'B' propagate to
-	each other.
+   If 'A' is shared, then 'B' is also shared and 'A' and 'B' propagate to
+   each other.
 
-	If 'A' is a slave mount of 'Z', then 'B' is also the slave mount of
-	'Z'.
+   If 'A' is a slave mount of 'Z', then 'B' is also the slave mount of
+   'Z'.
 
-	If 'A' is a private mount, then 'B' is a private mount too.
+   If 'A' is a private mount, then 'B' is a private mount too.
 
-	If 'A' is unbindable mount, then 'B' is a unbindable mount too.
+   If 'A' is unbindable mount, then 'B' is a unbindable mount too.
 
 
 6) Quiz
 -------
 
-	A. What is the result of the following command sequence?
+A. What is the result of the following command sequence?
 
-		::
+   ::
 
-		    mount --bind /mnt /mnt
-		    mount --make-shared /mnt
-		    mount --bind /mnt /tmp
-		    mount --move /tmp /mnt/1
+       mount --bind /mnt /mnt
+       mount --make-shared /mnt
+       mount --bind /mnt /tmp
+       mount --move /tmp /mnt/1
 
-		what should be the contents of /mnt /mnt/1 /mnt/1/1 should be?
-		Should they all be identical? or should /mnt and /mnt/1 be
-		identical only?
+   what should be the contents of /mnt /mnt/1 /mnt/1/1 should be?
+   Should they all be identical? or should /mnt and /mnt/1 be
+   identical only?
 
 
-	B. What is the result of the following command sequence?
+B. What is the result of the following command sequence?
 
-		::
+   ::
 
-		    mount --make-rshared /
-		    mkdir -p /v/1
-		    mount --rbind / /v/1
+       mount --make-rshared /
+       mkdir -p /v/1
+       mount --rbind / /v/1
 
-		what should be the content of /v/1/v/1 be?
+   what should be the content of /v/1/v/1 be?
 
 
-	C. What is the result of the following command sequence?
+C. What is the result of the following command sequence?
 
-		::
+   ::
 
-		    mount --bind /mnt /mnt
-		    mount --make-shared /mnt
-		    mkdir -p /mnt/1/2/3 /mnt/1/test
-		    mount --bind /mnt/1 /tmp
-		    mount --make-slave /mnt
-		    mount --make-shared /mnt
-		    mount --bind /mnt/1/2 /tmp1
-		    mount --make-slave /mnt
+       mount --bind /mnt /mnt
+       mount --make-shared /mnt
+       mkdir -p /mnt/1/2/3 /mnt/1/test
+       mount --bind /mnt/1 /tmp
+       mount --make-slave /mnt
+       mount --make-shared /mnt
+       mount --bind /mnt/1/2 /tmp1
+       mount --make-slave /mnt
 
-		At this point we have the first mount at /tmp and
-		its root dentry is 1. Let's call this mount 'A'
-		And then we have a second mount at /tmp1 with root
-		dentry 2. Let's call this mount 'B'
-		Next we have a third mount at /mnt with root dentry
-		mnt. Let's call this mount 'C'
+   At this point we have the first mount at /tmp and
+   its root dentry is 1. Let's call this mount 'A'
+   And then we have a second mount at /tmp1 with root
+   dentry 2. Let's call this mount 'B'
+   Next we have a third mount at /mnt with root dentry
+   mnt. Let's call this mount 'C'
 
-		'B' is the slave of 'A' and 'C' is a slave of 'B'
-		A -> B -> C
+   'B' is the slave of 'A' and 'C' is a slave of 'B'
+   A -> B -> C
 
-		at this point if we execute the following command::
+   at this point if we execute the following command::
 
-		  mount --bind /bin /tmp/test
+     mount --bind /bin /tmp/test
 
-		The mount is attempted on 'A'
+   The mount is attempted on 'A'
 
-		will the mount propagate to 'B' and 'C' ?
+   will the mount propagate to 'B' and 'C' ?
 
-		what would be the contents of
-		/mnt/1/test be?
+   what would be the contents of
+   /mnt/1/test be?
 
 7) FAQ
 ------
 
-	1. Why is bind mount needed? How is it different from symbolic links?
-		symbolic links can get stale if the destination mount gets
-		unmounted or moved. Bind mounts continue to exist even if the
-		other mount is unmounted or moved.
+1. Why is bind mount needed? How is it different from symbolic links?
 
-	2. Why can't the shared subtree be implemented using exportfs?
+   symbolic links can get stale if the destination mount gets
+   unmounted or moved. Bind mounts continue to exist even if the
+   other mount is unmounted or moved.
 
-		exportfs is a heavyweight way of accomplishing part of what
-		shared subtree can do. I cannot imagine a way to implement the
-		semantics of slave mount using exportfs?
+2. Why can't the shared subtree be implemented using exportfs?
 
-	3. Why is unbindable mount needed?
+   exportfs is a heavyweight way of accomplishing part of what
+   shared subtree can do. I cannot imagine a way to implement the
+   semantics of slave mount using exportfs?
 
-		Let's say we want to replicate the mount tree at multiple
-		locations within the same subtree.
+3. Why is unbindable mount needed?
 
-		if one rbind mounts a tree within the same subtree 'n' times
-		the number of mounts created is an exponential function of 'n'.
-		Having unbindable mount can help prune the unneeded bind
-		mounts. Here is an example.
+   Let's say we want to replicate the mount tree at multiple
+   locations within the same subtree.
 
-		step 1:
-		   let's say the root tree has just two directories with
-		   one vfsmount::
+   if one rbind mounts a tree within the same subtree 'n' times
+   the number of mounts created is an exponential function of 'n'.
+   Having unbindable mount can help prune the unneeded bind
+   mounts. Here is an example.
 
-				    root
-				   /    \
-				  tmp    usr
+   step 1:
+      let's say the root tree has just two directories with
+      one vfsmount::
 
-		   And we want to replicate the tree at multiple
-		   mountpoints under /root/tmp
+                                    root
+                                   /    \
+                                  tmp    usr
 
-		step 2:
-		      ::
+      And we want to replicate the tree at multiple
+      mountpoints under /root/tmp
+
+   step 2:
+      ::
 
 
-			mount --make-shared /root
+                        mount --make-shared /root
 
-			mkdir -p /tmp/m1
+                        mkdir -p /tmp/m1
 
-			mount --rbind /root /tmp/m1
+                        mount --rbind /root /tmp/m1
 
-		      the new tree now looks like this::
+      the new tree now looks like this::
 
-				    root
-				   /    \
-				 tmp    usr
-				/
-			       m1
-			      /  \
-			     tmp  usr
-			     /
-			    m1
+                                    root
+                                   /    \
+                                 tmp    usr
+                                /
+                               m1
+                              /  \
+                             tmp  usr
+                             /
+                            m1
 
-		      it has two vfsmounts
+      it has two vfsmounts
 
-		step 3:
-		    ::
+   step 3:
+      ::
 
-			    mkdir -p /tmp/m2
-			    mount --rbind /root /tmp/m2
+                            mkdir -p /tmp/m2
+                            mount --rbind /root /tmp/m2
 
-		    the new tree now looks like this::
+      the new tree now looks like this::
 
-				      root
-				     /    \
-				   tmp     usr
-				  /    \
-				m1       m2
-			       / \       /  \
-			     tmp  usr   tmp  usr
-			     / \          /
-			    m1  m2      m1
-				/ \     /  \
-			      tmp usr  tmp   usr
-			      /        / \
-			     m1       m1  m2
-			    /  \
-			  tmp   usr
-			  /  \
-			 m1   m2
+                                      root
+                                     /    \
+                                   tmp     usr
+                                  /    \
+                                m1       m2
+                               / \       /  \
+                             tmp  usr   tmp  usr
+                             / \          /
+                            m1  m2      m1
+                                / \     /  \
+                              tmp usr  tmp   usr
+                              /        / \
+                             m1       m1  m2
+                            /  \
+                          tmp   usr
+                          /  \
+                         m1   m2
 
-		    it has 6 vfsmounts
+                    it has 6 vfsmounts
 
-		step 4:
-                    ::
+   step 4:
+      ::
 
-			  mkdir -p /tmp/m3
-			  mount --rbind /root /tmp/m3
+                          mkdir -p /tmp/m3
+                          mount --rbind /root /tmp/m3
 
-		I won't draw the tree..but it has 24 vfsmounts
+      I won't draw the tree..but it has 24 vfsmounts
 
 
-		at step i the number of vfsmounts is V[i] = i*V[i-1].
-		This is an exponential function. And this tree has way more
-		mounts than what we really needed in the first place.
+   at step i the number of vfsmounts is V[i] = i*V[i-1].
+   This is an exponential function. And this tree has way more
+   mounts than what we really needed in the first place.
 
-		One could use a series of umount at each step to prune
-		out the unneeded mounts. But there is a better solution.
-		Unclonable mounts come in handy here.
+   One could use a series of umount at each step to prune
+   out the unneeded mounts. But there is a better solution.
+   Unclonable mounts come in handy here.
 
-		step 1:
-		   let's say the root tree has just two directories with
-		   one vfsmount::
+   step 1:
+      let's say the root tree has just two directories with
+      one vfsmount::
 
-				    root
-				   /    \
-				  tmp    usr
+                                    root
+                                   /    \
+                                  tmp    usr
 
-		   How do we set up the same tree at multiple locations under
-		   /root/tmp
+         How do we set up the same tree at multiple locations under
+         /root/tmp
 
-		step 2:
-		      ::
+   step 2:
+      ::
 
 
-			mount --bind /root/tmp /root/tmp
+                        mount --bind /root/tmp /root/tmp
 
-			mount --make-rshared /root
-			mount --make-unbindable /root/tmp
+                        mount --make-rshared /root
+                        mount --make-unbindable /root/tmp
 
-			mkdir -p /tmp/m1
+                        mkdir -p /tmp/m1
 
-			mount --rbind /root /tmp/m1
+                        mount --rbind /root /tmp/m1
 
-		      the new tree now looks like this::
+      the new tree now looks like this::
 
-				    root
-				   /    \
-				 tmp    usr
-				/
-			       m1
-			      /  \
-			     tmp  usr
+                                    root
+                                   /    \
+                                 tmp    usr
+                                /
+                               m1
+                              /  \
+                             tmp  usr
 
-		step 3:
-		      ::
+   step 3:
+      ::
 
-			    mkdir -p /tmp/m2
-			    mount --rbind /root /tmp/m2
+                            mkdir -p /tmp/m2
+                            mount --rbind /root /tmp/m2
 
-		      the new tree now looks like this::
+      the new tree now looks like this::
 
-				    root
-				   /    \
-				 tmp    usr
-				/   \
-			       m1     m2
-			      /  \     / \
-			     tmp  usr tmp usr
+                                    root
+                                   /    \
+                                 tmp    usr
+                                /   \
+                               m1     m2
+                              /  \     / \
+                             tmp  usr tmp usr
 
-		step 4:
-		      ::
+   step 4:
+      ::
 
-			    mkdir -p /tmp/m3
-			    mount --rbind /root /tmp/m3
+                            mkdir -p /tmp/m3
+                            mount --rbind /root /tmp/m3
 
-		      the new tree now looks like this::
+      the new tree now looks like this::
 
-				    	  root
-				      /    	  \
-				     tmp    	   usr
-			         /    \    \
-			       m1     m2     m3
-			      /  \     / \    /  \
-			     tmp  usr tmp usr tmp usr
+                                          root
+                                      /           \
+                                     tmp           usr
+                                 /    \    \
+                               m1     m2     m3
+                              /  \     / \    /  \
+                             tmp  usr tmp usr tmp usr
 
 8) Implementation
 -----------------
 
 A) Datastructure
 
-	Several new fields are introduced to struct vfsmount:
+   Several new fields are introduced to struct vfsmount:
 
-	->mnt_share
-		Links together all the mount to/from which this vfsmount
-		send/receives propagation events.
+   ->mnt_share
+           Links together all the mount to/from which this vfsmount
+           send/receives propagation events.
 
-	->mnt_slave_list
-		Links all the mounts to which this vfsmount propagates
-		to.
+   ->mnt_slave_list
+           Links all the mounts to which this vfsmount propagates
+           to.
 
-	->mnt_slave
-		Links together all the slaves that its master vfsmount
-		propagates to.
+   ->mnt_slave
+           Links together all the slaves that its master vfsmount
+           propagates to.
 
-	->mnt_master
-		Points to the master vfsmount from which this vfsmount
-		receives propagation.
+   ->mnt_master
+           Points to the master vfsmount from which this vfsmount
+           receives propagation.
 
-	->mnt_flags
-		Takes two more flags to indicate the propagation status of
-		the vfsmount.  MNT_SHARE indicates that the vfsmount is a shared
-		vfsmount.  MNT_UNCLONABLE indicates that the vfsmount cannot be
-		replicated.
+   ->mnt_flags
+           Takes two more flags to indicate the propagation status of
+           the vfsmount.  MNT_SHARE indicates that the vfsmount is a shared
+           vfsmount.  MNT_UNCLONABLE indicates that the vfsmount cannot be
+           replicated.
 
-	All the shared vfsmounts in a peer group form a cyclic list through
-	->mnt_share.
+   All the shared vfsmounts in a peer group form a cyclic list through
+   ->mnt_share.
 
-	All vfsmounts with the same ->mnt_master form on a cyclic list anchored
-	in ->mnt_master->mnt_slave_list and going through ->mnt_slave.
+   All vfsmounts with the same ->mnt_master form on a cyclic list anchored
+   in ->mnt_master->mnt_slave_list and going through ->mnt_slave.
 
-	 ->mnt_master can point to arbitrary (and possibly different) members
-	 of master peer group.  To find all immediate slaves of a peer group
-	 you need to go through _all_ ->mnt_slave_list of its members.
-	 Conceptually it's just a single set - distribution among the
-	 individual lists does not affect propagation or the way propagation
-	 tree is modified by operations.
+   ->mnt_master can point to arbitrary (and possibly different) members
+   of master peer group.  To find all immediate slaves of a peer group
+   you need to go through _all_ ->mnt_slave_list of its members.
+   Conceptually it's just a single set - distribution among the
+   individual lists does not affect propagation or the way propagation
+   tree is modified by operations.
 
-	All vfsmounts in a peer group have the same ->mnt_master.  If it is
-	non-NULL, they form a contiguous (ordered) segment of slave list.
+   All vfsmounts in a peer group have the same ->mnt_master.  If it is
+   non-NULL, they form a contiguous (ordered) segment of slave list.
 
-	A example propagation tree looks as shown in the figure below.
-	[ NOTE: Though it looks like a forest, if we consider all the shared
-	mounts as a conceptual entity called 'pnode', it becomes a tree]::
+   A example propagation tree looks as shown in the figure below.
+   [ NOTE: Though it looks like a forest, if we consider all the shared
+   mounts as a conceptual entity called 'pnode', it becomes a tree]::
 
 
-		        A <--> B <--> C <---> D
-		       /|\	      /|      |\
-		      / F G	     J K      H I
-		     /
-		    E<-->K
-			/|\
-		       M L N
+                        A <--> B <--> C <---> D
+                       /|\            /|      |\
+                      / F G          J K      H I
+                     /
+                    E<-->K
+                        /|\
+                       M L N
 
-	In the above figure  A,B,C and D all are shared and propagate to each
-	other.   'A' has got 3 slave mounts 'E' 'F' and 'G' 'C' has got 2 slave
-	mounts 'J' and 'K'  and  'D' has got two slave mounts 'H' and 'I'.
-	'E' is also shared with 'K' and they propagate to each other.  And
-	'K' has 3 slaves 'M', 'L' and 'N'
+   In the above figure  A,B,C and D all are shared and propagate to each
+   other.   'A' has got 3 slave mounts 'E' 'F' and 'G' 'C' has got 2 slave
+   mounts 'J' and 'K'  and  'D' has got two slave mounts 'H' and 'I'.
+   'E' is also shared with 'K' and they propagate to each other.  And
+   'K' has 3 slaves 'M', 'L' and 'N'
 
-	A's ->mnt_share links with the ->mnt_share of 'B' 'C' and 'D'
+   A's ->mnt_share links with the ->mnt_share of 'B' 'C' and 'D'
 
-	A's ->mnt_slave_list links with ->mnt_slave of 'E', 'K', 'F' and 'G'
+   A's ->mnt_slave_list links with ->mnt_slave of 'E', 'K', 'F' and 'G'
 
-	E's ->mnt_share links with ->mnt_share of K
+   E's ->mnt_share links with ->mnt_share of K
 
-	'E', 'K', 'F', 'G' have their ->mnt_master point to struct vfsmount of 'A'
+   'E', 'K', 'F', 'G' have their ->mnt_master point to struct vfsmount of 'A'
 
-	'M', 'L', 'N' have their ->mnt_master point to struct vfsmount of 'K'
+   'M', 'L', 'N' have their ->mnt_master point to struct vfsmount of 'K'
 
-	K's ->mnt_slave_list links with ->mnt_slave of 'M', 'L' and 'N'
+   K's ->mnt_slave_list links with ->mnt_slave of 'M', 'L' and 'N'
 
-	C's ->mnt_slave_list links with ->mnt_slave of 'J' and 'K'
+   C's ->mnt_slave_list links with ->mnt_slave of 'J' and 'K'
 
-	J and K's ->mnt_master points to struct vfsmount of C
+   J and K's ->mnt_master points to struct vfsmount of C
 
-	and finally D's ->mnt_slave_list links with ->mnt_slave of 'H' and 'I'
+   and finally D's ->mnt_slave_list links with ->mnt_slave of 'H' and 'I'
 
-	'H' and 'I' have their ->mnt_master pointing to struct vfsmount of 'D'.
+   'H' and 'I' have their ->mnt_master pointing to struct vfsmount of 'D'.
 
 
-	NOTE: The propagation tree is orthogonal to the mount tree.
+   NOTE: The propagation tree is orthogonal to the mount tree.
 
 B) Locking:
 
-	->mnt_share, ->mnt_slave, ->mnt_slave_list, ->mnt_master are protected
-	by namespace_sem (exclusive for modifications, shared for reading).
+   ->mnt_share, ->mnt_slave, ->mnt_slave_list, ->mnt_master are protected
+   by namespace_sem (exclusive for modifications, shared for reading).
 
-	Normally we have ->mnt_flags modifications serialized by vfsmount_lock.
-	There are two exceptions: do_add_mount() and clone_mnt().
-	The former modifies a vfsmount that has not been visible in any shared
-	data structures yet.
-	The latter holds namespace_sem and the only references to vfsmount
-	are in lists that can't be traversed without namespace_sem.
+   Normally we have ->mnt_flags modifications serialized by vfsmount_lock.
+   There are two exceptions: do_add_mount() and clone_mnt().
+   The former modifies a vfsmount that has not been visible in any shared
+   data structures yet.
+   The latter holds namespace_sem and the only references to vfsmount
+   are in lists that can't be traversed without namespace_sem.
 
 C) Algorithm:
 
-	The crux of the implementation resides in rbind/move operation.
+   The crux of the implementation resides in rbind/move operation.
 
-	The overall algorithm breaks the operation into 3 phases: (look at
-	attach_recursive_mnt() and propagate_mnt())
+   The overall algorithm breaks the operation into 3 phases: (look at
+   attach_recursive_mnt() and propagate_mnt())
 
-	1. Prepare phase.
+   1. Prepare phase.
 
-	   For each mount in the source tree:
+      For each mount in the source tree:
 
-	   a) Create the necessary number of mount trees to
-	      be attached to each of the mounts that receive
-	      propagation from the destination mount.
-	   b) Do not attach any of the trees to its destination.
-	      However note down its ->mnt_parent and ->mnt_mountpoint
-	   c) Link all the new mounts to form a propagation tree that
-	      is identical to the propagation tree of the destination
-	      mount.
+      a) Create the necessary number of mount trees to
+         be attached to each of the mounts that receive
+         propagation from the destination mount.
+      b) Do not attach any of the trees to its destination.
+         However note down its ->mnt_parent and ->mnt_mountpoint
+      c) Link all the new mounts to form a propagation tree that
+         is identical to the propagation tree of the destination
+         mount.
 
-	   If this phase is successful, there should be 'n' new
-           propagation trees; where 'n' is the number of mounts in the
-	   source tree.  Go to the commit phase
+      If this phase is successful, there should be 'n' new
+      propagation trees; where 'n' is the number of mounts in the
+      source tree.  Go to the commit phase
 
-	   Also there should be 'm' new mount trees, where 'm' is
-	   the number of mounts to which the destination mount
-	   propagates to.
+      Also there should be 'm' new mount trees, where 'm' is
+      the number of mounts to which the destination mount
+      propagates to.
 
-	   If any memory allocations fail, go to the abort phase.
+      If any memory allocations fail, go to the abort phase.
 
-	2. Commit phase.
+   2. Commit phase.
 
-	   Attach each of the mount trees to their corresponding
-	   destination mounts.
+      Attach each of the mount trees to their corresponding
+      destination mounts.
 
-	3. Abort phase.
-	   Delete all the newly created trees.
+   3. Abort phase.
 
-	.. Note::
-	   all the propagation related functionality resides in the file pnode.c
+      Delete all the newly created trees.
+
+   .. Note::
+      all the propagation related functionality resides in the file pnode.c
 
 
 ------------------------------------------------------------------------
-- 
An old man doll... just what I always wanted! - Clara


