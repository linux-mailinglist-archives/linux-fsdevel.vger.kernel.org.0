Return-Path: <linux-fsdevel+bounces-30091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2DA98612A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E60C285AE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFB118FC9F;
	Wed, 25 Sep 2024 13:59:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE2187568;
	Wed, 25 Sep 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272748; cv=none; b=Se1NCsdtuvWun5ZSJQU9jT+x6vnfTxfqE4iVVjgpXWkPCOwgQHsgkYYH5zQCVL8X1CfLvxT6MwljxG/m9NjMwc9TQ9oAi97HMwymr8WaNIzrklQP2QOhsg6/Cb88tWkjMGQZlyIN+K3+qZzMRqYp+z9ZKTGSCQ+3fFKyPlgpve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272748; c=relaxed/simple;
	bh=LaqiujrabjNuCdxLtvhTjGOIPotsoV1whHWw7yZzMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAPBqkbQ5UoY1IugkQeXuBbuAEfbV3THf2RrQnz0WK3L/pXQ7rxM+zH/BegzfdvtINH5iX/BGaVbXLDNHBcQeei7ylwHW32kshX2BXAvqTPPXtwZru32F5Tmx9N7ntLUn0ybir/ki2PEjRL7b9u7ucU2MPqPqDM4APNjGFUyBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 4A016A05; Wed, 25 Sep 2024 08:59:04 -0500 (CDT)
Date: Wed, 25 Sep 2024 08:59:04 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>, Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
Message-ID: <20240925135904.GA654417@mail.hallyn.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-1-88484f7a3dcf@google.com>
 <20240924194540.GA636453@mail.hallyn.com>
 <CAH5fLgggtjNAAotBzwRQ4RYQ9+WDom0MRyYFMnQ+E5UXgOc3RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgggtjNAAotBzwRQ4RYQ9+WDom0MRyYFMnQ+E5UXgOc3RQ@mail.gmail.com>

On Wed, Sep 25, 2024 at 01:06:10PM +0200, Alice Ryhl wrote:
> On Tue, Sep 24, 2024 at 9:45 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Sun, Sep 15, 2024 at 02:31:27PM +0000, Alice Ryhl wrote:
> > > This introduces a new marker type for types that shouldn't be thread
> > > safe. By adding a field of this type to a struct, it becomes non-Send
> > > and non-Sync, which means that it cannot be accessed in any way from
> > > threads other than the one it was created on.
> > >
> > > This is useful for APIs that require globals such as `current` to remain
> > > constant while the value exists.
> > >
> > > We update two existing users in the Kernel to use this helper:
> > >
> > >  * `Task::current()` - moving the return type of this value to a
> > >    different thread would not be safe as you can no longer be guaranteed
> > >    that the `current` pointer remains valid.
> > >  * Lock guards. Mutexes and spinlocks should be unlocked on the same
> > >    thread as where they were locked, so we enforce this using the Send
> > >    trait.
> >
> > Hi,
> >
> > this sounds useful, however from kernel side when I think thread-safe,
> > I think must not be used across a sleep.  Would something like ThreadLocked
> > or LockedToThread make sense?
> 
> Hmm, those names seem pretty similar to the current name to me?

Seems very different to me:

If @foo is not threadsafe, it may be global or be usable by many
threads, but must be locked to one thread during access.

What you're describing here is (iiuc) that @foo must only be used
by one particular thread.

-serge

