Return-Path: <linux-fsdevel+bounces-76849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPGhF71Zi2ljUAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:15:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449911D00B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3257130065D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9238885B;
	Tue, 10 Feb 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tstnnhf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E32749C7;
	Tue, 10 Feb 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740152; cv=none; b=dCJ5rGvxupnVK8r8lBrszYkNJqEj7qdkGIARA/m9yUvnKaHFBhSt6AfPbCE1WlNkTyetcp+N4zmjKeFgoNaqo1rqatYbs/FgAn14gXR0rcamVP24mqvjLveE7Owerk8jJpGFAa5EaxS4ruWOqIPz0YaNGy1niYmNF3JMUB/UfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740152; c=relaxed/simple;
	bh=25iQEFJmP2febFVX9cj3nJR52rinFwTU4a9EQkzYjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEXjXDR91aYyPJGE4qY1r8zTivCM/CGb5AgsDn0GeTBD8XtN1RC08rSFoc5YuGu59OehsXIHTJOWs2O1ylhWMiQApWtZLroxVUszIpyxmH9uBjp0uvPjUFKczwZRyZcjObNDr/lqc5GeLH7sb5BHL3DodwvZIc/Sv9OxPVx3P6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tstnnhf7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p8kByoE1pJR18vqbd50FRjNOd96e54dTyT/cWmxCr/0=; b=Tstnnhf7HSs2O+spmhUJuD0Oh1
	utAKzVqZIGJWNPLeH5Z4VjqAgPY+M1anXBBU6fxiqBDCMPlWDSndnVPTHTtm1trMXTm3fA9BcX2+R
	jdzRCCMKWFhgIR09tAhM42JUPM6fntsnh7+TW3H3xzOsJStqw8EEBpVa5kwFlBm3s6eLcxWLuVG5B
	ueyKcbYfNcTg9JRfxuTeHNgtcvGNzuNgdIxIcjraHCEJuoN6C4fLXK+T1Vh2ZAbLwj2z+uLWEzFDn
	8DD5vwKTUUdoybRuOfGhH6TlRgpOTfywPMIsPnpNoC7HxWTwCE3ptVjgQ3lj5kfZkf1NKpFizHbgT
	tW12fRpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpqP0-0000000HCwj-3vme;
	Tue, 10 Feb 2026 16:15:50 +0000
Date: Tue, 10 Feb 2026 08:15:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aYtZtuqy72C0VvnQ@infradead.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76849-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 0449911D00B
X-Rspamd-Action: no action

This looks sensible to me.  I'll add it to my zoned xfs test queue
to make sure it doesn't break anything there, but as the zoned
iomap_begin always allocates new space it should be fine.


