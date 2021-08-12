Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100173EA7FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhHLPv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbhHLPvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:51:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1790FC061756;
        Thu, 12 Aug 2021 08:50:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id x10so9014285iop.13;
        Thu, 12 Aug 2021 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52YB11PbYT2XA7ZGSfNYASI7QWQYhJ2oqmyQJ6UPaGI=;
        b=acV8F4nvjDnsC8bUwxCrVhhEFhDrUrr2UgW57D+BRtnlN6duv2qNDnK2Wg4n9AKTYI
         BwmD+jTG7xoYZ9Hj1cras4NXgpGTatOWDzhNLzIwCj7D+GkNK+aAXQ6LFoiAhQcQn2sr
         VAqa/HtRPz6NSGPfTZXLVFWl+eryrvFW7MJ2LnyqsofOYN7uM6tPtj2NrRVcHWF+q5sb
         iVMuRpXDIan/4ftjovlpI2pJPFzInp6R7jw1GuqHkVHqDckKER8WWof/k1qKMs5sCfEC
         43/6/LXaJ2xkdzSKJaHxGT0molQp3tw/R2IctVKaXYuND2qd4Di85mVBls3UKJl3+fBZ
         GzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52YB11PbYT2XA7ZGSfNYASI7QWQYhJ2oqmyQJ6UPaGI=;
        b=YOYTz1DDZiiR5yXi0Fd5ocMjB8e2rcPkHPZOKcWyk8ctzQHILGeZURyLs7NtJvrGS3
         DJE3ORns51eQSJ0U3HWoRDOuNEGRpHPfQoE+G6gnqCXhIuFJVzvHTXj9Sq+11E74ADlb
         N+Wq7wJxXzAQ9DpbgZ4BEGEphzynmcVG4S4lVXEuPyO2cRJxXXD/2t5sRWIBP2q62qHY
         Qaz47TTX3+uiQkjhhRYHwwPgGXfs0JPmMFusvWBCKu+Yn1kum/nvddfppmtlcF6mkAG8
         qM9A1NsQ6f2UnawXjaqbK7VsRgKGC3mF9QiOVFzpNeTGxEcAxbbTDlOAZbBXmBWM+RE4
         /7Cw==
X-Gm-Message-State: AOAM533AeozB3mIvZ+DUt7+qLZCi4HKepDE+DQyCVvkpe2jayRgRRYHK
        tBiWKNu/8AeLTBXIs5MDahwjltLNyAhK0dwTDzM=
X-Google-Smtp-Source: ABdhPJz8VyxH2BDxkmkCxOiVdMqBv89kfQC3ux1OVoTulzLkpgrdP97H5C9XiuvZ1ym9f/EwGAK1/jt71pMAik46c3M=
X-Received: by 2002:a05:6602:1848:: with SMTP id d8mr3500267ioi.72.1628783452469;
 Thu, 12 Aug 2021 08:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-15-krisman@collabora.com> <20210805095618.GF14483@quack2.suse.cz>
 <87fsvf65zu.fsf@collabora.com> <20210812142047.GG14675@quack2.suse.cz> <875ywa66ga.fsf@collabora.com>
In-Reply-To: <875ywa66ga.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Aug 2021 18:50:41 +0300
Message-ID: <CAOQ4uxiZAM2ma_iSiCvdcr_kBasuJocbEGAwPtVZAkU4WwugcQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/23] fanotify: Encode invalid file handler when no
 inode is provided
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 6:14 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Jan Kara <jack@suse.cz> writes:
>
> > On Wed 11-08-21 17:12:05, Gabriel Krisman Bertazi wrote:
> >> Jan Kara <jack@suse.cz> writes:
> >> >> @@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> >> >>           fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
> >> >>   }
> >> >>
> >> >> - dwords = fh_len >> 2;
> >> >> - type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> >> >> - err = -EINVAL;
> >> >> - if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> >> >> -         goto out_err;
> >> >> -
> >> >> - fh->type = type;
> >> >> - fh->len = fh_len;
> >> >> + if (inode) {
> >> >> +         dwords = fh_len >> 2;
> >> >> +         type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> >> >> +         err = -EINVAL;
> >> >> +         if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> >> >> +                 goto out_err;
> >> >> +         fh->type = type;
> >> >> +         fh->len = fh_len;
> >> >> + } else {
> >> >> +         /*
> >> >> +          * Invalid FHs are used on FAN_FS_ERROR for errors not
> >> >> +          * linked to any inode. Caller needs to guarantee the fh
> >> >> +          * has at least FANOTIFY_NULL_FH_LEN bytes of space.
> >> >> +          */
> >> >> +         fh->type = FILEID_INVALID;
> >> >> +         fh->len = FANOTIFY_NULL_FH_LEN;
> >> >> +         memset(buf, 0, FANOTIFY_NULL_FH_LEN);
> >> >> + }
> >> >
> >> > Maybe it will become clearer later during the series but why do you set
> >> > fh->len to FANOTIFY_NULL_FH_LEN and not 0?
> >>
> >> Jan,
> >>
> >> That is how we encode a NULL file handle (i.e. superblock error).  Amir
> >> suggested it would be an invalid FILEID_INVALID, with a zeroed handle of
> >> size 8.  I will improve the comment on the next iteration.
> >
> > Thanks for info. Then I have a question for Amir I guess :) Amir, what's
> > the advantage of zeroed handle of size 8 instead of just 0 length file
> > handle?
>
> Jan,
>
> Looking back at the email from Amir, I realize I misunderstood his
> original suggestion.  Amir suggested it be FILEID_INVALID with 0-len OR
> FILEID_INO32_GEN with zeroed fields.  I mixed the two suggestions.
>

That was from a discussion about UAPI and agree it doesn't make much sense
to report non-zero handle_bytes and invalid handle_type.

But specifically, Jan's question above was directly referring to the internal
representation of the event.

Since you are going to allocate a file handle buffer of size MAX_HANDLE_SZ
(right?), then there is no caveat in declaring the NULL_FH with positive size
internally, which I think, simplifies the implementation.
NULL_FH internal length could be 4 instead of 8 though.

You will not have to special case fanotify_fid_info_len() and the info record
hdr.len will include a 4 bytes zero padding after the fid info record
with NULL_FH.

You will only special case this line in copy_fid_info_to_user():
    handle.handle_type = fh->type;
    if (fh->type != FILEID_INVALID)
        handle.handle_bytes = fh_len;

Thanks,
Amir.
