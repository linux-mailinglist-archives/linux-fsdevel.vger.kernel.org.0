Return-Path: <linux-fsdevel+bounces-35794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855BB9D86C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBF285E8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A01AC8B9;
	Mon, 25 Nov 2024 13:44:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FED1ABECD;
	Mon, 25 Nov 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542289; cv=none; b=LaSq6LardekRkfWXkEK4ohKRoc+nYdFEkK1Ax6DAyOzF39R7GAm3hyx6uIP25QKhr7cAZXk4UPVA+4Np7kMyJPz/nEbv4IiKgBJ2bwXGqlDubxmCHCaE7tJOe6gndQ4M23jtu6NeZ7G5GjqZP2N10V3S7NOlE3MJgkvPME4TLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542289; c=relaxed/simple;
	bh=pXWrfgPtUiMGaYO4YxKycoWEXFfEFi5SD0iAfeDGyo0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHsRKWmQT2HfLjaIqYUyODovQglzHAllZK6sTLJQZF97onjM+7rKvwaBBGam2bflU67YHg/3Pvi7uQd2Hebku3opdyzScZJkRo39pLd9+z8jNV+h9XLwOgNnEO+i3m4Ig//Vi2Y1XLAaolsxZ78cvxESi6R1kBc8yMkaMkber9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xxn364h4czRhn5;
	Mon, 25 Nov 2024 21:43:14 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 91548180105;
	Mon, 25 Nov 2024 21:44:42 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 21:44:42 +0800
Date: Mon, 25 Nov 2024 21:42:48 +0800
From: Long Li <leo.lilong@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
CC: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH v4 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0R-2Jmj2u-Cqwxu@localhost.localdomain>
References: <20241125023341.2816630-1-leo.lilong@huawei.com>
 <Z0Qb1HKqWJKyR5Q0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Z0Qb1HKqWJKyR5Q0@infradead.org>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Sun, Nov 24, 2024 at 10:40:20PM -0800, Christoph Hellwig wrote:
> On Mon, Nov 25, 2024 at 10:33:40AM +0800, Long Li wrote:
> >   1. collect reviewed tag
> >   2. Modify the comment of io_size and iomap_ioend_size_aligned().
> >   3. Add explain of iomap_ioend_size_aligned() to commit message.
> 
> Just curious, did you look into Brian's suggestions to do away
> with the rounding up entirely as there is not much practical benefit
> in merging behind EOF?
> 
> 

I agree with Brian's point. The scenarios where rounding up io_size
enables ioend merging are quite rare, so the practical benefits are
limited, though such cases can still exist. Therefore, I think both
approaches are acceptable as there doesn't seem to be a significant
difference between them. 

Thanks,
Long Li

