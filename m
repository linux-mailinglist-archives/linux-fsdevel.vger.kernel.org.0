Return-Path: <linux-fsdevel+bounces-31805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF699B61D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86A8283938
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F859B71;
	Sat, 12 Oct 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SqGFhfSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2F1CFB6
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Oct 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728752491; cv=none; b=sGL8rp2G5xmQAPXWXTDPfu0k3mBifvLYXdbOYL75gnRkADgnkeb29u4gUznKp/tlQ2CNlJUFB/WFo5jd+mGCaWFUZhsDC/iyzIAottiIlws4koDv8tFa8Buug/jw8VVT04Qa8JWun5cP5CBDpQiO7yWAGd8gUbI6hfguDvNWyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728752491; c=relaxed/simple;
	bh=OrFTEk4OJ5/oC7f++K7QTVGGih9HPx9szWtkAxs8OI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpmG2aGjvBqfaEogxRUH+ICfKug9ey6sNk5+tmAIMy7VEOGFcLBJumAFLibq5r/+TU1oxh+5oBnJZt6yfMs29oUZznvV0GKUBkMa8rZZKk8Dolo7AGy4CNra4bi1vhl53U+XR+8IIJtABo9Wtf+mnpxh1g3TwAaS7w1sXDA1YiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SqGFhfSZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99b1f43aceso369664566b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Oct 2024 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728752487; x=1729357287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLK0SWU0DV/lYestXMEbl8Q5Iv6txd4W8a4XPICpv8U=;
        b=SqGFhfSZ2T6FWXMupAZAm3kGQw3UX4v6meofMYFq2BPjZVcuYWp5aEqyUPuHUpb4dH
         voWEowalKftOYa+TvgemSPjGSuguItFm58mkijKA0PaY/qZDHr+gpxL2jiLKrzGy39hG
         oaOcD4jAmrCjttt4kIjR3hLN9GOwsZ5W3Asm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728752487; x=1729357287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLK0SWU0DV/lYestXMEbl8Q5Iv6txd4W8a4XPICpv8U=;
        b=M+LvOHGKLRbe/YeM2LJUl1VbDJtGKFfaiM5KszHAX08/judj2qklztPNS9GK5VY6f9
         oIGiHEgPAh4SHCXtWo3U2ka/yfYHrSPFHLIht/S7dfcvc07V99a9af2Afo3fk8SpWfxx
         wLzi5BeIXEJN0niKs7WYoSGd8AL9XCKs+00UItgmpXlAUcquZj8YZGwHBMESZR0aUC5u
         qEDvpDXR1dnjfnxteWz/Xc5szVfOtHDwBAWWBBDpV+sHJ7q5kbaAflupAcDs05kP1xwq
         9f3ZKpqMphQGxMdJvIM/bbUXJhIXeDqq9cYdtue9ZERbHtdVcmq0ck9PW0VBoMJFgumI
         WyDw==
X-Forwarded-Encrypted: i=1; AJvYcCWTGJ+YLbw8q3vmTBW0xSL9VbfXUsVlG7pzJ65ZR6P4I3qqnl7D5petJH2UXErEjrjkcDI3x/qRNQ6YxF8X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27cNt44glEajivKOtkJ4uJ8mP/7qtanwuKBOhYMJnAE2Gahyj
	HaCciSgBJAu0mBQYiLX9lsLZOr86OTA8cgIVgF/F5IvKwMD/kDoTKJjaJ2Pxvznt0z1QeRz+IkB
	OnrE=
X-Google-Smtp-Source: AGHT+IFkfOwedwa9g5jZ/MY825X4qRtJ3gD3c2qBRMY3kJs+zk3lI1asf20ORYmV06DZyQfBNwk5Sg==
X-Received: by 2002:a17:907:728f:b0:a99:5f65:fd9a with SMTP id a640c23a62f3a-a99a13b0aefmr846048666b.21.1728752487265;
        Sat, 12 Oct 2024 10:01:27 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f292146fsm68794566b.118.2024.10.12.10.01.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 10:01:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99e3b3a411so133968766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Oct 2024 10:01:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdbONZYllWMRqWT8UpIYI7Hxx3I/83FekpixCoMMwwMXA3122PLM1qTp648HcFu7NYdzvfc2dAbCwVCjhA@vger.kernel.org
