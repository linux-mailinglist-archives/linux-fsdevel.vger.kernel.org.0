Return-Path: <linux-fsdevel+bounces-61294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE6B574EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E9C3A2987
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B768D2F6181;
	Mon, 15 Sep 2025 09:30:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F792F532F
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928608; cv=none; b=kQHbJQuHxvNiD5JnYgO8tqjsPY1owJyw0xQi6d1osjZ17xV/hHwrooIB6EdErRzaCtCW9ze5ub/JgsLZ6RXe2D3/v9jdnj5PjWvKOnwkAGq+7MINoeQGk/70on3eMLiFOsyqsRKl7lRQVQXb0Ng8sUKDL5EQt8L0W5A/MHxViDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928608; c=relaxed/simple;
	bh=IPfAkde0yIe807ran5ppMP5AKOj4LL0szSvvHD1ISZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/maxiRwj3SehCsJPrso9WG8L1UIJLQ3ijSYrRs1uRAxvk8cOc7ISdkdFptNUX8XfA1rGfzpoKtU9X0oD/A6k2nwFr4UosLh7k5n11Axtt6mFJWvs0TFrYjtNziay9IWwzPmZZ02TQ+q/GmSi6mXZazRZnssHf1bwOEgYQPC+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d71bcac45so25670907b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757928605; x=1758533405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUgqfguSx0JYIQbP5NvpP/bDY9xe6RKpvq3Gm1FdLkc=;
        b=FTY/Bdz4aHZejIVPpyA/9dx/UAhudK70Pms5hplcAcsBoD6ASca7MiTS/DEOsJSCzo
         bSUr9Mymo8ldQ5TgbaeVaP97iGYirKG2F9q/WKY9nTTdI5XT8uJr3sHW/wYuGbL9vZPH
         x0aMWqZA5vsrgh/+3cpfXVnBwpbOLWP+B0jG+p255owVlbB+a/WYa0gg+uo8D26sOD5z
         YJwaYok3qsyn15nmv+pjlBLWDHdh4ZdUQT7ifKWdp8mYgn/T26p//YhuTuwtJg8E76FL
         BHE7DU9UXin9NepTr7ZuLlGciyfRbLBkb1t6I7d6sN7z9t36lXndBFwDMmy8GK5yJGEy
         QroQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv3mumDON+lEIxb8/0YVdd0noR/M04Jq3FGOBU7ra/9PvrbFraAYojBcTfmlMiRf8ErfFfO1bHBYKvoIpK@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiiPDDNKMQ2/GFA4f7AuIOKuTF6DGIEHHNbB86MYF/+ZxyXGn
	qMdJ6Uo8+4ErYDuo9lNNggHKMTvx7GyHPZwM46wokuBSKfqGpXlzYFb646nAM2qCOPg=
X-Gm-Gg: ASbGnct22JmWGKz/avZpkUZCbpxQE0idqHdt4Le1sAmIS9/JnMzX4qx/+2OfX4pAlwA
	4Q5Q7zgV1ljGb1Csd63qQzXyBVwOTHokhCEElIpviIM9SLqIsqrZLDMh40VrmTMqYG76IJQzv8P
	Q3U7HWl/ZOjhNCa0Sf1XPlfekudMlj5wzAgsWDHs8D7RZZ1ZPzy8ZlGrgo7rM2X8p1/SPrFRffS
	qrtVUkb8qMQNozbMy5ecNqmgDSUD9OWAmKwRYQ25qtS3mpwd5ntnv2e2jXePQ4yi5kBvfuTp0Ku
	wN8W1sAHbAr2DovLgdt7a+ycb2GH76MuGMx2y3ph/DBJs8Id2+5CPiHvzRY6D4OyRa/J99t/Cu2
	/jOpJaPVzsSVVLNFkItcxC68UCTLNqj7ZSdGh0rkk65Xgwi1XMLb6XOgLQtVZEqaY+2YXaA6r4k
	dKT9ceWN1VCpwOXpkMVHRPUE9zAatYIS+6PMuE
