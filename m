Return-Path: <linux-fsdevel+bounces-65294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9CC0090F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8481D19A81A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AD430B508;
	Thu, 23 Oct 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLokn6j7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622622765DC;
	Thu, 23 Oct 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216413; cv=none; b=J7acZ53Z08PuI0EZ94hojatEirftDrp9WXg5qkcBAkfJI3/SU8yJrIKpyeY84JfavYr9Pt7eA0VXrrfIZwTupibz/vbKJo1ZYsX43B99IwVxUTGis1V6vBqP55s2JalCr2mzwYIvKwLJIlZ/fojSOYLZjU0FUWhvb267sYP92JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216413; c=relaxed/simple;
	bh=4Nycx1ORZclwlAUuSrDPm+Q6EH8JvLo9+c1zBeefgcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbHMTTQpLwl2OGBKFVjSqqSs5a7Kl03vI7CkwY/b+MOtlAdKnt80XVYlnIPw9fy+aqVGiGgUv0Eo8R0gZ4Ef4lHRZpI4TgpCPRs7CkHjpL98MI/jN8P97crQHkOOD1X62f310tNVtCXmzuyO8cpNGs/fohkpICcaRYMV4zVVX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLokn6j7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B7C4CEE7;
	Thu, 23 Oct 2025 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761216412;
	bh=4Nycx1ORZclwlAUuSrDPm+Q6EH8JvLo9+c1zBeefgcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MLokn6j7bsPTtDKzR8pqjp2OIR+OMKA1rj3J/6jxNvlhgcsOoQ+moyQ5GdMJY0dDs
	 Znmt5H3FHjRCN/E5Q2OiSn3Lge5IHCXD/l7T7/WJ6bkLphXMC2HXV8rhysZfDX6Sr+
	 rNUl8sN5/1gEAa9ysrMEafdWcYQ0VQhevGk1H7BhaFT8iiTd5n9BTY4verf1aGvcpu
	 2n7qQ7sTY81LVQ1UhGF1Gtff22NCJXEfiZHTApKvHY7cQr6tmKVbYlAGr+xV9kWFbP
	 87li730Z1OQYtoHcpFjViMqnavqolBedQ+OYK4M6H1LebiK34NEzwo7Gy1V6/AuNf7
	 96d0cS8eISSpA==
Message-ID: <5b287ec6-72ff-4707-9040-3c84efc58b94@kernel.org>
Date: Thu, 23 Oct 2025 12:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/32] pidfs: validate extensible ioctls
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10. 09. 25, 16:36, Christian Brauner wrote:
> Validate extensible ioctls stricter than we do now.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/pidfs.c         |  2 +-
>   include/linux/fs.h | 14 ++++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..0a5083b9cce5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
>   		 * erronously mistook the file descriptor for a pidfd.
>   		 * This is not perfect but will catch most cases.
>   		 */
> -		return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> +		return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);

Hi,

this turned EINVAL (from pidfd_info()) into ENOTTY (from pidfd_ioctl()) 
for at least LTP's:
struct pidfd_info_invalid {
	uint32_t dummy;
};

#define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct 
pidfd_info_invalid)

ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) == EINVAL

at:
https://github.com/linux-test-project/ltp/blob/9bb94efa39bb1b08f37e56c7437db5fa13ddcae2/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c#L46

Is this expected?

> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -4023,4 +4023,18 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
>   
>   int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
>   
> +static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> +					  unsigned int cmd_b, size_t min_size)
> +{
> +	if (_IOC_DIR(cmd_a) != _IOC_DIR(cmd_b))
> +		return false;
> +	if (_IOC_TYPE(cmd_a) != _IOC_TYPE(cmd_b))
> +		return false;
> +	if (_IOC_NR(cmd_a) != _IOC_NR(cmd_b))
> +		return false;
> +	if (_IOC_SIZE(cmd_a) < min_size)
> +		return false;
> +	return true;
> +}
> +
>   #endif /* _LINUX_FS_H */
> 

thanks,
-- 
js
suse labs


