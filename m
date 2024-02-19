Return-Path: <linux-fsdevel+bounces-12052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099F085AC1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B97284075
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7551C4A;
	Mon, 19 Feb 2024 19:35:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AA50A6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371336; cv=none; b=jQIuKqJ/rnMKTNWvgoiV9LWmjxdVPWrNDpEEgLEYEWn7pXE2K9xL7VvMQnSiCi4UxstuijGFht8uXjjZXkuT7tXBXex+xhkvG/Ieo7TslgP35W7e48J4NzQdCyzVZo6OSu9Nw1cC2rPFpiTZwtOEiXGqxkiFFS1PPpMbca+odQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371336; c=relaxed/simple;
	bh=+5margOpW4CvmYp3SbztDJ9DbM635NMYbVyCCAkM8Cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Gk6zo3S20AUHLi6EUE0gpVy7ii3Ks1sCYSpqFEg0FRUwdW+32a9+CH2WrsKGZo4sh2v0elUVHUMZ3v5Ta18PjoiPCLsaXLSZaBM+b/MjN7UmgaP+V2MHjDR4ITZMlJpbrTwh7IWdoMIZB/T2pPzx1oH63UEYWKgeishbHt753ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-314-iR3pvq1wNXunpGpx55236w-1; Mon, 19 Feb 2024 19:35:25 +0000
X-MC-Unique: iR3pvq1wNXunpGpx55236w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 19 Feb
 2024 19:35:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 19 Feb 2024 19:35:24 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>, "Arnd
 Bergmann" <arnd@kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Kees
 Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] fs/select: rework stack allocation hack for clang
Thread-Topic: [PATCH] fs/select: rework stack allocation hack for clang
Thread-Index: AQHaYlVmebUOAwzLC0yN/tKvvf8iVrESDxTg
Date: Mon, 19 Feb 2024 19:35:24 +0000
Message-ID: <029aeaa162a64758a548938d5b382cb3@AcuMS.aculab.com>
References: <20240216202352.2492798-1-arnd@kernel.org>
 <ZdHZydVbQ7rIhMYV@tassilo>
 <3a829098-612b-4e5a-bcec-3727acee7ff8@app.fastmail.com>
In-Reply-To: <3a829098-612b-4e5a-bcec-3727acee7ff8@app.fastmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Arnd Bergmann
> Sent: 18 February 2024 10:30
>=20
> On Sun, Feb 18, 2024, at 11:19, Andi Kleen wrote:
> > I suspect given the larger default stack now we could maybe just increa=
se the
> > warning limit too, but that should be fine.
>=20
> I don't think we have increased the default stack size in decades,
> it's still 8KB on almost all 32-bit architectures (sh, hexagon and m68k
> still allow 4KB stacks, but that's probably broken). I would actually
> like to (optionally) reduce the stack size for 64-bit machines
> from 16KB to 12KB now that it's always vmapped.

Hasn't the stack for (some) ppc64 been increased to 32k to try to
stop some recursive network code (of some kind) exploding the stack.
(This causes grief when the stack size is doubled for kasan!)

I really don't understand why the change isn't deemed necessary
for some cpu types (I think ones that are likely to have less
processors and less memory) because a small amount of the same
workload would explode a the smaller stack.

OTOH more pressure really ought to be applied to remove the recursion.
Unless you are trying to calculate the ackerman function (don't!) it
is usually not to difficult to convert recursion to a loop.
More than one level is really asking for trouble.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


