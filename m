Return-Path: <linux-fsdevel+bounces-64312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80EBE07DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F13C507091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C20306D57;
	Wed, 15 Oct 2025 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIozSut/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B0305E32
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557215; cv=none; b=UDRO0tr00H7OJVb923Dcqrw2GcaCFFV3pZeqCTslvUV78QssLfG5Bnvp9kufLbwiwC5Pgo+RNI1xZNqQXz6YZpMsM0U724sE0+hrTsAbVQ2UbIa/5YjvuhSX/vM+z8ExLdXnZ9tpRE8KI8735GjPPy7ydd7iNsAYMNVKx1MgdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557215; c=relaxed/simple;
	bh=+kjcilcNnl42PP01ue6qyMU4wvoCvOkJFn4w3QhQiE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWNU8i8FjMuL6gI7Z9TaxzTQ1lMojhlBZyyIsd5dsWaME63OxoSOOZI1ZWPyGwTF/qm2EV8Mp2cUbIbelGwPgjOLKDYP1tEY3gQONkmXFu6KOF3OvTVBSod92wcDLIrznxzpkmGfIeCPZEsMIk1MKrfjAY+YiJOH/odvL/us2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIozSut/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so2908a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760557211; x=1761162011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n8UZ7d2MXJ0mooKHeN+kYs3Duy/o2bf41dETvsjc+Y=;
        b=iIozSut/W2nIQjK42GMcWHc4okeMV/AcFEVKE67gAw3z1uMnVK56KzKtKg3e0P5wKY
         jisoM+paePWQy9DVm1vHf9sdxGwpH7f9o/YApzg0JZfQ1Q8iJZAicZ1yGP+5uRzN2oJ+
         KOXjIPb8cupFFnQ46rqHeOV0Vs/Kg5ZXvx9nM1184QDk2AtIN2mhjZh4U5sod8CBmr9m
         NFa53OXv4ecsaFKDA7rm5ypcksuRxS/xs1hQRcUd9y5fWQTL7cD1Okc6rTxZCtOyqzuI
         PLEwAgqFifmSQhWiQNswh/PmqMnAuOwVx8U3QG6yBWhqWUoWoOD2Of+40OntsFRMC0c+
         tpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557211; x=1761162011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n8UZ7d2MXJ0mooKHeN+kYs3Duy/o2bf41dETvsjc+Y=;
        b=W7SsqtbXy9786z1Xyd2t5VP3X6vUD1t4SBc9mau0791p3D+eA6fW18jgwXC8jtIKTk
         AfbX89PG3/wlVNcvrk2gVRoxBX5IFV4worsNNtc5jD6bB2j1FnnSHMB254t8a7+1jhGw
         X30svoR8TlQvSRMzXpk1guS6WsEpG/DzVmPVq6Kux5e9ta9HxxPSui+eDbJ/V2sWFYRy
         i/ibDVP657g/CLGctk7jPR/MNrpyQe2RNW9weLZJvpRHElAHe78IiPMDcJd/SYUZj94r
         m6megLDPtaunDBvpvJkiCxmTiqoiNh1BIUZNYnDsaTyoEl8KxHJjbgwJ3iYXTGXMr96N
         B29Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP/Ki5YxswOVpfF2QeRmFcPHg5ga7iHwlWHEWINYk53mISQU6TlvRM7S97GW48j3FYHKW27v9S8R0VvuiB@vger.kernel.org
X-Gm-Message-State: AOJu0YweIz/r/l0sRiS0QRIS9j5xZfBrqGo624zu1OEwZxg3/6vKsyLL
	Z4yrcGN+BWBdSJHCs52J7b8uyEh0Qgt9HVD81WYKrbsGQ7uJBXx4+z/b+ScRKe+drYhH7eILlnt
	9KOpOevximUf/OpUoiXPdLY2hFqEipwhfx3hArBZY
X-Gm-Gg: ASbGncsMQTCI9sTT+47Wol+GlryyCwPZmkvjTjy27TrTipO6uqw0WYPW66E+aQhsY4n
	UWshmUEOFKllouP4lqmcl0CbWmeCOG20pws8Emv/z2onVnyeUJjhnDLLipPGSIg6ZoHPCnGUHq1
	LyyZsIt0OlLidE92P7hP/hJRn8smZjBAjjx6VDba75RssLElEmuL2H9bFcBXRMw1zSD3FgTZf7e
	r+XqHlbOlbcJjK+xWlDm+/4HKejHVClqY0Vrm8D0+G+Fkzr/68h84iUM5LabMQUhCuVMM0/9A==
X-Google-Smtp-Source: AGHT+IH1hNKXb4/pUf1qyCZudGyGSw9NF8uf8Lrdu7RzgqVV4GV74DwVE6/60XlICJ44BkpiAsKuFWJqqSWZYx9QXyA=
X-Received: by 2002:a05:6402:3246:20b0:634:38d4:410a with SMTP id
 4fb4d7f45d1cf-63bebfa2921mr171979a12.2.1760557211329; Wed, 15 Oct 2025
 12:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 15 Oct 2025 12:39:59 -0700
