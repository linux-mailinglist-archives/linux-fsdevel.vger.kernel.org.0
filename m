Return-Path: <linux-fsdevel+bounces-3260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC18E7F1D79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691E11F25E7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7736B19;
	Mon, 20 Nov 2023 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tXfUcHq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8B1131
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 11:43:34 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYyc43LlMzMq31f;
	Mon, 20 Nov 2023 19:43:32 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYyc34b9jzMpnPj;
	Mon, 20 Nov 2023 20:43:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1700509412;
	bh=YClZIIHMyrXFCRMMGiLDrVUNx1LJtpllduk5rgMesRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXfUcHq9M2l7cs5ZBcCze2Xloh6889NcwAXiWs4FUWyFD/RE5RER8Ix1MIYT6m++S
	 B+ox84Q8nvHmh4GRSTktDzjVWv/zL7dbO0+4O4CSfW33PCf23Xsg0bHhDeIDcZauGh
	 tiop27YuLWDqV582KE4CQWrsiWtYJ+azmiWYCa3E=
Date: Mon, 20 Nov 2023 20:43:30 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] landlock: Add IOCTL access right
Message-ID: <20231120.fau2Oi6queij@digikod.net>
References: <20231117154920.1706371-1-gnoack@google.com>
 <20231117154920.1706371-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117154920.1706371-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 17, 2023 at 04:49:15PM +0100, Günther Noack wrote:
> Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> and increments the Landlock ABI version to 5.
> 
> Like the truncate right, these rights are associated with a file
> descriptor at the time of open(2), and get respected even when the
> file descriptor is used outside of the thread which it was originally
> opened in.
> 
> A newly enabled Landlock policy therefore does not apply to file
> descriptors which are already open.
> 
> If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
> of safe IOCTL commands will be permitted on newly opened files.  The
> permitted IOCTLs can be configured through the ruleset in limited ways
> now.  (See documentation for details.)
> 
> Noteworthy scenarios which require special attention:
> 
> TTY devices support IOCTLs like TIOCSTI and TIOCLINUX, which can be
> used to control shell processes on the same terminal which run at
> different privilege levels, which may make it possible to escape a
> sandbox.  Because stdin, stdout and stderr are normally inherited
> rather than newly opened, IOCTLs are usually permitted on them even
> after the Landlock policy is enforced.
> 
> Some legitimate file system features, like setting up fscrypt, are
> exposed as IOCTL commands on regular files and directories -- users of
> Landlock are advised to double check that the sandboxed process does
> not need to invoke these IOCTLs.
> 
> Known limitations:
> 
> The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
> over IOCTL commands.  Future work will enable a more fine-grained
> access control for IOCTLs.
> 
> In the meantime, Landlock users may use path-based restrictions in
> combination with their knowledge about the file system layout to
> control what IOCTLs can be done.  Mounting file systems with the nodev
> option can help to distinguish regular files and devices, and give
> guarantees about the affected files, which Landlock alone can not give
> yet.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h                |  58 ++++++-
>  security/landlock/fs.c                       | 150 ++++++++++++++++++-
>  security/landlock/fs.h                       |  11 ++
>  security/landlock/limits.h                   |  15 +-
>  security/landlock/ruleset.h                  |   2 +-
>  security/landlock/syscalls.c                 |  10 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  8 files changed, 233 insertions(+), 20 deletions(-)
> 

> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 93c9c6f91556..75e822f878e0 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,20 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>  
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS	LANDLOCK_ACCESS_FS_IOCTL
> +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS	((LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1) - 1)
> +
> +/*
> + * These are synthetic access rights, which are only used within the kernel, but
> + * not exposed to callers in userspace.  The mapping between these access rights
> + * and IOCTL commands is defined in the required_ioctl_access() helper function.
> + */
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 3)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 4)

Please move this LANDLOCK_ACCESS_FS_IOCTL_* block to fs.h

We can still create the public and private masks in limits.h but add a
static_assert() to make sure there is no overlap.

> +
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_GROUP4
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  #define LANDLOCK_SHIFT_ACCESS_FS	0
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index c7f1526784fd..5a28ea8e1c3d 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -30,7 +30,7 @@
>  	LANDLOCK_ACCESS_FS_REFER)
>  /* clang-format on */
>  
> -typedef u16 access_mask_t;
> +typedef u32 access_mask_t;
>  /* Makes sure all filesystem access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>  /* Makes sure all network access rights can be stored. */
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 898358f57fa0..c196cac2a5fb 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -137,7 +137,7 @@ static const struct file_operations ruleset_fops = {
>  	.write = fop_dummy_write,
>  };
>  
> -#define LANDLOCK_ABI_VERSION 4
> +#define LANDLOCK_ABI_VERSION 5
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -192,8 +192,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  		return err;
>  
>  	/* Checks content (and 32-bits cast). */
> -	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
> -	    LANDLOCK_MASK_ACCESS_FS)
> +	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_PUBLIC_ACCESS_FS) !=
> +	    LANDLOCK_MASK_PUBLIC_ACCESS_FS)

It would now be possible to add LANDLOCK_ACCESS_FS_IOCTL_GROUP* to a
rule, which is not part of the API/ABI. I've sent a patch with new tests
to make sure this is covered:
https://lore.kernel.org/r/20231120193914.441117-2-mic@digikod.net

I'll push it in my -next branch if everything is OK before pushing your
next series. Please review it.

>  		return -EINVAL;
>  

