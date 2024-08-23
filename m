Return-Path: <linux-fsdevel+bounces-26879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA51595C66C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 09:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E128543A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52213BC2F;
	Fri, 23 Aug 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2DGCc8hH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="57KMPpqQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2DGCc8hH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="57KMPpqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5407131BDF
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397684; cv=none; b=tKQYLCZZsPABQclt5w4c2Y3i5JxhKTIQjrVnOntj8N0nRnAakpAYAk2+ZwCVrlmQUfyajEzp5ZfHfIqGa35U/5TlL93wpAFngXFOcBOiqUiPO8OY4ZaB4CErwIfeWaS/xczbkLb4pN+3qUh+S5NC1Zfk05S2yKXA2gGkrM5WRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397684; c=relaxed/simple;
	bh=kkhg3tdSYidvfB1ecHrayloiqjajcBnG6Jd7wHFUzA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmy7H48htZbTtBe4hNru8yHF+8s+S4ZeCwaPbP7Zx0EEfWgYqLH1Cck4iJxt75PYogevyJEvaQ35Hg0dBdV37xclUNzS+VygGeH/BPCrJ3/F7n2gRmjkHX2qZQQ7/+btxv3CFZXk6JAXv+DDZZH3QEN6vU9xIhq32rR0IxiB2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2DGCc8hH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=57KMPpqQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2DGCc8hH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=57KMPpqQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 086BC22483;
	Fri, 23 Aug 2024 07:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724397675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OUN/95H7PjQlCNDBIQ4OmCyi74sRNaVOzTKB5M5QdXk=;
	b=2DGCc8hH7E6PUrLuWCsdVHl0jNLU7QvifKtJ2+SyensqL1tISB/mdXhMJjY5swphJ5IKXv
	1WUpjjKAWv94mqswLKnF+caNOTtzhg8dV7vBQtfuxws6fNVzbcigZ2oxVKZD9jYy32Ebfo
	v9phmBgAgNxcx9BUJadm3g2MaLGT0D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724397675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OUN/95H7PjQlCNDBIQ4OmCyi74sRNaVOzTKB5M5QdXk=;
	b=57KMPpqQ0ayzi22UaLrTEA0nnmig1VsgG5MyvWhCXQ37MlHW8k7qzp20H+HEuJkrAYQUcV
	adZJ+UX3rZ3Yk9AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2DGCc8hH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=57KMPpqQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724397675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OUN/95H7PjQlCNDBIQ4OmCyi74sRNaVOzTKB5M5QdXk=;
	b=2DGCc8hH7E6PUrLuWCsdVHl0jNLU7QvifKtJ2+SyensqL1tISB/mdXhMJjY5swphJ5IKXv
	1WUpjjKAWv94mqswLKnF+caNOTtzhg8dV7vBQtfuxws6fNVzbcigZ2oxVKZD9jYy32Ebfo
	v9phmBgAgNxcx9BUJadm3g2MaLGT0D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724397675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OUN/95H7PjQlCNDBIQ4OmCyi74sRNaVOzTKB5M5QdXk=;
	b=57KMPpqQ0ayzi22UaLrTEA0nnmig1VsgG5MyvWhCXQ37MlHW8k7qzp20H+HEuJkrAYQUcV
	adZJ+UX3rZ3Yk9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D43121333E;
	Fri, 23 Aug 2024 07:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tbn0MWo4yGbvdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Aug 2024 07:21:14 +0000
Message-ID: <50379388-302d-420a-8397-163433c31bdc@suse.de>
Date: Fri, 23 Aug 2024 09:21:14 +0200
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
 <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
 <20240822152022.GU504335@ZenIV> <20240823015719.GV504335@ZenIV>
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
In-Reply-To: <20240823015719.GV504335@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 086BC22483
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 23.08.24 um 03:57 schrieb Al Viro:
> Do you have any problems with the variant below?  The only changes are
> in commit message and added comment for new helper...
>
> commit 8c291056e3e88153ef4b6316d5247547da200757
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Fri Aug 2 09:56:28 2024 -0400
>
>      new helper: drm_gem_prime_handle_to_dmabuf()
>      
>      Once something had been put into descriptor table, the only thing you
>      can do with it is returning descriptor to userland - you can't withdraw
>      it on subsequent failure exit, etc.  You certainly can't count upon
>      it staying in the same slot of descriptor table - another thread
>      could've played with close(2)/dup2(2)/whatnot.
>      
>      drm_gem_prime_handle_to_fd() creates a dmabuf, allocates a descriptor
>      and attaches dmabuf's file to it (the last two steps are done
>      in dma_buf_fd()).  That's nice when all you are going to do is
>      passing a descriptor to userland.  If you just need to work with the
>      resulting object or have something else to be done that might fail,
>      drm_gem_prime_handle_to_fd() is racy.
>      
>      The problem is analogous to one with anon_inode_getfd(), and solution
>      is similar to what anon_inode_getfile() provides.
>      
>      Add drm_gem_prime_handle_to_dmabuf() - the "set dmabuf up" parts of
>      drm_gem_prime_handle_to_fd() without the descriptor-related ones.
>      Instead of inserting into descriptor table and returning the file
>      descriptor it just returns the struct file.
>      
>      drm_gem_prime_handle_to_fd() becomes a wrapper for it.  Other users
>      will be introduced in the next commit.
>      
>      Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Thank you so much.

Best regards
Thomas

>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 03bd3c7bd0dc..0e3f8adf162f 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -410,22 +410,30 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
>   }
>   
>   /**
> - * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
> + * drm_gem_prime_handle_to_dmabuf - PRIME export function for GEM drivers
>    * @dev: dev to export the buffer from
>    * @file_priv: drm file-private structure
>    * @handle: buffer handle to export
>    * @flags: flags like DRM_CLOEXEC
> - * @prime_fd: pointer to storage for the fd id of the create dma-buf
>    *
>    * This is the PRIME export function which must be used mandatorily by GEM
>    * drivers to ensure correct lifetime management of the underlying GEM object.
>    * The actual exporting from GEM object to a dma-buf is done through the
>    * &drm_gem_object_funcs.export callback.
> + *
> + * Unlike drm_gem_prime_handle_to_fd(), it returns the struct dma_buf it
> + * has created, without attaching it to any file descriptors.  The difference
> + * between those two is similar to that between anon_inode_getfile() and
> + * anon_inode_getfd(); insertion into descriptor table is something you
> + * can not revert if any cleanup is needed, so the descriptor-returning
> + * variants should only be used when you are past the last failure exit
> + * and the only thing left is passing the new file descriptor to userland.
> + * When all you need is the object itself or when you need to do something
> + * else that might fail, use that one instead.
>    */
> -int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
>   			       struct drm_file *file_priv, uint32_t handle,
> -			       uint32_t flags,
> -			       int *prime_fd)
> +			       uint32_t flags)
>   {
>   	struct drm_gem_object *obj;
>   	int ret = 0;
> @@ -434,14 +442,14 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
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
> @@ -463,7 +471,6 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   		/* normally the created dma-buf takes ownership of the ref,
>   		 * but if that fails then drop the ref
>   		 */
> -		ret = PTR_ERR(dmabuf);
>   		mutex_unlock(&dev->object_name_lock);
>   		goto out;
>   	}
> @@ -478,34 +485,51 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
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


