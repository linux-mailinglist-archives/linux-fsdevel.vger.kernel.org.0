Return-Path: <linux-fsdevel+bounces-59764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5BB3DEEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AFF3AF733
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A632FF16F;
	Mon,  1 Sep 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UrF+lXHE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yPhi5TW3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UrF+lXHE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yPhi5TW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FE19047F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719847; cv=none; b=PYIKTMmtKY+7gBSwfnLFXfXOaqtil5ktu3dXKgW209gWG/y5+jNYmct6mcUq3KgEj6QhPjgO4zTF2LLz1SKUo15d3eySUJ4+09XdGgC4BGDQpVJO7J3+jfKiGH6uIjOLL2SrP0Y8NAOiTtJy12gG9kqSWwYRZJD72CQbY9LiS2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719847; c=relaxed/simple;
	bh=BCW/liHUVSCBJtxtC79hYPrxIuYqSMeXDF3xUYRwTLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEvVh/SVHX9Zhfi55TOiBWUgipelH2JNpIDZ1kpUXh19BdFxqgMXfdPf3GsoUpOZqxiN5otDLJF8Ewr9Y6NUA1g17Fb9x3x936Zw0jtp5rXjdSMT2FU6hU1oi/VsMblZvPYnZU4+0AbYyvNF1tSGiz8fkyR0GZeR5CxOd8OflAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UrF+lXHE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yPhi5TW3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UrF+lXHE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yPhi5TW3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A8F41F387;
	Mon,  1 Sep 2025 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756719843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2KTaxYjYazeCw9Kf7XGSzpIG8xjtdkY1OJF2f9J/10=;
	b=UrF+lXHEPzJ+RXIC7WSnzngftA5y6MYwh/BJghh7Sej+4jo3pXHSCLZmgEF4KC91tmex+A
	cOoNULU+zwGkixU9w804iWnHzZ1PPI4oabYO22Ma63nTxt/7NBaO1EtUcmdA0VrjpaxkNT
	sku83pMOhTGcoZLintb3fIyoYaOCOzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756719843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2KTaxYjYazeCw9Kf7XGSzpIG8xjtdkY1OJF2f9J/10=;
	b=yPhi5TW3OSHD37oOlO8llzjQZuyr5DNVQWE/VGCex34O2IeLRg7FT/VPb4+DJusDj+UTIH
	rz2LiC/qt2akA7Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756719843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2KTaxYjYazeCw9Kf7XGSzpIG8xjtdkY1OJF2f9J/10=;
	b=UrF+lXHEPzJ+RXIC7WSnzngftA5y6MYwh/BJghh7Sej+4jo3pXHSCLZmgEF4KC91tmex+A
	cOoNULU+zwGkixU9w804iWnHzZ1PPI4oabYO22Ma63nTxt/7NBaO1EtUcmdA0VrjpaxkNT
	sku83pMOhTGcoZLintb3fIyoYaOCOzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756719843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2KTaxYjYazeCw9Kf7XGSzpIG8xjtdkY1OJF2f9J/10=;
	b=yPhi5TW3OSHD37oOlO8llzjQZuyr5DNVQWE/VGCex34O2IeLRg7FT/VPb4+DJusDj+UTIH
	rz2LiC/qt2akA7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D98D1378C;
	Mon,  1 Sep 2025 09:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K9u6GuNqtWiBcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 09:44:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3426A099B; Mon,  1 Sep 2025 11:44:02 +0200 (CEST)
Date: Mon, 1 Sep 2025 11:44:02 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fhandle: use more consistent rules for decoding file
 handle from userns
Message-ID: <6eyx4x65awtemsx7h63ghh2txuswg4wct4lt5nig3hmz2owter@ezhzwu4t6uwh>
References: <20250827194309.1259650-1-amir73il@gmail.com>
 <xdvs4ljulkgkpdyuum2hwzhpy2jxb7g55lcup7jvlf6rfwjsjt@s63vk6mpyp5e>
 <CAOQ4uxi_3nzGf74vi1E3P9imatLv+t1d5FE=jm4YzyAUVEkNyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi_3nzGf74vi1E3P9imatLv+t1d5FE=jm4YzyAUVEkNyA@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 29-08-25 14:55:13, Amir Goldstein wrote:
