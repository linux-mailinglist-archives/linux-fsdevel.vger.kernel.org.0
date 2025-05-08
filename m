Return-Path: <linux-fsdevel+bounces-48514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD560AB04BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAB61BA2AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC428C01F;
	Thu,  8 May 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKFYvyKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1F21D5B6;
	Thu,  8 May 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736736; cv=none; b=PqyXEJrE5ODM/PZUaJZbpQsD184zNlvy5jBi9FBIU0mSIafAdm+QaazxxgPvwMNP5azETFSPNbGQyy0vWe73/ZyOGfUJ1IzgpOosxRoRdT+/F1EfO196t0tyQC5+QsvzLpVGUwlN9lJjoeXgcLmqswYhXroWwh2bgFk+3rJ5RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736736; c=relaxed/simple;
	bh=/NhTmPsq03LOU2Ndupk1HqnkO92bDtzORaW6K8VXNHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNfpMFaruQm+I/RkEG1G7k/1pAuBA2tMpVUPRWAPv/dVX2rH9WwACZRr9q/Hslmok6Vmnc1pYk2OtZdZGPJZWBi6pblLzuyjrQc3M/slVKmMSMpn/5YIlMyzEVwmYaQF0pkdxYVovkjGSEaARB3HUkwPiTjCUnOmDdBueS6R0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKFYvyKz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad216a5a59cso56669566b.3;
        Thu, 08 May 2025 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746736732; x=1747341532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI451Xqo7kLwNWLFULFzz06ciaAE0AGPeH3OCBsLZVw=;
        b=EKFYvyKzxNY6lMVaki+pdVNONqvXLhHU1MnHGaYBoxKDXu32N/TrhbH9dMh2H7R5cK
         6D0oidxHm+iH99eWu+iyoHq0+Xhpx9+OE+vNRidw6fbQ3fHx8ayXubtMTrNELCEGvsK+
         LVODFO4qmLrzcIK8G25AeSv2n3cZk8GZTQyFDbYfmW3lpK3ttxOMKRfkwUPaArYG8NBD
         MpsRe+bV5wBcB2WPajvizacwFFz4CiNrLweZ8KifaKe8Fcc/MdSxEYQlH+iDwpUvjiyX
         gtQkT8366emhc1x/29mYJR8PsxdW8SgCnH8nNAEnbCL9rbCURty9KgQhqAE6RGf9LDkY
         lmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736732; x=1747341532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI451Xqo7kLwNWLFULFzz06ciaAE0AGPeH3OCBsLZVw=;
        b=PTuasNMSOaKIHl1Kvyngv97E9UzMZ/leD/5RdhxF4h2A31OulA8CJv8rR3FwF2Bwjx
         G/uwxY/D0KID/sWk289BLGvPMZSj0mqcmHxbrPqLctq6UW7JRl59tCmt160k9vTz9KQC
         riy6geKMaLSX1dKuUq3t4lbN9alMJMzFnHJqxZMO4YLcp4zyPplDpseTLPRqLjLKpfXL
         rZiENXDlmW8hmLfvsZn2YfWLoYaaW1Y3CG90BiCMtksx94SdXlx2dVqEIdvr9X22rvIb
         nuOdOnWZi/he5Rd7Vt3BPYyIdxJSk0VnecCeYhfkm+NlYIbTfC5O2PB4h4lXLrmvxojH
         LBOw==
X-Forwarded-Encrypted: i=1; AJvYcCWEV86LPXs8Q7GeJGp8hBU/QcwWrkdmVf93TNlbOSFSs1rogZZ1KQ9FMoUOAg8ClfX6IPbIvJHmwTioVByBcQ==@vger.kernel.org, AJvYcCWaAonQr+ZqXLf1Wp1s0mvR5W1vRlz3rX035WIJ04LZbcXUXYmUHH50KbGefkDLCZSBXPnhzwvT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8AIGOZdlpnm2xYRy986jpaENThlTVD7ZH+h5Yu3fzW966dnAt
	dALZ5wnYOzv9fTq7wMFRDvjjOZViWcA0ZBORIMNIvIhIEgXz47eq/+/KLaTC9CcOWilEjRv4xHW
	go5TethueFgEHWlX+ZFp3QrX1IRU=
