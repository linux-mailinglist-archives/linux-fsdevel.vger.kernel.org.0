Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C271C70FE2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjEXTDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjEXTDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 15:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812BA119;
        Wed, 24 May 2023 12:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16DBA60EFB;
        Wed, 24 May 2023 19:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B65C433EF;
        Wed, 24 May 2023 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684955008;
        bh=ibpSB5X+aojA3C7XXWRsgXXDfsbiBXjmlM1EiV0jMUM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ApZVtCj1i0qi1WtVDxenPoHM34KI9WKKq2lovXf0jyH1XbEaf2bSVg0USTO8rKjgG
         T6AGFeIu0FjNPdu9iYM+z06hewtI4CYjIUVwhGrcEuLLWRv9pIW8XsSjK82+rhwIfY
         s14G5zYH+3eG4VjPEQauz11sXBD6LzRp9Z37X09o7OUrUjuVZpUSISr+VYpqRXnqNy
         T6HAER/h2ZZlNV/injnIa69NOEki6zpRK/Ht8KNr3DKwOjNY3ujQhNMdTO+Hf8wFg1
         yvCzT8mDrcdDuqtVLHgwwQ3TMgnhScxx98B7mZ3iaEGsQW6GyZ6SXmhBC5Qmfy/+X4
         jQXEJ1xS68w9A==
Message-ID: <dc0c053d734dc5b45475cde015d1cebb78922336.camel@kernel.org>
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Wed, 24 May 2023 15:03:26 -0400
In-Reply-To: <b4c4d608-80aa-7f3d-7a83-2e7b24918b02@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
         <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
         <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
         <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
         <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
         <CDB5013B-A8D2-4035-9210-B0854B1EE729@oracle.com>
         <b4c4d608-80aa-7f3d-7a83-2e7b24918b02@oracle.com>
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

On Wed, 2023-05-24 at 11:05 -0700, dai.ngo@oracle.com wrote:
> On 5/24/23 10:41 AM, Chuck Lever III wrote:
> >=20
> > > On May 24, 2023, at 12:55 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Wed, 2023-05-24 at 15:09 +0000, Chuck Lever III wrote:
> > > > > On May 24, 2023, at 11:08 AM, Jeff Layton <jlayton@kernel.org> wr=
ote:
> > > > >=20
> > > > > On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
> > > > > > Remove the check for F_WRLCK in generic_add_lease to allow file=
_lock
> > > > > > to be used for write delegation.
> > > > > >=20
> > > > > > First consumer is NFSD.
> > > > > >=20
> > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > ---
> > > > > > fs/locks.c | 7 -------
> > > > > > 1 file changed, 7 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/locks.c b/fs/locks.c
> > > > > > index df8b26a42524..08fb0b4fd4f8 100644
> > > > > > --- a/fs/locks.c
> > > > > > +++ b/fs/locks.c
> > > > > > @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, lon=
g arg, struct file_lock **flp, void **pr
> > > > > > if (is_deleg && !inode_trylock(inode))
> > > > > > return -EAGAIN;
> > > > > >=20
> > > > > > - if (is_deleg && arg =3D=3D F_WRLCK) {
> > > > > > - /* Write delegations are not currently supported: */
> > > > > > - inode_unlock(inode);
> > > > > > - WARN_ON_ONCE(1);
> > > > > > - return -EINVAL;
> > > > > > - }
> > > > > > -
> > > > > > percpu_down_read(&file_rwsem);
> > > > > > spin_lock(&ctx->flc_lock);
> > > > > > time_out_leases(inode, &dispose);
> > > > > I'd probably move this back to the first patch in the series.
> > > > >=20
> > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > I asked him to move it to the end. Is it safe to take out this
> > > > check before write delegation is actually implemented?
> > > >=20
> > > I think so, but it don't think it doesn't make much difference either
> > > way. The only real downside of putting it at the end is that you migh=
t
> > > have to contend with a WARN_ON_ONCE if you're bisecting.
> > My main concern is in fact preventing problems during bisection.
> > I can apply 3/3 and then 1/3, if you're good with that.
>=20
> I'm good with that. You can apply 3/3 then 1/3 and drop 2/3 so I
> don't have to send out v6.
>=20

I'm fine with that too, particularly if other vendors don't recall on a
getattr currently.

I wonder though, if we need some clarification in the spec on
CB_GETATTR?

    https://www.rfc-editor.org/rfc/rfc8881.html#section-10.4.3

In that section, there is a big distinction about the client being able
to tell that the data was modified from the point where the delegation
was handed out.

There is always a point in time where a client has buffered writes that
haven't been flushed to the server yet, but that's true when it doesn't
have a delegation too. Mostly the client tries to start some writeback
fairly quickly so any lag how the in the change attr/size update is
usually short lived.

I don't think the Linux client materially changes its writeback behavior
based on a write delegation, so I guess (as Olga pointed out) the main
benefit from a write delegation is being able to do delegated opens for
write. A getattr's results won't be changed by extra opens or closes, so
yeah...I guess the utility of CB_GETATTR is really limited.

I guess it _might_ be useful in the case where the server has handed out
a write delegation, but hasn't gotten any writes. That would at least
tell the client that something has changed, even if the deleg holder
hasn't gotten around to writing anything back yet. The problem is that
it's common for applications to open O_RDWR and only do reads.

Maybe we ought to take this discussion to the IETF list? It seems like
the spec mandates that you must recall the delegation if you don't
implement CB_GETATTR, but I don't see much in way of harm in ignoring
that.
--=20
Jeff Layton <jlayton@kernel.org>
