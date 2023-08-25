Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D87788BFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbjHYO56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 10:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjHYO5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A092126;
        Fri, 25 Aug 2023 07:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B258462739;
        Fri, 25 Aug 2023 14:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927F0C433C7;
        Fri, 25 Aug 2023 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692975442;
        bh=+01OO+0jE/YMjZSiYN1+J14LZayZN64ZuR+r+Lsr2MM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MmB7wd2C8aJh1pNxoStC3DkNDDVN4pC1WW6x9H9CNA4e+LmUTn/CWis2EgekHu2Ob
         JnwyJQ29+GddG8Tln11PTZB1QZzQegzljVArCy4OGjlYDikrsXLIbplNutYtqD49fc
         sy5gsGcqL0ta4FnG3glpI94+wh9GRjd5tvdpKMBVNNv5x55z+qTVW09Jyq4dhRdnuR
         TtuHFfUYT57oFV72u+bfaqGnaiCwfqGLfNsx9QUr3JkpzgMjGTPo/5l5q/YLio97Hz
         HfweD1skmLK3/IodUfMgqY7MbnEhmi4VptSY5nB1zV8ZCTpa1u8zMUWhL28K3Ww9d2
         qGppIGJ/FocxQ==
Message-ID: <bf82ceee8ed50e5767c4570e4ff3d02ec56fc3b0.camel@kernel.org>
Subject: Re: [PATCH fstests v2 3/3] generic/578: only run on filesystems
 that support FIEMAP
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 25 Aug 2023 10:57:20 -0400
In-Reply-To: <20230825141651.vd6lh3n4ztru5svl@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
         <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
         <20230824170931.GC11251@frogsfrogsfrogs>
         <bc2586e3da8719b98126b22c15645a7951b9c1d9.camel@kernel.org>
         <20230825141651.vd6lh3n4ztru5svl@zlang-mailbox>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-08-25 at 22:16 +0800, Zorro Lang wrote:
> On Thu, Aug 24, 2023 at 01:28:26PM -0400, Jeff Layton wrote:
> > On Thu, 2023-08-24 at 10:09 -0700, Darrick J. Wong wrote:
> > > On Thu, Aug 24, 2023 at 12:44:19PM -0400, Jeff Layton wrote:
> > > > Some filesystems (e.g. NFS) don't support FIEMAP. Limit generic/578=
 to
> > > > filesystems that do.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  common/rc         | 13 +++++++++++++
> > > >  tests/generic/578 |  1 +
> > > >  2 files changed, 14 insertions(+)
> > > >=20
> > > > diff --git a/common/rc b/common/rc
> > > > index 33e74d20c28b..98d27890f6f7 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -3885,6 +3885,19 @@ _require_metadata_journaling()
> > > >  	fi
> > > >  }
> > > > =20
> > > > +_require_fiemap()
> > > > +{
> > > > +	local testfile=3D$TEST_DIR/fiemaptest.$$
> > > > +
> > > > +	touch $testfile
> > > > +	$XFS_IO_PROG -r -c "fiemap" $testfile 1>$testfile.out 2>&1
> > > > +	if grep -q 'Operation not supported' $testfile.out; then
> > > > +	  _notrun "FIEMAP is not supported by this filesystem"
> > > > +	fi
> > > > +
> > > > +	rm -f $testfile $testfile.out
> > > > +}
> > >=20
> > > _require_xfs_io_command "fiemap" ?
> > >=20
> > >=20
> >=20
> > Ok, I figured we'd probably do this test after testing for that
> > separately, but you're correct that we do require it here.
> >=20
> > If we add that, should we also do this, at least in all of the general
> > tests?
> >=20
> >     s/_require_xfs_io_command "fiemap"/_require_fiemap/
> >=20
> > I think we end up excluding some of those tests on NFS for other
> > reasons, but other filesystems that don't support fiemap might still tr=
y
> > to run these tests.
>=20
> We have lots of cases contains _require_xfs_io_command "fiemap", so I thi=
nk
> we can keep this "tradition", don't bring a new _require_fiemap for now,
> so ...
>=20
> > =20
> > > > +
> > > >  _count_extents()
> > > >  {
> > > >  	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -=
l
> > > > diff --git a/tests/generic/578 b/tests/generic/578
> > > > index b024f6ff90b4..903055b2ca58 100755
> > > > --- a/tests/generic/578
> > > > +++ b/tests/generic/578
> > > > @@ -26,6 +26,7 @@ _require_test_program "mmap-write-concurrent"
> > > >  _require_command "$FILEFRAG_PROG" filefrag
> > > >  _require_test_reflink
> > > >  _require_cp_reflink
> > > > +_require_fiemap
>=20
> _require_xfs_io_command "fiemap"
>=20

That's not sufficient -- there is already a call to that in this test.

_require_xfs_io_command just validates that the xfs_io binary has
plumbing for that command (which just issues an ioctl to the file).
Even if the binary has support, the underlying filesystem has to support
the ioctl.

Many don't, so we need to test for that specifically.

> > > > =20
> > > >  compare() {
> > > >  	for i in $(seq 1 8); do
> > > >=20
> > > > --=20
> > > > 2.41.0
> > > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
