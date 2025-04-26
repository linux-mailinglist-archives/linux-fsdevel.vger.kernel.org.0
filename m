Return-Path: <linux-fsdevel+bounces-47452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB0A9DCF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 21:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9143D1B67D97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FDB1F09AF;
	Sat, 26 Apr 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl8BRUVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7019DF8B;
	Sat, 26 Apr 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745696987; cv=none; b=CGRhjGg3lvdRdNaP6UlR2edUdFahxznBZo2bPAe9y9Shbd7gUU7hSFZKqvPZqPOuVMYDD1mJ4OxQA+LOL3Kq6g0oJ465/FV/TnmGc86A8sSzx4Qw7lm2yqYV1o+CvebYzrDu9OXhBbKSEeVK9mDC8fsM11HmNt/d4Ah0B78oFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745696987; c=relaxed/simple;
	bh=0QhmbA6z9dDYLS2F8XMNw6kfXNMzDVFZileQBPf7FD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=okIkNX15cUJe2maHEvmjeF51o3tdzRbBKasUh/YyRw/U8BYvLSWLagOkm5P/2C6bYxQ3jvxHJiRzIASwJABcfFPZQ0CpcFzy15unN5D5ktUE9jNObdmexf0P60jGuWQhjN1UgvYPpV8r/ggYc1q0enFcYLpBlARE/7XeXXM25hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl8BRUVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46ADC4CEE2;
	Sat, 26 Apr 2025 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745696986;
	bh=0QhmbA6z9dDYLS2F8XMNw6kfXNMzDVFZileQBPf7FD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rl8BRUVWnwk40+UZPvP+4t2WYn8HGeTQNpGvPvvDZsEbd9JMOIGCz9r6KaNAfKeU1
	 EO+/2SfjbKWzSh50Pg3Fib7v9rcn4S+8ULMAPQIfOTMQSrw9oiRT8v+R71aJ8sMtM9
	 5BIlgUfsBeW98YAtX37EGKQpUOj6FT3AJQuKj6bUavnjdUtDBoyqTjrXerWE5fW6/3
	 EQegwLXDdRU9oMK3h0da3CBdFZ9SbUyrHMLwNu/SRdE9EQlI2gcA43M994ftrnE5+h
	 9Evt3Hdfenz1iQNEkJC9DvK9SLqg9i70zcTT4g3xFucbQ/H4HKxw0XDDJUPgBXC88l
	 cr6KcbYFXdFcw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Tamir Duberstein <tamird@gmail.com>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
Subject: Re: [PATCH v19 0/3] rust: xarray: Add a minimal abstraction for
 XArray
Message-Id: <174569693396.840230.8180149993897629324.b4-ty@kernel.org>
Date: Sat, 26 Apr 2025 21:48:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev


On Wed, 23 Apr 2025 09:54:36 -0400, Tamir Duberstein wrote:
> This is a reimagining relative to earlier versions[0] by Asahi Lina and
> Maíra Canal.
> 
> It is needed to support rust-binder, though this version only provides
> enough machinery to support rnull.
> 
> 
> [...]

Applied, thanks!

[1/3] rust: types: add `ForeignOwnable::PointedTo`
      commit: a68f46e837473de56e2c101bc0df19078a0cfeaf
[2/3] rust: xarray: Add an abstraction for XArray
      commit: dea08321b98ed6b4e06680886f60160d30254a6d
[3/3] MAINTAINERS: add entry for Rust XArray API
      commit: 1061e78014e80982814083ec8375c455848abdb4

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



