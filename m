Return-Path: <linux-fsdevel+bounces-59942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646BCB3F60D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE45E1A86D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EE2E5B05;
	Tue,  2 Sep 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4XOk3kM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19F279787;
	Tue,  2 Sep 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796335; cv=none; b=lAwhw9m8h8TVNDojWJOFpB6eDPT94KZkE/M3ZcTh86rTR8Q1pOy71zTl3aFPdCOo/AvPm9nnBGN4NZXg02/4C3z2RBZifGHT4Uz8KKRqFcbfprywEZXmzxLKc1PJ8PIiu8WXOpHBarLzaIRJMnDtRTxhWrzbcwgCkFkgEwjildg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796335; c=relaxed/simple;
	bh=FxyB8KmeO2NsdMIYJ6uPIuHJnw18rr2QCLh3a8/xg20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZuutEqrVZnpxbJSANtLJcKHVI+mUv0WJp3PBA0lhdr54Qp6vfV7n/JwO3FcJCCWFhVjU0bHd7KbJxS5DgeaEvevjLEuhTk+OXHwu1PKCFIUWgi6JfaQFsGYRMFx1A1JU8oCsMzjiN7t2EjamZoasL3bM6FqMk/T5SpGNrL5naM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4XOk3kM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so7990951a12.3;
        Mon, 01 Sep 2025 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796332; x=1757401132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcgGJ/OYvj+YieT2Mj26UykE9RBcjh8dHLuyKc8kxcQ=;
        b=X4XOk3kMph49cTjv0poendEQjYx29mhhghAEn10XlPffOzVvYYdtyVmozUK/31QTdF
         vyepB5zciznube3gXY9oUZNhH5TRt0hRDcfuuVIQj4W/SNGNRdHm6I/2szGUMV1teT+g
         9P+wsfa8icC5Vn4DnjUXPEg7SfbCLRkZcl47+63n1UZ9YAr9uuTjI/w7+21d5gOtl9fp
         pV66WvdY2B+x6/RLpbJ02U8IJVLVl5TNVOTlB3Yp11GwKj2IqYoMW7f0ImzCbux4iJYV
         uMeQDMm2JUQlNs6k8qZu/131GE2EWWWjpVJrZvHgMh83LPAFufG3J+htwBOEQbYqjkDD
         m9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796332; x=1757401132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcgGJ/OYvj+YieT2Mj26UykE9RBcjh8dHLuyKc8kxcQ=;
        b=PcfGasjhTpuk60wiT4iB0jhTFAUH/VLzaKxlzcHzSuIEhOcEpOpXu58tV4bohYuffl
         WwoJn1gybAQejfYmIRxIZ06eUTUrB/PBqxYJyQG6JnadPKjoAhOxYOObPoG5Dejngg72
         NC/YicmWSxuNBguB7IJZicRFdRgDizelvnsPQZubcBDcL2TZnGBw6yybBIMCcx4F33Y/
         /X+exKc6gg73bcGE7HVTqHPNBWvLrUQpcQD6r1JPvOB4GYM0F0IsoAhf7WJUcCQ5w1LO
         vEJs9QAd+6vhkQwFlwhKWQO4lkvcdnapaVGePOvQHZ6NMTydQmZ34Ds1F2OlgqGTe/8w
         OgGg==
X-Forwarded-Encrypted: i=1; AJvYcCX2zrj7UvEmB+sAy+O2XniPxrS30SF9ZTOn5FM/2SHQP6icECYs3SkVOVQHEDYmXHZxUnm8h2ZX3lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzZxDmwSQvY0qaeiLtWI6BKlWk4nRbvxSS+BQlvigbYhAXbTB
	g15S86XX/3jUppt9u3ay/d1w6TXqak+cO4vld20CBpNhkmKEA2o90moTTIdhFjuuCcASYa+pswK
	kYS2IUlzHrqZUaPoL7tGHrBgXpLwzK84=
X-Gm-Gg: ASbGncvU6mLn4maSsCzc2FGD+lC7QNWXU82amkI0wPKPVclSvJ+VJFQ4gZ9kk3F5x0f
	3I36G+Zb94sHlTNNGvYgE8nLwt3izeMpg8MAMK7ER6lHTDjLKaOAvqxiEB/xx/yEum4vvN9KLJn
	TPhK1SNETT8/usadRuP1JCGi35Mom3ya+FqfAViSrQqCfd9wIo9Njx3JffUV8fwof3TQeWkfIEo
	kDmDNk3hlfro3Drxg==
