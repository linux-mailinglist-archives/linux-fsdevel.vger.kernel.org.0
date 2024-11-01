Return-Path: <linux-fsdevel+bounces-33390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289B9B883B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329F4282469
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859CB41C94;
	Fri,  1 Nov 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d+TuiBjr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E9125D5
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423865; cv=none; b=ouWNuNRBnuIaNMRrdtrr4/7Bx7B8bVmvbGJ/HML5wjbyafSmbb6c2NQwl7nSYJXDR6nLaxX8L7Z9+7HuVF/vTeqrHA5nZe7m7Wot+0RoCIorAnXbZQipA300ue2n/oA3phw7csZNM+yk1xLRzwOMNKPf/5sED8gS39YFhxj7NzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423865; c=relaxed/simple;
	bh=xenxC6YczH4K4H06vitMhCOWfzYDtRUIkPNwIHyqh44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQ3+QtI0uooToRpopcqqg1TgdgpOEVtg8VA8Jxq8pYUUHa0/gSKgj4p/IoCYO1eZla38/lcTYjrGvpMm9sgYGayB9Qkd+0Y1/HxI6Egn4/4Hau41jkyrKmQ5WsCkl+gAIwNlE8VZzCsgs0l5TMcLVVtORmAPSWtUN7cbP+pWMLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d+TuiBjr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1077304f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 18:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730423857; x=1731028657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zh9CWmFIfyHo2XfxJB/qRNbUq54r+yvMsrNNco21Oyc=;
        b=d+TuiBjrPMd8S2QpBKDTMwvEPRcuzlPRv8NoPujxZrD/lwcCbTGnNrfxOJobeH2p5+
         m5GqdCNvhT8OvIuASwFGm7IfaxOw4qu1EYDT2xzRWRoPH79/3IYYNcINDdVyioPuyuWD
         67gZAQNe55oInIE1USsQoV/j6kwZOT0O5VNhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730423857; x=1731028657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zh9CWmFIfyHo2XfxJB/qRNbUq54r+yvMsrNNco21Oyc=;
        b=L8Q4oiRSgwRoRlvz1hhGjs2qB2iJnoKRQFhCWVyQ6NaLFoSnw1J/G/kaCxyGE2w+cc
         5Q4Vrwgc+B43BLDa49/GGZ75f3YTEaoNRGTpa+P74ag2ykueDxRC54jTUeQFWbYTyigp
         bnRhgYyJR0Ub+tUG9A8PbJZW2MMcY8rhSeMM5lpgG9d4FeYTZo9FvErUHb+HPOL0ALNg
         JHSJeyDSyBZDlWunzcoQbylq0mm4VuwIuDsHek1S3xATOvhN8rc2Se6i56sKvRA7Lc7G
         HTP+r36oMZD64WbgN4tvyuEQvlsW+D25t8mfY58T4f3jO2x1wF+f3nUwF+weDCY+/mjn
         Ze8g==
X-Forwarded-Encrypted: i=1; AJvYcCWnQluJd1riFEAt1sLNuBHiaEA6zKd4ado8ZJkT2y08+A15x5Hd7PMf7BnLqmI+eFsdKcLyuZ9lUNcdZPp0@vger.kernel.org
X-Gm-Message-State: AOJu0YyGF6AHsaSKMtcQeYYzC+GoTaOgXW4RwhMxVZWoHxRAJjaa6KPO
	6uYpMyynn8vtNkjt1aVLKlabMDC0gE32cQdJboeRhUu6S2WbqPjY3Lqjl9eG2T2bfXlFlJs7BDw
	EDME=
X-Google-Smtp-Source: AGHT+IGGVrEawp0xqcys+codf0P1wYjOwttp1PrhlZbHompgtM/+s/D+4zZJoYT8k9isTcItC0s7fw==
X-Received: by 2002:a05:6000:1541:b0:37d:4e9d:34d1 with SMTP id ffacd0b85a97d-381bea1bbaamr4282376f8f.37.1730423857458;
        Thu, 31 Oct 2024 18:17:37 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789bf2sm1042658a12.45.2024.10.31.18.17.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 18:17:36 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9e44654ae3so163446266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 18:17:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOpKAPxK43flKbqoh+Xo6r20huOiayHlbR78fXEkazICD3siaisqH6b95rDvpgiozsf/QMGRCgilaGfq9r@vger.kernel.org
