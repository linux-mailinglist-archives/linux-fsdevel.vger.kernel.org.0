Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E623D0A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhGUHZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhGUHW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:22:57 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B950DC061767;
        Wed, 21 Jul 2021 01:03:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r18so1399398iot.4;
        Wed, 21 Jul 2021 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrxBBFKexvLCUZqRl/iD+UCzvOC6PPrKeeHyF2BJXl4=;
        b=PDc77U4EeM283yn29ud5NVDuYyVKSCzb1OhvXRM98u8SM5I1v4zBsN/N5cuwpG2DVW
         nqRRUs9DpZqE3Q/8lKl8vetwUJgnG59/Cpr51B0pggwSZNo2bvtPQ+UWNEZmgkgXqiOb
         sP0h9nprvfrwboapPibQM4TdEp/YiWt4D+JSs+PMsiBtjydHpd2qh5V9KT81x9Agy4pM
         m7w80zakoaupzlcLlox/vaL+SGIBaAXehG8K9QSmYwvpnVAjgvzug+Txr82JIj29L7iL
         5f3cOYzvqVKLoycyuMcgpDS0KilHuTZWILMTNxlDU2mk2Nz8sLBHalRbJgUPYqhjoKd4
         O3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrxBBFKexvLCUZqRl/iD+UCzvOC6PPrKeeHyF2BJXl4=;
        b=jhOzt6Ru7fSIPkMGht6QvB5Il8di82Y7ObHMEQMWjRPP7/1ypfHXL7IpsKsMgi/XcA
         iJUm1WkoIEsv2TJiHRakxAWBZxuHL6czZceOtFhXKec2zGA1RRuY1lvtij9rFY9jBdpR
         RdSYttRknpm0kzYkUVvdDwqjzg2e30vJ3BAbSoHH8TGYp0UhLKB5JiNIM6p8Q7AkAsrT
         uqIjy4NjrQ0gNvbUwyt0QyEWAbrIAgMn2jH/XLOsBxfHVJK3818xLeybo0UTcC48Hum2
         yI6MNS0N5pYtXfjlzGwiBFS5eUK/qlQAeD61KIDKe0ZAeXTIUA2RUNtG16K9tIazSEr6
         0h5A==
X-Gm-Message-State: AOAM531AcYxqUR2pGfQUkjjOGG95oejpypuTtph2WmmlFHcuroK2Gk2N
        CAgnmkV/gaChIGaTQm2aWNi6u6Yq2hygeRpqALc=
X-Google-Smtp-Source: ABdhPJwRQ3jv/NtvHO2eYQ4O+3E6U931SKZdMTUFwgqS3L/3DjNtDd1orSc7nSz+vyeGmrdWOnyaue6LoPotcMZliGo=
X-Received: by 2002:a02:3505:: with SMTP id k5mr29904920jaa.123.1626854609135;
 Wed, 21 Jul 2021 01:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-1-krisman@collabora.com> <20210720155944.1447086-14-krisman@collabora.com>
