Return-Path: <linux-fsdevel+bounces-15662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A641891242
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 05:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F861C23588
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A903A1A1;
	Fri, 29 Mar 2024 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXwlVJ53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6351118E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685007; cv=none; b=Ic0cczoHHZukAhie6Lxb/jQbbzmGKhSjDDjhRuiiytrk4MWu8XZg+bSFd148GhlQAX2Zr71aiS5RxNkmLNtuUGYKibDH2H3xgEpqKTuiDeQHQFhsNO/5GBQk+jnoNeUleWPdSeIAX8znl7VIFzJsehVZ6WzhkOA8HgKfdOqnTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685007; c=relaxed/simple;
	bh=ZhXVjNEvBrgbNRdwLYIFSvFQti2uWpnpeF3sRR/SqRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy7rrNaySrkqyFgkF3G6Y2qsnHjYIeqTZQdijLGm+h/YR/sZS7MrkPxg/ZfM7HXytl9CRJv8yrIyIiGgfgG18IdNSRW6NyWWwkrib6S2LKlLH9FUFRywaZhO9LkFuCIBggZKBy+/6VHY2EPvrLrTYWi4/BcyLt1jqNVsy4oV6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HXwlVJ53; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22215ccbafeso918689fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 21:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685004; x=1712289804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyIL4ZyXQu4gCc0zxFPA1WjlBqcdHOravdVHYGFWCwU=;
        b=HXwlVJ53T9MTB66zKYaDvHBLtBBkaxhnUaSdJ0POIo5wPiL0YFwED3yDO4QRbC0bQR
         sn5II1Rmsa1Pte5musCfW0aJgKc/8hYaU/7mP/agyw9mNoLiyDMYqHJ/l1WHGRsDLaaj
         QNCuXyKflXjmmkRh97KbiEbgVbz2f3v9LbNdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685004; x=1712289804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyIL4ZyXQu4gCc0zxFPA1WjlBqcdHOravdVHYGFWCwU=;
        b=oteuX1P+K2hbbep5nvMAOt3pm8LbnRZqeb2ovhCKHUhGBEjKpeNzufDvKZtxoTlzc2
         0/MfnQIzieTrwof+3W/EtckT9ZvBd0FK9pMfRzjcS6NuI3Wd4DEFJmnzLDe5qx86tsWP
         eLKmo5WW0a8nPJeJucKQuc3GdqY0iqja7DkhPRO0VRFbRM/1oegU0n/eY7LPPl2WWYzw
         2jNtnC4kWa6xfnbHvVi3Zg2SD4sbWe863juWta9/4OEFxi1zdC+Kzpfuc81WeS2JStla
         YthllPpq4RrYHO0/49ntHhcCv6HkQA+RtqC31AjNgBqahnpBBaMFXP6ZoHTN4Mx1HsDg
         GT0w==
X-Gm-Message-State: AOJu0Yz/qRDQedTWcA0jzeDIWZYGCZwlVuR3p8ihbvTExogLQ0a1mRvP
	xoA15Bw3nBQyk6/VEC+a1a91Yxi8JqhbTWYyWZtoL6ySqLA9M2rsFio8SaNEzQ==
X-Google-Smtp-Source: AGHT+IHvluku9U7jr6mQlg+iTXEmMv+9Y2Nee8Oul+9ay/ks9RgGFoU1n/SfTSlXuaMelIbrLW8M8w==
X-Received: by 2002:a05:6871:7999:b0:222:619f:9510 with SMTP id pb25-20020a056871799900b00222619f9510mr1247237oac.27.1711685004736;
        Thu, 28 Mar 2024 21:03:24 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k7-20020aa792c7000000b006eab9ef5d4esm2174614pfa.50.2024.03.28.21.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:03:24 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:03:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hfsplus: refactor copy_name to not use strncpy
