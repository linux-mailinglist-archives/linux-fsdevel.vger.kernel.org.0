Return-Path: <linux-fsdevel+bounces-47004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA021A979B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 23:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562A71B63E79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 21:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20AA27056C;
	Tue, 22 Apr 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="O4+z58nQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9305262FFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358531; cv=none; b=tlY4pQ46D8dyxzgAtVgnwY4IBqztvFN5iarUJ2TKBWH1L75Crc278GUbBP3S4jCh/osrwilWuluWcaysmIX8CrWN+74DCQAV2Uo63FI++Buc6YTKMeZ124ZGrqeW1USBCqWkse4GjDH5kICOJcPVcszQ287XJX6eAtZPJHlBtFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358531; c=relaxed/simple;
	bh=cOIXo7ZqDdZ+QS4zdAUMCMf++TK0fjOWoCdQb8s1uzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5LPkKqtR/CY4oz2drlmQWfnsl1Gba3Nj19t115/BBOyoUis0MaU93zAtmjOUPYsiNF9TiUlMJ96av0c7DFe4IUgFe9L9CivEf4Dy39Dn9Muk98Gt8kyv8iRadId5h+wP60nrdhTgACE7fWaqsY4FPHEVlTdSOq56MqfHjKmHgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=O4+z58nQ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uRtp9/+GH3ti0qaiY9ITwjKspoftAi8NbVVCctw8XgI=; t=1745358528; x=1745963328; 
	b=O4+z58nQJY8ZUU+kyx3rL7+pjdpXH+k/XyIaHeDmv2HBX2TFN02TgQFItZbq1Q/UwAEIlXAfGRX
	ZVTeNunRIzq0zL7UKINfW2R0sOiwkjpuA6IRg6x+JcFAkZyAFLr81j58X/vze0It7joRcZUKyWkRm
	5spBDeLkAKZFUBYy8fhWXDmc7QvWe3WVs+wFy6dsu2y1/yerwEUBkp8Uij4iMIe0+fMVe4xtbghva
	+lSFKRl8pfyQLExC+GjABz36r+u2JuFkhZGfT896Sj8vnbNzHxb/8iowiUDGvcefvHWppYoFHoAC+
	fm2QchtBDb++S14jr92r/a/wn3dgOmGemonQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u7LTy-00000000UJi-3XNq; Tue, 22 Apr 2025 23:48:46 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u7LTy-000000010tB-2aI9; Tue, 22 Apr 2025 23:48:46 +0200
Message-ID: <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
Subject: Re: HFS/HFS+ maintainership action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "brauner@kernel.org"
	 <brauner@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Date: Tue, 22 Apr 2025 23:48:46 +0200
In-Reply-To: <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
			 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
		 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
	 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
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

Hi Slava,

On Tue, 2025-04-22 at 23:47 +0200, John Paul Adrian Glaubitz wrote:
> Reducing the discussion on the repository for now.
>=20
> To get a repository on git.kernel.org, you need to have an entry in MAINT=
AINERS.
> Thus, first we would need to get ourselves added to MAINTAINERS for the h=
fs code.
>=20
> I have already an entry there as I'm maintaining arch/sh.
>=20
> You can just send a patch to the LKML, get me and you added to MAINTAINER=
S, see
> [1] and [2] for an example how to do that. Once Linus has merged your pat=
ch, you
> can request a kernel.org and git tree here [3].
>=20
> Adrian
>=20
> > [1] https://lore.kernel.org/lkml/87v8k7rrnf.wl-ysato@users.sourceforge.=
jp/T/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/MAINTAINERS?id=3D80510b63f7b6bdd30e07b3a42115d0a324e20cd6
> > [3] https://korg.docs.kernel.org/accounts.html

Please see also: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/commit/MAINTAINERS?id=3Dbf8f5de17442bba5f811e7e724980730e079ee11

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

