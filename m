Return-Path: <linux-fsdevel+bounces-27361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3B3960957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9B7B2256A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1921A0715;
	Tue, 27 Aug 2024 11:53:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42819D88C;
	Tue, 27 Aug 2024 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759633; cv=none; b=Lb/dit7IRkreODSXUYeG5SFrlxfRxxiIg9+rv5rBAjlwgAicdaPPUDwzblwe1dPsI6iK/Y6EsMF5EfDUytjYQRkRpWHW+RwuaYusL0IcRtAumxnyIjpmJJKPcHabA0z/QG6S/8d04uO/AKX6ADFXM2w+zEQ7w6qceeD7H4RDoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759633; c=relaxed/simple;
	bh=lBb3SIgc7twpOvalF/i3YUyRfTYDizDSmWrUoI2E8do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeOYPSW2E2UtGuC+pJTZ1r7OQR+lkr2ck6YMbfbyCS79X3+hi/PvyluR2ojvv9NFgV60eYP4Jm5UYzIIhBa7zwPvk0CHT9PEd6jSQb9riD0gUaFZbWNYDH1OvcqUZAVCY5f6rR72OMYFEBuoEDaA523YTV9qtkJbSo2AbmYTW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtQrP4kdQzpStZ;
	Tue, 27 Aug 2024 19:52:05 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 399E0140202;
	Tue, 27 Aug 2024 19:53:46 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 19:53:45 +0800
From: yangyun <yangyun50@huawei.com>
To: <jefflexu@linux.alibaba.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lixiaokeng@huawei.com>, <miklos@szeredi.hu>, <yangyun50@huawei.com>
Subject: Re: [PATCH] fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter
Date: Tue, 27 Aug 2024 19:52:52 +0800
Message-ID: <20240827115252.3481395-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <efc65503-15fd-4f8d-a6c4-b3bacb7481cb@linux.alibaba.com>
References: <efc65503-15fd-4f8d-a6c4-b3bacb7481cb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

On Tue, Aug 27, 2024 at 04:30:04PM +0800, Jingbo Xu wrote:
> Hi Miklos,
> 
> On 8/27/24 3:12 AM, Miklos Szeredi wrote:
> > On Mon, 26 Aug 2024 at 15:07, yangyun <yangyun50@huawei.com> wrote:
> >>
> >> Commit 23c94e1cdcbf ("fuse: Switch to using async direct IO
> >> for FOPEN_DIRECT_IO") gave the async direct IO code path in the
> >> fuse_direct_read_iter() and fuse_direct_write_iter(). But since
> >> these two functions are only called under FOPEN_DIRECT_IO is set,
> >> it seems that we can also use the async direct IO even the flag
> >> IOCB_DIRECT is not set to enjoy the async direct IO method. Also
> >> move the definition of fuse_io_priv to where it is used in fuse_
> >> direct_write_iter.
> > 
> > I'm interested in the motivation for this patch.
> > 
> > There's a minor risk of regressions when introducing such a behavior
> > change, so there should also be a strong supporting argument, which
> > seems to be missing in this case.
> > 
> 
> 
> I'm not sure what yangyun's use case is, but we indeed also observed a
> potential performance optimization for FOPEN_DIRECT_IO path.  When the
> buffer IO is submitted to a file flagged with FOPEN_DIRECT_IO, the code
> path is like:
> 
> fuse_direct_read_iter
>   __fuse_direct_read
>     fuse_direct_io
>       # split the request to multiple fuse requests according to
>       # max_read and max_pages constraint, for each split request:
>         fuse_send_read
>           fuse_simple_request
> 
> When the size of the user requested IO is greater than max_read and
> max_pages constraint, it's split into multiple requests and these split
> requests can not be sent to the fuse server until the previous split
> request *completes* (since fuse_simple_request()), even when the user
> request is submitted from async IO e.g. io-uring.

The same use case. Your explanation is more explicit.

And I just don't know why commit 23c94e1cdcbf ("fuse: Switch to using async 
direct IO for FOPEN_DIRECT_IO") adds the check of IOCB_DIRECT flag when using 
async direct_io. It seems unnessary.

> 
> -- 
> Thanks,
> Jingbo

