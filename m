Return-Path: <linux-fsdevel+bounces-78301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB+uFkT8nWmeSwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:30:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29518C15D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14DA3072449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5B3ACEED;
	Tue, 24 Feb 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px7UjPYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E03ACA5D;
	Tue, 24 Feb 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961406; cv=none; b=llBU7AiGRyy1XitZJabE+xwF2NDFSSXlaOIzNMNX+sGy/Ssff96mEeJXvlbmj33lNPA4ifOq7hOLlDNxAyCBy17HPpv6LduL4R1nPtyxtVcy7TFuMnMqcaEbw3NMQfSm1dah8ZiYTCJMU4aFBlmFlRERua8ht1Ym3CPvKKqQ2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961406; c=relaxed/simple;
	bh=Y+KuAB3Y519ZaKRKtPmDXY6lfcAg2czTRF4OrFb7eCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkmyqNxdZ4tgkK5Spe7oWKeD/z8Kq5e4ozjkJoHOaY/Y7SMKu8OUvMvbKcOJvS/DiYWZqdaKzdmwf71XfpbblpeyyVa9JUMtfHDqH3ydnO53ac6Hv7P8LpUAdDf5LOUZ4Fff6IxMm4w0rm6ylwrUoyBbGnefuHdw0BAHuBE2igM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px7UjPYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65740C116D0;
	Tue, 24 Feb 2026 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961406;
	bh=Y+KuAB3Y519ZaKRKtPmDXY6lfcAg2czTRF4OrFb7eCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=px7UjPYLfUoH3X/7gbwbWpmIIwWfJGWUM1mB440EWwxrugf2ugzwWxSpaTkhTLYTW
	 9/TZhTkQh6C/DH7vsK8kJc+60JYROkgMYcLIk9GAleTMcnWiEFbTYiw4PYE3fvu8IL
	 ZTtZmsCyBQwQ18KzTtvOZu7avPl3tPTNQGbBtkIC5Lmtw4hHVyGEL2dxjRTTdKlu1r
	 C2y8mJ/nj1JEo3KlBXLmUR4F62pqAaUdK8aQw3vcR+tUNEWrtWYfw6bCD7fAGYQnM3
	 O+99aYSmfnZNBSliiTGW2JWqS0ajNzW7zPQXfmHYG+t3Ex07LgRvrJrtyuizi9rBE5
	 /75ZKa4tYgpKg==
Date: Tue, 24 Feb 2026 11:30:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bpf@vger.kernel.org,
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 29/33] fuse: support atomic writes with iomap
Message-ID: <20260224193005.GD13829@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
 <177188734865.3935739.5549380606123677673.stgit@frogsfrogsfrogs>
 <ej24ajmh6ltfe37yiy6qzqko5p6y5eecixzybexgxs5oo45iuu@ufvfjxvppc3o>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ej24ajmh6ltfe37yiy6qzqko5p6y5eecixzybexgxs5oo45iuu@ufvfjxvppc3o>
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
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78301-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC29518C15D
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:58:31PM +0000, Pankaj Raghav (Samsung) wrote:
> > +	}
> > +
> >  	/*
> >  	 * Unaligned direct writes require zeroing of unwritten head and tail
> >  	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
> > @@ -1873,6 +1909,12 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
> >  	if (!iov_iter_count(from))
> >  		return 0;
> >  
> > +	if (iocb->ki_flags & IOCB_ATOMIC) {
> > +		ret = fuse_iomap_atomic_write_valid(iocb, from);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> 
> I still haven't gone through the whole patch blizzard but I had a
> general question here: we don't give ATOMIC guarantees to buffered IO,
> so I am wondering how we give that here.

Oh, we don't.  generic_atomic_write_valid rejects !IOCB_DIRECT iocbs.

> For example, we might mix
> atomic and non atomic buffered IO during writeback. Am I missing some
> implementation detail that makes it possible here? I don't think we
> should enable this for buffered IO.

<nod> Now that y'all have an lsf thread on this, I agree that not
supporting buffered writes in fuse-iomap should be more explicit.

	if (iocb->ki_flags & IOCB_ATOMIC)
		return -EOPNOTSUPP;

--D

> -- 
> Pankaj
> 

