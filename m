Return-Path: <linux-fsdevel+bounces-62426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308AB933C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 22:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593C51906041
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1932C261388;
	Mon, 22 Sep 2025 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvWDYbj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A5212D7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573075; cv=none; b=ZwP5+1X8yhJdLpynEr/+pra7vSKkqcEF8/uGW/ggBDA4SG3rSJv6ziH7xI8ukfwZGnmHOnZhjc6vdxAzd66ofXqhqCHjjUnAwpmW9Cx3RIbbWlYMEyiVcibdF61ymtvnv4Z3Rse94LzguIU0uBNp6y5fw1eQ0WAsSWY0OQ77zXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573075; c=relaxed/simple;
	bh=MJEFNOBSo3SKM5qiYRxxqoiLN0A/+xJxbSym8TLAOgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/Lz3/rVE2pwowsrcggt4FpZzY5jOfp1lwLb2lOTm22YyeBjeqj85rKD3/IhjfMRmf8HQs4vxKE1rZUFb9kMG3o8OpLg13NCBRAcZbFi5T7htejMQQ0kR0wMUjPcn8BWLMd8jP9EObxyR+nUcnQ1wY/kut0TFcYRaPaen0+Dy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvWDYbj3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24602f6d8b6so7178905ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758573072; x=1759177872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcwSM1XGta2EiHK7PYQk1Nst2JShxKlF4k281BKxKcw=;
        b=bvWDYbj3iqME7AmlblHpwc+1M5ztBJOGASqHVlb/kZLva/72avzSR19LqgOH2RelOn
         7do6odcBZpcHxaeSOMY9yKKjO8m6vuJGhPQNuGl1MSz6SZm4av5TUNbUvXcDiTok23dq
         TXXZ0tvsHfmZqo1Beaam8sUsNnKpz/4YZOlkdeRD+VcaQNKMfDU8roMZ9yP1PI565mEL
         NFwlUp4qcAVOoJG/+ugesrgxUdPiCAalF38eZcMsr5RlCgok0as1Y+ukUX5igbaBs8w7
         LqMfKTRvpJ1VatoFKgNUD21yT3ee1HGZTtLEDCaojN5ZNBXLoFcgkEl3cL/aA0pMQvpc
         kvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573072; x=1759177872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcwSM1XGta2EiHK7PYQk1Nst2JShxKlF4k281BKxKcw=;
        b=TcBuhVY4naXAkLX6qCYxQEgTkJzyfuF83BwZlrZemuL3N7w/E6J/D6g1zz1Y7zc1Ha
         KObXcQ0L/CMFFCE2khnZl1N+a8Oqv/UA05AUlZOoic7TAMjO/OckKs+fxa2WOBnRUDJ5
         O/NhaAhUuPgjU9rmHbiTnh0eM/sNigzu4HHqeDhEuRMm8M5b5uU0jiqpzERlDtPMyv7n
         n5WutfytcvesGV70wJQzB7EAJOJDSKivjkkvIt2sqUCO/3LWeVxboaZzi+mYSa0UAcQT
         gBGvrq7UJlY8bm8EleSpfRuG16BeoBJdX8B+4u4La9QRCvusAKPxVYS4BzObO/Ttj4wI
         uNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRF/oM/mY/Q70gFR0vgMjlTJXqd76rKQtafwNnBtW+kLF/Pf39VwX7r7Z7XLe9d0HHLxxvjjanQlMEkUd0@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTwzaxsbbyRjwLwqEvGQoR01XzYenT9k0wZBcKvdLbLPeostV
	sEwKi/4tJ4syf/bV1aVWVl96iJSlTdJRQg1AoKYrlNakq8g0GHOGZLzdW9MuR4osjiYM+w0PEL7
	trDjB/Sbps3yhwAB7O+gXtQ1MAgG/Cn0=
X-Gm-Gg: ASbGncs1UjOXFZCr7Egmw6YLdwmScEjgZdRUY2GDvOOSXrqESqeD5hsO3eOaa48qqnB
	3hEs20tLbPgjdK5oWMTC6xBUNHZyN4omi4Nb+xX470IeRT+abKyWEa4b+wqoI2drV/1vpOOuZ4u
	P7L4czjowkPhl7mdarrvG4zlby251k4PHaB5+Oe/2ynhaHthTFjf0p4gjvEUkAfKzgSuBrS0zut
	P4zStN4No79p4y5DdPk3JTLiVog9/+hcpwIWOZQM8/+sOuwVXP/URqxoOaQoQnhwKW2GC0VJmxK
	kQXFSIeHKfox0HNEjfljDalbIQ==
X-Google-Smtp-Source: AGHT+IGXlLgoOnlIi0xB27xbNnE/Gt3cViOhpVvylnU7nHRlbjGJ/bgbhPyP5R4jQ61rPO6JCpcQYEV2WsDmAL4iq+E=
X-Received: by 2002:a17:902:d48f:b0:272:f27d:33bd with SMTP id
 d9443c01a7336-27cbb8b9fd0mr1155245ad.0.1758573072387; Mon, 22 Sep 2025
 13:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-cstr-core-v15-0-c732d9223f4e@gmail.com>
In-Reply-To: <20250813-cstr-core-v15-0-c732d9223f4e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Sep 2025 22:31:00 +0200
X-Gm-Features: AS18NWB6PmBlAWRUNDsKcUzY6cTwjDnURYFePpOCqHbTRGNIsxmxdgZIFpfQAjE
Message-ID: <CANiq72nyQiHCvbTw1+njf3ZWYsK-f603iY-oox=9dMyfeCE8rg@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:45=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
>       rust: macros: reduce collections in `quote!` macro

Applied this one for the moment -- thanks everyone!

The others require a bunch of changes in linux-next.

Cheers,
Miguel

