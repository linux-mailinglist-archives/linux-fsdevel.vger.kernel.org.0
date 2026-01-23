Return-Path: <linux-fsdevel+bounces-75289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIi+Cs9/c2ncwwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:03:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5DD76A01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EF4D306C294
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B92EFDAF;
	Fri, 23 Jan 2026 14:01:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6032F363C;
	Fri, 23 Jan 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176869; cv=none; b=lWfwLYw/KneY68u7EBSrrI6cbE3uLVZ+vYKUa7Zcpa38wCCLpG3wXn2uqdfhvyDvtxmhEgm1ZmlrODikR+JMlrspzJf9ual/AaRz8fSomS+hCVMlWwmrRvleOfhosiaVfe9tuQwcYm+MSy2tgQaFMp0Cg302eaQPXemsx0w/7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176869; c=relaxed/simple;
	bh=RhQrGwadHS37/U6tcxYq4WpnbRJOXNKQUoVjLBnyBWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLY4ASfszRp+h23qkeUYgrFgHLyzs5FheFLcY0rtWSK7qOsHjxOf6Ie3D75I3bM29L9p+K6hdpCxmkeyyYjYwvIvjSVCzuJfMpS/zJm/hEA8pCLMay4stmleYa6gxqJHSFF608Pqj6cHTVPPpb7QuhS46HY+PUFPWFPaKHpq9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 895C0227AAE; Fri, 23 Jan 2026 15:01:03 +0100 (CET)
Date: Fri, 23 Jan 2026 15:01:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: bounce buffer direct I/O when stable pages are required v2
Message-ID: <20260123140102.GA24714@lst.de>
References: <20260119074425.4005867-1-hch@lst.de> <CGME20260123121444epcas5p4e729259011e031a28be8379ea3b9b749@epcas5p4.samsung.com> <20260123121026.tujkvhxixr6pgz7c@green245.gost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123121026.tujkvhxixr6pgz7c@green245.gost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75289-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AC5DD76A01
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:40:26PM +0530, Anuj Gupta wrote:
> I ran experiments[1] on two devices - Samsung PM1733 and Intel Optane
> with PI enabled (4K + 8b format).

Thanks for the additional benchmarking on more beefy devices!

> On my setup, I didn't observe any
> noticeable difference for sequential write workloads. Sequential reads,
> however, show a clear performance drop while using bounce buffering,
> which is expected.
> Used these fio commands listed below[2]
>
> Feel free to add:
> Tested-by: Anuj Gupta <anuj20.g@samsung.com


