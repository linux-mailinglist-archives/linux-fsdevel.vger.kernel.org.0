Return-Path: <linux-fsdevel+bounces-23575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28992EABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 16:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1609282DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2A716631A;
	Thu, 11 Jul 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aZO0hu+m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v+nkHe6R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mL7hHlO+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NpffYXfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2315ECCA;
	Thu, 11 Jul 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708188; cv=none; b=towT7NeMm62KqgsorwlLG/373TSBhLcWbP4Apoy/48CVLgcsp0aYejGiTZNkA6VcCCgSGHQ94dC8pJkD9CmmibhZP0STAs+1AOymokLnZBKyqCzau9JR+JtI2uGNKtAMnY43bM4Q4LAUeFYDGbnudsy7Wv1mNUfu+PfH9l1p2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708188; c=relaxed/simple;
	bh=GU0xdeNkNhxA/0nFt5TwpELEEtnBOegmjpdSd81yY7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEZ/VOZqstGkXW9S3CxeEF9aM7CiBdd9WibCuMtilvifM1qbNguw/hSSIhxi3A6IAkK6l1QJAx2N9oUUFcSdYPSLcjBOZ8XEPDIBmG/Zt75+PVwK2R91gG9te3JYhOUDKpSOiKiFt6Ovl4mRSCR5gW4SARhbGfBcweXRCZte0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aZO0hu+m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v+nkHe6R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mL7hHlO+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NpffYXfe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1471F8D6;
	Thu, 11 Jul 2024 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720708179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXsVvEVmcCHIEAk1iWp3BrHLQnBHN0Sz0SM1aR0NFn4=;
	b=aZO0hu+mkUDSRwYb+QjJF3LTIqXFbvbESBXutwQbhx5v4R0z1s7UmHH72MwFm+6Mmh9JGU
	unI5P0VY0zI8jjueNuWcFmEOexQjvnEzfHQQf6E/oGsrYwKvFbPY9vbM9IYeOMrrIu3UvM
	eeo5qjrYQRTLxW9ukjv9FFr9SSO3MFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720708179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXsVvEVmcCHIEAk1iWp3BrHLQnBHN0Sz0SM1aR0NFn4=;
	b=v+nkHe6Rx0ajlYVTJbe/sTh827Q8AwHvpnyPBBbqPqxySLJeVrM38WW2ywZJYpnilusEKP
	GdRBsGtrBvb0jNDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720708178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXsVvEVmcCHIEAk1iWp3BrHLQnBHN0Sz0SM1aR0NFn4=;
	b=mL7hHlO+czO+475uItk9I6CDuU3a0DdImFUa/g0DYxxfjM3us1BTUZOz9aifCt2O++wzSs
	Ao7rgNoU48yctzmU0Yq1EOjhkSou/YNgINB7mI/Dhz0F0FDd1Ig09UEM4gMYK/uwRaCLYF
	yXwBDlVvjaEW08LQOIz8mEji3C/kp3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720708178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXsVvEVmcCHIEAk1iWp3BrHLQnBHN0Sz0SM1aR0NFn4=;
	b=NpffYXfe14JmLWMJQRJS7259W7Z1zqvhPdVJxegKtCz1K4SJALeEyw10dJDKLApbU29My5
	yDUxUSchFtMR9SBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6D5D136AF;
	Thu, 11 Jul 2024 14:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M1wqOFHsj2ZuEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jul 2024 14:29:37 +0000
Date: Thu, 11 Jul 2024 16:29:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Kees Cook <kees@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs/affs: struct slink_front: Replace 1-element array
 with flexible array
Message-ID: <20240711142928.GB8022@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240710225734.work.823-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710225734.work.823-kees@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Jul 10, 2024 at 03:57:34PM -0700, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct slink_front with a modern flexible array.
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks, I've added the 3 patches to my tree. I've noticed there's one
more 1-element array in struct affs_root_head (hashtable):

https://elixir.bootlin.com/linux/latest/source/fs/affs/amigaffs.h#L50

The struct is used only partially by AFFS_ROOT_HEAD from affs_fill_super
and not accessing the hashtable. This could have been missed by the
tools you use or was the conversion intentionally skipped?

