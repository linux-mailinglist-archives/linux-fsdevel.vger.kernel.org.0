Return-Path: <linux-fsdevel+bounces-43006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39523A4CCE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 21:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8417A896C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AB236435;
	Mon,  3 Mar 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e0Rpdl0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86511CA9
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034795; cv=none; b=V//ghMNoVYae3nEG6NBZhxCdIWsBqaa4p7xDtM1pnidd/qXRhZwx8GAH2kzFo/T1PydyzQdBmFWyEa80uSgkST5YFKKjU6Q9yNs4DhYeX8aWFI2ZBKx8JmrGrRmnoK2LQH5/u7aG8Dn62NWu5YL9oVYLcMfSf9LYLPQpdA+wuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034795; c=relaxed/simple;
	bh=/TSvSx+n/7h75HAByI0XmaklVwSreC1/YD2z85/rnbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwpMhC4i5sYrzuRTllaiXB2EVN1/iZ/q5P+w5nf4RyS1sXbNglgIGlZEfAnNQ9dlgvLa3NObZwtBUPVk3Z5l/7Odx25ezKP2xDQ/4oYJTgk2Ihi926IpB+t+GEoc+7/5w2W3aWjECpSuQL9JjH9qZM7P5rQJ6cnyeTMleyLso1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e0Rpdl0S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso929679966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741034791; x=1741639591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8giJnezX3CtMdKV60CgQxT4SKIJQ9hhEThxu7GG34A=;
        b=e0Rpdl0S6MiX10ElYBR0Qw+FgqAZnaICzmql0ZDrZcIEe9wffXA5Ji9IrFuoc5E9ff
         nVIvkhQncvjCNn5vrBg2tJnsJXruwitiy2gSIudVdTFn0fRvjmnJujiG2X33x4017V+t
         XiIgSC4pFivc3IZ22VjuMV7uwkGbBzy1XrOX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034791; x=1741639591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8giJnezX3CtMdKV60CgQxT4SKIJQ9hhEThxu7GG34A=;
        b=lCGCJBeXVeArPJkqQlD4ZUHXljfVVxWpof+BX/q6on9TsOZ/uX7zj4bI2qEQMamcID
         g9NcR0D9zkyoqFFzrrsr49bgk3sWOmdVk6AWGhLSSE3LHJ/+24kCZqrEFPQCMnOfUWYi
         Fn/so8hOZ+iDSc2DYun/Wl+lxZVPZ1civ0LaRnaFdjXR6Vdwtgmb2uTJQpANfBwSPvEk
         H2rTKRwVeoA5U9d/wd+T6EFFMYSb9f/OYUYLdjhZ3smMfHzAJ1y6gOf2l4RgRAGPn7/V
         oBKdLe/Bz36q33sSmi5DNtYHCDxsrlXLAj9zs6jeEINs/i5xjueWF6MRFoHQCeFnMsPz
         K0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeUzW2C9s74OOhM0D65dLHA/wNou2491ahd5Xomc5fBRPQ1O1tfyKD5D06FiMknj0l1QFAMpCkGzDbbibd@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/rRX1KeUv6bMWLK3854AmXFimCNcPQmGgr6HKCeLUS0F9E/Q
	oOnb+mHvBub+gYZHVB+tQ33xVYiuwcgyoQxt41BA/AjaaksV/lV2La0b99tKx74A7i0CE8lgfgn
	Ta/g=
X-Gm-Gg: ASbGncuoPYSZIDSOnPcZGJQgrhf92Gs9FYlgbwygxq4z8mweyfrvCd3O9UV25FM3NcA
	Dt0zxFnNeD2MVQtRLcgp/ZpAwqyqgyMPxiBIIWsFrow9bnHjqkDyVarmqiQ573MxtzQQOlOda/S
	KDcEdY5AlqeeHLCWgQS5Cj2Qt5DI6WUxAqeaEJTjxsgjYE52vzt9Nb1xh+gPk4mR7EimHn98wsg
	xfMijT7WgHw/e6LgQ3tb9ISO4RVep7FCXTRCfRvUHRkKb5mmEzXhV9pXAJBAVy0MQRrnDxaa16+
	ZdH331koPsCHwRmp+s+1wwgOaliiVdIbvzdYzaaicbk+8cqWy3gXp/yhESNUHsHHLGQ1GM88DJT
	MyzxaoNuFqlIwp9g23ts=
