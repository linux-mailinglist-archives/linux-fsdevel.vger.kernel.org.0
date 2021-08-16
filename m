Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBD3EDA3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhHPP4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbhHPPzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:55:42 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA11C0613C1;
        Mon, 16 Aug 2021 08:55:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q16so21266949ioj.0;
        Mon, 16 Aug 2021 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86gI+NzB0JG/o2aUB+CDJisuRMY5xM1cZ3FPhO47TU0=;
        b=O5DhwiMUBu03kZOF7kkSBcIDv71Jhbu3XXyUsSgKaMt2GSBgVPSRpsz/70rIPcrAwo
         P8L8s8s61JdX+ekFu7p97cacaaxWQ3rDKWHY1L7CNzP7bmHGZ+YN8f+XjpTogW5Y75H6
         7/t16hl14sU5JIzvID2CO83qmvk03gDZQj5kZxJatC8mVNyF/MJAOJ951Is7XSZQ5zvH
         oAKQnNk0EsIlepIqGau+IpAMazOztKGTyLqCaTdL4XgkAiYMfTBblpBSLuMmCepkI4V/
         DVKEoV7V/6s7ohKP3hAZB65GT9GFGbRN81i9dGvmbdJJRGZy6oT+Jv9IBPnZEOphHFOX
         w9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86gI+NzB0JG/o2aUB+CDJisuRMY5xM1cZ3FPhO47TU0=;
        b=tUlws4OSdCa1O+tNltUGpMi4WYKQWRl2cPrI9s4jcL4DlBkIAxdBPg26yA/d5ugKCU
         h0QhbYmCPzVrmeM5Fd5P+M2EJOF3pBhjJDatcUF/6aWQrFMGbyD6mC8MtsJUctKwN+gr
         tpoPvCHbLPBGzVNV+JqsiHBiPXjfK67175Svc9E3usiX+7uID/FBZ2Cq7vyTAAlqaDVB
         4yxb6j5ngwuYwQdHstQMhkUDoZHPoNCNnpi9Ia2WGAcYBkLglWj5HHHf+5keFAmjMbOF
         K1JSx2ys80zmErRhsPAdy9ITGTLQS+0LxR/LXY6mi+mmpXpwv6cw0vCaf7/BNmzJxPb7
         m2qg==
X-Gm-Message-State: AOAM530FneLICvOzg/RHXRivNIaQBVWxMUIQntKqJ+zjoE2XGlWo5gPW
        TD1hVx6dWWfuPI2taTO8USfBBF+3M3WusRCzKWo=
X-Google-Smtp-Source: ABdhPJwhj8Grj401A4cSvm22yDjESOUyXRlQJV1iy/3aDN/FzPqj770/5r6/lVlot2QXJMqF66WJ3Z7UMpM9JSM+hWs=
X-Received: by 2002:a6b:e712:: with SMTP id b18mr4015967ioh.186.1629129310147;
 Mon, 16 Aug 2021 08:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-13-krisman@collabora.com> <CAOQ4uxgwuJ4hv8Dp1v40K5qdnnwa7n9MYyvuh2tkb4gkpZv2Yw@mail.gmail.com>
 <20210816140657.GE30215@quack2.suse.cz>
In-Reply-To: <20210816140657.GE30215@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Aug 2021 18:54:58 +0300
Message-ID: <CAOQ4uxjQ6R0SvUjasyU3c_ZHTAC1J4=2eamgxJAOyq7C9HZFbQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/21] fanotify: Encode invalid file handle when no
 inode is provided
