Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5173034BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbhAZF0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:26:45 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:58188 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732057AbhAZBfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:35:03 -0500
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id EE17B90CF;
        Tue, 26 Jan 2021 12:34:14 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l4DFG-002QrL-6o; Tue, 26 Jan 2021 12:34:14 +1100
Date:   Tue, 26 Jan 2021 12:34:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>, iant@google.com
Subject: Re: [BUG] copy_file_range with sysfs file as input
Message-ID: <20210126013414.GE4626@dread.disaster.area>
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=Gx1m1vkv1q0fsgJoGIkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 03:54:31PM +0800, Nicolas Boichat wrote:
> Hi copy_file_range experts,
> 
> We hit this interesting issue when upgrading Go compiler from 1.13 to
> 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> `/sys/kernel/debug/tracing/trace` to a temporary file.
> 
> Under the hood, Go now uses `copy_file_range` syscall to optimize the
> copy operation. However, that fails to copy any content when the input
> file is from sysfs/tracefs, with an apparent size of 0 (but there is
> still content when you `cat` it, of course).
> 
> A repro case is available in comment7 (adapted from the man page),
> also copied below [2].
> 
> Output looks like this (on kernels 5.4.89 (chromeos), 5.7.17 and
> 5.10.3 (chromeos))
> $ ./copyfrom /sys/kernel/debug/tracing/trace x
> 0 bytes copied

That's basically telling you that copy_file_range() was unable to
copy anything. The man page says:

RETURN VALUE
       Upon  successful  completion,  copy_file_range() will return
       the number of bytes copied between files.  This could be less
       than the length originally requested.  If the file offset
       of fd_in is at or past the end of file, no bytes are copied,
       and copy_file_range() returns zero.

THe man page explains it perfectly. Look at the trace file you are
trying to copy:

$ ls -l /sys/kernel/debug/tracing/trace
-rw-r--r-- 1 root root 0 Jan 19 12:17 /sys/kernel/debug/tracing/trace
$ cat /sys/kernel/debug/tracing/trace
tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |

Yup, the sysfs file reports it's size as zero length, so the CFR
syscall is saying "there's nothing to copy from this empty file" and
so correctly is returning zero without even trying to copy anything
because the file offset is at EOF...

IOWs, there's no copy_file_range() bug here - it's behaving as
documented.

'cat' "works" in this situation because it doesn't check the file
size and just attempts to read unconditionally from the file. Hence
it happily returns non-existent stale data from busted filesystem
implementations that allow data to be read from beyond EOF...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
