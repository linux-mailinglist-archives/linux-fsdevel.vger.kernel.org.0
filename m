Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F63F3EB29E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhHMI21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbhHMI20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:28:26 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB6EC061756;
        Fri, 13 Aug 2021 01:28:00 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i13so9984996ilm.11;
        Fri, 13 Aug 2021 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upxC7Qzfhn2zAyZxpc09Uenp14AJxdDPsx4s0+jAT/I=;
        b=skYYp0ihkbZQ/BbFCDl6U6VCaJU+sLoB0FYLXqNH/dzIfPl3h1pKhxv/2PcKvNEZ/5
         WPRyo/MFIA4d9LqFciZKdXrc5noKr1eMikxlQh/FZsg0ZcZNoeRjyYTNlJc1DcTMfBg9
         G47Dod7itcKQzUzC4J1NkPFo9aXjSJT1hbmkdyhUvqheB9A31P0Y0IDquE334vtlTat9
         MCva8N4Dwfw1mDFcyDSQGAdreJGkhNXQCcfGLnB7fvjYbx7kuYrF8AB/n3PSNULalby2
         ie8Mj3cs3KeinTZHjoBc66XGmesxwjrE+ai13z4wB1TPpNKlHAVM7F5rzxS45isjdZ2f
         0UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upxC7Qzfhn2zAyZxpc09Uenp14AJxdDPsx4s0+jAT/I=;
        b=j/6DqXJ5ABbzYyMpGnT3N/ItD11B1wXZa9MtdxQ4BcoBHl0ugeglLAV5UeFOfl3tor
         Q7jwqg6paHaSx1DbyVBYw82062ruiptagpXtngWETj8HDvDqrcBqhjFF1fTeISHa3qgT
         B2o07EOvqVRACD9X/g2YSv8gMRSup9hH2aV2RXzN3lpb5f22yPT5odSd2Hx8GjGpjd0M
         yAigI0iybImzdVBfjVHslPNa5I6TBlLxUg2Z3GdfLYf9Rr20TQg3LhAcwq/zYMzHfaeE
         ybSySAkdzql4X68YuPzLs4laVuOscYBfK++qZnq+aYNkHNen8HnL3MKmNmn0BTZ/VpdP
         Ycyg==
X-Gm-Message-State: AOAM530xMppFKTJ0iswlRVrDkg0vzJdnRr1Z5RZ7C0J6zmxKAO3sWART
        Po7wfygg5pYwkRD0myyuIV3d8m1ftSP3o7pBNaM=
X-Google-Smtp-Source: ABdhPJz+d/4H3QqKr2YpmgK2r3rp7gcTaceKl4J2dB7XvPXPf2TW72TKqk9CZ40tlJF1c0g9LYqV07ehT3ZZ0cAGwWE=
X-Received: by 2002:a05:6e02:1bcc:: with SMTP id x12mr1016584ilv.275.1628843279398;
 Fri, 13 Aug 2021 01:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-13-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-13-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 11:27:48 +0300
Message-ID: <CAOQ4uxgwuJ4hv8Dp1v40K5qdnnwa7n9MYyvuh2tkb4gkpZv2Yw@mail.gmail.com>
Subject: Re: [PATCH v6 12/21] fanotify: Encode invalid file handle when no
 inode is provided
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
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

On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Instead of failing, encode an invalid file handle in fanotify_encode_fh
> if no inode is provided.  This bogus file handle will be reported by
> FAN_FS_ERROR for non-inode errors.
>
> When being reported to userspace, the length information is actually
> reset and the handle cleaned up, such that userspace don't have the
> visibility of the internal kernel representation of this null handle.
>
> Also adjust the single caller that might rely on failure after passing
> an empty inode.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v5:
>   - Preserve flags initialization (jan)
>   - Add BUILD_BUG_ON (amir)
>   - Require minimum of FANOTIFY_NULL_FH_LEN for fh_len(amir)
>   - Improve comment to explain the null FH length (jan)
>   - Simplify logic
> ---
>  fs/notify/fanotify/fanotify.c      | 27 ++++++++++++++++++-----
>  fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++++-------------
>  2 files changed, 41 insertions(+), 21 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 50fce4fec0d6..2b1ab031fbe5 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -334,6 +334,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>         return test_mask & user_mask;
>  }
>
> +#define FANOTIFY_NULL_FH_LEN   4
> +
>  /*
>   * Check size needed to encode fanotify_fh.
>   *
> @@ -345,7 +347,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
>         int dwords = 0;
>
>         if (!inode)
> -               return 0;
> +               return FANOTIFY_NULL_FH_LEN;
>
>         exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
>
> @@ -367,11 +369,23 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         void *buf = fh->buf;
>         int err;
>
> -       fh->type = FILEID_ROOT;
> -       fh->len = 0;
> +       BUILD_BUG_ON(FANOTIFY_NULL_FH_LEN < 4 ||
> +                    FANOTIFY_NULL_FH_LEN > FANOTIFY_INLINE_FH_LEN);
> +
>         fh->flags = 0;
> -       if (!inode)
> -               return 0;
> +
> +       if (!inode) {
> +               /*
> +                * Invalid FHs are used on FAN_FS_ERROR for errors not
> +                * linked to any inode. The f_handle won't be reported
> +                * back to userspace.  The extra bytes are cleared prior
> +                * to reporting.
> +                */
> +               type = FILEID_INVALID;
> +               fh_len = FANOTIFY_NULL_FH_LEN;