X-Google-Smtp-Source: AGHT+IHq2Jewe1b9Qi4nPky8Q7VqHqSZSMCufQAD6MVEhqlvWOyaqeyGYkEGocLHttnW41zUvorTnA==
X-Received: by 2002:a05:690c:b13:b0:724:bd93:2545 with SMTP id 00721157ae682-730636753cemr101956277b3.16.1757928604446;
        Mon, 15 Sep 2025 02:30:04 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76928fe2sm30788737b3.25.2025.09.15.02.30.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 02:30:03 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea059954d52so2616311276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:30:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJN4Q3kcu09r5wj8KLyKVmudkLOOQ4gCyUKA/ab43+aRjue/IZXwfgbftVZW5NsDpmC0DLgtO7gBY3Nv4r@vger.kernel.org
X-Received: by 2002:a05:690c:b13:b0:721:5c65:3993 with SMTP id
 00721157ae682-73065dab45emr87632207b3.50.1757928602683; Mon, 15 Sep 2025
 02:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912225022.1083313-1-slava@dubeyko.com>
In-Reply-To: <20250912225022.1083313-1-slava@dubeyko.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Mon, 15 Sep 2025 17:29:50 +0800
X-Gmail-Original-Message-ID: <CAC1kPDOhAKPncdZntt5HtHW7R8MrR067fDc2F2bMCS7Nb31a_g@mail.gmail.com>
X-Gm-Features: Ac12FXxzKymMRdt5cQqURo4JrYD7hjQPISVaVi5Z-22-BBGr38qbTamplaKsGbs
Message-ID: <CAC1kPDOhAKPncdZntt5HtHW7R8MrR067fDc2F2bMCS7Nb31a_g@mail.gmail.com>
Subject: Re: [PATCH v3] hfs: introduce KUnit tests for HFS string operations
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	frank.li@vivo.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com, 
	Chen Linxuan <me@black-desk.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:50=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> This patch implements the initial Kunit based set of
> unit tests for HFS string operations. It checks
> functionality of hfs_strcmp(), hfs_hash_dentry(),
> and hfs_compare_dentry() methods.
>
> ./tools/testing/kunit/kunit.py run --kunitconfig ./fs/hfs/.kunitconfig
>
> [16:04:50] Configuring KUnit Kernel ...
> Regenerating .config ...
> Populating config with:
> $ make ARCH=3Dum O=3D.kunit olddefconfig
> [16:04:51] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=3Dum O=3D.kunit olddefconfig
> Building with:
> $ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --jobs=
=3D22
> [16:04:59] Starting KUnit Kernel (1/1)...
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Running tests with:
> $ .kunit/linux kunit.enable=3D1 mem=3D1G console=3Dtty kunit_shutdown=3Dh=
alt
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D hfs_string=
 (3 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [16:04:59] [PASSED] hfs_strcmp_test
> [16:04:59] [PASSED] hfs_hash_dentry_test
> [16:04:59] [PASSED] hfs_compare_dentry_test
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PAS=
SED] hfs_string =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [16:04:59] Testing complete. Ran 3 tests: passed: 3
> [16:04:59] Elapsed time: 9.087s total, 1.310s configuring, 7.611s buildin=
g, 0.125s running
>
> v2
> Fix linker error.
>
> v3
> Chen Linxuan suggested to use EXPORT_SYMBOL_IF_KUNIT.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> cc: Chen Linxuan <me@black-desk.cn>
> ---
>  fs/hfs/.kunitconfig  |   7 +++
>  fs/hfs/Kconfig       |  15 +++++
>  fs/hfs/Makefile      |   2 +
>  fs/hfs/string.c      |   5 ++
>  fs/hfs/string_test.c | 133 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 162 insertions(+)
>  create mode 100644 fs/hfs/.kunitconfig
>  create mode 100644 fs/hfs/string_test.c
>
> diff --git a/fs/hfs/.kunitconfig b/fs/hfs/.kunitconfig
> new file mode 100644
> index 000000000000..5caa9af1e3bb
> --- /dev/null
> +++ b/fs/hfs/.kunitconfig
> @@ -0,0 +1,7 @@
> +CONFIG_KUNIT=3Dy
> +CONFIG_HFS_FS=3Dy
> +CONFIG_HFS_KUNIT_TEST=3Dy
> +CONFIG_BLOCK=3Dy
> +CONFIG_BUFFER_HEAD=3Dy
> +CONFIG_NLS=3Dy
> +CONFIG_LEGACY_DIRECT_IO=3Dy
> diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
> index 5ea5cd8ecea9..7f3cbe43b4b7 100644
> --- a/fs/hfs/Kconfig
> +++ b/fs/hfs/Kconfig
> @@ -13,3 +13,18 @@ config HFS_FS
>
>           To compile this file system support as a module, choose M here:=
 the
