Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3E4D8E84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbiCNVCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 17:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiCNVCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 17:02:04 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 603C03D1F8
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 14:00:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 36E9510E4338;
        Tue, 15 Mar 2022 08:00:52 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nTroB-005V23-Ii; Tue, 15 Mar 2022 08:00:51 +1100
Date:   Tue, 15 Mar 2022 08:00:51 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christopher Hodgkins <George.Hodgkins@colorado.edu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: Spurious SIGBUS when threads race to insert a DAX page
Message-ID: <20220314210051.GQ661808@dread.disaster.area>
References: <CAGd_VJzZArEHHR5HUoUDjkN70aJ7CVsfBjro0mtS3eTPeTy1nw@mail.gmail.com>
 <CAGd_VJxRooTgJdkQw+2m_-r3NFhQ5EaY61Kw+b1GNh=sDvwVDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGd_VJxRooTgJdkQw+2m_-r3NFhQ5EaY61Kw+b1GNh=sDvwVDQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=622fad05
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=PhE4woCKD5HsnWeAxIwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 14, 2022 at 02:04:35PM -0600, Christopher Hodgkins wrote:
> NOTE: This question is about kernel 4.15. All line numbers and symbol
> names correspond to the Git source at tag v4.15.
> 
> Hi all,
> I've been running some benchmarks using ext4 files on PMEM (first-gen
> Intel Optane) as "anonymous" memory, and I've run into a weird error.
> For reference, the way this works is that we have a runtime that at
> startup `fallocate`s a large PMEM-backed file and maps the whole thing
> R/W with MAP_SYNC, and then it interposes on calls to `mmap` in
> userspace to return page-sized chunks of PMEM when anonymous memory is
> requested.
> 
> The error I have encountered is the nondeterministic delivery of
> SIGBUS on the first access to an untouched page of the mapped region
> (which since the file is passed to the application sequentially, is
> also typically the first uninitialized extent in the file at time of
> crash). The accesses are aligned and within a mapped region according
> to smaps, which eliminates the only documented reasons for delivery of
> SIGBUS that I'm aware of.

First thing to check is whether it occurs with XFS+DAX on that
kernel. That will tell you if it's an infrastructure or ext4
problem.

Second thing to do is to test a current 5.17-rc8 kernel to see if
the problem reproduces on a current kernel. i.e. determine if the
problem has actually been fixed or not.

If it reproduces on a current kernel, then update the bug report
with all that information and post the code that reproduces the
problem so we can look at it more detail.

> I did a bit of digging with FTrace, and the course of events at a
> crash seems to be as follows. Multiple (>2) threads start faulting in
> the page, and go through the "synchronous page fault" path. They all
> return error-free from the fdatasync() call at dax.c:1588 and call
> dax_insert_pfn_mkwrite. The first thread to exit that function returns
> NOPAGE (success) and the others all return SIGBUS, and each raises the
> userspace signal on the return path.
> 
> My best guess for why this occurs is that the unsuccessful calls all
> bounce with EBUSY (because of the successful one?) in insert_pfn
> (which tails into the call to vm_insert_mixed_mkwrite at dax.c:1548),
> and then dax_fault_return maps that to SIGBUS. The signal is
> definitely spurious -- as mentioned, one of the threads returns
> success, and if I catch the signal with GDB, the faulting access can
> be successfully performed after the signal is caught. Also, as
> mentioned above, the error is nondeterministic -- it happens maybe one
> out of every five runs. To clarify some other things that could make a
> difference, the pages are normal-sized (not huge) and the SIGBUS isn't
> due to PMEM failure (ie HWPOISON).
> 
> I'm on an old kernel (4.15) so if this is really an error in the
> kernel code it may be fixed on the current series. If that's the case,
> just point me to a patch or release number where it was fixed and I'll
> be happy.

git bisect is your friend, and it doesn't require any upstream
developer time for you to run the bisect and determine where it was
fixed...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
