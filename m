Return-Path: <linux-fsdevel+bounces-57398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E6B21285
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A541885CB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344029BD9C;
	Mon, 11 Aug 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b="mJiQGzai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hope.aquinas.su (hope.aquinas.su [82.148.24.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66C1A9FAA;
	Mon, 11 Aug 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.148.24.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930732; cv=none; b=UX93CMlYqO3vNIFYf+hTu0MyjvzWPY0k+D46Ujl5m+/xwbA1xWqjHo2t71RMDFKc16C/oM56b6hctaHFS0AwyQW0qYqafKQ4+Ijk1z7ZYWPKI1XP8XNPvWECxLbiRbTdsTPKua6BvU3/1s2Y1EkXqXUpWxppVdU99lFTw7jTrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930732; c=relaxed/simple;
	bh=PXdYOYgd73FHHDvRPv4cGkZgpCXyLJxu+pvZwjd0ZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbkJiCK88Gb/1GMUkvgl88u0+iEbCALg5K3hpY/xnNAFI6w3kl3b/lpDiWlLpUKxhcE6TtUVS5N9tLgvlfO1NocexNMYIZE+CazDe8H8nMgWgHgDFbUAg3TNBs7OtCUsffFGW7Izd9r0ZY2X5bnfVC7pF8TaA9CECv2ll7FTdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su; spf=pass smtp.mailfrom=aquinas.su; dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b=mJiQGzai; arc=none smtp.client-ip=82.148.24.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquinas.su
Received: from woolf.localnet (host-46-241-65-133.bbcustomer.zsttk.net [46.241.65.133])
	(Authenticated sender: admin@aquinas.su)
	by hope.aquinas.su (Postfix) with ESMTPSA id 1FCEE6EBAE;
	Mon, 11 Aug 2025 19:45:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquinas.su; s=default;
	t=1754930726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXdYOYgd73FHHDvRPv4cGkZgpCXyLJxu+pvZwjd0ZFw=;
	b=mJiQGzaiph1tsFTO0lf6I8X4THO6ySWTWd5toIS+346D3dT4TNzdpLAnihg+YcQg5/uUzy
	FEJdb6wPrPN+gufrVW28vgMj4prW2+oSbXQ0XYXoIb05xqvQljauqaBRNISC5UD3sAFUak
	hCh/WM4T2mtI9ru9O9abY/uMCwYlK8BbVR5u8A0DaafGTzzKsq5UwCgyj6PdRq98Op30SL
	jpQ3NaQPj7c4VOiQE9D+KbeYKVZU0YKrLQgWMF+TRjbRqqltmyOFxj0nx9U0ZtOy35Kt7m
	JxGUNhNs3x+uLamgMpCrTDzqx35t3BIjbseTv6DBZf4ve2O51vAAaslAWtNYLQ==
Authentication-Results: hope.aquinas.su;
	auth=pass smtp.auth=admin@aquinas.su smtp.mailfrom=admin@aquinas.su
From: Aquinas Admin <admin@aquinas.su>
To: kent.overstreet@linux.dev, Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, list-bcachefs@carlthompson.net,
 malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Mon, 11 Aug 2025 23:45:09 +0700
Message-ID: <13820530.uLZWGnKmhe@woolf>
In-Reply-To: <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
References:
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

=D0=92 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5 =D0=BE=D1=82 =D0=BF=D0=BE=D0=BD=
=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA, 11 =D0=B0=D0=B2=D0=B3=D1=
=83=D1=81=D1=82=D0=B0 2025=E2=80=AF=D0=B3. 16:51:11 =D0=9A=D1=80=D0=B0=D1=
=81=D0=BD=D0=BE=D1=8F=D1=80=D1=81=D0=BA, =D1=81=D1=82=D0=B0=D0=BD=D0=B4=D0=
=B0=D1=80=D1=82=D0=BD=D0=BE=D0=B5=20
=D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=
=D0=B0=D1=82=D0=B5=D0=BB=D1=8C Konstantin Shelekhin =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB:
> > Yes, this is accurate. I've been getting entirely too many emails from
> >Linus about>
> > how pissed off everyone is, completely absent of details - or anything
> > engineering related, for that matter.
>=20
> That's because this is not an engineering problem, it's a communication
> problem. You just piss people off for no good reason. Then people get tir=
ed
> of dealing with you and now we're here, with Linus thinking about `git rm
> -rf fs/bcachesfs`. Will your users be happy? Probably not. Will your
> sponsors be happy? Probably not either. Then why are you keep doing this?
>=20
> If you really want to change the way things work go see a therapist. A
> competent enough doctor probably can fix all that in a couple of months.

Come on? It's been around for 30 years because it's financially beneficial =
for=20
some players. Should we forget about the letters and insults that flew arou=
nd=20
before 2018? The Code of Conduct wasn't introduced just like that. Well,=20
that's just a small remark, in general. The fact is, there are no objection=
s=20
to the technical quality of Bcachefs. The objections are exclusively about=
=20
Kent's personality and how he conducts his affairs. Maybe someone experienc=
ed=20
in resolving such issues and handling personnel conflicts could suggest a=20
solution? Analyze the situation and offer methods for resolution? Especiall=
y=20
since the problem is far from being solely about Kent. I suggest that inste=
ad=20
of threats, hasty conclusions, and quick decisions, we turn to professional=
s=20
with the right expertise, who are surely present in the Linux Foundation. I=
t=20
will take time, but it will help everyone become better. I hope everyone=20
understands that the right solution shouldn't be dictated by someone's=20
feelings or grudges=E2=80=94regardless of who's involved.



