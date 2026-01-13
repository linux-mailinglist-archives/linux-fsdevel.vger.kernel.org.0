Return-Path: <linux-fsdevel+bounces-73446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233FD19B71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A048D303EF91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3752D94B2;
	Tue, 13 Jan 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOQMS7ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF312D8399
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316717; cv=none; b=r+nL2HhWhLUdZulEWc2bpJs8FMLLinHsW1zK+u6G7oTqu1hjG7lLTLvi+YrjmnkDr9J8bsmM4YgRdl0sgzWIpNqVFU344sCDyhgL2/LH9VTva4GMmcVR/t8GktR5HzlAetAB3pnXJVj92QIz2IRCfOQEaxcx7tluwNDbsF+SIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316717; c=relaxed/simple;
	bh=IajE/RDiMSZDaZL6Q9VmcgOd8JM7GhITwbxAZ69U9lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW2hWndWSVXde6WZTNq6+NdrpZymDwZN8hMKShvSCAyKpyIqIcsONrWH7vD0XlVR/KwpJ1X3/h0l8i/2DJWldKINnpZ3vXwsMSo/lmV3ybVch/hG4JqmFLCusVqCkCGG7F2UI8ygIkg0xNg/pUearUQLik3WF38S4xvGN3sd6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOQMS7ug; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso6773704d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 07:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768316715; x=1768921515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kDbV7EO4CDUad3xRjXJRBiYGHlez/VaykiXlOPqSMA=;
        b=VOQMS7ugiaIfzJkVX9N+phadks6DCLrxK55anXRwW9XgOmUBEP7YIc87h/iWW0Pthq
         oV1JkJZAn8bWAIwHEILvv4sHE9dtQIjLYQIA0+zCC0BsRC30j8Lu2T15oir199ZCx9N5
         3nZlC+cOT+5PTHIWQo8562YhEM15+1Ed0a1l9t6Sc54gqeXKmpQKItroMnVPDcba/UPw
         9T+tYax5SJxqt4hx3sn6RlESzFaS0DnU92znkIxlrV6dw+Gm+DSeWYYyNruf5Hgh9bqp
         ewzecWSxowaGheEvMW3YvQv1Np6gBM7xWvWTuUvRcto2tUoEDBovNFmnNUS6V77qUiTY
         OohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316715; x=1768921515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kDbV7EO4CDUad3xRjXJRBiYGHlez/VaykiXlOPqSMA=;
        b=hH2321fRkRiqa3VgdizAePzE7F4Rpt2DH+OwCS3KqqI0Qi3mMvgPWIfKn0zyYP2E/J
         vYcioUKgk6Vo+7KUsYBTx0q4oL9Twi0AMxHy1FYM/a45iVUgVeq/d8I0Vji0vC5XtxXO
         ZeW6WcNT9mOIlNNZdmYjSCeTa7oLF7tOj39jMiGyGav3UyR9YIntgmI5JDpPmP7P3jFp
         SB5wVnPXsCMQCzkFrFc7rC0vtSqZU/Njq1R6nNV5qGjdL5TGtw5eF9pO4rZamWXBi9R2
         4MtqlKnDpD3Wa6vt3AwoS08slWhP/faOOXiiZoBoigeGmqq/g+IkVfA/cBDO91mtdX3a
         eHVg==
X-Forwarded-Encrypted: i=1; AJvYcCWJg/sx5isRKD+GmT3yNwE/rpsjWxM//0fFYE8bQk3LxqMN+hW1o7Dmw4278g/oRD9h16ReFtbWgc/6JBPt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zg+v35Oh21HNhRSFG7ol6cjpVfsrxAr7WFAt/OoZvaPWGI8f
	oaVpWe7eQJizQHBR7yXerd5g/QxN6uqwIP22zLdfY9fNEMoAQ1hgaEnP
X-Gm-Gg: AY/fxX4w7icSY9Xvy+maI5YvxAchkMa12ERhePOqiOcufLJIG1xB7SPI0xZ5PyL6wrf
	36lJoQUTaICLbgdgIYCAJ1pqe3CoFR0xjxJ+O1c+KHCRX62KspG4+etVqBmSH8O7/bpn6q0v5Ks
	RmYFrogomAJ3hMX1A3rbmN0gm9jBi48fMcY+7vBnl0lCEVq3h3HJahLas2RxzUqj1QpRyotRk3o
	79r9hB5QnY6JcP/+fqQOZXIbbza3XNRZrA7bqrH/6KE3BpYj8xp7JVu3lJ6qVlu21o2N1Z9FeeE
	8YYEqYykL5oLG5hB7JMJjhvRw5dj5Nynk9vqSm3EcSyUDvMulPplBTnvcq4W0Dh2Obnr0VgsF3/
	vFF5Q8g2wSpoJQnQ+KnsNR+Wif432PUwodGidT6vDUAKedvWqn2SVJQTAdRG9np5aEqEugU8WdW
	RH
