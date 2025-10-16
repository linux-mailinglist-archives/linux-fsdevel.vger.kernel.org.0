Return-Path: <linux-fsdevel+bounces-64351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12EBE2355
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DE034FA058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3D30DD2F;
	Thu, 16 Oct 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3TUiDsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B23081C3;
	Thu, 16 Oct 2025 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604216; cv=none; b=rAvakXPKd/rx4+JrOw/GgjNh9wvhNuYicESeIRp6sBoerUiC+ShRDuuorsIxeIvzbmiES67wC+aye7n6l7lM8loTmnam9Hif1zEqkx+y+R67QGSeTufjaIDPqdMNVQAsBHbHRjbrMcxZxRItE46caP3RORJ+bi1Pu2asEWdSPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604216; c=relaxed/simple;
	bh=dG2kopHePGlGHIQgkzE2Ot+qQKYP9mZ35kDCrbYxLcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UoqiDh1itcMTsvXj/H7/2YMVM/sJGJ8Hbc6WMCST+YJGI2arTFkJWqvIHEI4VUA74SMpckOKGUp7bFeDYzATdSdC7gXnGIW0pOCkmb2Vw2bMVMFNw/pNSrWEazlsfBthwHPtzayB+7ECy2sjYXMYHSHRSLXukI/7nolyrKTrzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3TUiDsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9FAC113D0;
	Thu, 16 Oct 2025 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760604215;
	bh=dG2kopHePGlGHIQgkzE2Ot+qQKYP9mZ35kDCrbYxLcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U3TUiDsIVhBP++dTMJkmI7FsKT3vHUGp0J0Xh/tef61JROZxCQP6IZsjdDtbYhI5u
	 HoR4SDRmOrRiWj8z2V+I4SFhqkB4M0szqv2n8/9rnqhniAeuDphe4pXI6Z0xp6CJ3H
	 8IeP/L79oLo70fBltRjDea8D22uJE943rBo+nNCg4BN0G/b5a9aqPOSSp/5YPDF+/r
	 FmYB95TeCFOB2L04OW58Ztu4lryL6AkGr/gMacC0MnZWcNXO8nYYuMqLuzDQiFpF7t
	 lVc8tbvCZwSsO6ItaN57Dq9eC+DHD3JWPArU16lOZWosmB2WH6IwNXwbBF7WzD5MZj
	 8dAANUsgKjkPQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Christian
 Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
 Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Carlos
 Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens
 Axboe <axboe@kernel.dk>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, Tamir
 Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v17 05/11] rnull: use `kernel::fmt`
In-Reply-To: <20251015-cstr-core-v17-5-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
 <RKKuz-9d_SQ5OAoqfvdJBB9gl56enjKQXKLnKjp1A5Vuoj0ub5KkAT6VSmni4sA0uCb70U-Sj7QO3Q8NqI9imA==@protonmail.internalid>
 <20251015-cstr-core-v17-5-dc5e7aec870d@gmail.com>
Date: Thu, 16 Oct 2025 10:42:52 +0200
Message-ID: <87h5vznsoj.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> This backslid in commit d969d504bc13 ("rnull: enable configuration via
> `configfs`") and commit 34585dc649fb ("rnull: add soft-irq completion
> support").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



