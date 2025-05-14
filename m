Return-Path: <linux-fsdevel+bounces-48963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA98CAB6BE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E4C17939A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E72797B8;
	Wed, 14 May 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="SYoT6DTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-outp-cfd-1.case.edu (mta-outp-cfd-1.case.edu [129.22.103.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9A1F4CAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227404; cv=pass; b=WH/4jD5Src4lBH0hkbla9s6ebvwT85tYTMrQI7z93eENVBVUTMrUjNBK/UAoFgIYb+xc/NXBNZ+nSbTHBqQclC9mzF6QwZL2xRRRZZqNE8gPpTLD8H8l5NdBaMEvctwc8PRd028N4z0bJFgNOgIkVXhjguurJC03CqjgLQ4ydTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227404; c=relaxed/simple;
	bh=H23KFw/6YBiqbHRBAplGutuAWNOTYRKqsZ37/mbJohk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eTxXDNMWv0GKy22i93Ku087R348o3lz2pZg5uVDlitxfB1FJMED/U3B9Nnz/XXXBS/vn2qwX4EQlC1csmVQV2vBiiVCS5wcD+5LxA+0Kj2z2+3GXGCcHeUZmd4yJ1F2nmLx+KPpwVu2VHJiooZqwgPrWD+32X2JmCh6NKOCCJR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=SYoT6DTf; arc=pass smtp.client-ip=129.22.103.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: mta-outp-cfd-1;
       spf=pass (mta-outp-cfd-1.case.edu: domain of case.edu designates 209.85.219.72 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
ARC-Filter: OpenARC Filter v1.0.0 mta-outp-cfd-1.case.edu 7EAE9156B
Authentication-Results: mta-outp-cfd-1; arc=none smtp.remote-ip=129.22.103.196
ARC-Seal: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta; t=1747226945; cv=none;
	b=NcCIfiV2nsbV1TSlshFipKSQWrC4jE/4I7H5JVqWFjbRKAdkUI14nAEdSpqyUb+/bx+PuEGdVLcFOWswCXgxWL5/z14Sz6tfj6Zrax4VYynYfkvGgpOo+Tk2jS89NB0Cg1gtz9Epwn/3TczNoXs9Uef5s+Bh7sLYtU1hv0yXEkj2wcodpWs3tdWqa/tKbI23ar4cHDF4ynC2Cy8SUjLcXsuDdMZ79rkrHc07PsFXX0u1WCKktG6yroogWWq166Hkr7t9/laorIAGk5RpdR3wA+xHYNjabmxNZW7NfkUB7U0rJIQ1tL6XeeCXfww/l3zB4qfeRxgYNby0wIEDB4XraA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta;
	t=1747226945; c=relaxed/simple;
	bh=H23KFw/6YBiqbHRBAplGutuAWNOTYRKqsZ37/mbJohk=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature; b=T+7kloZzX5qYpvbP3z7u4usP/vFHptKceL1bgPC91dT28XSO1vmNxSxJx20ksenwey8MD6+qJ0gmPUDv79MixNR72PsmlcsIdMR4u5HwXXbKNbeqRPFpEP2f960se6seEZ6NbrYE/dPsbd4h2gnFXgS+i2jfPgGhZD37EaYZ3DoCGpFVJfjgU5WY4QfEKnD1KWEMIKiDdDW5T61Y/tra0l5I06zH+/e7dLZ0lSyHtI+2OeMXtGTAt5ImJtA2j9a4sGf0cXHMQXjYlUVwc2FNqnoZcLGmEY3AZy54y2FI9GIdQ9LltFNXWcYLdX/PEaizNFfU1KcpKYC4fN0m58GqEw==
ARC-Authentication-Results: i=1; mta-outp-cfd-1; spf=pass (mta-outp-cfd-1.case.edu: domain of case.edu designates 209.85.219.72 as permitted sender) smtp.mailfrom=case.edu; dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case; dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu
Received-SPF: Pass (mta-outp-cfd-1.case.edu: domain of case.edu designates 209.85.219.72 as permitted sender) client-ip=209.85.219.72
Received: from mpv-out-cfd-1.case.edu (mpv-out-cfd-1.case.edu [129.22.103.196])
	by mta-outp-cfd-1.case.edu (Postfix) with ESMTPS id 7EAE9156B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 08:49:05 -0400 (EDT)
Received: from mpv-local-ksl-1.case.edu (EHLO mpv-local-ksl-1.case.edu) ([129.22.103.235])
	by mpv-out-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DED33494;
	Wed, 14 May 2025 08:49:05 -0400 (EDT)
Received: from mail-qv1-f72.google.com (EHLO mail-qv1-f72.google.com) ([209.85.219.72])
	by mpv-local-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id EKB30035;
	Wed, 14 May 2025 08:49:04 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f53f748240so163257996d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1747226944; x=1747831744; darn=vger.kernel.org;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H23KFw/6YBiqbHRBAplGutuAWNOTYRKqsZ37/mbJohk=;
        b=SYoT6DTfysavWjIBb5ibSZYNCh1E8E9G8hIFAkGPvK45Vyxr09CV33+fleEX2vw5/z
         Q2j+yVXpv4HK65hVWtOEyNrKZO2c54TeOk3zeiAhn8hbn3/vZ7li9lQm1nsptDWqgA3w
         DBGhMN3gRyhHV6Lxe7wqulqgBYuENlLMd7JGanvyTh5uloVqQK/gjcLsSmWLoToTvEs6
         P1Frn+rYK+yqI1RIeoAB+aUOrljczehSwLPvSZmycR8urRKTHO3FITe9bEvWssAlVdxu
         jzIODkD90fd5k7vtA4ph7N437XiIRLXfAnKCdvb9jdyYWyFJsL1HVrnMM7yxc+8d3aIA
         rR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747226944; x=1747831744;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H23KFw/6YBiqbHRBAplGutuAWNOTYRKqsZ37/mbJohk=;
        b=niR10Oxq++zrU41NpnZfodUb2MHcqIgB6a931fC/mRtpyitRg+zE9O3Wxj5+kbHnLX
         yS3jM6yTFnWGNcRkfht1iQhRnB3uOCUuaL/Rt64XRxSg0NhQdnUSE961PMYCbgJVnnig
         MiIk8d7zH/qJTQPBVnXZLlvaRUUmUMpEKcQB71rAkZvctqBJMp+sHWRQA3oVPYTL4Kxu
         hmWrmHs30ut8bi+G2KZp9zZDUFQeC88lr/ldsH8UWa0DqVq8jTGtc1ZiCH5kTCNoRG+k
         0jB5tF2Ono7QbAp0oUiWkTiTqjpTMDwBsIH3glPvEDlnnLxRJCpDL0evQOsTkuhKWfr3
         5sNA==
X-Forwarded-Encrypted: i=1; AJvYcCW6L6yakkD00yifH85cQ9TwjU7NimYFXGJiDgPGD73tgI3q2q/g78856ihUQ0GYhfgpuI6+aXw8FXksM329@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRsVvgtpsC5OAwe3vn7nYKbskzcKnEPzpo8hwBJp4gkU0kOt6
	lrXAWDDjlE8YN9Lyh0ECsCUh/npDQ/5sf7eOlAy8EYpv5pzgxL/bNlTxuUKkkkhZve0DRKWJyKL
	y8DF26YhxBMtR54QVFSeUivLOp20thQsiz/q3J8xbWNH/ZZA/ZzHrGX+R54V59CIH
X-Gm-Gg: ASbGncstaRctqJ5LP2R1lzvxy+lx6c4DGgCgKCi2Mb1PcbYpJjCpLT735cZmcwEaAcD
	panMhEpPhqh0i1WPoS+QQWYpWTVJXKtkY3+nAhXufEE3aiMqyEIf/ugnlbmhBNs62kZA3O5dgN3
	GuebdxJ6oCkgHjwTrGnQQAQKqCdeAm7zkwv2Hp3TfJtuS/RB4mEgEExp9QewlCZ+ZFutxrlSYbM
	z7hYDn2SRCZaIQkhHvKKYFlUbElpkwGFxgMgk2IRqPn05Bauj+mX5qvPrCmLaIsS6Zy8gwvJ+AR
	tBp3QPHK2QcWYz1seo0RlB4Fi6JGBV0ODq7XrKf/Xt1Zco0zcLLuDJ6tDdmAvaxz/y4tiC81fQ=
	=
X-Received: by 2002:a05:6214:21ad:b0:6f4:c602:806e with SMTP id 6a1803df08f44-6f896e3fec2mr50868636d6.13.1747226943600;
        Wed, 14 May 2025 05:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEtwlQ14DtF6O3cZcsGZzgP2A9K/NUkdK5N8BNr+YLd1S14ZNfvBQa1BEnvTAza0IpLemntQ==
X-Received: by 2002:a05:6214:21ad:b0:6f4:c602:806e with SMTP id 6a1803df08f44-6f896e3fec2mr50868286d6.13.1747226943210;
        Wed, 14 May 2025 05:49:03 -0700 (PDT)
Received: from ?IPV6:2603:6010:dc00:1e:f5e5:3614:5780:f83d? ([2603:6010:dc00:1e:f5e5:3614:5780:f83d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a52382sm80386186d6.94.2025.05.14.05.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 05:49:02 -0700 (PDT)
Message-ID: <63dd526c-20cb-4493-8ac5-e87a44c74419@case.edu>
Date: Wed, 14 May 2025 08:49:00 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu, Alexander Viro <viro@zeniv.linux.org.uk>,
        Etienne Champetier <champetier.etienne@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman
 <jaltman@auristor.com>,
        Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org,
        openafs-devel@openafs.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>
References: <433928.1745944651@warthog.procyon.org.uk>
 <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
From: Chet Ramey <chet.ramey@case.edu>
Autocrypt: addr=chet.ramey@case.edu; keydata=
 xsDiBEEOsGwRBACFa0A1oa71HSZLWxAx0svXzhOZNQZOzqHmSuGOG92jIpQpr8DpvgRh40Yp
 AwdcXb8QG1J5yGAKeevNE1zCFaA725vGSdHUyypHouV0xoWwukYO6qlyyX+2BZU+okBUqoWQ
 koWxiYaCSfzB2Ln7pmdys1fJhcgBKf3VjWCjd2XJTwCgoFJOwyBFJdugjfwjSoRSwDOIMf0D
 /iQKqlWhIO1LGpMrGX0il0/x4zj0NAcSwAk7LaPZbN4UPjn5pqGEHBlf1+xDDQCkAoZ/VqES
 GZragl4VqJfxBr29Ag0UDvNbUbXoxQsARdero1M8GiAIRc50hj7HXFoERwenbNDJL86GPLAQ
 OTGOCa4W2o29nFfFjQrsrrYHzVtyA/9oyKvTeEMJ7NA3VJdWcmn7gOu0FxEmSNhSoV1T4vP2
 1Wf7f5niCCRKQLNyUy0wEApQi4tSysdz+AbgAc0b/bHYVzIf2uO2lIEZQNNt+3g2bmXgloWm
 W5fsm/di50Gm1l1Na63d3RZ00SeFQos6WEwLUHEB0yp6KXluXLLIZitEJM0wQ2hldCBSYW1l
 eSAoQ2FzZSBzdGFuZGFyZCkgPGNoZXQucmFtZXlAY2FzZS5lZHU+wl8EExECAB8FAkPi19EC
 GwMHCwkIBwMCAQMVAgMDFgIBAh4BAheAAAoJELtYafBk6nSrelkAn31Gsuib7GcCZHbv5L5t
 VKYR9LklAJ4hzUHKA49Z0QXR+qCb80osIcmPSc7ATQRBDrBvEAQAkK6TAOKBEM+EC4j6V/7o
 /riVZqcgU5cid2qG9TXdwNtD9a3kvA/ObZBO93sX59wc6Bnwo4VJxsOmMlpGrAjJsxNwg3QH
 akEtf8LXRbVpj5xStdmBdQZUhIQyalo/2/TZq5OijtddUQcL5cs70hTv/FpT3wUvr2Xr8rjF
 41IFEz8AAwcD/A0CZEGlzIrT5WCBnl6xBog/8vKiUCbarByat3d1mL6DbizvKNXQRTC9E/vE
 dENAWCQCjr75Bu55xT8n3SXGtWdDC5xmZ/P3OBYORP8yl8H8I1FIosWOFirbIeYdZPq8SPD1
 HL+EXo9zSiHVrrZRJ19ooCKKbSdXHFCY+aJG+0KZwkkEGBECAAkFAkEOsG8CGwwACgkQu1hp
 8GTqdKvjcACfZlkVCDwaz/NTO9cy3t69oWpVPNwAnRwe0qk/WL/gfhH346xh5B3HFbFN
Organization: ITS, Case Western Reserve University
In-Reply-To: <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------85Jz5FfALLMAEBt32OGUtd5w"
X-Mirapoint-Received-SPF: 209.85.219.72 mail-qv1-f72.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.235 mpv-local-ksl-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=10/90, host=mpv-out-cfd-1.case.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A002108.68249132.0026,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
	ip=0.0.0.0,
	so=2016-11-06 16:00:04,
	dmn=2013-03-21 17:37:32,
	mode=single engine
X-Junkmail-IWF: false

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------85Jz5FfALLMAEBt32OGUtd5w
Content-Type: multipart/mixed; boundary="------------pZEuYk6TQBKl8aeUUzadh7Ih";
 protected-headers="v1"
From: Chet Ramey <chet.ramey@case.edu>
Reply-To: chet.ramey@case.edu
To: Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>
Cc: chet.ramey@case.edu, Alexander Viro <viro@zeniv.linux.org.uk>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jeffrey Altman
 <jaltman@auristor.com>, Steve French <sfrench@samba.org>,
 linux-afs@lists.infradead.org, openafs-devel@openafs.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <63dd526c-20cb-4493-8ac5-e87a44c74419@case.edu>
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
References: <433928.1745944651@warthog.procyon.org.uk>
 <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
In-Reply-To: <20250505-erproben-zeltlager-4c16f07b96ae@brauner>

--------------pZEuYk6TQBKl8aeUUzadh7Ih
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS81LzI1IDk6MTQgQU0sIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KDQo+PiBUaGlz
IHdvcmtzIGFyb3VuZCB0aGUga2VybmVsIG5vdCBiZWluZyBhYmxlIHRvIHZhbGlkbHkgY2hl
Y2sgdGhlDQo+PiBjdXJyZW50X2ZzdWlkKCkgYWdhaW5zdCBpX3VpZCBvbiB0aGUgZmlsZSBv
ciB0aGUgZGlyZWN0b3J5IGJlY2F1c2UgdGhlDQo+PiB1aWRzcGFjZXMgb2YgdGhlIHN5c3Rl
bSBhbmQgb2YgQUZTIG1heSB3ZWxsIGJlIGRpc2pvaW50LiAgVGhlIHByb2JsZW0gbGllcw0K
Pj4gd2l0aCB0aGUgdWlkIGNoZWNrcyBpbiBtYXlfY3JlYXRlX2luX3N0aWNreSgpLg0KPj4N
Cj4+IEhvd2V2ZXIsIHRoZSBiYXNoIHdvcmsgYXJvdW5kIGlzIGdvaW5nIHRvIGJlIHJlbW92
ZWQ6DQo+IA0KPiBXaHkgaXMgaXQgcmVtb3ZlZD8gVGhhdCdzIGEgdmVyeSBzdHJhbmdlIGNv
bW1lbnQ6DQoNCkkgdGhpbmsgdGhpcyBxdWVzdGlvbiBoYXMgYmVlbiBhZGVxdWF0ZWx5IGFu
c3dlcmVkLg0KDQoNCj4gU28gdGhlbiBqdXN0IGRvbid0IHJlbW92ZSBpdC4gSSBkb24ndCBz
ZWUgYSByZWFzb24gZm9yIHVzIHRvIHdvcmthcm91bmQNCj4gdXNlcnNwYWNlIGNyZWF0aW5n
IGEgYnVnIGZvciBpdHNlbGYgYW5kIGZvcmNpbmcgdXMgdG8gYWRkIHR3byBuZXcgaW5vZGUN
Cj4gb3BlcmF0aW9ucyB0byB3b3JrIGFyb3VuZCBpdC4NCg0KSSB0aGluayB0aGlzIHNob3dz
IHRoYXQgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyBzaG91bGQgYmUgdmVyeSBjYXV0aW91cw0K
YWJvdXQgcHV0dGluZyBpbiB3b3JrYXJvdW5kcyBmb3Iga2VybmVsIGJ1Z3MsIGFuZCBtYWtp
bmcgdGhlbSBhcyBsaW1pdGVkDQppbiBzY29wZSBhcyBwb3NzaWJsZS4NCg0KDQotLSANCmBg
VGhlIGx5ZiBzbyBzaG9ydCwgdGhlIGNyYWZ0IHNvIGxvbmcgdG8gbGVybmUuJycgLSBDaGF1
Y2VyDQoJCSBgYEFycyBsb25nYSwgdml0YSBicmV2aXMnJyAtIEhpcHBvY3JhdGVzDQpDaGV0
IFJhbWV5LCBVVGVjaCwgQ1dSVSAgICBjaGV0QGNhc2UuZWR1ICAgIGh0dHA6Ly90aXN3d3cu
Y3dydS5lZHUvfmNoZXQvDQo=

--------------pZEuYk6TQBKl8aeUUzadh7Ih--

--------------85Jz5FfALLMAEBt32OGUtd5w
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQR8ATX7CIqvbGbGULm7WGnwZOp0qwUCaCSRPAUDAAAAAAAKCRC7WGnwZOp0q/cd
AJ0YC9WUqxzUhmZxvvlNd+VRUfB+aACeK1+oHx4Wpo53yFc78F/fFnTazM8=
=JIZz
-----END PGP SIGNATURE-----

--------------85Jz5FfALLMAEBt32OGUtd5w--

