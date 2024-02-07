Return-Path: <linux-fsdevel+bounces-10570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494E84C54D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028111F2759E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924241CFB5;
	Wed,  7 Feb 2024 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QRSkfQQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413011CF8B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289136; cv=none; b=PQ7tFVv6cJc4HA54eJJL7iryPT8sIHxvFM4kWIwYfnw4jqTsvtFfXLqR8GaW/bs7kE3sYPWwyrYkk8UMMzEdlB4lvaoZ2OKJNoI0ZZORB00d4czmk89cNqdddp1c/kG8ecqovH1YmQ68M4H8vjztndlo7/gsjJxlQ97cVnbqTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289136; c=relaxed/simple;
	bh=hGQdL7Pb3ieOdj6NN/Nx2EaOMhnf7hDUVPdl0cr8epc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHtcQrB854VFk8aQK/g0VOHaACJ+qVmCgTrmAVEEGZNLBofD5N1Yi9TTHcXA9uCpu/6dclItjwcDudOHBUHCPZespGgoIdcL6VEAw2nfxyaY1n6k5xIsrUr4MTXBrrWeJrL4h80UJcfbwtMDhSJmv5q5SJgIi7/HLaJ2YhLWQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=QRSkfQQH; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604713c4ee5so2954707b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 22:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707289131; x=1707893931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qADUWqhu/lzA1GSQbIFX5bCS8/LLHdKCMAhzZYJcLro=;
        b=QRSkfQQHH7S3S5EKo8rW27TghaM894kukGz+Jd12+x+H4jKQzSAUYxCLvQRJ7fl8Tm
         VRcICHUwjf5EDQ7Ub5hmUTJxRe/BUoCEQBzM2nX/ulBNLPY057fRLcKfIG70KHT4q90c
         rs2QCYHmVaKnTNO9CuwHcQKRmuaVBK2Ein4thiOe1sHbdvhddRgJ9xw+hvnG1JjhDdY9
         KdWjvI95wYbEOeNk2yYC7QPrla44DfR6iPSDMm29lLFORAmKyFdM9yVfdCtti6tr3u/A
         S9r9KTDAMoknLQeMyjrRkjBww4z3Zt+U4/kp3jYbNhSxcl/5XdJr3V+GaFCbd21pfJD+
         LbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289131; x=1707893931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qADUWqhu/lzA1GSQbIFX5bCS8/LLHdKCMAhzZYJcLro=;
        b=v0OUEOqyDyv9upzN7pEU93FYMPIE0e4NMBOZKxnhEOmaPdp0LwKPyhIB00f1UdPXwD
         AIgboizI0W88UFWZgapoOa9SZ+lMVjUtZPSLhQgEDlmrctTusiVjrXVE43FgKWYi/onK
         DNrMihc0J0BlRVHKdeEGx4im0rrwEfMdW0IS9M0QPcDL+NNNmn42WsFKJNCjj8xsa7Qi
         6DojRmxB2WqPDLzF1F+87JdjP7PcnVqk1wDNr49oc4mKOEGRGpYZ9xYQ4b9FsM7U+3yF
         bej6jazQakADgZytX3+C53gClIFE7gEtmXQ3jnX3+Me6yMvcgfPeJHYE8czfL5s44wEC
         //bg==
X-Forwarded-Encrypted: i=1; AJvYcCUziMvxLLl82OjroM8sWYrZv4fpP3AmaefduoXi/7xzBCED9ZZAPiI/XWChE5YnkswuJ2ptlxvXCfUzzdNryHu/I3wiNhZyFLcD0Dw6Wg==
X-Gm-Message-State: AOJu0Ywzdoy1BymOREzE6vjzuA6/VLWMGC47XcbG/01hpADJ7Jszl6X8
	0Z577Q2fIDmaYhyhrYsgupj+5Ia7HhmBD5VSavpf9QqZ0IYYL6VLXIjHeZvBaOGZrPQDbUWS2mo
	jQT/DGCMAFPgkgCKdNCRSyUKk8ZntrVEJHnTGXw==
