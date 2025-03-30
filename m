Return-Path: <linux-fsdevel+bounces-45300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF8DA75A52
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081233A62D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3216C1D5172;
	Sun, 30 Mar 2025 14:27:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA903232;
	Sun, 30 Mar 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743344874; cv=none; b=pibLdVksXuSRE0pjxslxR5TYnWhAAGGDHa5Df4WAQKzJLwq5OmOH7XdhoERsIstajuYcFqtFL1CIrL/ePGkJsRUJh/sUupMTM1wJd3jQx2sFBZ8Fa/6u848uv72xrQASbHeQL3l3esEjZVC6lArLdf7CG5ByPga4rdsdpbN4LxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743344874; c=relaxed/simple;
	bh=Xqehng9m3Qcp1mTjx7Gw51fQtpN49xnpGi3qNQ+ZOpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kx5QSGTh7LT9JmKhidLEIxCAkWBOqOMdSm/AzSi7ggiYjszQxQu8K/unLWUg+m6O6ZcYU76jbFmQY/fHxoWwQff7fFZcvVKx40q8zzM1/H2+jKvzcr113qLQGbUprXH1D5SlAcycstlxX/Z+VH7cZfYch4BEoB9dIEColzIsQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.241.128]
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <jaco@uls.co.za>)
	id 1tytdJ-000000000pA-3NNp;
	Sun, 30 Mar 2025 16:27:30 +0200
Message-ID: <cb0c9321-9c1d-4910-bcbd-3d0ca10d62cb@uls.co.za>
Date: Sun, 30 Mar 2025 16:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: Supply dir_context.count as readdir buffer size
 hint
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, miklos@szeredi.hu, rdunlap@infradead.org,
 trapexit@spawn.link
References: <20230727081237.18217-1-jaco@uls.co.za>
 <20250314221701.12509-1-jaco@uls.co.za>
 <20250314221701.12509-2-jaco@uls.co.za>
 <b1baac64-f56d-4d0f-92f1-d7bb808a151b@wanadoo.fr>
Content-Language: en-GB
From: Jaco Kroon <jaco@uls.co.za>
Autocrypt: addr=jaco@uls.co.za; keydata=
 xsBNBFXtplYBCADM6RTLCOSPiclevkn/gdf8h9l+kKA6N+WGIIFuUtoc9Gaf8QhXWW/fvUq2
 a3eo4ULVFT1jJ56Vfm4MssGA97NZtlOe3cg8QJMZZhsoN5wetG9SrJvT9Rlltwo5nFmXY3ZY
 gXsdwkpDr9Y5TqBizx7DGxMd/mrOfXeql57FWFeOc2GuJBnHPZQMJsQ66l2obPn36hWEtHYN
 gcUSPH3OOusSEGZg/oX/8WSDQ/b8xz1JKTEgcnu/JR0FxzjY19zSHmbnyVU+/gF3oeJFcEUk
 HvZu776LRVdcZ0lb1bHQB2K9rTZBVeZLitgAefPVH2uERVSO8EZO1I5M7afV0Kd/Vyn9ABEB
 AAHNG0phY28gS3Jvb24gPGphY29AdWxzLmNvLnphPsLAdwQTAQgAIQUCVe2mVgIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAILcSxr/fungCPB/sHrfufpRbrVTtHUjpbY4bTQLQE
 bVrh4/yMiKprALRYy0nsMivl16Q/3rNWXJuQ0gR/faC3yNlDgtEoXx8noXOhva9GGHPGTaPT
 hhpcp/1E4C9Ghcaxw3MRapVnSKnSYL+zOOpkGwye2+fbqwCkCYCM7Vu6ws3+pMzJNFK/UOgW
 Tj8O5eBa3DiU4U26/jUHEIg74U+ypYPcj5qXG0xNXmmoDpZweW41Cfo6FMmgjQBTEGzo9e5R
 kjc7MH3+IyJvP4bzE5Paq0q0b5zZ8DUJFtT7pVb3FQTz1v3CutLlF1elFZzd9sZrg+mLA5PM
 o8PG9FLw9ZtTE314vgMWJ+TTYX0kzsBNBFXtplYBCADedX9HSSJozh4YIBT+PuLWCTJRLTLu
 jXU7HobdK1EljPAi1ahCUXJR+NHvpJLSq/N5rtL12ejJJ4EMMp2UUK0IHz4kx26FeAJuOQMe
 GEzoEkiiR15ufkApBCRssIj5B8OA/351Y9PFore5KJzQf1psrCnMSZoJ89KLfU7C5S+ooX9e
 re2aWgu5jqKgKDLa07/UVHyxDTtQKRZSFibFCHbMELYKDr3tUdUfCDqVjipCzHmLZ+xMisfn
 yX9aTVI3FUIs8UiqM5xlxqfuCnDrKBJjQs3uvmd6cyhPRmnsjase48RoO84Ckjbp/HVu0+1+
 6vgiPjbe4xk7Ehkw1mfSxb79ABEBAAHCwF8EGAEIAAkFAlXtplYCGwwACgkQCC3Esa/37p7u
 XwgAjpFzUj+GMmo8ZeYwHH6YfNZQV+hfesr7tqlZn5DhQXJgT2NF6qh5Vn8TcFPR4JZiVIkF
 o0je7c8FJe34Aqex/H9R8LxvhENX/YOtq5+PqZj59y9G9+0FFZ1CyguTDC845zuJnnR5A0lw
 FARZaL8T7e6UGphtiT0NdR7EXnJ/alvtsnsNudtvFnKtigYvtw2wthW6CLvwrFjsuiXPjVUX
 825zQUnBHnrED6vG67UG4z5cQ4uY/LcSNsqBsoj6/wsT0pnqdibhCWmgFimOsSRgaF7qsVtg
 TWyQDTjH643+qYbJJdH91LASRLrenRCgpCXgzNWAMX6PJlqLrNX1Ye4CQw==
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <b1baac64-f56d-4d0f-92f1-d7bb808a151b@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-report: Relay access (ida.uls.co.za).

