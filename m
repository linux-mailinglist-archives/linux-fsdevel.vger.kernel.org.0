Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B438B6F96BF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 05:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjEGDuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 23:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjEGDtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 23:49:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5424531;
        Sat,  6 May 2023 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ep7EoMOoXMCq/skLpIelkWlzzgwjPy8ry18J0SW0lZA=; b=igZJPXwyVI+7Jqaiqbow/2/KGW
        mhV8bsAgA31yH20uaY72oHS1r6GuGii9wT7YBFj6YvRqJB9Jdj+y8ToI2smz0orb7P6uK3pmfqLTD
        6SRgIKrv1yiAVZDDH2fRW3mUC8eSQZm0skBG3oTP1BDACxsfAb7AqR4AN9PMExBwYIDVDvnmScjtH
        uA6A3hzp3W2unVoqz2Z2+U36irf6N12aPH3SUCZnq4n468T4MmgV/rRRQIJrHCfrZgoLgQkWiBqt+
        ZCpb/78Tl0ThijaahyS5vB3DwVR055qYBzHKnTlp4DqrW6wMJC7N94YcaJggOImhbNcr2BYisoRCC
        HMeIk8Ew==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvVMU-00F5XF-2a;
        Sun, 07 May 2023 03:47:02 +0000
Date:   Sat, 6 May 2023 20:47:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, ebiederm@xmission.com,
        mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 01/24] fs: unify locking semantics for fs freeze / thaw
Message-ID: <ZFcfNslrktWdIpaW@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-2-mcgrof@kernel.org>
 <20230116151455.lsggdn64jecwh36o@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116151455.lsggdn64jecwh36o@quack3>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:14:55PM +0100, Jan Kara wrote:
> So I  think we may need to also block attempts to unmount frozen filesystem -
> actually GFS2 needs this as well [1].
> 
> [1] lore.kernel.org/r/20221129230736.3462830-1-agruenba@redhat.com

Yes, I reviewed Andreas's patch and I think we end up just complicating
things by allowing us to continue to "support" unmounting frozen
filesystems. Instead it is easier for us to just block that insanity.

Current attempt / non-boot tested or anything.

From: Luis Chamberlain <mcgrof@kernel.org>
Date: Sat, 6 May 2023 20:13:49 -0700
Subject: [RFC] fs: prevent mount / umount of frozen filesystems

Today you can unmount a frozen filesystem. Doing that turns it into
a zombie filesystem, you cannot shut it down until first you remounting
it and then unthawing it.

Enabling this sort of behaviour is madness.

Simplify this by instead just preventing us to unmount frozen
filesystems, and likewise prevent mounting frozen filesystems.

Suggested-by: Jan Kara <jack@suse.cz>
Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/namespace.c |  3 +++
 fs/super.c     | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..9c21d8662fc8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1636,6 +1636,9 @@ static int do_umount(struct mount *mnt, int flags)
 	if (retval)
 		return retval;
 
+	if (!(sb_is_unfrozen(sb)))
+		return -EBUSY;
+
 	/*
 	 * Allow userspace to request a mountpoint be expired rather than
 	 * unmounting unconditionally. Unmount only happens if:
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..55f5728f5090 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -441,6 +441,7 @@ void retire_super(struct super_block *sb)
 {
 	WARN_ON(!sb->s_bdev);
 	down_write(&sb->s_umount);
+	WARN_ON_ONCE(!(sb_is_unfrozen(sb)));
 	if (sb->s_iflags & SB_I_PERSB_BDI) {
 		bdi_unregister(sb->s_bdi);
 		sb->s_iflags &= ~SB_I_PERSB_BDI;
@@ -468,6 +469,7 @@ void generic_shutdown_super(struct super_block *sb)
 {
 	const struct super_operations *sop = sb->s_op;
 
+	WARN_ON_ONCE(!(sb_is_unfrozen(sb)));
 	if (sb->s_root) {
 		shrink_dcache_for_umount(sb);
 		sync_filesystem(sb);
@@ -1354,6 +1356,12 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	if (IS_ERR(s))
 		goto error_s;
 
+	if (!(sb_is_unfrozen(sb))) {
+			deactivate_locked_super(s);
+			error = -EBUSY;
+			goto error_bdev;
+	}
+
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & SB_RDONLY) {
 			deactivate_locked_super(s);
@@ -1473,6 +1481,10 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 	s = sget(fs_type, compare_single, set_anon_super, flags, NULL);
 	if (IS_ERR(s))
 		return ERR_CAST(s);
+	if (!(sb_is_unfrozen(sb))) {
+		deactivate_locked_super(s);
+		return ERR_PTR(-EBUSY);
+	}
 	if (!s->s_root) {
 		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (!error)
@@ -1522,6 +1534,8 @@ int vfs_get_tree(struct fs_context *fc)
 
 	sb = fc->root->d_sb;
 	WARN_ON(!sb->s_bdi);
+	if (!(sb_is_unfrozen(sb)))
+		return -EBUSY;
 
 	/*
 	 * Write barrier is for super_cache_count(). We place it before setting
-- 
2.39.2

