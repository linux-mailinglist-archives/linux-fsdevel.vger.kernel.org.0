Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C5A4C66F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 11:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiB1KPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 05:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiB1KPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:15:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20440909;
        Mon, 28 Feb 2022 02:14:45 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7AE93210FE;
        Mon, 28 Feb 2022 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646043284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Nl/HRWLf2uRiBoL+p+hRLq5hSZUbfPxUEdyktKl8oE=;
        b=KULkTYGveo35jseuRrsxacL20e1mMh1AdDlv/Jq3tT845dxlZd8Qmg93vYbQ+tlOB5agtm
        paXFNSFpvJNvSOWZXYicuh2wJFUpWDt72JlU/CC4mjqTnpU6EleIpc/ectzIpPzGFaoU63
        xygKjv5c/TGhl0SzFPZbSy4N2oyZmqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646043284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Nl/HRWLf2uRiBoL+p+hRLq5hSZUbfPxUEdyktKl8oE=;
        b=5lw2eu8Ef56UGwgcaNsZEtM4WdIrEqLl75Cg1e8EHxo6tVZ/mEycmh+vwP/hkduGrn5Fxz
        VKNNL/KhIWqAKNBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 67A67A3B87;
        Mon, 28 Feb 2022 10:14:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21A2BA060A; Mon, 28 Feb 2022 11:14:44 +0100 (CET)
Date:   Mon, 28 Feb 2022 11:14:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Jan Kara <jack@suse.cz>, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.com, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <20220228101444.6frl63dn5vmgycbp@quack3.lan>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-2-git-send-email-byungchul.park@lge.com>
 <20220221190204.q675gtsb6qhylywa@quack3.lan>
 <20220223003534.GA26277@X58A-UD3R>
 <20220223144859.na2gjgl5efgw5zhn@quack3.lan>
 <20220224011102.GA29726@X58A-UD3R>
 <20220224102239.n7nzyyekuacgpnzg@quack3.lan>
 <20220228092826.GA5201@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228092826.GA5201@X58A-UD3R>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-02-22 18:28:26, Byungchul Park wrote:
> On Thu, Feb 24, 2022 at 11:22:39AM +0100, Jan Kara wrote:
> > On Thu 24-02-22 10:11:02, Byungchul Park wrote:
> > > On Wed, Feb 23, 2022 at 03:48:59PM +0100, Jan Kara wrote:
> > > > > KJOURNALD2(kthread)	TASK1(ksys_write)	TASK2(ksys_write)
> > > > > 
> > > > > wait A
> > > > > --- stuck
> > > > > 			wait B
> > > > > 			--- stuck
> > > > > 						wait C
> > > > > 						--- stuck
> > > > > 
> > > > > wake up B		wake up C		wake up A
> > > > > 
> > > > > where:
> > > > > A is a wait_queue, j_wait_commit
> > > > > B is a wait_queue, j_wait_transaction_locked
> > > > > C is a rwsem, mapping.invalidate_lock
> > > > 
> > > > I see. But a situation like this is not necessarily a guarantee of a
> > > > deadlock, is it? I mean there can be task D that will eventually call say
> > > > 'wake up B' and unblock everything and this is how things were designed to
> > > > work? Multiple sources of wakeups are quite common I'd say... What does
> > > 
> > > Yes. At the very beginning when I desgined Dept, I was thinking whether
> > > to support multiple wakeup sources or not for a quite long time.
> > > Supporting it would be a better option to aovid non-critical reports.
> > > However, I thought anyway we'd better fix it - not urgent tho - if
> > > there's any single circle dependency. That's why I decided not to
> > > support it for now and wanted to gather the kernel guys' opinions. Thing
> > > is which policy we should go with.
> > 
> > I see. So supporting only a single wakeup source is fine for locks I guess.
> > But for general wait queues or other synchronization mechanisms, I'm afraid
> > it will lead to quite some false positive reports. Just my 2c.
> 
> Thank you for your feedback.
> 
> I realized we've been using "false positive" differently. There exist
> the three types of code in terms of dependency and deadlock. It's worth
> noting that dependencies are built from between waits and events in Dept.
> 
> ---
> 
> case 1. Code with an actual circular dependency, but not deadlock.
> 
>    A circular dependency can be broken by a rescue wakeup source e.g.
>    timeout. It's not a deadlock. If it's okay that the contexts
>    participating in the circular dependency and others waiting for the
>    events in the circle are stuck until it gets broken. Otherwise, say,
>    if it's not meant, then it's anyway problematic.
> 
>    1-1. What if we judge this code is problematic?
>    1-2. What if we judge this code is good?
> 
> case 2. Code with an actual circular dependency, and deadlock.
> 
>    There's no other wakeup source than those within the circular
>    dependency. Literally deadlock. It's problematic and critical.
> 
>    2-1. What if we judge this code is problematic?
>    2-2. What if we judge this code is good?
> 
> case 3. Code with no actual circular dependency, and not deadlock.
> 
>    Must be good.
> 
>    3-1. What if we judge this code is problematic?
>    3-2. What if we judge this code is good?
> 
> ---
> 
> I call only 3-1 "false positive" circular dependency. And you call 1-1
> and 3-1 "false positive" deadlock.
> 
> I've been wondering if the kernel guys esp. Linus considers code with
> any circular dependency is problematic or not, even if it won't lead to
> a deadlock, say, case 1. Even though I designed Dept based on what I
> believe is right, of course, I'm willing to change the design according
> to the majority opinion.
> 
> However, I would never allow case 1 if I were the owner of the kernel
> for better stability, even though the code works anyway okay for now.

So yes, I call a report for the situation "There is circular dependency but
deadlock is not possible." a false positive. And that is because in my
opinion your definition of circular dependency includes schemes that are
useful and used in the kernel.

Your example in case 1 is kind of borderline (I personally would consider
that bug as well) but there are other more valid schemes with multiple
wakeup sources like:

We have a queue of work to do Q protected by lock L. Consumer process has
code like:

while (1) {
	lock L
	prepare_to_wait(work_queued);
	if (no work) {
		unlock L
		sleep
	} else {
		unlock L
		do work
		wake_up(work_done)
	}
}

AFAIU Dept will create dependency here that 'wakeup work_done' is after
'wait for work_queued'. Producer has code like:

while (1) {
	lock L
	prepare_to_wait(work_done)
	if (too much work queued) {
		unlock L
		sleep
	} else {
		queue work
		unlock L
		wake_up(work_queued)
	}
}

And Dept will create dependency here that 'wakeup work_queued' is after
'wait for work_done'. And thus we have a trivial cycle in the dependencies
despite the code being perfectly valid and safe.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
