Return-Path: <linux-fsdevel+bounces-70280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB28CC95091
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB5504E050D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4658230BCB;
	Sun, 30 Nov 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzhcLkA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAF22576E
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515022; cv=none; b=Y4VuHSDXIM+uf53sREsvlABHC38WEKr5N075d+DqRYxLtWGtI/s1x2mB9Fz6kmL2fgl5sEMc6+/VmOMLo1kaVN1qSMtqaqJyTvmvE5Yf0h2qCvvl3TBrsNgAfs7oYCK+eozDTZNZ3jEPd+oAEh6mrVYaMX3WlQX0BgXW3fo6+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515022; c=relaxed/simple;
	bh=454k0NdJ//sqxnUnQcRzwDFYCemOmxV74PVkMloNpm8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=JkflXmxceVchigpdBTkkudeumPHtgjyBrmBZYjf4CnQo5jGnbXUAOBxD5PY6Ci0TIF6JFWm2YHqlwcpPbyTVeEJDZO6wgVUlKWgVNDkJrDaW7gzzCGWtBnECBySJ8Hg6AGWMBSuevjzjLZdmyv/3hrr0R9s1eiw91T6yGAtpdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzhcLkA7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2955623e6faso36048825ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 07:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764515019; x=1765119819; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=454k0NdJ//sqxnUnQcRzwDFYCemOmxV74PVkMloNpm8=;
        b=HzhcLkA7+MrzTq6M5R4/E5mWJd6nKoX2zTDhxQdKvTB5JLMqFwq949L0uC9P3ps5RE
         Av13/apv/xqBEkacQ5h1qoQ7Tx3mUmzDT+VT94wd6xprpeaQd9lNWMBZbZTg+ETtUuu3
         iAr+CFvmx8bhoLAHFU+U8Sw2vAO1kXzUotTOQQ9+qiarpU5IogtU+qjYTORhkKl4qakZ
         /8BNlUEKax75cvxeqHWi1HQWV8xpVd8H/Vst77ssmEq3EJpxr8FdUEpDz0YsbwPOF3C3
         WSkY9nip8dFigNk1/RlQTlqPSbUKijmCbfZTOY2W+5ufUx6vJegMWR9INaD4zUDNvq6w
         qywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764515019; x=1765119819;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=454k0NdJ//sqxnUnQcRzwDFYCemOmxV74PVkMloNpm8=;
        b=EgFoYbGZ9XQXZyu6eM4E2EYTOMcS2Fyvoga0f5XqJtiCzDI/PIY+umLqxQL4Sy/o1H
         +0/fp+aEhijEB6NCcQNIOWc2HzYfipckro+Z/9+5KrZaqrJiUJnAq7ktonBrUHP4NQme
         xdYIvZ+lnJejEn0YeAHPKcYGoSSEpr/w4Xm48etEEd+WEgXphT8KQfLjxi5A9IRP3INM
         WE5kWnPdFs2KyaChR6gKM9jXWG9C8086GN26X6CD6W6F1S0yWnXGk4rLcui+zRVNxHI1
         +RhRq7xguFm2Yekv7fHCQvVIR+rlllfk5UuJadBF1qX3nffTXItv5EKHP48f3xJpuSiq
         L1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNyy6s10YFavhIyp4laBSFyq1rXAD4zP4PjBwC/dITycwm67JdBKxRQOTKZwNm2vGrW9SDea8dCGpPDeQu@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvTClHWEsjOUON9wW4InHPpiq1vXz2JM/qOLxin6trUNxhA4A
	oSNcZBgbZFqrv0p81sWtef+ictphHo2TAYGRBDXGnQRn3Mwbl45NR9+B
