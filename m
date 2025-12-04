Return-Path: <linux-fsdevel+bounces-70656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E187CA369A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 12:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5005D3107752
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73F33B6FC;
	Thu,  4 Dec 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFk9sSvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EF2DE704
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847186; cv=none; b=H143dSi4PRSSyItFTkAajIyn20Ttn0njoHZUuLl07eYrEVOlcSDyPtsiFAJ/MTK+wPrcYLDZQzAzk4Qfd2cO0xmZolkuNmHJrst4Y/rfkyJsA3HMZRYyl0wSvmQlneWEhuAi1lnYlLqLHMnKECy44mu2UtYKC67NQyOXCcgoE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847186; c=relaxed/simple;
	bh=WvWscm3N0CLn6M85vSbAydGeABjO0HO9GfKwvOQSNPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fz1X+Fs2b1TfuQ1NibVT6rQE52xOeqRPvU8Zys+dGDrnsEeB3XTyX5CN05+5Qvc4s12KJpLGsuw7sIUC/Lzlec/O3oh6As2sqEguZ6xP3f4ktlR/piSur1atGC/96tuDjIjLlN0/fq2BswNFS0XNFmb1F5aZ8RpXTuM6+ncsUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFk9sSvQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477aa91e75dso992435e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764847181; x=1765451981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2hKqtZ8qRJCylrwPhE3PF073DcXkJTYdnB19/D32AM=;
        b=TFk9sSvQzIOn9UWTY9FsvJvpD1wI6i0VvfQ/F2aZm3kaJxobCsyr1Ce4k6Ywv5YSEg
         /o5mo81Y1knFR5FJcSq2X6uqPR/heh/I/mum3Z2dRpOLGY8apbxiImEf16p+CBhCT8dd
         X8SD/vZZBjyd+jMF1DhJqXW2HuIIkHp1q4zYFnEkXBWYMvzd1LaoJF49NJRFe4JUrXxD
         zUq88/d7U7FpcjJy2wdMLc+12awFI3AL82cNUMb4Lr2LJ2ukqGeUTrYnp2+wngs5Twar
         /xffgseARru3Ye3czFsXqxrYwU2iCRbMGl0Ypw33kIUqDUVMlj1j9pBZIX9dA5gTlBRK
         WWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764847181; x=1765451981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2hKqtZ8qRJCylrwPhE3PF073DcXkJTYdnB19/D32AM=;
        b=UCsi+KZ4cI2iHj6M/OlRWV214FkFMMmfQvwo9Fd682j8Q/FFCHXeBNZbh9nqY6kCTd
         f8SDLi+WFv0g62+VIH+GpU4/jmibwQPtfW/b3qTJbatFr1ItX3Dl9u7qKpy8nnpLyCxA
         yIMTa8NK+Kq/Uyvul2zNk/00O/W8CG47obE1VRQk3hN99nsEBFyDq+e6uRIdbA3wAszW
         XbpuWCnl/Xc8ZJU9N/J1e+Ephc0Z6gqQjtwLG28ygB3/5Hx8LM3P6PeH7PGll/kUjp28
         g0FnfoDpETQoNzYXphRIt/Cp7lJN3N6MaCqOKm+nfpEc5VhUT4NH1I2e/Y+P+B+haMKJ
         q3sA==
X-Forwarded-Encrypted: i=1; AJvYcCVb/SuuGjgT2UoDKDui+mGbTk74lw4cbMqQJLEFboL+MnAxysndUFd47dvdWQwTUHlQU3GMCaC6zM6h48KP@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ61oIDQuK6VwyvjZa+ouRuHG59N4Fh0I12UsaOwjQn5LHD0fF
	3AL2lEIwzttxG6g4FX82MX/v9J292tQ2JSCsSyV7T7sqs4sxOKTIVXAC
