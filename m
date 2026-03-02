Return-Path: <linux-fsdevel+bounces-78940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAcSLDXBpWmBFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:56:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7785F1DD54D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A30B306228E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6A426EA0;
	Mon,  2 Mar 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owS2QK6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E283426D33;
	Mon,  2 Mar 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469964; cv=none; b=rAiD9hzj+tp3+Ej9KflEww0BlP7Rwtfx+NwrVodwdXPCIZS8WyYmj20fQwmkE6BzXyHBKwmnBcV5P6aHayezUhec+iim3hD+/R5+zzMh2Hw3w8ooG5e+RvaqWqpGv3HSSL4q6Dh+yemtq7SQpJ6bbIX8l/2S45MSSrm2beAYZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469964; c=relaxed/simple;
	bh=YdYqAtsqv1tLj60VfDFC1Rqku23CARifpQgzNEg87eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH+f703RFSk/MDVQtvH4/m//ECk7m8Usij/JgEB8JBsjya6R1vhtFGPexySvhRddmZvvXfyX9hPYBYc9LHEWk0fQH/0rGkjgU8GCPMMO5mbblz6fHsMDmcGvzUTKqC4gf8ArSVJ4uFQ6XbBFFySgxVz7wMuTM2k3echwDIjxEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=owS2QK6j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Vg7gqMeiyzPknt3qyMKgO+85Gcdawf8YPVMOwCXhuA=; b=owS2QK6jKnt+GVdLtj0zS8Wvnv
	omE+YRDnz15+BbCFScMK0nqhIE+g2d1g9cWeoRay+sPdP9qOR67XZZ1Hop8ALT8uO1s65oRagWMn7
	lzM58aSkEa9MJwJf4RWxmXXbN+r17MR/kwfI4iE1z7i3nMP8Y322XYS90pMvSu2lHiW2rSQzNulb5
	mPoNFIW2Tm0GTGn4inHkp5LiBPSQCt9Tgd0wv8Vqpp+TMEmesZYqJ0D/ZYz/5KIwR0IlwiQG48LPn
	IDG7qFF/nIVP5yO/j+/qmADSO53CG+iTe/CdnxFa1UKEnuYum7FRAsPRpjHitiNuFMWbjxGK9E4pC
	vNDIxDjw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx6P9-00000009mbi-1QvE;
	Mon, 02 Mar 2026 16:45:59 +0000
Date: Mon, 2 Mar 2026 16:45:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: WANG Rui <r@hev.cc>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] binfmt_elf: Align eligible read-only PT_LOAD
 segments to PMD_SIZE for THP
Message-ID: <aaW-x-HVQpSuPRA1@casper.infradead.org>
References: <20260302155046.286650-1-r@hev.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302155046.286650-1-r@hev.cc>
X-Rspamd-Queue-Id: 7785F1DD54D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78940-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:50:46PM +0800, WANG Rui wrote:
> +config ELF_RO_LOAD_THP_ALIGNMENT
> +	bool "Align read-only ELF load segments for THP (EXPERIMENTAL)"
> +	depends on READ_ONLY_THP_FOR_FS

This doesn't deserve a config option.

> +#if defined(CONFIG_ELF_RO_LOAD_THP_ALIGNMENT) && PMD_SIZE <= SZ_32M

Why 32MB?  This is weird and not justified anywhere.

> +			if (hugepage_global_always() && !(cmds[i].p_flags & PF_W)
> +				&& IS_ALIGNED(cmds[i].p_vaddr | cmds[i].p_offset, PMD_SIZE)
> +				&& cmds[i].p_filesz >= PMD_SIZE && p_align < PMD_SIZE)
> +				p_align = PMD_SIZE;

Normal style is to put the '&&' at the end of the line:

			if (!(cmds[i].p_flags & PF_W) &&
			    IS_ALIGNED(cmds[i].p_vaddr | cmds[i].p_offset, PMD_SIZE) &&
			    cmds[i].p_filesz >= PMD_SIZE && p_align < PMD_SIZE))
				p_align = PMD_SIZE;

But this conditional is too complex to be at this level of indentation.
Factor it out into a helper:

			if (align_to_pmd(cmds) && p_align < PMD_SIZE)
				p_align = PMD_SIZE;


