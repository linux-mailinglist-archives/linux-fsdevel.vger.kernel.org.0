Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC75789F9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 15:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjH0NoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjH0Nny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C6A114;
        Sun, 27 Aug 2023 06:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 306D260F5A;
        Sun, 27 Aug 2023 13:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE95C433C7;
        Sun, 27 Aug 2023 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693143823;
        bh=N7dwalO8sQOllbcE2k4YY0uHjbX6j+vxVbEe57lcNUk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tV+x8AEutUASTPuxrs5LPyR1wjrAwc5NgtqV0ff7sI08gYkpCgkW5h/B0CtN4jAtY
         +baY3/2mcdOfRpKbZvlXD1FrlvJi2I4A3688EN9GItPBPzuJkS1YRPR4Pd9FrdZhhj
         zCFAoSs1ZO0jZig/9eCcop05QhmF9LNSWjTuhCnYY1ZO9rP6LLxXvB9iz8XnyK/gze
         O0PSuif2p6KGpem3V1I0n+9KY3jNtJTRxJzgyXyuRRHK3O/LeMr0/0Pyw3+dKcKcX1
         rcfUpnSjVib1Eq6Hm3u1y1ODdpSh8VaKXDHRx5Y8/tAKUs5foJ19l+kQ3nrkFLjX35
         g8xSXRTMD4fJg==
Message-ID: <45e9152ccb8afdced1c1f6887368fec59804c6d9.camel@kernel.org>
Subject: Re: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Sun, 27 Aug 2023 09:43:41 -0400
In-Reply-To: <20230827124512.23qnfe3keedrf4a2@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
         <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
         <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
         <a93ba004a46177c213159878a51c7378536f33ad.camel@kernel.org>
         <20230827124512.23qnfe3keedrf4a2@zlang-mailbox>
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

On Sun, 2023-08-27 at 20:45 +0800, Zorro Lang wrote:
> On Fri, Aug 25, 2023 at 11:02:40AM -0400, Jeff Layton wrote:
> > On Fri, 2023-08-25 at 22:11 +0800, Zorro Lang wrote:
> > > On Thu, Aug 24, 2023 at 12:44:18PM -0400, Jeff Layton wrote:
> > > > This test requires being able to set file capabilities which some
> > > > filesystems (namely NFS) do not support. Add a _require_setcap test
> > > > and only run it on filesystems that pass it.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  common/rc         | 13 +++++++++++++
> > > >  tests/generic/513 |  1 +
> > > >  2 files changed, 14 insertions(+)
> > > >=20
> > > > diff --git a/common/rc b/common/rc
> > > > index 5c4429ed0425..33e74d20c28b 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -5048,6 +5048,19 @@ _require_mknod()
> > > >  	rm -f $TEST_DIR/$seq.null
> > > >  }
> > > > =20
> > > > +_require_setcap()
> > > > +{
> > > > +	local testfile=3D$TEST_DIR/setcaptest.$$
> > > > +
> > > > +	touch $testfile
> > > > +	$SETCAP_PROG "cap_sys_module=3Dp" $testfile > $testfile.out 2>&1
> > >=20
> > > Actually we talked about the capabilities checking helper last year, =
as below:
> > >=20
> > > https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang=
-mailbox/
> > >=20
> > > As you bring this discussion back, how about the _require_capabilitie=
s() in
> > > above link?
> > >=20
> >=20
> > I was testing a similar patch, but your version looks better. Should I
> > drop mine and you re-post yours?
>=20
> Actually we decided to use `_require_attrs security`, rather than a new
> _require_capabilities() helper. We need a chance/requirement to add
> that helper (when a test case really need it).
>=20
> So I hope know is `_require_attrs security` enough for you? Or you really
> need a specific _require_capabilities helper?
>=20
> Thanks,
> Zorro
>=20
>=20


Yeah, it looks like that should work:

    generic/513       [not run] attr namespace security not supported by th=
is filesystem type: nfs

I'll plan to respin this patch to add that instead.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
