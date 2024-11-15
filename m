Return-Path: <linux-fsdevel+bounces-34977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA959CF528
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C01B1F2323D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182C1E0E0C;
	Fri, 15 Nov 2024 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JVgNv+Vc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AA1DD0C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699814; cv=none; b=P8AP3elKD83Nc/Chg+F6m3nCzDCbxzkGVaCX5PtjjGqx3iDonaFPXPncwws+cQNusQQo59w7f4gsKLh0HPNf/CNiObw713tSwgCRgWXUSyMkg/XiKoJc0n4AHdXwlnejzkYhJPu1ew6VxUtYY4OlYTx1HPYSsMfJ6A13GnZnXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699814; c=relaxed/simple;
	bh=SLnDbfpMMNce5rifl/W6C6u1TB8YVSCvtovczmykQNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjDldJ5PG7kDvxB/NJ5dMvkNanKoHiKU+iPind7R/Iw2dTp0bQ+iQ3hPlf+4JcmHM9GDC7QCTKoacNDL1vjUrmp1YHAAeS59oCiJiaYWM2K72ti0GdIOwqoJ2zHC3ZbbPWiAGdCx+UILqgsuUsR+pNnu1PuSJ232ezRDKLi16gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JVgNv+Vc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53b34ed38easo2279038e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731699810; x=1732304610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8q/u2kGW54Efg3y1/zjzLgFIuit0NCZFXIw/u2X2600=;
        b=JVgNv+VcPWpsmL/203WeCMzg0haDxsPlTrvHh/QJMd67/Od1UDyL+KZKS/xGmUhmx4
         Wo0JQB9UCPgic5Uz9UcMRHkUx483S3XN8rGki+7VAAmHbDas/wTrO/ebTZIvHxLT93cy
         LAM8I46c1NtNDvNfua6kuia8y4Al3I6mzBSx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699810; x=1732304610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q/u2kGW54Efg3y1/zjzLgFIuit0NCZFXIw/u2X2600=;
        b=cCCjZQ3pEqGQBstVrHdNlxWnDxaDueUswDseeu09Io/91p7ZHAwwQ4CJkkIhXAhEa/
         WZiWGAmbDh62mtKicGQONrG0jCVSwQlVyxakjDA9OLHsxGP2UQrFXu7Wn3LpomNSQCid
         n3bOwatf6DQU2v2B1T5TgoBmpr6e11n9LIJu57TaKqlJ3B5BF4oAs77JUMLN+DLx/yRs
         +WgUkonwDOfFzimKE3oeI1/T9KVWse26/W3j4kxlRDf/l//T2ChiaRCc23e5IPk5gkxe
         V/InOryJf+NLbIcyU6rK5m3JDCXfrB2Oe3uxwaDR5C8SAE8hZfhbEIIDq4IRvrDFWv+g
         LTbg==
X-Forwarded-Encrypted: i=1; AJvYcCWuQW89YhJRbnJJbeY0yl6bJhWKyAkZgzvwevBQwrQoO7CGb+0Gycd7cMjzqU9EDnxZlwqLZHeumwdhWV1+@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSZGweSqGRRJxuPk112NB1pyNLngtvHXVQwjsjw6Dcd1J7VoT
	JiOS9Z3Qx+AyaqPcvKpaMHnRFJiFlTB5bvcKxCxrehzcuBAUJiiLalFo2F9jAnxPKegWDPoHscu
	MxJc=
X-Google-Smtp-Source: AGHT+IG0JJksq967c8RBSmEP/z4xMsCDTtxRKsgH4WWczNsUYm9rFahYWQPDC+SRQ5P8nCvyxNhdAg==
X-Received: by 2002:a05:6512:2252:b0:53d:a0f7:26e6 with SMTP id 2adb3069b0e04-53dab2a0753mr1846253e87.15.1731699809850;
        Fri, 15 Nov 2024 11:43:29 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79bb59cesm1838950a12.50.2024.11.15.11.43.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:43:27 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so371687566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 11:43:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzmGGy5iLFlPhvSlFSUaiEA9YkwslbICcICudiRdq7EX1LV5qmAQDRVY/CU2D03GF2IG9ZvEG+oYhaKQx4@vger.kernel.org
X-Received: by 2002:a17:906:f589:b0:a9a:2a56:91f with SMTP id
 a640c23a62f3a-aa4833f685cmr343442266b.2.1731699807210; Fri, 15 Nov 2024
 11:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org> <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com> <ZkNQiWpTOZDMp3kS@bombadil.infradead.org>
