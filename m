Return-Path: <linux-fsdevel+bounces-68615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A61CC61947
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 18:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 83162291C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E011130EF91;
	Sun, 16 Nov 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jujxuJqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D9286A7;
	Sun, 16 Nov 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313373; cv=none; b=IM3PeKEAj1WgZLkEYqkxSxggGIK7peQw6aoFBhNt7H+pEUPpU26Fa2cFgj5LNQSa1s1DyNhyJQofItNw0WdUoS5m3ePNf7lgH/TDUO2cPxIRIuo/NJIe/1yMWFBHMyKLjSaL8mu1lSUNeRnZd0GC4/qA6ut3VcnAZ46qhgzTVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313373; c=relaxed/simple;
	bh=/aS5zOK93eyNIDDSGRNBWnqRTTEpByObHgcF6orN4Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdz0dx0/0JtHbAt0DYKyuzM2Rjj9fHL59+PUvRzo2ORGQUfqyPazjpWp3bRyKy2oGokn+1rViv58T9jBApP/YGxEHSUETihGmhS4pkN8JVBOVE/5SSZg77KhfEq0Ed83339wsYyAfPo77cj6tEP/CRWXDALEDz/29+kVDRKOKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jujxuJqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB34C16AAE;
	Sun, 16 Nov 2025 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763313371;
	bh=/aS5zOK93eyNIDDSGRNBWnqRTTEpByObHgcF6orN4Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jujxuJqfEHQLA+NHUZtmuGW81W1OL1qTjc5WyfrkQftkmGPK/zBQzbVt9iCpAA1oe
	 eV4iWJF8aZwgSEzgVawAZxt6qwtJM9riD1s2xCfBtZnVaDJfY67sYec8l1E1BwUGrT
	 ne0AXCC4cEGXSAx9hONsxDx+NWdin5jmGJYp/cO7PKIOsTy1QaBsMS2gIq8/8sXSKW
	 dh3f6gm9soJeSlOw/UkCWIHfFz9ybmiZ4kOWi9ldf9L7+Kh0CAbx+9nji2SbQuZb1A
	 k2Cm/rs2qWps2B0rjtvlV6TbhjGTKw0yACvKl1vuToWrd3hYf33MI0d3CJqGaXy8sA
	 A/YK4OZgtqdWg==
