Return-Path: <linux-fsdevel+bounces-23899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14079348D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D1D1F2277B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4329770EF;
	Thu, 18 Jul 2024 07:30:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0418059;
	Thu, 18 Jul 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287842; cv=none; b=sQ5tgW5cfagdbWzsjV4BE5cDcYZAEOejpw6dUxpgekufcbYmrtNwgLn6ookPkfIwg6LwQiHObJJgrMXOTY4n1VFr611uRn+xIPl4CE+k5lFciQRHp9Nt/bnUFKvihscvcnncf59qjEHk28AsLW7oiYesWQeOy8SVYX0MojBOwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287842; c=relaxed/simple;
	bh=gxgSF5r/1aTolNGI95eCxaHoM+21qoGrkKwwKzAgZNk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CCtAR63Ueg5z/6NeYutwvlIbCYLmZRTDBGPmMlNRVw/igF5xaceab1aUv3TXn0ehQiT6H9vYTzi8ObQP4GxpqhfYkhzu9GlLSJGh0oiD83lwtlmyS2d7GiCpIVYy6pQ+PyRJOibGm5XaJ15PV6lvJBGfVzd435DLRGSzc4ejXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WPkrB6VCnz28fYF;
	Thu, 18 Jul 2024 15:26:18 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 22CE61A0170;
	Thu, 18 Jul 2024 15:30:38 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:30:37 +0800
Subject: Re: [BUG REPORT] potential deadlock in inode evicting under the inode
 lru traversing context on ext4 and ubifs
To: Ryder Wang <rydercoding@hotmail.com>, Theodore Ts'o <tytso@mit.edu>,
	Zhihao Cheng <chengzhihao@huaweicloud.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig
	<hch@infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>, Richard
 Weinberger <richard@nod.at>, "zhangyi (F)" <yi.zhang@huawei.com>, yangerkun
	<yangerkun@huawei.com>, "wangzhaolong (A)" <wangzhaolong1@huawei.com>
References: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
 <20240712143708.GA151742@mit.edu>
 <MEYP282MB3164B39D532251DC6C36B652BFAC2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <10db909b-1b42-82f1-4ca3-3079e66ac7d3@huawei.com>
Date: Thu, 18 Jul 2024 15:30:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <MEYP282MB3164B39D532251DC6C36B652BFAC2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/7/18 11:04, Ryder Wang Ð´µÀ:
Hi, Ryder
>> Um, I don't see how this can happen.  If the ea_inode is in use,
>> i_count will be greater than zero, and hence the inode will never be
>> go down the rest of the path in inode_lru_inode():
>>
>>          if (atomic_read(&inode->i_count) ||
>>              ...) {
>>                  list_lru_isolate(lru, &inode->i_lru);
>>                  spin_unlock(&inode->i_lock);
>>                  this_cpu_dec(nr_unused);
>>                  return LRU_REMOVED;
>>          }
> 
> Yes, in the function inode_lru_inode (in case of clearing cache), there has been such inode->i_state check mechanism to avoid double-removing the inode which is being removed by another process. Unluckily, no such similar inode->i_state check mechanism in the function iput_final (in case of removing file), so double-removing inode can still appear.

I'm a little confused about the process of inode double-removing, can 
you provide a detailed case about how double-revemoving happens? I can't 
find the relationship between inode double-removing and the problem i 
described.
> 
> It looks we need to add some inode->i_state check in iput_final() , if we want to fix this race condition bug.