>           module will be called hfs.
> +
> +config HFS_KUNIT_TEST
> +       tristate "KUnit tests for HFS filesystem" if !KUNIT_ALL_TESTS
> +       depends on HFS_FS && KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds KUnit tests for the HFS filesystem.
> +
> +         KUnit tests run during boot and output the results to the debug
> +         log in TAP format (https://testanything.org/). Only useful for
> +         kernel devs running KUnit test harness and are not for inclusio=
n
> +         into a production build.
> +
> +         For more information on KUnit and unit tests in general please
> +         refer to the KUnit documentation in Documentation/dev-tools/kun=
it/.
> diff --git a/fs/hfs/Makefile b/fs/hfs/Makefile
> index b65459bf3dc4..a7c9ce6b4609 100644
> --- a/fs/hfs/Makefile
> +++ b/fs/hfs/Makefile
> @@ -9,3 +9,5 @@ hfs-objs :=3D bitmap.o bfind.o bnode.o brec.o btree.o \
>             catalog.o dir.o extent.o inode.o attr.o mdb.o \
>              part_tbl.o string.o super.o sysdep.o trans.o
>
> +# KUnit tests
> +obj-$(CONFIG_HFS_KUNIT_TEST) +=3D string_test.o
> diff --git a/fs/hfs/string.c b/fs/hfs/string.c
> index 3912209153a8..0cfa35e82abc 100644
> --- a/fs/hfs/string.c
> +++ b/fs/hfs/string.c
> @@ -16,6 +16,8 @@
>  #include "hfs_fs.h"
>  #include <linux/dcache.h>
>
> +#include <kunit/visibility.h>
> +
>  /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D File-local variables =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
>
>  /*
> @@ -65,6 +67,7 @@ int hfs_hash_dentry(const struct dentry *dentry, struct=
 qstr *this)
>         this->hash =3D end_name_hash(hash);
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(hfs_hash_dentry);
>
>  /*
>   * Compare two strings in the HFS filename character ordering
> @@ -87,6 +90,7 @@ int hfs_strcmp(const unsigned char *s1, unsigned int le=
n1,
>         }
>         return len1 - len2;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(hfs_strcmp);
>
>  /*
>   * Test for equality of two strings in the HFS filename character orderi=
ng.
> @@ -112,3 +116,4 @@ int hfs_compare_dentry(const struct dentry *dentry,
>         }
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(hfs_compare_dentry);
> diff --git a/fs/hfs/string_test.c b/fs/hfs/string_test.c
> new file mode 100644
> index 000000000000..e1bf6f954312
> --- /dev/null
> +++ b/fs/hfs/string_test.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for HFS string operations
> + *
> + * Copyright (C) 2025 Viacheslav Dubeyko <slava@dubeyko.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/dcache.h>
> +#include "hfs_fs.h"
> +
> +/* Test hfs_strcmp function */
> +static void hfs_strcmp_test(struct kunit *test)
> +{
> +       /* Test equal strings */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("hello", 5, "hello", 5));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("test", 4, "test", 4));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("", 0, "", 0));
> +
> +       /* Test unequal strings */
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("hello", 5, "world", 5));
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("test", 4, "testing", 7));
> +
> +       /* Test different lengths */
> +       KUNIT_EXPECT_LT(test, hfs_strcmp("test", 4, "testing", 7), 0);
> +       KUNIT_EXPECT_GT(test, hfs_strcmp("testing", 7, "test", 4), 0);
> +
> +       /* Test case insensitive comparison (HFS should handle case) */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("Test", 4, "TEST", 4));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("hello", 5, "HELLO", 5));
> +
> +       /* Test with special characters */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("file.txt", 8, "file.txt", 8)=
);
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("file.txt", 8, "file.dat", 8)=
);
> +
> +       /* Test boundary cases */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_strcmp("a", 1, "a", 1));
> +       KUNIT_EXPECT_NE(test, 0, hfs_strcmp("a", 1, "b", 1));
> +}
> +
> +/* Test hfs_hash_dentry function */
> +static void hfs_hash_dentry_test(struct kunit *test)
> +{
> +       struct qstr test_name1, test_name2, test_name3;
> +       struct dentry dentry =3D {};
> +       char name1[] =3D "testfile";
> +       char name2[] =3D "TestFile";
> +       char name3[] =3D "different";
> +
> +       /* Initialize test strings */
> +       test_name1.name =3D name1;
> +       test_name1.len =3D strlen(name1);
> +       test_name1.hash =3D 0;
> +
> +       test_name2.name =3D name2;
> +       test_name2.len =3D strlen(name2);
> +       test_name2.hash =3D 0;
> +
> +       test_name3.name =3D name3;
> +       test_name3.len =3D strlen(name3);
> +       test_name3.hash =3D 0;
> +
> +       /* Test hashing */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name1));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name2));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_hash_dentry(&dentry, &test_name3));
> +
> +       /* Case insensitive names should hash the same */
> +       KUNIT_EXPECT_EQ(test, test_name1.hash, test_name2.hash);
> +
> +       /* Different names should have different hashes */
> +       KUNIT_EXPECT_NE(test, test_name1.hash, test_name3.hash);
> +}
> +
> +/* Test hfs_compare_dentry function */
> +static void hfs_compare_dentry_test(struct kunit *test)
> +{
> +       struct qstr test_name;
> +       struct dentry dentry =3D {};
> +       char name[] =3D "TestFile";
> +
> +       test_name.name =3D name;
> +       test_name.len =3D strlen(name);
> +
> +       /* Test exact match */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
> +                                                   "TestFile", &test_nam=
e));
> +
> +       /* Test case insensitive match */
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
> +                                                   "testfile", &test_nam=
e));
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 8,
> +                                                   "TESTFILE", &test_nam=
e));
> +
> +       /* Test different names */
> +       KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 8,
> +                                                   "DiffFile", &test_nam=
e));
> +
> +       /* Test different lengths */
> +       KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 7,
> +                                                   "TestFil", &test_name=
));
> +       KUNIT_EXPECT_EQ(test, 1, hfs_compare_dentry(&dentry, 9,
> +                                                   "TestFiles", &test_na=
me));
> +
> +       /* Test empty string */
> +       test_name.name =3D "";
> +       test_name.len =3D 0;
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, 0, "", &test=
_name));
> +
> +       /* Test HFS_NAMELEN boundary */
> +       test_name.name =3D "This_is_a_very_long_filename_that_exceeds_nor=
mal_limits";
> +       test_name.len =3D strlen(test_name.name);
> +       KUNIT_EXPECT_EQ(test, 0, hfs_compare_dentry(&dentry, HFS_NAMELEN,
> +                       "This_is_a_very_long_filename_th", &test_name));
> +}
> +
> +static struct kunit_case hfs_string_test_cases[] =3D {
> +       KUNIT_CASE(hfs_strcmp_test),
> +       KUNIT_CASE(hfs_hash_dentry_test),
> +       KUNIT_CASE(hfs_compare_dentry_test),
> +       {}
> +};
> +
> +static struct kunit_suite hfs_string_test_suite =3D {
> +       .name =3D "hfs_string",
> +       .test_cases =3D hfs_string_test_cases,
> +};
> +
> +kunit_test_suite(hfs_string_test_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for HFS string operations");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> --
> 2.51.0
>
>

Reviewed-by: Chen Linxuan <me@black-desk.cn>

