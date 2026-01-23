Return-Path: <linux-fsdevel+bounces-75224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KxEOcUhc2mUsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:22:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8858D71A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC36305147A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384237472A;
	Fri, 23 Jan 2026 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZRBw9BB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71C2DFF3F;
	Fri, 23 Jan 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152451; cv=none; b=KPjkvlQgrebMwCOw9mQeGHHCrA+w3e8IeVqiySP768/X8P/VtZOKsGHdQqfuSN3bwRUY4qpkYqnvR7w1aW1axqkKz1eKuY0J2MV4dOAd92M8TE0qQcJtVJYgQrVa2lLyR9ey1XAVrryH5kFe1Q7W5BfXg19MiUK68wEK1Sr+tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152451; c=relaxed/simple;
	bh=XAvD73ipZ1/1hQE+6xfcqQmqd06hJQpToKp6ONC1H3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM3PqU56o84lpOeqE8/mXF6/GoZsTR+OwvpnNhzsvnm1HNpxMLHwSUhDKOKk5cZfvUpWKXgpuQrZL6bW8mk9Hai2hAuFPO3GY5/fv0XThj8bDrLheFIamedxw9ekjCDr2z+2enGc4yNzIL8D9HqaUN25xudz5cWWmNgyFfDV83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZRBw9BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6FCC4CEF1;
	Fri, 23 Jan 2026 07:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769152451;
	bh=XAvD73ipZ1/1hQE+6xfcqQmqd06hJQpToKp6ONC1H3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZRBw9BBNYAP3Jj71Q5j/KoqRrhZWDNjnVmb/CTeTCPVW6JPxkXpKXprAB8gyk6ap
	 kjcrcFznRqsAQfT0uypsvg4sJI9aOplOBN8cvcidIsDtoZWj82kUMFa7IkVZ7TmEsO
	 dmlnuxL4PyX5qKfmVXuVi5z93lhSmbDV8jnXc8QZcDi0aGbRUVSuVtMIeMklRbniYN
	 vorIi0WTrM9eZDXJcftwI3R7/+exBzvBpbiyYXmECZZYuYVd5TjaHgnK3R1t4+pZlj
	 4BMWpDsUw4vu/pNNM9bCJ9dN+UcOTzlSbzRKlZFH1fzLm9OWMPfYY0kGblmbtq4+Py
	 8xF5D0brcDl9w==
Date: Thu, 22 Jan 2026 23:14:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/15] block: factor out a bio_integrity_setup_default
 helper
Message-ID: <20260123071410.GV5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-3-hch@lst.de>
 <20260123000537.GG5945@frogsfrogsfrogs>
 <20260123060833.GA25528@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123060833.GA25528@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75224-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8858D71A67
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 07:08:33AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 04:05:37PM -0800, Darrick J. Wong wrote:
> > On Wed, Jan 21, 2026 at 07:43:10AM +0100, Christoph Hellwig wrote:
> > > Add a helper to set the seed and check flag based on useful defaults
> > > from the profile.
> > > 
> > > Note that this includes a small behavior change, as we ow only sets the
> > 
> > "...as we only set the seed if..." ?
> 
> Yes.
> 
> > > +void bio_integrity_setup_default(struct bio *bio)
> > > +{
> > > +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> > > +	struct bio_integrity_payload *bip = bio_integrity(bio);
> > > +
> > > +	bip_set_seed(bip, bio->bi_iter.bi_sector);
> > > +
> > > +	if (bi->csum_type) {
> > > +		bip->bip_flags |= BIP_CHECK_GUARD;
> > > +		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
> > 
> > /me wonders if this should be a switch, but it'd be a pretty lame one.
> > 
> > 	switch (bi->csum_type) {
> > 	case BLK_INTEGRITY_CSUM_NONE:
> > 		break;
> > 	case BLK_INTEGRITY_CSUM_IP:
> > 		bip->bip_flags |= BIP_IP_CHECKSUM;
> > 		fallthrough;
> > 	case BLK_INTEGRITY_CSUM_CRC:
> > 	case BLK_INTEGRITY_CSUM_CRC64:
> > 		bip->bip_flags |= BIP_CHECK_GUARD;
> > 		break;
> > 	}
> 
> I don't really think that's a good idea here.  BIP_IP_CHECKSUM is a
> really a special snowflake for SCSI HBA (and not even actual device)
> usage, so it should be treated like a special snowflake with the if.
> I sincerely hope no new special snowflakes will show up for the checksums
> in the future.

Fair enough.  The BIP_* flags encoding is ... odd. :)

--D

