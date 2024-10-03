Return-Path: <linux-fsdevel+bounces-30853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22E98ED83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AF3281734
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074831514F8;
	Thu,  3 Oct 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcJ3AUMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893513D8AC;
	Thu,  3 Oct 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953385; cv=none; b=g46OVW9dScBmuc4BHmotyc5o0j/l9CXF+HVGSa0odf3HcxHYDu7i2jjU2xy8eMh3cMJU/PmoFd7KzZMfOyg2IN/5r48vjXUiJ4cZbFALfCR1CR3kLBNlBdfg4q6TNr6zIbFIx9RHHn9VyWITJrdl60+ikylM1Y0ujeuAk8/Pjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953385; c=relaxed/simple;
	bh=vsCv+tUHiFaWN8KpmPI5wjINPuThCTLc+DXFhE/dMtw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ro5Vl2uw04i6kGrIXGeWeTqp816FNOicSGPryLE2qLirq4LULzvxYTolhLLyClMgbRX21cGtkMQw7k/dVE4eusrbF7vckv/LKcon8+DEHAeI772Tiae/0WyNnaS6r/0jrltl29KEVEsYAivctFmakuwMt5xt38oKWC8p1S0cHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcJ3AUMV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso591203b3a.1;
        Thu, 03 Oct 2024 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727953383; x=1728558183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vsCv+tUHiFaWN8KpmPI5wjINPuThCTLc+DXFhE/dMtw=;
        b=TcJ3AUMVvs000uDH7DQtB2Rrbyt05Cg/P5/U6a5nJggrPkK1ns4R50+7U9EKY9zxue
         z6+7jzAbvLeYPOVnmM/MPuwUwvEMw3A91/MZzOVnvjFCDt/hayYz8sVs5By40p1AMU3l
         tzqG269DoN6ti1/ytv8R+JbCtkt5Pga5VNBS3ccqqF/lNto8autOHeOw65KuZ5DjXU/b
         XnlybDLbVh7Er3RggoPuGM4F7g8l/nCh3HbahQZ2iE4IbL1+KFhaBTZ193Ws+pfLW60B
         7QTdAj504FPiU544EeZfbkzRQd5YOxQgSD3nDFgb5GS5eJf3edwc6yzVsnAwVIT4Y1T+
         KnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727953383; x=1728558183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsCv+tUHiFaWN8KpmPI5wjINPuThCTLc+DXFhE/dMtw=;
        b=RxuqtmJDT5N7x4S4eP6m8szVT5HoSJOTLAgGRwNWLqH6YTBDIPUTapRQ/q1tKpoTCr
         9jlDgmoPaK1dxmFgTgKOy3IdI93olQFvqF+sfRB32AYoRcs6BSlDXm64y2nSRxjnU7of
         JqVQv1N8RRaLF4D50UgB3Rs7zQPfEIh6uHOLjywbfXIJpwS4XKAbLOfhlXjjAO2gtMHD
         CXOWnDYpuFJLwilg6auTVxqcRAXBoJzaTBTjiGlqRNhRO1+uUcCseqqVjjmhB2t1qNfr
         sAsxIWqnPTwQx4VArZbshhFI1q0TBgD6OGJYFw/s6JNVQ6o3nXWy+hKyZ5/x/COv8+tG
         Grog==
X-Forwarded-Encrypted: i=1; AJvYcCXYYd4t7mBnMsaOLgWvIG0TlDh5hkyAgC+Rvr/Wd1Ba5riaipHLCaV7NlDOU/2bBNnB199g7AYNJ6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ClVxkO3Nm/YUZLVcLIMuhAION+wFpM/fyqt8H94QzdUdLopO
	ZxMDI+eJucEJ/gXcgYchMe/HolahBcZQi806LGYWKXrT/t9skD5r
X-Google-Smtp-Source: AGHT+IGYh3VfpLMGmYt+kGqDimvOWMw77H3g1qA/Bn6vaVdplJxzhFFTTMdX0XgfsBcCXHzWjyxiEA==
X-Received: by 2002:a05:6a00:a08:b0:710:5825:5ba0 with SMTP id d2e1a72fcca58-71dc5c43f46mr10324406b3a.3.1727953383281;
        Thu, 03 Oct 2024 04:03:03 -0700 (PDT)
