Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1F1BB032
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 23:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgD0VSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 17:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgD0VR1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:27 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31D0221F5;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022245;
        bh=MSIDkFQpjWNdQzmc0lgQ2AK9rlXYgAOEwcZyNa8KNRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3XXjO2hAye0oXSPFyz6H8bVTEF1v6Zxd7OkU1rEfhDezRv92KAXQRTJbgSBDF+Yl
         1PB4+2YkFZbFZe3pz3BuMZYgkAuu2N5g7JTFIWjroQrEd959ovhsbfGwGzqMQ6bjn/
         vOYFmnRXj83LE/ROn+GA1Rzpg9n4Rbx++p1DVrHU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7z-000HlD-3Q; Mon, 27 Apr 2020 23:17:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 20/29] docs: filesystems: convert sharedsubtree.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:12 +0200
Message-Id: <6692b8abc177130e9e53aace94117a2ad076cab5.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 Documentation/filesystems/proc.rst            |   2 +-
 .../{sharedsubtree.txt => sharedsubtree.rst}  | 394 ++++++++++--------
 3 files changed, 227 insertions(+), 170 deletions(-)
 rename Documentation/filesystems/{sharedsubtree.txt => sharedsubtree.rst} (72%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1a99767f39e5..30f1583015bd 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -33,6 +33,7 @@ algorithms work.
    mount_api
    quota
    seq_file
+   sharedsubtree
 
    automount-support
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 38b606991065..a567bcccbb02 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1870,7 +1870,7 @@ unbindable        mount is unbindable
 
 For more information on mount propagation see:
 
-  Documentation/filesystems/sharedsubtree.txt
+  Documentation/filesystems/sharedsubtree.rst
 
 
 3.6	/proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
diff --git a/Documentation/filesystems/sharedsubtree.txt b/Documentation/filesystems/sharedsubtree.rst
similarity index 72%
rename from Documentation/filesystems/sharedsubtree.txt
rename to Documentation/filesystems/sharedsubtree.rst
index 8ccfbd55244b..d83395354250 100644
--- a/Documentation/filesystems/sharedsubtree.txt
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -1,7 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
 Shared Subtrees
----------------
+===============
 
-Contents:
+.. Contents:
 	1) Overview
 	2) Features
 	3) Setting mount states
@@ -41,31 +44,38 @@ replicas continue to be exactly same.
 
 	Here is an example:
 
-	Let's say /mnt has a mount that is shared.
-	mount --make-shared /mnt
+	Let's say /mnt has a mount that is shared::
+
+	    mount --make-shared /mnt
 
 	Note: mount(8) command now supports the --make-shared flag,
 	so the sample 'smount' program is no longer needed and has been
 	removed.
 
-	# mount --bind /mnt /tmp
+	::
+
+	    # mount --bind /mnt /tmp
+
 	The above command replicates the mount at /mnt to the mountpoint /tmp
 	and the contents of both the mounts remain identical.
 
-	#ls /mnt
-	a b c
+	::
 
-	#ls /tmp
-	a b c
+	    #ls /mnt
+	    a b c
 
-	Now let's say we mount a device at /tmp/a
-	# mount /dev/sd0  /tmp/a
+	    #ls /tmp
+	    a b c
 
-	#ls /tmp/a
-	t1 t2 t3
+	Now let's say we mount a device at /tmp/a::
 
-	#ls /mnt/a
-	t1 t2 t3
+	    # mount /dev/sd0  /tmp/a
+
+	    #ls /tmp/a
+	    t1 t2 t3
+
+	    #ls /mnt/a
+	    t1 t2 t3
 
 	Note that the mount has propagated to the mount at /mnt as well.
 
@@ -123,14 +133,15 @@ replicas continue to be exactly same.
 
 2d) A unbindable mount is a unbindable private mount
 
-	let's say we have a mount at /mnt and we make it unbindable
+	let's say we have a mount at /mnt and we make it unbindable::
 
-	# mount --make-unbindable /mnt
+	    # mount --make-unbindable /mnt
 
-	 Let's try to bind mount this mount somewhere else.
-	 # mount --bind /mnt /tmp
-	 mount: wrong fs type, bad option, bad superblock on /mnt,
-	        or too many mounted file systems
+	 Let's try to bind mount this mount somewhere else::
+
+	    # mount --bind /mnt /tmp
+	    mount: wrong fs type, bad option, bad superblock on /mnt,
+		    or too many mounted file systems
 
 	Binding a unbindable mount is a invalid operation.
 
