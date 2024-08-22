Return-Path: <linux-fsdevel+bounces-26743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C8495B8BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D0C1F25BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3861CC14E;
	Thu, 22 Aug 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1zTUDJDX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tpsywLou";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1zTUDJDX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tpsywLou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053861CC179
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337723; cv=none; b=elzwdJds7z3+s1uAamUMdELzJ4p0ZEAysSoon2ruALi1l8Ep4hJ7gJkuo30ioEdFDQNJyr8rgAGSeHQE5RYiGRVnvsdHunn0KNfHoUwRWzwSK6v+/N3F+FNC56wLDuAK5IiUDhtuNaABA0qKIBGmDfDrvrAQG/TQm8jG72f02XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337723; c=relaxed/simple;
	bh=djEAi+EcoKN3EddrveS51hobDOGugoZFsDhL+RncXPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqGObmZNrqdHXG9Ijtj93auD47TY82w/oZsc0zA+LVfU/bDWhHsEL15t6V0/UAcsk8peX+Gz/mhf9HvmpOe0crwGvYV+lpdr4DL4rA3T3SeKfz9TOF1z1zgVw6Rhmir0avKLmWKgowAhQ51ACD1chlFXnsVvwse6/YY+kFNdD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1zTUDJDX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tpsywLou; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1zTUDJDX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tpsywLou; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 326A621FE0;
	Thu, 22 Aug 2024 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724337720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaiNFercyjSU1gCDFlq9+we6qY7P7NGuCyxgdh0VoAs=;
	b=1zTUDJDXXiAmoHgG8NG7/Bi6bOndeemeXUy+AnpD6LKzLdUIvyLjPx5EfBbcCcSsYZ7TXA
	muEujSL2jJ2VtnHk1/wQ49BEi+TMs+CDwMSqtrpZfhf+9R76PTbP0FzkSi2bd7jewDYQms
	u8TGqWtbL40UdESNo/r7Jw5YQHbcnMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724337720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaiNFercyjSU1gCDFlq9+we6qY7P7NGuCyxgdh0VoAs=;
	b=tpsywLougvyw4e5fBOb3dWOIwtfsl7SCyZfaobbvWfsCj6/0ML9BB8wVnOCEj5qmXtogpC
	HukcjKn4y/hM0+Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724337720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaiNFercyjSU1gCDFlq9+we6qY7P7NGuCyxgdh0VoAs=;
	b=1zTUDJDXXiAmoHgG8NG7/Bi6bOndeemeXUy+AnpD6LKzLdUIvyLjPx5EfBbcCcSsYZ7TXA
	muEujSL2jJ2VtnHk1/wQ49BEi+TMs+CDwMSqtrpZfhf+9R76PTbP0FzkSi2bd7jewDYQms
	u8TGqWtbL40UdESNo/r7Jw5YQHbcnMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724337720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaiNFercyjSU1gCDFlq9+we6qY7P7NGuCyxgdh0VoAs=;
	b=tpsywLougvyw4e5fBOb3dWOIwtfsl7SCyZfaobbvWfsCj6/0ML9BB8wVnOCEj5qmXtogpC
	HukcjKn4y/hM0+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 075CF139D3;
	Thu, 22 Aug 2024 14:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cokIADhOx2aAZQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 22 Aug 2024 14:41:59 +0000
Message-ID: <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
Date: Thu, 22 Aug 2024 16:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] new helper: drm_gem_prime_handle_to_dmabuf()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240812065906.241398-1-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi

Am 12.08.24 um 08:59 schrieb Al Viro:
> Once something had been put into descriptor table, the only thing you
> can do with it is returning descriptor to userland - you can't withdraw
> it on subsequent failure exit, etc.  You certainly can't count upon
> it staying in the same slot of descriptor table - another thread
> could've played with close(2)/dup2(2)/whatnot.

This paragraph appears to refer to the newly added call to fd_install(). 
Maybe spell that out.

>
> Add drm_gem_prime_handle_to_dmabuf() - the "set dmabuf up" parts of
> drm_gem_prime_handle_to_fd() without the descriptor-related ones.
> Instead of inserting into descriptor table and returning the file
> descriptor it just returns the struct file.
>
> drm_gem_prime_handle_to_fd() becomes a wrapper for it.  Other users
> will be introduced in the next commit.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   drivers/gpu/drm/drm_prime.c | 84 +++++++++++++++++++------------------
>   include/drm/drm_prime.h     |  3 ++
>   2 files changed, 46 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 03bd3c7bd0dc..467c7a278ad3 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -409,23 +409,9 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
>   	return dmabuf;
>   }
>   
> -/**
> - * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
> - * @dev: dev to export the buffer from
> - * @file_priv: drm file-private structure
> - * @handle: buffer handle to export
> - * @flags: flags like DRM_CLOEXEC
> - * @prime_fd: pointer to storage for the fd id of the create dma-buf
> - *
> - * This is the PRIME export function which must be used mandatorily by GEM
> - * drivers to ensure correct lifetime management of the underlying GEM object.
> - * The actual exporting from GEM object to a dma-buf is done through the
> - * &drm_gem_object_funcs.export callback.
> - */
> -int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,