X-Gm-Gg: ASbGnctxMEks2eZd0rrM6193rFe03DjWpy9XsrarEPS8CFiM/O0mHqSNRDq7Qsqv9DE
	LeAc4xzA6J619v8hR85ihZ6piTZOnAoICuWvOV6/kVGKywGYz6gR6tb4oBjVoy1Edi8iif8hg4Q
	uLvYXIdW1phxgnK5VLMLJ6Wg==
X-Google-Smtp-Source: AGHT+IFzFrHX1p4irUKiYxOsN96aNfbOuXxlA3s7oefQoP35vL7h5Ns3xHMcXI/JqE3JAzZppvSCzyGCFvh3/CvnQW0=
X-Received: by 2002:a17:907:7f21:b0:ac1:ea29:4e63 with SMTP id
 a640c23a62f3a-ad219002422mr86746566b.26.1746736731947; Thu, 08 May 2025
 13:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115220.1911467-1-amir73il@gmail.com> <20250409115220.1911467-3-amir73il@gmail.com>
 <20250508193800.q2s4twfldlctre34@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250508193800.q2s4twfldlctre34@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 22:38:39 +0200
X-Gm-Features: ATxdqUGH2WWhBzVn6NbMbi0wtRICdDMPY6DRDExoBEHr7eR4DcgZmkxKEa45ZCQ
Message-ID: <CAOQ4uxjZnL5AMwwc06tiGJGbkjjW+88jDGudtp-MLkkPdzHT0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] open_by_handle: add a test for connectable file handles
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:38=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Apr 09, 2025 at 01:52:20PM +0200, Amir Goldstein wrote:
> > This is a variant of generic/477 with connectable file handles.
> > This test uses load and store of file handles from a temp file to test
> > decoding connectable file handles after cycle mount and after renames.
> > Decoding connectable file handles after being moved to a new parent
> > is expected to fail.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> Hi Amir,
>
> This test case fails on some filesystems, e.g. nfs [1] and tmpfs [2].
> Is this as your expected?

No. I will look into this failure.
Thanks for testing!

Amir.

>
> Thanks,
> Zorro
>
> [1]
> generic/777 fails on nfs:
>
> --- /dev/fd/63  2025-05-07 02:44:24.150560533 -0400
> +++ generic/777.out.bad 2025-05-07 02:44:23.999734558 -0400
> @@ -1,7 +1,37 @@
>  QA output created by 777
>  test_file_handles after cycle mount
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000000) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000001) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000002) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000003) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000004) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000005) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000006) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000007) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000008) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000009) returned 116=
 incorrectly on a linked file!
>  test_file_handles after rename parent
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000000) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000001) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000002) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000003) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000004) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000005) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000006) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000007) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000008) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000009) returned 116=
 incorrectly on a linked file!
>  test_file_handles after rename grandparent
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000000) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000001) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000002) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000003) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000004) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000005) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000006) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000007) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000008) returned 116=
 incorrectly on a linked file!
> +open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000009) returned 116=
 incorrectly on a linked file!
>  test_file_handles after move to new parent
>  open_by_handle(TEST_DIR/file000000) returned 116 incorrectly on a linked=
 file!
>  open_by_handle(TEST_DIR/file000001) returned 116 incorrectly on a linked=
 file!
>
> [2]
> generic/777 fails on tmpfs:
>
> --- /dev/fd/63  2025-05-07 07:53:26.265453903 -0400
> +++ generic/777.out.bad 2025-05-07 07:53:25.536434660 -0400
> @@ -3,13 +3,3 @@
>  test_file_handles after rename parent
>  test_file_handles after rename grandparent
>  test_file_handles after move to new parent
> -open_by_handle(TEST_DIR/file000000) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000001) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000002) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000003) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000004) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000005) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000006) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000007) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000008) returned 116 incorrectly on a linked=
 file!
