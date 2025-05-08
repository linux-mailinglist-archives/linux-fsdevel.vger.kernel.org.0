Return-Path: <linux-fsdevel+bounces-48503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2421CAB03C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C34C6945
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B928A721;
	Thu,  8 May 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdjXyihG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0722256E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746733091; cv=none; b=qgQmebF3fLabtKlSJdH6i16aHCkzitP0SNtSDMf4vvW/B4x7NCWaC8JcQ4nnJ4PoWQnPZYsp58DGuQNhGtMeRi/4yaAxvFmCTd633yvuo1tNsyarDKmemY/YOUMPvgzhGDP4Nu6arxDLjqVfHcfxdPqP/q7jS49MTvEUJSMVAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746733091; c=relaxed/simple;
	bh=ZwmwOvYQvbf69QSWxLfFXpw2Lk1uXCmE7XS/b+sH8+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyFGIXm+5PdEA6cWeOK2jTQLAv+kBcSYInkuvAdfjnCgtn2VGpUSxvDamUDto2Q16sR+JfTcXboPDBzlRqQc/I+5Gh9kzUafuBjVXR0z2FgqsN1vD6IV68p6I+nlrHlHpWD94wDPoGkZ0+FXRXcxKnjFkpFCSA/9WGqMIKmk/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdjXyihG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746733088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jv++P7xMSOcCEcOtqfXv7rlc0xsLWo70WZEwvo7nUo=;
	b=gdjXyihGPNNyG+z+ueoDbF4LIfOKLMyeTACu2XGw64hu53Xo2PfSQKjHY3DA2XfoYx8gCn
	NNx6RtSso8Tr/VTl+EO6KmqEZcVWJdfESOHgLNL9UnFJCPBmBf40uE7h7OO2uReJYlVK8X
	83b2Tt53tGdtoiqhC5wB9ssJbeFhm1Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-yeNm_KQyP1esy0Bs21zhYA-1; Thu, 08 May 2025 15:38:06 -0400
X-MC-Unique: yeNm_KQyP1esy0Bs21zhYA-1
X-Mimecast-MFC-AGG-ID: yeNm_KQyP1esy0Bs21zhYA_1746733086
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22fba10f55eso6297045ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 12:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746733086; x=1747337886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jv++P7xMSOcCEcOtqfXv7rlc0xsLWo70WZEwvo7nUo=;
        b=To82kOnupGF4E5/syDNJ6tmkyywHl1ktpjF+urQQ9hXCzQh+8GI2qfPMAtEouGsahF
         /YNDu/Q5nxSJXU7r+BoxAOE7feqjMDiOaY71gzLjkZrRTpfxqj6U6wUHl4HuQU8WP4M1
         q/yU36bgE+OJVXOoz6lgwtBp69WSudgqzVinL2ugCB3kfJfsr23ZmNiG6XkswqPaOFTW
         A4alTWyvNZuznrNLFLsJP9l6TDHoAgaZN3l1e/vaRGUpmfCKhV2sMPf64CqWV8BwtzEm
         Y5p48RjGcV9ogPcmwPp3iV0D/HhcuYRPzenydCp5p/v+wOPoPywfb7qDuIgnqr5dV4VB
         THwg==
X-Forwarded-Encrypted: i=1; AJvYcCXfLPsMQXXHTmKNcsUrVhmEFejN41KtXzvvjUO6CTfsV3D05yWQqEy1RV7snQv2d2UviHgDuFa3j3Z/EsmU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZTaGCTCX32mfsD79TCam/BO/V3jPKfTJNVIUTlF+W7lsR+g3
	Ky77aca5LF3g8G4WgmlXrkwOtmPl7wHCtsRJqC9Hr9pYHpHN1+aMfiRPn2Ly1o4uHcSBvqpyVNR
	hzQefvetcGUloH1vuh3mFisGEgq3L7TYU7ZXf1uAZxcZsL5aZmyohF6k+bVmX+H4=
X-Gm-Gg: ASbGnctxRGQlKh0ShskrgrqxfqLbYaV44fF4mxM75jWOSFxOW4XYCU17Zgr+xsogb5X
	Dw3V95M2Fb8LoJ1vhfrw0Rgw4u+CtzeB9LAg+bsOvmCjk825P9x61HCcS7bOk/pbZ0/Fdm8s7Ip
	VEtCRdapWXpg7tyg8THyBNgznrEuLtVEgFQXU7v3MgcutdDtJIDxqzvNIwPoJyZoeYf7z6AZA1x
	qUHhiXjbw6Ndv3lPMph1PwONv+5PTiRNcfaC0zf/3OdMDiEZX3gxReVaMBkcSRgy0UNWDNhtpo1
	Itu4x18mPKlRhvurZaPEgY9bPNmFWm5ZKCDTqdx1xen5xoui7yHg
X-Received: by 2002:a17:903:2349:b0:224:10a2:cae7 with SMTP id d9443c01a7336-22fc8e95bf0mr8986735ad.40.1746733085714;
        Thu, 08 May 2025 12:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhv3wp38xq2cFaGqXutRUEqQ5bZsD/2Df/pvxLX3UuYRi6ZR4xcX/7W0xqUwgAk5Asg2aD+A==
X-Received: by 2002:a17:903:2349:b0:224:10a2:cae7 with SMTP id d9443c01a7336-22fc8e95bf0mr8986405ad.40.1746733085361;
        Thu, 08 May 2025 12:38:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc773e7f8sm3396445ad.60.2025.05.08.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 12:38:05 -0700 (PDT)