@@ -138,12 +149,12 @@ replicas continue to be exactly same.
 3) Setting mount states
 
 	The mount command (util-linux package) can be used to set mount
-	states:
+	states::
 
-	mount --make-shared mountpoint
-	mount --make-slave mountpoint
-	mount --make-private mountpoint
-	mount --make-unbindable mountpoint
+	    mount --make-shared mountpoint
+	    mount --make-slave mountpoint
+	    mount --make-private mountpoint
+	    mount --make-unbindable mountpoint
 
 
 4) Use cases
@@ -154,9 +165,10 @@ replicas continue to be exactly same.
 
 	   Solution:
 
-		The system administrator can make the mount at /cdrom shared
-		mount --bind /cdrom /cdrom
-		mount --make-shared /cdrom
+		The system administrator can make the mount at /cdrom shared::
+
+		    mount --bind /cdrom /cdrom
+		    mount --make-shared /cdrom
 
 		Now any process that clones off a new namespace will have a
 		mount at /cdrom which is a replica of the same mount in the
@@ -172,14 +184,14 @@ replicas continue to be exactly same.
 	   Solution:
 
 		To begin with, the administrator can mark the entire mount tree
-		as shareable.
+		as shareable::
 
-		mount --make-rshared /
+		    mount --make-rshared /
 
 		A new process can clone off a new namespace. And mark some part
-		of its namespace as slave
+		of its namespace as slave::
 
-		mount --make-rslave /myprivatetree
+		    mount --make-rslave /myprivatetree
 
 		Hence forth any mounts within the /myprivatetree done by the
 		process will not show up in any other namespace. However mounts
@@ -206,13 +218,13 @@ replicas continue to be exactly same.
 		versions of the file depending on the path used to access that
 		file.
 
-		An example is:
+		An example is::
 
-		mount --make-shared /
-		mount --rbind / /view/v1
-		mount --rbind / /view/v2
-		mount --rbind / /view/v3
-		mount --rbind / /view/v4
+		    mount --make-shared /
+		    mount --rbind / /view/v1
+		    mount --rbind / /view/v2
+		    mount --rbind / /view/v3
+		    mount --rbind / /view/v4
 
 		and if /usr has a versioning filesystem mounted, then that
 		mount appears at /view/v1/usr, /view/v2/usr, /view/v3/usr and
@@ -224,8 +236,8 @@ replicas continue to be exactly same.
 		filesystem is being requested and return the corresponding
 		inode.
 
-5) Detailed semantics:
--------------------
+5) Detailed semantics
+---------------------
 	The section below explains the detailed semantics of
 	bind, rbind, move, mount, umount and clone-namespace operations.
 
@@ -235,6 +247,7 @@ replicas continue to be exactly same.
 5a) Mount states
 
 	A given mount can be in one of the following states
+
 	1) shared
 	2) slave
 	3) shared and slave
@@ -252,7 +265,8 @@ replicas continue to be exactly same.
 		A 'shared mount' is defined as a vfsmount that belongs to a
 		'peer group'.
 
-		For example:
+		For example::
+
 			mount --make-shared /mnt
 			mount --bind /mnt /tmp
 
@@ -270,7 +284,7 @@ replicas continue to be exactly same.
 		A slave mount as the name implies has a master mount from which
 		mount/unmount events are received. Events do not propagate from
 		the slave mount to the master.  Only a shared mount can be made
-		a slave by executing the following command
+		a slave by executing the following command::
 
 			mount --make-slave mount
 
@@ -290,8 +304,10 @@ replicas continue to be exactly same.
 		peer group.
 
 		Only a slave vfsmount can be made as 'shared and slave' by
-		either executing the following command
+		either executing the following command::
+
 			mount --make-shared mount
+
 		or by moving the slave vfsmount under a shared vfsmount.
 
 	(4) Private mount
@@ -307,30 +323,32 @@ replicas continue to be exactly same.
 
 
    	State diagram:
+
    	The state diagram below explains the state transition of a mount,
