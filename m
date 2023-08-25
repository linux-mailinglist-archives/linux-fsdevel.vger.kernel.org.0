Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B9788C4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjHYPSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjHYPSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BDB2121;
        Fri, 25 Aug 2023 08:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70DF65735;
        Fri, 25 Aug 2023 15:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB36C433C7;
        Fri, 25 Aug 2023 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692976697;
        bh=W2SyBBzNb4WShMHKF5hZMRixNovZZVbk+26N0VIDROM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tuxazfwyy4KeZzu2u/mJeRyklXFyPIE/F3DAdVYp+UokoaE5uEaRzQADIR0QWVO25
         Y9UBRjpjgvncgDxtnf5re6VjAyLdIQtUhYBCa3WwcgE0kK4n2z2vontUPBjOm0JPLI
         W2K7mHy809TwsmTL0u9R9pfKF3DVLI0TaV+i8RuLhTqZ2wvwuPUDp1u4ocXHHvcoJd
         OsPH2mww0TsEqHyxRFLhD1DyXG9kyQySD6/8ZQDwNXZTXezYpKXk5h7jY7A+Q9sjH3
         ghM2B9DbN/pzoYsST16a2asF8/tvM7Il8nQd7sejw3JrM/I+hrrrGcCXXk5a5WV/MM
         oHlXNRgZyUvCw==
Date:   Fri, 25 Aug 2023 08:18:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 3/3] generic/578: only run on filesystems that
 support FIEMAP
Message-ID: <20230825151816.GB17895@frogsfrogsfrogs>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
 <20230824170931.GC11251@frogsfrogsfrogs>
 <bc2586e3da8719b98126b22c15645a7951b9c1d9.camel@kernel.org>
 <20230825141651.vd6lh3n4ztru5svl@zlang-mailbox>
 <bf82ceee8ed50e5767c4570e4ff3d02ec56fc3b0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf82ceee8ed50e5767c4570e4ff3d02ec56fc3b0.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:57:20AM -0400, Jeff Layton wrote:
> On Fri, 2023-08-25 at 22:16 +0800, Zorro Lang wrote:
> > On Thu, Aug 24, 2023 at 01:28:26PM -0400, Jeff Layton wrote:
> > > On Thu, 2023-08-24 at 10:09 -0700, Darrick J. Wong wrote:
> > > > On Thu, Aug 24, 2023 at 12:44:19PM -0400, Jeff Layton wrote:
> > > > > Some filesystems (e.g. NFS) don't support FIEMAP. Limit generic/578 to
> > > > > filesystems that do.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  common/rc         | 13 +++++++++++++
> > > > >  tests/generic/578 |  1 +
> > > > >  2 files changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/common/rc b/common/rc
> > > > > index 33e74d20c28b..98d27890f6f7 100644
> > > > > --- a/common/rc
> > > > > +++ b/common/rc
> > > > > @@ -3885,6 +3885,19 @@ _require_metadata_journaling()
> > > > >  	fi
> > > > >  }
> > > > >  
> > > > > +_require_fiemap()
> > > > > +{
> > > > > +	local testfile=$TEST_DIR/fiemaptest.$$
> > > > > +
> > > > > +	touch $testfile
> > > > > +	$XFS_IO_PROG -r -c "fiemap" $testfile 1>$testfile.out 2>&1
> > > > > +	if grep -q 'Operation not supported' $testfile.out; then
> > > > > +	  _notrun "FIEMAP is not supported by this filesystem"
> > > > > +	fi
> > > > > +
> > > > > +	rm -f $testfile $testfile.out
> > > > > +}
> > > > 
> > > > _require_xfs_io_command "fiemap" ?
> > > > 
> > > > 
> > > 
> > > Ok, I figured we'd probably do this test after testing for that
> > > separately, but you're correct that we do require it here.
> > > 
> > > If we add that, should we also do this, at least in all of the general
> > > tests?
> > > 
> > >     s/_require_xfs_io_command "fiemap"/_require_fiemap/
> > > 
> > > I think we end up excluding some of those tests on NFS for other
> > > reasons, but other filesystems that don't support fiemap might still try
> > > to run these tests.
> > 
> > We have lots of cases contains _require_xfs_io_command "fiemap", so I think
> > we can keep this "tradition", don't bring a new _require_fiemap for now,
> > so ...
> > 
> > >  
> > > > > +
> > > > >  _count_extents()
> > > > >  {
> > > > >  	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
> > > > > diff --git a/tests/generic/578 b/tests/generic/578
> > > > > index b024f6ff90b4..903055b2ca58 100755
> > > > > --- a/tests/generic/578
> > > > > +++ b/tests/generic/578
> > > > > @@ -26,6 +26,7 @@ _require_test_program "mmap-write-concurrent"
> > > > >  _require_command "$FILEFRAG_PROG" filefrag
> > > > >  _require_test_reflink
> > > > >  _require_cp_reflink
> > > > > +_require_fiemap
> > 
> > _require_xfs_io_command "fiemap"
> > 
> 
> That's not sufficient -- there is already a call to that in this test.
> 
> _require_xfs_io_command just validates that the xfs_io binary has
> plumbing for that command (which just issues an ioctl to the file).
> Even if the binary has support, the underlying filesystem has to support
> the ioctl.
> 
> Many don't, so we need to test for that specifically.

It /does/ test the kernel support for fiemap...

_require_xfs_io_command()
{
...
	"fiemap")
		# If 'ranged' is passed as argument then we check to see if fiemap supports
		# ranged query params
		if echo "$param" | grep -q "ranged"; then
			param=$(echo "$param" | sed "s/ranged//")
			$XFS_IO_PROG -c "help fiemap" | grep -q "\[offset \[len\]\]"
			[ $? -eq 0 ] || _notrun "xfs_io $command ranged support is missing"
		fi
		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
			-c "fiemap -v $param" $testfile 2>&1`
		param_checked="$param"
		;;

--D

> > > > >  
> > > > >  compare() {
> > > > >  	for i in $(seq 1 8); do
> > > > > 
> > > > > -- 
> > > > > 2.41.0
> > > > > 
> > > 
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
