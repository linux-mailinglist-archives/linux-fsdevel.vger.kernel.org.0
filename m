Return-Path: <linux-fsdevel+bounces-79504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJGtM9qrqWmtCAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:14:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FF2153E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7138C319B3F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE013CE4A1;
	Thu,  5 Mar 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yjVL1Ntr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F553C6A56;
	Thu,  5 Mar 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727064; cv=none; b=DBeFux/1U/sMrfLalTHv4mpaPyJdqTtFtA/DJ/+Is8E/0nHkpDZ24KHaAXd5zkbQ5dwy0K+XKvlTLu9jx+iml5s3YPUPrxmfglpUF4x6/XWLKLRgFEV3X+LEVvvhT9scTqBs3MU1yQsq0mM4vNb21WT4V5MIzhJ/OdwBB3iQgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727064; c=relaxed/simple;
	bh=c+XF/gvoMyEyFXDRT+OEPe0qB4DuBMo7dbhaPsROzIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYa807U5R/zmxSifePJYHhN3AIftY+0mX+21nnjiGhCZiT+wZnl9sgznEA8NN1vigjzkS9fZBq04UxGghBargeicwZjlixJBnRQTGJIRG1reVCxYV+8EQ+x4q2bD83BwXqZ2LqOCtDhI30jWf+UVNgzSL4QJzbGm6cQgkPUpvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yjVL1Ntr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MFIpugouuHXRFsRvT9wNIewar3/u3GJDhCgVJkRbu6c=; b=yjVL1Ntr+Feu0SE6A1Y8MgXXVS
	jKFTrwAwSmLhlDcfV0w4aaF1iTiIr3gk74FklUlqdXhhfehYHlCDFYPS8BU6xBZQLh0vZCRbl8LlZ
	44LCWqnL3Ez+nnoV0eT0MPfN4pHD3GEQeGkXjM6XcMwAHZqj3unbaZn+7k7hvlKW/Z2YOMWoF3Rf2
	xfOdUwYdrfxhvOOegHnpDBxJD06P6NUi7ZhYzM3kxnOaUa3NV17SZJVzQa/HDqVZkNYe4ahPed59G
	p1RtNJ1c+lFzg6cFjZYviIcWlCD6DO6IR6yD7Nm6id0Uddd1k3poQG8O2Hfwbl16RUNKU+VvtudC8
	BsAvrRxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyBHt-00000002Bbz-2EcM;
	Thu, 05 Mar 2026 16:10:57 +0000
Date: Thu, 5 Mar 2026 08:10:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aamrESBdLn3q2mz8@infradead.org>
References: <aaXesgEmu46X7OwD@bfoster>
 <aabyFY0l7GTEHnoQ@infradead.org>
 <aacv39AZ5P9ubOZ5@bfoster>
 <aagv8y96vGHvbOdX@infradead.org>
 <aag-_c8G_L5MQ42m@bfoster>
 <aahEk4yNqd15BIt7@infradead.org>
 <aahJcVkrkLRtsJO9@bfoster>
 <aahmBCz1xJBCPcZ-@bfoster>
 <aamPDBAAuK8vvYDw@infradead.org>
 <aamb-zfiAd0xYqQP@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamb-zfiAd0xYqQP@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 453FF2153E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-79504-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:06:35AM -0500, Brian Foster wrote:
> Sure. I had reworked the latter part of the comment as well. With both
> the changes it currently looks like:
> 
>         /*
>          * When zeroing, don't allocate blocks for holes as they are already
>          * zeroes, but we need to ensure that no extents exist in both the data

overly long line here

>          * submission but doesn't remap into the data fork until completion. If

and here.

Otherwise looks great.