-	in response to various commands.
-	------------------------------------------------------------------------
-	|             |make-shared |  make-slave  | make-private |make-unbindab|
-	--------------|------------|--------------|--------------|-------------|
-	|shared	      |shared	   |*slave/private|   private	 | unbindable  |
-	|             |            |              |              |             |
-	|-------------|------------|--------------|--------------|-------------|
-	|slave	      |shared      |	**slave	  |    private   | unbindable  |
-	|             |and slave   |              |              |             |
-	|-------------|------------|--------------|--------------|-------------|
-	|shared	      |shared      |    slave	  |    private   | unbindable  |
-	|and slave    |and slave   |              |              |             |
-	|-------------|------------|--------------|--------------|-------------|
-	|private      |shared	   |  **private	  |    private   | unbindable  |
-	|-------------|------------|--------------|--------------|-------------|
-	|unbindable   |shared	   |**unbindable  |    private   | unbindable  |
-	------------------------------------------------------------------------
+	in response to various commands::
 
-	* if the shared mount is the only mount in its peer group, making it
-	slave, makes it private automatically. Note that there is no master to
-	which it can be slaved to.
+	    -----------------------------------------------------------------------
+	    |             |make-shared |  make-slave  | make-private |make-unbindab|
+	    --------------|------------|--------------|--------------|-------------|
+	    |shared	  |shared      |*slave/private|   private    | unbindable  |
+	    |             |            |              |              |             |
+	    |-------------|------------|--------------|--------------|-------------|
+	    |slave	  |shared      | **slave      |    private   | unbindable  |
+	    |             |and slave   |              |              |             |
+	    |-------------|------------|--------------|--------------|-------------|
+	    |shared       |shared      | slave        |    private   | unbindable  |
+	    |and slave    |and slave   |              |              |             |
+	    |-------------|------------|--------------|--------------|-------------|
+	    |private      |shared      |  **private   |    private   | unbindable  |
+	    |-------------|------------|--------------|--------------|-------------|
+	    |unbindable   |shared      |**unbindable  |    private   | unbindable  |
+	    ------------------------------------------------------------------------
 
-	** slaving a non-shared mount has no effect on the mount.
+	    * if the shared mount is the only mount in its peer group, making it
+	    slave, makes it private automatically. Note that there is no master to
+	    which it can be slaved to.
+
+	    ** slaving a non-shared mount has no effect on the mount.
 
 	Apart from the commands listed below, the 'move' operation also changes
 	the state of a mount depending on type of the destination mount. Its
@@ -338,31 +356,32 @@ replicas continue to be exactly same.
 
 5b) Bind semantics
 
-	Consider the following command
+	Consider the following command::
 
-	mount --bind A/a  B/b
+	    mount --bind A/a  B/b
 
 	where 'A' is the source mount, 'a' is the dentry in the mount 'A', 'B'
 	is the destination mount and 'b' is the dentry in the destination mount.
 
 	The outcome depends on the type of mount of 'A' and 'B'. The table
-	below contains quick reference.
-   ---------------------------------------------------------------------------
-   |         BIND MOUNT OPERATION                                            |
-   |**************************************************************************
-   |source(A)->| shared       |       private  |       slave    | unbindable |
-   | dest(B)  |               |                |                |            |
-   |   |      |               |                |                |            |
-   |   v      |               |                |                |            |
-   |**************************************************************************
-   |  shared  | shared        |     shared     | shared & slave |  invalid   |
-   |          |               |                |                |            |
-   |non-shared| shared        |      private   |      slave     |  invalid   |
-   ***************************************************************************
+	below contains quick reference::
+
+	    --------------------------------------------------------------------------
+	    |         BIND MOUNT OPERATION                                           |
+	    |************************************************************************|
+	    |source(A)->| shared      |       private  |       slave    | unbindable |
+	    | dest(B)  |              |                |                |            |
+	    |   |      |              |                |                |            |
+	    |   v      |              |                |                |            |
+	    |************************************************************************|
+	    |  shared  | shared       |     shared     | shared & slave |  invalid   |
+	    |          |              |                |                |            |
+	    |non-shared| shared       |      private   |      slave     |  invalid   |
+	    **************************************************************************
 
      	Details:
 
-	1. 'A' is a shared mount and 'B' is a shared mount. A new mount 'C'
+    1. 'A' is a shared mount and 'B' is a shared mount. A new mount 'C'
 	which is clone of 'A', is created. Its root dentry is 'a' . 'C' is
 	mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
 	are created and mounted at the dentry 'b' on all mounts where 'B'
@@ -371,7 +390,7 @@ replicas continue to be exactly same.
 	'B'.  And finally the peer-group of 'C' is merged with the peer group
 	of 'A'.
 
