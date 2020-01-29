Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD114C6AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 07:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2Gwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 01:52:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32487 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726020AbgA2Gwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580280754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o2nAYxiwbKwagyq/2EqzUb8SHM5xKAhszyjiJ0DgTQQ=;
        b=PNMqz5GxOyo6ZONOfG5cvUUZdhrt2NRxdccuMWc7U8+gfUaxWwuJHA9KGHQDOVpAdtAMRt
        osI1JqnaQHzINgcUXty7FabQuMWyyOcrJpQ4VBzoFLpTP0MW69tYaXuqU+ehILma7e6VJ/
        cS2FvD+wW8iIuy97pkyQ22ZSkFIbXek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-CUYTWbG3Noi0roICe5Rvmw-1; Wed, 29 Jan 2020 01:52:30 -0500
X-MC-Unique: CUYTWbG3Noi0roICe5Rvmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5641B107ACCA;
        Wed, 29 Jan 2020 06:52:29 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB2EC38A;
        Wed, 29 Jan 2020 06:52:28 +0000 (UTC)
Date:   Wed, 29 Jan 2020 15:02:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [RFC PATCH xfstests] generic: add smoke test for AT_LINK_REPLACE
Message-ID: <20200129070205.GK14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
References: <cover.1580251857.git.osandov@fb.com>
 <f23621bea2e8d5f919389131b84fa0226b90f502.1580253372.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23621bea2e8d5f919389131b84fa0226b90f502.1580253372.git.osandov@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 03:18:56PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---

I think you'd better to send this patch to/cc fstests@vger.kernel.org to
get review or merge.

Thanks,
Zorro

>  common/rc             |  2 +-
>  tests/generic/593     | 97 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/593.out |  6 +++
>  tests/generic/group   |  1 +
>  4 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100755 tests/generic/593
>  create mode 100644 tests/generic/593.out
> 
> diff --git a/common/rc b/common/rc
> index eeac1355..257f65a1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2172,7 +2172,7 @@ _require_xfs_io_command()
>  		;;
>  	"flink")
>  		local testlink=$TEST_DIR/$$.link.xfs_io
> -		testio=`$XFS_IO_PROG -F -f -c "flink $testlink" $testfile 2>&1`
> +		testio=`$XFS_IO_PROG -F -f -c "flink $param $testlink" $testfile 2>&1`
>  		rm -f $testlink > /dev/null 2>&1
>  		;;
>  	"-T")
> diff --git a/tests/generic/593 b/tests/generic/593
> new file mode 100755
> index 00000000..8a9fee02
> --- /dev/null
> +++ b/tests/generic/593
> @@ -0,0 +1,97 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 593
> +#
> +# Smoke test linkat() with AT_LINK_REPLACE.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_xfs_io_command "-T"
> +_require_xfs_io_command "flink" "-f"
> +
> +same_file() {
> +	[[ "$(stat -c '%d %i' "$1")" = "$(stat -c '%d %i' "$2")" ]]
> +}
> +
> +touch "$TEST_DIR/$seq.src"
> +touch "$TEST_DIR/$seq.tgt"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" ||
> +	echo "Target was not replaced"
> +
> +# Linking to the same file should be a noop.
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.src" "$TEST_DIR/$seq.src"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" || echo "Target changed?"
> +
> +# Should work with O_TMPFILE.
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" -T "$TEST_DIR"
> +stat -c '%h' "$TEST_DIR/$seq.tgt"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" &&
> +	echo "Target was not replaced"
> +
> +# It's okay if the target doesn't exist.
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt2" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt2" ||
> +	echo "Target was not created"
> +
> +# Can't replace directories.
> +mkdir "$TEST_DIR/$seq.dir"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.dir" "$TEST_DIR/$seq.src"
> +cd "$TEST_DIR/$seq.dir"
> +$XFS_IO_PROG -c "flink -f ." "$TEST_DIR/$seq.src"
> +$XFS_IO_PROG -c "flink -f .." "$TEST_DIR/$seq.src"
> +cd - &> /dev/null
> +
> +# Can't replace local mount points.
> +touch "$TEST_DIR/$seq.mnt"
> +$MOUNT_PROG --bind "$TEST_DIR/$seq.mnt" "$TEST_DIR/$seq.mnt"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.mnt" "$TEST_DIR/$seq.src"
> +
> +# Can replace mount points in other namespaces, though.
> +unshare -m \
> +	bash -c "$UMOUNT_PROG $TEST_DIR/$seq.mnt; $XFS_IO_PROG -c \"flink -f $TEST_DIR/$seq.mnt\" $TEST_DIR/$seq.src"
> +if $UMOUNT_PROG "$TEST_DIR/$seq.mnt" &> /dev/null; then
> +	echo "Mount point was not detached"
> +fi
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.mnt" ||
> +	echo "Mount point was not replaced"
> +
> +# Should replace symlinks, not follow them.
> +touch "$TEST_DIR/$seq.symtgt"
> +ln -s "$TEST_DIR/$seq.symtgt" "$TEST_DIR/$seq.sym"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.sym" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.sym" ||
> +	echo "Symlink was not replaced"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.symtgt" &&
> +	echo "Symlink target was replaced"
> +
> +rm -rf "$TEST_DIR/$seq."*
> +
> +status=0
> +exit
> diff --git a/tests/generic/593.out b/tests/generic/593.out
> new file mode 100644
> index 00000000..834c34bf
> --- /dev/null
> +++ b/tests/generic/593.out
> @@ -0,0 +1,6 @@
> +QA output created by 593
> +1
> +flink: Is a directory
> +flink: Is a directory
> +flink: Is a directory
> +flink: Device or resource busy
> diff --git a/tests/generic/group b/tests/generic/group
> index 6fe62505..0a87efca 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -595,3 +595,4 @@
>  590 auto prealloc preallocrw
>  591 auto quick rw pipe splice
>  592 auto quick encrypt
> +593 auto quick hardlink
> -- 
> 2.25.0
> 

