Return-Path: <linux-fsdevel+bounces-58003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AB6B28005
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83ADA1D00884
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0C2FB995;
	Fri, 15 Aug 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pftKXj6j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wo/Zp3I5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0b6K2XDb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1QhShcHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C21A238C
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261247; cv=none; b=CR8ofDS33egWcex2WLGL3VUJ9sK2OZT0OhdmvoeTKRGyF0HCR+hp8sH0oV3Q1XMXUl3A/rlh591srByKSBGMe0LR+x0UV8BAc8EeL+AITGWHp87Qif1ducr2EplWRSB8MNzRTvvmc4vwCCfWBcV4yVmW8cvnLWl3ax+GtRQBuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261247; c=relaxed/simple;
	bh=S7/XPMO0d+W6nIw8W5IyAf52ou3icGbH/Rx+JGDtyGI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFMGpHzuW98eIEJUH+cTdcauUqezudRSQc+QbCFUiImY2/jWAg7CFQQbJBJ7KQY9/a4Wx8UxIUax6QrCxbN9Synde5ynAsOn/dLsjcQroEhPjOuo7VTkO4mMQHlFJ7wGmVEhWfCptGXEJMIaMPVi2IVT0s87dGWdGwy0DKu7o3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pftKXj6j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wo/Zp3I5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0b6K2XDb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1QhShcHr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 545001F83E;
	Fri, 15 Aug 2025 12:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755261243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbKW3m79yzVvWd4c4oeFxoOPejDr9ro0zvoA9q/+lL0=;
	b=pftKXj6j6PflFjz2In7gvs+RV0Y8qhkGDb6PZ4y7+rzDZrIxXULvojkcqqPh8iwTzEdno0
	t0fkPgA4nkv5qshCOFXPS9L0fwIG+maJ0tAJBrbr3S2Fouy4camlszFTG8rqjB6VERTg6t
	eqGTGeGjoHhl7T695DNEWBJPIjZrprU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755261243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbKW3m79yzVvWd4c4oeFxoOPejDr9ro0zvoA9q/+lL0=;
	b=Wo/Zp3I5Sgxy1iMwvGxmiNjWV9Gfgb6MOxL/pPJ9FiTS5D6rmJmYExVUZXvuvJxD/7saaQ
	liN2MD3wVE3KiIAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755261241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbKW3m79yzVvWd4c4oeFxoOPejDr9ro0zvoA9q/+lL0=;
	b=0b6K2XDbFirJwyeNjzVe/NtQ2QWdZPG8fwGIo/40zzhCHxFLewXI2GmrpQfPPlaPRO54Ys
	SsiLlTw4OF4g/UkdjoBKbpkZFQGD3NH7KhlvTRQIr51CNqQw5PXa34XFkOasU8H9PD7Hok
	AFfK1Mf76dM/RaMkfPi2uB/OYlr99ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755261241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbKW3m79yzVvWd4c4oeFxoOPejDr9ro0zvoA9q/+lL0=;
	b=1QhShcHrjb+96XnMqazaYYsnkahj8edGVGHZGhwGL0Iu59wGl7xBM3cbXktVrJpRhaELXf
	B/zOwfneMk60jfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A137F13876;
	Fri, 15 Aug 2025 12:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R7KUIzgpn2hMYwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 15 Aug 2025 12:34:00 +0000
Date: Fri, 15 Aug 2025 13:34:02 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing/radix-tree/maple: hack around kfree_rcu not
 existing
Message-ID: <fcbr3lvd2aa6m4cjl666ksbf5px25htnh5slahj4pk2id54ygn@llqqfn5urq52>
References: <20250814064927.27345-1-lorenzo.stoakes@oracle.com>
 <kq3y4okddkjpl3yk3ginadnynysukiuxx3wlxk63yhudeuidcc@pu5gysfsrgrb>
 <20250814180217.da2ab57d5b940b52aa45b238@linux-foundation.org>
 <wh2wvfa5zt5zoztq3eqvjhicgsf3ywcmr6sto2zynkjlpjqj2b@bt7cdc4f7u3j>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wh2wvfa5zt5zoztq3eqvjhicgsf3ywcmr6sto2zynkjlpjqj2b@bt7cdc4f7u3j>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu, Aug 14, 2025 at 10:09:15PM -0400, Liam R. Howlett wrote:
> * Andrew Morton <akpm@linux-foundation.org> [250814 21:02]:
> > On Thu, 14 Aug 2025 13:40:03 +0100 Pedro Falcato <pfalcato@suse.de> wrote:
> > 
> > > On Thu, Aug 14, 2025 at 07:49:27AM +0100, Lorenzo Stoakes wrote:
> > > > From: Pedro Falcato <pfalcato@suse.de>
> > > > 
> > > > liburcu doesn't have kfree_rcu (or anything similar). Despite that, we can
> > > > hack around it in a trivial fashion, by adding a wrapper.
> > > > 
> > > > This wrapper only works for maple_nodes, and not anything else (due to us
> > > > not being able to know rcu_head offsets in any way), and thus we take
> > > > advantage of the type checking to avoid future silent breakage.
> > > > 
> > > > This fixes the build for the VMA userland tests.
> > > > 
> > > > Additionally remove the existing implementation in maple.c, and have
> > > > maple.c include the maple-shared.c header.
> > > > 
> > > > Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > > > Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > > 
> > > > Andrew - please attribute this as Pedro's patch (Pedro - please mail to
> > > > confirm), as this is simply an updated version of [0], pulled out to fix the
> > > > VMA tests which remain broken.
> > > >
> > > 
> > > ACK, this is fine. The future of the series is still unclear, so if this fixes
> > > the build then all good from my end :)
> > 
> > Well, can we have this as a standalone thing, rather than as a
> > modification to a patch whose future is uncertain?
> > 
> > Then we can just drop "testing/radix-tree/maple: hack around kfree_rcu
> > not existing", yes?
> > 
> > Some expansion of "fixes the build for the VMA userland tests" would be
> > helpful.
> 
> Ah, this is somewhat messy.
> 
> Pedro removed unnecessary rcu calls with the newer slab reality as you
> can directly call kfree instead of specifying the kmem_cache.
> 
> But the patch is partially already in Vlastimil's sheaves work and we'd
> like his work to go through his branch, so the future of this particular
> patch is a bit messy.
> 
> Maybe we should just drop the related patches that caused the issue from
> the mm-new branch?  That way we don't need a fix at all.
> 
> And when Vlastimil is around, we can get him to pick up the set
> including the fix.
> 
> Doing things this way will allow Vlastimil the avoid conflicts on
> rebase, and restore the userspace testing in mm-new.
> 
> Does that make sense to everyone?
>

I agree. This sounds sensible. I don't think it makes much sense to let the
patchset rot in mm-new.

-- 
Pedro

