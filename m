Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A6787712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 19:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbjHXR2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 13:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbjHXR2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55E19B5;
        Thu, 24 Aug 2023 10:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4144B65603;
        Thu, 24 Aug 2023 17:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39939C433C7;
        Thu, 24 Aug 2023 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692898108;
        bh=k90Vhmbg9klEt59jrs0hAr0evSAtaEy7iP9eMfbdzE0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ppU+IXxFfGuID0EgKsk4tXtcZYeGojHz7/f/4qk60uU49/CBYo4bfSqHU0fwEPz2f
         1lvTSC10SD8BHg1JdwiHoj6VXYNViRHvDTMLIp1tAzmmutv9nkN2ncsb+k5RydLn4U
         SqPbvD5hNtPyL5t8sidFRwmNzK67V1YGgx0QRdGbHp7gpAbnujr55a6SeioZCNCCiH
         58HR/poweyf8I7rPZXf2QgrBGWyRLrc1l43yj+7qWFJl2SUcfN8BK+Os5cD8fA/dvu
         ABAEvcBbvkGcdZAj6ChxzB3woORDTz+3A1WfDsHQsK6mVdp6ofYWLZyzxxkuueF4ZF
         LbCm/NHBb6f1Q==
Message-ID: <bc2586e3da8719b98126b22c15645a7951b9c1d9.camel@kernel.org>
Subject: Re: [PATCH fstests v2 3/3] generic/578: only run on filesystems
 that support FIEMAP
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 24 Aug 2023 13:28:26 -0400
In-Reply-To: <20230824170931.GC11251@frogsfrogsfrogs>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
         <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
         <20230824170931.GC11251@frogsfrogsfrogs>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-08-24 at 10:09 -0700, Darrick J. Wong wrote:
> On Thu, Aug 24, 2023 at 12:44:19PM -0400, Jeff Layton wrote:
> > Some filesystems (e.g. NFS) don't support FIEMAP. Limit generic/578 to
> > filesystems that do.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  common/rc         | 13 +++++++++++++
> >  tests/generic/578 |  1 +
> >  2 files changed, 14 insertions(+)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 33e74d20c28b..98d27890f6f7 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3885,6 +3885,19 @@ _require_metadata_journaling()
> >  	fi
> >  }
> > =20
> > +_require_fiemap()
> > +{
> > +	local testfile=3D$TEST_DIR/fiemaptest.$$
> > +
> > +	touch $testfile
> > +	$XFS_IO_PROG -r -c "fiemap" $testfile 1>$testfile.out 2>&1
> > +	if grep -q 'Operation not supported' $testfile.out; then
> > +	  _notrun "FIEMAP is not supported by this filesystem"
> > +	fi
> > +
> > +	rm -f $testfile $testfile.out
> > +}
>=20
> _require_xfs_io_command "fiemap" ?
>=20
>=20

Ok, I figured we'd probably do this test after testing for that
separately, but you're correct that we do require it here.

If we add that, should we also do this, at least in all of the general
tests?

    s/_require_xfs_io_command "fiemap"/_require_fiemap/

I think we end up excluding some of those tests on NFS for other
reasons, but other filesystems that don't support fiemap might still try
to run these tests.
=20
> > +
> >  _count_extents()
> >  {
> >  	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
> > diff --git a/tests/generic/578 b/tests/generic/578
> > index b024f6ff90b4..903055b2ca58 100755
> > --- a/tests/generic/578
> > +++ b/tests/generic/578
> > @@ -26,6 +26,7 @@ _require_test_program "mmap-write-concurrent"
> >  _require_command "$FILEFRAG_PROG" filefrag
> >  _require_test_reflink
> >  _require_cp_reflink
> > +_require_fiemap
> > =20
> >  compare() {
> >  	for i in $(seq 1 8); do
> >=20
> > --=20
> > 2.41.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
