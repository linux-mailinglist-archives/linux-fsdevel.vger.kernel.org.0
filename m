Return-Path: <linux-fsdevel+bounces-27530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D6796219F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C7D287C06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2715B109;
	Wed, 28 Aug 2024 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd/FwTEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA615ADBC;
	Wed, 28 Aug 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831056; cv=none; b=WQDdsSF7pR84wLF8OFcHxSddGK9+ctmUIiRNiRbKNCig486ujaG9CrG3W2tydtVQ9BD5ZAt2WBvYS5rETCB+qmWxQU8g75SjOfNz+OWbboCVxlB+fMhLFlWKW6t3P/H9p40DIcCHt0ODLX/rQeiaRZXBWnjeyjxE4W5cUi+G558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831056; c=relaxed/simple;
	bh=AZn9vfJ18FINJDEAecjIJtugo4dJJ9iBWr7T821QVis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mb+fnx+KnQHfAyKr0/0UvCL70QVsfo9UtrFwDzf84Vkjl05to9zDbqz0rmjHgkXbNiHX3jV2IfhOTz8d9DOR6Ja2qlr5WdbsqTECwjgQxrjBZAgXtXwFIyVY67MbhbnUlRQVbDN9XKS3GgXt1wT+b+Q6Xv+2/BHAx50PRVfrwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd/FwTEE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201df0b2df4so52211265ad.0;
        Wed, 28 Aug 2024 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724831055; x=1725435855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZn9vfJ18FINJDEAecjIJtugo4dJJ9iBWr7T821QVis=;
        b=Gd/FwTEEt3mtSIiCnLjIWC+K/HtCLQPVDkoM6HgximQZrdehayZsy+RV3eJmLeGEgn
         07Tu3JxPp0g0+BOTU7pkyp7pge12kLo7FdPdAmKHUs6M9HmM2T2xMUujYyxB7i4Jevon
         5OPuWSpqrENtZm53TOfV8fv0ZRzOeIeSMDELLwhT+d2DZ0xbcDc3eDKQmC4EVP56crPl
         MV6bRwEgmaL0R26Wa56S4p1YNLYJ3ZI1s+F/NeAxFZTTMO7ut4Hg13EAESN1+6VBeDVr
         I7V5ReqipqESzd6s+qK/Rj82M/hGjs+I9EN87I34CW4gesFztz5OAB0Z+c4mkla8ouc6
         yNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831055; x=1725435855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZn9vfJ18FINJDEAecjIJtugo4dJJ9iBWr7T821QVis=;
        b=j/N6O+ygCLACpQl4oK9YJCaJ3vFTe3EeScNGwLC7Y3Z/hFs93lnW5ye1h2qx108y37
         EZ9sdgZA5/5ON412y5G0LHojIH2qcmmm5o6KTX9W4mzZcmMfVrGDwmheMl6rxAovGDBW
         m0VvHhPdvwUgf++1GmE6oSFIfI6UpseRsVs1d8Wsr3SDlazAfohPGikyAj646cqx0tTq
         MHy6mSL704gMqx3McCUVuYIlIQ24aubrWEy8cqvrKW6QHVRzXOq/KNYPsC6s0GF/qm5r
         /XLeGl6sUUK4rtUYTA/7j/oDXnk4WWLc9qv3eOQ2UGWLloJ5ULdwE6j4EV9Y98mEH2m+
         JL2w==
X-Forwarded-Encrypted: i=1; AJvYcCUEry5PxYjk5rCv93ouPWcpF6XW03xoOXWz970UwEIwYJ4ZjRc1x7A3zuDMbBEy/wS1EhuJnQevFh7Ri0xX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cFofwmPHa/dHJTIypxKRBTmvIyk6NeANhXbpxXxcWY54cHm0
	qWREFEf5vpjU1QKiFvFe8pQDo1tSAYu0jy6wAOFb4PenSMBnOVxF
X-Google-Smtp-Source: AGHT+IE4SHYBwJ9aQmpHYvHdpk1bgbZK0HDFz2UQKnP2XXO+0jKMwzUCxpMP+5hRDqgm9+kOeOfwGg==
X-Received: by 2002:a17:903:2288:b0:203:a134:78ce with SMTP id d9443c01a7336-203a13478ecmr183465465ad.14.1724831054556;
        Wed, 28 Aug 2024 00:44:14 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd256sm93808325ad.170.2024.08.28.00.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:44:13 -0700 (PDT)
Message-ID: <9e9f7e7eb26dd312df1208ae5771c0bf6acf7730.camel@gmail.com>
Subject: Re: [PATCH] writeback: Refine the show_inode_state() macro
 definition
