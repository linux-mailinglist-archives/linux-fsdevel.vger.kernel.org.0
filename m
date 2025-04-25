Return-Path: <linux-fsdevel+bounces-47364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3184FA9CA78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F33C1C010D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9B253941;
	Fri, 25 Apr 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJME5D2F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="REzDjZJ4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJME5D2F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="REzDjZJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506342A9B
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587998; cv=none; b=EKa9gvFHuCZ0NJRXzSwpcxG2qncScD7dxT8m//MA5uLSof80SYAAYcxJUe2zxaRUqp4pnsTQ4zwfndtnATnYZRdZuN7ekJgjFri8q2KsI0FWb6znliDX0t8sPPmXJFs99g/olc5ZAs6a61aIQFGRSHLGmA3Y9df5L04D9ma8f48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587998; c=relaxed/simple;
	bh=iLRUti7dTkR6up2ApwgIxeAJYuBRC2Fr1IKJNQ136ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo16GUkHBgD2kwT1jMp01Yx1NYc6EUUMzH61X8zEZGR2QoqBxRjdi3f6ldgVez0DAZPyvNI21Aq55Xxk8/BioFAX09KsWI/CFnpZ0RIfdUVy9+BQgBgUAIbyd0PmLCwkDB4RmJEwk31ymVwU7C64J8ktE7AuCArXwXwiGND5+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJME5D2F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=REzDjZJ4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJME5D2F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=REzDjZJ4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30B6B1F394;
	Fri, 25 Apr 2025 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745587994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRYr+hp7iAv4I+sjQJLPecQtHGBr10H7ACLOpAxzNUI=;
	b=JJME5D2FAuYb7vWCnNJdEZkVdorJxB1iy68zSIviLRslFZOReEvBIyvdCNuEj8+gUnOKQr
	nWB8ssOQ5apQlXEvGyzczY5bAnUcjIneeKtHjlZuw2PKI9BDGjNVB3ec1k+oZsTlq46JEG
	6vnlaFl4xd3SBKEtCj136gF2Ny6qc1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745587994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRYr+hp7iAv4I+sjQJLPecQtHGBr10H7ACLOpAxzNUI=;
	b=REzDjZJ4R/uaJ2+z8F9k8SCMx8RZ6sF3yQrhCqKayeUKg5v0RT6JD4VRDBGzPeKGEeE071
	/YsY4abMlcJQ66BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745587994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRYr+hp7iAv4I+sjQJLPecQtHGBr10H7ACLOpAxzNUI=;
	b=JJME5D2FAuYb7vWCnNJdEZkVdorJxB1iy68zSIviLRslFZOReEvBIyvdCNuEj8+gUnOKQr
	nWB8ssOQ5apQlXEvGyzczY5bAnUcjIneeKtHjlZuw2PKI9BDGjNVB3ec1k+oZsTlq46JEG
	6vnlaFl4xd3SBKEtCj136gF2Ny6qc1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745587994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRYr+hp7iAv4I+sjQJLPecQtHGBr10H7ACLOpAxzNUI=;
	b=REzDjZJ4R/uaJ2+z8F9k8SCMx8RZ6sF3yQrhCqKayeUKg5v0RT6JD4VRDBGzPeKGEeE071
	/YsY4abMlcJQ66BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23C541388F;
	Fri, 25 Apr 2025 13:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LJq1CBqPC2hiVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Apr 2025 13:33:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C1B3FA0944; Fri, 25 Apr 2025 15:33:05 +0200 (CEST)
Date: Fri, 25 Apr 2025 15:33:05 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and
 getxattrat(2)
Message-ID: <a3w7xdgldyoodxeav6zwn3dkw6y4cir6fdhftopo3snrpgbjoz@zvz4vny63ehf>
References: <20250424132246.16822-2-jack@suse.cz>
 <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>
 <20250425-fahrschein-obacht-c622fbb4399b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-fahrschein-obacht-c622fbb4399b@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 25-04-25 10:45:22, Christian Brauner wrote:
> On Thu, Apr 24, 2025 at 05:45:17PM +0200, Mateusz Guzik wrote:
> > On Thu, Apr 24, 2025 at 03:22:47PM +0200, Jan Kara wrote:
> > > Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
> > > calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
> > > fail with -EBADF error instead of operating on CWD. Fix it.
> > > 
> > > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/xattr.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index 02bee149ad96..fabb2a04501e 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
> > >  		return error;
> > >  
> > >  	filename = getname_maybe_null(pathname, at_flags);
> > > -	if (!filename) {
> > > +	if (!filename && dfd >= 0) {
> > >  		CLASS(fd, f)(dfd);
> > >  		if (fd_empty(f))
> > >  			error = -EBADF;
> > > @@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
> > >  		return error;
> > >  
> > >  	filename = getname_maybe_null(pathname, at_flags);
> > > -	if (!filename) {
> > > +	if (!filename && dfd >= 0) {
> > >  		CLASS(fd, f)(dfd);
> > >  		if (fd_empty(f))
> > >  			return -EBADF;
> > 
> > Is there any code which legitimately does not follow this pattern?
> > 
> > With some refactoring getname_maybe_null() could handle the fd thing,
> > notably return the NULL pointer if the name is empty. This could bring
> > back the invariant that the path argument is not NULL.
> > 
> > Something like this:
> > static inline struct filename *getname_maybe_null(int fd, const char __user *name, int flags)
> > {
> >         if (!(flags & AT_EMPTY_PATH))
> >                 return getname(name);
> > 
> >         if (!name && fd >= 0)
> >                 return NULL;
> >         return __getname_maybe_null(fd, name);
> > }
> > 
> > struct filename *__getname_maybe_null(int fd, const char __user *pathname)
> > {
> >         char c;
> > 
> >         if (fd >= 0) {
> >                 /* try to save on allocations; loss on um, though */
> >                 if (get_user(c, pathname))
> >                         return ERR_PTR(-EFAULT);
> >                 if (!c)
> >                         return NULL;
> >         }
> > 
> > 	/* we alloc suffer the allocation of the buffer. worst case, if
> > 	 * the name turned empty in the meantime, we return it and
> > 	 * handle it the old-fashioned way.
> > 	 /
> >         return getname_flags(pathname, LOOKUP_EMPTY);
> > }
> > 
> > Then callers would look like this:
> > filename = getname_maybe_null(dfd, pathname, at_flags);
> > if (!filename) {
> > 	/* fd handling goes here */
> > 	CLASS(fd, f)(dfd);
> > 	....
> > 
> > } else {
> > 	/* regular path handling goes here */
> > }
> > 
> > 
> > set_nameidata() would lose this branch:
> > p->pathname = likely(name) ? name->name : "";
> > 
> > and putname would convert IS_ERR_OR_NULL (which is 2 branches) into one,
> > maybe like so:
> > -       if (IS_ERR_OR_NULL(name))
> > +       VFS_BUG_ON(!name);
> > +
> > +       if (IS_ERR(name))
> >                 return;
> > 
> > i think this would be an ok cleanup
> 
> Not opposed, but please for -next and Jan's thing as a backportable fix,
> please. Thanks!

Exactly, I agree the code is pretty subtle and ugly. It shouldn't take
several engineers to properly call a function to lookup a file :) So
some cleanup and refactoring is definitely long overdue but for now I
wanted some minimal fix which is easy to backport to stable.

When we speak about refactoring: Is there a reason why user_path_at()
actually doesn't handle NULL 'name' as empty like we do it in *xattrat()
syscalls? I understand this will make all _at() syscalls accept NULL name
with AT_EMPTY_PATH but is that a problem?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

