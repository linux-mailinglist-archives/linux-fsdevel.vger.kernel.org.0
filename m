Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F863BF91E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 13:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhGHLjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 07:39:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58734 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhGHLjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:39:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3FBE221F4A;
        Thu,  8 Jul 2021 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625744231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zOqQw4qUavojZrlEKdalTDwpwLp4CPGzK/GjPJmBfk=;
        b=ylsUSYdxAKhi88mJOMuyYuh5VPvsq1UFeI7LHYwmqOFx99W/80A6HAXtFMfW0JqJnJ58VN
        onL/xoZH/r64nAlDFicdbFyoqZq+QObsECl+IDbBwG5nOzysBzkgUCFRx2Zsm6rYZ/Ld7t
        pnprmc9wERUsDdH1sbZVnA7C4GItoTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625744231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zOqQw4qUavojZrlEKdalTDwpwLp4CPGzK/GjPJmBfk=;
        b=w556YszZnyknjmLozx/9z0/B+vefmBwM5Hg3BPExIGO8Y8XTUQJAEtDi4apaIpVWm5sxhQ
        xUlR8oDMgJI/FpBw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 2374AA3B85;
        Thu,  8 Jul 2021 11:37:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C35F1E62E4; Thu,  8 Jul 2021 13:37:11 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:37:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in
 struct fsnotify_event_info
Message-ID: <20210708113711.GF1656@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-8-krisman@collabora.com>
 <20210708104307.GA1656@quack2.suse.cz>
 <CAOQ4uxh2_vEiaPy1PQ-++Lpze90uUfNh6ymkE-SMYMVuN5_F1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh2_vEiaPy1PQ-++Lpze90uUfNh6ymkE-SMYMVuN5_F1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-07-21 14:09:43, Amir Goldstein wrote:
> On Thu, Jul 8, 2021 at 1:43 PM Jan Kara <jack@suse.cz> wrote:
> > On Tue 29-06-21 15:10:27, Gabriel Krisman Bertazi wrote:
> > > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > > index f8acddcf54fb..8c2c681b4495 100644
> > > --- a/include/linux/fsnotify.h
> > > +++ b/include/linux/fsnotify.h
> > > @@ -30,7 +30,10 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
> > >                                struct inode *child,
> > >                                const struct qstr *name, u32 cookie)
> > >  {
> > > -     fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
> > > +     __fsnotify(mask, &(struct fsnotify_event_info) {
> > > +                     .data = child, .data_type = FSNOTIFY_EVENT_INODE,
> > > +                     .dir = dir, .name = name, .cookie = cookie,
> > > +                     });
> > >  }
> >
> > Hmm, maybe we could have a macro initializer like:
> >
> > #define FSNOTIFY_EVENT_INFO(data, data_type, dir, name, inode, cookie)  \
> >         (struct fsnotify_event_info) {                                  \
> >                 .data = (data), .data_type = (data_type), .dir = (dir), \
> >                 .name = (name), .inode = (inode), .cookie = (cookie)}
> >
> > Then we'd have:
> >         __fsnotify(mask, &FSNOTIFY_EVENT_INFO(child, FSNOTIFY_EVENT_INODE,
> >                                 dir, name, NULL, cookie));
> >
> > Which looks a bit nicer to me. What do you think guys?
> >
> 
> Sure, looks good.
> But I think it would be even better to have different "wrapper defines" like
> FSNOTIFY_NAME_EVENT_INFO() will less irrelevant arguments.

If we don't overdo it, I agree :) I mean if we end up with a different
helper for each site creating this structure, I'm not sure it helps much...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
