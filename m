Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAB84C0A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 04:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbiBWDaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 22:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiBWDay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:30:54 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC9704EA12
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 19:30:26 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 23 Feb 2022 12:30:24 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 23 Feb 2022 12:30:24 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 23 Feb 2022 12:30:12 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Jan Kara <jack@suse.cz>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.com, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 1 in ext4 and journal based on v5.17-rc1
Message-ID: <20220223033012.GC26277@X58A-UD3R>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
 <20220222082723.rddf4typah3wegrc@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222082723.rddf4typah3wegrc@quack3.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 09:27:23AM +0100, Jan Kara wrote:
> On Thu 17-02-22 20:10:03, Byungchul Park wrote:
> > [    7.009608] ===================================================
> > [    7.009613] DEPT: Circular dependency has been detected.
> > [    7.009614] 5.17.0-rc1-00014-g8a599299c0cb-dirty #30 Tainted: G        W
> > [    7.009616] ---------------------------------------------------
> > [    7.009617] summary
> > [    7.009618] ---------------------------------------------------
> > [    7.009618] *** DEADLOCK ***
> > [    7.009618]
> > [    7.009619] context A
> > [    7.009619]     [S] (unknown)(&(bit_wait_table + i)->dmap:0)
> > [    7.009621]     [W] down_write(&ei->i_data_sem:0)
> > [    7.009623]     [E] event(&(bit_wait_table + i)->dmap:0)
> > [    7.009624]
> > [    7.009625] context B
> > [    7.009625]     [S] down_read(&ei->i_data_sem:0)
> > [    7.009626]     [W] wait(&(bit_wait_table + i)->dmap:0)
> > [    7.009627]     [E] up_read(&ei->i_data_sem:0)
> > [    7.009628]
> 
> Looking into this I have noticed that Dept here tracks bitlocks (buffer
> locks in particular) but it apparently treats locks on all buffers as one
> locking class so it conflates lock on superblock buffer with a lock on
> extent tree block buffer. These are wastly different locks with different
> locking constraints. So to avoid false positives in filesystems we will
> need to add annotations to differentiate locks on different buffers (based
> on what the block is used for). Similarly how we e.g. annotate i_rwsem for
> different inodes.

Hi Jan Kara,

I just understood why some guys in this space got mad at Dept reports.
I barely got reports from the lock you mentioned with my system -
precisely speaking only one, even though I've been rebooting my system
many times. But another report that someone gave for me showed there
were a lot of reports from the lock.

Your comment and the report are so much helpful. I need to assign
each's own class first for the buffer locks. Thank you very much.

Thanks,
Byungchul

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
