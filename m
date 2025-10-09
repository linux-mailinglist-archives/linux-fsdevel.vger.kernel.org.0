Return-Path: <linux-fsdevel+bounces-63650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740ABC870E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 12:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7355B188C074
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983352D9491;
	Thu,  9 Oct 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="MBPSuULL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43171157487
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005075; cv=none; b=kkPpieqIjB4kEHT8Dxr6LhjmS3sgK11yLicAZfb8QgjSFuHVy9b8yVAV8AszD9rZKCV4A1s9nnBkL4ookuRVXP6QVFtZ07YqMBdrDUzKtOtLH18Ma11f2MFll3uL2qqgAqqfF9G3ASAA40xDBCab3QzOLmDsasNatATXcUpOafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005075; c=relaxed/simple;
	bh=j+fmUXd6xQL9GDzbB+vnAAIgPklV/Xk+9LiMGhOmvy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=ahxHWr7hm2KlTO03PJNA/fFyzwmh+HYlO7QmhNEc6Q01pZIIkdCkHAKliTdkbgjBiSPvBYk0rfgnWbVfxwwmRQW+Gklng87Qd7DjGJuwK5gtWBB1RoGlUd4kdCR1rNV12G/qbL+XiMGVSoXQLOi+5q46tftNLI5fG377AcPe+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=MBPSuULL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e5980471eso4435145e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760005072; x=1760609872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwmSwkUktuGN2lTX/avRfIDxnGckKIu3Gz1DedDxn7c=;
        b=MBPSuULLmPt9UA949r4o8qqCiNsGLA2sj4XrdgFWQBet7x5c7Zd1/8v+76t6h/HiiM
         axtHIJsZN11L9jGEH1XXker8b5H4AlHEILGhitx76p2WhjkiVtC7yRVFYKalm+82AAnd
         M7pfSjYJn62h1zpVmgzaLMqdGnzvH1Y5ijwcCX7FOurCI7mhyNYS4GQPMZwTR1Hl5D0U
         M7WqyoTAJ+2AJr0DPueGJ5ugIv9i6eN1UJ51cu+3iAYi9aEXRtDDCzW37JOnWY4gmQ53
         vldrldXuH6GEQJYz5yiXpatB12RMoilpkVZHnm2ZGcwUk4Fa+PuLrnu91kYP3AuPf7JX
         P89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005072; x=1760609872;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwmSwkUktuGN2lTX/avRfIDxnGckKIu3Gz1DedDxn7c=;
        b=addI/gBvHvvV/z0zE7rRprAcBqJOg/Ff6RU5vSQefW6V60RMACK8VNhLnIqLBqh4xq
         5AfhVRBNHf38WqBwflc61aIiTmwf1Y9lYzsShz6KZBm6WDWFw5EuLudbnXAENFKrcO9y
         dpgmTWRI/Ljd27rUs3PGqUYJRir3ollLV5ORsWDY3Bw5UPDm3UhUvyqh9ZTLFV/ILCsm
         uhjtZZORxUi3H3Ya25v81SuCseH7++5L1fXenbftS3k8ww43KLtbOwBxN6X4If5joiM1
         kYjFV3v1FaovMV1jJVpSpvVEPpPDbYmR7/CQq1c9/IwmdSJg4yWJllrWUElazEmhHC3a
         W+1w==
X-Forwarded-Encrypted: i=1; AJvYcCXOXTzTbFpmFERJsisID+ys1zKqLMI7Hs+yJf8BxxUhm6nkWu/jIvnBpK8VuKjN7R+MbuxAAVPP+yIPNy94@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRgM4QWm3vJr1oXlJkz8mJV9cbm4pqnLLbeBViwvYMLpT9rTB
	/irfDaZdyKxJ5Vir5pojacVpfSVQmnI3yb6sxfpsD9weudAIU81BifoS6xElXhcjNGU=
