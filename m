Return-Path: <linux-fsdevel+bounces-78259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JPfGr2gnWlrQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:59:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDE18756D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE2F313140F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6260737FF43;
	Tue, 24 Feb 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ttQedrwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9C39A7F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937937; cv=none; b=LTkfdsKKzGJsXRAHwXiK03fCawT8LoyZweRBRTIcfSg40fn5eq31WBCns9mc+RDUmrqqVHRJSOl71m0RcMWe5t/JFOVEPC7Wwj7XN3WtDalv4Fuj535SQrA7Ev9g/2y4W8SlCFQtIrvD8CIbGGQl6jCzMZ0hGvD7/GjVcCX4rOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937937; c=relaxed/simple;
	bh=DDw96xmoZbUt+zs0MoI3/CFecRPmq/Pl4/MVFM0h0dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3ovQOUIObHvVpT73FJWUOScQeMmCZGpomRRuk0/GVsmzF5ryX6xKtu2553rC4btVcdGU4OT7cnebz1P5OJRmcnWmUfSsIIsTXWtStR9IebsMSYqf7fYjeDSf3FVZYNhdHUkhdmgPmKnpNjTjBmebUr55FeETS3pZxZhfujsGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ttQedrwE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Feb 2026 12:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771937923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+wivhIr528+W6wLESqvbuF0C1RtOB8ByC0jlMyM6cc=;
	b=ttQedrwEbhqs8TPNzb9B3Y861TAKH54StDmEW8UqoxOWKwPfTGhRbkouy/LuWORW1iTAq6
	3iX6s7XAptUtrsVJdnqPjv+U6/FPE/E3+kZLl+JhKrSQgHWm2mr9VDj5jIgTonPhNqUJ6H
	dhUIkRCp0FElxpQjDjSRyKjLXG75it4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 29/33] fuse: support atomic writes with iomap
Message-ID: <ej24ajmh6ltfe37yiy6qzqko5p6y5eecixzybexgxs5oo45iuu@ufvfjxvppc3o>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
 <177188734865.3935739.5549380606123677673.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177188734865.3935739.5549380606123677673.stgit@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78259-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: BDFDE18756D
X-Rspamd-Action: no action

> +	}
> +
>  	/*
>  	 * Unaligned direct writes require zeroing of unwritten head and tail
>  	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
> @@ -1873,6 +1909,12 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
>  	if (!iov_iter_count(from))
>  		return 0;
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		ret = fuse_iomap_atomic_write_valid(iocb, from);
> +		if (ret)
> +			return ret;
> +	}
> +

I still haven't gone through the whole patch blizzard but I had a
general question here: we don't give ATOMIC guarantees to buffered IO,
so I am wondering how we give that here. For example, we might mix
atomic and non atomic buffered IO during writeback. Am I missing some
implementation detail that makes it possible here? I don't think we
should enable this for buffered IO.

-- 
Pankaj