X-Google-Smtp-Source: AGHT+IG5CKDg3eU1xRiEoR1orSGz3fHOZ0yR7fGakmywNXg28jaP+Ar6w5Lvmtev/hzTR3irHHJyLw==
X-Received: by 2002:a53:dd03:0:b0:63f:95dd:b2c9 with SMTP id 956f58d0204a3-64716c4535fmr15016640d50.58.1768316714532;
        Tue, 13 Jan 2026 07:05:14 -0800 (PST)
Received: from illithid ([2600:1702:7cd0:e980::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa67c039sm80329087b3.28.2026.01.13.07.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:05:13 -0800 (PST)
Date: Tue, 13 Jan 2026 09:05:10 -0600
From: "G. Branden Robinson" <g.branden.robinson@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages] man/man2const: document the new F_SETDELEG and
 F_GETDELEG constants
Message-ID: <20260113150510.74mmegkp46dmd5uv@illithid>
References: <20260112-master-v1-1-3948465faaae@kernel.org>
 <aWZIQA3GJ9QCVywE@devuan>
 <14e88ee6ff3ffd671f579d103c53ebe98b4f92e2.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rmdsxzqejgaw52xw"
Content-Disposition: inline
In-Reply-To: <14e88ee6ff3ffd671f579d103c53ebe98b4f92e2.camel@kernel.org>


--rmdsxzqejgaw52xw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH man-pages] man/man2const: document the new F_SETDELEG and
 F_GETDELEG constants
MIME-Version: 1.0

Hi Jeff and Alex,

At 2026-01-13T09:45:11-0500, Jeff Layton wrote:
> On Tue, 2026-01-13 at 15:13 +0100, Alejandro Colomar wrote:
> > On Mon, Jan 12, 2026 at 01:47:11PM -0500, Jeff Layton wrote:
[...]
> > > +.br
> >=20
> > This .br seems superfluous.
> >=20
>=20
> You would think, no? But when I remove it, man seems to stick both
> lines togther. I really do not grok groff at all.

Try the introduction in groff_man_style(7).

https://man7.org/linux/man-pages/man7/groff_man_style.7.html

> I'm happy to accept other suggestions on how to fix that though.

Here's the hunk with context:

+.EE
+.P
+.BI "int fcntl(int " fd ", F_SETDELEG, struct delegation *" deleg );
+.br
+.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
+.fi

The `br` request really is necessary there, as Jeff says.  This is an
ordinary paragraph.  The `EE` (end example) restores filling.  So you
_do_ need the `br` request here _but_ you can discard the `fi` request
to enable filling afterward, because it's already on.

An alternative will become available in groff 1.24.0; you'll be able to
use groff man's syopsis macros to set C function protoypes.

https://cgit.git.savannah.gnu.org/cgit/groff.git/tree/NEWS?id=3Dcfcfe1dde5b=
1752484dcd94dde1d65c65a5540fb#n409

Regards,
Branden

--rmdsxzqejgaw52xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmlmXx4ACgkQ0Z6cfXEm
bc5xkg/7BBDbjNPf32TMbY6bG1vVzw8rhaeMlPYLeSwOqHfajthPjHjBxLOeSeNh
e7UiV16/jBx4Uk5DqPRGeWqVvk5PBYlPhntuaqA0ZoIXMGg1A0+xq3CIUwagBdlk
Oll5RBs5Ts/OKz8pjYCZ8+xMpeTHJSri4h1JEN9x72vGShqdf9Bs5T6D5TpCZrur
Op3W4qY4GCdEkZ6MelhRzzGBm+PIu/SYTEqmsGatcJ1oV2Pcwl8hT1fkjW1nUdWt
JD3ufDc/CVojdLjXWUeCASJrXOSkuToksC6TGRu98N4oQspOUhojB+pdR7GFcGQN
RJ+c2m8YFp6owX+HqF0of9IfFcqWljTaoFnBncUS64P/kXXGFHWSNRXcc8EHyqfZ
q97X1pY75F2AGhZYUGyrp1Jx+uh1oaUO9ZsrfxUEjzfKO/F30d25BrNcLaTnJvIn
yIH7JxR92/OJsO33cgKw8LHxZBeAUHsFjfo1HSsnxOBm14ttwHFIbpeFyF8mH3zu
+SnC9VQTQapDp6P2TVnIbeOE/RbwHqpUXIJFsnBpVUvpRod3BWOtI0y8e2oFBhhK
QWlbBaLM7lMDFZNGHsYN/s7cIGnYkPGRz6KmjPUByPbeUwLPt7ZsB45QbPY5Jgcs
+PYgFjvGD7ATA7WpLXN0nJizH5Glg2OYmZGd1zbdNIhc2HZUuKQ=
=fSZk
-----END PGP SIGNATURE-----

--rmdsxzqejgaw52xw--

