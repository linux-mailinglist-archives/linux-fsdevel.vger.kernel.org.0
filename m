Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66B6202541
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgFTQ14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFTQ14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:27:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD1C06174E;
        Sat, 20 Jun 2020 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ama9No7LcT5b/qPuEpA7ghtbIZZe7ttjP4oS5TfpNFI=; b=qoUHSzwTi0k/IMsmObNSMt+L/Y
        VDpGir+hw/HrjnqygnqAN+wb4HE0ci1oH8HJXb0TP8mz0AESEvWj0A0vOIaEPeDB7CaDQcee7H7N4
        1pgj35IJlKhYhtfDvusBDq5mTZmNRKqjjybiGmyPAwmSKUdwvu4mSqa4jrFfuRhsVPC0448Ysiz2T
        waTnm6QB6GZxFTFQ56FczUaCVxZd+U8yVA9hEsTwExj5blhtFEbl5T47iS823EMO+TkwGL2uOLwI4
        Bnug6L13QpyKv0GhCCDaW3IYxaCPd0uJNErR166tdxiX+cYUGFkMO0p+luXF+Pmodkwo1NcmvooW+
        K3OhISdg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmgLQ-0002AA-QI; Sat, 20 Jun 2020 16:27:52 +0000
Date:   Sat, 20 Jun 2020 09:27:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc
 dentries
Message-ID: <20200620162752.GF8681@bombadil.infradead.org>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
 <20200618233958.GV8681@bombadil.infradead.org>
 <877dw3apn8.fsf@x220.int.ebiederm.org>
 <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
 <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
 <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
 <87k1036k9y.fsf@x220.int.ebiederm.org>
 <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
 <87blle4qze.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blle4qze.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:42:45PM -0500, Eric W. Biederman wrote:
> Junxiao Bi <junxiao.bi@oracle.com> writes:
> > Still high lock contention. Collect the following hot path.
> 
> A different location this time.
> 
> I know of at least exit_signal and exit_notify that take thread wide
> locks, and it looks like exit_mm is another.  Those don't use the same
> locks as flushing proc.
> 
> 
> So I think you are simply seeing a result of the thundering herd of
> threads shutting down at once.  Given that thread shutdown is fundamentally
> a slow path there is only so much that can be done.
> 
> If you are up for a project to working through this thundering herd I
> expect I can help some.  It will be a long process of cleaning up
> the entire thread exit process with an eye to performance.

Wengang had some tests which produced wall-clock values for this problem,
which I agree is more informative.

I'm not entirely sure what the customer workload is that requires a
highly threaded workload to also shut down quickly.  To my mind, an
overall workload is normally composed of highly-threaded tasks that run
for a long time and only shut down rarely (thus performance of shutdown
is not important) and single-threaded tasks that run for a short time.

Understanding this workload is important to my next suggestion, which
is that rather than searching for all the places in the exit path which
contend on a single spinlock, we simply set the allowed CPUs for an
exiting task to include only the CPU that this thread is running on.
It will probably run faster to take the threads down in series on one
CPU rather than take them down in parallel across many CPUs (or am I
mistaken?  Is there inherently a lot of parallelism in the thread
exiting process?)