X-Received: by 2002:a17:907:720f:b0:a98:f44d:a198 with SMTP id
 a640c23a62f3a-a99b8775a40mr639248066b.1.1728752485597; Sat, 12 Oct 2024
 10:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org> <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org> <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com> <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area> <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io> <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io> <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <f8232f8b-06e0-4d1a-bee4-cfc2ac23194e@meta.com> <E07B71C9-A22A-4C0C-B4AD-247CECC74DFA@flyingcircus.io>
 <381863DE-17A7-4D4E-8F28-0F18A4CEFC31@flyingcircus.io> <0A480EBE-9B4D-49CC-9A32-3526F32426E6@flyingcircus.io>
 <c6d723ca-457a-4f97-9813-a75349225e85@meta.com>
In-Reply-To: <c6d723ca-457a-4f97-9813-a75349225e85@meta.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 12 Oct 2024 10:01:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjty_0NfiZn2HVzT0Ye-RR09+Rqbd1azwJLOTJrX+V5MQ@mail.gmail.com>
Message-ID: <CAHk-=wjty_0NfiZn2HVzT0Ye-RR09+Rqbd1azwJLOTJrX+V5MQ@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Chris Mason <clm@meta.com>
Cc: Christian Theune <ct@flyingcircus.io>, Dave Chinner <david@fromorbit.com>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: multipart/mixed; boundary="000000000000cf77a306244a8d90"

--000000000000cf77a306244a8d90
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 06:06, Chris Mason <clm@meta.com> wrote:
>
> - Linus's starvation observation.  It doesn't feel like there's enough
> load to cause this, especially given us sitting in truncate, where it
> should be pretty unlikely to have multiple procs banging on the page in
> question.

Yeah, I think the starvation can only possibly happen in
fdatasync-like paths where it's waiting for existing writeback without
holding the page lock. And while Christian has had those backtraces
too, the truncate path is not one of them.

That said, just because I wanted to see how nasty it is, I looked into
changing the rules for folio_wake_bit().

Christian, just to clarify, this is not for  you to test - this is
very experimental - but maybe Willy has comments on it.

Because it *might* be possible to do something like the attached,
where we do the page flags changes atomically but without any locks if
there are no waiters, but if there is a waiter on the page, we always
clear the page flag bit atomically under the waitqueue lock as we wake
up the waiter.

I changed the name (and the return value) of the
folio_xor_flags_has_waiters() function to just not have any
possibility of semantic mixup, but basically instead of doing the xor
atomically and unconditionally (and returning whether we had waiters),
it now does it conditionally only if we do *not* have waiters, and
returns true if successful.

And if there were waiters, it moves the flag clearing into the wakeup function.

That in turn means that the "while whiteback" loop can go back to be
just a non-looping "if writeback", and folio_wait_writeback() can't
get into any starvation with new writebacks always showing up.

The reason I say it *might* be possible to do something like this is
that it changes __folio_end_writeback() to no longer necessarily clear
the writeback bit under the XA lock. If there are waiters, we'll clear
it later (after releasing the lock) in the caller.

Willy? What do you think? Clearly this now makes PG_writeback not
synchronized with the PAGECACHE_TAG_WRITEBACK tag, but the reason I
think it might be ok is that the code that *sets* the PG_writeback bit
in __folio_start_writeback() only ever starts with a page that isn't
under writeback, and has a

        VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);

at the top of the function even outside the XA lock. So I don't think
these *need* to be synchronized under the XA lock, and I think the
folio flag wakeup atomicity might be more important than the XA
writeback tag vs folio writeback bit.

But I'm not going to really argue for this patch at all - I wanted to
look at how bad it was, I wrote it, I'm actually running it on my
machine now and it didn't *immediately* blow up in my face, so it
*may* work just fine.

The patch is fairly simple, and apart from the XA tagging issue is
seems very straightforward. I'm just not sure it's worth synchronizing
one part just to at the same time de-synchronize another..

                   Linus

--000000000000cf77a306244a8d90
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Test-atomic-folio-bit-waiting.patch"
Content-Disposition: attachment; 
	filename="0001-Test-atomic-folio-bit-waiting.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m26e2grp0>
