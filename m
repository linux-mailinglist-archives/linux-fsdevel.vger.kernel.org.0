Return-Path: <linux-fsdevel+bounces-64701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03516BF1467
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5131892FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F0313270;
	Mon, 20 Oct 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrjI7nyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB792F658F;
	Mon, 20 Oct 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964062; cv=none; b=mbG3EsA+cy1ULpekjXEu3M8qQcXd6Geb5s9WBbLdvgTF/7CBZe2FdffY5fSgH3DIS75+ZsAcFnFSarVKIgBoE4VR7IoSiMv2lIE7meXXqwPT/bEIeHSOG6DSvmqcyOy5EYfURpfIaZAAz3ZB4q89QnMVB6gOvXCUuh/u5IwD4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964062; c=relaxed/simple;
	bh=2eDyYQaO7XlvNmucQ2N+bSeLF1WgVW8OCkfcxnZbWAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVrmwtFTRCxbhLTakPi4HPedN33uJfJqY/uLcIdBOmNU8mXhs8cBRpVAwhDXvzNnyjUjX+B36jmlEA0txH5KGbX+vTigm4aosNZ1VOlH3tbdjn3hpWm62/3+wMRmyeUfDZYl50DlqN65WzVlkWn7O7dIDqjjRT0p7ACNj7rnFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrjI7nyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A43C4CEF9;
	Mon, 20 Oct 2025 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964062;
	bh=2eDyYQaO7XlvNmucQ2N+bSeLF1WgVW8OCkfcxnZbWAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RrjI7nywSvoPgJtWEn6wkCLzobqiGXzkPMkV/lrLTpXQ5oUF5Y091Wh8DPBlcdQ/8
	 oPogfZu/PVk+WjtAWC1/w9xojUR5U/p0o2qwaL2glHaYC+3WOMd4YEofm/Xnev+Esi
	 we3N5TOnAHOXMJCc3J9UrzFNjYBizzCHlzoxbPtcBRU1y+b2MMjlmjtl36IGbvmSap
	 MbLj8KwV36c0HAwhQLFKgUimuO8eaBncdvQapSNM5W2OFBG/zV0C7t7syISPiKXSRb
	 gl4m/l/bxbG/j2g32Ggfjyei9cZRsbWmUTharQyFeV9IzNZwm39/ANX5OgDtNvle+Z
	 mQ07hjugR3iBA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=
 <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, Carlos
 Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens
 Axboe <axboe@kernel.dk>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Breno Leitao
 <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Luis
 Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [RESEND PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
In-Reply-To: <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
 <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
Date: Mon, 20 Oct 2025 14:40:39 +0200
Message-ID: <87plahsq48.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@kernel.org> writes:

> From: Tamir Duberstein <tamird@gmail.com>
>
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




