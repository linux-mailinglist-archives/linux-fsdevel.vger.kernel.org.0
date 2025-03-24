Return-Path: <linux-fsdevel+bounces-44870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD5A6DD4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905F13A95C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FC26136B;
	Mon, 24 Mar 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqsnhrgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D873B7A8;
	Mon, 24 Mar 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827548; cv=none; b=iE3GQCVIG2CyVKlQtdvSvWLO6Ei/fStB35NNIWsjEJyvYbh4psSyqLOR4OFvQZtcOhYujchxY7x99RQzCD4/zHqQyP5KpyYk7YnZl5MTzMfT0glK9+gXZqaZnMyPnNMRWBJn5RKK8LUpQfXm9xhw8JIjKPKTMMF5x7fQ6sHMPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827548; c=relaxed/simple;
	bh=rMIDekdgu7k+w3o8KxlJ2MhnfGm0bZTtGCdWxSGqOTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRZUJX8zMbB/SjA0/wKgs4if3PsNITNkIyoOrkh74UlGErgefFPnLfoJg+5QpLzes9viWYL9wrggFShLdzTn9MBZFn8cRHQkcpSZnxUIOFccMey60GfW3FK7Mwo0wQx40FxqvUlmT3JsdU8nkpcBikw3czNCq9YG+cxh6s51GXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqsnhrgl; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307bc125e2eso46848411fa.3;
        Mon, 24 Mar 2025 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742827545; x=1743432345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YySDT6NdhdJKGPUFeJR1/DEX+p2cFBnIzeE/4PTN8fk=;
        b=dqsnhrglCaGX/uQGUWAs2NrspxZWhpEIMJKBkXMjuX7CcvEG88R3HNlcUCQCYWnddc
         yKAHsQmap+AvbuOkGXZeuoESmz8KUEH8oSrW4Un4U/ZwcVS1Qntf3+XEFSQ4LFtJlwdr
         ppCD/OdDoICYgEsgmwyv2EkbAwTpE9spSJp3hn4H37pLCRh540ksOfUI+9IwXVCZ1MsA
         26EPlXdxufdH8wm+8/3ECtXW8txc/R86VS/X8AkQButqBosQXcT1gvNJhPf6x9ncOP/0
         TSO1mYpOMIJ22K9/HvhQYoScJP73M8N9ag75LGWQG6DCHz0CVGeElA+enRsLKIqFvrfo
         w5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827545; x=1743432345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YySDT6NdhdJKGPUFeJR1/DEX+p2cFBnIzeE/4PTN8fk=;
        b=nij6Jsr6VxniPHQcm2OeiWOEmOuCeVfSUcPhqoa2Z3lWCQhJ/kXIXzpyWIG3bTZZjN
         FZ0CGKREwGjEqyyVnjTZqlfLBgylCQAdDgd9qkLgyKOQ9WCCdLvSP/+DdYouiWj3EOxT
         bxPbERIiIQ6knAqZSq0uv26PbyUx8nP9vvRW78aqyw+Tnpw7S9Mm2C/ew8FVELrUW1My
         MZZyK1Ju16S7Mhmz8jCoHqJaLwA3Zrvk9YZSwLkoua6SsGMqLguvXagUnAxSWe89xrF5
         nGSvmcster7FzwphxVZfrhIhkjiBIP2mNPaqpZl9D+x1uZuzqcNFMPT24/CNUfjCzhCF
         /V7A==
X-Forwarded-Encrypted: i=1; AJvYcCUNnVWCgWNYCgzInCbau1rI60wDXI5B6ofP4C32aRKkl+PjP9dhEYy0GiPDE8Ftvmuqw7qcEi4zEOYbPCmG@vger.kernel.org, AJvYcCUtSPl2lQsl8793sJ6AR35wafMXLqbL/T973/jTBYoTjaPlb5wPRfpFLkcK4uFfQqO0YC8ZDhwcuLXSCdC0@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgXCOL2x3vVbgMkhv/VRj3/zfbGMJFeizukiRSyw4LKEw6/Z/
	EELZaYRcbDZQcLDmjVH6v8C90dLi4QaBoD+A5X+Pk2QJXhtUI34f5/pRhBKfh/+mWHiE6LrnwG1
	sBKcvvJhJDXYmMjCmom7+jmtSxAksTUtPD80=
X-Gm-Gg: ASbGncuCgBz595JXbEdfXfbucXV+Lqr2LYPN0PpSmKxJVB0rL4Ao+vMLApfjC3KoNr1
	G+bdBEbrpb2a8hMmJRCpGDy/vXacskoCLrPqnf/1h9lLpqRfEFW6IAnxdRRB054KRs9XBgjM9EG
	wu2WbNgo/OA+BsFgtvPokknO6eUZQvlXgIFa/IwPExX7gdCzDS4heB
X-Google-Smtp-Source: AGHT+IHl9dwplhezNLn7IB7Sq3eiZyr65Hj6aswx7up7md4DBgKJttJkhnAhxsOY6v3v1JjbW7Pfci2rEpaF23aoXNM=
X-Received: by 2002:a2e:b8c8:0:b0:308:eb34:103a with SMTP id
 38308e7fff4ca-30d7e2a722cmr57009151fa.28.1742827544473; Mon, 24 Mar 2025
 07:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com> <Z98oChgU7Z9wyTw1@casper.infradead.org>
In-Reply-To: <Z98oChgU7Z9wyTw1@casper.infradead.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 10:45:07 -0400
X-Gm-Features: AQ5f1JrW68Vn_B0jmPyAT5zcOLPzNVAsAnicIcYueNfueTreXg8ST6v187cy9-0
Message-ID: <CAJ-ks9kZ-745x2_U00xwwG6nsJbcd=Fg-n8-X6oS+z=CsGy5VA@mail.gmail.com>
Subject: Re: [PATCH] XArray: revert (unintentional?) behavior change
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 5:13=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Mar 21, 2025 at 10:17:08PM -0400, Tamir Duberstein wrote:
> > Partially revert commit 6684aba0780d ("XArray: Add extra debugging chec=
k
> > to xas_lock and friends"), fixing test failures in check_xa_alloc.
> >
> > Fixes: 6684aba0780d ("XArray: Add extra debugging check to xas_lock and=
 friends")
>
> This doesn't fix anything.  The first failure is:
>
> #6  0x0000555555649979 in XAS_INVALID (xas=3Dxas@entry=3D0x7ffff4a003a0)
>     at ../shared/linux/../../../../include/linux/xarray.h:1434
> #7  0x000055555564f545 in check_xas_retry (xa=3Dxa@entry=3D0x55555591ba00=
 <array>)
> --Type <RET> for more, q to quit, c to continue without paging--
>     at ../../../lib/test_xarray.c:131
> #8  0x0000555555663869 in xarray_checks () at ../../../lib/test_xarray.c:=
2221
> #9  0x00005555556639ab in xarray_tests () at xarray.c:15

That's not what I see when I boot a kernel with CONFIG_TEST_XARRAY=3Dy.

> That has nothing to do with xa_destroy().  What on earth are you doing?

I'm running the kernel in a VM on arm64. What are you doing?

> Anyway, I'm at LSFMM and it'a Saturday.  I shan't be looking at this
> until the 27th.  There's clearly no urgency since you're the first one
> to notice in six months.

Sure. I misunderstood the purpose of linux-next, thinking that if a
commit is in there then it will soon head to mainline. I realize now
this isn't the case.

