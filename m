Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63F9671DC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 14:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjARNah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 08:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjARNaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:30:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050B89190;
        Wed, 18 Jan 2023 04:55:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674046535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AB+InJFKr3A1hH76vbzTChAWIkJom+fRvriRNNNTKpo=;
        b=ageL71ICTbkCOZ+nxBWyWkzol2RTpEDfAtuxHDdk+oA0FdqjcjKXSUkF9inonv4ABtk15r
        oK8DBFK58aaT5/QzdDugGKSJzh81kHFqnR2EfMHG5j0+tsDI7mxPeOje1FLE88KjgMHuxW
        p9VC5bB01OSk0VGh3OhxAGVEG4W5Emfq3pbOOqRqbbGx+opCyRLc30Uq39GtLuYv7BGepM
        Nu0iSXPbwX5LudmSv5tlt1RWjOHLvM7m1i4n2NfF0/ovbFR/RpcvK1VAoEYKFcBkrzNrLa
        kxIN7zJOzgQryGkh9TI0SeFPbreQcetsJBkf8nWsJ6ViHrKp5s0Fb4IHVx8jGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674046535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AB+InJFKr3A1hH76vbzTChAWIkJom+fRvriRNNNTKpo=;
        b=BRCPqEs33kUEXskwliUVCvnmh8wCJdDfDjrmbTNuzayEWcjpccjqIWU1fLzS/xuCffBT88
        uSrX6hUeLwzgQ6Dg==
To:     Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
In-Reply-To: <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
 <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
Date:   Wed, 18 Jan 2023 13:55:34 +0100
Message-ID: <873588j92x.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17 2023 at 10:18, Boqun Feng wrote:
> On Mon, Jan 16, 2023 at 10:00:52AM -0800, Linus Torvalds wrote:
>> I also recall this giving a fair amount of false positives, are they all fixed?
>
> From the following part in the cover letter, I guess the answer is no?
> 	...
>         6. Multiple reports are allowed.
>         7. Deduplication control on multiple reports.
>         8. Withstand false positives thanks to 6.
> 	...
>
> seems to me that the logic is since DEPT allows multiple reports so that
> false positives are fitlerable by users?

I really do not know what's so valuable about multiple reports. They
produce a flood of information which needs to be filtered, while a
single report ensures that the first detected issue is dumped, which
increases the probability that it can be recorded and acted upon.

Filtering out false positives is just the wrong approach. Decoding
dependency issues from any tracker is complex enough given the nature of
the problem, so adding the burden of filtering out issues from a stream
of dumps is not helpful at all. It's just a marketing gag.

> *	Instead of introducing a brand new detector/dependency tracker,
> 	could we first improve the lockdep's dependency tracker? I think
> 	Byungchul also agrees that DEPT and lockdep should share the
> 	same dependency tracker and the benefit of improving the
> 	existing one is that we can always use the self test to catch
> 	any regression. Thoughts?

Ack. If the internal implementation of lockdep has shortcomings, then we
can expand and/or replace it instead of having yet another
infrastructure which is not even remotely as mature.

Thanks,

        tglx
