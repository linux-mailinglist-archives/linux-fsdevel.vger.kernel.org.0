Return-Path: <linux-fsdevel+bounces-27335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB39605AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD28F1F21FAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73F19D08C;
	Tue, 27 Aug 2024 09:35:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07513B293;
	Tue, 27 Aug 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751327; cv=none; b=eprotJGy/oWoFRyA21NKkR0/8sBm0FCIGL6CFUlKYKEvgtQ8F7HaOl00OyPqwzNx1SDhjMNl2nokOh7kBVWVtHRvyezQJTOeXCgGDHOJ0yjqfxom09swfvXFeITh3FZr1VYYNgg9mBaPdUlmTiL5WHODpOCQ0A3LnsPyS3S6fHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751327; c=relaxed/simple;
	bh=/w/Ua/MGJgvSl63nVE98t9xbCFrbl8/uMQwwz5xl+oE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ma9dEkNShsBxoIqgzCd8VzzrO9Q8q9YU1pxkNyv2GrJyQ4vpDdPOR3nyfSJO6sN1P/jOIOSrldFnlgVv3GQx/WYrJg/S4XsnJD1uI6NRI34VUr6SZtOQbgoW4zCMi4Z999ZiRFztmKtQ5YCFW7PH6kEhs7Fk9rD1YFUVb3cPiU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtMnk5vFwz16PXC;
	Tue, 27 Aug 2024 17:34:34 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 98B0F1401F1;
	Tue, 27 Aug 2024 17:35:21 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 17:35:20 +0800
From: yangyun <yangyun50@huawei.com>
To: <miklos@szeredi.hu>
CC: <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lixiaokeng@huawei.com>,
	<yangyun50@huawei.com>
Subject: Re: [PATCH v2 1/2] fuse: move fuse_forget_link allocation inside fuse_queue_forget()
Date: Tue, 27 Aug 2024 17:34:26 +0800
Message-ID: <20240827093426.3397154-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAJfpegsFvE-oSaYqNWBAdiXnBYWGAp+Lc8cjL3BWs9bd+O_c2A@mail.gmail.com>
References: <CAJfpegsFvE-oSaYqNWBAdiXnBYWGAp+Lc8cjL3BWs9bd+O_c2A@mail.gmail.com>
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

On Mon, Aug 26, 2024 at 09:24:22PM +0200, Miklos Szeredi wrote:
> On Sat, 24 Aug 2024 at 11:26, yangyun <yangyun50@huawei.com> wrote:
> >
> > The `struct fuse_forget_link` is allocated outside `fuse_queue_forget()`
> > before this patch. This requires the allocation in advance. In some
> > cases, this struct is not needed but allocated, which contributes to
> > memory usage and performance degradation. Besides, this messes up the
> > code to some extent. So move the `fuse_forget_link` allocation inside
> > fuse_queue_forget with __GFP_NOFAIL.
> >
> > `fuse_force_forget()` is used by `readdirplus` before this patch for
> > the reason that we do not know how many 'fuse_forget_link' structures
> > will be allocated in advance when error happens. After this patch, this
> > function is not needed any more and can be removed. By this way, all
> > FUSE_FORGET requests are sent by using `fuse_queue_forget()` function as
> > e.g. virtiofs handles them differently from regular requests.
> 
> The patch is nice and clean.  However, I'm a bit worried about the
> inode eviction path, which can be triggered from memory reclaim.
> Allocating a small structure shouldn't be an issue, yet I feel that
> the old way of preallocating it on inode creation should be better.
> 
> What do you think?
You are right. Since flag __GFP_NOFAIL would block the system, especailly in 
the memeory reclaim situaion. The preallocating of this struct is necessary
because it will be exactly used in the inode eviction path. I'm sorry for not 
considering the risk of __GFP_NOFAIL seriously as a beginner.

Thanks for the reminder. Update soon.
> 
> Thanks,
> Miklos