Please memset() the NULL_FH buffer to zero.

> +
> +               goto success;
> +       }
>
>         /*
>          * !gpf means preallocated variable size fh, but fh_len could
> @@ -400,6 +414,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
>                 goto out_err;
>
> +success:
>         fh->type = type;
>         fh->len = fh_len;
>
> @@ -529,7 +544,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>         struct fanotify_info *info;
>         struct fanotify_fh *dfh, *ffh;
>         unsigned int dir_fh_len = fanotify_encode_fh_len(id);
> -       unsigned int child_fh_len = fanotify_encode_fh_len(child);
> +       unsigned int child_fh_len = child ? fanotify_encode_fh_len(child) : 0;
>         unsigned int size;
>
>         size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index c47a5a45c0d3..4cacea5fcaca 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -360,7 +360,10 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>                 return -EFAULT;
>
>         handle.handle_type = fh->type;
> -       handle.handle_bytes = fh_len;
> +
> +       /* FILEID_INVALID handle type is reported without its f_handle. */
> +       if (fh->type != FILEID_INVALID)
> +               handle.handle_bytes = fh_len;

I know I suggested those exact lines, but looking at the patch,
I think it would be better to do:
+       if (fh->type != FILEID_INVALID)
+               fh_len = 0;
         handle.handle_bytes = fh_len;

>         if (copy_to_user(buf, &handle, sizeof(handle)))
>                 return -EFAULT;
>
> @@ -369,20 +372,22 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>         if (WARN_ON_ONCE(len < fh_len))
>                 return -EFAULT;
>
> -       /*
> -        * For an inline fh and inline file name, copy through stack to exclude
> -        * the copy from usercopy hardening protections.
> -        */
> -       fh_buf = fanotify_fh_buf(fh);
> -       if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
> -               memcpy(bounce, fh_buf, fh_len);
> -               fh_buf = bounce;
> +       if (fh->type != FILEID_INVALID) {

... and here: if (fh_len) {

> +               /*
> +                * For an inline fh and inline file name, copy through
> +                * stack to exclude the copy from usercopy hardening
> +                * protections.
> +                */
> +               fh_buf = fanotify_fh_buf(fh);
> +               if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
> +                       memcpy(bounce, fh_buf, fh_len);
> +                       fh_buf = bounce;
> +               }
> +               if (copy_to_user(buf, fh_buf, fh_len))
> +                       return -EFAULT;
> +               buf += fh_len;
> +               len -= fh_len;
>         }
> -       if (copy_to_user(buf, fh_buf, fh_len))
> -               return -EFAULT;
> -
> -       buf += fh_len;
> -       len -= fh_len;
>
>         if (name_len) {
>                 /* Copy the filename with terminating null */
> @@ -398,7 +403,7 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>         }
>
>         /* Pad with 0's */
> -       WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
> +       WARN_ON_ONCE(len < 0);

According to my calculations, FAN_FS_ERROR event with NULL_FH is expected
to get here with len == 4, so you can change this to:
         WARN_ON_ONCE(len < 0 || len > FANOTIFY_EVENT_ALIGN);

But first, I would like to get Jan's feedback on this concept of keeping
unneeded 4 bytes zero padding in reported event in case of NULL_FH
in order to keep the FID reporting code simpler.

Thanks,
Amir.
