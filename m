Return-Path: <linux-fsdevel+bounces-48962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E90AB6BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300BA189DFE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B0279780;
	Wed, 14 May 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="ZcFAa+Ep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-outp-cfd-1.case.edu (mta-outp-cfd-1.case.edu [129.22.103.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E1202990
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227069; cv=pass; b=pLfJEBTl+YBVggTqGTh4+GY1QpmIUr5omyBC82hhMcD+zpiwMNhmZ6pOLDM93rtUvLkJWGcsY7Zy3AoBzcr4S7qGoi9MQzN+TRRpvKPgYzZgVD/C96FbW1yAyVrcCEE617LoIYEE59DDYpcjHH/zTRDhfw8uqbSmN3uTEdPeg74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227069; c=relaxed/simple;
	bh=ziBnVImEQka1k/5ArPVUpuK5Uv55pJxDufSS4gEWcPs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KKkT+CIRfhxe2KA1E1+8EO5dHlQhTUD4c6jf1xnHCOBriMNcc8RLMAE8oD9082I9r8Eyk+QOdCs9QYOGrdymQZcVIaqpxpxVKTwjcquhMUldkEjp4Vem0Frsnuoweq4a890BKXVIE/OvfYBfVCRgbjpKe08lNt/fwJlqWSAiMXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=ZcFAa+Ep; arc=pass smtp.client-ip=129.22.103.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: mta-outp-cfd-1;
       spf=pass (mta-outp-cfd-1.case.edu: domain of case.edu designates 209.85.160.197 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
ARC-Filter: OpenARC Filter v1.0.0 mta-outp-cfd-1.case.edu 5922C509
Authentication-Results: mta-outp-cfd-1; arc=none smtp.remote-ip=129.22.103.228
ARC-Seal: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta; t=1747227065; cv=none;
	b=jsc0N9Lc+bRUT4Lk+CzMLkvkAQeT9WYKotfSvMrv0ph45WluGh0+7th7HrgHyWRVmtZNJMbt+ycqMklLQsQum/z64u+Vzn4iw+6BzHEuZ2k02PhctJlUCGWwT8w/RNJ6Mi4MtD3iel8x7rLzFDRI17cTbn8Ecr142YrOyV1Nq7+8TtgVrS8vrTpzPjN9xBJlFsaMTWjWx+6zXxXd4fdebGlyfAciA2UBeXmEEJXR+LzHdUZRCPbtemd2QSJaC5rYk6ZAyfdh3FeUGl4Nra9sQVsPzx1mWjw21kC8L/rQJQdXVq/aMzGwqh4QV1KYTP4sjEbpcqvQhwjQAcyvawdNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta;
	t=1747227065; c=relaxed/simple;
	bh=ziBnVImEQka1k/5ArPVUpuK5Uv55pJxDufSS4gEWcPs=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature; b=W2JsU//ek1j+ILFDckTia1/bP8MdSu1sBVuSvguM0zCi4DkT5KuDriOHQFL+KAKrQjbQzN2nsEr0c41Cxvn0Pqxl6BehpzgLGErwtrP6BZ+hZRn1bdagBbq+LisjG0GyluHbBobgpxZEQPuODIGzeMp+VVSH1FuPGLJpnVPy2S2mWFN92G/JJ7mBiYfwXE+msgPTC3S70ln23tFryTRJQGfp1tdIVZtubxGGwqaigwIL4w0agJ9aNcedT2uq/D2QdPBSkXWBQ+Kc1SljAxwWnIzwkblQQuvYLv0S5Hu/KhWkMzJP8tQZ2aXqqRjc4BBm6FA6ZR8jsNar0CWikSEbng==
ARC-Authentication-Results: i=1; mta-outp-cfd-1; spf=pass (mta-outp-cfd-1.case.edu: domain of case.edu designates 209.85.160.197 as permitted sender) smtp.mailfrom=case.edu; dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case; dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu
Received-SPF: Pass (mta-outp-cfd-1.case.edu: domain of case.edu designates 209.85.160.197 as permitted sender) client-ip=209.85.160.197
Received: from mpv-out-ksl-1.case.edu (mpv-out-ksl-1.case.edu [129.22.103.228])
	by mta-outp-cfd-1.case.edu (Postfix) with ESMTPS id 5922C509
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 08:51:05 -0400 (EDT)
Received: from mpv-local-ksl-1.case.edu (EHLO mpv-local-ksl-1.case.edu) ([129.22.103.235])
	by mpv-out-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DCW46121;
	Wed, 14 May 2025 08:51:05 -0400 (EDT)
Received: from mail-qt1-f197.google.com (EHLO mail-qt1-f197.google.com) ([209.85.160.197])
	by mpv-local-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id EKB30364;
	Wed, 14 May 2025 08:51:04 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-478f78ff9beso199380951cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1747227062; x=1747831862; darn=vger.kernel.org;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ziBnVImEQka1k/5ArPVUpuK5Uv55pJxDufSS4gEWcPs=;
        b=ZcFAa+EpiyofytFE4hCoHtpOZDhoI/Ra6ORcTbbyu5xy4zsZuiK0OQtgBSUbtNoR+h
         qX2vR/vn7QMhngq5lTp8PsdQBimatAB0tgtz2YdL6j1dXlH311ELEHTEsqJmfym8IWJl
         HgVOp2bpG9j1BXbnKsHe1/GWUlzIsbU4VrQQMTez1oAtqwFdlleQh63IytpGExHY/jzf
         kWcIExf5/Tw2n92ITFjIIEdLaJuU2sFDTwzqKudE1Oug0ALtJEEf2mTYQr3oNZpqplSO
         sUzUJvq0HulvGuyhISGl5TVIQcbA201zfr8lCmmVKBkipkdEu5aHZqLGhzoTnCmeI9Nj
         fulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747227062; x=1747831862;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziBnVImEQka1k/5ArPVUpuK5Uv55pJxDufSS4gEWcPs=;
        b=QlsBlrEZXWmnBzuyIV1IRCf+EKW45CFvhDKGayP2tikE5aw46gQwVUOvq5rZQTlWDL
         WlX79q3C9K8kR4EQo5QU9Ulzg8RctP7dZtYDrfbqdCEQUUXHBN7nRsgxt1NzRDKS+kbW
         w7ckhp9vDG6KDNFMSli4yfQrRALHWCE8CJLE869g0lHsaZUmlHPiXM2PdZytFDIdpomG
         vG+/GJ1ypmFY6uCuYW97OSn8v01G8dGIWH/flYJNLZXXhVDmedViCuP7CXTSmNGIcSPI
         kenxQ6dgC8L/HVMIRgJ8s0V7/ziXl9CmOKrFUYUVBkoT6jbo4fsrmzn0zpL1JP37KMvk
         xcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWDW83kSOCfHhHgtg1nf0Qe1kvngZz8KiHf+HEoULjHIYepNTp7AXx+4SGlawz8PeOfi3ZottqYrHpoKbm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Xajfe8cuij1ZpaDzClxmarzhczqLKgv3eyMQudNB7vqTSpZ5
	AOXQS/Betk9aBKBbB5rqmHIRtS+5aPEdI4K0MIVEFBaU9ArcKuIPkKhmR4BQshN7AFvn9TOEq7B
	Z+PM8Z5jhrYiViNxzTFeexa86Cs6Moz/yXktVfM1z+u0vg4wu+lg0tGUMsiD828OVdbj6E6lk
X-Gm-Gg: ASbGncslLHSBYdd1N8vmLUkhitgRAQWfySVmqelkBJIKw9UE8XQTBzAJXyDFqR3HKIZ
	lGjIh+sH3ODAMW3XwwMHuRtQ3jV9e/oTfO39Jewl97xJWrzbGgRRhsu8nHvHiNyyevx3im3IcAq
	iOwI6G0TCurvPaOvyxqOAJWe2oTMMXF2vKsKMiz7sHKxvQpk9Yk2UG0Pg+5FSfhbzEGN6JSdwta
	KCF4lIwKkaEYfCsUA9IS8RP+53cOQ4vl5KzCdx4zb5sGyAG0IcSKRjZNvqCG+8PLAu+YlD6frTb
	Agtr4tr9C6m4A5v8lGcv1dNSj7dXhGdMxwAkKJBt4URPFZMOZgLS9kBXaB7kjV0wtm5uJCP18g=
	=
X-Received: by 2002:a05:622a:410d:b0:494:848e:d703 with SMTP id d75a77b69052e-49495ca4f3dmr55820451cf.30.1747227061937;
        Wed, 14 May 2025 05:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzQHI2rEryjYi08itQLGH9hVhvibYUYkKurYuspAd1v6/xkb8OjQbB/Q3z9M0RpvvTMatudg==
X-Received: by 2002:ad4:5bae:0:b0:6e8:f470:2b11 with SMTP id 6a1803df08f44-6f896e566cdmr50454446d6.23.1747227049536;
        Wed, 14 May 2025 05:50:49 -0700 (PDT)
Received: from ?IPV6:2603:6010:dc00:1e:f5e5:3614:5780:f83d? ([2603:6010:dc00:1e:f5e5:3614:5780:f83d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39e0b8bsm80792476d6.20.2025.05.14.05.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 05:50:48 -0700 (PDT)
Message-ID: <ad62849c-1728-4bae-b0d5-7d87dc94825f@case.edu>
Date: Wed, 14 May 2025 08:50:47 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu, David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org,
        Linux AFS mailing list <linux-afs@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        "openafs-devel@openafs.org" <openafs-devel@openafs.org>
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
Content-Language: en-US
To: Jeffrey E Altman <jaltman@auristor.com>,
        Etienne Champetier <champetier.etienne@gmail.com>,
        Christian Brauner <brauner@kernel.org>
References: <433928.1745944651@warthog.procyon.org.uk>
 <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
 <CAOdf3grbDQ-Fh2bV7XfoYvVBhgBAh7-hZyyxTNt1RfGekrA-nA@mail.gmail.com>
 <66c958db-0408-451d-b362-fed1f56d7c6d@auristor.com>
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
In-Reply-To: <66c958db-0408-451d-b362-fed1f56d7c6d@auristor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L5LSTY5M39gWnvMqVGp47caB"
X-Mirapoint-Received-SPF: 209.85.160.197 mail-qt1-f197.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.235 mpv-local-ksl-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=10/90, host=mpv-out-ksl-1.case.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A002112.682491B7.0002,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
	ip=0.0.0.0,
	so=2016-11-06 16:00:04,
	dmn=2013-03-21 17:37:32,
	mode=single engine
X-Junkmail-IWF: false

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------L5LSTY5M39gWnvMqVGp47caB
Content-Type: multipart/mixed; boundary="------------frKCS23FeCmgMLcTNF0WGjn4";
 protected-headers="v1"
From: Chet Ramey <chet.ramey@case.edu>
Reply-To: chet.ramey@case.edu
To: Jeffrey E Altman <jaltman@auristor.com>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: chet.ramey@case.edu, David Howells <dhowells@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>,
 linux-fsdevel@vger.kernel.org,
 Linux AFS mailing list <linux-afs@lists.infradead.org>,
 linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
 "openafs-devel@openafs.org" <openafs-devel@openafs.org>
Message-ID: <ad62849c-1728-4bae-b0d5-7d87dc94825f@case.edu>
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
References: <433928.1745944651@warthog.procyon.org.uk>
 <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
 <CAOdf3grbDQ-Fh2bV7XfoYvVBhgBAh7-hZyyxTNt1RfGekrA-nA@mail.gmail.com>
 <66c958db-0408-451d-b362-fed1f56d7c6d@auristor.com>
In-Reply-To: <66c958db-0408-451d-b362-fed1f56d7c6d@auristor.com>

--------------frKCS23FeCmgMLcTNF0WGjn4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS81LzI1IDEwOjQyIEFNLCBKZWZmcmV5IEUgQWx0bWFuIHdyb3RlOg0KDQo+Pj4gU28g
dGhlbiBqdXN0IGRvbid0IHJlbW92ZSBpdC4gSSBkb24ndCBzZWUgYSByZWFzb24gZm9yIHVz
IHRvIHdvcmthcm91bmQNCj4+PiB1c2Vyc3BhY2UgY3JlYXRpbmcgYSBidWcgZm9yIGl0c2Vs
ZiBhbmQgZm9yY2luZyB1cyB0byBhZGQgdHdvIG5ldyBpbm9kZQ0KPj4+IG9wZXJhdGlvbnMg
dG8gd29yayBhcm91bmQgaXQuDQo+PiBUaGlzIGJhc2ggd29ya2Fyb3VuZCBpbnRyb2R1Y2Vk
IGFnZXMgYWdvIGZvciBBRlMgYnlwYXNzIGZzLnByb3RlY3RlZF9yZWd1bGFyDQo+IA0KPiBD
aGV0LCBJIGRvbid0IHRoaW5rIHRoaXMgaGlzdG9yeSBpcyBjb3JyZWN0LiANCg0KSSB0aGlu
ayBFdGllbm5lJ3MgdGVyc2UgY29tbWVudCBhY2N1cmF0ZWx5IHN1bW1hcml6ZXMgdGhlIGN1
cnJlbnQgcHJvYmxlbQ0KKGFuZCBtYXliZSBpdCB3b3VsZCByZWFkIG1vcmUgY2xlYXJseSBp
ZiBoZSBoYWQgdXNlZCBgYnlwYXNzZXMnKS4NCg0KLS0gDQpgYFRoZSBseWYgc28gc2hvcnQs
IHRoZSBjcmFmdCBzbyBsb25nIHRvIGxlcm5lLicnIC0gQ2hhdWNlcg0KCQkgYGBBcnMgbG9u
Z2EsIHZpdGEgYnJldmlzJycgLSBIaXBwb2NyYXRlcw0KQ2hldCBSYW1leSwgVVRlY2gsIENX
UlUgICAgY2hldEBjYXNlLmVkdSAgICBodHRwOi8vdGlzd3d3LmN3cnUuZWR1L35jaGV0Lw0K


--------------frKCS23FeCmgMLcTNF0WGjn4--

--------------L5LSTY5M39gWnvMqVGp47caB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQR8ATX7CIqvbGbGULm7WGnwZOp0qwUCaCSRpwUDAAAAAAAKCRC7WGnwZOp0q8F+
AJ9LqPEdLlhWqcMgSVEfvfVvQQaLUQCeJ3uT3ggHKj9klGbE8GZKsHHVarM=
=1TNa
-----END PGP SIGNATURE-----

--------------L5LSTY5M39gWnvMqVGp47caB--

