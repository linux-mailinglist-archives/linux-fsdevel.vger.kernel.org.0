Return-Path: <linux-fsdevel+bounces-3774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922A7F8120
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016971F20FC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E7339BE;
	Fri, 24 Nov 2023 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KaFhgw90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CB1BC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:52:21 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a03a9009572so309916566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700851939; x=1701456739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xNuT9aL+BwgSK0CDB2p5O/f4j3yWkDx7/avEVjUORwE=;
        b=KaFhgw901uMP/WZeK80owvvztEER7hkKZgU0AhxYKDuahHhtq1iKufu/KE3+0TXOxj
         O/8jURia+Rupe+wT5hXOHv4Prwj9wTkidoHIMqB4tEvZunX8YMoazv3JskUuhM8yquwI
         cazY6zYGvVbS7+xfAGTAiI5NSrPHOTIsuCkD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851939; x=1701456739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNuT9aL+BwgSK0CDB2p5O/f4j3yWkDx7/avEVjUORwE=;
        b=FzOLokHe8SjEmt3+rXgblL3vX57plcjNxg9dFXCh39clrjPzaM7gElwBbnzCwiTG8N
         tglofkNxCnWyhEUcBWE3OzFlKWcGdDzs6LSND5jH74/KdCbMDM9mDwBWQwkYxAIuDk7N
         68aAInymG0hhyuvaxq5dpP4bIuzJqdjc7py+EXk4H54vJtjn5Y/zF7iMEm6FLC7/lejk
         0gbIiD3pidxN8DXQ1JHI4034l+v3PdjgPeh0GicrJnrABAiXjznj7r9+EesDIxC18V3Y
         sH2SUJs0jigAFs3kRr4/tK9qbSXHM7KX4M60jsSK2ZoaiJ9wF/OH25luiya38WtAg764
         5ATA==
X-Gm-Message-State: AOJu0YzyguPaNxJLqASq8aKebC2NeOwRTvdxcfBmC6C+fqG8JaDAQoYk
	vI+gphImenQBa9n9svd18UCEXdfj/mO6Z8Ul+0rMgAF+
X-Google-Smtp-Source: AGHT+IFNhHzInNrgXK8gvbBVhnPxWb2qLpgli6qq8dLpQv5079DCyTifY9oQaDXYxRcA4lF39JbLKw==
X-Received: by 2002:a17:906:230a:b0:a02:38a2:4d79 with SMTP id l10-20020a170906230a00b00a0238a24d79mr3087911eja.41.1700851939284;
        Fri, 24 Nov 2023 10:52:19 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id gx26-20020a170906f1da00b009ad89697c86sm2407071ejb.144.2023.11.24.10.52.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:52:18 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a02d91ab199so312914266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:52:18 -0800 (PST)
X-Received: by 2002:a17:907:c18:b0:a02:9c3d:6de7 with SMTP id
 ga24-20020a1709070c1800b00a029c3d6de7mr3372036ejc.13.1700851937678; Fri, 24
 Nov 2023 10:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124-vfs-fixes-3420a81c0abe@brauner> <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
In-Reply-To: <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Nov 2023 10:52:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
Message-ID: <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>, Omar Sandoval <osandov@fb.com>, 
	David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 10:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I just like how the patch looks:
>
>  6 files changed, 1 insertion(+), 368 deletions(-)
>
> and those 350+ deleted lines really looked disgusting to me.

Gaah. I guess it's the VM_IOREMAP case that is the cause of all this horridness.

So we'd have to know not to mess with IO mappings. Annoying.

But I think my patch could still act as a starting point, except that

                case KCORE_VMALLOC:

would have to have some kind of  "if this is not a regular vmalloc,
just skip it" logic.

So I guess we can't remove all those lines, but we *could* replace all
the vread_iter() code with a "bool can_I_vread_this()" instead. So the
fallback would still be to just do the bounce buffer copy.

Or something.

Oh well.

               Linus