X-Attachment-Id: f_m26e2grp0

RnJvbSA5ZDRmMGQ2MGFiYzRkY2U1YjdjZmJhZDQ1NzZhMjgyOTgzMmJiODM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMTIgT2N0IDIwMjQgMDk6MzQ6MjQgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBUZXN0IGF0b21pYyBmb2xpbyBiaXQgd2FpdGluZwoKLS0tCiBpbmNsdWRlL2xpbnV4
L3BhZ2UtZmxhZ3MuaCB8IDI2ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tCiBtbS9maWxlbWFw
LmMgICAgICAgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIG1tL3Bh
Z2Utd3JpdGViYWNrLmMgICAgICAgIHwgIDYgKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDQ1IGlu
c2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
cGFnZS1mbGFncy5oIGIvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgKaW5kZXggMWIzYTc2NzEw
NDg3Li5iMzBhNzNlMWMyYzcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy5o
CisrKyBiL2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oCkBAIC03MzAsMjIgKzczMCwyOCBAQCBU
RVNUUEFHRUZMQUdfRkFMU0UoS3NtLCBrc20pCiB1NjQgc3RhYmxlX3BhZ2VfZmxhZ3MoY29uc3Qg
c3RydWN0IHBhZ2UgKnBhZ2UpOwogCiAvKioKLSAqIGZvbGlvX3hvcl9mbGFnc19oYXNfd2FpdGVy
cyAtIENoYW5nZSBzb21lIGZvbGlvIGZsYWdzLgorICogZm9saW9feG9yX2ZsYWdzX25vX3dhaXRl
cnMgLSBDaGFuZ2UgZm9saW8gZmxhZ3MgaWYgbm8gd2FpdGVycwogICogQGZvbGlvOiBUaGUgZm9s
aW8uCi0gKiBAbWFzazogQml0cyBzZXQgaW4gdGhpcyB3b3JkIHdpbGwgYmUgY2hhbmdlZC4KKyAq
IEBtYXNrOiBXaGljaCBmbGFncyB0byBjaGFuZ2UuCiAgKgotICogVGhpcyBtdXN0IG9ubHkgYmUg
dXNlZCBmb3IgZmxhZ3Mgd2hpY2ggYXJlIGNoYW5nZWQgd2l0aCB0aGUgZm9saW8KLSAqIGxvY2sg
aGVsZC4gIEZvciBleGFtcGxlLCBpdCBpcyB1bnNhZmUgdG8gdXNlIGZvciBQR19kaXJ0eSBhcyB0
aGF0Ci0gKiBjYW4gYmUgc2V0IHdpdGhvdXQgdGhlIGZvbGlvIGxvY2sgaGVsZC4gIEl0IGNhbiBh
bHNvIG9ubHkgYmUgdXNlZAotICogb24gZmxhZ3Mgd2hpY2ggYXJlIGluIHRoZSByYW5nZSAwLTYg
YXMgc29tZSBvZiB0aGUgaW1wbGVtZW50YXRpb25zCi0gKiBvbmx5IGFmZmVjdCB0aG9zZSBiaXRz
LgorICogVGhpcyBkb2VzIHRoZSBvcHRpbWlzdGljIGZhc3QtY2FzZSBvZiBjaGFuZ2luZyBwYWdl
IGZsYWcgYml0cworICogdGhhdCBoYXMgbm8gd2FpdGVycy4gT25seSBmbGFncyBpbiB0aGUgZmly
c3Qgd29yZCBjYW4gYmUgbW9kaWZpZWQsCisgKiBhbmQgdGhlIG9sZCB2YWx1ZSBtdXN0IGJlIHN0
YWJsZSAodHlwaWNhbGx5IHRoaXMgY2xlYXJzIHRoZQorICogbG9ja2VkIG9yIHdyaXRlYmFjayBi
aXQgb3Igc2ltaWxhcikuCiAgKgotICogUmV0dXJuOiBXaGV0aGVyIHRoZXJlIGFyZSB0YXNrcyB3
YWl0aW5nIG9uIHRoZSBmb2xpby4KKyAqIFJldHVybjogdHJ1ZSBpZiBpdCBzdWNjZWVkZWQKICAq
Lwotc3RhdGljIGlubGluZSBib29sIGZvbGlvX3hvcl9mbGFnc19oYXNfd2FpdGVycyhzdHJ1Y3Qg
Zm9saW8gKmZvbGlvLAorc3RhdGljIGlubGluZSBib29sIGZvbGlvX3hvcl9mbGFnc19ub193YWl0
ZXJzKHN0cnVjdCBmb2xpbyAqZm9saW8sCiAJCXVuc2lnbmVkIGxvbmcgbWFzaykKIHsKLQlyZXR1
cm4geG9yX3VubG9ja19pc19uZWdhdGl2ZV9ieXRlKG1hc2ssIGZvbGlvX2ZsYWdzKGZvbGlvLCAw
KSk7CisJY29uc3QgdW5zaWduZWQgbG9uZyB3YWl0ZXJfbWFzayA9IDF1bCA8PCBQR193YWl0ZXJz
OworCXVuc2lnbmVkIGxvbmcgKmZsYWdzID0gZm9saW9fZmxhZ3MoZm9saW8sIDApOworCXVuc2ln
bmVkIGxvbmcgdmFsID0gUkVBRF9PTkNFKCpmbGFncyk7CisJZG8geworCQlpZiAodmFsICYgd2Fp
dGVyX21hc2spCisJCQlyZXR1cm4gZmFsc2U7CisJfSB3aGlsZSAoIXRyeV9jbXB4Y2hnX3JlbGVh
c2UoZmxhZ3MsICZ2YWwsIHZhbCBeIG1hc2spKTsKKwlyZXR1cm4gdHJ1ZTsKIH0KIAogLyoqCmRp
ZmYgLS1naXQgYS9tbS9maWxlbWFwLmMgYi9tbS9maWxlbWFwLmMKaW5kZXggNjY0ZTYwN2E3MWVh
Li41ZmJhZjZjZWE5NjQgMTAwNjQ0Ci0tLSBhL21tL2ZpbGVtYXAuYworKysgYi9tbS9maWxlbWFw
LmMKQEAgLTExNjQsNiArMTE2NCwxNCBAQCBzdGF0aWMgaW50IHdha2VfcGFnZV9mdW5jdGlvbih3
YWl0X3F1ZXVlX2VudHJ5X3QgKndhaXQsIHVuc2lnbmVkIG1vZGUsIGludCBzeW5jLAogCXJldHVy
biAoZmxhZ3MgJiBXUV9GTEFHX0VYQ0xVU0lWRSkgIT0gMDsKIH0KIAorLyoKKyAqIENsZWFyIHRo
ZSBmb2xpbyBiaXQgYW5kIHdha2Ugd2FpdGVycyBhdG9taWNhbGx5IHVuZGVyCisgKiB0aGUgZm9s
aW8gd2FpdHF1ZXVlIGxvY2suCisgKgorICogTm90ZSB0aGF0IHRoZSBmYXN0LXBhdGggYWx0ZXJu
YXRpdmUgdG8gY2FsbGluZyB0aGlzIGlzCisgKiB0byBhdG9taWNhbGx5IGNsZWFyIHRoZSBiaXQg
YW5kIGNoZWNrIHRoYXQgdGhlIFBHX3dhaXRlcnMKKyAqIGJpdCB3YXMgbm90IHNldC4KKyAqLwog
c3RhdGljIHZvaWQgZm9saW9fd2FrZV9iaXQoc3RydWN0IGZvbGlvICpmb2xpbywgaW50IGJpdF9u
cikKIHsKIAl3YWl0X3F1ZXVlX2hlYWRfdCAqcSA9IGZvbGlvX3dhaXRxdWV1ZShmb2xpbyk7CkBA
IC0xMTc1LDYgKzExODMsNyBAQCBzdGF0aWMgdm9pZCBmb2xpb193YWtlX2JpdChzdHJ1Y3QgZm9s
aW8gKmZvbGlvLCBpbnQgYml0X25yKQogCWtleS5wYWdlX21hdGNoID0gMDsKIAogCXNwaW5fbG9j
a19pcnFzYXZlKCZxLT5sb2NrLCBmbGFncyk7CisJY2xlYXJfYml0X3VubG9jayhiaXRfbnIsIGZv
bGlvX2ZsYWdzKGZvbGlvLCAwKSk7CiAJX193YWtlX3VwX2xvY2tlZF9rZXkocSwgVEFTS19OT1JN
QUwsICZrZXkpOwogCiAJLyoKQEAgLTE1MDcsNyArMTUxNiw3IEBAIHZvaWQgZm9saW9fdW5sb2Nr
KHN0cnVjdCBmb2xpbyAqZm9saW8pCiAJQlVJTERfQlVHX09OKFBHX3dhaXRlcnMgIT0gNyk7CiAJ
QlVJTERfQlVHX09OKFBHX2xvY2tlZCA+IDcpOwogCVZNX0JVR19PTl9GT0xJTyghZm9saW9fdGVz
dF9sb2NrZWQoZm9saW8pLCBmb2xpbyk7Ci0JaWYgKGZvbGlvX3hvcl9mbGFnc19oYXNfd2FpdGVy
cyhmb2xpbywgMSA8PCBQR19sb2NrZWQpKQorCWlmICghZm9saW9feG9yX2ZsYWdzX25vX3dhaXRl
cnMoZm9saW8sIDEgPDwgUEdfbG9ja2VkKSkKIAkJZm9saW9fd2FrZV9iaXQoZm9saW8sIFBHX2xv
Y2tlZCk7CiB9CiBFWFBPUlRfU1lNQk9MKGZvbGlvX3VubG9jayk7CkBAIC0xNTM1LDEwICsxNTQ0
LDI1IEBAIHZvaWQgZm9saW9fZW5kX3JlYWQoc3RydWN0IGZvbGlvICpmb2xpbywgYm9vbCBzdWNj
ZXNzKQogCVZNX0JVR19PTl9GT0xJTyghZm9saW9fdGVzdF9sb2NrZWQoZm9saW8pLCBmb2xpbyk7
CiAJVk1fQlVHX09OX0ZPTElPKGZvbGlvX3Rlc3RfdXB0b2RhdGUoZm9saW8pLCBmb2xpbyk7CiAK
KwkvKgorCSAqIFRyeSB0byBjbGVhciAnbG9ja2VkJyBhdCB0aGUgc2FtZSB0aW1lIGFzIHNldHRp
bmcgJ3VwdG9kYXRlJworCSAqCisJICogTm90ZSB0aGF0IGlmIHdlIGhhdmUgbG9jayBiaXQgd2Fp
dGVycyBhbmQgdGhpcyBmYXN0LWNhc2UgZmFpbHMsCisJICogd2UnbGwgaGF2ZSB0byBjbGVhciB0
aGUgbG9jayBiaXQgYXRvbWljYWxseSB1bmRlciB0aGUgZm9saW8gd2FpdAorCSAqIHF1ZXVlIGxv
Y2ssIHNvIHRoZW4gd2UnbGwgc2V0ICd1cGRhdGUnIHNlcGFyYXRlbHkuCisJICoKKwkgKiBOb3Rl
IHRoYXQgdGhpcyBpcyBwdXJlbHkgYSAiYXZvaWQgbXVsdGlwbGUgYXRvbWljcyBpbiB0aGUKKwkg
KiBjb21tb24gY2FzZSIgLSB3aGlsZSB0aGUgbG9ja2VkIGJpdCBuZWVkcyB0byBiZSBjbGVhcmVk
CisJICogc3luY2hyb25vdXNseSB3cnQgd2FpdGVycywgdGhlIHVwdG9kYXRlIGJpdCBoYXMgbm8g
c3VjaAorCSAqIHJlcXVpcmVtZW50cy4KKwkgKi8KIAlpZiAobGlrZWx5KHN1Y2Nlc3MpKQogCQlt
YXNrIHw9IDEgPDwgUEdfdXB0b2RhdGU7Ci0JaWYgKGZvbGlvX3hvcl9mbGFnc19oYXNfd2FpdGVy
cyhmb2xpbywgbWFzaykpCisJaWYgKCFmb2xpb194b3JfZmxhZ3Nfbm9fd2FpdGVycyhmb2xpbywg
bWFzaykpIHsKKwkJaWYgKHN1Y2Nlc3MpCisJCQlzZXRfYml0KFBHX3VwdG9kYXRlLCBmb2xpb19m
bGFncyhmb2xpbywgMCkpOwogCQlmb2xpb193YWtlX2JpdChmb2xpbywgUEdfbG9ja2VkKTsKKwl9
CiB9CiBFWFBPUlRfU1lNQk9MKGZvbGlvX2VuZF9yZWFkKTsKIApkaWZmIC0tZ2l0IGEvbW0vcGFn
ZS13cml0ZWJhY2suYyBiL21tL3BhZ2Utd3JpdGViYWNrLmMKaW5kZXggZmNkNGMxNDM5Y2I5Li4z
Mjc3YmMzY2VmZjkgMTAwNjQ0Ci0tLSBhL21tL3BhZ2Utd3JpdGViYWNrLmMKKysrIGIvbW0vcGFn
ZS13cml0ZWJhY2suYwpAQCAtMzA4MSw3ICszMDgxLDcgQEAgYm9vbCBfX2ZvbGlvX2VuZF93cml0
ZWJhY2soc3RydWN0IGZvbGlvICpmb2xpbykKIAkJdW5zaWduZWQgbG9uZyBmbGFnczsKIAogCQl4
YV9sb2NrX2lycXNhdmUoJm1hcHBpbmctPmlfcGFnZXMsIGZsYWdzKTsKLQkJcmV0ID0gZm9saW9f
eG9yX2ZsYWdzX2hhc193YWl0ZXJzKGZvbGlvLCAxIDw8IFBHX3dyaXRlYmFjayk7CisJCXJldCA9
ICFmb2xpb194b3JfZmxhZ3Nfbm9fd2FpdGVycyhmb2xpbywgMSA8PCBQR193cml0ZWJhY2spOwog
CQlfX3hhX2NsZWFyX21hcmsoJm1hcHBpbmctPmlfcGFnZXMsIGZvbGlvX2luZGV4KGZvbGlvKSwK
IAkJCQkJUEFHRUNBQ0hFX1RBR19XUklURUJBQ0spOwogCQlpZiAoYmRpLT5jYXBhYmlsaXRpZXMg
JiBCRElfQ0FQX1dSSVRFQkFDS19BQ0NUKSB7CkBAIC0zMDk5LDcgKzMwOTksNyBAQCBib29sIF9f
Zm9saW9fZW5kX3dyaXRlYmFjayhzdHJ1Y3QgZm9saW8gKmZvbGlvKQogCiAJCXhhX3VubG9ja19p
cnFyZXN0b3JlKCZtYXBwaW5nLT5pX3BhZ2VzLCBmbGFncyk7CiAJfSBlbHNlIHsKLQkJcmV0ID0g
Zm9saW9feG9yX2ZsYWdzX2hhc193YWl0ZXJzKGZvbGlvLCAxIDw8IFBHX3dyaXRlYmFjayk7CisJ
CXJldCA9ICFmb2xpb194b3JfZmxhZ3Nfbm9fd2FpdGVycyhmb2xpbywgMSA8PCBQR193cml0ZWJh
Y2spOwogCX0KIAogCWxydXZlY19zdGF0X21vZF9mb2xpbyhmb2xpbywgTlJfV1JJVEVCQUNLLCAt
bnIpOwpAQCAtMzE4NCw3ICszMTg0LDcgQEAgRVhQT1JUX1NZTUJPTChfX2ZvbGlvX3N0YXJ0X3dy
aXRlYmFjayk7CiAgKi8KIHZvaWQgZm9saW9fd2FpdF93cml0ZWJhY2soc3RydWN0IGZvbGlvICpm
b2xpbykKIHsKLQl3aGlsZSAoZm9saW9fdGVzdF93cml0ZWJhY2soZm9saW8pKSB7CisJaWYgKGZv
bGlvX3Rlc3Rfd3JpdGViYWNrKGZvbGlvKSkgewogCQl0cmFjZV9mb2xpb193YWl0X3dyaXRlYmFj
ayhmb2xpbywgZm9saW9fbWFwcGluZyhmb2xpbykpOwogCQlmb2xpb193YWl0X2JpdChmb2xpbywg
UEdfd3JpdGViYWNrKTsKIAl9Ci0tIAoyLjQ2LjEuNjA4LmdjNTZmMmMxMWM4Cgo=
--000000000000cf77a306244a8d90--

