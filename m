Return-Path: <linux-fsdevel+bounces-74771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBxZDldCcGnXXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:04:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D280150374
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C9994E8776
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78B35293C;
	Wed, 21 Jan 2026 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pr8JlwaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAE347BBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964687; cv=none; b=ru7b6Tu9nANizua97Zrjnge1/MTPeiYf5IHjhCfbi+vTiqgzOiSc86vgqy+5QQ5QLptFtZ5+0EzLbnOxD2hHs7Vv7feglq70ty4gK0tDARInjpdByAVNvY1e76E4dYhsdhP41mqJuz88/hZErXeMEAgSMECwH1cjM7PwYkkCdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964687; c=relaxed/simple;
	bh=TWEI54Iqzuw+CcLquu7Ufiwo1EhFnXvervNKZcJ8eIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppjmVFKG4+5zUhhdVwcYIaRtnM1a0SuUK65B1jwko4kUGBzTJxRMM50Np649KHGEZuSjh+a3wxyRPKYuKQcEYgftl5sQiX6Q+qI/9IRI6TC07QllFnhT6vCPOl9ejBGQzA8hEf0EbPLyxD5fw2wsh/Saqj3i2UZxeOKvMetDjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pr8JlwaC; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768964676; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v1Xb+9y2HraNWMqrebtudihWynXYvLYKmhtgRQKtt6Y=;
	b=Pr8JlwaCg30gn3l8bWescMjT163F0f+2E1An2lGkKt51NhNgBX0OseSLNTqCEytrB4+sIbbLWHRfxMlhbmMRvMhoNz22RvrFiuGCMlbX6S8Waxdv6W7rdf566jKAyd68gCT3o+TPf4lHjtjynnjrP+fyZ+cY7mTOZx33b6sVQDI=
Received: from 30.221.146.111(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WxWTogB_1768964675 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 11:04:35 +0800
Message-ID: <403da199-dc77-4597-9943-8888bad9a941@linux.alibaba.com>
Date: Wed, 21 Jan 2026 11:04:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] fuse: wait on congestion for async readahead
To: Abhishek Angale <abhishek.angale@rubrik.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
 Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 NeilBrown <neilb@ownmail.net>, linux-fsdevel@vger.kernel.org
References: <CAJnrk1Yi-_x6w0f7w=xRBT7s4SDEJKcTm_f-hCZjdyBVtvxCzQ@mail.gmail.com>
 <20260120105552.760619-1-abhishek.angale@rubrik.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260120105552.760619-1-abhishek.angale@rubrik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,suse.cz,kernel.org,hammerspace.com,ownmail.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-74771-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[rubrik.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D280150374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/20/26 6:55 PM, Abhishek Angale wrote:
> Hi Joanne,
> 
> First, please accept my apologies for the delay in responding.
> 
> Thanks for the thoughtful questions. I agree these are the right
> concerns to validate before making readahead block on congestion, since
> it can block application thread.
> 
> A few clarifications on the call path and what the patch actually waits
> on:
> 
> * The wait only triggers when we’ve reached the congestion threshold and
>   there are only async pages left in the current readahead window:
>   - Condition: fc->num_background >= fc->congestion_threshold &&
>     rac->ra->async_size >= readahead_count(rac)
>   - In other words, the page(s) needed to satisfy the caller’s current
>     read are already accounted for; we don’t block those. We only decide
>     whether to continue prefetching the remainder of the window or skip
>     it.
> 
> * The wait is killable (wait_event_killable), so signals will break out
>   immediately.
> 
> * Wakeups are driven by fuse_request_end() when the number of background
>   requests falls below the congestion threshold. The patch does not
>   increase concurrency; it only avoids the “idle gap” caused by aborting
>   async readahead when congestion eases.
> 
>> How does this perform on workloads where there's other work
>> interspersed between the buffered sequential reads, or on random/mixed
>> workloads where readahead is triggered but not fully utilized?
> 
> To your questions on interspersed and mixed/random workloads:
> 
> * Interspersed workload (thinktime between reads): We specifically
>   tested a workload with thinktime (to simulate CPU or other work
>   between IOs). Results are essentially unchanged with the patch:
>   - Avg latency: 6.12 us -> 6.29 us
>   - Avg IOPS: 7577 -> 7571
>   - BW: 29.60 -> 29.58 MB/s
>   - These deltas are within run-to-run noise. This makes sense given the
>     wait only applies to the async portion and doesn’t block the
>     synchronous data needed by the caller.
>   Command:
>     fio --name=interspersed_work --filename=file.1G --rw=read --bs=4K \
>         --numjobs=1 --ioengine=libaio --iodepth=1 --thinktime=1000 \
>         --thinktime_blocks=8 --size=1G
> 
> * Strided workload (wasted readahead): This is a case where readahead is
>   often not fully utilized. The patch doesn’t hurt; we actually see a
>   small improvement:
>   - Avg latency: 2565.90 us -> 2561.92 us
>   - Avg IOPS: 44260 -> 44960
>   - BW: 173.0 -> 175.8 MB/s
>   Command:
>     fio --name=strided_wasted_ra --filename=file.250G --rw=read --bs=4K \
>         --zonemode=strided --zonesize=128k --zoneskip=100M --numjobs=32 \
>         --ioengine=libaio --iodepth=4 --offset_increment=1G --size=1G
> 
> * Random read stability: Also slightly better with the patch:
>   - Avg latency: 15829.10 us -> 15536.74 us
>   - Avg IOPS: 7856.6 -> 8009.2
>   - BW: 30.7 -> 31.3 MB/s
>   Command:
>     fio --name=random_read --filename=file.250G --rw=randread --bs=4K \
>         --numjobs=32 --ioengine=libaio --iodepth=4 --offset_increment=1G \
>         --size=1G
> 
>> I'm also concerned about how this would affect application-visible
>> tail latency, since congestion could take a while to clear up (eg if
>> writeback is to a remote server somewhere).
> 
> On application-visible tail latency: because the wait only happens when
> the request stream has reached the congestion limit and only async pages
> remain, there is no blocking of the “needed now” page(s) for the current
> read. So the caller’s synchronous read path latency is not delayed by
> this wait. 

I think the async readahead only means that the calling process doesn't
need to wait for the completion of the readahead IO.  Indeed the IO
submission (i.e. fuse_readahead()) is called from the sync process
context, and thus the deliberate wait in fuse_readahead() will increase
the latency of the sync read(2).

Besides, we also noticed the similar issue where the congestion
mechanism can suppress the peak bandwidth performance.  But I'm not sure
if there's better solution except from increasing the threshold to a
noticeable large value which obviously breaks the congestion mechanism :|

-- 
Thanks,
Jingbo


