Return-Path: <linux-fsdevel+bounces-36618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE109E6B13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 10:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465951882A83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221B1F12F9;
	Fri,  6 Dec 2024 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gar5MRdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B01EF0A9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478637; cv=none; b=SFqCfdyQ8JAJ70QwDbq1wiY6A9qJ3Sgu60k+NDEZE6PKud8jvKOt3oDJ9NmdLkGDEpykwanGJgM/aEPPi2mhPemWfiSS+eo2/vZKVmD+HlmcXW5Wk8RdVR+vQuFLFphLMVlD9Qd/ae4y177QE/dBT9FveVNiHfxioanaiohxwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478637; c=relaxed/simple;
	bh=IbXOTwnyyJC0Ah9t978M5+LfWTP62MkrRKfypmMdkpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0poFg40JJWv0nnjPQvkfwXhZF8ScqJ9xv9uDBhAVLiGKPpymJwnmhaYRIvlWM6ldWJi/+Q1VrolU18b6E3RGs7Do6P6er0FBUECfdqSAbFIrGgTNabd6WLM9aS+m+wwGXaFDENyPKAYWuNuPVaU83+e1zANJXpF2rFglTacA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gar5MRdd; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733478626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gr/cxspBvRm4bJpAZw0ah70DQs96Z00PGv5GujYYQVk=;
	b=gar5MRddJK96WjolAUQat4Uo/GMfTCXmUG4p/eOrCzar1sAQBLFxtnZUFvv6FBcmvLvcS9+jNAfbZa1vJ0bYJjkMnx/1xXY4AQFLFip3lhBhFqUGL6FswLehGag9cvCveE48+tCFBDEHI1ihXvcsOzcjcnWtSgX5vUIqM9Rg/0k=
Received: from 30.221.145.242(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WKwD2KA_1733478624 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 17:50:25 +0800
Message-ID: <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com>
Date: Fri, 6 Dec 2024 17:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] fuse: support large folios
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, willy@infradead.org,
 shakeel.butt@linux.dev, kernel-team@meta.com
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

Have no checked the whole series yet, but I just spent some time on the
testing, attempting to find some statistics on the performance improvement.

At least we need:

@@ -2212,7 +2213,7 @@ static int fuse_write_begin(struct file *file,
struct address_space *mapping,

        WARN_ON(!fc->writeback_cache);

-       folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+       folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN |
fgf_set_order(len),

Otherwise the large folio is not enabled on the buffer write path.


Besides, when applying the above diff, the large folio is indeed enabled
but it suffers severe performance regression:

fio 1 job buffer write:
2GB/s BW w/o large folio, and 200MB/s BW w/ large folio

Have not figured it out yet.


On 11/26/24 6:05 AM, Joanne Koong wrote:
> This patchset adds support for folios larger than one page size in FUSE.
> 
> This patchset is rebased on top of the (unmerged) patchset that removes temp
> folios in writeback [1]. (There is also a version of this patchset that is
> independent from that change, but that version has two additional patches
> needed to account for temp folios and temp folio copying, which may require
> some debate to get the API right for as these two patches add generic
> (non-FUSE) helpers. For simplicity's sake for now, I sent out this patchset
> version rebased on top of the patchset that removes temp pages)
> 
> This patchset was tested by running it through fstests on passthrough_hp.
> 
> Benchmarks show roughly a ~45% improvement in read throughput.
> 
> Benchmark setup:
> 
> -- Set up server --
>  ./libfuse/build/example/passthrough_hp --bypass-rw=1 ~/libfuse
> ~/mounts/fuse/ --nopassthrough
> (using libfuse patched with https://github.com/libfuse/libfuse/pull/807)
> 
> -- Run fio --
>  fio --name=read --ioengine=sync --rw=read --bs=1M --size=1G
> --numjobs=2 --ramp_time=30 --group_reporting=1
> --directory=mounts/fuse/
> 
> Machine 1:
>     No large folios:     ~4400 MiB/s
>     Large folios:        ~7100 MiB/s
> 
> Machine 2:
>     No large folios:     ~3700 MiB/s
>     Large folios:        ~6400 MiB/s
> 
> Writes are still effectively one page size. Benchmarks showed that trying to get
> the largest folios possible from __filemap_get_folio() is an over-optimization
> and ends up being significantly more expensive. Fine-tuning for the optimal
> order size for the __filemap_get_folio() calls can be done in a future patchset.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoong@gmail.com/
> 
> Changelog:
> v1: https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joannelkoong@gmail.com/
> v1 -> v2:
> * Change naming from "non-writeback write" to "writethrough write"
> * Fix deadlock for writethrough writes by calling fault_in_iov_iter_readable() first
>   before __filemap_get_folio() (Josef)
> * For readahead, retain original folio_size() for descs.length (Josef)
> * Use folio_zero_range() api in fuse_copy_folio() (Josef)
> * Add Josef's reviewed-bys
> 
> Joanne Koong (12):
>   fuse: support copying large folios
>   fuse: support large folios for retrieves
>   fuse: refactor fuse_fill_write_pages()
>   fuse: support large folios for writethrough writes
>   fuse: support large folios for folio reads
>   fuse: support large folios for symlinks
>   fuse: support large folios for stores
>   fuse: support large folios for queued writes
>   fuse: support large folios for readahead
>   fuse: support large folios for direct io
>   fuse: support large folios for writeback
>   fuse: enable large folios
> 
>  fs/fuse/dev.c  | 128 ++++++++++++++++++++++++-------------------------
>  fs/fuse/dir.c  |   8 ++--
>  fs/fuse/file.c | 126 +++++++++++++++++++++++++++++++-----------------
>  3 files changed, 149 insertions(+), 113 deletions(-)
> 

-- 
Thanks,
Jingbo

