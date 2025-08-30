Return-Path: <linux-fsdevel+bounces-59702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FEFB3C861
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 07:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3EC1C24467
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 05:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4521B199;
	Sat, 30 Aug 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYYvkSPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69B1DF271;
	Sat, 30 Aug 2025 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756533203; cv=none; b=nKgFSmXeOs6Tb7I9I6Kscctm8QJvst+NXCSo9B3hGx7SUry4JU36b+M3zm8onjglYG/ja4Ed+gCTsUVvFPQQ3F1zjPHT4p9CcH4Tcc/yRsIsDGZ6ZKpxQDbW047JF98qayD3w/9VinL2MP/M0Derq5BGaMMWHf7PFu9fcllyAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756533203; c=relaxed/simple;
	bh=lqcd/R+DdO5kMRuz0zLmEsEPGqGzL52ygyU/GACMz7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk52IvG0D4TwCtA71FeoE7moQqfcnQlFWB31IswtLgArwgfAqWnSVKda7wl1spQz2YjqGfMo3KHL6OF3Fjpe0CXDAH8vGiliGf90pTdHHySZD+Bw2Z8JFheiR7mKLTEm/b/ZQEKeUhS0qoRVJE1HlxWjvsu9c4orQrgCMc0qzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYYvkSPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206BEC4CEF8;
	Sat, 30 Aug 2025 05:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756533201;
	bh=lqcd/R+DdO5kMRuz0zLmEsEPGqGzL52ygyU/GACMz7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eYYvkSPDn5pO6z5ABXsXJu4s8YVuFof+B7uR1zBSEpXyj9tjg+e3AdBiJqLfG7gmq
	 TkNK7UBxvKiIpNiepmD/vxqia+JKi6UjbuJL8bEGwdnebU2iw0PldRFWsu1MI07mk/
	 cWlLRzi32/5KfkjCntk+WyPwqx7N4QPKON7xDuMLWckGCflGO/XpauYFUScYtW08kM
	 E6w1fwSPuyMWtn4bGzj2pZyiRSfRYlokSKzmScaA+S2PxSE7Cc0bUpcSfvJwpdx1U2
	 ql+NSDicE6iW3gXMQmTtQYTo7usA2SzM11zla8JLtVccXAbTKweSHQpk/zdjs+y3LI
	 SqX9H8ENvSgZw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb73394b4so413090166b.0;
        Fri, 29 Aug 2025 22:53:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFcRJGGh3i8bv6Sp7jRA1svKz5TBPWNCMSH1vptVNpzD/q5zDuG/YWndyznB3C9dfncTM5PAhe77lIx1oJ@vger.kernel.org, AJvYcCWJTk99PByF9VsU1k8xfP/rwm7fUOi3vpMS2KGL5Pp35mQsQstAsWdZ4GDjt44lZ32vw4iH1McrCf+MscJM1g==@vger.kernel.org, AJvYcCWkdTQGNxIKwf2tXzWJOEwTt84v7NuYUQLf1SOVx5W/XOVD8EIgQ+V9+PxSt/bHvo81iaZiZgSqnStS@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUvJW7iy8nChglNQB9JrVj6jD6IuZOt9XU8CEVNPVYtWvofli
	i8NOfutKofBAPUhWKX/SayAPVyxEnTZLSjl+IbO4ly7KU0bqmhRdTt6Z1WfotawvhyWT75AvhRg
	/34tBalGdG91z0+bMCWa/ZE/PmoSK0vo=
X-Google-Smtp-Source: AGHT+IH7xEcevA/3WhQX4ch/nwc/Yl4aGOqZdV3uUcUo3FUqKaegtJRxTWK3fEyR1689VSDDnAS5kkdpT7LaWsmqUEk=
X-Received: by 2002:a17:907:9408:b0:ae0:b33d:2a4a with SMTP id
 a640c23a62f3a-b01d97558edmr74612566b.35.1756533199639; Fri, 29 Aug 2025
 22:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68a72860.050a0220.3d78fd.002a.GAE@google.com>
In-Reply-To: <68a72860.050a0220.3d78fd.002a.GAE@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 30 Aug 2025 14:53:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8xoejuSenjr5o7SG5o-DsYpfZdQt8QE-JRN2=u2PRMyA@mail.gmail.com>
X-Gm-Features: Ac12FXzymdpfQ6tnXXJr27JuI2ojirZ6swlPiBbQmZtOnYNe2YCbD8QHCyMYw8M
Message-ID: <CAKYAXd8xoejuSenjr5o7SG5o-DsYpfZdQt8QE-JRN2=u2PRMyA@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] [ext4?] WARNING in __rt_mutex_slowlock_locked
To: syzbot <syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com>
Cc: bigeasy@linutronix.de, brauner@kernel.org, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: multipart/mixed; boundary="00000000000066cb21063d8ec129"

