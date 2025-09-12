Return-Path: <linux-fsdevel+bounces-61116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA76B55575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 19:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24365188DF31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6DE23D7FB;
	Fri, 12 Sep 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="IlM/TLct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94122156D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697878; cv=none; b=CLqg7oujG4orkn63l6FwTzgt7A4auVfJnCZcowfMQVboNP87O717bhr6pzKrUabOPjNF/JwJlo/+Cz9c2imfVMyALa0DMtMH7wc8pO5QCNsPXlrvtHphCPM3J02T7PlnXRYXmuFff0kJT3w+Bb112SIpzJIse3zjmxgFVx5b/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697878; c=relaxed/simple;
	bh=GNda1Tqgo5nBnuwAblGqyd2aIYh1plyjY+lq98uDEm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kw0mW4jEUtfaJ7Z3IF6uXdRzdmOmlrvYGYA2cXdWSuZhUu9I1h9Gr8nhDdIz1al1wRu66vwPyFboFW8Stost3C83ORXkeN7jiBvEOS5SiZPEJ5yBomMUs/fPB7csfzW8Lpsvnebj4lBz0Em/I90umTd+78Mx+YLmO42KscGIW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=IlM/TLct; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d601859f5so15716007b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757697874; x=1758302674; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GNda1Tqgo5nBnuwAblGqyd2aIYh1plyjY+lq98uDEm0=;
        b=IlM/TLctJn7+znaT+rATeAg6U6a2aSfOZr93bX98jKwyeGl/GAAfow+k4mf6EJ+oYM
         ScUx9iaq/yHLWzbb7kunL7PsQF0DzqpAjhAxdShqw/8XDJpYIjMY5n9hvwoxq3P9N0Dh
         hE9MfLYQdYBsjq54BwpIIMvDMGPERrIE++DOe8KOCyLrFXCI9Vz8MGJDOdx7mI3zfgmq
         YGQf7umhBiwC7qLRuKe3rzmktt1EnT4qhgyJ8apPElylR2Ju5hsw4e6jJPu9EwjAKgWH
         0GFDPV5YGrjdIma6yDpPPOR6//JOmJ9mnTBoE68l9BSjh1gW0GVJ+2IEmAXJrAtYBc1w
         6oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757697874; x=1758302674;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNda1Tqgo5nBnuwAblGqyd2aIYh1plyjY+lq98uDEm0=;
        b=X5Ap6TkIbfbqelYAvoUrQY1yojyqkkOE/vJ03s6c8v4H+VH+aaIJ+xebJioW/GBPVI
         Wb2D96yCbLdLVdwcn1a1BEfJ3yeahRWoRb5vV/c8JDUv8U3Ov9VQD+v/f/gm2Pgx363l
         xXxlZneTUqQZbI8gFKmzHYKRPRW3aiZJ3LM6T3/1hMMrGPYc5gGn6WLe/KYy97PTJDmO
         P6CvPnSZzueOzETKBjEyNgcVfshs6q/naCW0Z+mM9Ri1KQYaXbJBCdE83ULlGFTbQr0q
         UdmDIqSD3uFSsgoDhRVs/qV5GaVW8zmEFi2Zen5pZemAazyplXvW72Wet4DjAvIuqyt1
         k2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU6UCkPILkMhwZgcyCxyLfc2ODnJir5eg0FQZN4bRphbrMa/vLzRY69E9h4vFzekF9zpTqSL/MKe9bUlUdF@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEz7ylMw7VsCzcQeh4OCXwYI83V0PlDMqHApeg9zTfZyZ5fDF
	rE7SbzE5TrM+I3S+0WxELdeycF1gtGBP4TPZBiPlluyxFhmmQ/ck2EQGPf5YaVsbetsfY9kZlJH
	nB3B1
