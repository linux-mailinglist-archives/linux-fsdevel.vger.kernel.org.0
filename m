Return-Path: <linux-fsdevel+bounces-76360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKVPNC/9g2kXwgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 03:15:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0DEDE9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 03:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08453028807
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A09277CA5;
	Thu,  5 Feb 2026 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ReU6ItaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69C1C862D;
	Thu,  5 Feb 2026 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257620; cv=none; b=hMtHW7KyDsOvvPBHDQwfA8CBgh5OjUMF5fhSTPbOc/Be3u0gTXMeGZc17kuWgzDrxE2wJPRJhfjA9MY4RGQrrbnzMi5cJEknaNKRi7jW1PsfvjfltJ6QSF5dygH/7tG+tQUQkVou5GRLlFuZlyqXuq8jl8VqccF2F2TSiW8nKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257620; c=relaxed/simple;
	bh=tG7iOtu6bbrK4DUjgYWB48R2hdPPJC71lbs+JT8piG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHqSccvGlPQhKHXhmhnqUxkHtExouy0yh/uSwpCFNOC9S6GPSyXtf/5V6JbZAXvGDVSjQwS2lp3PU+NevbBOYFY6eNd2hGrGpUyXz62Ola+z63MAbqHzvfKmoZhUcnZW/fOvFe+ij9VnhjnPOU0n4xWJZEPqrnUXprXK7HA1pYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ReU6ItaX; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=iD8GjZkTBsTzcjEw6PjNHJmTolFmnhWIHDK7Iznp46g=;
	b=ReU6ItaX9E8UUaRAFXshZ8BuVVIuHEF65b/kFTMsRjxxIVhLpfwJ2m5BClirC7
	FVvVfdBXszMLx9Q2tkO/PTEcNl6Y/ZVzvghx03mieF3FjSi0BmDGFywg2lHhhAWq
	jlJLrIxtTPXeQ/w1dDR7xW6V18sdcwYUINFvHkUBQamzc=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCnZqe1_INpdlZYJw--.238S2;
	Thu, 05 Feb 2026 10:13:11 +0800 (CST)
Message-ID: <41d06f88-d5b6-4a6d-a2fd-813dbdf71517@163.com>
Date: Thu, 5 Feb 2026 10:13:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] exfat: add block readahead in
 exfat_chain_cont_cluster
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260204071435.602246-1-chizhiling@163.com>
 <20260204071435.602246-2-chizhiling@163.com>
 <CAKYAXd-xgjbF1u4x9KZvoaVa0xL7LL6Mie_gL9v+UpfCPpH6BQ@mail.gmail.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <CAKYAXd-xgjbF1u4x9KZvoaVa0xL7LL6Mie_gL9v+UpfCPpH6BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnZqe1_INpdlZYJw--.238S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry3Ar1DKry8CF13ur4rZrb_yoW5tr1fpr
	43Ca13tF4UXa47Ww4Sgr1DXF1Sg3s7GFyYgry3uFyrAr9Ivrsa9r9rKryFgaykJw4UGF4j
	vF4YvFyjkrZrWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2zuAUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BenRWmD-LdWmQAA3j
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76360-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chizhiling@163.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 36F0DEDE9C
X-Rspamd-Action: no action

On 2/5/26 09:39, Namjae Jeon wrote:
> On Wed, Feb 4, 2026 at 4:15 PM Chi Zhiling <chizhiling@163.com> wrote:
>>
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> The conversion from NO_FAT_CHAIN format to FAT_CHAIN format occurs
>> when the file cannot allocate contiguous space. When the file to be
>> converted is very large, this process can take a long time.
>>
>> This patch introduces simple readahead to read all the blocks in
>> advance, as these blocks are consecutive.
>>
>> Test in an empty exfat filesystem:
>> dd if=/dev/zero of=/mnt/file bs=1M count=30k
>> dd if=/dev/zero of=/mnt/file2 bs=1M count=1
>> time cat /mnt/file2 >> /mnt/file
>>
>> | cluster size | before patch | after patch |
>> | ------------ | ------------ | ----------- |
>> | 512          | 47.667s      | 4.316s      |
>> | 4k           | 6.436s       | 0.541s      |
>> | 32k          | 0.758s       | 0.071s      |
>> | 256k         | 0.117s       | 0.011s      |
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   fs/exfat/exfat_fs.h |  9 +++++++--
>>   fs/exfat/fatent.c   | 38 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index 2dbed5f8ec26..5a3cdf725846 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -10,6 +10,7 @@
>>   #include <linux/ratelimit.h>
>>   #include <linux/nls.h>
>>   #include <linux/blkdev.h>
>> +#include <linux/backing-dev.h>
>>   #include <uapi/linux/exfat.h>
>>
>>   #define EXFAT_ROOT_INO         1
>> @@ -79,6 +80,10 @@ enum {
>>   #define EXFAT_HINT_NONE                -1
>>   #define EXFAT_MIN_SUBDIR       2
>>
>> +#define EXFAT_BLK_RA_SIZE(sb)          \
>> +(min((sb)->s_bdi->ra_pages, (sb)->s_bdi->io_pages) \
>> +        << (PAGE_SHIFT - sb->s_blocksize_bits))
>> +
>>   /*
>>    * helpers for cluster size to byte conversion.
>>    */
>> @@ -117,9 +122,9 @@ enum {
>>   #define FAT_ENT_SIZE (4)
>>   #define FAT_ENT_SIZE_BITS (2)
>>   #define FAT_ENT_OFFSET_SECTOR(sb, loc) (EXFAT_SB(sb)->FAT1_start_sector + \
>> -       (((u64)loc << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
>> +       (((u64)(loc) << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
>>   #define FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc) \
>> -       ((loc << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
>> +       (((loc) << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
>>
>>   /*
>>    * helpers for bitmap.
>> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
>> index 71ee16479c43..0c17621587d5 100644
>> --- a/fs/exfat/fatent.c
>> +++ b/fs/exfat/fatent.c
>> @@ -142,13 +142,51 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
>>          return -EIO;
>>   }
>>
>> +static int exfat_blk_readahead(struct super_block *sb, sector_t sec,
>> +               sector_t *ra, blkcnt_t *ra_cnt, sector_t end)
>> +{
>> +       struct blk_plug plug;
>> +
>> +       if (sec < *ra)
>> +               return 0;
>> +
>> +       *ra += *ra_cnt;
>> +
>> +       /* No blocks left (or only the last block), skip readahead. */
>> +       if (*ra >= end)
>> +               return 0;
>> +
>> +       *ra_cnt = min(end - *ra + 1, EXFAT_BLK_RA_SIZE(sb));
>> +       if (*ra_cnt == 0) {
>> +               /* Move 'ra' to the end to disable readahead. */
>> +               *ra = end;
>> +               return 0;
>> +       }
>> +
>> +       blk_start_plug(&plug);
>> +       for (unsigned int i = 0; i < *ra_cnt; i++)
>> +               sb_breadahead(sb, *ra + i);
>> +       blk_finish_plug(&plug);
>> +       return 0;
>> +}
> Can you combine multiple readahead codes (readahead in
> exfat_allocate_bitmap, exfat_dir_readahead) in exfat?

OK, I will do this in v2.

> Thanks.


