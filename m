Return-Path: <linux-fsdevel+bounces-16135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9FC899057
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5281C21B61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA813C3C4;
	Thu,  4 Apr 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YVZ9jJv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BD1384AE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265929; cv=none; b=G2mkc8f5cO+0NAulBsRFMUm2MyypWmaqpizpKSfUunKzGADc1c43k7zePbxgr5LiEn/bUURgAUh+/5z0MdXdJDSv7AiubBww15BBpVgapKWUW5yaoUciOu7oaUR2RwFlIw5gnAOAQtN+4B60CB/9b9o7xDftjm5tNWle36+ckZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265929; c=relaxed/simple;
	bh=3NKUzTGkIDEpQ5wUoVyjTBqpGFGUoC7t9j9PGK1BOcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViiqDQZmZYZHI3UYTjA8J8P7LYOjb9N9aAaMoAg4aMZp9rOwv+2tMm6O/EAM1DRU1cto20CUYxfKfkjA/fLZbo7K7YayTkmCNTsqA3QfUwtBPlBo+bzsBQYLEcMzstfzOjBZddQHyrLoefzfdWmkd9v8QTvp7lIsyHaN5346Ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YVZ9jJv4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0bec01232so12984265ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712265926; x=1712870726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpiEkHKVQpziLc/Q1KdhUKlYdlAbkM0446cfuS4Rfmw=;
        b=YVZ9jJv493y9smv/0jF5HIShwzyvA4qSjrnq97hYJ3HAYCz9eWw+iJehW9rnNcNqo2
         pfXJN8dbgnfQRVqee1wCqoIPuxN2XINa4wpzazZuVmgxyCUnd52m7oQCdwPrGwaJXncE
         ALaMg6WJ5nv1dhrjenPwviG7GoqJwbjfIc30Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265926; x=1712870726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpiEkHKVQpziLc/Q1KdhUKlYdlAbkM0446cfuS4Rfmw=;
        b=wtdQaVQMb5/5kF4smap+FIu1Pl94GxvftlTWYG2LBqTPz5hG5YS6jL4BgBtEYJqBY0
         u9XQfLFEVLxd9wi/eHFmYhQEVVfI8OauYXrQ5QaTS+MpJqNM8qnZL8et8ZFPfTQ4r0xs
         XlUi5HzSyLCVEaYXftTIz7pYT5IS0psoAUrATxkz51W0GjWBl0/Hd5n9SjD8UXUpYavm
         P+37tmRRm9XCgh3+Hzma1hTdxm5t8x8kqQnELxE5Diicn0WMtvXWhjwlhNFPZaFRZGEL
         ybvCq+JkNA37FpXm6HspWlT/qCZ6Ml16H393jWBuR2WpMbBlTMtaPfyNBtGthwaA14og
         1Xgg==
X-Gm-Message-State: AOJu0YzHCFwzN/CDWnTSs6cI77epqtfB3wRyNrkUvUy8s0RyIoJ9MwCk
	xb58+SM4zK6odktmse+lt0JLnHBUZ91hK6m7WISL20YF3K90XLhsHw9YWJGIrg==
X-Google-Smtp-Source: AGHT+IE94WGQc2eT/aw5lISX7Th0dXyOdwG6Wu0UODl3BM+QKoXt+9KC7Bf3vkB0vJ7kUinlMgttZA==
X-Received: by 2002:a17:902:9698:b0:1e2:a2ca:6366 with SMTP id n24-20020a170902969800b001e2a2ca6366mr3033583plp.21.1712265926601;
        Thu, 04 Apr 2024 14:25:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001e20be11688sm73790plg.229.2024.04.04.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:25:26 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:25:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hfsplus: refactor copy_name to not use strncpy
Message-ID: <202404041425.53F8283@keescook>
References: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>

On Mon, Apr 01, 2024 at 06:10:48PM +0000, Justin Stitt wrote:
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
> Additionally, for non-empty strings, include the NUL-byte in the length
> -- matching the behavior of the previous implementation.
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
> ... the error can potentially already be -E2BIG, skipping this else-if
> and ending up at the same state as other errors.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks, this looks right to me now!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

