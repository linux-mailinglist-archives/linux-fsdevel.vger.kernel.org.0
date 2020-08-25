Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4225140F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgHYIVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHYIVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:21:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A455C061574;
        Tue, 25 Aug 2020 01:21:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so841288pjx.5;
        Tue, 25 Aug 2020 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4fK4U9MpnRWH9SfQD0f0xJDPOUFft9AhKGv0VyuEOTk=;
        b=LmoqRgjL3kfcSK1+2KOhXbgAbk55TnCha+PUhD9OfCWxLQbqpCRI0Kv0J3wvDD/l63
         WJoyyrzuZaZvK5pHXGPcFZ4EoIsLOynL+f5e+6fU7lmrNJM30G/gopkq/Egb3xNwuNUx
         2CR+ww+hRzT0SW1xcXEWHoDgxHlmYY4PpLakzsErhCCWTNuilnPHg+j3UN1CY38EAFjt
         aMKuY8rDInFPfBep3fmmGkyJFi0rxjyBPNC4qRIC+Bj98rwBvT87llNyE2pxQ8Fqmqxw
         HRyufHq7TjQEU8+bkQeEuT6fTg9sQ7ycH0wjmENI4UxtrAedZdWmW932ZYgExVcrPTTv
         iFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4fK4U9MpnRWH9SfQD0f0xJDPOUFft9AhKGv0VyuEOTk=;
        b=qmsaf8RrUGeiyH3NghCn1tPwy/Fb4zZdOoPcxArSOpMYlPDHSkfnCWyJDiQPCwzA9s
         WeF2Izh1x1GZ6rjpUAA97EPss54eKryLs8tHln51d/MRbA3PgPFLckAyq9WOZkgkEaDP
         LyoHFqF351k3CgaOi1j/DnZg+3LMCREAAXq9ykZBzfmtH8LyB+h1YxqlBQNrgXYEmAPx
         XZ9p2zAluCFhY8yRPb+tbEr+R57Crvqn04Yhl3+Eajudon5i8b0Yg9j5oqHHAQR/ydsb
         0O91+dfJZw5awdEJp4KYs+3lnUZySVABWy7tcr+st5+CR8ePsD+rCtbBs3AKiNzRCVpO
         KLGA==
X-Gm-Message-State: AOAM530bezg0AjMjPNwka8831JvUqVkzYcu6Ldvz1PvYR/2nIz/PkK65
        nzNrqGpfOaB2TtFo0JFUOkzaLlYLNho=
X-Google-Smtp-Source: ABdhPJzgZlwpswIk93fH5m3DSZfxmcouES2mBtDVrVg8okF/xQaMHv/3mhM8p2JyordaumoL3+1SQg==
X-Received: by 2002:a17:90a:d901:: with SMTP id c1mr665637pjv.175.1598343667969;
        Tue, 25 Aug 2020 01:21:07 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id q11sm13959275pfn.170.2020.08.25.01.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 01:21:07 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: integrates dir-entry getting and validation
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e@epcas1p4.samsung.com>
 <20200806010229.24690-1-kohada.t2@gmail.com>
 <003c01d66edc$edbb1690$c93143b0$@samsung.com>
 <ca3b2b52-1abc-939c-aa11-8c7d12e4eb2e@gmail.com>
 <000001d67787$d3abcbb0$7b036310$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <fdaff3a3-99ba-8b9e-bdaf-9bcf9d7208e0@gmail.com>
Date:   Tue, 25 Aug 2020 17:21:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000001d67787$d3abcbb0$7b036310$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> I prefer to assign validated entries to **de and use it using enum value.
>>> 	struct exfat_dentry **de;
>>
>> I've tried several implementations that add a struct exfat_dentry type.(*de0 & *de1;  *de[2]; etc...)
>> The problem with the struct exfat_dentry type is that it is too flexible for type.
>> This means weak typing.
>> Therefore, when using them,
>> 	de[XXX_FILE]->dentry.file.zzz ...
>> It is necessary to re-specify the type. (against the DRY principle) Strong typing prevents use with
>> wrong type, at compiling.
>>
>> I think the approach of using de_file/de_stream could be strongly typed.
>> I don't think we need excessive flexibility.
> 
> Could you check the following change ?

Thank you so much for your suggestion.

