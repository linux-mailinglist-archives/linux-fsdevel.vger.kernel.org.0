Return-Path: <linux-fsdevel+bounces-60291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3674B4452F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 20:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB641CC33F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82068342C99;
	Thu,  4 Sep 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxDWRmlF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B72FFDC6;
	Thu,  4 Sep 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009859; cv=none; b=EFSWV1dGwiE50LexPKKfqhTqJa3t9m8mEPdiPAchvYwxn1GSKK5HaKzlA6zsIC12FB5Kv1iFxnxa9by8AFj8tNDAhBKkZBZ9t/NUnAcT43SHX/wGfptDoydF7WfsTPIrvtK1j3qudS+JbJ5wjgH3IVRy4SxrgAZJZHLzxjaD5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009859; c=relaxed/simple;
	bh=LYq5jMmwf1tK6A427+seN6JAweLGHNz8cuvRskLWoWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc/kQ1+3TaHPpCzs6FPxZ5ZT+qrtHGJgRGg1zipyhdX0+xEH9tSWQY5EjWoElwfXKabXaT7w9dKAEVMrtfBnmhsc22Yw/8VkNUb0Y6CsKnz3j5OawUKCZjc3Sr4rcl4dfTzDPI5bYaks7yMiyb8kvWVCal2IL9Nv3/0KNeOStts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxDWRmlF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso2024182a12.2;
        Thu, 04 Sep 2025 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757009856; x=1757614656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVl9M+7rBYeEk+Q4ereQo1MssY/lzOzRON17aSFuTwE=;
        b=OxDWRmlFYsxz9KEpnH3XropVm5aXgyGUVftStFfbc4AApQGNnuHCX3p81UlPMS7b+v
         E/dl23I9XWmU9MwdrXGY5jobmtakLNsWNYmRU2E4FRuzRyFIQsjScriLtr9oJmnQAezZ
         p3K7xuhBz+Sr6cNiKN31eSD6CVw+uStinNlHY27H9Owtv0EFKzaVTtmTHUQByDy5XgLC
         hyjmyUdJNuEu7afmEG7NSrz8lpWfcqtrlOngnVIJf98FgUUqg6RFqzrKVH2yeG/b2g3i
         fZLZNtnrS1QwPZPmNCj/419/4dXJncEG0zhr82ndm1Nn4ODbyurWmzaKfspxwlDmhPLQ
         362w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757009856; x=1757614656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVl9M+7rBYeEk+Q4ereQo1MssY/lzOzRON17aSFuTwE=;
        b=X03Rmh8oj5yeBYPMEUpDkKvtQEvR7FtVHCAkzVO6cpwX0328dBLHVTc4FR8/sWyy4a
         fSx0/fRAcJz6g/n5J/7MlOWkfiZwYkYTVHlkG/tog+gMDeEFksodDeqtyxl7htyVCT7a
         VSr94wgWvMHoSiXvUR98AZLHorA5iBseRbeq8jVkSvzqaHgFZ920b21hawbCe9dcL2gX
         FMeBsfQRKpchJj2cQ35g2boyIOM89XsdRNg0JifLhLDxLk19mTcK3DfkuOuJMAhprfbA
         Wrgs2deSPRNwIgEh8/9Zw855i9s+jf4k795a+wbR4KvzQ30aSizr/hHyxRabUl4qvNVo
         WhZA==
X-Forwarded-Encrypted: i=1; AJvYcCVTlBXW6fhDCya/OzcbTLxh8Q6tAOWWZ6zZtfRR7jJclgdr8cGlv8dLxaOCyuocvhBSTubqYlEqcHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhVd9T7s+YoQEq2IlOaGVAmeOO7KY1ITtv8XgMzBr9oJ6Qnny
	7D54jU4JNaFUAoYg++B6qaTvpGNEurwFy/UcV8SgZGMlvjT0NfnBezjEa1hPLJAvmAlku87IPZH
	VTNmcTuoI0A/GSWhsLBcGHujIHLneCGY=
X-Gm-Gg: ASbGnct24vkgiOsjEJjTzxnk05CkPjcGe/WpcTPZqdlGVkCXGwbg5ivo1ojX/aF/+en
	JPA9x4tCetvm0fhi8QluUr83BJj9fFAw3vl1tsqZU6DUlcQsZSLF8rDLwxilZtMt7qcyKOCreda
	B4vge/EqBvtC74IeJWllsCzt1C34BnaaHdOjLvH8vVMggMqdjVTv0b7Fbt64r+qwIyyMSZtHCoQ
	SjO9sik5yw+d76TcuWy7/VnNFgC
X-Google-Smtp-Source: AGHT+IGJz2JSIudgEVnDqRLiJcdmRiYal+DuCpFAIEVDl6VZtoOCZE1q2R+rgnd/I+RcowpUp6K16WAn0QPb3JC09ns=
X-Received: by 2002:a05:6402:2714:b0:61b:cadd:d95 with SMTP id
 4fb4d7f45d1cf-61d269974c9mr17198288a12.8.1757009856140; Thu, 04 Sep 2025
 11:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904062215.2362311-1-rdunlap@infradead.org>
In-Reply-To: <20250904062215.2362311-1-rdunlap@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Sep 2025 20:17:24 +0200
X-Gm-Features: Ac12FXweM2CRLKaIHwZXF44ldMbhiIcgbauy5mqyeZCT433IcAeKTjD7Y5imqKU
Message-ID: <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:22=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Don't define the AT_RENAME_* macros at all since the kernel does not
> use them nor does the kernel need to provide them for userspace.
> Leave them as comments in <uapi/linux/fcntl.h> only as an example.
>
> The AT_RENAME_* macros have recently been added to glibc's <stdio.h>.
> For a kernel allmodconfig build, this made the macros be defined
> differently in 2 places (same values but different macro text),
> causing build errors/warnings (duplicate definitions) in both
> samples/watch_queue/watch_test.c and samples/vfs/test-statx.c.
> (<linux/fcntl.h> is included indirecty in both programs above.)
>
> Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should be =
allocated")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> CC: linux-api@vger.kernel.org
> To: linux-fsdevel@vger.kernel.org
> ---
>  include/uapi/linux/fcntl.h |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
> +++ linux-next-20250819/include/uapi/linux/fcntl.h
> @@ -155,10 +155,16 @@
>   * as possible, so we can use them for generic bits in the future if nec=
essary.
>   */
>
> +/*
> + * Note: This is an example of how the AT_RENAME_* flags could be define=
d,
> + * but the kernel has no need to define them, so leave them as comments.
> + */
>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +/*
>  #define AT_RENAME_NOREPLACE    0x0001
>  #define AT_RENAME_EXCHANGE     0x0002
>  #define AT_RENAME_WHITEOUT     0x0004
> +*/
>

I find this end result a bit odd, but I don't want to suggest another varia=
nt
I already proposed one in v2 review [1] that maybe you did not like.
It's fine.
I'll let Aleksa and Christian chime in to decide on if and how they want th=
is
comment to look or if we should just delete these definitions and be done w=
ith
this episode.

Thanks,
Amir.

[1] https://lore.kernel.org/r/CAOQ4uxjXvYBsW1Nb2HKaoUg1qi8Pkq1XKtQEbnAvMUGc=
p7LrZA@mail.gmail.com/

