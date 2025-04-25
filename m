Return-Path: <linux-fsdevel+bounces-47417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A127AA9D384
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27C5177AA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50422332B;
	Fri, 25 Apr 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BoHNI5D/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8D1AC458
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614289; cv=none; b=MW99RTp2I476Bhv2HR9mTplrOQdnKPLwgNH4hb/GYfsP7qW5/2VpZE0qJJjwlxPoo8EnVROEaZPJlDbeWbl15e0PTxIikkVQtdi+5owcCLGVTosD84PHhcjdSGG2fuimP2n5x1NfAJuglKExHH7udcxKb77k4oKCgdQKXvE2bys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614289; c=relaxed/simple;
	bh=B2f42Zr9us5jZMi9vn7unY84Vdb6UxZQTwEV2SDQIGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KvD8BQ0B48OLX1v4GrBH+nETRwU2Lia37xmiW8iK6W2S5D7qNOcXTEk1JoelrsLaY8fY2CY7FTkfaYtUsCHBbu7pjBYp7I0mcsxmej186xGDuqymrgcpQeQBb/3F7z5/sRxvQvY2KK5WOZ7EIyLpi+NB0rNNtyrGeswEoeHHEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BoHNI5D/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wEiVbYUwhbBCQ6lA7RbhQ9aKpA2x87b6T2nS9gBE3xg=; t=1745614286; x=1746219086; 
	b=BoHNI5D/RYRomgv1LykjfUIKjHhKba1JHs2BOYHgE4+XRGVAlFIqnHHlvCodCLuPZ+7d4c80haG
	/JGENxT6Wf2s+GrA8Oa4FwvtAxSogWP8j6UxnbNp+Obx7Div9YJIhapZTazbgReTxImwJMYB3sTam
	wPKo2emm+h7KfZjzMVTpD5VZg0lef76MzPJJ37fgwt1TSGRnKlGRrmRAkWWPMkxPByh6+g7AeEbOe
	GI//cpl0KtrDJgcUqls1aiLj3shfj7tHH9blE9y86cxfftwD1gbTxmGFoZygTbHTdP/ZA2keIuO7h
	sTCQ16w2a5Y42TwS06ZH3IohCtr9Xg4caj2A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u8Q15-00000000pb4-2roY; Fri, 25 Apr 2025 22:51:23 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u8Q15-000000003oS-1rid; Fri, 25 Apr 2025 22:51:23 +0200
Message-ID: <1dc5a637002fca90b7f3e756c65a27da66dc2174.camel@physik.fu-berlin.de>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?=
 =?UTF-8?Q?__=E5=9B=9E=E5=A4=8D=3A?= =?UTF-8?Q?_=E5=9B=9E=E5=A4=8D=3A?=
 HFS/HFS+ maintainership action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?UTF-8?Q?=E6=9D=8E=E6=89=AC=E9=9F=AC?= <frank.li@vivo.com>, 
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "brauner@kernel.org"
	 <brauner@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Date: Fri, 25 Apr 2025 22:51:21 +0200
In-Reply-To: <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
							 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
						 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
					 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
				 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
			 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
			 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
		 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
		 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
	 <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
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

Hi Yangtao,

On Fri, 2025-04-25 at 19:36 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> 2). Arch Linux has the hfsprogs installation package, but
> after installation there is only mkfs.hfsplus, missing mkfs.hfs
>=20
> I think if I switch to Ubuntu or something, this problem should go away.

Apple removed support for creating legacy HFS filesystems around version
500 of the hfs source code but kept the code for checking legacy HFS
filesystems.

For the Debian package, I just forward-ported support for creating legacy
HFS filesystems such that Debian's hfsprogs supports both HFS and HFS+.

The patch can be found in [1].

In the future, I'm planning to split the Debian packages into a hfsprogs-le=
gacy
and a hfsprogs package. The -legacy package is supposed to stay at the old
package version and provide mkfs.hfs while the hfsprogs package will track =
the
current upstream sources as Apple is still actively maintaining hfsprogs [2=
].

I am also working on creating a patch set that all Linux distributions can =
use
on top of Apple's vanilla upstream sources. The current WIP can be found in=
 [3].

Adrian

> [1] https://salsa.debian.org/debian/hfsprogs/-/blob/master/debian/patches=
/0005-Re-add-support-for-creating-legacy-HFS-filesystems.patch?ref_type=3Dh=
eads
> [2] https://github.com/apple-oss-distributions/hfs
> [3] https://github.com/glaubitz/hfs/tree/linux

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

