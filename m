Return-Path: <linux-fsdevel+bounces-34000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254099C185D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 09:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32E0B236CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959611DFE0D;
	Fri,  8 Nov 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hc+AwEC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676781D07B1
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055748; cv=none; b=d2V82zywJA8R18fBPuaSGuTOYWSZOfMtc5ZFmGg3wmTnJvt5OHNDZFdZun3nYSpowb5DvE2oSMX+QIPtAcbfpRrSxj+c4ntv9DotToiKuTVotGL+Ao3FV4Ar60uQh5z8JC9HMHSUP3PsdAh0kP/1Tm/YVZMGtSqpCfGgt7rtZ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055748; c=relaxed/simple;
	bh=5TyKPr+swpwFihU4aerzLBv9qOtyJF/A0BS8a3kxGvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQr91EBpm8uLcw4fiDphT+RTX98xzJc20vvFkRVHDrORFR3Cif3qrStU/1kpcwojl+RyBgVnoyoQjN9rzEmzYEUdrDDwwdgQRL5J6eorv/S5Aye77z6qmR9UI33aZENPW4Jkn900me7CIV6yIa+Z/fTibO7xdUXZvfQFlJbdibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hc+AwEC+; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731055738; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KSjHF3Tnqu0fgSjAhgyHb1YKD87k6mfwyDJl3JsdIII=;
	b=hc+AwEC+tpb2Dl23UJktGKuZ20qSBsjaX97NaWJDYnOQz5fB0jV1ioEwseSRDQJbtle6FQNJREsjWfEN2l2OcA40HvA2SU5ZpzwR5X/jVfKf/aIHV3HOlyX4pQ4oogB0WjMsU4GGQyJ/IdbsyhUXd1aioChEBrApKBa7KZNxIzY=
Received: from 30.221.145.86(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WIzTmZz_1731055736 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 16:48:57 +0800
Message-ID: <1b3a36fe-1f62-410c-97fa-d59e7385f683@linux.alibaba.com>
Date: Fri, 8 Nov 2024 16:48:55 +0800
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

Hi, Joanne,

Thanks for the continuing work!

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


> @@ -1622,7 +1543,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  			return res;
>  		}
>  	}
> -	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> +	if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {

filemap_range_has_writeback() is not equivalent to
fuse_range_is_writeback(), as it will return true as long as there's any
locked or dirty page?  I can't find an equivalent helper function at
hand though.



> @@ -3423,7 +3143,6 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  	fi->iocachectr = 0;
>  	init_waitqueue_head(&fi->page_waitq);
>  	init_waitqueue_head(&fi->direct_io_waitq);
> -	fi->writepages = RB_ROOT;

It seems that 'struct rb_root writepages' is not removed from fuse_inode
structure.


Besides, I also looked through the former 5 patches and can't find any
obvious errors at the very first glance.  Hopefully the MM guys could
offer more professional reviews.

-- 
Thanks,
Jingbo

