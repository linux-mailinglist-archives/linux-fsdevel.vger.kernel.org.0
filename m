Return-Path: <linux-fsdevel+bounces-13190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C9886CC17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 15:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9FE1F22F7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340627D419;
	Thu, 29 Feb 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TndgSkfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566312F580;
	Thu, 29 Feb 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218373; cv=none; b=s/ZtYQ2wqtduhrtEM0CGBWtoYFyvXsO85XSQev4biqQex9fo5KsKnSKoWyl1b7J9vUAtkjaYYczbAYG6UXs3HJqgDcdTu3OV+igUlbxhTAB4dsSrVEcqEQ+7z++xwgh9PIpnbnZ4OOUcDpp4JQZ8D0m9S8hK6onnumwl9s8DCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218373; c=relaxed/simple;
	bh=4/WYCFVJPYjy7G7/hFBKsPck6u6SfHda5hhoNFmLQFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmZZQQWZTxVpzc2QBc7kxiufY3CmrsXWNnjGFdxaJ8K8ZKQldsd1v3tGSEBIH8S/jiUz/ggyCzdDwugCJVP+a2ZayU1CrLR4FIyg133iNJuqBOptGjiVY8+qjMyLHk6Mz3PivAOnOjnMQkwNrCw/pwRPHeMLlaZcsa+l+9qmg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TndgSkfh; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a0e2a3bf9bso490603eaf.2;
        Thu, 29 Feb 2024 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709218371; x=1709823171; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=af+U4+H5qh4xuNidDxTH9ZAhSfqD3dn9HBUYsy9T3kY=;
        b=TndgSkfh0JXOKJTZINCEjYa/p6/UusyrdAxZyLW6WbmdO3BcoaWzEFNkUQAN4fJtIq
         aFoDX2olkB7rOpBCC3KjI9ZGI12KgjuSC+6HNtR+Zm51aF9SfqShKTtmpxddW4D6h21r
         Kqz+eGNlHhQM4wjasNdR9cvcL1ABHZGZLMt0iO1XidHGRe/TsEXy54Se8nccccw8JqbK
         MoT6GW/vbCfHt/YuNHKh3urBe8hX+aHggYaVEttnZtD4ZZWXqnIyUphK795BTPTIwwy5
         fe1yGohI14D3opqjs0KgkInzgotok1av0ZpSAR0jED5vKZAxaKsw+R3d8HSwG7TRvlwF
         YtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709218371; x=1709823171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af+U4+H5qh4xuNidDxTH9ZAhSfqD3dn9HBUYsy9T3kY=;
        b=JlzE/5tsSHGX5QA+v1CfpxQ0wRx/lzo98elM89Dkd6hhJ9bHTjEgwx4dO2zXJEDArt
         zXHdTEKfDocx4Btc1IiXEkBKlavajCBofWvJgUKIXjwNpywoEjBQUcT8g7O9PuYfgT+U
         9k6m+EYp6TJjeUwJ8iujJvgofmcsv+2Gsn6ODdcvHpqVSBM54Rz3LWKri1f4lnyaiO9s
         cLpM3dhnUg00C6oc5kUcxwBF1ujBUPQkFkRhFFLJSdut+hTThyQHV9oHyeNuGAkN77a8
         S6I8X+RLyBLrKGi/zMVnavAV2fLI9ci+SL4BkJTMLTWBgEFhzwO6tNBRQzdrvJedLyDJ
         bUvg==
X-Forwarded-Encrypted: i=1; AJvYcCX8omyWegt2LCFfZhJo2AefAe1m2XziIeEbTHK52sFFlMObUFwle6htnHqnqVseXUr4z5iAj/+Mu5YrLpqtlLVMWzm3LmJQgvyyEDreC4ROybTDS0P9raimtS59ClrAxlBl6XUMO7CFq7NMi51o5mWSzSqrNq0gg7bqD1d1sbg+4WDOyLPvkFzz7c9U084uDBDFfmbBlEuNsbAH3GXEnyRKoQ==
X-Gm-Message-State: AOJu0YypkahjSVb4mZiG6LwF9+7pGE0tqcs2ZccLCP8Nq3FAYBJfb5sv
	PE8mYi5xDAB/kNz9av97vl9YpKhjFtYxF6uh75MuenGGocRrXJiW