X-Gm-Gg: ASbGncuBY2ETHeNKzAy6m6bHK6147yE01NJgTAAuAjb7Wzq9ls40s2jxOHNm7MaOJjX
	mY2ik9yCg/FR5SbuqDP66GHMwh8icwvEZbGgT7UFP/txGLVNNXtjhnd2uayCmAHTxWrHEckD4PT
	2vfUFVvgp8nf4ulX3Q4QEISpL8BPVGnM4pqefsENDrBUqSdJO65holaUq3ZaMdxpbzbD+hq3NAD
	UrJGB+IdJvsQZUrW9JQoY++VaMrmH6qh23w//rMoAbvp1As+qyHpr0DEWWVZqpL0DP4D8Q50B3w
	qhSfng47ldlYt0fWmWx2J8ZK+05+X6+fG1NH6jRjDsZXtmUDnzcM4CsxVEJBUUKOm7ItYMEKvaJ
	s+4mxBXnXe0KiVGAtnNw10iw6i7GRrlLSuj634kDoXhUecOnpFoYCe2OPWA==
X-Google-Smtp-Source: AGHT+IGwacbifiC1M5sZwj6eWdiAAxc5lwLIbJjHBooQIYKtxGjYSWSnlEuG/9LcwLnvjTDFuT1HuA==
X-Received: by 2002:a05:600c:8206:b0:46e:19f8:88d3 with SMTP id 5b1f17b1804b1-46fa9af313bmr41910765e9.22.1760005071533;
        Thu, 09 Oct 2025 03:17:51 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf11197esm42187475e9.6.2025.10.09.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:17:51 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca,
	kernel-team@cloudflare.com,
	libaokun1@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matt@readmodwrite.com,
	tytso@mit.edu,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Date: Thu,  9 Oct 2025 11:17:48 +0100
Message-Id: <20251009101748.529277-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
References: <20251006115615.2289526-1-matt@readmodwrite.com> <20251008150705.4090434-1-matt@readmodwrite.com> <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 08, 2025 at 06:35:29PM +0200, Jan Kara wrote:
> Hi Matt!
> 
> Nice talking to you again :)
 
Same. It's been too long :)

> On Wed 08-10-25 16:07:05, Matt Fleming wrote:
> 

[...]

> So this particular hang check warning will be silenced by [1]. That being
> said if the writeback is indeed taking longer than expected (depends on
> cgroup configuration etc.) these patches will obviously not fix it. Based
> on what you write below, are you saying that most of the time from these
> 225s is spent in the filesystem allocating blocks? I'd expect we'd spend
> most of the time waiting for IO to complete...
 
Yeah, you're right. Most of the time is spenting waiting for writeback
to complete.

> So I'm somewhat confused here. How big is the allocation request? Above you
> write that average size of order 9 bucket is < 1280 which is true and
> makes me assume the allocation is for 1 stripe which is 1280 blocks. But
> here you write about order 9 allocation.
 
Sorry, I muddled my words. The allocation request is for 1280 blocks.

> Anyway, stripe aligned allocations don't always play well with
> mb_optimize_scan logic, so you can try mounting the filesystem with
> mb_optimize_scan=0 mount option.

Thanks, but unfortunately running with mb_optimize_scan=0 gives us much
worse performance. It looks like it's taking a long time to write out
even 1 page to disk. The flusher thread has been running for 20+hours
now non-stop and it's blocking tasks waiting on writeback.

[Thu Oct  9 09:49:59 2025] INFO: task dockerd:45649 blocked for more than 70565 seconds.

mfleming@node:~$ ps -p 50674 -o pid,etime,cputime,comm
    PID     ELAPSED     TIME COMMAND
  50674    20:18:25 20:14:15 kworker/u400:20+flush-9:127

A perf profile shows:

