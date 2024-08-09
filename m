Return-Path: <linux-fsdevel+bounces-25514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811194CFC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB251C2119C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C2193091;
	Fri,  9 Aug 2024 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPA+x8Vb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9601553A2;
	Fri,  9 Aug 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205222; cv=none; b=rVFo88RD+u7H16yDOmFOkEmDioh9wOZRQVujnVXigGIctiP8523qiIMjeUKPPqarqx3IE//3TuGFLcrCLcK4bGzHICSFe0j3rVjXtldrso/8Ur0LoKz3XdAcWNONCwamhLsWS37yNI1Kr3ulbUeYIHkFUst4moHUMiiZ5MheYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205222; c=relaxed/simple;
	bh=/NP9gyaLS6iHtfsvWA3Hg6gmTFIGO8vbtF6ApVr6rZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXyBVweZT5cmjMltGWqdyCCmYvBwTixEqSqaNTCQVqgmIWBwFAgBzCd4ns1cJf3OxQ4m1gZc+v86Bss0zPrYuseBdGpPBIwxmmNOMi/HK0KBzn4LDvEgAEvA99e/r8jNJHvC1W0NL5/QrWXlPx4kBRydDoF2xiioNlr/qxVPecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPA+x8Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671B2C32782;
	Fri,  9 Aug 2024 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723205221;
	bh=/NP9gyaLS6iHtfsvWA3Hg6gmTFIGO8vbtF6ApVr6rZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPA+x8VbxzwL2mxP4Z8AK6xDfUbweE6//yRn5mbn/sClpWOtD+Lfmh84WFAYRQKlO
	 wlkVCxP+zg52jmPz2XkGzpEB3W1fku95SS1GFiHXz4iANhPz0ILZIp2sJ/dC2YJRfv
	 hf9tYmAqGkjdJzDtdUn744z5JMOjUuOSaNMr4t6Dh9Z2d+tBRJc+pFhz5Mg0u1c+M7
	 /XiMlnGXKWJA3C6Y2f+l6PmYRnYxi4MSbgr4g6N2TL8g758dhx/bs0ZAi0QdgXewYz
	 BDVeVMFTbVz3ti0igeBxdW/7g2pglywZCtrX/dXawQGVwqbKnMSfWN5Zn7JdUAJX9e
	 E+RSkUEd+1iyw==
Date: Fri, 9 Aug 2024 14:06:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 09/16] fanotify: allow to set errno in FAN_DENY
 permission response
