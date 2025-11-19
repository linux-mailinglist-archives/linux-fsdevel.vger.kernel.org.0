Return-Path: <linux-fsdevel+bounces-69153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC5C71408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 23:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACDE04E20EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C662ED159;
	Wed, 19 Nov 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMO8ckR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1881F0E32
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591062; cv=none; b=ZVTgNbMMJ9rjf72iWyW39pdT5NOv/8pc1nAbOl8iyAe+Z6OIQvbP5xhhVWYM8ZDx/vHHF5ml+7MF3NiJYjJ2c8fNxr5tp7j805PSbpoXEVIj4bBYyZiADkTHFhtL1dmA3iYjvuJFI9bkzHMNmmwsSCBxTsCunlMQhREveLNdXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591062; c=relaxed/simple;
	bh=xaPyOxNT/HcBqaLOWWrNAr3jgVtnKXjwmxRR4CkbxzM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ImBktCNEcp9m+MCtGEqSiUVJUdct4dcILuWBGFZBgO8YLCOZYb0A5voTk5L3NC7TTXHwMB+H3O2N6QanXNSWKWlvPCn6hGn99iS5v90Zu+CFBAKfTE4AY75lYR0l1jKtww8TT8qZABz8RyE96QbzlLZ45vsUnOJnybTDw64wMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMO8ckR6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47798f4059fso393055e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 14:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763591059; x=1764195859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T7WmQOx6iAlsV0MHuZ9X9eaYiLcx+jdU4wVC787CH7Y=;
        b=GMO8ckR6d4O6tLM3eAXBIYx9a0SdGlJ31rIkY+5ZMSbXgLTWm4OZ/ujcGTFUXQs6HQ
         neELZUbg9fWIYoNswBstelxp2FVjHp1EvtPbx5MQ+6dDhnXS1Qtk6tcgYgTREp4kYEmQ
         IvZ1ripUvfP1+hNAKPPY/8m08vq+u8hehmYCugLiDEJ2uIK2CjxBI+Vn2F2voZosPfW5
         3ZC6D5XNp5Jt5A2V/JManyiMKHcIIm+1NEor+ADf3LlFFi/kK9dp8SlF0WGjLoU8h8av
         +CuY5JqzfJ1l6AEbdUYPzu9nzprGGxiyrHK7ZF7V8nVB8W3/7UHtyeoUXInD6dK0kjvd
         hfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591059; x=1764195859;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7WmQOx6iAlsV0MHuZ9X9eaYiLcx+jdU4wVC787CH7Y=;
        b=pCOBVrgE3Q5bNjV1zPbiSwxhj29I6RhVfbp84WD4UTBf4F5YJvuLubJ7v6hZtZDBEp
         qjLVKhu/laEh2tajIqlfPvWKqzkTA2OLnBsfmmk9psnyoF7LRykbbyL67vZjLh4SzwCi
         ruiVocY9M4NhUM4ZQnpd7a+/OlPPi6KF1X+2PK/uE7u/4ll0GspTYuc+cWcy0IEDxUJr
         GEQ/jiwD7feCImTUjRUIVvAjEY1kzNktV9uHVfqo2+l//1d+t7WxiLCraH//UdwrTytI
         Uw/fXXS/LGUgiRtbFfU+JkPswgTSt5/Ass69n5Hj+uU/VbbYh38pzkBUn+VtHGmsXM7j
         U1ew==
X-Forwarded-Encrypted: i=1; AJvYcCUz9CxVYnQ6ujg3ug1M8DE9b0gmPUct/clRvhudoiE4l967QLlFFCo8GhjZsBc3tP52RTHlgBbIN2fT2R2/@vger.kernel.org
X-Gm-Message-State: AOJu0YxCo+lANKWSAhQwJBUyu6ZE2FPr2/ILpQWYRZDLDt70023l8HJB
	z+WPTbiuyGEGDPz9fG7VRuoWkfd/HyZbPkPWy+g5ABbLkPrXm6he1UlN
X-Gm-Gg: ASbGncsGw8YiqgDkAv1vsDvbDK6VFsxc8yJQyfKXu9CK4uXnW3OqrK2mXl/Y1zZO0f4
	c8AihpdrOp/i+/XTlHPq7xYdwLHGMtzHKzudbOL4rxSfeSaEyjDj98zKLU2xDux8y8wme/mCsLf
	5khCSyksw58MCOL5brlt9Qgrxr3rSyBhebrmQXJ2QdFTI5bK6DpooH8URCDpP4913nA6SjvrM+l
	JiZmIAgjNQt/E5VY0SpoIEGejRxbTyd52i4dVX7/rzjF2GELlJnTjAPHiCrSBmlca4dvmPrpE8u
	dHM9bzxdZMgxEzF/AvYo0OP0viPm8tz/UIsCyozYm5h+BRmsHr5795Gpor2zsWr2bP97gCzRxHv
	ulGOVMqaPbfOicMoufu+rpl86hMFbCzcGKfLeBvfRkef2U08Buhz6kvvS5GS/JlXjPT+iLu8CZi
	QLykNkxuWqxzaHIWLuW4IiuXjxAhcr1VlVxycCJzcA++edqD1D
