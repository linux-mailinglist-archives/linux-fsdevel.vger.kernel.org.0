Return-Path: <linux-fsdevel+bounces-10618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156684CD3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAE01F28109
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F37E77F;
	Wed,  7 Feb 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOnogLj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84F7D3E6;
	Wed,  7 Feb 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317451; cv=none; b=EX4ur6SEXwYW34LQuyatjqvkS+sTWuOWwMy1mdEhew+QE0dtz0uZvSTcAPOa6vUgI85VusJhm0hgZsUPcTOFiB/0szB5Y2O8nB2AAL7chibiiaHuzti+NjjBhsiahanxH1ZN+S04REUs8WlCo7jBXSo8ETyFgqdM7X0lDs2RIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317451; c=relaxed/simple;
	bh=LFOYbxeeNT8o8sq3dRMt6cDL/NxyuzdEROywXYtvuqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/juCn/wwJlFPQHmoiKc7pMooxnw9UdZvp+Q9ARXgfnebzVwfrjwHSzMF+6QLjLlf9IJ3qXuYjizy7Yyp3mZ0s7MdpFQtX2NTdiD3xDfc/BbJHERZ9NLsIbdEtET+rB1uWxV0FJ1bKTsY/0YJp2CZtW8v9BwPuF4AIoXd1PTBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOnogLj1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51124db6cf0so927331e87.0;
        Wed, 07 Feb 2024 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707317448; x=1707922248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhws+zI775ph0cG2vRgRfHNtGDcQtZP3QselJU6UXY8=;
        b=AOnogLj1a24S+9DzbRAUjf0S5gXUfRSCGzEMMGIE1V8aJToUdEm/nDskitS8Qp8lo2
         kZ/QqJow8TFIzqrzadJlqn4jxuyZo9nNqHRp0wmjJW0Ne62WzThNIlC7R9Ju8HnIHYDA
         OTgINOZApvFOuIf6GwBj5rz4cppwDZH2X4ChWVlpVgWaJ9MQvq3YcUY+hSesMl4PvZTi
         nFFHNAOgYl7LKNA6d0amb9RdL+yKmQ4YSEkcf9YN1zOTkbgp5uZihA7EUMozqQXtM6+i
         FCCF3bjSrLg1zDp3uGhUuWGsbiLV1ZhhqzmTM7eGcde7T8baqkYqHlIf3jt+tCAZfu/G
         4How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317448; x=1707922248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhws+zI775ph0cG2vRgRfHNtGDcQtZP3QselJU6UXY8=;
        b=BzyeaHWmBFrK3JqT33oOSzTkOuFlMmE2q7kkZG2IIcbMhGyWd5/+zaOFQYxQeoYlHv
         IMFLwsqNm2bQLTn2fjLHoCNGagQFXle8vPWs03TZ3A7Qhgaq0pl5B3dsGlCmPrBe9k7n
         uOVHNAC8l8lYD4YGqH+KA6lMM3OAqYLIy3+PxLfsqiYb4YJEFVSmZKkSaBn5L2gPRXQG
         +UQxsps/VUOcGQAYgv2P3tcjXXKY+BWtHpENeyUGS6AJj6oqZ7HMumGl1TLG/T8Wn8u3
         btSvEhMBbiJaxO6RqvdD/9ujenqV3lJNgXVUkv68cM1SiyvxRAhKK6xltzYom1lKFKpn
         EYKw==
X-Gm-Message-State: AOJu0YzSTAfdDPXJeGrITX7CzxdEaQuCiCBK4tlKKXSb8JT2vqqDqdJt
	PgP4m809N4Tg2yi8HITphmJrPotp88qEzm5JKT6bPaFQ94X0IgmEUEnCSyGUFPmJ/mYU39dxSnP
	8HrdFtdF+TFWGjOd6exN20Q4cYyw=
