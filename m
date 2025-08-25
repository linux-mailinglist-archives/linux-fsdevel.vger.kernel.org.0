Return-Path: <linux-fsdevel+bounces-58956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB24B33616
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3B91B211F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 05:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16E27A129;
	Mon, 25 Aug 2025 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC5ISAKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB31F5619;
	Mon, 25 Aug 2025 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101498; cv=none; b=k7wbomAZucuQT51rTO1qHGuF9FbfWexPfTqdNzVH32OqXf9QSh4oZEwyIN95dGt+Jhcnvvp4Whq3OrIIbXcS49+lDzqG9Mxh8FM4bwXu76QptVVqM9YiLFv0qBGc2vwhytKv20YZ3pCQwFgO37oETeFoB3oap+kzcZs7T4OvpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101498; c=relaxed/simple;
	bh=BXcUrDaM8Vpm5YcaAJv3oAER9sxm2uCM0g8H5RxShg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww3ZqxRn16k1Bi2xJeMpodUnKHA4uV/lVhpzO6irhzfo7ojPZX1BdiuTbJLg7Y0BN/FZPBTNSV/sTE6NlhGAVnFPswLhrVVaJZNlM6KOS+AVcyp4opQ6nDnN3Kp+s/8MYDxrkzycy/DTdlDFxiWHl17eBvvopG1L9Ewh5x/kJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC5ISAKY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c30ceacdcso2859289a12.1;
        Sun, 24 Aug 2025 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756101494; x=1756706294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA8LV5qkpLnwKPRqJhtAhmyH3VxK3FEWXEtgKtIE5CU=;
        b=GC5ISAKYI3AeLh8vmC0dmc28qP49oCSXbUgNCKUSZ4lkcrjSD5bCTt7/TE8/sOS1+d
         BwHXFzqsgCCKHjQuSSqLuvsZJDgjkBou51UMRWJo1aadAmfu3ITe30JJTurFdECppl9g
         NYQGkg+2Fr5Y9jrGbJKSQJAO8dpswuyk6+JNAHbRocmho/YfgPC+xOixGn/MmMKBaEpD
         pMn8FB0j91LqcfqWU73nUmIpFgvq223F/amVYh6DY45tdDQJQdE+lzfXeHB8+fAKtOZ5
         p0qJKqtOSA+OEjUJrwiHNJJ9ei+LRC0tVGk1c6+VxYVr9MT4BsS/vIIIHDUhG0yesjXx
         0x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101494; x=1756706294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA8LV5qkpLnwKPRqJhtAhmyH3VxK3FEWXEtgKtIE5CU=;
        b=iJ0PXuZtAGcccC9kyVpWxVJpgd11/QBWeujyq2hkF7m7Aa09EECuEgtKCuBSCJvoN8
         UZ7YZjWIZJ31X0sUFZ38wRdP3Ftx9bF9qxyHUiDbPSfwVieChvwQEEzz2rU16XNgVA6T
         7FRuU9WK6E4IYpTlT5YL825NMVuhWipahGzwifhYrDhwKjG6e/yUS4ESVAdbdbaGUyEi
         psV47KfMWFqm5StINuHv8u+7tjyULPs72ml8ITiO3qpQMezPv0DRF8ICictwQW0ioB5T
         zD5WIlwInLgBm3R+4bY48GLT3o7p2JfyT7zoD95fQ0U5r6D/L5BDkrdiPh2WGsK4qw2e
         IcYw==
X-Forwarded-Encrypted: i=1; AJvYcCU0cvZTWTqlpQ14dsMt/TvJ7bV/i+vTAcrQsaVwXyr7K8j8M272elN1rxnrU1TquP0kDkGfIumWSbM=@vger.kernel.org, AJvYcCVZMn1cSrXo/IBio2GbOQjKAcLomlai+gnnRBlV8SJ9InOMpQHbb3F7HzVe6LoFa0SZtUmp5CLcGbp4isNmEA==@vger.kernel.org, AJvYcCVh0XIcxbGzOG8AVAhermgQWklLoo1h0KFugLMYk/5oXxfAiZD1/5c/m93i0NLU+5NnzxEJ4FkmSQ/4YdJC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AVNTVkBryLNZwGzXja6fd9Q2UcP87BYl4vPhNAHbgGBW8iQc
	UbRXYYRa7sZypKcGmrAynzEylT4L2TeXbbmh8/Cg44LSVwzoEMh/AA77XrXByoUpUPkVzBnWTnD
	4mn7DfCIGy0HdLq6QTqZrEpsJX6eVzGbFW5+U0Ls=
X-Gm-Gg: ASbGnctpqz+3uzJ9Z5GZPUXWCRVHRXqSK2X4PfCpQNXwmB8GzDaoa7bN3b4ATwY0f1p
	zmhA5Tecnml525z3Dy5KPHpTtb8m5Cmf67ReNnqdCn4j+F9ZrxszTLqHkAlWizqfdK84Hk6mzyv
	K77rUS3C/DSJcKjU617i65kO+2uHe+/c6aTGJxjXBUv4uYlBZuW1DHQu1LFCEyW345TrCwSveML
	4GbkFw=
