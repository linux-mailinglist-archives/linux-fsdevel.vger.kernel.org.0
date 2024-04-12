Return-Path: <linux-fsdevel+bounces-16799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B328A2E85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5331D1C21560
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D058AC3;
	Fri, 12 Apr 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMBqsBAa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8YGf30Fw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMBqsBAa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8YGf30Fw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB554F87;
	Fri, 12 Apr 2024 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925532; cv=none; b=plIs/YDvFkfuEpKB+VtNTlbgd2KDpYxUMJj7PoEMHZhYPz7/kl2unJRpyQItN3fUaKzZxXZbDGO0de0rpCftDnpkwhzqvbDwzh3OZjhbkhABSzJNcCQkNxdN8kS+L2rHUixY4Pw6ALAOYgrHsaF2gSsCCaKoQ945GgQ4nFKx5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925532; c=relaxed/simple;
	bh=b/VfblD6S05RaA1RCAGojBZh50mufHTpEjwfpHh6eQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7ZguEi8cF4gigy+3Mfs6kz5o/prFjv6iAUXw3c70k3drIAxEey0X7R3A88ISxm9WcCe47dY8zLJWfJJ9y+t/ZX+ulBxEHlvWLHvmfUlm6sU2Bdv/VdNXtV5y8FtBn7ENl/Yec4njEXinhHt9FAd8q58SCdx2h0aFseqFrwiCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMBqsBAa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8YGf30Fw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMBqsBAa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8YGf30Fw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8452338262;
	Fri, 12 Apr 2024 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712925528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEBw+49UxZSpAkG7MYUNf10c5mjLpsm+3+mJDHW/cro=;
	b=hMBqsBAa/fJqI4EOM+eKmmEVPeL2Yri9Pz83j8BShmnsZprbbHTb2bPSTtU78pRO9zkNcw
	tCVc/ycnjY4CI+B0i9V/CcobT1+P7UiaYZ2aMdgvuDNPjTT3Nf7RbSVHd/6qVv0nnh7/bM
	NEX6Rd383BRXRO663COpAfHPkC7OF90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712925528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEBw+49UxZSpAkG7MYUNf10c5mjLpsm+3+mJDHW/cro=;
	b=8YGf30FweZ30bzBVb21uaRIrYuQxDa6Dln3jkKvAJ4RxwLRaHrJm6oPaPBuFyy/nDUJ6r9
	NUFYN6NDNbQp50Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712925528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEBw+49UxZSpAkG7MYUNf10c5mjLpsm+3+mJDHW/cro=;
	b=hMBqsBAa/fJqI4EOM+eKmmEVPeL2Yri9Pz83j8BShmnsZprbbHTb2bPSTtU78pRO9zkNcw
	tCVc/ycnjY4CI+B0i9V/CcobT1+P7UiaYZ2aMdgvuDNPjTT3Nf7RbSVHd/6qVv0nnh7/bM
	NEX6Rd383BRXRO663COpAfHPkC7OF90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712925528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEBw+49UxZSpAkG7MYUNf10c5mjLpsm+3+mJDHW/cro=;
	b=8YGf30FweZ30bzBVb21uaRIrYuQxDa6Dln3jkKvAJ4RxwLRaHrJm6oPaPBuFyy/nDUJ6r9
	NUFYN6NDNbQp50Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79B571368B;
	Fri, 12 Apr 2024 12:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R3qxHVgrGWaLTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Apr 2024 12:38:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32027A071E; Fri, 12 Apr 2024 14:38:48 +0200 (CEST)
Date: Fri, 12 Apr 2024 14:38:48 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] reiserfs: Convert to writepages
Message-ID: <20240412123848.mv5y56uuz4tjdyaz@quack3>
References: <20240305185208.1200166-1-willy@infradead.org>
 <ZedqFFiVyntHkxLZ@casper.infradead.org>
 <ZhgnMsJ9AGAkgFXT@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhgnMsJ9AGAkgFXT@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -2.31
X-Spam-Level: 
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-1.51)[91.79%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,infradead.org:email]

On Thu 11-04-24 19:08:50, Matthew Wilcox wrote:
> On Tue, Mar 05, 2024 at 06:53:08PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 05, 2024 at 06:52:05PM +0000, Matthew Wilcox (Oracle) wrote:
> > > Use buffer_migrate_folio to handle folio migration instead of writing
> > > out dirty pages and reading them back in again.  Use writepages to write
> > > out folios more efficiently.  We now only do that wait_on_write_block
> > > check once per call to writepages instead of once per page.  It would be
> > > possible to do one transaction per writeback run, but that's a bit of a
> > > big change to do to this old filesystem, so leave it as one transaction
> > > per folio (and leave reiserfs supporting only one page per folio).
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> This patch is not yet in linux-next.  Do I need to do anything to
> make that happen?

Hum, usually Andrew picks these up but he was not on CC this time. Queued
into my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

