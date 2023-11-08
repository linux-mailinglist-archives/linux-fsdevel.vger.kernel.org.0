Return-Path: <linux-fsdevel+bounces-2372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EF7E520E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327431C20B05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966033457C;
	Wed,  8 Nov 2023 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy9WX5oY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650C63B3;
	Wed,  8 Nov 2023 08:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9B5C433C8;
	Wed,  8 Nov 2023 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699432897;
	bh=5QBjcIVdRyvjtEpZWSfkf0W/R6kVQEZY1wxIeIW+Guc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy9WX5oYj8u2DGbKjKa6DpULaQZGQitNikzEwbZLsmsMwb6nE9im1GJytTQFGsSEi
	 L8pVCZGHY6/sJbHpk5VTddG6lmWPPJSOJxCvQIQ3nledsaQCCJjMcqBKIeHYWtLiva
	 JYHPa1V//LFQw9k1LMxlOfKmoN9c7q7cooGghw15dED4GsWWODUGqDQuP+BP7Tgm8h
	 DZZyZ0YOVdulGJ9xgEMYHEiWKSroUbb/DfLSZYJ2BU5HbmdEi1WB6oaQV8XAJTVGwQ
	 z9c4kdnwwSpvzKewNsbWhYh4zNgoFZ8bIk4HrYMextdZTnZpKd1vAiGvpC+t6YU1k4
	 M0fsZPHYSzqKA==
Date: Wed, 8 Nov 2023 09:41:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] btrfs: handle the ro->rw transition for mounting
 different subovls
Message-ID: <20231108-hallen-heimisch-d6bdb9e23cb7@brauner>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <0a73915edbb8d05e30d167351ea8c709a9bfe447.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a73915edbb8d05e30d167351ea8c709a9bfe447.1699308010.git.josef@toxicpanda.com>

On Mon, Nov 06, 2023 at 05:08:21PM -0500, Josef Bacik wrote:
> This is an oddity that we've carried around since 0723a0473fb4 ("btrfs:
> allow mounting btrfs subvolumes with different ro/rw options") where
> we'll under the covers flip the file system to RW if you're mixing and
> matching ro/rw options with different subvol mounts.  The first mount is
> what the super gets setup as, so we'd handle this by remount the super
> as rw under the covers to facilitate this behavior.
> 
> With the new mount API we can't really allow this, because user space
> has the ability to specify the super block settings, and the mount
> settings.  So if the user explicitly set the super block as read only,
> and then tried to mount a rw mount with the super block we'll reject
> this.  However the old API was less descriptive and thus we allowed this
> kind of behavior.
> 
> This patch preserves this behavior for the old api calls.  This is
> inspired by Christians work, and includes one of his comments, and thus
> is included in the link below.
> 
> Link: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org/
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

Just note that all capitalization was removed from the comment
preceeding btrfs_reconfigure_for_mount() by accident. You might want to
fix that up/recopy that comment.

