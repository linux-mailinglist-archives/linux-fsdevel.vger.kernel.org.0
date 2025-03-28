Return-Path: <linux-fsdevel+bounces-45185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90BA742C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 04:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC4B189E745
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34F21129C;
	Fri, 28 Mar 2025 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbeIj9xe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70926AC3;
	Fri, 28 Mar 2025 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743132172; cv=none; b=TWl5W1QLdRmR+38E8g4jeHaJ2zbsj+640flT1NdgVxMNzkDO/e+IqLSDNsiT4amiagKN/atPy/tobrI9cWOaZm5E8gdt7Iv/B1Vm/YRH+QG/5UCKJcH8kYCvNeyFVogeY3B1jVtRMyaxZWLf+dXmebA+A8lKP10LgRzqWI0xOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743132172; c=relaxed/simple;
	bh=M5y+SHEBcaPioIYa3upR4kMT+jizMmJOTydbfnEFN+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uceNLdTarelUR7Deu/IxdEKAQ5EQKIKOjztgXIL1pgpcUXSN9Wf2JfLOwgB5yNPS+5Itvub22aGGB5maZzyyd1i9or/yXP78rG69RU760pS5xdN0qLpNXnbGKLUfnwSdCgtbeOQIB8djDdTx+jbpZFsifHpJTgAa8hQTJ0HZQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbeIj9xe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so880527f8f.0;
        Thu, 27 Mar 2025 20:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743132169; x=1743736969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7C8z55+T8oYS2KV30NvrF9v2VMjdBS5RbEDCZuaYTo=;
        b=LbeIj9xezHgffGo3joskGQv1UQzhGj9sUy5jSgktp/AYhWTFPJWlcJrJTzmqzkWDu6
         0angimizh3ez1Qy6BdBP0RO9P2NMJ0jhClOrQmqQ4EV+4cN6fqUGYadjv7KKQKk5eGrS
         NiB3ENmwoSBfhepNLMJGRJpBgZFRXze3iwYnyG4/VuNRn+ML21ycz//Kv4aEh2XWGytn
         43d5tQXB4UHwvon/lIPf+kcFLI6w147MmQcrl+TQDEVrI6a8xjVnJo+mgrYhXqVYBJa+
         b25CB+tEXm6hBY/WI5DdZ1mhG5iXb1dvFWxhx2A3RGtUn9LvtyvhucR7IMaxEOQRG318
         fkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743132169; x=1743736969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7C8z55+T8oYS2KV30NvrF9v2VMjdBS5RbEDCZuaYTo=;
        b=LFGA/qh/0PQNFztF5HKjsbPvmLX6k12jVdHDtoH+o46+kUW/oQ/2OaIc4XHr3gfNU3
         H/ntvCZrqzlQzin4+OnyuqlmKGqurmwyawJbLsCwUSGrALo2TnWtanxfBiMSn3qBKbOC
         XK49Hs6EShr602aRdzRqb224B7sIVYk/Jd7A6R3mrabvIZGkiCIMLxZGg+VjFVS4IAjd
         LSirkg6f79LBVNtlKhrH7PEmh5z2MVBiZk1oVdkKfpVPXLOJa29Cv+eqUsW7pMPggxmO
         fCGupTKYkk910oEban284wTB06JNm10QIdCmgZ6z5gxfOjkPdoechXm9n8/87ZqNZ8Ln
         IRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRjIQRSnkXkeXOKkzoY15KgFdR+jLvDtSYpjutf31eIl+7L2r54NNbEj7WCiGPla9ASu1DUlr20x/sk/zgMxRu@vger.kernel.org, AJvYcCWbc/GyeLvRVqC358ztlKjE0mwobP37/044MTk7l5NimxKPQlBGWHxvk7hX+Gukxq7+Ltkhq6RZ6nA7pnz5@vger.kernel.org, AJvYcCX0/vAhBbatX2wsM1Gse+x70G1M4Rmd6wVjDFVfAiif7bEdFmUfLsXFuj9v0LilB4MTNPIlxXgT0BET+9vB@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6DTlZjIp9pIxXf762RKBoHdl6k8kdRPEJPlj8IwYdDZ++pQ8
	7EuwamifIQ9KDKcyDT7/W9UWf3dxdITrrRqBOweQ5p6MDUYAycECLxe/uihLwiWgUiiWurWP8Fi
	MZ26KwOGH8hC27Pg+eHKV96bOuYo=
