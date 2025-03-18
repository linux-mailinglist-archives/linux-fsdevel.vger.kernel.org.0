Return-Path: <linux-fsdevel+bounces-44306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E19A670F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E87E3ABCEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D9207DE7;
	Tue, 18 Mar 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z89p/Lsp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB4204C0F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293005; cv=none; b=NNWxHCLocykoIIr8fNoAuvCK43qFtMLR8aMkCWGDYuT2FHuZLEGUMuklgzwwxW/OYhwi/d03GKbQ96p4yyb2wI+HBwxouMSNAT7pQqO8S6peseOVKOHDPdH+cR8GeBwS6PT2xAAddSL011H5j+WzzepJXgNrDmi+PXeTs1ke+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293005; c=relaxed/simple;
	bh=QqeiQA+ByKTA1tcqUH3rsqKPcPvpI9PiVYVU+jLVsPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjOYCsnc5FCK5zXHkA/+UhVXM9dIcRmjuK3cMUyPM2HTVoI7l/cfxNlwNKBnXqntNXEqAVdAl98uqheQFW8F1eA45SAm1JZinB0RqUEi4O92nWnEfqQY9Epnph1PGZ0KxdexutGKyXjraMfxLObKM3mjVM/UkH8GnKXVreZ8aQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z89p/Lsp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so14755565e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742292998; x=1742897798; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QqeiQA+ByKTA1tcqUH3rsqKPcPvpI9PiVYVU+jLVsPg=;
        b=Z89p/LspGn+qb046yFA38CjobPbgQuW/IetMTV/MMik+A0HPI0FAQGukePxdqnnTHo
         cH2TVx2DkREvtTtLKSrcUOlEiPFRag3Avx4xMx3ZUNak3JNxtzNuvBK6I2WpWMpeCyIV
         AE9t/ty02jQaAYmB4kji85bFpk6YmM9JFEw3dhNjKWG9tAgNMh0qygeh3I62Du9Ia04t
         bWK6J5XT4twY2Z9IS0buwp6d6cWyjsSCyOIrVcHkL/dmURbB+M/wqgOl07CA5rVBle7X
         1fRS0lEr69jlgytIZggKydO44RvVj1uXIzgWS0UvN82bfArfR//cBQMXON1LxG7cxAZB
         GmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292998; x=1742897798;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqeiQA+ByKTA1tcqUH3rsqKPcPvpI9PiVYVU+jLVsPg=;
        b=mVjJiFVEmoaV1Do/OOSRFBeXwmehzxiitKRZZ7HfKuto/T9+CpRNPtuHX+PmHWHozC
         RLAPnZ3GnN7GwXUWn6zCYn1g0pYjq3KRaCZLYhOalWqrmBYCLTs9fDcvwngUhlW6fnyu
         NIu36iRPJq0WiUTQxMumkMo2P3RS43vAMaENfl7ZT3oaTkCZ9LN10XQaHy5xym0nsu7W
         5lViw3OKY1fh88wGHiqc5B1dV55C54bd5y64ChbdDip1/CCXovFa7Z8AlAQy1yPLyUDy
         Hm0Ze4rdkGsjnZV7VOyympFrLHzUsid0U5YoDmDZNJr6kkLkJ5Ds6Otgr0kTXts0pX+S
         ICuw==
X-Forwarded-Encrypted: i=1; AJvYcCXmh+Cwe0G5+LX4hOu+eHgeCTzbxaeUzF9wxw+dw5klHhB4kPruYjtNmPXxpLs8EwE9Z1ZCZjamRStfw22s@vger.kernel.org
X-Gm-Message-State: AOJu0YxOghMsh32KFw/2OomAJ3FYuAe20/q7YO8KfitU/42+DRus2Hfn
	jCcYNGaJOBxuBFZF128uuhlTkwaOYZSzWFUJVYKSKqZc1x0DsipsXb6FBe1dJgI=
X-Gm-Gg: ASbGnct09BnmIJZonUYcqX0esiETEyFfEjX96F8nvHhx1XVkQZsGc2BVlYNa+C1/bP1
	Ijv8yHzetJ6jbehHbWRvdQo36d4xD/xVKwHPGMClDrN7YJb0u1iPlcamJ0Q//rNH51Gd1mQQcZI
	0un5tn9qZ7iJSczUwz0JO3Z8dd3gm2/CDbtrcXQmJAKoXH17f2DGzoyXhsauF4RUy9gY8EzZSPO
	mMc7epbfQNI23LXvoSxonwB5l0eRcut576Oj5o2JjLGl+9DLt1H6qtupXQdxJPJOvxI3rViQl3U
	KnquYj1ym9mkk8ofyH/yrGWpavvDIHI0xBTIh30/7UROx13VLr0Y637wWhluUmRqxvfX0lX3CPk
	IQU7u/e4Q2kBzBN0HL/bxl5masQJ7HmDk0Ele2Fvs0YJN7wzZ3UYTTdceDbKmQIXSVCSSOw==