X-Google-Smtp-Source: AGHT+IGqmfw2vysIjfCjLETeZQhzH0WmMS11pBPoXKIPdAjEu+hLsnIBBXYyq7f7Qw6Y58vK5yvdSQ==
X-Received: by 2002:a4a:7604:0:b0:5a0:f121:63a9 with SMTP id t4-20020a4a7604000000b005a0f12163a9mr910923ooc.7.1709218370838;
        Thu, 29 Feb 2024 06:52:50 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id y12-20020a4a624c000000b0059d58430c2asm306267oog.20.2024.02.29.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:52:50 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 29 Feb 2024 08:52:48 -0600
From: John Groves <John@groves.net>
To: Dave Chinner <david@fromorbit.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	john@jagalactic.com, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <5segby7xk6wbyblovpapdymiuvg63e5qarahc4pramhsqikx2x@y3zmih6mgs33>
References: <cover.1708709155.git.john@groves.net>
 <ZdkzJM6sze-p3EWP@bombadil.infradead.org>
 <cc2pabb3szzpm5jxxeku276csqu5vwqgzitkwevfluagx7akiv@h45faer5zpru>
 <Zdy0CGL6e0ri8LiC@bombadil.infradead.org>
 <w5cqtmdgqtjvbnrg5okdgmxe45vjg5evaxh6gg3gs6kwfqmn5p@wgakpqcumrbt>
 <CAB=NE6UvHSvTJJCq-YuBEZNo8F5Kg25aK+2im=V7DgEsTJ8wPg@mail.gmail.com>
 <mw4yhbmza4idassgbqeiti4ue7jq377ezxfrqrcbsbzsrmfiln@kn7qmqljvswl>
 <Zd/ovHqO/16PsUsp@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd/ovHqO/16PsUsp@dread.disaster.area>


Hi Dave!

On 24/02/29 01:15PM, Dave Chinner wrote:
> On Mon, Feb 26, 2024 at 08:05:58PM -0600, John Groves wrote:
> > On 24/02/26 04:58PM, Luis Chamberlain wrote:
> > > On Mon, Feb 26, 2024 at 1:16 PM John Groves <John@groves.net> wrote:
> > > >
> > > > On 24/02/26 07:53AM, Luis Chamberlain wrote:
> > > > > On Mon, Feb 26, 2024 at 07:27:18AM -0600, John Groves wrote:
> > > > > > Run status group 0 (all jobs):
> > > > > >   WRITE: bw=29.6GiB/s (31.8GB/s), 29.6GiB/s-29.6GiB/s (31.8GB/s-31.8GB/s), io=44.7GiB (48.0GB), run=1511-1511msec
> > > > >
> > > > > > This is run on an xfs file system on a SATA ssd.
> > > > >
> > > > > To compare more closer apples to apples, wouldn't it make more sense
> > > > > to try this with XFS on pmem (with fio -direct=1)?
> > > > >
> > > > >   Luis
> > > >
> > > > Makes sense. Here is the same command line I used with xfs before, but
> > > > now it's on /dev/pmem0 (the same 128G, but converted from devdax to pmem
> > > > because xfs requires that.
> > > >
> > > > fio -name=ten-256m-per-thread --nrfiles=10 -bs=2M --group_reporting=1 --alloc-size=1048576 --filesize=256MiB --readwrite=write --fallocate=none --numjobs=48 --create_on_open=0 --ioengine=io_uring --direct=1 --directory=/mnt/xfs
> > > 
> > > Could you try with mkfs.xfs -d agcount=1024
> 
> Won't change anything for the better, may make things worse.

I dropped that arg, though performance looked about the same either way.

