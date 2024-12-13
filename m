Return-Path: <linux-fsdevel+bounces-37345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80CD9F12CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E09188D942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001E1EBFE8;
	Fri, 13 Dec 2024 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL0V0rrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C01EBA07;
	Fri, 13 Dec 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108472; cv=none; b=ZGbcX0Us3mzAg0KINdbrSLIsr1rT/5I2Q8goTmwELWU5By5OZ7D9S01C3nY9GA3FxOPQNhZupi8QVUe1W+QFlfhJq83IOBjmH1MxQoLQuShUDSmlxrBSy8UAwdvfMpXqFaXW21zOLuuulYcpsPHb1ZS+ZkUe6Om9sewph3cOEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108472; c=relaxed/simple;
	bh=CHtiSnoz+W4eMdUcxoqR2xMXRNGeM2tWEi1FfdMt/pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM8Zqnn8r/I40O6/vp10nGbEAdUIpMaqB5h5Sfr4WyrvkMoiPE2B8J03BLiVScJCK7qBxkH1f1nUGBsfaDcBHugUBxQ0M10JrTQHNdDK8+13jpkbfPzxzEzvlko5l8/kMZXirtAbJd91+lqonif1jTcU01HgP5oUT0h9NNS3Qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL0V0rrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C54EC4CED0;
	Fri, 13 Dec 2024 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108471;
	bh=CHtiSnoz+W4eMdUcxoqR2xMXRNGeM2tWEi1FfdMt/pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EL0V0rrOrfA75N76g2pAVzHro37q/XgT96Seta1QS1+b2GJh4ek26a98ggveHLtZv
	 SPyV2E2chbBJfUNsg4ofppZ4w32PAoYPmzwT7Opc44qc4qmacORGbGXPgjDYsJINTN
	 0N4p0vALr0H43K06cMf6zQjuCWfvupXNlQM95nSTJVsTB7IewG9104l9sM2L/1EYiM
	 AW/pG8KRqy2KRC/Ckxzy37K+31Rbou7evAH3lO6k6A0H2JVKSl8lIloQid6HluWEPt
	 2QpSqglBCFtm6qWC0U9RFtr2ZlwqAdjWG3vCuObHw18SXJ/GtWschlL2J+iUw/1veX
	 x4rzlbd9Kekjg==
Date: Fri, 13 Dec 2024 16:47:45 +0000
From: Lee Jones <lee@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
Message-ID: <20241213164745.GC2418536@google.com>
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
 <20241210-miscdevice-file-param-v3-2-b2a79b666dc5@google.com>
 <20241211115717.GC7139@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211115717.GC7139@google.com>

On Wed, 11 Dec 2024, Lee Jones wrote:

> On Tue, 10 Dec 2024, Alice Ryhl wrote:
> 
> > Providing access to the underlying `struct miscdevice` is useful for
> > various reasons. For example, this allows you access the miscdevice's
> > internal `struct device` for use with the `dev_*` printing macros.
> > 
> > Note that since the underlying `struct miscdevice` could get freed at
> > any point after the fops->open() call (if misc_deregister is called),
> > only the open call is given access to it. To use `dev_*` printing macros
> > from other fops hooks, take a refcount on `miscdevice->this_device` to
> > keep it alive. See the linked thread for further discussion on the
> > lifetime of `struct miscdevice`.
> > 
> > Link: https://lore.kernel.org/r/2024120951-botanist-exhale-4845@gregkh
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/miscdevice.rs | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Lee Jones <lee@kernel.org>

Tested-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

