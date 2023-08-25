Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95595788C12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbjHYPCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbjHYPCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55719B7;
        Fri, 25 Aug 2023 08:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8CCD61721;
        Fri, 25 Aug 2023 15:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00A1C433C8;
        Fri, 25 Aug 2023 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692975762;
        bh=LfIBUF2aFFltp+AZiO5guJcOjlwV4HWv3FGVSP0shkA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b3lipLvgIxasKcjhxWDlkpHazTyubKaTKHiwkunHZmKpWZfwAJ0y1SRTHembQbkgo
         ShBqfzlb+1nBFbDfmFRBb5a/3zoFX13LmvZVnPci60BUBftQHhYToER7In5FII3ozV
         xg8vQITYxrNRGHtjGcSLFTee4oPAUx1l/pjmgqDNjrlMPP1zLD/cHG+WAr5R9hv9YZ
         5HDpPJ1KFQmsncaguF5s68CMGHMKz6OBjvXDwe2GbrYGbtPEzrjAqEyQBRclIpfyer
         Cubce3ta/Lsk41h6Ea5uNS4/xcMrSoQQJ63124P2lm4Iw3lbe7VcyIKHIvpf45y7jN
         I3R2kfKCZy6Tw==
Message-ID: <a93ba004a46177c213159878a51c7378536f33ad.camel@kernel.org>
Subject: Re: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 25 Aug 2023 11:02:40 -0400
In-Reply-To: <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
         <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
         <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
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

On Fri, 2023-08-25 at 22:11 +0800, Zorro Lang wrote:
> On Thu, Aug 24, 2023 at 12:44:18PM -0400, Jeff Layton wrote:
> > This test requires being able to set file capabilities which some
> > filesystems (namely NFS) do not support. Add a _require_setcap test
> > and only run it on filesystems that pass it.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  common/rc         | 13 +++++++++++++
> >  tests/generic/513 |  1 +
> >  2 files changed, 14 insertions(+)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 5c4429ed0425..33e74d20c28b 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5048,6 +5048,19 @@ _require_mknod()
> >  	rm -f $TEST_DIR/$seq.null
> >  }
> > =20
> > +_require_setcap()
> > +{
> > +	local testfile=3D$TEST_DIR/setcaptest.$$
> > +
> > +	touch $testfile
> > +	$SETCAP_PROG "cap_sys_module=3Dp" $testfile > $testfile.out 2>&1
>=20
> Actually we talked about the capabilities checking helper last year, as b=
elow:
>=20
> https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mai=
lbox/
>=20
> As you bring this discussion back, how about the _require_capabilities() =
in
> above link?
>=20

I was testing a similar patch, but your version looks better. Should I
drop mine and you re-post yours?

Thanks,
--
Jeff Layton <jlayton@kernel.org>
