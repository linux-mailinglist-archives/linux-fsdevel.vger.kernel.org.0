Return-Path: <linux-fsdevel+bounces-27784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C296400C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3BA1F25394
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CBE18CC1B;
	Thu, 29 Aug 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="ZnnJE8Wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8C2B9CD;
	Thu, 29 Aug 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923693; cv=none; b=C2gBjy3bmd82WHs7Wnt8saSb/8hOx5ItcgJsL4NT4+RWNz28UaUAMmi7esK6EOin6HIbMQIyvFZaxwJTr1h74mscBzuAfV0DPUsIyGulB9hQgPbDoXcjZ+nnGofoWcfsMSZMwr2JCEx/d/lgxmQ8W+z48zki00VNev4pzH1s13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923693; c=relaxed/simple;
	bh=Ugvaq5GN5dLTmJoIXl/pkt3FdWzOygZUrW/0oYrQBC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSwoKBU6gk8hXMdEIPyeJ5FfSsY5/0U8S3v6XeiHwjiHnRWAHU0szXq2kGGH9EJtTBUYgMFdFS/FsncPr1z7BLAawEwpL8aT77udviMTw3i6e6D5XYe0aNEjsFiaJwYtduTQMhuMZORQJwyj6aBWmJC3YIt0cul326Wqx4Gzkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com; spf=pass smtp.mailfrom=ziswiler.com; dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b=ZnnJE8Wj; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
	s=s1-ionos; t=1724923668; x=1725528468; i=marcel@ziswiler.com;
	bh=Ugvaq5GN5dLTmJoIXl/pkt3FdWzOygZUrW/0oYrQBC0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZnnJE8Wj1q94jqg/tqzme/1U9wLX+/0uAL4b46BeU03nWqKPaKyUi8VNTOAYJKee
	 ajAbM1E0GqMVVdf7MY+qasGr0qNh76MWiRONlgeG7wRZwCg2JfMnD2vsxq1sZsa3K
	 Z/ukuptncKSV6E1mFp+2KfE+FECV2xB4O+yJKvmZyRGp6J8ZiU12VsKsiMPzz82uc
	 dDL1QFOuOwW7HiyBJI3AQ6gCdNsLPu9yFo8YhBs6K1tom9kOUlC8icix0MuyIcXfo
	 INlP7AYJkVPl9+jN2uiTzTeLaxpkM7x4EPaMIdFsf+SMKMs9Y2z2RADUYCscx4OkS
	 xOvDU1A2d1U++sd5+g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.123] ([84.227.224.111]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MeyiN-1sQ7a62yYz-00RrsO;
 Thu, 29 Aug 2024 11:27:48 +0200
Message-ID: <23a1d750092f4ae85364ee73b8efa1c7653db86f.camel@ziswiler.com>
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Miklos Szeredi <miklos@szeredi.hu>, =?ISO-8859-1?Q?J=FCrg?= Billeter
	 <j@bitron.ch>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	regressions@lists.linux.dev
Date: Thu, 29 Aug 2024 11:27:43 +0200
In-Reply-To: <CAJfpegtNF4yCH_00xzBB1OnPBHk+EP0ojxDPp=qCFVKC=c14ag@mail.gmail.com>
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
	 <ZrY97Pq9xM-fFhU2@casper.infradead.org>
	 <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
	 <ZreDcghI8t_1iXzQ@casper.infradead.org>
	 <CAJfpegvVc_bZbL1bjcEbEh4+WU=XVS94NMyBPKbcHzAzyxM6_Q@mail.gmail.com>
	 <ea297a16508dbf8ecfa4417cc88eef95b5d697e8.camel@bitron.ch>
	 <CAJfpegsvQLtxk-2zEqa_ZsY5J_sLd0m4XhWXn1nVoLoSs8tjrw@mail.gmail.com>
	 <CAJfpegtNF4yCH_00xzBB1OnPBHk+EP0ojxDPp=qCFVKC=c14ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:xA2rD6kqUFKuEtdC8gREy5oOQtSGtZzUVVVjUb3KQufWKVm9ioN
 vZsDL9T+Q47HaIVPVR0AH4f/u6XIgNw0SZ3GknbMbPFZ7bO7eeAypelqPi8xr5SrOEskSou
 FQrafUtxPGcSFLzFKuV2wLXfLrV6d3DJGvYh0RLqXE/TAxuiE0vPfsJ6EaoNh9F0Jf8W5Pz
 rX6ZIl6eJpizgjSm+5cbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SAuLtyQYq24=;WYqnK1rDl47tGkp8SpYdwR3x6+f
 tmJ7YNZw7aCEvXyWGzspnD5SuuvZ+cM/bHhictPqSltC/UOkSE/l6qRAq8T61qGh6DxilyNwn
 ZDLsd1PvHG6S1x3/LZtpylPzwUTthujOA3gOnb5hyEj7WLBcqJMF9YbcgUEUQ/g/AqyW+pGZ1
 32Ma+iQ/8C6viSdF/SIHm1Ao60Qt6iwEyF4pmfRL6HWMQNgTc6YRuQ6FT2Xcz9JUZp5P+NS2P
 +7n0j3Aat1x//ClNIn7no/PiH+pAu54n1j4sWqRBu9xro+77qS29iPtSg7KUSmpQOjrSNNnaj
 n/wNhGha4m0kOj2sQ52hYtgdejrZmZXObWXWL/IPpA9RouSjgO3XT2Sfaz2aTJuxiuP/RXZw5
 7Gt5IuA9Zzuj2iRfqUpsa5oWEkPFuhg7f+rqQ1yM6oNZqrDt+GX8HPd0vZx30BIRUWJ7kapUS
 WAXT5FIX+cdgF6Dd6H6+YUhLkOAYM2QkH4wwlMfuVF7Aj04vvr1C5NCHXrZnIFR6bz1SRhoxw
 0PloxLRyA8bo5O0Qu9gJ+eOkRtKS5ODFyaxHXe2Kmv2Y34x0opZqyzLgqG9zYzq7D8F452SRD
 2lLrodUZHoIoBy41c7sdMs0HEV0+KcZo2urzxReryaoqQExX+hjEKxtLyo5AcLjul+JeHHNMG
 eChPNbk9V2leE9HUvg9d8UPGqk5sak/gnmbiS4WJbaloBIzNFA6VRW+U4yAcUf/1ECxKHZFBX
 pGQPW/IGwX1VSlGuIVxy3I7ln5SxriADA==

Hi Miklos

On Thu, 2024-08-22 at 15:32 +0200, Miklos Szeredi wrote:
> On Thu, 22 Aug 2024 at 15:14, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> > > > What I don't understand is how this results in the -EIO that J=C3=
=BCrg
> > > > reported.
> > >=20
> > > I'm not really familiar with this code but it seems `folio_end_read()=
`
> > > uses xor to update the `PG_uptodate` flag. So if it was already set, =
it
> > > will incorrectly clear the `PG_uptodate` set, which I guess triggers
> > > the issue.
>=20
> Untested patch attached.=C2=A0 Could you please try this?

Any progress on this?=C2=A0I can confirm that it does also fix an issue I n=
oticed on Fedora Silverblue 40 running
6.10.6-200.fc40.x86_64. I successfully tested this patch on top of latest k=
ernel-ark 6.11.0-
0.rc4.872cf28b8df9.39.fc40.x86_64. Thanks!

> Thanks,
> Miklos

Cheers

Marcel