In-Reply-To: <20210720155944.1447086-14-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jul 2021 11:03:17 +0300
Message-ID: <CAOQ4uxg=yhfshLsT+ChUeQ0fALrU8dWmq3BR7hqRfV_yhj_kiQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/16] fanotify: Introduce FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 7:00 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> The FAN_FS_ERROR event is a new inode event used by filesystem wide
> monitoring tools to receive notifications of type FS_ERROR_EVENT,
> emitted directly by filesystems when a problem is detected.  The error
> notification includes a generic error descriptor and a FID identifying
> the file affected.
>
> FID is sent for every FAN_FS_ERROR. Errors not linked to a regular inode
> are reported against the root inode.
>
> An error reporting structure is attached per-mark, and only a single
> error can be stored at a time.  This is ok, since once an error occurs,
> it is common for a stream of related errors to be reported.  We only log
> accumulate the total of errors occurred since the last notification.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v3:
>   - Convert WARN_ON to pr_warn (amir)
>   - Remove unecessary READ/WRITE_ONCE (amir)
>   - Alloc with GFP_KERNEL_ACCOUNT(amir)
>   - Simplify flags on mark allocation (amir)
>   - Avoid atomic set of error_count (amir)
>   - Simplify rules when merging error_event (amir)
>   - Allocate new error_event on get_one_event (amir)
>   - Report superblock error with invalid FH (amir,jan)
>
> Changes since v2:
>   - Support and equire FID mode (amir)
>   - Goto error path instead of early return (amir)
>   - Simplify get_one_event (me)
>   - Base merging on error_count
>   - drop fanotify_queue_error_event
>
> Changes since v1:
>   - Pass dentry to fanotify_check_fsid (Amir)
>   - FANOTIFY_EVENT_TYPE_ERROR -> FANOTIFY_EVENT_TYPE_FS_ERROR
>   - Merge previous patch into it
>   - Use a single slot
>   - Move fanotify_mark.error_event definition to this commit
>   - Rename FAN_ERROR -> FAN_FS_ERROR
>   - Restrict FAN_FS_ERROR to FAN_MARK_FILESYSTEM
> ---
>  fs/notify/fanotify/fanotify.c      | 137 ++++++++++++++++++----
>  fs/notify/fanotify/fanotify.h      |  53 +++++++++
>  fs/notify/fanotify/fanotify_user.c | 180 +++++++++++++++++++++++++++--
>  include/linux/fanotify.h           |   8 +-
>  include/uapi/linux/fanotify.h      |   8 ++
>  5 files changed, 353 insertions(+), 33 deletions(-)

General comment: this patch is pretty big and has been hard for me
to review in every revision of the patch set.
I think this revision is easier for review, but still there are some unrelated
cleanups that could be split out of this patch for next revisions.
I'll leave it to you to decide where the cost/effective line crosses
(i.e. not too much work for you - less work for me)

>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 912d120b9e48..477596b92bc5 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -335,24 +335,6 @@ static u32 fanotify_group_event_mask(
>         return test_mask & user_mask;
>  }
>
> -/*
> - * Check size needed to encode fanotify_fh.
> - *
> - * Return size of encoded fh without fanotify_fh header.
> - * Return 0 on failure to encode.
> - */
> -static int fanotify_encode_fh_len(struct inode *inode)
> -{
> -       int dwords = 0;
> -
> -       if (!inode)
> -               return 0;
> -
> -       exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> -
> -       return dwords << 2;
> -}
> -
>  /*
>   * Encode fanotify_fh.
>   *
> @@ -404,8 +386,12 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         fh->type = type;
>         fh->len = fh_len;
>
> -       /* Mix fh into event merge key */
> -       *hash ^= fanotify_hash_fh(fh);
> +       /*
> +        * Mix fh into event merge key.  Hash might be NULL in case of
> +        * unhashed FID events (i.e. FAN_FS_ERROR).
> +        */
> +       if (hash)
> +               *hash ^= fanotify_hash_fh(fh);
>
>         return FANOTIFY_FH_HDR_LEN + fh_len;
>
> @@ -420,6 +406,27 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>         return 0;
>  }
>
> +#define FANOTIFY_EMPTY_FH_LEN  8
> +/*
> + * Encode an empty fanotify_fh
> + *
> + * Empty FHs are used on FAN_FS_ERROR for errors not linked to any
> + * inode. fh needs to guarantee at least 8 bytes of inline space.
> + */
> +static int fanotify_encode_empty_fh(struct fanotify_fh *fh, int max_len)

IMO FANOTIFY_NULL_FH_LEN and fanotify_encode_null_fh()
are better choices, but I do not insist.

