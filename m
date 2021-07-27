Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407C23D833C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhG0WnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:43:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57124 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhG0WnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:43:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00CDC21E78;
        Tue, 27 Jul 2021 22:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TpbPbKdpPuBJzOYDLGprabdAvWGnrm1h37EgRsFnts=;
        b=nL3M6YWdd6o/ZyD521zO3PjVfu0MTzCsWfh5OhGkhN+KcPtsm7tK6ucvRHtwju5ekFeADP
        8VOhZduis4H2FoVdVUGFqcb/2iWKNHpSknpDOKR1qiyrsY60T7v7yJY90My65vOmYcvRjO
        XgoiDdNrdPjliyJXcZTC6eovo4jU+aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TpbPbKdpPuBJzOYDLGprabdAvWGnrm1h37EgRsFnts=;
        b=CZzlkIxkHsCqWkUwj+ehsgFgw7bBL5VYd774t4FPisdItlI2nO0Krq1bvu+lubYsJBh0kb
        8RxuZBklBv4lCnDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FA2313A5D;
        Tue, 27 Jul 2021 22:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2DnzM/SLAGGsVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:00 +0000
Subject: [PATCH 04/11] VFS: export lookup_mnt()
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
Message-ID: <162742546551.32498.5847026750506620683.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to support filehandle lookup in filesystems with internal
mounts (multiple subvols in the one filesystem) reconnect_path() in
exportfs will need to find out if a given dentry is already mounted.
This can be done with the function lookup_mnt(), so export that to make
it available.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/internal.h         |    1 -
 fs/namespace.c        |    1 +
 include/linux/mount.h |    2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index 3ce8edbaa3ca..0feb2722d2e5 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -81,7 +81,6 @@ int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 /*
  * namespace.c
  */
-extern struct vfsmount *lookup_mnt(const struct path *);
 extern int finish_automount(struct vfsmount *, struct path *);
 
 extern int sb_prepare_remount_readonly(struct super_block *);
diff --git a/fs/namespace.c b/fs/namespace.c
index 81b0f2b2e701..73bbdb921e24 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -662,6 +662,7 @@ struct vfsmount *lookup_mnt(const struct path *path)
 	rcu_read_unlock();
 	return m;
 }
+EXPORT_SYMBOL(lookup_mnt);
 
 static inline void lock_ns_list(struct mnt_namespace *ns)
 {
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5d92a7e1a742..1d3daed88f83 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -118,6 +118,8 @@ extern unsigned int sysctl_mount_max;
 
 extern bool path_is_mountpoint(const struct path *path);
 
+extern struct vfsmount *lookup_mnt(const struct path *);
+
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 #endif /* _LINUX_MOUNT_H */


