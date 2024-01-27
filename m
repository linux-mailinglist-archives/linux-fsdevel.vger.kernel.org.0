Return-Path: <linux-fsdevel+bounces-9206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030583EDB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 15:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7AE3B21A98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE7F28DC8;
	Sat, 27 Jan 2024 14:52:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2B2577B
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367143; cv=none; b=FGYB08sCjxMnvMKY98gyRZZ7D1K1uEfKqVU8F/0SCtBgFHemPw5vwdCTN4oNUAB8C7z7n9uLH9n/gPiChBl7ieJCKryi3S0eew7ADh5Nghmsx5LBkMde15ermX2fjsjjEjMqHwpz0Cj1YWWkxKqsL0WMIlb5yO6wM9uwswtM/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367143; c=relaxed/simple;
	bh=Be/y4DGVPbfmx4K3rGTzJCiIH9BNVn8X6ivVn+mUvI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=SyXuY1k30R823C+Caa8YBjk1bplTO0umiFQ/djAaLGhhgrUij8QoXa6pFOgy/hmekI/I4wzCL/lFhf1JEkg9hRuG3e7l+pvX7f8UaF+sjANjBshY8uSRtooXbzMk/hGc1brCi8UlZQ96pnQoOLslwXUgsyjODis+m5UvEgTayEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-lY5SiMHAMkCe7VPZSgwSoQ-1; Sat, 27 Jan 2024 14:52:18 +0000
X-MC-Unique: lY5SiMHAMkCe7VPZSgwSoQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 27 Jan
 2024 14:51:58 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 27 Jan 2024 14:51:58 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Joe Damato <jdamato@fastly.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Netdev
	<netdev@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Jakub Kicinski <kuba@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "weiwan@google.com"
	<weiwan@google.com>, Jonathan Corbet <corbet@lwn.net>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Michael Ellerman
	<mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, Steve French
	<stfrench@microsoft.com>, Thomas Zimmermann <tzimmermann@suse.de>, Jiri Slaby
	<jirislaby@kernel.org>, Julien Panis <jpanis@baylibre.com>, Andrew Waterman
	<waterman@eecs.berkeley.edu>, Thomas Huth <thuth@redhat.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)"
	<linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Thread-Topic: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Thread-Index: AQHaUCR+m5BGvEW2OU6rGFqZjiahCbDtv1nw
Date: Sat, 27 Jan 2024 14:51:58 +0000
Message-ID: <f99dd6cfe7744ed8b9cfe9489aa499de@AcuMS.aculab.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012551-anyone-demeaning-867b@gregkh> <20240126001128.GC1987@fastly.com>
 <2024012525-outdoors-district-2660@gregkh> <20240126023630.GA1235@fastly.com>
 <57b62135-2159-493d-a6bb-47d5be55154a@app.fastmail.com>
In-Reply-To: <57b62135-2159-493d-a6bb-47d5be55154a@app.fastmail.com>
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
> Sent: 26 January 2024 06:16
>=20
> On Fri, Jan 26, 2024, at 03:36, Joe Damato wrote:
> > On Thu, Jan 25, 2024 at 04:23:58PM -0800, Greg Kroah-Hartman wrote:
> >> On Thu, Jan 25, 2024 at 04:11:28PM -0800, Joe Damato wrote:
> >> > On Thu, Jan 25, 2024 at 03:21:46PM -0800, Greg Kroah-Hartman wrote:
> >> > > On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> >> > > > +struct epoll_params {
> >> > > > +=09u64 busy_poll_usecs;
> >> > > > +=09u16 busy_poll_budget;
> >> > > > +
> >> > > > +=09/* for future fields */
> >> > > > +=09u8 data[118];
> >> > > > +} EPOLL_PACKED;
> >> > >
> >
> > Sure, that makes sense to me. I'll remove it in the v4 alongside the ot=
her
> > changes you've requested.
> >
> > Thanks for your time and patience reviewing my code. I greatly apprecia=
te
> > your helpful comments and feedback.
>=20
> Note that you should still pad the structure to its normal
> alignment. On non-x86 targets this would currently mean a
> multiple of 64 bits.
>=20
> I would suggest dropping the EPOLL_PACKED here entirely and
> just using a fully aligned structure on all architectures, like
>=20
> struct epoll_params {
>       __aligned_u64 busy_poll_usecs;
>       __u16 busy_poll_budget;
>       __u8 __pad[6];
> };
>=20
> The explicit padding can help avoid leaking stack data when
> a structure is copied back from kernel to userspace, so I would
> just always use it in ioctl data structures.

Or just use 32bit types for both fields.
Both values need erroring before they get that large.
32bit of usec is about 20 seconds.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