From: Julian Sun <sunjunchao2870@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, mhiramat@kernel.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Date: Wed, 28 Aug 2024 15:44:10 +0800
In-Reply-To: <20240827162150.rzgnguesq44yqd57@quack3>
References: <20240820095229.380539-1-sunjunchao2870@gmail.com>
	 <20240827162150.rzgnguesq44yqd57@quack3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA4LTI3IGF0IDE4OjIxICswMjAwLCBKYW4gS2FyYSB3cm90ZToKPiBPbiBU
dWUgMjAtMDgtMjQgMTc6NTI6MjksIEp1bGlhbiBTdW4gd3JvdGU6Cj4gPiBDdXJyZW50bHksIHRo
ZSBzaG93X2lub2RlX3N0YXRlKCkgbWFjcm8gb25seSBwcmludHMKPiA+IHBhcnQgb2YgdGhlIHN0
YXRlIG9mIGlub2RlLT5pX3N0YXRlLiBMZXTigJlzIGltcHJvdmUgaXQKPiA+IHRvIGRpc3BsYXkg
bW9yZSBvZiBpdHMgc3RhdGUuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEp1bGlhbiBTdW4gPHN1
bmp1bmNoYW8yODcwQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gwqBpbmNsdWRlL3RyYWNlL2V2ZW50
cy93cml0ZWJhY2suaCB8IDExICsrKysrKysrKystCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gWWVhaCwgaXQgY291bGQgYmUgdXNlZnVs
IGF0IHRpbWVzLiBTb21lIGNvbW1lbnRzIGJlbG93Lgo+IAo+ID4gQEAgLTIwLDcgKzIwLDE2IEBA
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHtJX0NMRUFSLMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCJJX0NMRUFSIn0swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBc
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHtJX1NZTkMswqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAiSV9TWU5DIn0swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oFwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKge0lfRElSVFlfVElNRSzCoMKg
wqDCoMKgwqDCoMKgwqDCoCJJX0RJUlRZX1RJTUUifSzCoMKgwqDCoMKgwqDCoMKgXAo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHtJX1JFRkVSRU5DRUQswqDCoMKgwqDCoMKgwqDC
oMKgwqAiSV9SRUZFUkVOQ0VEIn3CoMKgwqDCoMKgwqDCoMKgwqBcCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKge0lfUkVGRVJFTkNFRCzCoMKgwqDCoMKgwqDCoMKgwqDCoCJJX1JF
RkVSRU5DRUQifSzCoMKgwqDCoMKgwqDCoMKgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHtJX0RJT19XQUtFVVAswqDCoCJJX0RJT19XQUtFVVAifSzCoMKgwqDCoMKgwqDCoMKg
XAo+IAo+IElfRElPX1dBS0VVUCBpcyBuZXZlciBzZXQgYW5kIGlzIGJlaW5nIHJlbW92ZWQsIHBs
ZWFzZSBkb24ndCBwdXQgaXQKPiBoZXJlLgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHtJX0xJTktBQkxFLMKgwqDCoMKgIklfTElOS0FCTEUifSzCoMKgXAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHtJX0RJUlRZX1RJTUUswqDCoCJJX0RJUlRZX1RJTUUi
fSzCoMKgwqDCoMKgwqDCoMKgXAo+IAo+IFVtLCBJX0RJUlRZX1RJTUUgaXMgYWxyZWFkeSBpbmNs
dWRlZC4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB7SV9XQl9TV0lUQ0gs
wqDCoMKgIklfV0JfU1dJVENIIn0swqBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKge0lfT1ZMX0lOVVNFLMKgwqDCoCJJX09WTF9JTlVTRSJ9LMKgXAo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHtJX0NSRUFUSU5HLMKgwqDCoMKgIklfQ1JFQVRJTkcifSzCoMKg
XAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHtJX0RPTlRDQUNIRSzCoMKgwqAi
SV9ET05UQ0FDSEUifSzCoFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB7SV9T
WU5DX1FVRVVFRCzCoCJJX1NZTkNfUVVFVUVEIn0swqDCoMKgwqDCoMKgwqBcCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKge0lfUElOTklOR19ORVRGU19XQiwgIklfUElOTklOR19O
RVRGU19XQiJ9IFwKPiA+IMKgwqDCoMKgwqDCoMKgwqApCj4gCj4gT3RoZXJ3aXNlIHRoZSBwYXRj
aCBsb29rcyBnb29kIHRvIG1lLgpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBjb21tZW50cywg
SSB3aWxsIGZpeCB0aGVtIGluIHBhdGNoIHYyLgo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgSG9uemEKClRo
YW5rcywKLS0gCkp1bGlhbiBTdW4gPHN1bmp1bmNoYW8yODcwQGdtYWlsLmNvbT4K


