Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0233EE2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 11:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCQKSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 06:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCQKR3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:17:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A305CAC1F;
        Wed, 17 Mar 2021 10:17:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 59E871F2B76; Wed, 17 Mar 2021 11:17:28 +0100 (CET)
Date:   Wed, 17 Mar 2021 11:17:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] fanotify: mix event info and pid into merge key
 hash
Message-ID: <20210317101728.GA2541@quack2.suse.cz>
References: <20210304104826.3993892-1-amir73il@gmail.com>
 <20210304104826.3993892-4-amir73il@gmail.com>
 <20210316151807.GB23532@quack2.suse.cz>
 <CAOQ4uxizm9KdM+82MGni=fUkCzUvU2pt1q+0ynGLkDX47hJm3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxizm9KdM+82MGni=fUkCzUvU2pt1q+0ynGLkDX47hJm3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-03-21 11:26:36, Amir Goldstein wrote:
> On Tue, Mar 16, 2021 at 5:18 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 04-03-21 12:48:24, Amir Goldstein wrote:
> > > Improve the merge key hash by mixing more values relevant for merge.
> > >
> > > For example, all FAN_CREATE name events in the same dir used to have the
> > > same merge key based on the dir inode.  With this change the created
> > > file name is mixed into the merge key.
> > >
> > > The object id that was used as merge key is redundant to the event info
> > > so it is no longer mixed into the hash.
> > >
> > > Permission events are not hashed, so no need to hash their info.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > ...
> >
> > > @@ -530,6 +568,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> > >       struct inode *child = NULL;
> > >       bool name_event = false;
> > >       unsigned int hash = 0;
> > > +     unsigned long ondir = (mask & FAN_ONDIR) ? 1UL : 0;
> > > +     struct pid *pid;
> >
> > I've made a tiny change here and changed 'ondir' to bool since I don't see
> > a strong reason to play games like this. Otherwise I took the patch as is.
> >
> 
> OK, so you kept this arithmetics with a bool:
> 
> (unsigned long)pid | ondir
> 
> I suppose there's no harm.

Yes. Bool is guaranteed to be typed to int (and then subsequently lifted to
unsigned long) in this expression with 'false' translated to 0 and 'true'
translated to 1. So everything works as expected.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
