Return-Path: <linux-fsdevel+bounces-66488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64695C20C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7F1425A22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95590296159;
	Thu, 30 Oct 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ/8uG9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EB283FCE;
	Thu, 30 Oct 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836269; cv=none; b=LfAKhJ15xOkOJKu3mQTedEhouLmFizZUDoRqIH51ttJ6tl4SZFN/sGH1De7J7u660PbN8JMYQIZKu0ivBa1MDbrwGGMMJkYVTQpPuOcD/swkG8p87MrLLWrnuv8BuSb2psaJL74xdLPMTnXlFUrnaDszJGwRLW6TAIeItfCSi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836269; c=relaxed/simple;
	bh=MPH444EZaU6hB0oe8fwJQJCQuWbHbzn+g5+EsUVpY/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KihXs2Ax3cH2oVD0pN973jrvPe2rorCPQj8pvasGthU/0WVTXraqL/evd8Hah4wOiAqBxLX8HxZGyovBM38GV3Zi6BEPtPcbyr0cWO2gnhWUcdMIPXlj9BDMBmayDSWtOp/X0HibMBVJvhRdz08gvwL7k0slifE9WiEDoEUfsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ/8uG9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D33C4CEF8;
	Thu, 30 Oct 2025 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761836268;
	bh=MPH444EZaU6hB0oe8fwJQJCQuWbHbzn+g5+EsUVpY/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NZ/8uG9sgSxgb3j2CP8YltLWsQB47scQpxGKcbR+MrBAvSTgaYZddAH9NvQVGxgCw
	 jMpUMahh2MOfXnnLoIWYFzo/z5SUQWH6OtWirV1MskoUFnhA0Lw3LEVhTLAJ4ge2sB
	 EaW7Xt7Ts72Nt2tAEOjVuHrEoE4oiAUc53DYyXuydo3/t8rkO7kS4zaierKba829eG
	 lTVRQZtleWTO1rimqLOyp5tt4yk56zMv3caXQ/wkevBe5n0RkWPmE2h5jGuWpQ60AL
	 gx4egPU999DB+RUobTImD6plP3mbmCWsKA1FWaCseeITaGgey0cf7mVcCxCSzZaRaR
	 zCQ0turLOoXvg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno
 Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Asahi Lina
 <lina+kernel@asahilina.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, Oliver Mangold
 <oliver.mangold@pm.me>
Subject: Re: [PATCH v12 2/4] `AlwaysRefCounted` is renamed to `RefCounted`.
In-Reply-To: <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
 <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
Date: Thu, 30 Oct 2025 15:57:35 +0100
Message-ID: <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oliver Mangold <oliver.mangold@pm.me> writes:

> `AlwaysRefCounted` will become a marker trait to indicate that it is
> allowed to obtain an `ARef<T>` from a `&T`, which cannot be allowed for
> types which are also Ownable.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>

Please update the title to

 rust: rename `AlwaysRefCounted` to `RefCounted`

No period in the summary line.

With that, you can add my review tag.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Since this patch touches so many moving parts of the rust tree, it is
going to be a cat and mouse game regarding rebasing this thing. It also
touches a lot if peoples code. I am not sure how something like this
would merge. Do we need ACK from everyone @Miguel?

Best regards,
Andreas Hindborg




