Return-Path: <linux-fsdevel+bounces-69900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68395C8A863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C623A3CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9E308F33;
	Wed, 26 Nov 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsslog7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9E2FF641
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169620; cv=none; b=Ka91bz+i65hVaDsJqfLNUaWHiXKTnHb7Uwme3pNMQ9v6dfBPVTLK/nCQgIToeSqwIADO7juGbAyG2piGGd1zT81bgZgjUqni+rf+5uB3S8+boYuywc78vKZ+D6B+OxQlLCGsHQAOEZoRQUGX0XBskqjaLw440tpJV09HF1Gr/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169620; c=relaxed/simple;
	bh=mcPKLhMvHagy1WJT/pUQlmEU63E3rHGweCxYawVZK7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFSaTlBXQS6l3qPS2GGTFYv+OdRDyhUjQ+K0yNyuVE8d5RbW3myX5jH1xj/jOX3LICJE2Rv36h80k5YOUocjtjUclfdPS8wFYCVSHJ91afxCcuLfxOqx6oyJff2o8ELIyNQBlJ/SgsnjLh1y3ppfME13ar3EXaPEvSsT7OtRdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsslog7Y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4790f0347bfso503525e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764169617; x=1764774417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16S+92pxDzqHzQvEHk+W0SGiRWFobBQtwlTDSX4bj6Y=;
        b=Vsslog7YEDK26ftzyYZDvesuzyRwbsxay+Q4NCC2pXRkrqXMHhcurAmgqK3oz7rB1p
         tWiCuLZf9yjj6u0BhV36oPSYtkgg4jhdWA+jYanlofZlIqMkZoFFTM7889Dg/N+iIbbE
         p+VCYN4nNC1xtpEBDtpmQddDM9t9cnqrCcAdKfi7Vk7E5KGCGqS4yzUZG7w6BQ6BrNS/
         bQl11pgQo3vkQaoPDA8uhikSnRyFoWv/m2se6WfshtHWjc3J39te/WhARiG/cqqFTAF5
         QRNkAxUjsrm8lfLFFD8uzvzoGhv2guNgf+hUq8MMqsMpm73BXa8eE2wER8+wm7gKjuVA
         +QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764169617; x=1764774417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16S+92pxDzqHzQvEHk+W0SGiRWFobBQtwlTDSX4bj6Y=;
        b=t0WO9iURbsQFJqgr5DRw9lUT9PyLlAslaDZzX9OW+69zXoC6TTfPZz4UVa2pr9LlQA
         twMUt1krJWRs2aM9vA6dRvaznUmkaKELOX238UVUXP9mv74F7Tai6iMeiK8LugBRdJvR
         vf0RDpw1HjviOIfr9UPQD/zvy6OmDru8elaqiqsAP0rW62UWOWO2gcA1XQj0TZ5Kr9Id
         eOUBhhubhgzew6Zi4UVJOHL7whbVanlwaRdiNv+StpnbImCjhWL0UQ4f5OcFGtd1AYJi
         ISxgQ7nyWzb3c5m+H3OCqOjxsrPs8CqciVcAxiJuzD4wBDzCcxaTmP86Qy+EqmTjI4ca
         qkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD3LsoQ8gKwD/J7Y12pQK0xc4wBUpF3svldvNqguhO15SoHKlAJM6w+Att6Xfa0brBkIqRdF98k1AAnIq6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13LI/35+txtZS3aNp5VzCGIt+eRJ61eN3GIQ4depUXE2XClig
	kYgaSNao7/68fhJbMbCVnS3WpeJG7DOvQCfouykdWeoBenCwqfzOBHnw
X-Gm-Gg: ASbGncsOUtGlKiOrLUJ14OXJvh8hULCw3Q646lfcWs0tZkM5Ym258nncNQW6LfUEsph
	Kan3zzBOZJmuB8SZ8WVBkuFy+WHCBhpeMnvFpvNWo8p6u8RN0E4AODLybNzinG7GQr14frorUa6
	2utTOws9KlgjsXvcbPfHTwmD39FwXJMPxgYz3VOerQL8AfZ4USyii8LokjBHw+ey+vquUP6MUQR
	+z9E/aWP8dvxWBG5iLAXngOclZKESfxXRSlosmRqzKaeZtqebnCHXFrKYQeOLBfCAxkgzup/nzU
	cOhyaKob0UDfeN6AfDwfbnEBZs28F3xDRN0t69K5jxI6TCNQkOvKHxOSFPs8JHwIHfsjPCRWhRm
	83jDZVIwMMNLaG/Id3rrT4PZKjhOHwJITb6oZWVMntMf1RW0XwHXMF37B7N5UdEqKs45IIEjmd4
	F6m+vLgApkoZtkMIK/2wsLZ+w0PQjNjA==
