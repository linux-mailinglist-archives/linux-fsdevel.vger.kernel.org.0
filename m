Return-Path: <linux-fsdevel+bounces-14032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04A876DCE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 00:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D671F228A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A13D549;
	Fri,  8 Mar 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq700ToO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZypliiXG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq700ToO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZypliiXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AC208CE;
	Fri,  8 Mar 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709939358; cv=none; b=LcNsDTbXg79fTitZ7kXLaKfeAZmZVhVgcUzN5p3GUvsZcG0bdFUeA+ytp/FYWVXtIFGGPDJiBtGzkLR7eolVQIKWMMVz6ykC1ImETAjRNo7SMOmKT56R1a1ks1saNFHBnknDdB+MlDcjL0YFE6lMppPfG/l9vNsjRHYMWTg1Lkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709939358; c=relaxed/simple;
	bh=uPDgocnQQrZ4D7QPIXZ8K5iRdz2hoop3D6Q5l3W5h8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMbhwnciaaCQhzCYp3x6O4/hoNNEOqs1LZ9N6jSGyXJ/g+PVaiZ6Gs75DY03jIFiBBUoyXVMzQI3Q0l4ogDf2RL2smb+jmz0BHbPTnm5YQM3x2mzQMe15anp6aUFtf0C436WeKze0u3Z3mqO8zwWvkhVNkO9d5KixYlNS/3bx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq700ToO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZypliiXG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq700ToO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZypliiXG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3949921C39;
	Fri,  8 Mar 2024 23:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709939352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvfLiMqpWucVsTphMQYe1S3iLVe6cZt6/GQD9xs+uRA=;
	b=gq700ToOxZSByI70IHNrAJJc9Q0oefQc3qa/M7VC9VI+NB36V2+hQOcy9Ayyr9cuDu9dX7
	1hUwov8OQFqA3VuLe4Idvd9udHoTUaFtYmquMwrIj4CiKtcIVN73taR6k64IZW8DE39udx
	pd/IFFQEAf1GKSa9MLBNbFrn+nkh9kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709939352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvfLiMqpWucVsTphMQYe1S3iLVe6cZt6/GQD9xs+uRA=;
	b=ZypliiXGdw+CjKkXjWKoNFfJdYX5x29swUB5Tn6q8QAZ0UcPWqqQZz533Qft6vsn8ODDUo
	jtStRPOLDAsb6TBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709939352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvfLiMqpWucVsTphMQYe1S3iLVe6cZt6/GQD9xs+uRA=;
	b=gq700ToOxZSByI70IHNrAJJc9Q0oefQc3qa/M7VC9VI+NB36V2+hQOcy9Ayyr9cuDu9dX7
	1hUwov8OQFqA3VuLe4Idvd9udHoTUaFtYmquMwrIj4CiKtcIVN73taR6k64IZW8DE39udx
	pd/IFFQEAf1GKSa9MLBNbFrn+nkh9kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709939352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvfLiMqpWucVsTphMQYe1S3iLVe6cZt6/GQD9xs+uRA=;
	b=ZypliiXGdw+CjKkXjWKoNFfJdYX5x29swUB5Tn6q8QAZ0UcPWqqQZz533Qft6vsn8ODDUo
	jtStRPOLDAsb6TBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C15713310;
	Fri,  8 Mar 2024 23:09:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEm+Cpia62UoUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Mar 2024 23:09:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB523A0807; Sat,  9 Mar 2024 00:09:11 +0100 (CET)
Date: Sat, 9 Mar 2024 00:09:11 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <lhenriques@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240308230911.r5a4xn6f5vp24hil@quack3>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
 <20240301-gegossen-seestern-683681ea75d1@brauner>
 <87il269crs.fsf@suse.de>
 <20240307151356.ishrtxrsge2i5mjn@quack3>
 <20240308-fahrdienst-torten-eae8f3eed3b4@brauner>
 <87a5n9t4le.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5n9t4le.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,zeniv.linux.org.uk,szeredi.hu,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 08-03-24 10:12:13, Luis Henriques wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Thu, Mar 07, 2024 at 04:13:56PM +0100, Jan Kara wrote:
