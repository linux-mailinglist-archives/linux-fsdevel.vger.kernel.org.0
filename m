Return-Path: <linux-fsdevel+bounces-30843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E0198EBAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 10:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26E2281C96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A3413CF8E;
	Thu,  3 Oct 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMvqFrK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272B13B2A4;
	Thu,  3 Oct 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944432; cv=none; b=VKg9/WcP6T8DDUSR8A8enuaoH8E6506txps9fQ4+Jrrpn+dtFYpixkRdCLgZicNin9dRqOaOqqiRe8Ll/yMSuiPWKDmqphS0+W/Yv0/OqtgsfYULk+VOtXo3VS7QyK4hDvB5ovd0dUM0C6z8dXDpgpo+/uZjw83C2BHL65osdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944432; c=relaxed/simple;
	bh=t9NCdJyZZVWNegvqtHbQXG06Vs/AZR9IoZ/MuxzH4j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZOP3JnAZtWeivhwhQif5g2hxCwRSMh975K3SMbHYBo3SOhsIrk4iHEIsXDBcwpbC9jMswplsoS/NA9nIjVjoAuEJmZWjTgV3F54lnV8fADMkl5nFHtjF2q0LNM6ePkTgrs1R2d6pYk8f3Vz295Yz8//zzOBWgI8Ougdfao9l2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMvqFrK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD066C4CEC7;
	Thu,  3 Oct 2024 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727944431;
	bh=t9NCdJyZZVWNegvqtHbQXG06Vs/AZR9IoZ/MuxzH4j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMvqFrK5wTisMBMy2BU2/zMOBSpHxJKIS+iabq4XEt5oPI3RKYc4DngolQvSlOqyA
	 WL71jQXEzXUxCSrAb2D+hpZ92qQ3StEFY/mv2sY+jtgktMzNBmX3gR636iUX0GC8c0
	 +p+oHYO8njVrY/GKLmfIeCSGdawJ05Xg87flRxa/ixkdvXNL/HPa3gs6A7JEP1h1oa
	 rZJaRGb7PdghKiQ/T16iBpebEcuewl8CoX85AlNuH+AuJkcZNtSbSkeFwLQedyjVEn
	 QkQVD3hGVPKgabMDKsQfhBNkHKitCCC/Ha30od3CtQGVF4AsT1RCS/+n+5S/xgkb2k
	 fVzOEWWOnpg1w==
Date: Thu, 3 Oct 2024 10:33:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Message-ID: <20241003-karotten-geist-0ac7914b4445@brauner>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <20241002-ertrag-syntaktisch-6c18b81d6c90@brauner>
 <CAH5fLgjm=u_im776f9cTrqjKCYQ31F4t=_Dg6mDzCoSEGoJm-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjm=u_im776f9cTrqjKCYQ31F4t=_Dg6mDzCoSEGoJm-w@mail.gmail.com>

On Wed, Oct 02, 2024 at 04:24:58PM GMT, Alice Ryhl wrote:
> On Wed, Oct 2, 2024 at 4:06 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Oct 01, 2024 at 08:22:22AM GMT, Alice Ryhl wrote:
> > > +unsafe extern "C" fn fops_open<T: MiscDevice>(
> > > +    inode: *mut bindings::inode,
> > > +    file: *mut bindings::file,
> > > +) -> c_int {
> > > +    // SAFETY: The pointers are valid and for a file being opened.
> > > +    let ret = unsafe { bindings::generic_file_open(inode, file) };
> > > +    if ret != 0 {
> > > +        return ret;
> > > +    }
> >
> > Do you have code where that function is used? Because this looks wrong
> > or at least I don't understand from just a glance whether that
> > generic_file_open() call makes sense.
> >
> > Illustrating how we get from opening /dev/binder to this call would
> > help.
> 
> Hmm. I wrote this by comparing with the ashmem open callback. Now that
> you mention it you are right that Binder does not call
> generic_file_open ... I have to admit that I don't know what
> generic_file_open does.

It's irrelevant for binder.

