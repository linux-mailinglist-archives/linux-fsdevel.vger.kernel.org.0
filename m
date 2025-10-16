Return-Path: <linux-fsdevel+bounces-64360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380EBE30BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 13:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C64E4734
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A22317715;
	Thu, 16 Oct 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2tuFb3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B43164B0;
	Thu, 16 Oct 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613855; cv=none; b=LLAjnZd2yj5QWqEpW20wZEZ94kksyCl4ZqMvVfADwsbVyRNaRcLGVgSjdmA4YUPrMyZqgAnZ70mtAXfH9ofCqYRyJf8oTcsrpPg5Jisz0S2gM1/BUrmwdVzuOe84BUTZkJr5e8h/64FGKhbXouyh8dSD82ckkKqkpozZ5CfNtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613855; c=relaxed/simple;
	bh=0bHQoUy2ApllpsdZzdPazW2pJSX7I7p81GYZ3kyAd0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh1f7f2LzHvl0EdmXdPfgAmkLGVetJoUdjSGJOn1RJOFawD35UUplD9k6eXTEGbNSW6X3aHLDb4r/88mMrmujUA7rqd5wm4mRLVEaNuZf6/V9kPScbDCXlAYhL7si+DzdxtJ/UBAgfu68l1G07aDVzmZ4667yWAyKU3GjHA9sTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2tuFb3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAF4C4CEF1;
	Thu, 16 Oct 2025 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760613855;
	bh=0bHQoUy2ApllpsdZzdPazW2pJSX7I7p81GYZ3kyAd0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v2tuFb3wo3hjC4GT6QT5kqPgB6bGYyQvgR1FkkPoc3l/HK7MEuKqhxwX908cDG1SE
	 tbQtmPdl+hMEGTjW9G8MsDHQBgOdK51A4lCByHb2H09kbIEK6HnNdf0glTNODQa5X2
	 hW0z103OSPya/i3cmqIxir/nKZ/YGpo+IG/9vK4M=
Date: Thu, 16 Oct 2025 13:24:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Message-ID: <2025101610-detention-dangle-cef6@gregkh>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
 <2025101544-stopper-rifling-00e0@gregkh>
 <aPDGxz04OQgzRQqL@zeus>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPDGxz04OQgzRQqL@zeus>

On Thu, Oct 16, 2025 at 07:19:51PM +0900, Ryosuke Yasuoka wrote:
> On Wed, Oct 15, 2025 at 07:40:12AM +0200, Greg KH wrote:
> > On Wed, Oct 15, 2025 at 01:02:40PM +0900, Ryosuke Yasuoka wrote:
> > > Hi all,
> > > 
> > > This patch series add support for the llseek file operation to misc
> > > devices written in Rust.
> > 
> > Cool, but what miscdevice driver needs llseek support?  Do you have a
> > real user for this that we can see as well?
> 
> Currently no. Because lseek is one of fundamental functions for device
> driver, I think it's valuable to add support. I believe we'll have real
> users based on read, write, and this lseek support.

Char devices that use lseek are "odd", don't you agree?  There are no
such current users under drivers/misc/ and only a rare few under
drivers/char/ (the huge user of that is mem.c but we aren't going to be
reimplementing that in rust any time soon...)

So without a real user of this api, I suggest we hold-off on adding it.
Let's not add it until someone comes up with a very valid reason for it.

thanks,

greg k-h

