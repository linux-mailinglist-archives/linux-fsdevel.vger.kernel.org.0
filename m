Return-Path: <linux-fsdevel+bounces-30186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1C98769E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E710B1F21A32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92231531CC;
	Thu, 26 Sep 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qBOdu2mQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50A4D8C8;
	Thu, 26 Sep 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365005; cv=none; b=qeSP387rb2PV8XW4cw4uwv8iZrT1KUKEsFt2SgEKK/flaPuDTeADpKrdwlL0K+YGkk2zn7CfkCbzXq39syGA3Lq6pCFetKkia+hpinJXmuS+gKJEb2V+/CZxwW0Nmlpvr8oy5HqvI2W0A2g0Sv0eVo820pJxBab2MKcAHjN4QeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365005; c=relaxed/simple;
	bh=MnHn5Un5GctlEYw8FQfVsnDO6azbNmYGLMtZ416WHA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdZpeZR8te6KtTJX7MrHu5srBAWGaM65vqooga+55vHk4H1MeezNSG8DZq38iYKSdRSQbSGPLvrETVlDBvp9BqhGlpOvuhoyxP9/qa1zygL6faBsdfkhE0CH7pQOgexfFTmt0Hl9t9c4VOOKMrn0ZArQrzBvDu8o6HBppmLY57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qBOdu2mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17978C4CEC5;
	Thu, 26 Sep 2024 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727365004;
	bh=MnHn5Un5GctlEYw8FQfVsnDO6azbNmYGLMtZ416WHA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBOdu2mQaW34VK0viO1CHr5mi7XaLWDsdmQj2Llx95tsJec3C1IqknVDGCsoK+fqA
	 E+EQUeVouFnJ3ljflOzTf85FnnQEFOMTwc15jRFIJ481Mj33Sr32CVpQutCjg9zDve
	 i6huG2wAlwqAeupmGmUnTbsdkq8YKSIV0AB3e+og=
Date: Thu, 26 Sep 2024 17:36:41 +0200
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
Message-ID: <2024092657-snorkel-unmovable-7a6a@gregkh>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <2024092647-subgroup-aqueduct-ec24@gregkh>
 <CAH5fLgh8DE8cPC+-HPz6vshCwToA2QyGqngj77N9x16cAUfpiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgh8DE8cPC+-HPz6vshCwToA2QyGqngj77N9x16cAUfpiQ@mail.gmail.com>

On Thu, Sep 26, 2024 at 05:20:15PM +0200, Alice Ryhl wrote:
> On Thu, Sep 26, 2024 at 5:05 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 26, 2024 at 02:58:54PM +0000, Alice Ryhl wrote:
> > > A misc device is generally the best place to start with your first Rust
> > > driver, so having abstractions for miscdevice in Rust will be important
> > > for our ability to teach Rust to kernel developers.
> > >
> > > I intend to add a sample driver using these abstractions, and I also
> > > intend to use it in Rust Binder to handle the case where binderfs is
> > > turned off.
> > >
> > > I know that the patchset is still a bit rough. It could use some work on
> > > the file position aspect. But I'm sending this out now to get feedback
> > > on the overall approach.
> >
> > Very cool!
> >
> > > This patchset depends on files [1] and vma [2].
> > >
> > > Link: https://lore.kernel.org/all/20240915-alice-file-v10-0-88484f7a3dcf@google.com/ [1]
> > > Link: https://lore.kernel.org/all/20240806-vma-v5-1-04018f05de2b@google.com/ [2]
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >
> > Does it really need all of those dependencies?  I know your development
> > stack is deep here, but maybe I can unwind a bit of the file stuff to
> > get this in for the next merge window (6.13-rc1) if those two aren't
> > going to be planned for there.
> 
> Ah, maybe not. The dependency on files is necessary to allow the file
> to look at its own fields, e.g. whether O_NONBLOCK is set or what the
> file position is. But we can take that out for now and add it once
> both miscdevice and file have landed. I'm hoping that file will land
> for 6.13, but untangling them allows both to land in 6.13.
> 
> As for vma, it's needed for mmap, but if I take out the ability to
> define an mmap operation, I don't need it. We can always add back mmap
> once both miscdevice and vma have landed.

Yes, let's drop the mmap interface for now, and probably the seek stuff
too as most "normal" misc devices do not mess with them at all.

If that makes the dependencies simpler, that would be great.

thanks,

greg k-h

