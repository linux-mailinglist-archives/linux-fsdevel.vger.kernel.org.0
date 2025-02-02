Return-Path: <linux-fsdevel+bounces-40551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15FA24F81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 19:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EA91883DF1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A31FCFD8;
	Sun,  2 Feb 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JT2IicO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BDB1FBE87
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738521579; cv=none; b=pbqTAafyXxGIP+cS24qpWenaHP1y8s/3ZGjpzPh6TqYI8u1Dwqr5bAN1o9VoMEDJ4ZSHC5Htt5SRgJX4LKnaWP4596kW5EPLyu924qzkmQfbYMyhcsilOaSQk/7p8EX0SgIWAnNRa5Kl22k4Wf5veO6BPD0ThUu3wGicizrPKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738521579; c=relaxed/simple;
	bh=dzeuOtya3Wc7zF/kYzV6sgIqXXm9PR36oQDKg1A+d5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl7Slry4sA/fRs8jycQRSCjv1SKJsF1ZiB5c55ckNrySPZRvNaVWdzhhKFhv6Xj7riotta7q6J4c2un5EBLCiE+ZTAJtxJA2m3CeernHvHcwoTo0SpJ0NH4W3umssMC6ecIs8Y6iGXjqJic4E6WvdkKhI8u55UBq5N2DNGFPPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JT2IicO8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so579185966b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2025 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738521575; x=1739126375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H4S0RgGenjws27F+04GdAauVTnmbzhDtniffqBCRpno=;
        b=JT2IicO8HyYTkkPnXaEJ1Hn7Ius+xAWSfnU+EXovPntRSY2jkBNM4wYs+VHTRO3gFN
         IGeEsjGUROuYBgzKv1mfRJF0Og7Q0aAngvH4LBBeAI0EnIKKqtRXcvPE2vwXiwlIgjIY
         lYn+QFGXpHoBc3VTPl1/mXfX5ofapar8PL7S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738521575; x=1739126375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4S0RgGenjws27F+04GdAauVTnmbzhDtniffqBCRpno=;
        b=hZIS0E/2NzjYqlzjx7BnELu0Z3lcsGoUo7HgVmXZFqLEWFfiK8BOjWO3LR37GjpZww
         CN/nCZW9YCi9UD6iR8hwF1rSj+SCmSIkguFFAFQheqB0UNpwkIBXu6XD+XkwU1Npw+gm
         9UIayuKkdCXQBHrYSlZPIFmfYf/wdaHZF+Qs4BnQILeo/Ei2654/2Zrcf7AsXGDd3vJf
         9VZOmm4CEdjfdSmK7LvExUv2BDhVABVc3I5/O4trMp/zz+yvjstcAnT7rKZau3/naX22
         myq0I0he41ufBX6yK7+91YFLmnVaOQ3Cac7huIMvr1CtT7Weoct3zVyI0JV+k8YkE76t
         fHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO+OHY2x1k7UjjkBoMbCOuPMR7jESi3PHi+YSnjVWzPoZdhCSgcA9zss+Tehnsj2p7LVMWV6bl1lJtigAM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+UQT5Bcj6ougDG0i/ayMBiY5h/3bI9yM3U/5ZSeEAX9QhS+Kt
	F4SPLe4e2UN3qtVdIUSaseFp1sAAJChe1P4H5suoBH7dCtCNd+h4ERIYquwR054bvOygK0+SeYp
	xCoEIrg==
X-Gm-Gg: ASbGncvfjilUdifv5r0NR57Zai1hctmo8La0NiA9HTA+AbcOQHY0xH4iteTRaxkWAST
	rDzrYxTReO9YHXAcTzoMuuj+r2U4Vrd8ZfkFjGsX+cz7JjsATBcjw3fFbcW9RZ5Wv+U9XmwwNLK
	WSFMAFjXYCxV34aGJSAmPUqjbX+0iB9c4VpEE8Y4PwNLOf4ODC668GFAyQNUyY+iEI4+kg2P2/s
	TG5TFwT+diDdmz5pVpeHhOuheyqVcj88bDuzOBPFE7P8mv7QJxOZc9ooXitc+w5ybaRrU1vMczW
	nVU2obxgDjqfO504EXrHRuqvwckSoZ12Ztj8D6O1gdVFccDtHqFNbIhNdRTKDSr4zA==
X-Google-Smtp-Source: AGHT+IHSRw5sKp9mpENbW9ntoWlVuZy9LJuScQaVp/ahIYoWcme9X45fkHjjYBwYiLbtg/TIp+aHaQ==
X-Received: by 2002:a17:907:160f:b0:aae:ee49:e000 with SMTP id a640c23a62f3a-ab6cfceb3aemr1772036966b.18.1738521575193;
        Sun, 02 Feb 2025 10:39:35 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff968sm621288566b.111.2025.02.02.10.39.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 10:39:33 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso3289636a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2025 10:39:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzpR7mJ5BzAFA2PsxhvjrNz8ye9czBNF3z1zsqQ0N7q/3rm3pQOzO2POWofXak2Wrltj1YpzDb2gS1wjQZ@vger.kernel.org
X-Received: by 2002:a05:6402:50ca:b0:5d9:a55:42ef with SMTP id
 4fb4d7f45d1cf-5dc5efc4586mr23025684a12.17.1738521573175; Sun, 02 Feb 2025
 10:39:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
 <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com> <20250202170131.GA6507@redhat.com>
In-Reply-To: <20250202170131.GA6507@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Feb 2025 10:39:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgEj=1C08_PrqLLkBT28m5qYprf=k6MQt-m=dwuqYmKmQ@mail.gmail.com>
X-Gm-Features: AWEUYZn1mLEEFZrVgRBTGnd3WXHbXwdvbyu7UVX6NyaMQEXW9txXBTkd09cMrv8
Message-ID: <CAHk-=wgEj=1C08_PrqLLkBT28m5qYprf=k6MQt-m=dwuqYmKmQ@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Feb 2025 at 09:02, Oleg Nesterov <oleg@redhat.com> wrote:
>
> And if we do care about performance... Could you look at the trivial patch
> at the end? I don't think {a,c,m}time make any sense in the !fifo case, but
> as you explained before they are visible to fstat() so we probably shouldn't
> remove file_accessed/file_update_time unconditionally.

I dislike that patch because if we actually want to do this, I don't
think you are going far enough.

Yeah, you may stop updating the time, but you still do that
sb_start_write_trylock(), and you still call out to
file_update_time(), and it's all fairly expensive.

So the short-circuiting happens too late, and it happens using a flag
that is non-standard and only with a system call that almost nobody
actually uses (ie 'pipe2()' rather than the normal 'pipe()').

Put another way: if we really care about this, we should just be a lot
more aggressive.

Yes, the time is visible in fstat(). Yes, we've done this forever. But
if the time update is such a big thing, let's go all in, and just see
if anybody really notices?

For example, for tty's, a few years ago we intentionally started doing
time updates only every few seconds, because it was leaking keyboard
timing information (see tty_update_time()). Nobody ever complained.

So I'd actually favor a "let's just remove time updates entirely for
unnamed pipes", and see if anybody notices. Simpler and more
straightforward.

And yes, maybe somebody *does* notice, and we'll have to revisit.

IOW, if you care about this, I'd *much* rather try to do the big and
simple approach _first_. Not do something small and timid that nobody
will actually ever use and that complicates the code.

                Linus

