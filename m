Return-Path: <linux-fsdevel+bounces-69470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 292C0C7BE26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 23:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88E8D4EE367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 22:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773CB30C34A;
	Fri, 21 Nov 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAM3jP1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1438308F2B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763764604; cv=none; b=QAaNBSvAoGFT/em48btQm3G1dI1hO+KpnC0MdbOKMubFkfW1VpgAClSlpM6DHONSvAQDvhXshV584dODqMJ5jpUTGkwf230SB1Z2NaSByYGmp2avSMlYWq+aKfqeIAmYk3r9RUry0z2kSo+b0cx3XYKjMEoNwIOyvMjljAWLqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763764604; c=relaxed/simple;
	bh=/GZTueMSRaKW2C/6j8juQfO5EJMP9zmCjKhmksi5qM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxKkTjsrW/uztDKE/FLME6INqY0ACicV7wNCTpu1agqFAamRLgmXw3k/ohsRvHfI6HcS8yriuTAs3JWy2dWPdUBkiDiH7oWwvi+UpxCGDtlb64xXGewnoMaV+g3gOwVooH3M1rXO/QPS3NgzWqAQ1zc3kieHqyJYn2GkRw3fIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAM3jP1b; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b305881a1so199458f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763764594; x=1764369394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJDhF8kPxDYmP/xN+ENkv42XP//fvI//cHUvAnvrvpE=;
        b=fAM3jP1bPOcm+212immbCQqeCAuTgHuuRjsUbWIw9QSyYZBZyb8dSsPVE4FXIM9kUL
         gk23A4jLJXqkSVpQ7jccaHVpjQb8CONw1c+b2dcIsarc7b+u4F2HnmL3/zZ5RhVxnESv
         ZLThiqWktPWQ9aJSW5bcRAN+y/hYCZDdlw3LHoIgH5uEQCOEM1T71/UEnbGE3MTBJjt6
         +Nhzsn2CHiTB+BvwUUlHzsJeW4dTxoATSHz5HLrp8hXLlng5wV/7ni4H6aw0QeZ6LOod
         Wp7tqLwc9rYeiQPvsLN4VAjfj6iS4r0/UgLYkScCwvcGGKIrIE2LaPpGmNq2h6zH4IBt
         LLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763764594; x=1764369394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJDhF8kPxDYmP/xN+ENkv42XP//fvI//cHUvAnvrvpE=;
        b=CJcCS7ln2YzNpS0zvgAyXU3bowj/EinJv2Nm5LBdKa1UiGcJYp+qjVLUo5NPLgP1Lh
         l5JyidzXAVyLOO0/6JlgWMjfWLpYAxygsvKWdbMW2dCgeVOi8sVhNKQF6lc/zZJfcGH3
         G8gXDKH4lTU6SRji+YD3Q+0GR/PorWERcgOcy5OIKGeYzBLQMTyPPUFWeiQsC7ZLc0jd
         alMqI14VfwOQE9nBm7LoQmod35Vs6nXMSJRHOV4thpEwo3Mwd6U8OCuPHI8sNmdLH3dD
         cTmEfUnWVktS7sDbeq8zu2L9C7iSC4tynTceXixLJILocKF9REcs4pr1fjNonQDzUyJi
         gW+g==
X-Forwarded-Encrypted: i=1; AJvYcCVTVc54561Dbf+FBVzwXhEwdJNJR/ORFZfwcMpUz/nmwOzcTTlallMN46qnwU4wCvupA7/iyUaN6UKkxOXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YylBKGhNT1/zDpvnIN3/Wra7lPMPU4hz8lzTdaCGdaerRhV6ej8
	LRF1Fmuq76k06Y8VwAm6pfp2Zoln1EJRA58jzrwEpC8zvPrv3MEpZO77
