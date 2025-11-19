Return-Path: <linux-fsdevel+bounces-69087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021AC6EA4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2AE44FEB71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744763612E6;
	Wed, 19 Nov 2025 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD8GoMr3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia0W/+1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA23612D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556585; cv=none; b=ff0bTQ0U8rVnlde0wE+rO0w4Qb+Upoq1MVkb3nO58W4i7TbsFeu5dumYYVOwiPS66Dmk1LIVjmowzqh9S+8Xx0p64LcqAHdzPYfFkedscFXisloMse1pPEypqxAVUkFNdNSsAQ9Yj4KCGysf+fZwD+DpIWOXRTpjOpGAsOUpfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556585; c=relaxed/simple;
	bh=Aml9mhbo5ieOTq8KwkIuEkeGr1B1i0U6iqTTRe5f7Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcuxVqbO1/mP4fQBe1DrXJ6qnN+6P2rp5Pkcj+Y3Qto6wCcwB/3CTVbM1wVCVPNuM3I6tUjcmAnFP2Xzx57/+g5HVOkMelUI8o+vqNCeXgVTy14vwh0nn1yeFkK89lGuPixuVKEB7rT9eVXeSHfTKBvKur8FOwuEEDw3y43CWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YD8GoMr3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ia0W/+1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763556580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flkABsEx2eMbyuz8BLkDw0Qlh05ntEkhFH7p7w45OwQ=;
	b=YD8GoMr39Q3Qi2FH5id1z5PvRrGuNTW9GbhEfoqftNXrop62w1hJ3GRRvmQJQbxteDGgn4
	DcJL1mq4dNEQBpy3HT9lvT2P2SoCq3T0YQKy4Rz/zeZqMRakq7Ghx7C/EIdBCEWfAYIa4l
	UQ283K9Ty1eyZi1oKecQL89ORqe/cRo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-eUCduBQiP0KU5ogyVhoBtA-1; Wed, 19 Nov 2025 07:49:38 -0500
X-MC-Unique: eUCduBQiP0KU5ogyVhoBtA-1
X-Mimecast-MFC-AGG-ID: eUCduBQiP0KU5ogyVhoBtA_1763556575
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-298389232c4so106390855ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 04:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763556575; x=1764161375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flkABsEx2eMbyuz8BLkDw0Qlh05ntEkhFH7p7w45OwQ=;
        b=ia0W/+1CXj//F4QwCbEfblaDrxfK5qzB6pLz1YTm2o1ebEnHDyjdCuqiRKY6vGfGV8
         UIn8uJuVMp0W93MKqflQzuM7GA6uJ9jgxuGObEjinFGWvfY/cQzon6w5FWvgWaAjC5El
         traZkpN3kubUAv6rn1ykkP4yy+5LIAg2PAbg1jSLP6SD8BGknjrJTkFTLbyyaxGhakgY
         t0EeZ3AgMyVV6YUeM4fUJ7EESPIXdoySI3P4Vd04xn9tiMKUsy2Xn6F+tIAG6S6E0rdC
         sPoT7vS1fSTT3qvIWHd4yaoz8AOe3TEXbOgkQUusowzdSM8lqTHN9YC7CfoPeUP2ZMYw
         /tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556575; x=1764161375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flkABsEx2eMbyuz8BLkDw0Qlh05ntEkhFH7p7w45OwQ=;
        b=S5M0zAiVXf3uXTRpVaQQKsx6mVXil3iFVKm/+BeaysYSq1p2bDFuuJlKwInkT9Ki76
         4r9QKi/xSksWB86dsmeIvlTOkO4RU1fTy+FdiOJ75dBnYQQ6AI6KOCjeoYZxsFAQ8iPz
         VBuFNifub00Kwkq1yw9hQ/pI8V2m98AkziV3BEPZbbUSIUmYHxuRNM75Nu14A+3vHZ0f
         yjYGXtsv8FHa0Po0aL0mPS++FrQfdq1JqxceRNn1jXUrB48z+YzNOgFX6cXwGVNiNd9J
         MKIVQICca1mvq9fOc/nn0R9UQoH5rB8UjpTiS8/QmLRqlO8oht9cD7K0uxbfCg0QaYJp
         bLuw==
