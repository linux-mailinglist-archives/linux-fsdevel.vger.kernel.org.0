Return-Path: <linux-fsdevel+bounces-27359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF61960925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48584280FA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875F1A01B6;
	Tue, 27 Aug 2024 11:42:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DD19EED8;
	Tue, 27 Aug 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758964; cv=none; b=DaBo5JZgf46musTu0GNsoM9MX+2f5f9ezSe8pZNuo61nnCRO18Do6mwLkeww0YlpcxD05zBmXEa6QHp1QmVfoZfqYey4+KSwQQFLh97vDzExeB81dkJizscwHPLzqUMC5JbnNARaA2dXDIYaiqkxVZd4paOjUhTYRpTtvuPkwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758964; c=relaxed/simple;
	bh=dPe8DbtxerYaaq8xecDoFTNyrI561S8eGoHGxCwKKGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usqiJ1WgWXWuKGWgCJU7kYBCqzeXt6Jn5DOG66Gl7gI9zGjoCstiqnqkKs0c8ITn2B4cgy7Yd2GPiyY97P942pkT+1tnVJy9Ch0ysfHYXKOARLidby6YTaDvBaKQcvn4Yws9k4UBwp8WmLow9Vuk4pBtGgBFFtd8Q4zjnpxADw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtQcd5HGQzyQYJ;
	Tue, 27 Aug 2024 19:41:53 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id E3F4F18007C;
	Tue, 27 Aug 2024 19:42:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 19:42:40 +0800
From: yangyun <yangyun50@huawei.com>
To: <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lixiaokeng@huawei.com>, <yangyun50@huawei.com>
Subject: Re:[PATCH] fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter
Date: Tue, 27 Aug 2024 19:41:46 +0800
Message-ID: <20240827114146.3474592-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAJfpegt_P=Dj-CXnbZYK+XZW8ZwNH0_Str30q9vub0o00UMuWQ@mail.gmail.com>
References: <CAJfpegt_P=Dj-CXnbZYK+XZW8ZwNH0_Str30q9vub0o00UMuWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100024.china.huawei.com (7.221.188.41)

On Mon, Aug 26, 2024 at 09:12:39PM +0200, Miklos Szeredi wrote:
> On Mon, 26 Aug 2024 at 15:07, yangyun <yangyun50@huawei.com> wrote:
> >
> > Commit 23c94e1cdcbf ("fuse: Switch to using async direct IO
> > for FOPEN_DIRECT_IO") gave the async direct IO code path in the
> > fuse_direct_read_iter() and fuse_direct_write_iter(). But since
> > these two functions are only called under FOPEN_DIRECT_IO is set,
> > it seems that we can also use the async direct IO even the flag
> > IOCB_DIRECT is not set to enjoy the async direct IO method. Also
> > move the definition of fuse_io_priv to where it is used in fuse_
> > direct_write_iter.
> 
> I'm interested in the motivation for this patch.
> 
> There's a minor risk of regressions when introducing such a behavior
> change, so there should also be a strong supporting argument, which
> seems to be missing in this case.

Thanks for your reply!

It seems that there is a risk of regressions. But I think adding an argument 
in this case is not so graceful, whatever adding this argument to the 
`struct fuse_file->open_flags` or adding it to the init flags in `struct 
fuse_init_args`.

The reasons are:

1. Commit 23c94e1cdcbf ("fuse: Switch to using async direct IO for FOPEN_DIRECT_IO") 
also changes the behavior from sync to async direct io, but does not import a new 
argument to avoid the risk of regressions.

2. Fuse already has an init flags FUSE_ASYNC_DIO in `fuse_init_args`, which indicates
that the direct io should be submitted asynchrounously. The comment in function 
`fuse_direct_IO()` also indicates the situation:
"
      /*   
         * By default, we want to optimize all I/Os with async request
         * submission to the client filesystem if supported.
         */
"
But the code does not go through the async direct io code path in the case described in current patch.

3. If adding a argument, it would be so many arguments about async and direct io (FUSE_ASYNC_DIO, 
FUSE_ASYNC_READ, FOPEN_DIRECT_IO, etc), which may be redundant and confuse the developers about 
their differences.

What do you think ? 

> 
> Thanks,
> Miklos