X-Gm-Gg: ASbGncvCp2rele9a6YjTjvT3cI26nWwo9u81Db1sptCfA3oaWZ2obmxbzqTvsrDtV9L
	Y9Qsgrh5CaCis2aCZzaGiolIh0XnGw4a3qCFPMOT8S0r+MPuOy3Oxg9qbF2BbszDTxEKh8/JUOW
	XlhJ2PXwHmm2Ik9qXJ9GQ27DCmSrIKOX5cQTQ5/Pmtb5Y/8nfKP8UYi0b68/Wq4IQ2uku6zaFdP
	BQOa3ZrC8kzhVyvwyPXcCefLvjWALdXrKQvAfCAc2qNvtD6uq86YhQ2cUSg6+Hk3OGxQciOoDVU
	wGg23xRmnHtEapHoGPQ+/Xy/QSqjhI8IvQYtakNHRDF2ngDMl5mkyUFBA2v8PS+LBrVunaaTSwH
	z7LFM/Yq/2As8GSBN+zELUPpwERglOX+AeIERfYqQnahPUEMwgoU90zQPDncf1e+M9X55Xj4zM/
	RZ5j+HZRlSS84Ql/X4A4lRNChq7x4=
X-Google-Smtp-Source: AGHT+IFS6sbhxvmAzxzAoFlxY/ZxPlVrxJZXoAftQWYIRw8tY0AYqXShryiYb/otOfeq60ZGU/jiLg==
X-Received: by 2002:a05:600c:19cd:b0:477:a203:66dd with SMTP id 5b1f17b1804b1-477c016c83emr21188325e9.2.1763764593355;
        Fri, 21 Nov 2025 14:36:33 -0800 (PST)