If it's exported it should have kernel docs. At least copy-paste the 
docs from drm_gem_prime_handle_to_fd()
and reword a few bits.

Best regards
Thomas

>   			       struct drm_file *file_priv, uint32_t handle,
> -			       uint32_t flags,
> -			       int *prime_fd)
> +			       uint32_t flags)
>   {
>   	struct drm_gem_object *obj;
>   	int ret = 0;
> @@ -434,14 +420,14 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   	mutex_lock(&file_priv->prime.lock);
>   	obj = drm_gem_object_lookup(file_priv, handle);
>   	if (!obj)  {
> -		ret = -ENOENT;
> +		dmabuf = ERR_PTR(-ENOENT);
>   		goto out_unlock;
>   	}
>   
>   	dmabuf = drm_prime_lookup_buf_by_handle(&file_priv->prime, handle);
>   	if (dmabuf) {
>   		get_dma_buf(dmabuf);
> -		goto out_have_handle;
> +		goto out;
>   	}
>   
>   	mutex_lock(&dev->object_name_lock);
> @@ -463,7 +449,6 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   		/* normally the created dma-buf takes ownership of the ref,
>   		 * but if that fails then drop the ref
>   		 */
> -		ret = PTR_ERR(dmabuf);
>   		mutex_unlock(&dev->object_name_lock);
>   		goto out;
>   	}
> @@ -478,34 +463,51 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   	ret = drm_prime_add_buf_handle(&file_priv->prime,
>   				       dmabuf, handle);
>   	mutex_unlock(&dev->object_name_lock);
> -	if (ret)
> -		goto fail_put_dmabuf;
> -
> -out_have_handle:
> -	ret = dma_buf_fd(dmabuf, flags);
> -	/*
> -	 * We must _not_ remove the buffer from the handle cache since the newly
> -	 * created dma buf is already linked in the global obj->dma_buf pointer,
> -	 * and that is invariant as long as a userspace gem handle exists.
> -	 * Closing the handle will clean out the cache anyway, so we don't leak.
> -	 */
> -	if (ret < 0) {
> -		goto fail_put_dmabuf;
> -	} else {
> -		*prime_fd = ret;
> -		ret = 0;
> +	if (ret) {
> +		dma_buf_put(dmabuf);
> +		dmabuf = ERR_PTR(ret);
>   	}
> -
> -	goto out;
> -
> -fail_put_dmabuf:
> -	dma_buf_put(dmabuf);
>   out:
>   	drm_gem_object_put(obj);
>   out_unlock:
>   	mutex_unlock(&file_priv->prime.lock);
> +	return dmabuf;
> +}
> +EXPORT_SYMBOL(drm_gem_prime_handle_to_dmabuf);
>   
> -	return ret;
> +/**
> + * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
> + * @dev: dev to export the buffer from
> + * @file_priv: drm file-private structure
> + * @handle: buffer handle to export
> + * @flags: flags like DRM_CLOEXEC
> + * @prime_fd: pointer to storage for the fd id of the create dma-buf
> + *
> + * This is the PRIME export function which must be used mandatorily by GEM
> + * drivers to ensure correct lifetime management of the underlying GEM object.
> + * The actual exporting from GEM object to a dma-buf is done through the
> + * &drm_gem_object_funcs.export callback.
> + */
> +int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> +			       struct drm_file *file_priv, uint32_t handle,
> +			       uint32_t flags,
> +			       int *prime_fd)
> +{
> +	struct dma_buf *dmabuf;
> +	int fd = get_unused_fd_flags(flags);
> +
> +	if (fd < 0)
> +		return fd;
> +
> +	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
> +	if (IS_ERR(dmabuf)) {
> +		put_unused_fd(fd);
> +		return PTR_ERR(dmabuf);
> +	}
> +
> +	fd_install(fd, dmabuf->file);
> +	*prime_fd = fd;
> +	return 0;
>   }
>   EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
>   
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index 2a1d01e5b56b..fa085c44d4ca 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -69,6 +69,9 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
>   
>   int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>   			       struct drm_file *file_priv, int prime_fd, uint32_t *handle);
> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
> +			       struct drm_file *file_priv, uint32_t handle,
> +			       uint32_t flags);
>   int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   			       struct drm_file *file_priv, uint32_t handle, uint32_t flags,
>   			       int *prime_fd);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


