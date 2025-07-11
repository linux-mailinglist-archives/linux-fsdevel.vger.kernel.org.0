Return-Path: <linux-fsdevel+bounces-54607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C33B018C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FEDB4749F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D54427F007;
	Fri, 11 Jul 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="khfDsRpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5827CCEE;
	Fri, 11 Jul 2025 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227361; cv=none; b=BzjxpKLvmMV0sz9GBLmm457skwRUoCGFvsq74K8kOG9iqx+lyM/msUNJhA+6yKy7KQdyyXoifINKQtDaQsE1n+3l4GktYn4xYCIrtU+7mFU8Cjk8quSKVnwWUWbHuhhZVe3qdl+MinOn/IsrC/7NuPkJUBotnDKRM/QUF30o4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227361; c=relaxed/simple;
	bh=OFqeW5JZMl9wQNRy6aXIuRDpt7LacH3LfdXBhsVYWcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8lNZ75WRbiTkhS+E0tZs+IumQWeu1wioMYqYeJc1H81+AKrh7qwGdYx55TxURdMW64HQtR4enfTk1kD/v87VA+rarfVBymHfi6xHcpgl2dGjRke3RhxEF0nRY+K6BfEQAnLUeppBENaA8ABqZq00lMe/4i91J4k3bwbaTsKBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=khfDsRpS; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1752227351;
	bh=gZBQkqjNAPMPDfAyWwddtLFuhgnMCaqiylfHI707JNs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=khfDsRpSX1FhjrvbPEY/FfqEdlSApy8cs2OjDQSV3kDf4fPG5k6WoUFn62OOGIIe6
	 D3LzfEyzAX19CHj9QQX+IzkK02ckal6fOrhW94JsPnQieYjwVKWX4uStK0n9IGV6ru
	 qQbJMZhdMLpzej+trRXvbro1lRrRnTGb45vnF4RY=
Received: from [IPv6:110::1f] (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D941A65F62;
	Fri, 11 Jul 2025 05:49:03 -0400 (EDT)
Message-ID: <6856a981f0505233726af0301a1fb1331acdce1c.camel@xry111.site>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>, Nam Cao <namcao@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider	
 <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara	
 <jack@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John
 Ogness	 <john.ogness@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, Joe Damato	 <jdamato@fastly.com>, Martin
 Karsten <mkarsten@uwaterloo.ca>, Jens Axboe	 <axboe@kernel.dk>
Date: Fri, 11 Jul 2025 17:48:56 +0800
In-Reply-To: <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
References: <20250701-wochen-bespannt-33e745d23ff6@brauner>
	 <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
	 <20250710034805.4FtG7AHC@linutronix.de>
	 <20250710040607.GdzUE7A0@linutronix.de>
	 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
	 <20250710062127.QnaeZ8c7@linutronix.de>
	 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
	 <20250710083236.V8WA6EFF@linutronix.de>
	 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
	 <20250711050217.OMtx7Cz6@linutronix.de>
	 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-11 at 11:44 +0200, Christian Brauner wrote:
> On Fri, Jul 11, 2025 at 07:02:17AM +0200, Nam Cao wrote:
> > On Thu, Jul 10, 2025 at 05:47:57PM +0800, Xi Ruoyao wrote:
> > > It didn't work :(.
> >=20
> > Argh :(
> >=20
> > Another possibility is that you are running into event starvation probl=
em.
> >=20
> > Can you give the below patch a try? It is not the real fix, the patch h=
urts
> > performance badly. But if starvation is really your problem, it should
> > ameliorate the situation:
> >=20
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 895256cd2786..0dcf8e18de0d 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1764,6 +1764,8 @@ static int ep_send_events(struct eventpoll *ep,
> > =C2=A0		__llist_add(n, &txlist);
> > =C2=A0	}
> > =C2=A0
> > +	struct llist_node *shuffle =3D llist_del_all(&ep->rdllist);
> > +
> > =C2=A0	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
> > =C2=A0		init_llist_node(&epi->rdllink);
> > =C2=A0
> > @@ -1778,6 +1780,13 @@ static int ep_send_events(struct eventpoll *ep,
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > +	if (shuffle) {
> > +		struct llist_node *last =3D shuffle;
> > +		while (last->next)
> > +			last =3D last->next;
> > +		llist_add_batch(shuffle, last, &ep->rdllist);
> > +	}
> > +

Sadly, still no luck.

> > =C2=A0	__pm_relax(ep->ws);
> > =C2=A0	mutex_unlock(&ep->mtx);
> > =C2=A0
>=20
> I think we should revert the fix so we have time to fix it properly
> during v6.17+. This patch was a bit too adventurous for a fix in the
> first place tbh.

I tried to understand the code but all the comments seem outdated (they
still mention the removed rwlock).  IMO we'd at least clean them up...
and maybe we can notice something erratic.

--=20
Xi Ruoyao <xry111@xry111.site>

