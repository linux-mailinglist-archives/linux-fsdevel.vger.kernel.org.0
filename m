Return-Path: <linux-fsdevel+bounces-25592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62194DCC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A921F215B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8F158520;
	Sat, 10 Aug 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b="iPo8QfVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nov-007-i658.relay.mailchannels.net (nov-007-i658.relay.mailchannels.net [46.232.183.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42605182D8
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.183.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723293069; cv=none; b=aFvtvqPWs1JYBI0sFoQU8MJMhisMB8L35DfCV1pYSsdceGW2eoufptNTXFgf5A3C8HucNO25jg/dAaC7Gl4d6rW/KmmZIqARr2O1u+wFBpE4Ytsw3QPKLagj5FPkzsDN4AfWhPiBJz3xnSsLVSEvu8Rny0rdbkz/8ZS0R8ZaXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723293069; c=relaxed/simple;
	bh=E5I3QtUuprySi+I00V0UhUG7i9DuMS6lBdeWilqP39c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9c53hXOHrVPzgmhLUiDqwaj5mOToc6UfATfl6+cwL9lQJss7i9nmwb8lNwnf2nDCgDN/LAkrQMRTCDg1YD/tlvmfpYTsokuE0Ag/HLPDZKk3ZFvltH8qJQ5Cr/4KVJRNHIf5+lGmnNFKmFMDrPV6sB32QV6qwJND+8rAt8Pm28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch; spf=pass smtp.mailfrom=bitron.ch; dkim=pass (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b=iPo8QfVq; arc=none smtp.client-ip=46.232.183.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitron.ch
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A3E227E0066;
	Sat, 10 Aug 2024 12:24:29 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Company-Tart: 501d02243c178ce2_1723292668917_298374908
X-MC-Loop-Signature: 1723292668917:1083076595
X-MC-Ingress-Time: 1723292668917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitron.ch;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2IQ89S6VdaRNpfBclR0snL1k6Vsm/eFQU1+7PuHzWGs=; b=iPo8QfVqFGa2H8N7Xe4Q3av0rF
	pZ5v4LxHDNyEc6tmnXmbiSz1G5Uu4Odeq9oGyOp46OGGGeQyXUOqsMcJVC+6BEVwRB3bK3ujgHWLo
	NaOneYvyFPeTIa6A7AuL/B966xYoujvaQ5YEw522JZurbJvwITzD/FLAN4D7QE+bPKcGF0QjNxUaq
	5h1uxhjMylXyqeH8PXLC1iw/mUQFvVpNSpd9i7v58KEf7ATPQisbl+KHGNmWLOvNYcIADjZmWTEct
	WqwUtROspuYz3i61TFXGZihut4W65gMGq5E/BXS7kjSExTYTSv+ArL6J4ncVKkaQKGsz3pChdvNLy
	xUvB+9MQ==;
Message-ID: <d0844e7465a12eef0e2998b5f44b350ee9e185be.camel@bitron.ch>
Subject: Re: [PATCH 3/3] fuse: use folio_end_read
From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Date: Sat, 10 Aug 2024 14:24:24 +0200
In-Reply-To: <20240809162221.2582364-3-willy@infradead.org>
References: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
	 <20240809162221.2582364-3-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: juerg@bitron.ch

On Fri, 2024-08-09 at 17:22 +0100, Matthew Wilcox (Oracle) wrote:
> part three
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> =C2=A0fs/fuse/file.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2b5533e41a62..f39456c65ed7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -937,9 +937,7 @@ static void fuse_readpages_end(struct fuse_mount
> *fm, struct fuse_args *args,
> =C2=A0	for (i =3D 0; i < ap->num_pages; i++) {
> =C2=A0		struct folio *folio =3D page_folio(ap->pages[i]);
> =C2=A0
> -		if (!err)
> -			folio_mark_uptodate(folio);
> -		folio_unlock(folio);
> +		folio_end_read(folio, !err);
> =C2=A0		folio_put(folio);
> =C2=A0	}
> =C2=A0	if (ia->ff)

Reverting this part is sufficient to fix the issue for me.

Cheers,
J=C3=BCrg

