Return-Path: <linux-fsdevel+bounces-75421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNfuHcr1dmngZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:04:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616B841CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F37AD301573C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8AF2253AB;
	Mon, 26 Jan 2026 05:03:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EA1ADC97;
	Mon, 26 Jan 2026 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403838; cv=none; b=XOPLmqHL5Mg9H0q3ijRQhPg3aVd4QZ1hc7Lwi9AXXxecpb1Nf91bKwQnJj6yRkDpr7Xvc/7K9QTE39mT/spBMGdEyBl7ayuhEhp73tWElvaHE0wunJfyNjElKc0iaSxRZqP6kw8Etvr85KOvPmFbMwA7sYBe5r6RHGnLSmp6Hy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403838; c=relaxed/simple;
	bh=ZpiqmHWG/c+rs2V/R+5dF5nppepKPkjzRw8NuGrBQfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR568UaKwtgWNbrc2GO3Jg6f49GkChv/+R6lHhGekSWNVUO4Yw6WodAajeB2xBd6RW+VxFxmcDKYaiuJWNuhg5op6tRWLT/8TVLk/4egAwdm0XOKQnw8dMpljqybll1GL0Vkq6+57PosMhbnvD7BpR3CH0N0dd6ieBsm8z9eAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9C38227A88; Mon, 26 Jan 2026 06:03:54 +0100 (CET)
Date: Mon, 26 Jan 2026 06:03:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
Message-ID: <20260126050354.GA31813@lst.de>
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-2-hch@lst.de> <20260123000113.GF5945@frogsfrogsfrogs> <20260123060324.GA25239@lst.de> <20260123071323.GU5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123071323.GU5945@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75421-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4616B841CA
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:13:23PM -0800, Darrick J. Wong wrote:
> > > Er... does someone initialize it eventually?  Such as the filesystem?
> > > Or maybe an io_uring caller?
> > 
> > For integrity metadata?  The code called later fills it out.  But it
> > doesn't fill non-integrity metadata, so we need to zero it.
> 
> Ahhh, right, the app tag or whatever?

No, the app_tag is zeroed by the PI code itself.  NVMe added the concept
of generic user specified metdata.  That metadata could either be only
the PI tuple, contain the PI tuple inside of it, or not contain any PI
tuple at all.  This non-PI part is what needs explicit zeroing here.


