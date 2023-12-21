Return-Path: <linux-fsdevel+bounces-6757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57DB81BDDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 19:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D4A28BBD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB86351E;
	Thu, 21 Dec 2023 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="URUiS+XL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770564A84
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a268836254aso131382266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703181711; x=1703786511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFhYgBQMy/5618m05/BdiCx0uBB+GH471mXeLigE3V4=;
        b=URUiS+XLaaHkLQ82PhqotDxkOK9NjXsNUJPZEbQyZ83OOe2l/MvYHOnulgSDgeDizQ
         rmlAGMRfEGyJ03D689WkndHPG37/2XgtMPq47kc6NmAIcjter8dsRupUKBGGk2/COqTd
         bQKVNr5L9NAYmWrTFglJ57H3olMGJzSPhBWec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181711; x=1703786511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFhYgBQMy/5618m05/BdiCx0uBB+GH471mXeLigE3V4=;
        b=XpyrZ1NWSTF6dqHD9qwMFJ582pVdGlBvBQRapgVnzzmGfVS41T/L1OGxrZPd5H/0OO
         qT8LE3k7jDl37demPQv2Sgg3whmzjahWV9D7QFEAVh+uOXjSYDgn5SEJgUr68zrULYED
         C2nBeeF0uKH7yzwnPbUa4KMXPw6iYdrnCzrD+Dr4OuiC58NMa+5je13gjoy/0weStgw5
         M4uGmNvAPrKW7J27yb08LFFj9r5ZduoOiTFu69cq8AxIVit+HSBF22gYz+sQiphjAvqw
         37h/zxIn23McHPm8hXERK18rb3jcvRtMTRstnMBeB4Se+ZuPclWyVSs6lPoB9PeEoIg3
         oikg==
X-Gm-Message-State: AOJu0YzsUzIMNIHOaBBlFZgS3lqBMBWP+f0rd8I1TRYreIuDC6rPUl3g
	Nke55j86Keij9QAvdRgb0hdlxEJVAP66LnIh/ZiwNa3dfd4NXa9Z
X-Google-Smtp-Source: AGHT+IGEck7xOjOx9jEkAR4HEM6sSol9cwkhFWp0HeA2jBXD5Zw3OTHDlCC1BPzI9540bkK8dM4miw==
X-Received: by 2002:a17:906:51c8:b0:a23:660:ec5c with SMTP id v8-20020a17090651c800b00a230660ec5cmr102932ejk.40.1703181711731;
        Thu, 21 Dec 2023 10:01:51 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709064ad100b00a268b2ed7a9sm1182761ejt.184.2023.12.21.10.01.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:01:51 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5542ac8b982so847916a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 10:01:50 -0800 (PST)
X-Received: by 2002:a17:906:748b:b0:a23:52d2:44c8 with SMTP id
 e11-20020a170906748b00b00a2352d244c8mr97647ejl.37.1703181710093; Thu, 21 Dec
 2023 10:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1842328.1703171371@warthog.procyon.org.uk>
In-Reply-To: <1842328.1703171371@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Dec 2023 10:01:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJtcyi=oRf7Rtf2RueWq_336KEsSf9b-BKPxRcHHQx+Q@mail.gmail.com>
Message-ID: <CAHk-=wjJtcyi=oRf7Rtf2RueWq_336KEsSf9b-BKPxRcHHQx+Q@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix overwriting of result of DNS query
To: David Howells <dhowells@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 07:09, David Howells <dhowells@redhat.com> wrote:
>
> Could you apply this fix, please?

Ok, so this is just *annoying*.

Why did you send me this as a patch, and then *twenty minutes* later
you send me an AFS pull request that does *not* include this patch?

WTF?

I've applied this, but I'm really annoyed, because it really feels
like you went out of your way to just generate unnecessary noise and
pointless workflow churn.

It's not even like the pull request contained anything different. The
patch _and_ the pull request were both not just about AFS, but about
DNS issues in AFS.

Get your act together.

                    Linus

