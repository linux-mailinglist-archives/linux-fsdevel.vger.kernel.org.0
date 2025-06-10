Return-Path: <linux-fsdevel+bounces-51113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2AEAD2D70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 07:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8241891874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 05:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4925EFB7;
	Tue, 10 Jun 2025 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DY1secjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A520FAA9
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534209; cv=none; b=CCCpqHn2SghOFQQgBFRiv2Vw8TjG4p8Jtp7dxiL9LUb0IOtt6p1Eb2huG0ajK3/5CDIoMOaF2bEaUkY3YBviKBF/vN20woEzlf3WyBzVXXHNzSX2hZltLKE3rKZSNN6bjGWZpM/bdFP44uSmGEgmSNiVDGNC55lByRFILuqWr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534209; c=relaxed/simple;
	bh=/Hq1XE1cf2Bd784fl1Lv7WWWP51tDxS800mT8bVMIug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wm3IL0Mqj3O5uNTPZ4l2fu/6Xu9X0qmW+OBoEWA0qOQplNLlVn9VKcnhwyvHCef3pBgdd7H0WTQ/0mlOJ3MllqG5DMzYqwpANljbuVX8cS3enfQDrKFAWRXAri9M/nyy8xblzlY/1QpqcYfTcbkg8bO4S5MhlmPq6TXsy26kta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DY1secjB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8/a+qrzf8rWImDeqZmAGcl8q0YC/fiA4HXKkK/m75GE=; t=1749534205; x=1750139005; 
	b=DY1secjBzsrn8bq1Z3k5YSb9vZkP0iVwlcKX9CfR0AZs1PUW7GblUPcDnddXkM08Uf+xMG9uidt
	CV4yaxRdEa6qcvjFSEH41gglEVcGYgL3GkZNEVxo8AoAnGw1ls1rA+GJgpxA3RdSVji+NpANe7VlK
	38yBfXqqNPlb0blTewcac4nWdAkgp23/fTn/CUnjA/8VqC3aGjf/m4oN5NLxea6p9TWVDmRarai2g
	Sxo1s6X/fxunQvMbIZCBdPwakIOmsv8uXOMJ34ok+L5rRsewPdOb/o1LOPGSW91VngJFAZIJUn0xr
	oJQJ/6+KUXq/57AzzDN/GnIvjMx3QFfrrDvg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uOrla-00000000xPB-3mvg; Tue, 10 Jun 2025 07:43:22 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uOrla-00000000DJy-2vC7; Tue, 10 Jun 2025 07:43:22 +0200
Message-ID: <27fffebd97c65f20291bfe54ba5e824bcbf579a0.camel@physik.fu-berlin.de>
Subject: Re: [HFS] generic/740 failure details
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com"
	 <frank.li@vivo.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date: Tue, 10 Jun 2025 07:43:22 +0200
In-Reply-To: <7c676b6fe21c84033d34a09f4a02f2eb8746bce8.camel@ibm.com>
References: <ab5b979190e7e1019c010196a1990b278770b07f.camel@ibm.com>
		 <5b8df0f3-e2da-43d4-8940-0431429eccee@vivo.com>
	 <7c676b6fe21c84033d34a09f4a02f2eb8746bce8.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Mon, 2025-06-09 at 19:41 +0000, Viacheslav Dubeyko wrote:
> Frankly speaking, I don't see the point to re-write the hfs-progs in Rust=
 for
> multiple reasons:
> (1) mostly, the main use-case that HFS/HFS+ partition is created under Ma=
c OS
> and somebody tries to mount it under Linux to access data;
> (2) Apple is the owner of the code on Mac OS side and it's not good to
> significantly deviate from the Apple's state of the code;
> (3) I believe that Apple considers hfs-progs as obsolete code and they do=
n't
> want any significant changes in it;
> (4) the hfs-progs is user-space tool, it is not frequently used, and even=
 it
> fails, then there is no much harm.

Writing hfsprogs from scratch for Linux would mean though that a proper lic=
ense
could be chosen that is not APSL which some distributions consider non-free=
.

On the other hands, the current hfsprogs utility is based on Apple's origin=
al
HFS/HFS+ code which is battle-tested and known to be reliable and robust. I=
'm
not sure whether we would be able to reach this level of stability within a
reasonable amount of time.

I do have to resume my work on my Linux patches again so that we can synchr=
onize
hfsprogs with the latest upstream version.


Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

