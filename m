Return-Path: <linux-fsdevel+bounces-3815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C3A7F8B2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 15:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712982814D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3937125BE;
	Sat, 25 Nov 2023 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTefBvIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68DF9FE
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 14:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45EC433C7;
	Sat, 25 Nov 2023 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700921069;
	bh=oR2FZCEmyWJs3H/Sq60sOFaa52q/UAD9T3D3m2taMI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTefBvIHrBsWV7IYBI+6/VC4t2Vsw588aPNliu4s4L00U9hvRFxqa2qdx+kJwD9+b
	 w0oHnWAzg8e8JiXyLkaDlNs+/YB6pfT/EzhNY2X67o91uw6gEzED8IlppfXOpXkQTE
	 E51e1m9UvKCUu16Kx6Kv/+GlZFWklHNblVu7FSf+cSU6xpagLVQG6fBT9/LjIW0w9n
	 7odR9euCXZ//r8uTqh0AUw2QzRoH9TIkEF5sxO1v1XS2GmFnqmtveBWx/LyDJlB/bw
	 3ZthPdU8LNULQr9ENhQ5UVt40Nvqg4sMd73z4OSWPPLRaquwb8YFZuthiN0GemE1M9
	 HdqP8S7Ra6tig==
Date: Sat, 25 Nov 2023 15:04:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Omar Sandoval <osandov@fb.com>, David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231125-kurhotel-zuwege-10cce62a50fd@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <20231125-manifest-hinauf-7007f16894b6@brauner>
 <ZWH2kSJXcXEohpyd@telecaster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWH2kSJXcXEohpyd@telecaster>

On Sat, Nov 25, 2023 at 05:28:49AM -0800, Omar Sandoval wrote:
> On Sat, Nov 25, 2023 at 02:10:52PM +0100, Christian Brauner wrote:
> > On Fri, Nov 24, 2023 at 10:25:15AM -0800, Linus Torvalds wrote:
> > > On Fri, 24 Nov 2023 at 02:28, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > * Fix a bug introduced with the iov_iter rework from last cycle.
> > > >
> > > >   This broke /proc/kcore by copying too much and without the correct
> > > >   offset.
> > > 
> > > Ugh. I think the whole /proc/kcore vmalloc handling is just COMPLETELY broken.
> > 
> > Ugh, I didn't even look at that closely because the fix was obviously
> > correct for that helper alone. Let's try and just return zeroed memory
> > like you suggested in your last mail before we bother fixing any of
> > this.
> > 
> > Long-term plan, it'd be nice to just get distros to start turning
> > /proc/kcore off. Maybe I underestimate legitimate users but this
> > requires CAP_SYS_RAW_IO so it really can only be useful to pretty
> > privileged stuff anyway.
> 
> drgn needs /proc/kcore for debugging the live kernel, which is a very
> important use case for lots of our users. And it does in fact read from
> KCORE_VMALLOC segments, which is why I found and fixed this bug. I'm
> happy to clean up this code, although it's a holiday weekend here so I
> won't get to it immediately of course. But please don't rip this out.

Ugh, I see. I just grepped through the drgn repo. I didn't realize that
you were actively using it and not just testing it. If this is actively
used then we won't break you ofc.

And yeah, if you would fix it that would be great. Given that you're the
main active user who happens to have kernel experience you might even
want to be made responsible for this file in the future. ;)

