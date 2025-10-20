Return-Path: <linux-fsdevel+bounces-64702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6EBF14F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A713AC62F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC523126B1;
	Mon, 20 Oct 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu6ZG5gM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF1354AF2;
	Mon, 20 Oct 2025 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964331; cv=none; b=jotWm0LZIsEaWTpZri014HoAQQsj0j2BWrrQJXSe5T1TyN8j5c4xvG2f2UoeOGOKlrhUS2FTC0daR/UjTcNO0PgjnBM9rNmDR/GF93NzNCYrORoQndFN3BOwPcuB9CqVbXgjlPeNFaw+uVIHGBMk8a075EMB5N88QlYsrT1Y/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964331; c=relaxed/simple;
	bh=E8/qid2gLwe8oEsR/E/h8omGhNsTE6MoxWDuMvOCa7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9WGSdGJZfTsldgoANGBk5BHPyg8dvkCPzRPkh8Va3JOS9Mr8SCbDI6zKAm02O98uRiquIwfKP5upDrBXVw1S0OC8g4OA63Jb8KuYzviO2PE1LTBcjS/SCLw816YgD9LtHSdxDMhMToXTqlvuUVaKp0Rh3zpWgdW8U0H031iITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu6ZG5gM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FBC4CEF9;
	Mon, 20 Oct 2025 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964331;
	bh=E8/qid2gLwe8oEsR/E/h8omGhNsTE6MoxWDuMvOCa7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Vu6ZG5gMwnWnP18yIjq2Coml/n0/etetWYWhQZndfqasBjVzf2+h5BcpQunp2EHn+
	 wGk7ekgx863EYYacdpB1OViSJRoC/l+XSwl1uxM7EYG1sY2UggNWDXRgP0RB32Cmgj
	 DYpE2VPAWFKtWebkc5BpwpHugLyOqiCYSQGnaLoYNivILMG7GpOKZwfRXenNfGijBK
	 kdVZ6fLrKUefCxsbWH2QDLTtYHCOxzHkiFAe3sxmEx6ysXqBlcDPo+72hmNat+tBlr
	 HjH1ho9WQs3EnNIXnmRbNVoOQu9DpFY8DL27jefzvOZemLusSCC7in5APibiIwOgZf
	 ji8HRf0c9RL3Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, tamird@gmail.com
Cc: Liam.Howlett@oracle.com, airlied@gmail.com, alex.gaynor@gmail.com,
 aliceryhl@google.com, arve@android.com, axboe@kernel.dk,
 bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 brauner@kernel.org, broonie@kernel.org, cmllamas@google.com,
 dakr@kernel.org, dri-devel@lists.freedesktop.org, gary@garyguo.net,
 gregkh@linuxfoundation.org, jack@suse.cz, joelagnelf@nvidia.com,
 justinstitt@google.com, kwilczynski@kernel.org, leitao@debian.org,
 lgirdwood@gmail.com, linux-block@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, llvm@lists.linux.dev, longman@redhat.com,
 lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com,
 mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com,
 mturquette@baylibre.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, nm@ti.com, ojeda@kernel.org,
 peterz@infradead.org, rafael@kernel.org, russ.weight@linux.dev,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, simona@ffwll.ch,
 surenb@google.com, tkjos@android.com, tmgross@umich.edu, urezki@gmail.com,
 vbabka@suse.cz, vireshk@kernel.org, viro@zeniv.linux.org.uk,
 will@kernel.org
Subject: Re: [PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
In-Reply-To: <20251018180303.3615403-1-aliceryhl@google.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018180303.3615403-1-aliceryhl@google.com>
Date: Mon, 20 Oct 2025 14:44:56 +0200
Message-ID: <87ms5lspx3.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> From: Tamir Duberstein <tamird@gmail.com>
>
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



