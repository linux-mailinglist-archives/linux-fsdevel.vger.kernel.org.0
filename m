Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ADE204622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 02:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbgFWAsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 20:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbgFWAsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:48:20 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA47EC061573;
        Mon, 22 Jun 2020 17:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xW7XautdzOxud38pqzUM3uCC+kw5dmatbyChhqw/vJc=; b=XZOsF4wq148/vLc7JZ7mHdlG/h
        z9hXDq0z7ilaQccnLPANd6oz1/O0Fga5+UkO5lukzIIK2dB1/3sANlEtNeYOAkIY3LFg1TGlD4kfO
        JwWGqAhPvsqKRoOx1KHsBpF8SgseJQPZWKoeUWv/YPSmx6e0wS2tBVcwYXrUf2hz9lydsPGQovjGi
        uPH9f4d99anthkQ0G33tXrKSCafS6kyy+yA4BoojXhBsvE4y5xhJpQ857aOXJItLF0KvCV/qrej8A
        RDkrROu6NFbkKrVWizoOh7K236jXiPQKOhJ8GxPPS1+q0EpocGhaYGt/RHH/f8E9fLygaptMF1h0Z
        2kyT9/Fg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnX6S-00014H-8H; Tue, 23 Jun 2020 00:47:56 +0000
Date:   Tue, 23 Jun 2020 01:47:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc
 dentries
Message-ID: <20200623004756.GE21350@casper.infradead.org>
References: <20200618233958.GV8681@bombadil.infradead.org>
 <877dw3apn8.fsf@x220.int.ebiederm.org>
 <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
 <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
 <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
 <87k1036k9y.fsf@x220.int.ebiederm.org>
 <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
 <87blle4qze.fsf@x220.int.ebiederm.org>
 <20200620162752.GF8681@bombadil.infradead.org>
 <39e9f488-110c-588d-d977-413da3dc5dfa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e9f488-110c-588d-d977-413da3dc5dfa@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 21, 2020 at 10:15:39PM -0700, Junxiao Bi wrote:
> On 6/20/20 9:27 AM, Matthew Wilcox wrote:
> > On Fri, Jun 19, 2020 at 05:42:45PM -0500, Eric W. Biederman wrote:
> > > Junxiao Bi <junxiao.bi@oracle.com> writes:
> > > > Still high lock contention. Collect the following hot path.
> > > A different location this time.
> > > 
> > > I know of at least exit_signal and exit_notify that take thread wide
> > > locks, and it looks like exit_mm is another.  Those don't use the same
> > > locks as flushing proc.
> > > 
> > > 
> > > So I think you are simply seeing a result of the thundering herd of
> > > threads shutting down at once.  Given that thread shutdown is fundamentally
> > > a slow path there is only so much that can be done.
> > > 
> > > If you are up for a project to working through this thundering herd I
> > > expect I can help some.  It will be a long process of cleaning up
> > > the entire thread exit process with an eye to performance.
> > Wengang had some tests which produced wall-clock values for this problem,
> > which I agree is more informative.
> > 
> > I'm not entirely sure what the customer workload is that requires a
> > highly threaded workload to also shut down quickly.  To my mind, an
> > overall workload is normally composed of highly-threaded tasks that run
> > for a long time and only shut down rarely (thus performance of shutdown
> > is not important) and single-threaded tasks that run for a short time.
> 
> The real workload is a Java application working in server-agent mode, issue
> happened in agent side, all it do is waiting works dispatching from server
> and execute. To execute one work, agent will start lots of short live
> threads, there could be a lot of threads exit same time if there were a lots
> of work to execute, the contention on the exit path caused a high %sys time
> which impacted other workload.

How about this for a micro?  Executes in about ten seconds on my laptop.
You might need to tweak it a bit to get better timing on a server.

// gcc -pthread -O2 -g -W -Wall
#include <pthread.h>
#include <unistd.h>

void *worker(void *arg)
{
	int i = 0;
	int *p = arg;

	for (;;) {
		while (i < 1000 * 1000) {
			i += *p;
		}
		sleep(1);
	}
}

int main(int argc, char **argv)
{
	pthread_t threads[20][100];
	int i, j, one = 1;

	for (i = 0; i < 1000; i++) {
		for (j = 0; j < 100; j++)
			pthread_create(&threads[i % 20][j], NULL, worker, &one);
		if (i < 5)
			continue;
		for (j = 0; j < 100; j++)
			pthread_cancel(threads[(i - 5) %20][j]);
	}

	return 0;
}
