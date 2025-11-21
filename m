Return-Path: <linux-fsdevel+bounces-69466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF6C7BC8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 22:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E7B3A6A2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9AD2BE7DF;
	Fri, 21 Nov 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg7Wligd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9236D505
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761758; cv=none; b=f+CQ12fpQ4b//9gvyUqAeuiDqGG1QKtYB3CPRzr3Wim787CJc/ALBGD608iLo5E8TbiMUc1CLQt3lg6s+IC7y5TTfwF0Dys5vLZRlFiu+sr50bDTAQWDDIPt/hIRbw+c1jJv0J0ihbRdxaeLmGWiNb5QOcM11GwU24KAGAILrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761758; c=relaxed/simple;
	bh=VaCNC3d9lokqVq9Lu1iI7Xy7PcktOTPmKtGU2ROWGbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN3FzcqbaTpfigvrpnYNGZZUN/CUb1UFi6j9x97z9ixyY96xY9GXoVgAXE14+uzKOIzRpSQcF/9SoK5LCk91utw75YT4+S6DRA2Rz1gn/kMnJ8WZWJk6papicJCdt69e4emiiqAaH+BLoh5OwH3+nm3lE4V3DF+z+D9MhOajluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg7Wligd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c84bf326so199973f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763761755; x=1764366555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShgM055ssnixrmJjfqbroSni30Rw9PQ7MQEuAludf8M=;
        b=Mg7Wligd7VxJh78lubc2f2+nw1Ts96UA9aDoDao3IX6SKNLCmeZVSAmHy4Kkm+rprj
         VMdLPhJpXK2fKOp0mO4ozSJqQ31wZ/ok40iJODE0rD45Wrf28dN2sKpiOyBlhVE5my8p
         9/D0wv4p/eauWEw3FR5nc+rSIPMCxVRhDWyOpbLks8veFoqGqdzjZVdOsj4DdLhcBVRD
         RGyo/5wiU0Z/7Ka9ly3526hINfhZj6VahGgKqTDO3aiql0yD+uoC2a6t7wFC1Yb+vTpM
         +adn8WWp5OZU5ZRAIcbLbI9XMA60Fi2zDNULQf11ZLrjN+chQzqPDdSlaxgP0bD+ovAe
         1EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763761755; x=1764366555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShgM055ssnixrmJjfqbroSni30Rw9PQ7MQEuAludf8M=;
        b=OGXTP/Gt/OmvipKtAQGHTNbWHOIn+RDYF3AxX3qwsOGVog8cax1vgT1Y1MS9+05ifo
         3mA8LwRrWVtmyaafrwVdh541vFUcbz2agEFP67B5TwDW3AMFOuTWbtDepCR5FntpwSpC
         R9pQfn5SRTccViPp1lwwb3Yh8bOttFTGzxhUITUWgpIpeNN8sLG3xd0qhXdx6CvX8Orw
         9UX3ih0F8z1Q1QuWUhGa8v0KuHSyohvs+rOBHBNneaHt3PkKiPeFjGOmG3ajnYYNbDf3
         XSegRFzBU/BNjS9w0tunVtduWyXpgg8gQeAgddCE3oJfweiV+C/MVXhGFvSEawfgCBUg
         W+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXmEdioXtIP0UpqW4epGfTO7rs5CDrbnT9EHUp3w+pg8+Q6K0pb2rhiF8WvRjXFzg1CRxgluZxbjZbLQEXz@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPBt7HchipmYX0HedKim8JCvzPZyupYQVNeKd5EqQtkjevqAe
	nfPtKf3isn36TCIdppv+BNrV67+v/nt65wsW2rHoCyhGlGsJq6/1nUJI
X-Gm-Gg: ASbGncvepX1N913ojRWnsotUsB9pEljpcSBjn1yUOWvCQ6dPym+Zd0GywEewGDR56AG
	MCYvUWzP6Fq2qE3i6hM2xa65dzqnIkZTjwsDHfDu64H3w5Y90mIdUaCR18okaBnu0U91wjft4m+
	DrIHiNkh4YSsmEPw15BX0ux+rZeDwJdVQMsg7RTLPeKXb6nPniFBttQ7J8oYqxTMTiY+yOTgzGv
	2J6TbPheHTbTMrEM0AbiyNTuWAND6ojZ85mxcIJiteci14dB6D8qJg2wYCrh1wZHOQdv2+LdjZu
	8TIssMPo9BD7yOqdKI8OHBD4QVaqBTJlk96/qoNB1QbwqiEQ2mPnGjaxQ7jLFPYNZpgX7imEKz5
	kWPv2dW3kvBXgcEIBOl/aEIMIWNKCUVQ1GmSLE8HEgFUz0IajPgKzPdEQGyGjpb70jOH4hl9rvm
	0LwqlDMOB+axqBMaBHGkRQL0L2pjY=
