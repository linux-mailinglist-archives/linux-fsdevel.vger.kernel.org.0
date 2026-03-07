Return-Path: <linux-fsdevel+bounces-79680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dQuHEXXBq2nPgQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 07:11:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7B22A5C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 07:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE7F93019E26
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61F36894D;
	Sat,  7 Mar 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBePLtNh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42635AC02;
	Sat,  7 Mar 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772863854; cv=none; b=nMQIZOed2EEAcpDp3F0nW7Y3mC3wyik/47ZuxjiIEacA00iP3xbAekXgTJ5j7O7aJcSNs28fynUaKAnz95js+rGn4A80o1A/CYNU/s+hptwMhfbZKXKTo9KJNHo91KGBdybccjkua+3jVsYpOP9spnOLYSn/2bkPEAZXCwZtlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772863854; c=relaxed/simple;
	bh=L5+0sewHTjOOMZadTeXyVKIFXha2M9Nh/Y7IA1S4a94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkVDmGSeWFsrzoZ/cuDGRNwn7w0cQGYa/6qZD9yMLrbfYgaJF87AdbTR+L4Qx35zKUYStHx1Vupinpp3+sEKq88SgX8793GBf61fVrdQA+fb6d93cQAsg8nK7hryKxinlmWeUoP7JCJlJOKOHToBT9kkADtTvj93e70Mt06R744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBePLtNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA0CC19422;
	Sat,  7 Mar 2026 06:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772863853;
	bh=L5+0sewHTjOOMZadTeXyVKIFXha2M9Nh/Y7IA1S4a94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBePLtNhi97CVQTe9fViv3OvdZoPthFzzeTdhoI8wodWzNyOXVKwFB9Zbz0SLJY2q
	 avJinfWnWz0LwRb7q3jPqISPxLhpG/ceYfs8/b1aZm+/oIan7wnkZJqy4MSmmSmZIt
	 V7BV0ujSWK/BxXKl+Grt0dCHDgh9OXWbNj7U+cdVMg4OaLeCXYLZfjvJxupP1HHHx4
	 RaARo65Y6y3M9KTgFGIWq1GhuKNRGO8AbVOcAUSyHXgs35Ukzijd7gQExyi5le3WTJ
	 s4PM58DNY1fS5FIWEvPu6FCvAGKHx7H7NZ3SzvgdBWa09VVsBVgIuTadfOlyioS8Bu
	 0X6p6Q2bghf/A==
Date: Fri, 6 Mar 2026 22:10:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: remove externs from fs.h on functions modified by
 i_ino widening
Message-ID: <20260307061053.GU13829@frogsfrogsfrogs>
References: <20260306-iino-u64-v1-1-116b53b5ca42@kernel.org>
 <aau4LBhdBfnDJAsl@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aau4LBhdBfnDJAsl@casper.infradead.org>
X-Rspamd-Queue-Id: 39D7B22A5C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79680-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:31:24AM +0000, Matthew Wilcox wrote:
> On Fri, Mar 06, 2026 at 08:27:01AM -0500, Jeff Layton wrote:
> > @@ -2951,26 +2951,26 @@ struct inode *iget5_locked(struct super_block *, u64,
> >  struct inode *iget5_locked_rcu(struct super_block *, u64,
> >  			       int (*test)(struct inode *, void *),
> >  			       int (*set)(struct inode *, void *), void *);
> > -extern struct inode *iget_locked(struct super_block *, u64);
> > +struct inode *iget_locked(struct super_block *, u64);
> 
> I think plain 'u64' deserves a name.  I know some people get very
> upset when they see any unnamed parameter, but I don't think that you
> need to put "sb" in the first parameter.  A u64 is non-obvious though;
> is it i_ino?  Or hashval?
> 
> > -extern struct inode *find_inode_nowait(struct super_block *,
> > +struct inode *find_inode_nowait(struct super_block *,
> >  				       u64,
> >  				       int (*match)(struct inode *,
> >  						    u64, void *),
> >  				       void *data);
> 
> I think these need to be reflowed.  Before they were aligned with the
> open bracket, and this demonstrates why that's a stupid convention.
> And the u64 needs a name.

I think inode numbers ought to be their own typedef to make it *really
obvious* when you're dealing with one, and was pretty sad to see "vfs:
remove kino_t typedef and PRIino format macro" so soon after one was
added.  But our really excellent checkpatch tool says "do not add new
typedefs" so instead everyone else has to be really smart about what
"u64" represents when they see one, particularly because arithmetic is
meaningless for this particular "u64".

Yay.

--D

