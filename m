Return-Path: <linux-fsdevel+bounces-74707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON0BG2PQb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:58:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB049E98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A77A44DF91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3753E449EDC;
	Tue, 20 Jan 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQxlZ4MG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897EA33D4FA;
	Tue, 20 Jan 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932041; cv=none; b=qsiEA15JG8DNoCDEtOUvl5deS+zAdYBGUb7gGJKUdesZSB3LqYTZjNzep+Sz8HWgdDjCIHr0mT8GVajbKn6YlYg9h1k8Nf22vcVoxjYudmrnGUTfElwnuyqyxhu0qmRfTHmpiOOm4RDxb58YRkIFMke050hrk02iVrsicEuYVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932041; c=relaxed/simple;
	bh=ncigG/ePE2ZSWRzUXnkvsuMiY0IalkDBdmaSUX8A6DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/ihi2bjIulYUKAI0RNs1EnmDI9Obk/Ou82jH0jnjkzLD3BPGqfGxeu/aNA9FJKiVRFWyrQDAffvhzGfNAH7dmipm/CYcw6XcEltJLlIyyejS4OMCWFC283zeOnncLKZWZ/dNX0ZLkue/wPjlJ9X+vqSHehpVwrEkLE/OSjc2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQxlZ4MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0319FC16AAE;
	Tue, 20 Jan 2026 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932041;
	bh=ncigG/ePE2ZSWRzUXnkvsuMiY0IalkDBdmaSUX8A6DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQxlZ4MGc+TNGsdrGubT4ynqhlBY1QVPqAJFHiDQpCF69YpiKaQf1XWzEABmUYIsM
	 dY78fDOp75gPArmD9pDdRQiTsdacoZ3alj6QkpyRX8PAtxiPOBNn9xnY3IExCtZw/3
	 heAZM7zaIu1QdKQfPizvnFPaKAiR6mIrP5PeGYsr4QLEDEvUxvEVh+7nIkSwXaTdT1
	 8YYIPJER95dm47DNaKyK9Se+D/Pp7q83xpdA5t0HVp70J0Y+gT5RggedZd+iXc40hj
	 igszrudS0U+MlIutgwZ4CwpSu+QYCIuVjGrJID4cn0ThxqfJGenhzrF0foEBdYHOZR
	 4gYlkn8r0dGvw==
Date: Tue, 20 Jan 2026 10:00:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6.1 11/11] xfs: add media verification ioctl
Message-ID: <20260120180040.GU15551@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
 <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs>
 <20260120041226.GJ15551@frogsfrogsfrogs>
 <20260120071830.GA5686@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120071830.GA5686@lst.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74707-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 18EB049E98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 08:18:30AM +0100, Christoph Hellwig wrote:
> 
> > +		unsigned int	bio_bbcount;
> > +		blk_status_t	bio_status;
> > +
> > +		bio_reset(bio, btp->bt_bdev, REQ_OP_READ);
> > +		bio->bi_iter.bi_sector = daddr;
> > +		bio_add_folio_nofail(bio, folio,
> > +				min(bbcount << SECTOR_SHIFT, folio_size(folio)),
> > +				0);
> 
> You could actually use bio_reuse as you implied in the previous mail here
> and save the bio_add_folio_nofail call.  Not really going to make much
> of a difference, so:

Hrm.  Is that bio_reuse patch queued for upstream?  Though maybe it'd be
easier to make a mental note (ha!) to clean this up once both appear
upstream.

> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

--D