> 
> >    bw (  MiB/s): min= 5085, max=27367, per=100.00%, avg=14361.95, stdev=165.61, samples=719
> >    iops        : min= 2516, max=13670, avg=7160.17, stdev=82.88, samples=719
> >   lat (usec)   : 4=0.05%, 10=0.72%, 20=2.23%, 50=2.48%, 100=3.02%
> >   lat (usec)   : 250=1.54%, 500=2.37%, 750=1.34%, 1000=0.75%
> >   lat (msec)   : 2=3.20%, 4=43.10%, 10=23.05%, 20=14.81%, 50=1.25%
> 
> Most of the IO latencies are up round the 4-20ms marks. That seems
> kinda high for a 2MB IO. With a memcpy speed of 10GB/s, the 2MB
> should only take a couple of hundred microseconds. For Famfs, the
> latencies appear to be around 1-4ms.
> 
> So where's all that extra time coming from?

Below, you will see two runs with performance and latency distribution
about the same as famfs (the answer for that was --fallocate=native).

> 
> 
> >   lat (msec)   : 100=0.08%
> >   cpu          : usr=10.18%, sys=0.79%, ctx=67227, majf=0, minf=38511
> 
> And why is system time reporting at almost zero instead of almost
> all the remaining cpu time (i.e. up at 80-90%)?

Something weird is going on with the cpu reporting. Sometimes sys=~0, but other times
it's about what you would expect. I suspect some sort of measurement error,
like maybe the method doesn't work with my cpu model? (I'm grasping, but with
a somewhat rational basis...)

I pasted two xfs runs below. The first has the wonky cpu sys value, and
the second looks about like what one would expect.

> 
> Can you run call-graph kernel profiles for XFS and famfs whilst
> running this workload so we have some insight into what is behaving
> differently here?

Can you point me to an example of how to do that?

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com


I'd been thinking about the ~2x gap for a few days, and the most obvious
difference is famfs files must be preallocated (like fallocate, but works
a bit differently since allocation happens in user space). I just checked 
one of the xfs files, and it had maybe 80 extents (whereas the famfs 
files always have 1 extent here).

