Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD47870FC06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjEXQzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjEXQzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 12:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF7123;
        Wed, 24 May 2023 09:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD3963F57;
        Wed, 24 May 2023 16:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5178FC433EF;
        Wed, 24 May 2023 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684947343;
        bh=sGxhTK9X0YjqTCyycyn24FalMzlbamwdb0oSsXWIbqA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NA8pjEs+Q/z/3/JXcw+JZ2UuvO54Ux+k4fI8a8Sfh3dGZmgAAP4xFNsVjL9F01Lu0
         plgazzcantSpxOvUZTODWad5/L530OIPbDrB+vlk71GjNQ5Hv1pA8mI2k1FiP2WA/d
         yKeZAhBW+AMR1qommnNTfQNoHrDSeDOMmKE/zHu6zhAidWLplOSFsX9gTIeQzzOKMm
         fnm7jynnYoxcvyeIx/rVrs28+txYho1gdvkmSIJJxNR+WuHL0l2OTwThmzQOLwu+Bi
         htF2iYZVYJ155oXgr1AwwashhfRQw46mjhQW98mbzKo72FRD19nLTNWl5dh86dyElN
         5LHNxh5KgZG8w==
Message-ID: <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Wed, 24 May 2023 12:55:41 -0400
In-Reply-To: <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
         <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
         <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
         <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
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

On Wed, 2023-05-24 at 15:09 +0000, Chuck Lever III wrote:
>=20
> > On May 24, 2023, at 11:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
> > > Remove the check for F_WRLCK in generic_add_lease to allow file_lock
> > > to be used for write delegation.
> > >=20
> > > First consumer is NFSD.
> > >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > > fs/locks.c | 7 -------
> > > 1 file changed, 7 deletions(-)
> > >=20
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index df8b26a42524..08fb0b4fd4f8 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg,=
 struct file_lock **flp, void **pr
> > > if (is_deleg && !inode_trylock(inode))
> > > return -EAGAIN;
> > >=20
> > > - if (is_deleg && arg =3D=3D F_WRLCK) {
> > > - /* Write delegations are not currently supported: */
> > > - inode_unlock(inode);
> > > - WARN_ON_ONCE(1);
> > > - return -EINVAL;
> > > - }
> > > -
> > > percpu_down_read(&file_rwsem);
> > > spin_lock(&ctx->flc_lock);
> > > time_out_leases(inode, &dispose);
> >=20
> > I'd probably move this back to the first patch in the series.
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> I asked him to move it to the end. Is it safe to take out this
> check before write delegation is actually implemented?
>=20

I think so, but it don't think it doesn't make much difference either
way. The only real downside of putting it at the end is that you might
have to contend with a WARN_ON_ONCE if you're bisecting.
--=20
Jeff Layton <jlayton@kernel.org>
