Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBBF73AF78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 06:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFWEg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 00:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFWEg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524AC2126;
        Thu, 22 Jun 2023 21:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE9A617E6;
        Fri, 23 Jun 2023 04:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33BDC433C0;
        Fri, 23 Jun 2023 04:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687494985;
        bh=wIIxQfC5WSJRvYJdfbpQqGmitcfaxB6kixNhBzHA9Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHeDGp1qleQVq4JHlalZAEakskropekrk1RmNrSgOoiBsSu3R5mitQs8qoi3Q+lkZ
         xXJ5Q2LvhPeal1GRY/3BhiEeTahi2y6Peqrvlj1UCBWtdivPXfd1v1staEENvZoz20
         EDuG5+3oo/GioGXZysxI6Ov/4dGvX/ZiuPDK3cFeo4ZMGAGsPKVL/PgbL0GJLFBs1D
         +INEDpQ6F/DQ4icsBAzXFGzk+igqwUJDtiNmTatnPo8iJtFog1Es8D4w5LqT5WPY02
         Ynzw2JpAE11PN+mPfd+BpXBvcZQ+kSV8d0W+VkBOlm7QiNJm5SOTh3jPKqS4xx1cG2
         uL5NbVbqpyZjg==
Date:   Thu, 22 Jun 2023 21:36:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
Message-ID: <20230623043623.GA851@sol.localdomain>
References: <000000000000ffcb2e05fe9a445c@google.com>
 <ZJKhoxnkNF3VspbP@dread.disaster.area>
 <20230621075421.GA56560@sol.localdomain>
 <ZJQNjFJhLh0C84u/@dread.disaster.area>
 <20230623005617.GA1949@sol.localdomain>
 <328c6e2c-e055-3391-3499-4963e351b0be@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328c6e2c-e055-3391-3499-4963e351b0be@sandeen.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:09:55PM -0500, Eric Sandeen wrote:
> > Grepping for "WARNING:" is how other kernel testing systems find WARN_ON's in
> > the log too.  For example, see _check_dmesg() in common/rc in xfstests.
> > xfstests fails tests if "WARNING:" is logged.  You might be aware of this, as
> > you reviewed and applied xfstests commit 47e5d7d2bb17 which added the code.
> > 
> > I understand it's frustrating that Dmitry's attempt to do something about this
> > problem was incomplete.  I don't think it is helpful to then send a reflexive,
> > adversarial response that shifts the blame for this longstanding problem with
> > the kernel logs entirely onto syzbot and even Dmitry personally.  That just
> > causes confusion about the problem that needs to be solved.
> > 
> > Anyway, either everything that parses the kernel logs needs to be smarter about
> > identifying real WARN_ON's, or all instances of "WARNING:" need to be eliminated
> > from the log (with existing code, coding style guidelines, and checkpatch
> > updated as you mentioned).  I think I'm leaning towards the position that fake
> > "WARNING:"s should be eliminated.  It does seem like a hack, but it makes the
> > "obvious" log pattern matching that everyone tends to write work as expected...
> > 
> > If you don't want to help, fine, but at least please try not to be obstructive.
> 
> I didn't read Dave's reply as "obstructive." There's been a trend lately of
> ever-growing hoards of people (with machines behind them) generating
> ever-more work for a very small and fixed number of developers who are
> burning out. It's not sustainable. The work-generators need to help make
> things better, or the whole system is going to break.
> 
> Dave being frustrated that he has to deal with "bug reports" about a printk
> phrase is valid, IMHO. There are many straws breaking the camel's back these
> days.
> 
> You had asked for a constructive suggestion.
> 
> My specific suggestion is that the people who decided that printk("WARNING")
> merits must-fix syzbot reports should submit patches to any subsystem they
> plan to test, to replace printk("WARNING") with something that will not
> trigger syzbot reports. Don't spread that pain onto every subsystem
> developer who already has to deal with legitimate and pressing work. Or,
> work out some other reliable way to discern WARN_ON from WARNING.
> 
> And add it to checkpatch etc, as Dave suggested.
> 
> This falls into the "help us help you" category. Early on, syszbot
> filesystem reports presented filesystems only as a giant array of hex in a C
> file, leaving it to the poor developer to work out how to use standard
> filesystem tools to analyze the input. Now we get standard images. That's an
> improvement, with some effort on the syzbot side that saves time and effort
> for every filesystem developer forever more. Find more ways to make these
> reports more relevant, more accurate, and more efficient to triage.
> 
> That's my constructive suggestion.
> 

I went ahead and filed an issue against syzkaller for this:
https://github.com/google/syzkaller/issues/3980

I still would like to emphasize that other testing systems such as xfstests do
the same "dmesg | grep WARNING:" thing and therefore have the same problem, at
least in principle.  (Whether a test actually finds anything depends on the code
covered, of course.)  Again, I'm mentioning this not to try to absolve syzkaller
of responsibility, but rather because it's important that everyone agrees on the
problem here, and ideally its solution too.  If people continue operating under
the mistaken belief that this is a syzkaller specific issue, it might be hard to
get kernel patches merged to fix it, especially if those patches involve changes
to checkpatch.pl, CodingStyle, and several dozen different kernel subsystems.
Or, the syzkaller people might go off on their own and find and implement some
way to parse the log reliably, without other the testing systems being fixed...

- Eric
