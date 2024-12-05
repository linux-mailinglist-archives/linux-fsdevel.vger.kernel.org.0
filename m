Return-Path: <linux-fsdevel+bounces-36532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA719E55D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237F3288BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2A218AB5;
	Thu,  5 Dec 2024 12:49:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E1217F44;
	Thu,  5 Dec 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402988; cv=none; b=cpZ/t6im/eQE/V+LSWzBBwhWQJwpVTmQqHYTvQ06GAJSyIMqQdHbz1AZg8faiN7zE4wm8qAQd4DikGmq83zS5hnuGEW/ojOKTlJQ/DfU9MeMzAyPjgX3Njx0aA2/anSH/sYmvQKkXbaGBbcblukOgMXB4r7s6o8TVetYA4+N7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402988; c=relaxed/simple;
	bh=ztQaMevTiuALqQ+P4Iy/ReRe4nh9ictWYShpbeEF36I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB1yaLebmL+eJ/a9zI8UV6yZTYbx0md5g5G98L0Z9cv5G6mjy86IcHtAZeRwuPEvOHZ44wrCL/plEXdqY48s5Deu/8mnu3sKGbSEgXf6/McJSsyB0snZoCAZLvB9PrrxE75zgth5JzQari5DL3lvlAhoo9JHuTD8otK+iqBjHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y3vL34t72z2Fb4H;
	Thu,  5 Dec 2024 20:47:23 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id E3AC91402C4;
	Thu,  5 Dec 2024 20:49:41 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Dec
 2024 20:49:41 +0800
Date: Thu, 5 Dec 2024 20:47:14 +0800
From: Long Li <leo.lilong@huawei.com>
To: Brian Foster <bfoster@redhat.com>
CC: Dave Chinner <david@fromorbit.com>, <brauner@kernel.org>,
	<djwong@kernel.org>, <cem@kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z1Gg0pAa54MoeYME@localhost.localdomain>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
 <Z03RlpfdJgsJ_glO@bfoster>
 <Z05oJqT7983ifKqv@dread.disaster.area>
 <Z1AaPNoN_z5EQxFQ@localhost.localdomain>
 <Z1BIab8G3KmXuyfS@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Z1BIab8G3KmXuyfS@bfoster>
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Wed, Dec 04, 2024 at 07:17:45AM -0500, Brian Foster wrote:
> > Coming back to our current issue, during writeback mapping, we sample
> > the inode size to determine if the ioend is within EOF and attempt to
> > trim io_size. Concurrent truncate operations may update the inode size,
> > causing the pos of write back beyond EOF. In such cases, we simply don't
> > trim io_size, which seems like a viable approach.
> > 
> 
> Perhaps. I'm not claiming it isn't functional. But to Dave's (more
> elaborated) point and in light of the racy i_size issue you've
> uncovered, what bugs me also about this is that this creates an internal
> inconsistency in the submission codepath.
> 
> I.e., the top level code does one thing based on one value of i_size,
> then the ioend construction does another, and the logic is not directly
> correlated so there is no real guarantee changes in one area correlate
> to the other. IME, this increases potential for future bugs and adds
> maintenance burden.
> 
> A simple example to consider might be.. suppose sometime in the future
> we determine there is a selective case where we do want to allow a
> post-eof writeback. As of right now, all that really requires is
> adjustment to the "handle_eof()" logic and the rest of the codepath does
> the right thing agnostic to outside operations like truncate. I think
> there's value if we can preserve that invariant going forward.
> 
> FWIW, I'm not objecting to the alternative if something in the above
> reasoning is wrong. I'm just trying to prioritize keeping things simple
> and maintainable, particularly since truncate is kind of a complicated
> beast as it is.
> 
> Brian
> 

Yes, I agree with you, thanks for the detailed explanation.

Thanks,
Long Li

