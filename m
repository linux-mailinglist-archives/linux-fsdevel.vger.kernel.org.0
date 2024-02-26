Return-Path: <linux-fsdevel+bounces-12892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520798683F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C3F1C244BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E8F13540C;
	Mon, 26 Feb 2024 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VeqtFYOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C041E897
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987638; cv=none; b=OYuxrD4zd5hCougippDyQUwHCw1Lnm/NnGL7vaVNvAS/W0xMGBSal5rT5YQoI2V/nRnz2u0H3lOxZ4tS572JmQzZp/xrPcSLt3WqBy9kqH3u3T9vFBvq5TNY1FX3AFAjnGE3bWWkVRbg7Bz+U2C2jbT92hwGteAdH6sgZJTt3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987638; c=relaxed/simple;
	bh=VujxSr20NR23wdFophX5huOgcnWtBRJ2JAGgMtlQ+VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFdZSYQYPWCZPYiopkqdW7A031bbQcOLuaXw7XZlaUrg9Re8e9W6oheEsdhNN4E2ZoL57GLSf/9pot5sj/XmOueGCKZr60dCb6WCyMx1y655MpIIu4lDipi10i9az1QFCzQKMeuXM4qV7JcXSyIiRegROnGxeetmkVok7L4LGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VeqtFYOv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a437a2a46b1so128654566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708987634; x=1709592434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mapi+yKgf2BbFbObl206XXPY0pTKrfs2l+OnjEP7vGQ=;
        b=VeqtFYOvwbanaBs8qkQbiXoDxupJ9ccGSrrl0C1ygg63PN5OUZGrM9MeR9GQzfsz+Y
         p0jmGHqsYok/baq/XRt1tp0cSVvHfiHNKS4EUK40qcsVKnBBdn+kwQ+hJ9E3gEiCLydz
         42doa6Hekz2/AkpsoWnNM4NuJKUDfwafgOcHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987634; x=1709592434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mapi+yKgf2BbFbObl206XXPY0pTKrfs2l+OnjEP7vGQ=;
        b=eTWQseysP7p/x7hQGkeShOurd0QTdN4X+gOLh662mscAFzgzaDF++iTXWkqBPP291U
         YAcBmtfGqLmQ/tkX9O0flFATFVzVTdaxEtboCGh1AYbN5M2ticz6K6B0TLvhhFgJ3+Oy
         FOv560ahxfx51Ape3Zz26PEA/FxLezoTYq/6SOkS6tuB1NYNhgi+eCtAtFacTiZDnGOR
         5d2Ob8nEwQPj5pOQliowUI5Ud1ScqCo5drv+25nLHHaoFyyiN+6RXhDlQYgmMNF56/PD
         lhmCgiEQjGp3nDmOQ+Oh2PSO1qn3V8fn2lNV0kmm0yaCEt5MVt8zwkPzyhyaV43AITR2
         CDIg==
X-Forwarded-Encrypted: i=1; AJvYcCWNlIGEBDJbSzRXZV9ONFQXf6K42vQKm7IWfnByrKhegyc0yGQL9oiPtP8FiieS2rFgaNRl9sZHNlRNmlRMyeopbz8NvbvMfQwfGvjz/Q==
X-Gm-Message-State: AOJu0Yzlq5rA90SqIV429UX0K+Lc2sQMqIVBWp2BFKrADP/EeZJqbhj8
	xgCWTijXGZ1ZZCdRuMJ9NftyKt6bcYqD64px90DGwiazE37686yxA0xLynk4HNMhA6TuegAALsE
	JE/wGIw==
X-Google-Smtp-Source: AGHT+IH4DrShxtpZOAToVRNi0RGFn0FjhFNOlo3wV9ivgn3A6zR/AuzcELIAPWoPHugfpQ0d71VQTg==
X-Received: by 2002:a17:906:46da:b0:a3e:5ef3:c65d with SMTP id k26-20020a17090646da00b00a3e5ef3c65dmr5322865ejs.75.1708987634614;
        Mon, 26 Feb 2024 14:47:14 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id lu4-20020a170906fac400b00a3ecdd0ba23sm166964ejb.52.2024.02.26.14.47.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:47:13 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a437a2a46b1so128651066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 14:47:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVK/uvOQu1aH3VBlQjpjb9hRFjbo9e5AVy//CGyh9f17ZFQb2uo3vvWMr7z2wFNmZ45iUPZ5pJldFhOoVDhXcnZ2K9EeeZSVjGjsaDP8g==