> +{
> +       if (max_len < FANOTIFY_EMPTY_FH_LEN || fh->flags)
> +               return -EINVAL;

First of all, this condition must never happen so if we want to
be defensive it should be WARN_ON_ONCE().
I don't think that max_len should even be an input to this helper.
All allocated fh buffers should be at least of size FANOTIFY_NULL_FH_LEN.

Second, even if we return with WARN_ON, we must initialize
fh->len = 0 like fanotify_encode_fh() does otherwise the code repoorting
this event will trip over undefined values.

FWIW, fanotify_encode_fh() is never really called in the code with NULL
inode value - the fh->type = FILEID_ROOT code is a left over from some
old code that is not used and no code is looking at fh->type values
expecting them to be FILEID_ROOT or FILEID_INVALID.
The event reporting code just looks at fh->len to determine if fid info record
should be reported.

So if you like, you can also call fanotify_encode_null_fh() from
fanotify_encode_fh() if inode is NULL.

> +
> +       fh->type = FILEID_INVALID;
> +       fh->len = FANOTIFY_EMPTY_FH_LEN;
> +       fh->flags = 0;
> +
> +       memset(fh->buf, 0, FANOTIFY_EMPTY_FH_LEN);
> +
> +       return 0;
> +}
> +
>  /*
>   * The inode to use as identifier when reporting fid depends on the event.
>   * Report the modified directory inode on dirent modification events.
> @@ -691,6 +698,63 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
>         return fsid;
>  }
>
> +static int fanotify_merge_error_event(struct fsnotify_group *group,
> +                                     struct fsnotify_event *event)
> +{
> +       struct fanotify_event *fae = FANOTIFY_E(event);
> +       struct fanotify_error_event *fee = FANOTIFY_EE(fae);
> +
> +       /*
> +        * When err_count > 0, the reporting slot is full.  Just account
> +        * the additional error and abort the insertion.
> +        */
> +       if (fee->err_count) {
> +               fee->err_count++;
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static void fanotify_insert_error_event(struct fsnotify_group *group,
> +                                       struct fsnotify_event *event,
> +                                       const void *data)
> +{
> +       struct fanotify_event *fae = FANOTIFY_E(event);
> +       const struct fsnotify_event_info *ei =
> +               (struct fsnotify_event_info *) data;
> +       const struct fs_error_report *report =
> +               (struct fs_error_report *) ei->data;
> +       struct inode *inode = report->inode;
> +       struct fanotify_error_event *fee;
> +       int fh_len;
> +
> +       /* This might be an unexpected type of event (i.e. overflow). */
> +       if (!fanotify_is_error_event(fae->mask))
> +               return;
> +
> +       fee = FANOTIFY_EE(fae);
> +       fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       fee->error = report->error;
> +       fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
> +       fee->err_count = 1;
> +
> +       /*
> +        * Error reporting needs to happen in atomic context.  If this
> +        * inode's file handler is more than we initially predicted,
> +        * there is nothing better we can do than report the error with
> +        * a bad FH.
> +        */
> +       fh_len = inode ? fanotify_encode_fh_len(inode) : FANOTIFY_EMPTY_FH_LEN;

if we decide to call fanotify_encode_null_fh() from fanotify_encode_fh(),
we should move this logic into fanotify_encode_fh_len() and convert the
only possible caller of fanotify_encode_fh_len(NULL) to:

        unsigned int child_fh_len = child ? fanotify_encode_fh_len(child) : 0;

There are arguments for making this change and against it, so I'd like
to hear where Jan stands on this matter.


> +       if (fh_len > fee->max_fh_len)
> +               return;

You need to report a NULL/EMPTY fh in this case as your comment above
states, so why return?
max_fh_len must not be allowed to be less than FANOTIFY_NULL_FH_LEN.

> +
> +       if (inode)
> +               fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
> +       else
> +               fanotify_encode_empty_fh(&fee->object_fh, fee->max_fh_len);
> +}
> +

So this could be non conditional call to fanotify_encode_fh().

FYI, this is where my attention span on this patch review ends
and I need to take a break.

I think you should be able to split a prep patch for null fh support and
then the FAN_FS_ERROR patch would just use fanotify_encode_fh()
blindly without caring if inode is NULL or not.

Thanks,
Amir.
