Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3131B2C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 22:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhBNVZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 16:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBNVZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 16:25:22 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6BFC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 13:24:42 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBOsb-00E1Cd-EU; Sun, 14 Feb 2021 21:24:33 +0000
Date:   Sun, 14 Feb 2021 21:24:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK (Insufficiently faking current?)
Message-ID: <YCmVETSedjnaxz7g@zeniv-ca.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <m1lfbrwrgq.fsf@fess.ebiederm.org>
 <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
 <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 14, 2021 at 12:30:07PM -0800, Linus Torvalds wrote:
> On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > > Similarly it looks like opening of "/dev/tty" fails to
> > > return the tty of the caller but instead fails because
> > > io-wq threads don't have a tty.
> >
> > I've got a patch queued up for 5.12 that clears ->fs and ->files for the
> > thread if not explicitly inherited, and I'm working on similarly
> > proactively catching these cases that could potentially be problematic.
> 
> Well, the /dev/tty case still needs fixing somehow.
> 
> Opening /dev/tty actually depends on current->signal, and if it is
> NULL it will fall back on the first VT console instead (I think).
> 
> I wonder if it should do the same thing /proc/self does..

	I still think that entire "offload pathname resolution to helper
threads" thing is bollocks.  ->fs, ->files and ->signal is still nowhere
near enough - look at /proc/net, for example.  Or netns-sensitive parts
of sysfs, for that matter...  And that's not going into really weird crap
where opener is very special and assumed to be doing all IO.