>  fs/btrfs/super.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4ace42e08bff..e2ac0801211d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2513,13 +2513,15 @@ static int btrfs_reconfigure(struct fs_context *fc)
>  	struct btrfs_fs_context *ctx = fc->fs_private;
>  	struct btrfs_fs_context old_ctx;
>  	int ret = 0;
> +	bool mount_reconfigure = (fc->s_fs_info != NULL);
>  
>  	btrfs_info_to_ctx(fs_info, &old_ctx);
>  
>  	sync_filesystem(sb);
>  	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
>  
> -	if (!check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
> +	if (!mount_reconfigure &&
> +	    !check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
>  		return -EINVAL;
>  
>  	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
> @@ -2922,6 +2924,133 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	return ret;
>  }
>  
> +/*
> + * Christian wrote this long comment about what we're doing here, preserving it
> + * so the history of this change is preserved.
> + *
> + * ever since commit 0723a0473fb4 ("btrfs: allow * mounting btrfs subvolumes
> + * with different ro/rw * options") the following works:
> + *
> + *        (i) mount /dev/sda3 -o subvol=foo,ro /mnt/foo
> + *       (ii) mount /dev/sda3 -o subvol=bar,rw /mnt/bar
> + *
> + * which looks nice and innocent but is actually pretty * intricate and
> + * deserves a long comment.
> + *
> + * on another filesystem a subvolume mount is close to * something like:
> + *
> + *	(iii) # create rw superblock + initial mount
> + *	      mount -t xfs /dev/sdb /opt/
> + *
> + *	      # create ro bind mount
> + *	      mount --bind -o ro /opt/foo /mnt/foo
> + *
> + *	      # unmount initial mount
> + *	      umount /opt
> + *
> + * of course, there's some special subvolume sauce and there's the fact that the
> + * sb->s_root dentry is really swapped after mount_subtree(). but conceptually
> + * it's very close and will help us understand the issue.
> + *
> + * the old mount api didn't cleanly distinguish between a mount being made ro
> + * and a superblock being made ro.  the only way to change the ro state of
> + * either object was by passing ms_rdonly. if a new mount was created via
> + * mount(2) such as:
> + *
> + *      mount("/dev/sdb", "/mnt", "xfs", ms_rdonly, null);
> + *
> + * the ms_rdonly flag being specified had two effects:
> + *
> + * (1) mnt_readonly was raised -> the resulting mount got
> + *     @mnt->mnt_flags |= mnt_readonly raised.
> + *
> + * (2) ms_rdonly was passed to the filesystem's mount method and the filesystems
> + *     made the superblock ro. note, how sb_rdonly has the same value as
> + *     ms_rdonly and is raised whenever ms_rdonly is passed through mount(2).
> + *
> + * creating a subtree mount via (iii) ends up leaving a rw superblock with a
> + * subtree mounted ro.
> + *
> + * but consider the effect on the old mount api on btrfs subvolume mounting
> + * which combines the distinct step in (iii) into a a single step.
> + *
> + * by issuing (i) both the mount and the superblock are turned ro. now when (ii)
> + * is issued the superblock is ro and thus even if the mount created for (ii) is
> + * rw it wouldn't help. hence, btrfs needed to transition the superblock from ro
> + * to rw for (ii) which it did using an internal remount call (a bold
> + * choice...).
> + *
> + * iow, subvolume mounting was inherently messy due to the ambiguity of
> + * ms_rdonly in mount(2). note, this ambiguity has mount(8) always translate
> + * "ro" to ms_rdonly. iow, in both (i) and (ii) "ro" becomes ms_rdonly when
> + * passed by mount(8) to mount(2).
> + *
> + * enter the new mount api. the new mount api disambiguates making a mount ro
> + * and making a superblock ro.
> + *
> + * (3) to turn a mount ro the mount_attr_rdonly flag can be used with either
> + *     fsmount() or mount_setattr() this is a pure vfs level change for a
> + *     specific mount or mount tree that is never seen by the filesystem itself.
> + *
> + * (4) to turn a superblock ro the "ro" flag must be used with
> + *     fsconfig(fsconfig_set_flag, "ro"). this option is seen by the filesytem
> + *     in fc->sb_flags.
> + *
> + * this disambiguation has rather positive consequences.  mounting a subvolume
> + * ro will not also turn the superblock ro. only the mount for the subvolume
> + * will become ro.
> + *
> + * so, if the superblock creation request comes from the new mount api the
> + * caller must've explicitly done:
> + *
> + *      fsconfig(fsconfig_set_flag, "ro")
> + *      fsmount/mount_setattr(mount_attr_rdonly)
> + *
> + * iow, at some point the caller must have explicitly turned the whole
> + * superblock ro and we shouldn't just undo it like we did for the old mount
> + * api. in any case, it lets us avoid this nasty hack in the new mount api.
> + *
> + * Consequently, the remounting hack must only be used for requests originating
> + * from the old mount api and should be marked for full deprecation so it can be
> + * turned off in a couple of years.
> + *
> + * The new mount api has no reason to support this hack.
> + */
> +static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
> +{
> +	struct vfsmount *mnt;
> +	int ret;
> +	bool ro2rw = !(fc->sb_flags & SB_RDONLY);
> +
> +	/*
> +	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
> +	 * super block, so invert our setting here and re-try the mount so we
> +	 * can get our vfsmount.
> +	 */
> +	if (ro2rw)
> +		fc->sb_flags |= SB_RDONLY;
> +	else
> +		fc->sb_flags &= ~SB_RDONLY;
> +
> +	mnt = fc_mount(fc);
> +	if (IS_ERR(mnt))
> +		return mnt;
> +
> +	if (!fc->oldapi || !ro2rw)
> +		return mnt;
> +
> +	/* We need to convert to rw, call reconfigure */
> +	fc->sb_flags &= ~SB_RDONLY;
> +	down_write(&mnt->mnt_sb->s_umount);
> +	ret = btrfs_reconfigure(fc);
> +	up_write(&mnt->mnt_sb->s_umount);
> +	if (ret) {
> +		mntput(mnt);
> +		return ERR_PTR(ret);
> +	}
> +	return mnt;
> +}
> +
>  static int btrfs_get_tree_subvol(struct fs_context *fc)
>  {
>  	struct btrfs_fs_info *fs_info = NULL;
> @@ -2971,6 +3100,8 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
>  	fc->security = NULL;
>  
>  	mnt = fc_mount(dup_fc);
> +	if (PTR_ERR_OR_ZERO(mnt) == -EBUSY)
> +		mnt = btrfs_reconfigure_for_mount(dup_fc);
>  	put_fs_context(dup_fc);
>  	if (IS_ERR(mnt))
>  		return PTR_ERR(mnt);
> -- 
> 2.41.0
> 

