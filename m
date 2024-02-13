Return-Path: <linux-fsdevel+bounces-11363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBF8530F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFFD283E4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66954D9EE;
	Tue, 13 Feb 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mo3VwomQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xpCXHn3W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mo3VwomQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xpCXHn3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E74C604
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828676; cv=none; b=Cj5A4HhLCKn+h+2UXztXaOFlfRtru+C5LQFKWdTKOCVNealJMtMC3GVXnlerxgMaZf96+4Zi+QDScmdrFvKepaIMiXuiEHLBpEi9e21p+TI4hZ5NtFEAG4HeZJ2/ZW42D9x2TysSRUMu3JSgACiYgJb/dD0RK129kQGqhClNh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828676; c=relaxed/simple;
	bh=47F9CYpK/nyJrAg6PlUGbsZgtE70uLPpQ1XhmgND3dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEC7zJC5c/vXvNoIfLchoJeSR98ToDguOk5e4yl0maYM8fHaGc5zMGoeqLqZj3MMyDmO95R9564yc9E1IZ1WwpNlIlRqtGJk8uOuetp8y046sW+zBIHFL9Fy41+vIACfk8GQhS9BspeKXEeqPTmQWdpIX/zXAW3dn5loBWwMhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mo3VwomQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xpCXHn3W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mo3VwomQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xpCXHn3W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89F0F1F7D8;
	Tue, 13 Feb 2024 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707828672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ZDVgIShshpIZwRS6cJFpZ1EHtAT8CS27i4+oAKqdg=;
	b=Mo3VwomQYdrn7YmyxGfjvAcmTtqWrZ8DKsRD7w5bfkrMrBLTK3QIs/EaHQo9g8Csk2wC0p
	krMZ8OBfPIJ2QM5fSUKoWrliryVja0t1DB0aWYZJMoJZ0RWJedF9hhaA948tQmWSTtORAe
	QtQqDgcU2X7NNJMaBK9JaPVm3ydh0LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707828672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ZDVgIShshpIZwRS6cJFpZ1EHtAT8CS27i4+oAKqdg=;
	b=xpCXHn3WRAn9GCqRrv36dmygHWDSbhs1YIiTqInCxO+rD3a/SouPN9CK9hKL72ZTMvcw/0
	xHSMvTt23UsLZ8Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707828672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ZDVgIShshpIZwRS6cJFpZ1EHtAT8CS27i4+oAKqdg=;
	b=Mo3VwomQYdrn7YmyxGfjvAcmTtqWrZ8DKsRD7w5bfkrMrBLTK3QIs/EaHQo9g8Csk2wC0p
	krMZ8OBfPIJ2QM5fSUKoWrliryVja0t1DB0aWYZJMoJZ0RWJedF9hhaA948tQmWSTtORAe
	QtQqDgcU2X7NNJMaBK9JaPVm3ydh0LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707828672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ZDVgIShshpIZwRS6cJFpZ1EHtAT8CS27i4+oAKqdg=;
	b=xpCXHn3WRAn9GCqRrv36dmygHWDSbhs1YIiTqInCxO+rD3a/SouPN9CK9hKL72ZTMvcw/0
	xHSMvTt23UsLZ8Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 74F1113A0E;
	Tue, 13 Feb 2024 12:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WSCMHMBly2UkVwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 12:51:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F8D5A0809; Tue, 13 Feb 2024 13:51:12 +0100 (CET)
Date: Tue, 13 Feb 2024 13:51:12 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bill O'Donnell <billodo@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] udf: convert to new mount API
Message-ID: <20240213125112.jgv7qlva3bhezll5@quack3>
References: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
 <1adcfcc9-5ac8-4a53-a6a5-e8b9b41a9a83@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1adcfcc9-5ac8-4a53-a6a5-e8b9b41a9a83@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.89
X-Spamd-Result: default: False [-0.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.24%]
X-Spam-Flag: NO

On Mon 12-02-24 14:31:10, Eric Sandeen wrote:
> On 2/9/24 1:43 PM, Eric Sandeen wrote:
> > Convert the UDF filesystem to the new mount API.
> > 
> > UDF is slightly unique in that it always preserves prior mount
> > options across a remount, so that's handled by udf_init_options().
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>

...

> > +	case Opt_gid:
> > +		if (0 == kstrtoint(param->string, 10, &uv)) {
> >  			uopt->gid = make_kgid(current_user_ns(), uv);
> >  			if (!gid_valid(uopt->gid))
> > -				return 0;
> > +				return -EINVAL;
> >  			uopt->flags |= (1 <<  );
> > -			break;
> > -		case Opt_uid:
> > -			if (match_uint(args, &uv))
> > -				return 0;
> > +		} else if (!strcmp(param->string, "forget")) {
> > +			uopt->flags |= (1 << UDF_FLAG_GID_FORGET);
> > +		} else if (!strcmp(param->string, "ignore")) {
> > +			/* this option is superseded by gid=<number> */
> > +			;
> > +		} else {
> > +			return -EINVAL;
> > +		}
> > +		break;
> 
> I wonder if I need to redo this and not directly set the make_kgid option
> into uopt->gid. We do test that uopt->gid is valid, and return an error, and
> skip setting UDF_FLAG_GID_SET, but ...
> 
> ...
> 
> > -static int udf_fill_super(struct super_block *sb, void *options, int silent)
> > +static int udf_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >  	int ret = -EINVAL;
> >  	struct inode *inode = NULL;
> > -	struct udf_options uopt;
> > +	struct udf_options *uopt = fc->fs_private;
> >  	struct kernel_lb_addr rootdir, fileset;
> >  	struct udf_sb_info *sbi;
> >  	bool lvid_open = false;
> > -
> > -	uopt.flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
> > -	/* By default we'll use overflow[ug]id when UDF inode [ug]id == -1 */
> > -	uopt.uid = make_kuid(current_user_ns(), overflowuid);
> > -	uopt.gid = make_kgid(current_user_ns(), overflowgid);
> 
> this initialization (now moved to udf_init_options) gets overwritten
> even if the [gu]id was invalid during parsing ...
> 
> > +	sbi->s_flags = uopt->flags;
> > +	sbi->s_uid = uopt->uid;
> > +	sbi->s_gid = uopt->gid;
> 
> ... and gets set into sbi here.
> 
> In the past (I think) the whole mount would fail with an invalid UID/GID but w/
> fsconfig, we could just fail that one config and continue with the rest.

I see. Yes, I guess it cannot happen with normal mount but let's be
defensive and make sure only valid uid/gid gets into uopt and sbi.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

