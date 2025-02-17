Return-Path: <linux-fsdevel+bounces-41863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107FA386F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70AD07A1B05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC26224883;
	Mon, 17 Feb 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVYm4WSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65129223321;
	Mon, 17 Feb 2025 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803926; cv=none; b=Ah90Y/hQU1gEZ6hQH17VFL5k2+Z8GiZXvIxu6M9mSFvxFA4bVF9NGXep8BU+tGwb19q7BxnMelXAxeeU6QcvVpa1+yBFn1bU6BBTxDBTlvk1nj1DtTg0ZhYMNAv/O1ZFW7nOWdRdjoJjaRoy8pjHmW0e+/io9fTIABhZKLkBzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803926; c=relaxed/simple;
	bh=rO8qVsU8BgLOdQFqlb7PVK3vWPmC4h82WGd08o6I/fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feXsIuWJ8jdG//MFCHZ9H6aq74735nGmg87D2CbWUvmxa9Z7hC8Ec7sJKLLV0e+B6NnBO4zJWW5XLb73St81+eHqbr4nQgzygJbt0M2RDIfLsh+0R751i9FQMtX2V8XkRMd6TTfDY1q4Y7Q9CvxyWMGjTkdtWfU/C+wv/IVTR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVYm4WSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1B9C4CED1;
	Mon, 17 Feb 2025 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739803925;
	bh=rO8qVsU8BgLOdQFqlb7PVK3vWPmC4h82WGd08o6I/fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVYm4WSwhlxEOWwJRaXT1FHIPsX5mwO7+4pRSfyrAtaQgOyzVNC4enh8QZVjSO9zg
	 97qjYoQ/X4KFlsHaddYGLplZaMY8on5zXtsGOvSeudsujawg06mOiwzxSp2P6pv199
	 aMOZsGNrLHH0GyJNBtMjoj8eAYX3MJ3d9WFbCmkYbJpB27kBzFJ6XWycMVb2SHFoHV
	 uVHlXbuMJB8NrS9cPE+hnKIFZ+5CQe8l1SVDtGXeo1gdzK1xlxEaIJ4dAEojLuEifR
	 sL8yH09kmqn98QTEQ/SF8Vjhz1/8jm5qHe+xeZpp97b0lBeZ8XAc8+IGOAaz9dGWlg
	 aTSAswT6StZ3A==
Date: Mon, 17 Feb 2025 15:51:58 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <Z7NNDucW1-kEdFem@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae>
 <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae>
 <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
 <Z7NJugCD3FThZpbI@cassiopeiae>
 <CAJ-ks9mcRffgyMWxYf=anoP7XWCA1yzc74-NazLZCXdjNqZSfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mcRffgyMWxYf=anoP7XWCA1yzc74-NazLZCXdjNqZSfg@mail.gmail.com>

On Mon, Feb 17, 2025 at 09:47:14AM -0500, Tamir Duberstein wrote:
> On Mon, Feb 17, 2025 at 9:37 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > You're free to do the change (I encourage that), but that's of course up to you.
> 
> I'll create a "good first issue" for it in the RfL repository.

That's a good idea -- thanks.