> -open_by_handle(TEST_DIR/file000009) returned 116 incorrectly on a linked=
 file!
>
>
> >  tests/generic/777     | 79 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/777.out | 15 ++++++++
> >  2 files changed, 94 insertions(+)
> >  create mode 100755 tests/generic/777
> >  create mode 100644 tests/generic/777.out
> >
> > diff --git a/tests/generic/777 b/tests/generic/777
> > new file mode 100755
> > index 00000000..52a461c3
> > --- /dev/null
> > +++ b/tests/generic/777
> > @@ -0,0 +1,79 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2018-2025 CTERA Networks. All Rights Reserved.
> > +#
> > +# FS QA Test No. 777
> > +#
> > +# Check open by connectable file handle after cycle mount.
> > +#
> > +# This is a variant of test 477 with connectable file handles.
> > +# This test uses load and store of file handles from a temp file to te=
st
> > +# decoding file handles after cycle mount and after directory renames.
> > +# Decoding connectable file handles after being moved to a new parent
> > +# is expected to fail.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick exportfs
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +
> > +# Modify as appropriate.
> > +_require_test
> > +# Require connectable file handles support
> > +_require_open_by_handle -N
> > +
> > +NUMFILES=3D10
> > +testroot=3D$TEST_DIR/$seq-dir
> > +testdir=3D$testroot/testdir
> > +
> > +# Create test dir and test files, encode connectable file handles and =
store to tmp file
> > +create_test_files()
> > +{
> > +     rm -rf $testdir
> > +     mkdir -p $testdir
> > +     $here/src/open_by_handle -N -cwp -o $tmp.handles_file $testdir $N=
UMFILES
> > +}
> > +
> > +# Decode connectable file handles loaded from tmp file
> > +test_file_handles()
> > +{
> > +     local opt=3D$1
> > +     local when=3D$2
> > +
> > +     echo test_file_handles after $when
> > +     $here/src/open_by_handle $opt -i $tmp.handles_file $TEST_DIR $NUM=
FILES
> > +}
> > +
> > +# Decode file handles of files/dir after cycle mount
> > +create_test_files
> > +_test_cycle_mount
> > +test_file_handles -rp "cycle mount"
> > +
> > +# Decode file handles of files/dir after rename of parent and cycle mo=
unt
> > +create_test_files $testdir
> > +rm -rf $testdir.renamed
> > +mv $testdir $testdir.renamed/
> > +_test_cycle_mount
> > +test_file_handles -rp "rename parent"
> > +
> > +# Decode file handles of files/dir after rename of grandparent and cyc=
le mount
> > +create_test_files $testdir
> > +rm -rf $testroot.renamed
> > +mv $testroot $testroot.renamed/
> > +_test_cycle_mount
> > +test_file_handles -rp "rename grandparent"
> > +
> > +# Decode file handles of files/dir after move to new parent and cycle =
mount
> > +# This is expected to fail because the conectable file handle encodes =
the
> > +# old parent.
> > +create_test_files $testdir
> > +rm -rf $testdir.new
> > +mkdir -p $testdir.new
> > +mv $testdir/* $testdir.new/
> > +_test_cycle_mount
> > +test_file_handles -r "move to new parent" | _filter_test_dir
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/777.out b/tests/generic/777.out
> > new file mode 100644
> > index 00000000..648c480c
> > --- /dev/null
> > +++ b/tests/generic/777.out
> > @@ -0,0 +1,15 @@
> > +QA output created by 777
> > +test_file_handles after cycle mount
> > +test_file_handles after rename parent
> > +test_file_handles after rename grandparent
> > +test_file_handles after move to new parent
> > +open_by_handle(TEST_DIR/file000000) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000001) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000002) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000003) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000004) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000005) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000006) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000007) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000008) returned 116 incorrectly on a link=
ed file!
> > +open_by_handle(TEST_DIR/file000009) returned 116 incorrectly on a link=
ed file!
> > --
> > 2.34.1
> >
>

