Return-Path: <linux-fsdevel+bounces-49464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A59ABCAB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBCE3BED00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731621C19B;
	Mon, 19 May 2025 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eLkO11PK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A921ADA9
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692505; cv=none; b=ZvoAO4/iMDKVih0FQpWVh8H+B2JgOzYjQTisbGVOuijOosAWZfPcB5mrQH2Vt3aTXu+Izia5/Vfhdx3zBC63jaRZi/SdpoH9xXjN8o9hOIOwRpaHzu5GV7j7ciYjDhAZi+z64eRCxdqn5eMO5O2nHWJXT6sjY8Q8H9cS2hANuC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692505; c=relaxed/simple;
	bh=epaQpYG08Cx6+UOhy4LLIjLj5KTAGbzjTgbArmpqq1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNXB8GqZ7cpzTVED+lCScuZw6BKwnhggUhjsVpkIHKwLUlY2ks07E/UHyDXNIr+l4+gLPY0m2vFduZ4fHC8FprdF/NzF6QOiRkXSFKTSpJs4YPcHLI6Z5qrSZAFw+aalFd4tHFZN/PEDZpmnuFvCo9RtyPLXuVR43aTXR/2k0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eLkO11PK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad53cd163d9so572707366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747692500; x=1748297300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HRyJsWclVSfCGnIwr3ogNAIWVRnv2az9Jx8KNeipeBo=;
        b=eLkO11PKOcJ1WO1advd8Qc3hEc286TDzgEs3YF7b73rS6DwKVdXz+FSnUjY0RXF32s
         LEcqYJx6vFczE8giXDUjl+CZ872aHua2uRZuFMKdfbCTUW4/zr9s4AZWggIwx8xPrEiO
         Ezi5SAyyu8zZqkXKDLg34wPDFwYWnAaHq61JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747692500; x=1748297300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRyJsWclVSfCGnIwr3ogNAIWVRnv2az9Jx8KNeipeBo=;
        b=Lsc1A1UBXCV9A102DxNDb0L+gyAWfDuUrsr4cEOlXOFQX35aubW5gt4uOSgNfpBay3
         QHX/5Hm7Kqp0L4CoDxZ2QIMX5+Gb1DdZCh4dIPD0k3EbPonba3Q5chqJ+r3lqkXNCm8e
         t5jxcZKLHcmK+zgiJf6e0WxbAlig4P2bGZhSXjHiqwuiXOuTLMXiANnofTcR1Ovz+RBr
         kWkbrMIL2w0TDaZI6f7cf/wgfq2njmffCPE3WEPS9k9/wNW1wJfpd9FqAoM4VJ5MlWZu
         MIY+Y9glJrDVWl4GQD6SR/fNAlFGzw5qGPhV/K5s2f1KxmYqLZE0iaDyuOcFjGuOKrZU
         MMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/vBRC5R1sslpkfO+UyHvwpzeuNYQphW7Kd08YZ/V1KeSlLgxzdUuxB/0X4PO4F/7mjufnr3zO6fx375Sk@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZoS3/0zH+uhCuPmajuahIFWqumjJUyW4ACZZzjWTR7Gh+nVn
	0zRdbNxvJQdcUoKrEWe3Klg4V5d/an7v46zH/Abs6lEvW9Yq5Znu4Mvc25jUjFJ1zj7mqwIlZf5
	EmZrHk/U=
X-Gm-Gg: ASbGncsxC9XVRqDa7EgTMv+AamVZnh/BRjflx+k5SMjUx8Dmp+GUmBBKhVt7SsTbSGx
	/+I9BcT9VsavXsVq/M86P0cIeKCCcCH5LNSAWilkWDWW+Q4XF+6wuRkBi/KcENRJnLihD+39bvJ
	qkqW2iW6zRq4TJK7zrZV7mDM0roq/qQ1GwAghugqn8giUQwXs4DLt5gbYxHN2gWMuIFvilUrVYT
	QbvnU4lyYhdqUCF1o0i1QYJXYCxL7uIImYgirlXdZPyBnNiMpto9VoD1CoeOPylvEBumWCsnr1b
	ZuYC61GbqWND0KylVL5D0Gi5bbZ8X8ACPgRCRWWm9PQ6RNBTfKiRmczLvL3ESRTpibv1sDbI1a4
	HIVVu0IZmQqm2cZbQyYDzdT6LoA==
X-Google-Smtp-Source: AGHT+IE5Eef53TbCP/7vXZnUwr4lwF+3IhhYGQQrCnyVdG/kMIKiFd2fhb2I2lc1ksokFTVPes/rFQ==
X-Received: by 2002:a17:907:6eaa:b0:ad1:8f1f:6961 with SMTP id a640c23a62f3a-ad52d575809mr1405379166b.43.1747692500224;
        Mon, 19 May 2025 15:08:20 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d490794sm646127766b.131.2025.05.19.15.08.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 15:08:19 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad53cd163d9so572705066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 15:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+cOAsdgaXFtZeD+8WxrcWcOrdXg9yBsh9aOoFjZi4i2sIih7rSyafMAXFs7NLsHPhV4u7SHLYXQ52nIsM@vger.kernel.org
X-Received: by 2002:a17:907:78a:b0:ad2:2eb5:fc03 with SMTP id
 a640c23a62f3a-ad52d5b7dddmr1332210366b.56.1747692499002; Mon, 19 May 2025
 15:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511232732.GC2023217@ZenIV> <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV> <20250515114150.GA3221059@ZenIV>
 <20250515114749.GB3221059@ZenIV> <20250516052139.GA4080802@ZenIV>
 <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com> <20250519213508.GA2023217@ZenIV>
In-Reply-To: <20250519213508.GA2023217@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 May 2025 15:08:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixv3XKa8hzsy=WQXaXcE4kDLbBkc3vQiW3eoRjStQ+uw@mail.gmail.com>
X-Gm-Features: AX0GCFv9qzFYgoXvg-a4KLx6ZT327xmcMAdD2E2w-yhUZQhnLnoWqQ41DVO3PTU
Message-ID: <CAHk-=wixv3XKa8hzsy=WQXaXcE4kDLbBkc3vQiW3eoRjStQ+uw@mail.gmail.com>
Subject: Re: [RFC][CFT][PATCH] Rewrite of propagate_umount() (was Re: [BUG]
 propagate_umount() breakage)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 14:35, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         What trim_one(A) does instead is
> * note that A itself needs to be removed
> * remove B and D

Yeah, I wondered, but it wasn't obvious from the flow that the same
list was getting changed...  But now that you point it out, it's
fairly obvious in trim_one -> trim_ancestors -> remove_candidate().

I did see the direct call to remove_candidate(), but that only
affected 'A' itself.

And I guess passing the list head around wouldn't have helped make
that flow more obvious, because the removal is through the list head,
it's just that list_del_init() on the list entry.

A comment may have helped, just because I found that list traversal
pattern so odd. But yes

>  [..]  Then the loop would turn into
>
>        while !empty(candidates)
>                trim_one(first candidate)

would have made me not think it's oddly written.

            Linus

