Return-Path: <linux-fsdevel+bounces-13953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FDF875B18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89AF1C219D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6583A47F4A;
	Thu,  7 Mar 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZHUDU7z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hABcWakr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZHUDU7z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hABcWakr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45743AB8;
	Thu,  7 Mar 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853953; cv=none; b=ZZX2Od0LiDYRUQO6IbX78HThm5fe/Kg0PkL9/BrreZ7oaLTV0z8LMjnKsXXpQLFnIBGJ34w6RI5QPS+ir/lqEk4hnUXOiYylgdB29rRLxjUNw8XFr6hb0FdWYSazIwxseo0uLnFo2mVKF1eKNQdVPob73MDWDr4r0huHwYHwrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853953; c=relaxed/simple;
	bh=GATlIPdFbkYHI4oMWzU4gqRom870NR8qtqy/UKfD/Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkzjTkBGHlfRjeMoMSGL0vIHbtiQC7dx/snPOjJ62Z6uAJRp9wD2sOA7TwZKF9RIc5b9Q+09CovjPZSUMNbtWnpIiZyIiT4W5YcmCeNL2ZTmRCWGnlPOR4FgajrmQsr7gzlsvYaxQmtHwyabFkQI70sLANnejo1IxTKJxdYkyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZHUDU7z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hABcWakr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZHUDU7z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hABcWakr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55CA1244EE;
	Thu,  7 Mar 2024 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709824446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDnFH5PDuD+7iaOO9R1QK2SDg/WUCJSzMjtRfphruZ4=;
	b=FZHUDU7zThtrLO7c6vtPER4XCa89ByD9wWoLxK2kF4y89yAefGVVtYGRBcX18xQmPXGd0z
	F6vqfYPiJahPVNv2VQfxeMLd74dJ3HD+FNGDTijKQqD/l56ms1caQpJPAPpNGNrCeM60oB
	B4f/bt5hX8QZA4XE6uQulGFabG4Hneo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709824446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDnFH5PDuD+7iaOO9R1QK2SDg/WUCJSzMjtRfphruZ4=;
	b=hABcWakrX7D2nyn6sf/CWoDAz2yXp/IQtF2he/u15v5fx2G7Z9dycTozV2yScG2HEhNazP
	QTKCY5P4LfT7KnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709824446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDnFH5PDuD+7iaOO9R1QK2SDg/WUCJSzMjtRfphruZ4=;
	b=FZHUDU7zThtrLO7c6vtPER4XCa89ByD9wWoLxK2kF4y89yAefGVVtYGRBcX18xQmPXGd0z
	F6vqfYPiJahPVNv2VQfxeMLd74dJ3HD+FNGDTijKQqD/l56ms1caQpJPAPpNGNrCeM60oB
	B4f/bt5hX8QZA4XE6uQulGFabG4Hneo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709824446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDnFH5PDuD+7iaOO9R1QK2SDg/WUCJSzMjtRfphruZ4=;
	b=hABcWakrX7D2nyn6sf/CWoDAz2yXp/IQtF2he/u15v5fx2G7Z9dycTozV2yScG2HEhNazP
	QTKCY5P4LfT7KnCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 48D2E13997;
	Thu,  7 Mar 2024 15:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id l6nAEb3Z6WWTaQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Mar 2024 15:14:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E82B8A0803; Thu,  7 Mar 2024 16:13:56 +0100 (CET)
Date: Thu, 7 Mar 2024 16:13:56 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <lhenriques@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240307151356.ishrtxrsge2i5mjn@quack3>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
 <20240301-gegossen-seestern-683681ea75d1@brauner>
 <87il269crs.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il269crs.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
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
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,dilger.ca,zeniv.linux.org.uk,suse.cz,szeredi.hu,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 01-03-24 15:45:27, Luis Henriques wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
> >> Currently, only parameters that have the fs_parameter_spec 'type' set to
> >> NULL are handled as 'flag' types.  However, parameters that have the
> >> 'fs_param_can_be_empty' flag set and their value is NULL should also be
> >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
> >> 
> >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> ---
> >>  fs/fs_parser.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> >> index edb3712dcfa5..53f6cb98a3e0 100644
> >> --- a/fs/fs_parser.c
> >> +++ b/fs/fs_parser.c
> >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
> >>  	/* Try to turn the type we were given into the type desired by the
> >>  	 * parameter and give an error if we can't.
> >>  	 */
> >> -	if (is_flag(p)) {
> >> +	if (is_flag(p) ||
> >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
> >>  		if (param->type != fs_value_is_flag)
> >>  			return inval_plog(log, "Unexpected value for '%s'",
> >>  				      param->key);
> >
> > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
> > param->string is guaranteed to not be NULL. So really this is only
> > about:
> >
> > FSCONFIG_SET_FD
> > FSCONFIG_SET_BINARY
> > FSCONFIG_SET_PATH
> > FSCONFIG_SET_PATH_EMPTY
> >
> > and those values being used without a value. What filesystem does this?
> > I don't see any.
> >
> > The tempting thing to do here is to to just remove fs_param_can_be_empty
> > from every helper that isn't fs_param_is_string() until we actually have
> > a filesystem that wants to use any of the above as flags. Will lose a
> > lot of code that isn't currently used.
> 
> Right, I find it quite confusing and I may be fixing the issue in the
> wrong place.  What I'm seeing with ext4 when I mount a filesystem using
> the option '-o usrjquota' is that fs_parse() will get:
> 
>  * p->type is set to fs_param_is_string
>    ('p' is a struct fs_parameter_spec, ->type is a function)
>  * param->type is set to fs_value_is_flag
>    ('param' is a struct fs_parameter, ->type is an enum)
> 
> This is because ext4 will use the __fsparam macro to set define a
> fs_param_spec as a fs_param_is_string but will also set the
> fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
> as a flag.  That's why param->string will be NULL in this case.

So I'm a bit confused here. Valid variants of these quota options are like
"usrjquota=<filename>" (to set quota file name) or "usrjquota=" (to clear
quota file name). The variant "usrjquota" should ideally be rejected
because it doesn't make a good sense and only adds to confusion. Now as far
as I'm reading fs/ext4/super.c: parse_options() (and as far as my testing
shows) this is what is happening so what is exactly the problem you're
trying to fix?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

