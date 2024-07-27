Return-Path: <linux-fsdevel+bounces-24363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B993DEA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 12:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A44A1F2256D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12B55E4C;
	Sat, 27 Jul 2024 10:06:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCB1B86CD;
	Sat, 27 Jul 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074766; cv=none; b=abfXb9iUmlKGX4nCgdFoiGKTWjp0VH9j2hT4VnQRj6AQ1KBQi5uakX907VgwrelkLI59CXRUYFGU/54RNlvjimEtAda8XkWukK4ekJCFZ2oVKlmOfJJDWi1mKpGx+03C9/HHCVyTJtlQBjRrCbSezB1OXu01Tx9tv3AY2jxiVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074766; c=relaxed/simple;
	bh=rQv9vUbv9mOJz1kZVWzTih/cKYHLOLRxmzsuocw9ccI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQtByJmO6iq3YklQ9TVo/b+vuhz+9GnzdHsEeSAYuM+xZpFdbUyvKamQ2bSUYxQqG/pEta9aK9q/PBc1ieOHXz4hA9YT1diD3ww9X29EBs0voOw3XQHMyFuVh9iME8UDlA6vHJOn2/uRVARG+vTnrf8gqmXCJl2qtmKuse5Qq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WWKxH3k6WzncVF;
	Sat, 27 Jul 2024 18:05:07 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id CEEBE1400DD;
	Sat, 27 Jul 2024 18:06:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 27 Jul
 2024 18:06:00 +0800
From: yangyun <yangyun50@huawei.com>
To: <josef@toxicpanda.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<miklos@szeredi.hu>, <yangyun50@huawei.com>
Subject: Re: [PATCH 1/2] fuse: replace fuse_queue_forget with fuse_force_forget if error
Date: Sat, 27 Jul 2024 18:05:56 +0800
Message-ID: <20240727100556.1225580-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240726153908.GD3432726@perftesting>
References: <20240726153908.GD3432726@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100024.china.huawei.com (7.221.188.41)


Hi Josef,

Thanks for the comment.


On Fri, Jul 26, 2024 at 11:39:08AM -0400, Josef Bacik wrote:
> On Fri, Jul 26, 2024 at 04:37:51PM +0800, yangyun wrote:
> > Most usecases for 'fuse_queue_forget' in the code are about reverting
> > the lookup count when error happens, except 'fuse_evict_inode' and
> > 'fuse_cleanup_submount_lookup'. Even if there are no errors, it
> > still needs alloc 'struct fuse_forget_link'. It is useless, which
> > contributes to performance degradation and code mess to some extent.
> > 
> > 'fuse_force_forget' does not need allocate 'struct fuse_forget_link'in
> > advance, and is only used by readdirplus before this patch for the reason
> > that we do not know how many 'fuse_forget_link' structures will be
> > allocated when error happens.
> > 
> > Signed-off-by: yangyun <yangyun50@huawei.com>
> 
> Forcing file systems to have their forget suddenly be synchronous in a lot of
> cases is going to be a perf regression for them.

Sorry for that I didn't notice that 'fuse_force_forget' is synchronous. Actually,
I'm not on purpose to make forget be synchronous, just want to reuse the already 
known function 'fuse_force_forget' to avoid useless memory alloc in some cases.

And thank you for the reminder regarding the performance impact of synchronization.

> 
> In some of these cases a synchronous forget is probably ok, as you say a lot of
> them are error cases.  However d_revalidate() isn't.  That's us trying to figure
> out if what we have in cache matches the file systems view of the inode, and if
> it doesn't we're going to do a re-lookup, so we don't necessarily care for a
> synchronous forget in this case.  Think of an NFS fuse client where the file got
> renamed on the backend and now we're telling the kernel this is the inode we
> have.  Forcing us to do a synchronous response now is going to be much more
> performance impacting than it was pre-this patch.

Yeah, this is definitely a performance impacting case. Thank for your adivce.

> 
> A better approach would be to make the allocation optional based on the
> ->no_forget flag.  Thanks,

The reason that I don't make the allocataion optional is that even the no_forget flag
is disabled, there are still many useless memory allocations if no errors. And The code
is also a bit messy because of those allocations.

Since forget is not necessarily synchronous (In my opinion, the pre-this patch use of 
synchronous 'fuse_force_forget' is an error case and also not necessarily synchronous), 
what about just changing the 'fuse_force_forget' to be asynchronous?

By this way, all the forget requests are asynchronous (less impact on performance) and 
we doesn't need to allocate useless memory in advance. 

> 
> Josef

Thank you once again for your time and advice.

