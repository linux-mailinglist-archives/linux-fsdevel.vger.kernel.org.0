Return-Path: <linux-fsdevel+bounces-49820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4322DAC33FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 12:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2192E3A3CEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887AE1E5B64;
	Sun, 25 May 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctCLdNaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47571EEE6
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748170194; cv=none; b=BgJVSvxJOztZ7CH63NczDlbRGERFk/9UvRNRPJfji3Okatyy1Jb21Y39zqpbdQCH656V9PFV1ipV166TcZn7+LqstkI7/69Z1sOVftvQZC4D1WxRS3iPaCBV0EijpAXToUT09Xh/7D23kXya+Oxfj4iSK5mEHAFOPKRkYfbNvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748170194; c=relaxed/simple;
	bh=7yKbTv3gj8ctU0b67nCBA69euCAu2svDUYEd+GFonl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0AWhuCnnhx9t7xKVFskYwX+fjTQvuS10BSL8KzMZ1rGKr1amKAXED3lyvC7sA4WAc+E9KjDxTtsAruG3qVf3q9tkkG9Bjn+bNZ/aW6Lww89sosKi+lq4eqa14OFc26FuqPkZ9qwNpv75LS850gm0Zf4Bhh+KBUJnHKtOOgNp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctCLdNaC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748170190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz/E9IWdMOFr6BicHH50vsyvsKiWajN3DhCKTVNub3k=;
	b=ctCLdNaCf4JPGblcM+vLmATU8Tg8yO8tvZHsdyd5Izxy7PUhQqRNFd+j1L4Bct65etXvRA
	U49Bzqe21lptvmLiiWLPenJE3FP4nM2PHtsNRyou4/dykkROuS6Or36QsfzEpWRpEzjrAU
	M9IGVKO6wp1f87QVEqkBDjrIeW2+LxE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-oK2mrU-HNROqi0kzQHnVZQ-1; Sun, 25 May 2025 06:49:48 -0400
X-MC-Unique: oK2mrU-HNROqi0kzQHnVZQ-1
X-Mimecast-MFC-AGG-ID: oK2mrU-HNROqi0kzQHnVZQ_1748170188
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2344f88f9easo1584885ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 03:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748170188; x=1748774988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz/E9IWdMOFr6BicHH50vsyvsKiWajN3DhCKTVNub3k=;
        b=BomVS0pcT/Ol0u+ivCHhcNXvVQsHzyKZcUKb5jZHqbR0m1N4G6gDsFhhEfZ7vk4Owc
         PWzZIaYvchZWA+2Jmd9hzOIYoLhd1zZ74JtyPz1rgDg4v5DA2mKoaaiH5ZwY1EOe2i8M
         3hqSn953XucYmLMbyPb6RiSPtD+l9FRlKLUVaU82ulycB1+j9ATj0n/VBl/GfBBg7Omf
         9JuVcaBEWL+mJJS53CrMl4zrxbLCIetPRuQGwhhm98OzzMnIZN9cFpDt+HVvChr+DK2D
         awCWD4bxpv3vQbI+SYoex2FKclapgKmR7ZZ6Bx77ESvtAuCdcRR8Thkm4Cj1e/o8HGaB
         /OuA==
X-Forwarded-Encrypted: i=1; AJvYcCUoHRc1zazQMDD//Me6tFtvi1d3DeeljjQYxQaKfRgiAki+zfKIHB1C3hvuONn8nbIZ0ZNFlhNOcNon0+3L@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAHPWv45UZ7R1V1vpnVWu5rFNjYcNxxFJ/7T9kZxwbrowYLnJ
	TMlQ58pRh70pUck+ChXZjYUTTKwDnukny14/uCjUoa3J6c7jf5ZrDLgEEZ1oNLKjnID3ZODapxk
	T+HBRKVzE3LgzQqy2kh9nwtzB1x9qy5jHBGlijZLs3oK+XDd/XJF44GT2xhFIfzocKKM=
X-Gm-Gg: ASbGncsyOdyxb0prGGE49mG1Dgic7nLQCXtk1lOu19WOySWD6uCmb4ukSWuV1CFh8pY
	y2Lc8WDGNzH5wBVU3BJRKYBVQMGD7j8fDbJxtIIN4fT/uHRj5prZ89ESGOEviD1DdB4ThxvRQZy
	QgOAS3xls2qdl0JuV5ho7uNnsDOcejRrIwMZ4b4saremEX8ewP4zjz1jMrXK+W+OGH4nHA8Ovjk
	CqtXowa2apwWbEEraeAW9ezyFFHA3wBp2uq95czuwPIf5/4jblLMssQ+8mVCw0sLQI6ATg8DVyr
	k+W8KrG7iyp21Ty+zo3B46/3kdsvH+0EEnJeOsbwvM0a3DR+6Taz
X-Received: by 2002:a17:903:19f0:b0:224:10a2:cae7 with SMTP id d9443c01a7336-23414fb2509mr97440565ad.40.1748170187724;
        Sun, 25 May 2025 03:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfbENn2ZeSNx6g8fBNFmQvjshZpRLDgWWDXIFrUQuZkXZ5Jj1/il0RzWBUhU4fO9SKEuFn9w==
X-Received: by 2002:a17:903:19f0:b0:224:10a2:cae7 with SMTP id d9443c01a7336-23414fb2509mr97440425ad.40.1748170187359;
        Sun, 25 May 2025 03:49:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23445ee77c8sm8451705ad.127.2025.05.25.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:49:47 -0700 (PDT)
Date: Sun, 25 May 2025 18:49:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] open_by_handle: add a test for connectable
 file handles
Message-ID: <20250525104942.v66gb6kekfmwlbtp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170456.538501-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509170456.538501-1-amir73il@gmail.com>

On Fri, May 09, 2025 at 07:04:56PM +0200, Amir Goldstein wrote:
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

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/777.out |  4 +++
>  2 files changed, 74 insertions(+)
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
> +# do not really get unmounted in mount cycle like tmpfs, so skip this test.
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
> +status=0
> +exit
> diff --git a/tests/generic/777.out b/tests/generic/777.out
> new file mode 100644
> index 00000000..f2dd33c3
> --- /dev/null
> +++ b/tests/generic/777.out
> @@ -0,0 +1,4 @@
> +QA output created by 777
> +test_file_handles after cycle mount
> +test_file_handles after rename parent
> +test_file_handles after rename grandparent
> -- 
> 2.34.1
> 


