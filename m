Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A17178B01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 07:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgCDGzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 01:55:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52406 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgCDGzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:55:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9NwZ-004wMP-8p; Wed, 04 Mar 2020 06:55:47 +0000
Date:   Wed, 4 Mar 2020 06:55:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
Message-ID: <20200304065547.GP23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200301215125.GA873525@ZenIV.linux.org.uk>
 <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
 <20200302003926.GM23230@ZenIV.linux.org.uk>
 <87o8tdgfu8.fsf@x220.int.ebiederm.org>
 <20200304002434.GO23230@ZenIV.linux.org.uk>
 <87wo80g0bo.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo80g0bo.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:23:39PM -0600, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Tue, Mar 03, 2020 at 05:48:31PM -0600, Eric W. Biederman wrote:
> >
> >> > I hope it gets serious beating, though - it touches pretty much every
> >> > codepath in pathname resolution.  Is there any way to sic the bots on
> >> > a branch, short of "push it into -next and wait for screams"?
> >> 
> >> Last I looked pushing a branch to kernel.org was enough for the
> >> kbuild bots.  Sending patches to LKML is also enough for those bots.
> >> 
> >> I don't know if that kind of bot is what you need testing your code.
> >
> > Build bots are generally nice, but in this case... pretty much all of
> > the changes are in fs/namei.c, which is not all that sensitive to
> > config/architecture/whatnot.  Sure, something like "is audit enabled?"
> > may affect the build problems, but not much beyond that.
> >
> > What was that Intel-run(?) bot that posts "such-and-such metrics has
> > 42% regression on such-and-such commit" from time to time?
> > <checks>
> > Subject: [locking/qspinlock] 7b6da71157: unixbench.score 8.4% improvement
> > seems to be the latest of that sort,
> > From: kernel test robot <rong.a.chen@intel.com>
> >
> > Not sure how much of pathwalk-heavy loads is covered by profiling
> > bots of that sort, unfortunately... ;-/
> 
> Do the xfs-tests cover that sort of thing?
> The emphasis is stress testing the filesystem not the VFS but there is a
> lot of overlap between the two.

I do run xfstests.  But "runs in KVM without visible slowdowns" != "won't
cause them on 48-core bare metal".  And this area (especially when it
comes to RCU mode) can be, er, interesting in that respect.

FWIW, I'm putting together some litmus tests for pathwalk semantics -
one of the things I'd like to discuss at LSF; quite a few codepaths
are simply not touched by anything in xfstests.
