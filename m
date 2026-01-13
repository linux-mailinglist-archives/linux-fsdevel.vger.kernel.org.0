Return-Path: <linux-fsdevel+bounces-73389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E17D17662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56659302B773
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4F37FF5F;
	Tue, 13 Jan 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LCksgNTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3751366560;
	Tue, 13 Jan 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294438; cv=none; b=JCNnHtLQkGySKvzytO89nrDfm0Y+66EDfxQ0LSJvPFaaMYx9jn0GfH2t5fpxKUtmggzWr7/zbtuKl6ZvFdUMq/lgOQMrX5zEeOGOKsac5Hv+DMdI8GOQ6GSiXTQoJWk7/M1X0sX3EzbznI0NglDMujQd810o5i5H1DknJsmZz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294438; c=relaxed/simple;
	bh=voCaPO1GtdaQzr9QnH+KeXQVt/oZSSu6HF0DsQYVj0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPtkLiLKxqFAtj4dYB2kyJ9hX647P82+uf++5fBcESfLoBVLtUflQOLLw5CNyVxJDCL7GTUpJ/0Oih+B/JQpJyo82XJuK4Y6UHP4HpK5RnzJdgRhQBHY1iRU7JvmtrT8uIuEERUQdq7588eXN89ge6mDJlotUdRWAAHG4NhGhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LCksgNTk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Nh3sa8YpupxDXnKz85mzudcfw8rlZGwz6IfXCDQd8Ng=;
	b=LCksgNTk5+tIeHtNDlk1YHPPdK5s98mpf79/jEuE9nhflMHeWouh06ty7tz5FK
	M3KPvexXKhBwCpHy4ZDK9CjFat5BzE3HyQuvH6G8lwAm/IfjQx/63ySX9UDicgm+
	A+mFnOiyRExyrUSkvqgtPH+rNoPCE9TZHrUalKYnus8zU=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3P_0ACGZp8oE+Gg--.51058S2;
	Tue, 13 Jan 2026 16:53:21 +0800 (CST)
Message-ID: <f7cc8f8a-81f0-4a31-9d75-983858daf985@163.com>
Date: Tue, 13 Jan 2026 16:53:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] exfat: support multi-cluster for
 exfat_map_cluster
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20260108074929.356683-1-chizhiling@163.com>
 <20260108074929.356683-11-chizhiling@163.com>
 <PUZPR04MB631615D6191EF6FB711E63C3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB631615D6191EF6FB711E63C3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3P_0ACGZp8oE+Gg--.51058S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW5Kry7GF45CFy3XF47Jwb_yoW8Gr4xp3
	4kC3Wktw4xWa4DWa1xtr4qgr1S9ayxGFWfJF4xWFW5GryvgF1xZFyvyr9xuw1rtas3Gryq
	qa45KryUuws7G3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRaLvNUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3AL1k2lmCAIkAwAA3a

On 1/13/26 14:37, Yuezhang.Mo@sony.com wrote:
>> @@ -281,7 +285,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>>         sec_offset = iblock & (sbi->sect_per_clus - 1);
>>
>>         phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
>> -       mapped_blocks = sbi->sect_per_clus - sec_offset;
>> +       mapped_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
> 
> This left shift will cause an overflow if the file is larger than 2TB
> and the clusters are contiguous.

Thank you for pointing this out, I will change the type to blkcnt_t in 
v3 to fix this bug.

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index e8b74185b0ad..9c1e00f5b011 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -250,9 +250,9 @@ static int exfat_get_block(struct inode *inode, 
sector_t iblock,
         struct exfat_inode_info *ei = EXFAT_I(inode);
         struct super_block *sb = inode->i_sb;
         struct exfat_sb_info *sbi = EXFAT_SB(sb);
-       unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
+       blkcnt_t max_blocks = EXFAT_B_TO_BLK(bh_result->b_size, sb);
+       blkcnt_t mapped_blocks = 0;
         int err = 0;
-       unsigned long mapped_blocks = 0;
         unsigned int cluster, sec_offset, count;
         sector_t last_block;
         sector_t phys = 0;

> 
> The others look good.
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>


Thanks,


