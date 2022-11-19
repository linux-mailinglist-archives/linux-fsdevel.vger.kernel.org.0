Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C785630E92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 12:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKSLz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 06:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKSLzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:55:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C943B92B64;
        Sat, 19 Nov 2022 03:55:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64462B80A0A;
        Sat, 19 Nov 2022 11:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7ACC433D6;
        Sat, 19 Nov 2022 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668858919;
        bh=TU744jj+Gxt8pU/CpHqgWTocl5qK4YLgy4i9zIMlaSY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cBFL3r3AnN/fmAFkOJ0dsTpV28uHjCGQLSG0z0cDFdyyfREBvE508XNbwdFeskWcv
         IzHtNAJDZ0xk/dWTkQb7S7+jr6T/b0+kv6u1lQ7oC7SaCEm+WcCVCeIHUBCvxrXFkl
         zMDfJ46MjBe8DxqN1a+NsAsyEFz31FGaP18cCYrfIRCizPg76F2dJ+2tBOyuK6j2ST
         XCnPy+LQf+IwCtRX/QVizl0bKFvopMxTFfRnCOn/eGUXFuT7KpT4nLeOsO/dmvRaw8
         V8XwYrEsrxZbWvVutGVDEx6gfxK/nVaG81xwXrNczyOJxmq2agqZaoErkgRr8mxbwq
         IU3kE0aEaAwCw==
Message-ID: <28450a6a42b6004ecf3bc82844b1e716a6a18cd4.camel@kernel.org>
Subject: Re: [PATCH] Add process name to locks warning
From:   Jeff Layton <jlayton@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 19 Nov 2022 06:55:17 -0500
In-Reply-To: <9a521db6342b977805d7161406f86d44fea7ba55.camel@kernel.org>
References: <20221118234357.243926-1-ak@linux.intel.com>
         <9a521db6342b977805d7161406f86d44fea7ba55.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-18 at 21:06 -0500, Jeff Layton wrote:
> On Fri, 2022-11-18 at 15:43 -0800, Andi Kleen wrote:
> > It's fairly useless to complain about using an obsolete feature without
> > telling the user which process used it. My Fedora desktop randomly drop=
s
> > this message, but I would really need this patch to figure out what
> > triggers is.
> >=20
>=20
> Interesting. The only program I know of that tried to use these was
> samba, but we patched that out a few years ago (about the time this
> patch went in). Are you running an older version of samba?
>=20
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  fs/locks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 607f94a0e789..2e45232dbeb1 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2096,7 +2096,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned=
 int, cmd)
> >  	 * throw a warning to let people know that they don't actually work.
> >  	 */
> >  	if (cmd & LOCK_MAND) {
> > -		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This sup=
port has been removed and the request ignored.\n");
> > +		pr_warn_once("%s: Attempt to set a LOCK_MAND lock via flock(2). This=
 support has been removed and the request ignored.\n", current->comm);
> >  		return 0;
> >  	}
> > =20
>=20
> Looks reasonable. Would it help to print the pid or tgid as well?=20

Merged into my locks-next branch, along with a small change to print
current->pid in addition to current->comm. This should make v6.2.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
