Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1624C293D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 11:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiBXKXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 05:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiBXKXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:23:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF84108557;
        Thu, 24 Feb 2022 02:22:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E0F821155;
        Thu, 24 Feb 2022 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645698160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBK5OITzTpB4IVgjdOW97uEOhFLeY9qY+4HyFM8sGYY=;
        b=I0U8WkYbcbWzYb9fTZNlD9Okgzr6jJvChRQD8cqYCfndc4lGEXR3CQ34IrhnDor0uYmnVv
        lfgayJJs2g/Gy+mn+YiCh9lXGqixYwkHa+hnja3uVJVt1c9cP96EjqXA1yEvI8zsiyRGuo
        zT8b1d2APIu4IGAwTShbPfpKRsTMLtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645698160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBK5OITzTpB4IVgjdOW97uEOhFLeY9qY+4HyFM8sGYY=;
        b=EcM3p1ez+hdjjYOajGwXlBcwFpZI8E/pmqluQG2C5CJthHBkO7DAvLmgivUHH3k9bnjgs5
        oPatSRJiNq4VR/AA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E1981A3B84;
        Thu, 24 Feb 2022 10:22:39 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4D488A0605; Thu, 24 Feb 2022 11:22:39 +0100 (CET)
Date:   Thu, 24 Feb 2022 11:22:39 +0100
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
Message-ID: <20220224102239.n7nzyyekuacgpnzg@quack3.lan>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-2-git-send-email-byungchul.park@lge.com>
 <20220221190204.q675gtsb6qhylywa@quack3.lan>
 <20220223003534.GA26277@X58A-UD3R>
 <20220223144859.na2gjgl5efgw5zhn@quack3.lan>
 <20220224011102.GA29726@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224011102.GA29726@X58A-UD3R>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-02-22 10:11:02, Byungchul Park wrote:
> On Wed, Feb 23, 2022 at 03:48:59PM +0100, Jan Kara wrote:
> > > KJOURNALD2(kthread)	TASK1(ksys_write)	TASK2(ksys_write)
> > > 
> > > wait A
> > > --- stuck
> > > 			wait B
> > > 			--- stuck
> > > 						wait C
> > > 						--- stuck
> > > 
> > > wake up B		wake up C		wake up A
> > > 
> > > where:
> > > A is a wait_queue, j_wait_commit
> > > B is a wait_queue, j_wait_transaction_locked
> > > C is a rwsem, mapping.invalidate_lock
> > 
> > I see. But a situation like this is not necessarily a guarantee of a
> > deadlock, is it? I mean there can be task D that will eventually call say
> > 'wake up B' and unblock everything and this is how things were designed to
> > work? Multiple sources of wakeups are quite common I'd say... What does
> 
> Yes. At the very beginning when I desgined Dept, I was thinking whether
> to support multiple wakeup sources or not for a quite long time.
> Supporting it would be a better option to aovid non-critical reports.
> However, I thought anyway we'd better fix it - not urgent tho - if
> there's any single circle dependency. That's why I decided not to
> support it for now and wanted to gather the kernel guys' opinions. Thing
> is which policy we should go with.

I see. So supporting only a single wakeup source is fine for locks I guess.
But for general wait queues or other synchronization mechanisms, I'm afraid
it will lead to quite some false positive reports. Just my 2c.

> > Dept do to prevent false reports in cases like this?
> > 
> > > The above is the simplest form. And it's worth noting that Dept focuses
> > > on wait and event itself rather than grabing and releasing things like
> > > lock. The following is the more descriptive form of it.
> > > 
> > > KJOURNALD2(kthread)	TASK1(ksys_write)	TASK2(ksys_write)
> > > 
> > > wait @j_wait_commit
> > > 			ext4_truncate_failed_write()
> > > 			   down_write(mapping.invalidate_lock)
> > > 
> > > 			   ext4_truncate()
> > > 			      ...
> > > 			      wait @j_wait_transaction_locked
> > > 
> > > 						ext_truncate_failed_write()
> > > 						   down_write(mapping.invalidate_lock)
> > > 
> > > 						ext4_should_retry_alloc()
> > > 						   ...
> > > 						   __jbd2_log_start_commit()
> > > 						      wake_up(j_wait_commit)
> > > jbd2_journal_commit_transaction()
> > >    wake_up(j_wait_transaction_locked)
> > > 			   up_write(mapping.invalidate_lock)
> > > 
> > > I hope this would help you understand the report.
> > 
> > I see, thanks for explanation! So the above scenario is impossible because
> 
> My pleasure.
> 
> > for anyone to block on @j_wait_transaction_locked the transaction must be
> > committing, which is done only by kjournald2 kthread and so that thread
> > cannot be waiting at @j_wait_commit. Essentially blocking on
> > @j_wait_transaction_locked means @j_wait_commit wakeup was already done.
> 
> kjournal2 repeatedly does the wait and the wake_up so the above scenario
> looks possible to me even based on what you explained. Maybe I should
> understand how the journal things work more for furhter discussion. Your
> explanation is so helpful. Thank you really.

OK, let me provide you with more details for better understanding :) In
jbd2 we have an object called 'transaction'. This object can go through
many states but for our case is important that transaction is moved to
T_LOCKED state and out of it only while jbd2_journal_commit_transaction()
function is executing and waiting on j_wait_transaction_locked waitqueue is
exactly waiting for a transaction to get out of T_LOCKED state. Function
jbd2_journal_commit_transaction() is executed only by kjournald. Hence
anyone can see transaction in T_LOCKED state only if kjournald is running
inside jbd2_journal_commit_transaction() and thus kjournald cannot be
sleeping on j_wait_commit at the same time. Does this explain things?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