To:     Jan Kara <jack@suse.cz>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 5:07 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 13-08-21 11:27:48, Amir Goldstein wrote:
> > On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> > >
> > > Instead of failing, encode an invalid file handle in fanotify_encode_fh
> > > if no inode is provided.  This bogus file handle will be reported by
> > > FAN_FS_ERROR for non-inode errors.
> > >
> > > When being reported to userspace, the length information is actually
> > > reset and the handle cleaned up, such that userspace don't have the
> > > visibility of the internal kernel representation of this null handle.
> > >
> > > Also adjust the single caller that might rely on failure after passing
> > > an empty inode.
> > >
> > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > >
> > > ---
> > > Changes since v5:
> > >   - Preserve flags initialization (jan)
> > >   - Add BUILD_BUG_ON (amir)
> > >   - Require minimum of FANOTIFY_NULL_FH_LEN for fh_len(amir)
> > >   - Improve comment to explain the null FH length (jan)
> > >   - Simplify logic
> > > ---
> > >  fs/notify/fanotify/fanotify.c      | 27 ++++++++++++++++++-----
> > >  fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++++-------------
> > >  2 files changed, 41 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > > index 50fce4fec0d6..2b1ab031fbe5 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -334,6 +334,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> > >         return test_mask & user_mask;
> > >  }
> > >
> > > +#define FANOTIFY_NULL_FH_LEN   4
> > > +
> > >  /*
> > >   * Check size needed to encode fanotify_fh.
> > >   *
> > > @@ -345,7 +347,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
> > >         int dwords = 0;
> > >
> > >         if (!inode)
> > > -               return 0;
> > > +               return FANOTIFY_NULL_FH_LEN;
> > >
> > >         exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> > >
> > > @@ -367,11 +369,23 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> > >         void *buf = fh->buf;
> > >         int err;
> > >
> > > -       fh->type = FILEID_ROOT;
> > > -       fh->len = 0;
> > > +       BUILD_BUG_ON(FANOTIFY_NULL_FH_LEN < 4 ||
> > > +                    FANOTIFY_NULL_FH_LEN > FANOTIFY_INLINE_FH_LEN);
> > > +
> > >         fh->flags = 0;
> > > -       if (!inode)
> > > -               return 0;
> > > +
> > > +       if (!inode) {
> > > +               /*
> > > +                * Invalid FHs are used on FAN_FS_ERROR for errors not
> > > +                * linked to any inode. The f_handle won't be reported
> > > +                * back to userspace.  The extra bytes are cleared prior
> > > +                * to reporting.
> > > +                */
> > > +               type = FILEID_INVALID;
> > > +               fh_len = FANOTIFY_NULL_FH_LEN;
> >
> > Please memset() the NULL_FH buffer to zero.
> >
> > > +
> > > +               goto success;
> > > +       }
> > >
> > >         /*
> > >          * !gpf means preallocated variable size fh, but fh_len could
> > > @@ -400,6 +414,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> > >         if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> > >                 goto out_err;
> > >
> > > +success:
> > >         fh->type = type;
> > >         fh->len = fh_len;
> > >
> > > @@ -529,7 +544,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
> > >         struct fanotify_info *info;
> > >         struct fanotify_fh *dfh, *ffh;
> > >         unsigned int dir_fh_len = fanotify_encode_fh_len(id);
> > > -       unsigned int child_fh_len = fanotify_encode_fh_len(child);
> > > +       unsigned int child_fh_len = child ? fanotify_encode_fh_len(child) : 0;
> > >         unsigned int size;
> > >
> > >         size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index c47a5a45c0d3..4cacea5fcaca 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -360,7 +360,10 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> > >                 return -EFAULT;
> > >
> > >         handle.handle_type = fh->type;
> > > -       handle.handle_bytes = fh_len;
> > > +
> > > +       /* FILEID_INVALID handle type is reported without its f_handle. */
> > > +       if (fh->type != FILEID_INVALID)
> > > +               handle.handle_bytes = fh_len;
> >
> > I know I suggested those exact lines, but looking at the patch,
> > I think it would be better to do:
> > +       if (fh->type != FILEID_INVALID)
> > +               fh_len = 0;
> >          handle.handle_bytes = fh_len;
> >
> > >         if (copy_to_user(buf, &handle, sizeof(handle)))
> > >                 return -EFAULT;
> > >
> > > @@ -369,20 +372,22 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> > >         if (WARN_ON_ONCE(len < fh_len))
> > >                 return -EFAULT;
> > >
> > > -       /*
> > > -        * For an inline fh and inline file name, copy through stack to exclude
> > > -        * the copy from usercopy hardening protections.
> > > -        */
> > > -       fh_buf = fanotify_fh_buf(fh);
> > > -       if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
> > > -               memcpy(bounce, fh_buf, fh_len);
> > > -               fh_buf = bounce;
> > > +       if (fh->type != FILEID_INVALID) {
> >
> > ... and here: if (fh_len) {
> >
> > > +               /*
> > > +                * For an inline fh and inline file name, copy through
> > > +                * stack to exclude the copy from usercopy hardening
> > > +                * protections.
> > > +                */
> > > +               fh_buf = fanotify_fh_buf(fh);
> > > +               if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
> > > +                       memcpy(bounce, fh_buf, fh_len);
> > > +                       fh_buf = bounce;
> > > +               }
> > > +               if (copy_to_user(buf, fh_buf, fh_len))
> > > +                       return -EFAULT;
> > > +               buf += fh_len;
> > > +               len -= fh_len;
> > >         }
> > > -       if (copy_to_user(buf, fh_buf, fh_len))
> > > -               return -EFAULT;
> > > -
> > > -       buf += fh_len;
> > > -       len -= fh_len;
> > >
> > >         if (name_len) {
> > >                 /* Copy the filename with terminating null */
> > > @@ -398,7 +403,7 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> > >         }
> > >
> > >         /* Pad with 0's */
> > > -       WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
> > > +       WARN_ON_ONCE(len < 0);
> >
> > According to my calculations, FAN_FS_ERROR event with NULL_FH is expected
> > to get here with len == 4, so you can change this to:
> >          WARN_ON_ONCE(len < 0 || len > FANOTIFY_EVENT_ALIGN);
> >
> > But first, I would like to get Jan's feedback on this concept of keeping
> > unneeded 4 bytes zero padding in reported event in case of NULL_FH
> > in order to keep the FID reporting code simpler.
>
> Dunno, it still seems like quite some complications (simple ones but
> non-trivial amount of them) for what is rather a corner case. What if we
> *internally* propagated the information that there's no inode info with
> FILEID_ROOT fh? That means: No changes to fanotify_encode_fh_len(),
> fanotify_encode_fh(), or fanotify_alloc_name_event(). In
> copy_info_to_user() we just mangle FILEID_ROOT to FILEID_INVALID and that's
> all. No useless padding, no specialcasing of copying etc. Am I missing
> something?

I am perfectly fine with encoding "no inode" with FILEID_ROOT internally.
It's already the value used by fanotify_encode_fh() in upstream.

However, if we use zero len internally, we need to pass fh_type to
fanotify_fid_info_len() and special case FILEID_ROOT in order to
take FANOTIFY_FID_INFO_HDR_LEN into account.

And special case fanotify_event_object_fh_len() in
 fanotify_event_info_len() and in copy_info_records_to_user().

Or maybe I am missing something....

Thanks,
Amir.
