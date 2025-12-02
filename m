Return-Path: <linux-fsdevel+bounces-70441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709BDC9AD11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 10:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5173A5986
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8174229BDB0;
	Tue,  2 Dec 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVx8dxys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD225D208
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667003; cv=none; b=U61cwvOCpAscy92bh8vdfqKCUwFdjmnFPGf/UNWlDjST9lVpnfKvX/DGD3MbNkwxq0z3thT7U317IG/beY0NjrCcADTCJMApkeZvy8JsC7JVIJVomUAWgZFt5VAf6zWc80nUDXARYm4OK/zT6fb05i2SHpcIrL8ZBKwNG2wOBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667003; c=relaxed/simple;
	bh=jG84e4jf1/Y6KoSuOJESompZU0Ht8HkOAu+fl79mqOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L95VdsrESl1JLmtEzHpAZi6DUw0Gy7G5gucqqxs/Ms/2Ruxry4YMiPKywq/QgCCbmcqA0SictTbzZtN+eeIHz36MHc+1EVe3CGmK5Peu/BhBalvJcxJ70Kc0PAyD/jkh55i0wTsAZf1oflTmfQZvl9vfSGx8pB4YbVTu7QO6nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVx8dxys; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64075080480so870766a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 01:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764667000; x=1765271800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOeyoFeE9ptuDprFUEesktlVJrLNkcXMrb/XLaSLirY=;
        b=eVx8dxysV722Vhz1iow/DluKDGeix17tr1twDhhw9qNEdp8ApKfgUqSZM3URhmZAi3
         eRxNq1oR/aEqdf/4dBEwTEtH6Og3gHLhFuga4XwDLa6GVR3RAkOPhA/pHJP6vsIG+Lsj
         cqv4wQBgW4GD0KyPrd97ekMeAhyHJHuueRKVjOgAKqQ9nzf8+38chWDz6UgTt7oqGFzt
         Yu/37oYGO+qTuz51V3S36VVdjcc1UdLL/6Qa+2MsEODV4tsxCWWv0BcZjixmjwLBzI7y
         nAT/Ryzy/0C8bSth8S9Yt2/gSkGdpyelASOxepKeLQNv8smWcZFRY4Rm4wnuMW0BKAEQ
         TCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667000; x=1765271800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOeyoFeE9ptuDprFUEesktlVJrLNkcXMrb/XLaSLirY=;
        b=F6XT6KyCUFEu93hnvMHDmzsw44abOxFuor09g2auISc+/8dwxPS23IRbqW4AakpyJA
         x5b4R40K6gROE46VymC+GaKs1zIWQmTNf0SoSLUcNTiy7RL0ev9YbyD6hP6nIyJoamgM
         HKD7Cp/56WB4YsrvY6sOTX4w4FELVHx1Xd0lM7XAzomL1tYPe6Xt85HY8DVW1Jiyaep4
         P8bLQ+ymVwWCzdbbl4kwGo3mKtj1MPdrnO9AuEpmWIsTJmwW0UOSHzdsawoKgz1X1WVn
         9uEI600pGDVAeLsXt1+rRknNd1Bl9YFNT3jbifLpXMONAhEQqaun7I9BdAJCbjTMK69w
         941w==
X-Forwarded-Encrypted: i=1; AJvYcCWjYIkooKJXSUU4q1Tvjdjqv5+1s3ZJHS2h+DrQXlu7p+JNlK8NdEJPBAVEvE+ezxb8y0dJIl5habQs1nU6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6S6H+7JGtV8WAudJ7lVze8aHp3vdP9E/frTYB5bc9Ew2SiSn
	ZFsFfkGCTL9jHmTWNrTaP1vofZps04OGHGbNIc+oAIDssxRv3A5PGjoz
X-Gm-Gg: ASbGncts3ObR3jaO45+awa25SnYWhuUpYDNpHFMEgt8Agz7i9gzmRxJaXoYL14Aq2qi
	WjX+6AncxwZw3SinPA76WKoiACvs2CZcMGDWWNkWQI75rjFKdKEbQ9pZBtwonVQtBr1CZc2G0v8
	AbXPCdI1L5wcsdYz1E0UvYcYgmsbJRGmhl/xoW5pOROLUqZIUkdeJogZBHsZmS5eqLenXwE0cWL
	A3AvShcaWliPMHqxY0Eks+pU6gUMjinnO14WaJWDWAGjIBrlzcUxVwmbHu+0i8yfl7VAydglAXg
	c2a95iENvMUiJDc/sBvwxzla86PmE5HahumBB1lMB/zKmaIBdiwMkU3BHs7r9s+H27mE9ucXCpm
	dMnmm+3bogFT4GpBYI1zVLKUeF5SwjFEjFGf8vl38YStzdENSl7KeztOydOhQHq9KkLwgndQ8al
	u/BtNIurtX3Ef6ctgS1yI1i4HZXI/P5Q==
