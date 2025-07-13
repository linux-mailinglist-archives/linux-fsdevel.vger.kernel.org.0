Return-Path: <linux-fsdevel+bounces-54770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74014B02FE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 10:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C486189A65E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56251EF39F;
	Sun, 13 Jul 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Cphgb7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51B81E;
	Sun, 13 Jul 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752395475; cv=none; b=LjcPVxjIsUpVnP89OfJFTaJrRbBKCuRuVxJ3BrXkOA2Z73hCPBRJr+Nxc2Hc5XJhCefnrOPNzzj0IJL9X7mj5CrqltNAt+OE8D+n/NGtOGBpqQ9CkgwG4jLIUrq+zw3p3pCeoo/k2Vl4WTYbPrjWQMLbhaPmljUZcgpvLQSRgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752395475; c=relaxed/simple;
	bh=DviaSuoXmayTy4YQ15jZXOKVUswO0Wwo8H6L9yw9d44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXhJZKFEpCESK749tq9vIKLJq8YdsOvQv/5UxHp1Ydu9lAK3XhASKxxCBOamlvLWT/sYf+tNsV5IiJRH/aFYo+MECk+5VP3WcOU67v1aYYYDjXw9tf0n+N0jEj3jWnnCLCFmp1Aj14ENZl1wc/Ao65s8zGPcuJs4m/5YC1egg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Cphgb7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217C5C4CEE3;
	Sun, 13 Jul 2025 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752395473;
	bh=DviaSuoXmayTy4YQ15jZXOKVUswO0Wwo8H6L9yw9d44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0Cphgb7WrKAiXcydPZO58ngLsJAfacm88KLsBfuRkrEgaGKK/uANwfhuNfzvTIeml
	 e0eTmaPN9olhPyegm6fkp3v/KLxUW38Pb5c7cyvfQ4cBkfD9BS31FqevGhBVnNXhck
	 f/erCtI2iUBiYiGam4QB97iLAfqL96J9G5VXRbTo=
Date: Sun, 13 Jul 2025 10:31:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Shivank Garg <shivankg@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Message-ID: <2025071355-debunk-sprang-e1ad@gregkh>
References: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
 <b9b74600-4467-4c76-aa41-0a36b1cce1f4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b74600-4467-4c76-aa41-0a36b1cce1f4@kernel.org>

On Sat, Jul 12, 2025 at 08:26:17PM +0200, Daniel Gomez wrote:
> On 11/07/2025 16.05, Vlastimil Babka wrote:
> > Christoph suggested that the explicit _GPL_ can be dropped from the
> > module namespace export macro, as it's intended for in-tree modules
> > only. It would be possible to resrict it technically, but it was pointed
> > out [2] that some cases of using an out-of-tree build of an in-tree
> > module with the same name are legitimate. But in that case those also
> > have to be GPL anyway so it's unnecessary to spell it out.
> > 
> > Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
> > Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Shivank Garg <shivankg@amd.com>
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> > Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
> > part to avoid controversy converting selected existing EXPORT_SYMBOL().
> > Christoph argued [2] that the _FOR_MODULES() export is intended for
> > in-tree modules and thus GPL is implied anyway and can be simply dropped
> > from the export macro name. Peter agreed [3] about the intention for
> > in-tree modules only, although nothing currently enforces it.
> > 
> > It seemed straightforward to add this enforcement, so v1 did that. But
> > there were concerns of breaking the (apparently legitimate) usecases of
> > loading an updated/development out of tree built version of an in-tree
> > module.
> > 
> > So leave out the enforcement part and just drop the _GPL_ from the
> > export macro name and so we're left with EXPORT_SYMBOL_FOR_MODULES()
> > only. Any in-tree module used in an out-of-tree way will have to be GPL
> > anyway by definition.
> > 
> > Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
> > in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
> > 8250: export RSA functions"). Hopefully it's resolvable by a merge
> > commit fixup and we don't need to provide a temporary alias.
> > 
> > [1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
> > [2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
> > [3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
> > ---
> > Changes in v2:
> > - drop the patch to restrict module namespace export for in-tree modules
> > - fix a pre-existing documentation typo (Nicolas Schier)
> > - Link to v1: https://patch.msgid.link/20250708-export_modules-v1-0-fbf7a282d23f@suse.cz
> > ---
> >  Documentation/core-api/symbol-namespaces.rst | 8 ++++----
> >  fs/anon_inodes.c                             | 2 +-
> >  include/linux/export.h                       | 2 +-
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
> > index 32fc73dc5529e8844c2ce2580987155bcd13cd09..6f7f4f47d43cdeb3b5008c795d254ca2661d39a6 100644
> > --- a/Documentation/core-api/symbol-namespaces.rst
> > +++ b/Documentation/core-api/symbol-namespaces.rst
> > @@ -76,8 +76,8 @@ A second option to define the default namespace is directly in the compilation
> >  within the corresponding compilation unit before the #include for
> >  <linux/export.h>. Typically it's placed before the first #include statement.
> >  
> > -Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
> > ------------------------------------------------
> > +Using the EXPORT_SYMBOL_FOR_MODULES() macro
> > +-------------------------------------------
> >  
> >  Symbols exported using this macro are put into a module namespace. This
> >  namespace cannot be imported.
> 
> The new naming makes sense, but it breaks the pattern with _GPL suffix:
> 
> * EXPORT_SYMBOL(sym)
> * EXPORT_SYMBOL_GPL(sym)
> * EXPORT_SYMBOL_NS(sym, ns)
> * EXPORT_SYMBOL_NS_GPL(sym, ns)
> * EXPORT_SYMBOL_FOR_MODULES(sym, mods)
> 
> So I think when reading this one may forget about the _obvious_ reason. That's
> why I think clarifying that in the documentation would be great. Something like:
> 
> Symbols exported using this macro are put into a module namespace. This
> namespace cannot be imported. And it's implicitly GPL-only as it's only intended
> for in-tree modules.

s/implicitly/explicitly/

thanks,

greg k-h

