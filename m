Return-Path: <linux-fsdevel+bounces-46892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65162A95F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E47F1898197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC92238C17;
	Tue, 22 Apr 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="iK6TzNnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98710A3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306520; cv=none; b=SrfaBc4SLXnW8srgRDZ2E/ul4g2HMKYGs2DILmlIAnC1fiL/jxvcGfxpr+MxFdpXKGAdsy7DK06cvCyQjAEQaBltT22qeZPM5JIuYDmTizZNFAkOj9TVQQbp7HZZibt8shR612X3/W26rqiPvizr/mJ4Ec4QiEGvhY0v7ApE/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306520; c=relaxed/simple;
	bh=QOxokqMvXgiuSv7PNhR18EmwB2eN9QNEo01HUzFTWBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1oWISLJEODK9brQuFRTuycsnIviNH2PEIn3yfPINeCL/Zoas2licN8zOit6Mx5BPXWDKK2/J0MmYkwREwWcKaOzZ5Imn0Q2kwMUTnHE+tLXeS5IpB8b02G2Qte9VO2DxPorIoJxetQxHKEuS8eK09rV4o9KKe8BNkkUq25ZLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=iK6TzNnH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EmVVfmkysYUQQb973zItFvC6PEzvBK21LOcXPBx8Bvs=; t=1745306518; x=1745911318; 
	b=iK6TzNnHPpjSM7YMIPtWPp3luUgXW0cK2jYlbhwBlHYYHwjUE1Zni/14dHXxkM5MbkYMJFkPq68
	AtbTqhzkOHwHL+XUR76R8TpkhiSpLRRIr9xQG7auSlipHUFyQTcUr8ccfrczzoYqTGVk483KmZinB
	tkSXNiBeixcTFT/VIb4WZtXUAUWMwAFc6oiQu4H6FW2BsLd1WkC8eIUFqAFrXcEm9qgFMS2fohIG2
	6WnkRN8H9QObWD6ec/+EJ6Utti3290SF0MInHYOWoeSodH1pOXpvGS8HrEAxm4f0k2oN2gn8k7IJi
	up4ywOfJHLyr0V/yOKgsTFqufVLcpHyV8gQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u77x6-00000003bXT-1A38; Tue, 22 Apr 2025 09:21:56 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u77x6-00000001orG-0ZBW; Tue, 22 Apr 2025 09:21:56 +0200
Message-ID: <661fb07d164e19e02ae18b4fe24e6cd1613b9a7b.camel@physik.fu-berlin.de>
Subject: Re: HFS/HFS+ maintainership action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
 "linux-fsdevel@vger.kernel.org"	 <linux-fsdevel@vger.kernel.org>,
 "brauner@kernel.org" <brauner@kernel.org>,  "slava@dubeyko.com"	
 <slava@dubeyko.com>
Date: Tue, 22 Apr 2025 09:21:55 +0200
In-Reply-To: <20250422041655.GN25659@frogsfrogsfrogs>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
	 <20250422024333.GD569616@mit.edu> <20250422041655.GN25659@frogsfrogsfrogs>
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

On Mon, 2025-04-21 at 21:16 -0700, Darrick J. Wong wrote:
> > One potential problem is that the userspace utilities to format,
> > check, repair HFS/HFS+ utilities don't really exist.  There is the HFS
> > Utilities[1] which is packaged in Debian as hfsutils, but it only
> > supports HFS, not HFS+, and it can only format an HFS file system; it
> > doesn't have a fsck analog.  This is going to very limit the ability
> > to run xfstests for HFS or HFS+.
> >=20
> > [1] https://www.mars.org/home/rob/proj/hfs/
>=20
> How about hfsprogs, it has mkfs and fsck tools.  Though it /is/ APSL
> licensed...

That's what I use and maintain in Debian. I have been trying to reach out
to Apple to get it relicensed under Apache or MIT but I unfortunately got
a reply.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

