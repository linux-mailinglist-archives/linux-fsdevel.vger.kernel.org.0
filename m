Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291336BF6FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 01:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCRAjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCRAjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:39:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC52136D1;
        Fri, 17 Mar 2023 17:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54E2EB82748;
        Sat, 18 Mar 2023 00:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA4DC433D2;
        Sat, 18 Mar 2023 00:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679099949;
        bh=3RaGi3gu+EUiIuxXokzaBDwA3iuBlxoWQJXU4R68shY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1IraCsd3vUb1IaxLDUYtj8EeMzEgY6RBGMzQWknFkM2z4rYlH6/iXjkoqo/CFp06
         nkCQTePXU627Dcaz3iSGomvDj7ukgVDlTy9e08SBrTqWs4Aztvle9py+7meegJ+vKn
         nAJkQvBEDmrH0cxUnpXqV4FIFk5UqDFx2M0FOcQTqr51qyZBpagGWnbZ8ykCXaBwCD
         Vti4U0cTDToOF2fvhXK4M+oH/KkR0Ej/tjhZ/3/9SQDEWOGf+42DwW9l/f2jO16moh
         sKLcXfuIdjcnPDCAkfIyS2CZVWklKasTktB8OvaI8X/THYFNDuw2+fKZcffJZkbWXt
         PBVdh9Yyjzksw==
Date:   Fri, 17 Mar 2023 17:39:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v1 3/4] xfs: add XFS_IOC_SETFSUUID ioctl
Message-ID: <20230318003909.GT11376@frogsfrogsfrogs>
References: <20230314042109.82161-1-catherine.hoang@oracle.com>
 <20230314042109.82161-4-catherine.hoang@oracle.com>
 <CAOQ4uxiYVpF9gjt-kTVpnoVYboOFG-Fpfw=KMrM=-aEHod4vXw@mail.gmail.com>
 <FC1BD250-7179-470B-854E-649E52147219@oracle.com>
 <CAOQ4uxg6hR8R9XC8qSkxQG8=tkwKZi=2Ofq_-LgZEwwPqbFQjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg6hR8R9XC8qSkxQG8=tkwKZi=2Ofq_-LgZEwwPqbFQjA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:09:56AM +0200, Amir Goldstein wrote:
