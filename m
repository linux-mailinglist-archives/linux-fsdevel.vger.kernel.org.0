Return-Path: <linux-fsdevel+bounces-76514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH/CJ55OhWkS/wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:14:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE27F929F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AA7C3008990
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DFE25FA29;
	Fri,  6 Feb 2026 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaibNhog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768125782D;
	Fri,  6 Feb 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344081; cv=none; b=bEOdPphGPf1v0SAbu9hlSvL7Q3y3huuAZdPCcZ+kHEe61mMvBOOTPCN3/VW4MB29vekBOIR1MFC9fjl2nTt3VLRk39ZiVkqDRcXTQTZLLLUoJMkPGDMOGprI0K6D01QF7aDnXBUU8qOwCEw76hmtRtOojE58ezexDIONieNmKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344081; c=relaxed/simple;
	bh=ATLPJS/UH91yRpelUNPks520SMde5zqgJce85JDspgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHgOryx4iyetcea2a2J9B32998kz3KWCAvyPJHyFy7biTG/1mL7OTbqEoLbny/nzqYk34EI8kQ4G/tqpm5FCyQJUSXQjV3CvZRp6UWnX7Up3YfUyB22QLztBRH4WffYj7glnDHYiLMgEBnFwE0s6kBDgmNCd53MuL0+S6ybfZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaibNhog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C334BC4CEF7;
	Fri,  6 Feb 2026 02:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344080;
	bh=ATLPJS/UH91yRpelUNPks520SMde5zqgJce85JDspgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaibNhoguUe9AatS0VySPj7uwJUWB0YBt9reDVKYei584R7LyzNKVZ9499trUO06N
	 H0REq7d2EYzzQFYveE4Z96Rb5AqaxTg/ZQ8q3Cgyvqk4ycyeB///bM/nyhZHYF+8zW
	 LQcW5zx4xloczcz7Ez7l8V/P/jrXvP2yysrYmhqoBGHxLPXKVL2O8ExAswm15p5gBa
	 8d2hYvexkNe5ofEXSokPN0zWd6HN04K/rlTaBLfYRuSMBpR21lbpcW/YI8bhnikkWq
	 tR+ve89XUZXHZiGXqexv+K6SZIW0LCOJAmpphD6HY+Csf+uPPhyGniTHqdnyLvn96w
	 1V13h788RTkKg==
Date: Thu, 5 Feb 2026 18:14:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/31] fuse: implement buffered IO with iomap
Message-ID: <20260206021440.GG7686@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810656.1424854.15239592653019383193.stgit@frogsfrogsfrogs>
 <20260205191253.2011999-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205191253.2011999-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76514-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FE27F929F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:12:09AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Implement pagecache IO with iomap, complete with hooks into truncate and
> > fallocate so that the fuse server needn't implement disk block zeroing
> > of post-EOF and unaligned punch/zero regions.
> > 
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
> 
> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through:
> 
> commit 05d561a4dd38273cb93745e8ddf913f490f81ad5
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: implement buffered IO with iomap
> 
> Implement pagecache IO with iomap, complete with hooks into truncate and
> fallocate so that the fuse server needn't implement disk block zeroing
> of post-EOF and unaligned punch/zero regions.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> 
> [ ... ]
> 
> > @@ -1056,6 +1144,365 @@ void fuse_iomap_open_truncate(struct inode *inode)
> >  	fi->i_disk_size = 0;
> >  }
> >
> > +struct fuse_writepage_ctx {
> > +	struct iomap_writepage_ctx ctx;
> > +};
> > +
> > +static void fuse_iomap_end_ioend(struct iomap_ioend *ioend)
> > +{
> > +	struct inode *inode = ioend->io_inode;
> > +	unsigned int ioendflags = FUSE_IOMAP_IOEND_WRITEBACK;
> > +	unsigned int nofs_flag;
> > +	int error = blk_status_to_errno(ioend->io_bio.bi_status);
> > +
> > +	ASSERT(fuse_inode_has_iomap(inode));
> > +
> > +	if (fuse_is_bad(inode))
> > +		return;
> >                 ^^^^
> 
> Does this early return leak the ioend?  When fuse_is_bad(inode) returns
> true, this function returns without calling iomap_finish_ioends().
> 
> Looking at the iomap code, iomap_finish_ioends() is responsible for:
> 
> 1. Calling bio_put() to free the bio structure embedded in the ioend
> 2. Calling iomap_finish_folio_write() to end writeback on the folios
> 
> Without this cleanup, we get two problems:
> 
> - Memory leak: the bio structure is never freed
> - Folios stuck in writeback state forever, which can cause system
>   hangs as pages cannot be reclaimed or written again
> 
> The cleanup at line 1176 appears mandatory regardless of inode state.

Correct, will fix.

--D

> 
> [ ... ]
> 
> 

