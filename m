Return-Path: <linux-fsdevel+bounces-55121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11731B070C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BE13A40BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487322EE987;
	Wed, 16 Jul 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8Oyz9kS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="THfnqitT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737228C872;
	Wed, 16 Jul 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655202; cv=none; b=BmziYoIKaicoRSICgw4evJyG2flEeTWDiM/ngg41ERB/RJSkxLqtsS0ZvL3FGM2gnf0t8tRLtWWPbXCv9ZLSqeUmUhkTdkvjFWvo3RZw8zYY/Ff4NBcUU6X176xJknqQzkkPwbeZrJ/QNXJm5/7MBiJOYMhQGJD84f9tiFbUxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655202; c=relaxed/simple;
	bh=S38WWsWkK5+NkyYzozBR50z/mT83nkF7Zap3npoyPPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWnplxy4iOXNtIt3dDTaQY5ozFJ6j3gNPAPtAPmOoWkl0xMYeVqHSUqB8V+cXYh/rB/z7MWd/VoZrGCZlZTUUw7gniSLkwtZNjlLqF7gqf95Pe4yFyTwqqXsTEvbxIlhCbPqQlwtJMWhQRdhLyowUexmb/NrGQkHJFQo8YdzVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8Oyz9kS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=THfnqitT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:39:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752655199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jco++hyHdbIu/TIuhMr6dAmZZnmYOnbilSFqBhBBsns=;
	b=v8Oyz9kSetVsZIud2t2NkpwliXNDmacL2MFfhuIIH3hGinp7yzfp1Hw+fr7/7MAXCokFj9
	/Ax2U+RlgDybB8RRArY6d1XojZ1xLOv76OzVgyJ174UhVkwIdZ8WOBQdJb/wQQ3FcccTIo
	L7L958b7z3cRBjtCzeJk623ucRPFSuyV0jovt73+X//iHc8ZPazTmz3AIx45tTnb3u7Erv
	r/DtCuoMuwzM+v088CgyJbuHmK/D+TdsNcZelp+HakFeXdUOU3fp/cKDO7bELFTFLQgWfE
	sMefrLfrerN11Y2tLJXoJ4NGlfeGC6O3qogUchsQnf4zLuc529Bp+0C0aDb++Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752655199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jco++hyHdbIu/TIuhMr6dAmZZnmYOnbilSFqBhBBsns=;
	b=THfnqitTCj9NZEIu4dy792cKr0Pful9b/CaZpduRD0Rntz3+Vk6lY8Z91YA+H39PfC8uH5
	cVk+8gu02gc67YCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250716101207-c4201cef-abbe-481d-bca5-c2b27f324506@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
 <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
 <aHdE9zgr_vjQlpwH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHdE9zgr_vjQlpwH@infradead.org>

On Tue, Jul 15, 2025 at 11:21:43PM -0700, Christoph Hellwig wrote:
> On Wed, Jul 16, 2025 at 07:30:46AM +0200, Thomas Weißschuh wrote:
> > On Mon, Jul 14, 2025 at 07:52:28AM +0200, Thomas Weißschuh wrote:
> > > On Fri, Jul 11, 2025 at 04:44:23PM +0100, Al Viro wrote:
> > 
> > (...)
> > 
> > > > On Fri, Jul 11, 2025 at 12:35:59PM +0200, Thomas Weißschuh wrote:
> > > > > could you take a look at these new symbol exports?
> > > > 
> > > > > > +EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");
> > > > 
> > > > What's that one for???
> > > 
> > > What are you referring to?
> > 
> > Reading this again you probably asked why put_filesystem() is exported.
> > 
> > As I see it, that should be called after being done with the return value of
> > get_fs_type(). Not that it does anything for the always built-in ramfs.
> > The alternatives I see are a commented-out variant with an explanation or
> > making put_filesystem() into an inline function.
> 
> The right answer is to rework your code to not need all those exports.

If I saw a way, I surely would do that and I certainly tried before.
For the first revisions of this series I didn't even try to make this code
modular to avoid these discussions.

> Nothing modular, and especially not something testing only should need
> all these low-level bits.

Let's take kernel_execve() as example, there is no way around using this
function in one way or another. It only has two existing callers.
init/main.c: It is completely unsuitable for this usecase.
kernel/umh.c: It is also what Al suggested and I am all for it.
Unfortunately it is missing features. Citation from my response to Al:

> It gets neutered by CONFIG_STATIC_USERMODEHELPER_PATH. That could be worked
> around be overriding sub_info->path, but it would be a hack.
> It does not allow to implement a custom wait routine to forward the process
> output to KUnit as implemented in kunit_uapi_forward_to_printk() [0].
> That may be solved by adding another thread, but that would also be hacky.

So I can either hack around the official API of umh.c, or modify it only to
cater to "something testing".

Then we have put_filesystem(), it is the counterpart to get_fs_type().
But while get_fs_type() is EXPORT_SYMBOL(), put_filesystem() is private.
I can leave out the call to put_filesystem(), the result would be the same
but it is still a hack.

create_pipe_files() and replace_fd() are used together with umh.c. But while
the umh.c API is EXPORT_SYMBOL_GPL(), they are not.

In general KUnit is already fairly integrated into the core kernel.
When built as a module it contains some built-in components and even has its
own member in 'struct task_struct'.
Having a built-in helper for my framework that wraps the calls to the
non-exported symbols into a helper function would work but again be hacky.

Or the code becomes non-modular again and suddenly nobody cares anymore...


Thomas

