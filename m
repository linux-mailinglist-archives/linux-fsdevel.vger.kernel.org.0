Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055354DB598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbiCPQII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbiCPQHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6362A2B;
        Wed, 16 Mar 2022 09:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1826D61559;
        Wed, 16 Mar 2022 16:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1F0C340E9;
        Wed, 16 Mar 2022 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647446789;
        bh=yAOYmTLS/MbtW4UXom//Z0Kovckbzucj/rCvXtamwA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bz1g2NRBc7+jkFjjikA7EbQZ0ZzD7uPFXxb5c5KjRMkBVTPDrE5ykFce2DVpww5z0
         c2cVY3ZPessDpiTDE3e6VLBwPAzgEgQa2K7XdbIPSyFfz+CBOR0Sh0Yq7goPkIBfvQ
         QD6i2oZk99scOxVpSyKIeUQ0YQXw3nRlZSoskhmLhHa27XzJzX2FYgKVQjFubNAiy2
         FyXF0gfh8YY20Fnz8FfZWHD0FQitDCkNpMMP7qo2PTUk8FNgXEcCiwL0jd0OlqzYzJ
         tmfnCKLFQ7pSU3BO9pY+RttAHaDwgZVyeK9aqX+SIkJOcnZSCmZeSZngjDOyd0fxyb
         zjpW8YfAGKIcg==
Date:   Wed, 16 Mar 2022 16:06:26 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH v2 2/4] btrfs: mark device addition as mnt_want_write_file
Message-ID: <YjILAo2ueZsnhza/@debian9.Home>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:22:38PM +0900, Naohiro Aota wrote:
> btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
> file-system internal writing. That writing can cause a deadlock with
> FS freezing like as described in like as described in commit
> 26559780b953 ("btrfs: zoned: mark relocation as writing").
> 
> Mark the device addition as mnt_want_write_file. This is also consistent
> with the removing device ioctl counterpart.
> 
> Cc: stable@vger.kernel.org # 4.9+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/ioctl.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 60c907b14547..a6982a1fde65 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3474,8 +3474,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>  	return ret;
>  }
>  
> -static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
> +static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
>  {
> +	struct inode *inode = file_inode(file);
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_ioctl_vol_args *vol_args;
>  	bool restore_op = false;
>  	int ret;
> @@ -3488,6 +3490,10 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>  		return -EINVAL;
>  	}
>  
> +	ret = mnt_want_write_file(file);
> +	if (ret)
> +		return ret;

So, this now breaks all test cases that exercise device seeding, and I clearly
forgot about seeding when I asked about why not use mnt_want_write_file()
instead of a bare call to sb_start_write():

