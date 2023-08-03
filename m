Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225B76EF5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjHCQ1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjHCQ1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:27:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5F30D3;
        Thu,  3 Aug 2023 09:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC7861E31;
        Thu,  3 Aug 2023 16:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95019C433C7;
        Thu,  3 Aug 2023 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080049;
        bh=R9CF2H7mbl0cgRXO+z4tXwwMfit3swiAWcNJEtpzi1Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cItRdHU8ppyTRYkjux/OaZteYYB46EBf6G8e/iMfeXgRUR8ZGlWDDbC9jCWrex8dX
         q88xudYsQ4coAFRhO/Uiq2Ste3axYkcId1WfMhh85ioLEjq87RsPVLZA7ILU7ZNhqo
         Q6Bnh2fcTMyiCEKX2IIx57hQKViodinp4xPXgG3N2VTtsTuN+/8NMPeMMk46zyu39k
         ezVItsWlD5GsUOD0jo7fUYoAlA4HQLTE5IDnmAIZhCLk9ZO6zcgWXlshnO3FupfZM4
         6cpWec+RvB0hGaMmVB7kUVVEH1ikferq79RA2TN0sxqoUy0yYw/op2RMMdNpTgVKlG
         Ot0/BUJr2U50Q==
Message-ID: <ec1fd18f271593d5c6b6813cfaeb688994f20bf4.camel@kernel.org>
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
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
Date:   Thu, 03 Aug 2023 12:27:26 -0400
In-Reply-To: <CAHC9VhTQDVyZewU0Oiy4AfJt_UtB7O2_-PcUmXkZtuwKDQBfXg@mail.gmail.com>
References: <20230802-master-v6-1-45d48299168b@kernel.org>
         <bac543537058619345b363bbfc745927.paul@paul-moore.com>
         <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
         <CAHC9VhTQDVyZewU0Oiy4AfJt_UtB7O2_-PcUmXkZtuwKDQBfXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-02 at 22:46 -0400, Paul Moore wrote:
> On Wed, Aug 2, 2023 at 3:34=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> > On Wed, 2023-08-02 at 14:16 -0400, Paul Moore wrote:
> > > On Aug  2, 2023 Jeff Layton <jlayton@kernel.org> wrote:
>=20
> ...
>=20
> > > I generally dislike core kernel code which makes LSM calls conditiona=
l
> > > on some kernel state maintained outside the LSM.  Sometimes it has to
> > > be done as there is no other good options, but I would like us to try
> > > and avoid it if possible.  The commit description mentioned that this
> > > was put here to avoid a SELinux complaint, can you provide an example
> > > of the complain?  Does it complain about a double/invalid mount, e.g.
> > > "SELinux: mount invalid.  Same superblock, different security ..."?
> >=20
> > The problem I had was not so much SELinux warnings, but rather that in =
a
> > situation where I would expect to share superblocks between two
> > filesystems, it didn't.
> >=20
> > Basically if you do something like this:
> >=20
> > # mount nfsserver:/export/foo /mnt/foo -o context=3Dsystem_u:object_r:r=
oot_t:s0
> > # mount nfsserver:/export/bar /mnt/bar -o context=3Dsystem_u:object_r:r=
oot_t:s0
> >=20
> > ...when "foo" and "bar" are directories on the same filesystem on the
> > server, you should get two vfsmounts that share a superblock. That's
> > what you get if selinux is disabled, but not when it's enabled (even
> > when it's in permissive mode).
>=20
> Thanks, that helps.  I'm guessing the difference in behavior is due to
> the old->has_sec_mnt_opts check in nfs_compare_super().
>=20

Yep. That gets set, but fc->security is still NULL.

> > > I'd like to understand why the sb_set_mnt_opts() call fails when it
> > > comes after the fs_context_init() call.  I'm particulary curious to
> > > know if the failure is due to conflicting SELinux state in the
> > > fs_context, or if it is simply an issue of sb_set_mnt_opts() not
> > > properly handling existing values.  Perhaps I'm being overly naive,
> > > but I'm hopeful that we can address both of these within the SELinux
> > > code itself.
> >=20
> > The problem I hit was that nfs_compare_super is called with a fs_contex=
t
> > that has a NULL ->security pointer. That caused it to call
> > selinux_sb_mnt_opts_compat with mnt_opts set to NULL, and at that point
> > it returns 1 and decides not to share sb's.
> >=20
> > Filling out fc->security with this new operation seems to fix that, but
> > if you see a better way to do this, then I'm certainly open to the idea=
.
>=20
> Just as you mention that you are not a LSM expert, I am not a VFS
> expert, so I think we'll have to help each other a bit ;)
>=20
> I think I'm beginning to understand alloc_fs_context() a bit more,
> including the fs_context_for_XXX() wrappers.  One thing I have
> realized is that I believe we need to update the
> selinux_fs_context_init() and smack_fs_context_init() functions to
> properly handle a NULL @reference dentry; I think returning without
> error in both cases is the correct answer.  In the non-NULL @reference
> case, I believe your patch is correct, we do want to inherit the
> options from @reference.
>=20


ACK. That seems reasonable. I'll work that in.


>   My only concern now is the
> fs_context::lsm_set flag.
>=20

Yeah, that bit is ugly. David studied this problem a lot more than I
have, but basically, we only want to set the context info once, and
we're not always going to have a nice string to parse to set up the
options. This obviously works, but I'm fine with a more elegant method
if you can spot one.


> You didn't mention exactly why the security_sb_set_mnt_opts() was
> failing, and requires the fs_context::lsm_set check, but my guess is
> that something is tripping over the fact that the superblock is
> already properly setup.  I'm working under the assumption that this
> problem - attempting to reconfigure a properly configured superblock -
> should only be happening in the submount/non-NULL-reference case.  If
> it is happening elsewhere I think I'm going to need some help
> understanding that ...
>=20

Correct. When you pass in the mount options, fc->security seems to be
properly set. NFS mounting is complex though, so the final superblock
you care about may end up being a descendant of the one that was
originally configured.

This patch is intended to ensure we carry over security info in these
cases. We already try to inherit other parameters from parent mounts, so
this is just another set that we need to make sure we inherit.

> However, assuming I'm mostly correct in the above paragraph, would it
> be possible to take a reference to the @reference dentry's superblock
> in security_fs_context_init(), that we could later compare to the
> superblock passed into security_sb_set_mnt_opts()?  If we know that
> the fs_context was initialized with the same superblock we are now
> being asked to set mount options on, we should be able to return from
> the LSM hook without doing anything.
>=20

I'm not sure that I follow your logic here:

You want to take a sb reference and carry that in the fs_context? What
will you do with it in security_sb_set_mnt_opts?

FWIW, It's generally easier to deal with inode or dentry references than
refs to the superblock too, so if we want to carry a reference to an
object around, we'd probably rather handle one of those.
--=20
Jeff Layton <jlayton@kernel.org>
