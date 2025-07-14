Return-Path: <linux-fsdevel+bounces-54810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D606B0387B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F727AD576
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72946238C35;
	Mon, 14 Jul 2025 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gn8uiHUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8922356CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479827; cv=none; b=G4QSjntM63C9R9KHDCReBsPU7n4ckkpMpyCw62Wnk9z+nZ7r09ZNV3INwUPK1mdwXYmYqyIf/cdGoErHYXcSYF6VYfEVv5Eq7pj1cjIDXa80LMdcPhMicqSXez/0s4IiK5abeYUjt++fn70oZRObuyONgInCKEKWpDIo+IXsiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479827; c=relaxed/simple;
	bh=oqA56g+oYqN0dxdRHpwKvCm0rHz/oogHIPMlNn7IpR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVimhYBUzBmF6k3vUho8CdXxQsOJWhtAB+KbL7/GrlvwmOMfVjnWgvwFNS9Jp7I1cjrHvi0BBw7O4l9iihLqy83w+lq+aEcq5rko+yQdGdAlBTFV7CPF3Bbl3jHYeoAutHcTAEPL9VZ8p5UI+r5J2BJDA2ZrDiiG/P9rCyboBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gn8uiHUW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso451992266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752479823; x=1753084623; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oqA56g+oYqN0dxdRHpwKvCm0rHz/oogHIPMlNn7IpR4=;
        b=gn8uiHUWxYpYiYTVUsJ6ZCeGhMPykJInfeuC6aWLULuQ1fQeeymls2am7TieS+wnea
         +MQl/sa4JZ04UHzmm2P2ASg47S1nXSdlXj1NDwop402w2HCDO58Eoa2ODZ4rvdQdZnqQ
         awkSToCgPZLPNPmicdUnnOo5pAzyY6pfBsITvqBcvgsU6tvAINF9Ea/QPu8QWe4q/b/x
         g4hKmzRuYkJ8xEZR3VM+UfYExw3uw+0pVthJh1CGXu68YQZqRwBI6lIBFyoAUHIMlIaD
         SlTfha4vyIAnjR4rlR8XaaVcPbCOCm47M31qJQhN3TwysnHGfApKC9CUtAuQtDrg2gJS
         urcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479823; x=1753084623;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqA56g+oYqN0dxdRHpwKvCm0rHz/oogHIPMlNn7IpR4=;
        b=BKRdF91J6CT3FROj7BojEmaqtcq9lQsJlnZOC6FbNQB5UDgm84iyGpadcakpfaGhHn
         DoGLvro+wmaFHrK90RgzH6zVIcGxOsamOWBFEAhYcTE2fXqWLWqMZ1A8ONynwLNhnbim
         UnIBRUAtKqTiJf0dTNx61zs3AGuPc/pm+AHHn/uSkjCDU5ezUKNOgxrUlNbkkzGKcs68
         F0kfu0q4ZTfLvsnvpmLxte5dLxS54vvq3wVo+Ln4IS+jWrpnNNoi6rpfbjlMVx5U66RK
         xkv3GwCT7+P9g1g41E1AYRGd4BBZSYZS03tjiUSvaFzvo4+7Q2aiuHFBr3syb5ggusgW
         W2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmapE+gqveTM2sqnuMgUqdIyDVcIIxUO7WoDpCoIrQ8tQGk8ppFAYm+Pc7nA4OFjD3y3JI0wn7RDU0clZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YymDTrbAL4fiEI06yDeu5mTVRyg6QTHmkI3UeaRsRJmMoKRUxQk
	Ayhj4NjcZC57TmEFDkRJvv54SV0aJRRutypyZGkIPFDIbKqQJw0wlS91bQPV2T0JIDM=