X-Google-Smtp-Source: AGHT+IEUe65+h0njLaQw7LZAgYv9XS5wgeItFteBQfHReQmxiMj+syDNXX3N8J3uPp8A5wQTWy5Kow==
X-Received: by 2002:a05:6402:2755:b0:645:b2dc:9fd with SMTP id 4fb4d7f45d1cf-645b2dc0a91mr20550708a12.2.1764667000012;
        Tue, 02 Dec 2025 01:16:40 -0800 (PST)
Received: from [192.168.1.105] ([165.50.23.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a90e44sm14775151a12.14.2025.12.02.01.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:16:39 -0800 (PST)
Message-ID: <4047dad6-d7f8-4630-896a-68d4b224f6c6@gmail.com>
Date: Tue, 2 Dec 2025 11:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hfs: ensure sb->s_fs_info is always cleaned up
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>, "jack@suse.cz" <jack@suse.cz>,
 "sandeen@redhat.com" <sandeen@redhat.com>
Cc: "khalid@kernel.org" <khalid@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
 <20251201222843.82310-2-mehdi.benhadjkhelifa@gmail.com>
 <4b620e91b43f86dceed88ed2f73b1ff1e72bff6c.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <4b620e91b43f86dceed88ed2f73b1ff1e72bff6c.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/25 12:04 AM, Viacheslav Dubeyko wrote:
> On Mon, 2025-12-01 at 23:23 +0100, Mehdi Ben Hadj Khelifa wrote:
>> When hfs was converted to the new mount api a bug was introduced by
>> changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
>> fails after a new superblock has been allocated by sget_fc(), but before
>> hfs_fill_super() takes ownership of the filesystem-specific s_fs_info
>> data it was leaked.
>>
>> Fix this by freeing sb->s_fs_info in hfs_kill_super().
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>> Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>>   fs/hfs/mdb.c   | 35 ++++++++++++++---------------------
>>   fs/hfs/super.c | 10 +++++++++-
>>   2 files changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
>> index 53f3fae60217..f28cd24dee84 100644
>> --- a/fs/hfs/mdb.c
>> +++ b/fs/hfs/mdb.c
>> @@ -92,7 +92,7 @@ int hfs_mdb_get(struct super_block *sb)
>>   		/* See if this is an HFS filesystem */
>>   		bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>>   		if (!bh)
>> -			goto out;
>> +			return -EIO;
> 
> Frankly speaking, I don't see the point to rework the hfs_mdb_get() method so
> intensively. We had pretty good pattern before:
> 
> int hfs_mdb_get(struct super_block *sb) {
>          if (something_happens)
>               goto out;
> 
>          if (something_happens_and_we_need_free_buffer)
>              goto out_bh;
> 
>   	return 0;
> 
> out_bh:
> 	brelse(bh);
> out:
> 	return -EIO;
>   }
> 
> The point here that we have error management logic in one place. Now you have
> spread this logic through the whole function. It makes function more difficult
> to manage and we can introduce new bugs. Could you please localize your change
> without reworking this pattern of error situation management? Also, it will make
> the patch more compact. Could you please rework the patch?
> 
This change in particular is made by christian. As he mentionned in one 
of his emails to my patches[1], his logic was that hfs_mdb_put() should 
only be called in fill_super() which cleans everything up and that the 
cleanup labels don't make sense here which is why he spread the logic of 
cleanup across the function. Maybe he can give us more input on this 
since it wasn't my code.

[1]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f@brauner/
> Thanks,
> Slava.
Best Regards,
Mehdi Ben Hadj Khelifa
> 
>>   
>>   		if (mdb->drSigWord == cpu_to_be16(HFS_SUPER_MAGIC))
>>   			break;
>> @@ -102,13 +102,14 @@ int hfs_mdb_get(struct super_block *sb)
>>   		 * (should do this only for cdrom/loop though)
>>   		 */
>>   		if (hfs_part_find(sb, &part_start, &part_size))
>> -			goto out;
>> +			return -EIO;
>>   	}
>>   
>>   	HFS_SB(sb)->alloc_blksz = size = be32_to_cpu(mdb->drAlBlkSiz);
>>   	if (!size || (size & (HFS_SECTOR_SIZE - 1))) {
>>   		pr_err("bad allocation block size %d\n", size);
>> -		goto out_bh;
>> +		brelse(bh);
>> +		return -EIO;
>>   	}
>>   
>>   	size = min(HFS_SB(sb)->alloc_blksz, (u32)PAGE_SIZE);
>> @@ -125,14 +126,16 @@ int hfs_mdb_get(struct super_block *sb)
>>   	brelse(bh);
>>   	if (!sb_set_blocksize(sb, size)) {
>>   		pr_err("unable to set blocksize to %u\n", size);
>> -		goto out;
>> +		return -EIO;
>>   	}
>>   
>>   	bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>>   	if (!bh)
>> -		goto out;
>> -	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC))
>> -		goto out_bh;
>> +		return -EIO;
>> +	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC)) {
>> +		brelse(bh);
>> +		return -EIO;
>> +	}
>>   
>>   	HFS_SB(sb)->mdb_bh = bh;
>>   	HFS_SB(sb)->mdb = mdb;
>> @@ -174,7 +177,7 @@ int hfs_mdb_get(struct super_block *sb)
>>   
>>   	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
>>   	if (!HFS_SB(sb)->bitmap)
>> -		goto out;
>> +		return -EIO;
>>   
>>   	/* read in the bitmap */
>>   	block = be16_to_cpu(mdb->drVBMSt) + part_start;
>> @@ -185,7 +188,7 @@ int hfs_mdb_get(struct super_block *sb)
>>   		bh = sb_bread(sb, off >> sb->s_blocksize_bits);
>>   		if (!bh) {
>>   			pr_err("unable to read volume bitmap\n");
>> -			goto out;
>> +			return -EIO;
>>   		}
>>   		off2 = off & (sb->s_blocksize - 1);
>>   		len = min((int)sb->s_blocksize - off2, size);
>> @@ -199,12 +202,12 @@ int hfs_mdb_get(struct super_block *sb)
>>   	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
>>   	if (!HFS_SB(sb)->ext_tree) {
>>   		pr_err("unable to open extent tree\n");
>> -		goto out;
>> +		return -EIO;
>>   	}
>>   	HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
>>   	if (!HFS_SB(sb)->cat_tree) {
>>   		pr_err("unable to open catalog tree\n");
>> -		goto out;
>> +		return -EIO;
>>   	}
>>   
>>   	attrib = mdb->drAtrb;
>> @@ -229,12 +232,6 @@ int hfs_mdb_get(struct super_block *sb)
>>   	}
>>   
>>   	return 0;
>> -
>> -out_bh:
>> -	brelse(bh);
>> -out:
>> -	hfs_mdb_put(sb);
>> -	return -EIO;
>>   }
>>   
>>   /*
>> @@ -359,8 +356,6 @@ void hfs_mdb_close(struct super_block *sb)
>>    * Release the resources associated with the in-core MDB.  */
>>   void hfs_mdb_put(struct super_block *sb)
>>   {
>> -	if (!HFS_SB(sb))
>> -		return;
>>   	/* free the B-trees */
>>   	hfs_btree_close(HFS_SB(sb)->ext_tree);
>>   	hfs_btree_close(HFS_SB(sb)->cat_tree);
>> @@ -373,6 +368,4 @@ void hfs_mdb_put(struct super_block *sb)
>>   	unload_nls(HFS_SB(sb)->nls_disk);
>>   
>>   	kfree(HFS_SB(sb)->bitmap);
>> -	kfree(HFS_SB(sb));
>> -	sb->s_fs_info = NULL;
>>   }
>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>> index 47f50fa555a4..df289cbdd4e8 100644
>> --- a/fs/hfs/super.c
>> +++ b/fs/hfs/super.c
>> @@ -431,10 +431,18 @@ static int hfs_init_fs_context(struct fs_context *fc)
>>   	return 0;
>>   }
>>   
>> +static void hfs_kill_super(struct super_block *sb)
>> +{
>> +	struct hfs_sb_info *hsb = HFS_SB(sb);
>> +
>> +	kill_block_super(sb);
>> +	kfree(hsb);
>> +}
>> +
>>   static struct file_system_type hfs_fs_type = {
>>   	.owner		= THIS_MODULE,
>>   	.name		= "hfs",
>> -	.kill_sb	= kill_block_super,
>> +	.kill_sb	= hfs_kill_super,
>>   	.fs_flags	= FS_REQUIRES_DEV,
>>   	.init_fs_context = hfs_init_fs_context,
>>   };


