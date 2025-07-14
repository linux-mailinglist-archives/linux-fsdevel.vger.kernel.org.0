Return-Path: <linux-fsdevel+bounces-54812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC10B038BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E04516B028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B2239E62;
	Mon, 14 Jul 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bg6NTz1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19C2356C3;
	Mon, 14 Jul 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480504; cv=none; b=IOxciB8iwtiO2lOcvjxRD1QpbRtmzJIWKofqdxVfAyb2MAn7gbafgOPJjM77M+bMMGD9nEXPaiGWBJacmLLW+nbT+c5KPZGrdVjGf8b+3mfqPchsvek6b8RMBVGIxLJBo4Rjmgj8A6Ua2pjVCesjvfcEcKV7g35+PUfGj93UfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480504; c=relaxed/simple;
	bh=9sbqkkiER8bcGZotV9lm24ZrEWQa8/vL3mB6ZS0+W5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz+oCvzFpnhfRrh6n7lbtLO6AMuO/IdGmD1JY8a4QntWkasgCuPcMywBL4XaSQHEqzH/Pk/I7eZ34X3V5bU+2FSp2JuuyHEVxvP1rEFro38dJEJLnmWuKQ7f8dsfN43VNpKJyRWOZqCcsqSx2BIvgD2D1CCjwP+HHlp9djVUlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bg6NTz1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0CEC4CEED;
	Mon, 14 Jul 2025 08:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480503;
	bh=9sbqkkiER8bcGZotV9lm24ZrEWQa8/vL3mB6ZS0+W5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bg6NTz1IAIUQlwt8otqkfZX5bKk1zqzqOeMw0V8wECduUQ6U0vPAE4vUp9pq2L3DX
	 V3l9R2dxRk0bxJqs9jlwwUQex9J714ilSl/WolY2G37P4Qz48FNMFBoDiK/cWZ4OPY
	 aIpEK5shOCT80WnUAQDV58RyLNGEZ4BD8zYq7Gib1sNK40k2vjnLATbqMPLE+BEMrZ
	 IvZumceGju7cF4+bN057oKRZthDlPQCroL0gP0A7c0BXJUG11MpNR9PfFZQEiKAnmx
	 2JS4yhqWjF5f1BIaBhLimsnQnDNB4lF6U9gfNZYG6XHv/sky3RHlvo2FNEjDwUDu2V
	 Gaqdtw1sd2tBQ==
Date: Mon, 14 Jul 2025 10:08:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Maennich <maennich@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Shivank Garg <shivankg@amd.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Message-ID: <20250714-geliebt-neupositionierung-f69ca29c5e40@brauner>
References: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>

On Fri, Jul 11, 2025 at 04:05:16PM +0200, Vlastimil Babka wrote:
> Christoph suggested that the explicit _GPL_ can be dropped from the
> module namespace export macro, as it's intended for in-tree modules
> only. It would be possible to resrict it technically, but it was pointed
> out [2] that some cases of using an out-of-tree build of an in-tree
> module with the same name are legitimate. But in that case those also
> have to be GPL anyway so it's unnecessary to spell it out.
> 
> Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
> Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Shivank Garg <shivankg@amd.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
> part to avoid controversy converting selected existing EXPORT_SYMBOL().

Thank you!
Reviewed-by: Christian Brauner <brauner@kernel.org>

Am I supposed to take this or how's that going to work?

> Christoph argued [2] that the _FOR_MODULES() export is intended for
> in-tree modules and thus GPL is implied anyway and can be simply dropped
> from the export macro name. Peter agreed [3] about the intention for
> in-tree modules only, although nothing currently enforces it.
> 
> It seemed straightforward to add this enforcement, so v1 did that. But
> there were concerns of breaking the (apparently legitimate) usecases of
> loading an updated/development out of tree built version of an in-tree
> module.
> 
> So leave out the enforcement part and just drop the _GPL_ from the
> export macro name and so we're left with EXPORT_SYMBOL_FOR_MODULES()
> only. Any in-tree module used in an out-of-tree way will have to be GPL
> anyway by definition.
> 
> Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
> in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
> 8250: export RSA functions"). Hopefully it's resolvable by a merge
> commit fixup and we don't need to provide a temporary alias.
> 
> [1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
> [2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
> [3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
> ---

