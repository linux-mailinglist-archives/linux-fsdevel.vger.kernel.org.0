Return-Path: <linux-fsdevel+bounces-69127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F749C70597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0EFD32F30E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 17:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FDD30BB87;
	Wed, 19 Nov 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoM1rRLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3B30ACE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572347; cv=none; b=r3BkF/8H4kKDSWECW35l8qawuS9wQ/rUTcicfRuSjvFwTOhGq1BBxzP0tSnm7VuYsMOytL51WoYGOMehUApVVfkIejirY6FKSi5iGtx1N6AUbqJlTMUBMwg+syrDyQre8n5JGNBwgHkxeNeb03/pUCshYUbKW51KNCvy6Yz9VMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572347; c=relaxed/simple;
	bh=w6kqF6fnUpsB/PZ9jA+/sWDdgtjvStdMKkxAgqfj548=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/atzuAQaXb+jggX73zSO+mfBKjUxc8hFKToBl4Tv2RkT/lb76VMiYjJCl1vj6ZX8FQhr2VtGLhQ46UpQl9y/9pcRO86nOKGTQ7ZPlQax/LnPmwwkxrzOpqvPlT3vaNBDON2CtdHvcqlJ+H/65XgTRnONoIS0IJHItzFz6oWv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoM1rRLb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso702470a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763572345; x=1764177145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lttwGYno15TKpeAV3UohAgRcGG4eYP6EQ60N4Vw7zBA=;
        b=BoM1rRLbltKeUtNPwOeUr98x/9oQX7fEM+9I2z9GH/jI8GyESgL31LJrKwS7H+scsA
         4Du6HvxC+ZK1zrkbTkN233hShREGpe7MOOLOz1LImnIY1tWcd8iWqXbiRJJHWuf/p9Pd
         kODDJEfcH6gkuNQJXm0F5CobzpeVkC/OEAERu0g822um1JPb+rBT7rKPxvbtcSrAZUaT
         YaXFkS/DjCwohdKit715lfI8/SwYlZbzxh0KvHE5ZSLy5Ocn9Nej3drpk0iptqaLcXWr
         M4Cmgum8Lc7QSrTEQh6pv8Y6hUMgaW9EC+Qn1jMUS9Vv40WZi/m/DwhTTr7e5ob7EOM8
         Y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572345; x=1764177145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lttwGYno15TKpeAV3UohAgRcGG4eYP6EQ60N4Vw7zBA=;
        b=Su0YiOEzB+oaw40J8OunNAshk4mNQgU1peIz4pVDME0E18DRl6CGroZ5/LgX/kx3ZW
         J+ZDJMkH+z76lYvt77J+zaJEmORiJaqPCn4VRAqWO02mxOk6vJDIMtYPlGuxfqXiU0ga
         Q4XasV9MIvfLTB/wbcAlplvECOLyBFJb7A9oGghaIJAQd/shUneHgD9NdngVqjmT3h2i
         YfR6JQzvGx30sePSq1sz7AFEovisw4tOAEwxJu4z1zq/Eb54tEcmQMdTt63MAaRESzvz
         VyzNJEn5N0P6fvJ7Bx6/G/nD4Lw/4uznbNFy2el+EdRODAiplDpajVdIO1+2pUYooidB
         QweQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2mmMMDkR+Q2TMjs3+VEM36MWpcuPiji28pc2NvJvn0/x7oJXoVmfGVWIy4oSZiDvukCx1Iuvv1oow5Nso@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2ntInCBGWgYtGLhWOkK0LxgJulgZiI2cjGZ+wSt42Cxoqju6
	IuU9B65lIX7wZoPmbRL72Di+HXj3EAX8njDzmkr6HYu2MgpsAVrhHRxdbeXR4ninjr05b8iUhVN
	iYy42zXlHzI2YFmlixALkui/0nhtfG18=
X-Gm-Gg: ASbGnctR7sedpUWqxQNS6Yo+QoG36hHgDFCkSPNoxPQ6xNM+8VHzocKTYvgzGD0gkos
	6boQtD29gZNnRYpwdDXStbhdAkypheRW7xEBDLS7yBKtXl6i7fNzbDJJ6AsymOnpvy4UKKF3Cdy
	m9hz9dQuEIsHIpJ0usnHkroiTKh98LDe71AqEzV0XKPOhG6q/fxMp3BIloGznf1hiloTNRKY/J2
	O9oJWnGfiYFWU8QC6EPpng1QZIdZJW9wRqrNQ0KzoJcPt8tl5xDxQ4nN5wByuASSmhHX61AethY
	UxNnvFh9AAKfgE05z2qtww==
X-Google-Smtp-Source: AGHT+IF9TqhCM5sftaGQEl9XduGer2CQZxEu8IUrH3eRt+kYJfd47IRIpaKq9Ngl12wdt9H+9C14CbQPOOKDWoLkN3c=
X-Received: by 2002:a17:90b:51cd:b0:343:7410:5b66 with SMTP id
 98e67ed59e1d1-345bd1fb660mr3491803a91.11.1763572345294; Wed, 19 Nov 2025
 09:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114193729.251892-1-ssranevjti@gmail.com> <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org> <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org> <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org> <aRySpQbNuw3Y5DN-@casper.infradead.org>
 <CAEf4BzY1fu+7pqotaW6DxH_vvwCY8rTuX=+0RO96-baKJDeB_Q@mail.gmail.com> <aR1awLOhdOXNMl9c@infradead.org>
In-Reply-To: <aR1awLOhdOXNMl9c@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Nov 2025 09:12:13 -0800
X-Gm-Features: AWmQ_bnhWvlGu_up0m2ui85unGpA2DRPQC9h14GAV7wAvQEwMdsyPJvZ2JIRYok
Message-ID: <CAEf4BzYWBUE0VseYgoa4r+UndxiOdCWazZ5FgZxi=dfhXaM16g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in do_read_cache_folio()
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org, 
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:50=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Nov 18, 2025 at 11:27:47AM -0800, Andrii Nakryiko wrote:
> > Then please help make it better, give us interfaces you think are
> > appropriate. People do use this functionality in production, it's
> > important and we are not going to drop it. In non-sleepable mode it's
> > best-effort, if the requested part of the file is paged in, we'll
> > successfully read data (such as ELF's build ID), and if not, we'll
> > report that to the BPF program as -EFAULT. In sleepable mode, we'll
> > wait for that part of the file to be paged in before proceeding.
> > PROCMAP_QUERY ioctl() is always in sleepable mode, so it will wait for
> > file data to be read.
>
> That's pretty demanding:  "If you don't give me the interface that I want
> I'll just poke into internals and do broken shit" isn't really the
> best way to make friends and win influence.,

Did you read the second part of my reply? The functionality in
question ([0]) was developed in the open, over multiple revisions,
with both mm and fsdevel mailing list CC'ed. Matthew Wilcox did look
at this, provided feedback and suggestion to use filemap_get_folio() +
read_cache_folio(), which I did incorporate.

  [0] https://lore.kernel.org/bpf/20240829174232.3133883-1-andrii@kernel.or=
g/

>
> > If you don't like the implementation, please help improve it, don't
> > just request dropping it "because BPF folks" or anything like that.
>
> Again, you're trying to put a lot of work you should have done on
> others.  Everyone here is pretty helpful guiding when asking for help,
> but being asked at gunpoint to cleanup the mess your created is not
> going to get everyone drop their work and jump onto your project.

Gunpoint, really?.. Am I not asking for help to improve the code? This
functionality is being used, and we can't "just rip it out" as you
propose. Let's fix it instead.

