Return-Path: <linux-fsdevel+bounces-48650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17345AB1B46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E357171A09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A2228CB0;
	Fri,  9 May 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+NY4tWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D132222BD;
	Fri,  9 May 2025 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810378; cv=none; b=eK0NrvxEJKmjbXbKdKYjuTR2+XZ5JJzSfhe8DjDfS1BiiurwxPkBD3zjim/3yfzYf8teYDjXFZdn310R3M7ue037lExs6aHWPEOeDiCrS1WIgW++EPLVvuI22c9SjPJh83d8JSbuZt/INcjs6Mkqnxc+4z3PH9B6bipalRZwWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810378; c=relaxed/simple;
	bh=9NoAtyv0QTFlw0+Wvi9ySMNjb3Y06NTLdkGhH7ASppM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRnxkkNXijzhP5tARoT+wCl0dLpK7yfdpJRdluY3hL9TXMdXYpcmkugfEQLDQV7YhNkAViR8prRzt81YwHlGWDaEk2cE1LG5DIgNTXIj+LkomtCG8jmfeMijVixa6jfbRMCqK+o2ll/O/JdX7yX/zypAQ0X6b1MgugIQapqJFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+NY4tWN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acb615228a4so655147566b.0;
        Fri, 09 May 2025 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810375; x=1747415175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5ps/sOtt7pD8Pm8DpHgdsdm3C2ywQuYhYtGKQKr4S0=;
        b=E+NY4tWNLzHeYqtXeh52WBmqIdfO2AjA66PtWqoLcnHAUfuEk4T5yhm/YPBGzzj/MG
         Pvr+Y3RVpz8OhtpJHQTAMnw8yCPAvtwAkdBaEyRxCXlrLTGGObw+qXIZBp1VGeoIvSvS
         m0mVhcQeQv3lsFPkJlEdj/hk/eaHBeWcCrSAqJqAB81OtZkrhNrfXzuGVqiiplJ7efwz
         cmvuOdkcznZGyZunOSFJG4Btqd0rs3jF3JS5u2o3qLYBRc0Qcfvh6wo8w2qBa9VrmPQx
         3yFaCAXGhQQfWoDqoHhYuSi98So3qJvO0KMLw32ccbbdqkIc8SavMn1rhAM6u0hbz196
         vgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810375; x=1747415175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5ps/sOtt7pD8Pm8DpHgdsdm3C2ywQuYhYtGKQKr4S0=;
        b=oHrzMXyEPzGMLDojbD/0fsM7IinKZxpLkq100L6kS3ebbY/Gfn//6qoSJ34B4Mxeba
         uorEmwnH5qXmSI6Ogn6YyQmoyLbycdPLN54r0BBoWa4YOEXIxum2DJiNtH1OucZoJzAC
         jlnyV/pjuzlPDX9ZrPPj333OuislrXTFxmzrvLyTuNe60YGEBYFx7nksrW3Beg1Eq9dJ
         Krk8LZiI2JZt5InjNI+870k0N8r5Kk8PN6rVReuUPozyXVFQ9/TAaALW6Pe6uQ1HNCqw
         lKZwqYavmsNHp90jZmYB1mGGmHDFCkIlLltwU/2D5BCkVOu6pa2es20Mfx61CWCL0Rn7
         kVow==
X-Forwarded-Encrypted: i=1; AJvYcCXeTxPJ7bqFHkHnWDmQALq+5Op25tlsFR8Rt0wlkDMq5WjwF2rT/6aC+eJZO9mo+Zs3Rc/bzvX3@vger.kernel.org, AJvYcCXooUsK0JFASptfAWWgyhEyH8jbkeOiZZntsXmSbJO5uNC5rK5NTKLLiptbWKSdzTsf+1s8Mh0cRkXTMSHWBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WI0wGSbINM2hy0s46SZwCytwMgahKaDuusCTw79ryFvW9NMD
	PkXfzJQB2OwO7pjqh6DYkUCxPukC5vUrQhVqegkHN36EWvPPajr5yTnqefhXAgRudJD0+zc6MDT
	7wBiJPk9XopZY9z8+k1jld8yKsjM=
X-Gm-Gg: ASbGncuBzSI5SHT+rtvGbGvQg99+J1FwqMx+c2d5UUGlAv7mXrZEHsk0irPhfKodZvo
	RKzOD8+swKy5LSu4iroOb1CEtTXunUjH4WbzT7fgSKI9ZIDRErrttsl0iT6N0dYd54ePwlPPp24
	PGQlx7Kjx13rJmOv80egPIxw==