X-Google-Smtp-Source: AGHT+IGXRsOL/024GSaaTsj0I6bJ+HF/nWMcN9UcSMdGUI6X0OltJ6Kr+lU1tvqI65hxFgJwQnP8+Q==
X-Received: by 2002:a5d:5f93:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-3971d42ae27mr18927937f8f.15.1742292998087;
        Tue, 18 Mar 2025 03:16:38 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a3dsm17781886f8f.74.2025.03.18.03.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:16:37 -0700 (PDT)
Message-ID: <a9f0a22c-2a97-42e7-838e-a210be215e21@suse.com>
Date: Tue, 18 Mar 2025 11:16:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] xen: balloon: update the NR_BALLOON_PAGES state
To: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com, muchun.song@linux.dev,
 roman.gushchin@linux.dev, mhocko@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 akpm@linux-foundation.org, mst@redhat.com, david@redhat.com,
 yosry.ahmed@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, kanchana.p.sridhar@intel.com, llong@redhat.com,
 shakeel.butt@linux.dev
References: <20250314213757.244258-1-npache@redhat.com>
 <20250314213757.244258-5-npache@redhat.com>
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
In-Reply-To: <20250314213757.244258-5-npache@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6nFuvn90f00fPGQn5quF42xx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6nFuvn90f00fPGQn5quF42xx
Content-Type: multipart/mixed; boundary="------------Ymj9dgUiA6mQZpNBIbVIuM35";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com, muchun.song@linux.dev,
 roman.gushchin@linux.dev, mhocko@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 akpm@linux-foundation.org, mst@redhat.com, david@redhat.com,
 yosry.ahmed@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, kanchana.p.sridhar@intel.com, llong@redhat.com,
 shakeel.butt@linux.dev
Message-ID: <a9f0a22c-2a97-42e7-838e-a210be215e21@suse.com>
Subject: Re: [PATCH v2 4/4] xen: balloon: update the NR_BALLOON_PAGES state
References: <20250314213757.244258-1-npache@redhat.com>
 <20250314213757.244258-5-npache@redhat.com>
In-Reply-To: <20250314213757.244258-5-npache@redhat.com>

--------------Ymj9dgUiA6mQZpNBIbVIuM35
Content-Type: multipart/mixed; boundary="------------F0LwjPwAT0UT4XBZzX0cDv8Z"

--------------F0LwjPwAT0UT4XBZzX0cDv8Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDMuMjUgMjI6MzcsIE5pY28gUGFjaGUgd3JvdGU6DQo+IFVwZGF0ZSB0aGUgTlJf
QkFMTE9PTl9QQUdFUyBjb3VudGVyIHdoZW4gcGFnZXMgYXJlIGFkZGVkIHRvIG9yDQo+IHJl
bW92ZWQgZnJvbSB0aGUgWGVuIGJhbGxvb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNv
IFBhY2hlIDxucGFjaGVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jv
c3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=
--------------F0LwjPwAT0UT4XBZzX0cDv8Z
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------F0LwjPwAT0UT4XBZzX0cDv8Z--

--------------Ymj9dgUiA6mQZpNBIbVIuM35--

--------------6nFuvn90f00fPGQn5quF42xx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfZSAQFAwAAAAAACgkQsN6d1ii/Ey/J
jgf/deb7eb7DEWa4WHP3ywhAnXjAfRO3pIdEA2BDhLdNN1buCZyW9zYsai+acWuHT0fNBKrGEs7g
wotCH2G8AFUB22/5d0FpTJ2bKxAQ1IJqZi/P7zt9VM511OI5ytOzdiG5T9XP364zFqXO+512r3Ue
RE28mv9CK6mfPpLuxxhHBKy0HSvkq03ifwL+Kbs0O0wbiyHE2yaPKGVB3MtIP6LpErreDLvqDHuO
OALFl6UgkVRUbd9VUCaXcwwqZu0rDoUR/3bpdLrRq94ldBtBPVbirTPGH7+ndexmloSK44qnQxlF
GyUc1Zs34C59ZztRGlXJwEI/WJBQ6h6UoWQFfgGF3g==
=IGq1
-----END PGP SIGNATURE-----

--------------6nFuvn90f00fPGQn5quF42xx--

