Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6D156108
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 23:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBGWFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 17:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgBGWFb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:05:31 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B458021775;
        Fri,  7 Feb 2020 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581113130;
        bh=qlcWDRwEnzvcPfmtvySQ7gNQ1Rf4CjYVACOTUXhbijw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tOaqLFmViNHtLJ0btaMSz2O23itaYUjpdi7DO/FH7kX+FopxjY6pERxhD1s2MgkcJ
         81RiotUbuzIsf4uat0ulWeRNmTSzO7IhTsrQWlQJQmJzcC49f2fwxLJUehisWrqbz8
         EWID0NKm/xXKgL3NTngEVcyDtCrEO5Hv7mjgl3qs=
Message-ID: <220e015c525650588f24d17f549cd0a87ec518fd.camel@kernel.org>
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Andres Freund <andres@anarazel.de>,
        Dave Chinner <david@fromorbit.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, dhowells@redhat.com, hch@infradead.org,
        jack@suse.cz, akpm@linux-foundation.org
Date:   Fri, 07 Feb 2020 17:05:28 -0500
In-Reply-To: <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
References: <20200207170423.377931-1-jlayton@kernel.org>
         <20200207205243.GP20628@dread.disaster.area>
         <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-07 at 13:20 -0800, Andres Freund wrote:
> Hi,
> 
> On 2020-02-08 07:52:43 +1100, Dave Chinner wrote:
> > On Fri, Feb 07, 2020 at 12:04:20PM -0500, Jeff Layton wrote:
> > > You're probably wondering -- Where are v1 and v2 sets?
> > > The basic idea is to track writeback errors at the superblock level,
> > > so that we can quickly and easily check whether something bad happened
> > > without having to fsync each file individually. syncfs is then changed
> > > to reliably report writeback errors, and a new ioctl is added to allow
> > > userland to get at the current errseq_t value w/o having to sync out
> > > anything.
> > 
> > So what, exactly, can userspace do with this error? It has no idea
> > at all what file the writeback failure occurred on or even
> > what files syncfs() even acted on so there's no obvious error
> > recovery that it could perform on reception of such an error.
> 
> Depends on the application.  For e.g. postgres it'd to be to reset
> in-memory contents and perform WAL replay from the last checkpoint. Due
> to various reasons* it's very hard for us (without major performance
> and/or reliability impact) to fully guarantee that by the time we fsync
> specific files we do so on an old enough fd to guarantee that we'd see
> the an error triggered by background writeback.  But keeping track of
> all potential filesystems data resides on (with one fd open permanently
> for each) and then syncfs()ing them at checkpoint time is quite doable.
> 
> *I can go into details, but it's probably not interesting enough
> 

Do applications (specifically postgresql) need the ability to check
whether there have been writeback errors on a filesystem w/o blocking on
a syncfs() call?  I thought that you had mentioned a specific usecase
for that, but if you're actually ok with syncfs() then we can drop that
part altogether.

> 
> > > - This adds a new generic fs ioctl to allow userland to scrape the
> > >   current superblock's errseq_t value. It may be best to present this
> > >   to userland via fsinfo() instead (once that's merged). I'm fine with
> > >   dropping the last patch for now and reworking it for fsinfo if so.
> > 
> > What, exactly, is this useful for? Why would we consider exposing
> > an internal implementation detail to userspace like this?
> 
> There is, as far as I can tell, so far no way but scraping the kernel
> log to figure out if there have been data loss errors on a
> machine/fs. Even besides app specific reactions like outlined above,
> just generally being able to alert whenever there error count increases
> seems extremely useful.  I'm not sure it makes sense to expose the
> errseq_t bits straight though - seems like it'd enshrine them in
> userspace ABI too much?
> 

Yeah, if we do end up keeping it, I'm leaning toward making this
fetchable via fsinfo() (once that's merged). If we do that, then we'll
split this into a struct with two fields -- the most recent errno and an
opaque token that you can keep to tell whether new errors have been
recorded since.

I think that should be a little cleaner from an API standpoint. Probably
we can just drop the ioctl, under the assumption that fsinfo() will be
available in 5.7.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

