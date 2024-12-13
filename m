Return-Path: <linux-fsdevel+bounces-37346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B09F9F12C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A616AA97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E961F03C3;
	Fri, 13 Dec 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEgQQIMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA291EF09A;
	Fri, 13 Dec 2024 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108497; cv=none; b=P2VG7MyqKmd+9nK/RWbKH7fl025D3lNNUTAtyxWwi/mFyNd7z19VKb8Psb+0YYs7WR43UNWhHtR1GgCtrHVMfALMJUAfMmuLVFAve+KOQ9x0wavq+VFepdgQ7mUlSMFHlH8aoLGWK7bCUOaNccWj3FsUCYkexiRz9c7LNnT7DL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108497; c=relaxed/simple;
	bh=iqodaNwcQy8DjyhSjaVhXhRAKYjFTeod8iz9/BuzS7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmFR+or0wGIXofXv/mB+oLbiRVlZAJg0O1jTowmZ0PAV4jOgorRgR0yN/GAUhnMND1jmF+0SqavTJDQHZRrSTBQZX6QzbZisag5tJhDyL0jRCNTg1ddru9PP7Xbd7eHFqHr43SF28rr+3eW9xNGqDs++ZSmIjihIE4aoJB8DKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEgQQIMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3ECC4CED0;
	Fri, 13 Dec 2024 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108497;
	bh=iqodaNwcQy8DjyhSjaVhXhRAKYjFTeod8iz9/BuzS7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEgQQIMf1dutBJKV2bIJZMzROdoGx/AemYuS2SRGQJTL8OS9tTQUdQmeyqt4HJ0/D
	 Q/nx0O05iBY3aNKRJOIH6F1f4fpOq6tv6iPTNCNFZ5XaPUMnAz087Ei2Dy87XCN3qh
	 exo+6UteJ66wF9B4Fsa/+++zIokG20kKdFmqSrSc2ubT2rkFQuNb9aTCOEUi2FI57N
	 VtQjEjteAzWDHNdUz2NEY2EzzfRPnHMUpOZHTtEkjj3AJDhMSEIs8ep027cATB59w4
	 Ecbr2WQXUkBHp7dsP6jgcbSmDZc1rYGsiRjEQfKB1UzbNENWjO6duwhhlYYsud9H9r
	 09jTFXR9fISXw==
Date: Fri, 13 Dec 2024 16:48:10 +0000
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
Subject: Re: [PATCH v3 1/3] rust: miscdevice: access file in fops
Message-ID: <20241213164810.GD2418536@google.com>
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
 <20241210-miscdevice-file-param-v3-1-b2a79b666dc5@google.com>
 <20241211115651.GB7139@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211115651.GB7139@google.com>

jn Wed, 11 Dec 2024, Lee Jones wrote:

> On Tue, 10 Dec 2024, Alice Ryhl wrote:
> 
> > This allows fops to access information about the underlying struct file
> > for the miscdevice. For example, the Binder driver needs to inspect the
> > O_NONBLOCK flag inside the fops->ioctl() hook.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/miscdevice.rs | 31 +++++++++++++++++++++++++------
> >  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Lee Jones <lee@kernel.org>

Tested-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

