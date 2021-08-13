Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30FE3EB506
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhHMMK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 08:10:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbhHMMKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:10:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C01FB2232F;
        Fri, 13 Aug 2021 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628856597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZDrASliUDxQKAR4lqmIWyOYaRQOJ3szPxAVZ9aYxObM=;
        b=wnxard6CyPLNJOUa12qVcYR3ZxXLFFRV50NSoCVIL8M1na6T8UEsg8zHI0xFrNoJGUTFEV
        qTUE77u548MiwB0pGGpbgVMxQAodVgMk+6F9MXqugNdZw89OCsCnx5dEQU0JMOjKMF8TeB
        HeILTO3ukcLuaSLA/X9+/Wu8oTAMpNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628856597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZDrASliUDxQKAR4lqmIWyOYaRQOJ3szPxAVZ9aYxObM=;
        b=9eh9YddJ4JzR+mPw8Myo306KnLpGaU5X+Gnhgl1RkfrCmXmPWg3hFmJwom7PF5b3jNorBV
        rounD5JBNxfsZmAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A1F43A3B84;
        Fri, 13 Aug 2021 12:09:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7EC891E423D; Fri, 13 Aug 2021 14:09:54 +0200 (CEST)
Date:   Fri, 13 Aug 2021 14:09:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v5 14/23] fanotify: Encode invalid file handler when no
 inode is provided
Message-ID: <20210813120954.GA11955@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-15-krisman@collabora.com>
 <20210805095618.GF14483@quack2.suse.cz>
 <87fsvf65zu.fsf@collabora.com>
 <20210812142047.GG14675@quack2.suse.cz>
 <CAOQ4uxjy2FOt6r5=x9FO3YXs8_FWwew055ZfrumDjSz0HCgz3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjy2FOt6r5=x9FO3YXs8_FWwew055ZfrumDjSz0HCgz3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 18:17:10, Amir Goldstein wrote:
> On Thu, Aug 12, 2021 at 5:20 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 11-08-21 17:12:05, Gabriel Krisman Bertazi wrote:
> > > Jan Kara <jack@suse.cz> writes:
> > > >> @@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> > > >>            fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
> > > >>    }
> > > >>
> > > >> -  dwords = fh_len >> 2;
> > > >> -  type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> > > >> -  err = -EINVAL;
> > > >> -  if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> > > >> -          goto out_err;
> > > >> -
> > > >> -  fh->type = type;
> > > >> -  fh->len = fh_len;
> > > >> +  if (inode) {
> > > >> +          dwords = fh_len >> 2;
> > > >> +          type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> > > >> +          err = -EINVAL;
> > > >> +          if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> > > >> +                  goto out_err;
> > > >> +          fh->type = type;
> > > >> +          fh->len = fh_len;
> > > >> +  } else {
> > > >> +          /*
> > > >> +           * Invalid FHs are used on FAN_FS_ERROR for errors not
> > > >> +           * linked to any inode. Caller needs to guarantee the fh
> > > >> +           * has at least FANOTIFY_NULL_FH_LEN bytes of space.
> > > >> +           */
> > > >> +          fh->type = FILEID_INVALID;
> > > >> +          fh->len = FANOTIFY_NULL_FH_LEN;
> > > >> +          memset(buf, 0, FANOTIFY_NULL_FH_LEN);
> > > >> +  }
> > > >
> > > > Maybe it will become clearer later during the series but why do you set
> > > > fh->len to FANOTIFY_NULL_FH_LEN and not 0?
> > >
> > > Jan,
> > >
> > > That is how we encode a NULL file handle (i.e. superblock error).  Amir
> > > suggested it would be an invalid FILEID_INVALID, with a zeroed handle of
> > > size 8.  I will improve the comment on the next iteration.
> >
> > Thanks for info. Then I have a question for Amir I guess :) Amir, what's
> > the advantage of zeroed handle of size 8 instead of just 0 length file
> > handle?
> 
> With current code, zero fh->len means we are not reporting an FID info
> record (e.g. due to encode error), see copy_info_records_to_user().
> 
> This is because fh->len plays a dual role for indicating the length of the
> file handle and the existence of FID info.

I see, thanks for info.

> I figured that keeping a positive length for the special NULL_FH is an
> easy way to workaround this ambiguity and keep the code simpler.
> We don't really need to pay any cost for keeping the 8 bytes zero buffer.

There are two separate questions:
1) How do we internally propagate the information that we don't have
file_handle to report but we do want fsid reported.
2) What do we report to userspace in file_handle.

For 2) I think we should report fsid + FILEID_INVALID, 0-length filehandle.
Currently the non-zero lenght FILEID_INVALID filehandle was propagating to
userspace and IMO that's confusing. For 1), whatever is the simplest to
propagate the information "we want only fsid reported" internally is fine
by me. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
