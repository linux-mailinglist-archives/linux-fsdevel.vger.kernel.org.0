Return-Path: <linux-fsdevel+bounces-77678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLAqNGOulmlkjQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:32:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924E15C64F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC7230136A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12712EF64F;
	Thu, 19 Feb 2026 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNZPzLij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8951EB5F8;
	Thu, 19 Feb 2026 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482709; cv=none; b=NPAPqR3t8sb3n8LRsg/1yMF364kvQzkvYHTzp5jEAcqD8rSlV3XlUz5Q6msuqgYRarWgIrjFTUVQEFdxzsVuha5Cg7XNVKMF+Cu0cnEc38Jgc58CNbMVR5CejLWBIyLkGlekQM8gCEFaEiYAy4wMmn4VN8B6bddXebDLjfg3yWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482709; c=relaxed/simple;
	bh=0HX4J8Dqjk/eO9ijBN0eFtuJSD4xDBAQIR6xOfcZTZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jneuyWvjVkVMplzp8iOM7Gn456hMuc1GCLHARKRmz5RC6Y+c3avYEvAasQ2aHM/X17WJFr2mQAsL7tvLUTzEBYQR712USOATHZl9uxj8KsSK8cYtOe2NPB85+rw9IXeusnkEEB8UGJMJeIvQWRoTyp6SMfUtyJMJqowniPl3RpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNZPzLij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F05C4CEF7;
	Thu, 19 Feb 2026 06:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771482709;
	bh=0HX4J8Dqjk/eO9ijBN0eFtuJSD4xDBAQIR6xOfcZTZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNZPzLijTHEDRBrPjNXbh8hR0rWIdeIkjxt0UeVC7oNOSxO7LTDD3FXlEVcpMuXOe
	 rPqoE1Z0Z+aDhRKOn+RB8+CAIyss+to39eMZr9nQBK3ZLPq2UdX2sTLSbCFQ9nSvRc
	 ty3XzoxLH0IwwNgSV6K6UO3sTPJquKEr/C7nDrxmVD5m5P5b8AGQEGOoTeE3Iw2Qxk
	 t2WtyOxmokBFCmloXRpZhEM+pkrMS/SCXkwRllvl4tvqL0tAgBYY36xMIyOXRIyXbu
	 6YWyL+GQAoNRO57yWb+f9tuza5RG9e8vMgEfvWxjjhcwpYWjHIXzVvwOIZtYgmdZW6
	 ExAYUlzEeiWOQ==
Date: Wed, 18 Feb 2026 22:30:59 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v3 06/35] fsverity: pass digest size and hash of the
 empty block to ->write
Message-ID: <20260219063059.GA13306@sol>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-7-aalbersh@kernel.org>
 <20260218061834.GB8416@lst.de>
 <wl5dkpyqtmbdyc7w7v4kqiydpuemaccmivi37ebbzohn4bvcwo@iny5xh3qaqsq>
 <20260219055857.GA3739@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219055857.GA3739@lst.de>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77678-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6924E15C64F
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 06:58:57AM +0100, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 01:17:52PM +0100, Andrey Albershteyn wrote:
> > On 2026-02-18 07:18:34, Christoph Hellwig wrote:
> > > On Wed, Feb 18, 2026 at 12:19:06AM +0100, Andrey Albershteyn wrote:
> > > > Let filesystem iterate over hashes in the block and check if these are
> > > > hashes of zeroed data blocks. XFS will use this to decide if it want to
> > > > store tree block full of these hashes.
> > > 
> > > Does it make sense to pass in the zero_digest vs just having a global
> > > symbol or accessor?  This should be static information.
> > 
> > I think this won't work if we have two filesystems with different
> > block sizes and therefore different merkle block sizes => different
> > hash.
> 
> Looking at this a bit more - you're storing the entirely zero_digest
> in struct merkle_tree_params, which is embedded intothe
> fsverity_info.  This means that you can trivially access it using an
> accessor of the fsverity_inode.

Not in ->write_merkle_tree_block(), since that's called during
FS_IOC_ENABLE_VERITY before the fsverity_info has been set.

> It also means that you actually bloat that structure quite a bit for
> constant file system wide information.  Maybe it's time to split
> out the file system wide part of it into a separate structure?

The hash of a block of zeroes depends on the salt, which is a per-file
value.  The salt is optional, though.

There is already another dynamic allocation done only for files that use
a salt: merkle_tree_params::hashstate.

The hash could be stored in that same allocation for salted files, or as
a fixed value in struct fsverity_hash_alg for unsalted files.  Then at
least unsalted files wouldn't use any additional memory per-file.

- Eric

