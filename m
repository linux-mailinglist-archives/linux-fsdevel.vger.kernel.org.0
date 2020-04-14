Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865071A7AA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440081AbgDNMZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 08:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440076AbgDNMZN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:25:13 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7B920732;
        Tue, 14 Apr 2020 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586867112;
        bh=DLC4zgaNQ14RfITykXG9gxVio2ZQiChHVfTCrp8ZAC0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cTpx5q7M+3Viyyki6a8/O3QT57wAhELIOZANquHPs6Vm0wfPMo1j5fuwHTL47n8xF
         /EVDF1u8v10FuvHp4Tk9pdWwlK4wjpIBKhGn3F3cakgz9XUwHvanM0Q2MMeY8Otb+8
         JmjBblQKIjDoBVik7gXaKEGH79T4WlGtdbS58XGs=
Message-ID: <3d570fae484a944b2ce61db7669bd2cd15c92678.camel@kernel.org>
Subject: Re: [RFC PATCH xfstests] generic: test reporting of wb errors via
 syncfs
From:   Jeff Layton <jlayton@kernel.org>
To:     guaneryu@gmail.com
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 14 Apr 2020 08:25:11 -0400
In-Reply-To: <20200414120740.293998-1-jlayton@kernel.org>
References: <20200414120740.293998-1-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-04-14 at 08:07 -0400, Jeff Layton wrote:
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

I should note that I sent this as an RFC as it will fail until this
series is merged:

    Subject: [PATCH v4 RESEND 0/2] vfs: have syncfs() return error when there are writeback errors

...which I've just recently re-posted to linux-fsdevel, et. al.

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
> +
> +# use fd 5 to hold file open
> +testfile=$SCRATCH_MNT/syncfs-reports-errors
> +exec 5>$testfile
> +
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

-- 
Jeff Layton <jlayton@kernel.org>

