Return-Path: <linux-fsdevel+bounces-47003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1F2A979B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 23:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D8E7AD6A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C09244698;
	Tue, 22 Apr 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="SYMMxwKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8992701BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358471; cv=none; b=R4OARcPlQc62wwBS0wcjhfvBYQXhScB/lh6BGkCFRRFfmeOqZ8JQzh7eLSe/haUpf0ifS8RaoHYY7XGOjvUnM0mWqtTGuFoTGFifotOOoO4SUsW0DEC3Zj/gzMdQKTqEJCFWdL5LWPi7Ed34MAcl6lnq686iItYx88cnlfEcfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358471; c=relaxed/simple;
	bh=mr60lZ33m7inOw2vkxaLiXvCBmqz+yEgNNFtmwAi2cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmV3x/g21rDHKiuY4Q9ZjeaAUV8mcDtxy/Fv8fm4jnyxPLlSgOOu2ifhUgHfTFJhxZ20yX7hq7Q31S6zWRKIPPgHnH5nWGx3CZ/oY2FKcVQemIH/0ankHMiLB5Jk+0xEoZyfDkULwZqHXbzjGYrlbZBV2hs+4Az1VY0Xta/zzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=SYMMxwKL; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5JBCT+qDY+Klir1zbPByl9vmFoPmnt1lzOjb1c/vCUY=; t=1745358468; x=1745963268; 
	b=SYMMxwKLqmyTDYvEITPwiQCi9k0Ta/FJDK7XLEgqnITPuzorWQ9IK5rQJdC2a7LOsUMZiMUYGP0
	groiuU55HKWI/n8Rn7FYK+d4RMaw32iqSd10RE3NLH8LMDmTiCnenmSKPOrZFFMID/AVA+NQRsD1X
	JgJ3fbvjP0u7Fmp8ocP4nNqtm9cXi1282RkPBXdiORc0zgMRWpL2MWWkwcgZj+X0ukmbzytYynPUT
	2GY67Sd9ZNHkrCUxYZQsDFprWJESoY7vqHMBIFMSLlmOgEWv8jpss63g44y2on6wAdiimrx5pYO3z
	SFPcR8AhbafT2kXj25g4nyoc/S3Uxv6hraPg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u7LSy-00000000U8c-2VIy; Tue, 22 Apr 2025 23:47:44 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u7LSy-000000010i7-1SKz; Tue, 22 Apr 2025 23:47:44 +0200
Message-ID: <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
Subject: Re: HFS/HFS+ maintainership action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "brauner@kernel.org"
	 <brauner@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Date: Tue, 22 Apr 2025 23:47:43 +0200
In-Reply-To: <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
		 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
	 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
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

On Tue, 2025-04-22 at 21:12 +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-04-22 at 14:35 +0200, John Paul Adrian Glaubitz wrote:
> > Hi Slava,
> >=20
> > On Mon, 2025-04-21 at 21:52 +0000, Viacheslav Dubeyko wrote:
> > > I am trying to elaborate the HFS/HFS+ maintainership action items:
> > > (1) We need to prepare a Linux kernel tree fork to collect patches.
> >=20
> > Yes. I suggest creating a tree on git.kernel.org.
> >=20
>=20
> Makes sense. Whom do we need to ask to make it happened?

Reducing the discussion on the repository for now.

To get a repository on git.kernel.org, you need to have an entry in MAINTAI=
NERS.
Thus, first we would need to get ourselves added to MAINTAINERS for the hfs=
 code.

I have already an entry there as I'm maintaining arch/sh.

You can just send a patch to the LKML, get me and you added to MAINTAINERS,=
 see
[1] and [2] for an example how to do that. Once Linus has merged your patch=
, you
can request a kernel.org and git tree here [3].

Adrian

> [1] https://lore.kernel.org/lkml/87v8k7rrnf.wl-ysato@users.sourceforge.jp=
/T/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/MAINTAINERS?id=3D80510b63f7b6bdd30e07b3a42115d0a324e20cd6
> [3] https://korg.docs.kernel.org/accounts.html

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

