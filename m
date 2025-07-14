Return-Path: <linux-fsdevel+bounces-54814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2BB038D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B450189D306
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F042397BF;
	Mon, 14 Jul 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/e4KxYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066E2E370A;
	Mon, 14 Jul 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480782; cv=none; b=nRji80XHLjoMv+uJsysa5QctqzlCT3kYXOiDPYirK4miWxn6+Iq8XdiSQgLuHoPjzMeXYeYQXGU/L1tCI7vuwAD5xkk5WShz3/K3qj4vjV6UHu9tQrQ83EV8LjrB4pjg/zSTk+H+37+tGMxQphKgJLjB5sS7T0vm7vWQZa7+WW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480782; c=relaxed/simple;
	bh=eYX9mlVmNIdiqs19RLbDyQSky0HEgi+QIUoV5j9P+zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK2YzNg6qnWXusW93CsF2mW+Gjwd/sdcelvVLjxDQmObPvrBUgB6TWP2QusYNfvNBXU7N/UxBKWA5ikTmEZzgMcbfLMVM4Nubm5BtK4X+gwdE0XSn4jROPrG7erNMGEe2yWGSoCCohVMH8TTis/jYNBzwrOHyvm95uvc3DzHhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/e4KxYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2C4C4CEED;
	Mon, 14 Jul 2025 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480781;
	bh=eYX9mlVmNIdiqs19RLbDyQSky0HEgi+QIUoV5j9P+zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/e4KxYTKu4jlOwPcroo4+UNuZsjPfHR2xBpjWdqyGeNIzT4J7HmVSa8cFABYww4p
	 xYoD8x7nZcDn4d7G7nVzkQk3CNcydNxiiMTV33PZQyPjdUdR+fSv/OormbXxiDAIWh
	 GH8Pu6tomvgHwde9I/xx5C9Nd4staFpwgBP11jdxTVZoRpenyORR3soAk4FOj3oS/M
	 OSVUxtjQ1oaJgBIPKHBa+Q49cJRF9bfJiK69+ZXCa215ycojuFGb3mAPO1ZUFZE8YD
	 oC1jdTeRNcUQW8m650eqtjt2nmloLAdwpQekHw3dhBvv9BeLiJPYwmoMdtn5EMkdB1
	 aWBkV/59JP0jA==
Date: Mon, 14 Jul 2025 10:12:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250714-fernhalten-holzkisten-d085d5802884@brauner>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>

On Mon, Jul 14, 2025 at 07:52:27AM +0200, Thomas Weißschuh wrote:
> (+Luis for the usermode helper discussion)
> 
> On Fri, Jul 11, 2025 at 04:44:23PM +0100, Al Viro wrote:
> > On Fri, Jul 11, 2025 at 12:35:59PM +0200, Thomas Weißschuh wrote:
> > > Hi Kees, Al, Christian and Honza,
> > > 
> > > On Thu, Jun 26, 2025 at 08:10:14AM +0200, Thomas Weißschuh wrote:
> > > > The KUnit UAPI infrastructure starts userspace processes.
> > > > As it should be able to be built as a module, export the necessary symbols.
> > 
> > What's wrong with kernel/umh.c?
> 
> It gets neutered by CONFIG_STATIC_USERMODEHELPER_PATH. That could be worked
> around be overriding sub_info->path, but it would be a hack.
> It does not allow to implement a custom wait routine to forward the process
> output to KUnit as implemented in kunit_uapi_forward_to_printk() [0].
> That may be solved by adding another thread, but that would also be hacky.
> 
> It would probably be possible to extend kernel/umh.c for my usecase but I
> didn't want bloat the core kernel code for my test-only functionality.
> 
> > > could you take a look at these new symbol exports?
> > 
> > > > +EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");
> > 
> > What's that one for???
> 
> What are you referring to?
> 
> The macro EXPORT_SYMBOL_GPL_FOR_MODULES() will only export the symbol for one
> specific module. Personally I'm also fine with EXPORT_SYMBOL_GPL().

No, we're going to use the new restricted macros going forward that
limit exports to very specific modules. This is a good example. Though
it will be renamed to EXPORT_SYMBOL_FOR_MODULES() anyway.