X-Gm-Gg: ASbGnctoBsZgYQ/4h5EdXXK9Xq+uBeHdSf97J0zdr2xcW0Hm7yS6QIZ7ggclvWYivgZ
	HkyRHM6Vw5uecZacJ0CJc0KaI7/g5a9YmRH/MyX2Hn/dIvKggajHKkwbAJhIUZm7dIMaZswhlME
	uN/eeAW55zAvYz2N93YoKn2WKVzWDXCsGO15kaT22bzwKG8s/Gdvd0TKC9Jq6iAyWkKaYB946wj
	S+2nB9zqgBApwCXoeOHRvKt940y2M0GTzuEwiGlbbSCNWawbNYrA7xC15UJEEpcsuhKWOfwGW14
	ZvegCS29zPr5JoNXjSz3sCl2HT5ujmG7iMpXSWt0Iqaa4HhCq/H4fYyG42wjyvI5581k5ga3MYz
	3vHi2NV2kSehEaug0wx2unGWvBr3FCLsdxQNR8YbFgB+N35QXlp53mHIFzk5wtneDkRqSKeeKaX
	DkDQ4yEJGcmHVL1cEroOo0x+Pbsoc4OBr8ScBsaXc=
X-Google-Smtp-Source: AGHT+IHKGaDGgUu/hfwTgcpCX6n2PEp9miiG+arZ8x+lwbdliZVRvTkAtNbXyE16s9JREheiCryq8w==
X-Received: by 2002:a05:600c:c4b7:b0:477:5b01:7d42 with SMTP id 5b1f17b1804b1-4792c8e4c60mr29672955e9.5.1764847181177;
        Thu, 04 Dec 2025 03:19:41 -0800 (PST)
Received: from [192.168.1.105] ([165.50.56.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f8bsm2691904f8f.43.2025.12.04.03.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 03:19:40 -0800 (PST)
Message-ID: <3237e199-2375-4064-9a28-134836b00606@gmail.com>
Date: Thu, 4 Dec 2025 13:19:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hfs: ensure sb->s_fs_info is always cleaned up
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "sandeen@redhat.com" <sandeen@redhat.com>, "jack@suse.cz" <jack@suse.cz>
Cc: "khalid@kernel.org" <khalid@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
 <20251201222843.82310-2-mehdi.benhadjkhelifa@gmail.com>
 <4b620e91b43f86dceed88ed2f73b1ff1e72bff6c.camel@ibm.com>
 <4047dad6-d7f8-4630-896a-68d4b224f6c6@gmail.com>
 <32a2196b93ccdac0623175180a26c690e97536f6.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <32a2196b93ccdac0623175180a26c690e97536f6.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 12:19 AM, Viacheslav Dubeyko wrote:
> On Tue, 2025-12-02 at 11:16 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 12/2/25 12:04 AM, Viacheslav Dubeyko wrote:
>>> On Mon, 2025-12-01 at 23:23 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>> When hfs was converted to the new mount api a bug was introduced by
>>>> changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
>>>> fails after a new superblock has been allocated by sget_fc(), but before
>>>> hfs_fill_super() takes ownership of the filesystem-specific s_fs_info
>>>> data it was leaked.
>>>>
>>>> Fix this by freeing sb->s_fs_info in hfs_kill_super().
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
>>>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>>>> Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>> ---
>>>>    fs/hfs/mdb.c   | 35 ++++++++++++++---------------------
>>>>    fs/hfs/super.c | 10 +++++++++-
>>>>    2 files changed, 23 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
>>>> index 53f3fae60217..f28cd24dee84 100644
>>>> --- a/fs/hfs/mdb.c
>>>> +++ b/fs/hfs/mdb.c
>>>> @@ -92,7 +92,7 @@ int hfs_mdb_get(struct super_block *sb)
>>>>    		/* See if this is an HFS filesystem */
>>>>    		bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>>>>    		if (!bh)
>>>> -			goto out;
>>>> +			return -EIO;
>>>
>>> Frankly speaking, I don't see the point to rework the hfs_mdb_get() method so
>>> intensively. We had pretty good pattern before:
>>>
>>> int hfs_mdb_get(struct super_block *sb) {
>>>           if (something_happens)
>>>                goto out;
>>>
>>>           if (something_happens_and_we_need_free_buffer)
>>>               goto out_bh;
>>>
>>>    	return 0;
>>>
>>> out_bh:
>>> 	brelse(bh);
>>> out:
>>> 	return -EIO;
>>>    }
>>>
>>> The point here that we have error management logic in one place. Now you have
>>> spread this logic through the whole function. It makes function more difficult
>>> to manage and we can introduce new bugs. Could you please localize your change
>>> without reworking this pattern of error situation management? Also, it will make
>>> the patch more compact. Could you please rework the patch?
>>>
>> This change in particular is made by christian. As he mentionned in one
>> of his emails to my patches[1], his logic was that hfs_mdb_put() should
>> only be called in fill_super() which cleans everything up and that the
>> cleanup labels don't make sense here which is why he spread the logic of
>> cleanup across the function. Maybe he can give us more input on this
>> since it wasn't my code.
>>
>> [1]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f@brauner/
>>>
> 
> I am not against of not calling the hfs_mdb_put() in hfs_mdb_get(). But if I am
> trying to rework some method significantly, guys are not happy at all about it.
> :) I am slightly worried about such significant rework of hfs_mdb_get() because
> we potentially could introduce some new bugs. And I definitely will have the
> conflict with another patch under review. :)
> 

