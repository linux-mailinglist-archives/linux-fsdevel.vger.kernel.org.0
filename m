Return-Path: <linux-fsdevel+bounces-54226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A5AFC45A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AE97AD37E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7329A308;
	Tue,  8 Jul 2025 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tESejgv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3517298CA7;
	Tue,  8 Jul 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960446; cv=none; b=S6AnL1oon0fjGSzcZ5kXKt30zb/RVAbM2ClkYDxikGI0/TpYNJpAqBOTUkJZ/14sP3ugCV36fFkuc9ZtbgVrwBM8yF53lDp/EZoEqbOsceDAWFDrbmvPN4FsDHiVVoAQf+RQs96alj0Lzg+i+tbeNSgfTTCChEQi3ss9dGpZMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960446; c=relaxed/simple;
	bh=rUqpGKNpxIkdFXiunXQ2FeKSD8DPlAjO+yZ3JAxkNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn/xe3zoM1WctVeSQitYyt5fOv2IcZgyZXDxwMXxRAQ4qYMaSY6b6mnFuoj0Vvwaptifukj3BuIitaD+Ah6oX4xLVWZ1Mob7fh/s/xm/5kIPu7MAOQ+Lj+Ghd/k0qvULtUQgnQsQeg4kzCWMz5BybGlymPENArUpUq+4gDYyAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tESejgv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F22DC4CEED;
	Tue,  8 Jul 2025 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960445;
	bh=rUqpGKNpxIkdFXiunXQ2FeKSD8DPlAjO+yZ3JAxkNuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tESejgv/MmDWFWBcXknnPCM1K7gBEJtSANDv+H+XH0veTXGmPzkv6/ZGQOcnThJ0+
	 6iXZDgLeESsSgXYmlLNzlSuQ7j39FxQXYvoxHagiQUHUbxZvYtFG0e4sc0P9RIOoiG
	 xxHqO9VVxqeq50c+pExIBBGIe8CO+rv8b5WSdijcy7BQ5O/5xN8C9S52GJ3ec0dkoW
	 wV2WvRN7qZk+Kobli9gql+GDFcqiZNSuloTGspcdREeUwcLFsgoCJbq0ty40upapYJ
	 xhOBPzy5rOpapgy5wk6p+sxcDDHJyrBRUsoTEtN8wu6KD3SkxXmv7cpk5gGKgJyJHx
	 h/HYHMO+V4xPA==
Date: Tue, 8 Jul 2025 09:40:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
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
Subject: Re: [PATCH 0/2] Restrict module namespace to in-tree modules and
 rename macro
Message-ID: <20250708-merkmal-erhitzen-23e7e9daa150@brauner>
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>

On Tue, Jul 08, 2025 at 09:28:56AM +0200, Vlastimil Babka wrote:
> Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
> part to avoid controversy converting selected existing EXPORT_SYMBOL().
> Christoph argued [2] that the _FOR_MODULES() export is intended for
> in-tree modules and thus GPL is implied anyway and can be simply dropped
> from the export macro name. Peter agreed [3] about the intention for
> in-tree modules only, although nothing currently enforces it.
> 
> It seems straightforward to add this enforcement, so patch 1 does that.
> Patch 2 then drops the _GPL_ from the name and so we're left with
> EXPORT_SYMBOL_FOR_MODULES() restricted to in-tree modules only.
> 
> Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
> in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
> 8250: export RSA functions"). Hopefully it's resolvable by a merge
> commit fixup and we don't need to provide a temporary alias.
> 
> [1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
> [2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
> [3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Love this. It'd be great to get this in as a bugfix,
Acked-by: Christian Brauner <brauner@kernel.org>

