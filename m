Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9436588B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfGKOKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:10:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKOKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dmt+pyxw4T8mpV04yaOR9Ac6pmdUH/6jx5BRJ/VTKwk=; b=coBVf6pqOhCxhlHxZ9jfrb5HIq
        ZIxMQPsvl/1QYBSuJZ2qrOQS7f4mGMfasw7bXNG0qpCNsuWadIMZLNwl7OYbGVCJd2UbbWWOT8ulL
        jieZjB9EX28Ot8ElDXoevE6hXg5n/VAFcpM98wDmKV6665EcvkBeD9L5rJycn1WxB6LHzIxH8wXvq
        ai4b9IGzqcLo5U+aVro7B8GQnPKYlV/UqE2Z+Q0QYcOCk2KgY8s9EUTYzgQoyOdASD0VX/9FFt6rL
        IhYObU/yrPxXR0U5ksG4M3yFW1wLduESZnhsr2ZVMTiJV6QfLbdbuv0idzy2WmW/c3WpQM91jVDUb
        pIsG/a8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlZmS-00016J-Jn; Thu, 11 Jul 2019 14:10:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 661B320976D81; Thu, 11 Jul 2019 16:10:38 +0200 (CEST)
Date:   Thu, 11 Jul 2019 16:10:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
Subject: Re: [PATCH 3/4] numa: introduce numa group per task group
Message-ID: <20190711141038.GE3402@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <93cf9333-2f9a-ca1e-a4a6-54fc388d1673@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93cf9333-2f9a-ca1e-a4a6-54fc388d1673@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 11:32:32AM +0800, 王贇 wrote:
> By tracing numa page faults, we recognize tasks sharing the same page,
> and try pack them together into a single numa group.
> 
> However when two task share lot's of cache pages while not much
> anonymous pages, since numa balancing do not tracing cache page, they
> have no chance to join into the same group.
> 
> While tracing cache page cost too much, we could use some hints from

I forgot; where again do we skip shared pages? task_numa_work() doesn't
seem to skip file vmas.

> userland and cpu cgroup could be a good one.
> 
> This patch introduced new entry 'numa_group' for cpu cgroup, by echo
> non-zero into the entry, we can now force all the tasks of this cgroup
> to join the same numa group serving for task group.
> 
> In this way tasks are more likely to settle down on the same node, to
> share closer cpu cache and gain benefit from NUMA on both file/anonymous
> pages.
> 
> Besides, when multiple cgroup enabled numa group, they will be able to
> exchange task location by utilizing numa migration, in this way they
> could achieve single node settle down without breaking load balance.

I dislike cgroup only interfaces; it there really nothing else we could
use for this?