ACK.  Fixed locally.

Thank you.

Will give a few more days before re-sending.

Kind regards,
Jaco

On 2025/03/29 11:20, Christophe JAILLET wrote:

> Hi,
>
> a few nitpicks below to reduce the diffpatch with unrelated changes. 
> (trainling spaces)
>
>
> Le 14/03/2025 à 23:16, Jaco Kroon a écrit :
>> This was provided by Miklos <miklos@szeredi.hu> via LKML on 2023/07/27
>> subject "Re: [PATCH] fuse: enable larger read buffers for readdir.".
>>
>> This is thus preperation for an improved fuse readdir() patch. The
>
> s/preperation/preparation/
>
>> description he provided:
>>
>> "The best strategy would be to find the optimal buffer size based on 
>> the size of
>> the userspace buffer.  Putting that info into struct dir_context 
>> doesn't sound
>> too complicated...
>>
>> "Here's a patch.  It doesn't touch readdir.  Simply setting the fuse 
>> buffer size
>> to the userspace buffer size should work, the record sizes are 
>> similar (fuse's
>> is slightly larger than libc's, so no overflow should ever happen)."
>
> ...
>
>> @@ -239,7 +240,7 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
>>     /*
>>    * New, all-improved, singing, dancing, iBCS2-compliant getdents()
>> - * interface.
>> + * interface.
>
> Unrelated change.
>
>>    */
>>   struct linux_dirent {
>>       unsigned long    d_ino;
>
> ...
>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 2788df98080f..1e426e2b5999 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -308,7 +308,7 @@ struct iattr {
>>    */
>>   #define FILESYSTEM_MAX_STACK_DEPTH 2
>>   -/**
>> +/**
>
> Unrelated change.
>
>>    * enum positive_aop_returns - aop return codes with specific 
>> semantics
>>    *
>>    * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
>> @@ -318,7 +318,7 @@ struct iattr {
>>    *                 be a candidate for writeback again in the near
>>    *                 future.  Other callers must be careful to unlock
>>    *                 the page if they get this return.  Returned by
>> - *                 writepage();
>> + *                 writepage();
>
> Unrelated change.
>
>>    *
>>    * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked 
>> page has
>>    *              unlocked it and the page might have been truncated.
>> @@ -1151,8 +1151,8 @@ struct file *get_file_active(struct file **f);
>>     #define    MAX_NON_LFS    ((1UL<<31) - 1)
>>   -/* Page cache limit. The filesystems should put that into their 
>> s_maxbytes
>> -   limits, otherwise bad things can happen in VM. */
>> +/* Page cache limit. The filesystems should put that into their 
>> s_maxbytes
>> +   limits, otherwise bad things can happen in VM. */
>
> Unrelated change.
>
>>   #if BITS_PER_LONG==32
>>   #define MAX_LFS_FILESIZE    ((loff_t)ULONG_MAX << PAGE_SHIFT)
>>   #elif BITS_PER_LONG==64
>> @@ -2073,6 +2073,13 @@ typedef bool (*filldir_t)(struct dir_context 
>> *, const char *, int, loff_t, u64,
>>   struct dir_context {
>>       filldir_t actor;
>>       loff_t pos;
>> +    /*
>> +     * Filesystems MUST NOT MODIFY count, but may use as a hint:
>> +     * 0        unknown
>> +     * > 0      space in buffer (assume at least one entry)
>> +     * INT_MAX  unlimited
>> +     */
>> +    int count;
>>   };
>>     /*
>> @@ -2609,7 +2616,7 @@ int sync_inode_metadata(struct inode *inode, 
>> int wait);
>>   struct file_system_type {
>>       const char *name;
>>       int fs_flags;
>> -#define FS_REQUIRES_DEV        1
>> +#define FS_REQUIRES_DEV        1
>
> Unrelated change.
>
>>   #define FS_BINARY_MOUNTDATA    2
>>   #define FS_HAS_SUBTYPE        4
>>   #define FS_USERNS_MOUNT        8    /* Can be mounted by userns 
>> root */
>> @@ -3189,7 +3196,7 @@ ssize_t __kernel_read(struct file *file, void 
>> *buf, size_t count, loff_t *pos);
>>   extern ssize_t kernel_write(struct file *, const void *, size_t, 
>> loff_t *);
>>   extern ssize_t __kernel_write(struct file *, const void *, size_t, 
>> loff_t *);
>>   extern struct file * open_exec(const char *);
>> -
>> +
>
> Unrelated change.
>
>>   /* fs/dcache.c -- generic fs support functions */
>>   extern bool is_subdir(struct dentry *, struct dentry *);
>>   extern bool path_is_under(const struct path *, const struct path *);
>

