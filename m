Return-Path: <linux-fsdevel+bounces-47861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62EAA6390
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801D53AEA5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE822539C;
	Thu,  1 May 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="loQTpKA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F32215191;
	Thu,  1 May 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126670; cv=none; b=lxyDx8SnOw/v2AUUCSYlawCaQI8ko4KaPkFNhQBPvr4AhRh+hjduNe1v7yDvbh3vyI0BApKd2lRlckT2NySquqchvrsH/Bsk+ciKqyxxGifbWnCfLaOjbUVLG62po/wHPA12fgUCK284kQjn5pXk00HG1lxACXp1bDP2wai3vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126670; c=relaxed/simple;
	bh=U2FU1esoCVqO1kIjHH+nnXJfMZetiBwlh+rkrZjBlI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHBw7VutIJc5hyqsx2HcU6dzaXw6U1sCVgKBFD2tOtC9rhvdK0dEfgPSyoZyVbkytnxYxFAZ7OyvEUacmiM2Q/gy2H4AshLjJc4pqV56SGZbklvakqiM9Fi9aUgGO/HlXxURAFnC4JLF1wCXvDb6IYRwPCoa8MEklNwkuQGDUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=loQTpKA0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qLsJOZMO3rfwlxNGV9d6qf89gtfbcWNjdy6FOcZ/E84=; t=1746126666; x=1746731466; 
	b=loQTpKA086O1XM6nIzCYJqYBw1WZmFdinjunPjPMt0zJOFPptlcEMJoZdTY0ALGfBUyi0QzqTTd
	7g8aIpdu9Fg6aC2MXgmMs6UGt4gY9dp4dU2KC44ZuKuhTWqFJhPQ4+LoViGmBEW3k6GWZptLauWw0
	yUggt3sv1tdmWRloNQTJTQ6bDSbNIPnyBGzsA4sSW8pXd7T3uQehmtsf/J5danic/Rt1BSmeKJAL8
	yjQEXDFF7T8t1wMUxlV+CmTyzuKeRoGxholy986XaeE5yl/DRcH5h0kGapDV2hyST6WPnYluBgyxq
	pc1fhWSy7A1aoTTlWF6AqMyZn4TIn9EDoifA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uAZJC-00000003UHR-1r2F; Thu, 01 May 2025 21:10:58 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uAZJC-00000001fiT-0t6M; Thu, 01 May 2025 21:10:58 +0200
Message-ID: <082cd97a11ca1680249852e975f8c3e06b53c26c.camel@physik.fu-berlin.de>
Subject: Re:  =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?=  [PATCH 1/2] hfsplus: fix to
 update ctime after rename
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com"
	 <frank.li@vivo.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 01 May 2025 21:10:57 +0200
In-Reply-To: <b0181fae61173d3d463637c7f2b197a4befc4796.camel@ibm.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
		 <d865b68eca9ac7455829e38665bda05d3d0790b0.camel@ibm.com>
		 <SEZPR06MB52696A013C6D7553634C4429E8822@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <b0181fae61173d3d463637c7f2b197a4befc4796.camel@ibm.com>
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

On Thu, 2025-05-01 at 18:57 +0000, Viacheslav Dubeyko wrote:
> On Thu, 2025-05-01 at 12:01 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> > Hi Slava,
> >=20
> > > Unfortunately, I am unable to apply you patch. In 6.15-rc4 we have al=
ready:
> >=20
> > Why can't apply?
> >=20
> > > Could you please prepare the patch for latest state of the kernel tre=
e?
> >=20
> > In fact, I applied these two patches to 6.15-rc4, and there were no abn=
ormalities.
> > based on commit 4f79eaa2ceac86a0e0f304b0bab556cca5bf4f30
> >=20
>=20
> It's strange. The 'git apply' doesn't work, but 'git am' does work.
>=20
> git apply -v ./\[EXTERNAL\]\ \[PATCH\ 1_2\]\ hfsplus\:\ fix\ to\ update\ =
ctime\
> after\ rename.mbox
> Checking patch fs/hfsplus/dir.c...
> error: while searching for:
> 			  struct inode *new_dir, struct dentry *new_dentry,?
> 			  unsigned int flags)?
> {?
> 	int res;?
> ?
> 	if (flags & ~RENAME_NOREPLACE)?
>=20
> error: patch failed: fs/hfsplus/dir.c:534
> error: fs/hfsplus/dir.c: patch does not apply
>=20
> git am ./\[EXTERNAL\]\ \[PATCH\ 1_2\]\ hfsplus\:\ fix\ to\ update\ ctime\=
 after\
> rename.mbox
> Applying: hfsplus: fix to update ctime after rename
>=20
> Does 'git apply' works on your side if you try to apply the patch from em=
ail? Is
> it some glitch on my side? As far as I can see, I am trying to apply on c=
lean
> kernel tree.

git-apply is for applying plain patches while git-am is for patches from ma=
ilboxes.

I would suggest to always use git-am after fetching patches using "b4 am <M=
SGID>"
from the kernel mailing list.

Please note that when you apply patches with git-am, you should always use =
the "-s"
option so that the patches are automatically signed-off with your own email=
 address.

Btw, can you push your tree somewhere until you've got your kernel.org acco=
unt?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

