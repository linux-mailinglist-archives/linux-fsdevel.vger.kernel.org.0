Return-Path: <linux-fsdevel+bounces-78394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJFdIK1Cn2laZgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:42:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A719C630
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9063074138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606953E95AD;
	Wed, 25 Feb 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PVic9kLC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4dO0/gg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gRNts8IB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0WbjbSVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC220248886
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044839; cv=none; b=Njwa9VIENchVb/ICGhvTTtRyCZ7LlWfswXRz09pocoWtIJuxwaUZSv5HxOCeQ6E1xl1AnYnEZ0n1fPM5NYanQocRHu8u05oDDf1FIyDYKLK2BMbNkw7ffp7HQCy2DA5FiGq97Kr8RQUL+kovI1rVTashi0UEEk/61KuuOHCqO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044839; c=relaxed/simple;
	bh=+JwJnc3eTzQez3wKNDSf+h+KO3/tKRxfEoKCoXwOves=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZud1Hsip6lijycWKdEjuzZnWbHLugWv8ZTKPTWWtqK1daHc+csCKAlY9zQVQ6O22bzF6sXZlU3e1sxFalnAy6NdzXyt/mCsG/bFzYOpnJEljUbQ1VXKcODPPe8ey3w5AuKmC73hlaaVF2ph592NC0lIjwMZWSq519bjvNChnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PVic9kLC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4dO0/gg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gRNts8IB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0WbjbSVs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEDE34D7B2;
	Wed, 25 Feb 2026 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772044836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LTTKoOdsIKznzkRdeCN410TGEi6YBCDh895wdk+jMk=;
	b=PVic9kLCqmOetPeV2akHzijYFGW5XUmncUZsGOEcYzTTedd+Tg851kdyWKvuWFc4AWKw56
	uJ5StAinrtysGmvkhOIqjh+1e0O6KlhfldimUhnYc0ahiBayvJnpuhIFaRMBZyNRCVxgLQ
	pDIKz0LBuXZMiQjgQO+/waFL2bBfhso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772044836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LTTKoOdsIKznzkRdeCN410TGEi6YBCDh895wdk+jMk=;
	b=w4dO0/ggueyCUDkvaohQsYs33+X7o5eLdAOyE6uAMQaSVaPlKa07QfFy1abzihC0TX1vmz
	3krrNvuwL+yT1rAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772044835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LTTKoOdsIKznzkRdeCN410TGEi6YBCDh895wdk+jMk=;
	b=gRNts8IBRu/OTICDOKtUwJX3U396Ujb8cHFQuIO4OFZW0+9Rnszw2kbtrt2x870lfjfXEV
	DFTLFO3RI/aTcZv9W13wdn4D6wjn87HuWiFNfWjjvhnf0HftE9DwkLcqAVoZ+n1+nW2BVV
	7m9XpLc4ASk3g1mvkzXAFRu8mgdYc6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772044835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LTTKoOdsIKznzkRdeCN410TGEi6YBCDh895wdk+jMk=;
	b=0WbjbSVscF2mV7+53vWTE1iPhB6cQri7dFTYgrGtiCd8XrT2Sr11O+3dgnPn52WQNCrO4w
	5dF7e064d4Ut1PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C81E13EA65;
	Wed, 25 Feb 2026 18:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zSXVMCNCn2nbXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Feb 2026 18:40:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62E5BA0A27; Wed, 25 Feb 2026 19:40:35 +0100 (CET)
Date: Wed, 25 Feb 2026 19:40:35 +0100
From: Jan Kara <jack@suse.cz>
To: Carlos Maiolino <cem@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] File system testing
Message-ID: <ozdhtaoqcsc2otp2luufkoondjpyycyocnfdqtpesuyj7uxlns@b4pnu7a65xtm>
References: <20260218150736.GD45984@macsyma-wired.lan>
 <aZ2UA2l3o9Z2j9H-@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ2UA2l3o9Z2j9H-@nidhogg.toxiclabs.cc>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78394-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D96A719C630
X-Rspamd-Action: no action

On Tue 24-02-26 13:48:38, Carlos Maiolino via Lsf-pc wrote:
> > 3) Automating the use of tests to validate file system backports to
> >    LTS kernels, so that commits which might cause file system
> >    regressions can be automatically dropped from a LTS rc kernel.
> 
> This seems useful for me even for mainline, if a regression has been
> found in LTS, it's likely it shouldn't have got into mainline anyway.

This often isn't true. Rather often the failure in LTS means patches
implicitely depend on some change that's missing from LTS...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

