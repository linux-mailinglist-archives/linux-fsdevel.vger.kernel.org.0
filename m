Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9266E520A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 02:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiEJAhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 20:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiEJAhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 20:37:48 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FFD52AEDB9
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 17:33:51 -0700 (PDT)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 10 May 2022 09:33:49 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 10 May 2022 09:33:49 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 10 May 2022 09:32:13 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Message-ID: <20220510003213.GD6047@X58A-UD3R>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
 <YnmCE2iwa0MSqocr@mit.edu>
 <YnmVgVQ7usoXnJ1N@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnmVgVQ7usoXnJ1N@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 06:28:17PM -0400, Theodore Ts'o wrote:
> Oh, one other problem with DEPT --- it's SLOW --- the overhead is
> enormous.  Using kvm-xfstests[1] running "kvm-xfstests smoke", here
> are some sample times:

Yes, right. DEPT has never been optimized. It rather turns on
CONFIG_LOCKDEP and even CONFIG_PROVE_LOCKING when CONFIG_DEPT gets on
because of porting issue. I have no choice but to rely on those to
develop DEPT out of tree. Of course, that's what I don't like.

Plus, for now, I'm focusing on removing false positives. Once it's
considered settled down, I will work on performance optimizaition. But
it should still keep relying on Lockdep CONFIGs and adding additional
overhead on it until DEPT can be developed in the tree.

> 			LOCKDEP		DEPT
> Time to first test	49 seconds	602 seconds
> ext4/001      		2 s		22 s
> ext4/003		2 s		8 s
> ext4/005		0 s		7 s
> ext4/020		1 s		8 s
> ext4/021		11 s		17 s
> ext4/023		0 s		83 s
> generic/001		4 s		76 s
> generic/002		0 s		11 s
> generic/003		10 s		19 s
> 
> There are some large variations; in some cases, some xfstests take 10x
> as much time or more to run.  In fact, when I first started the
> kvm-xfstests run with DEPT, I thought something had hung and that
> tests would never start.  (In fact, with gce-xfstests the default
> watchdog "something has gone terribly wrong with the kexec" had fired,
> and I didn't get any test results using gce-xfstests at all.  If DEPT
> goes in without any optimizations, I'm going to have to adjust the
> watchdogs timers for gce-xfstests.)

Thank you for informing it. I will go for the optimization as well.

> The bottom line is that at the moment, between the false positives,
> and the significant overhead imposed by DEPT, I would suggest that if
> DEPT ever does go in, that it should be possible to disable DEPT and
> only use the existing CONFIG_PROVE_LOCKING version of LOCKDEP, just
> because DEPT is S - L - O - W.
> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> 
> 						- Ted
> 
> P.S.  Darrick and I both have disabled using LOCKDEP by default
> because it slows down ext4 -g auto testing by a factor 2, and xfs -g
> auto testing by a factor of 3.  So the fact that DEPT is a factor of
> 2x to 10x or more slower than LOCKDEP when running various xfstests
> tests should be a real concern.

DEPT is tracking way more objects than Lockdep so it's inevitable to be
slower, but let me try to make it have the similar performance to
Lockdep.

	Byungchul