X-Google-Smtp-Source: AGHT+IG47oo3iQ8nYMD0SxPP1uyr0J5eg22Xte5ep9oouWwGidDsm4CMcTQTGLs3tfKLKgBIxdk8xpxprW1b0FkmMV4=
X-Received: by 2002:a05:6512:20da:b0:511:45db:b2e7 with SMTP id
 u26-20020a05651220da00b0051145dbb2e7mr3627578lfr.0.1707317447265; Wed, 07 Feb
 2024 06:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com> <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
In-Reply-To: <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 7 Feb 2024 08:50:35 -0600
Message-ID: <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000f6a9030610cbd1d9"

--000000000000f6a9030610cbd1d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had attached the wrong file - reattaching the correct patch (ie that
updates the previous version to use PAGE_SIZE instead of 4096)

On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@gmail.com> wr=
ote:
>
> Updated patch - now use PAGE_SIZE instead of hard coding to 4096.
>
> See attached
>
> On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrench@gmail.com>=
 wrote:
> >
> > Attached updated patch which also adds check to make sure max write
> > size is at least 4K
> >
> > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrench@gmail.co=
m> wrote:
> > >
> > > > his netfslib work looks like quite a big refactor. Is there any pla=
ns to land this in 6.8? Or will this be 6.9 / later?
> > >
> > > I don't object to putting them in 6.8 if there was additional review
> > > (it is quite large), but I expect there would be pushback, and am
> > > concerned that David's status update did still show some TODOs for
> > > that patch series.  I do plan to upload his most recent set to
> > > cifs-2.6.git for-next later in the week and target would be for
> > > merging the patch series would be 6.9-rc1 unless major issues were
> > > found in review or testing
> > >
> > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > <matthew.ruffell@canonical.com> wrote:
> > > >
> > > > I have bisected the issue, and found the commit that introduces the=
 problem:
> > > >
> > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > Author: David Howells <dhowells@redhat.com>
> > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > Subject: cifs: Change the I/O paths to use an iterator rather than =
a page list
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > >
> > > > $ git describe --contains d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > v6.3-rc1~136^2~7
> > > >
> > > > David, I also tried your cifs-netfs tree available here:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.g=
it/log/?h=3Dcifs-netfs
> > > >
> > > > This tree solves the issue. Specifically:
> > > >
> > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > Author: David Howells <dhowells@redhat.com>
> > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > Subject: cifs: Cut over to using netfslib
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linu=
x-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54db119fd0=
d8
> > > >
> > > > This netfslib work looks like quite a big refactor. Is there any pl=
ans to land this in 6.8? Or will this be 6.9 / later?
> > > >
> > > > Do you have any suggestions on how to fix this with a smaller delta=
 in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > >
> > > > Thanks,
> > > > Matthew
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--000000000000f6a9030610cbd1d9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Disposition: attachment; 
	filename="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsbwnr330>
X-Attachment-Id: f_lsbwnr330

