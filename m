Return-Path: <linux-fsdevel+bounces-47274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B0A9B2CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68B14A0C8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18F27F724;
	Thu, 24 Apr 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1w73h/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B027F756
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509544; cv=none; b=C95rRfMQBRgF+hRCyJNDuQNIAsjNygtBFuyzDNHBNeVBHy/A2zQYwY9AfLHL/j2KuIUO7qHiFVsbxI22xgvg9GIPzK10oHlWWyRV5EltpMRWms4kSPkMaAAVovRQnJ8jboVmnjGGHq4dY9OrTZHvnnfLYrJlZ81xMJzLEw+YX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509544; c=relaxed/simple;
	bh=k+XX2RQzFhhP48T1kEKcxNjZJBlGkKR0LBn+21Aa6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITqD+2Rml6ycHEIWfnIgD2YBSVV9uhQzLkGnXVHJWtQ8JCtikQCMiCOnLJ28lhsdAgC/w/LlyQ+Vty44F0LX9kNdOpLujWnqirMWh5VJaLAJytQCbKIitt65cJYVXlUycTQfGP7+6qB74RudjuErMPS2eXSdabcjyqPbGz4YagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1w73h/i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso8769375e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509534; x=1746114334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKFeOnPWWTdWi8+45XXBWcaMUmFnsQrwBiKxLeR5lyM=;
        b=f1w73h/iZaT9myxSSHVB8gt025X50H+MoP89kBWfAzTu4EW2yobUBZVeUOMQ/iFgmW
         pX8iht9oVqZCV5XRllhBLqpb58kWyZq7jTWL94Xd3TzwZIeSS9Ie28MmKdmTcGJqnsX8
         AFL27W9ivl9May9jUh5EKNJSb7FSNvnieT9PT/eG8GuA+M6fL1PtKw2BsUtwIRgwZ2to
         BTghAgK9Nrd66c/NdXa+mPeonJr92Iqkwc6xoxyIE5QbPAocFy7eN4W/936xZtVyBceC
         LZ2ay8cmple/Rk1Cf8G39or75sMPwpG3vc5gUu8H4e63vhZ3XxZJK8ywSKXVcdpIX1Mo
         pgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509534; x=1746114334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKFeOnPWWTdWi8+45XXBWcaMUmFnsQrwBiKxLeR5lyM=;
        b=Cb2SbMbbld1IY4l0J7Pr2yi8uVmC+XRG3hO03geUflAy+RMDKpV1JhnlQ/+7BO7a3h
         m3zNOQzUUSUX5v8n5jdUSNhW2/YUZWB8GxvRUFMgD/4KczKSlks4rHORHw2zatYnuRwF
         5Y4gTMiW71NAQhukeE5mBNu9k6b/XIii0Z2QvchKLWmifz5JhUvDd1P8Q1Y4Fn/ci3O6
         9nf1NQYfvfsZgco8hiqgouUZEr14shPtb3coL0JFIoJ4RY8xvU0e/8HMNkUB8x/oUr5l
         EqhvtwFUJerBEDZ4VAFPHId/Wur/4qYTHG5NJwwh5Z8Wjd//nwwQar6i273zisrbx0MW
         FAwg==
X-Forwarded-Encrypted: i=1; AJvYcCUiLIzuqs8PjWT1WS2hW6ol6VZkE9kdqsstpXWBo7AzEJo2qSRmGwW8OsUebEJPgyvwiKmdowY+uBIh2zb/@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVwUo8lcHpbesVhgkPfs8uv325qG3/UUMJx90Z/b7jiZ9WkCo
	w8fy63HQB8jlMTRAtGGwXIPgrdoo2gTqDNVTIpnT2Y/yxA+9WVDj
