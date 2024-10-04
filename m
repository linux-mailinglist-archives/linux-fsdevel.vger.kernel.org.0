Return-Path: <linux-fsdevel+bounces-31015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEEA990F6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66F51F22C94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1561D966E;
	Fri,  4 Oct 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="GLl6W1Dm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D968289E;
	Fri,  4 Oct 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068418; cv=none; b=e8tAoxH4XzVthId05zIuHbUY+KyhlkHsw4sfzLHDTU+NKkkttH6xkb0LGGzDAKYX1tAHC+VvXkK6rCDhu0CLFB4RY1yUWpFajquxubeT9tT2cKKZrHufGEjEfcq8K9WW/Zzi9m5asz8mB1RZ3r/V8iY12jN3lfI+cs7U8ywefpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068418; c=relaxed/simple;
	bh=kDPhIOhRF/uzQkaM9pjAhz97+sk3r8bY2o96T4XK5S8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iSMEYQwvGGUq1BjvW9FNZmz7H+KiEL4O1Nc7ggoKq07EWXjr+hkmGQ8MaBvQUR/5kybv8jCe0kP8FGuxRS0un525kC3xFFSFCLzGjAzm7QZpSqtZqFjEszloxZkV4pkdiBv4fVe4zrzy+vY8U6SMCrSTbgBc88V73EZ8m/cj+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=GLl6W1Dm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DD71FF804;
	Fri,  4 Oct 2024 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728068413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NKH79yYRcFrkjMOXVFhQVQVbLafFFDnV8gtNqwhEnGQ=;
	b=GLl6W1DmwIhVNyP2yE6eUw52M8tF8hphkQPmUsWi2/SRN0VEje5bEui4+M8xz/4MLbUV33
	y4feaU1rtPuJCpA+rSORxdEtRwm3g3yOs5oDeYtnQIft4OZWAQUEGG7oecnFd9SUbj8l+5
	c2Qc4U52r0WURkVEpBGIhNo/rrPjfNTWi3GfQ0c+O2a12iJG5A4/ro+G6QAb1CthMl5RQQ
	ehnmXPxAT8MqyYF3teJElhGiBqHIEJ5m48loo2bOQr5UBc1tPpFjyCU91awcyNKEZfOZPp
	neDiWUr++Kt63mFMaltxJ0USY1HOfcRI6ZfWGPZr67otx07+zFAYoI5EM3eoLQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Pedro Orlando <porlando@lkcamp.dev>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,  David Gow
 <davidgow@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  linux-fsdevel@vger.kernel.org,  ~lkcamp/patches@lists.sr.ht,
  linux-kselftest@vger.kernel.org,  kunit-dev@googlegroups.com,  Gabriela
 Bittencourt <gbittencourt@lkcamp.dev>,  Danilo Pereira
 <dpereira@lkcamp.dev>
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
In-Reply-To: <20240928235825.96961-3-porlando@lkcamp.dev> (Pedro Orlando's
	message of "Sat, 28 Sep 2024 20:58:28 -0300")
References: <20240928235825.96961-1-porlando@lkcamp.dev>
	<20240928235825.96961-3-porlando@lkcamp.dev>
Date: Fri, 04 Oct 2024 15:00:10 -0400
Message-ID: <87iku7u211.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Pedro Orlando <porlando@lkcamp.dev> writes:

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
>  obj-y			+= unicode.o
>  endif
>  obj-$(CONFIG_UNICODE)	+= utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o

This breaks compilation for me.

fs/unicode/tests/utf8_kunit.c:11:10: fatal error: utf8n.h: No such file or directory
   11 | #include "utf8n.h"
      |          ^~~~~~~~~

After this patch that local header is now in the parent directory.

I'm building with:

CONFIG_UNICODE=m
CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=m

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

-- 
Gabriel Krisman Bertazi

