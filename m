Return-Path: <linux-fsdevel+bounces-67530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEBAC42B9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 12:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27F1C4E5C46
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3F3009D8;
	Sat,  8 Nov 2025 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4huGEO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCC1F3FE2
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600017; cv=none; b=HhUljFz/lYKgTNK/rq0k9bB/RDV1mQA26oMYZsUmxnz3Z03kyapj5OpDJwrM5+kueSkVgHXI8vkJFr8jrv29NWzsBk9dvKZNcnP2f1K0TbTTDD2RUl9i16nq+idTXoNl1nivzBBtivWCsmuxG0f8EBJNLaFIkFqVhFjySGKcN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600017; c=relaxed/simple;
	bh=i08KUySVAHCfUlFFBoI2K5PUmPZWNpyc3hoS9Mc7Ays=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7rTaS/Qf36N5geWaVF272mvcupiR4umx4OiVFHCPC2/ubtFZPs1Fckq0i6Hs9d4wwRZNHfQj7QBUmftFueqorJevqBDAdOks+L+qaDPXuL/ZmIB1NVyq6vkYbN8rKZUd8VDYvAmKwklzJicCPTtu/c39Kvc+CFgQSKZe0F7B8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4huGEO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF247C16AAE
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762600016;
	bh=i08KUySVAHCfUlFFBoI2K5PUmPZWNpyc3hoS9Mc7Ays=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G4huGEO/b6xJ2xCcPgkP5e5DxcH2ZlCXf4jVbsW/NLvmlgFyJUUl4cODjXU2gP+Ny
	 i7iF/hIh/QdDPGVSrhdcq6NupdP6z6ZQtXlxqKrR13cIg32vh2e6CWzD33FcZ2nOFN
	 GEU8JeSmiCyty4wD4fZeNeDpYhzondyydoJpaqV4MM5kkIVaDcK6Qr+kasaCta5pGt
	 bgF2iYuAGP1pu+Bz8Hy+MXtiEnLGFFV/CTDKBZo96ZjpTAMW+GA2bIPjz3JtNUhTab
	 X8te8YWuObf4o+2RqLLBtI2f+CqtwaW6MaRpC+Zvd6lRfSINxomHzad/vYk06YJRL9
	 k8FPhcvFHApEg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso2727715a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 03:06:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8ShSELWm03LoExd5qA2XUrqqxWnolp7FOiKSUkGxPgN5Ct7mZEkeVFzT2D8dn/yDL6V0N53mB8oBJeBBO@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKO8gkrOXn9xCwTYbHGnnsx7DlvEhe12dUlpeYPjxv6PzHLZg
	ygn4NFJQaP5D+iKDOieMZbdmPDZzaulHPhgEfROEfCdRzuuwQfmIayP4nSAGCqHInSp9Fzljz+K
	E+PB96zi7Bqiwonv5rvPbiNJA+VmCVxk=
X-Google-Smtp-Source: AGHT+IGs4bi2Mul+LCRlbtbW3N+2AJ4M7pLPj9IaiKkFaiTgWf1tqEI8u8Pg8vsviMdt16PRWbPfSeY5sVCWYbhZxTI=
X-Received: by 2002:a17:907:948f:b0:b41:f729:77b0 with SMTP id
 a640c23a62f3a-b72e02d5f28mr198115066b.21.1762600015286; Sat, 08 Nov 2025
 03:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
In-Reply-To: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 8 Nov 2025 20:06:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ycMzZ+o2wDMk4tdE8msafQ1syedsC-n19i=0Bba-x4Q@mail.gmail.com>
X-Gm-Features: AWmQ_bngaZ9A3ODAreoJc5WofqCVZgsbb2ETOPrvu0RwrMMsiUd8xA5dU-m8foc
Message-ID: <CAKYAXd-ycMzZ+o2wDMk4tdE8msafQ1syedsC-n19i=0Bba-x4Q@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
To: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: multipart/mixed; boundary="000000000000cb1f2a0643134be5"

--000000000000cb1f2a0643134be5
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000cb1f2a0643134be5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-exfat-validate-the-cluster-bitmap-bits-of-root-direc.patch"
Content-Disposition: attachment; 
	filename="0001-exfat-validate-the-cluster-bitmap-bits-of-root-direc.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhq6iiex0>
X-Attachment-Id: f_mhq6iiex0