In-Reply-To: <ZkNQiWpTOZDMp3kS@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Nov 2024 11:43:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfgdhfe=Dw_Tg=LgSd+FXzsikg3-+cH5uP_LoZGJoU0Q@mail.gmail.com>
Message-ID: <CAHk-=wgfgdhfe=Dw_Tg=LgSd+FXzsikg3-+cH5uP_LoZGJoU0Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Al Viro <viro@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: multipart/mixed; boundary="000000000000de0ba40626f8c7b2"

--000000000000de0ba40626f8c7b2
Content-Type: text/plain; charset="UTF-8"

I'm coming back to this ancient discussion, because I've actually been
running that odd small-reads patch on my machine since February,
because it's been in my random pile of "local test patches".

I had to rebase the patch because it conflicted with a recent fix, and
as part of rebasing it I looked at it again.

And I did find that the "do small reads entirely under RCU" didn't
test for one condition that filemap_get_read_batch() checked for: the
xa_is_sibling() check.

So...

On Tue, 14 May 2024 at 04:52, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Feb 26, 2024 at 02:46:56PM -0800, Linus Torvalds wrote:
> > I really haven't tested this AT ALL. I'm much too scared. But I don't
> > actually hate how the code looks nearly as much as I *thought* I'd
> > hate it.
>
> Thanks for this, obviously those interested in this will have to test
> this and fix the below issues. I've tested for regressions just against
> xfs on 4k reflink profile and detected only two failures, generic/095
> fails with a failure rate of about 1/2 or so:
>
>   * generic/095
>   * generic/741

Would you mind seeing if that ancient patch with the xa_is_sibling()
check added, and rebased to be on top of current -git maybe works for
you now?

I still haven't "really" tested this in any real way, except for
running all my normal desktop loads on it. Which isn't really saying
much. I compile kernels, and read email. That's pretty much all I do.
So no fstests or anything like that.

But it *has* worked in that capacity for 8+ months now. So it's not
entirely broken, but the fact that it failed fstests for you clearly
means that *something* was subtly but horribly broken in the original
version.

               Linus

--000000000000de0ba40626f8c7b2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m3j5bthr0>
X-Attachment-Id: f_m3j5bthr0