X-Gm-Gg: ASbGnctPhnbXQWfIywbpoM2lSH6rq3X0XDvVhLhDW2Ec++j1gTWzGdS1B/kVH+5APaX
	e9hwr6DNO8GgiSWcqob8bJvrF9txzgq6NVUm2IliqLgPKOU3y7OhqFBfcGPZMyZ7whKwBvH2VxI
	Pvy6zagEwRn+hjAgnr+kH3OhfK1PI+
X-Google-Smtp-Source: AGHT+IHVqJ00wvtvQwj5eSUkJyD/Qm8KBYe23yrQxTy9l1qjtGvOpEvI62C4RjCoDOOLaZM92/M93nihjWAGw7b+r8o=
X-Received: by 2002:a05:6000:40e0:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-39ad176dea8mr5129848f8f.34.1743132168612; Thu, 27 Mar 2025
 20:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325015617.23455-1-pcc@google.com> <20250325015617.23455-3-pcc@google.com>
In-Reply-To: <20250325015617.23455-3-pcc@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 28 Mar 2025 04:22:37 +0100
X-Gm-Features: AQ5f1JrJXWzo2O7BIgaxbbGefH-hJc8YZYbR3ERisHcev8zGo0XarIRgt3wr42U
Message-ID: <CA+fCnZe+KzyBOBPsJonEhDV-5ZH57QPfTCREawXiwvpTcspNug@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 2:56=E2=80=AFAM Peter Collingbourne <pcc@google.com=
> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> When we invoke strscpy() with a maximum size of N bytes, it assumes
> that:
> - It can always read N bytes from the source.
> - It always write N bytes (zero-padded) to the destination.
>
> On aarch64 with Memory Tagging Extension enabled if we pass an N that is
> bigger then the source buffer, it triggers an MTE fault.
>
> Implement a KASAN KUnit test that triggers the issue with the current
> implementation of read_word_at_a_time() on aarch64 with MTE enabled.

I think the wording here is confusing, makes it sound like the issue
is not fixed.

> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a252=
274120e77b1898a
> ---
> v3:
> - simplify test case
>
> v2:
> - rebased
> - fixed test failure
>
>  mm/kasan/kasan_test_c.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 59d673400085f..b69f66b7eda1d 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1570,6 +1570,7 @@ static void kasan_memcmp(struct kunit *test)
>  static void kasan_strings(struct kunit *test)
>  {
>         char *ptr;
> +       char *src;
>         size_t size =3D 24;
>
>         /*
> @@ -1581,6 +1582,18 @@ static void kasan_strings(struct kunit *test)
>         ptr =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       src =3D kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
> +       strscpy(src, "f0cacc1a0000000", KASAN_GRANULE_SIZE);
> +
> +       /*

Please also extend the comment here to say something like: "Make sure
that strscpy() does not trigger KASAN if it overreads into poisoned
memory".

> +        * The expected size does not include the terminator '\0'
> +        * so it is (KASAN_GRANULE_SIZE - 2) =3D=3D
> +        * KASAN_GRANULE_SIZE - ("initial removed character" + "\0").
> +        */
> +       KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
> +                       strscpy(ptr, src + 1, KASAN_GRANULE_SIZE));
> +
> +       kfree(src);
>         kfree(ptr);
>
>         /*
> --
> 2.49.0.395.g12beb8f557-goog
>

The code looks much better!

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

