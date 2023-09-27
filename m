Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43227B04A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjI0MtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjI0MtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:49:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A224139
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 05:48:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F5CC433C8;
        Wed, 27 Sep 2023 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695818938;
        bh=LWvCeLqmFK6LBl9xEbcppIZf++XdALRq2CSfyltF/KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=seO5eF+9pVXtuV/5Z8iClqZ2lIcykv+dPB1yyxsIz4fbpL10dFs1lT2+HGceNqLcb
         XbrdGGByjvX8QixzAuQxvsEWKApaGVwScnz01EYDn9R/DwsJ9Em3mU88vjk8vGysak
         A/Ac5iCoxqOD3qT3FqzndwNGNGpvVH9h8uEqWao/yn8FUzkoQL2FgkarI0IPpg5n58
         gYUqVqePq/m+AztFrLIF8RR8BlNDpIXKOolxPqxwznoY+4c8d5YEsAlgkYewv1kP1O
         BAwxEv+JH9x94n+9uVew/oSctjUSjUdoaoRHhWSlqUeVE4SQlvN2nl2bhzu93hylR5
         4khWatEUOej5A==
Date:   Wed, 27 Sep 2023 14:48:50 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/3] tmpfs: Add project quota interface support for
 get/set attr
Message-ID: <20230927124850.ctzuix4vwxw3l5xy@andromeda>
References: <20230925130028.1244740-1-cem@kernel.org>
 <20230925130028.1244740-4-cem@kernel.org>
 <LgGddofE85pV3URnGzKm8XtdfuZBrMd62BOp2v-7s91Lh1lHWNgTpOV7EdmW6lEhXaP4G_99jhpFiX60g3XRtw==@protonmail.internalid>
 <E5CA9BA7-513A-4D63-B183-B137B727D026@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5CA9BA7-513A-4D63-B183-B137B727D026@dilger.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:28:06PM -0600, Andreas Dilger wrote:
> I've added Dave to the CC list, since he has a deep understanding
> of the projid code since it originated from XFS.
> 
> On Sep 25, 2023, at 7:00 AM, cem@kernel.org wrote:
> > 
> > From: Carlos Maiolino <cem@kernel.org>
> > 
> > Not project quota support is in place, enable users to use it.
> 
> There is a peculiar behavior of project quotas, that rename across
> directories with different project IDs and PROJINHERIT set should
> cause the project ID to be updated (similar to BSD setgid).
> 
> For renaming regular files and other non-directories, it is OK to
> change the projid and update the quota for the old and new IDs
> to avoid copying all of the data needlessly.  For directories this
> (unfortunately) means that the kernel should return -EXDEV if the
> project IDs don't match, and then "mv" will create a new target
> directory and resume moving the files (which are thankfully still
> done with a rename() call if possible).

Right! I meant to include it on the TODO list of things, but I totally forgot to
do so, thanks for reminding me!

> 
> The reason for this is that just renaming the directory does not
> atomically update the projid on all of the (possibly millions of)
> sub-files/sub-dirs, which is required for PROJINHERIT directories.
> 
> 
> Another option for tmpfs to maintain this PROJINHERIT behavior would
> be to rename the directory and then spawn a background kernel thread
> to change the projids on the whole tree.  Since tmpfs is an in-memory
> filesystem there will be a "limited" number of files and subdirs
> to update, and you don't need to worry about error handling if the
> system crashes before the projid updates are done.
> 
> While not 100% atomic, it is not *less* atomic than having "mv"
> recursively copy the whole directory tree to the target name when
> the projid on the source and target don't match.  It is also a
> *lot* less overhead than doing a million mkdir() + rename() calls.
> 
> There would be a risk that the target directory projid could go over
> quota, but the alternative (that "mv" is half-way between moving the
> directory tree from the source to the destination before it fails,
> or fills up the filesystem because it can't hold another full copy
> of the tree being renamed) is not better.

I will look into these while I work on a non-rfc version of this series.
Thanks Andreas.

Carlos

> 
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> > mm/shmem.c | 35 +++++++++++++++++++++++++++++++----
> > 1 file changed, 31 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 4d2b713bff06..744a39251a31 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -3571,6 +3571,23 @@ static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> > 
> > 	fileattr_fill_flags(fa, info->fsflags & SHMEM_FL_USER_VISIBLE);
> > 
> > +	fa->fsx_projid = (u32)from_kprojid(&init_user_ns, info->i_projid);
> > +	return 0;
> > +}
> > +
> > +static int shmem_set_project(struct inode *inode, __u32 projid)
> > +{
> > +	int err = -EOPNOTSUPP;
> > +	kprojid_t kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
> > +
> > +	if (projid_eq(kprojid, SHMEM_I(inode)->i_projid))
> > +		return 0;
> > +
> > +	err = dquot_initialize(inode);
> > +	if (err)
> > +		return err;
> > +
> > +	SHMEM_I(inode)->i_projid = kprojid;
> > 	return 0;
> > }
> 
> (defect) this also needs to __dquot_transfer() the quota away from the
> previous projid, or the accounting will be broken.
> 
> 
> I think one hole in project quotas is the fact that any user can set
> the projid of their files to any project they want.  Changing the projid/PROJINHERIT is restricted outside of the init namespace by
> fileattr_set_prepare(), which is good in itself, but I think it makes
> sense for root/CAP_SYS_RESOURCE to be needed to change projid/PROJINHERIT
> even in the init namespace. Otherwise project quota is only an estimate
> of space usage in a directory, if users are not actively subverting it.
> 
> > @@ -3579,19 +3596,29 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
> > {
> > 	struct inode *inode = d_inode(dentry);
> > 	struct shmem_inode_info *info = SHMEM_I(inode);
> > +	int err = -EOPNOTSUPP;
> > +
> > +	if (fa->fsx_valid &&
> > +	   ((fa->fsx_xflags & ~FS_XFLAG_COMMON) ||
> > +	   fa->fsx_extsize != 0 || fa->fsx_cowextsize != 0))
> > +		goto out;
> > 
> > -	if (fileattr_has_fsx(fa))
> > -		return -EOPNOTSUPP;
> > 	if (fa->flags & ~SHMEM_FL_USER_MODIFIABLE)
> > -		return -EOPNOTSUPP;
> > +		goto out;
> > 
> > 	info->fsflags = (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
> > 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
> > 
> > 	shmem_set_inode_flags(inode, info->fsflags);
> > +	err = shmem_set_project(inode, fa->fsx_projid);
> > +		if (err)
> > +			goto out;
> > +
> > 	inode_set_ctime_current(inode);
> > 	inode_inc_iversion(inode);
> > -	return 0;
> > +
> > +out:
> > +	return err;
> > }
> 
> 
> 
> There were also some patches to add projid support to statx() that didn't
> quite get merged:
> 
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449184-7942-3-git-send-email-wshilong1991@gmail.com/
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449184-7942-2-git-send-email-wshilong1991@gmail.com/
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-6-git-send-email-wshilong1991@gmail.com/
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-7-git-send-email-wshilong1991@gmail.com/
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-8-git-send-email-wshilong1991@gmail.com/
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-9-git-send-email-wshilong1991@gmail.com/
> 
> They were part of a larger series to allow setting projid directly with
> the fchownat(2), but that got bogged down in how the interface should
> work, and whether i_projid should be moved to struct inode, but I think
> the statx() functionality was uncontroversial and could land as-is.
> 
> Cheers, Andreas
> 
> 
> 
> 


