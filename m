Return-Path: <linux-fsdevel+bounces-76512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ4/GgROhWnj/gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:12:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D09F925A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9A73016531
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBD24503F;
	Fri,  6 Feb 2026 02:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6co0v4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646778F2B;
	Fri,  6 Feb 2026 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770343927; cv=none; b=a1I1lv9mnWFjzyF1ZongGOsZ9AVkCkFq16WiEOXqdG0yV6Ua2bJgPuAVxeBhwX2SfdaR/DHDxhjMyAgX9pwo0TAFeqcG+2FhCztStksqgEqd26hwv6D6uApE4JMV8snq+yoL1j+ARPmhpI6chNL/sjSgjLNMg1PrPozZTqbZWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770343927; c=relaxed/simple;
	bh=UQdo2yiwz8viSVAiBkuJ+vqP9kTgy/kNTNt6+4NDieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbsB/LVAI5mwi4DFtrhLfKd9e0Wpsen16DDEo8p0LbDmKdwIvYsWWnW9eeJ0eKA5v5FYhlDKSD+31GwJPjR9BnaAYMTcwt0hWhbHY+BpJzOug7WZy3wPSi3A5XJsZ5RFqKNzKcDkW6/ZhQimopNY7xXhdNFU47YVNparr6Nu0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6co0v4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529E0C4CEF7;
	Fri,  6 Feb 2026 02:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770343927;
	bh=UQdo2yiwz8viSVAiBkuJ+vqP9kTgy/kNTNt6+4NDieE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6co0v4V4X6zYfIACIbeb2wpEnZ8FI11eV9HnP7ixPtf3c/ecXz6tidQYvDJkMoZY
	 7sSr2s+WWxPZlEtalU2wa5kqdc7DiKsEKW2mqw2zYQbBYQHJIhtH4xMuxrEOkEPFFx
	 0QlKpe1QU0nZ2K5B7hPE5M/MdGLDsAaULXTYEGtufXxqYn4dCx9neiMq1aFeB8X6YD
	 pqJMkfrkYtznBHhGBVnBn6wKcaBMziWVB3U58kR/qzb62d9AS4C8GvK6pn9CunF1d0
	 GP4W7OqWt6+oyam8AxxfD0NwGiQhWwRtc2CqqGBH2FTQQcRWLIw8aNPHvd1R8bu/qA
	 1XZI7qMzCdMxg==
Date: Thu, 5 Feb 2026 18:12:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/31] fuse_trace: implement direct IO with iomap
Message-ID: <20260206021206.GF7686@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810634.1424854.13084435884326863405.stgit@frogsfrogsfrogs>
 <20260205191717.2066475-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205191717.2066475-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76512-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0D09F925A
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:16:54AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add tracepoints for the previous patch.
> > 
> 
> commit 3fad15ebe8d51187a2b6820ed6db4774a8b065b0
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse_trace: implement direct IO with iomap
> 
> Add tracepoints for the previous patch.
> 
> > diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> > index 730ab8bce4445..efba6ecbbf670 100644
> > --- a/fs/fuse/fuse_trace.h
> > +++ b/fs/fuse/fuse_trace.h
> 
> [ ... ]
> 
> > @@ -484,6 +499,75 @@ TRACE_EVENT(fuse_iomap_end_error,
> > +TRACE_EVENT(fuse_iomap_ioend,
> > +	TP_PROTO(const struct inode *inode,
> > +		 const struct fuse_iomap_ioend_in *inarg),
> > +
> > +	TP_ARGS(inode, inarg),
> > +
> > +	TP_STRUCT__entry(
> > +		FUSE_IO_RANGE_FIELDS()
> > +		__field(unsigned,		ioendflags)
> > +		__field(int,			error)
> > +		__field(uint32_t,		dev)
> > +		__field(uint64_t,		new_addr)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		FUSE_INODE_ASSIGN(inode, fi, fm);
> > +		__entry->offset		=	inarg->pos;
> > +		__entry->length		=	inarg->written;
> > +		__entry->ioendflags	=	inarg->flags;
> > +		__entry->error		=	inarg->error;
> > +		__entry->dev		=	inarg->dev;
> > +		__entry->new_addr	=	inarg->new_addr;
> > +	),
> > +
> > +	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d dev %u new_addr 0x%llx",
> > +		  FUSE_IO_RANGE_PRINTK_ARGS(),
> > +		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
> > +		  __entry->dev,
> > +		  __entry->error,
> > +		  __entry->new_addr)
>                   ^^^^
> 
> Are the error and dev fields swapped in the argument list?
> 
> The format string expects 'error %d dev %u' but the arguments are
> provided as __entry->dev, __entry->error. This would cause the trace
> output to display the dev value as error and the error value as dev.
> 
> > +);
> > +
> > +TRACE_EVENT(fuse_iomap_ioend_error,
> > +	TP_PROTO(const struct inode *inode,
> > +		 const struct fuse_iomap_ioend_in *inarg,
> > +		 const struct fuse_iomap_ioend_out *outarg,
> > +		 int error),
> > +
> > +	TP_ARGS(inode, inarg, outarg, error),
> > +
> > +	TP_STRUCT__entry(
> > +		FUSE_IO_RANGE_FIELDS()
> > +		__field(unsigned,		ioendflags)
> > +		__field(int,			error)
> > +		__field(uint32_t,		dev)
> > +		__field(uint64_t,		new_addr)
> > +		__field(uint64_t,		new_size)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		FUSE_INODE_ASSIGN(inode, fi, fm);
> > +		__entry->offset		=	inarg->pos;
> > +		__entry->length		=	inarg->written;
> > +		__entry->ioendflags	=	inarg->flags;
> > +		__entry->error		=	error;
> > +		__entry->dev		=	inarg->dev;
> > +		__entry->new_addr	=	inarg->new_addr;
> > +		__entry->new_size	=	outarg->newsize;
> > +	),
> > +
> > +	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d dev %u new_addr 0x%llx new_size 0x%llx",
> > +		  FUSE_IO_RANGE_PRINTK_ARGS(),
> > +		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
> > +		  __entry->dev,
> > +		  __entry->error,
> > +		  __entry->new_addr,
> > +		  __entry->new_size)
>                   ^^^^
> 
> Same issue here. The format string expects 'error %d dev %u' but the
> arguments are provided as __entry->dev, __entry->error, swapping the
> values in the trace output.

Yep, both wrong, both fixed.  Thanks!

--D

> 
> > +);
> > +
> 
> [ ... ]
> 
> 

