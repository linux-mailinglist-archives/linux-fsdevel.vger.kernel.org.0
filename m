Return-Path: <linux-fsdevel+bounces-7489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF78825BF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51C71F23A17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E121A15;
	Fri,  5 Jan 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dX0o205j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF621A0D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so13069566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704487576; x=1705092376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=dX0o205jUNd1IonIZDf8AdRd8RejmwYO/tlDBLBeePCX2Z9hKK8bm/mc9y9U+P3osb
         IMj8eEiH40f+THYm2ure6bJ1DvTsgAOO1VEc66I1IfIJ94mMktEzJBDt1d85VjpHOqN8
         TXjHmlW5BFIGFfX6GvOQh7XUY4MguC22tEMkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704487576; x=1705092376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=gqdbjTEkP7BfsbbqX3EbTbm2ju2FLcCvWKHQYx3w9aJ/Q2opIMTEPVEfXKbLfwBc3G
         EsRSp9RUwtrL7eB072fD4YJv+CYwbH+F1NCzVVus9Y7TOw98H7deku3ReleW6Z0GBNLY
         ff2/kp8lYdNXCOuV3X0GBIrowoVoxBn4noesjdn7Iv4h7nK90spjaOYo7ZwIueqvlmgc
         mkQ7EfwSxtkLBoXUgDE39k+HuqDqBuKYMUVo+zRbhyiT4eBXSGCGH7ai3Kc535gGfzaF
         0/kzGx38e+5/fjUIntulLDi4hrRFF9ZwhvLlDcVthmY+SWD6OtVcIEpjo+Chck6SO+3I
         03aQ==
X-Gm-Message-State: AOJu0YxSFtuXSYLHkZgdRp8hkywTwCFi8DLMUuSdEh0tw8m3Uptb6+r4
	tMmWVlrNOzaOvhnR/URAFAuhdM/MP07VeJxxB7I54jzHraPk915e
X-Google-Smtp-Source: AGHT+IFRIzmaZzZcd378mROU+9BajNPw/oci2FmfivPyToJv7ioVTmjPR3mDCQuEjjrAimLcY8Lriw==
X-Received: by 2002:a17:906:3c5a:b0:a28:de1f:e679 with SMTP id i26-20020a1709063c5a00b00a28de1fe679mr1512775ejg.76.1704487576055;
        Fri, 05 Jan 2024 12:46:16 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id gw18-20020a170906f15200b00a28c466974dsm1252221ejb.178.2024.01.05.12.46.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:46:14 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28e6392281so221063066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 12:46:14 -0800 (PST)
X-Received: by 2002:a17:906:74c1:b0:a28:fab0:9004 with SMTP id
 z1-20020a17090674c100b00a28fab09004mr943524ejl.86.1704487574561; Fri, 05 Jan
 2024 12:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com> <ZZhncYtRDp/pI+Aa@casper.infradead.org>
In-Reply-To: <ZZhncYtRDp/pI+Aa@casper.infradead.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:45:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 12:32, Matthew Wilcox <willy@infradead.org> wrote:
>
> I can't tell from the description whether there are going to be a lot of
> these.  If there are, it might make sense to create a slab cache for
> them rather than get them from the general-purpose kmalloc caches.

I suspect it's a "count on the fingers of your hand" thing, and having
a slab cache would be more overhead than you'd ever win.

           Linus