X-Forwarded-Encrypted: i=1; AJvYcCVtJElZ0F2pXLJXsLqthPe7M+OpqFWCUaAeN217d5HuoY4+qYE3930ZntEjN9kucqffx04+5le27kjeuikf@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1ihGqMCsQaWbWEgbjINrKunAKwg8YzytG/txHjTASXk4DlWs
	hwkm2bVn5a4B1aXkKVzU+V2Ufu+/xn3gG8QXm44SbPVNtTKPRV1ssrdARHdNsMglukV1+cL6Smu
	9rFg4ZfqVNrLAVFQGysulORQIVltP2QrGrt9ZLexGAbj2ed5s+a/TCzvCpbs+bkLGy9E=
X-Gm-Gg: ASbGnctfj5i5PQmhq7d/qdmzgVe0LtmAl/HVw1Wvjm7mpVkB0fOjW75TWPwXa2Y/ASw
	PxNxgOnUmo97njBEbhsb2uM8OyaHNR1KF6QfQuUQ9Cc+FaLiDo2aaHItTevdQkQ8bkmc0fTk2WK
	k2SNJ0x6QN51GOXHnJtJMapbt0A0X0GAmUsKDV5o0WrC2DSLs6q3+KJTd2K4OyESf/VcX5I9w4O
	kT8x/beYs/nvIBnuiWgOKHW8QBx2FG+btUz3H6Db4BZwOEHacdrSHwUx6XhOmfGY46/gPWPhZ3f
	4p80kivSSfD14mKUPbM2ulHTki7UHPGB9B4yq485VHejL7zXDKOcxGCfC2CH+qc2am2o6Si1ehk
	xPvQg5c+J4oPaTkibkvcl0F95SztCuNkbh9aHrWSP4OkUwxM9rg==
X-Received: by 2002:a17:902:e788:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-2986a72bfa8mr210273915ad.38.1763556575377;
        Wed, 19 Nov 2025 04:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbH9UiL2wp1w2nlF+UYaofJ7mKdhhfcN9stx+h2/YWunOFbKhq9ZMAdbKY9c4oxzla47t0Ag==
X-Received: by 2002:a17:902:e788:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-2986a72bfa8mr210273645ad.38.1763556574905;
        Wed, 19 Nov 2025 04:49:34 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d68sm208240305ad.61.2025.11.19.04.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:49:34 -0800 (PST)
Date: Wed, 19 Nov 2025 20:49:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] fstests: add fuse.gocryptfs support
Message-ID: <20251119124930.mefocqn25p3j2fbm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251116184545.3450048-1-jakobunt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116184545.3450048-1-jakobunt@gmail.com>

On Sun, Nov 16, 2025 at 07:45:38PM +0100, Jakob Unterwurzacher wrote:
> Add instructions for testing gocryptfs, an encrypted overlay filesystem,
> and a few small changes that were needed for gocryptfs compatibility:
> 
> 1) _scratch_unmount and _test_unmount now unmount fuse filesystems
> via mountpoint instead of via device. Unmounting via device fails when
> the "device" is actually a directory on a different filesystem.
> Unmounting via mountpoint always works.
> 
> 2) Add subtype=passthrough_ll to the passthrough_ll mount options.
> This makes passthrough_ll behave more like most other fuse filesystems
> which do set a subtype. Example from my Fedora box:
> 
> 	$ mount | grep -o "type fuse\\..* "
> 	type fuse.gvfsd-fuse
> 	type fuse.portal
> 	type fuse.gocryptfs
> 	type fuse.encfs
> 	type fuse.passthrough_ll
> 
> With this change, _check_mounted_on can match on $FSTYP$FUSE_SUBTYP
> for passthrough_ll, which also works for gocryptfs and likely most
> other fuse filesystems.
> 
> Results for passthrough_ll on top of tmpfs:
> 
> 	Failures: generic/120 generic/125 generic/184 generic/294 generic/306 generic/317 generic/355
> 	generic/363 generic/426 generic/434 generic/452 generic/467 generic/477 generic/633 generic/647
> 	generic/653 generic/675 generic/683 generic/684 generic/729 generic/745 generic/751 generic/756
> 	generic/777
> 	Failed 24 of 769 tests
> 
> Results for gocryptfs on top of tmpfs:
> 
> 	Failures: generic/020 generic/062 generic/093 generic/099 generic/103 generic/120 generic/125
> 	generic/184 generic/285 generic/294 generic/306 generic/317 generic/319 generic/426 generic/434
> 	generic/444 generic/452 generic/467 generic/471 generic/477 generic/633 generic/676 generic/683
> 	generic/688 generic/696 generic/697 generic/707 generic/756 generic/777
> 	Failed 29 of 769 tests
> 
> Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
> ---
>  README.fuse | 34 ++++++++++++++++++++++++++++++++--
>  common/rc   | 11 ++++++++++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/README.fuse b/README.fuse
> index 969dbd5d..df248681 100644
> --- a/README.fuse
> +++ b/README.fuse
> @@ -1,3 +1,6 @@
> +passthrough_ll
> +==============
> +
>  Here are instructions for testing fuse using the passthrough_ll example
>  filesystem provided in the libfuse source tree:
>  
> @@ -22,5 +25,32 @@ export SCRATCH_DEV=non2
>  export SCRATCH_MNT=/mnt/scratch
>  export FSTYP=fuse
>  export FUSE_SUBTYP=.passthrough_ll
> -export MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
> -export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"
> +export MOUNT_OPTIONS="-osource=/home/test/scratch,subtype=passthrough_ll,allow_other,default_permissions"
> +export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,subtype=passthrough_ll,allow_other,default_permissions"

