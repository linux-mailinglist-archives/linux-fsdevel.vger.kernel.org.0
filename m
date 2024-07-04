Return-Path: <linux-fsdevel+bounces-23105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B99273B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE3B2185B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D81AB906;
	Thu,  4 Jul 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z6YnfVKP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4YcRZxQD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QVtt9Ckj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8W4r3nxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8181A0730;
	Thu,  4 Jul 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087868; cv=none; b=IceT9KWkETCMA4bhj2TPuxv/FHvYsqkQElLkBFyi8dqQ/TJCTpIOFobAoaJH8Q/6m71tkZpCNTdbZEUVttN0gBkowDQvCi+Wj8LiRMfUuNcBHApHskXFe+7hQDqH3B96wzDuYlCENNoOeqQ7QME30HptGO/lkuvLSc3Xt3eg9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087868; c=relaxed/simple;
	bh=REDkPGsiavxL2k363CjZX5Holdl9qed6inupLZxFSDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyA1IiXgvd1yjmxS4aCBRQgF3JdjLptZkiYrDbY6DHEF9bDid3lZN6dzZ2c6GglF6yKc1+UEbycKOnbV8q//+uAnEhBb3GjNT19siG5HaZFgkWOZXCVE0XKQxZh4ViAmSFJy+UXn4p6CyeQp6jO0aSyGYtC0OWf0gspjnoGjwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z6YnfVKP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4YcRZxQD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QVtt9Ckj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8W4r3nxM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F19FF21AB6;
	Thu,  4 Jul 2024 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720087865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg0uBLdt9E/i1S+HKhxKO6kyT4SuMZfGYVUxX1nIWUY=;
	b=z6YnfVKP7Nz96TCmyYBGZG0gDHPuRiAEqKj06RcBj3I7X5C53c/0L4U+3xnf4tNjHtKMEb
	82Byu5a9aLUAR9tOmzu76R1BgSq04Pq770k+47VFvc1r2Hoppb2WQT9FPXemaORP7vIVTl
	GA95dHY7eZlZPGVdFMWSw9OYbV0RAyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720087865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg0uBLdt9E/i1S+HKhxKO6kyT4SuMZfGYVUxX1nIWUY=;
	b=4YcRZxQDf8+SQjseipotQC2NK+vXvqGncLsmiNCzXLjiAcaOIVlAgIm9UqRUgI3vnx7AIo
	qGfSXI8UZbAHLTAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QVtt9Ckj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8W4r3nxM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720087864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg0uBLdt9E/i1S+HKhxKO6kyT4SuMZfGYVUxX1nIWUY=;
	b=QVtt9CkjnruDnsdyLN/8N8Q2NVgQzT6OEusWpqw+rXgQ4DqJZTux/FeI7c0fbSRoLaxJht
	sOu5QgDZlg//CQ3a3+10dkEXKnzdHrBtrBWDk+M5xHch0S2oJgh6G9Lr35gBccYXTPUKNW
	pdJV5DvBPBdOVmQ8yebJRxU1QlNEWT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720087864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg0uBLdt9E/i1S+HKhxKO6kyT4SuMZfGYVUxX1nIWUY=;
	b=8W4r3nxMBACqU47kxWqN5d5+ZoiTHxxJxh/K/FnqhK1wmi6Xx7W+baISucayqne8pcxxdW
	1oJF/ls9YXyzyACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E07131369F;
	Thu,  4 Jul 2024 10:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mx1iNjh1hmbzYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jul 2024 10:11:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96EDAA088E; Thu,  4 Jul 2024 12:11:04 +0200 (CEST)
Date: Thu, 4 Jul 2024 12:11:04 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <20240704101104.btkwwnhwf3mnfsvj@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-2-yu.ma@intel.com>
 <20240703-ketchup-aufteilen-3e4c648b20c8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-ketchup-aufteilen-3e4c648b20c8@brauner>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,zeniv.linux.org.uk,suse.cz,gmail.com,google.com,vger.kernel.org,linux.intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F19FF21AB6
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 03-07-24 16:34:49, Christian Brauner wrote:
> On Wed, Jul 03, 2024 at 10:33:09AM GMT, Yu Ma wrote:
> > alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> > allocated fd is NULL. Remove this sanity check since it can be assured by
> > exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
> > likely/unlikely and expand_file() call avoidance to reduce the work under
> > file_lock.
> > 
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 38 ++++++++++++++++----------------------
> >  1 file changed, 16 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index a3b72aa64f11..5178b246e54b 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -515,28 +515,29 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> >  	if (fd < files->next_fd)
> >  		fd = files->next_fd;
> >  
> > -	if (fd < fdt->max_fds)
> > +	if (likely(fd < fdt->max_fds))
> >  		fd = find_next_fd(fdt, fd);
> >  
> > +	error = -EMFILE;
> > +	if (unlikely(fd >= fdt->max_fds)) {
> > +		error = expand_files(files, fd);
> > +		if (error < 0)
> > +			goto out;
> > +		/*
> > +		 * If we needed to expand the fs array we
> > +		 * might have blocked - try again.
> > +		 */
> > +		if (error)
> > +			goto repeat;
> > +	}
> 
> So this ends up removing the expand_files() above the fd >= end check
> which means that you can end up expanding the files_struct even though
> the request fd is past the provided end. That seems odd. What's the
> reason for that reordering?

Yeah, not only that but also:

> >  	/*
> >  	 * N.B. For clone tasks sharing a files structure, this test
> >  	 * will limit the total number of files that can be opened.
> >  	 */
> > -	error = -EMFILE;
> > -	if (fd >= end)
> > -		goto out;
> > -
> > -	error = expand_files(files, fd);
> > -	if (error < 0)
> > +	if (unlikely(fd >= end))
> >  		goto out;

We could then exit here with error set to 0 instead of -EMFILE. So this
needs a bit of work. But otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