X-Gm-Gg: ASbGncs0Iio1fNEjf5C9Vb/i0alE+igJcdpgaAKy0szAAE/B9hqIgDgZpxvY2FMGaho
	98YRT26qbxuZjTiRgim8cuUlCR2l2bO+gxYICU6rZdYtHxQWeIsBD824wXMbxCOuaLQof+DdR3c
	lTje5Vg/KUz72vCQ0Mrzc8nVnaNWV30IHDwNrQMl4uY+0RPP9hXGQyrCcoYY6hAtwJJ+cX3Nky7
	ZI8UCH7rDly9p2GVd+wikWigSt8c7nAxk9irpVHtv3LR64Yr9Xcy/4kRqsy31ky4qeWEiyjzDit
	YDgfFnK+imNh9br7bZKOyTtunUL+3a3CTNI2Zfn3ykjv2NFLFD07vQ==
X-Google-Smtp-Source: AGHT+IEakt/kUoJk6ddNhg1AfBVUZ4Iv1mcahmZi2whJeAaEbm2513Vxf0qmyThlWtkMtg/RObk4bg==
X-Received: by 2002:a05:600c:1f0d:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-4409bd23afcmr28292595e9.14.1745509533528;
        Thu, 24 Apr 2025 08:45:33 -0700 (PDT)
Received: from f (cst-prg-30-64.cust.vodafone.cz. [46.135.30.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e0241sm26052375e9.37.2025.04.24.08.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:45:32 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:45:17 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and
 getxattrat(2)
Message-ID: <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>
References: <20250424132246.16822-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424132246.16822-2-jack@suse.cz>

On Thu, Apr 24, 2025 at 03:22:47PM +0200, Jan Kara wrote:
> Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
> calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
> fail with -EBADF error instead of operating on CWD. Fix it.
> 
> Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/xattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 02bee149ad96..fabb2a04501e 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
>  		return error;
>  
>  	filename = getname_maybe_null(pathname, at_flags);
> -	if (!filename) {
> +	if (!filename && dfd >= 0) {
>  		CLASS(fd, f)(dfd);
>  		if (fd_empty(f))
>  			error = -EBADF;
> @@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
>  		return error;
>  
>  	filename = getname_maybe_null(pathname, at_flags);
> -	if (!filename) {
> +	if (!filename && dfd >= 0) {
>  		CLASS(fd, f)(dfd);
>  		if (fd_empty(f))
>  			return -EBADF;

Is there any code which legitimately does not follow this pattern?

With some refactoring getname_maybe_null() could handle the fd thing,
notably return the NULL pointer if the name is empty. This could bring
back the invariant that the path argument is not NULL.

Something like this:
static inline struct filename *getname_maybe_null(int fd, const char __user *name, int flags)
{
        if (!(flags & AT_EMPTY_PATH))
                return getname(name);

        if (!name && fd >= 0)
                return NULL;
        return __getname_maybe_null(fd, name);
}

struct filename *__getname_maybe_null(int fd, const char __user *pathname)
{
        char c;

        if (fd >= 0) {
                /* try to save on allocations; loss on um, though */
                if (get_user(c, pathname))
                        return ERR_PTR(-EFAULT);
                if (!c)
                        return NULL;
        }

	/* we alloc suffer the allocation of the buffer. worst case, if
	 * the name turned empty in the meantime, we return it and
	 * handle it the old-fashioned way.
	 /
        return getname_flags(pathname, LOOKUP_EMPTY);
}

Then callers would look like this:
filename = getname_maybe_null(dfd, pathname, at_flags);
if (!filename) {
	/* fd handling goes here */
	CLASS(fd, f)(dfd);
	....

} else {
	/* regular path handling goes here */
}


set_nameidata() would lose this branch:
p->pathname = likely(name) ? name->name : "";

and putname would convert IS_ERR_OR_NULL (which is 2 branches) into one,
maybe like so:
-       if (IS_ERR_OR_NULL(name))
+       VFS_BUG_ON(!name);
+
+       if (IS_ERR(name))
                return;

i think this would be an ok cleanup

