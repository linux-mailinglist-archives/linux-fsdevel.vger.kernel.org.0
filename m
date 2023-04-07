Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B466DAD9F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbjDGNbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbjDGNbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1CAF15;
        Fri,  7 Apr 2023 06:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C08164C35;
        Fri,  7 Apr 2023 13:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB5C433EF;
        Fri,  7 Apr 2023 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680874172;
        bh=4fZ5vntQ/4/IuDVoBsJvMKJ19n4BQOxP6Cy308sJ/DE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I/zq6k3P5nn52mhmhbzjcSMiXW9bl9DnNsKvNvuzvQDw951D+EWmav2b9kVlG9PJk
         VYAUKQF43anEnBAgb0f3hD1g1AASkQwMABcopx3JbX2VszYIFpTpFKkGLAN7MwZcq4
         87/e09TZUosHESlvMKma8pftyvqpeS6+Eyw3SY/bUEDFGtvBjpQDU3qDldYwNBRYY9
         Li2s8xSBD3mWFOnxkzYu3kxjJdxxPDpM1eAOUbYcbldDDxrZPeFlE/bVDaehRDEdht
         r6NHGiWn9k9Kd/HrMgS2Q5SXhidZrjRByrHcsC1dRwCtJTVnAEkCPtyNhgzT9D8h/w
         C7mSjYNpMP48A==
Message-ID: <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Fri, 07 Apr 2023 09:29:29 -0400
In-Reply-To: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > >=20
> > > > I would ditch the original proposal in favor of this 2-line patch s=
hown here:
> > > >=20
> > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecb=
de3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
>=20
> We should cool it with the quick hacks to fix things. :)
>=20

Yeah. It might fix this specific testcase, but I think the way it uses
the i_version is "gameable" in other situations. Then again, I don't
know a lot about IMA in this regard.

When is it expected to remeasure? If it's only expected to remeasure on
a close(), then that's one thing. That would be a weird design though.

> > > >=20
> > > >=20
> > >=20
> > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > overlayfs inode.
> > >=20
> > > I suspect that the real problem here is that IMA is just doing a bare
> > > inode_query_iversion. Really, we ought to make IMA call
> > > vfs_getattr_nosec (or something like it) to query the getattr routine=
 in
> > > the upper layer. Then overlayfs could just propagate the results from
> > > the upper layer in its response.
> > >=20
> > > That sort of design may also eventually help IMA work properly with m=
ore
> > > exotic filesystems, like NFS or Ceph.
> > >=20
> > >=20
> > >=20
> >=20
> > Maybe something like this? It builds for me but I haven't tested it. It
> > looks like overlayfs already should report the upper layer's i_version
> > in getattr, though I haven't tested that either:
> >=20
> > -----------------------8<---------------------------
> >=20
> > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> >=20
> > IMA currently accesses the i_version out of the inode directly when it
> > does a measurement. This is fine for most simple filesystems, but can b=
e
> > problematic with more complex setups (e.g. overlayfs).
> >=20
> > Make IMA instead call vfs_getattr_nosec to get this info. This allows
> > the filesystem to determine whether and how to report the i_version, an=
d
> > should allow IMA to work properly with a broader class of filesystems i=
n
> > the future.
> >=20
> > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
>=20
> So, I think we want both; we want the ovl_copyattr() and the
> vfs_getattr_nosec() change:
>=20
> (1) overlayfs should copy up the inode version in ovl_copyattr(). That
>     is in line what we do with all other inode attributes. IOW, the
>     overlayfs inode's i_version counter should aim to mirror the
>     relevant layer's i_version counter. I wouldn't know why that
>     shouldn't be the case. Asking the other way around there doesn't
>     seem to be any use for overlayfs inodes to have an i_version that
>     isn't just mirroring the relevant layer's i_version.

It's less than ideal to do this IMO, particularly with an IS_I_VERSION
inode.

You can't just copy=A0up the value from the upper. You'll need to call
inode_query_iversion(upper_inode), which will flag the upper inode for a
logged i_version update on the next write. IOW, this could create some
(probably minor) metadata write amplification in the upper layer inode
with IS_I_VERSION inodes.


> (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
>     Currently, ima assumes that it will get the correct i_version from
>     an inode but that just doesn't hold for stacking filesystem.
>=20
> While (1) would likely just fix the immediate bug (2) is correct and
> _robust_. If we change how attributes are handled vfs_*() helpers will
> get updated and ima with it. Poking at raw inodes without using
> appropriate helpers is much more likely to get ima into trouble.

This will fix it the right way, I think (assuming it actually works),
and should open the door for IMA to work properly with networked
filesystems that support i_version as well.

Note that there Stephen is correct that calling getattr is probably
going to be less efficient here since we're going to end up calling
generic_fillattr unnecessarily, but I still think it's the right thing
to do.

If it turns out to cause measurable performance regressions though,
maybe we can look at adding a something that still calls ->getattr if it
exists but only returns the change_cookie value.
--=20
Jeff Layton <jlayton@kernel.org>