X-Gm-Gg: ASbGnctrh7y0xSfXimXhmslpZI5jGjWPKz3I1aSqz/iB8BlN1ir6TaI/X7ufnhIYnD4
	AHjIJ4ZwnAhEnO8iq2q5hzwUYp8on06tlxUP+O6oG5GIfPv+dCF7TX5P4qG1hk1s/XyqaN+0AeZ
	Lu09JP7PpwimvOmidk4puUUu6V9f+/DsA351kI3TK7QAEkYEi1Hem97Jj2D0fMpOlYc1KmIM008
	cAfwyBK0eL1IbkZ4v9PVh0VbGJbdCEels5JNG63GCT7prJ7Lbf9N2Wu3+XuJ72f7H9IM0Rfu/6z
	AWkfzx1suN9HPj3tzdbGPBLfJP+QLK1VWGWQyRiM2L+4PC5bXz6wY7hDvuWXuFZMA7zIMSNlWsi
	0Hy8DiPjSY0stxf6ElKm3M9IosJWXjsHc1KZMwPGYoIz3nuOLkc43kbg+WEBLtySZOafVIJqz+l
	DUrpfx0moVppcyq/72imDMSF6UHiftvVwOwptvfJEeAlF7ApYEjB5c/cQ=
X-Google-Smtp-Source: AGHT+IGu+nWwawV5ChwOmhhJwGD5r7xlcIavX7xc1c5+WEOiPICxEOVPDqZSgI99fAXCkzUDemR2cw==
X-Received: by 2002:a17:902:f54a:b0:295:6427:87d4 with SMTP id d9443c01a7336-29bab1db61fmr227655505ad.50.1764515019196;
        Sun, 30 Nov 2025 07:03:39 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:f0ca:4857:a475:749a? ([2405:201:31:d869:f0ca:4857:a475:749a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fb1486asm10660567b3a.61.2025.11.30.07.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 07:03:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------PBFi06tPLAhiQ94kFTybRu9c"
Message-ID: <ff6e08e2-a7c7-4ebf-8f93-03e5ece9b335@gmail.com>
Date: Sun, 30 Nov 2025 20:33:33 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, brauner@kernel.org, hare@suse.de,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mcgrof@kernel.org, syzkaller-bugs@googlegroups.com,
 willy@infradead.org
References: <680ae31e.050a0220.2c0118.0c72.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] kernel BUG in __filemap_add_folio
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <680ae31e.050a0220.2c0118.0c72.GAE@google.com>

This is a multi-part message in MIME format.
--------------PBFi06tPLAhiQ94kFTybRu9c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------PBFi06tPLAhiQ94kFTybRu9c
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-mm-readahead-fix-race-between-page_cache_ra_order-an.patch"
Content-Disposition: attachment;
 filename*0="0001-mm-readahead-fix-race-between-page_cache_ra_order-an.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlYzdlYTlhMWYwM2YzNjY3MmNmNWFjYjIzNzYxY2ZlZjZiOTQ4ZjIxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogU3VuLCAzMCBOb3YgMjAyNSAyMDoyNzoyNSArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIG1tL3JlYWRhaGVhZDogZml4IHJhY2UgYmV0d2VlbiBwYWdlX2NhY2hlX3Jh
X29yZGVyIGFuZAogc2V0X2Jsb2Nrc2l6ZQoKcGFnZV9jYWNoZV9yYV9vcmRlcigpIHJlYWRz
IG1hcHBpbmdfbWluX2ZvbGlvX29yZGVyKCkgYmVmb3JlIGFjcXVpcmluZwp0aGUgaW52YWxp
ZGF0ZV9sb2NrLCBjcmVhdGluZyBhIHRpbWUtb2YtY2hlY2stdGltZS1vZi11c2UgKFRPQ1RP
VSkgcmFjZQp3aXRoIHNldF9ibG9ja3NpemUoKSB3aGljaCBjYW4gY2hhbmdlIHRoZSBtYXBw
aW5nJ3MgbWluX2ZvbGlvX29yZGVyCndoaWxlIGhvbGRpbmcgdGhlIGludmFsaWRhdGVfbG9j
ayBleGNsdXNpdmVseS4KCklmIHNldF9ibG9ja3NpemUoKSBpbmNyZWFzZXMgdGhlIG1hcHBp
bmcncyBtaW5fZm9saW9fb3JkZXIgYWZ0ZXIKcGFnZV9jYWNoZV9yYV9vcmRlcigpIHJlYWRz
IHRoZSBvbGQgdmFsdWUgYnV0IGJlZm9yZSBpdCBhZGRzIGZvbGlvcwp0byB0aGUgcGFnZSBj
YWNoZSwgdGhlIFZNX0JVR19PTiBjaGVjayBpbiBfX2ZpbGVtYXBfYWRkX2ZvbGlvKCkgd2ls
bAp0cmlnZ2VyOgoKICBWTV9CVUdfT05fRk9MSU8oZm9saW9fb3JkZXIoZm9saW8pIDwgbWFw
cGluZ19taW5fZm9saW9fb3JkZXIobWFwcGluZyksCiAgICAgICAgICAgICAgICAgIGZvbGlv
KTsKClRoaXMgY2FuIGhhcHBlbiBiZWNhdXNlIHRoZSBzdGFsZSBtaW5fb3JkZXIgaXMgdXNl
ZCB0byBjYWxjdWxhdGUKbmV3X29yZGVyIGFuZCBjb25zdHJhaW4gdGhlIGZvbGlvIG9yZGVy
LCBidXQgZmlsZW1hcF9hZGRfZm9saW8oKQpyZS1yZWFkcyB0aGUgKG5vdyBpbmNyZWFzZWQp
IG1pbl9mb2xpb19vcmRlciBmcm9tIHRoZSBtYXBwaW5nLgoKRml4IHRoaXMgYnkgbW92aW5n
IHRoZSByZWFkIG9mIG1hcHBpbmdfbWluX2ZvbGlvX29yZGVyKCkgYW5kIHRoZQpuZXdfb3Jk
ZXIgY2FsY3VsYXRpb24gdG8gYWZ0ZXIgdGhlIGludmFsaWRhdGVfbG9jayBpcyBhY3F1aXJl
ZCBpbgpzaGFyZWQgbW9kZS4KClJlcG9ydGVkLWJ5OiBzeXpib3QrNGQzY2MzM2VmN2E3NzA0
MWVmYTZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2Fs
bGVyLmFwcHNwb3QuY29tL2J1Z1w/ZXh0aWRcPTRkM2NjMzNlZjdhNzcwNDFlZmE2CkZpeGVz
OiA0N2RkNjc1MzIzMDMgKCJibG9jay9iZGV2OiBsaWZ0IGJsb2NrIHNpemUgcmVzdHJpY3Rp
b25zIHRvIDY0ayIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6
IFNoYXVyeWEgUmFuZSA8c3NyYW5lX2IyM0BlZS52anRpLmFjLmluPgotLS0KIG1tL3JlYWRh
aGVhZC5jIHwgMTUgKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9yZWFkYWhlYWQuYyBi
L21tL3JlYWRhaGVhZC5jCmluZGV4IDNhNGI1ZDU4ZWViNi4uOTU3MThmODdiZDQzIDEwMDY0
NAotLS0gYS9tbS9yZWFkYWhlYWQuYworKysgYi9tbS9yZWFkYWhlYWQuYwpAQCAtNDY3LDcg
KzQ2Nyw3IEBAIHZvaWQgcGFnZV9jYWNoZV9yYV9vcmRlcihzdHJ1Y3QgcmVhZGFoZWFkX2Nv
bnRyb2wgKnJhY3RsLAogCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gcmFjdGwt
Pm1hcHBpbmc7CiAJcGdvZmZfdCBzdGFydCA9IHJlYWRhaGVhZF9pbmRleChyYWN0bCk7CiAJ
cGdvZmZfdCBpbmRleCA9IHN0YXJ0OwotCXVuc2lnbmVkIGludCBtaW5fb3JkZXIgPSBtYXBw
aW5nX21pbl9mb2xpb19vcmRlcihtYXBwaW5nKTsKKwl1bnNpZ25lZCBpbnQgbWluX29yZGVy
OwogCXBnb2ZmX3QgbGltaXQgPSAoaV9zaXplX3JlYWQobWFwcGluZy0+aG9zdCkgLSAxKSA+
PiBQQUdFX1NISUZUOwogCXBnb2ZmX3QgbWFyayA9IGluZGV4ICsgcmEtPnNpemUgLSByYS0+
YXN5bmNfc2l6ZTsKIAl1bnNpZ25lZCBpbnQgbm9mczsKQEAgLTQ4MywxNSArNDgzLDIyIEBA
IHZvaWQgcGFnZV9jYWNoZV9yYV9vcmRlcihzdHJ1Y3QgcmVhZGFoZWFkX2NvbnRyb2wgKnJh
Y3RsLAogCiAJbGltaXQgPSBtaW4obGltaXQsIGluZGV4ICsgcmEtPnNpemUgLSAxKTsKIAor
CS8qIFNlZSBjb21tZW50IGluIHBhZ2VfY2FjaGVfcmFfdW5ib3VuZGVkKCkgKi8KKwlub2Zz
ID0gbWVtYWxsb2Nfbm9mc19zYXZlKCk7CisJZmlsZW1hcF9pbnZhbGlkYXRlX2xvY2tfc2hh
cmVkKG1hcHBpbmcpOworCisJLyoKKwkgKiBSZS1yZWFkIG1pbl9vcmRlciBhZnRlciBhY3F1
aXJpbmcgdGhlIGludmFsaWRhdGVfbG9jayB0byBhdm9pZCBhCisJICogcmFjZSB3aXRoIHNl
dF9ibG9ja3NpemUoKSB3aGljaCBjYW4gY2hhbmdlIHRoZSBtYXBwaW5nJ3MgbWluX29yZGVy
CisJICogd2hpbGUgaG9sZGluZyB0aGUgaW52YWxpZGF0ZV9sb2NrIGV4Y2x1c2l2ZWx5Lgor
CSAqLworCW1pbl9vcmRlciA9IG1hcHBpbmdfbWluX2ZvbGlvX29yZGVyKG1hcHBpbmcpOwog
CW5ld19vcmRlciA9IG1pbihtYXBwaW5nX21heF9mb2xpb19vcmRlcihtYXBwaW5nKSwgbmV3
X29yZGVyKTsKIAluZXdfb3JkZXIgPSBtaW5fdCh1bnNpZ25lZCBpbnQsIG5ld19vcmRlciwg
aWxvZzIocmEtPnNpemUpKTsKIAluZXdfb3JkZXIgPSBtYXgobmV3X29yZGVyLCBtaW5fb3Jk
ZXIpOwogCiAJcmEtPm9yZGVyID0gbmV3X29yZGVyOwogCi0JLyogU2VlIGNvbW1lbnQgaW4g
cGFnZV9jYWNoZV9yYV91bmJvdW5kZWQoKSAqLwotCW5vZnMgPSBtZW1hbGxvY19ub2ZzX3Nh
dmUoKTsKLQlmaWxlbWFwX2ludmFsaWRhdGVfbG9ja19zaGFyZWQobWFwcGluZyk7CiAJLyoK
IAkgKiBJZiB0aGUgbmV3X29yZGVyIGlzIGdyZWF0ZXIgdGhhbiBtaW5fb3JkZXIgYW5kIGlu
ZGV4IGlzCiAJICogYWxyZWFkeSBhbGlnbmVkIHRvIG5ld19vcmRlciwgdGhlbiB0aGlzIHdp
bGwgYmUgbm9vcCBhcyBpbmRleAotLSAKMi4zNC4xCgo=

--------------PBFi06tPLAhiQ94kFTybRu9c--

