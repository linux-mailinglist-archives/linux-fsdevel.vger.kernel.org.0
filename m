Return-Path: <linux-fsdevel+bounces-64305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4BBE06E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602C11A23410
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA05A30B520;
	Wed, 15 Oct 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKhj5fJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F83064B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556586; cv=none; b=h/GzUOxJnMDpcEs/N3PIDR6mx0ds9j26qCne9tvY26EMqRRLcXSse9OokpoVQbSk8f14X5KX91gsD1g9X8U87VMm21h+rQs3F2Y3Pi/mKOP/MTUnYXhenj6/9Zx050SlD0SEBk6MQhaty0P19K1W6WkCJyKJjdehug3SG2Dngp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556586; c=relaxed/simple;
	bh=PIriNEl1QINcRygfPV3g4fvxTFN2kEqSnPbk62zLE6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8msLnEbK7Z0bRNqY2xR9ZlQTf4hHG8oyQRzimzcRlz3TWCmpMdrsPjGv7B81KHVuXxmFBWc1ylyxlw6SDISOa8PFaYNdMRKTU7zo244yetQfFAB7wUpu2oEIYQRy8t9pG7Z5g8qF99KkaEeoz9cPMuD91oqNWOpfW7ajHeBH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKhj5fJt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3c2db014easo466692166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556582; x=1761161382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ksEMbgKeIvUZBJjpo4N52YV+1hwQuAsDSMHWnzo/ss=;
        b=TKhj5fJtrNz4feapeW+0BK2MENorh0xfEIf4HeOhca9C4ugfPEesr5Rvj/9LJKP265
         +Fv94g6YH9ge6yTTOEBaxpfjboKa6lVggSOP8GyE15m0yJZ7w72JCAdlw+kcfVkZQRfE
         aD/g0AbzPQYM6a8be7MQ/q6yuPiort3pyrIOg9kHtQ3lRxu/wzwhKLcpyHYxjWf66tcA
         5D1GiEJuydLItL24D53kl+Gg50c6LjqVM6l0E2++vjF+tcaF68PkusKomjrlZOBAViWq
         AoVA7IOpVVj8B/rBZ34p8sV8lcA7+Nxw6yW4GPF188pfJTNfmXkCXhDcuY1lOI2Frn5G
         2b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556582; x=1761161382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ksEMbgKeIvUZBJjpo4N52YV+1hwQuAsDSMHWnzo/ss=;
        b=NNpyhyIqJnfTwlMJLDNS7QCg/IMq2f75nXQEgjhar2eh43lnQTwZZgv+X1bLYcoXv2
         fh6GoibbOs4k1LMefKJtA11UYOjymQytIcWgZEUWTf6mBgZRI5Dkgdg0fTOzU3hs4hez
         uCNipRWTzZzd2H78PknRIH+nPBo294A2Fc9uZMW6fwES1jrtOdyVMLtQxYxeMCMnvIJe
         xhgLmVXihk5P7GlUl5CzMgq8MZRR1c2lQNFLzQ1b0xcz+QSPj+V4TJXlkZslKHp9ke0T
         k4yNOabOToBTx2EajZH/nUHpxyTEYQCZ1rjIEreA14X+cYv5mTMK2vPCzFTuqYPeEVWl
         XaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVlynsLa0edccCQDEYThV8H8yldvk9ouFOHxiwqVU630mUjhBURU+D/Eg1UFSMONz4sKLLurkTD0/Yimz+@vger.kernel.org
X-Gm-Message-State: AOJu0YyI53bbhMSTw7QW3n2DXkJp1gsNr+kSgQxrDqvGgbTTj3XDgrqV
	SHNaGeRuIQ4f5rUY049KGCyClom1e709FO57NTkHNCsw0CpuFS7qBcGkIlHAx8ANpvcnn7sgLd5
	tzVlSlIcdWYshgh+quma6QmrA/aKKJ0E=
X-Gm-Gg: ASbGncuxB+pDqu6XoMqLQupg+RiOwrrIvoEWzePQPXUxLD2SaXvGDP7szTuk1f1dSs+
	hICLgkeW4OdWCLMAWCJzt7QRDlyUoL0l7r0yMkaGGly01S9nwDkY7SkfK8v/9GjudnUNxQ5hpi2
	tri/ALIBlH27LBdGrL0Hre2zjoXRSlEbOdxVEiFbP/06i1JRNqQlIbCTFKBVm9j+mExwgP49/Fp
	kfX3PnG3cp4rqPH8lSg//CDESoOrl8J+AEvfPyRyjx0SaVFl3YyXFsP2SJ/VKFZ260x8h20KaAs
	HOI84MmwoFiKO84qrnpVfhw90lXuGfxNNWJQSxGNt6X4pLaDWRh5pOibeQdKkpHWBNbV43/+ED2
	S6LSdsQ5cpm364MwM6nJZoz0csWvg2A119uoPSK52qQ1buEMJ2J94
X-Google-Smtp-Source: AGHT+IGtfw5s80CNJkem4TNXL/X5g30lTuJ5LAlCBEIiiOXle0xqvtrIM2mLDYUfLHDwkWL5hMYZfB33sxDVPZ7wk+M=
X-Received: by 2002:a17:907:5c8:b0:b40:b6a9:f70f with SMTP id
 a640c23a62f3a-b50a9c5b352mr3117730966b.4.1760556581571; Wed, 15 Oct 2025
 12:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:29:05 -0400
X-Gm-Features: AS18NWAV3lBjrdoX5xVPTxh-gkxtXMZeTFZJaDEZjzjbFJTQq56Dz3hw5BWoKLo
Message-ID: <CAJ-ks9myBRqJJEErMU3Zt5-nx-AJ=D=gMNf07e3jFFj=SH_QGg@mail.gmail.com>
Subject: Re: [PATCH v17 06/11] rust: alloc: use `kernel::fmt`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
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
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:25=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> This backslid in commit 9def0d0a2a1c ("rust: alloc: add
> Vec::push_within_capacity").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kvec/errors.rs | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/er=
rors.rs
> index 21a920a4b09b..e7de5049ee47 100644
> --- a/rust/kernel/alloc/kvec/errors.rs
> +++ b/rust/kernel/alloc/kvec/errors.rs
> @@ -2,14 +2,14 @@
>
>  //! Errors for the [`Vec`] type.
>
> -use kernel::fmt::{self, Debug, Formatter};
> +use kernel::fmt;
>  use kernel::prelude::*;

Oops, this one is not necessary. Just a style change here.