RnJvbSBmMmNhODYyZGViZDhiOTg3NWI1NDQ4NTUzYmUwZjIxNzhmYzQyMzFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgNiBGZWIgMjAyNCAxNjozNDoyMiAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMDEv
MjZdIHNtYjogRml4IHJlZ3Jlc3Npb24gaW4gd3JpdGVzIHdoZW4gbm9uLXN0YW5kYXJkIG1heGlt
dW0KIHdyaXRlIHNpemUgbmVnb3RpYXRlZAoKVGhlIGNvbnZlcnNpb24gdG8gbmV0ZnMgaW4gdGhl
IDYuMyBrZXJuZWwgY2F1c2VkIGEgcmVncmVzc2lvbiB3aGVuCm1heGltdW0gd3JpdGUgc2l6ZSBp
cyBzZXQgYnkgdGhlIHNlcnZlciB0byBhbiB1bmV4cGVjdGVkIHZhbHVlIHdoaWNoIGlzCm5vdCBh
IG11bHRpcGxlIG9mIDQwOTYgKHNpbWlsYXJseSBpZiB0aGUgdXNlciBvdmVycmlkZXMgdGhlIG1h
eGltdW0Kd3JpdGUgc2l6ZSBieSBzZXR0aW5nIG1vdW50IHBhcm0gIndzaXplIiwgYnV0IHNldHMg
aXQgdG8gYSB2YWx1ZSB0aGF0CmlzIG5vdCBhIG11bHRpcGxlIG9mIDQwOTYpLiAgV2hlbiBuZWdv
dGlhdGVkIHdyaXRlIHNpemUgaXMgbm90IGEKbXVsdGlwbGUgb2YgNDA5NiB0aGUgbmV0ZnMgY29k
ZSBjYW4gc2tpcCB0aGUgZW5kIG9mIHRoZSBmaW5hbApwYWdlIHdoZW4gZG9pbmcgbGFyZ2Ugc2Vx
dWVudGlhbCB3cml0ZXMsIGNhdXNpbmcgZGF0YSBjb3JydXB0aW9uLgoKVGhpcyBzZWN0aW9uIG9m
IGNvZGUgaXMgYmVpbmcgcmV3cml0dGVuL3JlbW92ZWQgZHVlIHRvIGEgbGFyZ2UKbmV0ZnMgY2hh
bmdlLCBidXQgdW50aWwgdGhhdCBwb2ludCAoaWUgZm9yIHRoZSA2LjMga2VybmVsIHVudGlsIG5v
dykKd2UgY2FuIG5vdCBzdXBwb3J0IG5vbi1zdGFuZGFyZCBtYXhpbXVtIHdyaXRlIHNpemVzLgoK
QWRkIGEgd2FybmluZyBpZiBhIHVzZXIgc3BlY2lmaWVzIGEgd3NpemUgb24gbW91bnQgdGhhdCBp
cyBub3QKYSBtdWx0aXBsZSBvZiA0MDk2LCBhbmQgYWxzbyBhZGQgYSBjaGFuZ2Ugd2hlcmUgd2Ug
cm91bmQgZG93biB0aGUKbWF4aW11bSB3cml0ZSBzaXplIGlmIHRoZSBzZXJ2ZXIgbmVnb3RpYXRl
cyBhIHZhbHVlIHRoYXQgaXMgbm90CmEgbXVsdGlwbGUgb2YgNDA5NiAod2UgYWxzbyBoYXZlIHRv
IGNoZWNrIHRvIG1ha2Ugc3VyZSB0aGF0CndlIGRvIG5vdCByb3VuZCBpdCBkb3duIHRvIHplcm8p
LgoKUmVwb3J0ZWQtYnk6IFIuIERpZXoiIDxyZGllei0yMDA2QHJkMTAuZGU+CkZpeGVzOiBkMDgw
ODlmNjQ5YTAgKCJjaWZzOiBDaGFuZ2UgdGhlIEkvTyBwYXRocyB0byB1c2UgYW4gaXRlcmF0b3Ig
cmF0aGVyIHRoYW4gYSBwYWdlIGxpc3QiKQpTdWdnZXN0ZWQtYnk6IFJvbm5pZSBTYWhsYmVyZyA8
cm9ubmllc2FobGJlcmdAZ21haWwuY29tPgpBY2tlZC1ieTogUm9ubmllIFNhaGxiZXJnIDxyb25u
aWVzYWhsYmVyZ0BnbWFpbC5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjYuMysK
Q2M6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0
ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9zbWIvY2xpZW50L2Nv
bm5lY3QuYyAgICB8IDEzICsrKysrKysrKysrLS0KIGZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5j
IHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2Nvbm5lY3QuYyBiL2ZzL3NtYi9jbGllbnQv
Y29ubmVjdC5jCmluZGV4IGJmZDU2OGY4OTcxMC4uNDZiM2FlZWJmYmYyIDEwMDY0NAotLS0gYS9m
cy9zbWIvY2xpZW50L2Nvbm5lY3QuYworKysgYi9mcy9zbWIvY2xpZW50L2Nvbm5lY3QuYwpAQCAt
MzQzOCw4ICszNDM4LDE3IEBAIGludCBjaWZzX21vdW50X2dldF90Y29uKHN0cnVjdCBjaWZzX21v
dW50X2N0eCAqbW50X2N0eCkKIAkgKiB0aGUgdXNlciBvbiBtb3VudAogCSAqLwogCWlmICgoY2lm
c19zYi0+Y3R4LT53c2l6ZSA9PSAwKSB8fAotCSAgICAoY2lmc19zYi0+Y3R4LT53c2l6ZSA+IHNl
cnZlci0+b3BzLT5uZWdvdGlhdGVfd3NpemUodGNvbiwgY3R4KSkpCi0JCWNpZnNfc2ItPmN0eC0+
d3NpemUgPSBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3dzaXplKHRjb24sIGN0eCk7CisJICAgIChj
aWZzX3NiLT5jdHgtPndzaXplID4gc2VydmVyLT5vcHMtPm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBj
dHgpKSkgeworCQljaWZzX3NiLT5jdHgtPndzaXplID0gcm91bmRfZG93bihzZXJ2ZXItPm9wcy0+
bmVnb3RpYXRlX3dzaXplKHRjb24sIGN0eCksIFBBR0VfU0laRSk7CisJCS8qCisJCSAqIGluIHRo
ZSB2ZXJ5IHVubGlrZWx5IGV2ZW50IHRoYXQgdGhlIHNlcnZlciBzZW50IGEgbWF4IHdyaXRlIHNp
emUgdW5kZXIgUEFHRV9TSVpFLAorCQkgKiAod2hpY2ggd291bGQgZ2V0IHJvdW5kZWQgZG93biB0
byAwKSB0aGVuIHJlc2V0IHdzaXplIHRvIGFic29sdXRlIG1pbmltdW0gZWcgNDA5NgorCQkgKi8K
KwkJaWYgKGNpZnNfc2ItPmN0eC0+d3NpemUgPT0gMCkgeworCQkJY2lmc19zYi0+Y3R4LT53c2l6
ZSA9IFBBR0VfU0laRTsKKwkJCWNpZnNfZGJnKFZGUywgIndzaXplIHRvbyBzbWFsbCwgcmVzZXQg
dG8gbWluaW11bSBpZSBQQUdFX1NJWkUsIHVzdWFsbHkgNDA5NlxuIik7CisJCX0KKwl9CiAJaWYg
KChjaWZzX3NiLT5jdHgtPnJzaXplID09IDApIHx8CiAJICAgIChjaWZzX3NiLT5jdHgtPnJzaXpl
ID4gc2VydmVyLT5vcHMtPm5lZ290aWF0ZV9yc2l6ZSh0Y29uLCBjdHgpKSkKIAkJY2lmc19zYi0+
Y3R4LT5yc2l6ZSA9IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfcnNpemUodGNvbiwgY3R4KTsKZGlm
ZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jIGIvZnMvc21iL2NsaWVudC9mc19j
b250ZXh0LmMKaW5kZXggNTJjYmVmMmVlYjI4Li42MDBhNzcwNTJjM2IgMTAwNjQ0Ci0tLSBhL2Zz
L3NtYi9jbGllbnQvZnNfY29udGV4dC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5j
CkBAIC0xMTExLDYgKzExMTEsOCBAQCBzdGF0aWMgaW50IHNtYjNfZnNfY29udGV4dF9wYXJzZV9w
YXJhbShzdHJ1Y3QgZnNfY29udGV4dCAqZmMsCiAJY2FzZSBPcHRfd3NpemU6CiAJCWN0eC0+d3Np
emUgPSByZXN1bHQudWludF8zMjsKIAkJY3R4LT5nb3Rfd3NpemUgPSB0cnVlOworCQlpZiAocm91
bmRfdXAoY3R4LT53c2l6ZSwgUEFHRV9TSVpFKSAhPSBjdHgtPndzaXplKQorCQkJY2lmc19kYmco
VkZTLCAid3NpemUgc2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgNDA5NiAoUEFHRV9TSVpFKVxuIik7
CiAJCWJyZWFrOwogCWNhc2UgT3B0X2FjcmVnbWF4OgogCQljdHgtPmFjcmVnbWF4ID0gSFogKiBy
ZXN1bHQudWludF8zMjsKLS0gCjIuNDAuMQoK
--000000000000f6a9030610cbd1d9--