X-Received: by 2002:a17:907:3da1:b0:a99:e831:1b52 with SMTP id
 a640c23a62f3a-a9e50b948a8mr433969466b.51.1730423855277; Thu, 31 Oct 2024
 18:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031060507.GJ1350452@ZenIV> <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
 <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com>
 <20241031222837.GM1350452@ZenIV> <CAHk-=wisMQcFUC5F1_NNPm+nTfBo__P9MwQ5jcGAer7vjz+WzQ@mail.gmail.com>
In-Reply-To: <CAHk-=wisMQcFUC5F1_NNPm+nTfBo__P9MwQ5jcGAer7vjz+WzQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Oct 2024 15:17:18 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgXEoAOFRkDg+grxs+p1U+QjWXLixRGmYEfd=vG+OBuFw@mail.gmail.com>
Message-ID: <CAHk-=wgXEoAOFRkDg+grxs+p1U+QjWXLixRGmYEfd=vG+OBuFw@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000349cfb0625cfb387"

--000000000000349cfb0625cfb387
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 12:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'd rather start with just the cheap inode-only "ACL is clearly not
> there" check, and later if we find that the ACL_NOT_CACHED case is
> problematic do we look at that.

Actually, if I switch the tests around so that I do the permission bit
check first, it becomes very natural to just check IS_POSIXACL() at
the end (where we're about to go to the slow case, which will be
touching i_sb anyway).

Plus I can actually improve code generation by not shifting the mode
bits down into the low bits, but instead spreading the requested
permission bits around.

The "spread bits around" becomes a simple constant multiplication with
just three bits set, and the compiler will actually generate much
better code (you can do it with two consecutive 'lea' instructions).

The expression for this ends up looking a bit like line noise, so a
comment explaining each step is a good idea.

IOW, here's a rewritten patch that does it that way around, and thus
deals with IS_POSIXACL() very naturally and seems to generate quite
good code for me.

Of course, while I actually tested the previous version after sending
it out, this new version is entirely untested. Again.

             Linus

--000000000000349cfb0625cfb387
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m2y1o85o0>
X-Attachment-Id: f_m2y1o85o0

