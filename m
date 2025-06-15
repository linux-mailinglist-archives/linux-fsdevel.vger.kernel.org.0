Return-Path: <linux-fsdevel+bounces-51683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B829DADA11A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 07:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECD43B4AE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026C25A341;
	Sun, 15 Jun 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O2l169Gg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59E7E1;
	Sun, 15 Jun 2025 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749966613; cv=none; b=jdSpn4D91CeemdoVDvp7i3oebFQNT366dHfWHt+yFmE7FrwH5OCY/uF1thTeNA0n2ADzN1BQekG7TEQjJLtw78xLEgma9wGB/GDW8lfoLBpdDubYd/qwNbfv803vKs272T0GvykuAlH3BN7zpAdiOcdN5NZh/PjkYRakA2Cp1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749966613; c=relaxed/simple;
	bh=0sG3u+/kAiEi66k1JGx0jpD/hbBUrdPtzjK1IF4nVu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uap1FJruaKEz5zVx8PbcqWp/eee10/XLbBMoy1EOYTv2bCPh4QiwBhT1rT28n3t3qNUZrBox9c2C5hiaE4J8IMaz3yRDQ1/yXtd9CKoKQ5h4I6DclafauDynSMX9EGuFiVv3AXDlEt9G+4BJUaQvXCVxTFpKx8q0xLny3W5pBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O2l169Gg; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749966600; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w+0CrxDqnkuzZTYUwubgUhqWxAs2khRXstAaVSFraRI=;
	b=O2l169Gg8e1omJujayVEKRXuiw9GeeCQUEqeO1klJK1H1+mh/PhheplQ3Rch3fmaqeJwRfKJ95HrgPl3IYW/ZXnct2e4GRmLepCDE4PRMIna+u/Xv3kSFd4gDWBG4pKpMcxdb3uCL5LmtOlcToMnz3J1u0Jg2suCI5gyqAYieXU=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wdp0hqa_1749966590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 15 Jun 2025 13:49:58 +0800
Message-ID: <54e69067-1696-453a-b8a3-3a6967e03b24@linux.alibaba.com>
Date: Sun, 15 Jun 2025 13:49:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: confirm big pcluster before setting extents
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Cc: brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <684d44da.050a0220.be214.02b2.GAE@google.com>
 <tencent_15B5C44A7766B77466C6B36CE367297EA305@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_15B5C44A7766B77466C6B36CE367297EA305@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Edward,

On 2025/6/15 13:05, Edward Adam Davis wrote:
> In this case, advise contains Z_EROFS_ADVISE_EXTENTS,
> Z_EROFS_ADVISE_BIG_PCLUSTER_1, Z_EROFS_ADVISE_BIG_PCLUSTER_2 at the same
> time, and following 1 and 2 are met, WARN_ON_ONCE(iter->iomap.offset >
> iter->pos) in iomap_iter_done() is triggered.
> 
> 1. When Z_EROFS_ADVISE_EXTENTS exists, z_erofs_fill_inode_lazy() is exited
>     after z_extents is set, which skips the check of big pcluster;
> 2. When the condition "lstart < lend" is met in z_erofs_map_blocks_ext(),
>     m_la is updated, and m_la is used to update iomap->offset in
>     z_erofs_iomap_begin_report();
> 
> Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
> Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
> Tested-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Z_EROFS_ADVISE_BIG_PCLUSTER_1 and Z_EROFS_ADVISE_BIG_PCLUSTER_2 are
valid only for !Z_EROFS_ADVISE_EXTENTS, so I don't think this change
is a proper solution.

 From the commit message above, I don't get the root cause either.
Anyway, I will seek time to look into this issue later.

Thanks,
Gao Xiang