Date: Sun, 16 Nov 2025 19:15:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
Message-ID: <aRoGw9gml3vozrbz@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-6-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-6-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:51PM -0500, Pasha Tatashin wrote:
> Introduce the user-space interface for the Live Update Orchestrator
> via ioctl commands, enabling external control over the live update
> process and management of preserved resources.
> 
> The idea is that there is going to be a single userspace agent driving
> the live update, therefore, only a single process can ever hold this
> device opened at a time.
> 
> The following ioctl commands are introduced:
> 
> LIVEUPDATE_IOCTL_CREATE_SESSION
> Provides a way for userspace to create a named session for grouping file
> descriptors that need to be preserved. It returns a new file descriptor
> representing the session.
> 
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> Allows the userspace agent in the new kernel to reclaim a preserved
> session by its name, receiving a new file descriptor to manage the
> restored resources.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/uapi/linux/liveupdate.h  |  66 +++++++++++-
>  kernel/liveupdate/luo_internal.h |  21 ++++
>  kernel/liveupdate/luo_ioctl.c    | 178 +++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> index d2ef2f7e0dbd..6e04254ee535 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -44,6 +44,70 @@
>  #define LIVEUPDATE_IOCTL_TYPE		0xBA
>  
>  /* The maximum length of session name including null termination */
> -#define LIVEUPDATE_SESSION_NAME_LENGTH 56
> +#define LIVEUPDATE_SESSION_NAME_LENGTH 64
> +
> +/* The /dev/liveupdate ioctl commands */
> +enum {
> +	LIVEUPDATE_CMD_BASE = 0x00,
> +	LIVEUPDATE_CMD_CREATE_SESSION = LIVEUPDATE_CMD_BASE,
> +	LIVEUPDATE_CMD_RETRIEVE_SESSION = 0x01,
> +};
> +
> +/**
> + * struct liveupdate_ioctl_create_session - ioctl(LIVEUPDATE_IOCTL_CREATE_SESSION)
> + * @size:	Input; sizeof(struct liveupdate_ioctl_create_session)
> + * @fd:		Output; The new file descriptor for the created session.
> + * @name:	Input; A null-terminated string for the session name, max
> + *		length %LIVEUPDATE_SESSION_NAME_LENGTH including termination
> + *		char.

Nit:          ^ character

> + *
> + * Creates a new live update session for managing preserved resources.
> + * This ioctl can only be called on the main /dev/liveupdate device.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +struct liveupdate_ioctl_create_session {
> +	__u32		size;
> +	__s32		fd;
> +	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +};
> +
> +#define LIVEUPDATE_IOCTL_CREATE_SESSION					\
> +	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_CREATE_SESSION)
> +
> +/**
> + * struct liveupdate_ioctl_retrieve_session - ioctl(LIVEUPDATE_IOCTL_RETRIEVE_SESSION)
> + * @size:    Input; sizeof(struct liveupdate_ioctl_retrieve_session)
> + * @fd:      Output; The new file descriptor for the retrieved session.
> + * @name:    Input; A null-terminated string identifying the session to retrieve.
> + *           The name must exactly match the name used when the session was
> + *           created in the previous kernel.
> + *
> + * Retrieves a handle (a new file descriptor) for a preserved session by its
> + * name. This is the primary mechanism for a userspace agent to regain control
> + * of its preserved resources after a live update.
> + *
> + * The userspace application provides the null-terminated `name` of a session
> + * it created before the live update. If a preserved session with a matching
> + * name is found, the kernel instantiates it and returns a new file descriptor
> + * in the `fd` field. This new session FD can then be used for all file-specific
> + * operations, such as restoring individual file descriptors with
> + * LIVEUPDATE_SESSION_RETRIEVE_FD.
> + *
> + * It is the responsibility of the userspace application to know the names of
> + * the sessions it needs to retrieve. If no session with the given name is
> + * found, the ioctl will fail with -ENOENT.
> + *
> + * This ioctl can only be called on the main /dev/liveupdate device when the
> + * system is in the LIVEUPDATE_STATE_UPDATED state.
> + */
> +struct liveupdate_ioctl_retrieve_session {
> +	__u32		size;
> +	__s32		fd;
> +	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +};
> +
> +#define LIVEUPDATE_IOCTL_RETRIEVE_SESSION \
> +	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_RETRIEVE_SESSION)
>  
>  #endif /* _UAPI_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 245373edfa6f..5185ad37a8c1 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -9,6 +9,27 @@
>  #define _LINUX_LUO_INTERNAL_H
>  
>  #include <linux/liveupdate.h>
> +#include <linux/uaccess.h>
> +
> +struct luo_ucmd {
> +	void __user *ubuffer;
> +	u32 user_size;
> +	void *cmd;
> +};
> +
> +static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
> +				   size_t kernel_cmd_size)
> +{
> +	/*
> +	 * Copy the minimum of what the user provided and what we actually
> +	 * have.
> +	 */
> +	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
> +			 min_t(size_t, ucmd->user_size, kernel_cmd_size))) {
> +		return -EFAULT;
> +	}
> +	return 0;
> +}
>  
>  /**
>   * struct luo_session - Represents an active or incoming Live Update session.
> diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
> index 44d365185f7c..367385efa962 100644
> --- a/kernel/liveupdate/luo_ioctl.c
> +++ b/kernel/liveupdate/luo_ioctl.c
> @@ -5,15 +5,192 @@
>   * Pasha Tatashin <pasha.tatashin@soleen.com>
>   */
>  
> +/**
> + * DOC: LUO ioctl Interface
> + *
> + * The IOCTL user-space control interface for the LUO subsystem.
> + * It registers a character device, typically found at ``/dev/liveupdate``,
> + * which allows a userspace agent to manage the LUO state machine and its
> + * associated resources, such as preservable file descriptors.
> + *
> + * To ensure that the state machine is controlled by a single entity, access
> + * to this device is exclusive: only one process is permitted to have
> + * ``/dev/liveupdate`` open at any given time. Subsequent open attempts will
> + * fail with -EBUSY until the first process closes its file descriptor.
> + * This singleton model simplifies state management by preventing conflicting
> + * commands from multiple userspace agents.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/atomic.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <linux/liveupdate.h>
>  #include <linux/miscdevice.h>
> +#include <uapi/linux/liveupdate.h>
> +#include "luo_internal.h"
>  
>  struct luo_device_state {
>  	struct miscdevice miscdev;
> +	atomic_t in_use;
> +};
> +
> +static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
> +	struct file *file;
> +	int err;
> +
> +	argp->fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (argp->fd < 0)
> +		return argp->fd;
> +
> +	err = luo_session_create(argp->name, &file);
> +	if (err)
> +		goto err_put_fd;
> +
> +	err = luo_ucmd_respond(ucmd, sizeof(*argp));
> +	if (err)
> +		goto err_put_file;
> +
> +	fd_install(argp->fd, file);
> +
> +	return 0;
> +
> +err_put_file:
> +	fput(file);
> +err_put_fd:
> +	put_unused_fd(argp->fd);
> +
> +	return err;
> +}
> +
> +static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
> +	struct file *file;
> +	int err;
> +
> +	argp->fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (argp->fd < 0)
> +		return argp->fd;
> +
> +	err = luo_session_retrieve(argp->name, &file);
> +	if (err < 0)
> +		goto err_put_fd;
> +
> +	err = luo_ucmd_respond(ucmd, sizeof(*argp));
> +	if (err)
> +		goto err_put_file;
> +
> +	fd_install(argp->fd, file);
> +
> +	return 0;
> +
> +err_put_file:
> +	fput(file);
> +err_put_fd:
> +	put_unused_fd(argp->fd);
> +
> +	return err;
> +}
> +
> +static int luo_open(struct inode *inodep, struct file *filep)
> +{
> +	struct luo_device_state *ldev = container_of(filep->private_data,
> +						     struct luo_device_state,
> +						     miscdev);
> +
> +	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
> +		return -EBUSY;
> +
> +	luo_session_deserialize();

Why luo_session_deserialize() is tied to the first open of the chardev?

> +
> +	return 0;
> +}
> +

-- 
Sincerely yours,
Mike.

