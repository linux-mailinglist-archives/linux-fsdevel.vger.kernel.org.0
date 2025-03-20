Return-Path: <linux-fsdevel+bounces-44626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF4A6ABF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7CF480113
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A5225793;
	Thu, 20 Mar 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV1vnlxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F0223706;
	Thu, 20 Mar 2025 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491519; cv=none; b=LgP2mGo3yWZbHDEs6xK60t+kWNtyu2DitrXWM6jmWTjIZgmQ8m3DDawAT9wZS287vgmnTGIb9N1OEhyx9niVqKv326XZqJSW5c2xIzmw1nIxiTblNEaSvoHHP9iMWDq9Kp4W4MVxFemLkXPnIComWZ5JitVfiJk1LKeEqdYSgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491519; c=relaxed/simple;
	bh=4zqqM/obyW2E0BuqiJ/Nxhmg3i/+8Sb12y9pHFBqpXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdzvEN1CpubXyrSxADbxTqn6OP2UwantdZ/BTdZ4GFazkYiQnqwhG0lX13hfVJASDGsrPRWhz1WNZPtAoPRJy9nJL5vmAnuoipC4UjPj/3Om9wvHntOuxkAW0oWoIzwqHJbfpuCoOZx0RBb+1xzQmtF8e97jDhExE+VegBj6vSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV1vnlxc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3997205e43eso856179f8f.0;
        Thu, 20 Mar 2025 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742491516; x=1743096316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Srr0VBZQwN4yXqvwN4Xth0EZBYASL+7tLcIViL1r650=;
        b=XV1vnlxcopTo0M+QJMUADjcOqKg4eddLqrJ26Jrcx/CnmaqvEI9jLQtEU5hngR0Jw3
         ZkLRaz50+jeLB4Bei0OhCpO+d92hbibOgDwy+uaXpq/NK3BI3m5hDYftjuhSo7W4IoR9
         QfyRYcZWso6g8J1Tvks8NNC7+NAcyKZjn3nrWM/we1frAe1HVDTegCS3MyZj8PQDqcy/
         duc6qwCV42gy1g4XHsKwrqcemMksItFCF+HpswP12puoB9Fuo84+NhlHrpiCf9gKjfYV
         MALyfs9LrQWH2Wh5k3zPBlv4qkoT7U0sgwjp4BC5C2GW8SDcH2YwAD/wu87F4VYRnCrV
         Pmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742491516; x=1743096316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srr0VBZQwN4yXqvwN4Xth0EZBYASL+7tLcIViL1r650=;
        b=MYMcz+QT3x996vvKJNral6nnaoSlgKiSQrxdBxExLxkzbZMXNct2/IIgGg9c8dAOYq
         bCwWHeRCtVPI2XSJBmZIFWwEhX0hlRP+v2JN/wN3I3stDw48GL2tY1tnHyYrIpLDw1uf
         hPTCIeivOUeY01a5UAO/DqxQ7/2skkgZ6016BdXSTXil87hjNC7gV2Ano17Tn5/FnSKV
         Qv4f1ObufpdaEte42tHMMTgUOxDoTnGl24YWvfDYsQ/1vyUtONiJbps9m1+zCqJSSXVh
         5i9RfYMxtLVugEShn/IWsfXjqwgwfCnyBSYy5R7u/8H/5fln2+GgkvMWUBWRnLUqjrwJ
         Vs8w==
X-Forwarded-Encrypted: i=1; AJvYcCUK6N+N0Vx3xGY9CMNU7N9Ox8lQLMc0y6oRfrLS7VAtMTTJFfPiAPHvSye7ihBXdqzt4Ecn14AZ2D9Cew9z@vger.kernel.org, AJvYcCWIz1yk+ozHqQ6FCgZyHZk/+yWRfT/qa4GgmgVwqUr6RGggJNMkMvHr/oIrRjQSWoEpQLs3iJ7ha5q2MxsW@vger.kernel.org, AJvYcCXyHZagZTVYnX00o1wn0YVaTAhhCIHvxrW06f4N8GdRK6QOLpuD9XtFePp4SG/uIHrp/T6/XXT/K9Lh92AnEHwX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5G4zYJrIb880pvWuEhTrMraPveMalCA0lyAXECDYU+Bv7Zlnj
	sDYvCNQJJtMkc8HhJhqj0bEg+l8031UngNWOmSL5JWDiBjABCAo5VZCw7d5MV+k3S4MaNxBeSf0
	hMpl1ZQXGexoo0PzfbfyjaH39OrU=
