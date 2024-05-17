Return-Path: <linux-fsdevel+bounces-19698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 158CC8C8D5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 22:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22381F23C3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3B13D884;
	Fri, 17 May 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mH+oa/U+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0E1DFE4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978475; cv=none; b=klEfP2TJfsjGFK3zV2iUNDnCtFCrg2oS+u9X/bFU+gvEe6mnPGh27J9y6UYq5lH91KVmP+6ZhQx0yKR/CBS0QmuudbqE7liQ5OwoODt+5nE1bLBqgITs3g/WjRwYBTqt6lN2s6Ots7yyOqA5L+Kp5iTHLx//lMqoExHA7BibEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978475; c=relaxed/simple;
	bh=1zR4oNwvnA8BkAHQhbNCPpvycGJsy3kDip8fLJUMvs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNGcKT5qiiZ3U8S8Xynt9Zb/UpOGO/1m/EGOSKEndqhpOwMYu1oRsvdts4o3ThexxF8zAA0LhHBpjgrT+LalhXNGiNAlPCEgNkYqnqalZGPsqMwhgt2Vv1Jt5xJ5x4T5+qHP9m8ZhWXR6ekZHn6KUbP/Hk5bLOQp5P2XJnL34PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mH+oa/U+; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7f3faea0ce0so367271241.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715978472; x=1716583272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R30tVZwDgV0/d0XFfhvgj7VuYYCEcxfHEIQCyiSom9Q=;
        b=mH+oa/U+pZw9M6PdpQ0Ikf9E0v+oC4j3gECWwxWWr9cRfLqWdCjLZ3Tq/F9vO3H8AZ
         RJX2aEPhAz6oT7DMFisz6xSAKeosAs1p/h5fj9zJMg3WmlrbLt0bEkQiS6Cwk+pp7yeq
         mFkspH4SPjy0Xt/0azA07J7te/vpitJsbEUFmnliPiiRzb1cmVR6eVrcuC0HhD5tL48u
         fPOOzWJrBCkTZlYbsl+TdPT937jCX3bVLOj/c0Agmd4k1GWtp3+lwuvPRm9vfLtMq/mC
         DLReSp6iscWNBwxP8tz6NRgSreGqkrovduvwEGc9qfvIJ3b6q/PWf367QqFqPfWHGWdY
         D2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715978472; x=1716583272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R30tVZwDgV0/d0XFfhvgj7VuYYCEcxfHEIQCyiSom9Q=;
        b=SMFhMGBWRvPvm3biCz/UhF55TlSbaFebudQ7qZ0zzWzdCPb5oUFK9eSqYmqZ+aIILy
         hHqoJGf52B7xvdudrlLmxlzgfJA3MjXo4PINizwMF8uNmZmqH5MLb/7KfiaZOOb3mAOM
         9bYAtENbmM5EJUjPSrBOZeITPxKiPUGXYukeu59UKp+G3T0N4ebGqnW34a2+Fb/Dwa6x
         SSDJU62EaU9hxCYMiZmAMzXvBfl1ZI4cXK0EZgwTiPen06zV5qm+rvn9EY34xJ/Dk/gT
         966hjWkPA/JF1s/9r/p2AwAnG0RM1w77sKzIhhNqFOws6Zi3/UkbYoRGyEUd3CbDjKnw
         vabg==
X-Forwarded-Encrypted: i=1; AJvYcCUz6fVYyTmYZxVYDEIqPdMNNHtnAnm5Thd3lPXQZVrcPLCIl8lPFGYBe74gfpmalkb8+djR6puynK98URmVGyPsRTzW7HIaSTA8SYz+HQ==
X-Gm-Message-State: AOJu0Yxn8+0EkjO09c7XrFi5zSQEv4txoZ2unblp171Dvk0qOT2K1pWZ
	EmxNGt9rcGIWQ4zKrmvcZNMOfXS7A4nbs/RrYfemP4o35nAle2FKIqisoNzl7xeMFN0nqcNIicf
	eUvZGgAlM0l4PT0raRfPBBaHXzxmDs6QAA3Km
X-Google-Smtp-Source: AGHT+IHmfBLbTvuWZDrq9Mhu7TtpE/aaISjoWzyeUMYFC/bgu3kwTmD10Cx24kOB+yYtazT4c5jmMdY6e5JklVkmxy8=
X-Received: by 2002:a05:6102:390b:b0:486:2c0:1d86 with SMTP id
 ada2fe7eead31-48602c02a3cmr6067630137.7.1715978472478; Fri, 17 May 2024
 13:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com> <ZkavMgtP2IQFGCoQ@casper.infradead.org>
In-Reply-To: <ZkavMgtP2IQFGCoQ@casper.infradead.org>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 17 May 2024 13:40:59 -0700
Message-ID: <CAFhGd8pQKE_uak2gqUXjbQy4LCGoJqVD2XCZrOC606u-tzS0mg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset calculation
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Bill Wendling <morbo@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 6:13=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> > When running syzkaller with the newly reintroduced signed integer
> > overflow sanitizer we encounter this report:
>
> why do you keep saying it's unintentional?  it's clearly intended.

Right, "unintentional" is a poor choice of phrasing. I actually mean:
"overflow-checking arithmetic was done in a way that intrinsically
causes an overflow (wraparound)".

I can clearly see the intent of the code; there's even comments saying
exactly what it does: "/* Ensure offsets don't wrap. */"... So the
thinking is: let's use the overflow-checking helpers so we can get a
good signal through the sanitizers on _real_ bugs, especially in spots
with no bounds handling.


Thanks
Justin