FWIW I ran xfs with and without io_uring, and there was no apparent
difference (which makes sense to me because it's not block I/O).

The prior ~2x gap still seems like a lot of overhead for extent list 
mapping to memory, but adding --fallocate=native to the xfs test brought 
it into line with famfs:


+ fio -name=ten-256m-per-thread --nrfiles=10 -bs=2M --group_reporting=1 --alloc-size=1048576 --filesize=256MiB --readwrite=write --fallocate=native --numjobs=48 --create_on_open=0 --ioengine=io_uring --direct=1 --directory=/mnt/xfs
ten-256m-per-thread: (g=0): rw=write, bs=(R) 2048KiB-2048KiB, (W) 2048KiB-2048KiB, (T) 2048KiB-2048KiB, ioengine=io_uring, iodepth=1
...
fio-3.33
Starting 48 processes
Jobs: 38 (f=380): [W(5),_(1),W(12),_(1),W(3),_(1),W(2),_(1),W(2),_(1),W(1),_(1),W(1),_(1),W(6),_(1),W(6),_(2)][57.1%][w=28.0GiB/s][w=14.3k IOPS][eta 00m:03s]
ten-256m-per-thread: (groupid=0, jobs=48): err= 0: pid=1452590: Thu Feb 29 07:46:06 2024
  write: IOPS=15.3k, BW=29.8GiB/s (32.0GB/s)(114GiB/3838msec); 0 zone resets
    slat (usec): min=17, max=55364, avg=668.20, stdev=1120.41
    clat (nsec): min=1368, max=99619k, avg=1982477.32, stdev=2198309.32
     lat (usec): min=179, max=99813, avg=2650.68, stdev=2485.15
    clat percentiles (usec):
     |  1.00th=[    4],  5.00th=[   14], 10.00th=[  172], 20.00th=[  420],
     | 30.00th=[  644], 40.00th=[ 1057], 50.00th=[ 1582], 60.00th=[ 2008],
     | 70.00th=[ 2343], 80.00th=[ 3097], 90.00th=[ 4555], 95.00th=[ 5473],
     | 99.00th=[ 8717], 99.50th=[11863], 99.90th=[20055], 99.95th=[27657],
     | 99.99th=[49546]
   bw (  MiB/s): min=20095, max=59216, per=100.00%, avg=35985.47, stdev=318.61, samples=280
   iops        : min=10031, max=29587, avg=17970.76, stdev=159.29, samples=280
  lat (usec)   : 2=0.06%, 4=1.02%, 10=2.33%, 20=4.29%, 50=1.85%
  lat (usec)   : 100=0.20%, 250=3.26%, 500=11.23%, 750=8.87%, 1000=5.82%
  lat (msec)   : 2=20.95%, 4=26.74%, 10=12.60%, 20=0.66%, 50=0.09%
  lat (msec)   : 100=0.01%
  cpu          : usr=15.48%, sys=1.17%, ctx=62654, majf=0, minf=22801
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,58560,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=29.8GiB/s (32.0GB/s), 29.8GiB/s-29.8GiB/s (32.0GB/s-32.0GB/s), io=114GiB (123GB), run=3838-3838msec

Disk stats (read/write):
  pmem0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%


## Here is a run where the cpu looks "normal"

+ fio -name=ten-256m-per-thread --nrfiles=10 -bs=2M --group_reporting=1 --alloc-size=1048576 --filesize=256MiB --readwrite=write --fallocate=native --numjobs=48 --create_on_open=0 --direct=1 --directory=/mnt/xfs
ten-256m-per-thread: (g=0): rw=write, bs=(R) 2048KiB-2048KiB, (W) 2048KiB-2048KiB, (T) 2048KiB-2048KiB, ioengine=psync, iodepth=1
...
fio-3.33
Starting 48 processes
Jobs: 19 (f=190): [W(2),_(1),W(2),_(8),W(1),_(3),W(1),_(1),W(2),_(2),W(1),_(1),W(3),_(2),W(1),_(1),W(1),_(2),W(2),_(7),W(3),_(1)][55.6%][w=26.7GiB/s][w=13.6k IOPS][eta 00m:04s]
ten-256m-per-thread: (groupid=0, jobs=48): err= 0: pid=1463615: Thu Feb 29 08:19:53 2024
  write: IOPS=12.4k, BW=24.1GiB/s (25.9GB/s)(114GiB/4736msec); 0 zone resets
    clat (usec): min=138, max=117903, avg=2581.99, stdev=2704.61
     lat (usec): min=152, max=120405, avg=3019.04, stdev=2964.47
    clat percentiles (usec):
     |  1.00th=[  161],  5.00th=[  249], 10.00th=[  627], 20.00th=[ 1270],
     | 30.00th=[ 1631], 40.00th=[ 1942], 50.00th=[ 2089], 60.00th=[ 2212],
     | 70.00th=[ 2343], 80.00th=[ 2704], 90.00th=[ 5866], 95.00th=[ 6849],
     | 99.00th=[12387], 99.50th=[14353], 99.90th=[26084], 99.95th=[38536],
     | 99.99th=[78119]
   bw (  MiB/s): min=21204, max=47040, per=100.00%, avg=29005.40, stdev=237.31, samples=329
   iops        : min=10577, max=23497, avg=14479.74, stdev=118.65, samples=329
  lat (usec)   : 250=5.04%, 500=4.03%, 750=2.37%, 1000=3.13%
  lat (msec)   : 2=29.39%, 4=41.05%, 10=13.37%, 20=1.45%, 50=0.15%
  lat (msec)   : 100=0.03%, 250=0.01%
  cpu          : usr=14.43%, sys=78.18%, ctx=5272, majf=0, minf=15708
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,58560,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=24.1GiB/s (25.9GB/s), 24.1GiB/s-24.1GiB/s (25.9GB/s-25.9GB/s), io=114GiB (123GB), run=4736-4736msec

Disk stats (read/write):
  pmem0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%


Cheers,
John