# Overhead  Command          Shared Object      Symbol                             
# ........  ...............  .................  ...................................
#
    32.09%  kworker/u400:20  [kernel.kallsyms]  [k] ext4_get_group_info
            |          
            |--11.91%--ext4_mb_prefetch
            |          ext4_mb_regular_allocator
            |          ext4_mb_new_blocks
            |          ext4_ext_map_blocks
            |          ext4_map_blocks
            |          ext4_do_writepages
            |          ext4_writepages
            |          do_writepages
            |          __writeback_single_inode
            |          writeback_sb_inodes
            |          __writeback_inodes_wb
            |          wb_writeback
            |          wb_workfn
            |          process_one_work
            |          worker_thread
            |          kthread
            |          ret_from_fork
            |          ret_from_fork_asm
            |          
            |--7.23%--ext4_mb_regular_allocator
            |          ext4_mb_new_blocks
            |          ext4_ext_map_blocks
            |          ext4_map_blocks
            |          ext4_do_writepages
            |          ext4_writepages
            |          do_writepages
            |          __writeback_single_inode
            |          writeback_sb_inodes
            |          __writeback_inodes_wb
            |          wb_writeback
            |          wb_workfn
            |          process_one_work
            |          worker_thread
            |          kthread
            |          ret_from_fork
            |          ret_from_fork_asm

mfleming@node:~$ sudo perf ftrace latency -b  -p 50674 -T ext4_mb_regular_allocator -- sleep 10
#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |          0 |                                                |
     1 - 2    us |          0 |                                                |
     2 - 4    us |          0 |                                                |
     4 - 8    us |          0 |                                                |
     8 - 16   us |          0 |                                                |
    16 - 32   us |          0 |                                                |
    32 - 64   us |          0 |                                                |
    64 - 128  us |          0 |                                                |
   128 - 256  us |          0 |                                                |
   256 - 512  us |          0 |                                                |
   512 - 1024 us |          0 |                                                |
     1 - 2    ms |          0 |                                                |
     2 - 4    ms |          0 |                                                |
     4 - 8    ms |          0 |                                                |
     8 - 16   ms |          0 |                                                |
    16 - 32   ms |          0 |                                                |
    32 - 64   ms |          0 |                                                |
    64 - 128  ms |         85 | #############################################  |
   128 - 256  ms |          1 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |

mfleming@node:~$ sudo perf ftrace latency -b  -p 50674 -T ext4_mb_prefetch -- sleep 10
#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |        130 |                                                |
     1 - 2    us |    1962306 | ####################################           |
     2 - 4    us |     497793 | #########                                      |
     4 - 8    us |       4598 |                                                |
     8 - 16   us |        277 |                                                |
    16 - 32   us |         21 |                                                |
    32 - 64   us |         10 |                                                |
    64 - 128  us |          1 |                                                |
   128 - 256  us |          0 |                                                |
   256 - 512  us |          0 |                                                |
   512 - 1024 us |          0 |                                                |
     1 - 2    ms |          0 |                                                |
     2 - 4    ms |          0 |                                                |
     4 - 8    ms |          0 |                                                |
     8 - 16   ms |          0 |                                                |
    16 - 32   ms |          0 |                                                |
    32 - 64   ms |          0 |                                                |
    64 - 128  ms |          0 |                                                |
   128 - 256  ms |          0 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |

mfleming@node:~$ sudo bpftrace -e 'fentry:vmlinux:writeback_sb_inodes / tid==50674/ { @in = args.work->nr_pages; @start=nsecs;} fexit:vmlinux:writeback_sb_inodes /tid == 50674/ { $delta = (nsecs - @start) / 1000000; printf("IN: work->nr_pages=%d, OUT: work->nr_pages=%d, wrote=%d page(s) in %dms\n", @in, args.work->nr_pages, @in - args.work->nr_pages, $delta);} END{clear(@in);} interval:s:5 { exit();}'
Attaching 4 probes...
IN: work->nr_pages=6095831, OUT: work->nr_pages=6095830, wrote=1 page(s) in 108ms
IN: work->nr_pages=6095830, OUT: work->nr_pages=6095829, wrote=1 page(s) in 108ms
IN: work->nr_pages=6095829, OUT: work->nr_pages=6095828, wrote=1 page(s) in 108ms
IN: work->nr_pages=6095828, OUT: work->nr_pages=6095827, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095827, OUT: work->nr_pages=6095826, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095826, OUT: work->nr_pages=6095825, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095825, OUT: work->nr_pages=6095824, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095824, OUT: work->nr_pages=6095823, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095823, OUT: work->nr_pages=6095822, wrote=1 page(s) in 107ms
IN: work->nr_pages=6095822, OUT: work->nr_pages=6095821, wrote=1 page(s) in 106ms

Thanks,
Matt

