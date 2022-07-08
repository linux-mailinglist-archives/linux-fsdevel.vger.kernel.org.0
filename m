Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9871A56B846
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 13:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiGHLRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 07:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiGHLRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:17:36 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jul 2022 04:17:35 PDT
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E4C88F39
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 04:17:34 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LfW312vc3zMpnlb;
        Fri,  8 Jul 2022 13:17:33 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LfW3073dLzln2Fy;
        Fri,  8 Jul 2022 13:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1657279053;
        bh=3ihbiLzyjyLzxY0td1hZ3S4AHqV5y3I4JQz7Ed6bT8U=;
        h=Date:To:References:Cc:From:Subject:In-Reply-To:From;
        b=v1AaLINLE0r1JZi09MqfXgeQv5xXMg/8D1GrFRVpT18BHbo84leV//mm9vyqeUURB
         AEImnWRILdlo8AkCjO/zYBljUut4tMPlq1hGsjBLtrjrcuByzZbJoX1PdREXq0DL/u
         il+k7rVH2mLW9aoVPYGs2PDGKJpHx75nlI8jhnQ4=
Message-ID: <78bf2921-388b-df21-303c-c7d1eaa5b681@digikod.net>
Date:   Fri, 8 Jul 2022 13:17:32 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <20220707200612.132705-2-gnoack3000@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 1/2] landlock: Support truncate(2).
In-Reply-To: <20220707200612.132705-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No final dot for a subject please.

On 07/07/2022 22:06, Günther Noack wrote:
> Add support for restricting the use of the truncate(2) and
> ftruncate(2) family of syscalls with Landlock.
> 
> This change also updates the Landlock ABI version and updates the
> existing Landlock tests to match the new ABI version.
> 
> Technically, unprivileged processes can already restrict the use of
> truncate(2) with seccomp-bpf.
> 
> Using Landlock instead of seccomp-bpf has the folowwing advantages:

typo: following

> 
> - it doesn't require the use of BPF (conceptually simpler)
> 
> - callers don't need to keep track of lists of syscall numbers for
>    different architectures and kernel versions
> 
> - the restriction policy can be configured per file hierarchy.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   include/uapi/linux/landlock.h                | 2 ++
>   security/landlock/fs.c                       | 9 ++++++++-
>   security/landlock/limits.h                   | 2 +-
>   security/landlock/syscalls.c                 | 2 +-
>   tools/testing/selftests/landlock/base_test.c | 2 +-
>   tools/testing/selftests/landlock/fs_test.c   | 7 ++++---
>   6 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 23df4e0e8ace..2351050d4773 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -134,6 +134,7 @@ struct landlock_path_beneath_attr {
>    *   directory) parent.  Otherwise, such actions are denied with errno set to
>    *   EACCES.  The EACCES errno prevails over EXDEV to let user space
>    *   efficiently deal with an unrecoverable error.
> + * - %LANDLOCK_ACCESS_FS_TRUNCATE%: Truncate a file.

We need to specify the ABI version starting to support this right.

>    *
>    * .. warning::

You need to remove truncate(2) from this warning block.

>    *
> @@ -160,6 +161,7 @@ struct landlock_path_beneath_attr {
>   #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
>   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> +#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>   /* clang-format on */
>   
>   #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index ec5a6247cd3e..c57f581a9cd5 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -146,7 +146,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>   #define ACCESS_FILE ( \
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> -	LANDLOCK_ACCESS_FS_READ_FILE)
> +	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   /* clang-format on */
>   
>   /*
> @@ -1140,6 +1141,11 @@ static int hook_path_rmdir(const struct path *const dir,
>   	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
>   }
>   
> +static int hook_path_truncate(const struct path *const path)
> +{
> +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> +}
> +
>   /* File hooks */
>   
>   static inline access_mask_t get_file_access(const struct file *const file)
> @@ -1192,6 +1198,7 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
>   	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>   	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> +	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
>   
>   	LSM_HOOK_INIT(file_open, hook_file_open),
>   };
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index b54184ab9439..82288f0e9e5e 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,7 @@
>   #define LANDLOCK_MAX_NUM_LAYERS		16
>   #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>   
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_REFER
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
>   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>   
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 735a0865ea11..f4d6fc7ed17f 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
>   	.write = fop_dummy_write,
>   };
>   
> -#define LANDLOCK_ABI_VERSION 2
> +#define LANDLOCK_ABI_VERSION 3
>   
>   /**
>    * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index da9290817866..72cdae277b02 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>   	const struct landlock_ruleset_attr ruleset_attr = {
>   		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>   	};
> -	ASSERT_EQ(2, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
>   					     LANDLOCK_CREATE_RULESET_VERSION));
>   
>   	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 21a2ce8fa739..cb77eaa01c91 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -399,9 +399,10 @@ TEST_F_FORK(layout1, inval)
>   #define ACCESS_FILE ( \
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> -	LANDLOCK_ACCESS_FS_READ_FILE)
> +	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_REFER
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
>   
>   #define ACCESS_ALL ( \
>   	ACCESS_FILE | \
> @@ -415,7 +416,7 @@ TEST_F_FORK(layout1, inval)
>   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
>   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
>   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> -	ACCESS_LAST)
> +	LANDLOCK_ACCESS_FS_REFER)

I created ACCESS_LAST to store the last access right while avoiding to 
copy it in ACCESS_FILE or ACCESS_ALL, and then avoid forgetting about 
new access right, but I now think it is not worth it and I prefer your 
approach which will be easier to maintain.

>   
>   /* clang-format on */
>   
