Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D26F1754
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjD1MPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 08:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjD1MPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C131726;
        Fri, 28 Apr 2023 05:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA97C60F11;
        Fri, 28 Apr 2023 12:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E586C433EF;
        Fri, 28 Apr 2023 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682684152;
        bh=4v0DDtlK0RfHaV/3Ex65TF5vM9xrQZIxy2D+X2nJF2Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d1Ag2KQriCq0iZQcCXDFSZCqaeafsuBYm5EgOn8jddY9KoHTCpZJgYx9nLDg2M0lL
         OOX4whVdcxnm9h3k1lSWpQxo1i3hl1cIekrX2WKpP4WZchp/ie8AjIwxhOGlW1DCkm
         qkHm3U+fh0U9UffY/e57AAWeUpLD1+zqN19hebBryPVwC6ftjzeyc7BnOZGrt/z2ID
         72eO6X6WV7iDV6vVk22LebRTuwU4DLAp3/oSEch2GhxLUBm/oxL9JzEKnMvk1Gf5Mf
         YepLhlAcZNf7V7BvFD+dt/ZLbCWJlN7b1kGN7wZwOTNiBEwHzXKSvJBQDqo7RAppti
         o2QrsN+RJjd4g==
Message-ID: <2d0f5a6cd8e9e92f871c95ce586234425e47b719.camel@kernel.org>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with
 fanotify
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 28 Apr 2023 08:15:50 -0400
In-Reply-To: <20230428114002.3vqve7g76xonjs5f@quack3>
References: <20230425130105.2606684-1-amir73il@gmail.com>
         <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
         <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com>
         <df31058f662fe9ec9ad1cc59838f288b8aff10f0.camel@kernel.org>
         <CAOQ4uxhWzV7YJ_kPGg_4wHhWAd79_Xgo2uoDY+1K9sEtJcH_cA@mail.gmail.com>
         <20230428114002.3vqve7g76xonjs5f@quack3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-04-28 at 13:40 +0200, Jan Kara wrote:
> On Thu 27-04-23 22:11:46, Amir Goldstein wrote:
> > On Thu, Apr 27, 2023 at 7:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > > > There is also a way to extend the existing API with:
> > > >=20
> > > > Perhstruct file_handle {
> > > >         unsigned int handle_bytes:8;
> > > >         unsigned int handle_flags:24;
> > > >         int handle_type;
> > > >         unsigned char f_handle[];
> > > > };
> > > >=20
> > > > AFAICT, this is guaranteed to be backward compat
> > > > with old kernels and old applications.
> > > >=20
> > >=20
> > > That could work. It would probably look cleaner as a union though.
> > > Something like this maybe?
> > >=20
> > > union {
> > >         unsigned int legacy_handle_bytes;
> > >         struct {
> > >                 u8      handle_bytes;
> > >                 u8      __reserved;
> > >                 u16     handle_flags;
> > >         };
> > > }
> >=20
> > I have no problem with the union, but does this struct
> > guarantee that the lowest byte of legacy_handle_bytes
> > is in handle_bytes for all architectures?
> >=20
> > That's the reason I went with
> >=20
> > struct {
> >          unsigned int handle_bytes:8;
> >          unsigned int handle_flags:24;
> > }
> >=20
> > Is there a problem with this approach?
>=20
> As I'm thinking about it there are problems with both approaches in the
> uAPI. The thing is: A lot of bitfield details (even whether they are pack=
ed
> to a single int or not) are implementation defined (depends on the
> architecture as well as the compiler) so they are not really usable in th=
e
> APIs.
>=20
> With the union, things are well-defined but they would not work for
> big-endian architectures. We could make the structure layout depend on th=
e
> endianity but that's quite ugly...
>=20

Good point. Bitfields just have a bad code-smell anyway.

Another idea would be to allow someone to set handle_bytes to a
specified value that's larger than the current max of 128 (maybe ~0 or
something), and use that as an indicator that this is a v2 struct.

So the v2 struct would look something like:

struct file_handle_v2 {
	unsigned int	legacy_handle_bytes;	// always set to ~0 or whatever
	unsigned int	flags;
	int		handle_type;
	unsigned int	handle_bytes;
	unsigned char	f_handle[];
=09
};

...but now I'm wondering...why do we return -EINVAL when
f_handle.handle_bytes is > MAX_HANDLE_SZ? Is it really wrong for the
caller to allocate more space for the resulting file_handle than will be
needed? That seems wrong too. In fact, name_to_handle_at(2) says:

"The constant MAX_HANDLE_SZ, defined in <fcntl.h>, specifies the maximum
expected size for a file handle.  It  is  not guaranteed upper limit as
future filesystems may require more space."

So by returning -EINVAL when handle_bytes is too large, we're probably
doing the wrong thing there.

Using an AT_* flag may be the best plan, actually.
--=20
Jeff Layton <jlayton@kernel.org>
