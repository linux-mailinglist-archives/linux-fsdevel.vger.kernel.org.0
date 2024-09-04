Return-Path: <linux-fsdevel+bounces-28606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A896C594
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638FA1F262D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5547A1E133D;
	Wed,  4 Sep 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkoYEsP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFD6E619;
	Wed,  4 Sep 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471582; cv=none; b=lCk0xutvj5jeAzv9iUSERApyjm2rZbU+MDq7XJ6xTni/nRI7EORIkYac1Gt0NQc3cB7KhUiEV/UIsuh+iisuMTaywrh70WuQnJBng26hbJ+hWsyCD9vPYlZYaFA6V3H0P5lkJe4e1WvP+M3AnvmmTy6dzNs0+tJ44y0mpoa3GU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471582; c=relaxed/simple;
	bh=ydYZY7v7ruTG2d3pFr0sYhTXJYpdllJL3bZ7mdEGhtc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TXeEJ5AY8CpqOAMLFxJcicaiF0tp5u0j6fdOr+POj45DEbSOzExjMgJdFGIX0zgGZtV6/OHQl1B3L4CUh1syW4ZH3gjDXsZapdGQ6/2rLg6kSEZ9NPVpm2BwQhINVJtXASBU23Ym0rehnU7LRqzORVa1bUOro8qocAjUaXAmPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkoYEsP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4560C4CEC2;
	Wed,  4 Sep 2024 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725471582;
	bh=ydYZY7v7ruTG2d3pFr0sYhTXJYpdllJL3bZ7mdEGhtc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SkoYEsP/ap8vBwx+/K1MQOJcE2X78/ExYLoEAvAegdn6PMDtsocZl8obKE5x/Tg9r
	 /sJXUNyUhfFAZ0t89zKv+b0vY4Jua8EBYXGo7VnqJySkH/MQ1I0SAJIGd+/ZXZhJN6
	 T0Z5JTy6u9l1YwfRwzg8RGsDYY6fMg/2G/fwj4IVlmr9tWqG1WyjsbiN6n5Fni0ww7
	 rR52L1f+sSpDA0CWnLthCio7KtqX8p9eLXer74ZKDigFNimFR/rknMRukTxGRJnGDv
	 CG8Tda51OrgfwE7W8I8fWQPkXPgn393GntAzmv6OpTT1KVY1B1IOB4IJSgua0stxOm
	 7PIEjCRytrvdw==
Message-ID: <2ae8b2d1e2f22fba5acb88c3f12cef9716f28a62.camel@kernel.org>
Subject: Re: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet
 <corbet@lwn.net>,  Tom Haynes <loghyr@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Linux FS Devel
 <linux-fsdevel@vger.kernel.org>,  "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Date: Wed, 04 Sep 2024 13:39:39 -0400
In-Reply-To: <52C563DF-88D1-4AAC-B441-9B821A7B32FF@oracle.com>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
	 <20240829-delstid-v3-3-271c60806c5d@kernel.org>
	 <Zth6oPq1GV2iiypL@tissot.1015granger.net>
	 <82b17019fb334973a74adf88e3eb255df4091f12.camel@kernel.org>
	 <52C563DF-88D1-4AAC-B441-9B821A7B32FF@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 17:28 +0000, Chuck Lever III wrote:
>=20
> > On Sep 4, 2024, at 12:58=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Wed, 2024-09-04 at 11:20 -0400, Chuck Lever wrote:
> > > On Thu, Aug 29, 2024 at 09:26:41AM -0400, Jeff Layton wrote:
> > > > This is always the same value, and in a later patch we're going to =
need
> > > > to set bits in WORD2. We can simplify this code and save a little s=
pace
> > > > in the delegation too. Just hardcode the bitmap in the callback enc=
ode
> > > > function.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > OK, lurching forward on this ;-)
> > >=20
> > > - The first patch in v3 was applied to v6.11-rc.
> > > - The second patch is now in nfsd-next.
> > > - I've squashed the sixth and eighth patches into nfsd-next.
> > >=20
> > > I'm replying to this patch because this one seems like a step
> > > backwards to me: the bitmap values are implementation-dependent,
> > > and this code will eventually be automatically generated based only
> > > on the protocol, not the local implementation. IMO, architecturally,
> > > bitmap values should be set at the proc layer, not in the encoders.
> > >=20
> > > I've gone back and forth on whether to just go with it for now, but
> > > I thought I'd mention it here to see if this change is truly
> > > necessary for what follows. If it can't be replaced, I will suck it
> > > up and fix it up later when this encoder is converted to an xdrgen-
> > > manufactured one.
> >=20
> > It's not truly necessary, but I don't see why it's important that we
> > keep a record of the full-blown bitmap here. The ncf_cb_bmap field is a
> > field in the delegation record, and it has to be carried around in
> > perpetuity. This value is always set by the server and there are only a
> > few legit bit combinations that can be set in it.
> >=20
> > We certainly can keep this bitmap around, but as I said in the
> > description, the delstid draft grows this bitmap to 3 words, and if we
> > want to be a purists about storing a bitmap,
>=20
> Fwiw, it isn't purism about storing the bitmap, it's
> purism about adopting machine-generated XDR marshaling/
> unmarshaling code. The patch adds non-marshaling logic
> in the encoder. Either we'll have to add a way to handle
> that in xdrgen eventually, or we'll have to exclude this
> encoder from machine generation. (This is a ways down the
> road, of course)
>

Understood. I'll note that this function works with a nfs4_delegation
pointer too, which is not part of the protocol spec.

Once we move to autogenerated code, we will always have a hand-rolled
"glue" layer that morphs our internal representation of these sorts of
objects into a form that the xdrgen code requires. Storing this info as
a flag in the delegation makes more sense to me, as the glue layer
should massage that into the needed form.

>=20
> > then that will also
> > require us to keep the bitmap size (in another 32-bit word), since we
> > don't always want to set anything in the third word. That's already 24
> > extra bits per delegation, and we'll be adding new fields for the
> > timestamps in a later patch.
> >=20
> > I don't see the benefit here.
>=20
> Understood, there's a memory scalability issue.
>=20
> There are other ways to go about this that do not grow
> the size of the delegation data structure, I think. For
> instance, you could store the handful of actual valid
> bitmap values in read-only memory, and have the proc
> function select and reference one of them. IIRC the
> client already does this for certain GETATTR operations.
>=20

Unfortunately, it turns out that the bitmap is a bit more complicated,
and we don't quite do it right today. I did a more careful read of
section 10.4.3 in RFC8881. It has this pseudocode:

    if (!modified) {
        do CB_GETATTR for change and size;

        if (cc !=3D sc)
            modified =3D TRUE;
    } else {
        do CB_GETATTR for size;
    }

    if (modified) {
        sc =3D sc + 1;
        time_modify =3D time_metadata =3D current_time;
        update sc, time_modify, time_metadata into file's metadata;
    }

Note that if the thing is already considered to be modified, then it
says to not request FATTR4_CHANGE. I have a related question around
this on the IETF list too.

> So, leave this patch as is, and I will deal with it
> later when we convert the callback XDR functions.
>=20

Thanks, will do.
--=20
Jeff Layton <jlayton@kernel.org>