X-Google-Smtp-Source: AGHT+IEKCIB5hYalWFaZ6FGXcIlyuKISDgRoUCkCpF9VWJpjH/E0If47FwiW3tXLdXxj/Hsg4QRq8A==
X-Received: by 2002:a17:907:6ea6:b0:abf:6e88:3a65 with SMTP id a640c23a62f3a-abf6e883e60mr638981966b.19.1741034791002;
        Mon, 03 Mar 2025 12:46:31 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1daea1cd2sm157440866b.181.2025.03.03.12.46.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 12:46:27 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so7948023a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 12:46:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJrot7TPmLfEHJ+3xt8Yccfx5LNFIsfc71Km5WsqfrnbY0TDfjx71rOPBi9NNZiRszqB36AQIzEMDnGdsV@vger.kernel.org
X-Received: by 2002:a17:907:3fa9:b0:ac1:eec4:91f7 with SMTP id
 a640c23a62f3a-ac1eec4925fmr117255866b.27.1741034787283; Mon, 03 Mar 2025
 12:46:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com> <20250303202735.GD9870@redhat.com>
In-Reply-To: <20250303202735.GD9870@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 10:46:10 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
X-Gm-Features: AQ5f1JqBdfS3OsjWtvaQ1iJbyRmzh1AYJAvBekLXzynzy8xNvLqN0Ww6oCUKFIc
Message-ID: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: multipart/mixed; boundary="0000000000000a0263062f764049"

--0000000000000a0263062f764049
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 10:28, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Stupid question... but do we really need to change the code which update
> tail/head if we pack them into a single word?

No. It's only the READ_ONCE() parts that need changing.

See this suggested patch, which does something very similar to what
you were thinking of.

ENTIRELY UNTESTED, but it seems to generate ok code. It might even
generate better code than what we have now.

               Linus

--0000000000000a0263062f764049
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m7tj52z80>
X-Attachment-Id: f_m7tj52z80

