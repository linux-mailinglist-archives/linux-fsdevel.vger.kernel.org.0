Return-Path: <linux-fsdevel+bounces-79491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFDiNCKPqWni/gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 15:11:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F662130D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 15:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382BE302D09C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09798396584;
	Thu,  5 Mar 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0M+oNSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF23A0B13;
	Thu,  5 Mar 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719886; cv=none; b=F+7cVQ5VU6Lo7JhsjxP7ebsE8Ev+PRycXJB5qMxPS8kommfPMgja9G2llIg8oK+I6YOBFTPWxKigSeLsLeXct8GUOT1C6oWcsFBFJZtZ47TUdKlLwGuXt+expeRFQIRGWxU/PrnYS37jjcTPhPmj6KolNImf1IiRST7ohR+MnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719886; c=relaxed/simple;
	bh=B8mvh0Htan+FopbEQT5zI/wsx82EDniiBryEpva3/u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+xg8Rg6h+HpF4fwQYqjm+oBkYbiKpVIwU6yQJZD175UfLg0EY/ByAaGQkjgrxtQfKaL6rNOz0oinZXk85UlMNswQutkvjk4t3bm6SsZBj0gTZpVxP7fudVTPDrFFoFKIwLsKjqumEJj8wvYm7Ctf5fn1plxselsxdnkRdZ11Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T0M+oNSf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BEtMQwJ41ps4Z2R0nTRGNa9qDDL4Xks6T2KCI2MRAtE=; b=T0M+oNSft7UuOf+isJ9Aj3ocbW
	OoL/ahFy90CY0DllJPJn7Swnwb9NOBGSwpoQylnUEUy81bPHuvBm2aAOFXxwRg7KdJ8MSBTRycp/2
	cTR24UizmNDTzhXU8xmLEfTAMf8H34OksBO07YdUwARSxAZ9QNsBhJQhmnENSg1BxENneHwXZ+Yn5
	ZbhNp2wuG/RETR3kcvnVgSkppdDGMay1UMeAVtykzHiWOTTjp+KTUMLxD7p+1Atvk45PO2pGmyETT
	t7b8Omyc736qCm+udI688korwAmI+cUiQcm0NnZp7obcK8cRRz2anYBZrlfY2k9vQIendDOugqNrj
	aW2NRxog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy9QC-00000001vT1-3PJh;
	Thu, 05 Mar 2026 14:11:24 +0000
Date: Thu, 5 Mar 2026 06:11:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aamPDBAAuK8vvYDw@infradead.org>
References: <aY6_eqkIrMkOr039@infradead.org>
 <aY9hY7TwgMXJNzkI@bfoster>
 <aaXesgEmu46X7OwD@bfoster>
 <aabyFY0l7GTEHnoQ@infradead.org>
 <aacv39AZ5P9ubOZ5@bfoster>
 <aagv8y96vGHvbOdX@infradead.org>
 <aag-_c8G_L5MQ42m@bfoster>
 <aahEk4yNqd15BIt7@infradead.org>
 <aahJcVkrkLRtsJO9@bfoster>
 <aahmBCz1xJBCPcZ-@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahmBCz1xJBCPcZ-@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 84F662130D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-79491-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 12:04:04PM -0500, Brian Foster wrote:
> This patch seems to work on a quick test. It's basically the two patches
> squashed together (I'd post them as independent patches), so nothing too
> different, but if we fix up the zero logic first that helps clean up the
> indentation as a bonus.

Cool, thanks a lot for putting in this extra effort!

Cosmetic comment on the comment:

> +	/*
> +	 * We don't allocate blocks for zeroing a hole, but we only report a
> +	 * hole in zoned mode if one exists in both the COW and data forks.

I'd reword this a bit as:

	/*
	 * When zeroing, don't allocate blocks for holes as they already
	 * zeroes, but we need to ensure that no extents exist in both
	 * the data and COW fork to ensure this really is a hole.
> +	 *
> +	 * There is currently a corner case where writeback removes the COW fork
> +	 * mapping and unlocks the inode, leaving a transient state where a hole
> +	 * exists in both forks until write completion maps blocks into the data
> +	 * fork. Until we can avoid this transient hole state, detect and avoid
> +	 * this with a flush of any such range that appears dirty in pagecache.
> +	 */