X-Google-Smtp-Source: AGHT+IEsHyRMQ5pcW3Ld7TQbeWKn9n9tuuRTUNEesIDP2g12lL/hprJtX1I0mMWZv0u25tvMu6LN2Q==
X-Received: by 2002:a05:600c:1c2a:b0:477:a203:66dd with SMTP id 5b1f17b1804b1-477b8579778mr5398185e9.2.1763591058508;
        Wed, 19 Nov 2025 14:24:18 -0800 (PST)
Received: from [192.168.1.111] ([165.50.70.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d21591sm52867025e9.2.2025.11.19.14.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:24:18 -0800 (PST)
Message-ID: <42a9f815-fcda-4bfe-918c-8a676909c9ac@gmail.com>
Date: Wed, 19 Nov 2025 23:24:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>
Cc: "khalid@kernel.org" <khalid@kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <25434098-4bf0-4330-b7b1-527983d9c903@gmail.com>
Content-Language: en-US
In-Reply-To: <25434098-4bf0-4330-b7b1-527983d9c903@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/25 11:21 PM, Mehdi Ben Hadj Khelifa wrote:
> On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
>> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
>>> The regression introduced by commit aca740cecbe5 ("fs: open block device
>>> after superblock creation") allows setup_bdev_super() to fail after a 
>>> new
>>> superblock has been allocated by sget_fc(), but before hfs_fill_super()
>>> takes ownership of the filesystem-specific s_fs_info data.
>>>
>>> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
>>> are never reached, leaving the HFS mdb structures attached to s- 
>>> >s_fs_info
>>> unreleased.The default kill_block_super() teardown also does not free
>>> HFS-specific resources, resulting in a memory leak on early mount 
>>> failure.
>>>
>>> Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
>>> hfs_put_super() and the hfs_fill_super() failure path into a dedicated
>>> hfs_kill_sb() implementation. This ensures that both normal unmount and
>>> early teardown paths (including setup_bdev_super() failure) correctly
>>> release HFS metadata.
>>>
>>> This also preserves the intended layering: generic_shutdown_super()
>>> handles VFS-side cleanup, while HFS filesystem state is fully destroyed
>>> afterwards.
>>>
>>> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
>>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>>> Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>> ---
>>> ChangeLog:
>>>
>>> Changes from v1:
>>>
>>> -Changed the patch direction to focus on hfs changes specifically as
>>> suggested by al viro
>>>
>>> Link:https://lore.kernel.org/all/20251114165255.101361-1- 
>>> mehdi.benhadjkhelifa@gmail.com/
>>>
>>> Note:This patch might need some more testing as I only did run selftests
>>> with no regression, check dmesg output for no regression, run reproducer
>>> with no bug and test it with syzbot as well.
>>
>> Have you run xfstests for the patch? Unfortunately, we have multiple 
>> xfstests
>> failures for HFS now. And you can check the list of known issues here 
>> [1]. The
>> main point of such run of xfstests is to check that maybe some 
>> issue(s) could be
>> fixed by the patch. And, more important that you don't introduce new 
>> issues. ;)
>>
> I did not know of such tests. I will try to run them for both my patch 
> and christian's patch[1] and report the results.

Forgot to reference the mentioned link "[1]". Sorry for the noise.

[1]:https://github.com/brauner/linux/commit/058747cefb26196f3c192c76c631051581b29b27

>>>
>>>   fs/hfs/super.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>>> index 47f50fa555a4..06e1c25e47dc 100644
>>> --- a/fs/hfs/super.c
>>> +++ b/fs/hfs/super.c
>>> @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
>>>   {
>>>       cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
>>>       hfs_mdb_close(sb);
>>> -    /* release the MDB's resources */
>>> -    hfs_mdb_put(sb);
>>>   }
>>>   static void flush_mdb(struct work_struct *work)
>>> @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, 
>>> struct fs_context *fc)
>>>   bail_no_root:
>>>       pr_err("get root inode failed\n");
>>>   bail:
>>> -    hfs_mdb_put(sb);
>>>       return res;
>>>   }
>>> @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct 
>>> fs_context *fc)
>>>       return 0;
>>>   }
>>> +static void hfs_kill_sb(struct super_block *sb)
>>> +{
>>> +    generic_shutdown_super(sb);
>>> +    hfs_mdb_put(sb);
>>> +    if (sb->s_bdev) {
>>> +        sync_blockdev(sb->s_bdev);
>>> +        bdev_fput(sb->s_bdev_file);
>>> +    }
>>> +
>>> +}
>>> +
>>>   static struct file_system_type hfs_fs_type = {
>>>       .owner        = THIS_MODULE,
>>>       .name        = "hfs",
>>> -    .kill_sb    = kill_block_super,
>>
>> It looks like we have the same issue for the case of HFS+ [2]. Could 
>> you please
>> double check that HFS+ should be fixed too?
>>
> Yes, I will check it tomorrow in addition to running xfstests and report 
> my findings in response to this email. But I'm not sure if my solution 
> would be the attended fix or a similar solution to what christian did is 
> preferred instead for HFS+. We'll discuss it when I send a response.
>> Thanks,
>> Slava.
>>
> Thank you for your insights Slava!
> 
> Best Regards,
> Mehdi Ben Hadj Khelifa

>>> +    .kill_sb    = hfs_kill_sb,
>>>       .fs_flags    = FS_REQUIRES_DEV,
>>>       .init_fs_context = hfs_init_fs_context,
>>>   };
>>
>> [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues
>> [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/ 
>> super.c#L694
> 


