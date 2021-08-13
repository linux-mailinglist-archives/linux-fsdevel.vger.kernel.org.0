Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A033EBB6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhHMR0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhHMR0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:26:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE11C061756;
        Fri, 13 Aug 2021 10:25:46 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j18so11565827ile.8;
        Fri, 13 Aug 2021 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+S4KVBw8yJJB/lH4WqdNiyvGW22o5SNQiP41sgzMDNQ=;
        b=qCL/GtZbI6TEy2j8PXsp4xYga40DBF2y5vJrPqkm7lDJRM7Bvat6M5IrGE+Utie2Ak
         qT9/G+b762+CSLWqSddSRQVJIfZHO/mZcHIuQvLV9yxYh+NRO50kyh7DqlByW0f88MKt
         Cv8i4i33w/eEVWNDl1QDeaKdiMd2T2KxxDiM72vrGwx+kWRQN4J97Zx+S43vTZYsJu26
         NYkwLLsigMfr1D+qau34a66fe+1VibqZ55+XcdaAz11hzsf5juWU5cqmZt8v5+2MTPFb
         RxTNWGlDftqImdhHLtuSvH8L0+mvco7qPQ3XJnraSfQIZRVYLmI1CtjdKeEvpFvo2lMD
         yL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+S4KVBw8yJJB/lH4WqdNiyvGW22o5SNQiP41sgzMDNQ=;
        b=blYggq4kD5jX/i6icHVusWG/vBbJWGktm30XaEOawsC3sJkXERJizfEy4n75fCDSzy
         MjP3FZbBwCVuCgHw1+vrpzhQ3RX5MSsFZKwNuwzerksO6BrX9Xb0vWa64Y50c54rN/+F
         kTGUZr+FC1PSQ0Zn5s+EsIbrlvlt3GAYZzz+lzlIDr1IhZmohCtwfNLQ/u94pwxDiSIm
         DdYe3VtrNEHm+x7AWwDMAiDOWbP6MgFobHdnL2XBHdB72Q60c0mOBd+TYgrRlaF9bFxT
         YGOHaDIB1+SG0BpNrI8FmQ6AHCbvQDPyLzYRNwCKZO4OXRXzHwE4ysGCgA0WZmVsDZND
         ixJw==
X-Gm-Message-State: AOAM533A5mwqwZiIncax7QMlPMkoxQbiPgE6P1ww9ENdaaykDkT++UjA
        JgQs9RaeIi0K+wmp09+OIG5HwBnD3AueAzX1Ies=
X-Google-Smtp-Source: ABdhPJz5mNdrteFnDuv6JqWGHzA1iVZT98tciPujIaiqBIoNiO83BVZdgRaJR3Z/lQ6gvp0Q8n1Va5/WZ6JI0ZPxlms=
X-Received: by 2002:a92:cd0a:: with SMTP id z10mr2392060iln.137.1628875545704;
 Fri, 13 Aug 2021 10:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-15-krisman@collabora.com> <20210805095618.GF14483@quack2.suse.cz>
 <87fsvf65zu.fsf@collabora.com> <20210812142047.GG14675@quack2.suse.cz>
 <CAOQ4uxjy2FOt6r5=x9FO3YXs8_FWwew055ZfrumDjSz0HCgz3w@mail.gmail.com> <20210813120954.GA11955@quack2.suse.cz>
In-Reply-To: <20210813120954.GA11955@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 20:25:34 +0300
Message-ID: <CAOQ4uxgffafdqTYYjy4tsXFMQxN5zeKfXcC3G93SGaEOnqpZMQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/23] fanotify: Encode invalid file handler when no
 inode is provided
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
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

On Fri, Aug 13, 2021 at 3:09 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 12-08-21 18:17:10, Amir Goldstein wrote:
> > On Thu, Aug 12, 2021 at 5:20 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 11-08-21 17:12:05, Gabriel Krisman Bertazi wrote:
> > > > Jan Kara <jack@suse.cz> writes:
> > > > >> @@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> > > > >>            fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
> > > > >>    }
> > > > >>
> > > > >> -  dwords = fh_len >> 2;
> > > > >> -  type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> > > > >> -  err = -EINVAL;
> > > > >> -  if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> > > > >> -          goto out_err;
> > > > >> -
> > > > >> -  fh->type = type;
> > > > >> -  fh->len = fh_len;
> > > > >> +  if (inode) {
> > > > >> +          dwords = fh_len >> 2;
> > > > >> +          type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> > > > >> +          err = -EINVAL;
> > > > >> +          if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> > > > >> +                  goto out_err;
> > > > >> +          fh->type = type;
> > > > >> +          fh->len = fh_len;
> > > > >> +  } else {
> > > > >> +          /*
> > > > >> +           * Invalid FHs are used on FAN_FS_ERROR for errors not
> > > > >> +           * linked to any inode. Caller needs to guarantee the fh
> > > > >> +           * has at least FANOTIFY_NULL_FH_LEN bytes of space.
> > > > >> +           */
> > > > >> +          fh->type = FILEID_INVALID;
> > > > >> +          fh->len = FANOTIFY_NULL_FH_LEN;
> > > > >> +          memset(buf, 0, FANOTIFY_NULL_FH_LEN);
> > > > >> +  }
> > > > >
> > > > > Maybe it will become clearer later during the series but why do you set
> > > > > fh->len to FANOTIFY_NULL_FH_LEN and not 0?
> > > >
> > > > Jan,
> > > >
> > > > That is how we encode a NULL file handle (i.e. superblock error).  Amir
> > > > suggested it would be an invalid FILEID_INVALID, with a zeroed handle of
> > > > size 8.  I will improve the comment on the next iteration.
> > >
> > > Thanks for info. Then I have a question for Amir I guess :) Amir, what's
> > > the advantage of zeroed handle of size 8 instead of just 0 length file
> > > handle?
> >
> > With current code, zero fh->len means we are not reporting an FID info
> > record (e.g. due to encode error), see copy_info_records_to_user().
> >
> > This is because fh->len plays a dual role for indicating the length of the
> > file handle and the existence of FID info.
>
> I see, thanks for info.
>
> > I figured that keeping a positive length for the special NULL_FH is an
> > easy way to workaround this ambiguity and keep the code simpler.
> > We don't really need to pay any cost for keeping the 8 bytes zero buffer.
>
> There are two separate questions:
> 1) How do we internally propagate the information that we don't have
> file_handle to report but we do want fsid reported.
> 2) What do we report to userspace in file_handle.
>
> For 2) I think we should report fsid + FILEID_INVALID, 0-length filehandle.
> Currently the non-zero lenght FILEID_INVALID filehandle was propagating to
> userspace and IMO that's confusing.

Agree. That was implemented in v6.

> For 1), whatever is the simplest to
> propagate the information "we want only fsid reported" internally is fine
> by me.
>

Ok. I think it would be fair (based on v6 patches) to call the fh->len = 4
option "simple".

But following my "simple" suggestion as is, v6 has a side effect of
adding 4 bytes of zero padding after the event fid info record.

Can you please confirm that this side effect is fine by you as well.
It wouldn't be too hard to special case FILEID_INVALID and also
truncate those 4 bytes of zero padding, but I really don't think it is
worth the effort.

Thanks,
Amir.
