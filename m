Return-Path: <linux-fsdevel+bounces-57414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A8B213F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A8119075AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402B2E1C55;
	Mon, 11 Aug 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIomUPfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D92E06EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936026; cv=none; b=F060bzEei9EoAkhzOQAMZVe8kkC/oYWdaOynUR3Kb3rtk9AFRhRjt95z3z7marR5nsHF0ArGgiNTVvT18XqyPIgC8HzbjtptFe4KyL0whAC3Y4me/R2rdbVfumJ9+WMm+tNS8Pg0rVZk+IxMTNF0Pr+pDFHPIEsUeHfDDO5QCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936026; c=relaxed/simple;
	bh=SaDYoexQ4i5tsfF3WUqgJORGkWiPSN9Fx4XhDfEx2tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2FGvcinbRDgjRB8ejDkUXhi1OwsBawNzPynXUAqcY962jE3hxCLQ7wfDkxoYL1BJJFpc7h7TmhHjNoRxOL8DMxYZZPdsrUFKGChoVJMvR+Be8FrzWkXAbNgrZxBYvaZDRITxQzF++zGSvzT22qm1PmBHf7LY5BfZyiPITL51wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIomUPfw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TMPOQosyR3kzECChmd17ITJUt3EfWra1AAklKdXopQ=;
	b=HIomUPfwNuqsw1XY2bZouyhNtpqmrsqZ7q57FOzT4PVK4iUMNL1FYHIBAUV16m8g0gBcpi
	RizPl84Uuy8XvNw5ToagHrCd/SJlu0YBOev7iRH3Za+TggwFktnElxSdkQjcCJnBgQQOA6
	bR6g9ppbNF4ab8fBQPG7vgZIwEFTDBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-KQrHDoG0NZW7G8PzKhuiaA-1; Mon, 11 Aug 2025 14:13:41 -0400
X-MC-Unique: KQrHDoG0NZW7G8PzKhuiaA-1
X-Mimecast-MFC-AGG-ID: KQrHDoG0NZW7G8PzKhuiaA_1754936020
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d30992bcso44641355e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936020; x=1755540820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TMPOQosyR3kzECChmd17ITJUt3EfWra1AAklKdXopQ=;
        b=AfmCziFZGJ3nGAdb2xxzmpkZnOGdd8CSG6I7yfS5lb8y6RL2IIuOaifLjX+C7a80+/
         7BXctpGSTMRm0vBG6vU7/NoVzEZRQLMiiAnKX+dccrtszH7JpQloAJ7IpfCZeyLe64kP
         zh4IW0KLKuxvG+EZ6YQIfhHv+mJZJgXOOEHW8UFZKEyqjhr0deUMWfipLUdi48gu0h/j
         Co0lkIKGUnQZG/x1qYk/EmVeArIL+qve6x2frbavFLrhSw/c5lYI5EGrCWuGKJzQ8pkK
         cOW+NxY5AN6o6C7p2i48pIPMvjNXs7A1cp+PCJJ5YFzwfLZ2cmTJnF7RjNZ6WT1mSuPi
         kWAA==
X-Forwarded-Encrypted: i=1; AJvYcCUv2myHjpjyzM8goBoAPU2mNJb915CiBI7IlZzrMjgZbcqXoS87zSnxWmHudKrQRI90U4yd9UlM8CkfFZpc@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJXzisD4eBHXasOe98oaX+JjU6pGxvQ7F3EZ78xFz5VprKG/z
	xWvY9BAl0A3022R4cRUPzKR8yFuKTO5fUDIBYtTNeNTNaC4le6yIAX4vShl6aBBVcRPDHZSOgHo
	HHkfmKmXVJXo4PKVe3BCcSitbu34drWmSQRpyd5bx1TDz8OreRF6fnGCDm+mTLDeeWg==
X-Gm-Gg: ASbGncvIMaroVNVylHJgY6gBExrcSDyAP9eBvrGcaOdpyRzJNIW20McB2l7cn1ipsPH
	oGJ2LZV5Y0pYyGtxuTUhklIsJDsNRWau5/7MPosD6EeFtR8tsX4x243zEZ1VKtljRPcwl2g9N1U
	8HgUcIjIUnS+Vs2pDfaQz0cawJ9XLaFih3nbNfRLtRBp9gozU9MikEnGCBvVyF4ZvyKYwgMQsjF
	NPKEMaB4ffh22jgMZ8VOZShPSgPGVqqFbN9fl2CM2crgxrkxF7aj578k5sm0B3zCBP0hCVAOpHI
	ip4+114+jaylgOMfNochbcg2LvfnlriDwwot/yvzqPV6MF/zX3elhpB+gxY=
X-Received: by 2002:a05:600c:1c97:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-459f4f3dda6mr118690345e9.2.1754936019712;
        Mon, 11 Aug 2025 11:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpEEe1Ffykdz8Jornajz4J1RLFvc/FUoBKAZ7COCrJvtMvhYda/gZ9RZ/4GOWvQPFQrYHNYA==
X-Received: by 2002:a05:600c:1c97:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-459f4f3dda6mr118690175e9.2.1754936019256;
        Mon, 11 Aug 2025 11:13:39 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5873c43sm286317885e9.22.2025.08.11.11.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:13:39 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:13:38 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <n226bxztejpoulfh5ok4qp2acccnr3d2smbqev2jsbd46omnom@4xqc67yx234p>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>
 <20250811151740.GE7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811151740.GE7965@frogsfrogsfrogs>

