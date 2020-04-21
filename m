Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659CC1B2952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUOVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 10:21:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUOVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587478868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MCypdTKM5tRqvg3YLnFLW+zpGbcMZB6sw+7VXbKZIvk=;
        b=BRG1XY8N9eYt3dBfCCxMrxcnKGAE7nIKo8ke0/Vj9DvjAZGch0vg1qozkCIFebjMYk6VPY
        BaWn3sh6LRVJmFIZzQ4lQSGyNEVuxFw+6U9WxlZW/Ky9VPLrJXz4Z5xUyB6h4fHl3DCndz
        pyxHO2EQjBu1KIp8H7iAzMB6oR3Whrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-LlToL-d3O8CneMQxR0k8vw-1; Tue, 21 Apr 2020 10:21:04 -0400
X-MC-Unique: LlToL-d3O8CneMQxR0k8vw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D24F107ACC4;
        Tue, 21 Apr 2020 14:21:03 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13FFE76E8A;
        Tue, 21 Apr 2020 14:21:03 +0000 (UTC)
Date:   Tue, 21 Apr 2020 10:21:01 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        guaneryu@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH v2] generic: test reporting of wb errors via syncfs
Message-ID: <20200421142101.GA32228@bfoster>
References: <20200414120740.293998-1-jlayton@kernel.org>
 <20200420162143.28170-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420162143.28170-1-jlayton@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:21:43PM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> Add a test for new syncfs error reporting behavior. When an inode fails
> to be written back, ensure that a subsequent call to syncfs() will also
> report an error.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/generic/999     | 79 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  8 +++++
>  tests/generic/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> v2:
> - update license comment
> - only write a page of data
> - don't bother testing for enough scratch space
> - don't hold file open over test
> 
> Thanks to Brian Foster for the review! This is testing a proposed
> behavior change and is dependent on this patchset being merged:
> 
>     vfs: have syncfs() return error when there are writeback errors
> 
> We'll probably want to wait until its fate is clear before merging this.
> 
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 000000000000..cdc0772d0774
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2020, Jeff Layton. All rights reserved.
> +# FS QA Test No. 999
> +#
> +# Open a file and write to it and fsync. Then, flip the data device to throw
> +# errors, write to it again and do an fdatasync. Then open an O_RDONLY fd on
> +# the same file and call syncfs against it and ensure that an error is reported.
> +# Then call syncfs again and ensure that no error is reported. Finally, repeat
> +# the open and syncfs and ensure that there is no error reported.
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	_dmerror_cleanup
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmerror
> +
> +# real QA test starts here
> +_supported_os Linux
> +_require_scratch_nocheck
> +# This test uses "dm" without taking into account the data could be on
> +# realtime subvolume, thus the test will fail with rtinherit=1
> +_require_no_rtinherit
> +_require_dm_target error
> +
> +rm -f $seqres.full
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_dmerror_init
> +_dmerror_mount
> +
> +
> +# create file
> +testfile=$SCRATCH_MNT/syncfs-reports-errors
> +touch $testfile
> +
> +# write a page of data to file, and call fsync
> +datalen=$(getconf PAGE_SIZE)
> +$XFS_IO_PROG -c "pwrite -W -q 0 $datalen" $testfile
> +
> +# flip device to non-working mode
> +_dmerror_load_error_table
> +
> +# rewrite the data and call fdatasync
> +$XFS_IO_PROG -c "pwrite -w -q 0 $datalen" $testfile
> +
> +# heal the device error
> +_dmerror_load_working_table
> +
> +# open again and call syncfs twice
> +echo "One of the following syncfs calls should fail with EIO:"
> +$XFS_IO_PROG -r -c syncfs -c syncfs $testfile
> +echo "done"
> +
> +echo "This syncfs call should succeed:"
> +$XFS_IO_PROG -r -c syncfs $testfile
> +echo "done"
> +
> +# success, all done
> +_dmerror_cleanup
> +
> +status=0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 000000000000..950a2ba42503
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,8 @@
> +QA output created by 999
> +Format and mount
> +fdatasync: Input/output error
> +One of the following syncfs calls should fail with EIO:
> +syncfs: Input/output error
> +done
> +This syncfs call should succeed:
> +done
> diff --git a/tests/generic/group b/tests/generic/group
> index 718575baeef9..9bcf296fc3dd 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -598,3 +598,4 @@
>  594 auto quick quota
>  595 auto quick encrypt
>  596 auto quick
> +999 auto quick
> -- 
> 2.25.3
> 

