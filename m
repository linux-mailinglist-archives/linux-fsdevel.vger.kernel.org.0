Return-Path: <linux-fsdevel+bounces-18574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2850E8BA760
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CFA1F21C97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF6146A8F;
	Fri,  3 May 2024 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WAIf9HaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DF14658F;
	Fri,  3 May 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720044; cv=none; b=UjmAwbi0RvUi8ogSE1RhJeCDk1t27Yt5m11XYKtT+XU8uKsbNqNEdSYqQhDS8cw7OnsNq336RFLigDy9MIL6D6/as4T+RHQKH8VlExAydMLIHnyVl+7HW4xF1TpzNmE9zzYNRjOA6KZiEuTsyYRR7XAshxNqT5RxsFodtyo0RYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720044; c=relaxed/simple;
	bh=O/sHsdCylG2MFy1pSJ1PRazemWy7FKCci38WHBEzE9g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=tjnRr6Cd9cepS43rS1XDcjSslkRrFyZ8v1uBbJNJjM9EEsVxAfio4cLtzLrnYBSShSmEDBS4+qfCYm4HhDrDFDxhAvEnKqTpOIpLQdXtIe/V3NIRwa14qN9wWV8nJvmMjbGTkLHfi0R4aHmef4K2LUoAH3564aVlabtmtTspF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=WAIf9HaO; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:49a3:0:640:a0c5:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTPS id E94DD6129C;
	Fri,  3 May 2024 10:07:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id B7OTss7uBeA0-71e0e3jK;
	Fri, 03 May 2024 10:07:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714720032; bh=O/sHsdCylG2MFy1pSJ1PRazemWy7FKCci38WHBEzE9g=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=WAIf9HaOlTOaIVdooYDyz/agzHBhFaEj5ddWhxaxW6ZMpp9oacohngFBO7K4/LZ2p
	 wv+RlKiuFQsE0VHQOwQBDIO9KlCvtElS6Tk8/F7YRFRC9DRT6xUjxCMSdek4fr9euj
	 EbdFUr2M4Elo6XG6efknhRLcXprPdynIeexpg1Co=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d5866bd9-299c-45be-93ac-98960de1c91e@yandex.ru>
Date: Fri, 3 May 2024 10:07:11 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 lvc-project@linuxtesting.org,
 syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org
References: <20240423191310.19437-1-dmantipov@yandex.ru>
 <85b476cd-3afd-4781-9168-ecc88b6cc837@amd.com>
 <3a7d0f38-13b9-4e98-a5fa-9a0d775bcf81@yandex.ru>
 <72f5f1b8-ca5b-4207-9ac9-95b60c607f3a@amd.com>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: [PATCH] [RFC] dma-buf: fix race condition between poll and close
In-Reply-To: <72f5f1b8-ca5b-4207-9ac9-95b60c607f3a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yNC8yNCAyOjI4IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KDQo+IEkgZG9u
J3QgZnVsbHkgdW5kZXJzdGFuZCBob3cgdGhhdCBoYXBwZW5zIGVpdGhlciwgaXQgY291bGQg
YmUgdGhhdCB0aGVyZSBpcyBzb21lIGJ1ZyBpbiB0aGUgRVBPTExfRkQgY29kZS4gTWF5YmUg
aXQncyBhIHJhY2Ugd2hlbiB0aGUgRVBPTEwgZmlsZSBkZXNjcmlwdG9yIGlzIGNsb3NlZCBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KDQpJSVVDIHRoZSByYWNlIGNvbmRpdGlvbiBsb29r
cyBsaWtlIHRoZSBmb2xsb3dpbmc6DQoNClRocmVhZCAwICAgICAgICAgICAgICAgICAgICAg
ICAgVGhyZWFkIDENCi0+IGRvX2Vwb2xsX2N0bCgpDQogICAgZl9jb3VudCsrLCBub3cgMg0K
ICAgIC4uLg0KICAgIC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgLT4gdmZzX3BvbGwo
KSwgZl9jb3VudCA9PSAyDQogICAgLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4N
CjwtIGRvX2Vwb2xsX2N0bCgpICAgICAgICAgICAgICAgLi4uDQogICAgZl9jb3VudC0tLCBu
b3cgMSAgICAgICAgICAgICAuLi4NCi0+IGZpbHBfY2xvc2UoKSwgZl9jb3VudCA9PSAxICAg
Li4uDQogICAgLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0+IGRtYV9idWZfcG9s
bCgpLCBmX2NvdW50ID09IDENCiAgICAtPiBmcHV0KCkgICAgICAgICAgICAgICAgICAgICAg
Li4uIFsqKiogcmFjZSB3aW5kb3cgKioqXQ0KICAgICAgIGZfY291bnQtLSwgbm93IDAgICAg
ICAgICAgICAgIC0+IG1heWJlIGdldF9maWxlKCksIG5vdyA/Pz8NCiAgICAgICAtPiBfX2Zw
dXQoKSAoZGVsYXllZCkNCg0KRS5nLiBkbWFfYnVmX3BvbGwoKSBtYXkgYmUgZW50ZXJlZCBp
biB0aHJlYWQgMSB3aXRoIGYtPmNvdW50ID09IDENCmFuZCBjYWxsIHRvIGdldF9maWxlKCkg
c2hvcnRseSBsYXRlciAoYW5kIG1heSBldmVuIHNraXAgdGhpcyBpZg0KdGhlcmUgaXMgbm90
aGluZyB0byBFUE9MTElOIG9yIEVQT0xMT1VUKS4gRHVyaW5nIHRoaXMgdGltZSB3aW5kb3cs
DQp0aHJlYWQgMCBtYXkgY2FsbCBmcHV0KCkgKG9uIGJlaGFsZiBvZiBjbG9zZSgpIGluIHRo
aXMgZXhhbXBsZSkNCmFuZCAoc2luY2UgaXQgc2VlcyBmLT5jb3VudCA9PSAxKSBmaWxlIGlz
IHNjaGVkdWxlZCB0byBkZWxheWVkX2ZwdXQoKS4NCg0KRG1pdHJ5DQo=