X-Gm-Gg: ASbGncvC7+SezlD+xx1EhUAQr710PYLZImz0jc4jZH2FW6g20JFmkLbWjrCjw7C2Use
	lxbe31ZSvhvmbDSHGp0ttSr93Unt1rA0Io+2AjmKPtqtXhFLcW/2aIT0cJWrAD5q2fy6ydvwYrD
	xMVUkrZThbbTJqYjVIG1H31vPIOmLbO4BcHQ3nwacdJolwI9MV97I+nlGOdYKd6H072cn/i0j4Y
	BnVx3mEgpJvwmCCtOdGa7VnYk18Px0o0JneQdrA2oX112jT15FfxsVccpFI0gEdIPCBHwtfMNav
	4K5yuF3nKF8IHTzYi9GximK3SSlxTB88sgNSOuiirzrPfiVYJrLTMld+G8wZe8oKgjNOy+W3ssV
	X5V6liyX1A+pcMdbrVT+iR8K6CzOnoOvHpBbXW4fB4EOwfWyJTRhbj+57hd79G5OvXSyCtiEVXQ
	QRjzHZqX/QVxaVTyI0PPbdUPFFRQezyx/LpJjtQZ9IPrYQ
X-Google-Smtp-Source: AGHT+IEY8wHD8LrJHpdzi2oVkTVScdjsjLfRHtklTWWRJplbLpgLHJb53QErTUBoMuAk4KEVZ6BD9g==
X-Received: by 2002:a17:907:fdca:b0:ae1:1a30:6682 with SMTP id a640c23a62f3a-ae6fca47eafmr1466320966b.18.1752479823105;
        Mon, 14 Jul 2025 00:57:03 -0700 (PDT)