X-Received: by 2002:a17:906:2f14:b0:a3f:ac2f:893a with SMTP id
 v20-20020a1709062f1400b00a3fac2f893amr5153910eji.73.1708987632904; Mon, 26
 Feb 2024 14:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org> <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
In-Reply-To: <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2024 14:46:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
Message-ID: <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Al Viro <viro@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: multipart/mixed; boundary="000000000000c91180061250b052"

--000000000000c91180061250b052
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 09:17, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Are tiny reads (handwaving: 100 bytes or less) really worth optimizing
> for to that degree?

So this ended up just bothering me, and dammit, we already *have* that
stack buffer, except it's that 'folio batch' buffer.

Which is already 128 bytes of stack space (on 64-bit).

So, just hypothetically, let's say that *before* we start using that
folio batch buffer for folios, we use it as a dummy buffer for small
reads.

So we'd make that 'fbatch' thing be a union with a temporary byte buffer.

That hypothetical patch might look something like this TOTALLY UNTESTED CRAP.

Anybody interested in seeing if something like this might actually
work? I do want to emphasize the "something like this".

This pile of random thoughts ends up compiling for me, and I _tried_
to think of all the cases, but there might be obvious thinkos, and
there might be things I just didn't think about at all.

I really haven't tested this AT ALL. I'm much too scared. But I don't
actually hate how the code looks nearly as much as I *thought* I'd
hate it.

              Linus

--000000000000c91180061250b052
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lt3j26330>
X-Attachment-Id: f_lt3j26330

