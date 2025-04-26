Return-Path: <linux-fsdevel+bounces-47448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3AA9D8E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C213AAFFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3E22157F;
	Sat, 26 Apr 2025 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Xl4xqpIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4232701A7
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650769; cv=none; b=QL3SK+ta+XiU6zoR2Z9AGourJ4UgalTUyeM+rc/gM+cHYt40L9LywRnylzj2FR+3mxMWgPgRKVB5XwvzZay7bagUDdJo0qNaLJls0fvW8nCequ3+Slb4AsLO2nCYDM8VcG8L4ZJTbbQX3x0C3+WwyW7eh8Zy2E9bKD7YV4WXYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650769; c=relaxed/simple;
	bh=R15b57+PqVmtlymCHMEZIgZ4eEuBMQpxvBu4ubEhvzQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGRrS+7y+VloZWI2LEx7cAWUthJTpX+BkKGC/cdUA7UIjxFxvoFz1YulSBS147DitevylS7kBeD8VvfS2t4JlsvJnUVDrTbzFC1NzFk6ZPhzwj1o5RX2SFd7bBaDGTJejUXb8Kfma9qPpDHRAHWoSvERp3uRjQV1OYQhrhJRUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Xl4xqpIh; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=asiXK04Ov4MdQCyJscfM0XtJCrt9HKoOuhirEevDlak=; t=1745650766; x=1746255566; 
	b=Xl4xqpIhG2bc4G7ReGIhTbLKV33CWY77VQVyS+goxMpBo44SLNiMPB6nsD2XsrMduGSYa7ivhvW
	d1giZYyE8TH6b/q8wduvhhrnRiwR7TXlbV3QrFyYYE3x4B1bDiMPCRv+0B+n5ea88VFRzBjgtq5bT
	mG0BZARKWJSEnUEMCSPaEFxEu2nhG7apW3ppJaWqvUd2rkrS+qFz/qw8rhD+hojqnAsvQ/exd7MGA
	Vhf/3OVzLTxJyt1TC+BFMTQq4p+QoqR5dyndlPuTD8wMSmd6LUYIjTws2DYVrCUn6G7runKbYs8X5
	ufv1LfDBG6ftdf031O5qQMdzSwDkPGEK8UOw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u8ZVT-00000002fL5-3W31; Sat, 26 Apr 2025 08:59:23 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u8ZVT-00000002e6d-2VIv; Sat, 26 Apr 2025 08:59:23 +0200
Message-ID: <0995ae944427253daccca3ff42db2c9ce37f8322.camel@physik.fu-berlin.de>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?=
 =?UTF-8?Q?__=E5=9B=9E=E5=A4=8D=3A?= =?UTF-8?Q?__=E5=9B=9E=E5=A4=8D=3A?=
 =?UTF-8?Q?_=E5=9B=9E=E5=A4=8D=3A?= HFS/HFS+ maintainership action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?UTF-8?Q?=E6=9D=8E=E6=89=AC=E9=9F=AC?= <frank.li@vivo.com>, 
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "brauner@kernel.org"
	 <brauner@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Date: Sat, 26 Apr 2025 08:59:22 +0200
In-Reply-To: <SEZPR06MB52699F3D7B651C40266E4445E8872@SEZPR06MB5269.apcprd06.prod.outlook.com>
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
	 <97cd591a7b5a2f8e544f0c00aeea98cd88f19349.camel@ibm.com>
	 <SEZPR06MB52699F3D7B651C40266E4445E8872@SEZPR06MB5269.apcprd06.prod.outlook.com>
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

On Sat, 2025-04-26 at 06:17 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> > I am also working on creating a patch set that all Linux distributions =
can use on top of
> > Apple's vanilla upstream sources. The current WIP can be found in [3].
>=20
> Adrian, Would you mind adding a branch that supports mkfs.hfs in your git=
 repository now?

Yes, I can do that. Will let you know once that's ready.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

