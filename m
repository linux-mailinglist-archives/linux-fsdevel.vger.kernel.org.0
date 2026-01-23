Return-Path: <linux-fsdevel+bounces-75185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENntGeTQcmnKpgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:37:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA76F2AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6BB330120FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889CF34F46F;
	Fri, 23 Jan 2026 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XCYI5AMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BE36CDE7;
	Fri, 23 Jan 2026 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132250; cv=none; b=IfzeOPjno9jiRxEptNSvmqEbRf2nkEUUpGY/TDxHY1IKNF4h9t1Ynz4Q/EOiMdSssEwMTk7eC064dUPi9wFPpkhsVx9ipu7Qolc7g2vDk9qPOVrOnj/KFqltJt1ngLvGXo5HDb/b1vPC3ySmoAiVg8MWWzuwx8vBFCIJ9iQzIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132250; c=relaxed/simple;
	bh=URzEB4TyVLPJ0Q9KqeHfxpBTrzPlgb7DYWhcPdepu6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz8/qGZ1cqW8k+PBwW3+jCOWfY4EAsoYI3g7MRc+9FpnJ7bTtngaTGdEaGhcbg6MouqAhQXG+Vz5S8EsM1Iw1yB/LP+KOKbWlPLXka/As6Kne8/BB++Q7KBRDPP3EfqUain7h38OQj3WIm3bLUQxumAUs1SNkFDHPoXtPTXTz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XCYI5AMH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=oJpR0abL6Upot0fWbyBrvmiec0l2GBXUNO1f0js3zDA=; b=XCYI5AMHgU7dGxUeQtdnSDkWie
	KPLw9SlMuVfNUv2nEtN69WvPUHdBVZfdaQ3sM7lkHIITHmgKEJBp0vmOzTdx/g7/p9SLrrqiUjKDj
	6iQL7sDlaeMXyX9/5d4nkKzb3cgz4zWQgFZQUjX+wjmruuyUxNHCpZh8ziR8YZZX/Qi1QEhoZOsPQ
	qphdr0JdzeWubH0JzsnFaS24bu29FIeYfZGdBoSxXL0SI4Ne9266UYanfQ1zF+KXmnjotGGBN2FMH
	YJl5h6kWA1E0Zel+7HnxrePTzL0VLAxmCghVT0syQ6tF2auFF7oX5R9dHN6udIfZ3NTsawvNHY8+8
	VI3U+XEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vj68Z-0000000Gb6u-2hnp;
	Fri, 23 Jan 2026 01:38:59 +0000
Date: Fri, 23 Jan 2026 01:38:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alejandro Colomar <alx@kernel.org>
Cc: Zack Weinberg <zack@owlfolio.org>, Vincent Lefevre <vincent@vinc17.net>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20260123013859.GI3183987@ZenIV>
References: <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <aXLGdWGTrYo1s6v7@devuan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXLGdWGTrYo1s6v7@devuan>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75185-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[62.89.141.173:received,100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: D4EA76F2AD
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:02:53AM +0100, Alejandro Colomar wrote:
> > HISTORY
> >        The close() system call was present in Unix V7.
> 
> That would be simply stated as:
> 
> 	V7.
> 
> We could also document the first POSIX standard, as not all Unix APIs
> were standardized at the same time.  Thus:
> 
> 	V7, POSIX.1-1988.
> 
> Thanks!

11/3/71							 SYS CLOSE (II)
NAME		close -- close a file
SYNOPSIS	(file descriptor in r0)
		sys	close		/ close = 6.
DESCRIPTION	Given a file descriptor such as returned from an open or
		creat call, close closes the associated file. A close of
		all files is automatic on exit, but since processes are
		limited to 10 simultaneously open files, close is
		necessary to programs which deal with many files.
FILES
SEE ALSO	creat, open
DIAGNOSTICS	The error bit (c—bit) is set for an unknown file
		descriptor.
BUGS
OWNER		ken, dmr

That's V1 manual.  In V3 we already get EBADF on unopened descriptor;
in _all_ cases there close(N) ends up with descriptor N not opened.