RnJvbSAyZGFmZDE1Y2ViMDBhNDFiOWY2YjM3YzFkODQ2NjIwMzliYTJkMTQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgMjYgRmViIDIwMjQgMTU6MTg6NDQgLTA4MDAKU3ViamVjdDog
W1BBVENIXSBtbS9maWxlbWFwOiBkbyBzbWFsbCByZWFkcyBpbiBSQ1UtbW9kZSByZWFkIHdpdGhv
dXQgcmVmY291bnRzCgpIYWNrZXR5IGhhY2sgaGFjayBjb25jZXB0IGZyb20gcmVwb3J0IGJ5IFdp
bGx5LgoKTW9tbXksIEknbSBzY2FyZWQuCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvWmR1dG8zMExVRXFJSGc0aEBjYXNwZXIuaW5mcmFkZWFkLm9yZy8KTm90LXlldC1zaWduZWQt
b2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0t
LQogbW0vZmlsZW1hcC5jIHwgMTE3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTA3IGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL2ZpbGVtYXAuYyBiL21tL2ZpbGVt
YXAuYwppbmRleCA1NmZhNDMxYzUyYWYuLjkxZGQwOWM0M2FmNSAxMDA2NDQKLS0tIGEvbW0vZmls
ZW1hcC5jCisrKyBiL21tL2ZpbGVtYXAuYwpAQCAtMjU5NCw2ICsyNTk0LDg1IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCBwb3Nfc2FtZV9mb2xpbyhsb2ZmX3QgcG9zMSwgbG9mZl90IHBvczIsIHN0cnVj
dCBmb2xpbyAqZm9saW8pCiAJcmV0dXJuIChwb3MxID4+IHNoaWZ0ID09IHBvczIgPj4gc2hpZnQp
OwogfQogCisvKgorICogSSBjYW4ndCBiZSBib3RoZXJlZCB0byBjYXJlIGFib3V0IEhJR0hNRU0g
Zm9yIHRoZSBmYXN0IHJlYWQgY2FzZQorICovCisjaWZkZWYgQ09ORklHX0hJR0hNRU0KKyNkZWZp
bmUgZmlsZW1hcF9mYXN0X3JlYWQobWFwcGluZywgcG9zLCBidWZmZXIsIHNpemUpIDAKKyNlbHNl
CisKKy8qCisgKiBDYWxsZWQgdW5kZXIgUkNVIHdpdGggc2l6ZSBsaW1pdGVkIHRvIHRoZSBmaWxl
IHNpemUgYW5kIG9uZSBwYWdlCisgKi8KK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBmaWxl
bWFwX2ZvbGlvX2NvcHlfcmN1KHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBsb2ZmX3Qg
cG9zLCBjaGFyICpidWZmZXIsIHNpemVfdCBzaXplKQoreworCVhBX1NUQVRFKHhhcywgJm1hcHBp
bmctPmlfcGFnZXMsIHBvcyA+PiBQQUdFX1NISUZUKTsKKwlzdHJ1Y3QgZm9saW8gKmZvbGlvOwor
CXNpemVfdCBvZmZzZXQ7CisKKwl4YXNfcmVzZXQoJnhhcyk7CisJZm9saW8gPSB4YXNfbG9hZCgm
eGFzKTsKKwlpZiAoeGFzX3JldHJ5KCZ4YXMsIGZvbGlvKSkKKwkJcmV0dXJuIDA7CisKKwlpZiAo
IWZvbGlvIHx8IHhhX2lzX3ZhbHVlKGZvbGlvKSB8fCB4YV9pc19zaWJsaW5nKGZvbGlvKSkKKwkJ
cmV0dXJuIDA7CisKKwlpZiAoIWZvbGlvX3Rlc3RfdXB0b2RhdGUoZm9saW8pKQorCQlyZXR1cm4g
MDsKKworCS8qIE5vIGZhc3QtY2FzZSBpZiB3ZSBhcmUgc3VwcG9zZWQgdG8gc3RhcnQgcmVhZGFo
ZWFkICovCisJaWYgKGZvbGlvX3Rlc3RfcmVhZGFoZWFkKGZvbGlvKSkKKwkJcmV0dXJuIDA7CisJ
LyogLi4gb3IgbWFyayBpdCBhY2Nlc3NlZCAqLworCWlmICghZm9saW9fdGVzdF9yZWZlcmVuY2Vk
KGZvbGlvKSkKKwkJcmV0dXJuIDA7CisKKwkvKiBEbyB0aGUgZGF0YSBjb3B5ICovCisJb2Zmc2V0
ID0gcG9zICYgKGZvbGlvX3NpemUoZm9saW8pIC0gMSk7CisJbWVtY3B5KGJ1ZmZlciwgZm9saW9f
YWRkcmVzcyhmb2xpbykgKyBvZmZzZXQsIHNpemUpOworCisJLyogV2Ugc2hvdWxkIHByb2JhYmx5
IGRvIHNvbWUgc2lsbHkgbWVtb3J5IGJhcnJpZXIgaGVyZSAqLworCWlmICh1bmxpa2VseShmb2xp
byAhPSB4YXNfcmVsb2FkKCZ4YXMpKSkKKwkJcmV0dXJuIDA7CisKKwlyZXR1cm4gc2l6ZTsKK30K
KworLyoKKyAqIElmZiB3ZSBjYW4gY29tcGxldGUgdGhlIHJlYWQgY29tcGxldGVseSBpbiBvbmUg
YXRvbWljIGdvIHVuZGVyIFJDVSwKKyAqIGRvIHNvIGhlcmUuIE90aGVyd2lzZSByZXR1cm4gMCAo
bm8gcGFydGlhbCByZWFkcywgcGxlYXNlIC0gdGhpcyBpcworICogcHVyZWx5IGZvciB0aGUgdHJp
dmlhbCBmYXN0IGNhc2UpLgorICovCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgZmlsZW1h
cF9mYXN0X3JlYWQoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsIGxvZmZfdCBwb3MsIGNo
YXIgKmJ1ZmZlciwgc2l6ZV90IHNpemUpCit7CisJc3RydWN0IGlub2RlICppbm9kZTsKKwlsb2Zm
X3QgZmlsZV9zaXplOworCXVuc2lnbmVkIGxvbmcgcGdvZmY7CisKKwkvKiBEb24ndCBldmVuIHRy
eSBmb3IgcGFnZS1jcm9zc2VycyAqLworCXBnb2ZmID0gcG9zICYgflBBR0VfTUFTSzsKKwlpZiAo
cGdvZmYgKyBzaXplID4gUEFHRV9TSVpFKQorCQlyZXR1cm4gMDsKKworCS8qIExpbWl0IGl0IHRv
IHRoZSBmaWxlIHNpemUgKi8KKwlpbm9kZSA9IG1hcHBpbmctPmhvc3Q7CisJZmlsZV9zaXplID0g
aV9zaXplX3JlYWQoaW5vZGUpOworCWlmICh1bmxpa2VseShwb3MgPj0gZmlsZV9zaXplKSkKKwkJ
cmV0dXJuIDA7CisJZmlsZV9zaXplIC09IHBvczsKKwlpZiAoZmlsZV9zaXplIDwgc2l6ZSkKKwkJ
c2l6ZSA9IGZpbGVfc2l6ZTsKKworCS8qIExldCdzIHNlZSBpZiB3ZSBjYW4ganVzdCBkbyB0aGUg
cmVhZCB1bmRlciBSQ1UgKi8KKwlyY3VfcmVhZF9sb2NrKCk7CisJc2l6ZSA9IGZpbGVtYXBfZm9s
aW9fY29weV9yY3UobWFwcGluZywgcG9zLCBidWZmZXIsIHNpemUpOworCXJjdV9yZWFkX3VubG9j
aygpOworCisJcmV0dXJuIHNpemU7Cit9CisjZW5kaWYgLyogIUhJR0hNRU0gKi8KKwogLyoqCiAg
KiBmaWxlbWFwX3JlYWQgLSBSZWFkIGRhdGEgZnJvbSB0aGUgcGFnZSBjYWNoZS4KICAqIEBpb2Ni
OiBUaGUgaW9jYiB0byByZWFkLgpAQCAtMjYxNCw3ICsyNjkzLDEwIEBAIHNzaXplX3QgZmlsZW1h
cF9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVyLAogCXN0cnVj
dCBmaWxlX3JhX3N0YXRlICpyYSA9ICZmaWxwLT5mX3JhOwogCXN0cnVjdCBhZGRyZXNzX3NwYWNl
ICptYXBwaW5nID0gZmlscC0+Zl9tYXBwaW5nOwogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBtYXBw
aW5nLT5ob3N0OwotCXN0cnVjdCBmb2xpb19iYXRjaCBmYmF0Y2g7CisJdW5pb24geworCQlzdHJ1
Y3QgZm9saW9fYmF0Y2ggZmJhdGNoOworCQlfX0RFQ0xBUkVfRkxFWF9BUlJBWShjaGFyLCBidWZm
ZXIpOworCX0gYXJlYTsKIAlpbnQgaSwgZXJyb3IgPSAwOwogCWJvb2wgd3JpdGFibHlfbWFwcGVk
OwogCWxvZmZfdCBpc2l6ZSwgZW5kX29mZnNldDsKQEAgLTI2MjYsNyArMjcwOCwyMiBAQCBzc2l6
ZV90IGZpbGVtYXBfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRl
ciwKIAkJcmV0dXJuIDA7CiAKIAlpb3ZfaXRlcl90cnVuY2F0ZShpdGVyLCBpbm9kZS0+aV9zYi0+
c19tYXhieXRlcyAtIGlvY2ItPmtpX3Bvcyk7Ci0JZm9saW9fYmF0Y2hfaW5pdCgmZmJhdGNoKTsK
KworCWlmIChpb3ZfaXRlcl9jb3VudChpdGVyKSA8PSBzaXplb2YoYXJlYSkpIHsKKwkJdW5zaWdu
ZWQgbG9uZyBjb3VudCA9IGlvdl9pdGVyX2NvdW50KGl0ZXIpOworCisJCWNvdW50ID0gZmlsZW1h
cF9mYXN0X3JlYWQobWFwcGluZywgaW9jYi0+a2lfcG9zLCBhcmVhLmJ1ZmZlciwgY291bnQpOwor
CQlpZiAoY291bnQpIHsKKwkJCXNpemVfdCBjb3BpZWQgPSBjb3B5X3RvX2l0ZXIoYXJlYS5idWZm
ZXIsIGNvdW50LCBpdGVyKTsKKwkJCWlmICh1bmxpa2VseSghY29waWVkKSkKKwkJCQlyZXR1cm4g
YWxyZWFkeV9yZWFkID8gYWxyZWFkeV9yZWFkIDogLUVGQVVMVDsKKwkJCXJhLT5wcmV2X3BvcyA9
IGlvY2ItPmtpX3BvcyArPSBjb3BpZWQ7CisJCQlmaWxlX2FjY2Vzc2VkKGZpbHApOworCQkJcmV0
dXJuIGNvcGllZCArIGFscmVhZHlfcmVhZDsKKwkJfQorCX0KKworCWZvbGlvX2JhdGNoX2luaXQo
JmFyZWEuZmJhdGNoKTsKIAogCWRvIHsKIAkJY29uZF9yZXNjaGVkKCk7CkBAIC0yNjQyLDcgKzI3
MzksNyBAQCBzc2l6ZV90IGZpbGVtYXBfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBp
b3ZfaXRlciAqaXRlciwKIAkJaWYgKHVubGlrZWx5KGlvY2ItPmtpX3BvcyA+PSBpX3NpemVfcmVh
ZChpbm9kZSkpKQogCQkJYnJlYWs7CiAKLQkJZXJyb3IgPSBmaWxlbWFwX2dldF9wYWdlcyhpb2Ni
LCBpdGVyLT5jb3VudCwgJmZiYXRjaCwgZmFsc2UpOworCQllcnJvciA9IGZpbGVtYXBfZ2V0X3Bh
Z2VzKGlvY2IsIGl0ZXItPmNvdW50LCAmYXJlYS5mYmF0Y2gsIGZhbHNlKTsKIAkJaWYgKGVycm9y
IDwgMCkKIAkJCWJyZWFrOwogCkBAIC0yNjcwLDExICsyNzY3LDExIEBAIHNzaXplX3QgZmlsZW1h
cF9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVyLAogCQkgKiBt
YXJrIGl0IGFzIGFjY2Vzc2VkIHRoZSBmaXJzdCB0aW1lLgogCQkgKi8KIAkJaWYgKCFwb3Nfc2Ft
ZV9mb2xpbyhpb2NiLT5raV9wb3MsIGxhc3RfcG9zIC0gMSwKLQkJCQkgICAgZmJhdGNoLmZvbGlv
c1swXSkpCi0JCQlmb2xpb19tYXJrX2FjY2Vzc2VkKGZiYXRjaC5mb2xpb3NbMF0pOworCQkJCSAg
ICBhcmVhLmZiYXRjaC5mb2xpb3NbMF0pKQorCQkJZm9saW9fbWFya19hY2Nlc3NlZChhcmVhLmZi
YXRjaC5mb2xpb3NbMF0pOwogCi0JCWZvciAoaSA9IDA7IGkgPCBmb2xpb19iYXRjaF9jb3VudCgm
ZmJhdGNoKTsgaSsrKSB7Ci0JCQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gZmJhdGNoLmZvbGlvc1tp
XTsKKwkJZm9yIChpID0gMDsgaSA8IGZvbGlvX2JhdGNoX2NvdW50KCZhcmVhLmZiYXRjaCk7IGkr
KykgeworCQkJc3RydWN0IGZvbGlvICpmb2xpbyA9IGFyZWEuZmJhdGNoLmZvbGlvc1tpXTsKIAkJ
CXNpemVfdCBmc2l6ZSA9IGZvbGlvX3NpemUoZm9saW8pOwogCQkJc2l6ZV90IG9mZnNldCA9IGlv
Y2ItPmtpX3BvcyAmIChmc2l6ZSAtIDEpOwogCQkJc2l6ZV90IGJ5dGVzID0gbWluX3QobG9mZl90
LCBlbmRfb2Zmc2V0IC0gaW9jYi0+a2lfcG9zLApAQCAtMjcwNSw5ICsyODAyLDkgQEAgc3NpemVf
dCBmaWxlbWFwX3JlYWQoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIs
CiAJCQl9CiAJCX0KIHB1dF9mb2xpb3M6Ci0JCWZvciAoaSA9IDA7IGkgPCBmb2xpb19iYXRjaF9j
b3VudCgmZmJhdGNoKTsgaSsrKQotCQkJZm9saW9fcHV0KGZiYXRjaC5mb2xpb3NbaV0pOwotCQlm
b2xpb19iYXRjaF9pbml0KCZmYmF0Y2gpOworCQlmb3IgKGkgPSAwOyBpIDwgZm9saW9fYmF0Y2hf
Y291bnQoJmFyZWEuZmJhdGNoKTsgaSsrKQorCQkJZm9saW9fcHV0KGFyZWEuZmJhdGNoLmZvbGlv
c1tpXSk7CisJCWZvbGlvX2JhdGNoX2luaXQoJmFyZWEuZmJhdGNoKTsKIAl9IHdoaWxlIChpb3Zf
aXRlcl9jb3VudChpdGVyKSAmJiBpb2NiLT5raV9wb3MgPCBpc2l6ZSAmJiAhZXJyb3IpOwogCiAJ
ZmlsZV9hY2Nlc3NlZChmaWxwKTsK
--000000000000de0ba40626f8c7b2--

