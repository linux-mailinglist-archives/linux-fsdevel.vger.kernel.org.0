Return-Path: <linux-fsdevel+bounces-20786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748718D7BA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A57A2821D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C552F38382;
	Mon,  3 Jun 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rlBxd92x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rwyNnWrp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UGMnkjWk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fDm2g84Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A9364A0;
	Mon,  3 Jun 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396559; cv=none; b=J2LtJVVlHdf2BGfSJiEYAF54o3UydsHB7+9uATpEeYCM1AmOyvOUmIUJl/b2Lwss9iXx/OisYJimjkwbkA/t97uUQyLJr9MtZjFEguzmZzEuXj8hW4nkG0wS5kG/RjIr/d2v0QuU7Q3MHnGE3uRkXcmLTQZvU/w/dxoAECK1OuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396559; c=relaxed/simple;
	bh=ZVoQYQWWDmBQDju0NKPZU0T4wOef3Ry0IiPdLMRYgX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp3j/jP2jJZxqIRisDS4ivgbEnJ18Ou+q4qX5NP0kkHmTiSVcKZlFgHyQrVR5z/Bkrd5pSS213EpFO0mhFOdllkuntx65HYx6aaNnu/EqRQORZBwlfLF8kyttAtZrXMbb8lGlmFTaCN5ilirZGgvZzX8z5V7gXzV5VjH0s7wQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rlBxd92x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rwyNnWrp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UGMnkjWk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fDm2g84Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C605C20027;
	Mon,  3 Jun 2024 06:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=853DH3aVAMRxb01uzkxMb9tlSlc8955pXLKQM4T4EJY=;
	b=rlBxd92x1e2ro8pJT5DvUP2kRsfluDRXWKJ2QDs1r9MwR2AUsM5R4z7wghUR5BepjpoUDI
	4GuAh8j2EeclvNlVZDt2rFhOe+P84Wi+pSGvC08bP0aRSQtTS0xy0zr4/Z3fmVVkqbDPrP
	LyJIvwJkL7iMWHX04bJ5PDw2Ouaqydw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=853DH3aVAMRxb01uzkxMb9tlSlc8955pXLKQM4T4EJY=;
	b=rwyNnWrpRThZ/grwvpaSYNTD9r1f+fWYVPg6G7DGrcVlgvCoQ9RsErAJkHA0qwXyb7SjMG
	uevmXzMw+3J6n6BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UGMnkjWk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fDm2g84Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=853DH3aVAMRxb01uzkxMb9tlSlc8955pXLKQM4T4EJY=;
	b=UGMnkjWkwi5REcndsoqDNWAnhJ3+Z3XkPkgrP4lhBeHQXv6iFsrK8puzxVaM+VyWBL48m1
	jE+eVnWbHTD3X520ndiz4+5++fEfH25eEwpqbrIj8JYWFGvRvpYzqsyRnllEnjcPUtFGIR
	Ej+G0nSOGAZCEWr075y0N0SCDT3wzpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=853DH3aVAMRxb01uzkxMb9tlSlc8955pXLKQM4T4EJY=;
	b=fDm2g84Zte6hVo2PxaQ831Fvn8YWP6a/AO82xKIzwPzDhDcSKF3lig0maGIu2LiQrg22Ft
	+prMrsfH79pkoOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05E3913A93;
	Mon,  3 Jun 2024 06:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4LgKOUpkXWbTSQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 06:35:54 +0000
Message-ID: <beae5aaf-eb90-4486-9430-3ac7c9d020b4@suse.de>
Date: Mon, 3 Jun 2024 08:35:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 chandan.babu@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
 willy@infradead.org, djwong@kernel.org
Cc: linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
 gost.dev@samsung.com, yang@os.amperecomputing.com, p.raghav@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
 mcgrof@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-7-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240529134509.120826-7-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C605C20027
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.50

On 5/29/24 15:45, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Usually the page cache does not extend beyond the size of the inode,
> therefore, no PTEs are created for folios that extend beyond the size.
> 
> But with LBS support, we might extend page cache beyond the size of the
> inode as we need to guarantee folios of minimum order. Cap the PTE range
> to be created for the page cache up to the max allowed zero-fill file
> end, which is aligned to the PAGE_SIZE.
> 
> An fstests test has been created to trigger this edge case [0].
> 
> [0] https://lore.kernel.org/fstests/20240415081054.1782715-1-mcgrof@kernel.org/
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/filemap.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


