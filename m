Return-Path: <linux-fsdevel+bounces-69152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84959C713EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 23:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8FE78295A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83C312816;
	Wed, 19 Nov 2025 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP0FCFJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4726E703
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590866; cv=none; b=otPLPNz1k8Ax+CONG4CLzygnev/vNfwCtBpq4U0R2bD+VEAlYRpbuKuRXqXhfAYb1qhEfhruGVV/LBt1n7aWl8fZER3tfuNPQl84A8+gdpcC44c2U2gT+tdNbBxDto12y63TcCbvzuMv3IX6PLmm7upn6a8DI4BcNqNWpMRvy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590866; c=relaxed/simple;
	bh=50Q9sBTjpmF9okPX4ahM+W4f4BYMCV2mUkt/5FtAic0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu0lS+e8vy2YPC5EZERE53G5a8Rfb1iP7WO5keGjBXv0wUewydXhHyndLfn67uULCzwPEwgUu5zcryk8Qg34TotrZjVNuITAVcospnyQYO5Z/1N31g5wog3DbnbzNxZwZjwH76XZgvphlxK+eJY/TCZFIdgIYANfcLpaAxH78NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP0FCFJH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779b49d724so453815e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 14:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763590862; x=1764195662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=288Dw9sswG0A+z/lBkxnm7oNArScrtV4EVd6dIg2R2Y=;
        b=JP0FCFJHP2X5MXrAcMtQ+4dXgB7O2fhO5EEGwlNDXRVDWKtUvmuF82KPPc12AAfcGm
         doVt/W4Q/AYtsOQBjUtCtQ6gJUzNGTIWDhudlQpJKG56ZnAwZQmahr0wCQf6CP/haD7I
         7BXQycyHTvPIBCLdaZvaiDLpI+GV5pV+0EYsFaFVlTdrI7OBiP3Gf4fd84scioTZqba6
         y3TpcoRo1ASM9uo424amHjfUluJK6pGHd0oPs42osgsv42/adXv0osiqJGB7RBw8Oy1s
         Ens32drV7bvJduLuXLKA2Oxif1b3U5fRH4L3qxcAO42TvxA+BJ8jzCJo+f01+kCqdGeh
         fziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590862; x=1764195662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=288Dw9sswG0A+z/lBkxnm7oNArScrtV4EVd6dIg2R2Y=;
        b=OW3qsuRe5j1rKpTkV8dA4aVkIsTyLPtAksS6ZwyzkJgGZWcEnlOuW5xqtfmYfQ2oho
         3J7xSsoHyJ2DCoAyCLi+m97k5d0zIXQEvVS4sMn2hbWzJB+/2xouX4+UI457OWRZ0+iP
         sUOxJMRM3jiGmF8QLKHpdmUaOHo+T4Mjvt2nYZg5qrds1zKt0VFuu/arZVCeb15yf5A9
         wsIlr6272vY3VaIjQ/qphXC/YngzrquT2j4NPfSifHXIN4iIHFIjdDi2WiqxDcZnBB0v
         67W//+GtvTr7h9ed91Ws2PJk+Npdywct8O2ofcaUW+YL7PTAekFgGMg3ec/59YZXRX89
         GpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbvoWnPv/uVzX7xRORrWfh8HZe9w7cdy9ZG4VAhDzPBKz5jdiEneGvJ5e0UoRm2j82Lv2i+YLUN49N4Q2j@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfwTB6KOQhz8H2mmU+EnQ168JVCHiOZl32rk4P4cRst74k2rr
	2zEg+m3ENXtcZbVbA0tC4QvE+/tQtV0vlPjMSjwuXX/P2F2JVd/RAYHJ
X-Gm-Gg: ASbGnctClAhiXhpWSLkbbo6sVO18ZFoAcpeFs2A8IGM0AII7sFavuA84asC/Nkozl8/
	jMjLgd2dAS6j/G2+U3LtYMO+LQvXamOlSowQi+mAFdXjNwoxpAd/VtO0F31OyeQL9Yz4S5XrfmA
	FUl51V9ONPpPRZlgRdUOXVQEYfwhzCwCl9WC7cuC/nSar6/hBUdQg+3DPG+r62W0N1LB2zAvKO9
	I+lvyve85N4aCFWrfxogSm9DBeQV49omXG/iw/oDzl6jH0cceObDvu8vEOsdwpF/OjEVMwJtbjp
	FjJHOxCSqQax6IEU0ILa4t6EyW9kVCEJXHRRtZPagReQXA2HQF7WW+nyHjGRuB6euzHd+Q+QjKr
	GGG3+QX0x4nIBDB5fP5pwkZMkOZ2K6a3Qefgw5DPMNXJxIE8rxLJn25+weSXm0Ro+kzWWP0H1ke
	Ez39C7uSJz+kceeIKBudIiZhUSquyKq4PHLubACw==
