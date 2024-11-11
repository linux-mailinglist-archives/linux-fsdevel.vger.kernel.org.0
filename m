Return-Path: <linux-fsdevel+bounces-34197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47C9C39AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360591F2213E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A536158853;
	Mon, 11 Nov 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ed3uhBSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B442A8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313959; cv=none; b=HGwULs4sbRLuQMc18F1ldoRSFzOQHdhB7X8QpEUTCI3eCG5PaktTAg7IYPBJvEMMJ+e/s0Oh91MNxMd8EtCzcDKtDLf5dJCG+Ht0/qIJjk9iu3png9W1eUGfnWfzelJnMt+pqkIa168Bdy4xJSJd6UqSe4C9P1fUjTRoA1m0Ecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313959; c=relaxed/simple;
	bh=LEMyKTB9HKFyfTLJiDz/fGA5Wcumtq1CY4cRoHm3QM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgOIHBt1McEv3SQEgIb6jcvh0V3ESnAdFw03HzyMZecxtjvld21EG1zy1ZPplg8yqkJyrmpo0/3fB+YjZvIgPB7ApkRUSDqkRvEi+pshrQa+7FnNs2Hvu54eT0vLcnLwUCV8LMSOgjPaFd1mWvxGh93p0m8pqMtkTdwxzXtHCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ed3uhBSy; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731313943; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WZAMxPae5+8nJ4E38SLlG5upXOWFiLLeZBjopoTsqEk=;
	b=Ed3uhBSyfilWjZovTxEn4eQ0BQxp4GH//S4KwoS1NIRpdTfwlDKHuviRrzaQGJg6Gp8dV/Zbf2iLwwLitddD3r9zQIgoU0jA1DuF2++EJ78jS7BGeJ3h+YO4LmEthM2nMpM/6OnYf/kU7UM+hyUoBCjgJT4DeTWyIgcZrG5OKxQ=
Received: from 30.221.145.166(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJ7teQf_1731313941 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 16:32:22 +0800
Message-ID: <9c0dbdac-0aed-467c-86c7-5b9a9f96d89d@linux.alibaba.com>
Date: Mon, 11 Nov 2024 16:32:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, josef@toxicpanda.com, linux-mm@kvack.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241107235614.3637221-7-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Joanne and Miklos,

On 11/8/24 7:56 AM, Joanne Koong wrote:
> Currently, we allocate and copy data to a temporary folio when
> handling writeback in order to mitigate the following deadlock scenario
> that may arise if reclaim waits on writeback to complete:
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
> 
> To work around this, we allocate a temporary folio and copy over the
> original folio to the temporary folio so that writeback can be
> immediately cleared on the original folio. This additionally requires us
> to maintain an internal rb tree to keep track of writeback state on the
> temporary folios.
> 
> A recent change prevents reclaim logic from waiting on writeback for
> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> will prevent FUSE folios from running into the reclaim deadlock described
> above) and removes the temporary folio + extra copying and the internal
> rb tree.
> 
> fio benchmarks --
> (using averages observed from 10 runs, throwing away outliers)
> 
> Setup:
> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
> 
> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
> 
>         bs =  1k          4k            1M
> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> % diff        -3%          23%         45%
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>


IIUC this patch seems to break commit
8b284dc47291daf72fe300e1138a2e7ed56f38ab ("fuse: writepages: handle same
page rewrites").

> -	/*
> -	 * Being under writeback is unlikely but possible.  For example direct
> -	 * read to an mmaped fuse file will set the page dirty twice; once when
> -	 * the pages are faulted with get_user_pages(), and then after the read
> -	 * completed.
> -	 */

In short, the target scenario is like:

```
# open a fuse file and mmap
fd1 = open("fuse-file-path", ...)
uaddr = mmap(fd1, ...)

# DIRECT read to the mmaped fuse file
fd2 = open("ext4-file-path", O_DIRECT, ...)
read(fd2, uaddr, ...)
    # get_user_pages() of uaddr, and triggers faultin
    # a_ops->dirty_folio() <--- mark PG_dirty

    # when DIRECT IO completed:
    # a_ops->dirty_folio() <--- mark PG_dirty
```

The auxiliary write request list was introduced to fix this.

I'm not sure if there's an alternative other than the auxiliary list to
fix it, e.g. calling folio_wait_writeback() in a_ops->dirty_folio() so
that the same folio won't get dirtied when the writeback has not
completed yet?



-- 
Thanks,
Jingbo

