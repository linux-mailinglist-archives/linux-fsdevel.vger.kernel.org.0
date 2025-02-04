Return-Path: <linux-fsdevel+bounces-40784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B30A277B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A33D3A665E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBF21578C;
	Tue,  4 Feb 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHjBuKVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6328399;
	Tue,  4 Feb 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688339; cv=none; b=RVMKSCT9kSJVQ+KE1ciaeejqBQEK0dXmMZXnJay2mqEOAIj11XCf7Y35H53BrX94PfpUrWxd7mgbU3pap+x+Odf+16XaRHH2SZNUabuA7vstYlxNn4SXRS6nJ1zX7Cz856/s3hayCfVxKvT+N6HIJg9ZhgfX+aeutUz8ei4AHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688339; c=relaxed/simple;
	bh=LbxYU7EuGREsbdwz5TUen7s+5wYYoVfOCHMiWXezq04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OkMpZLRuBGopbfjyr5cme2a+PfeQtUwDOAjPKFobDxI6+OvsA6ffAv5REbXo3SGoIiNgUslC0vVwfD6oHKf/LOq6qD48yqUzwgKr0U69rWDG1LwgWKMIRva5nv20W1VaYauGHmkIN7oVw/VNI9wWKU+BeW4nLBr1KNJ2nx9omzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHjBuKVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DACC4CEDF;
	Tue,  4 Feb 2025 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688338;
	bh=LbxYU7EuGREsbdwz5TUen7s+5wYYoVfOCHMiWXezq04=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KHjBuKVYcRqQmhfwXpsBtdveFBXt+lTAJ4p5xykzvY6UhMFKkLHZqtFwJq3lWorEa
	 cZ+9MtKG2qXzgWF/V5NFuUehP4GZYYVRkB8Ge3znTAYCKGqJq7HqWY6sSWRcnS7thi
	 pwbF2JWyH2obLGi2YjWPzYDe8NBXvXmX19LkfM7BSOIaCfCDfVzbHFFd7dIrVb2clj
	 pdMqCqe1XogvCyZvJI/G7vQRw7Yvd/1jio1IkMcP3709rPBJuVEYagIbGG4Cl1uBaZ
	 IGzZE/ML8M8CW9pHn9lVzrMvRIzSJaNEExF5B4u57kOM90jBsx3wPS9sLWHwp0Omo/
	 uN30NockjpE6w==
Message-ID: <bd2878d7d3a320298729e69123553031dfdeef3f.camel@kernel.org>
Subject: Re: [PATCH] statmount: add a new supported_mask field
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Feb 2025 11:58:56 -0500
In-Reply-To: <20250204-keimzelle-reibt-84877b62936c@brauner>
References: <20250203-statmount-v1-1-871fa7e61f69@kernel.org>
	 <20250204-stengel-lodern-8e6ce624cf77@brauner>
	 <8d07cfbab7b1d70b6fc381ad065d55773f73d93f.camel@kernel.org>
	 <20250204-vintage-sozusagen-33df0d66bd6c@brauner>
	 <3a139a0cca7772935dbc7e376d19547191143ce5.camel@kernel.org>
	 <20250204-keimzelle-reibt-84877b62936c@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 17:45 +0100, Christian Brauner wrote:
> On Tue, Feb 04, 2025 at 10:57:39AM -0500, Jeff Layton wrote:
> > On Tue, 2025-02-04 at 16:09 +0100, Christian Brauner wrote:
> > > On Tue, Feb 04, 2025 at 07:28:20AM -0500, Jeff Layton wrote:
> > > > On Tue, 2025-02-04 at 12:07 +0100, Christian Brauner wrote:
> > > > > On Mon, Feb 03, 2025 at 12:09:48PM -0500, Jeff Layton wrote:
> > > > > > Some of the fields in the statmount() reply can be optional. If=
 the
> > > > > > kernel has nothing to emit in that field, then it doesn't set t=
he flag
> > > > > > in the reply. This presents a problem: There is currently no wa=
y to
> > > > > > know what mask flags the kernel supports since you can't always=
 count on