X-Gm-Gg: ASbGncv9es+TEm4RS239PQw4kpXZ0YIoDbKsNFx/l/Xq478q1iwrhlHD8sC4T5srrzP
	8GcTwJoaTGwFGEP1LaQXsLGUVvcsE6mexRSSpAhp7WqIWCpgkdH8g6a1XjpdZijV71THxX/Hclw
	zzhzRWuXDkCsvCnSRPoxb2b1XEIchJmPijpNUgtdy3Ltgqx7ti89eWBEisTeN49bKkxbr8qEQVp
	Vf4WuQsdEaGwfGt7TsL5gpvLYntE3QcP1gv2KTH4irSL1r4januy/I6U5SWp8lRr7R/DL4cCNkq
	hmAJoOZSCBi1Z8IyXC2RA6kAm/xttvTCUHO5fW6IMolSs13gBntVZGP0OxxOg/b25R+KEaKYL79
	yZydVo0s8/Kz1Icy2v9YM3VbeAdnz3pcMuw==
X-Google-Smtp-Source: AGHT+IHvafv5tnJPapurY3GyBYLK0eg8KNhNzONbNk1Y6sMF6Z205JRh66hecza4Dn2ov7caMUSTrA==
X-Received: by 2002:a05:690c:4d82:b0:721:6b2e:a073 with SMTP id 00721157ae682-730655c91b4mr33300047b3.45.1757697874571;
        Fri, 12 Sep 2025 10:24:34 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:b6c1:d48b:d9e8:3fbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76238386sm12488137b3.8.2025.09.12.10.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 10:24:33 -0700 (PDT)
Message-ID: <4158dcc4aaf605453473839ca436ed125e6bea47.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: introduce KUnit tests for HFS string operations
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: black_desk <me@black-desk.cn>
Cc: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	frank.li@vivo.com, Slava.Dubeyko@ibm.com
Date: Fri, 12 Sep 2025 10:24:32 -0700
In-Reply-To: <CAC1kPDO9jCx73_PqRtFRMLyTp7KmX6PzpN+LFL4gw6Pckju-HA@mail.gmail.com>
References: <20250912010956.1044233-1-slava@dubeyko.com>
	 <CAC1kPDO9jCx73_PqRtFRMLyTp7KmX6PzpN+LFL4gw6Pckju-HA@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 11:28 +0800, black_desk wrote:
> On Fri, Sep 12, 2025 at 9:10=E2=80=AFAM Viacheslav Dubeyko
> <slava@dubeyko.com> wrote:
> >=20
> > This patch implements the initial Kunit based set of
> > unit tests for HFS string operations. It checks
> > functionality of hfs_strcmp(), hfs_hash_dentry(),
> > and hfs_compare_dentry() methods.
> >=20
> > ./tools/testing/kunit/kunit.py run --kunitconfig
> > ./fs/hfs/.kunitconfig
> >=20
> > [16:04:50] Configuring KUnit Kernel ...
> > Regenerating .config ...
> > Populating config with:
> > $ make ARCH=3Dum O=3D.kunit olddefconfig
> > [16:04:51] Building KUnit Kernel ...
> > Populating config with:
> > $ make ARCH=3Dum O=3D.kunit olddefconfig
> > Building with:
> > $ make all compile_commands.json scripts_gdb ARCH=3Dum O=3D.kunit --
> > jobs=3D22
> > [16:04:59] Starting KUnit Kernel (1/1)...
> > [16:04:59]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Running tests with:
> > $ .kunit/linux kunit.enable=3D1 mem=3D1G console=3Dtty
> > kunit_shutdown=3Dhalt
> > [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D hfs_stri=
ng (3 subtests)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [16:04:59] [PASSED] hfs_strcmp_test
> > [16:04:59] [PASSED] hfs_hash_dentry_test
> > [16:04:59] [PASSED] hfs_compare_dentry_test
> > [16:04:59] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [P=
ASSED] hfs_string
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [16:04:59]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [16:04:59] Testing complete. Ran 3 tests: passed: 3
> > [16:04:59] Elapsed time: 9.087s total, 1.310s configuring, 7.611s
> > building, 0.125s running
> >=20
> > v2
> > Fix linker error.
> >=20
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > cc: Yangtao Li <frank.li@vivo.com>
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> > =C2=A0fs/hfs/.kunitconfig=C2=A0 |=C2=A0=C2=A0 7 +++
> > =C2=A0fs/hfs/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +++=
++
> > =C2=A0fs/hfs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0fs/hfs/string.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0fs/hfs/string_test.c | 132
> > +++++++++++++++++++++++++++++++++++++++++++
> > =C2=A05 files changed, 159 insertions(+)
> > =C2=A0create mode 100644 fs/hfs/.kunitconfig
> > =C2=A0create mode 100644 fs/hfs/string_test.c
> >=20
> > diff --git a/fs/hfs/.kunitconfig b/fs/hfs/.kunitconfig
> > new file mode 100644
> > index 000000000000..5caa9af1e3bb
> > --- /dev/null
> > +++ b/fs/hfs/.kunitconfig
> > @@ -0,0 +1,7 @@
> > +CONFIG_KUNIT=3Dy
> > +CONFIG_HFS_FS=3Dy
> > +CONFIG_HFS_KUNIT_TEST=3Dy
> > +CONFIG_BLOCK=3Dy
> > +CONFIG_BUFFER_HEAD=3Dy
> > +CONFIG_NLS=3Dy
> > +CONFIG_LEGACY_DIRECT_IO=3Dy
> > diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
> > index 5ea5cd8ecea9..7f3cbe43b4b7 100644
> > --- a/fs/hfs/Kconfig
> > +++ b/fs/hfs/Kconfig
> > @@ -13,3 +13,18 @@ config HFS_FS
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this =
file system support as a module, choose M
> > here: the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module will be c=
alled hfs.
> > +
> > +config HFS_KUNIT_TEST
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "KUnit tests for HFS fil=
esystem" if
> > !KUNIT_ALL_TESTS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on HFS_FS && KUNIT
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default KUNIT_ALL_TESTS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This builds KUnit tes=
ts for the HFS filesystem.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUnit tests run durin=
g boot and output the results to the
> > debug
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log in TAP format (ht=
tps://testanything.org/). Only
> > useful for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel devs running K=
Unit test harness and are not for
> > inclusion
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 into a production bui=
ld.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For more information =
on KUnit and unit tests in general
> > please
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refer to the KUnit do=
cumentation in Documentation/dev-
> > tools/kunit/.
> > diff --git a/fs/hfs/Makefile b/fs/hfs/Makefile
> > index b65459bf3dc4..a7c9ce6b4609 100644
> > --- a/fs/hfs/Makefile
> > +++ b/fs/hfs/Makefile
> > @@ -9,3 +9,5 @@ hfs-objs :=3D bitmap.o bfind.o bnode.o brec.o btree.o
> > \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cata=
log.o dir.o extent.o inode.o attr.o mdb.o \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 part_tbl.o string.o super.o sysdep.o trans.o
> >=20
> > +# KUnit tests
> > +obj-$(CONFIG_HFS_KUNIT_TEST) +=3D string_test.o
> > diff --git a/fs/hfs/string.c b/fs/hfs/string.c
> > index 3912209153a8..b011c1cbdf94 100644
> > --- a/fs/hfs/string.c
> > +++ b/fs/hfs/string.c
> > @@ -65,6 +65,7 @@ int hfs_hash_dentry(const struct dentry *dentry,
> > struct qstr *this)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this->hash =3D end_name_hash=
(hash);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> > +EXPORT_SYMBOL_GPL(hfs_hash_dentry);
>=20
> It seems we should use EXPORT_SYMBOL_IF_KUNIT here?
> See
> https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functio=
ns
>=20

Yeah, you are right. I missed this. It will be much better to use
EXPORT_SYMBOL_IF_KUNIT. Let me rework the patch.

Thanks,
Slava.

