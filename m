Return-Path: <linux-fsdevel+bounces-71093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A5CB5596
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 10:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0FE830124CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911C2F691A;
	Thu, 11 Dec 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iSF3iqZZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cvddhdp0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iSF3iqZZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cvddhdp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4652E228D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445001; cv=none; b=lIsWA6E9GX3FzUONFdD7La7u7EQDde0KikMo56gmUXxWbgR/DY9E9AOtgVlym7+o7mviqc45sRrMQglvXG8oH2weUPMVNprGi7BApIzMkJmU7K4nVeIHLddwcBMHiK3vYPFpf+Ina9xReEVOvCOdXOKzVmswCLJgP27605a4L6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445001; c=relaxed/simple;
	bh=FFYZkF+UscqW+IWTiSHpoEaNKCCX1ZypaCb5gEq+z4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCGo9gQ1u1KSOC8NnB8zgnAwG3/d1YlRIhE9czJ6JKjwL72TkAbE72UMtq9Kg/FV245vppLY+CQFA0G8SnMy3uPLCoEMuA5iae1w4on3D3Cl3bao4rTDAn1car0LjWR64mzT+PAaO+WrLgB40EdfPVzArj+edgLEIpp8LNjebQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iSF3iqZZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cvddhdp0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iSF3iqZZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cvddhdp0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9B42337FC;
	Thu, 11 Dec 2025 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765444997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXntFMz/1BItVG7BvsstcortUO7vx/YgUgUDL2qXBqE=;
	b=iSF3iqZZaJrUzVh/nhj6PdwJEthnAQy0QYc1mpHJiPiyiaBizi36yLvF7cXtFalxhQTrGR
	PMwYI1ak2JMSe6oOE+koNDCfB0TBf85IQR4BgUrcbZIVTUuzsdQBSwhBaoQ9kAyEbPpR37
	AFC4jwR3HYiL3BG19FRM4isEFf/C2po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765444997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXntFMz/1BItVG7BvsstcortUO7vx/YgUgUDL2qXBqE=;
	b=Cvddhdp0Fjq2RHksq6zh9kRmwA0xd166utjHnw/+xQaSp8yYOft/CkEU5SteuF4KKYOpxx
	hHOD9FZ/73CzawAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765444997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXntFMz/1BItVG7BvsstcortUO7vx/YgUgUDL2qXBqE=;
	b=iSF3iqZZaJrUzVh/nhj6PdwJEthnAQy0QYc1mpHJiPiyiaBizi36yLvF7cXtFalxhQTrGR
	PMwYI1ak2JMSe6oOE+koNDCfB0TBf85IQR4BgUrcbZIVTUuzsdQBSwhBaoQ9kAyEbPpR37
	AFC4jwR3HYiL3BG19FRM4isEFf/C2po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765444997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXntFMz/1BItVG7BvsstcortUO7vx/YgUgUDL2qXBqE=;
	b=Cvddhdp0Fjq2RHksq6zh9kRmwA0xd166utjHnw/+xQaSp8yYOft/CkEU5SteuF4KKYOpxx
	hHOD9FZ/73CzawAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DD9F3EA63;
	Thu, 11 Dec 2025 09:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PC6FJoWNOmkodgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Dec 2025 09:23:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F54CA0A04; Thu, 11 Dec 2025 10:23:13 +0100 (CET)
Date: Thu, 11 Dec 2025 10:23:13 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Deepakkumar Karn <dkarn@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam.Howlett@oracle.com, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagemap: Add alert to mapping_set_release_always() for
 mapping with no release_folio
Message-ID: <5edukhcwwr6foo67isfum3az6ds6tcmgrifgthwtivho6ffjmw@qrxmadbaib3l>
References: <20251210200104.262523-1-dkarn@redhat.com>
 <aTnn68vLGxFxO8kv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTnn68vLGxFxO8kv@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Wed 10-12-25 21:36:43, Matthew Wilcox wrote:
> On Thu, Dec 11, 2025 at 01:31:04AM +0530, Deepakkumar Karn wrote:
> >  static inline void mapping_set_release_always(struct address_space *mapping)
> >  {
> > +	/* Alert while setting the flag with no release_folio callback */
> 
> The comment is superfluous.

Agreed.

> > +	VM_WARN_ONCE(!mapping->a_ops->release_folio,
> > +		     "Setting AS_RELEASE_ALWAYS with no release_folio");
> 
> But you haven't said why we need to do this.  Surely the NULL pointer
> splat is enough to tell you that you did something stupid?

Well, but this will tell it much earlier and it will directly point to the
place were you've done the mistake (instead of having to figure out why
drop_buffers() is crashing on you). So I think this assert makes sense to
ease debugging and as kind of self-reminding documentation :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

