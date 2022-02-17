Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D419C4BA52B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbiBQPvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 10:51:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiBQPvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:51:41 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27F0185542;
        Thu, 17 Feb 2022 07:51:15 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21HFp9vA004055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 10:51:10 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4815815C34C8; Thu, 17 Feb 2022 10:51:09 -0500 (EST)
Date:   Thu, 17 Feb 2022 10:51:09 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
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
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH 00/16] DEPT(Dependency Tracker)
Message-ID: <Yg5u7dzUxL3Vkncg@mit.edu>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 07:57:36PM +0900, Byungchul Park wrote:
> 
> I've got several reports from the tool. Some of them look like false
> alarms and some others look like real deadlock possibility. Because of
> my unfamiliarity of the domain, it's hard to confirm if it's a real one.
> Let me add the reports on this email thread.

The problem is we have so many potentially invalid, or
so-rare-as-to-be-not-worth-the-time-to-investigate-in-the-
grand-scheme-of-all-of-the-fires-burning-on-maintainers laps that it's
really not reasonable to ask maintainers to determine whether
something is a false alarm or not.  If I want more of these unreliable
potential bug reports to investigate, there is a huge backlog in
Syzkaller.  :-)

Looking at the second ext4 report, it doesn't make any sense.  Context
A is the kjournald thread.  We don't do a commit until (a) the timeout
expires, or (b) someone explicitly requests that a commit happen
waking up j_wait_commit.  I'm guessing that complaint here is that
DEPT thinks nothing is explicitly requesting a wake up.  But note that
after 5 seconds (or whatever journal->j_commit_interval) is configured
to be we *will* always start a commit.  So ergo, there can't be a deadlock.

At a higher level of discussion, it's an unfair tax on maintainer's
times to ask maintainers to help you debug DEPT for you.  Tools like
Syzkaller and DEPT are useful insofar as they save us time in making
our subsystems better.  But until you can prove that it's not going to
be a massive denial of service attack on maintainer's time, at the
*very* least keep an RFC on the patch, or add massive warnings that
more often than not DEPT is going to be sending maintainers on a wild
goose chase.

If you know there there "appear to be false positives", you need to
make sure you've tracked them all down before trying to ask that this
be merged.

You may also want to add some documentation about why we should trust
this; in particular for wait channels, when a process calls schedule()
there may be multiple reasons why the thread will wake up --- in the
worst case, such as in the select(2) or epoll(2) system call, there
may be literally thousands of reasons (one for every file desriptor
the select is waiting on) --- why the process will wake up and thus
resolve the potential "deadlock" that DEPT is worrying about.  How is
DEPT going to handle those cases?  If the answer is that things need
to be tagged, then at least disclose potential reasons why DEPT might
be untrustworthy to save your reviewers time.

I know that you're trying to help us, but this tool needs to be far
better than Lockdep before we should think about merging it.  Even if
it finds 5% more potential deadlocks, if it creates 95% more false
positive reports --- and the ones it finds are crazy things that
rarely actually happen in practice, are the costs worth the benefits?
And who is bearing the costs, and who is receiving the benefits?

Regards,

					- Ted
