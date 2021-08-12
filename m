Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377B43EA758
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhHLPRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 11:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbhHLPRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:17:47 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF3C061756;
        Thu, 12 Aug 2021 08:17:21 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d22so8845109ioy.11;
        Thu, 12 Aug 2021 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKF7LrLlAMLrMH2jjtDnlDfaAEBjd6hDHDkqDzyH70U=;
        b=VfbKknBhm2fGwdJTot0711RnnL7y6Qhgs9e2zfiOwrkNpi0rea3ye3tAgh3L7WpQjm
         xbPwQmZja5ypeB5Z87gMwRpTT/4H9pBP6hRkjglD70bJqwPynQYtPjov63i4O74+jTxy
         l9Etp06qnsoWBueKRO4Yp6hF/0Dug9vfoonHl67VCf+lQc+P7gwCmU3sKeQd4GmY5lGj
         NimPHZSFkF5V8Gv2X4q/aHAvZ1sclp7UV86RaxMOMhfGX3uvcLWag5WQBrQhT13mqxkc
         xqwqVAWYLARBLtH75y4PLlK+OgnZyYnTHFEvjE+Bd9axwrgOUlbfGfahiBrrmbNJUj7x
         UHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKF7LrLlAMLrMH2jjtDnlDfaAEBjd6hDHDkqDzyH70U=;
        b=Zc8u2+KBe0D4rR8aUK5zVSiUepSNDeKBws0rYT2ifp0WULvmtyilTaOigcjw/DHb9b
         69iwTCuI/4/lxUq2GhvyhMbnZ5fASjRVcb2M/fHVQcvabIJnCKTGyI+/7R3A1/yhqOmM
         r0io4wcDgzkcVYcCEOuJYlmKXH1A3fJQjOumz69VS+4MIZbvKUZ1vlpiTzaJEHgHV0MZ
         KPm9W40XlCCFwCA6T3mZpavbb/b92x8tHGVPLnOqemy8Ly3khAHHET3od4KHNkt0e8JN
         wlclasQN2yLKhZn0oeW6QXgzK/ao9+1pE5tuyraLIqSrrIRQoGOnj9vx+0DoNX0gl+6z
         Moaw==
X-Gm-Message-State: AOAM5334PH4cadPO9DMfMqP9kP+Gxh5K9kvOtLGHVbMQkJuqcgqw/qw9
        wbpohHFJdSBSnu1RgCiEONj7bzzOxDQwjlL/JOM=
X-Google-Smtp-Source: ABdhPJw+JMdbedFr5jKVfRwQWQa5uSVt3hUyO+7+Bpv9tLQuffuWwfvREG0GcQZMPPxQZvb9p/ft4/pRqijFisF7tJE=
X-Received: by 2002:a02:a390:: with SMTP id y16mr4378166jak.120.1628781441440;
 Thu, 12 Aug 2021 08:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-15-krisman@collabora.com> <20210805095618.GF14483@quack2.suse.cz>
 <87fsvf65zu.fsf@collabora.com> <20210812142047.GG14675@quack2.suse.cz>
In-Reply-To: <20210812142047.GG14675@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Aug 2021 18:17:10 +0300
Message-ID: <CAOQ4uxjy2FOt6r5=x9FO3YXs8_FWwew055ZfrumDjSz0HCgz3w@mail.gmail.com>
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

On Thu, Aug 12, 2021 at 5:20 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 11-08-21 17:12:05, Gabriel Krisman Bertazi wrote:
> > Jan Kara <jack@suse.cz> writes:
> > >> @@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> > >>            fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
> > >>    }
> > >>
> > >> -  dwords = fh_len >> 2;
> > >> -  type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> > >> -  err = -EINVAL;
> > >> -  if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> > >> -          goto out_err;
> > >> -
> > >> -  fh->type = type;
> > >> -  fh->len = fh_len;
> > >> +  if (inode) {
> > >> +          dwords = fh_len >> 2;
> > >> +          type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> > >> +          err = -EINVAL;
> > >> +          if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> > >> +                  goto out_err;
> > >> +          fh->type = type;
> > >> +          fh->len = fh_len;
> > >> +  } else {
> > >> +          /*
> > >> +           * Invalid FHs are used on FAN_FS_ERROR for errors not
> > >> +           * linked to any inode. Caller needs to guarantee the fh
> > >> +           * has at least FANOTIFY_NULL_FH_LEN bytes of space.
> > >> +           */
> > >> +          fh->type = FILEID_INVALID;
> > >> +          fh->len = FANOTIFY_NULL_FH_LEN;
> > >> +          memset(buf, 0, FANOTIFY_NULL_FH_LEN);
> > >> +  }
> > >
> > > Maybe it will become clearer later during the series but why do you set
> > > fh->len to FANOTIFY_NULL_FH_LEN and not 0?
> >
> > Jan,
> >
> > That is how we encode a NULL file handle (i.e. superblock error).  Amir
> > suggested it would be an invalid FILEID_INVALID, with a zeroed handle of
> > size 8.  I will improve the comment on the next iteration.
>
> Thanks for info. Then I have a question for Amir I guess :) Amir, what's
> the advantage of zeroed handle of size 8 instead of just 0 length file
> handle?

With current code, zero fh->len means we are not reporting an FID info
record (e.g. due to encode error), see copy_info_records_to_user().

This is because fh->len plays a dual role for indicating the length of the
file handle and the existence of FID info.

I figured that keeping a positive length for the special NULL_FH is an
easy way to workaround this ambiguity and keep the code simpler.
We don't really need to pay any cost for keeping the 8 bytes zero buffer.

Thanks,
Amir.