> On Fri, Aug 29, 2025 at 12:50 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 27-08-25 21:43:09, Amir Goldstein wrote:
> > > Commit 620c266f39493 ("fhandle: relax open_by_handle_at() permission
> > > checks") relaxed the coditions for decoding a file handle from non init
> > > userns.
> > >
> > > The conditions are that that decoded dentry is accessible from the user
> > > provided mountfd (or to fs root) and that all the ancestors along the
> > > path have a valid id mapping in the userns.
> > >
> > > These conditions are intentionally more strict than the condition that
> > > the decoded dentry should be "lookable" by path from the mountfd.
> > >
> > > For example, the path /home/amir/dir/subdir is lookable by path from
> > > unpriv userns of user amir, because /home perms is 755, but the owner of
> > > /home does not have a valid id mapping in unpriv userns of user amir.
> > >
> > > The current code did not check that the decoded dentry itself has a
> > > valid id mapping in the userns.  There is no security risk in that,
> > > because that final open still performs the needed permission checks,
> > > but this is inconsistent with the checks performed on the ancestors,
> > > so the behavior can be a bit confusing.
> > >
> > > Add the check for the decoded dentry itself, so that the entire path,
> > > including the last component has a valid id mapping in the userns.
> > >
> > > Fixes: 620c266f39493 ("fhandle: relax open_by_handle_at() permission checks")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Yeah, probably it's less surprising this way. Feel free to add:
> >
> 
> BTW, Jan, I was trying to think about whether we could do
> something useful with privileged_wrt_inode_uidgid() for filtering
> events that we queue by group->user_ns.
> 
> Then users could allow something like:
> 1. Admin sets up privileged fanotify fd and filesystem watch on
>     /home filesystem
> 2. Enters userns of amir and does ioctl to change group->user_ns
>     to user ns of amir
> 3. Hands over fanotify fd to monitor process running in amir's userns
> 4. amir's monitor process gets all events on filesystem /home
>     whose directory and object uid/gid are mappable to amir's userns
> 5. With properly configured systems, that we be all the files/dirs under
>     /home/amir
> 
> I have posted several POCs in the past trying different approaches
> for filtering by userns, but I have never tried to take this approach.
> 
> Compared to subtree filtering, this could be quite pragmatic? Hmm?

This is definitely relatively easy to implement in the kernel. I'm just not
sure about two things:

1) Will this be easy enough to use from userspace so that it will get used?
Mount watches have been created as a "partial" solution for subtree watches
as well. But in practice it didn't get very widespread use as subtree watch
replacement because setting up a mountpoint for subtree you want to watch is
not flexible enough. Setting up userns and id mappings and proper inode
ownership seems like a similar hassle for anything else than a full home
dir as well...

2) Filtering all events on the fs only by inode owner being mappable to
user ns looks somewhat dangerous to me. Sure you offload the responsibility
of the safe setup to userspace but the fact that this completely bypasses
any permission checks means that configuring the system so that it does not
leak any unintended information (like filenames or facts that some things
have changed user otherwise wouldn't be able to see) might be difficult.
Consider if e.g. maildir is on your monitored fs and for some reason the
UID of the postfix is mapped to your user ns (e.g. because the user needs
access to some file/dir managed by postfix). Then you could monitor all
fs activity of postfix possibly learning about emails to other persons in
the system.

> The difference from subtree filtering is that it shifts the responsibility
> of making sure that /home/amir and /home/jack have files with uid,gid
> in different ranges to the OS/runtime, which is a responsibility that
> some systems are already taking care of anyway.

At this point I'm not convinced there are that many systems where this way
of filtering would be useful but I could be wrong. The fact that some ID is
mappable in a namespace looks as kind of weak restriction because you may
need to map into the namespace various external "system" ids AFAIU. But I
can see that e.g. for containers the idea of restricting events to inodes
whose owners are in a range of UIDs may be attractive.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