> >> On Fri 01-03-24 15:45:27, Luis Henriques wrote:
> >> > Christian Brauner <brauner@kernel.org> writes:
> >> > 
> >> > > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
> >> > >> Currently, only parameters that have the fs_parameter_spec 'type' set to
> >> > >> NULL are handled as 'flag' types.  However, parameters that have the
> >> > >> 'fs_param_can_be_empty' flag set and their value is NULL should also be
> >> > >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
> >> > >> 
> >> > >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> > >> ---
> >> > >>  fs/fs_parser.c | 3 ++-
> >> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> > >> 
> >> > >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> >> > >> index edb3712dcfa5..53f6cb98a3e0 100644
> >> > >> --- a/fs/fs_parser.c
> >> > >> +++ b/fs/fs_parser.c
> >> > >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
> >> > >>  	/* Try to turn the type we were given into the type desired by the
> >> > >>  	 * parameter and give an error if we can't.
> >> > >>  	 */
> >> > >> -	if (is_flag(p)) {
> >> > >> +	if (is_flag(p) ||
> >> > >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
> >> > >>  		if (param->type != fs_value_is_flag)
> >> > >>  			return inval_plog(log, "Unexpected value for '%s'",
> >> > >>  				      param->key);
> >> > >
> >> > > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
> >> > > param->string is guaranteed to not be NULL. So really this is only
> >> > > about:
> >> > >
> >> > > FSCONFIG_SET_FD
> >> > > FSCONFIG_SET_BINARY
> >> > > FSCONFIG_SET_PATH
> >> > > FSCONFIG_SET_PATH_EMPTY
> >> > >
> >> > > and those values being used without a value. What filesystem does this?
> >> > > I don't see any.
> >> > >
> >> > > The tempting thing to do here is to to just remove fs_param_can_be_empty
> >> > > from every helper that isn't fs_param_is_string() until we actually have
> >> > > a filesystem that wants to use any of the above as flags. Will lose a
> >> > > lot of code that isn't currently used.
> >> > 
> >> > Right, I find it quite confusing and I may be fixing the issue in the
> >> > wrong place.  What I'm seeing with ext4 when I mount a filesystem using
> >> > the option '-o usrjquota' is that fs_parse() will get:
> >> > 
> >> >  * p->type is set to fs_param_is_string
> >> >    ('p' is a struct fs_parameter_spec, ->type is a function)
> >> >  * param->type is set to fs_value_is_flag
> >> >    ('param' is a struct fs_parameter, ->type is an enum)
> >> > 
> >> > This is because ext4 will use the __fsparam macro to set define a
> >> > fs_param_spec as a fs_param_is_string but will also set the
> >> > fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
> >> > as a flag.  That's why param->string will be NULL in this case.
> >> 
> >> So I'm a bit confused here. Valid variants of these quota options are like
> >> "usrjquota=<filename>" (to set quota file name) or "usrjquota=" (to clear
> >> quota file name). The variant "usrjquota" should ideally be rejected
> >> because it doesn't make a good sense and only adds to confusion. Now as far
> >> as I'm reading fs/ext4/super.c: parse_options() (and as far as my testing
> >> shows) this is what is happening so what is exactly the problem you're
> >> trying to fix?
> >
> > mount(8) has no way of easily knowing that for something like
> > mount -o usrjquota /dev/sda1 /mnt that "usrjquota" is supposed to be
> > set as an empty string via FSCONFIG_SET_STRING. For mount(8) it is
> > indistinguishable from a flag because it's specified without an
> > argument. So mount(8) passes FSCONFIG_SET_FLAG and it seems strange that
> > we should require mount(8) to know what mount options are strings or no.
> > I've ran into this issue before myself when using the mount api
> > programatically.
> 
> Right.  A simple usecase is to try to do:
> 
>   mount -t ext4 -o usrjquota= /dev/sda1 /mnt/
> 
> It will fail, and this has been broken for a while.

I see. But you have to have new enough mount that is using fsconfig, don't
you? Because for me in my test VM this works just fine...

But anyway, I get the point. Thanks for educating me :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