> > > > > > them being in the reply.
> > > > > >=20
> > > > > > Add a new STATMOUNT_SUPPORTED_MASK flag and field that the kern=
el can
> > > > > > set in the reply. Userland can use this to determine if the fie=
lds it
> > > > > > requires from the kernel are supported. This also gives us a wa=
y to
> > > > > > deprecate fields in the future, if that should become necessary=
.
> > > > > >=20
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > > I ran into this problem recently. We have a variety of kernels =
running
> > > > > > that have varying levels of support of statmount(), and I need =
to be
> > > > > > able to fall back to /proc scraping if support for everything i=
sn't
> > > > > > present. This is difficult currently since statmount() doesn't =
set the
> > > > > > flag in the return mask if the field is empty.
> > > > > > ---
> > > > > >  fs/namespace.c             | 18 ++++++++++++++++++
> > > > > >  include/uapi/linux/mount.h |  4 +++-
> > > > > >  2 files changed, 21 insertions(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > > > index a3ed3f2980cbae6238cda09874e2dac146080eb6..7ec5fc436c4ff30=
0507c4ed71a757f5d75a4d520 100644
> > > > > > --- a/fs/namespace.c
> > > > > > +++ b/fs/namespace.c
> > > > > > @@ -5317,6 +5317,21 @@ static int grab_requested_root(struct mn=
t_namespace *ns, struct path *root)
> > > > > >  	return 0;
> > > > > >  }
> > > > > > =20
> > > > > > +/* This must be updated whenever a new flag is added */
> > > > > > +#define STATMOUNT_SUPPORTED (STATMOUNT_SB_BASIC | \
> > > > > > +			     STATMOUNT_MNT_BASIC | \
> > > > > > +			     STATMOUNT_PROPAGATE_FROM | \
> > > > > > +			     STATMOUNT_MNT_ROOT | \
> > > > > > +			     STATMOUNT_MNT_POINT | \
> > > > > > +			     STATMOUNT_FS_TYPE | \
> > > > > > +			     STATMOUNT_MNT_NS_ID | \
> > > > > > +			     STATMOUNT_MNT_OPTS | \
> > > > > > +			     STATMOUNT_FS_SUBTYPE | \
> > > > > > +			     STATMOUNT_SB_SOURCE | \
> > > > > > +			     STATMOUNT_OPT_ARRAY | \
> > > > > > +			     STATMOUNT_OPT_SEC_ARRAY | \
> > > > > > +			     STATMOUNT_SUPPORTED_MASK)
> > > > >=20
> > > > > Hm, do we need a separate bit for STATMOUNT_SUPPORTED_MASK? Afaiu=
, this
> > > > > is more of a convenience thing but then maybe we just do:
> > > > >=20
> > > > > #define STATMOUNT_SUPPORTED_MASK STATMOUNT_MNT_BASIC
> > > > >=20
> > > > > and be done with it?
> > > > >=20
> > > > > Otherwise I think it is worth having support for this.
> > > > >=20
> > > >=20
> > > > Are you suggesting that we should just add the ->supported_mask fie=
ld
> > > > without a declaring a bit for it? If so, how would that work on old
> > > > kernels? You'd never know if you could trust the contents of that f=
ield
> > > > since the return mask wouldn't indicate any difference.
> > >=20
> > > What I didn't realize because I hadn't read carefully enough in your
> > > patch was that STATMOUNT_SUPPORTED_MASK is raised in ->mask and only
> > > then is ->supported_mask filled in.
> > >=20
> > > My thinking had been that ->supported_mask will simply always be fill=
ed
> > > in by the kernel going forward. Which is arguably not ideal but would
> > > work:
> > >=20
> > > So the kernel guarantees since the introduction of statmount() that w=
hen
> > > we copy out to userspace that anything the kernel doesn't know will b=
e
> > > copied back zeroed. So any unknown fields are zero.
> > >=20
> > > (1) Say userspace passes a struct statmount with ->supported_mask to =
the
> > >     kernel - even if it has put garbage in there or intentionally rai=
sed
> > >     valid flags in there - the old kernel will copy over this and set=
 it
> > >     to zero.
> > >=20
> > > (2) If you're on a new kernel but pass an old struct the kernel will
> > >     fill in ->supported_mask. Imho, that's fine. Userspace simply wil=
l
> > >     not know about it.
> > >=20
> > > But we can leave the explicit request in!
> > >=20
> >=20
> >=20
> > I can respin without STATMOUNT_SUPPORTED_MASK. I was thinking it left
> > that part of the return buffer untouched, but if it's zeroed, then that
> > works as well.
> >=20
> > If you see a supported_mask of 0, you know the kernel didn't fill it in
> > (since it should at least support _something_). That'll need to be
> > carefully documented though.
>=20
> It's probably easier for userspace if that flag must be specifically rais=
ed.

Agreed. Should I assume you'll take this one as-is then? If you want to
change it to always set the field though, then that's fine with me.
--=20
Jeff Layton <jlayton@kernel.org>

