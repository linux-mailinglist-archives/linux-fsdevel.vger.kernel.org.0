Return-Path: <linux-fsdevel+bounces-70198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884DC9367B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 03:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22DC3A91A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836EE1D798E;
	Sat, 29 Nov 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KPB7YVm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CD8635D;
	Sat, 29 Nov 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764382083; cv=none; b=Ivc1hhHngs470RqbgdgXQyXLF0jDAvabOrfcKtWZLsjNKSYAy261UxgVMxnjCfG/ws5ke4CiJt6BdLtOErI7txuM7NXCjKdg13r6qvEvzbjsnZuDA9YjuwGuNFTt6VZLgEFpfqKyoXJcVsMd3e8sGgCBdPipJEoeGkD7A2tcmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764382083; c=relaxed/simple;
	bh=pR2RFN1A4nc/6wKMIIXxcBJY4+41gpLM4m5qw2Vk06g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7BUZeRQkMbDdQO3mcsBry5wQtC6A8Br7GLsLuGZ9KljIpTYPW1GAv0pi+7gBxGBO4QI0NFyaUflBuuq83c2eAeJ/Oc/0zC0gfmlPck3BDtb6YwS1oPjs17b9S4CNOIi1gELRixm4UZtcEzD53FOP92G+kW4x/23uSBnhRPZTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KPB7YVm7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=UJCc/45Qhh5tFVaQaMCYhgTyp00Zjw3eYEzVCcypDl4=;
	b=KPB7YVm70yrRi4Gxzn6+Zj2TY+sKJ0n7tfGL5p0HZeE2XzO2smyPtgd47ISntm
	xvPI/iMyZtJ+LKhazjxZN8GgfVKeEwxHF6MfgNNcyRtbmigq3phLdFl0uhqWmrPO
	IoLYu2jHMBpwO3VAJe+yRklUQzl7Am+6V4lbQV7y+zoaE=
Received: from [10.42.20.201] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3pXLhUippbGbhFg--.38326S2;
	Sat, 29 Nov 2025 09:56:51 +0800 (CST)
Message-ID: <6f43ef92-a9a4-4c9b-b0e0-0bfa579ad3e4@163.com>
Date: Sat, 29 Nov 2025 09:56:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] exfat: introduce exfat_count_contig_clusters
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20251118082208.1034186-1-chizhiling@163.com>
 <20251118082208.1034186-7-chizhiling@163.com>
 <PUZPR04MB6316A47C9E593BCF7EB550B881DCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316A47C9E593BCF7EB550B881DCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgC3pXLhUippbGbhFg--.38326S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1UJF18AF4DAF4rGF1DGFg_yoW5Jr47pF
	48Ja15JrW8X3ZrW3W3Jr4kZF1Svwn7AFyqka43Ja43trZ0vrn5Cr98K34a9rWktw1qkF1j
	vF1Ygr129rsxKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zReT5LUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFAEVnWkqR27MfwAAsE

On 11/28/25 19:09, Yuezhang.Mo@sony.com wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> This patch introduces exfat_count_contig_clusters to obtain batch entries,
>> which is an infrastructure used to support iomap.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   fs/exfat/exfat_fs.h |  2 ++
>>   fs/exfat/fatent.c   | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index d52893276e9a..421dd7c61cca 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -449,6 +449,8 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
>>                  unsigned int *ret_clu);
>>   int exfat_count_num_clusters(struct super_block *sb,
>>                  struct exfat_chain *p_chain, unsigned int *ret_count);
>> +int exfat_count_contig_clusters(struct super_block *sb,
>> +               struct exfat_chain *p_chain, unsigned int *ret_count);
>>
>>   /* balloc.c */
>>   int exfat_load_bitmap(struct super_block *sb);
>> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
>> index d980d17176c2..9dcee9524155 100644
>> --- a/fs/exfat/fatent.c
>> +++ b/fs/exfat/fatent.c
>> @@ -524,3 +524,36 @@ int exfat_count_num_clusters(struct super_block *sb,
>>
>>          return 0;
>>   }
>> +
>> +int exfat_count_contig_clusters(struct super_block *sb,
>> +               struct exfat_chain *p_chain, unsigned int *ret_count)
>> +{
>> +       struct buffer_head *bh = NULL;
>> +       unsigned int clu, next_clu;
>> +       unsigned int count;
>> +
>> +       if (!p_chain->dir || p_chain->dir == EXFAT_EOF_CLUSTER) {
>> +               *ret_count = 0;
>> +               return 0;
>> +       }
>> +
>> +       if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
>> +               *ret_count = p_chain->size;
>> +               return 0;
>> +       }
>> +
>> +       clu = p_chain->dir;
>> +       for (count = 1; count < p_chain->size; count++) {
>> +               if (exfat_ent_get(sb, clu, &next_clu, &bh))
>> +                       return -EIO;
>> +               if (++clu != next_clu)
>> +                       break;
>> +       }
>> +
>> +       /* TODO: Update p_claim to help caller read ahead the next block */
>> +
>> +       brelse(bh);
>> +       *ret_count = count;
>> +
>> +       return 0;
>> +}
> 
> Hi Chi,
> 
> The clusters traversed in exfat_get_cluster() are cached to
> ->cache_lru, but the clusters traversed in this function are
> not.
> 
> I think we can implement this functionality in exfat_get_cluster()
> and cache the clusters.

Agreed, I will implement it in the next version.


Thanks,

> 
>> --
>> 2.43.0