IGZzL3BpcGUuYyAgICAgICAgICAgICAgICAgfCAxOSArKysrKysrKy0tLS0tLS0tLS0tCiBpbmNs
dWRlL2xpbnV4L3BpcGVfZnNfaS5oIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2ZzL3BpcGUuYyBiL2ZzL3BpcGUuYwppbmRleCBjZTFhZjc1OTI3
ODAuLjk3Y2M3MDU3MjYwNiAxMDA2NDQKLS0tIGEvZnMvcGlwZS5jCisrKyBiL2ZzL3BpcGUuYwpA
QCAtMjEwLDExICsyMTAsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwaXBlX2J1Zl9vcGVyYXRp
b25zIGFub25fcGlwZV9idWZfb3BzID0gewogLyogRG9uZSB3aGlsZSB3YWl0aW5nIHdpdGhvdXQg
aG9sZGluZyB0aGUgcGlwZSBsb2NrIC0gdGh1cyB0aGUgUkVBRF9PTkNFKCkgKi8KIHN0YXRpYyBp
bmxpbmUgYm9vbCBwaXBlX3JlYWRhYmxlKGNvbnN0IHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBp
cGUpCiB7Ci0JdW5zaWduZWQgaW50IGhlYWQgPSBSRUFEX09OQ0UocGlwZS0+aGVhZCk7Ci0JdW5z
aWduZWQgaW50IHRhaWwgPSBSRUFEX09OQ0UocGlwZS0+dGFpbCk7CisJdW5pb24gcGlwZV9pbmRl
eCBpZHggPSB7IFJFQURfT05DRShwaXBlLT5oZWFkX3RhaWwpIH07CiAJdW5zaWduZWQgaW50IHdy
aXRlcnMgPSBSRUFEX09OQ0UocGlwZS0+d3JpdGVycyk7CiAKLQlyZXR1cm4gIXBpcGVfZW1wdHko
aGVhZCwgdGFpbCkgfHwgIXdyaXRlcnM7CisJcmV0dXJuICFwaXBlX2VtcHR5KGlkeC5oZWFkLCBp
ZHgudGFpbCkgfHwgIXdyaXRlcnM7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHBp
cGVfdXBkYXRlX3RhaWwoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwKQEAgLTQxNywxMSAr
NDE2LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGlzX3BhY2tldGl6ZWQoc3RydWN0IGZpbGUgKmZp
bGUpCiAvKiBEb25lIHdoaWxlIHdhaXRpbmcgd2l0aG91dCBob2xkaW5nIHRoZSBwaXBlIGxvY2sg
LSB0aHVzIHRoZSBSRUFEX09OQ0UoKSAqLwogc3RhdGljIGlubGluZSBib29sIHBpcGVfd3JpdGFi
bGUoY29uc3Qgc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSkKIHsKLQl1bnNpZ25lZCBpbnQg
aGVhZCA9IFJFQURfT05DRShwaXBlLT5oZWFkKTsKLQl1bnNpZ25lZCBpbnQgdGFpbCA9IFJFQURf
T05DRShwaXBlLT50YWlsKTsKKwl1bmlvbiBwaXBlX2luZGV4IGlkeCA9IHsgUkVBRF9PTkNFKHBp
cGUtPmhlYWRfdGFpbCkgfTsKIAl1bnNpZ25lZCBpbnQgbWF4X3VzYWdlID0gUkVBRF9PTkNFKHBp
cGUtPm1heF91c2FnZSk7CiAKLQlyZXR1cm4gIXBpcGVfZnVsbChoZWFkLCB0YWlsLCBtYXhfdXNh
Z2UpIHx8CisJcmV0dXJuICFwaXBlX2Z1bGwoaWR4LmhlYWQsIGlkeC50YWlsLCBtYXhfdXNhZ2Up
IHx8CiAJCSFSRUFEX09OQ0UocGlwZS0+cmVhZGVycyk7CiB9CiAKQEAgLTY1OSw3ICs2NTcsNyBA
QCBwaXBlX3BvbGwoc3RydWN0IGZpbGUgKmZpbHAsIHBvbGxfdGFibGUgKndhaXQpCiB7CiAJX19w
b2xsX3QgbWFzazsKIAlzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlID0gZmlscC0+cHJpdmF0
ZV9kYXRhOwotCXVuc2lnbmVkIGludCBoZWFkLCB0YWlsOworCXVuaW9uIHBpcGVfaW5kZXggaWR4
OwogCiAJLyogRXBvbGwgaGFzIHNvbWUgaGlzdG9yaWNhbCBuYXN0eSBzZW1hbnRpY3MsIHRoaXMg
ZW5hYmxlcyB0aGVtICovCiAJV1JJVEVfT05DRShwaXBlLT5wb2xsX3VzYWdlLCB0cnVlKTsKQEAg
LTY4MCwxOSArNjc4LDE4IEBAIHBpcGVfcG9sbChzdHJ1Y3QgZmlsZSAqZmlscCwgcG9sbF90YWJs
ZSAqd2FpdCkKIAkgKiBpZiBzb21ldGhpbmcgY2hhbmdlcyBhbmQgeW91IGdvdCBpdCB3cm9uZywg
dGhlIHBvbGwKIAkgKiB0YWJsZSBlbnRyeSB3aWxsIHdha2UgeW91IHVwIGFuZCBmaXggaXQuCiAJ
ICovCi0JaGVhZCA9IFJFQURfT05DRShwaXBlLT5oZWFkKTsKLQl0YWlsID0gUkVBRF9PTkNFKHBp
cGUtPnRhaWwpOworCWlkeC5oZWFkX3RhaWwgPSBSRUFEX09OQ0UocGlwZS0+aGVhZF90YWlsKTsK
IAogCW1hc2sgPSAwOwogCWlmIChmaWxwLT5mX21vZGUgJiBGTU9ERV9SRUFEKSB7Ci0JCWlmICgh
cGlwZV9lbXB0eShoZWFkLCB0YWlsKSkKKwkJaWYgKCFwaXBlX2VtcHR5KGlkeC5oZWFkLCBpZHgu
dGFpbCkpCiAJCQltYXNrIHw9IEVQT0xMSU4gfCBFUE9MTFJETk9STTsKIAkJaWYgKCFwaXBlLT53
cml0ZXJzICYmIGZpbHAtPmZfcGlwZSAhPSBwaXBlLT53X2NvdW50ZXIpCiAJCQltYXNrIHw9IEVQ
T0xMSFVQOwogCX0KIAogCWlmIChmaWxwLT5mX21vZGUgJiBGTU9ERV9XUklURSkgewotCQlpZiAo
IXBpcGVfZnVsbChoZWFkLCB0YWlsLCBwaXBlLT5tYXhfdXNhZ2UpKQorCQlpZiAoIXBpcGVfZnVs
bChpZHguaGVhZCwgaWR4LnRhaWwsIHBpcGUtPm1heF91c2FnZSkpCiAJCQltYXNrIHw9IEVQT0xM
T1VUIHwgRVBPTExXUk5PUk07CiAJCS8qCiAJCSAqIE1vc3QgVW5pY2VzIGRvIG5vdCBzZXQgRVBP
TExFUlIgZm9yIEZJRk9zIGJ1dCBvbiBMaW51eCB0aGV5CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3BpcGVfZnNfaS5oIGIvaW5jbHVkZS9saW51eC9waXBlX2ZzX2kuaAppbmRleCA4ZmYyM2Jm
NWE4MTkuLmIxYTNiOTlmOWZmOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9waXBlX2ZzX2ku
aAorKysgYi9pbmNsdWRlL2xpbnV4L3BpcGVfZnNfaS5oCkBAIC0zMSw2ICszMSwzMyBAQCBzdHJ1
Y3QgcGlwZV9idWZmZXIgewogCXVuc2lnbmVkIGxvbmcgcHJpdmF0ZTsKIH07CiAKKy8qCisgKiBS
ZWFsbHkgb25seSBhbHBoYSBuZWVkcyAzMi1iaXQgZmllbGRzLCBidXQKKyAqIG1pZ2h0IGFzIHdl
bGwgZG8gaXQgZm9yIDY0LWJpdCBhcmNoaXRlY3R1cmVzCisgKiBzaW5jZSB0aGF0J3Mgd2hhdCB3
ZSd2ZSBoaXN0b3JpY2FsbHkgZG9uZSwKKyAqIGFuZCBpdCBtYWtlcyAnaGVhZF90YWlsJyBhbHdh
eXMgYmUgYSBzaW1wbGUKKyAqICd1bnNpZ25lZCBsb25nJy4KKyAqLworI2lmZGVmIENPTkZJR182
NEJJVAorICB0eXBlZGVmIHVuc2lnbmVkIGludCBwaXBlX2luZGV4X3Q7CisjZWxzZQorICB0eXBl
ZGVmIHVuc2lnbmVkIHNob3J0IHBpcGVfaW5kZXhfdDsKKyNlbmRpZgorCisvKgorICogV2UgaGF2
ZSB0byBkZWNsYXJlIHRoaXMgb3V0c2lkZSAnc3RydWN0IHBpcGVfaW5vZGVfaW5mbycsCisgKiBi
dXQgdGhlbiB3ZSBjYW4ndCB1c2UgJ3VuaW9uIHBpcGVfaW5kZXgnIGZvciBhbiBhbm9ueW1vdXMK
KyAqIHVuaW9uLCBzbyB3ZSBlbmQgdXAgaGF2aW5nIHRvIGR1cGxpY2F0ZSB0aGlzIGRlY2xhcmF0
aW9uCisgKiBiZWxvdy4gQW5ub3lpbmcuCisgKi8KK3VuaW9uIHBpcGVfaW5kZXggeworCXVuc2ln
bmVkIGxvbmcgaGVhZF90YWlsOworCXN0cnVjdCB7CisJCXBpcGVfaW5kZXhfdCBoZWFkOworCQlw
aXBlX2luZGV4X3QgdGFpbDsKKwl9OworfTsKKwogLyoqCiAgKglzdHJ1Y3QgcGlwZV9pbm9kZV9p
bmZvIC0gYSBsaW51eCBrZXJuZWwgcGlwZQogICoJQG11dGV4OiBtdXRleCBwcm90ZWN0aW5nIHRo
ZSB3aG9sZSB0aGluZwpAQCAtNTgsOCArODUsMTYgQEAgc3RydWN0IHBpcGVfYnVmZmVyIHsKIHN0
cnVjdCBwaXBlX2lub2RlX2luZm8gewogCXN0cnVjdCBtdXRleCBtdXRleDsKIAl3YWl0X3F1ZXVl
X2hlYWRfdCByZF93YWl0LCB3cl93YWl0OwotCXVuc2lnbmVkIGludCBoZWFkOwotCXVuc2lnbmVk
IGludCB0YWlsOworCisJLyogVGhpcyBoYXMgdG8gbWF0Y2ggdGhlICd1bmlvbiBwaXBlX2luZGV4
JyBhYm92ZSAqLworCXVuaW9uIHsKKwkJdW5zaWduZWQgbG9uZyBoZWFkX3RhaWw7CisJCXN0cnVj
dCB7CisJCQlwaXBlX2luZGV4X3QgaGVhZDsKKwkJCXBpcGVfaW5kZXhfdCB0YWlsOworCQl9Owor
CX07CisKIAl1bnNpZ25lZCBpbnQgbWF4X3VzYWdlOwogCXVuc2lnbmVkIGludCByaW5nX3NpemU7
CiAJdW5zaWduZWQgaW50IG5yX2FjY291bnRlZDsK
--0000000000000a0263062f764049--

