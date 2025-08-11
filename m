Return-Path: <linux-fsdevel+bounces-57403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D5EB21399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4613F3B49D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE2726AA91;
	Mon, 11 Aug 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJHc8Woc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA856B640
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934383; cv=none; b=BceyXOI/yuRRKxYi1KTybQjSJB9Q1x1HaNmpPzhOD8OCxlCr2Uma5qX+mnw93gbR8TmXxmNTePlqpNIB/HAe6fHmmq5auat8Df6IxNFzkiSeRJ6Y5vj8ffeX09VB1P8OqI9fGaePBC/JM7RvR2xSb3wltF1aLwnN3ZvVhP751OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934383; c=relaxed/simple;
	bh=jblgerfx+aJVX6LVOYqXPt0kykFkW9DjcEJst3CKdxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8zhH6ZhQl9yoFupI26TOVv9BygeVJnwbmwixEP1PRgYK2nGUCBod5vfgAG+xgzykcOVMZClVqnoz0RKcfcpYMhwe+/v14B2F1COaaeo0YOqmuWRpAS4oJIoEUFlXl4Ay7pvmpjaqq0vy/kS1fkGOxac4AlfP+n9Rmq0WQA87gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJHc8Woc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754934380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMneaytKQ0AD4shgUGd68vlulgEjA6lPuzfiwSM1OQI=;
	b=bJHc8WocAKhZem/nA5kbYJOvJ4FhUmW+zQaNa6vdhMk4tKhWT9i/5T3c2GIc3O8/h5612L
	gsJ6LCqos4SpIZ9PxppsH64oI1J0DdDotCxZeXVVA7StAlwwI+zIAN9iMmPe5lQXsp01Cs
	IccJJJz0vI7qvEpb9XUUKaPmI1rT/rA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-mNgZA-XGPQudsQ9MSXptlQ-1; Mon, 11 Aug 2025 13:46:19 -0400
X-MC-Unique: mNgZA-XGPQudsQ9MSXptlQ-1
X-Mimecast-MFC-AGG-ID: mNgZA-XGPQudsQ9MSXptlQ_1754934379
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso8906017b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934378; x=1755539178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMneaytKQ0AD4shgUGd68vlulgEjA6lPuzfiwSM1OQI=;
        b=jHXPeeCrrqrL7WLm4RXouimqUmUX6kcc298QUWZt2uhh+BQZxomjqx270tuecrtEC3
         onTK//Zt0AG+/emNMjbNou95cSOqjDkJCVmxpa7u8DmcEpoCllkPysLN06mXKdwqYz6x
         fJohohi+d6mNn9ilGzgbX0Z64JjuHOpmuG3rmNnd5unmTDBYSOIwUJZxAONRCb8HQzVY
         v5Ttq5FieGG3K4pUjIHqqTsxPESt92uWon3gbHvjJk+dHWL3rjNTU6qvzpa+hRc7NBs3
         bpTndrMxpX6D1Cyplk2bqrLGJvXHcOfveJ5G+AdNB9AYsMbOma+ITRu/HdfTi2xkgBTR
         iSHA==
X-Forwarded-Encrypted: i=1; AJvYcCW28r0eKfsH6TblYiL/DIpByRpmZuVt/F+nsjsCj/IogqvgYjd52sKxSEC6WL+57l5QpK3GLIBWIzzcbC7h@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqfvGChXjuuUSRsYZZLjD9e+glhjYsmnR01qzEa/K4MLioOMm
	JBjUpAri6bYgNofpGkVhIe12XH+kGvE4VbXG9FwbTSdWB+dh5ZUJvMISwyRKFBOs2oR3/A9BV1S
	E/wT/ZYZ1w5ePU5cANMMoBNnMBDLHm2AhdXAFTteOm4rB1p7PzVg52dk+DgS7D30yX3EmDoTW4t
	0=
