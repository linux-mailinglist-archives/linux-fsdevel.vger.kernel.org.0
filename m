Return-Path: <linux-fsdevel+bounces-76516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGeXB2JPhWn5/gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:18:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D4F92F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E37302E7CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356B231A23;
	Fri,  6 Feb 2026 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU0bhYT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5013D638;
	Fri,  6 Feb 2026 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344278; cv=none; b=GXVai6Vzx16saOotWaf/7UsJTHQHrt6xsy+E/xSoido2zNyJm14kBdfR4zRDPUNbxr4qkGD7m4gcKVpI3+t3m04TD2GJS/tcrAbObVTNV52pJLIhCbuQ8RrVc3WUcli+vwuDYlUsrfriKWHkzwfr5DIYEHXeE9Sxloo1Z9yyJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344278; c=relaxed/simple;
	bh=H7hcb4yD74v+ArCF3EQg+vG8Omg40qciQ9LrMi5+vco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGw4AI284ydWuKImZ1wTueJI+skeSCxmRikxVf9bVwgSaD1L6/EPGpo9MIg9pO/jel5mQ9cIe8dA/YWm7JiE9aAVlc/HvRoLs01iU6oyPj8+kSIfv0PQ3oDMq4f6e4jSYJMZE6KcDH2Ba39SzXrUBSqh21TVSWFqGPEaUtKhN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU0bhYT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3FDC4CEF7;
	Fri,  6 Feb 2026 02:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344278;
	bh=H7hcb4yD74v+ArCF3EQg+vG8Omg40qciQ9LrMi5+vco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lU0bhYT7KhkQYUTGnwX8e1qmQEHMRwPQcerlIlCK1l/U1y23BAwXJcdcGbmjo9mYR
	 ZjZxJfPMTnyxM/iRU5bkFGzxjtEWQ2w8GTkfHblEZgDHMmmQKasn2sf+3p5gSZcxUR
	 DwFHx/MLzAF7r5cwZRS00H18YsheVwNyVDmSvlE0KHJ3Oe/Zfp3/aUdrOSb9b7Nrm7
	 1IY4TC/9jgEZi7jhNmJIzGp/rJkCO5w/fazeKoxrX8LFgbpw6bHsmDDBVH9JUIWT7n
	 uKQVwvUMdo75VUiA5v7fhycxuxP83zDtJzVXT2z4P17J8flnC7HS1KYOODt3OwSgRH
	 VanoG4+fDTV5Q==
Date: Thu, 5 Feb 2026 18:17:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/31] fuse: query filesystem geometry when using iomap
Message-ID: <20260206021757.GH7686@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810765.1424854.10969346031644824992.stgit@frogsfrogsfrogs>
 <20260205190840.1958463-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205190840.1958463-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76516-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A24D4F92F6
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:07:55AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a new upcall to the fuse server so that the kernel can request
> > filesystem geometry bits when iomap mode is in use.
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
> commit d529d13100b2e00c33a507c371b6c1b19f2206ae
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse_trace: query filesystem geometry when using iomap
> 
> This commit adds tracepoints for the FUSE_IOMAP_CONFIG operation,
> enabling tracing of filesystem geometry queries when using iomap with
> FUSE. The tracepoint captures configuration flags, block size, link
> limits, time granularity and ranges, maximum file size, and UUID length.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > --- a/fs/fuse/fuse_iomap.c
> > +++ b/fs/fuse/fuse_iomap.c
> > @@ -743,6 +743,8 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
> >  		return error;
> >  	}
> >
> > +	trace_fuse_iomap_config(fm, outarg);
> > +
> >  	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
> >  		return -EINVAL;
> >
> 
> [ ... ]
> 
> > diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> > --- a/fs/fuse/fuse_trace.h
> > +++ b/fs/fuse/fuse_trace.h
> 
> [ ... ]
> 
> > @@ -1005,6 +1014,45 @@
> >  		  __entry->mode,
> >  		  __entry->newsize)
> >  );
> > +
> > +TRACE_EVENT(fuse_iomap_config,
> > +	TP_PROTO(const struct fuse_mount *fm,
> > +		 const struct fuse_iomap_config_out *outarg),
> > +	TP_ARGS(fm, outarg),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,			connection)
> > +
> > +		__field(uint32_t,		flags)
> > +		__field(uint32_t,		blocksize)
> > +		__field(uint32_t,		max_links)
> > +		__field(uint32_t,		time_gran)
> > +
> > +		__field(int64_t,		time_min)
> > +		__field(int64_t,		time_max)
> > +		__field(int64_t,		maxbytes)
> > +		__field(uint8_t,		uuid_len)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->connection	=	fm->fc->dev;
> > +		__entry->flags		=	outarg->flags;
>                                                            ^^^^
> 
> Does this truncate the upper 32 bits of the flags field? The flags field
> in struct fuse_iomap_config_out (include/uapi/linux/fuse.h:1471) is
> defined as uint64_t:
> 
> struct fuse_iomap_config_out {
> 	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
> 	...
> }
> 
> But the trace event declares it as uint32_t in TP_STRUCT__entry. While
> current flag definitions (FUSE_IOMAP_CONFIG_SID through
> FUSE_IOMAP_CONFIG_MAXBYTES) only use bits 0-5, using uint32_t will lose
> the upper 32 bits if future flags use them.
> 
> Should the trace event field be declared as uint64_t to match the
> structure definition?

Yes.  Fixed, thanks!

--D