This patch changes the required parameter to test FUSE, cc fuse list to get
more review.

> +
> +
> +gocryptfs
> +=========
> +
> +Here are the instructions for gocryptfs:
> +
> +git clone https://github.com/rfjakob/gocryptfs.git
> +cd gocryptfs
> +./build.bash
> +cat << EOF | sudo tee /sbin/mount.fuse.gocryptfs
> +#!/bin/bash
> +exec $(pwd)/gocryptfs -q -allow_other -acl -extpass "echo test" "\$@"
> +EOF
> +sudo chmod +x /sbin/mount.fuse.gocryptfs
> +mkdir -p /mnt/gocryptfs.test /mnt/gocryptfs.scratch /home/test/gocryptfs.test /home/test/gocryptfs.scratch
> +gocryptfs -init -q -scryptn=10 -extpass "echo test" /home/test/gocryptfs.test
> +gocryptfs -init -q -scryptn=10 -extpass "echo test" /home/test/gocryptfs.scratch
> +
> +Use the following local.config file:
> +
> +export TEST_DEV=/home/test/gocryptfs.test
> +export TEST_DIR=/mnt/gocryptfs.test
> +export SCRATCH_DEV=/home/test/gocryptfs.scratch
> +export SCRATCH_MNT=/mnt/gocryptfs.scratch
> +export FSTYP=fuse
> +export FUSE_SUBTYP=.gocryptfs
> diff --git a/common/rc b/common/rc
> index 8fd7876a..da8be16e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -512,6 +512,11 @@ _scratch_unmount()
>  	tmpfs)
>  		_unmount $SCRATCH_MNT
>  		;;
> +	fuse)
> +		# The "source device" can be an arbitrary string for fuse filesystems
> +		# and may not be unique. Unmount by mountpoint instead.
> +		_unmount $SCRATCH_MNT
> +		;;
>  	*)
>  		_unmount $SCRATCH_DEV
>  		;;
> @@ -703,6 +708,10 @@ _test_unmount()
>  {
>  	if [ "$FSTYP" == "overlay" ]; then
>  		_overlay_test_unmount
> +	elif [ "$FSTYP" == "fuse" ]; then
> +		# The "source device" can be an arbitrary string for fuse filesystems
> +		# and may not be unique. Unmount by mountpoint instead.
> +		_unmount $TEST_DIR
>  	else
>  		_unmount $TEST_DEV
>  	fi
> @@ -5021,7 +5030,7 @@ init_rc()
>  
>  	# Sanity check that TEST partition is not mounted at another mount point
>  	# or as another fs type
> -	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP || _exit 1
> +	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP$FUSE_SUBTYP || exit 1
>  	if [ -n "$SCRATCH_DEV" ]; then
>  		# Sanity check that SCRATCH partition is not mounted at another
>  		# mount point, because it is about to be unmounted and formatted.
> -- 
> 2.51.0
> 
> 


