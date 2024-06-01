Return-Path: <linux-fsdevel+bounces-20701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 028918D6EAF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 09:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D441F23D69
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993D18C36;
	Sat,  1 Jun 2024 07:38:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379CD304;
	Sat,  1 Jun 2024 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717227526; cv=none; b=p23zENO05dlfWaACoINKBhirvpzbtu70O24nYAK2BbtADNVC7wWtG4x7E0ViHfBkj18YI3VFNUjAEHrt4qLk4C04wk/+11B7hFxR8ZUnkpLybt2qGVNkSaaBfFYDVPmwWmyxogF+D++wMey+dDE2SIS0q+lJGOeBg5aE3IgXCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717227526; c=relaxed/simple;
	bh=TGhn62G3kHUo4+xm8IQf/8vUBogZ4sWXSEQEar1FMI4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ea63JVrUnvuVyaMpSE7JM08r+dFnvdu01579mQErx4A+ySq1speLxduA1Td7tdrM3Wdc/9HPAv7P94LXqKkI53w5vFq52j0wwOV05iUx6bTE8lvR0J+SMkqxrOP8Y+ZJzL3OG/jiBeGdcopXgwBrP2YTnMHILWlVh275JhXqYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VrsKw5MhNz4f3n5j;
	Sat,  1 Jun 2024 15:38:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AB0DC1A016E;
	Sat,  1 Jun 2024 15:38:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXPA_9z1pmSDx2Og--.13740S3;
	Sat, 01 Jun 2024 15:38:39 +0800 (CST)
Subject: Re: [RFC PATCH v4 0/8] iomap/xfs: fix stale data exposure when
 truncating realtime inodes
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <ZlnCAo0aM8tP__hc@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <eb8872e2-4651-5158-cd7c-33ef8cf3cd03@huaweicloud.com>
Date: Sat, 1 Jun 2024 15:38:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlnCAo0aM8tP__hc@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXPA_9z1pmSDx2Og--.13740S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/31 20:26, Christoph Hellwig wrote:
> Procedural question before I get into the actual review:  given we
> are close to -rc3 and there is no user of the iomap change yet,
> should we revert that for 6.10 and instead try again in 6.11 when
> the XFS bits are sorted out?
> 

Okay, fine, it looks we still need some time to fix this issue.  I
will send out a patch to revert the commit '943bc0882ceb ("iomap:
don't increase i_size if it's not a write operation")' soon, other
commits in my previous series looks harmless, so I think we can
keep them.

Thanks,
Yi.


