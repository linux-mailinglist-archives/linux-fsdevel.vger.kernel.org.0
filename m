Return-Path: <linux-fsdevel+bounces-15485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F188F29D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 00:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB18B210C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 23:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB7153BE2;
	Wed, 27 Mar 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cOObFM/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B812E1F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580749; cv=none; b=JgwaaKyT1sDBA1MR72THPWdMfBziJZdTUWOGjA7eoxtcgZSLnd6z+y1sWyOkB11eKHzorGecHuWRLRSfNtjjpxxX4tY8m6PBrtGu+8TgGAWfntBR4w8vhz74+ogsGBv/sHERnp+e7jUd2BxLvHGx+J4ZpuYObrVboLgirXAg63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580749; c=relaxed/simple;
	bh=VO6BQZp9XbSQ+WsnBdem/mcXj4kD5L/TqZKDrqpZiSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAtYQclExzBaEaM7Tkj/G0AsUdKScbeK1zmtOjiEexv8qqXd8VXdgwhmDcEjdHpLWJ9MfIsyLRZdhiXMJM3dN6r6i0kgRPXulOv792SYSomLZHwPjS2rH0eAzzx+A/3lpDUnA/VXKKVEMiDVSWboo8zneY/ohNiRDB+PVfVKA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cOObFM/0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso430893a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711580744; x=1712185544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ME3b1Rt51xAoj3MwQWhqtTxBw4ApU7TZHqRjbw2b7co=;
        b=cOObFM/00g22S7ZZZOKb4csbWbIxboV7GTqKpGpdW8oFhamoPAwIEGq0XQVuy1E1C8
         GgCYBdjsn98EfI6zAjZb0knLQW9R89QL9EjjA5tcHkanbqqABO73SQFK8fTz3z3awaA8
         aE6KgO9hZFlkMugW3IjlogXl4fV+1dykP+ejs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580744; x=1712185544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ME3b1Rt51xAoj3MwQWhqtTxBw4ApU7TZHqRjbw2b7co=;
        b=Q/Ebtl6xmMUzoabJ/e7CDslvkdzeJkub/jSvh0v3Kf9Y3/AZ0twRnNH/KuajD3m1mA
         kxZRVWPFy+onjH7tHLG6O3RmzNB4GLFn8FOmiTvw1k0NBFtDgMhwZOQmo5AR3p/Z5csb
         gmulP2OwnODp1a4vqgGnVlPmfy3Wyqux9HdV1agI3NgEMmoyB+MMKld6YFiCXVmZ32G9
         Dtr12skrnRL1CQ/PTefKyfT4cKvQhtXx/oSfxVkjqI6q0r2N0MKx6PYrrFWs03WqPJh8
         WwOM4AFfj2xynNYq2q7KJrL07NEzvcbv64BAcQSEgDjjgwzWfYDj87nYKLFXbywpyTCo
         0ZPg==
X-Forwarded-Encrypted: i=1; AJvYcCWDINykU6mAms/v0d4tVboT77PurVsB0PHKSbJA90JE9Kh/cuO0hTnqXpPS3dhuoEgvGRyJ7mmhiGkaZdFxKQqNQplBjmJCXFqyj/rJ7w==
X-Gm-Message-State: AOJu0YwSWSuL5LOPhOkO9z2/P3r60i+sME8OKvBzJcu4o1HWugSL1aZo
	Ce6AIdFzDQFUH4dfpJyYJYQI8XIyQQhymnotK98UV1Yh/B2ThEsuXXRFkiZ0pX6OL64qkW4dJZo
	zPaVGBQ==
X-Google-Smtp-Source: AGHT+IH2f/lHCJDFY5WkY8N+1xv2EhykujBAzvPA4EV4dKIcbkXCQr3K5vyuSuQlVO6enPENAqb+UQ==
X-Received: by 2002:a17:906:494a:b0:a4e:11bd:e64 with SMTP id f10-20020a170906494a00b00a4e11bd0e64mr535010ejt.49.1711580744136;
        Wed, 27 Mar 2024 16:05:44 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090626c700b00a4735e440e1sm51839ejc.97.2024.03.27.16.05.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 16:05:43 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4e1566610fso27431666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOTcF8bqkjOe5AvP/gjgCiOBRsCt3s6Wq9pU6qC5pD9dSLgaab36ILzH+GAuUBRaqXiP3zVQl4IQhdFpnlTo8z3hkpSqYGYua3XwXScw==
X-Received: by 2002:a17:906:1352:b0:a47:3887:db68 with SMTP id
 x18-20020a170906135200b00a473887db68mr468280ejb.38.1711580249028; Wed, 27 Mar
 2024 15:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com> <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
In-Reply-To: <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 15:57:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
Message-ID: <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 14:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
>
> On the hardware end, the Mill guys were pointing out years ago that
> register renaming is a big power bottleneck in modern processors;

LOL.

The Mill guys took the arguments from the Itanium people, and turned
the crazy up to 11, with "the belt" and seemingly trying to do a
dataflow machine but not worrying over-much about memory accesses etc.

The whole "we'll deal with it in the compiler" is crazy talk.

In other words, I'll believe it when I see it. And I doubt we'll ever see it.

               Linus