Received: from [192.168.51.233] ([206.237.119.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d6f944sm1055203b3a.42.2024.10.03.04.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:03:02 -0700 (PDT)
Message-ID: <7cdbc4b1f7634e650168fa6cb83fc832e6c9b803.camel@gmail.com>
Subject: Re: [PATCH 2/2] iomap: constrain the file range passed to
 iomap_file_unshare
From: Julian Sun <sunjunchao2870@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner
	 <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, xfs
	 <linux-xfs@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Brian
	Foster <bfoster@redhat.com>, jack@suse.cz
Date: Thu, 03 Oct 2024 19:02:57 +0800
In-Reply-To: <20241002150213.GC21853@frogsfrogsfrogs>
References: <20241002150040.GB21853@frogsfrogsfrogs>
	 <20241002150213.GC21853@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTEwLTAyIGF0IDA4OjAyIC0wNzAwLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6
Cj4gRnJvbTogRGFycmljayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4KPiAKPiBGaWxlIGNv
bnRlbnRzIGNhbiBvbmx5IGJlIHNoYXJlZCAoaS5lLiByZWZsaW5rZWQpIGJlbG93IEVPRiwgc28g
aXQgbWFrZXMKPiBubyBzZW5zZSB0byB0cnkgdG8gdW5zaGFyZSByYW5nZXMgYmV5b25kIEVPRi7C
oCBDb25zdHJhaW4gdGhlIGZpbGUgcmFuZ2UKPiBwYXJhbWV0ZXJzIGhlcmUgc28gdGhhdCB3ZSBk
b24ndCBoYXZlIHRvIGRvIHRoYXQgaW4gdGhlIGNhbGxlcnMuCj4gCj4gRml4ZXM6IDVmNGU1NzUy
YThhMyAoImZzOiBhZGQgaW9tYXBfZmlsZV9kaXJ0eSIpCj4gU2lnbmVkLW9mZi1ieTogRGFycmlj
ayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4KPiAtLS0KPiDCoGZzL2RheC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDYgKysrKystCj4gwqBmcy9pb21hcC9idWZmZXJl
ZC1pby5jIHzCoMKgwqAgNiArKysrKy0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvZGF4LmMgYi9mcy9kYXgu
Ywo+IGluZGV4IGJlY2I0YTY5MjBjNmEuLmM2MmFjZDI4MTJmOGQgMTAwNjQ0Cj4gLS0tIGEvZnMv
ZGF4LmMKPiArKysgYi9mcy9kYXguYwo+IEBAIC0xMzA1LDExICsxMzA1LDE1IEBAIGludCBkYXhf
ZmlsZV91bnNoYXJlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdAo+IHBvcywgbG9mZl90IGxl
biwKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGlvbWFwX2l0ZXIgaXRlciA9IHsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5pbm9kZcKgwqDCoMKgwqDCoMKgwqDCoMKgPSBpbm9k
ZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5wb3PCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqA9IHBvcywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmxlbsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoD0gbGVuLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLmZsYWdzwqDCoMKgwqDCoMKgwqDCoMKgwqA9IElPTUFQX1dSSVRFIHwgSU9NQVBfVU5TSEFS
RSB8Cj4gSU9NQVBfREFYLAo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+ICvCoMKgwqDCoMKgwqDCoGxv
ZmZfdCBzaXplID0gaV9zaXplX3JlYWQoaW5vZGUpOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0
Owo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHBvcyA8IDAgfHwgcG9zID49IHNpemUpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqBpdGVyLmxlbiA9IG1pbihsZW4sIHNpemUgLSBwb3MpOwo+IMKgwqDCoMKgwqDCoMKgwqB3aGls
ZSAoKHJldCA9IGlvbWFwX2l0ZXIoJml0ZXIsIG9wcykpID4gMCkKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGl0ZXIucHJvY2Vzc2VkID0gZGF4X3Vuc2hhcmVfaXRlcigmaXRlcik7
Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gZGlmZiAtLWdpdCBhL2ZzL2lvbWFwL2J1
ZmZlcmVkLWlvLmMgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jCj4gaW5kZXggYzFjNTU5ZTBjYzA3
Yy4uNzhlYmQyNjVmNDI1OSAxMDA2NDQKPiAtLS0gYS9mcy9pb21hcC9idWZmZXJlZC1pby5jCj4g
KysrIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYwo+IEBAIC0xMzc1LDExICsxMzc1LDE1IEBAIGlv
bWFwX2ZpbGVfdW5zaGFyZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QKPiBwb3MsIGxvZmZf
dCBsZW4sCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpb21hcF9pdGVyIGl0ZXIgPSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaW5vZGXCoMKgwqDCoMKgwqDCoMKgwqDCoD0g
aW5vZGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucG9zwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgPSBwb3MsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5sZW7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9IGxlbiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5mbGFnc8KgwqDCoMKgwqDCoMKgwqDCoMKgPSBJT01BUF9XUklURSB8IElPTUFQX1VO
U0hBUkUsCj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gK8KgwqDCoMKgwqDCoMKgbG9mZl90IHNpemUg
PSBpX3NpemVfcmVhZChpbm9kZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gwqAKPiAr
wqDCoMKgwqDCoMKgwqBpZiAocG9zIDwgMCB8fCBwb3MgPj0gc2l6ZSkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGl0ZXIubGVu
ID0gbWluKGxlbiwgc2l6ZSAtIHBvcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoHdoaWxlICgocmV0ID0g
aW9tYXBfaXRlcigmaXRlciwgb3BzKSkgPiAwKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaXRlci5wcm9jZXNzZWQgPSBpb21hcF91bnNoYXJlX2l0ZXIoJml0ZXIpOwo+IMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gcmV0OwoKU29ycnkgSSBkaWRu4oCZdCB1cGRhdGUgdGhlIHBhdGNo
IHNvb25lcuKAlEkgd2FzIHBsYW5uaW5nIHRvIGdldCB0byBpdCBhZnRlcgp3cmFwcGluZyB1cCBt
eSB3ZWVrLWxvbmcgdmFjYXRpb24uLi4gQW55d2F5LCB0aGFua3MgZm9yIHRoZSBwYXRjaCwgaXQg
bG9va3MKZ3JlYXQhCgpUaGFua3MsCi0tIApKdWxpYW4gU3VuIDxzdW5qdW5jaGFvMjg3MEBnbWFp
bC5jb20+Cg==


