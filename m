Return-Path: <linux-fsdevel+bounces-34269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854949C4379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 18:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2820F2842B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECD41A76A3;
	Mon, 11 Nov 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSHhWanb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4553389;
	Mon, 11 Nov 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345748; cv=none; b=VqClxIaobaUbue8/vU3/Ghatct7JutBSrb3jNBN4n4Bmi7F9yyFTxmI9GHkPQUSdUBzeofjoULgZ/MjRWFEQ8vWYgsfn5HA2avNU9ARXnqFjbmXVwdCLN0Pq79EAyRH4pYDEW6xOokN039h+DDFfPIVP7XmTXJRHwz8QJl8ZWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345748; c=relaxed/simple;
	bh=2yCvhy5w1wUJs3yDzbydKGxRKFF4D4l6onN7VM+5Uck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=he6/PCE+FBOOH3eNTE+8gPK3uT3OxEbHerv38qr0/mr1ZMNx6shGE5UCkS1mozPsrxIKIUhmvxs+sdGoNbtB6O1WIOB7WAnF4RzMTvphRnMPBsCiGkZfem8iJBagOw5pYZ1GF9d932DdIE8XOTzjHfqXN0kUkZJa2MNmTBwQqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSHhWanb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e71401844so609328266b.3;
        Mon, 11 Nov 2024 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731345745; x=1731950545; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2yCvhy5w1wUJs3yDzbydKGxRKFF4D4l6onN7VM+5Uck=;
        b=JSHhWanbb0uI1IYmzz+5O8DAvmKqgt7Kg+uC1Y1jK0kJTw58flwWQJqW8ruf904Jt4
         T0ztYXhW3lsBX9xquZeQGfvhR9EpCfwt6Xo2g6/CJIQehhoHsl7rLXc8avPwZ5egq+b+
         z+VfxO7tHIoqZUoCHouxhEBRjAjsUCFswt9rnwo9EYPbYqWbyxTBYOItOXXhxxULvjxU
         wdf1AsUGQGkaUNo0A0aXCJ7Y57zegzNKfkjpHTCNN3+u5Nc63Nbx3iZWwnaLhYXYTTGb
         OykExxWYg4VogrKqz8uy51bE45Y0o0NrzRDzj0sbouSLrE0Lu2VSKGcjt2zXfeK89Lc2
         5C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345745; x=1731950545;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yCvhy5w1wUJs3yDzbydKGxRKFF4D4l6onN7VM+5Uck=;
        b=UKR7QlHeWfau12OwRpNCXQfFgduONLvYbNVKbxQN4TIRQZdw4R6EnJs/1rsPIs4xsx
         8nJJm72D9xz2Tj0XUvx5ip5KcNINVMrdNBXQBViizFk9bVzhS1qP/ErJLoZ54tB7rXEv
         JeV0dcxUXtN6pA2kPM5TBQVB0RTLH+wBfuaH/A5k41AD77NFkb+qhIXi9enGFZCnpMUV
         jLr/tAR+rex2vflQSHhM6bCMnU293Ek6u4i1tG7a3w7UNw1d6nYZrVAENOWVgLElT7O3
         q7Tm3MTKdjxX/WMpZFLIu500+66fOEw+vN27Z1+O9ZT7YMI9FpzLfKqvfuwU3vGOVzGk
         iFQA==
X-Forwarded-Encrypted: i=1; AJvYcCUkrBzJpwJVzS2xSm5K3NwEOTRvVlwX8zklIvr4yNMBtr7Qynje+xEGZr2xyfAJ9zjW5K2cTNw2@vger.kernel.org, AJvYcCWHMTptRW1Lysh9Bw0Ugo/K1oEUVFr6CHNZZ7dWNxctcQlX83j/C82b59HSfe43YjjJA9Ui@vger.kernel.org, AJvYcCWiEmeXVGSFEIGbfltYHDy0wuNTuLc1oD9RLtxcvFM1j8biaLy1xNKC3Eha96Tgpn68w/4AZylB/Bpp832FHg==@vger.kernel.org, AJvYcCXNnECAfKkJI7MC6H4pFCvJLalj/tv4FRgYOkZb90Nqg0E+zLUh0kSwH7lWkAbNXocfEb4dbmnv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8YyDMniAq/OGwgHg3tyCdtXlHAqkPv/lLi3oarWK9TcFHsiL
	8J4+nx3J6CUQvBHyhZ3tzOHH/xuwO0+g73vCSAF7D6sujL+IWNUe
