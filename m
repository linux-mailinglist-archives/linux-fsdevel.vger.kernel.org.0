Return-Path: <linux-fsdevel+bounces-69451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679AC7B5F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA783A4E1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B342F362B;
	Fri, 21 Nov 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfDS3qM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15927B32D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750670; cv=none; b=ElpSaBGASljXr9X9ChA9v9z7qjk+AhVxepiHw7WvafOd8j4yZ7jgHBjmClOoN1mYH1O4IM07mDaHDedMNYrb0k7WCcoMhPHldCR+IErKoYBH18w+6sS+/+T7X/d9aIZt2DLuLfYGpJpyMp4cSNypgzmh+5rlYIaThkvwW1bniPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750670; c=relaxed/simple;
	bh=xs873lP2qfM/5k9HQFM+nsmWeoIPWrEybL41vtvJ+iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHMmGKhbvRRd3JW4WenFv+U0AiGPWFSd37FvdfBtjKKZqDArJRqgXhLeGd2XonRdxFIAzjzKHdFbKXI2qlo5lljPz12i8p5pRS7WD/ssFdUPF+qefGgzkxVXBfZORlpcqobobjyH3Obf0lt6A3qgLbqSTk8boQif2GzFM++KtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfDS3qM3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b55ba1e62so177997f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763750667; x=1764355467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kbZldhfPU7Rvn2reEs+OkYe904af99Ncl1hi8HiSUU=;
        b=kfDS3qM34l9g/eyzEfeeNiGoVEM/PXEu4ill0Ec2qp1qD+khm5hnLbt00r13W1kujo
         oRVuP3/i3deaeyE3rvu0XGBDS7Jxa1JQqPlHMzYad9bx2X1qpyCZm1lzsEeUSyL/oe8+
         Km5D8VBauupBrEv5i1lXEM5aSnYXJLgRgR3qV6SyvLnYiKJhJyVR9yV3+ZXQtaqoBjii
         Fm5BkDKmJIuse8a9P3RpG2LXU+MyJmhKLsr9YMKr8BFQZ/GviQrPmeMNy6YWNUbGEnF3
         UJJQ1H8UQlrNieOnby2eurXhbLIPVLMOIE4IXfZSMzzWVp140Oww9T3El//uOzGdrRTe
         ladw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763750667; x=1764355467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kbZldhfPU7Rvn2reEs+OkYe904af99Ncl1hi8HiSUU=;
        b=u+ja3Tz2FwxzzmSMBfFynstJWEZZPBK3acDFbeHMC7YXrV4AxUxhcU0I56YjYQvK/v
         wulZ3GyGG/4th0urKGPQ5P2cU5HxormaWrDHuv+O2gFujIUatOtryLXsnv74GtRkN17L
         w5kxMxohVH0YvdtNgEMAiFc2Lg9AToDqlWiHlKdLVxG26cK4WoTrc+YjAxUG4jwHTSqz
         VSyb4YmTXPId3I5xPpd60TwcNjpL0Y0O2U+bBJF4y5OTIjH5ib8VMYJ5SUVFFZikEMo2
         W0fslr4mj+Kkyq/4KSjLGIdsUcRqVqb1Wm32Nrv+wNI2ePXEKM57dT5haUW12/seReW9
         CF0A==
X-Forwarded-Encrypted: i=1; AJvYcCW1Frf/3rwgR4Tmp/VgUltpjahdv6qof+yaPKSI1wDD1n0qxL/ynZMfh4y2xyF7V0+pVgaWa6jBi5JceiXW@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaVgWxaBtyxhJ/81lw+L69XrKYfB+jtwj1J6Fh72LrSf9sfRo
	Xb6/1c0/Lwl9k9xQlceAk3N92QWwkWfs5ewT/W8dtvmsMw9Xlz/TpVU3
