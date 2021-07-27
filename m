Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC723D833E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhG0WnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:43:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57146 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhG0WnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:43:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2895B21E78;
        Tue, 27 Jul 2021 22:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLs00Rrv/kTcj/5olsX73VJ3zYmRNlaU9tOovlvLkrY=;
        b=CDYrsqvXmziG2cY28/a82LbbwXxEKRAV1gNZwQZZjcmIeTklR0CSSUHSCu/Y8kbUonbe78
        wjytZURQAFUN9P7NL1uOozNd/XxH68LBZ2xuRkX6yleEp1GBawrGqI4r5Uq4RZmKoos8RD
        3E2YzIB7cRdofn5hdWyD0PIc8fkzukw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425792;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLs00Rrv/kTcj/5olsX73VJ3zYmRNlaU9tOovlvLkrY=;
        b=WP2zRKJ88WSgYMmFFXlnfNH3h946jiyNr0bF/6uXF8WrxO9XhcMa7bNsJ2H42E5Iv6mzYx
        6eNbxKV9SskOJzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22F9C13A5D;
        Tue, 27 Jul 2021 22:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rca3NPyLAGGzVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:08 +0000
Subject: [PATCH 05/11] VFS: new function: mount_is_internal()
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546552.32498.14429836898036234922.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the concept of an "internal" mount which is a
mount where a filesystem has create the mount itself.

Both the mounted-on-dentry and the mount's root dentry must refer to the
same superblock (they may be the same dentry), and the mounted-on dentry
must be an automount.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namespace.c        |   29 +++++++++++++++++++++++++++++
 include/linux/mount.h |    2 ++
 2 files changed, 31 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 73bbdb921e24..a14efbccfb03 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1273,6 +1273,35 @@ bool path_is_mountpoint(const struct path *path)
 }
 EXPORT_SYMBOL(path_is_mountpoint);
 
+/**
+ * mount_is_internal() - Check if path is a mount internal to a single filesystem
+ * @mnt: vfsmount to check
+ *
+ * Some filesystems present multiple file-sets using a single
+ * superblock, such as btrfs with multiple subvolumes.  Names within a
+ * parent filesystem which lead to a subordinate filesystem are
+ * implemented as automounts so that the structure is visible in the
+ * mount table.  nfsd needs visibility into this arrangement so that it
+ * can determine if a mountpoint requires a new export, or is completely
+ * covered by an existing mount.
+ *
+ * An "internal" mount is one where the parent and child have the same
+ * superblock, and the mounted-on dentry is "managed" as an automount.  A
+ * filehandle found for an inode in the child can be looked-up using either
+ * vfsmount.
+ */
+bool mount_is_internal(struct vfsmount *mnt)
+{
+	struct mount *m = real_mount(mnt);
+
+	if (!mnt_has_parent(m))
+		return false;
+	if (m->mnt_parent->mnt.mnt_sb != m->mnt.mnt_sb)
+		return false;
+	return m->mnt_mountpoint->d_flags & DCACHE_NEED_AUTOMOUNT;
+}
+EXPORT_SYMBOL(mount_is_internal);
+
 struct vfsmount *mnt_clone_internal(const struct path *path)
 {
 	struct mount *p;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1d3daed88f83..ab58087728ba 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -118,6 +118,8 @@ extern unsigned int sysctl_mount_max;
 
 extern bool path_is_mountpoint(const struct path *path);
 
+extern bool mount_is_internal(struct vfsmount *mnt);
+
 extern struct vfsmount *lookup_mnt(const struct path *);
 
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);


