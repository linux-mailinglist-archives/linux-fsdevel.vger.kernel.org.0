Return-Path: <linux-fsdevel+bounces-31470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E9E997583
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 21:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69715280FB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5B1E1A36;
	Wed,  9 Oct 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hKq5LyrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CE15CD49;
	Wed,  9 Oct 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501632; cv=none; b=NyZ4E0WzPohsKz2w9t8u+HM6yxItPjN+/AziHMnz/o93OsJA+HL+LgpiBAojRb0/s9gEDSb9fxfRdMOAIQ6yy2rLUjTmWcRXshAcdlsgtCKPmQhLvpC0suwDMMqKSLcHC0+bb+2ifTOX2omk8pvlKQTmrvZg7tG8b4DnKoVg8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501632; c=relaxed/simple;
	bh=vaFkN0y+BNJI4hpWx9vTBvxzUz2+CG3St1LnByGwgBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sv9uL2l2MeE1EJ1bMUuCRl1xLW5WF7bCC+ANTsXSCnjJoANVyGfieclaAoLp2rldrP7fJ79hPOjeC1uCoW8Y3bzfByN1NiCYM831A8W+YKWVHQOS76CnRNWhOw1LHXy8kO2YXRMBCZ0EK2WIkVIQVccFHmG0eNNqHfUtFmSAgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hKq5LyrD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B673742B27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728501629; bh=NFviVX6j8uoh4WNDflXHr0jIuDjjpUm7uym8YfejszM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hKq5LyrDtlrqbNzbqYGA0gOoNl8uPiRPMtFw5Ajbk+izIzknVl0BhuHHdtTNbnvve
	 t1UVx8u5j3B2I536JDmlzFtss1/mJcszQFlrSsO5Rltktd1IQPIKaJ/SlGa+WS5P7y
	 uxZuCU9MBkH3k5KmgElcu9z0WFiBxNDuItiiOfIqFaOC8DZIjm9CW05nV4j7LtDyXa
	 pAVq0b2uwt3JcKddIKZLzBoGz/tjaynGzXTxF38/UgrabPOrGzjPNvVE9JdL/YwkaU
	 yDdm72ub45A1Hbhi+zuq0nZ89O0rK3K/G9dA7XU9eHrQVgrpwQfu8vVUIMIjtVqNdt
	 FR5aKKQ2a56gA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B673742B27;
	Wed,  9 Oct 2024 19:20:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org
Cc: christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
In-Reply-To: <20241008121930.869054-1-luca.boccassi@gmail.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
Date: Wed, 09 Oct 2024 13:20:28 -0600
Message-ID: <87msjd9j7n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

luca.boccassi@gmail.com writes:

> As discussed at LPC24, add an ioctl with an extensible struct
> so that more parameters can be added later if needed. Start with
> returning pid/tgid/ppid and creds unconditionally, and cgroupid
> optionally.

I was looking this over, and a couple of questions came to mind...

> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---

[...]

> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 80675b6bf884..15cdc7fe4968 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -2,6 +2,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/cgroup.h>
>  #include <linux/magic.h>
>  #include <linux/mount.h>
>  #include <linux/pid.h>
> @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	return poll_flags;
>  }
>  
> +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> +{
> +	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> +	size_t usize = _IOC_SIZE(cmd);
> +	struct pidfd_info kinfo = {};
> +	struct user_namespace *user_ns;
> +	const struct cred *c;
> +	__u64 request_mask;
> +
> +	if (!uinfo)
> +		return -EINVAL;
> +	if (usize < sizeof(struct pidfd_info))
> +		return -EINVAL; /* First version, no smaller struct possible */
> +
> +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> +		return -EFAULT;

You don't check request_mask for unrecognized flags, so user space will
not get an error if it puts random gunk there.  That, in turn, can make
it harder to add new options in the future.

> +	c = get_task_cred(task);
> +	if (!c)
> +		return -ESRCH;

[...]

> +
> +	/*
> +	 * If userspace and the kernel have the same struct size it can just
> +	 * be copied. If userspace provides an older struct, only the bits that
> +	 * userspace knows about will be copied. If userspace provides a new
> +	 * struct, only the bits that the kernel knows about will be copied and
> +	 * the size value will be set to the size the kernel knows about.
> +	 */
> +	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> +		return -EFAULT;

Which "size value" are you referring to here; I can't see it.

If user space has a bigger struct, should you perhaps zero-fill the part
the kernel doesn't know about?

> +	return 0;
> +}

Thanks,

jon

