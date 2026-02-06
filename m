Return-Path: <linux-fsdevel+bounces-76517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBseEvlRhWmV/wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:29:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E868F94E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4AD7301940A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA372641FC;
	Fri,  6 Feb 2026 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV7J+ZPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46226056D;
	Fri,  6 Feb 2026 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344831; cv=none; b=On3dINc+IspghJm8EkB3/jMzXBGtbUUc2u9zDvjKu/KRz/uQ6aGYErwXk3w1BNe8UVTaSpiBbwuOKULshlHQkxQNaOu3yPPWvSsrvp61eqjNQTaYW6nl+w2+7vXeWynmPlm8XTz7wGWfSBO46J9GKhAZIyEc6/psAeByM6aUq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344831; c=relaxed/simple;
	bh=OgultMdtKlAnkcqfSuJC4xDW6u4QRyvvLiMlJor9E3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdDN9H/XtGNsoG7qeVHyV5pXEi2x3MxAgKReFnRDwNbBFm5GAsbtlPthEFsLyPASWqfnpIvoXXqiFkirKgzCvQGNbVEpRMC97hDIGqpSdPoy/zlXIE78WblsI4gcclriCqknJtFP13Nws0xAxYTMeYRy2h0mNcERzjBYCRkvcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV7J+ZPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209D2C4CEF7;
	Fri,  6 Feb 2026 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344831;
	bh=OgultMdtKlAnkcqfSuJC4xDW6u4QRyvvLiMlJor9E3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TV7J+ZPngfM7BKREpPPyHLkCp4aYBif0FSnJeIn1wzYU6q3nn/SSum/30rX682MQ+
	 Z3lLTy20PRfwTbrlF2ptjyRqHw9nuckJfcZiT9CrqAh3r8tSviijXPqccC41pptDRJ
	 1tuJCUUHfJy2KRR2+z0h9ykRbAKel1NIeARSCZmnrTVV7FVuIjJIkh/T6z0/40/Kd3
	 BpjxLKo9PE2OZGpcx7VCsl3qzQmlGqfNn9My9gqQ6eyQzt+5bIEAgxtOIrDXYLAsE2
	 R1h6gvvRRdUUhAecY80SWq1TqYrC67/jfqaqCdt0yW/VaDf5LlGNCHZLxKxHJCcEUV
	 Z6sVnu16gTFaQ==
Date: Thu, 5 Feb 2026 18:27:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/31] fuse: implement inline data file IO via iomap
Message-ID: <20260206022710.GI7686@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810874.1424854.5037707950055785011.stgit@frogsfrogsfrogs>
 <20260205190206.1890644-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205190206.1890644-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76517-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E868F94E2
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:01:07AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
> > in response to an inline data mapping.
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
> commit 1263eae0852acb1359182377ad94d570701e2274
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: implement inline data file IO via iomap
> 
> Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
> in response to an inline data mapping.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > --- a/fs/fuse/fuse_iomap.c
> > +++ b/fs/fuse/fuse_iomap.c
> > @@ -398,6 +398,150 @@ fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
> >  	return ret;
> >  }
> >
> > +/*
> > + * Use the FUSE_READ command to read inline file data from the fuse server.
> > + * Note that there's no file handle attached, so the fuse server must be able
> > + * to reconnect to the inode via the nodeid.
> > + */
> > +static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
> > +				  loff_t count, struct iomap *iomap)
> > +{
> > +	struct fuse_read_in in = {
> > +		.offset = pos,
> > +		.size = count,
> > +	};
> > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > +	struct fuse_mount *fm = get_fuse_mount(inode);
> > +	FUSE_ARGS(args);
> > +	ssize_t ret;
> > +
> > +	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
> > +		return -EFSCORRUPTED;
> 
> Does this code leak memory when the BAD_DATA check fails?  Looking at
> the call chain:
> 
> fuse_iomap_set_inline()->fuse_iomap_inline_alloc() allocates
> iomap->inline_data via kvzalloc.  If the iomap_inline_data_valid check
> fails (i.e., iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data)),
> the function returns -EFSCORRUPTED without freeing iomap->inline_data.
> 
> Other error paths in this function (around the fuse_simple_request call)
> properly call fuse_iomap_inline_free(iomap) before returning errors.
> 
> The caller fuse_iomap_set_inline doesn't clean up iomap->inline_data on
> error in the read path (line 538: 'if (err) return err;'), so the
> allocation is leaked when a FUSE server returns an IOMAP_INLINE mapping
> with length > PAGE_SIZE.

Yep, it does leak the ioend and the bio.  I'll amend this to call
fuse_iomap_inline_free on its way out.

> > +
> > +	args.opcode = FUSE_READ;
> > +	args.nodeid = fi->nodeid;
> > +	args.in_numargs = 1;
> > +	args.in_args[0].size = sizeof(in);
> > +	args.in_args[0].value = &in;
> > +	args.out_argvar = true;
> > +	args.out_numargs = 1;
> > +	args.out_args[0].size = count;
> > +	args.out_args[0].value = iomap_inline_data(iomap, pos);
> > +
> > +	ret = fuse_simple_request(fm, &args);
> > +	if (ret < 0) {
> > +		fuse_iomap_inline_free(iomap);
> > +		return ret;
> > +	}
> > +	/* no readahead means something bad happened */
> > +	if (ret == 0) {
> > +		fuse_iomap_inline_free(iomap);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> > @@ -511,8 +663,28 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
> >  {
> >  	struct fuse_inode *fi = get_fuse_inode(inode);
> >  	struct fuse_mount *fm = get_fuse_mount(inode);
> > +	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
> > +	struct iomap *srcmap = &iter->srcmap;
> 
> Can this container_of usage corrupt memory?  Looking at
> fuse_iomap_writeback_range, it calls fuse_iomap_end with &write_iomap,
> which is a stack-local struct iomap variable (not embedded in an
> iomap_iter):
> 
> fuse_iomap_writeback_range()
>     struct iomap write_iomap = { };
>     ...
>     fuse_iomap_end(inode, offset, len, 0,
>                    FUSE_IOMAP_OP_WRITEBACK, &write_iomap);
> 
> The container_of macro computes an invalid pointer by subtracting the
> offset of the iomap member from the address, resulting in iter pointing
> to garbage memory on the stack.  Subsequently, accessing iter->srcmap
> reads from invalid memory, potentially causing undefined behavior or
> crashes.
> 
> The iomap core calls fuse_iomap_end via fuse_iomap_ops where iomap IS
> properly embedded in iomap_iter, but the direct call from
> fuse_iomap_writeback_range violates this assumption.

Oops, that's a severe bug.  fuse_iomap_writeback_range should indeed
define a whole iomap_iter instead of just the iomap.  I'll fix that,
thanks for pointing out these bugs.

--D

