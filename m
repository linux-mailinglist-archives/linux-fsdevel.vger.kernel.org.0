Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634657700A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjHDM6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 08:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHDM6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:58:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2D13D;
        Fri,  4 Aug 2023 05:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8012061FDF;
        Fri,  4 Aug 2023 12:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46253C433C8;
        Fri,  4 Aug 2023 12:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691153919;
        bh=FJU2BYATQry473jCPeCpOu9lfHYELvBFzEIys+3I708=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BfL3xD/hQTN+OEA2XaALBGIMQtjxr+xppY+5gosC0+dxWrRWMlW5n24DKRg07PExg
         O6bbMq6tyjok2CmXagNkNZ+GXjejQs5quJRlZqV3naksus+477wBZdHrhariqq8pIV
         Np6P4PQWGln7ckslB83NjJzc2do8oRsS7eJY4oERn113V3It4mSCZA2Js+0V/4/PiC
         rB2QHlRKX7aa+BYkxTyWNLnbcIS4vM43y5S15nciEKsVNF5OKFph1ev/AP/UPjBcnw
         1eVKSu/i6WGr9V6sHBBbrvjPBrSkw9+/cJKDzEpPW5GRN6Yhc/Hg30vroTT6t7/lbU
         Z6Fu5yaS+DTBg==
Message-ID: <d6b4f6b84f8470264702771f00531c47225f0e6b.camel@kernel.org>
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Date:   Fri, 04 Aug 2023 08:58:37 -0400
In-Reply-To: <CAHC9VhSNXbJzfKLF+DjfK+_2eJYYc_AC3u3aUc_NUs_o5M5AaA@mail.gmail.com>
References: <20230802-master-v6-1-45d48299168b@kernel.org>
         <bac543537058619345b363bbfc745927.paul@paul-moore.com>
         <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
         <CAHC9VhTQDVyZewU0Oiy4AfJt_UtB7O2_-PcUmXkZtuwKDQBfXg@mail.gmail.com>
         <ec1fd18f271593d5c6b6813cfaeb688994f20bf4.camel@kernel.org>
         <CAHC9VhSNXbJzfKLF+DjfK+_2eJYYc_AC3u3aUc_NUs_o5M5AaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 2023-08-03 at 22:48 -0400, Paul Moore wrote:
> On Thu, Aug 3, 2023 at 12:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> > On Wed, 2023-08-02 at 22:46 -0400, Paul Moore wrote:
> > > On Wed, Aug 2, 2023 at 3:34=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > > On Wed, 2023-08-02 at 14:16 -0400, Paul Moore wrote:
> > > > > On Aug  2, 2023 Jeff Layton <jlayton@kernel.org> wrote:
>=20
> ...
>=20
> > > My only concern now is the fs_context::lsm_set flag.
> >=20
> > Yeah, that bit is ugly. David studied this problem a lot more than I
> > have, but basically, we only want to set the context info once, and
> > we're not always going to have a nice string to parse to set up the
> > options. This obviously works, but I'm fine with a more elegant method
> > if you can spot one.
>=20
> Like I said before, sometimes making a LSM hook conditional on some
> flag is the only practical solution, but I always worry that there is
> a chance that a future patch might end up toggling that flag by
> accident and we lose an important call into the LSM.  Even if all we
> end up doing is moving the flag down into the LSMs I would be happier;
> there is still a risk, but at least if something breaks it is our (the
> LSM folks) own damn fault ;)
>=20
> > > You didn't mention exactly why the security_sb_set_mnt_opts() was
> > > failing, and requires the fs_context::lsm_set check, but my guess is
> > > that something is tripping over the fact that the superblock is
> > > already properly setup.  I'm working under the assumption that this
> > > problem - attempting to reconfigure a properly configured superblock =
-
> > > should only be happening in the submount/non-NULL-reference case.  If
> > > it is happening elsewhere I think I'm going to need some help
> > > understanding that ...
> >=20
> > Correct. When you pass in the mount options, fc->security seems to be
> > properly set. NFS mounting is complex though, so the final superblock
> > you care about may end up being a descendant of the one that was
> > originally configured.
>=20
> Ooof, okay, there goes that idea.
>=20
> At this point I guess it comes back to that question of why is calling
> into security_sb_set_mnt_opts() a second (or third, etc.) time failing
> for you?  Is there some conflict with the superblock
> config/labeling/etc.?  Is there a permissions problem?  Better
> understanding why that is failing might help us come up with a better
> solution.
>=20

I removed the lsm_set parameter from this patch, and my testcase still
works fine.=C2=A0I can post a v7 if we want to go forward with that. I'm
guessing the complaint he saw was the "out_double_mount" pr_warn.

It looks like as long as the context options match, there shouldn't be
an issue, and I don't see how you'd get mismatched ones if you're
inheriting them.

David, do you remember what prompted you to add the lsm_set parameter?
--=20
Jeff Layton <jlayton@kernel.org>