> If you think it's okay, please add it to your patch series.

I tentatively implemented name length and FileSet-checksum based on your patch.
(sorry for the late reply to write this email)
As a result, I cannot accept the following points.

First: It has no range validation.
The main purpose of my patch is to implement Sungjong's suggestions.

>> In order to prevent illegal accesses to bh and dentries, it would be better
>> to check validation for num and bh.

Range over is a common mistakes when handling with variable length objects.
Therefore, range validation is required at accessing es->de[].
-------------------------
[name-length example]
	for (l = 0, n = ENTRY_NAME; l < uniname->name_len; n++) {
		if (n > es->num_entries || exfat_get_entry_type(es->de[n]) != TYPE_NAME)
			return -EIO;
		for (i = 0; l < uniname->name_len && i < EXFAT_FILE_NAME_LEN; i++, l++)
			uniname->name[l] = le16_to_cpu(es->de[n]->dentry.name.unicode_0_14[i]);
	}
-------------------------
[chksum example]
	*chksum = exfat_calc_chksum16(es->de[ENTRY_FILE], DENTRY_SIZE, 0, CS_DIR_ENTRY);
	for (i = 0; i < ES_FILE(es)->num_ext; i++) {
		if (i > es->num_entries || !(exfat_get_entry_type(es->de[i]) & TYPE_SECONDARY))
			return -EIO;
		*chksum = exfat_calc_chksum16(es->de[1 + i], DENTRY_SIZE, chksum, CS_DEFAULT);
	}
-------------------------
We must be careful not only with the range of the target object(name,dir-entries), but also with the range of es->de[].
However, in most cases, it will work well without such as range validation of es->de[].
Even if we forget it, we are hard to notice.
Also, direct access to arrays can be a serious problem(continue to run with memory corruption) when an overrange occurs.
A check miss on a null pointer will only kernel-panic. <- This is also serious, but still better, I think.
Range verification should be enforced for dir-entries access.
And, I think exfat_entry_set_cache should be a fixed size structure.
It is easy to detect mistakes at compile time and has good memory efficiency at runtime.


Second: Range validation and type validation should not be separated.
When I started making this patch, I intended to add only range validation.
However, after the caller gets the ep, the type validation follows.
Get ep, null check of ep (= range verification), type verification is a series of procedures.
There would be no reason to keep them independent anymore.
Range and type validation is enforced when the caller uses ep.

--
Range validation is the most important fix for this patch.
Accessing pre-validated file/stream is a side change.

What changes are the biggest problems in my V3 patch?
("On the whole" makes me sad)

I wrote a comment in your patch code, so please read it.

> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 573659bfbc55..37e0f92f74b3 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -44,14 +44,12 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
>   	 * Third entry  : first file-name entry
>   	 * So, the index of first file-name dentry should start from 2.
>   	 */
> -	for (i = 2; i < es->num_entries; i++) {
> -		struct exfat_dentry *ep = exfat_get_dentry_cached(es, i);
> -
> +	for (i = ENTRY_NAME; i < es->num_entries; i++) {
>   		/* end of name entry */
> -		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
> +		if (exfat_get_entry_type(es->de[i]) != TYPE_NAME)
>   			break;
>   
> -		exfat_extract_uni_name(ep, uniname);
> +		exfat_extract_uni_name(es->de[i], uniname);
>   		uniname += EXFAT_FILE_NAME_LEN;
>   	}
>   
> @@ -372,7 +370,7 @@ unsigned int exfat_get_entry_type(struct exfat_dentry *ep)
>   		if (ep->type == EXFAT_STREAM)
>   			return TYPE_STREAM;
>   		if (ep->type == EXFAT_NAME)
> -			return TYPE_EXTEND;
> +			return TYPE_NAME;
>   		if (ep->type == EXFAT_ACL)
>   			return TYPE_ACL;
>   		return TYPE_CRITICAL_SEC;
> @@ -388,7 +386,7 @@ static void exfat_set_entry_type(struct exfat_dentry *ep, unsigned int type)
>   		ep->type &= EXFAT_DELETE;
>   	} else if (type == TYPE_STREAM) {
>   		ep->type = EXFAT_STREAM;
> -	} else if (type == TYPE_EXTEND) {
> +	} else if (type == TYPE_NAME) {
>   		ep->type = EXFAT_NAME;
>   	} else if (type == TYPE_BITMAP) {
>   		ep->type = EXFAT_BITMAP;
> @@ -421,7 +419,7 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
>   {
>   	int i;
>   
> -	exfat_set_entry_type(ep, TYPE_EXTEND);
> +	exfat_set_entry_type(ep, TYPE_NAME);
>   	ep->dentry.name.flags = 0x0;
>   
>   	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
> @@ -591,16 +589,13 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
>   {
>   	int chksum_type = CS_DIR_ENTRY, i;
>   	unsigned short chksum = 0;
> -	struct exfat_dentry *ep;
>   
>   	for (i = 0; i < es->num_entries; i++) {
> -		ep = exfat_get_dentry_cached(es, i);
> -		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
> +		chksum = exfat_calc_chksum16(es->de[i], DENTRY_SIZE, chksum,
>   					     chksum_type);
>   		chksum_type = CS_DEFAULT;
>   	}
> -	ep = exfat_get_dentry_cached(es, 0);
> -	ep->dentry.file.checksum = cpu_to_le16(chksum);
> +	ES_FILE(es).checksum = cpu_to_le16(chksum);
>   	es->modified = true;
>   }
>   
> @@ -741,59 +736,8 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
>   	return (struct exfat_dentry *)((*bh)->b_data + off);
>   }
>   
> -enum exfat_validate_dentry_mode {
> -	ES_MODE_STARTED,
> -	ES_MODE_GET_FILE_ENTRY,
> -	ES_MODE_GET_STRM_ENTRY,
> -	ES_MODE_GET_NAME_ENTRY,
> -	ES_MODE_GET_CRITICAL_SEC_ENTRY,
> -};
> -
> -static bool exfat_validate_entry(unsigned int type,
> -		enum exfat_validate_dentry_mode *mode)
> -{
> -	if (type == TYPE_UNUSED || type == TYPE_DELETED)
> -		return false;
> -
> -	switch (*mode) {
> -	case ES_MODE_STARTED:
> -		if  (type != TYPE_FILE && type != TYPE_DIR)
> -			return false;
> -		*mode = ES_MODE_GET_FILE_ENTRY;
> -		return true;
> -	case ES_MODE_GET_FILE_ENTRY:
> -		if (type != TYPE_STREAM)
> -			return false;
> -		*mode = ES_MODE_GET_STRM_ENTRY;
> -		return true;
> -	case ES_MODE_GET_STRM_ENTRY:
> -		if (type != TYPE_EXTEND)
> -			return false;
> -		*mode = ES_MODE_GET_NAME_ENTRY;
> -		return true;
> -	case ES_MODE_GET_NAME_ENTRY:
> -		if (type == TYPE_STREAM)
> -			return false;
> -		if (type != TYPE_EXTEND) {
> -			if (!(type & TYPE_CRITICAL_SEC))
> -				return false;
> -			*mode = ES_MODE_GET_CRITICAL_SEC_ENTRY;
> -		}
> -		return true;
> -	case ES_MODE_GET_CRITICAL_SEC_ENTRY:
> -		if (type == TYPE_EXTEND || type == TYPE_STREAM)
> -			return false;
> -		if ((type & TYPE_CRITICAL_SEC) != TYPE_CRITICAL_SEC)
> -			return false;
> -		return true;
> -	default:
> -		WARN_ON_ONCE(1);
> -		return false;
> -	}
> -}
> -
> -struct exfat_dentry *exfat_get_dentry_cached(
> -	struct exfat_entry_set_cache *es, int num)
> +struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
> +		int num)
>   {
>   	int off = es->start_off + num * DENTRY_SIZE;
>   	struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> @@ -817,16 +761,14 @@ struct exfat_dentry *exfat_get_dentry_cached(
>    *   NULL on failure.
>    */
>   struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
> -		struct exfat_chain *p_dir, int entry, unsigned int type)
> +		struct exfat_chain *p_dir, int entry, int max_entries)
>   {
> -	int ret, i, num_bh;
> -	unsigned int off, byte_offset, clu = 0;
> +	int i, num_bh, num_entries, last_name_entry;
> +	unsigned int clu = 0;
>   	sector_t sec;
>   	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>   	struct exfat_entry_set_cache *es;
>   	struct exfat_dentry *ep;
> -	int num_entries;
> -	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
>   	struct buffer_head *bh;
>   
>   	if (p_dir->dir == DIR_DELETED) {
> @@ -834,42 +776,31 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>   		return NULL;
>   	}
>   
> -	byte_offset = EXFAT_DEN_TO_B(entry);
> -	ret = exfat_walk_fat_chain(sb, p_dir, byte_offset, &clu);
> -	if (ret)
> +	ep = exfat_get_dentry(sb, p_dir, entry, &bh, &sec);
> +	if (!ep || ep->type != EXFAT_FILE) {
> +		brelse(bh);
>   		return NULL;
> +	}
>   
> -	es = kzalloc(sizeof(*es), GFP_KERNEL);
> -	if (!es)
> +	max_entries = max(max_entries, ES_2_ENTRIES);
> +	num_entries = min(ep->dentry.file.num_ext + 1, max_entries);
> +	es = kzalloc(sizeof(*es) + num_entries * sizeof(struct exfat_dentry *),
> +			GFP_KERNEL);
> +	if (!es) {
> +		brelse(bh);
>   		return NULL;
> +	}
> +
>   	es->sb = sb;
>   	es->modified = false;
> -
> -	/* byte offset in cluster */
> -	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
> -
> -	/* byte offset in sector */
> -	off = EXFAT_BLK_OFFSET(byte_offset, sb);
> -	es->start_off = off;
> -
> -	/* sector offset in cluster */
> -	sec = EXFAT_B_TO_BLK(byte_offset, sb);
> -	sec += exfat_cluster_to_sector(sbi, clu);
> -
> -	bh = sb_bread(sb, sec);
> -	if (!bh)
> -		goto free_es;
> -	es->bh[es->num_bh++] = bh;
> -
> -	ep = exfat_get_dentry_cached(es, 0);
> -	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> -		goto free_es;
> -
> -	num_entries = type == ES_ALL_ENTRIES ?
> -		ep->dentry.file.num_ext + 1 : type;
>   	es->num_entries = num_entries;
> +	es->de[ENTRY_FILE] = ep;
> +	es->bh[es->num_bh++] = bh;
> +	/* byte offset in sector */
> +	es->start_off = EXFAT_BLK_OFFSET(EXFAT_DEN_TO_B(entry), sb);
>   
> -	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
> +	clu = exfat_sector_to_cluster(sbi, sec);
> +	num_bh = EXFAT_B_TO_BLK_ROUND_UP(es->start_off + num_entries * DENTRY_SIZE, sb);
>   	for (i = 1; i < num_bh; i++) {
>   		/* get the next sector */
>   		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
> @@ -888,14 +819,27 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>   		es->bh[es->num_bh++] = bh;
>   	}
>   
> -	/* validiate cached dentries */
> -	for (i = 1; i < num_entries; i++) {
> -		ep = exfat_get_dentry_cached(es, i);
> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> +	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
> +	if (!ep || ep->type != EXFAT_STREAM)
> +		goto free_es;
> +	es->de[ENTRY_STREAM] = ep;

The value contained in stream-ext dir-entry should not be used before validating the EntrySet checksum.
So I would insert EntrySet checksum validation here.
In that case, the checksum verification loop would be followed by the TYPE_NAME verification loop, can you acceptable?


> +	last_name_entry =
> +		ENTRY_NAME + ES_STREAM(es).name_len / EXFAT_FILE_NAME_LEN;
> +	for (i = ENTRY_NAME; i < es->num_entries; i++) {
> +		es->de[i] = exfat_get_dentry_cached(es, i);
> +
> +		if (i <= last_name_entry) {
> +			if (exfat_get_entry_type(es->de[i]) != TYPE_NAME)
> +				goto free_es;
> +			continue;
> +		}
> +
> +		if (!(exfat_get_entry_type(es->de[i]) & TYPE_SECONDARY))
>   			goto free_es;
>   	}
> -	return es;
>   
> +	return es;
>   free_es:
>   	exfat_free_dentry_set(es, false);
>   	return NULL;
> @@ -1028,7 +972,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
>   			}
>   
>   			brelse(bh);
> -			if (entry_type == TYPE_EXTEND) {
> +			if (entry_type == TYPE_NAME) {
>   				unsigned short entry_uniname[16], unichar;
>   
>   				if (step != DIRENT_STEP_NAME) {
> @@ -1144,7 +1088,7 @@ int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
>   
>   		type = exfat_get_entry_type(ext_ep);
>   		brelse(bh);
> -		if (type == TYPE_EXTEND || type == TYPE_STREAM)
> +		if (type == TYPE_NAME || type == TYPE_STREAM)
>   			count++;
>   		else
>   			break;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 44dc04520175..0e4cc8ba2f8e 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -33,6 +33,12 @@ enum {
>   	NLS_NAME_OVERLEN,	/* the length is over than its limit */
>   };
>   
> +enum {
> +	ENTRY_FILE,
> +	ENTRY_STREAM,
> +	ENTRY_NAME,
> +};

This is necessary!
With this, some magic numbers will be gone.
But, I think it's better to use a name that can be recognized as an offset/index in the EntrySet.
And, I think it's better to define this in "exfat_raw.h"

> +
>   #define EXFAT_HASH_BITS		8
>   #define EXFAT_HASH_SIZE		(1UL << EXFAT_HASH_BITS)
>   
> @@ -40,7 +46,7 @@ enum {
>    * Type Definitions
>    */
>   #define ES_2_ENTRIES		2
> -#define ES_ALL_ENTRIES		0
> +#define ES_ALL_ENTRIES		256
>   
>   #define DIR_DELETED		0xFFFF0321
>   
> @@ -56,7 +62,7 @@ enum {
>   #define TYPE_FILE		0x011F
>   #define TYPE_CRITICAL_SEC	0x0200
>   #define TYPE_STREAM		0x0201
> -#define TYPE_EXTEND		0x0202
> +#define TYPE_NAME		0x0202
>   #define TYPE_ACL		0x0203
>   #define TYPE_BENIGN_PRI		0x0400
>   #define TYPE_GUID		0x0401
> @@ -65,6 +71,8 @@ enum {
>   #define TYPE_BENIGN_SEC		0x0800
>   #define TYPE_ALL		0x0FFF
>   
> +#define TYPE_SECONDARY		(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)
> +
>   #define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
>   #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
>   #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
> @@ -126,6 +134,9 @@ enum {
>   #define BITS_PER_BYTE_MASK	0x7
>   #define IGNORED_BITS_REMAINED(clu, clu_base) ((1 << ((clu) - (clu_base))) - 1)
>   
> +#define ES_FILE(es)	(es->de[ENTRY_FILE]->dentry.file)
> +#define ES_STREAM(es)	(es->de[ENTRY_STREAM]->dentry.stream)

I think that hiding with a macro is simple and good.
My V3 patch was a bit tricky.

> +
>   struct exfat_dentry_namebuf {
>   	char *lfn;
>   	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
> @@ -171,7 +182,8 @@ struct exfat_entry_set_cache {
>   	unsigned int start_off;
>   	int num_bh;
>   	struct buffer_head *bh[DIR_CACHE_SIZE];
> -	unsigned int num_entries;
> +	int num_entries;
> +	struct exfat_dentry *de[0];
>   };
>   
>   struct exfat_dir_entry {
> @@ -461,7 +473,7 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
>   struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
>   		int num);
>   struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
> -		struct exfat_chain *p_dir, int entry, unsigned int type);
> +		struct exfat_chain *p_dir, int entry, int max_entries);
>   int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
>   int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
>   
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 4831a39632a1..504ffcaffacc 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -152,7 +152,6 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
>   	/* update the directory entry */
>   	if (!evict) {
>   		struct timespec64 ts;
> -		struct exfat_dentry *ep, *ep2;
>   		struct exfat_entry_set_cache *es;
>   		int err;
>   
> @@ -160,32 +159,30 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
>   				ES_ALL_ENTRIES);
>   		if (!es)
>   			return -EIO;
> -		ep = exfat_get_dentry_cached(es, 0);
> -		ep2 = exfat_get_dentry_cached(es, 1);
>   
>   		ts = current_time(inode);
>   		exfat_set_entry_time(sbi, &ts,
> -				&ep->dentry.file.modify_tz,
> -				&ep->dentry.file.modify_time,
> -				&ep->dentry.file.modify_date,
> -				&ep->dentry.file.modify_time_cs);
> -		ep->dentry.file.attr = cpu_to_le16(ei->attr);
> +				&ES_FILE(es).modify_tz,
> +				&ES_FILE(es).modify_time,
> +				&ES_FILE(es).modify_date,
> +				&ES_FILE(es).modify_time_cs);
> +		ES_FILE(es).attr = cpu_to_le16(ei->attr);
>   
>   		/* File size should be zero if there is no cluster allocated */
>   		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
> -			ep2->dentry.stream.valid_size = 0;
> -			ep2->dentry.stream.size = 0;
> +			ES_STREAM(es).valid_size = 0;
> +			ES_STREAM(es).size = 0;
>   		} else {
> -			ep2->dentry.stream.valid_size = cpu_to_le64(new_size);
> -			ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
> +			ES_STREAM(es).valid_size = cpu_to_le64(new_size);
> +			ES_STREAM(es).size = ES_STREAM(es).valid_size;
>   		}
>   
>   		if (new_size == 0) {
>   			/* Any directory can not be truncated to zero */
>   			WARN_ON(ei->type != TYPE_FILE);
>   
> -			ep2->dentry.stream.flags = ALLOC_FAT_CHAIN;
> -			ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
> +			ES_STREAM(es).flags = ALLOC_FAT_CHAIN;
> +			ES_STREAM(es).start_clu = EXFAT_FREE_CLUSTER;
>   		}
>   
>   		exfat_update_dir_chksum_with_entry_set(es);
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index 7f90204adef5..a6be7ab76a72 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -20,7 +20,6 @@
>   static int __exfat_write_inode(struct inode *inode, int sync)
>   {
>   	unsigned long long on_disk_size;
> -	struct exfat_dentry *ep, *ep2;
>   	struct exfat_entry_set_cache *es = NULL;
>   	struct super_block *sb = inode->i_sb;
>   	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> @@ -45,26 +44,24 @@ static int __exfat_write_inode(struct inode *inode, int sync)
>   	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES);
>   	if (!es)
>   		return -EIO;
> -	ep = exfat_get_dentry_cached(es, 0);
> -	ep2 = exfat_get_dentry_cached(es, 1);
>   
> -	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
> +	ES_FILE(es).attr = cpu_to_le16(exfat_make_attr(inode));
>   
>   	/* set FILE_INFO structure using the acquired struct exfat_dentry */
>   	exfat_set_entry_time(sbi, &ei->i_crtime,
> -			&ep->dentry.file.create_tz,
> -			&ep->dentry.file.create_time,
> -			&ep->dentry.file.create_date,
> -			&ep->dentry.file.create_time_cs);
> +			&ES_FILE(es).create_tz,
> +			&ES_FILE(es).create_time,
> +			&ES_FILE(es).create_date,
> +			&ES_FILE(es).create_time_cs);
>   	exfat_set_entry_time(sbi, &inode->i_mtime,
> -			&ep->dentry.file.modify_tz,
> -			&ep->dentry.file.modify_time,
> -			&ep->dentry.file.modify_date,
> -			&ep->dentry.file.modify_time_cs);
> +			&ES_FILE(es).modify_tz,
> +			&ES_FILE(es).modify_time,
> +			&ES_FILE(es).modify_date,
> +			&ES_FILE(es).modify_time_cs);
>   	exfat_set_entry_time(sbi, &inode->i_atime,
> -			&ep->dentry.file.access_tz,
> -			&ep->dentry.file.access_time,
> -			&ep->dentry.file.access_date,
> +			&ES_FILE(es).access_tz,
> +			&ES_FILE(es).access_time,
> +			&ES_FILE(es).access_date,
>   			NULL);
>   
>   	/* File size should be zero if there is no cluster allocated */
> @@ -73,8 +70,8 @@ static int __exfat_write_inode(struct inode *inode, int sync)
>   	if (ei->start_clu == EXFAT_EOF_CLUSTER)
>   		on_disk_size = 0;
>   
> -	ep2->dentry.stream.valid_size = cpu_to_le64(on_disk_size);
> -	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
> +	ES_STREAM(es).valid_size = cpu_to_le64(on_disk_size);
> +	ES_STREAM(es).size = ES_STREAM(es).valid_size;
>   
>   	exfat_update_dir_chksum_with_entry_set(es);
>   	return exfat_free_dentry_set(es, sync);
> @@ -219,7 +216,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>   		*clu = new_clu.dir;
>   
>   		if (ei->dir.dir != DIR_DELETED && modified) {
> -			struct exfat_dentry *ep;
>   			struct exfat_entry_set_cache *es;
>   			int err;
>   
> @@ -227,17 +223,12 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>   				ES_ALL_ENTRIES);
>   			if (!es)
>   				return -EIO;
> -			/* get stream entry */
> -			ep = exfat_get_dentry_cached(es, 1);
>   
>   			/* update directory entry */
> -			ep->dentry.stream.flags = ei->flags;
> -			ep->dentry.stream.start_clu =
> -				cpu_to_le32(ei->start_clu);
> -			ep->dentry.stream.valid_size =
> -				cpu_to_le64(i_size_read(inode));
> -			ep->dentry.stream.size =
> -				ep->dentry.stream.valid_size;
> +			ES_STREAM(es).flags = ei->flags;
> +			ES_STREAM(es).start_clu = cpu_to_le32(ei->start_clu);
> +			ES_STREAM(es).valid_size = cpu_to_le64(i_size_read(inode));
> +			ES_STREAM(es).size = ES_STREAM(es).valid_size;
>   
>   			exfat_update_dir_chksum_with_entry_set(es);
>   			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index 2aff6605fecc..469fe075dc1f 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -658,25 +658,21 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
>   
>   		info->num_subdirs = count;
>   	} else {
> -		struct exfat_dentry *ep, *ep2;
>   		struct exfat_entry_set_cache *es;
>   
>   		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
>   		if (!es)
>   			return -EIO;
> -		ep = exfat_get_dentry_cached(es, 0);
> -		ep2 = exfat_get_dentry_cached(es, 1);
>   
> -		info->type = exfat_get_entry_type(ep);
> -		info->attr = le16_to_cpu(ep->dentry.file.attr);
> -		info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
> +		info->type = exfat_get_entry_type(es->de[ENTRY_FILE]);
> +		info->attr = le16_to_cpu(ES_FILE(es).attr);
> +		info->size = le64_to_cpu(ES_STREAM(es).valid_size);
>   		if ((info->type == TYPE_FILE) && (info->size == 0)) {
>   			info->flags = ALLOC_NO_FAT_CHAIN;
>   			info->start_clu = EXFAT_EOF_CLUSTER;
>   		} else {
> -			info->flags = ep2->dentry.stream.flags;
> -			info->start_clu =
> -				le32_to_cpu(ep2->dentry.stream.start_clu);
> +			info->flags = ES_STREAM(es).flags;
> +			info->start_clu = le32_to_cpu(ES_STREAM(es).start_clu);
>   		}
>   
>   		if (ei->start_clu == EXFAT_FREE_CLUSTER) {
> @@ -688,19 +684,19 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
>   		}
>   
>   		exfat_get_entry_time(sbi, &info->crtime,
> -				ep->dentry.file.create_tz,
> -				ep->dentry.file.create_time,
> -				ep->dentry.file.create_date,
> -				ep->dentry.file.create_time_cs);
> +				ES_FILE(es).create_tz,
> +				ES_FILE(es).create_time,
> +				ES_FILE(es).create_date,
> +				ES_FILE(es).create_time_cs);
>   		exfat_get_entry_time(sbi, &info->mtime,
> -				ep->dentry.file.modify_tz,
> -				ep->dentry.file.modify_time,
> -				ep->dentry.file.modify_date,
> -				ep->dentry.file.modify_time_cs);
> +				ES_FILE(es).modify_tz,
> +				ES_FILE(es).modify_time,
> +				ES_FILE(es).modify_date,
> +				ES_FILE(es).modify_time_cs);
>   		exfat_get_entry_time(sbi, &info->atime,
> -				ep->dentry.file.access_tz,
> -				ep->dentry.file.access_time,
> -				ep->dentry.file.access_date,
> +				ES_FILE(es).access_tz,
> +				ES_FILE(es).access_time,
> +				ES_FILE(es).access_date,
>   				0);
>   		exfat_free_dentry_set(es, false);
>   
> 

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
