Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE771B0777
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTLda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTLda (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:33:30 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D10C206D4;
        Mon, 20 Apr 2020 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587382409;
        bh=a4JxLNVo8P5vCvCI7Om1mehKcLGZ7e7TRLza9xWNdoE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pGhBdYubKbyovlT2nxysTjsdDCwQpXt+BVqmZw52jimOFTYmuqVef4g80auy1TM/E
         z/6lTqUE5WNttvW3iysSWugSBmh6kV9LzG9cZ6LtAKO2TEq03792ch3J55+w9JwsL0
         qAD9je7PfKy1u5WwDy0CpjvBXklx3AMC3und6GCU=
Message-ID: <d80c659f7755dadf218ba03f23da277811840475.camel@kernel.org>
Subject: Re: [RFC PATCH xfstests] generic: test reporting of wb errors via
 syncfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 20 Apr 2020 07:33:27 -0400
In-Reply-To: <20200417153620.GA13463@bfoster>
References: <20200414120740.293998-1-jlayton@kernel.org>
         <20200417153620.GA13463@bfoster>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-04-17 at 11:36 -0400, Brian Foster wrote:
> On Tue, Apr 14, 2020 at 08:07:40AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > Add a test for new syncfs error reporting behavior. When an inode fails
> > to be written back, ensure that a subsequent call to syncfs() will also
> > report an error.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  tests/generic/999     | 98 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/999.out |  8 ++++
> >  tests/generic/group   |  1 +
> >  3 files changed, 107 insertions(+)
> >  create mode 100755 tests/generic/999
> >  create mode 100644 tests/generic/999.out
> > 
> > diff --git a/tests/generic/999 b/tests/generic/999
> > new file mode 100755
> > index 000000000000..7383ce24c8fd
> > --- /dev/null
> > +++ b/tests/generic/999
> > @@ -0,0 +1,98 @@
> > +#! /bin/bash
> > +# FS QA Test No. 999
> > +#
> > +# Open a file and write to it and fsync. Then, flip the data device to throw
> > +# errors, write to it again and do an fdatasync. Then open an O_RDONLY fd on
> > +# the same file and call syncfs against it and ensure that an error is reported.
> > +# Then call syncfs again and ensure that no error is reported. Finally, repeat
> > +# the open and syncfs and ensure that there is no error reported.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2020, Jeff Layton <jlayton@kernel.org>
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> 
> I think the big copyright hunk has been replaced with the
> SPDX-License-Identifier thing (see other tests for reference).
> 

Thanks. Will fix.

> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +	_dmerror_cleanup
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmerror
> > +
> > +# real QA test starts here
> > +_supported_os Linux
> > +_require_scratch_nocheck
> > +# This test uses "dm" without taking into account the data could be on
> > +# realtime subvolume, thus the test will fail with rtinherit=1
> > +_require_no_rtinherit
> > +_require_dm_target error
> > +
> > +rm -f $seqres.full
> > +
> > +echo "Format and mount"
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_dmerror_init
> > +_dmerror_mount
> > +
> > +datalen=65536
> > +_require_fs_space $SCRATCH_MNT $datalen
> 
> That seems unnecessary for such a small value. BTW, any reason this
> needs to write more than a page?
> 

No reason for that size. I think I just copied that from generic/487
since I started with that one as a template. I'll cut it down to a page.

Should I not bother calling _require_fs_space here since it's so small?
I wasn't sure how strict that was...

> > +
> > +# use fd 5 to hold file open
> > +testfile=$SCRATCH_MNT/syncfs-reports-errors
> > +exec 5>$testfile
> > +
> 
> Also what's the reason for holding an fd on the test file like this?
> Does this affect error reporting behavior in some way? Otherwise the
> rest looks reasonable to me.
> 

Again, copied from 487. It's not necessary for this test. I'll switch
that to just "touch testfile" at the start and get rid of the follow-on
close.

Thanks for the review!
-- 
Jeff Layton <jlayton@kernel.org>