X-Google-Smtp-Source: AGHT+IEaePtWGAcs6cY6BlYozZs9/7GM+wHXN+9aCjmPI/3evE1sIwzWlPkWpdgiK4VRxdNqtj3F00+U+axcbSHU9rI=
X-Received: by 2002:a05:690c:72f:b0:604:11f9:5bfb with SMTP id
 bt15-20020a05690c072f00b0060411f95bfbmr4250202ywb.18.1707289130986; Tue, 06
 Feb 2024 22:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207055845.611710-1-tahbertschinger@gmail.com>
In-Reply-To: <20240207055845.611710-1-tahbertschinger@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 7 Feb 2024 01:58:40 -0500
Message-ID: <CALNs47u9QU2t1ug9_3_-nPzJCOR=uAHpuCT-yVd-MfWFkVVeYA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] bcachefs: introduce Rust module implementation
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kent.overstreet@linux.dev, bfoster@redhat.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:59=E2=80=AFAM Thomas Bertschinger
<tahbertschinger@gmail.com> wrote:
>
> This patch uses the bcachefs bindgen framework to introduce a Rust
> implementation of the module entry and exit functions. With this change,
> bcachefs is now a Rust kernel module (that calls C functions to do most
> of its work).
>
> This is only if CONFIG_BCACHEFS_RUST is defined; the C implementation of
> the module init and exit code is left around so that bcachefs remains
> usable in kernels compiled without Rust support.
>
> Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
> ---
>
> [...]
>
> diff --git a/fs/bcachefs/bcachefs_module.rs b/fs/bcachefs/bcachefs_module=
.rs
> new file mode 100644
> index 000000000000..8db2de8139bc
> --- /dev/null
> +++ b/fs/bcachefs/bcachefs_module.rs
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! bcachefs
> +//!
> +//! Rust kernel module for bcachefs.
> +
> +pub mod bindings;
> +
> +use kernel::prelude::*;
> +
> +use crate::bindings::*;

Most in-tree code uses the `bindings::` prefix when referencing C to
make extern calls clear, rather than doing the glob import. I think we
probably want to keep this style.

> +module! {
> +    type: Bcachefs,
> +    name: "bcachefs",
> +    author: "Kent Overstreet <kent.overstreet@gmail.com>",
> +    description: "bcachefs filesystem",
> +    license: "GPL",
> +}
> +
> +struct Bcachefs;
> +
> +impl kernel::Module for Bcachefs {
> +    #[link_section =3D ".init.text"]

Is the attribute still needed if this lands?
https://lore.kernel.org/rust-for-linux/20240206153806.567055-1-tahbertschin=
ger@gmail.com/T/#u

> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        // SAFETY: this block registers the bcachefs services with the k=
ernel. After succesful
> +        // registration, all such services are guaranteed by the kernel =
to exist as long as the
> +        // driver is loaded. In the event of any failure in the registra=
tion, all registered
> +        // services are unregistered.
> +        unsafe {
> +            bch2_bkey_pack_test();
> +
> +            if bch2_kset_init() !=3D 0
> +                || bch2_btree_key_cache_init() !=3D 0
> +                || bch2_chardev_init() !=3D 0
> +                || bch2_vfs_init() !=3D 0
> +                || bch2_debug_init() !=3D 0
> +            {
> +                __drop();
> +                return Err(ENOMEM);

Do these init functions ever return anything more descriptive than
ENOMEM that should be returned instead? Maybe not worth changing if
the next phase will let you `?` the results.

> +            }
> +        }
> +
> +        Ok(Bcachefs)
> +    }
> +}
> +
> +fn __drop() {

Something like `drop_impl` or `unregister` is probably more in line
with naming, dunder is really only used when something
unstable/generated needs to be made public.

> [...]

Cool to see the ball rolling on this :)

- Trevor

