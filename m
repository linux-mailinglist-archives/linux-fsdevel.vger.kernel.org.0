Return-Path: <linux-fsdevel+bounces-35870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AB29D91FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 07:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69229B2446C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F94185935;
	Tue, 26 Nov 2024 06:55:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A51A260;
	Tue, 26 Nov 2024 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604147; cv=none; b=qqmn+BOL/i/Fxt7yveKNTDLWQQoTzprZrBNNswuJsKbGy3XLJlxP5vuFm6bzfXqRBq7g6ZtEoO7GYY19qJqIdHmtZYZNrKZTfRmg8EV6fj/r1oVK/j2m0wYoV73Sw/m/PvNbD3C6XdOOrOHjJOvawfDsHZBRlRCDmu7WnkX0ABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604147; c=relaxed/simple;
	bh=q687nhoBX4SCVayJCg7rK/GY+IYLXQ86kdUrh+gr95c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAm/1/XAe0a8Gx7NM0TIu3keYAphhe/n+cZYnoKduG/Cg1xxGNolVd06k63BWN+P0vhYhHuhBkORtu7f7Ak9mDRzIXS+Yn4nMZ/PFPYg7iMGX10JgwqoctfMKciYWJE+YoZd3UaO5Bn6Ryrtdli5eqBbmYe4d9YE7GFzkj9KfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XyCwH4r8XzqSpT;
	Tue, 26 Nov 2024 14:53:51 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id DCB8C1401F4;
	Tue, 26 Nov 2024 14:55:41 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 14:55:41 +0800
Date: Tue, 26 Nov 2024 14:53:45 +0800
From: Long Li <leo.lilong@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
CC: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH v4 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0Vwed_tGNAC-adv@localhost.localdomain>
References: <20241125023341.2816630-1-leo.lilong@huawei.com>
 <Z0Qb1HKqWJKyR5Q0@infradead.org>
 <Z0R-2Jmj2u-Cqwxu@localhost.localdomain>
 <Z0VqmgQisdDxlSAy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Z0VqmgQisdDxlSAy@infradead.org>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Mon, Nov 25, 2024 at 10:28:42PM -0800, Christoph Hellwig wrote:
> On Mon, Nov 25, 2024 at 09:42:48PM +0800, Long Li wrote:
> > I agree with Brian's point. The scenarios where rounding up io_size
> > enables ioend merging are quite rare, so the practical benefits are
> > limited, though such cases can still exist. Therefore, I think both
> > approaches are acceptable as there doesn't seem to be a significant
> > difference between them. 
> 
> Given that not rounding and using the unaligned value should be
> a lot simpler, can you give it a try?
> 

Okay, so let me send a new version and change it.

Thanks,
Long Li

