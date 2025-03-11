Return-Path: <linux-fsdevel+bounces-43679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EAEA5B5DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 02:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7ED18911E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64601E3772;
	Tue, 11 Mar 2025 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HWNJ/EMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717F1DE887
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656449; cv=none; b=lxkbjPG+0KVjGQJWG03mGwPOQKu6yPTZk4+IIoDToFdaIgOPL13jbcK28FpAWKBVhiJisa3XmgAqUZpO4GU0WY4KKbil8aqRZXNMC/XcTJf3/l2EafJg5BBrdEZvHiJhHDinUtkUq9ylc77wxoe6Rjv8uoOzOUNHCRd1AgxUUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656449; c=relaxed/simple;
	bh=yd0tvkajftiDcyo9cbo+Euelf894/Gh0EHYlrxNiUPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUGU2bxgPd16HHtkkohBRcJiQ+/8gxFTaSCRDi3HUaqb+wuUnfBjTWeuYvL1UDKAYNYCuygV9l9U0uVU2ENZLIMJmKESbairHybInqUY2OmKRANddKiHEgofqrXSPHEDLEDEDCBRNvFw/sCpdpsZ8zWsrcg04KjzW4CFfLCZYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HWNJ/EMg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22438c356c8so57706015ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 18:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741656446; x=1742261246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnnlRtfdf6JJQ+GgX7W8whItH8r4U22DKrAzj9YwijY=;
        b=HWNJ/EMglSlBLZp9sxJVGDvOTrgXd0xagSWs7+v4kHflGgX4KErT2TvUn4QPJK8Rfc
         NNBo4nRF9FqOMzMd8cZG6sebOYgKg5NqaONgNbHzJ6rp2jjCsKPQLljI0QowVa5pZql6
         iiwn/1ICmLHe4+aM7Yg2Gk7K/XlwbRuWZWwb3g2i8spB9EcjXK0TpYSqDS8LRjSYMi10
         lToE5YAtZ9PyWhSy4i8ZOl8Fpmv4ATiSXo09SQq0L24Q38hCKqfWb01pFIKEfLhtWm9E
         gmxl9w4MBgJ2w5vmZCLrpLq1/t8pwsYMtSTDs3b5O3408z6QIlszoGC4+6WzLtyJ6Qg/
         hxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741656446; x=1742261246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnnlRtfdf6JJQ+GgX7W8whItH8r4U22DKrAzj9YwijY=;
        b=vl6NLStyf9DRXKlCyAMn33AFaRZUywE9SznQUlkTvpFkG1k/o8jAVax6SWp60b1qVw
         WcJChN3fMKDKRVRox/pDSEPPlZJv/BxMlbV69h1YdK3Pp/WvsWOqjBh8YKHuSVMaXXLO
         SS1ZAk4e3/9gBi6J4SRcJUMI1B4FHmkoMY3ahbCg0u9KyYnVlA5SVL/OIDP84A5QPjqt
         XtBTMSPGTQlwzjsGFC0C0GFfQSrZrWDkD0HXYeVnq9BpKX+pgFqmigNo1vg3z1raOx3A
         Zz4PJOT1adwXA3XUuZxTq6Y6Fq0DgkYsKtJ+mxyVe6e/z2y/336mKxUxg5mqp1WA+Oww
         g1lg==
X-Forwarded-Encrypted: i=1; AJvYcCUjIyWtzDLdtAz4ccl8qu1pOney3Ylb9SdDtDZAihBbOs3JjzopN05yCJM7FVuScW1xe4hhtDPJjeithV0c@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpIYFnyh5eB0fahvpfJBoj2RgTEH4y3KaeE/02/IYHRFmAMBA
	3G1kf07+d89ge5pBQd4m+Hi1YlsVu7Lez2OOw2pkcBPWiamEWVbBkG9zckVZdIs=
X-Gm-Gg: ASbGnctwIKb8TR3otyV8ri3zrPyl24LzhqmxI/eZ+12mnxtoNmtixhY+OyPCYVbA6NC
	fjNXcayCc6SQ2wXPAsVWeSD7ChXE0Q0kPIhn6h8lrNzVF5o6f85cAESpzwBdKzV1MqbayiLV7wx
	vzGorlfk4e+5TBXgpb7Z8aZ21fOHX3KYDBwkLJ9nmNGLCnCAOewT2Kln4TSk7KOE3uP8tozAGmH
	tZWfMXTD1onL9UGChB6QmwDNIgf+21NnoP5Z79QwFPaovKH41lCLSgjegn0BFAYZ1n0ywa7YP9C
	fa1vUdMgmEO/7bwvA0vXbErexayk6im8Fv6KzjNDloS4RSOzJKf73Kx2TE35d4yfKgiEGScmooX
	4DrgBrJWNdb5JJjbnHa/y