-	2. 'A' is a private mount and 'B' is a shared mount. A new mount 'C'
+    2. 'A' is a private mount and 'B' is a shared mount. A new mount 'C'
 	which is clone of 'A', is created. Its root dentry is 'a'. 'C' is
 	mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
 	are created and mounted at the dentry 'b' on all mounts where 'B'
@@ -379,7 +398,7 @@ replicas continue to be exactly same.
 	'C', 'C1', .., 'Cn' with exactly the same configuration as the
 	propagation tree for 'B'.
 
-	3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount. A new
+    3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount. A new
 	mount 'C' which is clone of 'A', is created. Its root dentry is 'a' .
 	'C' is mounted on mount 'B' at dentry 'b'. Also new mounts 'C1', 'C2',
 	'C3' ... are created and mounted at the dentry 'b' on all mounts where
@@ -389,19 +408,19 @@ replicas continue to be exactly same.
 	is made the slave of mount 'Z'.  In other words, mount 'C' is in the
 	state 'slave and shared'.
 
-	4. 'A' is a unbindable mount and 'B' is a shared mount. This is a
+    4. 'A' is a unbindable mount and 'B' is a shared mount. This is a
 	invalid operation.
 
-	5. 'A' is a private mount and 'B' is a non-shared(private or slave or
+    5. 'A' is a private mount and 'B' is a non-shared(private or slave or
 	unbindable) mount. A new mount 'C' which is clone of 'A', is created.
 	Its root dentry is 'a'. 'C' is mounted on mount 'B' at dentry 'b'.
 
-	6. 'A' is a shared mount and 'B' is a non-shared mount. A new mount 'C'
+    6. 'A' is a shared mount and 'B' is a non-shared mount. A new mount 'C'
 	which is a clone of 'A' is created. Its root dentry is 'a'. 'C' is
 	mounted on mount 'B' at dentry 'b'.  'C' is made a member of the
 	peer-group of 'A'.
 
-	7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount. A
+    7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount. A
 	new mount 'C' which is a clone of 'A' is created. Its root dentry is
 	'a'.  'C' is mounted on mount 'B' at dentry 'b'. Also 'C' is set as a
 	slave mount of 'Z'. In other words 'A' and 'C' are both slave mounts of
@@ -409,7 +428,7 @@ replicas continue to be exactly same.
 	mount/unmount on 'A' do not propagate anywhere else. Similarly
 	mount/unmount on 'C' do not propagate anywhere else.
 
-	8. 'A' is a unbindable mount and 'B' is a non-shared mount. This is a
+    8. 'A' is a unbindable mount and 'B' is a non-shared mount. This is a
 	invalid operation. A unbindable mount cannot be bind mounted.
 
 5c) Rbind semantics
@@ -422,7 +441,9 @@ replicas continue to be exactly same.
 	then the subtree under the unbindable mount is pruned in the new
 	location.
 
-	eg: let's say we have the following mount tree.
+	eg:
+
+	  let's say we have the following mount tree::
 
 		A
 	      /   \
@@ -430,12 +451,12 @@ replicas continue to be exactly same.
 	     / \ / \
 	     D E F G
 
-	     Let's say all the mount except the mount C in the tree are
-	     of a type other than unbindable.
+	  Let's say all the mount except the mount C in the tree are
+	  of a type other than unbindable.
 
-	     If this tree is rbound to say Z
+	  If this tree is rbound to say Z
 
-	     We will have the following tree at the new location.
+	  We will have the following tree at the new location::
 
 		Z
 		|
@@ -457,24 +478,26 @@ replicas continue to be exactly same.
 	the dentry in the destination mount.
 
 	The outcome depends on the type of the mount of 'A' and 'B'. The table