X-Google-Smtp-Source: AGHT+IH1AuDcZ7oKwTGe3soJrH0kmydiJxV4W5SbB3BHcvtWa929sL7oOJDOnzaAvtFeO9t7uGk/hIJYvstkWFoQzg4=
X-Received: by 2002:a05:6402:3594:b0:613:5257:6cad with SMTP id
 4fb4d7f45d1cf-61c1afd3368mr9440210a12.11.1756101494297; Sun, 24 Aug 2025
 22:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824221055.86110-1-rdunlap@infradead.org> <aKuedOXEIapocQ8l@casper.infradead.org>
 <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
In-Reply-To: <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Aug 2025 07:58:02 +0200
X-Gm-Features: Ac12FXy-XGV5AjtO-eZ_IexXne5nftjy5F_iHheYbB1l8u7dNSeTWbeUT7Wzcac
Message-ID: <CAOQ4uxiShq5gPCsRh5ZDNXbG4AGH5XpfHx0HXDWTS+5Y95hieQ@mail.gmail.com>
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
To: Randy Dunlap <rdunlap@infradead.org>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:54=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 8/24/25 4:21 PM, Matthew Wilcox wrote:
> > On Sun, Aug 24, 2025 at 03:10:55PM -0700, Randy Dunlap wrote:
> >> Don't define the AT_RENAME_* macros when __USE_GNU is defined since
> >> /usr/include/stdio.h defines them in that case (i.e. when _GNU_SOURCE
> >> is defined, which causes __USE_GNU to be defined).
> >>
> >> Having them defined in 2 places causes build warnings (duplicate
> >> definitions) in both samples/watch_queue/watch_test.c and
> >> samples/vfs/test-statx.c.
> >
> > It does?  What flags?
> >
>
> for samples/vfs/test-statx.c:
>
> In file included from ../samples/vfs/test-statx.c:23:
> usr/include/linux/fcntl.h:159:9: warning: =E2=80=98AT_RENAME_NOREPLACE=E2=
=80=99 redefined
>   159 | #define AT_RENAME_NOREPLACE     0x0001
> In file included from ../samples/vfs/test-statx.c:13:
> /usr/include/stdio.h:171:10: note: this is the location of the previous d=
efinition
>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> usr/include/linux/fcntl.h:160:9: warning: =E2=80=98AT_RENAME_EXCHANGE=E2=
=80=99 redefined
>   160 | #define AT_RENAME_EXCHANGE      0x0002
> /usr/include/stdio.h:173:10: note: this is the location of the previous d=
efinition
>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
> usr/include/linux/fcntl.h:161:9: warning: =E2=80=98AT_RENAME_WHITEOUT=E2=
=80=99 redefined
>   161 | #define AT_RENAME_WHITEOUT      0x0004
> /usr/include/stdio.h:175:10: note: this is the location of the previous d=
efinition
>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>
> for samples/watch_queue/watch_test.c:
>
> In file included from usr/include/linux/watch_queue.h:6,
>                  from ../samples/watch_queue/watch_test.c:19:
> usr/include/linux/fcntl.h:159:9: warning: =E2=80=98AT_RENAME_NOREPLACE=E2=
=80=99 redefined
>   159 | #define AT_RENAME_NOREPLACE     0x0001
> In file included from ../samples/watch_queue/watch_test.c:11:
> /usr/include/stdio.h:171:10: note: this is the location of the previous d=
efinition
>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> usr/include/linux/fcntl.h:160:9: warning: =E2=80=98AT_RENAME_EXCHANGE=E2=
=80=99 redefined
>   160 | #define AT_RENAME_EXCHANGE      0x0002
> /usr/include/stdio.h:173:10: note: this is the location of the previous d=
efinition
>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
> usr/include/linux/fcntl.h:161:9: warning: =E2=80=98AT_RENAME_WHITEOUT=E2=
=80=99 redefined
>   161 | #define AT_RENAME_WHITEOUT      0x0004
> /usr/include/stdio.h:175:10: note: this is the location of the previous d=
efinition
>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>
>
> > #define AT_RENAME_NOREPLACE     0x0001
> > #define AT_RENAME_NOREPLACE     0x0001
> >
> > int main(void)
> > {
> >       return AT_RENAME_NOREPLACE;
> > }
> >
> > gcc -W -Wall testA.c -o testA
> >
> > (no warnings)
> >
> > I'm pretty sure C says that duplicate definitions are fine as long
> > as they're identical.
> The vales are identical but the strings are not identical.
>
> We can't fix stdio.h, but we could just change uapi/linux/fcntl.h
> to match stdio.h. I suppose.

I do not specifically object to a patch like this (assuming that is works?)=
:

--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -156,9 +156,9 @@
  */

 /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
-#define AT_RENAME_NOREPLACE    0x0001
-#define AT_RENAME_EXCHANGE     0x0002
-#define AT_RENAME_WHITEOUT     0x0004
+#define AT_RENAME_NOREPLACE    RENAME_NOREPLACE
+#define AT_RENAME_EXCHANGE     RENAME_EXCHANGE
+#define AT_RENAME_WHITEOUT     RENAME_WHITEOUT


But to be clear, this is a regression introduced by glibc that is likely
to break many other builds, not only the kernel samples
and even if we fix linux uapi to conform to its downstream
copy of definitions, it won't help those users whose programs
build was broken until they install kernel headers, so feels like you
should report this regression to glibc and they'd better not "fix" the
regression by copying the current definition string as that may change as p=
er
the patch above.

Why would a library copy definitions from kernel uapi without
wrapping them with #ifndef or #undef?

Thanks,
Amir.