X-Google-Smtp-Source: AGHT+IHdCIBG9Q+ikp04BtthZtSdlzURVMOHvSAT5bnHrk/BUP6x7DTNqVmtJsryQ3BPig+WeP8OAw==
X-Received: by 2002:a17:903:32c5:b0:224:249f:9734 with SMTP id d9443c01a7336-2242887ecd7mr239695415ad.4.1741656446503;
        Mon, 10 Mar 2025 18:27:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e9f29sm85662185ad.81.2025.03.10.18.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 18:27:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1troOx-0000000BWxq-0bQ7;
	Tue, 11 Mar 2025 12:27:23 +1100
Date: Tue, 11 Mar 2025 12:27:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Jooyung Han <jooyung@google.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8-ReyFRoTN4G7UU@dread.disaster.area>
References: <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
 <Z8eURG4AMbhornMf@dread.disaster.area>
 <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com>
 <Z8zbYOkwSaOJKD1z@fedora>
 <a8e5c76a-231f-07d1-a394-847de930f638@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e5c76a-231f-07d1-a394-847de930f638@redhat.com>

On Mon, Mar 10, 2025 at 12:18:51PM +0100, Mikulas Patocka wrote:
> 
> 
> On Sun, 9 Mar 2025, Ming Lei wrote:
> 
> > On Fri, Mar 07, 2025 at 04:21:58PM +0100, Mikulas Patocka wrote:
> > > > I didn't say you were. I said the concept that dm-loop is based on
> > > > is fundamentally flawed and that your benchmark setup does not
> > > > reflect real world usage of loop devices.
> > > 
> > > > Where are the bug reports about the loop device being slow and the
> > > > analysis that indicates that it is unfixable?
> > > 
> > > So, I did benchmarks on an enterprise nvme drive (SAMSUNG 
> > > MZPLJ1T6HBJR-00007). I stacked ext4/loop/ext4, xfs/loop/xfs (using losetup 
> > > --direct-io=on), ext4/dm-loop/ext4 and xfs/dm-loop/xfs. And loop is slow.
> > > 
> > > synchronous I/O:
> > > fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=psync --iodepth=1 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> > > raw block device:
> > >    READ: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3985MiB (4179MB), run=10001-10001msec
> > >   WRITE: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3990MiB (4184MB), run=10001-10001msec
> > > ext4/loop/ext4:
> > >    READ: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2232MiB (2341MB), run=10002-10002msec
> > >   WRITE: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2231MiB (2339MB), run=10002-10002msec
> > > xfs/loop/xfs:
> > >    READ: bw=220MiB/s (230MB/s), 220MiB/s-220MiB/s (230MB/s-230MB/s), io=2196MiB (2303MB), run=10001-10001msec
> > >   WRITE: bw=219MiB/s (230MB/s), 219MiB/s-219MiB/s (230MB/s-230MB/s), io=2193MiB (2300MB), run=10001-10001msec
> > > ext4/dm-loop/ext4:
> > >    READ: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3383MiB (3547MB), run=10002-10002msec
> > >   WRITE: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3385MiB (3549MB), run=10002-10002msec
> > > xfs/dm-loop/xfs:
> > >    READ: bw=375MiB/s (393MB/s), 375MiB/s-375MiB/s (393MB/s-393MB/s), io=3752MiB (3934MB), run=10002-10002msec
> > >   WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=3756MiB (3938MB), run=10002-10002msec
> > > 
> > > asynchronous I/O:
> > > fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=libaio --iodepth=16 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> > > raw block device:
> > >    READ: bw=1246MiB/s (1306MB/s), 1246MiB/s-1246MiB/s (1306MB/s-1306MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
> > >   WRITE: bw=1247MiB/s (1308MB/s), 1247MiB/s-1247MiB/s (1308MB/s-1308MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
> > > ext4/loop/ext4:
> > >    READ: bw=274MiB/s (288MB/s), 274MiB/s-274MiB/s (288MB/s-288MB/s), io=2743MiB (2877MB), run=10001-10001msec
> > >   WRITE: bw=275MiB/s (288MB/s), 275MiB/s-275MiB/s (288MB/s-288MB/s), io=2747MiB (2880MB), run=10001-10001msec
> > > xfs/loop/xfs:
> > >    READ: bw=276MiB/s (289MB/s), 276MiB/s-276MiB/s (289MB/s-289MB/s), io=2761MiB (2896MB), run=10002-10002msec
> > >   WRITE: bw=276MiB/s (290MB/s), 276MiB/s-276MiB/s (290MB/s-290MB/s), io=2765MiB (2899MB), run=10002-10002msec
> > > ext4/dm-loop/ext4:
> > >    READ: bw=1189MiB/s (1247MB/s), 1189MiB/s-1189MiB/s (1247MB/s-1247MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
> > >   WRITE: bw=1190MiB/s (1248MB/s), 1190MiB/s-1190MiB/s (1248MB/s-1248MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
> > > xfs/dm-loop/xfs:
> > >    READ: bw=1209MiB/s (1268MB/s), 1209MiB/s-1209MiB/s (1268MB/s-1268MB/s), io=11.8GiB (12.7GB), run=10001-10001msec
> > >   WRITE: bw=1210MiB/s (1269MB/s), 1210MiB/s-1210MiB/s (1269MB/s-1269MB/s), io=11.8GiB (12.7GB), run=10001-10001msec
> > 
> > Hi Mikulas,
> > 
> > Please try the following patchset:
> > 
> > https://lore.kernel.org/linux-block/20250308162312.1640828-1-ming.lei@redhat.com/
> > 
> > which tries to handle IO in current context directly via NOWAIT, and
> > supports MQ for loop since 12 io jobs are applied in your test. With this
> > change, I can observe similar perf data on raw block device and loop/xfs
> > over mq-virtio-scsi & nvme in my test VM.

I'm not sure RWF_NOWAIT is a workable solution.

Why?

IO submission is queued to a different thread context because to
avoid a potential deadlock. That is, we are operating here in the
writeback context of another filesystem, and so we cannot do things
like depend on memory allocation making forwards progress for IO
submission.  RWF_NOWAIT is not a guarantee that memory allocation
will not occur in the IO submission path - it is implemented as best
effort non-blocking behaviour.

Further, if we have stacked loop devices (e.g.
xfs-loop-ext4-loop-btrfs-loop-xfs) we can will be stacking
RWF_NOWAIT IO submission contexts through multiple filesystems. This
is not a filesystem IO path I want to support - being in the middle
of such a stack creates all sorts of subtle constraints on behaviour
that otherwise wouldn't exist. We actually do this sort of multi-fs
stacking in fstests, so it's not a made up scenario.

I'm also concerned that RWF_NOWAIT submission is not an optimisation
at all for the common sparse/COW image file case, because in this
case RWF_NOWAIT failing with EAGAIN is just as common (if not
moreso) than it succeeding.

i.e. in this case, RWF_NOWAIT writes will fail with -EAGAIN very
frequently, so all that time spent doing IO submission is wasted
time.

Further, because allocation on write requires an exclusive lock and
it is held for some time, this will affect read performance from the
backing device as well. i.e. block mapping during a read while a
write is doing allocation will also return EAGAIN for RWF_NOWAIT.
This will push the read off to the background worker thread to be
serviced and so that will go much slower than a RWF_NOWAIT read that
hits the backing file between writes doing allocation. i.e. read
latency is going to become much, much more variable.

Hence I suspect RWF_NOWAIT is simply hiding the underlying issue
by providing this benchmark with a "pure overwrite" fast path that
avoids the overhead of queueing work through loop_queue_work()....

Can you run these same loop dev tests using a sparse image file and
a sparse fio test file so that the fio benchmark measures the impact
of loop device block allocation on the test? I suspect the results
with the RWF_NOWAIT patch will be somewhat different to the fully
allocated case...

> 
> Yes - with these patches, it is much better.
> 
> > 1) try single queue first by `modprobe loop`
> 
> fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=psync --iodepth=1 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> xfs/loop/xfs
>    READ: bw=302MiB/s (317MB/s), 302MiB/s-302MiB/s (317MB/s-317MB/s), io=3024MiB (3170MB), run=10001-10001msec
>   WRITE: bw=303MiB/s (317MB/s), 303MiB/s-303MiB/s (317MB/s-317MB/s), io=3026MiB (3173MB), run=10001-10001msec
> 
> fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=libaio --iodepth=16 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> xfs/loop/xfs
>    READ: bw=1055MiB/s (1106MB/s), 1055MiB/s-1055MiB/s (1106MB/s-1106MB/s), io=10.3GiB (11.1GB), run=10001-10001msec
>   WRITE: bw=1056MiB/s (1107MB/s), 1056MiB/s-1056MiB/s (1107MB/s-1107MB/s), io=10.3GiB (11.1GB), run=10001-10001msec

Yup, this sort of difference in performance simply from bypassing
loop_queue_work() implies the problem is the single threaded loop
device queue implementation needs to be fixed.

loop_queue_work()
{
	....
	spin_lock_irq(&lo->lo_work_lock);
	....

        } else {
                work = &lo->rootcg_work;
                cmd_list = &lo->rootcg_cmd_list;
        }
	list_add_tail(&cmd->list_entry, cmd_list);
	queue_work(lo->workqueue, work);
	spin_unlock_irq(&lo->lo_work_lock);
}

Not only does every IO that is queued takes this queue lock, there
is only one work instance for the loop device. Therefore there is
only one kworker process per control group that does IO submission
for the loop device. And that kworker thread also takes the work
lock to do dequeue as well.

That serialised queue with a single IO dispatcher thread looks to be
the performance bottleneck to me. We could get rid of the lock by
using a llist for this multi-producer/single consumer cmd list
pattern, though I suspect we can get rid of the list entirely...

i.e. we have a work queue that can run a
thousand concurrent works for this loop device, but the request
queue is depth limited to 128 requests. hence we can have a full
set of requests in flight and not run out of submission worker
concurrency. There's no need to isolate IO from different cgroups in
this situation - they will not get blocked behind IO submission
from a different cgroup that is throttled...

i.e. the cmd->list_entry list_head could be replaced with a struct
work_struct and that whole cmd list management and cgroup scheduling
thing could be replaced with a single call to
queue_work(cmd->io_work). i.e. the single point that all IO
submission is directed through goes away completely.

-Dave
-- 
Dave Chinner
david@fromorbit.com

