Return-Path: <linux-fsdevel+bounces-66513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34FC21B3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2608189AE0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254713655E4;
	Thu, 30 Oct 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LIzRLqGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940E2868B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847661; cv=none; b=uF+EHuMMI+uMDFOKR5MoRXiIil6JqTTXFD1E+Yyn1dNoMDgKc+f3CucsV4rDZFwsNAvwv36qiQmTHKHfvtWp1XaorQmGoN62dfxdD0ps8FKu3FCkmS0IAvGboBoEknIDvg8gY9C8hNxto6CLH1DX0hZ3gz7++xFiVE5KyC6ME+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847661; c=relaxed/simple;
	bh=o4D+KJz5KmTGP3qABZ5U9YBAhg1ZAif2VFV1CQtEzVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8cvKAEi8uFzQe3HzkjiB6rv8lIxhPsjhKRUap7s5ECH0iAcZXXB0Tih08h5AfRA1d1f8NI7cId8lY8nsSGJatbbKmXN0a0QESuAcuZGC74Z7zbSel17nFHG3UJ/LpOOJL98/jskXflx/WOs6KrfhzzqZOHg22gnn9VgXgXZX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LIzRLqGa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d53684cfdso282707066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761847657; x=1762452457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhvcl1yeQC/w6b6iGe+L6hfO/fybpVFfvYB2unB5MhM=;
        b=LIzRLqGaNG4zAAAcS4KrBoDs5Utr7Ugdgew11DAEloJmLIvfnDpMX/WmzmT+q9tBwR
         kYjcTwPXUyj8H9X6H5W5v+Dllxdxbi3jCUKrVMf9FPUIe+AxGvFxUav3Q4oOVGBvYSWQ
         YLxRRPLXMdF0ilZocaV+7SYp2hoCtEnrnqsQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847657; x=1762452457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nhvcl1yeQC/w6b6iGe+L6hfO/fybpVFfvYB2unB5MhM=;
        b=TmqqF39/2o2QQA3yf2vlX4yscQHjsShWrFVcnHlhQBrFCSaH1shsgcPiH6qMq9EcJE
         NTarevrAmXDXyn1OVbfaXgIcknJ/3kYUQeUARXkyvQp12mWFOPP+D/K9hvb9ZcPKVb6D
         ryD0PW311Pwe6x6M/ywMs3ZytfQiEOiOAsphrM1XpZGtsLzo2kpUdii1AmyBtgRR++g5
         Bh5eG1sJgRWKJ70D8Laq3YDrK14Dpc6WeQSeGk48YHSaqSuFfM/SWy2VvbdXg/Wep6/q
         gE3hZWonF49c9E0P/kz4wfEuC2PfPIrCDKkL0mUdu3+7jaKbdmxvez3BXXJAG4IwCdJT
         T/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtVmCIs2q8Yg8T+qEMImx014rSOGLC0050fVf9t9fhD5S8m+m9EXfyv6aVJlPtjPmt4gXfjHnYDRwUYKMp@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuEQLwCGtUOqUQf5dWZUsNoBUTom/ppGO/DRiDEOclPErLlDW
	wbPNQBHRHftUlH6b+tLKj5eN/2kZBXV1LrcBr0mN7NPU694lJl+ouRzOM/7Kpt8vqzuMVG/EVMG
	vqxn76HQ=
X-Gm-Gg: ASbGnctCG1aNX8jkR5xuQk0Nq2u9aLp/wxSx94GhEUO6GEbWkGnpgDJpNZMPdBKLF6s
	2MC8OglnWmRhPcH32LQmGco8L4huw2h4nB2+esVYHcZrajixmT5zqAmKWml4+kH+X6xnV5z6xs0
	2ofsgJAjuYtIGfmkp55Yshd2xmpxHNZAO4t7B9pLhV8zz4E4a8Aso+lzvSq+hRkGhxy8oW4/lOS
	Au0U1qTjYcm5OxR/A0IasTln8att5+CrIx64I57NreDNvb2125yT/sIJ2Mx7bSW9n6BYy/5grSX
	E3y8Uo8YmTvROeqUt4ad0dHOqp+8eKyLnapMWDEAy/n4QT6xqIXIzOWplJHfa4dLb0gKkQl2BI2
	mpl0SwXAWVXIPTeslpJM4aDXTAtqOqC6rqpoYvSHnD5vZb5xdO+DNroBL7EIxjcWl8TvePtQG0j
	zX8zphijgX8NjvyCbVyUuIpL8lBSVxNJm0r5Qhp5sWjBwUH0slhm/kSfaDo/X+2jssF3KgPuA=