X-Google-Smtp-Source: AGHT+IFYEZ1/6L9UETxi0/2KA4ED65LKTjmRNPVHgUUoHyk2J00ccx2iWQGqBPXNb4aIlMn5XfMtuw==
X-Received: by 2002:a05:600c:45d1:b0:477:9c73:268a with SMTP id 5b1f17b1804b1-477c01da8c0mr23195895e9.6.1763761754405;
        Fri, 21 Nov 2025 13:49:14 -0800 (PST)
Received: from [192.168.1.105] ([165.50.70.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a6bsm13196086f8f.28.2025.11.21.13.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 13:49:13 -0800 (PST)
Message-ID: <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
Date: Fri, 21 Nov 2025 23:48:54 +0100
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
 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "khalid@kernel.org" <khalid@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
 <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 10:15 PM, Viacheslav Dubeyko wrote:
> On Fri, 2025-11-21 at 20:44 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 11/19/25 8:58 PM, Viacheslav Dubeyko wrote:
>>> On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>> The regression introduced by commit aca740cecbe5 ("fs: open block device
>>>> after superblock creation") allows setup_bdev_super() to fail after a new
>>>> superblock has been allocated by sget_fc(), but before hfs_fill_super()
>>>> takes ownership of the filesystem-specific s_fs_info data.
>>>>
>>>> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
>>>> are never reached, leaving the HFS mdb structures attached to s->s_fs_info
>>>> unreleased.The default kill_block_super() teardown also does not free
>>>> HFS-specific resources, resulting in a memory leak on early mount failure.
>>>>
>>>> Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
>>>> hfs_put_super() and the hfs_fill_super() failure path into a dedicated
>>>> hfs_kill_sb() implementation. This ensures that both normal unmount and
>>>> early teardown paths (including setup_bdev_super() failure) correctly
>>>> release HFS metadata.
>>>>
>>>> This also preserves the intended layering: generic_shutdown_super()
>>>> handles VFS-side cleanup, while HFS filesystem state is fully destroyed
>>>> afterwards.
>>>>
>>>> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
>>>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>>>> Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>>>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>> ---
>>>> ChangeLog:
>>>>
>>>> Changes from v1:
>>>>
>>>> -Changed the patch direction to focus on hfs changes specifically as
>>>> suggested by al viro
>>>>
>>>> Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/
>>>>
>>>> Note:This patch might need some more testing as I only did run selftests
>>>> with no regression, check dmesg output for no regression, run reproducer
>>>> with no bug and test it with syzbot as well.
>>>
>>> Have you run xfstests for the patch? Unfortunately, we have multiple xfstests
>>> failures for HFS now. And you can check the list of known issues here [1]. The
>>> main point of such run of xfstests is to check that maybe some issue(s) could be
>>> fixed by the patch. And, more important that you don't introduce new issues. ;)
>>>
>> I have tried to run the xfstests with a kernel built with my patch and
>> also without my patch for TEST and SCRATCH devices and in both cases my
>> system crashes in running the generic/631 test.Still unsure of the
>> cause. For more context, I'm running the tests on the 6.18-rc5 version
>> of the kernel and the devices and the environment setup is as follows:
>>
>> For device creation and mounting(also tried it with dd and had same
>> results):
>> fallocate -l 10G test.img
>> fallocate -l 10G scratch.img
>> sudo mkfs.hfs test.img
>> sudo losetup /dev/loop0 ./test.img
>> sudo losetup /dev/loop1 ./scratch.img
>> sudo mkdir -p /mnt/test /mnt/scratch
>> sudo mount /dev/loop0 /mnt/test
>>
>> For environment setup(local.config):
>> export TEST_DEV=/dev/loop0
>> export TEST_DIR=/mnt/test
>> export SCRATCH_DEV=/dev/loop1
>> export SCRATCH_MNT=/mnt/scratch
> 
> This is my configuration:
> 
> export TEST_DEV=/dev/loop50
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/loop51
> export SCRATCH_MNT=/mnt/scratch
> 
> export FSTYP=hfs
> 
Ah, Missed that option. I will try with that in my next testing.
> Probably, you've missed FSTYP. Did you tried to run other file system at first
> (for example, ext4) to be sure that everything is good?
> 
No, I barely squeezed in time today to the testing for the HFS so I 
didn't do any preliminary testing but I will check that too my next run 
before trying to test HFS.
>>
>> Ran the tests using:sudo ./check -g auto
>>
> 
> You are brave guy. :) Currently, I am trying to fix the issues for quick group:
> 
> sudo ./check -g quick
> 
I thought I needed to do a more exhaustive testing so I went with auto. 
I will try to experiment with quick my next round of testing. Thanks for 
the heads up!
>> If more context is needed to know the point of failure or if I have made
>> a mistake during setup I'm happy to receive your comments since this is
>> my first time trying to run xfstests.
>>
> 
> I don't see the crash on my side.
> 
> sudo ./check generic/631
> FSTYP         -- hfs
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #96 SMP
> PREEMPT_DYNAMIC Wed Nov 19 12:47:37 PST 2025
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/631       [not run] attr namespace trusted not supported by this
> filesystem type: hfs
> Ran: generic/631
> Not run: generic/631
> Passed all 1 tests
> 
> This test simply is not running for HFS case.
> 
> I see that HFS+ is failing for generic/631, but I don't see the crash. I am
> running 6.18.0-rc3+ but I am not sure that 6.18.0-rc5+ could change something
> dramatically.
> 
> My guess that, maybe, xfstests suite is trying to run some other file system but
> not HFS.
> 
I'm assuming that it's running HFSPLUS testing foir me because I just 
realised that the package that I downloaded to do mkfs.hfs is just a 
symlink to mkfs.hfsplus. Also I didn't find a package(in arch) for 
mkfs.hfs in my quick little search now. All refer to mkfs.hfsplus as if 
mkfs.hfs is deprecated somehow. I will probably build it from source if 
available with fsck.hfs... Eitherway, even if i was testing for HFSPLUS 
i don't think that a fail on generic/631 would crash my system multiple 
times with different kernels. I would have to test with ext4 before and 
play around more to find out why that happened..
>>>>
>>>>    fs/hfs/super.c | 16 ++++++++++++----
>>>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>>>> index 47f50fa555a4..06e1c25e47dc 100644
>>>> --- a/fs/hfs/super.c
>>>> +++ b/fs/hfs/super.c
>>>> @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
>>>>    {
>>>>    	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
>>>>    	hfs_mdb_close(sb);
>>>> -	/* release the MDB's resources */
>>>> -	hfs_mdb_put(sb);
>>>>    }
>>>>    
>>>>    static void flush_mdb(struct work_struct *work)
>>>> @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>    bail_no_root:
>>>>    	pr_err("get root inode failed\n");
>>>>    bail:
>>>> -	hfs_mdb_put(sb);
>>>>    	return res;
>>>>    }
>>>>    
>>>> @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static void hfs_kill_sb(struct super_block *sb)
>>>> +{
>>>> +	generic_shutdown_super(sb);
>>>> +	hfs_mdb_put(sb);
>>>> +	if (sb->s_bdev) {
>>>> +		sync_blockdev(sb->s_bdev);
>>>> +		bdev_fput(sb->s_bdev_file);
>>>> +	}
>>>> +
>>>> +}
>>>> +
>>>>    static struct file_system_type hfs_fs_type = {
>>>>    	.owner		= THIS_MODULE,
>>>>    	.name		= "hfs",
>>>> -	.kill_sb	= kill_block_super,
> 
> I've realized that if we are trying to solve the issue with pure call of
> kill_block_super() for the case of HFS/HFS+, then we could have the same trouble
> for other file systems. It make sense to check that we do not have likewise
> trouble for: bfs, hpfs, fat, nilfs2, ext2, ufs, adfs, omfs, isofs, udf, minix,
> jfs, squashfs, freevxfs, befs.
While I was doing my original fix for hfs, I did notice that too. Many 
other filesystems(not all) don't have a "custom" super block destroyer 
and they just refer to the generic kill_block_super() function which 
might lead to the same problem as HFS and HFS+. That would more digging 
too. I will see what I can do next when we finish HFS and potentially 
HFS+ first.
> 
>>>
>>> It looks like we have the same issue for the case of HFS+ [2]. Could you please
>>> double check that HFS+ should be fixed too?
>>>
>> I have checked the same error path and it seems that hfsplus_sb_info is
>> not freed in that path(I could provide the exact call stack which would
>> cause such a memory leak) although I didn't create or run any
>> reproducers for this particular filesystem type.
>> If you would like a patch for this issue, would something like what is
>> shown below be acceptable? :
>>
>> +static void hfsplus_kill_super(struct super_block *sb)
>> +{
>> +       struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
>> +
>> +       kill_block_super(sb);
>> +       kfree(sbi);
>> +}
>> +
>>    static struct file_system_type hfsplus_fs_type = {
>>           .owner          = THIS_MODULE,
>>           .name           = "hfsplus",
>> -       .kill_sb        = kill_block_super,
>> +       .kill_sb        = hfsplus_kill_super,
>>           .fs_flags       = FS_REQUIRES_DEV,
>>           .init_fs_context = hfsplus_init_fs_context,
>>    };
>>
>> If there is something to add, remove or adjust. Please let me know in
>> the case of you willing accepting such a patch of course.
> 
> We call hfs_mdb_put() for the case of HFS:
> 
> void hfs_mdb_put(struct super_block *sb)
> {
> 	if (!HFS_SB(sb))
> 		return;
> 	/* free the B-trees */
> 	hfs_btree_close(HFS_SB(sb)->ext_tree);
> 	hfs_btree_close(HFS_SB(sb)->cat_tree);
> 
> 	/* free the buffers holding the primary and alternate MDBs */
> 	brelse(HFS_SB(sb)->mdb_bh);
> 	brelse(HFS_SB(sb)->alt_mdb_bh);
> 
> 	unload_nls(HFS_SB(sb)->nls_io);
> 	unload_nls(HFS_SB(sb)->nls_disk);
> 
> 	kfree(HFS_SB(sb)->bitmap);
> 	kfree(HFS_SB(sb));
> 	sb->s_fs_info = NULL;
> }
> 
> So, we need likewise course of actions for HFS+ because we have multiple
> pointers in superblock too:
> 
IIUC, hfs_mdb_put() isn't called in the case of hfs_kill_super() in 
christian's patch because fill_super() (for the each specific 
filesystem) is responsible for cleaning up the superblock in case of 
failure and you can reference christian's patch[1] which he explained 
the reasoning for here[2].And in the error path the we are trying to 
fix, fill_super() isn't even called yet. So such pointers shouldn't be 
pointing to anything allocated yet hence only freeing the pointer to the 
sb_info here is sufficient I think.
[1]:https://github.com/brauner/linux/commit/058747cefb26196f3c192c76c631051581b29b27
[2]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f@brauner/
> struct hfsplus_sb_info {
> 	void *s_vhdr_buf;
> 	struct hfsplus_vh *s_vhdr;
> 	void *s_backup_vhdr_buf;
> 	struct hfsplus_vh *s_backup_vhdr;
> 	struct hfs_btree *ext_tree;
> 	struct hfs_btree *cat_tree;
> 	struct hfs_btree *attr_tree;
> 	atomic_t attr_tree_state;
> 	struct inode *alloc_file;
> 	struct inode *hidden_dir;
> 	struct nls_table *nls;
> 
> 	/* Runtime variables */
> 	u32 blockoffset;
> 	u32 min_io_size;
> 	sector_t part_start;
> 	sector_t sect_count;
> 	int fs_shift;
> 
> 	/* immutable data from the volume header */
> 	u32 alloc_blksz;
> 	int alloc_blksz_shift;
> 	u32 total_blocks;
> 	u32 data_clump_blocks, rsrc_clump_blocks;
> 
> 	/* mutable data from the volume header, protected by alloc_mutex */
> 	u32 free_blocks;
> 	struct mutex alloc_mutex;
> 
> 	/* mutable data from the volume header, protected by vh_mutex */
> 	u32 next_cnid;
> 	u32 file_count;
> 	u32 folder_count;
> 	struct mutex vh_mutex;
> 
> 	/* Config options */
> 	u32 creator;
> 	u32 type;
> 
> 	umode_t umask;
> 	kuid_t uid;
> 	kgid_t gid;
> 
> 	int part, session;
> 	unsigned long flags;
> 
> 	int work_queued;               /* non-zero delayed work is queued */
> 	struct delayed_work sync_work; /* FS sync delayed work */
> 	spinlock_t work_lock;          /* protects sync_work and work_queued */
> 	struct rcu_head rcu;
> };
> 


> Thanks,
> Slava.
>
Best Regards,
Mehdi Ben Hadj Khelifa

>>
>>>> +	.kill_sb	= hfs_kill_sb,
>>>>    	.fs_flags	= FS_REQUIRES_DEV,
>>>>    	.init_fs_context = hfs_init_fs_context,
>>>>    };
>>>
>>> [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues
>>> [2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/super.c#L694


