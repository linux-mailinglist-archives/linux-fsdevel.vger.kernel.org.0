Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534D1358468
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhDHNQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhDHNQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:16:30 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB6C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 06:16:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i9so2084907qka.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w01U76ArOMU4qfaOfMuHKTEXURHPFfypn+mwAKgRWg=;
        b=nWjywnpBjNgV+cJQeeOIwJRrVP48BPLuHoYlSr9oJG2v+NslBVjDlCWadFekYn0/9e
         UC1zgzA047o8OgDc8ItdFDA2gyKmNaIzRyXiIa48aBpKTON4tph96fs3DbMe2fAz4RF+
         yPanVIFoiIW0kCSukyxykuip3YpzZQivLqayo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w01U76ArOMU4qfaOfMuHKTEXURHPFfypn+mwAKgRWg=;
        b=M5Wcg2DSl9odMGp4yxaWyTfxeANhO1LxcIrCwigFMmJIrouYWpEHe5bQnlJqLjYqMF
         bliXYDtIWqWk8oVtLfKx8BXxwK27jkK/8cavlRBJUAdaBP+qTaa5VjSmiv9XQ3dYbUoQ
         gIJD54alDmJO2O+lZMPyn79S99yYwwAdZTKuxuTh/2vkus+M9tshmOe9/Z51JPJQUAt1
         dAFx8BN5Esbl3P/LyEgGSqCbxUOTRxZZWHqjcmh6gkIpdvSZM4kgrY9kpIuI2yAwAQeT
         GldLS0RBy7LhcRLqxel9zqCHeT689dwM0cj5VOj3QofdUKYDrVn2E8VYGkoOA9m5vj2N
         Jbrw==
X-Gm-Message-State: AOAM530BZCHthONWwc/YpInH+YIqsNX45LsUQkrpQRzDFto7JVz6bURd
        w/k3o3aexH1MrDDhuoNyCfLNHJLqu5lu5GDxr0Fc2w==
X-Google-Smtp-Source: ABdhPJzUIM8LUL6kkKTb6nlRS6A7oX/tRyttYG3XbBwPqopByJN20AgTfdEhnVLd+aQwcUBE5T8vsxoYpXrJL9qvzOY=
X-Received: by 2002:a05:620a:714:: with SMTP id 20mr8461579qkc.192.1617887777933;
 Thu, 08 Apr 2021 06:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210407201857.3582797-1-willy@infradead.org> <20210408105705.exod2cvtvnr4467o@riteshh-domain>
In-Reply-To: <20210408105705.exod2cvtvnr4467o@riteshh-domain>
From:   Brendan Gregg <bgregg@netflix.com>
Date:   Thu, 8 Apr 2021 23:15:51 +1000
Message-ID: <CAJN39oidUmM2t9n6RaVpc9e09ckPF592cf8gBcpctm5Z-cveQw@mail.gmail.com>
Subject: Re: [PATCH 0/3] readahead improvements
To:     riteshh <riteshh@linux.ibm.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 8, 2021 at 8:57 PM riteshh <riteshh@linux.ibm.com> wrote:
>
> On 21/04/07 09:18PM, Matthew Wilcox (Oracle) wrote:
> > As requested, fix up readahead_expand() so as to not confuse the ondemand
> > algorithm.  Also make the documentation slightly better.  Dave, could you
> > put in some debug and check this actually works?  I don't generally test
> > with any filesystems that use readahead_expand(), but printing (index,
> > nr_to_read, lookahead_size) in page_cache_ra_unbounded() would let a human
> > (such as your good self) determine whether it's working approximately
> > as designed.
>
> Hello,
>
> Sorry about the silly question here, since I don't have much details of how
> readahead algorithm code path.
>
> 1. Do we know of a way to measure efficiency of readahead in Linux?
> 2. And if there is any way to validate readahead is working correctly and as
>    intended in Linux?

I created a bpftrace tool for measuring readahead efficiency for my
LSFMM 2019 keynote, where it showed the age of readahead pages when
they were finally used:

https://www.slideshare.net/brendangregg/lsfmm-2019-bpf-observability-143092820/29

If they were mostly of a young age, one might conclude that readahead
is not only working, but could be tuned higher. Mostly of an old age,
and one might conclude readahead was tuned too high, and was reading
too many pages (that were later used unrelated to the original
workload).

I think my tool is just the start. What else should we measure for
understanding readahead efficiency? Code it today as a bpftrace tool
(and share it)!

>
> Like is there anything designed already to measure above two things?
> If not, are there any stats which can be collected and later should be parsed to
> say how efficient readahead is working in different use cases and also can
> verify if it's working correctly?
>
> I guess, we can already do point 1 from below. What about point 2 & 3?
> 1. Turn on/off the readahead and measure file reads timings for different
>    patterns. - I guess this is already doable.
>
> 2. Collecting runtime histogram showing how readahead window is
>    increasing/decreasing based on changing read patterns. And collecting how
>    much IOs it takes to increase/decrease the readahead size.
>    Are there any tracepoints needed to be enabled for this?
>
> 3. I guess it won't be possible w/o a way to also measure page cache
>    efficiency. Like in case of a memory pressure, if the page which was read
>    using readahead is thrown out only to re-read it again.
>    So a way to measure page cache efficiency also will be required.
>
> Any idea from others on this?
>
> I do see below page[1] by Brendan showing some ways to measure page cache
> efficiency using cachestat. But there are also some problems mentioned in the
> conclusion section, which I am not sure of what is the latest state of that.
> Also it doesn't discusses much on the readahead efficiency measurement.
>
> [1]: http://www.brendangregg.com/blog/2014-12-31/linux-page-cache-hit-ratio.html

Coincidentally, during the same LSFMMBPF keynote I showed cachestat
and described it as a "sandcastle," as kernel changes easily wash it
away. The MM folk discussed the various issues in measuring this
accurately: while cachestat worked for my workloads, I think there's a
lot more work to do to make it a robust tool for all workloads. I
still think it should be /proc metrics instead, as I commonly want a
page cache hit ratio metric (whereas many of my other tracing tools
are more niche, and can stay as tracing tools).

I don't think there's a video of the talk, but there was a writeup:
https://lwn.net/Articles/787131/

People keep porting my cachestat tool and building other things upon
it, but aren't updating the code, which is getting a bit annoying.
You're all assuming I solved it. But in my original Ftrace cachestat
code I thought I made it clear that it was a proof of concept for
3.13!:

#!/bin/bash
#
# cachestat - show Linux page cache hit/miss statistics.
#             Uses Linux ftrace.
#
# This is a proof of concept using Linux ftrace capabilities on older kernels,
# and works by using function profiling for in-kernel counters. Specifically,
# four kernel functions are traced:
#
# mark_page_accessed() for measuring cache accesses
# mark_buffer_dirty() for measuring cache writes
# add_to_page_cache_lru() for measuring page additions
# account_page_dirtied() for measuring page dirties
#
# It is possible that these functions have been renamed (or are different
# logically) for your kernel version, and this script will not work as-is.
# This script was written on Linux 3.13. This script is a sandcastle: the
# kernel may wash some away, and you'll need to rebuild.
[...]


Brendan

--
Brendan Gregg, Senior Performance Architect, Netflix
