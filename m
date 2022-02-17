Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661384B9D43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 11:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiBQKfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 05:35:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiBQKfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:35:52 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29BEA2804FA
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 02:35:36 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 17 Feb 2022 19:35:34 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 17 Feb 2022 19:35:34 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
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
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report in ata_scsi_port_error_handler()
Date:   Thu, 17 Feb 2022 19:35:28 +0900
Message-Id: <1645094128-17099-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAHk-=wgfpfWuNQi2SjXQL1ir6iKCpUdBruJ+kmOQP1frH7Zdig@mail.gmail.com>
References: <CAHk-=wgfpfWuNQi2SjXQL1ir6iKCpUdBruJ+kmOQP1frH7Zdig@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 15, 2022 at 10:37 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > On 2/16/22 13:16, Byungchul Park wrote:
> > > [    2.051040 ] ===================================================
> > > [    2.051406 ] DEPT: Circular dependency has been detected.
> > > [    2.051730 ] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W
> > > [    2.051991 ] ---------------------------------------------------
> > > [    2.051991 ] summary
> > > [    2.051991 ] ---------------------------------------------------
> > > [    2.051991 ] *** DEADLOCK ***
> > > [    2.051991 ]
> > > [    2.051991 ] context A
> > > [    2.051991 ]     [S] (unknown)(&(&ap->eh_wait_q)->dmap:0)
> > > [    2.051991 ]     [W] __raw_spin_lock_irq(&host->lock:0)
> > > [    2.051991 ]     [E] event(&(&ap->eh_wait_q)->dmap:0)
> > > [    2.051991 ]
> > > [    2.051991 ] context B
> > > [    2.051991 ]     [S] __raw_spin_lock_irqsave(&host->lock:0)
> > > [    2.051991 ]     [W] wait(&(&ap->eh_wait_q)->dmap:0)
> > > [    2.051991 ]     [E] spin_unlock(&host->lock:0)
> >
> > Sleeping with a spinlock held would be triggering warnings already, so
> > these reports seem bogus to me.
> 
> Yeah, Matthew pointed out the same thing for another use-case, where
> it looks like DEPT is looking at the state at the wrong point (not at
> the scheduling point, but at prepare_to_sleep()).
> 
> This ata_port_wait() is the exact same pattern, ie we have
> 
>	spin_lock_irqsave(ap->lock, flags);
> 
>	while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
>		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
>		spin_unlock_irqrestore(ap->lock, flags);
>		schedule();
> 
> and DEPT has incorrectly taken it to mean that 'ap->lock' is held
> during the wait, when it is actually released before actually waiting.
> 
> For the spin-locks, this is all very obvious (because they'd have been
> caught long ago by much simpler debug code), but the same
> prepare_to_wait -> wait pattern can most definitely happen with
> sleeping locks too, so they are all slightly suspect.
> 
> And yes, the detailed reports are hard to read because the locations
> are given as "ata_port_wait_eh+0x52/0xc0". Running them through
> scripts/decode_stacktrace.sh to turn them into filename and line
> numbers - and also sort out inlining - would help a lot.
> 
> Byungchul, could you fix those two issues? Some of your reports may

Of couse, that's what I should do. Thanks for your feedback.

> well be entirely valid, but the hard-to-read hex offsets and the
> knowledge that at least some of them are confused about how
> prepare_to_wait -> wait actually works makes the motivation to look at
> the details much less..
> 
> 	Linus
