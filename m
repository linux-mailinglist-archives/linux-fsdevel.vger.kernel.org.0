Return-Path: <linux-fsdevel+bounces-17078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E18A7600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D78E1F21DD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79355A0FE;
	Tue, 16 Apr 2024 20:57:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8D2375B
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301045; cv=none; b=tVP5CQQUvCNqkcBFiQPCUtQ8hagFqpb7wDR5jbb14pDydmjUHEmwyuNaPIacFLcg0lTCI/JUndrN7tIklbKRGQsdhnRX6c1C07V4KgGog8fwCIUdlPWu9sgUlaIn9CSRGem7TB8uLF8qBZflpdpUFCN9QtHpY2cznejMc2MqxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301045; c=relaxed/simple;
	bh=vUKXpiDqyT8T8DxSVN8Hs7fJBHzb8ojHCrAFFhTGZv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=T815+qOUGNp+r6HRIDTZig1OliqOGaEZxDUvUd30NBtimmsUAy7hLjPQXsUJIMgTilYxi8hfBfSp8j6nswiDhoEPVx7kfAM6tdhmNzsT/XKNlzUzkZHrYMoFG881JDtepAQci+lIF1CILq/1jh3Zw97zXhOpst6S++WBjCMFDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-W1bCR735Ndq7Qsyjp7sOkA-1; Tue, 16 Apr 2024 21:57:20 +0100
X-MC-Unique: W1bCR735Ndq7Qsyjp7sOkA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Apr
 2024 21:56:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 Apr 2024 21:56:51 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Al Viro' <viro@zeniv.linux.org.uk>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] seq_file: Optimize seq_puts()
Thread-Topic: [PATCH] seq_file: Optimize seq_puts()
Thread-Index: AQHaj3fscOebCwNNKkWKivYclXgg7bFrX8Cg
Date: Tue, 16 Apr 2024 20:56:51 +0000
Message-ID: <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
 <20240415210035.GW2118490@ZenIV>
In-Reply-To: <20240415210035.GW2118490@ZenIV>
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

From: Al Viro
> Sent: 15 April 2024 22:01
...
> No need to make it a macro, actually.  And I would suggest going
> a bit further:
>=20
> static inline void seq_puts(struct seq_file *m, const char *s)

That probably needs to be 'always_inline'.

> {
>=09if (!__builtin_constant_p(*s))
> =09=09__seq_puts(m, s);
> =09else if (s[0] && !s[1])
> =09=09seq_putc(m, s[0]);
> =09else
> =09=09seq_write(m, s, __builtin_strlen(s));
> }

You missed seq_puts(m, "");

I did wonder about checking sizeof(s) <=3D 2 in the #define version.
That would pick up the cases where a separator is changed/added
in a loop.

Could you do:
=09size_t len =3D __builtin_strlen(s);
=09if (!__builtin_constant_p(len))
=09=09__seq_puts(m, s);
=09else switch (len){
=09case 0: break;
=09case 1: seq_putc(m, s[0]);
=09default: seq_write(m, s, len);
=09}

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