-	below is a quick reference.
-   ---------------------------------------------------------------------------
-   |         		MOVE MOUNT OPERATION                                 |
-   |**************************************************************************
-   | source(A)->| shared      |       private  |       slave    | unbindable |
-   | dest(B)  |               |                |                |            |
-   |   |      |               |                |                |            |
-   |   v      |               |                |                |            |
-   |**************************************************************************
-   |  shared  | shared        |     shared     |shared and slave|  invalid   |
-   |          |               |                |                |            |
-   |non-shared| shared        |      private   |    slave       | unbindable |
-   ***************************************************************************
-	NOTE: moving a mount residing under a shared mount is invalid.
+	below is a quick reference::
+
+	    ---------------------------------------------------------------------------
+	    |         		MOVE MOUNT OPERATION                                 |
+	    |**************************************************************************
+	    | source(A)->| shared      |       private  |       slave    | unbindable |
+	    | dest(B)  |               |                |                |            |
+	    |   |      |               |                |                |            |
+	    |   v      |               |                |                |            |
+	    |**************************************************************************
+	    |  shared  | shared        |     shared     |shared and slave|  invalid   |
+	    |          |               |                |                |            |
+	    |non-shared| shared        |      private   |    slave       | unbindable |
+	    ***************************************************************************
+
+	.. Note:: moving a mount residing under a shared mount is invalid.
 
       Details follow:
 
-	1. 'A' is a shared mount and 'B' is a shared mount.  The mount 'A' is
+    1. 'A' is a shared mount and 'B' is a shared mount.  The mount 'A' is
 	mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1', 'A2'...'An'
 	are created and mounted at dentry 'b' on all mounts that receive
 	propagation from mount 'B'. A new propagation tree is created in the
@@ -483,7 +506,7 @@ replicas continue to be exactly same.
 	propagation tree is appended to the already existing propagation tree
 	of 'A'.
 
-	2. 'A' is a private mount and 'B' is a shared mount. The mount 'A' is
+    2. 'A' is a private mount and 'B' is a shared mount. The mount 'A' is
 	mounted on mount 'B' at dentry 'b'. Also new mount 'A1', 'A2'... 'An'
 	are created and mounted at dentry 'b' on all mounts that receive
 	propagation from mount 'B'. The mount 'A' becomes a shared mount and a
@@ -491,7 +514,7 @@ replicas continue to be exactly same.
 	'B'. This new propagation tree contains all the new mounts 'A1',
 	'A2'...  'An'.
 
-	3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount.  The
+    3. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount.  The
 	mount 'A' is mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1',
 	'A2'... 'An' are created and mounted at dentry 'b' on all mounts that
 	receive propagation from mount 'B'. A new propagation tree is created
@@ -501,32 +524,32 @@ replicas continue to be exactly same.
 	'A'.  Mount 'A' continues to be the slave mount of 'Z' but it also
 	becomes 'shared'.
 
-	4. 'A' is a unbindable mount and 'B' is a shared mount. The operation
+    4. 'A' is a unbindable mount and 'B' is a shared mount. The operation
 	is invalid. Because mounting anything on the shared mount 'B' can
 	create new mounts that get mounted on the mounts that receive
 	propagation from 'B'.  And since the mount 'A' is unbindable, cloning
 	it to mount at other mountpoints is not possible.
 
-	5. 'A' is a private mount and 'B' is a non-shared(private or slave or
+    5. 'A' is a private mount and 'B' is a non-shared(private or slave or
 	unbindable) mount. The mount 'A' is mounted on mount 'B' at dentry 'b'.
 
-	6. 'A' is a shared mount and 'B' is a non-shared mount.  The mount 'A'
+    6. 'A' is a shared mount and 'B' is a non-shared mount.  The mount 'A'
 	is mounted on mount 'B' at dentry 'b'.  Mount 'A' continues to be a
 	shared mount.
 
-	7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount.
+    7. 'A' is a slave mount of mount 'Z' and 'B' is a non-shared mount.
 	The mount 'A' is mounted on mount 'B' at dentry 'b'.  Mount 'A'
 	continues to be a slave mount of mount 'Z'.
 
-	8. 'A' is a unbindable mount and 'B' is a non-shared mount. The mount
+    8. 'A' is a unbindable mount and 'B' is a non-shared mount. The mount
 	'A' is mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a
 	unbindable mount.
 
 5e) Mount semantics
 
-	Consider the following command
+	Consider the following command::
 
-	mount device  B/b
+	    mount device  B/b
 
 	'B' is the destination mount and 'b' is the dentry in the destination
 	mount.
@@ -537,9 +560,9 @@ replicas continue to be exactly same.
 
 5f) Unmount semantics
 
-	Consider the following command
+	Consider the following command::
 
-	umount A
+	    umount A
 
 	where 'A' is a mount mounted on mount 'B' at dentry 'b'.
 
@@ -592,10 +615,12 @@ replicas continue to be exactly same.
 
 	A. What is the result of the following command sequence?
 
