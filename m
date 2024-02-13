Return-Path: <linux-fsdevel+bounces-11403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B5853712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7221F29D57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA75FDC7;
	Tue, 13 Feb 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AyoMW9YA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606285FDB7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844660; cv=none; b=OOmuNvylN3IJoxU/0thaybbxdQLJM8ldBUxGted+Gf527ofdpUI+p++GVC5MatYr4CgT8fvOKBUS3Cbq/gy/XALck19JkSA3AHpef3TzZgrDRJniogQFiSAjcGNiOTHyBsI+U46Tub3sgnH29en9DywFX8gMJ1g3psSZzV61LvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844660; c=relaxed/simple;
	bh=38kx9jmZ+jYww0779Ipx7DvRovCFEMpqxhaviyzCy3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfsKru+VuvndsN2/5TTj3NgDfaslZaKRfgeT0gPNgbc1AH03vaHaPzI8AlnT/VImbkdwddWJbzundDzAJZhNQXDlr5/aZuR13ouJArDFalR/35e+9/QYXtjDCsTNCHuVtEdk//p+Dowpn4sSS6NQwgt5g2zMhM8Oz9eqx2UuUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AyoMW9YA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d2587116aso43147666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 09:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707844656; x=1708449456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fz+HP5pKdIXtr5W2norUinvVaUURHHECi/4WZsXtlUc=;
        b=AyoMW9YAxWTxwMReVlhbCVDmrh84/q/Y2nsb0tqjhUPwtJERGorclcx8XFzHRLfNLj
         HEsv6xXktaJ8ogy9GQDh1BaYMUdKIxFnIeKxnDw97xIPCtWjOS0IyPhWrL+ojPMCq/0/
         uwe2yVIEqlYJaIH1kvicqCk8qGUR9qpuu3D/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844656; x=1708449456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz+HP5pKdIXtr5W2norUinvVaUURHHECi/4WZsXtlUc=;
        b=PSKGwQw+eBy/beJCI9kme77YHlCwE0KbVQPa/MSnHSCQ+Nnz0eQMTW2m8O2QQOp/tB
         ecbrPyCiL0VOMsK5myCzqk1ZaJkM/xqYm6phOXqRkIKMlYydfCdj7g+G9q01BAD/NyFH
         zlTMS/7EyvX9O4rRPesHl3n6MqVt4YjtppU18mPvb8WnRPunevUNWgsXihg+OjeTMlcc
         9KtuNDkOCInGjF731mgXOS7E2m4UoZ4UvRvfGuFHAFfWaquwtB3Qi7mX8/exsiSGQXLT
         O91C1kZxgjtX+uFz6iMXo8JgHDO6+Kqf/CkhP86YAfx6dS2aTyzUnggLQG0kMfbp5Faw
         zZSQ==
X-Gm-Message-State: AOJu0YyseTybJQCFFqLVH6ulosxKDD7uHbQKlxnAZm1+5GpnKcX4RZL8
	+HZGSw7P7Djtr7CCS35V+cM8IAUZtTwSQQeJTvOQLOJUGe/78JCtfWQ1/mhTOl73I1AX4IamkyO
	RlSIdog==
X-Google-Smtp-Source: AGHT+IEcp4A8Ai2QaRrcCs1XOJTHcwmLI+ZOezXjv1R8RmxsuGCOzvnPvYMdjHb3pd3zwUSDQ15zuw==
X-Received: by 2002:a17:906:4f09:b0:a3d:1798:deab with SMTP id t9-20020a1709064f0900b00a3d1798deabmr1310289eju.6.1707844656247;
        Tue, 13 Feb 2024 09:17:36 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id lz23-20020a170906fb1700b00a3af8158bd7sm1474854ejb.67.2024.02.13.09.17.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:17:35 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso5555898a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 09:17:35 -0800 (PST)
X-Received: by 2002:aa7:d1cb:0:b0:55f:99:c895 with SMTP id g11-20020aa7d1cb000000b0055f0099c895mr220909edp.20.1707844655189;
 Tue, 13 Feb 2024 09:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org> <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
In-Reply-To: <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 Feb 2024 09:17:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
Message-ID: <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 08:46, Christian Brauner <brauner@kernel.org> wrote:
>
> * Each struct pid will refer to a different inode but the same struct
>   pid will refer to the same inode if it's opened multiple times. In
>   contrast to now where each struct pid refers to the same inode.

The games for this are disgusting. This needs to be done some other way.

Yes, I realize that you copied what Al did for nsfs. It's still
entirely disgusting.

To quote the Romans: "Quod licet Al, non licet bovi".

It might be a *bit* less disgusting if we hid the casting games with
"atomic_long_xyz" by having nice wrappers that do "atomic_ptr_xyz".
Because having an "atomic_long_t" and stuffing a dentry pointer in it
is just too ugly for words.

But I do think that if we're going to do the same disgusting thing
that nsfs does, then the whole "keep one dentry" logic needs to be
shared between the two filesystem. Not be two different copies of the
same inscrutable thing.

Because they *are* the same thing, although you wrote the pidfs copy
slightly differently.

I was ok with one incredibly ugly thing, but I'm not ok with having it
copied and duplicated.

               Linus