Message-ID: <20240809-seemeilen-rundum-2096794f9851@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <a28e072cd17de44133b5bce5b8ee6db880523ebb.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a28e072cd17de44133b5bce5b8ee6db880523ebb.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:11PM GMT, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> With FAN_DENY response, user trying to perform the filesystem operation
> gets an error with errno set to EPERM.
> 
> It is useful for hierarchical storage management (HSM) service to be able
> to deny access for reasons more diverse than EPERM, for example EAGAIN,
> if HSM could retry the operation later.
> 
> Allow fanotify groups with priority FAN_CLASSS_PRE_CONTENT to responsd
> to permission events with the response value FAN_DENY_ERRNO(errno),
> instead of FAN_DENY to return a custom error.
> 
> Limit custom error values to errors expected on read(2)/write(2) and
> open(2) of regular files. This list could be extended in the future.
> Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
> writing a response to an fanotify group fd with a value of FAN_NOFD in
> the fd field of the response.
> 
> The change in fanotify_response is backward compatible, because errno is
> written in the high 8 bits of the 32bit response field and old kernels
> reject respose value with high bits set.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 18 ++++++++++-----
>  fs/notify/fanotify/fanotify.h      | 10 +++++++++
>  fs/notify/fanotify/fanotify_user.c | 36 +++++++++++++++++++++++++-----
>  include/linux/fanotify.h           |  5 ++++-
>  include/uapi/linux/fanotify.h      |  7 ++++++
>  5 files changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 4e8dce39fa8f..1cbf41b34080 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -224,7 +224,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  				 struct fanotify_perm_event *event,
>  				 struct fsnotify_iter_info *iter_info)
>  {
> -	int ret;
> +	int ret, errno;
> +	u32 decision;
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>  
> @@ -257,20 +258,27 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  		goto out;
>  	}
>  
> +	decision = fanotify_get_response_decision(event->response);
>  	/* userspace responded, convert to something usable */
> -	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
> +	switch (decision & FANOTIFY_RESPONSE_ACCESS) {
>  	case FAN_ALLOW:
>  		ret = 0;
>  		break;
>  	case FAN_DENY:
> +		/* Check custom errno from pre-content events */
> +		errno = fanotify_get_response_errno(event->response);

Fwiw, you're fetching from event->response again but have already
stashed it in @decision earlier. Probably just an oversight.

> +		if (errno) {
> +			ret = -errno;
> +			break;
> +		}
> +		fallthrough;
>  	default:
>  		ret = -EPERM;
>  	}
>  
>  	/* Check if the response should be audited */
> -	if (event->response & FAN_AUDIT)
> -		audit_fanotify(event->response & ~FAN_AUDIT,
> -			       &event->audit_rule);
> +	if (decision & FAN_AUDIT)
> +		audit_fanotify(decision & ~FAN_AUDIT, &event->audit_rule);
>  
>  	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
>  		 group, event, ret);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 7f06355afa1f..d0722ef13138 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -528,3 +528,13 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
>  
>  	return mflags;
>  }
> +
> +static inline u32 fanotify_get_response_decision(u32 res)
> +{
> +	return res & (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS);
> +}
> +
> +static inline int fanotify_get_response_errno(int res)
> +{
> +	return res >> FAN_ERRNO_SHIFT;
> +}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index ed56fe6f5ec7..0a37f1c761aa 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -337,11 +337,13 @@ static int process_access_response(struct fsnotify_group *group,
>  	struct fanotify_perm_event *event;
>  	int fd = response_struct->fd;
>  	u32 response = response_struct->response;
> +	u32 decision = fanotify_get_response_decision(response);
> +	int errno = fanotify_get_response_errno(response);
>  	int ret = info_len;
>  	struct fanotify_response_info_audit_rule friar;
>  
> -	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%zu\n", __func__,
> -		 group, fd, response, info, info_len);
> +	pr_debug("%s: group=%p fd=%d response=%x errno=%d buf=%p size=%zu\n",
> +		 __func__, group, fd, response, errno, info, info_len);
>  	/*
>  	 * make sure the response is valid, if invalid we do nothing and either
>  	 * userspace can send a valid response or we will clean it up after the
> @@ -350,18 +352,42 @@ static int process_access_response(struct fsnotify_group *group,
>  	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
>  		return -EINVAL;
>  
> -	switch (response & FANOTIFY_RESPONSE_ACCESS) {
> +	switch (decision & FANOTIFY_RESPONSE_ACCESS) {
>  	case FAN_ALLOW:
> +		if (errno)
> +			return -EINVAL;
> +		break;
>  	case FAN_DENY:
> +		/* Custom errno is supported only for pre-content groups */
> +		if (errno && group->priority != FSNOTIFY_PRIO_PRE_CONTENT)
> +			return -EINVAL;
> +
> +		/*
> +		 * Limit errno to values expected on open(2)/read(2)/write(2)
> +		 * of regular files.
> +		 */
> +		switch (errno) {
> +		case 0:
> +		case EIO:
> +		case EPERM:
> +		case EBUSY:
> +		case ETXTBSY:
> +		case EAGAIN:
> +		case ENOSPC:
> +		case EDQUOT:
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> +	if ((decision & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
>  		return -EINVAL;
>  
> -	if (response & FAN_INFO) {
> +	if (decision & FAN_INFO) {
>  		ret = process_access_response_info(info, info_len, &friar);
>  		if (ret < 0)
>  			return ret;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index ae6cb2688d52..547514542669 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -132,7 +132,10 @@
>  /* These masks check for invalid bits in permission responses. */
>  #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
>  #define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
> -#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
> +#define FANOTIFY_RESPONSE_ERRNO	(FAN_ERRNO_MASK << FAN_ERRNO_SHIFT)
> +#define FANOTIFY_RESPONSE_VALID_MASK \
> +	(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
> +	 FANOTIFY_RESPONSE_ERRNO)
>  
>  /* Do not use these old uapi constants internally */
>  #undef FAN_ALL_CLASS_BITS
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index cc28dce5f744..7b746c5fcbd8 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -233,6 +233,13 @@ struct fanotify_response_info_audit_rule {
>  /* Legit userspace responses to a _PERM event */
>  #define FAN_ALLOW	0x01
>  #define FAN_DENY	0x02
> +/* errno other than EPERM can specified in upper byte of deny response */
> +#define FAN_ERRNO_BITS	8
> +#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
> +#define FAN_ERRNO_MASK	((1 << FAN_ERRNO_BITS) - 1)
> +#define FAN_DENY_ERRNO(err) \
> +	(FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT))
> +
>  #define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
>  #define FAN_INFO	0x20	/* Bitmask to indicate additional information */
>  
> -- 
> 2.43.0
> 

