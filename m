Return-Path: <linux-fsdevel+bounces-62514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882AB96C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E5D18842A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8152319601;
	Tue, 23 Sep 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SouXAZ3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC33148AC
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643756; cv=none; b=EqIdcPBZOJOOJqsQVOP0gTKmUSJJTr754/BvD7qXqqhJSvuB9Jdr6IE3rl4CveqWJMEKC6rDkjyykDgQWREsO6hdIo6krBgOSaFx7x+KKqLtdjAFaNvDcSPdVZrUg7OQDZceOmmsCS5A8OA/12dviE/X3LU3R2rEYPUyO3DrFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643756; c=relaxed/simple;
	bh=AoFvGMfkzlYTY4XcmhZ6GjRRNwyayuTKGq8KTQImh8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ/WRBDOKp3IjOzFiEWxub+cguIp0t5keDZkfTRCp97MdjsEZ/6iu6tU5vKJ2IBxzTp9yUK2C6iOVhPmbvc/hhW/T0pnLmjx5x40DXOJrv9MLSyAoH5wlc4jLbSrxYYOnAZ8RmHhyfg2ZZU4Rh64k/Z5YfyWktAjXCswaHhXI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SouXAZ3J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758643753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5vd0aC3s/m2gc3mlU8i8eR04/f2eUNWS80Cftv0iH4=;
	b=SouXAZ3J+xHc5eJzgZVVtuwXX5cV4snnBerxGkpQUGSXhMYsgd4j4WeMN5w+m9h+tdHtsO
	mTCbl3UalVmLTXNByaj89icty30OnHehbBvdnvVI5uEKh3Nb5yoWIGZ4n32do8fx+HLgHZ
	1Mtdqn0jNMWEbawR7wgiPFyD+JBCQ3k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-hFBXpv3JP3ySh6OEGox9oQ-1; Tue, 23 Sep 2025 12:09:11 -0400
X-MC-Unique: hFBXpv3JP3ySh6OEGox9oQ-1
X-Mimecast-MFC-AGG-ID: hFBXpv3JP3ySh6OEGox9oQ_1758643750
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so2375914f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 09:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643750; x=1759248550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5vd0aC3s/m2gc3mlU8i8eR04/f2eUNWS80Cftv0iH4=;
        b=ptKHeqdrvF4DEoYnKDpjqyQ4DDv/QycMbDuddB1fuPhTuCSSb6UVSvLduEumvMnmge
         h4ndikdVCY0iWPD0f4LHgNtJKc1mfUt2U0JQEdELjpkdC5PsOaWXki3vLDWqmmylaPVW
         edFKA2wwGkGUr1iW0Qp5a/cXwAv9m8Gr/BvjTEzI4m0ZVi1jYCHW13rAX5RIsAuX75Gl
         thZdAyyVgf4P5cDr4Iwg01lblQ7AuKsFzWw7s3yJLsUsEwW+00ulca+Et8Bp6DaMHsiR
         qeYzYpJ8HtlmvxhNEMvmBl5D5iLWOlYenx9d8s2cSwBiRpWT9azL8Ps5+Dpb8MwwzuE+
         YKlg==
X-Forwarded-Encrypted: i=1; AJvYcCULEn53XFUff1BZo8+rUkOa5uHpR5T51qp8xweUFVEXvveAGopNIrucVoTpRyZZ6vbVO6qeO0LEIY3YM6Lj@vger.kernel.org
X-Gm-Message-State: AOJu0YydOD2qUSy3YYp6s+aJwYZdu/1bw5zDC90gDIqAh1CXzBc3sGN1
	RuTo3pqzPeC+/xvMBZeMTJsAIFfagAT/lxXV5vTgpHVVZK5k213RDVME5ILXXkFffL7lO6xKj9D
	tJB1dvtl+pVoShSzv7FT14IefKiV18Ibd6kiaXCoxSP6eMp6Yxf6Z2AzWZ3GsU+wdYQ==
X-Gm-Gg: ASbGncuwjWfx5FJqTHEMEabuJlSpxQceqPjIZ0dAJuDqcn/M3t+AsMBD7XBb/0QTPsC
	w4VNwsNucYYVwYKMNtaEOeYZSEuMGfbj+itURtHGoavQhdjZimwJ4aDmnu5re8iS95ZOFBH+fJ/
	GwZHoLp2fGjwBryNqXsvLygyEdUoxXIHIfF0MvgLl5Su8WWBCm729LImfzTj+NbrWxHawDp7vtl
	dBXYgJuhHsG99E707w6CM9N6m9HBpc7Pwf0PCzmn8YCWK4ZGMdInDVNGvofTf+NirlFDy8Kf28T
	LYVdIEFhsWyDLIHw8/il6L4FPTXfGsDQ
X-Received: by 2002:a05:6000:26cd:b0:3e5:f1e2:6789 with SMTP id ffacd0b85a97d-405cc9ed076mr2638302f8f.59.1758643749756;
        Tue, 23 Sep 2025 09:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk7KWuOxdWQwJk5j2Bm+7Bbm1XrYxeHAGuZKX2fTAdLyAS+6cxLl7cEeEhDWv5BsKh9XHIlA==
