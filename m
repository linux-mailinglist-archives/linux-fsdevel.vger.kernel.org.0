Return-Path: <linux-fsdevel+bounces-63276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBCBB3CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509513A62C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827630FC3B;
	Thu,  2 Oct 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wwF2dHn4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FC2797AF;
	Thu,  2 Oct 2025 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405369; cv=none; b=pQYuynUYaZEX8QHtvpPwvAG132SQN53vrGa6725Ah2lj+IPQaZWPGk/9fK/VsLQpu1bU59VMyedN/A1xyiHsV1H5+j5Om8Kj2SZYtKqcFMf/j3GV8l6opgEhSxf46muk918yl7O45vnQl95Hw2ZzL1Ybaz14ZK9xI0UF67K0JYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405369; c=relaxed/simple;
	bh=zSH9797fJ78xiisbHGjTWoEbZLjtnPdnxj+9risSCs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP15osQdDp1aueLfcdJMjx9wgoTDNr2AK1xb9j+uDnuPPi0A3K3rSULrwW7TKuy8e79YwBsAwjkDOxMy6zr6FhNdJ2LtjEOChU9qKq3zPgxvOzzxa59Nipu2vx3bbgeMo5/zQHzPRd4Ui+6XZ2juSGiVizc+u7QY87cJg/ZQsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wwF2dHn4; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759405357; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yfqJW3Keyz7btvmQhBVyThI19zXN+mtr///MNA4fQb4=;
	b=wwF2dHn4fBTG7oib9ikM7uA5N79XM2sSWc47LkzqoYjupQnZyned4VjIvoBfauopXCvA1TP6Y3wqWOkkWilVexuQMxUZ9DP8JAjh+l8kXtUIHiTv1U3krumVixKlSdpoOXtnS5gqrnk4vZd3aawvMsazyqrSK+mOiz2/vH1rVdk=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpHqq9F_1759405355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Oct 2025 19:42:36 +0800
Message-ID: <4a152e1b-c468-4fbf-ac0b-dbb76fa1e2ac@linux.alibaba.com>
Date: Thu, 2 Oct 2025 19:42:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ext4: fix an data corruption issue in nojournal mode
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ted,

On 2025/9/16 17:33, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Hello!
> 
> This series fixes an data corruption issue reported by Gao Xiang in
> nojournal mode. The problem is happened after a metadata block is freed,
> it can be immediately reallocated as a data block. However, the metadata
> on this block may still be in the process of being written back, which
> means the new data in this block could potentially be overwritten by the
> stale metadata and trigger a data corruption issue. Please see below
> discussion with Jan for more details:
> 
>    https://lore.kernel.org/linux-ext4/a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com/
> 
> Patch 1 strengthens the same case in ordered journal mode, theoretically
> preventing the occurrence of stale data issues.
> Patch 2 fix this issue in nojournal mode.

It seems this series is not applied, is it ignored?

When ext4 nojournal mode is used, it is actually a very
serious bug since data corruption can happen very easily
in specific conditions (we actually have a specific
environment which can reproduce the issue very quickly)

Also it seems AWS folks reported this issue years ago
(2021), the phenomenon was almost the same, but the issue
still exists until now:
https://lore.kernel.org/linux-ext4/20211108173520.xp6xphodfhcen2sy@u87e72aa3c6c25c.ant.amazon.com/

Some of our internal businesses actually rely on EXT4
no_journal mode and when they upgrade the kernel from
4.19 to 5.10, they actually read corrupted data after
page cache memory is reclaimed (actually the on-disk
data was corrupted even earlier).

So personally I wonder what's the current status of
EXT4 no_journal mode since this issue has been existing
for more than 5 years but some people may need
an extent-enabled ext2 so they selected this mode.

We already released an announcement to advise customers
not using no_journal mode because it seems lack of
enough maintainence (yet many end users are interested
in this mode):
https://www.alibabacloud.com/help/en/alinux/support/data-corruption-risk-and-solution-in-ext4-nojounral-mode

Thanks,
Gao Xiang

> 
> Regards,
> Yi.
> 
> Zhang Yi (2):
>    jbd2: ensure that all ongoing I/O complete before freeing blocks
>    ext4: wait for ongoing I/O to complete before freeing blocks
> 
>   fs/ext4/ext4_jbd2.c   | 11 +++++++++--
>   fs/jbd2/transaction.c | 13 +++++++++----
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 


