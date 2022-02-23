Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42494C15BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbiBWOtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 09:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbiBWOth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:49:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2CDB715B;
        Wed, 23 Feb 2022 06:49:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 792EC210FA;
        Wed, 23 Feb 2022 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645627740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FK9sEqjfjXY5LitlS8xP8QxizShsUv7zVJcMSguuQsI=;
        b=Tk2CjgZxXq9scsobDc7T0IE8j69fBv5oYo0j3SprpnwipqdH1e05ijG3ppRVnvj9ajcx0m
        8dVZCeyNUWJwVds4B0pGKj/goPeyZwV0aYGsTK2pehyuDpIhJDE2I7uA0ettmJEHCGNcoZ
        KJmeZzigTmasqi+IjZeoiOCACKRgeMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645627740;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FK9sEqjfjXY5LitlS8xP8QxizShsUv7zVJcMSguuQsI=;
        b=ea1wLDQMhfNJsERaMMn0yrMF8Gd3nmirnS6yKtTzzWUn9tSe6Ic6pkXSOxazPL99wYG7nU
        s6X8OdP1Q7JKn5Dg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57AB1A3B8E;
        Wed, 23 Feb 2022 14:49:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 03F62A0605; Wed, 23 Feb 2022 15:48:59 +0100 (CET)
Date:   Wed, 23 Feb 2022 15:48:59 +0100
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
Message-ID: <20220223144859.na2gjgl5efgw5zhn@quack3.lan>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-2-git-send-email-byungchul.park@lge.com>
 <20220221190204.q675gtsb6qhylywa@quack3.lan>
 <20220223003534.GA26277@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223003534.GA26277@X58A-UD3R>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 09:35:34, Byungchul Park wrote:
> On Mon, Feb 21, 2022 at 08:02:04PM +0100, Jan Kara wrote:
> > On Thu 17-02-22 20:10:04, Byungchul Park wrote:
> > > [    9.008161] ===================================================
> > > [    9.008163] DEPT: Circular dependency has been detected.
> > > [    9.008164] 5.17.0-rc1-00015-gb94f67143867-dirty #2 Tainted: G        W
> > > [    9.008166] ---------------------------------------------------
> > > [    9.008167] summary
> > > [    9.008167] ---------------------------------------------------
> > > [    9.008168] *** DEADLOCK ***
> > > [    9.008168]
> > > [    9.008168] context A
> > > [    9.008169]     [S] (unknown)(&(&journal->j_wait_transaction_locked)->dmap:0)
> > > [    9.008171]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
> > > [    9.008172]     [E] event(&(&journal->j_wait_transaction_locked)->dmap:0)
> > > [    9.008173]
> > > [    9.008173] context B
> > > [    9.008174]     [S] down_write(mapping.invalidate_lock:0)
> > > [    9.008175]     [W] wait(&(&journal->j_wait_transaction_locked)->dmap:0)
> > > [    9.008176]     [E] up_write(mapping.invalidate_lock:0)
> > > [    9.008177]
> > > [    9.008178] context C
> > > [    9.008179]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
> > > [    9.008180]     [W] down_write(mapping.invalidate_lock:0)
> > > [    9.008181]     [E] event(&(&journal->j_wait_commit)->dmap:0)
> > > [    9.008181]
> > > [    9.008182] [S]: start of the event context
> > > [    9.008183] [W]: the wait blocked
> > > [    9.008183] [E]: the event not reachable
> > 
> > So what situation is your tool complaining about here? Can you perhaps show
> > it here in more common visualization like:
> 
> Sure.
> 
> > TASK1				TASK2
> > 				does foo, grabs Z
> > does X, grabs lock Y
> > blocks on Z
> > 				blocks on Y
> > 
> > or something like that? Because I was not able to decipher this from the
> > report even after trying for some time...
> 
> KJOURNALD2(kthread)	TASK1(ksys_write)	TASK2(ksys_write)
> 
> wait A
> --- stuck
> 			wait B
> 			--- stuck
> 						wait C
> 						--- stuck
> 
> wake up B		wake up C		wake up A
> 
> where:
> A is a wait_queue, j_wait_commit
> B is a wait_queue, j_wait_transaction_locked
> C is a rwsem, mapping.invalidate_lock

I see. But a situation like this is not necessarily a guarantee of a
deadlock, is it? I mean there can be task D that will eventually call say
'wake up B' and unblock everything and this is how things were designed to
work? Multiple sources of wakeups are quite common I'd say... What does
Dept do to prevent false reports in cases like this?

> The above is the simplest form. And it's worth noting that Dept focuses
> on wait and event itself rather than grabing and releasing things like
> lock. The following is the more descriptive form of it.
> 
> KJOURNALD2(kthread)	TASK1(ksys_write)	TASK2(ksys_write)
> 
> wait @j_wait_commit
> 			ext4_truncate_failed_write()
> 			   down_write(mapping.invalidate_lock)
> 
> 			   ext4_truncate()
> 			      ...
> 			      wait @j_wait_transaction_locked
> 
> 						ext_truncate_failed_write()
> 						   down_write(mapping.invalidate_lock)
> 
> 						ext4_should_retry_alloc()
> 						   ...
> 						   __jbd2_log_start_commit()
> 						      wake_up(j_wait_commit)
> jbd2_journal_commit_transaction()
>    wake_up(j_wait_transaction_locked)
> 			   up_write(mapping.invalidate_lock)
> 
> I hope this would help you understand the report.

I see, thanks for explanation! So the above scenario is impossible because
for anyone to block on @j_wait_transaction_locked the transaction must be
committing, which is done only by kjournald2 kthread and so that thread
cannot be waiting at @j_wait_commit. Essentially blocking on
@j_wait_transaction_locked means @j_wait_commit wakeup was already done.

I guess this shows there can be non-trivial dependencies between wait
queues which are difficult to track in an automated way and without such
tracking we are going to see false positives...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
