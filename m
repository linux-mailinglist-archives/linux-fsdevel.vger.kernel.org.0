Return-Path: <linux-fsdevel+bounces-17551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F388AF8E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 23:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442572836E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5EB143888;
	Tue, 23 Apr 2024 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ERxgKYBU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7cttWFm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ERxgKYBU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7cttWFm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DE13CFA4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907366; cv=none; b=tt409J5BH/+D4cQx7e5SDbR3kOvA9MPloyzcM7uwnShXWswDYyQ6B7BAfnh5jnmsUZxv14Vu3/Rrva2/4tX2/9+apLgF3zVCoV825slTZSmQaANTL6vFfDNR2rKezcvHq4FuccmWd5xAGF/+Kzq4TI349aF8BoQJkIkiQ0hMeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907366; c=relaxed/simple;
	bh=eQ4natgl6amYTTack8uEPYi9Uqy/5FkNz1GMfm9/lds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKDei8VufB87f9JqbGllt7L9eXA2O369On24yhbuuaRR2VkVMkagE+hCY4pZ/Giuktgup6SLWL2HD5yKcaqPpr2CcKxsrAbq7Y27LQTnYaBD6/Uy6YlWkShVnlanC7Y0M2suWVLNr/xVM8+sjZLEMiin/NevCHakgvnch23YSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ERxgKYBU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7cttWFm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ERxgKYBU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7cttWFm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 59AA73872A;
	Tue, 23 Apr 2024 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713907357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlgDgI7BkNobiGtaX4fyK+IvMcUHTik1gZ2rqkIZqpc=;
	b=ERxgKYBUzQ2g4KmHnbGd+tn5i2SKJvUMRSyZ6708PGpoCW9op5trbV0Bbc1lkCWfnfWay1
	1Jnngi+nvtAPvFf1N8gqTDaAvZNHTtBHuRPtDTzP/xv5odqL22sHky1wjDt39j5muZb7vD
	ggWYPnnalwWz1SJwFHWpuL9ZTWXoK+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713907357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlgDgI7BkNobiGtaX4fyK+IvMcUHTik1gZ2rqkIZqpc=;
	b=f7cttWFmLNfWZjxlJfjV8JFqJ6amshD+lV8pu7wROH/xnMtUKqO3G3KfwmRg6BoX2QcAB2
	Q7/iC6Htj3/9M/CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ERxgKYBU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f7cttWFm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713907357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlgDgI7BkNobiGtaX4fyK+IvMcUHTik1gZ2rqkIZqpc=;
	b=ERxgKYBUzQ2g4KmHnbGd+tn5i2SKJvUMRSyZ6708PGpoCW9op5trbV0Bbc1lkCWfnfWay1
	1Jnngi+nvtAPvFf1N8gqTDaAvZNHTtBHuRPtDTzP/xv5odqL22sHky1wjDt39j5muZb7vD
	ggWYPnnalwWz1SJwFHWpuL9ZTWXoK+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713907357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlgDgI7BkNobiGtaX4fyK+IvMcUHTik1gZ2rqkIZqpc=;
	b=f7cttWFmLNfWZjxlJfjV8JFqJ6amshD+lV8pu7wROH/xnMtUKqO3G3KfwmRg6BoX2QcAB2
	Q7/iC6Htj3/9M/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BD5A13894;
	Tue, 23 Apr 2024 21:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gL08Ep0mKGaNcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Apr 2024 21:22:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01544A082F; Tue, 23 Apr 2024 23:22:36 +0200 (CEST)
Date: Tue, 23 Apr 2024 23:22:36 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/30] isofs: Remove calls to set/clear the error flag
Message-ID: <20240423212236.a7it44olku35cysr@quack3>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-14-willy@infradead.org>
 <20240422215753.ppmbki53e4yx7p4p@quack3>
 <Zif1Ml9oFhrfCb8p@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zif1Ml9oFhrfCb8p@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 59AA73872A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Tue 23-04-24 18:51:46, Matthew Wilcox wrote:
> On Mon, Apr 22, 2024 at 11:57:53PM +0200, Jan Kara wrote:
> > On Sat 20-04-24 03:50:08, Matthew Wilcox (Oracle) wrote:
> > > Nobody checks the error flag on isofs folios, so stop setting and
> > > clearing it.
> > > 
> > > Cc: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Do you plan to merge this together or should I pick this up myself?
> 
> Please take it through your tree; I'll prepare a pull request for the
> remainder, but having more patches go through fs maintainers means
> better testing.

OK, picked up ext2 and isofs patches into my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