X-Gm-Gg: ASbGnctIl3Ossm/xWbZkhBLT/MFx87fyCU2wm3ZsI45zLpMS5fsRpM0AcXpFxpa3+tg
	xysl0bBtKdwpRFcv/cmN9n6/snFzYrT2t53XnYXABm2geqXIvhC/hkfwq0896YA24ZvrArbDDrS
	uM2Hdo6GVut3ez8YMWhV8GXFhCXT6TScgH6It90mv4HPGSDiKx2pwFzE1/Iv2pDYJuOv7/kpndu
	vUuc5dwkF5AMIutOI5W1BpgFln2MAqWNANZ/mKqOwjKcJ1ABT/f2mdkYL7dHowe+bnGTSpdLyxN
	fKbDmOR+eCdaiYyygBPLXWdZNW2hcvxWpb07KbtVHBcQLYcBBZZIIMbjzJOMgn4XFJfN6PtY+6f
	VJKcU
X-Received: by 2002:a05:6a00:2d1b:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-76c461afafbmr20914884b3a.24.1754934378068;
        Mon, 11 Aug 2025 10:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHICW+eZv8C5Z5RSskTv0jMxvDRZLNGUY53XhWHmVwEA9SnpT+Jnb7MR3JJ8/dMmD/l01jQSw==
X-Received: by 2002:a05:6a00:2d1b:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-76c461afafbmr20914839b3a.24.1754934377649;
        Mon, 11 Aug 2025 10:46:17 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm15396442b3a.117.2025.08.11.10.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:46:17 -0700 (PDT)
Date: Tue, 12 Aug 2025 01:46:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 3/3] xfs: test quota's project ID on special files
Message-ID: <20250811174613.tskc4xzbhteyiq5z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-3-6a09c4f37f10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-xattrat-syscall-v1-3-6a09c4f37f10@kernel.org>

On Fri, Aug 08, 2025 at 09:31:58PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> With addition of file_getattr() and file_setattr(), xfs_quota now can
> set project ID on filesystem inodes behind special files. Previously,
> quota reporting didn't count inodes of special files created before
> project initialization. Only new inodes had project ID set.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  tests/xfs/2000     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/2000.out | 17 ++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/tests/xfs/2000 b/tests/xfs/2000
> new file mode 100755
> index 000000000000..26a0093c1da1
> --- /dev/null
> +++ b/tests/xfs/2000
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Red Hat.  All Rights Reserved.
> +#
> +# FS QA Test No. 2000
> +#
> +# Test that XFS can set quota project ID on special files
> +#
> +. ./common/preamble
> +_begin_fstest auto quota
> +
> +# Import common functions.
> +. ./common/quota
> +. ./common/filter
> +
> +_wants_kernel_commit xxxxxxxxxxx \
> +	"xfs: allow setting file attributes on special files"
> +_wants_git_commit xfsprogs xxxxxxxxxxx \
> +	"xfs_quota: utilize file_setattr to set prjid on special files"
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_xfs_quota
> +_require_test_program "af_unix"
> +_require_symlinks
> +_require_mknod
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_qmount_option "pquota"
> +_scratch_mount
> +
> +create_af_unix () {
> +	$here/src/af_unix $* || echo af_unix failed
> +}
> +
> +filter_quota() {
> +	_filter_quota | sed "s~$tmp.projects~PROJECTS_FILE~"
> +}
> +
> +projectdir=$SCRATCH_MNT/prj
> +id=42
> +
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
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "report -inN -p" $SCRATCH_DEV
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +
> +# Let's check that we can recreate the project (flags were cleared out)
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "report -inN -p" $SCRATCH_DEV
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/2000.out b/tests/xfs/2000.out
> new file mode 100644
> index 000000000000..dd3918f1376d
> --- /dev/null
> +++ b/tests/xfs/2000.out
> @@ -0,0 +1,17 @@
> +QA output created by 2000
> +Setting up project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +Checking project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +#0                   3          0          0     00 [--------]

Better to filter out the root quota report, it might fail on some test environments.

Thanks,
Zorro

> +#42                  8         20         20     00 [--------]
> +
> +Clearing project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +Setting up project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +#0                   3          0          0     00 [--------]
> +#42                  8         20         20     00 [--------]
> +
> +Clearing project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> 
> -- 
> 2.49.0
> 


