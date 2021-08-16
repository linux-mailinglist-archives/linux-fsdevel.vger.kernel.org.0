Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9BD3ED8AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhHPOHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 10:07:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhHPOHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:07:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 119AC21E27;
        Mon, 16 Aug 2021 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629122818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JsF6+BoXnC28sTlCstj2SdLrWErzfa+QHb46bNyZj90=;
        b=2ngC0JxdPYjxx593JaQJWL+ZYZhGqOLVR1vHMYPUzC6+anaUmn4RkzlGbBMiwv2GyfDZ29
        KTn6Tg+PujJx+twSlWAbpgDYi5e2xZOQUs9ewCJ/czhZK3G2MEwrjjGWZ0fXQ2HCMyaFl0
        pkHhLppdvbCFnzExxFGr96hK9mtKnU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629122818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JsF6+BoXnC28sTlCstj2SdLrWErzfa+QHb46bNyZj90=;
        b=DDSwtXS11Zx//sz+f+UdW/tmJsPTEACggufjERjoDMNCtk20ieUgxeAtYNbowt4/7dhQ89
        h5Lv0Qqz+2Na8LAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id EC618A3B85;
        Mon, 16 Aug 2021 14:06:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BE49E1E0426; Mon, 16 Aug 2021 16:06:57 +0200 (CEST)
Date:   Mon, 16 Aug 2021 16:06:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v6 12/21] fanotify: Encode invalid file handle when no
 inode is provided
Message-ID: <20210816140657.GE30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-13-krisman@collabora.com>
 <CAOQ4uxgwuJ4hv8Dp1v40K5qdnnwa7n9MYyvuh2tkb4gkpZv2Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgwuJ4hv8Dp1v40K5qdnnwa7n9MYyvuh2tkb4gkpZv2Yw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 13-08-21 11:27:48, Amir Goldstein wrote:
