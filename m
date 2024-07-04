Return-Path: <linux-fsdevel+bounces-23143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6AF927A57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9A1F22F93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DC61B141D;
	Thu,  4 Jul 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="21EusLaB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="59XJatkO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="21EusLaB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="59XJatkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AF1AE866;
	Thu,  4 Jul 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107703; cv=none; b=VH9Dvu70qmcBC7cbNNoHoRgMlQg5Q6pnIie5de0SmexxEaWK8OphJhZ2y0kGx2WnOtJvWFhHYWgabhMch+kZPKZuPVpny8T7T81M5BCisU7XEB/sG/mRfkU4TOX0defHYiQvlWZDTjvteh/9CdAYjIglv95vB+nbNN2lmaANEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107703; c=relaxed/simple;
	bh=WUldS21YVYxGXxGgQ8nbRAlBPVCfKgitOYlYMZMGTvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0UHlsT8qPhAr6sO0At8BFlMCd0DS9W9JThQOYWdK/S/zJrnFRBpaEXexDI72g1ou/X4/gVrEnAerT9iMXqSwWHW2EIdBc5reFxFg3kJKbwF9750UReFzQ/LW3AgkmUpZJcAOC/7tSVNRzwm6WfTB8dsejqawlt+EojNnBHqroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=21EusLaB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=59XJatkO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=21EusLaB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=59XJatkO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 501F81F7E0;
	Thu,  4 Jul 2024 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720107699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyfrBGmFs+Lzd0UfVXg7zkoXk9VyUL0moaO9mNxlEqY=;
	b=21EusLaB/VKHNIIETFWfSThXUSA7ONptKRzm6etuxA7ceieHCGLuE268wZ/EYJXteDpsdQ
	U3ZhZXExTe7YvZVb8AZ3wRC2mT6KgCDqTFFRcdtEN4e3ti3McxMBVDNdNlpAUM4H9gDWxj
	SBGyFguwmcIyfzElIA9NSc19vVewLlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720107699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyfrBGmFs+Lzd0UfVXg7zkoXk9VyUL0moaO9mNxlEqY=;
	b=59XJatkOy8pg0zGYJ8+TBrAnvjAvXDJkgQTAC9JsIPjVeI95nHncUlOuESbmdCCgot8Ouw
	mRSQ2IevVjdD1ODw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=21EusLaB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=59XJatkO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720107699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyfrBGmFs+Lzd0UfVXg7zkoXk9VyUL0moaO9mNxlEqY=;
	b=21EusLaB/VKHNIIETFWfSThXUSA7ONptKRzm6etuxA7ceieHCGLuE268wZ/EYJXteDpsdQ
	U3ZhZXExTe7YvZVb8AZ3wRC2mT6KgCDqTFFRcdtEN4e3ti3McxMBVDNdNlpAUM4H9gDWxj
	SBGyFguwmcIyfzElIA9NSc19vVewLlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720107699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyfrBGmFs+Lzd0UfVXg7zkoXk9VyUL0moaO9mNxlEqY=;
	b=59XJatkOy8pg0zGYJ8+TBrAnvjAvXDJkgQTAC9JsIPjVeI95nHncUlOuESbmdCCgot8Ouw
	mRSQ2IevVjdD1ODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4000C1369F;
	Thu,  4 Jul 2024 15:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K5BOD7PChmZ4RgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jul 2024 15:41:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E02B7A08A5; Thu,  4 Jul 2024 17:41:38 +0200 (CEST)
Date: Thu, 4 Jul 2024 17:41:38 +0200
From: Jan Kara <jack@suse.cz>
To: "Ma, Yu" <yu.ma@intel.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk, mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <20240704154138.2mzaglillgtvmacz@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-2-yu.ma@intel.com>
 <20240703-ketchup-aufteilen-3e4c648b20c8@brauner>
 <20240704101104.btkwwnhwf3mnfsvj@quack3>
 <8fd90ebb-5d47-4630-a972-386a9caed976@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fd90ebb-5d47-4630-a972-386a9caed976@intel.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,zeniv.linux.org.uk,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 501F81F7E0
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 04-07-24 22:45:32, Ma, Yu wrote:
> 
> On 7/4/2024 6:11 PM, Jan Kara wrote:
> > On Wed 03-07-24 16:34:49, Christian Brauner wrote:
> > > On Wed, Jul 03, 2024 at 10:33:09AM GMT, Yu Ma wrote:
> > > > alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> > > > allocated fd is NULL. Remove this sanity check since it can be assured by
> > > > exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
> > > > likely/unlikely and expand_file() call avoidance to reduce the work under
> > > > file_lock.
> > > > 
> > > > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > > > ---
> > > >   fs/file.c | 38 ++++++++++++++++----------------------
> > > >   1 file changed, 16 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/fs/file.c b/fs/file.c
> > > > index a3b72aa64f11..5178b246e54b 100644
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.c
> > > > @@ -515,28 +515,29 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> > > >   	if (fd < files->next_fd)
> > > >   		fd = files->next_fd;
> > > > -	if (fd < fdt->max_fds)
> > > > +	if (likely(fd < fdt->max_fds))
> > > >   		fd = find_next_fd(fdt, fd);
> > > > +	error = -EMFILE;
> > > > +	if (unlikely(fd >= fdt->max_fds)) {
> > > > +		error = expand_files(files, fd);
> > > > +		if (error < 0)
> > > > +			goto out;
> > > > +		/*
> > > > +		 * If we needed to expand the fs array we
> > > > +		 * might have blocked - try again.
> > > > +		 */
> > > > +		if (error)
> > > > +			goto repeat;
> > > > +	}
> > > So this ends up removing the expand_files() above the fd >= end check
> > > which means that you can end up expanding the files_struct even though
> > > the request fd is past the provided end. That seems odd. What's the
> > > reason for that reordering?
> > Yeah, not only that but also:
> > 
> > > >   	/*
> > > >   	 * N.B. For clone tasks sharing a files structure, this test
> > > >   	 * will limit the total number of files that can be opened.
> > > >   	 */
> > > > -	error = -EMFILE;
> > > > -	if (fd >= end)
> > > > -		goto out;
> > > > -
> > > > -	error = expand_files(files, fd);
> > > > -	if (error < 0)
> > > > +	if (unlikely(fd >= end))
> > > >   		goto out;
> > We could then exit here with error set to 0 instead of -EMFILE. So this
> > needs a bit of work. But otherwise the patch looks good to me.
> > 
> > 								Honza
> 
> Do you mean that we return 0 here is fd >=end, I'm afraid that might broke
> the original design of this function. And all the callers of it are using
> ret < 0 for error handling, if ret=0, that should mean the fd allocated is 0
> ...

What I meant is that after your changes alloc_fd() could return 0 in fd >=
end case. It could happen if we went through expand_files() which then
returned 0. Anyway, please just fix the ordering of checks and we should be
fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

