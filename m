Return-Path: <linux-fsdevel+bounces-57407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74343B213BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252633A3D8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9A2D6E41;
	Mon, 11 Aug 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxnKZude"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16102296BB7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934953; cv=none; b=kUoEjE/pye2jpqLZ9hBYAqkrLd8591nKoI7IxMvvNycZ8bL4WmjvAzG8oxLy2LzkTsmy1eqzgiv7zQmCMKPzQoOtD+qq2DvbYaJKb2l2pKE2vGAHYpfJHultKkEuY7V3JQXTHqtigQOTY0RZb60oQ7lRGye0UZMjEZxKhOC7J6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934953; c=relaxed/simple;
	bh=d76Rw9ArLn/J5YVt1ffSDv17TJKmXjtKa6MujY3MULY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztw1cNAgMW7uf5IdQHkLufoo8otwQcq6UGApZlNDw95dDgfK6D4V5GCT2hRuGhT8Ec9OOm0KbBrpR7hKawYstwyd4ly+5nkG9sbDIWGQNOgBbVsZKpNhHZyR+4mj0Sl1djDEoBvctVFwzwojpD+Rh1E3aCE7prWw0Et0CIGjtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxnKZude; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754934951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C3QXOydH3LXGSPQs+asu65g20FwVWtDtiIiic1aVboc=;
	b=YxnKZudeVdJLULanMbrjFifjVzr92eHF0XGnA+A+wSGzAqRcNabyU9ZLE5K/zdlkqX5VyM
	uENsfw9kdaB2inw4GNFgUTJbnTl6zImsiZm/RFKzIe2QDjZxne2Gzy/wvqjz+JwGAndrcQ
	M/xEAGzelYVkPCL6+bfzX+7AgOoTsWg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-OhD1nmlmMxeR4EnjSr9dsg-1; Mon, 11 Aug 2025 13:55:49 -0400
X-MC-Unique: OhD1nmlmMxeR4EnjSr9dsg-1
X-Mimecast-MFC-AGG-ID: OhD1nmlmMxeR4EnjSr9dsg_1754934948
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76be85bfc0aso3622584b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934948; x=1755539748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3QXOydH3LXGSPQs+asu65g20FwVWtDtiIiic1aVboc=;
        b=WmNrPcv74l4FFjonjmJ8euqSYsS9/o6L/F5t0d5XfsTAr7nLspOWFaZwK1Ti3s0xCc
         pJYDfOpbwuUs+GTCidBFerz7WPP14W+xuggVkQun2zTO1kbacBb0R0e6hqncwtoW7b3I
         z2/vvLB1G75Va4KjS/IJeIuBjIS1R32g4rFyEwWaRzGNDXBmCC9fRb474Y3bPyVNOhf9
         0bsnAJ7wh1LF6JETUu8JeiFWPXI9W+dtpQ2ZjroFJR3F/INxlRmwRcAfni4boEn9RFBn
         Ondk3RAKpvGZhU80GPJv16g00zQh/qgJhIOqaI5CVUWmd0mnp+g4X1sFyyIGKG539E4h
         Fg9g==
X-Forwarded-Encrypted: i=1; AJvYcCXajrpCDsmzsvinG+1f1IL4LbKglCh+b14O7o3iWar4H3dle3n+n7C4ojTM7YrxshGPLEdDMSZdUxB3+rdf@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtcSwOeJWh6EZu8U7hzZ2sqJdr85i/jqO+VtLHCBkxvlc+eZ6
	PmNYbIKb6X7db+ksUCebkWFMKt9tRZQadCRHN/kU2PQrn9D+i+Oec59YDcATQ17ku2pP6xVWGU2
	+4DDe1f6WF2EYQITu7IZnzKeviMbm+7XqZ4Pwh9twExIPKYJCYer2PdZVbj4Gr4yBfayv35SliM
	0=
