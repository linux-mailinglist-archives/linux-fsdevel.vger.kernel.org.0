Return-Path: <linux-fsdevel+bounces-47556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDFAA0352
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 08:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28C7169AA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13216270EAB;
	Tue, 29 Apr 2025 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Ja8iX3Y8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2225332F
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908093; cv=none; b=guHFzl7vpsPKpgTKdVAv+hRlYZyTdBk/PEjcf6vZoDfkYzcq4YSiSnKIUlgimxgmkC6QGB8EssuH/B3W7PaEf8NBKN/4jYvuKogyVCsVCtYj6UixnEPvsK6EauYoCpndjFJKl+VzO7ZOK/qA18d9PGUc4IuvbMz2mdly1MQYZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908093; c=relaxed/simple;
	bh=BU06VzYIA7D1zXAi+JsdC+GFWldhRimzO0ujjqBLRBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9phHCQDhV0jHGsPdXFikT9gyC4iGXOPyB5TqTwU7qNojZvXfa58sCXWLJhW7gC4MYOJ6cQPXVuB7Kd1H+Ka+KXH53/wwPLZyyOEnsMcrysRCowoPVRGZChcC66ndHNRch34hhmsnEMl2vj3YeO6+m3I9qNux8yLeR+Tkb7xArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Ja8iX3Y8; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i/Ne1PslC3vyutxzudfORhLh1SZ1nvMJwXKdaZAodnU=; t=1745908089; x=1746512889; 
	b=Ja8iX3Y8K2mDlxEyxMaLT+zUsyfbXZSbAIuR1H7oV45EgTMBLk+b5GEo8oXXygKN8L+AlLfRmHI
	QAATCYMF4R+xE220na7+pD5KAKwewzhtjQCHPgwnbLn4Aw1uN3jEf6XYj0Z8eWrdWoKugmktqf+EA
	xqkFmparRHWiSTqVnjGwL1j8T3q+1gNdtSjFsrAxYPnnQe59YlNNnUemngaL0N9XBSpeJ7TQ5al43
	USUtYrh+n5SToo8g4Y67uSG9C4RXN3oaXFaHtYUR5m8SG9iZ7v0l8AdgDEHK6juZe68XsUU1WnARX
	BQ3h3BX3ngJHL3vu8dlOONJqX6/lfvBrrbMw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u9eRm-00000000keX-0fBJ; Tue, 29 Apr 2025 08:28:02 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u9eRl-00000000TiT-3vxQ; Tue, 29 Apr 2025 08:28:02 +0200
Message-ID: <abd793e61cd23e1954d2c46554127dafbd80c61c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] hfs: fix not erasing deleted b-tree node issue
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Viacheslav Dubeyko
	 <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "frank.li@vivo.com" <frank.li@vivo.com>
Cc: "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Date: Tue, 29 Apr 2025 08:28:01 +0200
In-Reply-To: <78d3899f-5e07-4a76-8135-81cfea3b0086@wdc.com>
References: <20250429011524.1542743-1-slava@dubeyko.com>
	 <78d3899f-5e07-4a76-8135-81cfea3b0086@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Johannes,

On Tue, 2025-04-29 at 06:05 +0000, Johannes Thumshirn wrote:
> On 29.04.25 03:16, Viacheslav Dubeyko wrote:
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > ---
> >   fs/hfs/bnode.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> > index cb823a8a6ba9..c5eae7c418a1 100644
> > --- a/fs/hfs/bnode.c
> > +++ b/fs/hfs/bnode.c
> > @@ -219,6 +219,8 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
> >   		tree->root =3D 0;
> >   		tree->depth =3D 0;
> >   	}
> > +
> > +	hfs_bnode_clear(node, 0, tree->node_size);
> >   	set_bit(HFS_BNODE_DELETED, &node->flags);
> >   }
> >  =20
>=20
> I've just checked HFS+ code and hfs_bnode_unlink() in fs/hfsplus/bnode.c=
=20
> is a copy of the fs/hfs/bnode.c one (maybe most of the file is so=20
> there's room for unification?). So I think the fix is needed there as wel=
l.

Good catch. I assume we should be able to reproduce the above error with xf=
stests
with HFS+ as well and the same fix should address the bug accordingly.

I haven't created my xfstests setup yet, so hopefully someone will beat me =
to this.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

