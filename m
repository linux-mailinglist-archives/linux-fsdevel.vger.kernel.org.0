Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59166DA590
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 00:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjDFWJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDFWJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281A6AD08;
        Thu,  6 Apr 2023 15:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83D164D1C;
        Thu,  6 Apr 2023 22:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19933C433EF;
        Thu,  6 Apr 2023 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680818984;
        bh=f6T3+3vB3sTjnYSO7cmbQKukN5XfIZL65zfaUJiyItU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E6qHZurMXgW2VHXj9AYvfdOetAE9Em9DXIPUf26jCUItONWc87JAnObvq2caRHqaE
         TtBDK/Ym9URix52bbJq0TUWyC30FShRY6M/17WwuRFcO4RM8Q4wtyaQaSgjILDSkdb
         G0QTPZBJDkCMngkmt8PhEjW3rhEb2fIUQTccfD3L5ERBn87fKkgprcAMDTHnb25O/E
         xbyHr9zXyDflzHfH24MHxQtF4NCkA3eSOLbZC8FeuyDuLaxV1ijEMnQWY8pbkHP/7X
         Xyl1KjYsUs68u8uJ+gR5NTpHXWPomxEkvkKJ7Yy4xfUHopHx4ZuNEJcxRkBaHh+ZQk
         zp1CtdJipU/EA==
Message-ID: <d363403595c79cc735e4c930e2bc08c7f9796aac.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Date:   Thu, 06 Apr 2023 18:09:41 -0400
In-Reply-To: <b7e3b342-9b88-7698-9e9d-f81a6f79c395@linux.ibm.com>
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
         <20230406-diffamieren-langhaarig-87511897e77d@brauner>
         <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
         <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
         <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
         <20230406-wasser-zwanzig-791bc0bf416c@brauner>
         <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
         <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
         <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
         <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
         <4f739cc6847975991874d56ef9b9716c82cf62a3.camel@kernel.org>
         <b7e3b342-9b88-7698-9e9d-f81a6f79c395@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-06 at 17:58 -0400, Stefan Berger wrote:
>=20
> On 4/6/23 17:24, Jeff Layton wrote:
> > On Thu, 2023-04-06 at 16:22 -0400, Stefan Berger wrote:
> > >=20
> > > On 4/6/23 15:37, Jeff Layton wrote:
> > > > On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
> > > > >=20
> > > > > On 4/6/23 14:46, Jeff Layton wrote:
> > > > > > On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> > > > > > > On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> > > > >=20
> > > > > >=20
> > > > > > Correct. As long as IMA is also measuring the upper inode then =
it seems
> > > > > > like you shouldn't need to do anything special here.
> > > > >=20
> > > > > Unfortunately IMA does not notice the changes. With the patch pro=
vided in the other email IMA works as expected.
> > > > >=20
> > > >=20
> > > >=20
> > > > It looks like remeasurement is usually done in ima_check_last_write=
r.
> > > > That gets called from __fput which is called when we're releasing t=
he
> > > > last reference to the struct file.
> > > >=20
> > > > You've hooked into the ->release op, which gets called whenever
> > > > filp_close is called, which happens when we're disassociating the f=
ile
> > > > from the file descriptor table.
> > > >=20
> > > > So...I don't get it. Is ima_file_free not getting called on your fi=
le
> > > > for some reason when you go to close it? It seems like that should =
be
> > > > handling this.
> > >=20
> > > I would ditch the original proposal in favor of this 2-line patch sho=
wn here:
> > >=20
> > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde=
3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > >=20
> > >=20
> >=20
> > Ok, I think I get it. IMA is trying to use the i_version from the
> > overlayfs inode.
> >=20
> > I suspect that the real problem here is that IMA is just doing a bare
> > inode_query_iversion. Really, we ought to make IMA call
> > vfs_getattr_nosec (or something like it) to query the getattr routine i=
n
> > the upper layer. Then overlayfs could just propagate the results from
> > the upper layer in its response.
>=20
> You mean compare known stat against current ? It seems more expensive to =
stat the file
> rather than using the simple i_version-has-changed indicator.
>=20

getattr is fairly cheap on a local filesystem. It's more expensive with
something networked, but that's the price of correctness.

> > That sort of design may also eventually help IMA work properly with mor=
e
> > exotic filesystems, like NFS or Ceph.
>=20
> And these don't support i_version at all?

They absolutely do. Their change attributes are mediated by the server,
so they can't use the kernel's mechanism for IS_I_VERSION inodes. They
can report that field in their ->getattr routines however.

--=20
Jeff Layton <jlayton@kernel.org>