RnJvbSBlNzVjNTcyNTc2MmRkZGZlNWI2MThmOGVmOWU4YWM4ODRkOGQ2NmJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBTYXQsIDggTm92IDIwMjUgMjA6MDQ6MDQgKzA5MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogdmFsaWRhdGUgdGhlIGNsdXN0ZXIgYml0bWFwIGJpdHMgb2Ygcm9vdCBkaXJlY3RvcnkKClN5
emJvdCBjcmVhdGVkIHRoaXMgaXNzdWUgYnkgdGVzdGluZyBhbiBpbWFnZSB0aGF0IGRpZCBub3Qg
aGF2ZSB0aGUgcm9vdApjbHVzdGVyIGJpdG1hcCBiaXQgbWFya2VkLiBBZnRlciBhY2Nlc3Npbmcg
YSBmaWxlIHRocm91Z2ggdGhlIHJvb3QKZGlyZWN0b3J5IHZpYSBleGZhdF9sb29rdXAsIHdoZW4g
Y3JlYXRpbmcgYSBmaWxlIGFnYWluIHdpdGggbWtkaXIsCnRoZSByb290IGNsdXN0ZXIgYml0IGNh
biBiZSBhbGxvY2F0ZWQgZm9yIGRpcmVjb3RyeSwgd2hpY2ggY2FuIGNhdXNlCnRoZSByb290IGNs
dXN0ZXIgdG8gYmUgemVyb2VkIG91dCBhbmQgdGhlIHNhbWUgZW50cnkgY2FuIGJlIGFsbG9jYXRl
ZAppbiB0aGUgc2FtZSBjbHVzdGVyLiBUaGlzIHBhdGNoIGltcHJvdmVkIHRoaXMgaXNzdWUgYnkg
YWRkaW5nCmV4ZmF0X3Rlc3RfYml0bWFwIHRvIGNoZWNrIHRoZSBjbHVzdGVyIGJpdCBhbmQgdmFs
aWRhdGUgdGhlIGNsdXN0ZXJzCm9mIHRoZSByb290IGRpcmVjdG9yeS4KClNpZ25lZC1vZmYtYnk6
IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvZXhmYXQvYmFsbG9j
LmMgICB8IDE5ICsrKysrKysrKysrKysrKysrKysKIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMSAr
CiBmcy9leGZhdC9zdXBlci5jICAgIHwgIDYgKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9leGZhdC9iYWxsb2MuYyBiL2ZzL2V4ZmF0L2Jh
bGxvYy5jCmluZGV4IDJkMmQ1MTBmMjM3Mi4uZTZkNWI5Y2I1NmQ2IDEwMDY0NAotLS0gYS9mcy9l
eGZhdC9iYWxsb2MuYworKysgYi9mcy9leGZhdC9iYWxsb2MuYwpAQCAtMjQsNiArMjQsMjUgQEAK
ICNlcnJvciAiQklUU19QRVJfTE9ORyBub3QgMzIgb3IgNjQiCiAjZW5kaWYKIAorYm9vbCBleGZh
dF90ZXN0X2JpdG1hcChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBpbnQgY2x1KQor
eworCWludCBpLCBiOworCXVuc2lnbmVkIGludCBlbnRfaWR4OworCXN0cnVjdCBleGZhdF9zYl9p
bmZvICpzYmkgPSBFWEZBVF9TQihzYik7CisKKwlpZiAoIWlzX3ZhbGlkX2NsdXN0ZXIoc2JpLCBj
bHUpKQorCQlyZXR1cm4gZmFsc2U7CisKKwllbnRfaWR4ID0gQ0xVU1RFUl9UT19CSVRNQVBfRU5U
KGNsdSk7CisJaSA9IEJJVE1BUF9PRkZTRVRfU0VDVE9SX0lOREVYKHNiLCBlbnRfaWR4KTsKKwli
ID0gQklUTUFQX09GRlNFVF9CSVRfSU5fU0VDVE9SKHNiLCBlbnRfaWR4KTsKKworCWlmICghdGVz
dF9iaXRfbGUoYiwgc2JpLT52b2xfYW1hcFtpXS0+Yl9kYXRhKSkKKwkJcmV0dXJuIGZhbHNlOwor
CisJcmV0dXJuIHRydWU7Cit9CisKIC8qCiAgKiAgQWxsb2NhdGlvbiBCaXRtYXAgTWFuYWdlbWVu
dCBGdW5jdGlvbnMKICAqLwpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBiL2ZzL2V4
ZmF0L2V4ZmF0X2ZzLmgKaW5kZXggMzgyMTBmYjY5MDFjLi42YTMxNzkxNzUwNmMgMTAwNjQ0Ci0t
LSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgKKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaApAQCAtNDUw
LDYgKzQ1MCw3IEBAIGludCBleGZhdF9jb3VudF9udW1fY2x1c3RlcnMoc3RydWN0IHN1cGVyX2Js
b2NrICpzYiwKIAkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2NoYWluLCB1bnNpZ25lZCBpbnQgKnJl
dF9jb3VudCk7CiAKIC8qIGJhbGxvYy5jICovCitib29sIGV4ZmF0X3Rlc3RfYml0bWFwKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIGludCBjbHUpOwogaW50IGV4ZmF0X2xvYWRfYml0
bWFwKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpOwogdm9pZCBleGZhdF9mcmVlX2JpdG1hcChzdHJ1
Y3QgZXhmYXRfc2JfaW5mbyAqc2JpKTsKIGludCBleGZhdF9zZXRfYml0bWFwKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHUsIGJvb2wgc3luYyk7CmRpZmYgLS1naXQgYS9mcy9l
eGZhdC9zdXBlci5jIGIvZnMvZXhmYXQvc3VwZXIuYwppbmRleCA3Zjk1OTI4NTZiZjcuLmNlMDVk
YzYwNGUxMyAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvc3VwZXIuYworKysgYi9mcy9leGZhdC9zdXBl
ci5jCkBAIC02MjYsNiArNjI2LDEyIEBAIHN0YXRpYyBpbnQgX19leGZhdF9maWxsX3N1cGVyKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJCWdvdG8gZnJlZV9iaDsKIAl9CiAKKwlpZiAoIWV4ZmF0
X3Rlc3RfYml0bWFwKHNiLCBzYmktPnJvb3RfZGlyKSkgeworCQlleGZhdF9lcnIoc2IsICJmYWls
ZWQgdG8gdGVzdCByb290IGNsdXN0ZXIgYml0Iik7CisJCXJldCA9IC1FSU87CisJCWdvdG8gZnJl
ZV9hbGxvY19iaXRtYXA7CisJfQorCiAJcmV0ID0gZXhmYXRfY291bnRfdXNlZF9jbHVzdGVycyhz
YiwgJnNiaS0+dXNlZF9jbHVzdGVycyk7CiAJaWYgKHJldCkgewogCQlleGZhdF9lcnIoc2IsICJm
YWlsZWQgdG8gc2NhbiBjbHVzdGVycyIpOwotLSAKMi4yNS4xCgo=
--000000000000cb1f2a0643134be5--