X-Google-Smtp-Source: AGHT+IG/wJ7Aaz37mXLzcO74yWwcjdbnF8mjOxzLT81DyT1s3fbL9Pty3G5JtiVp6En9+zLPVH7muw==
X-Received: by 2002:a05:600c:4f0b:b0:477:a16e:fec5 with SMTP id 5b1f17b1804b1-477b8355ed8mr4060285e9.0.1763590862068;
        Wed, 19 Nov 2025 14:21:02 -0800 (PST)
Received: from [192.168.1.111] ([165.50.70.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b106a9b0sm72950165e9.11.2025.11.19.14.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:21:01 -0800 (PST)
Message-ID: <25434098-4bf0-4330-b7b1-527983d9c903@gmail.com>
Date: Wed, 19 Nov 2025 23:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
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
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
>> The regression introduced by commit aca740cecbe5 ("fs: open block device
>> after superblock creation") allows setup_bdev_super() to fail after a new
>> superblock has been allocated by sget_fc(), but before hfs_fill_super()
>> takes ownership of the filesystem-specific s_fs_info data.
>>
>> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
>> are never reached, leaving the HFS mdb structures attached to s->s_fs_info
>> unreleased.The default kill_block_super() teardown also does not free
>> HFS-specific resources, resulting in a memory leak on early mount failure.
>>
>> Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
>> hfs_put_super() and the hfs_fill_super() failure path into a dedicated
>> hfs_kill_sb() implementation. This ensures that both normal unmount and
>> early teardown paths (including setup_bdev_super() failure) correctly
>> release HFS metadata.
>>
>> This also preserves the intended layering: generic_shutdown_super()
>> handles VFS-side cleanup, while HFS filesystem state is fully destroyed
>> afterwards.
>>
>> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>> Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> ChangeLog:
>>
>> Changes from v1:
>>
>> -Changed the patch direction to focus on hfs changes specifically as
>> suggested by al viro
>>
>> Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/
>>
>> Note:This patch might need some more testing as I only did run selftests
>> with no regression, check dmesg output for no regression, run reproducer
>> with no bug and test it with syzbot as well.
> 
> Have you run xfstests for the patch? Unfortunately, we have multiple xfstests
> failures for HFS now. And you can check the list of known issues here [1]. The
> main point of such run of xfstests is to check that maybe some issue(s) could be
> fixed by the patch. And, more important that you don't introduce new issues. ;)
> 
I did not know of such tests. I will try to run them for both my patch 
and christian's patch[1] and report the results.
>>
>>   fs/hfs/super.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>> index 47f50fa555a4..06e1c25e47dc 100644
>> --- a/fs/hfs/super.c
>> +++ b/fs/hfs/super.c
>> @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
>>   {
>>   	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
>>   	hfs_mdb_close(sb);
>> -	/* release the MDB's resources */
>> -	hfs_mdb_put(sb);
>>   }
>>   
>>   static void flush_mdb(struct work_struct *work)
>> @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   bail_no_root:
>>   	pr_err("get root inode failed\n");
>>   bail:
>> -	hfs_mdb_put(sb);
>>   	return res;
>>   }
>>   
>> @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
>>   	return 0;
>>   }
>>   
>> +static void hfs_kill_sb(struct super_block *sb)
>> +{
>> +	generic_shutdown_super(sb);
>> +	hfs_mdb_put(sb);
>> +	if (sb->s_bdev) {
>> +		sync_blockdev(sb->s_bdev);
>> +		bdev_fput(sb->s_bdev_file);
>> +	}
>> +
>> +}
>> +
>>   static struct file_system_type hfs_fs_type = {
>>   	.owner		= THIS_MODULE,
>>   	.name		= "hfs",
>> -	.kill_sb	= kill_block_super,
> 
> It looks like we have the same issue for the case of HFS+ [2]. Could you please
> double check that HFS+ should be fixed too?
> 
Yes, I will check it tomorrow in addition to running xfstests and report 
my findings in response to this email. But I'm not sure if my solution 
would be the attended fix or a similar solution to what christian did is 
preferred instead for HFS+. We'll discuss it when I send a response.
> Thanks,
> Slava.
> 
Thank you for your insights Slava!

Best Regards,
Mehdi Ben Hadj Khelifa
>> +	.kill_sb	= hfs_kill_sb,
>>   	.fs_flags	= FS_REQUIRES_DEV,
>>   	.init_fs_context = hfs_init_fs_context,
>>   };
> 
> [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues
> [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/super.c#L694