-		mount --bind /mnt /mnt
-		mount --make-shared /mnt
-		mount --bind /mnt /tmp
-		mount --move /tmp /mnt/1
+		::
+
+		    mount --bind /mnt /mnt
+		    mount --make-shared /mnt
+		    mount --bind /mnt /tmp
+		    mount --move /tmp /mnt/1
 
 		what should be the contents of /mnt /mnt/1 /mnt/1/1 should be?
 		Should they all be identical? or should /mnt and /mnt/1 be
@@ -604,23 +629,27 @@ replicas continue to be exactly same.
 
 	B. What is the result of the following command sequence?
 
-		mount --make-rshared /
-		mkdir -p /v/1
-		mount --rbind / /v/1
+		::
+
+		    mount --make-rshared /
+		    mkdir -p /v/1
+		    mount --rbind / /v/1
 
 		what should be the content of /v/1/v/1 be?
 
 
 	C. What is the result of the following command sequence?
 
-		mount --bind /mnt /mnt
-		mount --make-shared /mnt
-		mkdir -p /mnt/1/2/3 /mnt/1/test
-		mount --bind /mnt/1 /tmp
-		mount --make-slave /mnt
-		mount --make-shared /mnt
-		mount --bind /mnt/1/2 /tmp1
-		mount --make-slave /mnt
+		::
+
+		    mount --bind /mnt /mnt
+		    mount --make-shared /mnt
+		    mkdir -p /mnt/1/2/3 /mnt/1/test
+		    mount --bind /mnt/1 /tmp
+		    mount --make-slave /mnt
+		    mount --make-shared /mnt
+		    mount --bind /mnt/1/2 /tmp1
+		    mount --make-slave /mnt
 
 		At this point we have the first mount at /tmp and
 		its root dentry is 1. Let's call this mount 'A'
@@ -668,7 +697,8 @@ replicas continue to be exactly same.
 
 		step 1:
 		   let's say the root tree has just two directories with
-		   one vfsmount.
+		   one vfsmount::
+
 				    root
 				   /    \
 				  tmp    usr
@@ -676,14 +706,17 @@ replicas continue to be exactly same.
 		    And we want to replicate the tree at multiple
 		    mountpoints under /root/tmp
 
-		step2:
-		      mount --make-shared /root
+		step 2:
+		      ::
 
-		      mkdir -p /tmp/m1
 
-		      mount --rbind /root /tmp/m1
+			mount --make-shared /root
 
-		      the new tree now looks like this:
+			mkdir -p /tmp/m1
+
+			mount --rbind /root /tmp/m1
+
+		      the new tree now looks like this::
 
 				    root
 				   /    \
@@ -697,11 +730,13 @@ replicas continue to be exactly same.
 
 			  it has two vfsmounts
 
-		step3:
+		step 3:
+		    ::
+
 			    mkdir -p /tmp/m2
 			    mount --rbind /root /tmp/m2
 
-			the new tree now looks like this:
+			the new tree now looks like this::
 
 				      root
 				     /    \
@@ -724,6 +759,7 @@ replicas continue to be exactly same.
 		       it has 6 vfsmounts
 
 		step 4:
+		      ::
 			  mkdir -p /tmp/m3
 			  mount --rbind /root /tmp/m3
 
@@ -740,7 +776,8 @@ replicas continue to be exactly same.
 
 		step 1:
 		   let's say the root tree has just two directories with
-		   one vfsmount.
+		   one vfsmount::
+
 				    root
 				   /    \
 				  tmp    usr
@@ -748,17 +785,20 @@ replicas continue to be exactly same.
 		    How do we set up the same tree at multiple locations under
 		    /root/tmp
 
-		step2:
-		      mount --bind /root/tmp /root/tmp
+		step 2:
+		      ::
 
-		      mount --make-rshared /root
-		      mount --make-unbindable /root/tmp
 
-		      mkdir -p /tmp/m1
+			mount --bind /root/tmp /root/tmp
 
-		      mount --rbind /root /tmp/m1
+			mount --make-rshared /root
+			mount --make-unbindable /root/tmp
 
-		      the new tree now looks like this:
+			mkdir -p /tmp/m1
+
+			mount --rbind /root /tmp/m1
+
+		      the new tree now looks like this::
 
 				    root
 				   /    \