IG1tL2ZpbGVtYXAuYyB8IDExNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwNyBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9maWxlbWFwLmMgYi9tbS9maWxlbWFw
LmMKaW5kZXggNzUwZTc3OWMyM2RiLi41ZjY2ZmQxYmM4MmQgMTAwNjQ0Ci0tLSBhL21tL2ZpbGVt
YXAuYworKysgYi9tbS9maWxlbWFwLmMKQEAgLTI1NDMsNiArMjU0Myw4NSBAQCBzdGF0aWMgaW5s
aW5lIGJvb2wgcG9zX3NhbWVfZm9saW8obG9mZl90IHBvczEsIGxvZmZfdCBwb3MyLCBzdHJ1Y3Qg
Zm9saW8gKmZvbGlvKQogCXJldHVybiAocG9zMSA+PiBzaGlmdCA9PSBwb3MyID4+IHNoaWZ0KTsK
IH0KIAorLyoKKyAqIEkgY2FuJ3QgYmUgYm90aGVyZWQgdG8gY2FyZSBhYm91dCBISUdITUVNIGZv
ciB0aGUgZmFzdCByZWFkIGNhc2UKKyAqLworI2lmZGVmIENPTkZJR19ISUdITUVNCisjZGVmaW5l
IGZpbGVtYXBfZmFzdF9yZWFkKG1hcHBpbmcsIHBvcywgYnVmZmVyLCBzaXplKSAwCisjZWxzZQor
CisvKgorICogQ2FsbGVkIHVuZGVyIFJDVSB3aXRoIHNpemUgbGltaXRlZCB0byB0aGUgZmlsZSBz
aXplIGFuZCBvbmUKKyAqLworc3RhdGljIHVuc2lnbmVkIGxvbmcgZmlsZW1hcF9mb2xpb19jb3B5
X3JjdShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgbG9mZl90IHBvcywgY2hhciAqYnVm
ZmVyLCBzaXplX3Qgc2l6ZSkKK3sKKwlYQV9TVEFURSh4YXMsICZtYXBwaW5nLT5pX3BhZ2VzLCBw
b3MgPj4gUEFHRV9TSElGVCk7CisJc3RydWN0IGZvbGlvICpmb2xpbzsKKwlzaXplX3Qgb2Zmc2V0
OworCisJeGFzX3Jlc2V0KCZ4YXMpOworCWZvbGlvID0geGFzX2xvYWQoJnhhcyk7CisJaWYgKHhh
c19yZXRyeSgmeGFzLCBmb2xpbykpCisJCXJldHVybiAwOworCisJaWYgKCFmb2xpbyB8fCB4YV9p
c192YWx1ZShmb2xpbykpCisJCXJldHVybiAwOworCisJaWYgKCFmb2xpb190ZXN0X3VwdG9kYXRl
KGZvbGlvKSkKKwkJcmV0dXJuIDA7CisKKwkvKiBObyBmYXN0LWNhc2UgaWYgd2UgYXJlIHN1cHBv
c2VkIHRvIHN0YXJ0IHJlYWRhaGVhZCAqLworCWlmIChmb2xpb190ZXN0X3JlYWRhaGVhZChmb2xp
bykpCisJCXJldHVybiAwOworCS8qIC4uIG9yIG1hcmsgaXQgYWNjZXNzZWQgKi8KKwlpZiAoIWZv
bGlvX3Rlc3RfcmVmZXJlbmNlZChmb2xpbykpCisJCXJldHVybiAwOworCisJLyogRG8gdGhlIGRh
dGEgY29weSAqLworCW9mZnNldCA9IHBvcyAmIChmb2xpb19zaXplKGZvbGlvKSAtIDEpOworCW1l
bWNweShidWZmZXIsIGZvbGlvX2FkZHJlc3MoZm9saW8pICsgb2Zmc2V0LCBzaXplKTsKKworCS8q
IFdlIHNob3VsZCBwcm9iYWJseSBkbyBzb21lIHNpbGx5IG1lbW9yeSBiYXJyaWVyIGhlcmUgKi8K
KwlpZiAodW5saWtlbHkoZm9saW8gIT0geGFzX3JlbG9hZCgmeGFzKSkpCisJCXJldHVybiAwOwor
CisJcmV0dXJuIHNpemU7Cit9CisKKy8qCisgKiBJZmYgd2UgY2FuIGNvbXBsZXRlIHRoZSByZWFk
IGNvbXBsZXRlbHkgaW4gb25lIGF0b21pYyBnbyB1bmRlciBSQ1UsCisgKiBkbyBzbyBoZXJlLiBP
dGhlcndpc2UgcmV0dXJuIDAgKG5vIHBhcnRpYWwgcmVhZHMsIHBsZWFzZSAtIHRoaXMgaXMKKyAq
IHB1cmVseSBmb3IgdGhlIHRyaXZpYWwgZmFzdCBjYXNlKS4KKyAqLworc3RhdGljIHVuc2lnbmVk
IGxvbmcgZmlsZW1hcF9mYXN0X3JlYWQoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsIGxv
ZmZfdCBwb3MsIGNoYXIgKmJ1ZmZlciwgc2l6ZV90IHNpemUpCit7CisJc3RydWN0IGlub2RlICpp
bm9kZTsKKwlsb2ZmX3QgZmlsZV9zaXplOworCXVuc2lnbmVkIGxvbmcgcGdvZmY7CisKKwkvKiBE
b24ndCBldmVuIHRyeSBmb3IgcGFnZS1jcm9zc2VycyAqLworCXBnb2ZmID0gcG9zICYgflBBR0Vf
TUFTSzsKKwlpZiAocGdvZmYgKyBzaXplID4gUEFHRV9TSVpFKQorCQlyZXR1cm4gMDsKKworCS8q
IExpbWl0IGl0IHRvIHRoZSBmaWxlIHNpemUgKi8KKwlpbm9kZSA9IG1hcHBpbmctPmhvc3Q7CisJ
ZmlsZV9zaXplID0gaV9zaXplX3JlYWQoaW5vZGUpOworCWlmICh1bmxpa2VseShwb3MgPj0gZmls
ZV9zaXplKSkKKwkJcmV0dXJuIDA7CisJZmlsZV9zaXplIC09IHBvczsKKwlpZiAoZmlsZV9zaXpl
IDwgc2l6ZSkKKwkJc2l6ZSA9IGZpbGVfc2l6ZTsKKworCS8qIExldCdzIHNlZSBpZiB3ZSBjYW4g
anVzdCBkbyB0aGUgcmVhZCB1bmRlciBSQ1UgKi8KKwlyY3VfcmVhZF9sb2NrKCk7CisJc2l6ZSA9
IGZpbGVtYXBfZm9saW9fY29weV9yY3UobWFwcGluZywgcG9zLCBidWZmZXIsIHNpemUpOworCXJj
dV9yZWFkX3VubG9jaygpOworCisJcmV0dXJuIHNpemU7Cit9CisjZW5kaWYgLyogIUhJR0hNRU0g
Ki8KKwogLyoqCiAgKiBmaWxlbWFwX3JlYWQgLSBSZWFkIGRhdGEgZnJvbSB0aGUgcGFnZSBjYWNo
ZS4KICAqIEBpb2NiOiBUaGUgaW9jYiB0byByZWFkLgpAQCAtMjU2Myw3ICsyNjQyLDEwIEBAIHNz
aXplX3QgZmlsZW1hcF9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpp
dGVyLAogCXN0cnVjdCBmaWxlX3JhX3N0YXRlICpyYSA9ICZmaWxwLT5mX3JhOwogCXN0cnVjdCBh
ZGRyZXNzX3NwYWNlICptYXBwaW5nID0gZmlscC0+Zl9tYXBwaW5nOwogCXN0cnVjdCBpbm9kZSAq
aW5vZGUgPSBtYXBwaW5nLT5ob3N0OwotCXN0cnVjdCBmb2xpb19iYXRjaCBmYmF0Y2g7CisJdW5p
b24geworCQlzdHJ1Y3QgZm9saW9fYmF0Y2ggZmJhdGNoOworCQlfX0RFQ0xBUkVfRkxFWF9BUlJB
WShjaGFyLCBidWZmZXIpOworCX0gYXJlYTsKIAlpbnQgaSwgZXJyb3IgPSAwOwogCWJvb2wgd3Jp
dGFibHlfbWFwcGVkOwogCWxvZmZfdCBpc2l6ZSwgZW5kX29mZnNldDsKQEAgLTI1NzUsNyArMjY1
NywyMiBAQCBzc2l6ZV90IGZpbGVtYXBfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBp
b3ZfaXRlciAqaXRlciwKIAkJcmV0dXJuIDA7CiAKIAlpb3ZfaXRlcl90cnVuY2F0ZShpdGVyLCBp
bm9kZS0+aV9zYi0+c19tYXhieXRlcyk7Ci0JZm9saW9fYmF0Y2hfaW5pdCgmZmJhdGNoKTsKKwor
CWlmIChpb3ZfaXRlcl9jb3VudChpdGVyKSA8IHNpemVvZihhcmVhKSkgeworCQl1bnNpZ25lZCBs
b25nIGNvdW50ID0gaW92X2l0ZXJfY291bnQoaXRlcik7CisKKwkJY291bnQgPSBmaWxlbWFwX2Zh
c3RfcmVhZChtYXBwaW5nLCBpb2NiLT5raV9wb3MsIGFyZWEuYnVmZmVyLCBjb3VudCk7CisJCWlm
IChjb3VudCkgeworCQkJc2l6ZV90IGNvcGllZCA9IGNvcHlfdG9faXRlcihhcmVhLmJ1ZmZlciwg
Y291bnQsIGl0ZXIpOworCQkJaWYgKHVubGlrZWx5KCFjb3BpZWQpKQorCQkJCXJldHVybiBhbHJl
YWR5X3JlYWQgPyBhbHJlYWR5X3JlYWQgOiAtRUZBVUxUOworCQkJcmEtPnByZXZfcG9zID0gaW9j
Yi0+a2lfcG9zICs9IGNvcGllZDsKKwkJCWZpbGVfYWNjZXNzZWQoZmlscCk7CisJCQlyZXR1cm4g
Y29waWVkICsgYWxyZWFkeV9yZWFkOworCQl9CisJfQorCisJZm9saW9fYmF0Y2hfaW5pdCgmYXJl
YS5mYmF0Y2gpOwogCiAJZG8gewogCQljb25kX3Jlc2NoZWQoKTsKQEAgLTI1OTEsNyArMjY4OCw3
IEBAIHNzaXplX3QgZmlsZW1hcF9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9p
dGVyICppdGVyLAogCQlpZiAodW5saWtlbHkoaW9jYi0+a2lfcG9zID49IGlfc2l6ZV9yZWFkKGlu
b2RlKSkpCiAJCQlicmVhazsKIAotCQllcnJvciA9IGZpbGVtYXBfZ2V0X3BhZ2VzKGlvY2IsIGl0
ZXItPmNvdW50LCAmZmJhdGNoLCBmYWxzZSk7CisJCWVycm9yID0gZmlsZW1hcF9nZXRfcGFnZXMo
aW9jYiwgaXRlci0+Y291bnQsICZhcmVhLmZiYXRjaCwgZmFsc2UpOwogCQlpZiAoZXJyb3IgPCAw
KQogCQkJYnJlYWs7CiAKQEAgLTI2MjgsMTEgKzI3MjUsMTEgQEAgc3NpemVfdCBmaWxlbWFwX3Jl
YWQoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCiAJCSAqIG1hcmsg
aXQgYXMgYWNjZXNzZWQgdGhlIGZpcnN0IHRpbWUuCiAJCSAqLwogCQlpZiAoIXBvc19zYW1lX2Zv
bGlvKGlvY2ItPmtpX3BvcywgbGFzdF9wb3MgLSAxLAotCQkJCSAgICBmYmF0Y2guZm9saW9zWzBd
KSkKLQkJCWZvbGlvX21hcmtfYWNjZXNzZWQoZmJhdGNoLmZvbGlvc1swXSk7CisJCQkJICAgIGFy
ZWEuZmJhdGNoLmZvbGlvc1swXSkpCisJCQlmb2xpb19tYXJrX2FjY2Vzc2VkKGFyZWEuZmJhdGNo
LmZvbGlvc1swXSk7CiAKLQkJZm9yIChpID0gMDsgaSA8IGZvbGlvX2JhdGNoX2NvdW50KCZmYmF0
Y2gpOyBpKyspIHsKLQkJCXN0cnVjdCBmb2xpbyAqZm9saW8gPSBmYmF0Y2guZm9saW9zW2ldOwor
CQlmb3IgKGkgPSAwOyBpIDwgZm9saW9fYmF0Y2hfY291bnQoJmFyZWEuZmJhdGNoKTsgaSsrKSB7
CisJCQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gYXJlYS5mYmF0Y2guZm9saW9zW2ldOwogCQkJc2l6
ZV90IGZzaXplID0gZm9saW9fc2l6ZShmb2xpbyk7CiAJCQlzaXplX3Qgb2Zmc2V0ID0gaW9jYi0+
a2lfcG9zICYgKGZzaXplIC0gMSk7CiAJCQlzaXplX3QgYnl0ZXMgPSBtaW5fdChsb2ZmX3QsIGVu
ZF9vZmZzZXQgLSBpb2NiLT5raV9wb3MsCkBAIC0yNjYzLDkgKzI3NjAsOSBAQCBzc2l6ZV90IGZp
bGVtYXBfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKIAkJ
CX0KIAkJfQogcHV0X2ZvbGlvczoKLQkJZm9yIChpID0gMDsgaSA8IGZvbGlvX2JhdGNoX2NvdW50
KCZmYmF0Y2gpOyBpKyspCi0JCQlmb2xpb19wdXQoZmJhdGNoLmZvbGlvc1tpXSk7Ci0JCWZvbGlv
X2JhdGNoX2luaXQoJmZiYXRjaCk7CisJCWZvciAoaSA9IDA7IGkgPCBmb2xpb19iYXRjaF9jb3Vu
dCgmYXJlYS5mYmF0Y2gpOyBpKyspCisJCQlmb2xpb19wdXQoYXJlYS5mYmF0Y2guZm9saW9zW2ld
KTsKKwkJZm9saW9fYmF0Y2hfaW5pdCgmYXJlYS5mYmF0Y2gpOwogCX0gd2hpbGUgKGlvdl9pdGVy
X2NvdW50KGl0ZXIpICYmIGlvY2ItPmtpX3BvcyA8IGlzaXplICYmICFlcnJvcik7CiAKIAlmaWxl
X2FjY2Vzc2VkKGZpbHApOwo=
--000000000000c91180061250b052--