X-Google-Smtp-Source: AGHT+IHtxRdy/cLBH9rL18FC84yByLcaoc43KzkNVlknKUEcHp6Ul3SE5+4+xVW28Ki8sLRZg6VPCoBHV2tJefNOaOg=
X-Received: by 2002:a05:6402:274d:b0:61e:95b0:c95d with SMTP id
 4fb4d7f45d1cf-61e95b11582mr5639504a12.19.1756796331930; Mon, 01 Sep 2025
 23:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901231457.1179748-1-rdunlap@infradead.org>
In-Reply-To: <20250901231457.1179748-1-rdunlap@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Sep 2025 08:58:40 +0200
X-Gm-Features: Ac12FXz70y9An6zSkD9I5T6JyN4lQ-aLSWISxg8ShazAXP3F9zmY8IGf3i4xCAk
Message-ID: <CAOQ4uxjXvYBsW1Nb2HKaoUg1qi8Pkq1XKtQEbnAvMUGcp7LrZA@mail.gmail.com>
Subject: Re: [PATCH v2] uapi/fcntl: define RENAME_* and AT_RENAME_* macros
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:14=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Define the RENAME_* and AT_RENAME_* macros exactly the same as in
> recent glibc <stdio.h> so that duplicate definition build errors in
> both samples/watch_queue/watch_test.c and samples/vfs/test-statx.c
> no longer happen. When they defined in exactly the same way in
> multiple places, the build errors are prevented.
>
> Defining only the AT_RENAME_* macros is not sufficient since they
> depend on the RENAME_* macros, which may not be defined when the
> AT_RENAME_* macros are used.
>
> Build errors being fixed:
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
>
>  include/uapi/linux/fcntl.h |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
> +++ linux-next-20250819/include/uapi/linux/fcntl.h
> @@ -156,9 +156,12 @@
>   */
>
>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> -#define AT_RENAME_NOREPLACE    0x0001
> -#define AT_RENAME_EXCHANGE     0x0002
> -#define AT_RENAME_WHITEOUT     0x0004
> +# define RENAME_NOREPLACE (1 << 0)
> +# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> +# define RENAME_EXCHANGE (1 << 1)
> +# define AT_RENAME_EXCHANGE RENAME_EXCHANGE
> +# define RENAME_WHITEOUT (1 << 2)
> +# define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>

This solution, apart from being terribly wrong (adjust the source to match
to value of its downstream copy), does not address the issue that Mathew
pointed out on v1 discussion [1]:

$ grep -r AT_RENAME_NOREPLACE /usr/include
/usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE  0x0001

It's not in stdio.h at all.  This is with libc6 2.41-10

[1] https://lore.kernel.org/linux-fsdevel/aKxfGix_o4glz8-Z@casper.infradead=
.org/

I don't know how to resolve the mess that glibc has created.

Perhaps like this:

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index f291ab4f94ebc..dde14fa3c2007 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -155,10 +155,16 @@
  * as possible, so we can use them for generic bits in the future if neces=
sary.
  */

-/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
-#define AT_RENAME_NOREPLACE    0x0001
-#define AT_RENAME_EXCHANGE     0x0002
-#define AT_RENAME_WHITEOUT     0x0004
+/*
+ * The legacy renameat2(2) RENAME_* flags are conceptually also
syscall-specific
+ * flags, so it could makes sense to create the AT_RENAME_* aliases
for them and
+ * maybe later add support for generic AT_* flags to this syscall.
+ * However, following a mismatch of definitions in glibc and since no
kernel code
+ * currently uses the AT_RENAME_* aliases, we leave them undefined here.
+#define AT_RENAME_NOREPLACE    RENAME_NOREPLACE
+#define AT_RENAME_EXCHANGE     RENAME_EXCHANGE
+#define AT_RENAME_WHITEOUT     RENAME_WHITEOUT
+*/

 /* Flag for faccessat(2). */
 #define AT_EACCESS             0x200   /* Test access permitted for