Date: Fri, 9 May 2025 03:38:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] open_by_handle: add a test for connectable file
 handles
Message-ID: <20250508193800.q2s4twfldlctre34@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250409115220.1911467-1-amir73il@gmail.com>
 <20250409115220.1911467-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409115220.1911467-3-amir73il@gmail.com>

On Wed, Apr 09, 2025 at 01:52:20PM +0200, Amir Goldstein wrote:
> This is a variant of generic/477 with connectable file handles.
> This test uses load and store of file handles from a temp file to test
> decoding connectable file handles after cycle mount and after renames.
> Decoding connectable file handles after being moved to a new parent
> is expected to fail.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Hi Amir,

This test case fails on some filesystems, e.g. nfs [1] and tmpfs [2].
Is this as your expected?

Thanks,
Zorro

[1]
generic/777 fails on nfs:

--- /dev/fd/63	2025-05-07 02:44:24.150560533 -0400
+++ generic/777.out.bad	2025-05-07 02:44:23.999734558 -0400
@@ -1,7 +1,37 @@
 QA output created by 777
 test_file_handles after cycle mount
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000009) returned 116 incorrectly on a linked file!
 test_file_handles after rename parent
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000009) returned 116 incorrectly on a linked file!
 test_file_handles after rename grandparent
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/fstests/TEST_DIR/nfs-client/file000009) returned 116 incorrectly on a linked file!
 test_file_handles after move to new parent
 open_by_handle(TEST_DIR/file000000) returned 116 incorrectly on a linked file!
 open_by_handle(TEST_DIR/file000001) returned 116 incorrectly on a linked file!

[2]
generic/777 fails on tmpfs:

--- /dev/fd/63	2025-05-07 07:53:26.265453903 -0400
+++ generic/777.out.bad	2025-05-07 07:53:25.536434660 -0400
@@ -3,13 +3,3 @@
 test_file_handles after rename parent
 test_file_handles after rename grandparent
 test_file_handles after move to new parent
-open_by_handle(TEST_DIR/file000000) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000001) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000002) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000003) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000004) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000005) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000006) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000007) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000008) returned 116 incorrectly on a linked file!
-open_by_handle(TEST_DIR/file000009) returned 116 incorrectly on a linked file!


>  tests/generic/777     | 79 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/777.out | 15 ++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100755 tests/generic/777
>  create mode 100644 tests/generic/777.out
> 
> diff --git a/tests/generic/777 b/tests/generic/777
> new file mode 100755
> index 00000000..52a461c3
> --- /dev/null
> +++ b/tests/generic/777
> @@ -0,0 +1,79 @@
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
> +# is expected to fail.
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
> +NUMFILES=10
> +testroot=$TEST_DIR/$seq-dir
> +testdir=$testroot/testdir
> +
> +# Create test dir and test files, encode connectable file handles and store to tmp file
> +create_test_files()
> +{
> +	rm -rf $testdir
> +	mkdir -p $testdir
> +	$here/src/open_by_handle -N -cwp -o $tmp.handles_file $testdir $NUMFILES
> +}
> +
> +# Decode connectable file handles loaded from tmp file
> +test_file_handles()
> +{
> +	local opt=$1
> +	local when=$2
> +
> +	echo test_file_handles after $when
> +	$here/src/open_by_handle $opt -i $tmp.handles_file $TEST_DIR $NUMFILES
> +}
> +
> +# Decode file handles of files/dir after cycle mount
> +create_test_files
> +_test_cycle_mount
> +test_file_handles -rp "cycle mount"
> +
> +# Decode file handles of files/dir after rename of parent and cycle mount
> +create_test_files $testdir
> +rm -rf $testdir.renamed
> +mv $testdir $testdir.renamed/
> +_test_cycle_mount
> +test_file_handles -rp "rename parent"
> +
> +# Decode file handles of files/dir after rename of grandparent and cycle mount
> +create_test_files $testdir
> +rm -rf $testroot.renamed
> +mv $testroot $testroot.renamed/
> +_test_cycle_mount
> +test_file_handles -rp "rename grandparent"
> +
> +# Decode file handles of files/dir after move to new parent and cycle mount
> +# This is expected to fail because the conectable file handle encodes the
> +# old parent.
> +create_test_files $testdir
> +rm -rf $testdir.new
> +mkdir -p $testdir.new
> +mv $testdir/* $testdir.new/
> +_test_cycle_mount
> +test_file_handles -r "move to new parent" | _filter_test_dir
> +
> +status=0
> +exit
> diff --git a/tests/generic/777.out b/tests/generic/777.out
> new file mode 100644
> index 00000000..648c480c
> --- /dev/null
> +++ b/tests/generic/777.out
> @@ -0,0 +1,15 @@
> +QA output created by 777
> +test_file_handles after cycle mount
> +test_file_handles after rename parent
> +test_file_handles after rename grandparent
> +test_file_handles after move to new parent
> +open_by_handle(TEST_DIR/file000000) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000001) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000002) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000003) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000004) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000005) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000006) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000007) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000008) returned 116 incorrectly on a linked file!
> +open_by_handle(TEST_DIR/file000009) returned 116 incorrectly on a linked file!
> -- 
> 2.34.1
> 