X-Gm-Gg: ASbGncsPpEwCdHxBjMr88DyRsJSw2d1Yqw9VFiMGb09miZN8rFaEwW73cmMpzvvz18i
	fMPqRccEUz1ayJei3aLNSEKbvTvc35OdQDLVwMCYMKOrwpAj60vlzSNSzUShyZWAIitMY5OeH7r
	3TzPQ1c5sDXhglwdxyKYk9Dq+qXWLWVtSwWX7M8+JmtL1p9/F6iqbjrtj0jFwnVQNVY9oze0CxZ
	/prm7al/jUEb9wj23uALzwQ2EVHVgRb5B5wPjCTJvaKfuyE+7PmkkB/MvRA5Q7W7fqYZiMYTuRL
	rF+ZXV5/12ZHdVTsa1mtGE6ehM4omPaWlsuzp0SYvIFnzRsjOJnz2wc9PRxIbk8cuwI+fC3wyVc
	XWU2Q
X-Received: by 2002:a05:6a21:6da1:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-2409a97be24mr557750637.29.1754934947522;
        Mon, 11 Aug 2025 10:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkx3HlXgqAb3dC/KM8+a1wL3fzhbRQifsRsePpuzZS+oPXlv/TTJGnW1EcRAswQskCNnsL6A==
X-Received: by 2002:a05:6a21:6da1:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-2409a97be24mr557666637.29.1754934946575;
        Mon, 11 Aug 2025 10:55:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b428e6244a5sm9723150a12.23.2025.08.11.10.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:55:46 -0700 (PDT)
Date: Tue, 12 Aug 2025 01:55:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <20250811175541.nbvwyy76zulslgnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>

On Fri, Aug 08, 2025 at 09:31:57PM +0200, Andrey Albershteyn wrote:
> Add a test to test basic functionality of file_getattr() and
> file_setattr() syscalls. Most of the work is done in file_attr
> utility.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  tests/generic/2000     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/2000.out |  37 ++++++++++++++++
>  2 files changed, 150 insertions(+)
> 
> diff --git a/tests/generic/2000 b/tests/generic/2000
> new file mode 100755
> index 000000000000..b4410628c241
> --- /dev/null
> +++ b/tests/generic/2000
> @@ -0,0 +1,113 @@
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
> +# Import common functions.
> +# . ./common/filter
> +
> +_wants_kernel_commit xxxxxxxxxxx \
> +	"fs: introduce file_getattr and file_setattr syscalls"

As this's a new feature test, I'm wondering if we should use a _require_
function to check if current kernel and FSTYP supports file_set/getattr
syscalls, and _notrun if it's not supported, rather than fail the test.

Thanks,
Zorro

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
> +file_attr --get $projectdir
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
> +file_attr --get $projectdir
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
> index 000000000000..51b4d84e2bae
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
> +----------------- /mnt/scratch/prj 
> +----------------- ./fifo 
> +----------------- ./chardev 
> +----------------- ./blockdev 
> +----------------- ./socket 
> +----------------- ./foo 
> +----------------- ./symlink 
> +Set FS_XFLAG_NODUMP (d)
> +Read attributes
> +------d---------- /mnt/scratch/prj 
> +------d---------- ./fifo 
> +------d---------- ./chardev 
> +------d---------- ./blockdev 
> +------d---------- ./socket 
> +------d---------- ./foo 
> +------d---------- ./symlink 
> +Set attribute on broken link with AT_SYMLINK_NOFOLLOW
> +Can not get fsxattr on ./broken-symlink: No such file or directory
> +Can not get fsxattr on ./broken-symlink: No such file or directory
> +------d---------- ./broken-symlink 
> +Initial state of foo2
> +----------------- ./foo2 
> +Set attribute relative to AT_FDCWD
> +------d---------- ./foo2 
> +Set attribute on AT_FDCWD
> +----------------- ./bar 
> +------d---------- . 
> 
> -- 
> 2.49.0
> 


