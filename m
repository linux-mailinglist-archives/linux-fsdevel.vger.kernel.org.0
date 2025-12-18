Return-Path: <linux-fsdevel+bounces-71687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C5CCD6F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 20:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FA583022B41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC86264628;
	Thu, 18 Dec 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwy2M4z+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F697237163;
	Thu, 18 Dec 2025 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087398; cv=none; b=Y2jffSOuSHwCeht0aKmxzqdqm6Bz0tuSCSiicMUJxPv8DPtVxgeq/s/OUBJVrNRs/NXE6JH934QfvKN55NGiLoBQdeDwDOKMSTNWOWXOBEfomCi1ePj/39kSNJmQ2mSW1LPtCV5itsyWHE7YWmEoDkvSLi9lzlWD5cWiwbnEMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087398; c=relaxed/simple;
	bh=tkqO3vpCZantWcHwrnUs6vVfsh10cw+iHhymLHph53M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4FVWqriyXasBAQEostUwGFgde0ns4jBesFwbrfzfvx07pJaIXaa1RPo92cbrOgnH2DNXxVF9eLhFAxTNVyLVP2+nwLWbfooUljpJor6UopQLV4HKK9IJ7G9doU8IlpBhRzRL64wf1EsNO24kvC9J+w2fSE4VvWGzF1NTy3Mj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwy2M4z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240CFC4CEFB;
	Thu, 18 Dec 2025 19:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766087398;
	bh=tkqO3vpCZantWcHwrnUs6vVfsh10cw+iHhymLHph53M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwy2M4z+cTH1GbJEDPiCXP0zgAMzJlC2B4QVH9pcB4WCGESbf+kGMkqvJ3ABgthZK
	 AeUkmbksp6gw4pTGczouI6d5eDMmZCqzvkCkwwTdzGR6jaPlL3suqrIYwOmZuL8uyC
	 nk8Mt5qW8DQ+F/DR64NNI6q1VVZ6HpZTDsFZwav7b41pe4DBIx2hzzr73TH2fUjw6W
	 RAu33WPR88XMvbHgnYx4XVNHBbyvHLuGPcUh1U8TEIYMT54Ac3htoWKdzpNSTCPfZz
	 iVZR9x9Qs+tgXp02sa74xtIxNnif1y77fNoRGW2tks194k541C6tS1HPithZZsZjU2
	 DH35id2+NynoQ==
Date: Thu, 18 Dec 2025 11:49:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: send uevents for filesystem mount events
Message-ID: <20251218194957.GZ7725@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
 <aUOQkY3s_D_REIsH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUOQkY3s_D_REIsH@infradead.org>

On Wed, Dec 17, 2025 at 09:26:41PM -0800, Christoph Hellwig wrote:
> > +#define ADVANCE_ENV(envp, buf, buflen, written) \
> > +	do { \
> > +		ssize_t __written = (written); \
> > +\
> > +		WARN_ON((buflen) < (__written) + 1); \
> > +		*(envp) = (buf); \
> > +		(envp)++; \
> > +		(buf) += (__written) + 1; \
> > +		(buflen) -= (__written) + 1; \
> > +	} while (0)
> 
> Any reason this is a macro vs an (inline?) function?  Looking at this a
> bit more, could this simply use a seq_buf?

I'll change it to something like this:

	seq_buf_init(&sbuf, buf, buflen);
	envp = env;

	/*
	 * Add a second null terminator on the end so the next printf can start
	 * printing at the second null terminator.
	 */
	seq_buf_get_buf(&sbuf, envp++);
	seq_buf_printf(&sbuf, "TYPE=filesystem");
	seq_buf_putc(&sbuf, 0);

	seq_buf_get_buf(&sbuf, envp++);
	seq_buf_printf(&sbuf, "SID=%s", sb->s_id);
	seq_buf_putc(&sbuf, 0);

	...

	/* Add null terminator to strings array */
	*envp = NULL;

That does look a lot cleaner than opencoding it.

--D

