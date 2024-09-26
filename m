Return-Path: <linux-fsdevel+bounces-30183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37900987635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9336FB26953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311A14BF8B;
	Thu, 26 Sep 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBc/gFHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5852E56A;
	Thu, 26 Sep 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363140; cv=none; b=vDC/2smoMTQShlT1opW7aSfq3pJxq6BKzdRPO+KTNGhGGSQdGewLvZhqAEPK0/S5DO+hoibPFm9pQPu7UEjUKdJ14VTUc/Z0H/f6GfH/JaUpHkJzdryok+/F1xlgG60S7QdXoPDEOPRw9AUx9NaeiYyR13i2pgetBWXIPSFny4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363140; c=relaxed/simple;
	bh=/NGdEFNyrAbKge3yFgZc4lPX3H1bXgr4e2H1TEfy630=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWd1i74DkMijrzmyIvlhU65IoJYvWKQPcQKJm4P7Wyskc2CO1TSZ8doNJdZX6eZ8Ro9hgDc2V6tgT7q7HRi28/kEzxWXM4Rb7eD7H8AliuHzsHW71u94SeKXf9mfJY4gCms0opqo6kwcfXKobqSBEvWuoTeO2ZQYDe1a/LkOdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBc/gFHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F15C4CEC5;
	Thu, 26 Sep 2024 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727363139;
	bh=/NGdEFNyrAbKge3yFgZc4lPX3H1bXgr4e2H1TEfy630=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBc/gFHnNdzdAs6CNYvZpTJjvZ9DFM3wkruwCecoVPTNp4xncYRoa7roHTynT6z4p
	 08fRxhMJzMt4RcloKu0Pv13EuNMRaocY7fH6D1uvCCexXBOOfjpgVY3wuM6atFC7ei
	 ajCPrjM2duKFwThWNaSrjYX1PdwJIILTrhpJmSSk=
Date: Thu, 26 Sep 2024 17:05:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Miscdevices in Rust
Message-ID: <2024092647-subgroup-aqueduct-ec24@gregkh>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>

On Thu, Sep 26, 2024 at 02:58:54PM +0000, Alice Ryhl wrote:
> A misc device is generally the best place to start with your first Rust
> driver, so having abstractions for miscdevice in Rust will be important
> for our ability to teach Rust to kernel developers.
> 
> I intend to add a sample driver using these abstractions, and I also
> intend to use it in Rust Binder to handle the case where binderfs is
> turned off.
> 
> I know that the patchset is still a bit rough. It could use some work on
> the file position aspect. But I'm sending this out now to get feedback
> on the overall approach.

Very cool!

> This patchset depends on files [1] and vma [2].
>
> Link: https://lore.kernel.org/all/20240915-alice-file-v10-0-88484f7a3dcf@google.com/ [1]
> Link: https://lore.kernel.org/all/20240806-vma-v5-1-04018f05de2b@google.com/ [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Does it really need all of those dependencies?  I know your development
stack is deep here, but maybe I can unwind a bit of the file stuff to
get this in for the next merge window (6.13-rc1) if those two aren't
going to be planned for there.

I'll look into this some more next week, thanks!

greg k-h

