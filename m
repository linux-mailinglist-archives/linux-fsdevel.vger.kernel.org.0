Return-Path: <linux-fsdevel+bounces-7410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E782488E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2DA283B1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD642C192;
	Thu,  4 Jan 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9PehNeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10824A1D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1069182a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704395080; x=1704999880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=S9PehNeEr+4blxt6e8NKLyPCSA2MX+RY9rcAoM3px4mPQPOO+kRd3glFZgMH+UW4r7
         MZ9qeyyNPJiGMZHOYIR/4hJ/a7FeOvgqlL0xGVzFT9nNcQCiezvfZfYVNzLd/fLUqawB
         Pap8dX9qdHLkAx09xHOOuRMXM5t3EdOsWhD7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395080; x=1704999880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=fn+Lc51h5kttEuWq0fjTPl0/cQ9TlGL68H7xnzZVUjgi6VmZ/m68hlajbETBEJLBic
         Xi2KaZwhfIpHLmO2ukUAS9UnZkKSkRM6cYIxqoWqAXcazCSc8Y/VOqWnrBP6TbSWVIVP
         ELLIOtVNIYJrdMA2G8VPxxdC4Rts+300Cf7IrRLWGf8q+vOCEA+TVQZrVGNzKg8x82cr
         +pH/mV7RXvaOmZkC+MfXt2C2nwq+FRssNWFm9I1KOIDhhbNWRiNKbue7t6q1CusQg/Q3
         bNIqU99+dqFLzL47F9GSnx/rxwZ0WIJ9jYMwKVOvTBC/jSTqNpZYBtQK4ujefh0Xupog
         VhPw==
X-Gm-Message-State: AOJu0Yy7EUarmQKQEFKOREabpTupeKjyCvXlWdkkMYe4pEUBqnNw7l6U
	WwxjytABf6iKwrfs65WpTjcGsx4I1fgHxvOwbiYvJkUHrglj8m6j
X-Google-Smtp-Source: AGHT+IFEG/CMvUy0+7XnT2oiGCU5jUdTm6nRGu7Wm3s0t9nmDBayhyE+oQv/euq58TZPTPs4XvVW4w==
X-Received: by 2002:a50:9b14:0:b0:552:d802:7993 with SMTP id o20-20020a509b14000000b00552d8027993mr513745edi.20.1704395080492;
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id d8-20020aa7d688000000b0055520e4f17csm32492edr.45.2024.01.04.11.04.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1069159a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 11:04:39 -0800 (PST)
X-Received: by 2002:a17:906:18:b0:a28:f456:42a2 with SMTP id
 24-20020a170906001800b00a28f45642a2mr318777eja.44.1704395079598; Thu, 04 Jan
 2024 11:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-14-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-14-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 4 Jan 2024 11:04:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/29] libbpf: add BPF token support to
 bpf_map_create() API
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:24, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add ability to provide token_fd for BPF_MAP_CREATE command through
> bpf_map_create() API.

I'll try to look through the series later, but this email was marked
as spam for me.

And it seems to be due to all your emails failing DMARC, even though
the others came through:

       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

there's no DKIM signature at all, looks like you never went through
the kernel.org smtp servers.

             Linus