X-Google-Smtp-Source: AGHT+IHLJQtnOrQIqHTS6ZGn2BqHnmibcb1tF6cwMKDudSdfcrV8sfkTLUNEh2Gbp5Vi4ArcWVva6Q==
X-Received: by 2002:a05:600c:4f51:b0:477:a977:b8a0 with SMTP id 5b1f17b1804b1-477c01ba7d6mr131441845e9.3.1764169617033;
        Wed, 26 Nov 2025 07:06:57 -0800 (PST)
Received: from [192.168.1.105] ([165.50.65.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ade12cesm65565045e9.9.2025.11.26.07.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 07:06:56 -0800 (PST)
Message-ID: <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
Date: Wed, 26 Nov 2025 17:06:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: Christian Brauner <brauner@kernel.org>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
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
 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 2:48 PM, Christian Brauner wrote:
> On Wed, Nov 19, 2025 at 07:58:21PM +0000, Viacheslav Dubeyko wrote:
>> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
>>> The regression introduced by commit aca740cecbe5 ("fs: open block device
>>> after superblock creation") allows setup_bdev_super() to fail after a new
>>> superblock has been allocated by sget_fc(), but before hfs_fill_super()
>>> takes ownership of the filesystem-specific s_fs_info data.
>>>
>>> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
>>> are never reached, leaving the HFS mdb structures attached to s->s_fs_info
>>> unreleased.The default kill_block_super() teardown also does not free
>>> HFS-specific resources, resulting in a memory leak on early mount failure.
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
>>> Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/
>>>
>>> Note:This patch might need some more testing as I only did run selftests
>>> with no regression, check dmesg output for no regression, run reproducer
>>> with no bug and test it with syzbot as well.
>>
>> Have you run xfstests for the patch? Unfortunately, we have multiple xfstests
>> failures for HFS now. And you can check the list of known issues here [1]. The
>> main point of such run of xfstests is to check that maybe some issue(s) could be
>> fixed by the patch. And, more important that you don't introduce new issues. ;)
>>
>>>
>>>   fs/hfs/super.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>>> index 47f50fa555a4..06e1c25e47dc 100644
>>> --- a/fs/hfs/super.c
>>> +++ b/fs/hfs/super.c
>>> @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
>>>   {
>>>   	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
>>>   	hfs_mdb_close(sb);
>>> -	/* release the MDB's resources */
>>> -	hfs_mdb_put(sb);
>>>   }
>>>   
>>>   static void flush_mdb(struct work_struct *work)
>>> @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>>   bail_no_root:
>>>   	pr_err("get root inode failed\n");
>>>   bail:
>>> -	hfs_mdb_put(sb);
>>>   	return res;
>>>   }
>>>   
>>> @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
>>>   	return 0;
>>>   }
>>>   
>>> +static void hfs_kill_sb(struct super_block *sb)
>>> +{
>>> +	generic_shutdown_super(sb);
>>> +	hfs_mdb_put(sb);
>>> +	if (sb->s_bdev) {
>>> +		sync_blockdev(sb->s_bdev);
>>> +		bdev_fput(sb->s_bdev_file);
>>> +	}
>>> +
>>> +}
>>> +
>>>   static struct file_system_type hfs_fs_type = {
>>>   	.owner		= THIS_MODULE,
>>>   	.name		= "hfs",
>>> -	.kill_sb	= kill_block_super,
>>
>> It looks like we have the same issue for the case of HFS+ [2]. Could you please
>> double check that HFS+ should be fixed too?
> 
> There's no need to open-code this unless I'm missing something. All you
> need is the following two patches - untested. Both issues were
> introduced by the conversion to the new mount api.
Yes, I don't think open-code is needed here IIUC, also as I mentionned 
before I went by the suggestion of Al Viro in previous replies that's my 
main reason for doing it that way in the first place.

Also me and Slava are working on testing the mentionned patches, Should 
I sent them from my part to the maintainers and mailing lists once 
testing has been done?

Best Regards,
Mehdi Ben Hadj Khelifa

