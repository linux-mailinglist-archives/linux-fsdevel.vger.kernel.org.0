Return-Path: <linux-fsdevel+bounces-47454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C32A9E39B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7924A189B5BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490861B4153;
	Sun, 27 Apr 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAlczry0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBF5661;
	Sun, 27 Apr 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745764782; cv=none; b=gkTkjXG1iMFvOojG3r7JvDfkrgpBhLhFgnfogM4BtaLFlqZoycq+w8+qAzmWV/c5ora79hviAndnCIb/LQVLe3w7pL4nwaFTRMPFhmcO+HbPy6WlfQk0VqNi1thbnUSX9NzArUcuqwIEUBWIxTsb1yd0Xl2NM3pvX3jivI+cNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745764782; c=relaxed/simple;
	bh=fbBigoq2W+bx4bPJxUWbLtRO3onZsaYE5SivwASh1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE5UjNXyd54Ne0lTCXHWoUsV5rJwnt4OFBxp/JVrTqrOfZm/qQ5EdXXSCboYUG0fkDvWfPuS7wyR43oqhuD3T1WPBBXNhqjiOUvPEucKBCE4WLDgNqo8Zqw8KSYs5jMW2Qi0gkraRO1kCGf8MdwfuH9icA2JHAKbXjIJ5IwSEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAlczry0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38093C4CEE3;
	Sun, 27 Apr 2025 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745764782;
	bh=fbBigoq2W+bx4bPJxUWbLtRO3onZsaYE5SivwASh1HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAlczry0TuDiPzZZk5y2H5caEWUCSEuRlNrL1biBBK+AupfgJJ2xp5T0fII0EhX02
	 oSugYcnXR1+cNK5GpSlNt0w6H2l/PjW18IT0ABeyFQeX/JMKslkhKmiGUD7T1GzmRf
	 rIib+aZ2q96u5qyIZf/Ail8xEDfzngDmbmbvi6M2MM2NwUNv1SFGc6mojIwCHBNPtZ
	 +lzlHrfuW42zuKPNjhN7RRTCbtAJplpudSzKOUjYeortbxnW77aMhQ47BWcGSsRjc5
	 AsMYXnWuSsEoCuNh+nykBD7LqxrJU99sVaJ3fPIibFA0w6RQc1BPcrCcBr9bNXfysC
	 zi7UU6VAP03FA==
Date: Sun, 27 Apr 2025 16:39:35 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v19 0/3] rust: xarray: Add a minimal abstraction for
 XArray
Message-ID: <aA5Bp3Psj7yWg9wu@pollux>
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
 <174569693396.840230.8180149993897629324.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174569693396.840230.8180149993897629324.b4-ty@kernel.org>

On Sat, Apr 26, 2025 at 09:48:53PM +0200, Andreas Hindborg wrote:
> 
> On Wed, 23 Apr 2025 09:54:36 -0400, Tamir Duberstein wrote:
> > This is a reimagining relative to earlier versions[0] by Asahi Lina and
> > Maíra Canal.
> > 
> > It is needed to support rust-binder, though this version only provides
> > enough machinery to support rnull.
> > 
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] rust: types: add `ForeignOwnable::PointedTo`
>       commit: a68f46e837473de56e2c101bc0df19078a0cfeaf
> [2/3] rust: xarray: Add an abstraction for XArray
>       commit: dea08321b98ed6b4e06680886f60160d30254a6d
> [3/3] MAINTAINERS: add entry for Rust XArray API
>       commit: 1061e78014e80982814083ec8375c455848abdb4

I assume this went into xarray-next? If so, you probably want to adjust the
MAINTAINERS entry accordingly.

