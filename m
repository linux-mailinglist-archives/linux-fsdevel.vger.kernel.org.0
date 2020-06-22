Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95016203C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgFVQJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgFVQJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:09:11 -0400
X-Greylist: delayed 1203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Jun 2020 09:09:11 PDT
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BDC061573;
        Mon, 22 Jun 2020 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K1w3Es33FaLd3FA+vAkCOuYJ1kplKwwrQTokMapYqC0=; b=fDTCalao2peu2NLnAdq19qtI3f
        7xJ07Z+bHK77ohChgt0obakRXIoDNi3awvxbpCn9mGVATs47NnLz5u7unGufj6xu2g6HCGVZn6INe
        jJwS1XK2kiNAsxJiMJsARGDvRjkibUFvZZHzIMRUZNK6S+4DPyn+seczDEURTZbUMd1GlZnnWaoxA
        5hH+TZYCsY5sN8ZyKJDpZLcvCZgGqEO2xmnUJ13fkqcY3zX2gboWkcy+pMpyf7DpmReYIkirdZiws
        KPr00MTv6CiwGuRfF4BEoXSdjae4yaGNBLIadclcqfPYQ4lf/IOVyAOcztojtvm+FLzlxqZuymGyk
        c2KU+8Iw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnOga-0004Pe-P7; Mon, 22 Jun 2020 15:48:41 +0000
Date:   Mon, 22 Jun 2020 16:48:40 +0100
From:   willy@casper.infradead.org
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc
 dentries
Message-ID: <20200622154840.GA13945@casper.infradead.org>
References: <877dw3apn8.fsf@x220.int.ebiederm.org>
 <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
 <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
 <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
 <87k1036k9y.fsf@x220.int.ebiederm.org>
 <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
 <87blle4qze.fsf@x220.int.ebiederm.org>
 <20200620162752.GF8681@bombadil.infradead.org>
 <39e9f488-110c-588d-d977-413da3dc5dfa@oracle.com>
 <87d05r2kl3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d05r2kl3.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:20:40AM -0500, Eric W. Biederman wrote:
> Junxiao Bi <junxiao.bi@oracle.com> writes:
> > On 6/20/20 9:27 AM, Matthew Wilcox wrote:
> >> On Fri, Jun 19, 2020 at 05:42:45PM -0500, Eric W. Biederman wrote:
> >>> Junxiao Bi <junxiao.bi@oracle.com> writes:
> >>>> Still high lock contention. Collect the following hot path.
> >>> A different location this time.
> >>>
> >>> I know of at least exit_signal and exit_notify that take thread wide
> >>> locks, and it looks like exit_mm is another.  Those don't use the same
> >>> locks as flushing proc.
> >>>
> >>>
> >>> So I think you are simply seeing a result of the thundering herd of
> >>> threads shutting down at once.  Given that thread shutdown is fundamentally
> >>> a slow path there is only so much that can be done.
> >>>
> >>> If you are up for a project to working through this thundering herd I
> >>> expect I can help some.  It will be a long process of cleaning up
> >>> the entire thread exit process with an eye to performance.
> >> Wengang had some tests which produced wall-clock values for this problem,
> >> which I agree is more informative.
> >>
> >> I'm not entirely sure what the customer workload is that requires a
> >> highly threaded workload to also shut down quickly.  To my mind, an
> >> overall workload is normally composed of highly-threaded tasks that run
> >> for a long time and only shut down rarely (thus performance of shutdown
> >> is not important) and single-threaded tasks that run for a short time.
> >
> > The real workload is a Java application working in server-agent mode, issue
> > happened in agent side, all it do is waiting works dispatching from server and
> > execute. To execute one work, agent will start lots of short live threads, there
> > could be a lot of threads exit same time if there were a lots of work to
> > execute, the contention on the exit path caused a high %sys time which impacted
> > other workload.
> 
> If I understand correctly, the Java VM is not exiting.  Just some of
> it's threads.
> 
> That is a very different problem to deal with.  That are many
> optimizations that are possible when _all_ of the threads are exiting
> that are not possible when _many_ threads are exiting.

Ah!  Now I get it.  This explains why the dput() lock contention was
so important.  A new thread starting would block on that lock as it
tried to create its new /proc/$pid/task/ directory.

Terminating thousands of threads but not the entire process isn't going
to hit many of the locks (eg exit_signal() and exit_mm() aren't going
to be called).  So we need a more sophisticated micro benchmark that is
continually starting threads and asking dozens-to-thousands of them to
stop at the same time.  Otherwise we'll try to fix lots of scalability
problems that our customer doesn't care about.

> Do you know if it is simply the cpu time or if it is the lock contention
> that is the problem?  If it is simply the cpu time we should consider if
> some of the locks that can be highly contended should become mutexes.
> Or perhaps something like Matthew's cpu pinning idea.

If we're not trying to optimise for the entire process going down, then
we definitely don't want my CPU pinning idea.
