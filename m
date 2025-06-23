Return-Path: <linux-fsdevel+bounces-52568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08FAE4401
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69EB3B8C2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B3253F03;
	Mon, 23 Jun 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDgSRkZq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bb7ov7uR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDgSRkZq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bb7ov7uR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5E253F1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685389; cv=none; b=KOH/cDzvEGNwXKRUEqII4glGdpvHThmZaLzF26qHMU3tOmx+vs/Is7qZM3sftCiptdQ3AQTDpiOnFGKaZ1yQMb7Bu5+tOGmBd8zIkBCmMJnEOrD7Qf2MtBOZIBQJIwWRCvOlsH55CR7QSjmnBTvfSsMgRni+kYnWeuatXMFQnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685389; c=relaxed/simple;
	bh=qgnLAA0t41WuDTV8cYxwIFOHukaDRA2lm/tz8ZIJcgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYZ9sWpsCEz59jVVP9/jLOGeUBQ6Mp9oeJ8PsMnzG6arqt2V4jW1eW3uNoLFHAF63boDXaWdmuLx+TEOA9kKPs+Xl6n0f/VhYV2suiOPThpSdOrYcCEHTkI+uGqUhtc2m/yD07BA32S6TLrlrG9DtIFDthT0Dq3HnJ+CxJ3k1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDgSRkZq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bb7ov7uR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDgSRkZq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bb7ov7uR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11DA12116D;
	Mon, 23 Jun 2025 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750685385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b7qD5/GAgg35+Or8uEXb3xqQbRadqto1keS1Sf5ZnPM=;
	b=VDgSRkZqX3Y4kyUbwlnYdR1yRwPovjKig+81kdSKhY5v3cJ/GUoyMyWIdELMwCFCbzTLZH
	K14swf8I89IkS47M/6Q2/r2Fe7Hi5DDeIYSDLOvEBrayOFYb9LW6av+iOVZW5aTfzhB5G3
	C3+6ajIu9etBrIH0aREy5i6AHHWt8lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750685385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b7qD5/GAgg35+Or8uEXb3xqQbRadqto1keS1Sf5ZnPM=;
	b=bb7ov7uRCXh9n4VAl7FNrU/Fm5mj6ac3ZkJR4A0U3FRrQhimQoJEmQFdai5rIWL+D7peV1
	h2e1gD831mdIxMBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VDgSRkZq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bb7ov7uR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750685385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b7qD5/GAgg35+Or8uEXb3xqQbRadqto1keS1Sf5ZnPM=;
	b=VDgSRkZqX3Y4kyUbwlnYdR1yRwPovjKig+81kdSKhY5v3cJ/GUoyMyWIdELMwCFCbzTLZH
	K14swf8I89IkS47M/6Q2/r2Fe7Hi5DDeIYSDLOvEBrayOFYb9LW6av+iOVZW5aTfzhB5G3
	C3+6ajIu9etBrIH0aREy5i6AHHWt8lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750685385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b7qD5/GAgg35+Or8uEXb3xqQbRadqto1keS1Sf5ZnPM=;
	b=bb7ov7uRCXh9n4VAl7FNrU/Fm5mj6ac3ZkJR4A0U3FRrQhimQoJEmQFdai5rIWL+D7peV1
	h2e1gD831mdIxMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE48E13A27;
	Mon, 23 Jun 2025 13:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jEMjOshWWWjAUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 13:29:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 353F5A09BE; Mon, 23 Jun 2025 15:29:38 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:29:38 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
Message-ID: <dy45cph3wjvxzonoakm57s55bzo6mp3jyfoio2w4jevpif4njt@llanzjjddqfk>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
 <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu>
 <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-wegnehmen-fragen-9dfdfdf0b2af@brauner>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 11DA12116D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,oracle.com,gmail.com,ffwll.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 23-06-25 14:25:45, Christian Brauner wrote:
> On Mon, Jun 23, 2025 at 02:06:43PM +0200, Jan Kara wrote:
> > On Mon 23-06-25 11:01:30, Christian Brauner wrote:
> > > Various filesystems such as pidfs (and likely drm in the future) have a
> > > use-case to support opening files purely based on the handle without
> > > having to require a file descriptor to another object. That's especially
> > > the case for filesystems that don't do any lookup whatsoever and there's
> > > zero relationship between the objects. Such filesystems are also
> > > singletons that stay around for the lifetime of the system meaning that
> > > they can be uniquely identified and accessed purely based on the file
> > > handle type. Enable that so that userspace doesn't have to allocate an
> > > object needlessly especially if they can't do that for whatever reason.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > Hmm, maybe we should predefine some invalid fd value userspace should pass
> > when it wants to "autopick" fs root? Otherwise defining more special fd
> > values like AT_FDCWD would become difficult in the future. Or we could just
> 
> Fwiw, I already did that with:
> 
> #define PIDFD_SELF_THREAD		-10000 /* Current thread. */
> #define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */

Right.

> I think the correct thing to do would have been to say anything below
> 
> #define AT_FDCWD		-100    /* Special value for dirfd used to
> 
> is reserved for the kernel. But we can probably easily do this and say
> anything from -10000 to -40000 is reserved for the kernel.
> 
> I would then change:
> 
> #define PIDFD_SELF_THREAD		-10000 /* Current thread. */
> #define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
> 
> since that's very very new and then move
> PIDFD_SELF_THREAD/PIDFD_SELF_THREAD_GROUP to include/uapi/linux/fcntl.h
> 
> and add that comment about the reserved range in there.

Given the experience with AT_ flags and various extension flags
combinations getting used in various syscalls and finally leading to odd
flag conflicts I agree this would be probably a good future proofing. I'll
leave it upto your judgement whether renumbering PIDFD_SELF_THREAD_GROUP is
safe to do or not. It is kind of optional in my opinion.

> The thing is that we'd need to enforce this on the system call level.

Not sure what do you mean by this...

> > define that FILEID_PIDFS file handles *always* ignore the fd value and
> > auto-pick the root.
> 
> I see the issue I don't think it's a big deal but I'm open to adding:
> 
> #define AT_EBADF -10009 /* -10000 - EBADF */
> 
> and document that as a stand-in for a handle that can't be resolved.

Yeah, or the FD_INVALID name you've suggested later. That sounded even
better to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

