Return-Path: <linux-fsdevel+bounces-41342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0698A2E0E1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 22:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066543A55A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A21FC10F;
	Sun,  9 Feb 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BYbGDKoO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264E1E283C
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739137122; cv=none; b=AbQpqCeqz2jIVgEZjdqcZidBh05XXdHJzfe1j3/uK+J9FyTWJcgEwWvIzyV3FN+ocqLC0Od7CQAvXYOqttxn2SBLZuxrMPWfII3Hj3gsHMh0jlxF6cLZNl0kVi36zEHeEQ4Ao2iysaTmsk8m2m3qsV1DWU0/UyKUtGKjVtiEqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739137122; c=relaxed/simple;
	bh=6S1lUOrlLJQJSB6iy6z/54XwDRpdbSSEfGlk7fXrxlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfEdstVmwVgnW1p9XyQTDGoiMPqbKBPi3jlKVXqfDB8A/evM94I8Y3+y8gUkgX5FW1KbkKkcPdFSDepWiIdEHPoRhJF/v+7FH5UQELS6wxhiyRLt+iiOV5aZcAlt1mR4Y6wu+iE2PX2IW8R9Ym9tf0uHYtGo16U5KwMaNju5Og4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BYbGDKoO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7b80326cdso101442366b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 13:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739137119; x=1739741919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=apWyvTC5cYpMp+QgVKPxMdVerUEMamXyfh1oLcq+CqU=;
        b=BYbGDKoOOgIQ03mn4vXoR8yY/fN1QbjPmpO00W0XaaRKC9tXiCsQjG3/FzlZ3UlRdQ
         oKf65Y4pjiZPH+ZqjMcSq6rpqxLUJJu05uKuXePQH0Mwoo3NrdO8XnMI+g0ApoVf+Y5x
         ilbqpMdwM8BaA9AbUYRehNlorrkfBGAAHmDFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739137119; x=1739741919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apWyvTC5cYpMp+QgVKPxMdVerUEMamXyfh1oLcq+CqU=;
        b=ET7xP6L2RvXh77sHhLQhbgVKY0LWgcszew1/StxvFiZjX7stBrlrmO53hSNwJ7ArJC
         cR2mq93/bimm0Xka3iywAfahvfo8Zv7ZYxVR85GrSJF8tm0FJr0Kzc5tckRV7mSnBaiH
         3pOv7tIEeKus6wg7mR8J63wC7EiDBbwgw3I095nHUaYg5vi1yzGysbP/mrmCjg5rVdDm
         nnB5FYdzNUq7nHOUkpDsReIrAwnY2RMX6kmiUcguaharwOnigR/5O1WZqnmiPaJJ5m64
         Bd1nTFx0oNsdvZEnrubdEKjCRyBIHwp/LOHNJgQk9RcEzqAfmf1dEGNfiXvT5pxFFPv/
         Ljkw==
X-Gm-Message-State: AOJu0Yx+I03tcwtpoKloQHDUFTFmBZNBbevJebeSZBZJiIV4BCuME/EP
	zZy+b122xPSbdbjSfqu0JQqpAAUblmEnlEdIEKjtWOGn46hemoNFKxJ0F1yY73VxsQwTSXndhqK
	Rd3s=
X-Gm-Gg: ASbGncvZ5dzrkedudigwLy+slUm5a0gs0qyzgjCR7/dpPTrl93FsiEVEkEg8CcRMv+Y
	AQZIat4ItbYKPoXDj4/jCUsBatLhseFDVM8BFlXCKwRgdsFBVyIxQGP/L+pBTFznThg0vkq78kb
	a9lra3WNaugpLgc/6GlnlFG8by1WgGrDM1JDZDdum26lc1E7zOlJIw1IP0c73kJx4MCd4w/yu5w
	Z7HtXAmLZOSnNNzr2k+L0TA4nIjmFoKGvFp6k2SfW2nUCgZs+g4XJUg40eQfunWMTU5nyJ9PHBM
	OszR/ODtwhNZckDEurmF358b/5QHOVdZKpXueeRHs5EiAEp2Nek3bGxJNKNDprcUug==
X-Google-Smtp-Source: AGHT+IGZlcD9/iIO4a1BKBpNhvhMzoxtG1sUYnus3s9jkzrDTjSuy9uISiQL2NkF1voou4uv/AX8Dg==
X-Received: by 2002:a17:907:360c:b0:ab7:63fa:e4a8 with SMTP id a640c23a62f3a-ab7897b37ffmr1011688766b.0.1739137119204;
        Sun, 09 Feb 2025 13:38:39 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab77efe3111sm684312766b.51.2025.02.09.13.38.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 13:38:37 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so5108964a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 13:38:36 -0800 (PST)
X-Received: by 2002:a05:6402:2084:b0:5dc:7fbe:730a with SMTP id
 4fb4d7f45d1cf-5de44e5fdb7mr12452558a12.0.1739137116607; Sun, 09 Feb 2025
 13:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
 <20250209105600.3388-2-david.laight.linux@gmail.com> <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
 <20250209194756.4cd45e12@pumpkin> <CAHk-=wisZo7+-xmC_o8GQJ-G0qFp4u29t_FkjgPvgq7FXaTyDg@mail.gmail.com>
 <20250209211805.5fc2e9e4@pumpkin>
In-Reply-To: <20250209211805.5fc2e9e4@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 13:38:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGYtJOrgrjXF6zceePOp5G_F7VTfikjdGOsJ3eqsyfJg@mail.gmail.com>
X-Gm-Features: AWEUYZnNAzSZJAGV2yu2h4_mOX5H8DgW7QZAQnW2C_BR_FTN8wyLPiijB4-v5YI
Message-ID: <CAHk-=wjGYtJOrgrjXF6zceePOp5G_F7VTfikjdGOsJ3eqsyfJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user copies
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 13:18, David Laight <david.laight.linux@gmail.com> wrote:
>
> Except for the ppc? case which needs the size to open a bounded window.

It passes the size down, but I didn't actually see it *use* the size
anywhere outside of the actual range check.

So it has code like

  static __always_inline void allow_user_access(void __user *to, const
void __user *from,
                                              u32 size, unsigned long dir)
  {
        BUILD_BUG_ON(!__builtin_constant_p(dir));

        if (!(dir & KUAP_WRITE))
                return;

        current->thread.kuap = (__force u32)to;
        uaccess_begin_32s((__force u32)to);
  }

but notice how the size is basically not an issue. Same for the 8xx case:

  static __always_inline void allow_user_access(void __user *to, const
void __user *from,
                                              unsigned long size,
unsigned long dir)
  {
        uaccess_begin_8xx(MD_APG_INIT);
  }

or the booke case:

  static __always_inline void allow_user_access(void __user *to, const
void __user *from,
                                              unsigned long size,
unsigned long dir)
  {
        uaccess_begin_booke(current->thread.pid);
  }

but admittedly this is all a maze of small helper functions calling
each other, so I might have missed some path.

             Linus

