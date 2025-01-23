Return-Path: <linux-fsdevel+bounces-39888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417F9A19C2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749E77A44F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762101C2BD;
	Thu, 23 Jan 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oVIv/CQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04B1805A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595476; cv=none; b=tV7A/tnorc+1OVnTPfzUFc4fPJMVDkIP4kQueFBQCsb6MnVs1ygxCN95F3ovaKdYJzylrL3bVJsgvaBkYmCy1fT8rEC+hZT3DKq5k5PmI0Tul/6E8pePGUl/9/3BW4j6PUVwd41qAkcyGFOvqh9SqQwAM+JYQPck5LcCD07cdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595476; c=relaxed/simple;
	bh=V9uqSNRBgyQX0zzdPjRdJ60HRm0wStI4onI9OmOTI6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqg/RaksPQE/XlsmCQkTE5DlNWRhiR6ViuBv7ydX8pbiYJFmR95KRxlzkussrWmbXV0dl9z0i1/4D91XI2Od0H8cIAb7vSSAQoflm6PmzAOXduqHJ7uXlTyonj7/9NkY/dgISonr++TBMil+JrklMxdgTGusrTIGX705I9SNm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oVIv/CQx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737595467; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8JOjcv31AzQsNF8SwSAz4bMvJ9ueePL7wgmYiMDSRqc=;
	b=oVIv/CQxKaPnjBureWo01AFCnMyaswKYhtiWF5rFWiFBZNxIgJcNcoe7dFEoj+yzYGcJUY1JgNIn41gOIe8Ejk9QuVg483bTEUhfSFBw/Iw3i8IuBNKq3owTKf3mA/py4MJ9DdC7W3LnGyFqC8xgojUw0HZdb5ERHg5Lp3cXPI0=
Received: from 30.221.144.200(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WO9sosD_1737595463 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 09:24:26 +0800
Message-ID: <ff59b715-efa7-4ede-8f82-313af11c51f2@linux.alibaba.com>
Date: Thu, 23 Jan 2025 09:24:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] fuse: support large folios
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, willy@infradead.org,
 shakeel.butt@linux.dev, jlayton@kernel.org, kernel-team@meta.com
References: <20241213221818.322371-1-joannelkoong@gmail.com>
 <CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/25 7:23 AM, Joanne Koong wrote:
> On Fri, Dec 13, 2024 at 2:23 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> This patchset adds support for folios larger than one page size in FUSE.
>>
>> This patchset is rebased on top of the (unmerged) patchset that removes temp
>> folios in writeback [1]. This patchset was tested by running it through fstests
>> on passthrough_hp.
>>
>> Please note that writes are still effectively one page size. Larger writes can
>> be enabled by setting the order on the fgp flag passed in to __filemap_get_folio()
>> but benchmarks show this significantly degrades performance. More investigation
>> needs to be done into this. As such, buffered writes will be optimized in a
>> future patchset.
>>
>> Benchmarks show roughly a ~45% improvement in read throughput.
>>
>> Benchmark setup:
>>
>> -- Set up server --
>>  ./libfuse/build/example/passthrough_hp --bypass-rw=1 ~/libfuse
>> ~/mounts/fuse/ --nopassthrough
>> (using libfuse patched with https://github.com/libfuse/libfuse/pull/807)
>>
>> -- Run fio --
>>  fio --name=read --ioengine=sync --rw=read --bs=1M --size=1G
>> --numjobs=2 --ramp_time=30 --group_reporting=1
>> --directory=mounts/fuse/
>>
>> Machine 1:
>>     No large folios:     ~4400 MiB/s
>>     Large folios:        ~7100 MiB/s
>>
>> Machine 2:
>>     No large folios:     ~3700 MiB/s
>>     Large folios:        ~6400 MiB/s
>>
>>
>> [1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/
>>
> 
> A couple of updates on this:
> * I'm going to remove the writeback patch (patch 11/12) in this series
> and resubmit, and leave large folios writeback to be done as a
> separate future patchset. Getting writeback to work with large folios
> has a dependency on [1], which unfortunately does not look like it'll
> be resolved anytime soon. If we cannot remove tmp pages, then we'll
> likely need to use a different data structure than the rb tree to
> account for large folios w/ tmp pages. I believe we can still enable
> large folios overall even without large folios writeback, as even with
> the inode->i_mapping set to a large folio order range, writeback will
> still only operate on 4k folios until fgf_set_order() is explicitly
> set in fuse_write_begin() for the __filemap_get_folio() call.
> 
> * There's a discussion here [2] about perf degradation for writeback
> writes on large folios due to writeback throttling when balancing
> dirty pages. This is due to fuse enabling bdi strictlimit. More
> experimentation will be needed to figure out what a good folio order
> is, and whether it's possible to do something like remove the
> strictlimit for privileged servers.

FYI the sysadmin can already disable strictlimit for FUSE through
/sys/class/bdi/<bdi>/strict_limit knob[*].

[*] https://lore.kernel.org/all/20221119005215.3052436-1-shr@devkernel.io/

-- 
Thanks,
Jingbo