IGZzL25hbWVpLmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9uYW1l
aS5jIGIvZnMvbmFtZWkuYwppbmRleCA0YTRhMjJhMDhhYzIuLjgwZjlhMTRjYTlhNSAxMDA2NDQK
LS0tIGEvZnMvbmFtZWkuYworKysgYi9mcy9uYW1laS5jCkBAIC0zMjYsNiArMzI2LDI1IEBAIHN0
YXRpYyBpbnQgY2hlY2tfYWNsKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCXJldHVybiAtRUFH
QUlOOwogfQogCisvKgorICogVmVyeSBxdWljayBvcHRpbWlzdGljICJ3ZSBrbm93IHdlIGhhdmUg
bm8gQUNMJ3MiIGNoZWNrLgorICoKKyAqIE5vdGUgdGhhdCB0aGlzIGlzIHB1cmVseSBmb3IgQUNM
X1RZUEVfQUNDRVNTLCBhbmQgcHVyZWx5CisgKiBmb3IgdGhlICJ3ZSBoYXZlIGNhY2hlZCB0aGF0
IHRoZXJlIGFyZSBubyBBQ0xzIiBjYXNlLgorICoKKyAqIElmIHRoaXMgcmV0dXJucyB0cnVlLCB3
ZSBrbm93IHRoZXJlIGFyZSBubyBBQ0xzLiBCdXQgaWYKKyAqIGl0IHJldHVybnMgZmFsc2UsIHdl
IG1pZ2h0IHN0aWxsIG5vdCBoYXZlIEFDTHMgKGl0IGNvdWxkCisgKiBiZSB0aGUgaXNfdW5jYWNo
ZWRfYWNsKCkgY2FzZSkuCisgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBub19hY2xfaW5vZGUoc3Ry
dWN0IGlub2RlICppbm9kZSkKK3sKKyNpZmRlZiBDT05GSUdfRlNfUE9TSVhfQUNMCisJcmV0dXJu
IGxpa2VseSghUkVBRF9PTkNFKGlub2RlLT5pX2FjbCkpOworI2Vsc2UKKwlyZXR1cm4gdHJ1ZTsK
KyNlbmRpZgorfQorCiAvKioKICAqIGFjbF9wZXJtaXNzaW9uX2NoZWNrIC0gcGVyZm9ybSBiYXNp
YyBVTklYIHBlcm1pc3Npb24gY2hlY2tpbmcKICAqIEBpZG1hcDoJaWRtYXAgb2YgdGhlIG1vdW50
IHRoZSBpbm9kZSB3YXMgZm91bmQgZnJvbQpAQCAtMzQ4LDYgKzM2NywyOCBAQCBzdGF0aWMgaW50
IGFjbF9wZXJtaXNzaW9uX2NoZWNrKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLAogCXVuc2lnbmVk
IGludCBtb2RlID0gaW5vZGUtPmlfbW9kZTsKIAl2ZnN1aWRfdCB2ZnN1aWQ7CiAKKwkvKgorCSAq
IENvbW1vbiBjaGVhcCBjYXNlOiBldmVyeWJvZHkgaGFzIHRoZSByZXF1ZXN0ZWQKKwkgKiByaWdo
dHMsIGFuZCB0aGVyZSBhcmUgbm8gQUNMcyB0byBjaGVjay4gTm8gbmVlZAorCSAqIHRvIGRvIGFu
eSBvd25lci9ncm91cCBjaGVja3MgaW4gdGhhdCBjYXNlLgorCSAqCisJICogIC0gJ21hc2smNycg
aXMgdGhlIHJlcXVlc3RlZCBwZXJtaXNzaW9uIGJpdCBzZXQKKwkgKiAgLSBtdWx0aXBseWluZyBi
eSAwMTExIHNwcmVhZHMgdGhlbSBvdXQgdG8gYWxsIG9mIHVnbworCSAqICAtICcmIH5tb2RlJyBs
b29rcyBmb3IgbWlzc2luZyBpbm9kZSBwZXJtaXNzaW9uIGJpdHMKKwkgKiAgLSB0aGUgJyEnIGlz
IGZvciAibm8gbWlzc2luZyBwZXJtaXNzaW9ucyIKKwkgKgorCSAqIEFmdGVyIHRoYXQsIHdlIGp1
c3QgbmVlZCB0byBjaGVjayB0aGF0IHRoZXJlIGFyZSBubworCSAqIEFDTCdzIG9uIHRoZSBpbm9k
ZSAtIGRvIHRoZSAnSVNfUE9TSVhBQ0woKScgY2hlY2sgbGFzdAorCSAqIGJlY2F1c2UgaXQgd2ls
bCBkZXJlZmVyZW5jZSB0aGUgLT5pX3NiIHBvaW50ZXIgYW5kIHdlCisJICogd2FudCB0byBhdm9p
ZCB0aGF0IGlmIGF0IGFsbCBwb3NzaWJsZS4KKwkgKi8KKwlpZiAoISgobWFzayAmIDcpKjAxMTEg
JiB+bW9kZSkpIHsKKwkJaWYgKG5vX2FjbF9pbm9kZShpbm9kZSkpCisJCQlyZXR1cm4gMDsKKwkJ
aWYgKCFJU19QT1NJWEFDTChpbm9kZSkpCisJCQlyZXR1cm4gMDsKKwl9CisKIAkvKiBBcmUgd2Ug
dGhlIG93bmVyPyBJZiBzbywgQUNMJ3MgZG9uJ3QgbWF0dGVyICovCiAJdmZzdWlkID0gaV91aWRf
aW50b192ZnN1aWQoaWRtYXAsIGlub2RlKTsKIAlpZiAobGlrZWx5KHZmc3VpZF9lcV9rdWlkKHZm
c3VpZCwgY3VycmVudF9mc3VpZCgpKSkpIHsK
--000000000000349cfb0625cfb387--