X-Gm-Features: AS18NWB8AyHrypSBGVaV1zRPTZvCdB6mfFLenAU_JFgUJqaxeHd248FJTuy2y7E
Message-ID: <CAGSQo03-9H58F6GKBta2fH0CjrYNpJcTW=vtyEsL4k3m-YuDMg@mail.gmail.com>
Subject: Re: [PATCH v17 07/11] rust: debugfs: use `kernel::fmt`
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
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
> callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
> support for read-only files").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/debugfs.rs                   |  2 +-
>  rust/kernel/debugfs/callback_adapters.rs |  7 +++----
>  rust/kernel/debugfs/file_ops.rs          |  6 +++---
>  rust/kernel/debugfs/traits.rs            | 10 +++++-----
>  4 files changed, 12 insertions(+), 13 deletions(-)
>

Reviewed-by: Matthew Maurer <mmaurer@google.com>


On Wed, Oct 15, 2025 at 12:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
> callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
> support for read-only files").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/debugfs.rs                   |  2 +-
>  rust/kernel/debugfs/callback_adapters.rs |  7 +++----
>  rust/kernel/debugfs/file_ops.rs          |  6 +++---
>  rust/kernel/debugfs/traits.rs            | 10 +++++-----
>  4 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index 381c23b3dd83..8c35d032acfe 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -8,12 +8,12 @@
>  // When DebugFS is disabled, many parameters are dead. Linting for this =
isn't helpful.
>  #![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
>
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::str::CStr;
>  #[cfg(CONFIG_DEBUG_FS)]
>  use crate::sync::Arc;
>  use crate::uaccess::UserSliceReader;
> -use core::fmt;
>  use core::marker::PhantomData;
>  use core::marker::PhantomPinned;
>  #[cfg(CONFIG_DEBUG_FS)]
> diff --git a/rust/kernel/debugfs/callback_adapters.rs b/rust/kernel/debug=
fs/callback_adapters.rs
> index 6c024230f676..a260d8dee051 100644
> --- a/rust/kernel/debugfs/callback_adapters.rs
> +++ b/rust/kernel/debugfs/callback_adapters.rs
> @@ -5,10 +5,9 @@
>  //! than a trait implementation. If provided, it will override the trait=
 implementation.
>
>  use super::{Reader, Writer};
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::uaccess::UserSliceReader;
> -use core::fmt;
> -use core::fmt::Formatter;
>  use core::marker::PhantomData;
>  use core::ops::Deref;
>
> @@ -76,9 +75,9 @@ fn deref(&self) -> &D {
>
>  impl<D, F> Writer for FormatAdapter<D, F>
>  where
> -    F: Fn(&D, &mut Formatter<'_>) -> fmt::Result + 'static,
> +    F: Fn(&D, &mut fmt::Formatter<'_>) -> fmt::Result + 'static,
>  {
> -    fn write(&self, fmt: &mut Formatter<'_>) -> fmt::Result {
> +    fn write(&self, fmt: &mut fmt::Formatter<'_>) -> fmt::Result {
>          // SAFETY: FormatAdapter<_, F> can only be constructed if F is i=
nhabited
>          let f: &F =3D unsafe { materialize_zst() };
>          f(&self.inner, fmt)
> diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_o=
ps.rs
> index 50fead17b6f3..9ad5e3fa6f69 100644
> --- a/rust/kernel/debugfs/file_ops.rs
> +++ b/rust/kernel/debugfs/file_ops.rs
> @@ -3,11 +3,11 @@
>
>  use super::{Reader, Writer};
>  use crate::debugfs::callback_adapters::Adapter;
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::seq_file::SeqFile;
>  use crate::seq_print;
>  use crate::uaccess::UserSlice;
> -use core::fmt::{Display, Formatter, Result};
>  use core::marker::PhantomData;
>
>  #[cfg(CONFIG_DEBUG_FS)]
> @@ -65,8 +65,8 @@ fn deref(&self) -> &Self::Target {
>
>  struct WriterAdapter<T>(T);
>
> -impl<'a, T: Writer> Display for WriterAdapter<&'a T> {
> -    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
> +impl<'a, T: Writer> fmt::Display for WriterAdapter<&'a T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          self.0.write(f)
>      }
>  }
> diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.r=
s
> index ab009eb254b3..ad33bfbc7669 100644
> --- a/rust/kernel/debugfs/traits.rs
> +++ b/rust/kernel/debugfs/traits.rs
> @@ -3,10 +3,10 @@
>
>  //! Traits for rendering or updating values exported to DebugFS.
>
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::sync::Mutex;
>  use crate::uaccess::UserSliceReader;
> -use core::fmt::{self, Debug, Formatter};
>  use core::str::FromStr;
>  use core::sync::atomic::{
>      AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, A=
tomicU32, AtomicU64,
> @@ -24,17 +24,17 @@
>  /// explicitly instead.
>  pub trait Writer {
>      /// Formats the value using the given formatter.
> -    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result;
> +    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
>  }
>
>  impl<T: Writer> Writer for Mutex<T> {
> -    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
> +    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          self.lock().write(f)
>      }
>  }
>
> -impl<T: Debug> Writer for T {
> -    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
> +impl<T: fmt::Debug> Writer for T {
> +    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          writeln!(f, "{self:?}")
>      }
>  }
>
> --
> 2.51.0
>
>

