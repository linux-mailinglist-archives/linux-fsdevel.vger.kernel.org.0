Return-Path: <linux-fsdevel+bounces-24128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506793A083
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9FB1F2309D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37515218F;
	Tue, 23 Jul 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dUTCJAPQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QBCEry7W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dUTCJAPQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QBCEry7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5542A96;
	Tue, 23 Jul 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737931; cv=none; b=AOUr5EkKBgo+RjlGakScH415MjgQCZBmx2+N4k6pVMkVC2zQaXZjIvxeiGyovhaom8uSMyaVXN12KDgGM7jCNcV8oYR8Z0gkLEjqtqYZ0qTHJNubN7FarTblQzcYzyQvsQGeYfDrVS3OQdhi+m4EWVFlnSoAtCUfjkeA3JzjKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737931; c=relaxed/simple;
	bh=rJBrIb6vzd1itvY6vM+pBG61XCfeuNKdxFiAnkGIae0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEAo1K5Jvmp4TLA15I6AGoMV6o6QdxqX4VfxTvx3iDTpS/36A2AaXFgQ86cWaWLrtg6NV2nGcJ6Fs7TPD8P7MOg4uwxNYSb8RAoWbrPm21+U/eIc5w5iozxfyauIbR9U56eA1AiZT90ofDhAqEmZMJGC6zQLOnBOB5SKpuQ3Sa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dUTCJAPQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QBCEry7W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dUTCJAPQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QBCEry7W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F7421FCE6;
	Tue, 23 Jul 2024 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721737927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE9ldY35I1sn/FbE1cCKXIvVB8Qf9PyCUf7w17jAGMw=;
	b=dUTCJAPQ4wh3qbKoE4t90PezB2pEqYPULn39G0yZL4Fuo0F+/T96MxvS64dvrZ2uxqtdqA
	VIbWLwnP01G+ruSVllUdS/hsqDRGG+555XfnWPRB8Jh23pBwIjfX41ld8YMBdJdvqmZuNB
	Xd1efaIOe6FOFNjAwNqFbEGSdlrfVQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721737927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE9ldY35I1sn/FbE1cCKXIvVB8Qf9PyCUf7w17jAGMw=;
	b=QBCEry7WJfp/8HTaYiB5zcaARk/1Fpb1w/StNhoGsuM1ak+8BFgGdwthDrC+baF+NDQ5Xr
	XiJINHZjW043ycDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dUTCJAPQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QBCEry7W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721737927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE9ldY35I1sn/FbE1cCKXIvVB8Qf9PyCUf7w17jAGMw=;
	b=dUTCJAPQ4wh3qbKoE4t90PezB2pEqYPULn39G0yZL4Fuo0F+/T96MxvS64dvrZ2uxqtdqA
	VIbWLwnP01G+ruSVllUdS/hsqDRGG+555XfnWPRB8Jh23pBwIjfX41ld8YMBdJdvqmZuNB
	Xd1efaIOe6FOFNjAwNqFbEGSdlrfVQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721737927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE9ldY35I1sn/FbE1cCKXIvVB8Qf9PyCUf7w17jAGMw=;
	b=QBCEry7WJfp/8HTaYiB5zcaARk/1Fpb1w/StNhoGsuM1ak+8BFgGdwthDrC+baF+NDQ5Xr
	XiJINHZjW043ycDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D146137DF;
	Tue, 23 Jul 2024 12:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1zCYGqKin2YjFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jul 2024 12:31:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CCA69A08BD; Tue, 23 Jul 2024 14:32:02 +0200 (CEST)
Date: Tue, 23 Jul 2024 14:32:02 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240723123202.vu5tfzoblpib3nve@quack3>
References: <2136178.1721725194@warthog.procyon.org.uk>
 <20240723104533.mznf3svde36w6izp@quack3>
 <20240723-aberkennen-unruhen-61570127dc6e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-aberkennen-unruhen-61570127dc6e@brauner>
X-Rspamd-Queue-Id: 2F7421FCE6
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.81
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Tue 23-07-24 13:11:51, Christian Brauner wrote:
> On Tue, Jul 23, 2024 at 12:45:33PM GMT, Jan Kara wrote:
> > On Tue 23-07-24 09:59:54, David Howells wrote:
> > > When using cachefiles, lockdep may emit something similar to the circular
> > > locking dependency notice below.  The problem appears to stem from the
> > > following:
> > > 
> > >  (1) Cachefiles manipulates xattrs on the files in its cache when called
> > >      from ->writepages().
> > > 
> > >  (2) The setxattr() and removexattr() system call handlers get the name
> > >      (and value) from userspace after taking the sb_writers lock, putting
> > >      accesses of the vma->vm_lock and mm->mmap_lock inside of that.
> > > 
> > >  (3) The afs filesystem uses a per-inode lock to prevent multiple
> > >      revalidation RPCs and in writeback vs truncate to prevent parallel
> > >      operations from deadlocking against the server on one side and local
> > >      page locks on the other.
> > > 
> > > Fix this by moving the getting of the name and value in {get,remove}xattr()
> > > outside of the sb_writers lock.  This also has the minor benefits that we
> > > don't need to reget these in the event of a retry and we never try to take
> > > the sb_writers lock in the event we can't pull the name and value into the
> > > kernel.
> > 
> > Well, it seems like you are trying to get rid of the dependency
> > sb_writers->mmap_sem. But there are other places where this dependency is
> 
> Independent of this issue, I think that moving the retrieval of name and
> value out of the lock is a good thing. The commit message might need to
> get reworded of course.

Oh, absolutely. I think the change itself makes sense, just it will not fix
what David hopes to fix :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

