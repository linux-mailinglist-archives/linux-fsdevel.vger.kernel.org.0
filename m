Return-Path: <linux-fsdevel+bounces-38804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2134BA0870D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8ED1663CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 05:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C292066C6;
	Fri, 10 Jan 2025 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtn28oO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEAE8624B;
	Fri, 10 Jan 2025 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488362; cv=none; b=UQS5ipDSeWKU/sxTzv9Q0Rt7A58LfcTkKfScu0YR6U3NMh0VatnWzLV4GGMur2/5Nosm0u1ZRY8/h9fdccetd4fH6qUvc4YtoKToxMJRPg24CwQIHRo9ws1Pgd1yPlJSiNeHMVMi3IlX7IE42Yjt7sU19EHS+6k+GXJ7kr6a0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488362; c=relaxed/simple;
	bh=72Pop+nwHEx4Spq79SZPF6dmyu0kSHdWUbCLtVxZZkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=PuTbcFUIvwL9SN7FIPyBRsM+kBIst6fZgFxNCC5H1BbxIzSTjdRayo0p3KJ9PLtilYS/e6jmjqp4c/DxLGZ/QRdV/n/5/nYoXnD4a7p6VhVRSWokCkBsA7BU/HJWBd9xXgQjiv48o2hPZRZZyF8oj8OVbBtiLSUuCuPAPFYZcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtn28oO5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216634dd574so18697385ad.2;
        Thu, 09 Jan 2025 21:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736488360; x=1737093160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC73s1da2wBZ1Jcdn82GRJzbEEBquBpfH55SncZ1RcI=;
        b=Gtn28oO5KMufHN18yXR0VnzzLiFd3Rri/erRURnpJc2DaUFH4y7UTTgp8iKz2juV3j
         AZpxjHUcavCxjAWNxBPGtkzhh0+8lksaTa4MjWIaDEAlQu26Ckfi06x0zOhJI/0KqMJ8
         Oa2a+qLimOGhbPPinG7Zw+xolXQvTWA8p+QNoDJ+ar9gEXZZrRHUkIKAI/bVtFCvGtaQ
         ywAD/X7WU54x4Jmhj1LLgQM1YE9YUS4Is3x2KxfAEBlWexw0tKzL42w273AYWHXOJoTH
         a6svN1EcWe25PlplzjQQigear+lCub4F7VqqVwpjIqSW8YMMZaOG1hGWqxcMOYsGkFLs
         16Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736488360; x=1737093160;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VC73s1da2wBZ1Jcdn82GRJzbEEBquBpfH55SncZ1RcI=;
        b=XrWlt9pr3SUcdpilUiZxo5tcNA6BWP19P3iqzJhrCikiP+U6PEiq3BUDfNb+n89WWI
         nS+NYeXeKf7h/kLgWBd9pa32BJfZnx5g9NleF3X3WP14srAYdEzBmA0prEktOkGSAOaa
         fXq4JW/Lu+1htXgwPuECMAIFOVEKMQzXTjoHqQu6wXMuCBwilVUrr5ciqJKlf8uRh//H
         h0xf8tv3uNJF62fxz70mYzy2W0qA4V+29ZmgItzz2gT2xpLmB5x5zr51UC923+khnIBM
         KQiBUP8lwP4JHyfIbAc6YkhVdD29O5/U37+SOaDwqSEuIP+N9YeV5xh4D+0nSfZaprt+
         uYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxwaM8huzuZw4o8qOc2JVA9lvxi6UCECZdLdrgSSJBXDfJAk9nY+BcV9Hl0C/PwP/OxiCmxVON@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDC0zxxOzXj3pMlEx6A8/dgcC/WpnWo/wzEmbA2IEdjXk2u71
	U5u6JB3lZIcQ4MOLMdIuRT3XMmtbtkEeLx2TiJj6XtUwspCl8P/e
