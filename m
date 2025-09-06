Return-Path: <linux-fsdevel+bounces-60449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD2B46AFF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 13:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537221B220A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99AD27F732;
	Sat,  6 Sep 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SxdClgEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EA18DF8D;
	Sat,  6 Sep 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757157788; cv=none; b=q+0NtYr4PDO1jeHNPNaYNrbhj6qhFJ7AnTEUFucWqNLLQ8IsYJ/qWH76W0yiJdLAFI0TzpN1s9dF6HqDg3Yz6NQMT84iCE77ObNo2+ddy44CMf+k3VtgOLAcscd6rPlXioDbaYJmmBFV1R2/MjEjeGn6Ia1BT3kDbo6jZhGOkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757157788; c=relaxed/simple;
	bh=L9+2WEni2nbXwFjfdFAMVWEbqbdgloEAYqjQNq8sd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZsVzTXbVB2AodATLqICVwc4mkeTa1Q/vdzTnSooAufq+FT8zsycEDfHH8BhhUmf/A958cfjd8356C7OjnpWrUCtrXNPa+RuzmF4SMDZl70naVf9wyDbVNcUFjZd8vKC9kTTxnpD3oOB0bC4YUYJXnXAyoHDSHw2JK3cIs0YAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SxdClgEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BA2C4CEE7;
	Sat,  6 Sep 2025 11:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757157787;
	bh=L9+2WEni2nbXwFjfdFAMVWEbqbdgloEAYqjQNq8sd6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxdClgEZa/fMc3yIgcPtqO5hcFl4BNtsjygFVS9EUP43p8uJs6Op1pVLPEZkqHsfn
	 R5zULYIHCyXSx9ZVz9iKJkvTOtjHIvRnNDa9rMQri9MIstb9XpxJaNOtcMV6SfNT7R
	 P6LdYE8waoC25NvuemHvNFjAhHhnQ6zsn5OrbJOg=
Date: Sat, 6 Sep 2025 13:23:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Benno Lossin <lossin@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 0/5] Rust support for `struct iov_iter`
Message-ID: <2025090657-laboring-entrap-e323@gregkh>
References: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>

On Fri, Aug 22, 2025 at 08:42:31AM +0000, Alice Ryhl wrote:
> This series adds support for the `struct iov_iter` type. This type
> represents an IO buffer for reading or writing, and can be configured
> for either direction of communication.
> 
> In Rust, we define separate types for reading and writing. This will
> ensure that you cannot mix them up and e.g. call copy_from_iter in a
> read_iter syscall.
> 
> To use the new abstractions, miscdevices are given new methods read_iter
> and write_iter that can be used to implement the read/write syscalls on
> a miscdevice. The miscdevice sample is updated to provide read/write
> operations.
> 
> Intended for Greg's miscdevice tree.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Now queued up, thanks.

greg k-h

