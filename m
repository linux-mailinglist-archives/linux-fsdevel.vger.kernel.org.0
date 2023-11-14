Return-Path: <linux-fsdevel+bounces-2855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA747EB68B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6531F25737
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877C1C05;
	Tue, 14 Nov 2023 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yx1q809n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZXg4bLa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048B33CC6;
	Tue, 14 Nov 2023 18:43:00 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA0F0;
	Tue, 14 Nov 2023 10:42:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82C9421BD5;
	Tue, 14 Nov 2023 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699987377;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRq1xbyM4C5MmPxC/WtmQpu8C8x9/omYZNqYfVPmHuY=;
	b=yx1q809nV9KgQ7sKf7rlj2fqnwWGpwO/qiBPulIoQFtnZ9+FUH5/oU1QDA2OKj4/P6oYNR
	RSFBkeukE0oywZ+S3YltJAye72yDotK27EKa0bcTthBWVuIGNpEfi97Fz+SJa65XszzlgG
	n+ectDuh2aCrdXRHxQKZ4zB+NfNgIBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699987377;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wRq1xbyM4C5MmPxC/WtmQpu8C8x9/omYZNqYfVPmHuY=;
	b=VZXg4bLatWwSKDTikgVE3H3fDRO84c6efkTZUyMwS1B+Afh2ZL61mgmlwBedv48X7gVTKo
	+MSsArqcG08GVHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 483E113416;
	Tue, 14 Nov 2023 18:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fULZELG/U2WSMQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 14 Nov 2023 18:42:57 +0000
Date: Tue, 14 Nov 2023 19:35:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v2 12/18] btrfs: add get_tree callback for new mount API
Message-ID: <20231114183550.GH11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1699470345.git.josef@toxicpanda.com>
 <1dea0813411eb5c08ddcdefcdae006e751dd15eb.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dea0813411eb5c08ddcdefcdae006e751dd15eb.1699470345.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 08, 2023 at 02:08:47PM -0500, Josef Bacik wrote:
> This is the actual mounting callback for the new mount API.  Implement
> this using our current fill super as a guideline, making the appropriate
> adjustments for the new mount API.
> 
> Our old mount operation had two fs_types, one to handle the actual
> opening, and the one that we called to handle the actual opening and
> then did the subvol lookup for returning the actual root dentry.  This
> is mirrored here, but simply with different behaviors for ->get_tree.
> We use the existence of ->s_fs_info to tell which part we're in.  The
> initial call allocates the fs_info, then call mount_fc() with a
> duplicated fc to do the actual open_ctree part.  Then we take that
> vfsmount and use it to look up our subvolume that we're mounting and
> return that as our s_root.  This idea was taken from Christians attempt
> to convert us to the new mount api.
> 
> References: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org/
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 206 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index b5067cf637a2..4ace42e08bff 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -95,6 +95,7 @@ struct btrfs_fs_context {
>  	unsigned long mount_opt;
>  	unsigned long compress_type:4;
>  	unsigned int compress_level;
> +	refcount_t refs;
>  };
>  
>  enum {
> @@ -2833,6 +2834,181 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0;
>  }
>  
> +static int btrfs_fc_test_super(struct super_block *s, struct fs_context *fc)
> +{
> +	struct btrfs_fs_info *p = fc->s_fs_info;

That's a confusing variable name

> +	struct btrfs_fs_info *fs_info = btrfs_sb(s);
> +
> +	return fs_info->fs_devices == p->fs_devices;
> +}
> +
> +static int btrfs_get_tree_super(struct fs_context *fc)
> +{
> +	struct btrfs_fs_info *fs_info = fc->s_fs_info;
> +	struct btrfs_fs_context *ctx = fc->fs_private;
> +	struct btrfs_fs_devices *fs_devices = NULL;
> +	struct block_device *bdev;
> +	struct btrfs_device *device;
> +	struct super_block *s;

Please use 'sb' for super block.

> +	blk_mode_t mode = sb_open_mode(fc->sb_flags);
> +	int ret;
> +
> +	btrfs_ctx_to_info(fs_info, ctx);
> +	mutex_lock(&uuid_mutex);
> +
> +	/*
> +	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
> +	 * either a valid device or an error.
> +	 */
> +	device = btrfs_scan_one_device(fc->source, mode, true);
> +	ASSERT(device != NULL);
> +	if (IS_ERR(device)) {
> +		mutex_unlock(&uuid_mutex);
> +		return PTR_ERR(device);
> +	}
> +
> +	fs_devices = device->fs_devices;
> +	fs_info->fs_devices = fs_devices;
> +
> +	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
> +	mutex_unlock(&uuid_mutex);

Regarding the previous comments about mount and scanning, here the
device is scanned and opened in one go, so all the other devices are
expected to be scanned independently from before.

This is not a prolbem, although it allows to something race in between
the mount option scanning and here and call 'forget' on the devices.
We've seen udev to race with mkfs to register the device, which is not a
problem here, but if there's something calling 'forget' automatically
then it will be.

Since systemd started to mess with background mounts and scans we can
never ber sure what's going to happen when triggered by system events.


> +	if (ret)
> +		return ret;
> +
> +	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
> +		ret = -EACCES;
> +		goto error;
> +	}
> +
> +	bdev = fs_devices->latest_dev->bdev;
> +
> +	/*
> +	 * If successful, this will transfer the fs_info into the super block,
> +	 * and fc->s_fs_info will be NULL.  However if there's an existing
> +	 * super, we'll still have fc->s_fs_info populated.  If we error
> +	 * completely out it'll be cleaned up when we drop the fs_context,
> +	 * otherwise it's tied to the lifetime of the super_block.
> +	 *
> +	 * Adding this comment because I was horribly confused about the error
> +	 * handling from here on out.

The last sentence does not need to be there, that we add comments to
avoid confusion is kind of implicit.

> +	 */
> +	s = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
> +	if (IS_ERR(s)) {
> +		ret = PTR_ERR(s);
> +		goto error;
> +	}
> +
> +	if (s->s_root) {
> +		btrfs_close_devices(fs_devices);
> +		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
> +			ret = -EBUSY;
> +	} else {
> +		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
> +		shrinker_debugfs_rename(&s->s_shrink, "sb-btrfs:%s", s->s_id);

In 6.7-rc1 there's a change do allocate shrinkers dynamically so this
will need to be adjusted

		shrinker_debugfs_rename(s->s_shrink, ...

> +		btrfs_sb(s)->bdev_holder = &btrfs_fs_type;
> +		ret = btrfs_fill_super(s, fs_devices, NULL);
> +	}
> +
> +	if (ret) {
> +		deactivate_locked_super(s);
> +		return ret;
> +	}
> +
> +	fc->root = dget(s->s_root);
> +	return 0;
> +
> +error:
> +	btrfs_close_devices(fs_devices);
> +	return ret;
> +}