X-Google-Smtp-Source: AGHT+IFjlivJr5fD0JvOrWDcxV+SiEGAxrMcBDsju+fsgjlHREZxCW+2jHDRQC0iYjRmpmttizilIFSt6kBkL6tga7I=
X-Received: by 2002:a17:907:a4ca:b0:acb:aa43:e82d with SMTP id
 a640c23a62f3a-ad21b14c5a8mr463937766b.3.1746810374896; Fri, 09 May 2025
 10:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509170033.538130-1-amir73il@gmail.com> <20250509170033.538130-3-amir73il@gmail.com>
In-Reply-To: <20250509170033.538130-3-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 19:06:03 +0200
X-Gm-Features: ATxdqUEb-IZs5lpNG8fbW7uazGIwJxvToq8btQxAr_o4GWZvhPVnZ7ZIgsvIuKs
Message-ID: <CAOQ4uxhd7YLYndF0fgSkM53NuqUMkqghM0Vra-d0OYpTqT0tBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] open_by_handle: add a test for connectable file handles
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 7:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> This is a variant of generic/477 with connectable file handles.
> This test uses load and store of file handles from a temp file to test
> decoding connectable file handles after cycle mount and after renames.
>
> Decoding connectable file handles after being moved to a new parent
> is expected to fail on some filesystems, but not on filesystems that
> do not really get unmounted in mount cycle like tmpfs, so skip this test.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/777.out |  5 ++++
>  2 files changed, 75 insertions(+)
>  create mode 100755 tests/generic/777
>  create mode 100644 tests/generic/777.out
>
> diff --git a/tests/generic/777 b/tests/generic/777
> new file mode 100755
> index 00000000..d8d33e55
> --- /dev/null
> +++ b/tests/generic/777
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018-2025 CTERA Networks. All Rights Reserved.
> +#
> +# FS QA Test No. 777
> +#
> +# Check open by connectable file handle after cycle mount.
> +#
> +# This is a variant of test 477 with connectable file handles.
> +# This test uses load and store of file handles from a temp file to test
> +# decoding file handles after cycle mount and after directory renames.
> +# Decoding connectable file handles after being moved to a new parent
> +# is expected to fail on some filesystems, but not on filesystems that
> +# do not really get unmounted in mount cycle like tmpfs, so skip this te=
st.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick exportfs
> +
> +# Import common functions.
> +. ./common/filter
> +
> +
> +# Modify as appropriate.
> +_require_test
> +# Require connectable file handles support
> +_require_open_by_handle -N
> +
> +NUMFILES=3D10
> +testroot=3D$TEST_DIR/$seq-dir
> +testdir=3D$testroot/testdir
> +
> +# Create test dir and test files, encode connectable file handles and st=
ore to tmp file
> +create_test_files()
> +{
> +       rm -rf $testdir
> +       mkdir -p $testdir
> +       $here/src/open_by_handle -N -cwp -o $tmp.handles_file $testdir $N=
UMFILES
> +}
> +
> +# Decode connectable file handles loaded from tmp file
> +test_file_handles()
> +{
> +       local opt=3D$1
> +       local when=3D$2
> +
> +       echo test_file_handles after $when
> +       $here/src/open_by_handle $opt -i $tmp.handles_file $TEST_DIR $NUM=
FILES
> +}
> +
> +# Decode file handles of files/dir after cycle mount
> +create_test_files
> +_test_cycle_mount
> +test_file_handles -rp "cycle mount"
> +
> +# Decode file handles of files/dir after rename of parent and cycle moun=
t
> +create_test_files $testdir
> +rm -rf $testdir.renamed
> +mv $testdir $testdir.renamed/
> +_test_cycle_mount
> +test_file_handles -rp "rename parent"
> +
> +# Decode file handles of files/dir after rename of grandparent and cycle=
 mount
> +create_test_files $testdir
> +rm -rf $testroot.renamed
> +mv $testroot $testroot.renamed/
> +_test_cycle_mount
> +test_file_handles -rp "rename grandparent"
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/777.out b/tests/generic/777.out
> new file mode 100644
> index 00000000..c0617681
> --- /dev/null
> +++ b/tests/generic/777.out
> @@ -0,0 +1,5 @@
> +QA output created by 777
> +test_file_handles after cycle mount
> +test_file_handles after rename parent
> +test_file_handles after rename grandparent
> +test_file_handles after move to new parent

OOPS this line was supposed to be removed - resending

