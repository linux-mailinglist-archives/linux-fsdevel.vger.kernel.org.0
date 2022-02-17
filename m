Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C774BA699
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 18:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiBQRAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 12:00:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbiBQRA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:00:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754511A340B;
        Thu, 17 Feb 2022 09:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 128226178A;
        Thu, 17 Feb 2022 17:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA09C340E8;
        Thu, 17 Feb 2022 17:00:06 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:00:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch,
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
Message-ID: <20220217120005.67f5ddf4@gandalf.local.home>
In-Reply-To: <Yg5u7dzUxL3Vkncg@mit.edu>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
        <Yg5u7dzUxL3Vkncg@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Feb 2022 10:51:09 -0500
"Theodore Ts'o" <tytso@mit.edu> wrote:

> I know that you're trying to help us, but this tool needs to be far
> better than Lockdep before we should think about merging it.  Even if
> it finds 5% more potential deadlocks, if it creates 95% more false
> positive reports --- and the ones it finds are crazy things that
> rarely actually happen in practice, are the costs worth the benefits?
> And who is bearing the costs, and who is receiving the benefits?

I personally believe that there's potential that this can be helpful and we
will want to merge it.

But, what I believe Ted is trying to say is, if you do not know if the
report is a bug or not, please do not ask the maintainers to determine it
for you. This is a good opportunity for you to look to see why your tool
reported an issue, and learn that subsystem. Look at if this is really a
bug or not, and investigate why.

The likely/unlikely tracing I do finds issues all over the kernel. But
before I report anything, I look at the subsystem and determine *why* it's
reporting what it does. In some cases, it's just a config issue. Where, I
may submit a patch saying "this is 100% wrong in X config, and we should
just remove the "unlikely". But I did the due diligence to find out exactly
what the issue is, and why the tooling reported what it reported.

I want to stress that your Dept tooling looks to have the potential of
being something that will be worth while including. But the false positives
needs to be down to the rate of lockdep false positives. As Ted said, if
it's reporting 95% false positives, nobody is going to look at the 5% of
real bugs that it finds.

-- Steve