Received: from ?IPV6:2003:e5:8709:f00:6357:915b:11f9:6d20? (p200300e587090f006357915b11f96d20.dip0.t-ipconnect.de. [2003:e5:8709:f00:6357:915b:11f9:6d20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee569asm770014366b.44.2025.07.14.00.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 00:57:02 -0700 (PDT)
Message-ID: <107f0e09-cd9a-4e09-9f1a-d9c892dfa04a@suse.com>
Date: Mon, 14 Jul 2025 09:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xen: fix UAF in dmabuf_exp_from_pages()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20250712050231.GX1880847@ZenIV> <20250712050916.GY1880847@ZenIV>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20250712050916.GY1880847@ZenIV>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dk3Ih5Zg7lSD7beMdoJrzNrY"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dk3Ih5Zg7lSD7beMdoJrzNrY
Content-Type: multipart/mixed; boundary="------------BxvLPzQyU1gOIBktOm5o97V3";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <107f0e09-cd9a-4e09-9f1a-d9c892dfa04a@suse.com>
Subject: Re: [PATCH 2/2] xen: fix UAF in dmabuf_exp_from_pages()
References: <20250712050231.GX1880847@ZenIV> <20250712050916.GY1880847@ZenIV>
In-Reply-To: <20250712050916.GY1880847@ZenIV>

--------------BxvLPzQyU1gOIBktOm5o97V3
Content-Type: multipart/mixed; boundary="------------0WXUQaB3zvU2uj6f2pEjezbr"

--------------0WXUQaB3zvU2uj6f2pEjezbr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDcuMjUgMDc6MDksIEFsIFZpcm8gd3JvdGU6DQo+IFtkbWFfYnVmX2ZkKCkgZml4
ZXM7IG5vIHByZWZlcmVuY2VzIHJlZ2FyZGluZyB0aGUgdHJlZSBpdCBnb2VzIHRocm91Z2gg
LQ0KPiB1cCB0byB4ZW4gZm9sa3NdDQoNCkknbGwgdGFrZSBpdCB2aWEgdGhlIFhlbiB0cmVl
Lg0KDQo+IEFzIHNvb24gYXMgd2UnZCBpbnNlcnRlZCBhIGZpbGUgcmVmZXJlbmNlIGludG8g
ZGVzY3JpcHRvciB0YWJsZSwgYW5vdGhlcg0KPiB0aHJlYWQgY291bGQgY2xvc2UgaXQuICBU
aGF0J3MgZmluZSBmb3IgdGhlIGNhc2Ugd2hlbiBhbGwgd2UgYXJlIGRvaW5nIGlzDQo+IHJl
dHVybmluZyB0aGF0IGRlc2NyaXB0b3IgdG8gdXNlcmxhbmQgKGl0J3MgYSByYWNlLCBidXQg
aXQncyBhIHVzZXJsYW5kDQo+IHJhY2UgYW5kIHRoZXJlJ3Mgbm90aGluZyB0aGUga2VybmVs
IGNhbiBkbyBhYm91dCBpdCkuICBIb3dldmVyLCBpZiB3ZQ0KPiBmb2xsb3cgZmRfaW5zdGFs
bCgpIHdpdGggYW55IGtpbmQgb2YgYWNjZXNzIHRvIG9iamVjdHMgdGhhdCB3b3VsZCBiZQ0K
PiBkZXN0cm95ZWQgb24gY2xvc2UgKGJlIGl0IHRoZSBzdHJ1Y3QgZmlsZSBpdHNlbGYgb3Ig
YW55dGhpbmcgZGVzdHJveWVkDQo+IGJ5IGl0cyAtPnJlbGVhc2UoKSksIHdlIGhhdmUgYSBV
QUYuDQo+IA0KPiBkbWFfYnVmX2ZkKCkgaXMgYSBjb21iaW5hdGlvbiBvZiByZXNlcnZpbmcg
YSBkZXNjcmlwdG9yIGFuZCBmZF9pbnN0YWxsKCkuDQo+IGdudGRldiBkbWFidWZfZXhwX2Zy
b21fcGFnZXMoKSBjYWxscyBpdCBhbmQgdGhlbiBwcm9jZWVkcyB0byBhY2Nlc3MgdGhlDQo+
IG9iamVjdHMgZGVzdHJveWVkIG9uIGNsb3NlIC0gc3RhcnRpbmcgd2l0aCBnbnRkZXZfZG1h
YnVmIGl0c2VsZi4NCj4gDQo+IEZpeCB0aGF0IGJ5IGRvaW5nIHJlc2VydmluZyBkZXNjcmlw
dG9yIGJlZm9yZSBhbnl0aGluZyBlbHNlIGFuZCBkbw0KPiBmZF9pbnN0YWxsKCkgb25seSB3
aGVuIGV2ZXJ5dGhpbmcgaGFkIGJlZW4gc2V0IHVwLg0KPiANCj4gRml4ZXM6IGEyNDBkNmU0
MmUyOCAoInhlbi9nbnRkZXY6IEltcGxlbWVudCBkbWEtYnVmIGV4cG9ydCBmdW5jdGlvbmFs
aXR5IikNCj4gU2lnbmVkLW9mZi1ieTogQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcu
dWs+DQoNCkFja2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0K
SnVlcmdlbg0K
--------------0WXUQaB3zvU2uj6f2pEjezbr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------0WXUQaB3zvU2uj6f2pEjezbr--

--------------BxvLPzQyU1gOIBktOm5o97V3--

--------------dk3Ih5Zg7lSD7beMdoJrzNrY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmh0uE4FAwAAAAAACgkQsN6d1ii/Ey95
dAf/aTz9/n6JLW+ceFVg59UgNUwNCu8binbe4WijEp2GhwV9ILY31FXHr9x3PQpje/kz7hzgzWul
zJZT+Ke7191QzWvvvEpkAqY2QXqKuMDyBWOk6WtcbnozKTWXmxtdXhPBhmaBoWs1uy9bwt931t2i
RXvn3RQD0tEuRu5+aYgDNJOk4bSvLpY8TIFED1TsIZO7rCgzmGsVezMlo6W0CGDKDz0jXdimGEGB
sC4499U3iBNKZxAEFZmS6aFBif1IF/ZeqRFkrKrY7b5nPKJOpaBVQgSjveIvSmaudJsgT7C0n19i
5hhFeOzrlUYT1Sz9UvCx8ehW6pPgXFYQItnO8+R84g==
=X0XW
-----END PGP SIGNATURE-----

--------------dk3Ih5Zg7lSD7beMdoJrzNrY--