X-Gm-Gg: ASbGncuYgjqeEMjYvw0vtcJJGLrCE0qzij7obBsoYBIoz1nCJ5ApfWFhAgg9YvTmQlx
	zOGjQeFNwtPGmwvdw6tm3iDDcKpPgIjiMqmPd5/Me2zSy+xUkAwq83zhG7rlh06S7HR/IaJfYy9
	HxTuvjV/bqc3YJvZ+H0puTNTaa1JnsD5BDkXFaH4ol0mCZgDalnYYv7JSWG3TDIrO2KAgy344gz
	ptdUF7pu2/Z/qUpt99hoT0gLwA1kzYQgGxU/yJ9uV7OFHrItI7R87wh2d9nxX/1zdrtcB5fCMbZ
	ePy1hb+zalooGWczo4KkymqFpGfihqU=
X-Google-Smtp-Source: AGHT+IGEkzls92LjSw2qKhAmdealc+tGSK4NEYWmxLAIkCFDPCh3dMgDXlWxHPWqeF2nqMYJDTtRTg==
X-Received: by 2002:a17:903:230b:b0:215:b087:5d62 with SMTP id d9443c01a7336-21a83fe4b38mr160976685ad.36.1736488360084;
        Thu, 09 Jan 2025 21:52:40 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f1386bbsm7091845ad.81.2025.01.09.21.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:52:39 -0800 (PST)
Message-ID: <4e72f6a0195edfa09f828ccdcdbb0ee283b69cbb.camel@gmail.com>
Subject: Re: [xfstests PATCH v3] generic: add a partial pages zeroing out
 test
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, fstests@vger.kernel.org, 
	zlang@kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
 jack@suse.cz, willy@infradead.org, ojaswin@linux.ibm.com,
 djwong@kernel.org,  yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com,  yangerkun@huawei.com
Date: Fri, 10 Jan 2025 11:22:33 +0530
In-Reply-To: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
References: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-01-08 at 16:44 +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial
> page
> zeroing in ext4 which the block size is smaller than the page size
> [1].
> Add a new test which is expanded upon generic/567, this test performs
> a
> zeroing range test that spans two partial pages to cover this case,
> and
> also generalize it to work for non-4k page sizes.
> 
> Link: 
> https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/
>  [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v3:
>  - Put the verifyfile in $SCRATCH_MNT and remove the overriding
>    _cleanup.
>  - Correct the test name.
> v1->v2:
>  - Add a new test instead of modifying generic/567.
>  - Generalize the test to work for non-4k page sizes.
> v2: 
> https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
> v1: 
> https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
> 
>  tests/generic/758     | 68
> +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/758.out |  3 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
> 
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..bf0a342b
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. 758
> +#
> +# Test mapped writes against zero-range to ensure we get the data
> +# correctly written. This can expose data corruption bugs on
> filesystems
> +# where the block size is smaller than the page size.
> +#
> +# (generic/567 is a similar test but for punch hole.)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw zero
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +
> +verifyfile=$SCRATCH_MNT/verifyfile
> +testfile=$SCRATCH_MNT/testfile
> +
> +pagesz=$(getconf PAGE_SIZE)
you can directly use _get_page_size() function in common/rc
pagesz=$(_get_page_size)

> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_dump_files()
> +{
> +	echo "---- testfile ----"
> +	_hexdump $testfile
> +	echo "---- verifyfile --"
> +	_hexdump $verifyfile
> +}
> +
> +# Build verify file, the data in this file should be consistent with
> +# that in the test file.
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +		$verifyfile | _filter_xfs_io >> /dev/null
> +
> +# Zero out straddling two pages to check that the mapped write after
> the
> +# range-zeroing are correctly handled.
> +$XFS_IO_PROG -t -f \
> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +	-c "mmap -rw 0 $((pagesz * 3))" \
> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "close"      \
> +$testfile | _filter_xfs_io > $seqres.full
> +
> +echo "==== Pre-Remount ==="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match pre-remount."
> +	_dump_files
Extremely minor: Maybe exit the test if data mismatch takes place pre-
mount since, post mount it will definitely mismatch right?
> +fi
> +_scratch_cycle_mount
> +echo "==== Post-Remount =="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match post-remount."
> +	_dump_files
Minor: Maybe redirect the content of _dump_file to $seqres.full, just
to keep the stdout diff clean in case of mismatch?
--NR
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/758.out b/tests/generic/758.out
> new file mode 100644
> index 00000000..d01c1959
> --- /dev/null
> +++ b/tests/generic/758.out
> @@ -0,0 +1,3 @@
> +QA output created by 758
> +==== Pre-Remount ===
> +==== Post-Remount ==


