Return-Path: <linux-fsdevel+bounces-30222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D027987F01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B501F23BFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1C178CE8;
	Fri, 27 Sep 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwIufxqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491015B963;
	Fri, 27 Sep 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420269; cv=none; b=Lw7GtB5bcyWpaKP0PsV0FzJuYnI/FzosSxE9JNT5X74UjgjY8GC41XH5lM36ADguMBVcWbufsBtGpDYpSF+Hw67BWimmYbPop1cd3XBTZ35CZa/VLfPT84SOdkCOgpbt8br1ztS4HcWiGN7Am0VJ3a0jTw+saTUx4Db5+Fxe6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420269; c=relaxed/simple;
	bh=ZBkLLKTBaN1RjLuhzJQz+joYB3PW3NEjgBMzNhvaLdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttvWH2pI/YExD8hyllUbnYoLwPZqEFc5uj4W62q+zKccSXNav7BcnjPpixbMYcrY+/e7u3uZGQsRYJRNi0yARBoAYJHfiIZq+DH87+gCVKSBqI5vvbdcHWfGDA+pCV3Lt3AR26mJrNq8pvF7tSWinSTFkg+t7ZBV2QHRsrstdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwIufxqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5BDC4CEC4;
	Fri, 27 Sep 2024 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727420268;
	bh=ZBkLLKTBaN1RjLuhzJQz+joYB3PW3NEjgBMzNhvaLdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwIufxqtd3FG3lteOTOIMoFr6Xh2lF3oTsqU420IGbCX9JgVr2dfZuhQWRbMs8GYC
	 YumEFJAzJ2kTYWU7S216axRRyrKAYPMaub0WpGro+/5CKypfgx3pkZMW/hzV8L5QTn
	 E9pNPxBpv1c6VBuRdbGvWxyA1IkxnhcXtoCmNWM4=
Date: Fri, 27 Sep 2024 08:57:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, stable@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
Message-ID: <2024092739-prefix-cheek-6c46@gregkh>
References: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
 <2024091801-segment-lurk-e67b@gregkh>
 <f6ecd24e0fdb1327dad41f41c3ac31477ca00c9f.camel@xry111.site>
 <2024091900-sloppy-swept-0a2e@gregkh>
 <D5904FCB-5681-4744-93AE-BF030307CF86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5904FCB-5681-4744-93AE-BF030307CF86@gmail.com>

On Thu, Sep 19, 2024 at 08:18:10PM +0800, Miao Wang wrote:
> 
> > 2024年9月19日 19:18，Greg Kroah-Hartman <gregkh@linuxfoundation.org> 写道：
> > 
> > On Thu, Sep 19, 2024 at 01:37:17AM +0800, Xi Ruoyao wrote:
> >> On Wed, 2024-09-18 at 19:33 +0200, Greg Kroah-Hartman wrote:
> >>> On Wed, Sep 18, 2024 at 10:01:18PM +0800, Miao Wang via B4 Relay wrote:
> >>>> Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
> >>>> ...)") added support for passing in NULL when AT_EMPTY_PATH is given,
> >>>> improving performance when statx is used for fetching stat informantion
> >>>> from a given fd, which is especially important for 32-bit platforms.
> >>>> This commit also improved the performance when an empty string is given
> >>>> by short-circuiting the handling of such paths.
> >>>> 
> >>>> This series is based on the commits in the Linus’ tree. Sligth
> >>>> modifications are applied to the context of the patches for cleanly
> >>>> applying.
> >>>> 
> >>>> Tested-by: Xi Ruoyao <xry111@xry111.site>
> >>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> >>> 
> >>> This really looks like a brand new feature wanting to be backported, so
> >>> why does it qualify under the stable kernel rules as fixing something?
> >>> 
> >>> I am willing to take some kinds of "fixes performance issues" new
> >>> features when the subsystem maintainers agree and ask for it, but that
> >>> doesn't seem to be the case here, and so without their approval and
> >>> agreement that this is relevant, we can't accept them.
> >> 
> >> Unfortunately the performance issue fix and the new feature are in the
> >> same commit.  Is it acceptable to separate out the performance fix part
> >> for stable?  (Basically remove "if (!path) return true;" from the 1st
> >> patch.)
> > 
> > What prevents you, if you wish to have the increased performance, from
> > just moving to a newer kernel version?  We add new features and
> > improvements like this all the time, why is this one so special to
> > warrant doing backports.  Especially with no maintainer or subsystem
> > developer asking for this to be done?
> 
> We all know the long process from a new improvement getting into the mainline
> kernel to landing in users' devices. Considering 32-bit archectures which lacks
> 64-bit time support in fstat(), statx(fd, AT_EMPTY_PATH) is heavily relied on.
> My intention on putting up this backport is that to quicken this process,
> benefiting these users.
> 
> Another reason is about loongarch. fstat() was not included in loongarch
> initially, until 6.11. Although the re-inclusion of fstat() is backported to
> stable releases, we still have implementation problems on the glibc side, that
> loongarch is the only architecture that may lack the support of fstat. If
> dynamic probing of the existence of fstat() is implemented, this code path
> would be only effective on loongarch, adding another layer of mess to the
> current fstat implementation and adding maintenance burden to glibc maintainers.
> Instead, if we choose to utilize statx(fd, NULL, AT_EMPTY_PATH), even if using
> dynamic probing, loongarch and all other 32-bit architectures using statx() for
> fstat() can benefit from this.
> 
> Based on the same reason why you have accepted the re-inclusion of fstat on
> loongarch into the stable trees, I believe it would be potentially possible to
> let the statx(..., NULL, AT_EMPTY_PATH, ...) get into the stable trees as well.

That was a simple patch that only affected one arch, unlike this patch
series which touches core kernel code used by everyone.

Please just encourage users of this hardware to use a newer kernel if
they wish to take advantage of the performance increase.

thanks,

greg k-h

