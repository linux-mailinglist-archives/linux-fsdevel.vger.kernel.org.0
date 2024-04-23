Return-Path: <linux-fsdevel+bounces-17512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CEB8AE86A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50B31C21C2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7087136983;
	Tue, 23 Apr 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GFLjutNM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDFBI4Nm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GFLjutNM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDFBI4Nm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE41135A5F
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879852; cv=none; b=V0f76QtbT2ScZBUMkMSPg2FdybNPj6vWTtDj7IPPmfxh9TSEdz4jxYJgJXFND1zExotL4X2S1D8OYIPpF0OA/m0skWz4TXnAYQJUyNSxM5sT7aJJeX/rY+LuwG++j3M4G0Cd9g/ifuViar/0v88dQWcx78RThYft2N0Xz6oro3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879852; c=relaxed/simple;
	bh=HwNP2ts79uxld4K+N1MhEgx6BMg/rEGnkuka2wKPNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HECqZLHrw8S5xPadcDNyhybns4LIGEPDwF/AHFDRmnECmS1zgHX53uYvWuDdm1i44PzgtY3xVajPhrVbqkSfjrpvFAiBPsl9a9xs8iaXA9oMAK8qYxLZ8IYygOGJA4x0OTADBEDgHfMTgOGFf7z/+nMAFW7+uecCnQWHentQxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GFLjutNM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDFBI4Nm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GFLjutNM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDFBI4Nm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2AD038025;
	Tue, 23 Apr 2024 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713879846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dEPcTCQhgGYvzXEEyy5uV8qHn8/HEUM9N1O83PSJ/I=;
	b=GFLjutNM5Vwk6th4sD80zOZIJAeA1fPpC2+xlNodLStDkVTUCHo4Lv2zZKYvGNTDn73NnC
	0fnR3AHzL6IwqfIKh0lky+UmivMcGPDdwGfjTyf7vBTYF3mhVseZRzlQFY6ua5+sT596/L
	cbD9M6htTBvgR7hZXYg37i0Q9hZ9MNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713879846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dEPcTCQhgGYvzXEEyy5uV8qHn8/HEUM9N1O83PSJ/I=;
	b=MDFBI4NmsYeuh1CIW3lfp0gn2W7R0BrDEeDS8hrtYVxEKB9kl1h8ca7B9yTUHnWNkdbI/k
	89RJL2rdDK9BArBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GFLjutNM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MDFBI4Nm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713879846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dEPcTCQhgGYvzXEEyy5uV8qHn8/HEUM9N1O83PSJ/I=;
	b=GFLjutNM5Vwk6th4sD80zOZIJAeA1fPpC2+xlNodLStDkVTUCHo4Lv2zZKYvGNTDn73NnC
	0fnR3AHzL6IwqfIKh0lky+UmivMcGPDdwGfjTyf7vBTYF3mhVseZRzlQFY6ua5+sT596/L
	cbD9M6htTBvgR7hZXYg37i0Q9hZ9MNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713879846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dEPcTCQhgGYvzXEEyy5uV8qHn8/HEUM9N1O83PSJ/I=;
	b=MDFBI4NmsYeuh1CIW3lfp0gn2W7R0BrDEeDS8hrtYVxEKB9kl1h8ca7B9yTUHnWNkdbI/k
	89RJL2rdDK9BArBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AAE813929;
	Tue, 23 Apr 2024 13:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tZy9JSa7J2bVagAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Apr 2024 13:44:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E4C3A082F; Tue, 23 Apr 2024 15:44:06 +0200 (CEST)
Date: Tue, 23 Apr 2024 15:44:06 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] Convert UDF to folios
Message-ID: <20240423134406.oid5oyuy64uxrl35@quack3>
References: <20240417150416.752929-1-willy@infradead.org>
 <20240418105323.qyelkvgnzodlkwpr@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418105323.qyelkvgnzodlkwpr@quack3>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A2AD038025
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 18-04-24 12:53:23, Jan Kara wrote:
> On Wed 17-04-24 16:04:06, Matthew Wilcox (Oracle) wrote:
> > I'm not making any attempt here to support large folios.  This is just to
> > remove uses of the page-based APIs.  Most of these places are for inline
> > data or symlinks, so it wouldn't be appropriate to use large folios
> > (unless we want to support bs>PS, which seems to be permitted by UDF,
> > although not widely supported).
> 
> Thanks for the conversion. Overall it looks good and I can fixup the minor
> stuff I've found on commit, just I'd like to get a confirmation regarding
> the flush_dcache_folio() thing...

OK, I've merged the patches into my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