Message-ID: <202403282059.37BA0B8E20@keescook>
References: <20240321-strncpy-fs-hfsplus-xattr-c-v1-1-0c6385a10251@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-strncpy-fs-hfsplus-xattr-c-v1-1-0c6385a10251@google.com>

On Thu, Mar 21, 2024 at 11:46:27PM +0000, Justin Stitt wrote:
> strncpy() is deprecated with NUL-terminated destination strings [1].
> 
> The copy_name() method does a lot of manual buffer manipulation to
> eventually arrive with its desired string. If we don't know the
> namespace this attr has or belongs to we want to prepend "osx." to our
> final string. Following this, we're copying xattr_name and doing a
> bizarre manual NUL-byte assignment with a memset where n=1.
> 
> Really, we can use some more obvious string APIs to acomplish this,
> improving readability and security. Following the same control flow as
> before: if we don't know the namespace let's use scnprintf() to form our
> prefix + xattr_name pairing (while NUL-terminating too!). Otherwise, use
> strscpy() to return the number of bytes copied into our buffer.
> 
> Note that strscpy() _can_ return -E2BIG but this is already handled by
> all callsites:
> 
> In both hfsplus_listxattr_finder_info() and hfsplus_listxattr(), ret is
> already type ssize_t so we can change the return type of copy_name() to
> match (understanding that scnprintf()'s return type is different yet
> fully representable by ssize_t). Furthermore, listxattr() in fs/xattr.c
> is well-equipped to handle a potential -E2BIG return result from
> vfs_listxattr():
> |	ssize_t error;
> ...
> |	error = vfs_listxattr(d, klist, size);
> |	if (error > 0) {
> |		if (size && copy_to_user(list, klist, error))
> |			error = -EFAULT;
> |	} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
> |		/* The file system tried to returned a list bigger
> |			than XATTR_LIST_MAX bytes. Not possible. */
> |		error = -E2BIG;
> |	}
> ... our error can potentially already be -E2BIG, skipping this else-if
> and ending up at the same state as other errors.
> 
> This whole copy_name() function could really be a one-line with some
> ternary statements embedded into a scnprintf() arg-list but I've opted
> to maintain some semblance of readability.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> ---
>  fs/hfsplus/xattr.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9c9ff6b8c6f7..00351f566e9f 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -400,22 +400,13 @@ static int name_len(const char *xattr_name, int xattr_name_len)
>  	return len;
>  }
>  
> -static int copy_name(char *buffer, const char *xattr_name, int name_len)
> +static ssize_t copy_name(char *buffer, const char *xattr_name, int name_len)
>  {
> -	int len = name_len;
> -	int offset = 0;
> -
> -	if (!is_known_namespace(xattr_name)) {
> -		memcpy(buffer, XATTR_MAC_OSX_PREFIX, XATTR_MAC_OSX_PREFIX_LEN);
> -		offset += XATTR_MAC_OSX_PREFIX_LEN;
> -		len += XATTR_MAC_OSX_PREFIX_LEN;
> -	}
> -
> -	strncpy(buffer + offset, xattr_name, name_len);
> -	memset(buffer + offset + name_len, 0, 1);
> -	len += 1;

The old code appears to include the NUL in the count of bytes written.

> +	if (!is_known_namespace(xattr_name))
> +		return scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
> +				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
>  
> -	return len;
> +	return strscpy(buffer, xattr_name, name_len + 1);

Neither scnprintf nor strscpy include the NUL in their return value, so
I think special handling is needed here. Perhaps:

	ssize_t len;
	...
	if (!is_known_namespace(xattr_name))
		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
	else
		len = strscpy(buffer, xattr_name, name_len + 1);

	if (len >= 0)
		len++;
	return len;

-Kees

>  }
>  
>  int hfsplus_setxattr(struct inode *inode, const char *name,
> 
> ---
> base-commit: 241590e5a1d1b6219c8d3045c167f2fbcc076cbb
> change-id: 20240321-strncpy-fs-hfsplus-xattr-c-4ebfe67f4c6d
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook

