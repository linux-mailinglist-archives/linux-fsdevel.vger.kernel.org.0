Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6B5B39D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiIINv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiIINvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:51:33 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECBC6FDD
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 06:51:19 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MPHTL00yXzMqQm6;
        Fri,  9 Sep 2022 15:51:18 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MPHTJ66Tlzwy;
        Fri,  9 Sep 2022 15:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662731477;
        bh=zPZ48ZhF7Z2McjGXgAbGN1pcLdlRIJd3QjNPkTlMTp0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P3vldl6vznUMOOWUxxAzI4HJ7P89EZw2Nf+i8AUx945w+ihoH533ig33T9JucKcJr
         SnCf2nDk/JwBz42ZXRw+whkn5HrxBERNL3M3/Oas3udIogQa2uHiBhShOA+sZjgScw
         q1Sx3rbkG1los3wpy/1RaG/YpIjBtdhDU1H9R3Z8=
Message-ID: <b5984fd3-6310-9803-8b33-99715beeccfb@digikod.net>
Date:   Fri, 9 Sep 2022 15:51:16 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220908195805.128252-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/09/2022 21:58, Günther Noack wrote:
> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> 
> This flag hooks into the path_truncate LSM hook and covers file
> truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
> well as creat().
> 
> This change also increments the Landlock ABI version, updates
> corresponding selftests, and updates code documentation to document
> the flag.
> 
> The following operations are restricted:
> 
> open(): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
> implicitly truncated as part of the open() (e.g. using O_TRUNC).
> 
> Notable special cases:
> * open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
> * open() with O_TRUNC does *not* need the TRUNCATE right when it
>    creates a new file.
> 
> truncate() (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
> right.
> 
> ftruncate() (on a file): requires that the file had the TRUNCATE right
> when it was previously opened.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   include/uapi/linux/landlock.h                | 18 ++--
>   security/landlock/fs.c                       | 88 +++++++++++++++++++-
>   security/landlock/fs.h                       | 18 ++++
>   security/landlock/limits.h                   |  2 +-
>   security/landlock/setup.c                    |  1 +
>   security/landlock/syscalls.c                 |  2 +-
>   tools/testing/selftests/landlock/base_test.c |  2 +-
>   tools/testing/selftests/landlock/fs_test.c   |  7 +-
>   8 files changed, 124 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 23df4e0e8ace..8c0124c5cbe6 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -95,8 +95,16 @@ struct landlock_path_beneath_attr {
>    * A file can only receive these access rights:
>    *
>    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> - * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> + * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> + *   you might additionally need the `LANDLOCK_ACCESS_FS_TRUNCATE` right in
> + *   order to overwrite files with :manpage:`open(2)` using `O_TRUNC` or
> + *   :manpage:`creat(2)`.
>    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
> + *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> + *   `O_TRUNC`. The right to truncate a file gets carried along with an opened
> + *   file descriptor for the purpose of :manpage:`ftruncate(2)`.

You can add a bit to explain that it is the same behavior as for 
LANDLOCK_ACCESS_FS_{READ,WRITE}_FILE .


> This access
> + *   right is available since the third version of the Landlock ABI.
>    *
>    * A directory can receive access rights related to files or directories.  The
>    * following access right is applied to the directory itself, and the
> @@ -139,10 +147,9 @@ struct landlock_path_beneath_attr {
>    *
>    *   It is currently not possible to restrict some file-related actions
>    *   accessible through these syscall families: :manpage:`chdir(2)`,
> - *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
> - *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
> - *   :manpage:`utime(2)`, :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
> - *   :manpage:`access(2)`.
> + *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> + *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> + *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
>    *   Future Landlock evolutions will enable to restrict them.
>    */
>   /* clang-format off */
> @@ -160,6 +167,7 @@ struct landlock_path_beneath_attr {
>   #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
>   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> +#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>   /* clang-format on */
>   
>   #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index a9dbd99d9ee7..1b546edf69a6 100644
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
> @@ -761,6 +762,47 @@ static bool collect_domain_accesses(
>   	return ret;
>   }
>   
> +/**
> + * get_path_access_rights - Returns the subset of rights in access_request
> + * which are permitted for the given path.
> + *
> + * @domain: The domain that defines the current restrictions.
> + * @path: The path to get access rights for.
> + * @access_request: The rights we are interested in.
> + *
> + * Returns: The access mask of the rights that are permitted on the given path,
> + * which are also a subset of access_request (to save some calculation time).
> + */
> +static inline access_mask_t
> +get_path_access_rights(const struct landlock_ruleset *const domain,
> +		       const struct path *const path,
> +		       access_mask_t access_request)
> +{
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> +	unsigned long access_bit;
> +	unsigned long access_req;

unsigned long access_bit, long access_req;


> +
> +	init_layer_masks(domain, access_request, &layer_masks);
> +	if (!check_access_path_dual(domain, path, access_request, &layer_masks,
> +				    NULL, 0, NULL, NULL)) {
> +		/*
> +		 * Return immediately for successful accesses and for cases

Returns


> +		 * where everything is permitted because the path belongs to an
> +		 * internal filesystem.
> +		 */
> +		return access_request;
> +	}
> +
> +	access_req = access_request;
> +	for_each_set_bit(access_bit, &access_req, ARRAY_SIZE(layer_masks)) {
> +		if (layer_masks[access_bit]) {
> +			/* If any layer vetoed the access right, remove it. */
> +			access_request &= ~BIT_ULL(access_bit);
> +		}
> +	}
> +	return access_request;
> +}
> +
>   /**
>    * current_check_refer_path - Check if a rename or link action is allowed
>    *
> @@ -1142,6 +1184,11 @@ static int hook_path_rmdir(const struct path *const dir,
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
> @@ -1159,22 +1206,55 @@ static inline access_mask_t get_file_access(const struct file *const file)
>   	/* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
>   	if (file->f_flags & __FMODE_EXEC)
>   		access |= LANDLOCK_ACCESS_FS_EXECUTE;
> +

Not needed.


>   	return access;
>   }
>   
>   static int hook_file_open(struct file *const file)
>   {
> +	access_mask_t access_req, access_rights;
> +	const access_mask_t optional_rights = LANDLOCK_ACCESS_FS_TRUNCATE;
>   	const struct landlock_ruleset *const dom =
>   		landlock_get_current_domain();
>   
> -	if (!dom)
> +	if (!dom) {
> +		/* Grant all rights. */

Something like:
Grants all rights, even if most of them are not checked here, it is more 
consistent.


> +		landlock_file(file)->rights = LANDLOCK_MASK_ACCESS_FS;
>   		return 0;
> +	}
> +
>   	/*
>   	 * Because a file may be opened with O_PATH, get_file_access() may
>   	 * return 0.  This case will be handled with a future Landlock
>   	 * evolution.
>   	 */
> -	return check_access_path(dom, &file->f_path, get_file_access(file));
> +	access_req = get_file_access(file);
> +	access_rights = get_path_access_rights(dom, &file->f_path,
> +					       access_req | optional_rights);
> +	if (access_req & ~access_rights)
> +		return -EACCES;
> +
> +	/*
> +	 * For operations on already opened files (i.e. ftruncate()), it is the
> +	 * access rights at the time of open() which decide whether the
> +	 * operation is permitted. Therefore, we record the relevant subset of
> +	 * file access rights in the opened struct file.
> +	 */
> +	landlock_file(file)->rights = access_rights;
> +

Style preferences, but why do you use a new line here? I try to group 
code blocks until the return.


> +	return 0;
> +}
> +
> +static int hook_file_truncate(struct file *const file)
> +{
> +	/*
> +	 * We permit truncation if the truncation right was available at the

Allows truncation if the related right was…


> +	 * time of opening the file.

…to get a consistent access check as for read, write and execute operations.

This kind of explanation could be used to complete the documentation as 
well. The idea being to mimic the file mode check.


> +	 */
> +	if (!(landlock_file(file)->rights & LANDLOCK_ACCESS_FS_TRUNCATE))

I prefer to invert the "if" logic and return -EACCES by default.


> +		return -EACCES;
> +
> +	return 0;
>   }
>   
>   static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> @@ -1194,6 +1274,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
>   	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>   	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> +	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> +	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
>   
>   	LSM_HOOK_INIT(file_open, hook_file_open),
>   };
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 8db7acf9109b..275ba5375839 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -36,6 +36,18 @@ struct landlock_inode_security {
>   	struct landlock_object __rcu *object;
>   };
>   
> +/**
> + * struct landlock_file_security - File security blob
> + *
> + * This information is populated when opening a file in hook_file_open, and
> + * tracks the relevant Landlock access rights that were available at the time
> + * of opening the file. Other LSM hooks use these rights in order to authorize
> + * operations on already opened files.
> + */
> +struct landlock_file_security {
> +	access_mask_t rights;

I think it would make it more consistent to name it "access" to be in 
line with struct landlock_layer and other types.


> +};
> +
>   /**
>    * struct landlock_superblock_security - Superblock security blob
>    *
> @@ -50,6 +62,12 @@ struct landlock_superblock_security {
>   	atomic_long_t inode_refs;
>   };
>   
> +static inline struct landlock_file_security *
> +landlock_file(const struct file *const file)
> +{
> +	return file->f_security + landlock_blob_sizes.lbs_file;
> +}
> +
>   static inline struct landlock_inode_security *
>   landlock_inode(const struct inode *const inode)
>   {
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
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index f8e8e980454c..3f196d2ce4f9 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -19,6 +19,7 @@ bool landlock_initialized __lsm_ro_after_init = false;
>   
>   struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>   	.lbs_cred = sizeof(struct landlock_cred_security),
> +	.lbs_file = sizeof(struct landlock_file_security),
>   	.lbs_inode = sizeof(struct landlock_inode_security),
>   	.lbs_superblock = sizeof(struct landlock_superblock_security),
>   };
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
> index 45de42a027c5..87b28d14a1aa 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -406,9 +406,10 @@ TEST_F_FORK(layout1, inval)
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
> @@ -422,7 +423,7 @@ TEST_F_FORK(layout1, inval)
>   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
>   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
>   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> -	ACCESS_LAST)
> +	LANDLOCK_ACCESS_FS_REFER)
>   
>   /* clang-format on */
>   
