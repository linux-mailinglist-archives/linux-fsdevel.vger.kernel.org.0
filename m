Return-Path: <linux-fsdevel+bounces-47357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82567A9C7B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CBB1896495
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392711E1C1A;
	Fri, 25 Apr 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="W75GO4HD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D381C7019
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580778; cv=none; b=I9C7jH44CuJLNd/yKkDgdNFG2vsPcgplKKuJlmCmmBxFu7bXM7aGC5JLiejqdqIZ5DO0vdVb2VIAzCnFlE27fTpin8qGMOYFPyGaMyeO6YxAPCWkpAKKksLr05qHZs1QpMImaKUYDIcbr4TedranUCBRoFbfWX+1JZWG+KyFV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580778; c=relaxed/simple;
	bh=M3P0bTrtgnwVqnUsqGyPCi3vepuzmRLnWdv+mUP18KI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATvXMSPt7TQ+xN/sn6sNHz7mCXLvlDBCicmgTv4uYDVnmcyuO/Iq5wWvRo7U7tHrDiNGgg4cyInZSliCJssu82UT9dR5snIEQWNQOM84HxX1aCOkZdX7sUrAXri+UxZMiWJjlfuN+9NJMmQjkabevtXsK5JWeihzFRqRelpQN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=W75GO4HD; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J6SjygUmo7PnepyTif20K9sxjKXzXKe9K62U1BWPy2A=; t=1745580774; x=1746185574; 
	b=W75GO4HDBQaE7ykUJXAPK8bLamiClJle9no7OMVD9h8A3IX3+ESuyyQgGZi0EnAGt1y9dH4uqmv
	y7FD9p78G4mhBiVT0ZaQNY8g3LjqZyN9FySVEAGy5+RSnjbzM+ZKL7krrB1kST6QY1+jY/7lYt0M+
	7pZsfp1/oQqi0+GaoclF1BouHNHDxkpCIBUNub3Qgn6MTaajcB4k146wG41j2cNwS6fxNXP0LOogA
	IBz83KVbWQnItVZHCP51g5V6D1syQKdu7RBXxi/x+QLeHp4axzrJJ6+NbOgbnrEgzBWxrMACBsOIK
	TtAozYPKIgKPz3NgHTv8Yxq5tGQ5RKaAViiQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u8HIU-00000002On8-2QAD; Fri, 25 Apr 2025 13:32:46 +0200
Received: from ip1f11bac0.dynamic.kabel-deutschland.de ([31.17.186.192] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u8HIU-00000000k96-1asy; Fri, 25 Apr 2025 13:32:46 +0200
Message-ID: <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?= HFS/HFS+ maintainership
 action items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?UTF-8?Q?=E6=9D=8E=E6=89=AC=E9=9F=AC?= <frank.li@vivo.com>, 
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "brauner@kernel.org"
	 <brauner@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Date: Fri, 25 Apr 2025 13:32:46 +0200
In-Reply-To: <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
					 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
				 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
			 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
		 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
	 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
	 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
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

Hi Slava and Yangtao,

On Fri, 2025-04-25 at 10:17 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> > So, we need at first to check these issues. And it's a lot of work. :)
>=20
> That's a lot of test failures, probably many for the same reason.

I agree, there is probably one bug causing most of these failures.

> Are there any changes to xfstest? Has this been sent to the fstest mailin=
g list?
>=20
> I'm also planning to start deploying a local xfstest environment. : )

Would you guys mind help me create an xfstest test environment as well?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