X-Received: by 2002:a05:6000:26cd:b0:3e5:f1e2:6789 with SMTP id ffacd0b85a97d-405cc9ed076mr2638277f8f.59.1758643749305;
        Tue, 23 Sep 2025 09:09:09 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1d35sm26265729f8f.55.2025.09.23.09.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:09:08 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:09:07 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <3dzhysyljtiwafvtnqf4fd5vrb6rdqfohx3l2lvfb5xpcbwikk@tdcmhjpitqll>
References: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
 <20250909-xattrat-syscall-v3-2-9ba483144789@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-xattrat-syscall-v3-2-9ba483144789@kernel.org>

On 2025-09-09 17:25:57, Andrey Albershteyn wrote:
> Add a test to test basic functionality of file_getattr() and
> file_setattr() syscalls. Most of the work is done in file_attr
> utility.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/2000     | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/2000.out |  37 +++++++++++++++++
>  2 files changed, 146 insertions(+)
> 
> diff --git a/tests/generic/2000 b/tests/generic/2000
> new file mode 100755
> index 000000000000..b03e9697bb14
> --- /dev/null
> +++ b/tests/generic/2000
> @@ -0,0 +1,109 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 2000
> +#
> +# Test file_getattr/file_setattr syscalls
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +. ./common/filter
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_test_program "af_unix"
> +_require_test_program "file_attr"
> +_require_symlinks
> +_require_mknod
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +file_attr () {
> +	$here/src/file_attr $*
> +}
> +
> +create_af_unix () {
> +	$here/src/af_unix $* || echo af_unix failed
> +}
> +
> +projectdir=$SCRATCH_MNT/prj
> +
> +# Create normal files and special files
> +mkdir $projectdir
> +mkfifo $projectdir/fifo
> +mknod $projectdir/chardev c 1 1
> +mknod $projectdir/blockdev b 1 1
> +create_af_unix $projectdir/socket
> +touch $projectdir/foo
> +ln -s $projectdir/foo $projectdir/symlink
> +touch $projectdir/bar
> +ln -s $projectdir/bar $projectdir/broken-symlink
> +rm -f $projectdir/bar
> +
> +echo "Error codes"
> +# wrong AT_ flags
> +file_attr --get --invalid-at $projectdir ./foo
> +file_attr --set --invalid-at $projectdir ./foo
> +# wrong fsxattr size (too big, too small)
> +file_attr --get --too-big-arg $projectdir ./foo
> +file_attr --get --too-small-arg $projectdir ./foo
> +file_attr --set --too-big-arg $projectdir ./foo
> +file_attr --set --too-small-arg $projectdir ./foo
> +# out of fsx_xflags mask
> +file_attr --set --new-fsx-flag $projectdir ./foo
> +
> +echo "Initial attributes state"
> +file_attr --get $projectdir | _filter_scratch
> +file_attr --get $projectdir ./fifo
> +file_attr --get $projectdir ./chardev
> +file_attr --get $projectdir ./blockdev
> +file_attr --get $projectdir ./socket
> +file_attr --get $projectdir ./foo
> +file_attr --get $projectdir ./symlink
> +
> +echo "Set FS_XFLAG_NODUMP (d)"
> +file_attr --set --set-nodump $projectdir
> +file_attr --set --set-nodump $projectdir ./fifo
> +file_attr --set --set-nodump $projectdir ./chardev
> +file_attr --set --set-nodump $projectdir ./blockdev
> +file_attr --set --set-nodump $projectdir ./socket
> +file_attr --set --set-nodump $projectdir ./foo
> +file_attr --set --set-nodump $projectdir ./symlink
> +
> +echo "Read attributes"
> +file_attr --get $projectdir | _filter_scratch
> +file_attr --get $projectdir ./fifo
> +file_attr --get $projectdir ./chardev
> +file_attr --get $projectdir ./blockdev
> +file_attr --get $projectdir ./socket
> +file_attr --get $projectdir ./foo
> +file_attr --get $projectdir ./symlink
> +
> +echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
> +file_attr --set --set-nodump $projectdir ./broken-symlink
> +file_attr --get $projectdir ./broken-symlink
> +
> +file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
> +file_attr --get --no-follow $projectdir ./broken-symlink
> +
> +cd $SCRATCH_MNT
> +touch ./foo2
> +echo "Initial state of foo2"
> +file_attr --get --at-cwd ./foo2
> +echo "Set attribute relative to AT_FDCWD"
> +file_attr --set --at-cwd --set-nodump ./foo2
> +file_attr --get --at-cwd ./foo2
> +
> +echo "Set attribute on AT_FDCWD"
> +mkdir ./bar
> +file_attr --get --at-cwd ./bar
> +cd ./bar
> +file_attr --set --at-cwd --set-nodump ""
> +file_attr --get --at-cwd .
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/2000.out b/tests/generic/2000.out
> new file mode 100644
> index 000000000000..11b1fcbb630b
> --- /dev/null
> +++ b/tests/generic/2000.out
> @@ -0,0 +1,37 @@
> +QA output created by 2000
> +Error codes
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Argument list too long
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Argument list too long
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not set fsxattr on ./foo: Invalid argument
> +Initial attributes state
> +----------------- SCRATCH_MNT/prj 

hmm, this needs to filter out ------X standing for extended
attributes, this test will fail if selinux is enabled for example

I will send another revision soon

-- 
- Andrey


