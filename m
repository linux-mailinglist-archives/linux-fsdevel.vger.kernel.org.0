Return-Path: <linux-fsdevel+bounces-29705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A989D97C875
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 13:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81D61C20B6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D960B8A;
	Thu, 19 Sep 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XmqBG8ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8637194083;
	Thu, 19 Sep 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744724; cv=none; b=VVYySHwTfVChhRGMgY0fr0CPNe/mGmrRc6YWMWQn8ckVSGwmcSgIZG4/qrxlLWN6Es5qIjT6xIEBoRlefyI/jB1+xs/wEHzCzhn9H8nyPSk0piL3Igog6s9+6ba7AQ5g9rxAX065MOYht5k/a0Je+9AxfI3P8xcjpKUDclx1LTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744724; c=relaxed/simple;
	bh=hIkLd8AvzpCoLbV7CT9rjtimplqyC+/Fv5vdmWL3vtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqIhtzP3VrnfGkJXEqOG0GUgiA/3ElUNdYCL6WrKM5sP5B3U7jdjAQPLupCZAYB3gBX57wz3lkVQ8lOYw7I1vTrDRN5pVZxFUN7KDetiZasnPDnJ652AKsQTSP2Ci5JcoFyDamkiVzP+mwnCjBWsefzpqHmE0na+T6Q/XFEfmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XmqBG8ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0196C4CEC4;
	Thu, 19 Sep 2024 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726744723;
	bh=hIkLd8AvzpCoLbV7CT9rjtimplqyC+/Fv5vdmWL3vtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmqBG8ns2uJ+6E4E/IgTH8qLWzDPEqlixy+wG/Zne4Mt1niENwCleA7LucsTqxgTW
	 qle3tzZtULuoXOjL0rJkxq/x1lJOeFLe8IDNSPFWznBJuogRumfG7J6Q8t0TJyrI1F
	 o3x2t7G9a6J9FaICAQWcTCuWUIe71Oxk/mwNZ2NE=
Date: Thu, 19 Sep 2024 13:18:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: shankerwangmiao@gmail.com, stable@vger.kernel.org,
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
Message-ID: <2024091900-sloppy-swept-0a2e@gregkh>
References: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
 <2024091801-segment-lurk-e67b@gregkh>
 <f6ecd24e0fdb1327dad41f41c3ac31477ca00c9f.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6ecd24e0fdb1327dad41f41c3ac31477ca00c9f.camel@xry111.site>

On Thu, Sep 19, 2024 at 01:37:17AM +0800, Xi Ruoyao wrote:
> On Wed, 2024-09-18 at 19:33 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 18, 2024 at 10:01:18PM +0800, Miao Wang via B4 Relay wrote:
> > > Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
> > > ...)") added support for passing in NULL when AT_EMPTY_PATH is given,
> > > improving performance when statx is used for fetching stat informantion
> > > from a given fd, which is especially important for 32-bit platforms.
> > > This commit also improved the performance when an empty string is given
> > > by short-circuiting the handling of such paths.
> > > 
> > > This series is based on the commits in the Linus’ tree. Sligth
> > > modifications are applied to the context of the patches for cleanly
> > > applying.
> > > 
> > > Tested-by: Xi Ruoyao <xry111@xry111.site>
> > > Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> > 
> > This really looks like a brand new feature wanting to be backported, so
> > why does it qualify under the stable kernel rules as fixing something?
> > 
> > I am willing to take some kinds of "fixes performance issues" new
> > features when the subsystem maintainers agree and ask for it, but that
> > doesn't seem to be the case here, and so without their approval and
> > agreement that this is relevant, we can't accept them.
> 
> Unfortunately the performance issue fix and the new feature are in the
> same commit.  Is it acceptable to separate out the performance fix part
> for stable?  (Basically remove "if (!path) return true;" from the 1st
> patch.)

What prevents you, if you wish to have the increased performance, from
just moving to a newer kernel version?  We add new features and
improvements like this all the time, why is this one so special to
warrant doing backports.  Especially with no maintainer or subsystem
developer asking for this to be done?

thanks,

greg k-h

