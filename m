Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1320F171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgF3JUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 05:20:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgF3JUo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:20:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15DD3AEDA;
        Tue, 30 Jun 2020 09:20:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A00691E12ED; Tue, 30 Jun 2020 11:20:42 +0200 (CEST)
Date:   Tue, 30 Jun 2020 11:20:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: fsnotify pre-modify VFS hooks (Was: fanotify and LSM path hooks)
Message-ID: <20200630092042.GL26507@quack2.suse.cz>
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz>
 <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz>
 <CAOQ4uxgsJ7NRtFbRYyBj_RW-trysOrUTKUnkYKYR5OMyq-+HXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgsJ7NRtFbRYyBj_RW-trysOrUTKUnkYKYR5OMyq-+HXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-06-20 14:06:37, Amir Goldstein wrote:
> On Wed, Apr 17, 2019 at 2:30 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 16-04-19 21:24:44, Amir Goldstein wrote:
> > > > I'm not so sure about directory pre-modification hooks. Given the amount of
> > > > problems we face with applications using fanotify permission events and
> > > > deadlocking the system, I'm not very fond of expanding that API... AFAIU
> > > > you want to use such hooks for recording (and persisting) that some change
> > > > is going to happen and provide crash-consistency guarantees for such
> > > > journal?
> > > >
> > >
> > > That's the general idea.
> > > I have two use cases for pre-modification hooks:
> > > 1. VFS level snapshots
> > > 2. persistent change tracking
> > >
> > > TBH, I did not consider implementing any of the above in userspace,
> > > so I do not have a specific interest in extending the fanotify API.
> > > I am actually interested in pre-modify fsnotify hooks (not fanotify),
> > > that a snapshot or change tracking subsystem can register with.
> > > An in-kernel fsnotify event handler can set a flag in current task
> > > struct to circumvent system deadlocks on nested filesystem access.
> >
> > OK, I'm not opposed to fsnotify pre-modify hooks as such. As long as
> > handlers stay within the kernel, I'm fine with that. After all this is what
> > LSMs are already doing. Just exposing this to userspace for arbitration is
> > what I have a problem with.
> >
> 
> Short update on that.
> 
> I decided to ditch the LSM hooks approach because I realized that for
> the purpose of persistent change tracking, the pre-modify hooks need
> to be called before the caller is taking filesystem locks.
> 
> So I added hooks inside mnt_want_write and file_start_write wrappers:
> https://github.com/amir73il/linux/commits/fsnotify_pre_modify

FWIW I've glanced through the series. I like the choice of mnt_want_write()
and file_start_write() as a place to generate the event. I somewhat dislike
the number of variants you have to introduce and then pass NULL in some
places because you don't have the info available and then it's not
immediately clear what semantics the event consumers can expect... That
would be good to define and then verify in the code.

Also given you have the requirement "no fs locks on event generation", I'm
not sure how reliable this can be. If you don't hold fs locks when
generating event, cannot it happen that actually modified object is
different from the reported one because we raced with some other fs
operations? And can we prove that? So what exactly is the usecase and
guarantees the event needs to provide?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