$ ./check btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian9 5.17.0-rc8-btrfs-next-114 #2 SMP PREEMPT Wed Mar 16 14:10:07 WET 2022
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/161 1s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/161.out.bad)
    --- tests/btrfs/161.out	2020-06-10 19:29:03.822519250 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/161.out.bad	2022-03-16 15:48:10.835678228 +0000
    @@ -3,7 +3,3 @@
     0000000 abab abab abab abab abab abab abab abab
     *
     1000000
    --- sprout --
    -0000000 abab abab abab abab abab abab abab abab
    -*
    -1000000
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/161.out /home/fdmanana/git/hub/xfstests/results//btrfs/161.out.bad'  to see the entire diff)
btrfs/162 1s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/162.out.bad)
    --- tests/btrfs/162.out	2020-06-10 19:29:03.822519250 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/162.out.bad	2022-03-16 15:48:12.815741973 +0000
    @@ -3,7 +3,3 @@
     0000000 abab abab abab abab abab abab abab abab
     *
     1000000
    --- sprout --
    -0000000 abab abab abab abab abab abab abab abab
    -*
    -1000000
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/162.out /home/fdmanana/git/hub/xfstests/results//btrfs/162.out.bad'  to see the entire diff)
btrfs/163 2s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/163.out.bad)
    --- tests/btrfs/163.out	2020-11-05 15:55:23.585035140 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/163.out.bad	2022-03-16 15:48:15.215819215 +0000
    @@ -3,10 +3,3 @@
     0000000 abab abab abab abab abab abab abab abab
     *
     20000000
    --- sprout --
    -0000000 abab abab abab abab abab abab abab abab
    -*
    -20000000
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/163.out /home/fdmanana/git/hub/xfstests/results//btrfs/163.out.bad'  to see the entire diff)
btrfs/164 1s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/164.out.bad)
    --- tests/btrfs/164.out	2020-06-10 19:29:03.822519250 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/164.out.bad	2022-03-16 15:48:17.291886010 +0000
    @@ -3,7 +3,3 @@
     0000000 abab abab abab abab abab abab abab abab
     *
     1000000
    --- sprout --
    -0000000 abab abab abab abab abab abab abab abab
    -*
    -1000000
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/164.out /home/fdmanana/git/hub/xfstests/results//btrfs/164.out.bad'  to see the entire diff)
btrfs/248 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/248.out.bad)
    --- tests/btrfs/248.out	2021-10-26 11:04:03.879678608 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/248.out.bad	2022-03-16 15:48:19.363952657 +0000
    @@ -1,2 +1,9 @@
     QA output created by 248
    +ERROR: bad magic on superblock on /dev/sdd at 65536
    +mount: /home/fdmanana/btrfs-tests/scratch_1: wrong fs type, bad option, bad superblock on /dev/sdd, missing codepage or helper program, or other error.
    +cat: /sys/fs/btrfs//devinfo/2/fsid: No such file or directory
    +Usage: grep [OPTION]... PATTERNS [FILE]...
    +Try 'grep --help' for more information.
    +cat: /sys/fs/btrfs//devinfo/1/fsid: No such file or directory
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/248.out /home/fdmanana/git/hub/xfstests/results//btrfs/248.out.bad'  to see the entire diff)
Ran: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
Failures: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
Failed 5 of 5 tests

So device seeding introduces a special case. If we mount a seeding
filesystem, it's RO, so the mnt_want_write_file() fails.

Something like this deals with it and it makes the tests pass:

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d7d9e1f39b87..4f347e363a8e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3472,6 +3472,7 @@ static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
 {
        struct inode *inode = file_inode(file);
        struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+       const bool seeding = fs_info->fs_devices->seeding;
        struct btrfs_ioctl_vol_args *vol_args;
        bool restore_op = false;
        int ret;
@@ -3484,9 +3485,13 @@ static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
                return -EINVAL;
        }
 
-       ret = mnt_want_write_file(file);
-       if (ret)
-               return ret;
+       if (seeding) {
+               sb_start_write(fs_info->sb);
+       } else {
+               ret = mnt_want_write_file(file);
+               if (ret)
+                       return ret;
+       }
 
        if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
                if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
@@ -3520,7 +3525,12 @@ static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
                btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
        else
                btrfs_exclop_finish(fs_info);
-       mnt_drop_write_file(file);
+
+       if (seeding)
+               sb_end_write(fs_info->sb);
+       else
+               mnt_drop_write_file(file);
+
        return ret;
 }

We are also changing the semantics as we no longer allow for adding a device
to a RO filesystem. So the lack of a mnt_want_write_file() was intentional
to deal with the seeding filesystem case. But calling mnt_want_write_file()
if we are not seeding, changes the semantics - I'm not sure if anyone relies
on the ability to add a device to a fs mounted RO, I'm not seeing if it's an
useful use case.

So either we do that special casing like in that diff, or we always do the
sb_start_write() / sb_end_write() - in any case please add a comment explaining
why we do it like that, why we can't use mnt_want_write_file().
 
Thanks.


> +
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
>  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
>  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> @@ -3520,6 +3526,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
>  	else
>  		btrfs_exclop_finish(fs_info);
> +	mnt_drop_write_file(file);
>  	return ret;
>  }
>  
> @@ -5443,7 +5450,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>  	case BTRFS_IOC_RESIZE:
>  		return btrfs_ioctl_resize(file, argp);
>  	case BTRFS_IOC_ADD_DEV:
> -		return btrfs_ioctl_add_dev(fs_info, argp);
> +		return btrfs_ioctl_add_dev(file, argp);
>  	case BTRFS_IOC_RM_DEV:
>  		return btrfs_ioctl_rm_dev(file, argp);
>  	case BTRFS_IOC_RM_DEV_V2:
> -- 
> 2.35.1
> 