X-Gm-Gg: ASbGncuS2cbJCvMqwG0F2PcPO3hprfRN51NfQQfKevUkbfEx8ym8piQw+atitOMGUqb
	5neLKplmp04a7LclYQEAyks0+mK5m3gogSiPx739P4q8FxNcyeute/bzrQRqcvrcg92NmwwFbjT
	OdiodBmREOHdTBzYBAui6FBloUlfc=
X-Google-Smtp-Source: AGHT+IHbGxKbQYCFuWIhUZcVJczLm09+fIRHtWAIdQXRdJS6TuroZiuhT9dXX9oyzczviIbaRcswg6Yl68ThvI97uCA=
X-Received: by 2002:a05:6000:21c6:b0:385:d7f9:f157 with SMTP id
 ffacd0b85a97d-3997f9375admr249521f8f.36.1742491515474; Thu, 20 Mar 2025
 10:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318214035.481950-1-pcc@google.com> <20250318214035.481950-3-pcc@google.com>
In-Reply-To: <20250318214035.481950-3-pcc@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Mar 2025 18:25:04 +0100
X-Gm-Features: AQ5f1Jokd8HHitZidj6J_qrj1ibwtVddlmZs6GFQ40Nq--4p2Wt3mzW0XeogKWQ
Message-ID: <CA+fCnZfG79JmGG9rj7KbE=9yX-EM4e8CXDSm5F9=YEmgyX5v3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
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

On Tue, Mar 18, 2025 at 10:41=E2=80=AFPM Peter Collingbourne <pcc@google.co=
m> wrote:
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
>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a252=
274120e77b1898a
> ---
> v2:
> - rebased
> - fixed test failure
>
>  mm/kasan/kasan_test_c.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 59d673400085f..c4bb3ee497b54 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1570,7 +1570,9 @@ static void kasan_memcmp(struct kunit *test)
>  static void kasan_strings(struct kunit *test)
>  {
>         char *ptr;
> -       size_t size =3D 24;
> +       char *src, *src2;
> +       u8 tag;
> +       size_t size =3D 2 * KASAN_GRANULE_SIZE;
>
>         /*
>          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYP=
T.
> @@ -1581,6 +1583,33 @@ static void kasan_strings(struct kunit *test)
>         ptr =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       src =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +       strscpy(src, "f0cacc1a00000000f0cacc1a00000000", size);
> +
> +       tag =3D get_tag(src);
> +
> +       src2 =3D src + KASAN_GRANULE_SIZE;
> +
> +       /*
> +        * Shorten string and poison the granule after it so that the una=
ligned
> +        * read in strscpy() triggers a tag mismatch.
> +        */
> +       src[KASAN_GRANULE_SIZE - 1] =3D '\0';
> +       kasan_poison(src2, KASAN_GRANULE_SIZE, tag + 1, false);
> +
> +       /*
> +        * The expected size does not include the terminator '\0'
> +        * so it is (KASAN_GRANULE_SIZE - 2) =3D=3D
> +        * KASAN_GRANULE_SIZE - ("initial removed character" + "\0").
> +        */
> +       KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
> +                       strscpy(ptr, src + 1, size));
> +
> +       /* Undo operations above. */
> +       src[KASAN_GRANULE_SIZE - 1] =3D '0';
> +       kasan_poison(src2, KASAN_GRANULE_SIZE, tag, false);
> +
> +       kfree(src);

I have trouble understanding what this code is doing...

So the goal is to call strcpy with such an address, that the first 8
bytes (partially) cover 2 granules, one accessible and the other is
not?

If so, can we not do something like:

src =3D kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
strscpy(src, "aabbcceeddeeffg\0", size);
strscpy(ptr, src + KASAN_GRANULE_SIZE - 2, sizeof(unsigned long));

Otherwise, this code needs more explanatory comments and it's probably
better to move it out to a helper function.

>         kfree(ptr);
>
>         /*
> --
> 2.49.0.395.g12beb8f557-goog
>