X-Gm-Gg: ASbGncvLFKvCjzARZvgnknVgnD3v0lDNl/iHJStcjaNICN4kkpuHNACKR7dXUCKOb65
	3ECVxzmQxReIbvx9RT9NHQDCpijKB1vmdXullgF1NfNTq/qGWq/yKPanh7AJbgiSlSZcTDfT68h
	KX5DHjXgO425TeWyuOnKMwLLnS7NfcCLci9c1DgkYcRuwTSJ37x7P30MkPvDmNjEpz+TSMobQrS
	14PZeYpEx0TlXdcw4KY0mqlHJ0fyQmZ1yoB7/pGNlGn11yTFFfBMmKSkfNE1EvdbIEtHM/NtBGd
	VuPRo7msWghCc12AyBu2ULI/UyY0VPbIC7KuEFzT78wTEC1bUozUFUgx9Q/CvTT+qlO6q4WxZVt
	CKbiYzdtST9OHPPIrhnXf2n+NhtmQ4S5zx8hjbhmaOofOrth3OUqsHYbgruVAd1CvqLTd1GIi9s
	+/mi58fNabEpZrNwRsr2MBvJ5U7ds=
X-Google-Smtp-Source: AGHT+IFkSly13mqDBCmwEwYfW9NieAAUkgKyRNW0RsRA2Vw0zRJZrc4jelR19X0rHc2qDJ05zM9xjQ==
X-Received: by 2002:a05:600c:5487:b0:477:a16e:fec5 with SMTP id 5b1f17b1804b1-477c00f4cb0mr19903895e9.0.1763750666624;
        Fri, 21 Nov 2025 10:44:26 -0800 (PST)
Received: from [192.168.1.105] ([165.50.70.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e454sm12620407f8f.2.2025.11.21.10.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 10:44:26 -0800 (PST)
Message-ID: <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
Date: Fri, 21 Nov 2025 20:44:07 +0100
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
I have tried to run the xfstests with a kernel built with my patch and 
also without my patch for TEST and SCRATCH devices and in both cases my 
system crashes in running the generic/631 test.Still unsure of the 
cause. For more context, I'm running the tests on the 6.18-rc5 version 
of the kernel and the devices and the environment setup is as follows:

For device creation and mounting(also tried it with dd and had same 
results):
fallocate -l 10G test.img
fallocate -l 10G scratch.img
sudo mkfs.hfs test.img
sudo losetup /dev/loop0 ./test.img
sudo losetup /dev/loop1 ./scratch.img
sudo mkdir -p /mnt/test /mnt/scratch
sudo mount /dev/loop0 /mnt/test

For environment setup(local.config):
export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt/scratch

Ran the tests using:sudo ./check -g auto

If more context is needed to know the point of failure or if I have made 
a mistake during setup I'm happy to receive your comments since this is 
my first time trying to run xfstests.

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
I have checked the same error path and it seems that hfsplus_sb_info is 
not freed in that path(I could provide the exact call stack which would 
cause such a memory leak) although I didn't create or run any 
reproducers for this particular filesystem type.
If you would like a patch for this issue, would something like what is 
shown below be acceptable? :

+static void hfsplus_kill_super(struct super_block *sb)
+{
+       struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+
+       kill_block_super(sb);
+       kfree(sbi);
+}
+
  static struct file_system_type hfsplus_fs_type = {
         .owner          = THIS_MODULE,
         .name           = "hfsplus",
-       .kill_sb        = kill_block_super,
+       .kill_sb        = hfsplus_kill_super,
         .fs_flags       = FS_REQUIRES_DEV,
         .init_fs_context = hfsplus_init_fs_context,
  };

If there is something to add, remove or adjust. Please let me know in 
the case of you willing accepting such a patch of course.
> Thanks,
> Slava.
> 
Best Regards,
Mehdi Ben Hadj Khelifa
>> +	.kill_sb	= hfs_kill_sb,
>>   	.fs_flags	= FS_REQUIRES_DEV,
>>   	.init_fs_context = hfs_init_fs_context,
>>   };
> 
> [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues
> [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/super.c#L694


