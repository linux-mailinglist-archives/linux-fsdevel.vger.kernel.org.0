Return-Path: <linux-fsdevel+bounces-50814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6AACFCD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC35179381
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAF266565;
	Fri,  6 Jun 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UKAV0P9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986C25DAE8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749191490; cv=none; b=HOqSnIF+1paqcN2aNUzmbmGWqWX+PglWkOAxQJNMmhARWPihmDydwCgNVCSYvMsC3l84cM7V319V8Sl7u2CrqNKtr1L/k0ER52dBUKgV6M66iZwcsgfrPn17W/yvBXOSJX+WSPLcyy7mla3jyEu/miPMP+MxuNPODLWKugORGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749191490; c=relaxed/simple;
	bh=5o4fhkrQDumsCHQGBueGJE5jUAmRfcS8M5WWpNu7+fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jeUw0mPf82KHI2n447W5jhkAH7LmHJoHQF5lO5WNOlWlBA8dgDddZJiDkJStD/fnC2k5OscbP4msIY+uHFRlS+MsCg9BU9ch+GNeK36liAv+pbizkpn50CdFilKhj5Ue7bwBMzYHvdtULlitsyIbpu5HTvpoemZGTFRynksU0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UKAV0P9/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Sk/p6tehgdiEyE+xwfCZS/wGDj6phHAb4KFpdTHBvk=; t=1749191487; x=1749796287; 
	b=UKAV0P9/1aqRhTjGmpKiJd5ZuDAEy7k8/lnxLl4/bEPBZSigPwXWKrJl72340SJOLGAc+LmSujl
	bm0IuXSGjDIXGqHoVS8xUsWwVL+NERdTuiwRVt02Up2mxWa+irs5cAUdpsx3ZtPfqI7geoGhbJCZq
	S16d6PmxexztUE5YYhU99WS1ofErGEDaYRGv13VDBs4cFcVODnAguZDSs8eLqFKw/4RbSkqyL7ye6
	lD2RtD2mi1xsVxWKJheLjvQ+u7N+iHL0GFah1ebYVTj1q+Zl7y18+KdhOgf/JdcbXqUuQDR6DNfq1
	dHN8wp0S+npARb2thSBrOz4GX+3GxWofSVdg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uNQbs-00000002JhI-30lx; Fri, 06 Jun 2025 08:31:24 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=suse-laptop-4.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uNQbs-00000003Lzd-2BVC; Fri, 06 Jun 2025 08:31:24 +0200
Message-ID: <7d3c595141e8ce70e0dd4b0b6fe28bfc7649bd2b.camel@physik.fu-berlin.de>
Subject: Re: [HFS] generic/740 failure details
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com"
	 <frank.li@vivo.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date: Fri, 06 Jun 2025 08:31:24 +0200
In-Reply-To: <ab5b979190e7e1019c010196a1990b278770b07f.camel@ibm.com>
References: <ab5b979190e7e1019c010196a1990b278770b07f.camel@ibm.com>
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

Hi Slava,

On Thu, 2025-06-05 at 22:41 +0000, Viacheslav Dubeyko wrote:
> It looks like we need to modify the HFS/HFS+ mkfs tool to refuse the refo=
rmat of
> existing file system and to add the forcing option.
>=20
> Adrian, How does it feasible such modification?

It would be certainly possible although we would deviate from what Apple
does upstream with their hfs utilities. I'll add an issue in my repository
for hfs for Linux [1].

Adrian

> [1] https://github.com/glaubitz/hfs/tree/linux

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

