Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF9759E43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 21:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGSTMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSTMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFBE1BF6;
        Wed, 19 Jul 2023 12:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D00D617EB;
        Wed, 19 Jul 2023 19:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98FDC433C8;
        Wed, 19 Jul 2023 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689793935;
        bh=WnEpYb5mCjqyiCqGCFbyID54hiPfijMfm02T5CHpq+E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IPMW/TPeElwK4pnrsNJ+14tW2/Yrz6imn5BjbGDOpzEDr+QClaZJVrJUOYiE2OKOd
         xKKYnksaQmZBaNmBONHN+HLYGGF6Iu7di2hT04NRYI9gipdHE2pLSqHJ7pvm93WJ4r
         ODXdgj1e/c7iKOvJkoABDHpeB0RMTqJXZPPK/Go43yb9z7GR56jVNbMjmR7FHtkEZT
         DXSdRFUldGiU/XixofL86zqBJ6WkYJB2rnuEcE5Ji73zcjfEpNjDX0bkVoXVCjgvu3
         eU2hEFDhssej7vwy0O4EQj2GoLjZ+VneJh8Acdgzr/cFJ95Lsd5RmaVdoErtFW+INY
         yubRivpI6RYTQ==
Message-ID: <32b660c62f2abb17695816b83c41ae15b065b70e.camel@kernel.org>
Subject: Re: [PATCH] nfsd: inherit required unset default acls from
 effective set
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek@diasemi.com>,
        Andreas Gruenbacher <agruen@redhat.com>
Date:   Wed, 19 Jul 2023 15:12:13 -0400
In-Reply-To: <0FE91AAE-0A90-4856-B9F3-A2CC4B4A94CC@oracle.com>
References: <20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org>
         <0FE91AAE-0A90-4856-B9F3-A2CC4B4A94CC@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Wed, 2023-07-19 at 19:02 +0000, Chuck Lever III wrote:
>=20
> > On Jul 19, 2023, at 1:49 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
> > ACEs, but there is no requirement for inheritable entries for those
> > entities. POSIX ACLs must always have owner/group/other entries, even f=
or a
> > default ACL.
> >=20
> > nfsd builds the default ACL from inheritable ACEs, but the current code
> > just leaves any unspecified ACEs zeroed out. The result is that adding =
a
> > default user or group ACE to an inode can leave it with unwanted deny
> > entries.
> >=20
> > For instance, a newly created directory with no acl will look something
> > like this:
> >=20
> > # NFSv4 translation by server
> > A::OWNER@:rwaDxtTcCy
> > A::GROUP@:rxtcy
> > A::EVERYONE@:rxtcy
> >=20
> > # POSIX ACL of underlying file
> > user::rwx
> > group::r-x
> > other::r-x
> >=20
> > ...if I then add new v4 ACE:
> >=20
> > nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test
> >=20
> > ...I end up with a result like this today:
> >=20
> > user::rwx
> > user:1000:rwx
> > group::r-x
> > mask::rwx
> > other::r-x
> > default:user::---
> > default:user:1000:rwx
> > default:group::---
> > default:mask::rwx
> > default:other::---
> >=20
> > A::OWNER@:rwaDxtTcCy
> > A::1000:rwaDxtcy
> > A::GROUP@:rxtcy
> > A::EVERYONE@:rxtcy
> > D:fdi:OWNER@:rwaDx
> > A:fdi:OWNER@:tTcCy
> > A:fdi:1000:rwaDxtcy
> > A:fdi:GROUP@:tcy
> > A:fdi:EVERYONE@:tcy
> >=20
> > ...which is not at all expected. Adding a single inheritable allow ACE
> > should not result in everyone else losing access.
> >=20
> > The setfacl command solves a silimar issue by copying owner/group/other
> > entries from the effective ACL when none of them are set:
> >=20
> >    "If a Default ACL entry is created, and the  Default  ACL  contains =
 no
> >     owner,  owning group,  or  others  entry,  a  copy of the ACL owner=
,
> >     owning group, or others entry is added to the Default ACL.
> >=20
> > Having nfsd do the same provides a more sane result (with no deny ACEs
> > in the resulting set):
> >=20
> > user::rwx
> > user:1000:rwx
> > group::r-x
> > mask::rwx
> > other::r-x
> > default:user::rwx
> > default:user:1000:rwx
> > default:group::r-x
> > default:mask::rwx
> > default:other::r-x
> >=20
> > A::OWNER@:rwaDxtTcCy
> > A::1000:rwaDxtcy
> > A::GROUP@:rxtcy
> > A::EVERYONE@:rxtcy
> > A:fdi:OWNER@:rwaDxtTcCy
> > A:fdi:1000:rwaDxtcy
> > A:fdi:GROUP@:rxtcy
> > A:fdi:EVERYONE@:rxtcy
> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2136452
> > Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
> > Suggested-by: Andreas Gruenbacher <agruen@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> As you pointed out in the bug report, there is not much testing
> infrastructure for NFSv4 ACLs. It will be hard to tell in
> advance if this change results in a behavior regression.
>=20
> On the other hand, I'm not sure we have a large cohort of
> NFSv4 ACL users on Linux.
>=20
> I can certainly apply this to nfsd-next at least for a few
> weeks to see if anyone yelps.
>=20

Thanks, that's probably the best we can do, given the state of v4 ACL
test coverage.
--=20
Jeff Layton <jlayton@kernel.org>
