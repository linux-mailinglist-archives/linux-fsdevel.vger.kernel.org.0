Return-Path: <linux-fsdevel+bounces-74979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOMRES2+cWkmLwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:05:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9396229E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCB48542651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 06:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6520A2DCC04;
	Thu, 22 Jan 2026 06:04:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312736C590;
	Thu, 22 Jan 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061846; cv=none; b=S57/aBIdP8NNGTAN/D0Txj2uenMqaIjDeu5yuubyKYUoVtQWOeBpWFxTzxfIpdnUpjMrVBqTC0iIiWc7jfv2h42waISr7xTMCsDZOqNJumRV8iUlBsAjBoTUQ64/1INtKFdoTq87xQpUoJytVjVlBlEpHCjr5Z8QUItCiiFNrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061846; c=relaxed/simple;
	bh=qL/6fhBAIeZg7aAiyzwJ0h1lBqVBWusJUvD+4Ey7hsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOGlUcQ0MBSpYmnY56IOIV1g+7CSMSwWaP6jZWqnlCjHTBJYZe0cL3ploVCV3R5uFNlLP77zgYZjAM/MpjFLXPnHerEMmRze8GIgqRWLt48PPf2sPTFnemIjXS2A5FQr6iBsbZvS+krtdFkfiJ/kpoIDQ8A0Ry9CFUtA0sdLOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DA21227AA8; Thu, 22 Jan 2026 07:04:01 +0100 (CET)
Date: Thu, 22 Jan 2026 07:04:00 +0100
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
Subject: Re: [PATCH 07/15] block: pass a maxlen argument to
 bio_iov_iter_bounce
Message-ID: <20260122060400.GD24006@lst.de>
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-8-hch@lst.de> <20260122010440.GT5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122010440.GT5945@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74979-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: AB9396229E
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:04:40PM -0800, Darrick J. Wong wrote:
> >  	if (dio->flags & IOMAP_DIO_BOUNCE)
> > -		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
> > +		ret = bio_iov_iter_bounce(bio, dio->submit.iter, UINT_MAX);
> 
> Nitpicking here, but shouldn't this be SIZE_MAX?

bi_size can't store more than UINT_MAX, so I think this is correct.