@@ -768,11 +808,13 @@ replicas continue to be exactly same.
 			      /  \
 			     tmp  usr
 
-		step3:
+		step 3:
+		      ::
+
 			    mkdir -p /tmp/m2
 			    mount --rbind /root /tmp/m2
 
-		      the new tree now looks like this:
+		      the new tree now looks like this::
 
 				    root
 				   /    \
@@ -782,12 +824,13 @@ replicas continue to be exactly same.
 			      /  \     / \
 			     tmp  usr tmp usr
 
-		step4:
+		step 4:
+		      ::
 
 			    mkdir -p /tmp/m3
 			    mount --rbind /root /tmp/m3
 
-		      the new tree now looks like this:
+		      the new tree now looks like this::
 
 				    	  root
 				      /    	  \
@@ -801,25 +844,31 @@ replicas continue to be exactly same.
 
 8A) Datastructure
 
-	4 new fields are introduced to struct vfsmount
+	4 new fields are introduced to struct vfsmount:
+
+	*   ->mnt_share
+	*   ->mnt_slave_list
+	*   ->mnt_slave
+	*   ->mnt_master
+
 	->mnt_share
-	->mnt_slave_list
-	->mnt_slave
-	->mnt_master
-
-	->mnt_share links together all the mount to/from which this vfsmount
+		links together all the mount to/from which this vfsmount
 		send/receives propagation events.
 
-	->mnt_slave_list links all the mounts to which this vfsmount propagates
+	->mnt_slave_list
+		links all the mounts to which this vfsmount propagates
 		to.
 
-	->mnt_slave links together all the slaves that its master vfsmount
+	->mnt_slave
+		links together all the slaves that its master vfsmount
 		propagates to.
 
-	->mnt_master points to the master vfsmount from which this vfsmount
+	->mnt_master
+		points to the master vfsmount from which this vfsmount
 		receives propagation.
 
-	->mnt_flags takes two more flags to indicate the propagation status of
+	->mnt_flags
+		takes two more flags to indicate the propagation status of
 		the vfsmount.  MNT_SHARE indicates that the vfsmount is a shared
 		vfsmount.  MNT_UNCLONABLE indicates that the vfsmount cannot be
 		replicated.
@@ -842,7 +891,7 @@ replicas continue to be exactly same.
 
 	A example propagation tree looks as shown in the figure below.
 	[ NOTE: Though it looks like a forest, if we consider all the shared
-	mounts as a conceptual entity called 'pnode', it becomes a tree]
+	mounts as a conceptual entity called 'pnode', it becomes a tree]::
 
 
 		        A <--> B <--> C <---> D
@@ -864,14 +913,19 @@ replicas continue to be exactly same.
 	A's ->mnt_slave_list links with ->mnt_slave of 'E', 'K', 'F' and 'G'
 
 	E's ->mnt_share links with ->mnt_share of K
-	'E', 'K', 'F', 'G' have their ->mnt_master point to struct
-				vfsmount of 'A'
+
+	'E', 'K', 'F', 'G' have their ->mnt_master point to struct vfsmount of 'A'
+
 	'M', 'L', 'N' have their ->mnt_master point to struct vfsmount of 'K'
+
 	K's ->mnt_slave_list links with ->mnt_slave of 'M', 'L' and 'N'
 
 	C's ->mnt_slave_list links with ->mnt_slave of 'J' and 'K'
+
 	J and K's ->mnt_master points to struct vfsmount of C
+
 	and finally D's ->mnt_slave_list links with ->mnt_slave of 'H' and 'I'
+
 	'H' and 'I' have their ->mnt_master pointing to struct vfsmount of 'D'.
 
 
@@ -903,6 +957,7 @@ replicas continue to be exactly same.
 	Prepare phase:
 
 	for each mount in the source tree:
+
 		   a) Create the necessary number of mount trees to
 		   	be attached to each of the mounts that receive
 			propagation from the destination mount.
@@ -929,11 +984,12 @@ replicas continue to be exactly same.
 	Abort phase
 		delete all the newly created trees.
 
-	NOTE: all the propagation related functionality resides in the file
-	pnode.c
+	.. Note::
+	   all the propagation related functionality resides in the file pnode.c
 
 
 ------------------------------------------------------------------------
 
 version 0.1  (created the initial document, Ram Pai linuxram@us.ibm.com)
+
 version 0.2  (Incorporated comments from Al Viro)
-- 
2.25.4

