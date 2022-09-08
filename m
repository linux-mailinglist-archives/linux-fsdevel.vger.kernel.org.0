Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7293B5B2813
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHVDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIHVDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10CE3D6C;
        Thu,  8 Sep 2022 14:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C496261E14;
        Thu,  8 Sep 2022 21:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90029C433D7;
        Thu,  8 Sep 2022 21:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662670983;
        bh=7YBYgg7/TJrR66/a7iaQ2eaR35nFX2co0CfBFOEQmS0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hwP04eoLTnHQDfB81mv4MOJrK7StjHLWM4e3dwS5s0WkXoWQe63A14lJMkyv1I2QS
         vuEBxbyQWYSOQ8LR+9yIJmbf/5wuudqlYEzCWaKWZNPqsrdEXXz8W9jZ2hBx3kGgCn
         0eAqijJ3CRyKdHApze13EeKXOWLEOFZ2dpXsQWLv0obaeGh9ExXrVJgOfasTmMlRJn
         hgq0jp1xl/3PH0q9Y6Ie6tE2vPYIZ1n4KLvDJ8hGC+fLu2FiGeer8dJvcny41obGuX
         2PXk6eaABVbJO1WVS3ld7PtgxykPSqXTsVlJ03SpwTig+pDFsTe9CwQXX5Zk2SolxJ
         hL08HGAr39dwg==
Message-ID: <2b75d8b1b259f5d8db19edba4b8bbd8111be54f4.camel@kernel.org>
Subject: Re: Does NFS support Linux Capabilities
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        battery dude <jyf007@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Date:   Thu, 08 Sep 2022 17:03:01 -0400
In-Reply-To: <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
         <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-09-08 at 20:24 +0000, Chuck Lever III wrote:
> [ This question comes up on occasion, so I've added a few interested
>   parties to the Cc: list ]
>=20
> > On Sep 8, 2022, at 8:27 AM, battery dude <jyf007@gmail.com> wrote:
> >=20
> > According to https://access.redhat.com/solutions/2117321 this article,
> > I want to ask, how to make NFS support the penetration of Linux
> > Capabilities
>=20
> That link is access-limited, so I was able to view only the top
> few paragraphs of it. Not very open, Red Hat.
>=20
> TL;DR: I looked into this while trying to figure out how to enable
> IMA on NFS files. It's difficult for many reasons.
>=20
>=20
> A few of these reasons include:
>=20
> The NFS protocol is a standard, and is implemented on a wide variety
> of OS platforms. Each OS implements its own flavor of capabilities.
> There's no way to translate amongst the variations to ensure
> interoperation. On Linux, capabilities(7) says:
>=20
> > No standards govern capabilities, but the Linux capability implementati=
on is based on the withdrawn POSIX.1e draft standard; see =E2=9F=A8https://=
archive.org/details/posix_1003.1e-990310=E2=9F=A9.
>=20
> I'm not sure how closely other implementations come to implementing
> POSIX.1e, but there are enough differences that interoperability
> could be a nightmare. Anything Linux has done differently than
> POSIX.1e would be encumbered by GPL, making it nearly impossible to
> standardize those differences. (Let alone the possible problems
> trying to cite a withdrawn POSIX standard in an Internet RFC!)
>=20
> The NFSv4 WG could invent our own capabilities scheme, just as was
> done with NFSv4 ACLs. I'm not sure everyone would agree that effort
> was 100% successful.
>=20
>=20
> Currently, an NFS server bases its access control choices on the
> RPC user that makes each request. We'd have to figure out a way to
> enable NFS clients and servers to communicate more than just user
> identity to enable access control via capabilities.
>=20
> When sending an NFS request, a client would have to provide a set
> of capabilities to the server so the server can make appropriate
> access control choices for that request.
>=20
> The server would have to report the updated capset when a client
> accesses and executes a file with capabilities, and the server
> would have to trust that its clients all respect those capsets
> correctly.
>=20
>=20
> Because capabilities are security-related, setting and retrieving
> capabilities should be done only over networks that ensure
> integrity of communication. So, protection via RPC-with-TLS or
> RPCSEC GSS with an integrity service ought to be a requirement
> both for setting and updating capabilities and for transmitting
> any protected file content. We have implementations, but there
> is always an option of not deploying this kind of protection
> when NFS is actually in use, making capabilities just a bit of
> security theater in those cases.
>=20
>=20
> Given these enormous challenges, who would be willing to pay for
> standardization and implementation? I'm not saying it can't or
> shouldn't be done, just that it would be a mighty heavy lift.
> But maybe other folks on the Cc: list have ideas that could
> make this easier than I believe it to be.
>=20
>=20

I'm not disputing anything you wrote above, and I clearly haven't
thought through the security implications, but I wonder if we could
piggyback this info onto security label support somehow? That already
requires a (semi-opaque) per-inode attribute, which is mostly what's
required for file capabilities.
--=20
Jeff Layton <jlayton@kernel.org>
