Return-Path: <linux-fsdevel+bounces-3782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4FB7F8519
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 21:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4F028A115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B4E3BB26;
	Fri, 24 Nov 2023 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fii3w53d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411C10F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 12:12:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54acdd65c88so1701525a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700856759; x=1701461559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCf2e1EXSjwPuuSKzIrJH5yWdmYJqYZ2ahdEqbl+dh8=;
        b=fii3w53dj5vUs+qziU2lhHlCCT8x42om3PueoXKw2Ih+1en2VjHXlEoncpujII/8JL
         kfa0KjPyDOBg1FRrcimzvokWUkzcjKv7z4OLo8O0VjdNwY32DsYgFMiQEh+VgKLKSSaM
         wIxE1wGG0V+VG4WQGDGpxGDtNzH9a2C7IgNnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700856759; x=1701461559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCf2e1EXSjwPuuSKzIrJH5yWdmYJqYZ2ahdEqbl+dh8=;
        b=Af5C3n9TyTlfVVV8qzLm0zAwNstWs6P57m413i9ZQTVr/3/93ggLMl6gYa2cb4tbQh
         UC3ck+OoKtr6PoJIWLDyQlEmEEtxP01i4oZwIgSx+jVgb8YA8jvpd0AdR/qTKSa5JRd3
         LZF4I2laYAikD0VYmFydQtrI3keYn81NcazAxq7rXH7eYjKJWWOEuyMvvGeBBTYan2Mr
         e7JjBvWoWDl7rK2Ys7C4mYrWDJOn3A/xQxxcG7Mekwqo1VvZ3FxOHIZACobOMwVHRA2f
         DOVZ0czAoG3GJ6dAdle3JrvvxzWlKq9H5saCFexX20qvsTDkmT75IiltB/UtTsdPsu7E
         GlpA==
X-Gm-Message-State: AOJu0YxBEfP3HAOpH+HKY9wnWWO+dVOy4GtvL90mamsMgFEY7v0eI28s
	6IQdojGP+Jnut7BCVbFrvih3y3A8xpTQ7rz6PYqglF0Y
X-Google-Smtp-Source: AGHT+IFZswSwR5FFV9OK+RWS7Z6Bv6y/yaN4knBrmp7b7rY9AB/gbphO0yAyYtBtUpN7jqEuOTxnoQ==
X-Received: by 2002:a05:6402:6c2:b0:54b:1361:700 with SMTP id n2-20020a05640206c200b0054b13610700mr772347edy.29.1700856759521;
        Fri, 24 Nov 2023 12:12:39 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id e12-20020a50fb8c000000b0053e88c4d004sm2079102edq.66.2023.11.24.12.12.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 12:12:38 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a00191363c1so340666166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 12:12:38 -0800 (PST)
X-Received: by 2002:a17:906:a1c8:b0:9a1:891b:6eed with SMTP id
 bx8-20020a170906a1c800b009a1891b6eedmr3423738ejb.76.1700856758205; Fri, 24
 Nov 2023 12:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124-vfs-fixes-3420a81c0abe@brauner> <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
In-Reply-To: <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Nov 2023 12:12:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>
Message-ID: <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>, Omar Sandoval <osandov@fb.com>, 
	David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 10:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Gaah. I guess it's the VM_IOREMAP case that is the cause of all this horridness.
>
> So we'd have to know not to mess with IO mappings. Annoying.

Doing a debian code search, I see a number of programs that do a
"stat()" on the kcore file, to get some notion of "system memory
size". I don't think it's valid, but whatever. We probably shouldn't
change it.

I also see some programs that actually read the ELF notes and sections
for dumping purposes.

But does anybody actually run gdb on that thing or similar? That's the
original model for that file, but it was always more of a gimmick than
anything else.

Because we could just say "read zeroes from KCORE_VMALLOC" and be done
with it that way.

                  Linus

