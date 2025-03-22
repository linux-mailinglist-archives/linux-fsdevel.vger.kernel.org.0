Return-Path: <linux-fsdevel+bounces-44790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C21A6CB71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFED46165C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBB231A2D;
	Sat, 22 Mar 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dfEZ08Kf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KUEo3ZsP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DhOAG2JU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nTV5l7uh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7B12D758
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742660515; cv=none; b=lZ7SzfqX3Lfjz94XuriEQfVYU4n3mcJxXH7y9wdEgdMx91rIHFSkFH7IYl5aAGl6yRiPJFBtZi24gYyG6Nta53x7+PrEt7trBIBWJM0CZf1RKoSl9Ulx5YjBNPgxwfXo7TksCQhlf6oUCOCfv+xsBm+d4q0QUeozfSMCuIJyxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742660515; c=relaxed/simple;
	bh=TDOPyX4RredP+eHc98Bn3kwBpMzKBWGoxfgC8FQDuh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWCE4LykD+sUGORt6c9cuZiiWfDd9qwufjqhltAFNv6DRbY64Mu4KaVv6q27pJr1cfJKfFi66xyzBKUPsZxz96YMIGqCORegRfWpiBb+eqjPc+LbZKYrUB5ShO571a0BdFF/WQKNXUTbXFjo9W+Auo7kCWK3U40TaiDJwO+9uCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dfEZ08Kf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KUEo3ZsP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DhOAG2JU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nTV5l7uh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C713421186;
	Sat, 22 Mar 2025 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742660506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wK/exj5N83u3i2QYOzuHN0D+7nQ1TTHf2Xgu8IGmwmw=;
	b=dfEZ08Kf64CxXPKglswEt41eRIpno8JA9LWPzF+kjny6dV50tMEI2/QbfS+YFIXy8B6coc
	VKOdoRXhpQtTZYU1NhcLi853k5wnAyc0iqb226zqqPcnizCzFKtFZphmYZdvTOzdOnmIMb
	BVwrRDkURRZzQma5dUqHzAN6qx3w4TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742660506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wK/exj5N83u3i2QYOzuHN0D+7nQ1TTHf2Xgu8IGmwmw=;
	b=KUEo3ZsPgSrqvpsaqb23444z2qLmThgDMU0hXBGJbTxGmLC8ah3Si7iOC7JMnGxNTU2AK5
	r+UZ/MU/nllPHhAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742660505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wK/exj5N83u3i2QYOzuHN0D+7nQ1TTHf2Xgu8IGmwmw=;
	b=DhOAG2JU1jTpJCCgrzKAeimnJrvTCw2xDDg6Dz+ddzFDPqAkX2EH58l4jy40BearfKGaRj
	uI02x4mWYcuqZaEWtOtZVHoYJ0XLOM7X/gj0GOaEPjdBAgQHiVKv7rzOCVCaNkkUN3ffSS
	qhOoLR1ZBbvrG7mJwbk9DH3QIaQbPYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742660505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wK/exj5N83u3i2QYOzuHN0D+7nQ1TTHf2Xgu8IGmwmw=;
	b=nTV5l7uhYhzJo6A9tAPiS1JIhU0KP1YwovnxncCUe/sp3tv9NQ+5Pr5FYNLEVmHvjjB3AS
	JcUNIhHbawQP3yAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38C5413A38;
	Sat, 22 Mar 2025 16:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mmRpCpnj3mfvBQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sat, 22 Mar 2025 16:21:45 +0000
Date: Sat, 22 Mar 2025 16:21:43 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tamir Duberstein <tamird@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] XArray: revert (unintentional?) behavior change
Message-ID: <blhrpa6do6ishcimnskwqjndu75cnv6ky7k3tznp7pczrsig65@ky6yo4upky6m>
References: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>
 <20250321213733.b75966312534184c6d46d6aa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321213733.b75966312534184c6d46d6aa@linux-foundation.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,canb.auug.org.au,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:url];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri, Mar 21, 2025 at 09:37:33PM -0700, Andrew Morton wrote:
> On Fri, 21 Mar 2025 22:17:08 -0400 Tamir Duberstein <tamird@gmail.com> wrote:
> 
> > Partially revert commit 6684aba0780d ("XArray: Add extra debugging check
> > to xas_lock and friends"), fixing test failures in check_xa_alloc.
> > 
> > Fixes: 6684aba0780d ("XArray: Add extra debugging check to xas_lock and friends")
> 
> Thanks.
> 
> 6684aba0780d appears to be only in linux-next.  It has no Link: and my
> efforts to google its origin story failed.  Help?
> 

It was added back in september to willy's tree due to an XFS data corruption bug.
See https://lore.kernel.org/linux-mm/ZvLhrF5lj3x596Qm@casper.infradead.org/ and
https://git.infradead.org/?p=users/willy/xarray.git;a=commitdiff;h=6684aba0780da9f505c202f27e68ee6d18c0aa66.

-- 
Pedro

