Return-Path: <linux-fsdevel+bounces-21694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B79908434
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4931F228B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C6C14882D;
	Fri, 14 Jun 2024 07:09:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111E17C72;
	Fri, 14 Jun 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348970; cv=none; b=ax8ZiHdW1zxvv1Ou7iJlDTOlL15GBgLO1t5iscnWdmCdp+XhEi03i4BPyxE4Kgxg+OVUenME9nadQybzpk7E3s/iSaKi2eUYNlnQk2jBmKqaGmCc3fmY8ZlPWd05MS4SRRPkzuV7FNtCaasFLjdF8w/Ng/mwqgq6gY1D3riMGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348970; c=relaxed/simple;
	bh=/6rFKvOQaCB8YRGD+hgifAbvc2jodgj/xPueB3FDbVI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=rZIJq+bvI0Gli/G3qByN/0hKyRjMAKX8xExwLrBffBpp+yifuKbdQDUKLCWxy1vu//gNDsgF1d7Jy9x1fjgHlSwmogYEeieLVjLMJTgARucriltSS0TDw1w9+wF/t6Gdck6e24oeH5nJaEmIfQ2me0u1w5dYbDDNsra4ltM9mmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W0r2f6WyMzdbBb;
	Fri, 14 Jun 2024 15:07:54 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CCFD140486;
	Fri, 14 Jun 2024 15:09:23 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 15:09:22 +0800
Message-ID: <e4f9392e-b5b6-4063-aecb-4d034c5d2bb6@huawei.com>
Date: Fri, 14 Jun 2024 15:09:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
Subject: How to create new file in idmapped mountpoint
To: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Hi everyone !

How can I create new file in idmapped mountpoint in ext4?

I try to do the following test:
```
losetup /dev/loop1 ext4.img
mkfs.ext4 /dev/loop1
mount /dev/loop1 /mnt/ext4
./mount-idmapped --map-mount b:0:1001:1 /mnt/ext4 /mnt/idmapped1
cp testfile /mnt/idmapped1
```
then it rebacks me:
```
cp: cannot create regular file '/mnt/idmapped1/testfile': Value too 
large for defined data type
```
Did I use it incorrectly?


Thanks,
Hongbo.

