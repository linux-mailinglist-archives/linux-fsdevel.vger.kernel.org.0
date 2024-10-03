Return-Path: <linux-fsdevel+bounces-30832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594198E9E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 08:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC491F22EE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064518063C;
	Thu,  3 Oct 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiNOX+Kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76A8003F
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938468; cv=none; b=cVNnSDvdl05mbNe/xkQ9o1NxUlZH31Ot8R9Fu5hgpOpUkDYbXqLMruTYhBA7egzbLzAxemYjIITwy//p2GTkBzB+nH892kiZjW7NTp4pQPpMTHAZrQYzKB+qfoqx200aCPTXZ9YKlTsW11xuFXyXwCu9Se3HGaIFtfjQm8jODKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938468; c=relaxed/simple;
	bh=3vB34HIu2qEBdg2AwhJ8Jzm4AV8fAtkZTWTDexEw+xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjPptUoMdkmhdzGMkv9kFXv2B1QG/wKsW1mnB2xSlr+cyMsy5FcQVD4F3mgFZ5aXibyVSOtZg0mgbk1HaYZabvVK2m9ixwhxKR1UAxqU0gUIhXeqZUz6uYqKASkRkLvuA9Q7jJ1lANQryGkPQ8qvXr0gL5k5kvby98jRj98d758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiNOX+Kd; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so6824036d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938466; x=1728543266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge4dpVL76Zh+7rjxbRWs/IjfXPZtOX6i1AIvG9oxRhg=;
        b=DiNOX+KdIXA1y8d+X+12Y5ouH4cJMsapqUomilMH8//bMjYwhFX0GGGQYJ/6Qkg+9N
         hq57rrPobVAJeBWCeVCgQIHjBln+uIyxAQQ6qb65Qfwx96biAxsCQxrSs44D84FWCB+V
         dj/EAq8H/EGIwnjRcHjudXm8muIRlKy0ceZndnrak/cjO9c243k4bz6SeIfiH0M6ZwCc
         4Xn0X7/TkhQBpKPi8FRZaXn6EbzzA+I7qakoI+oCV8rprZJavr0GnvPq2VT/4zhQgGlC
         jBNFGLEgKl/8+7z2CSZ0Nlpyg3OIZLEUDLiJ3XadkhbK5OAgsQgsdkG84zVrhx252bwy
         RdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938466; x=1728543266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge4dpVL76Zh+7rjxbRWs/IjfXPZtOX6i1AIvG9oxRhg=;
        b=ln9re2O8hKJ5BsG3j+gNJhRU4+Ls5x95HQMcdWeCU3xj2QcBfMyb0POQswHzDsmGYb
         KaoVNEK6w7Neys2GQHySSdLsf2KVPC3SI/XXx5YOQeqiBcK6rI3WPqsfJNtD9+mwUrdi
         Xo1mSHQa6DzQXcZjpTxdIviDN1A09ifev63eCXGOZS6XwT6Nesr7qxdefHCOJoamS34v
         h2O1bK+21TM+VRXAg90iunJ5Af6KjSc2qI+yfC+e9VzV5pUrbO6M/X68+eQ4e44mvAE+
         2vKweFSC2JmzjkjutGEoMCjy9RAu+r/Fm0tlBj366TdJ79i8civqafaVhUxMvpNEYpuC
         8Zeg==
X-Forwarded-Encrypted: i=1; AJvYcCUyTlMkq8y3dVmRQUlkarZw3Qq60iadkpMJifru3d2wQCwbZ3TcjEwkxkcx5yYeUo95eNM0nUwg7n7Vt7SU@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHraTnOBB/sUbRXrLDEevZ7E2yNSxW+Nt893Gsp6ol85uhC/6
	Nt9pUwgAECmbAEJg78e9OVHqrQYwflppH0ZTFqhy0ce7K5GITNc90XgZM+jFnb5AO6SrVmB+PkT
	krj14MrqYm1w09+yd6NNclFw7I/qagrkaxLUV
X-Google-Smtp-Source: AGHT+IEXQZdXgoooD1JSj8Wurktpq6GWBKTTeDL8JlTr1GcUqf/gGnqwOpsESQLJXOrw7nBmIdP/vBbYpb8CpWGc2Lo=
X-Received: by 2002:a05:6214:3211:b0:6cb:9200:944d with SMTP id
 6a1803df08f44-6cb920095dfmr21385426d6.7.1727938465735; Wed, 02 Oct 2024
 23:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928235825.96961-1-porlando@lkcamp.dev> <20240928235825.96961-3-porlando@lkcamp.dev>
In-Reply-To: <20240928235825.96961-3-porlando@lkcamp.dev>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Oct 2024 14:54:14 +0800
Message-ID: <CABVgOSk3BDO90wzG2192kagKEH5c4+hGqZPK7izfVsL+U08JmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
To: Pedro Orlando <porlando@lkcamp.dev>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>, Danilo Pereira <dpereira@lkcamp.dev>
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Sept 2024 at 08:00, Pedro Orlando <porlando@lkcamp.dev> wrote:
>
> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>
> Change utf8 kunit test filename and path to follow the style
> convention on Documentation/dev-tools/kunit/style.rst
>
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> ---

This looks good to me. The only thing I'm not 100% sure about is
whether or not we want to move the .kunitconfig file into the tests/
directory. I'm leaning towards "yes", but we may want to update
kunit.py at some point to support automatically adding tests/ to the
search path for a .kunitconfig if this becomes a common enough
pattern.

Regardless, let's take this as-is.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  fs/unicode/Makefile                                | 2 +-
>  fs/unicode/{ => tests}/.kunitconfig                | 0
>  fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename fs/unicode/{ => tests}/.kunitconfig (100%)
>  rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
>
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index 37bbcbc628a1..d95be7fb9f6b 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>  obj-y                  += unicode.o
>  endif
>  obj-$(CONFIG_UNICODE)  += utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
>
>  unicode-y := utf8-norm.o utf8-core.o
>
> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
> similarity index 100%
> rename from fs/unicode/.kunitconfig
> rename to fs/unicode/tests/.kunitconfig
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
> similarity index 100%
> rename from fs/unicode/utf8-selftest.c
> rename to fs/unicode/tests/utf8_kunit.c
> --
> 2.34.1
>