> On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Instead of failing, encode an invalid file handle in fanotify_encode_fh
> > if no inode is provided.  This bogus file handle will be reported by
> > FAN_FS_ERROR for non-inode errors.
> >
> > When being reported to userspace, the length information is actually
> > reset and the handle cleaned up, such that userspace don't have the
> > visibility of the internal kernel representation of this null handle.
> >
> > Also adjust the single caller that might rely on failure after passing
> > an empty inode.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
> > ---
> > Changes since v5:
> >   - Preserve flags initialization (jan)
> >   - Add BUILD_BUG_ON (amir)
> >   - Require minimum of FANOTIFY_NULL_FH_LEN for fh_len(amir)
> >   - Improve comment to explain the null FH length (jan)
> >   - Simplify logic
> > ---
> >  fs/notify/fanotify/fanotify.c      | 27 ++++++++++++++++++-----
> >  fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++++-------------
> >  2 files changed, 41 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 50fce4fec0d6..2b1ab031fbe5 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -334,6 +334,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >         return test_mask & user_mask;
> >  }
> >
> > +#define FANOTIFY_NULL_FH_LEN   4
> > +
> >  /*
> >   * Check size needed to encode fanotify_fh.
> >   *
> > @@ -345,7 +347,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
> >         int dwords = 0;
> >
> >         if (!inode)
> > -               return 0;
> > +               return FANOTIFY_NULL_FH_LEN;
> >
> >         exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> >
> > @@ -367,11 +369,23 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> >         void *buf = fh->buf;
> >         int err;
> >
> > -       fh->type = FILEID_ROOT;
> > -       fh->len = 0;
> > +       BUILD_BUG_ON(FANOTIFY_NULL_FH_LEN < 4 ||
> > +                    FANOTIFY_NULL_FH_LEN > FANOTIFY_INLINE_FH_LEN);
> > +
> >         fh->flags = 0;
> > -       if (!inode)
> > -               return 0;
> > +
> > +       if (!inode) {
> > +               /*
> > +                * Invalid FHs are used on FAN_FS_ERROR for errors not
> > +                * linked to any inode. The f_handle won't be reported
> > +                * back to userspace.  The extra bytes are cleared prior
> > +                * to reporting.
> > +                */
> > +               type = FILEID_INVALID;
> > +               fh_len = FANOTIFY_NULL_FH_LEN;
> 
> Please memset() the NULL_FH buffer to zero.
> 
> > +
> > +               goto success;
> > +       }
> >
> >         /*
> >          * !gpf means preallocated variable size fh, but fh_len could
> > @@ -400,6 +414,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> >         if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> >                 goto out_err;
> >
> > +success:
> >         fh->type = type;
> >         fh->len = fh_len;
> >
> > @@ -529,7 +544,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
> >         struct fanotify_info *info;
> >         struct fanotify_fh *dfh, *ffh;
> >         unsigned int dir_fh_len = fanotify_encode_fh_len(id);
> > -       unsigned int child_fh_len = fanotify_encode_fh_len(child);
> > +       unsigned int child_fh_len = child ? fanotify_encode_fh_len(child) : 0;
> >         unsigned int size;
> >
> >         size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index c47a5a45c0d3..4cacea5fcaca 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -360,7 +360,10 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >                 return -EFAULT;
> >
> >         handle.handle_type = fh->type;
> > -       handle.handle_bytes = fh_len;
> > +
> > +       /* FILEID_INVALID handle type is reported without its f_handle. */
> > +       if (fh->type != FILEID_INVALID)
> > +               handle.handle_bytes = fh_len;
> 
> I know I suggested those exact lines, but looking at the patch,
> I think it would be better to do:
> +       if (fh->type != FILEID_INVALID)
> +               fh_len = 0;
>          handle.handle_bytes = fh_len;
> 
> >         if (copy_to_user(buf, &handle, sizeof(handle)))
> >                 return -EFAULT;
> >
> > @@ -369,20 +372,22 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >         if (WARN_ON_ONCE(len < fh_len))
> >                 return -EFAULT;
> >
> > -       /*
> > -        * For an inline fh and inline file name, copy through stack to exclude
> > -        * the copy from usercopy hardening protections.
> > -        */
> > -       fh_buf = fanotify_fh_buf(fh);
> > -       if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
> > -               memcpy(bounce, fh_buf, fh_len);
> > -               fh_buf = bounce;
> > +       if (fh->type != FILEID_INVALID) {
> 
> ... and here: if (fh_len) {
> 
> > +               /*
> > +                * For an inline fh and inline file name, copy through
> > +                * stack to exclude the copy from usercopy hardening
> > +                * protections.
> > +                */
> > +               fh_buf = fanotify_fh_buf(fh);
> > +               if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
> > +                       memcpy(bounce, fh_buf, fh_len);
> > +                       fh_buf = bounce;
> > +               }
> > +               if (copy_to_user(buf, fh_buf, fh_len))
> > +                       return -EFAULT;
> > +               buf += fh_len;
> > +               len -= fh_len;
> >         }
> > -       if (copy_to_user(buf, fh_buf, fh_len))
> > -               return -EFAULT;
> > -
> > -       buf += fh_len;
> > -       len -= fh_len;
> >
> >         if (name_len) {
> >                 /* Copy the filename with terminating null */
> > @@ -398,7 +403,7 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >         }
> >
> >         /* Pad with 0's */
> > -       WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
> > +       WARN_ON_ONCE(len < 0);
> 
> According to my calculations, FAN_FS_ERROR event with NULL_FH is expected
> to get here with len == 4, so you can change this to:
>          WARN_ON_ONCE(len < 0 || len > FANOTIFY_EVENT_ALIGN);
> 
> But first, I would like to get Jan's feedback on this concept of keeping
> unneeded 4 bytes zero padding in reported event in case of NULL_FH
> in order to keep the FID reporting code simpler.

Dunno, it still seems like quite some complications (simple ones but
non-trivial amount of them) for what is rather a corner case. What if we
*internally* propagated the information that there's no inode info with
FILEID_ROOT fh? That means: No changes to fanotify_encode_fh_len(),
fanotify_encode_fh(), or fanotify_alloc_name_event(). In
copy_info_to_user() we just mangle FILEID_ROOT to FILEID_INVALID and that's
all. No useless padding, no specialcasing of copying etc. Am I missing
something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