--00000000000066cb21063d8ec129
Content-Type: text/plain; charset="UTF-8"

#syz test

--00000000000066cb21063d8ec129
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-exfat-validate-cluster-allocation-bits-of-bitmap.patch"
Content-Disposition: attachment; 
	filename="0001-exfat-validate-cluster-allocation-bits-of-bitmap.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mexufu8b0>
X-Attachment-Id: f_mexufu8b0

RnJvbSAxM2M3ZmE4YzYzN2Y2MmVkMzJhZTgyMzFkYzM5NWQ3NjUwM2M2ZmRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBTYXQsIDMwIEF1ZyAyMDI1IDE0OjQ0OjM1ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gZXhm
YXQ6IHZhbGlkYXRlIGNsdXN0ZXIgYWxsb2NhdGlvbiBiaXRzIG9mIHRoZSBhbGxvY2F0aW9uIGJp
dG1hcAoKVGhpcyBwYXRjaCBhZGRzIGV4ZmF0X3Rlc3RfYml0bWFwX3JhbmdlIHRvIHZhbGlkYXRl
IHRoYXQgY2x1c3RlcnMgdXNlZCBmb3IKdGhlIGFsbG9jYXRpb24gYml0bWFwIGFyZSBjb3JyZWN0
bHkgbWFya2VkIGFzIGluLXVzZS4KClNpZ25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5q
ZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvZXhmYXQvYmFsbG9jLmMgfCA3MiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYwIGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2JhbGxv
Yy5jIGIvZnMvZXhmYXQvYmFsbG9jLmMKaW5kZXggY2MwMTU1NmM5ZDliLi5jMDliZGIxNzYyZjQg
MTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2JhbGxvYy5jCisrKyBiL2ZzL2V4ZmF0L2JhbGxvYy5jCkBA
IC0yNiwxMiArMjYsNTUgQEAKIC8qCiAgKiAgQWxsb2NhdGlvbiBCaXRtYXAgTWFuYWdlbWVudCBG
dW5jdGlvbnMKICAqLworc3RhdGljIGJvb2wgZXhmYXRfdGVzdF9iaXRtYXBfcmFuZ2Uoc3RydWN0
IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50IGNsdSwKKwkJdW5zaWduZWQgaW50IGNvdW50
KQoreworCXN0cnVjdCBleGZhdF9zYl9pbmZvICpzYmkgPSBFWEZBVF9TQihzYik7CisJdW5zaWdu
ZWQgaW50IHN0YXJ0ID0gY2x1OworCXVuc2lnbmVkIGludCBlbmQgPSBjbHUgKyBjb3VudDsKKwl1
bnNpZ25lZCBpbnQgZW50X2lkeCwgaSwgYjsKKwl1bnNpZ25lZCBpbnQgYml0X29mZnNldCwgYml0
c190b19jaGVjazsKKwlfX2xlX2xvbmcgKmJpdG1hcF9sZTsKKwl1bnNpZ25lZCBsb25nIG1hc2ss
IHdvcmQ7CisKKwlpZiAoIWlzX3ZhbGlkX2NsdXN0ZXIoc2JpLCBzdGFydCkgfHwgIWlzX3ZhbGlk
X2NsdXN0ZXIoc2JpLCBlbmQgLSAxKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwl3aGlsZSAoc3Rh
cnQgPCBlbmQpIHsKKwkJZW50X2lkeCA9IENMVVNURVJfVE9fQklUTUFQX0VOVChzdGFydCk7CisJ
CWkgPSBCSVRNQVBfT0ZGU0VUX1NFQ1RPUl9JTkRFWChzYiwgZW50X2lkeCk7CisJCWIgPSBCSVRN
QVBfT0ZGU0VUX0JJVF9JTl9TRUNUT1Ioc2IsIGVudF9pZHgpOworCisJCWJpdG1hcF9sZSA9IChf
X2xlX2xvbmcgKilzYmktPnZvbF9hbWFwW2ldLT5iX2RhdGE7CisKKwkJLyogQ2FsY3VsYXRlIGhv
dyBtYW55IGJpdHMgd2UgY2FuIGNoZWNrIGluIHRoZSBjdXJyZW50IHdvcmQgKi8KKwkJYml0X29m
ZnNldCA9IGIgJSBCSVRTX1BFUl9MT05HOworCQliaXRzX3RvX2NoZWNrID0gbWluKGVuZCAtIHN0
YXJ0LAorCQkJCSAgICAodW5zaWduZWQgaW50KShCSVRTX1BFUl9MT05HIC0gYml0X29mZnNldCkp
OworCisJCS8qIENyZWF0ZSBhIGJpdG1hc2sgZm9yIHRoZSByYW5nZSBvZiBiaXRzIHRvIGNoZWNr
ICovCisJCWlmIChiaXRzX3RvX2NoZWNrID49IEJJVFNfUEVSX0xPTkcpCisJCQltYXNrID0gfjBV
TDsKKwkJZWxzZQorCQkJbWFzayA9ICgoMVVMIDw8IGJpdHNfdG9fY2hlY2spIC0gMSkgPDwgYml0
X29mZnNldDsKKwkJd29yZCA9IGxlbF90b19jcHUoYml0bWFwX2xlW2IgLyBCSVRTX1BFUl9MT05H
XSk7CisKKwkJLyogQ2hlY2sgaWYgYWxsIGJpdHMgaW4gdGhlIG1hc2sgYXJlIHNldCAqLworCQlp
ZiAoKHdvcmQgJiBtYXNrKSAhPSBtYXNrKQorCQkJcmV0dXJuIGZhbHNlOworCisJCXN0YXJ0ICs9
IGJpdHNfdG9fY2hlY2s7CisJfQorCisJcmV0dXJuIHRydWU7Cit9CisKIHN0YXRpYyBpbnQgZXhm
YXRfYWxsb2NhdGVfYml0bWFwKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJCXN0cnVjdCBleGZh
dF9kZW50cnkgKmVwKQogewogCXN0cnVjdCBleGZhdF9zYl9pbmZvICpzYmkgPSBFWEZBVF9TQihz
Yik7CiAJbG9uZyBsb25nIG1hcF9zaXplOwotCXVuc2lnbmVkIGludCBpLCBuZWVkX21hcF9zaXpl
OworCXVuc2lnbmVkIGludCBpLCBqLCBuZWVkX21hcF9zaXplOwogCXNlY3Rvcl90IHNlY3RvcjsK
IAogCXNiaS0+bWFwX2NsdSA9IGxlMzJfdG9fY3B1KGVwLT5kZW50cnkuYml0bWFwLnN0YXJ0X2Ns
dSk7CkBAIC01OCwyMCArMTAxLDI1IEBAIHN0YXRpYyBpbnQgZXhmYXRfYWxsb2NhdGVfYml0bWFw
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJc2VjdG9yID0gZXhmYXRfY2x1c3Rlcl90b19zZWN0
b3Ioc2JpLCBzYmktPm1hcF9jbHUpOwogCWZvciAoaSA9IDA7IGkgPCBzYmktPm1hcF9zZWN0b3Jz
OyBpKyspIHsKIAkJc2JpLT52b2xfYW1hcFtpXSA9IHNiX2JyZWFkKHNiLCBzZWN0b3IgKyBpKTsK
LQkJaWYgKCFzYmktPnZvbF9hbWFwW2ldKSB7Ci0JCQkvKiByZWxlYXNlIGFsbCBidWZmZXJzIGFu
ZCBmcmVlIHZvbF9hbWFwICovCi0JCQlpbnQgaiA9IDA7Ci0KLQkJCXdoaWxlIChqIDwgaSkKLQkJ
CQlicmVsc2Uoc2JpLT52b2xfYW1hcFtqKytdKTsKLQotCQkJa3ZmcmVlKHNiaS0+dm9sX2FtYXAp
OwotCQkJc2JpLT52b2xfYW1hcCA9IE5VTEw7Ci0JCQlyZXR1cm4gLUVJTzsKLQkJfQorCQlpZiAo
IXNiaS0+dm9sX2FtYXBbaV0pCisJCQlnb3RvIGVycl9vdXQ7CiAJfQogCisJaWYgKGV4ZmF0X3Rl
c3RfYml0bWFwX3JhbmdlKHNiLCBzYmktPm1hcF9jbHUsCisJCXJvdW5kX3VwKG1hcF9zaXplLCBz
YmktPmNsdXN0ZXJfc2l6ZSkgPj4gc2JpLT5jbHVzdGVyX3NpemVfYml0cykgPT0gZmFsc2UpCisJ
CWdvdG8gZXJyX291dDsKKwogCXJldHVybiAwOworCitlcnJfb3V0OgorCWogPSAwOworCS8qIHJl
bGVhc2UgYWxsIGJ1ZmZlcnMgYW5kIGZyZWUgdm9sX2FtYXAgKi8KKwl3aGlsZSAoaiA8IGkpCisJ
CWJyZWxzZShzYmktPnZvbF9hbWFwW2orK10pOworCisJa3ZmcmVlKHNiaS0+dm9sX2FtYXApOwor
CXNiaS0+dm9sX2FtYXAgPSBOVUxMOworCXJldHVybiAtRUlPOwogfQogCiBpbnQgZXhmYXRfbG9h
ZF9iaXRtYXAoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKLS0gCjIuMjUuMQoK
--00000000000066cb21063d8ec129--

