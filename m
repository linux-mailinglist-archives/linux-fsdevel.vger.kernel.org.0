Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A369074323E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjF3Bal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 21:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjF3Baj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD4E10E7;
        Thu, 29 Jun 2023 18:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C59A66168A;
        Fri, 30 Jun 2023 01:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D22CC433C8;
        Fri, 30 Jun 2023 01:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688088637;
        bh=OAqWEOuqwYYf3KGnZm7AvLVFke+FPtXRMXoAuderhCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hv+5LSo/T4KAqGDhbRNczXVodV6cg4L6Y+ZmCpyp2t/0EV7IJXv/9FFi9bDmgIwMa
         V9m7FVETr/y7sJ91fqUfkSdazgOMwTIPh3C+Dc8IvJru6C7iZ/a4JkKjd0O/FD0qC6
         1qPo3+20+UrrDNRJiKb0Eg+dCsCw9iuCnByM2COV6+fU4TUKiSq+Ww9RzOiqVyotyN
         m3DpSViemtrFeg8VdOZc9uDrSjh8Gtn4mqraY5QKF2h8gLLEnhRCNy9ixfNQTZqRPO
         32svX6YbWpkkqNTBkItdQ+YNmFZvAz6Ndqxcmc+8114YqGrJ1N491c3VsTMuqikemU
         6fZhm6Bcup5RA==
Date:   Thu, 29 Jun 2023 18:30:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>,
        dchinner@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
Message-ID: <20230630013036.GC11423@frogsfrogsfrogs>
References: <000000000000ffcb2e05fe9a445c@google.com>
 <ZJKhoxnkNF3VspbP@dread.disaster.area>
 <20230621075421.GA56560@sol.localdomain>
 <ZJQNjFJhLh0C84u/@dread.disaster.area>
 <20230623005617.GA1949@sol.localdomain>
 <328c6e2c-e055-3391-3499-4963e351b0be@sandeen.net>
 <20230623043623.GA851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623043623.GA851@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 09:36:23PM -0700, Eric Biggers wrote:
> On Thu, Jun 22, 2023 at 10:09:55PM -0500, Eric Sandeen wrote:
> > > Grepping for "WARNING:" is how other kernel testing systems find WARN_ON's in
> > > the log too.  For example, see _check_dmesg() in common/rc in xfstests.
> > > xfstests fails tests if "WARNING:" is logged.  You might be aware of this, as
> > > you reviewed and applied xfstests commit 47e5d7d2bb17 which added the code.
> > > 
> > > I understand it's frustrating that Dmitry's attempt to do something about this
> > > problem was incomplete.  I don't think it is helpful to then send a reflexive,
> > > adversarial response that shifts the blame for this longstanding problem with
> > > the kernel logs entirely onto syzbot and even Dmitry personally.  That just
> > > causes confusion about the problem that needs to be solved.
> > > 
> > > Anyway, either everything that parses the kernel logs needs to be smarter about
> > > identifying real WARN_ON's, or all instances of "WARNING:" need to be eliminated
> > > from the log (with existing code, coding style guidelines, and checkpatch
> > > updated as you mentioned).  I think I'm leaning towards the position that fake
> > > "WARNING:"s should be eliminated.  It does seem like a hack, but it makes the
> > > "obvious" log pattern matching that everyone tends to write work as expected...
> > > 
> > > If you don't want to help, fine, but at least please try not to be obstructive.
> > 
> > I didn't read Dave's reply as "obstructive." There's been a trend lately of
> > ever-growing hoards of people (with machines behind them) generating
> > ever-more work for a very small and fixed number of developers who are
> > burning out. It's not sustainable. The work-generators need to help make
> > things better, or the whole system is going to break.
> > 
> > Dave being frustrated that he has to deal with "bug reports" about a printk
> > phrase is valid, IMHO. There are many straws breaking the camel's back these
> > days.
> > 
> > You had asked for a constructive suggestion.
> > 
> > My specific suggestion is that the people who decided that printk("WARNING")
> > merits must-fix syzbot reports should submit patches to any subsystem they
> > plan to test, to replace printk("WARNING") with something that will not
> > trigger syzbot reports. Don't spread that pain onto every subsystem
> > developer who already has to deal with legitimate and pressing work. Or,
> > work out some other reliable way to discern WARN_ON from WARNING.
> > 
> > And add it to checkpatch etc, as Dave suggested.
> > 
> > This falls into the "help us help you" category. Early on, syszbot
> > filesystem reports presented filesystems only as a giant array of hex in a C
> > file, leaving it to the poor developer to work out how to use standard
> > filesystem tools to analyze the input. Now we get standard images. That's an
> > improvement, with some effort on the syzbot side that saves time and effort
> > for every filesystem developer forever more. Find more ways to make these
> > reports more relevant, more accurate, and more efficient to triage.
> > 
> > That's my constructive suggestion.
> > 
> 
> I went ahead and filed an issue against syzkaller for this:
> https://github.com/google/syzkaller/issues/3980
> 
> I still would like to emphasize that other testing systems such as xfstests do
> the same "dmesg | grep WARNING:" thing and therefore have the same problem, at
> least in principle.  (Whether a test actually finds anything depends on the code

I was /about/ to comment that fstests allows test authors to disable
various parts of the dmesg reporting when they /know/ the code they're
exercising will spit out logging messages with "WARNING" in them, but
then I decided to read the syzkaller issue you filed...

> covered, of course.)  Again, I'm mentioning this not to try to absolve syzkaller
> of responsibility, but rather because it's important that everyone agrees on the
> problem here, and ideally its solution too.  If people continue operating under
> the mistaken belief that this is a syzkaller specific issue, it might be hard to
> get kernel patches merged to fix it, especially if those patches involve changes
> to checkpatch.pl, CodingStyle, and several dozen different kernel subsystems.

...and observed your claim that bug.h tells you not to use the strings
"BUG" or "WARNING" in a printk message.  That's not a rule that /I/ have
ever heard of at any point during my 20 year career writing kernel code.

Assuming this is the commente that you were referring to:

96c6a32ccb55a (Dmitry Vyukov  2018-08-21 21:55:24 -0700 85)  * Do not include "BUG"/"WARNING" in format strings manually to make these

It was quietly added to a header file five years ago...

$ git grep BUG.*WARNING Documentation/
$ git grep WARNING.*BUG Documentation/
$

...and isn't documented anywhere.  Let me lazily try to figure out how
many printks there are that spit out "BUG:" or "WARNING:"

$ git grep printk.*BUG:  | grep -v -E '(DEBUG|KERN_DEBUG)' | wc -l
23
$ git grep printk.*WARNING: | grep -v KERN_WARNING | wc -l
16

No enforcement via checkpatch.pl either.  Why /do/ I keep running into
linux conventions that I've never heard of, aren't documented, and
are not checked by any of the automation?  I just tripped over rst
heading style complaints a few weeks ago -- same problem!

No wonder you suggested "Follow through with "conversion" to
BUG/WARNING-free log in the kernel."  I had wondered if you could at
least use dmesg -r to find KERN_WARNING.*WARNING, but I suppose XFS
does xfs_warn("WARNING...") so that wouldn't work anyway.

Ugh, string parsing.  At this point I'm going to back away slowly into
the hedge.  Sorry, man, everything is a mess. :(

(That said, if someone sent me a patch changing xfs_warn("WARNING...")
into xfs_notice("NOTICE:") for these "we patched your fs back together"
things, I think I'd be ok with that.)

--D

> Or, the syzkaller people might go off on their own and find and implement some
> way to parse the log reliably, without other the testing systems being fixed...
> 
> - Eric