X-Google-Smtp-Source: AGHT+IEx8OnbykPGy4f6eWQoWmDySenWo8hIPrT3zblQC9L6SbeYzeZpoVaF6fTVt7NttLnO1TF+Gw==
X-Received: by 2002:a17:907:7b89:b0:a9e:b093:2422 with SMTP id a640c23a62f3a-a9eeffe9665mr1131551766b.48.1731345745148;
        Mon, 11 Nov 2024 09:22:25 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:fe70:af48:a973:5fa7? ([2001:b07:5d29:f42d:fe70:af48:a973:5fa7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def47esm609209666b.160.2024.11.11.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:22:24 -0800 (PST)
Message-ID: <a70cedcc4389cc90ecac7b7c477481724c71824a.camel@gmail.com>
Subject: Re: [PATCH v3 14/28] fdget(), trivial conversions
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Date: Mon, 11 Nov 2024 18:22:23 +0100
In-Reply-To: <20241102050827.2451599-14-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
	 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
	 <20241102050827.2451599-14-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU2F0LCAyMDI0LTExLTAyIGF0IDA1OjA4ICswMDAwLCBBbCBWaXJvIHdyb3RlOgo+IGZkZ2V0
KCkgaXMgdGhlIGZpcnN0IHRoaW5nIGRvbmUgaW4gc2NvcGUsIGFsbCBtYXRjaGluZyBmZHB1dCgp
IGFyZQo+IGltbWVkaWF0ZWx5IGZvbGxvd2VkIGJ5IGxlYXZpbmcgdGhlIHNjb3BlLgo+IAo+IFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPgo+IC0tLQo+IMKgYXJj
aC9wb3dlcnBjL2t2bS9ib29rM3NfNjRfdmlvLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIxICsr
Ky0tLS0tLS0tLQo+IMKgYXJjaC9wb3dlcnBjL2t2bS9wb3dlcnBjLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDI0ICsrKystLS0tLS0tLS0KPiDCoGFyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvY2VsbC9zcHVfc3lzY2FsbHMuYyB8wqAgNiArKy0tCj4gwqBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L3NneC9tYWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKy0tLS0KPiDCoGFy
Y2gveDg2L2t2bS9zdm0vc2V2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMzkgKysrKysrKystLS0tLS0tLS0tLS0KPiAtLQo+IMKgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3NjaGVkLmPCoCB8IDIzICsrKystLS0tLS0tLS0KPiDCoGRyaXZlcnMv
Z3B1L2RybS9kcm1fc3luY29iai5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKyst
LS0KPiDCoGRyaXZlcnMvbWVkaWEvcmMvbGlyY19kZXYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDEzICsrKy0tLS0tCj4gwqBmcy9idHJmcy9pb2N0bC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKy0KPiDCoGZzL2V2
ZW50ZmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgOSArKy0tLQo+IMKgZnMvZXZlbnRwb2xsLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIzICsrKystLS0tLS0t
LS0KPiDCoGZzL2ZoYW5kbGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKy0KPiDCoGZzL2lvY3RsLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MjMgKysrKystLS0tLS0tLQo+IMKgZnMva2VybmVsX3JlYWRfZmlsZS5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTIgKysrLS0tLQo+IMKgZnMvbm90aWZ5L2Zh
bm90aWZ5L2Zhbm90aWZ5X3VzZXIuY8KgwqDCoMKgwqDCoMKgwqAgfCAxNSArKystLS0tLS0KPiDC
oGZzL25vdGlmeS9pbm90aWZ5L2lub3RpZnlfdXNlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAx
NyArKystLS0tLS0tCj4gwqBmcy9vcGVuLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzNiArKysrKysrKystLS0tLS0t
LS0tLQo+IMKgZnMvcmVhZF93cml0ZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjggKysrKystLS0tLS0tLS0tLQo+IMKgZnMvc2lnbmFs
ZmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDkgKystLS0KPiDCoGZzL3N5bmMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI5ICsrKysrKy0tLS0t
LS0tLS0KPiDCoGlvX3VyaW5nL3NxcG9sbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyOSArKysrKy0tLS0tLS0tLS0tCj4gwqBrZXJuZWwvZXZl
bnRzL2NvcmUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MTQgKysrLS0tLS0KPiDCoGtlcm5lbC9uc3Byb3h5LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA1ICsrLQo+IMKga2VybmVsL3BpZC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA3ICsrLS0KPiDCoGtlcm5lbC9zeXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1ICsrKy0tLS0tLQo+IMKga2VybmVs
L3dhdGNoX3F1ZXVlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgNiArKy0tCj4gwqBtbS9mYWR2aXNlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKy0tLS0KPiDCoG1tL3JlYWRh
aGVhZC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxNyArKystLS0tLS0tCj4gwqBuZXQvY29yZS9uZXRfbmFtZXNwYWNlLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKystLS0KPiDCoHNlY3VyaXR5L2xh
bmRsb2NrL3N5c2NhbGxzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjYgKysrKyst
LS0tLS0tLS0tCj4gwqB2aXJ0L2t2bS92ZmlvLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKystLS0KPiDCoDMxIGZpbGVzIGNoYW5n
ZWQsIDE2NCBpbnNlcnRpb25zKCspLCAzMzkgZGVsZXRpb25zKC0pCgpbLi4uXQoKPiBkaWZmIC0t
Z2l0IGEvZnMvcmVhZF93cml0ZS5jIGIvZnMvcmVhZF93cml0ZS5jCj4gaW5kZXggZWYzZWUzNzI1
NzE0Li41ZTNkZjJkMzkyODMgMTAwNjQ0Cj4gLS0tIGEvZnMvcmVhZF93cml0ZS5jCj4gKysrIGIv
ZnMvcmVhZF93cml0ZS5jCj4gQEAgLTE2NjMsMzYgKzE2NjMsMzIgQEAgU1lTQ0FMTF9ERUZJTkU2
KGNvcHlfZmlsZV9yYW5nZSwgaW50LCBmZF9pbiwKPiBsb2ZmX3QgX191c2VyICosIG9mZl9pbiwK
PiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgbG9mZl90IHBvc19pbjsKPiDCoMKgwqDCoMKgwqDCoMKg
bG9mZl90IHBvc19vdXQ7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGZkIGZfaW47Cj4gLcKgwqDC
oMKgwqDCoMKgc3RydWN0IGZkIGZfb3V0Owo+IMKgwqDCoMKgwqDCoMKgwqBzc2l6ZV90IHJldCA9
IC1FQkFERjsKClRoaXMgaW5pdGlhbGl6YXRpb24gaXMgbm8gbG9uZ2VyIG5lZWRlZC4KCj4gwqAK
PiAtwqDCoMKgwqDCoMKgwqBmX2luID0gZmRnZXQoZmRfaW4pOwo+IC3CoMKgwqDCoMKgwqDCoGlm
ICghZmRfZmlsZShmX2luKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBv
dXQyOwo+ICvCoMKgwqDCoMKgwqDCoENMQVNTKGZkLCBmX2luKShmZF9pbik7Cj4gK8KgwqDCoMKg
wqDCoMKgaWYgKGZkX2VtcHR5KGZfaW4pKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVCQURGOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZl9vdXQgPSBmZGdldChmZF9v
dXQpOwo+IC3CoMKgwqDCoMKgwqDCoGlmICghZmRfZmlsZShmX291dCkpCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0MTsKPiArwqDCoMKgwqDCoMKgwqBDTEFTUyhmZCwg
Zl9vdXQpKGZkX291dCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGZkX2VtcHR5KGZfb3V0KSkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FQkFERjsKPiDCoAo+IC3CoMKg
wqDCoMKgwqDCoHJldCA9IC1FRkFVTFQ7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChvZmZfaW4pIHsK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjb3B5X2Zyb21fdXNlcigmcG9z
X2luLCBvZmZfaW4sIHNpemVvZihsb2ZmX3QpKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FRkFVTFQ7Cj4gwqDCoMKgwqDCoMKgwqDC
oH0gZWxzZSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwb3NfaW4gPSBmZF9m
aWxlKGZfaW4pLT5mX3BvczsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoGlmIChvZmZfb3V0KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAo
Y29weV9mcm9tX3VzZXIoJnBvc19vdXQsIG9mZl9vdXQsCj4gc2l6ZW9mKGxvZmZfdCkpKQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVG
QVVMVDsKPiDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBvc19vdXQgPSBmZF9maWxlKGZfb3V0KS0+Zl9wb3M7Cj4gwqDCoMKgwqDCoMKg
wqDCoH0KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldCA9IC1FSU5WQUw7Cj4gwqDCoMKgwqDCoMKg
wqDCoGlmIChmbGFncyAhPSAwKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IG91dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gdmZzX2NvcHlfZmlsZV9yYW5nZShmZF9maWxlKGZf
aW4pLCBwb3NfaW4sCj4gZmRfZmlsZShmX291dCksIHBvc19vdXQsIGxlbiwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZmxhZ3MpOwoK