> On Thu, Mar 16, 2023 at 1:13 AM Catherine Hoang
> <catherine.hoang@oracle.com> wrote:
> >
> > > On Mar 13, 2023, at 10:50 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Mar 14, 2023 at 6:27 AM Catherine Hoang
> > > <catherine.hoang@oracle.com> wrote:
> > >>
> > >> Add a new ioctl to set the uuid of a mounted filesystem.
> > >>
> > >> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> > >> ---
> > >> fs/xfs/libxfs/xfs_fs.h |   1 +
> > >> fs/xfs/xfs_ioctl.c     | 107 +++++++++++++++++++++++++++++++++++++++++
> > >> fs/xfs/xfs_log.c       |  19 ++++++++
> > >> fs/xfs/xfs_log.h       |   2 +
> > >> 4 files changed, 129 insertions(+)
> > >>
> > >> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> > >> index 1cfd5bc6520a..a350966cce99 100644
> > >> --- a/fs/xfs/libxfs/xfs_fs.h
> > >> +++ b/fs/xfs/libxfs/xfs_fs.h
> > >> @@ -831,6 +831,7 @@ struct xfs_scrub_metadata {
> > >> #define XFS_IOC_FSGEOMETRY          _IOR ('X', 126, struct xfs_fsop_geom)
> > >> #define XFS_IOC_BULKSTAT            _IOR ('X', 127, struct xfs_bulkstat_req)
> > >> #define XFS_IOC_INUMBERS            _IOR ('X', 128, struct xfs_inumbers_req)
> > >> +#define XFS_IOC_SETFSUUID           _IOR ('X', 129, uuid_t)
> > >
> > > Should be _IOW.
> >
> > Ok, will fix that.
> > >
> > > Would you consider defining that as FS_IOC_SETFSUUID in fs.h,
> > > so that other fs could implement it later on, instead of hoisting it later?
> > >
> > > It would be easy to add support for FS_IOC_SETFSUUID to ext4
> > > by generalizing ext4_ioctl_setuuid().
> > >
> > > Alternatively, we could hoist EXT4_IOC_SETFSUUID and struct fsuuid
> > > to fs.h and use that ioctl also for xfs.
> >
> > I actually did try to hoist the ext4 ioctls previously, but we weren’t able to come
> > to a consensus on the implementation.
> >
> > https://lore.kernel.org/linux-xfs/20221118211408.72796-2-catherine.hoang@oracle.com/
> >
> > I would prefer to keep this defined as an xfs specific ioctl to avoid all of the
> > fsdevel bikeshedding.
> 
> For the greater good, please do try to have this bikeshedding, before giving up.
> The discussion you pointed to wasn't so far from consensus IMO except
> fsdevel was not CCed.

Why?  fsdevel bikeshedding is a pointless waste of time.  Jeremy ran
four rounds of proposing the new api on linux-api, linux-fsdevel, and
linux-ext4.  Matthew Wilcox and I sent in our comments, including adding
some flexibility for shorter or longer uuids, so he updated the proposal
and it got merged:

https://lore.kernel.org/linux-api/?q=Bongio

The instant Catherine started talking about using this new API, Dave
came in and said no, flex arrays for uuids are stupid, and told
Catherine she ought to "fix" the landmines by changing the structure
definition:

https://lore.kernel.org/linux-xfs/20221121211437.GK3600936@dread.disaster.area/ 

Never mind that changing the struct size causes the output of _IOR to
change, which means a new ioctl command number, which is effectively a
new interface.  I think we'll just put new ioctls in xfs_fs_staging.h,
merge the code, let people kick the tires for a few months, and only
then make it permanent.

Though really, that's the least of the problems, especially since Dave
had a pretty good list of questions elsewhere in this thread.

--D

> > >
> > > Using an extensible struct with flags for that ioctl may turn out to be useful,
> > > for example, to verify that the new uuid is unique, despite the fact
> > > that xfs was
> > > mounted with -onouuid (useful IMO) or to explicitly request a restore of old
> > > uuid that would fail if new_uuid != meta uuid.
> >
> > I think using a struct is probably a good idea, I can add that in the next version.
> 
> Well, if you agree about a struct and agree about flags then the only thing
> left is Dave's concern about variable size arrays in ioctl and that could be
> addressed in a way that is compatible with ext4.
> 
> See untested patch below.
> 
> Thanks,
> Amir.
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..143a4735486e 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -215,6 +215,17 @@ struct fsxattr {
>  #define FS_IOC_FSSETXATTR              _IOW('X', 32, struct fsxattr)
>  #define FS_IOC_GETFSLABEL              _IOR(0x94, 49, char[FSLABEL_MAX])
>  #define FS_IOC_SETFSLABEL              _IOW(0x94, 50, char[FSLABEL_MAX])
> +#define FS_IOC_GETFSUUID               _IOR('v', 44, struct fsuuid)
> +#define FS_IOC_SETFSUUID               _IOW('v', 44, struct fsuuid)
> +
> +/*
> + * Structure for FS_IOC_GETFSUUID/FS_IOC_SETFSUUID
> + */
> +struct fsuuid {
> +       __u32   fsu_len; /* for backward compat has to be 16 */
> +       __u32   fsu_flags;
> +       __u8    fsu_uuid[16];

Um, these two ioctls have different namespace /and/ different structure
sizes.  This is literally defining a new interface.

> +};
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 140e1eb300d1..c4ded5d5e421 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -722,8 +722,8 @@ enum {
>  #define EXT4_IOC_GETSTATE              _IOW('f', 41, __u32)
>  #define EXT4_IOC_GET_ES_CACHE          _IOWR('f', 42, struct fiemap)
>  #define EXT4_IOC_CHECKPOINT            _IOW('f', 43, __u32)
> -#define EXT4_IOC_GETFSUUID             _IOR('f', 44, struct fsuuid)
> -#define EXT4_IOC_SETFSUUID             _IOW('f', 44, struct fsuuid)
> +#define EXT4_IOC_GETFSUUID             _IOR('f', 44, struct fsuuid_bdr)
> +#define EXT4_IOC_SETFSUUID             _IOW('f', 44, struct fsuuid_hdr)
> 
>  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
> 
> @@ -756,7 +756,7 @@ enum {
>  /*
>   * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
>   */
> -struct fsuuid {
> +struct fsuuid_hdr {
>         __u32       fsu_len;
>         __u32       fsu_flags;
>         __u8        fsu_uuid[];
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 8067ccda34e4..fc744231ad24 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1149,7 +1149,7 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
>         struct fsuuid fsuuid;
>         __u8 uuid[UUID_SIZE];
> 
> -       if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +       if (copy_from_user(&fsuuid, ufsuuid, offsetof(fsuuid, fsu_uuid)))
>                 return -EFAULT;
> 
>         if (fsuuid.fsu_len == 0) {
> @@ -1168,7 +1168,7 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
>         unlock_buffer(sbi->s_sbh);
> 
>         fsuuid.fsu_len = UUID_SIZE;
> -       if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid)) ||
> +       if (copy_to_user(ufsuuid, &fsuuid, offsetof(fsuuid, fsu_uuid)) ||
>             copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
>                 return -EFAULT;
>         return 0;
> @@ -1194,7 +1194,7 @@ static int ext4_ioctl_setuuid(struct file *filp,
>                 || ext4_has_feature_stable_inodes(sb))
>                 return -EOPNOTSUPP;
> 
> -       if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +       if (copy_from_user(&fsuuid, ufsuuid, offsetof(fsuuid, fsu_uuid)))
>                 return -EFAULT;
> 
>         if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)
> @@ -1596,8 +1596,10 @@ static long __ext4_ioctl(struct file *filp,
> unsigned int cmd, unsigned long arg)
>                 return ext4_ioctl_setlabel(filp,
>                                            (const void __user *)arg);
> 
> +       case FS_IOC_GETFSUUID:
>         case EXT4_IOC_GETFSUUID:
>                 return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
> +       case FS_IOC_SETFSUUID:
>         case EXT4_IOC_SETFSUUID:
>                 return ext4_ioctl_setuuid(filp, (const void __user *)arg);
>         default:
