Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9B3ED62C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbhHPNSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:18:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45690 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbhHPNQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:16:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FD131FE5F;
        Mon, 16 Aug 2021 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629119737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFqrL9tlo3vHH2OdCMbi/CRA3pJJfS/41yIA8FjXzf0=;
        b=Y+/b46UOpoHG8J+Den7D1I/U91wSOlxhsn4uivMO+Um52pZb4o1wu3i9pSHbwFY003kxJK
        kPOLDVKsavKS3HPLJIvRjNoc6/OBKQliGpPOfuNPqY/GvYA0yB3R9ZwQdyfqtPYTk3sv0O
        3jDtlS6KKuQ/rW8m8bCC1m04jU6inNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629119737;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFqrL9tlo3vHH2OdCMbi/CRA3pJJfS/41yIA8FjXzf0=;
        b=K9F1H0giDC5X/udipaLGIVqN+I2jMVsptFImKLYPW//ApiZGVPXmfixcCOcXe7vKoEHmgT
        szNwcQFVyAmS1lBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 058AEA3B8F;
        Mon, 16 Aug 2021 13:15:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E21741E0426; Mon, 16 Aug 2021 15:15:36 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:15:36 +0200
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
Subject: Re: [PATCH v6 04/21] fsnotify: Reserve mark flag bits for backends
Message-ID: <20210816131536.GB30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-5-krisman@collabora.com>
 <CAOQ4uxh0WNxsuwtfv_iDCaZbmJEDB700D5_v==ffm2-WAg_V7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh0WNxsuwtfv_iDCaZbmJEDB700D5_v==ffm2-WAg_V7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 13-08-21 10:28:27, Amir Goldstein wrote:
> On Fri, Aug 13, 2021 at 12:40 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Split out the final bits of struct fsnotify_mark->flags for use by a
> > backend.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
> > Changes since v1:
> >   - turn consts into defines (jan)
> > ---
> >  include/linux/fsnotify_backend.h | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> > index 1ce66748a2d2..ae1bd9f06808 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -363,6 +363,20 @@ struct fsnotify_mark_connector {
> >         struct hlist_head list;
> >  };
> >
> > +enum fsnotify_mark_bits {
> > +       FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY,
> > +       FSN_MARK_FL_BIT_ALIVE,
> > +       FSN_MARK_FL_BIT_ATTACHED,
> > +       FSN_MARK_PRIVATE_FLAGS,
> > +};
> > +
> > +#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY \
> > +       (1 << FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY)
> > +#define FSNOTIFY_MARK_FLAG_ALIVE \
> > +       (1 << FSN_MARK_FL_BIT_ALIVE)
> > +#define FSNOTIFY_MARK_FLAG_ATTACHED \
> > +       (1 << FSN_MARK_FL_BIT_ATTACHED)
> > +
> >  /*
> >   * A mark is simply an object attached to an in core inode which allows an
> >   * fsnotify listener to indicate they are either no longer interested in events
> > @@ -398,9 +412,7 @@ struct fsnotify_mark {
> >         struct fsnotify_mark_connector *connector;
> >         /* Events types to ignore [mark->lock, group->mark_mutex] */
> >         __u32 ignored_mask;
> > -#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY 0x01
> > -#define FSNOTIFY_MARK_FLAG_ALIVE               0x02
> > -#define FSNOTIFY_MARK_FLAG_ATTACHED            0x04
> > +       /* Upper bits [31:PRIVATE_FLAGS] are reserved for backend usage */
> 
> I don't understand what [31:PRIVATE_FLAGS] means

I think it should be [FSN_MARK_PRIVATE_FLAGS:31] (identifying a range of
bits). I'd maybe write just "Bits starting from FSN_MARK_PRIVATE_FLAGS are
reserved for backend usage". With this fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
