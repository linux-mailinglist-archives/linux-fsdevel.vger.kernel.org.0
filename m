Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7389F748E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbfGYIQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 04:16:00 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:34888 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388497AbfGYIQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:16:00 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id CEA9A2E1546;
        Thu, 25 Jul 2019 11:15:55 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BHFOVffvkF-FsBKYq39;
        Thu, 25 Jul 2019 11:15:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1564042555; bh=mqwyPL/Kvi4FlMJZMuuGgTLVmBANLSvlAgU95QJvMKg=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=yg2Z6Kv3kAo5EaGGy3G9RVrs92O5ikWA9VmdX0QpVDDSlO0VlBwqkO2pAkbukBQnn
         J5OizK5Zp+57pK6J+mXCnOSs2NZMLzr+oqr3vj3KLBzIx55idigsymckEWqbyt6bei
         kw1JkUxfveSV9/6Vmj8g1+t1A7++FSfjCZ7y2NpI=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38b3:1cdf:ad1a:1fe1])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QkVcPTjsve-FrIap0Me;
        Thu, 25 Jul 2019 11:15:54 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
To:     Joel Fernandes <joel@joelfernandes.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        Brendan Gregg <bgregg@netflix.com>, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        carmenjackson@google.com, Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        sspatil@google.c
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190723061358.GD128252@google.com> <20190723142049.GC104199@google.com>
 <20190724042842.GA39273@google.com> <20190724141052.GB9945@google.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <c116f836-5a72-c6e6-498f-a904497ef557@yandex-team.ru>
Date:   Thu, 25 Jul 2019 11:15:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190724141052.GB9945@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.07.2019 17:10, Joel Fernandes wrote:> On Wed, Jul 24, 2019 at 01:28:42PM +0900, Minchan Kim wrote:
 >> On Tue, Jul 23, 2019 at 10:20:49AM -0400, Joel Fernandes wrote:
 >>> On Tue, Jul 23, 2019 at 03:13:58PM +0900, Minchan Kim wrote:
 >>>> Hi Joel,
 >>>>
 >>>> On Mon, Jul 22, 2019 at 05:32:04PM -0400, Joel Fernandes (Google) wrote:
 >>>>> The page_idle tracking feature currently requires looking up the pagemap
 >>>>> for a process followed by interacting with /sys/kernel/mm/page_idle.
 >>>>> This is quite cumbersome and can be error-prone too. If between
 >>>>
 >>>> cumbersome: That's the fair tradeoff between idle page tracking and
 >>>> clear_refs because idle page tracking could check even though the page
 >>>> is not mapped.
 >>>
 >>> It is fair tradeoff, but could be made simpler. The userspace code got
 >>> reduced by a good amount as well.
 >>>
 >>>> error-prone: What's the error?
 >>>
 >>> We see in normal Android usage, that some of the times pages appear not to be
 >>> idle even when they really are idle. Reproducing this is a bit unpredictable
 >>> and happens at random occasions. With this new interface, we are seeing this
 >>> happen much much lesser.
 >>
 >> I don't know how you did test. Maybe that could be contributed by
 >> swapping out or shared pages touched by other processes or some kernel
 >> behavior not to keep access bit of their operation.
 >
 > It could be something along these lines is my thinking as well. So we know
 > its already has issues due to what you mentioned, I am not sure what else
 > needs investigation?
 >
 >> Please investigate more what's the root cause. That would be important
 >> point to justify for the patch motivation.
 >
 > The motivation is security. I am dropping the 'accuracy' factor I mentioned
 > from the patch description since it created a lot of confusion.
If you are tracking idle working set for one process you could use degrading
'accuracy' for good - just don't walk page rmap and play only with access
bits in one process. Foreign access could be detected with arbitrary delay,
but this does not important if main goal is heap profiling.

 >
 >>>>> More over looking up PFN from pagemap in Android devices is not
 >>>>> supported by unprivileged process and requires SYS_ADMIN and gives 0 for
 >>>>> the PFN.
 >>>>>
 >>>>> This patch adds support to directly interact with page_idle tracking at
 >>>>> the PID level by introducing a /proc/<pid>/page_idle file. This
 >>>>> eliminates the need for userspace to calculate the mapping of the page.
 >>>>> It follows the exact same semantics as the global
 >>>>> /sys/kernel/mm/page_idle, however it is easier to use for some usecases
 >>>>> where looking up PFN is not needed and also does not require SYS_ADMIN.
 >>>>
 >>>> Ah, so the primary goal is to provide convinience interface and it would
 >>>> help accurary, too. IOW, accuracy is not your main goal?
 >>>
 >>> There are a couple of primary goals: Security, conveience and also solving
 >>> the accuracy/reliability problem we are seeing. Do keep in mind looking up
 >>> PFN has security implications. The PFN field in pagemap is zeroed if the user
 >>> does not have CAP_SYS_ADMIN.
 >>
 >> Myaybe you don't need PFN. is it?
 >
 > With the traditional idle tracking, PFN is needed which has the mentioned
 > security issues. This patch solves it. And the interface is identical and
 > familiar to the existing page_idle bitmap interface.
 >
 >>>>> In Android, we are using this for the heap profiler (heapprofd) which
 >>>>> profiles and pin points code paths which allocates and leaves memory
 >>>>> idle for long periods of time.
 >>>>
 >>>> So the goal is to detect idle pages with idle memory tracking?
 >>>
 >>> Isn't that what idle memory tracking does?
 >>
 >> To me, it's rather misleading. Please read motivation section in document.
 >> The feature would be good to detect workingset pages, not idle pages
 >> because workingset pages are never freed, swapped out and even we could
 >> count on newly allocated pages.
 >>
 >> Motivation
 >> ==========
 >>
 >> The idle page tracking feature allows to track which memory pages are being
 >> accessed by a workload and which are idle. This information can be useful for
 >> estimating the workload's working set size, which, in turn, can be taken into
 >> account when configuring the workload parameters, setting memory cgroup limits,
 >> or deciding where to place the workload within a compute cluster.
 >
 > As we discussed by chat, we could collect additional metadata to check if
 > pages were swapped or freed ever since the time we marked them as idle.
 > However this can be incremental improvement.
 >
 >>>> It couldn't work well because such idle pages could finally swap out and
 >>>> lose every flags of the page descriptor which is working mechanism of
 >>>> idle page tracking. It should have named "workingset page tracking",
 >>>> not "idle page tracking".
 >>>
 >>> The heap profiler that uses page-idle tracking is not to measure working set,
 >>> but to look for pages that are idle for long periods of time.
 >>
 >> It's important part. Please include it in the description so that people
 >> understands what's the usecase. As I said above, if it aims for finding
 >> idle pages durting the period, current idle page tracking feature is not
 >> good ironically.
 >
 > Ok, I will mention.
 >
 >>> Thanks for bringing up the swapping corner case..  Perhaps we can improve
 >>> the heap profiler to detect this by looking at bits 0-4 in pagemap. While it
 >>
 >> Yeb, that could work but it could add overhead again what you want to remove?
 >> Even, userspace should keep metadata to identify that page was already swapped
 >> in last period or newly swapped in new period.
 >
 > Yep.
Between samples page could be read from swap and swapped out back multiple times.
For tracking this swap ptes could be marked with idle bit too.
I believe it's not so hard to find free bit for this.

Refault\swapout will automatically clear this bit in pte even if
page goes nowhere stays if swap-cache.