Received: from [192.168.1.105] ([165.50.70.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm95200065e9.8.2025.11.21.14.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 14:36:32 -0800 (PST)
Message-ID: <28fbe625-eb1b-4c7f-925c-aec4685a6cbf@gmail.com>
Date: Sat, 22 Nov 2025 00:36:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "jack@suse.cz"
 <jack@suse.cz>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "khalid@kernel.org" <khalid@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
 <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
 <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
 <148f1324cd2ae50059e1dcdc811cccdee667b9ae.camel@ibm.com>
 <6ddd2fd3-5f62-4181-a505-38a5d37fa793@gmail.com>
 <960f74ac4a4b67ebb0c1c4311302798c1a9afc53.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <960f74ac4a4b67ebb0c1c4311302798c1a9afc53.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 11:28 PM, Viacheslav Dubeyko wrote:
> On Sat, 2025-11-22 at 00:16 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 11/21/25 11:04 PM, Viacheslav Dubeyko wrote:
>>> On Fri, 2025-11-21 at 23:48 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>> On 11/21/25 10:15 PM, Viacheslav Dubeyko wrote:
>>>>> On Fri, 2025-11-21 at 20:44 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>> On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
>>>>>>> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>>>> The regression introduced by commit aca740cecbe5 ("fs: open block device
>>>>>>>> after superblock creation") allows setup_bdev_super() to fail after a new
>>>>>>>> superblock has been allocated by sget_fc(), but before hfs_fill_super()
>>>>>>>> takes ownership of the filesystem-specific s_fs_info data.
>>>>>>>>
>>>>>>>> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
>>>>>>>> are never reached, leaving the HFS mdb structures attached to s->s_fs_info
>>>>>>>> unreleased.The default kill_block_super() teardown also does not free
>>>>>>>> HFS-specific resources, resulting in a memory leak on early mount failure.
>>>>>>>>
>>>>>>>> Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
>>>>>>>> hfs_put_super() and the hfs_fill_super() failure path into a dedicated
>>>>>>>> hfs_kill_sb() implementation. This ensures that both normal unmount and
>>>>>>>> early teardown paths (including setup_bdev_super() failure) correctly
>>>>>>>> release HFS metadata.
>>>>>>>>
>>>>>>>> This also preserves the intended layering: generic_shutdown_super()
>>>>>>>> handles VFS-side cleanup, while HFS filesystem state is fully destroyed
>>>>>>>> afterwards.
>>>>>>>>
>>>>>>>> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
>>>>>>>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>>>>>>>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>>>>>>>> Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>>>>>>>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>>>>>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>>>>>> ---
>>>>>>>> ChangeLog:
>>>>>>>>
>>>>>>>> Changes from v1:
>>>>>>>>
>>>>>>>> -Changed the patch direction to focus on hfs changes specifically as
>>>>>>>> suggested by al viro
>>>>>>>>
>>>>>>>> Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/
>>>>>>>>
>>>>>>>> Note:This patch might need some more testing as I only did run selftests
>>>>>>>> with no regression, check dmesg output for no regression, run reproducer
>>>>>>>> with no bug and test it with syzbot as well.
>>>>>>>
>>>>>>> Have you run xfstests for the patch? Unfortunately, we have multiple xfstests
>>>>>>> failures for HFS now. And you can check the list of known issues here [1]. The
>>>>>>> main point of such run of xfstests is to check that maybe some issue(s) could be
>>>>>>> fixed by the patch. And, more important that you don't introduce new issues. ;)
>>>>>>>
>>>>>> I have tried to run the xfstests with a kernel built with my patch and
>>>>>> also without my patch for TEST and SCRATCH devices and in both cases my
>>>>>> system crashes in running the generic/631 test.Still unsure of the
>>>>>> cause. For more context, I'm running the tests on the 6.18-rc5 version
>>>>>> of the kernel and the devices and the environment setup is as follows:
>>>>>>
>>>>>> For device creation and mounting(also tried it with dd and had same
>>>>>> results):
>>>>>> fallocate -l 10G test.img
>>>>>> fallocate -l 10G scratch.img
>>>>>> sudo mkfs.hfs test.img
>>>>>> sudo losetup /dev/loop0 ./test.img
>>>>>> sudo losetup /dev/loop1 ./scratch.img
>>>>>> sudo mkdir -p /mnt/test /mnt/scratch
>>>>>> sudo mount /dev/loop0 /mnt/test
>>>>>>
>>>>>> For environment setup(local.config):
>>>>>> export TEST_DEV=/dev/loop0
>>>>>> export TEST_DIR=/mnt/test
>>>>>> export SCRATCH_DEV=/dev/loop1
>>>>>> export SCRATCH_MNT=/mnt/scratch
>>>>>
>>>>> This is my configuration:
>>>>>
>>>>> export TEST_DEV=/dev/loop50
>>>>> export TEST_DIR=/mnt/test
>>>>> export SCRATCH_DEV=/dev/loop51
>>>>> export SCRATCH_MNT=/mnt/scratch
>>>>>
>>>>> export FSTYP=hfs
>>>>>
>>>> Ah, Missed that option. I will try with that in my next testing.
>>>>> Probably, you've missed FSTYP. Did you tried to run other file system at first
>>>>> (for example, ext4) to be sure that everything is good?
>>>>>
>>>> No, I barely squeezed in time today to the testing for the HFS so I
>>>> didn't do any preliminary testing but I will check that too my next run
>>>> before trying to test HFS.
>>>>>>
>>>>>> Ran the tests using:sudo ./check -g auto
>>>>>>
>>>>>
>>>>> You are brave guy. :) Currently, I am trying to fix the issues for quick group:
>>>>>
>>>>> sudo ./check -g quick
>>>>>
>>>> I thought I needed to do a more exhaustive testing so I went with auto.
>>>> I will try to experiment with quick my next round of testing. Thanks for
>>>> the heads up!
>>>>>> If more context is needed to know the point of failure or if I have made
>>>>>> a mistake during setup I'm happy to receive your comments since this is
>>>>>> my first time trying to run xfstests.
>>>>>>
>>>>>
>>>>> I don't see the crash on my side.
>>>>>
>>>>> sudo ./check generic/631
>>>>> FSTYP         -- hfs
>>>>> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #96 SMP
>>>>> PREEMPT_DYNAMIC Wed Nov 19 12:47:37 PST 2025
>>>>> MKFS_OPTIONS  -- /dev/loop51
>>>>> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
>>>>>
>>>>> generic/631       [not run] attr namespace trusted not supported by this
>>>>> filesystem type: hfs
>>>>> Ran: generic/631
>>>>> Not run: generic/631
>>>>> Passed all 1 tests
>>>>>
>>>>> This test simply is not running for HFS case.
>>>>>
>>>>> I see that HFS+ is failing for generic/631, but I don't see the crash. I am
>>>>> running 6.18.0-rc3+ but I am not sure that 6.18.0-rc5+ could change something
>>>>> dramatically.
>>>>>
>>>>> My guess that, maybe, xfstests suite is trying to run some other file system but
>>>>> not HFS.
>>>>>
>>>> I'm assuming that it's running HFSPLUS testing foir me because I just
>>>> realised that the package that I downloaded to do mkfs.hfs is just a
>>>> symlink to mkfs.hfsplus. Also I didn't find a package(in arch) for
>>>> mkfs.hfs in my quick little search now. All refer to mkfs.hfsplus as if
>>>> mkfs.hfs is deprecated somehow. I will probably build it from source if
>>>> available with fsck.hfs... Eitherway, even if i was testing for HFSPLUS
>>>> i don't think that a fail on generic/631 would crash my system multiple
>>>> times with different kernels. I would have to test with ext4 before and
>>>> play around more to find out why that happened..
>>>
>>> The mkfs.hfs is symlink on mkfs.hfsplus and the same for fsck. The mkfs.hfsplus
>>> can create HFS volume by using this option:
>>>
>>> -h create an HFS format filesystem (HFS Plus is the default)
>>>
>>> I don't have any special package installed for HFS on my side.
>>>
>> In my case, -h option in mkfs.hfsplus doesn't create hfs format
>> filesystem. I checked kernel docs and found this[1] which refers to a
>> package called hfsutils which has hformat as a binary for creating HFS
>> filesystems. I just got it and used it successfully. I will be rerunning
>> all tests soon.
>> [1]:https://docs.kernel.org/filesystems/hfs.html
>>> Thanks,
>>> Slava.
>>>
>> Also did you check my other comments on the code part of your last
>> reply? Just making sure. Thanks.
>>
>> Best Regards,
>> Mehdi Ben Hadj Khelifa
>>>>>>>>
>>>>>>>>      fs/hfs/super.c | 16 ++++++++++++----
>>>>>>>>      1 file changed, 12 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>>>>>>>> index 47f50fa555a4..06e1c25e47dc 100644
>>>>>>>> --- a/fs/hfs/super.c
>>>>>>>> +++ b/fs/hfs/super.c
>>>>>>>> @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
>>>>>>>>      {
>>>>>>>>      	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
>>>>>>>>      	hfs_mdb_close(sb);
>>>>>>>> -	/* release the MDB's resources */
>>>>>>>> -	hfs_mdb_put(sb);
>>>>>>>>      }
>>>>>>>>      
>>>>>>>>      static void flush_mdb(struct work_struct *work)
>>>>>>>> @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>>>>>      bail_no_root:
>>>>>>>>      	pr_err("get root inode failed\n");
>>>>>>>>      bail:
>>>>>>>> -	hfs_mdb_put(sb);
>>>>>>>>      	return res;
>>>>>>>>      }
>>>>>>>>      
>>>>>>>> @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
>>>>>>>>      	return 0;
>>>>>>>>      }
>>>>>>>>      
>>>>>>>> +static void hfs_kill_sb(struct super_block *sb)
>>>>>>>> +{
>>>>>>>> +	generic_shutdown_super(sb);
>>>>>>>> +	hfs_mdb_put(sb);
>>>>>>>> +	if (sb->s_bdev) {
>>>>>>>> +		sync_blockdev(sb->s_bdev);
>>>>>>>> +		bdev_fput(sb->s_bdev_file);
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static struct file_system_type hfs_fs_type = {
>>>>>>>>      	.owner		= THIS_MODULE,
>>>>>>>>      	.name		= "hfs",
>>>>>>>> -	.kill_sb	= kill_block_super,
>>>>>
>>>>> I've realized that if we are trying to solve the issue with pure call of
>>>>> kill_block_super() for the case of HFS/HFS+, then we could have the same trouble
>>>>> for other file systems. It make sense to check that we do not have likewise
>>>>> trouble for: bfs, hpfs, fat, nilfs2, ext2, ufs, adfs, omfs, isofs, udf, minix,
>>>>> jfs, squashfs, freevxfs, befs.
>>>> While I was doing my original fix for hfs, I did notice that too. Many
>>>> other filesystems(not all) don't have a "custom" super block destroyer
>>>> and they just refer to the generic kill_block_super() function which
>>>> might lead to the same problem as HFS and HFS+. That would more digging
>>>> too. I will see what I can do next when we finish HFS and potentially
>>>> HFS+ first.
>>>>>
>>>>>>>
>>>>>>> It looks like we have the same issue for the case of HFS+ [2]. Could you please
>>>>>>> double check that HFS+ should be fixed too?
>>>>>>>
>>>>>> I have checked the same error path and it seems that hfsplus_sb_info is
>>>>>> not freed in that path(I could provide the exact call stack which would
>>>>>> cause such a memory leak) although I didn't create or run any
>>>>>> reproducers for this particular filesystem type.
>>>>>> If you would like a patch for this issue, would something like what is
>>>>>> shown below be acceptable? :
>>>>>>
>>>>>> +static void hfsplus_kill_super(struct super_block *sb)
>>>>>> +{
>>>>>> +       struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
>>>>>> +
>>>>>> +       kill_block_super(sb);
>>>>>> +       kfree(sbi);
>>>>>> +}
>>>>>> +
>>>>>>      static struct file_system_type hfsplus_fs_type = {
>>>>>>             .owner          = THIS_MODULE,
>>>>>>             .name           = "hfsplus",
>>>>>> -       .kill_sb        = kill_block_super,
>>>>>> +       .kill_sb        = hfsplus_kill_super,
>>>>>>             .fs_flags       = FS_REQUIRES_DEV,
>>>>>>             .init_fs_context = hfsplus_init_fs_context,
>>>>>>      };
>>>>>>
>>>>>> If there is something to add, remove or adjust. Please let me know in
>>>>>> the case of you willing accepting such a patch of course.
>>>>>
>>>>> We call hfs_mdb_put() for the case of HFS:
>>>>>
>>>>> void hfs_mdb_put(struct super_block *sb)
>>>>> {
>>>>> 	if (!HFS_SB(sb))
>>>>> 		return;
>>>>> 	/* free the B-trees */
>>>>> 	hfs_btree_close(HFS_SB(sb)->ext_tree);
>>>>> 	hfs_btree_close(HFS_SB(sb)->cat_tree);
>>>>>
>>>>> 	/* free the buffers holding the primary and alternate MDBs */
>>>>> 	brelse(HFS_SB(sb)->mdb_bh);
>>>>> 	brelse(HFS_SB(sb)->alt_mdb_bh);
>>>>>
>>>>> 	unload_nls(HFS_SB(sb)->nls_io);
>>>>> 	unload_nls(HFS_SB(sb)->nls_disk);
>>>>>
>>>>> 	kfree(HFS_SB(sb)->bitmap);
>>>>> 	kfree(HFS_SB(sb));
>>>>> 	sb->s_fs_info = NULL;
>>>>> }
>>>>>
>>>>> So, we need likewise course of actions for HFS+ because we have multiple
>>>>> pointers in superblock too:
>>>>>
>>>> IIUC, hfs_mdb_put() isn't called in the case of hfs_kill_super() in
>>>> christian's patch because fill_super() (for the each specific
>>>> filesystem) is responsible for cleaning up the superblock in case of
>>>> failure and you can reference christian's patch[1] which he explained
>>>> the reasoning for here[2].And in the error path the we are trying to
>>>> fix, fill_super() isn't even called yet. So such pointers shouldn't be
>>>> pointing to anything allocated yet hence only freeing the pointer to the
>>>> sb_info here is sufficient I think.
> 
> I was confused that your code with hfs_mdb_put() is still in this email. So,
> yes, hfs_fill_super()/hfsplus_fill_super() try to free the memory in the case of
> failure. It means that if something wasn't been freed, then it will be issue in
> these methods. Then, I don't see what should else need to be added here. Some
> file systems do sb->s_fs_info = NULL. But absence of this statement is not
> critical, from my point of view.
> 
Thanks for the input. I will be sending the same mentionned patch after 
doing testing for it and also after finishing my testing for the hfs 
patch too.
> Thanks,
> Slava.
> 
Best Regards,
Mehdi Ben Hadj Khelifa
>>>> [1]:https://github.com/brauner/linux/commit/058747cefb26196f3c192c76c631051581b29b27
>>>> [2]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f@brauner/
>>>>> struct hfsplus_sb_info {
>>>>> 	void *s_vhdr_buf;
>>>>> 	struct hfsplus_vh *s_vhdr;
>>>>> 	void *s_backup_vhdr_buf;
>>>>> 	struct hfsplus_vh *s_backup_vhdr;
>>>>> 	struct hfs_btree *ext_tree;
>>>>> 	struct hfs_btree *cat_tree;
>>>>> 	struct hfs_btree *attr_tree;
>>>>> 	atomic_t attr_tree_state;
>>>>> 	struct inode *alloc_file;
>>>>> 	struct inode *hidden_dir;
>>>>> 	struct nls_table *nls;
>>>>>
>>>>> 	/* Runtime variables */
>>>>> 	u32 blockoffset;
>>>>> 	u32 min_io_size;
>>>>> 	sector_t part_start;
>>>>> 	sector_t sect_count;
>>>>> 	int fs_shift;
>>>>>
>>>>> 	/* immutable data from the volume header */
>>>>> 	u32 alloc_blksz;
>>>>> 	int alloc_blksz_shift;
>>>>> 	u32 total_blocks;
>>>>> 	u32 data_clump_blocks, rsrc_clump_blocks;
>>>>>
>>>>> 	/* mutable data from the volume header, protected by alloc_mutex */
>>>>> 	u32 free_blocks;
>>>>> 	struct mutex alloc_mutex;
>>>>>
>>>>> 	/* mutable data from the volume header, protected by vh_mutex */
>>>>> 	u32 next_cnid;
>>>>> 	u32 file_count;
>>>>> 	u32 folder_count;
>>>>> 	struct mutex vh_mutex;
>>>>>
>>>>> 	/* Config options */
>>>>> 	u32 creator;
>>>>> 	u32 type;
>>>>>
>>>>> 	umode_t umask;
>>>>> 	kuid_t uid;
>>>>> 	kgid_t gid;
>>>>>
>>>>> 	int part, session;
>>>>> 	unsigned long flags;
>>>>>
>>>>> 	int work_queued;               /* non-zero delayed work is queued */
>>>>> 	struct delayed_work sync_work; /* FS sync delayed work */
>>>>> 	spinlock_t work_lock;          /* protects sync_work and work_queued */
>>>>> 	struct rcu_head rcu;
>>>>> };
>>>>>
>>>>
>>>>
>>>>> Thanks,
>>>>> Slava.
>>>>>
>>>> Best Regards,
>>>> Mehdi Ben Hadj Khelifa
>>>>
>>>>>>
>>>>>>>> +	.kill_sb	= hfs_kill_sb,
>>>>>>>>      	.fs_flags	= FS_REQUIRES_DEV,
>>>>>>>>      	.init_fs_context = hfs_init_fs_context,
>>>>>>>>      };
>>>>>>>
>>>>>>> [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues
>>>>>>> [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/super.c#L694


