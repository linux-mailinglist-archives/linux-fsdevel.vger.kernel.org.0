Return-Path: <linux-fsdevel+bounces-73904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C9D23540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3416301B12E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB0342530;
	Thu, 15 Jan 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgJ7Z2Xl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E433DEF9;
	Thu, 15 Jan 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467768; cv=none; b=kL0ErlcNatTC74Gp0rTQTyYSJeO4MaTSaISLHwHwo9uZjsUHqx6IGpr6RzBydDrvuyTkEtla10fW6b9cwxbpd8ybfDWWwmgR1hjhEMv95UGns6sg+Asv9CHbV+32v80/0h8eOC2jaIH5WK+AilqEX5KY4FQfWFdk5VGQr4+9A88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467768; c=relaxed/simple;
	bh=DrUlgAreRjMLVp7ZtlPiPfu7LA5dkOhKlrNbuz3KAdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M0gWOc6PzRPiMRvOF5DzmYPItjg3GekgNerNug/qX77jxTOsklD3AMU7XeO9j05y5IxPy/i9T5ebqwdSTo5rdc40PXZFzF1gtrAdBBhZmltcmqYoSxCFz9/SD6Qf8NwzoDrrKch1NyR/+1EyMtlznihVmI9nHi1HMz4Az67zBgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgJ7Z2Xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199EEC116D0;
	Thu, 15 Jan 2026 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768467767;
	bh=DrUlgAreRjMLVp7ZtlPiPfu7LA5dkOhKlrNbuz3KAdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fgJ7Z2XlqAEcp8dWpgnsTRv3MgBc47pmJeBopSoKgoZTjNjNzMe26Vc5tNXHzCOzo
	 GJgG2XHGWTNvUvRK1S74RWgVebCzuHtB/iz69IJHCQedcNE0NIVU7utMuabHZPkA92
	 qRYi4tovpuqrxkCiaIVaIF5CakRERK8RM0dmVrvF01swtY86unWmmXr1bvLU+7pCCb
	 ZQM3PSgQiUw6Qs6odqoHTAn54XFiEXku9TjgWI3AVhZRk/t1SkyXB+FTkQaKOKQebv
	 LWiKtrKJjPXUeTCK4ietsJqOhnHYTo1pHDCdBEZOLXSjCA1SLUqqPL75yvffhcXF+E
	 vqZWVqqY0J13g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20260105-define-rust-helper-v2-27-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
 <20260105-define-rust-helper-v2-27-51da5f454a67@google.com>
Subject: Re: [PATCH v2 27/27] rust: xarray: add __rust_helper to helpers
Message-Id: <176846772738.752326.14630458466153959186.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 10:02:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Mon, 05 Jan 2026 12:42:40 +0000, Alice Ryhl wrote:
> This is needed to inline these helpers into Rust code.
> 
> 

Applied, thanks!

[27/27] rust: xarray: add __rust_helper to helpers
        commit: c455f19bbe6104debd980bb15515faf716bd81b8

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



