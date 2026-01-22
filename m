Return-Path: <linux-fsdevel+bounces-75138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULZYCktncmmrjwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:07:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759246BF8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B0A3028B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36472310764;
	Thu, 22 Jan 2026 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QODMgOqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375320298D;
	Thu, 22 Jan 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105067; cv=none; b=M86Woi1zwOpMHN9ZgbpuxYDGXJSVvcL9kATlq9iWrKirIAib5VflXrIJrw4er+XoqiF/WGttYV/ePbAHcAaTo1FAyn/GdyhmDCzoQuC3VkNMOFeCd4siaHJ3k7SUjsTvSrrR0Ab9KD7ZoIntimDo6/vCCZXzY69untz3K0TDW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105067; c=relaxed/simple;
	bh=NRcfnBfc/uf0Kgun1SB8oAWnZ++/lrKR1XlM4gal20k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhaqKhDjSZqSAE1N+x9KnyyqY/OHZMkt+NMPaDRXeglaxAt6hor/7VxrvIYIVEAWTwdyciuzFrkFmD79WoJEHFKJ7rtPhCSQxwZo346a675PoqzhQymbbxZiZI8n/6VkAQ9S+ormo5+fmh2M6QvvHIYP8NaV7Iq7+e35QQoiq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QODMgOqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB5EC116C6;
	Thu, 22 Jan 2026 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769105064;
	bh=NRcfnBfc/uf0Kgun1SB8oAWnZ++/lrKR1XlM4gal20k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QODMgOqS1CoZDHQRoxAeZjfHZa3GlQYfTY58ZEkbbhrCLMNmT9uxNd6/sUzXluz0e
	 PDln5IwNp7FCRmz5DQ+hIUhBD1fWzHcvvBsc55i+Iw5ebXOH3bIa3M4aw4VHEDQnfQ
	 +NrPQ0ns+gHf9SDaf2GBJVEaldp7mj84kPGCBjYC1NzwbUJe2HmAznz+kr7hRVFm2x
	 9J2pe0g9wvkOoLkaYtJTzIrSnR2xPzOtJnjK+GLXPMJuHV1VpMLF9Wl+6nnysCpDLZ
	 LwkFVClSK5ZIZy3SlrXy1GJgEoKQ7UXVb0mgE7mBsY8QflczEBsCrno6zevpOLbEhD
	 7Y3d7TOkTpUSA==
Date: Thu, 22 Jan 2026 10:04:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/15] iomap: allow file systems to hook into buffered
 read bio submission
Message-ID: <20260122180424.GC5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-12-hch@lst.de>
 <20260122004933.GO5945@frogsfrogsfrogs>
 <20260122060114.GB24006@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122060114.GB24006@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75138-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 759246BF8B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 07:01:14AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 21, 2026 at 04:49:33PM -0800, Darrick J. Wong wrote:
> > > verifying data checksums.  Allow file systems to hook into submission
> > > of the bio to allow for this processing by replacing the direct
> > > submit_bio call in iomap_read_alloc_bio with a call into ->submit_read
> > > and exporting iomap_read_alloc_bio.  Also add a new field to
> > > struct iomap_read_folio_ctx to track the file logic offset of the current
> > > read context.
> > 
> > Basically you're enabling filesystems to know what's the offset of a
> > read bio that iomap is about to start?
> 
> Yes.
> 
> > I guess that enables btrfs to
> > stash that info somewhere so that when the bio completes, it can go look
> > up the checksum or something, and compare?
> 
> Yes, where something in this series is the ioend that the bio is embedded
> into.
> 
> > Or for PI the filesystem can do the PI validation itself and if that
> > fails, decide if it's going to do something evil like ask another
> > replica to try reading the information?
> 
> Yeah.  If your file system can do it.  Nothing in this series does
> that, though.

<nod> and at this point we're never going to circle back to that project
either.  :/

In the meantime I think I've understood this patch well enough to say
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