X-Google-Smtp-Source: AGHT+IEgkRcJnV8p7TYfgGWJQUSQ+PZXqUejurPZXHq3+MpH+IdP3xyVnkhgWSmv1dgQWKFNNj7DsQ==
X-Received: by 2002:a17:907:5ce:b0:b6d:5c4e:b0b8 with SMTP id a640c23a62f3a-b70700ad41dmr46698766b.8.1761847656666;
        Thu, 30 Oct 2025 11:07:36 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b706703dccasm135367066b.2.2025.10.30.11.07.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 11:07:35 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4f323cf89bso315032866b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 11:07:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlGaPljCkVRopcoaafoJ0JoUyU2B+UKtN0cX4hNfcQln6/TtqnpDlrww7kLtLO3Iox8tcHdFAgcMLSnuNB@vger.kernel.org
X-Received: by 2002:a17:907:26c3:b0:b30:c9d5:3adc with SMTP id
 a640c23a62f3a-b7070627703mr42634166b.49.1761847654683; Thu, 30 Oct 2025
 11:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
In-Reply-To: <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Oct 2025 11:07:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
X-Gm-Features: AWmQ_bk0nXdmIZ3ZdZHzO6SbRe1SK66BYaV56nliMUq6zTKWnVQoJraIlMoRIYg
Message-ID: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: multipart/mixed; boundary="0000000000009b66050642641f04"

--0000000000009b66050642641f04
Content-Type: text/plain; charset="UTF-8"

[ Adding Thomas, because he's been working on our x86 uaccess code,
and I actually think we get this all wrong for access_ok() etc ]

On Thu, 30 Oct 2025 at 09:35, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I don't know if you are suggesting to make the entire thing fail to
> compile if included for a module, or to transparently convert
> runtime-optimized access into plain access.
>
> I presume the former.

I think *including* it should be ok, because we have things like
<asm/uaccess.h> - or your addition to <linux/fs.h> - that use it for
core functionality that is then not supported for module use.

Yeah, in a perfect world we'd have those things only in "internal"
headers and people couldn't include them even by mistake, but that
ends up being a pain.

So I don't think your

+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif

model works, because I think it might be too painful to fix (but hey,
maybe I'm wrong).

I was thinking more along the lines of forcing linker errors or
something like that.

ENTIRELY UNTESTED PATCH attached - may not compile at all, but
something like this *might* work to show when a module uses the
runtime_const infrastructure.

And I think I should have made the default runtime const value
something small. But the original use of this was just the dcache
code, and that used it purely as a pointer, so a non-fixed-up address
would cause a nice clean oops. Then I started using it for the user
access limit, and now it's actually wrong if used by modules.

Thanks for making me think about this. I thought about the module case
*originally*, but then with some of the expanded use I definitely did
not.

               Linus

--0000000000009b66050642641f04
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mhdqhvpo0>
X-Attachment-Id: f_mhdqhvpo0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaCB8IDEzICsrKysrKysrKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcnVudGltZS1jb25zdC5oCmluZGV4IDhkOTgzY2ZkMDZlYS4uMDFlMzU5OTc1ODdk
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9ydW50aW1lLWNvbnN0LmgKKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oCkBAIC0yLDcgKzIsMTggQEAKICNp
Zm5kZWYgX0FTTV9SVU5USU1FX0NPTlNUX0gKICNkZWZpbmUgX0FTTV9SVU5USU1FX0NPTlNUX0gK
IAotI2lmZGVmIF9fQVNTRU1CTFlfXworI2lmZGVmIE1PRFVMRQorCisvKgorICogTm9uZSBvZiB0
aGlzIGlzIGF2YWlsYWJsZSB0byBtb2R1bGVzLCBzbyB3ZSBmb3JjZSBsaW5rIGVycm9ycworICog
aWYgcGVvcGxlIHRyeSB0byB1c2UgaXQKKyAqLworZXh0ZXJuIHVuc2lnbmVkIGxvbmcgbm9fcnVu
dGltZV9jb25zdDsKKyNkZWZpbmUgcnVudGltZV9jb25zdF9wdHIoc3ltKSAoKHR5cGVvZihzeW0p
KW5vX3J1bnRpbWVfY29uc3QpCisjZGVmaW5lIHJ1bnRpbWVfY29uc3Rfc2hpZnRfcmlnaHRfMzIo
dmFsLCBzeW0pICgodTMyKW5vX3J1bnRpbWVfY29uc3QpCisjZGVmaW5lIHJ1bnRpbWVfY29uc3Rf
aW5pdCh0eXBlLHN5bSkgZG8geyBub19ydW50aW1lX2NvbnN0PTE7IH0gd2hpbGUgKDApCisKKyNl
bGlmIGRlZmluZWQoX19BU1NFTUJMWV9fKQogCiAubWFjcm8gUlVOVElNRV9DT05TVF9QVFIgc3lt
IHJlZwogCW1vdnEJJDB4MDEyMzQ1Njc4OWFiY2RlZiwgJVxyZWcK
--0000000000009b66050642641f04--

