Return-Path: <linux-fsdevel+bounces-36863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3B9EA00B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9BB1883397
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D95D199EA1;
	Mon,  9 Dec 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A4Mn37YJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3C184556;
	Mon,  9 Dec 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774771; cv=none; b=TotLV9SSr9aZSAn/rmzgligv9T7lb4sxSkMrCB4wGGy1fzaZX0fMvANkrydIU7T8qI5UHvQ6zi89pBldgniw4vVNBlbaDkfwR8cZa9igQPGXlmzpqJsbAODhjykZ0/02lgrbOWAmZe6r/31AxzTmvO7pYVZSL7dGVJO43bwW430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774771; c=relaxed/simple;
	bh=a0KqQJNhivR6oD5B0cFa+tQPszc4KiL2GOSXUov4z/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA/kqnaFP0yOTess7LmbGA5sTuziOhP/CQcip9cOQAgedqoTEp+EiSEpC46jvesDxuDNH9sdzAXBHvsj0F29dDMbEw7XxT+VTvFgYIAqXBirquhD0NmF9p23OqMRJwU1hX75FoajjjuH2JUut7jAjPAv2/4xvaMILsGZ1fVMib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A4Mn37YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35F8C4CED1;
	Mon,  9 Dec 2024 20:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733774771;
	bh=a0KqQJNhivR6oD5B0cFa+tQPszc4KiL2GOSXUov4z/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4Mn37YJEk6WkQgOJvA3m57XIUuVAKWssukXMrvqMgzrWBXSSmb440bOWGPWu0JXN
	 kuJkOWo1aLn5mxQd31WIDjWzxVt74pXjv8yghUDdIvROAm98Uz7d/UWF69PfQpoBGH
	 mbUAIjz2Uph6lpzo8hgcmQV6Q4h3p8UJBZNiHyRg=
Date: Mon, 9 Dec 2024 15:06:07 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Additional miscdevice fops parameters
Message-ID: <tnndwacgkkqdljfqfroel77zufvhw7zpwoe5hnw4pa4pi4fw3n@jszn35kpp4d2>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <2024120936-tarnish-chafe-bd25@gregkh>
 <CAH5fLghxiX8PjJH3s+xcXpJTD_XLuKKEjRM2dOqXkX7n7PoQ6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH5fLghxiX8PjJH3s+xcXpJTD_XLuKKEjRM2dOqXkX7n7PoQ6Q@mail.gmail.com>

On Mon, Dec 09, 2024 at 11:44:04AM +0100, Alice Ryhl wrote:
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >
> > No need to sign off on patch 0/X :)
> 
> That's just the default when using b4 to send series.

Some subsystems use cover letters as merge commit messages, which is why we
put the Signed-off-by there by default. Those subsystems that don't use this
workflow can just ignore it (or switch to using the "b4 shazam -M" workflow
themselves, which has its perks).

-K

