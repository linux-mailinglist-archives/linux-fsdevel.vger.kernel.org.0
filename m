Return-Path: <linux-fsdevel+bounces-77074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNBOJJy/jmmzEQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:07:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B01332ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA46C30097F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD4270540;
	Fri, 13 Feb 2026 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z/ZPiMY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F921D3F3;
	Fri, 13 Feb 2026 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962813; cv=none; b=CITSHZ/2uEFgv9mtpdW3dJ/mk8y2u9vCE8KWcCSQ3fzZ8cEa77aVn9Xih2dY/BGGujYztGmOqsvoadPFHT/8QV5UWwTLlVnAHN7MwkaAbp0hm2hZmTk8YYC5yn7Tz+aWX/vjFi8XZVSI1TjWZqE63RslcobKSFBqRqkdVho+AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962813; c=relaxed/simple;
	bh=4VJciUQLsAJnVVYGBaz4YsGOhEY67mRItsVdBCJbpBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYkVRR1HLS/bIsckqzxonv0cpsOS+IP/IatdnHqOSu8jwUk7Ie5QOPVPjnamy0Xyufp+tKZHTFgDygNqKdO99rucvH41Y8LIsQedU/SCR3p3IoaPIouuYZZY5I/fQDSPoBfTh1TSfs/ScpYIXRp2YhL7LhiGbUvHOXXUjGzGVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z/ZPiMY7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4VJciUQLsAJnVVYGBaz4YsGOhEY67mRItsVdBCJbpBg=; b=z/ZPiMY7dI9RWFF4otrrhpNhuz
	1a2z2hYNpdQRkiTgNtlB+GmKKVRGeRebmCo+VoqelOAXkL0RxtSWv7kEuzTeSa2y6PxiWFYELv/aW
	mAla+be25e1ezVLugQb0ktvMKiic7ffKf21NlmybcF1oChbPPx6qh2BYWHjQtEk8VCepV2XUOg0U4
	YED8ubxoxMiBKzZwjQ7VFWRVZNyu1IeMxPgiuXvklUZhxn5YG5PtxKUl66KO18IFXCDgEDM9wghR9
	XpjXur3+Dw6doQrwZWGhwk0owFjKdXHehOcS384ETylanoZCwYfMHrTRLnel9TSF/TZWNc/+k7M1s
	LUJUs6Xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqmKI-000000033In-2oVM;
	Fri, 13 Feb 2026 06:06:50 +0000
Date: Thu, 12 Feb 2026 22:06:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aY6_eqkIrMkOr039@infradead.org>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129155028.141110-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77074-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E07B01332ED
X-Rspamd-Action: no action

This patch makes generic/363 and xfs/131 fail on zoned XFS file systems.
A later patch also makes generic/127, but I haven't fully bisected
the cause yet.

I'll see if I can make sense of it, but unfortunately I've got a fair
amount of travel coming up, so it might take a while.

If you want to give it a spin yourself, you can just add '-r zoned=1'
to the mkfs arguments for the test and scratch device.