On 2025-08-11 08:17:40, Darrick J. Wong wrote:
> On Fri, Aug 08, 2025 at 09:31:57PM +0200, Andrey Albershteyn wrote:
> > Add a test to test basic functionality of file_getattr() and
> > file_setattr() syscalls. Most of the work is done in file_attr
> > utility.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  tests/generic/2000     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/2000.out |  37 ++++++++++++++++
> >  2 files changed, 150 insertions(+)
> > 
> > diff --git a/tests/generic/2000 b/tests/generic/2000
> > new file mode 100755
> > index 000000000000..b4410628c241
> > --- /dev/null
> > +++ b/tests/generic/2000
> > @@ -0,0 +1,113 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 2000
> > +#
> > +# Test file_getattr/file_setattr syscalls
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +# Import common functions.
> > +# . ./common/filter
> > +
> > +_wants_kernel_commit xxxxxxxxxxx \
> > +	"fs: introduce file_getattr and file_setattr syscalls"
> > +
> > +# Modify as appropriate.
> > +_require_scratch
> > +_require_test_program "af_unix"
> > +_require_test_program "file_attr"
> > +_require_symlinks
> > +_require_mknod
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +file_attr () {
> > +	$here/src/file_attr $*
> > +}
> > +
> > +create_af_unix () {
> > +	$here/src/af_unix $* || echo af_unix failed
> > +}
> > +
> > +projectdir=$SCRATCH_MNT/prj
> > +
> > +# Create normal files and special files
> > +mkdir $projectdir
> > +mkfifo $projectdir/fifo
> > +mknod $projectdir/chardev c 1 1
> > +mknod $projectdir/blockdev b 1 1
> > +create_af_unix $projectdir/socket
> > +touch $projectdir/foo
> > +ln -s $projectdir/foo $projectdir/symlink
> > +touch $projectdir/bar
> > +ln -s $projectdir/bar $projectdir/broken-symlink
> > +rm -f $projectdir/bar
> > +
> > +echo "Error codes"
> > +# wrong AT_ flags
> > +file_attr --get --invalid-at $projectdir ./foo
> > +file_attr --set --invalid-at $projectdir ./foo
> > +# wrong fsxattr size (too big, too small)
> > +file_attr --get --too-big-arg $projectdir ./foo
> > +file_attr --get --too-small-arg $projectdir ./foo
> > +file_attr --set --too-big-arg $projectdir ./foo
> > +file_attr --set --too-small-arg $projectdir ./foo
> > +# out of fsx_xflags mask
> > +file_attr --set --new-fsx-flag $projectdir ./foo
> > +
> > +echo "Initial attributes state"
> > +file_attr --get $projectdir
> > +file_attr --get $projectdir ./fifo
> > +file_attr --get $projectdir ./chardev
> > +file_attr --get $projectdir ./blockdev
> > +file_attr --get $projectdir ./socket
> > +file_attr --get $projectdir ./foo
> > +file_attr --get $projectdir ./symlink
> > +
> > +echo "Set FS_XFLAG_NODUMP (d)"
> > +file_attr --set --set-nodump $projectdir
> > +file_attr --set --set-nodump $projectdir ./fifo
> > +file_attr --set --set-nodump $projectdir ./chardev
> > +file_attr --set --set-nodump $projectdir ./blockdev
> > +file_attr --set --set-nodump $projectdir ./socket
> > +file_attr --set --set-nodump $projectdir ./foo
> > +file_attr --set --set-nodump $projectdir ./symlink
> > +
> > +echo "Read attributes"
> > +file_attr --get $projectdir
> > +file_attr --get $projectdir ./fifo
> > +file_attr --get $projectdir ./chardev
> > +file_attr --get $projectdir ./blockdev
> > +file_attr --get $projectdir ./socket
> > +file_attr --get $projectdir ./foo
> > +file_attr --get $projectdir ./symlink
> > +
> > +echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
> > +file_attr --set --set-nodump $projectdir ./broken-symlink
> > +file_attr --get $projectdir ./broken-symlink
> > +
> > +file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
> > +file_attr --get --no-follow $projectdir ./broken-symlink
> > +
> > +cd $SCRATCH_MNT
> > +touch ./foo2
> > +echo "Initial state of foo2"
> > +file_attr --get --at-cwd ./foo2
> > +echo "Set attribute relative to AT_FDCWD"
> > +file_attr --set --at-cwd --set-nodump ./foo2
> > +file_attr --get --at-cwd ./foo2
> > +
> > +echo "Set attribute on AT_FDCWD"
> > +mkdir ./bar
> > +file_attr --get --at-cwd ./bar
> > +cd ./bar
> > +file_attr --set --at-cwd --set-nodump ""
> > +file_attr --get --at-cwd .
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/2000.out b/tests/generic/2000.out
> > new file mode 100644
> > index 000000000000..51b4d84e2bae
> > --- /dev/null
> > +++ b/tests/generic/2000.out
> > @@ -0,0 +1,37 @@
> > +QA output created by 2000
> > +Error codes
> > +Can not get fsxattr on ./foo: Invalid argument
> > +Can not get fsxattr on ./foo: Invalid argument
> > +Can not get fsxattr on ./foo: Argument list too long
> > +Can not get fsxattr on ./foo: Invalid argument
> > +Can not get fsxattr on ./foo: Argument list too long
> > +Can not get fsxattr on ./foo: Invalid argument
> > +Can not set fsxattr on ./foo: Invalid argument
> > +Initial attributes state
> > +----------------- /mnt/scratch/prj 
> 
> Assuming SCRATCH_DIR=/mnt/scratch on your system, please _filter_scratch
> the output.
> 
> (The rest looks reasonable to me.)
> 
> --D
> 

ops, will fix, thanks

-- 
- Andrey


