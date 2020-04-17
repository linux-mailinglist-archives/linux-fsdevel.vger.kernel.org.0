Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9F11AE148
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgDQPga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 11:36:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30383 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728956AbgDQPg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587137788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpksWbiojdZSM0Gv0EflxBWmKvTa5qwFS7JjyNC++FM=;
        b=d8iXAVI6ObvjJ9pA7ylfK+QgN3eqoJRbePXBw5Fp2SrCPBLZVZtcE64O+ifc/2OjDB/FKn
        gow96nopHVFVkS+2jbR/QnyRrWitbGXOae2uR42OdFp6s/7WilYPY9DLiN8CAcMLJHF+NM
        WRvpPU5YaaIzWIjqOBqG41Bh6pIuJIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-jRLvVksrMd2Ce80VipDGbA-1; Fri, 17 Apr 2020 11:36:24 -0400
X-MC-Unique: jRLvVksrMd2Ce80VipDGbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2475F107ACC4;
        Fri, 17 Apr 2020 15:36:23 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91848118F4A;
        Fri, 17 Apr 2020 15:36:22 +0000 (UTC)
Date:   Fri, 17 Apr 2020 11:36:20 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH xfstests] generic: test reporting of wb errors via
 syncfs
Message-ID: <20200417153620.GA13463@bfoster>
References: <20200414120740.293998-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414120740.293998-1-jlayton@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:07:40AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> Add a test for new syncfs error reporting behavior. When an inode fails
> to be written back, ensure that a subsequent call to syncfs() will also
> report an error.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/999     | 98 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  8 ++++
>  tests/generic/group   |  1 +
>  3 files changed, 107 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 000000000000..7383ce24c8fd
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,98 @@
> +#! /bin/bash
> +# FS QA Test No. 999
> +#
> +# Open a file and write to it and fsync. Then, flip the data device to throw
> +# errors, write to it again and do an fdatasync. Then open an O_RDONLY fd on
> +# the same file and call syncfs against it and ensure that an error is reported.
> +# Then call syncfs again and ensure that no error is reported. Finally, repeat
> +# the open and syncfs and ensure that there is no error reported.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2020, Jeff Layton <jlayton@kernel.org>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------

I think the big copyright hunk has been replaced with the
SPDX-License-Identifier thing (see other tests for reference).

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
> +datalen=65536
> +_require_fs_space $SCRATCH_MNT $datalen

That seems unnecessary for such a small value. BTW, any reason this
needs to write more than a page?

> +
> +# use fd 5 to hold file open
> +testfile=$SCRATCH_MNT/syncfs-reports-errors
> +exec 5>$testfile
> +

Also what's the reason for holding an fd on the test file like this?
Does this affect error reporting behavior in some way? Otherwise the
rest looks reasonable to me.

Brian

> +# write some data to file and fsync it out
> +$XFS_IO_PROG -c "pwrite -W -q 0 $datalen" $testfile
> +
> +# flip device to non-working mode
> +_dmerror_load_error_table
> +
> +# rewrite the data, and do fdatasync
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
> +# close file
> +exec 5>&-
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
> index 99d06c9ad945..028cdbd0d52b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -598,3 +598,4 @@
>  594 auto quick quota
>  595 auto quick encrypt
>  596 auto quick
> +999 auto quick
> -- 
> 2.25.2
> 