Totally understandable. If I was to make that change I would probably 
seperate it from the fix (except the part where we delete freeing the 
s_fs_info struct). But I guess christian wanted to do the whole 
refactoring since it was related and it made more sense as he explained it.
> I've spent some more time for reviewing the patch again. And I think I can
> accept it as it is. Currently, I don't see any serious issue in hfs_mdb_get().
> It is simply my code style preferences. :) But people can see it in different
> ways.
> 
Thanks for you time and effort!
>>>
>>>>    
>>>>    		if (mdb->drSigWord == cpu_to_be16(HFS_SUPER_MAGIC))
>>>>    			break;
>>>> @@ -102,13 +102,14 @@ int hfs_mdb_get(struct super_block *sb)
>>>>    		 * (should do this only for cdrom/loop though)
>>>>    		 */
>>>>    		if (hfs_part_find(sb, &part_start, &part_size))
>>>> -			goto out;
>>>> +			return -EIO;
>>>>    	}
>>>>    
>>>>    	HFS_SB(sb)->alloc_blksz = size = be32_to_cpu(mdb->drAlBlkSiz);
>>>>    	if (!size || (size & (HFS_SECTOR_SIZE - 1))) {
>>>>    		pr_err("bad allocation block size %d\n", size);
>>>> -		goto out_bh;
>>>> +		brelse(bh);
>>>> +		return -EIO;
>>>>    	}
>>>>    
>>>>    	size = min(HFS_SB(sb)->alloc_blksz, (u32)PAGE_SIZE);
>>>> @@ -125,14 +126,16 @@ int hfs_mdb_get(struct super_block *sb)
>>>>    	brelse(bh);
>>>>    	if (!sb_set_blocksize(sb, size)) {
>>>>    		pr_err("unable to set blocksize to %u\n", size);
>>>> -		goto out;
>>>> +		return -EIO;
>>>>    	}
>>>>    
>>>>    	bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>>>>    	if (!bh)
>>>> -		goto out;
>>>> -	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC))
>>>> -		goto out_bh;
>>>> +		return -EIO;
>>>> +	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC)) {
>>>> +		brelse(bh);
>>>> +		return -EIO;
>>>> +	}
>>>>    
>>>>    	HFS_SB(sb)->mdb_bh = bh;
>>>>    	HFS_SB(sb)->mdb = mdb;
>>>> @@ -174,7 +177,7 @@ int hfs_mdb_get(struct super_block *sb)
>>>>    
>>>>    	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
>>>>    	if (!HFS_SB(sb)->bitmap)
>>>> -		goto out;
>>>> +		return -EIO;
>>>>    
>>>>    	/* read in the bitmap */
>>>>    	block = be16_to_cpu(mdb->drVBMSt) + part_start;
>>>> @@ -185,7 +188,7 @@ int hfs_mdb_get(struct super_block *sb)
>>>>    		bh = sb_bread(sb, off >> sb->s_blocksize_bits);
>>>>    		if (!bh) {
>>>>    			pr_err("unable to read volume bitmap\n");
>>>> -			goto out;
>>>> +			return -EIO;
>>>>    		}
>>>>    		off2 = off & (sb->s_blocksize - 1);
>>>>    		len = min((int)sb->s_blocksize - off2, size);
>>>> @@ -199,12 +202,12 @@ int hfs_mdb_get(struct super_block *sb)
>>>>    	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
>>>>    	if (!HFS_SB(sb)->ext_tree) {
>>>>    		pr_err("unable to open extent tree\n");
>>>> -		goto out;
>>>> +		return -EIO;
>>>>    	}
>>>>    	HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
>>>>    	if (!HFS_SB(sb)->cat_tree) {
>>>>    		pr_err("unable to open catalog tree\n");
>>>> -		goto out;
>>>> +		return -EIO;
>>>>    	}
>>>>    
>>>>    	attrib = mdb->drAtrb;
>>>> @@ -229,12 +232,6 @@ int hfs_mdb_get(struct super_block *sb)
>>>>    	}
>>>>    
>>>>    	return 0;
>>>> -
>>>> -out_bh:
>>>> -	brelse(bh);
>>>> -out:
>>>> -	hfs_mdb_put(sb);
>>>> -	return -EIO;
>>>>    }
>>>>    
>>>>    /*
>>>> @@ -359,8 +356,6 @@ void hfs_mdb_close(struct super_block *sb)
>>>>     * Release the resources associated with the in-core MDB.  */
>>>>    void hfs_mdb_put(struct super_block *sb)
>>>>    {
>>>> -	if (!HFS_SB(sb))
>>>> -		return;
>>>>    	/* free the B-trees */
>>>>    	hfs_btree_close(HFS_SB(sb)->ext_tree);
>>>>    	hfs_btree_close(HFS_SB(sb)->cat_tree);
>>>> @@ -373,6 +368,4 @@ void hfs_mdb_put(struct super_block *sb)
>>>>    	unload_nls(HFS_SB(sb)->nls_disk);
>>>>    
>>>>    	kfree(HFS_SB(sb)->bitmap);
>>>> -	kfree(HFS_SB(sb));
>>>> -	sb->s_fs_info = NULL;
>>>>    }
>>>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>>>> index 47f50fa555a4..df289cbdd4e8 100644
>>>> --- a/fs/hfs/super.c
>>>> +++ b/fs/hfs/super.c
>>>> @@ -431,10 +431,18 @@ static int hfs_init_fs_context(struct fs_context *fc)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static void hfs_kill_super(struct super_block *sb)
>>>> +{
>>>> +	struct hfs_sb_info *hsb = HFS_SB(sb);
>>>> +
>>>> +	kill_block_super(sb);
>>>> +	kfree(hsb);
>>>> +}
>>>> +
>>>>    static struct file_system_type hfs_fs_type = {
>>>>    	.owner		= THIS_MODULE,
>>>>    	.name		= "hfs",
>>>> -	.kill_sb	= kill_block_super,
>>>> +	.kill_sb	= hfs_kill_super,
>>>>    	.fs_flags	= FS_REQUIRES_DEV,
>>>>    	.init_fs_context = hfs_init_fs_context,
>>>>    };
> 
> Looks good. Thanks a lot for the fix.
> 
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> Thanks,
> Slava.

Best Regards,
Mehdi Ben Hadj khelifa


