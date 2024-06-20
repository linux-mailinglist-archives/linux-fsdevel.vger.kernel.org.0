Return-Path: <linux-fsdevel+bounces-21974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AFE910784
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02734283023
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E01AD482;
	Thu, 20 Jun 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0L4Dqe5A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OuCbvaS6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0L4Dqe5A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OuCbvaS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93171DFE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892456; cv=none; b=qTsGpw/HXnB4xTXLfQbEg73q4+9OjDzwc7Sj+b/ui9SDV9x/rFmY7j+FzdKpgtcGbh46teeOsFBL0hLkv71GTQzaxen0VF6k1JPz/d2RSkpHQh+N/UoQJh8UMJ7PkKU7jTnwqnaMGKKfLuwUMXhXfefH2gZmpjEcgwvcFKdSSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892456; c=relaxed/simple;
	bh=cXC5qOXfEF3ufRNlTmVFOJE/wfxPT1XF7Ro5c6HakR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um/wse15rD04qeOGWivMQbsfNvuZYPIfnBs4AxoOE4n9j+WpgU3lzhbgYGhgPbuYzsLF9QjjkN/E9inaRPDGqFc8S/DcjhvZQE2uBezZdtWO9gYpMUfeL0W3ClkaontxQM9XVzMR4DEt1CXJOnxnAYfr3FqI2OHDkwVWHrCfIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0L4Dqe5A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OuCbvaS6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0L4Dqe5A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OuCbvaS6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D798221ACF;
	Thu, 20 Jun 2024 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718892452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8hDfn2vHhi13X8lfq9d9OpvDkFc1IOOIa9gk+T8KyQ=;
	b=0L4Dqe5A+UKIFDWa5FgEussf4G8AOlXpB8MIHNjAOPRHZFXIn7UKyO3PynMeqT9aHX1hOX
	fj3ScilbhJvSsxyszGol3zO8OeBLkovhp0hk0Vnz/cAnDCydru8nnnDm/PuSw5ezrWX8k4
	Gdz/G0agbig0HOfjUTkPmnmUO3q7Osc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718892452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8hDfn2vHhi13X8lfq9d9OpvDkFc1IOOIa9gk+T8KyQ=;
	b=OuCbvaS6/+zSKT5ZazQTUCazhviozgANZTELx8N1zsOKAe8JIppl7c1sQTt34r/iF/vb94
	HLLyI9DjOqsZOcAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718892452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8hDfn2vHhi13X8lfq9d9OpvDkFc1IOOIa9gk+T8KyQ=;
	b=0L4Dqe5A+UKIFDWa5FgEussf4G8AOlXpB8MIHNjAOPRHZFXIn7UKyO3PynMeqT9aHX1hOX
	fj3ScilbhJvSsxyszGol3zO8OeBLkovhp0hk0Vnz/cAnDCydru8nnnDm/PuSw5ezrWX8k4
	Gdz/G0agbig0HOfjUTkPmnmUO3q7Osc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718892452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8hDfn2vHhi13X8lfq9d9OpvDkFc1IOOIa9gk+T8KyQ=;
	b=OuCbvaS6/+zSKT5ZazQTUCazhviozgANZTELx8N1zsOKAe8JIppl7c1sQTt34r/iF/vb94
	HLLyI9DjOqsZOcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA37E13AC1;
	Thu, 20 Jun 2024 14:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5mkcMaQ3dGaeWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Jun 2024 14:07:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55C94A086A; Thu, 20 Jun 2024 16:07:24 +0200 (CEST)
Date: Thu, 20 Jun 2024 16:07:24 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: Avoid excessive partition lengths
Message-ID: <20240620140724.672hixqsmd2zrxo7@quack3>
References: <20240620130403.14731-1-jack@suse.cz>
 <ZnQzaimw_oeM1se6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQzaimw_oeM1se6@casper.infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 20-06-24 14:49:30, Matthew Wilcox wrote:
> On Thu, Jun 20, 2024 at 03:04:03PM +0200, Jan Kara wrote:
> > +			udf_err(sb, "Partition %d it too long (%u)\n", p_index,
> > +				map->s_partition_len);
> 
> s/it/is/ ?

Yup, thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

