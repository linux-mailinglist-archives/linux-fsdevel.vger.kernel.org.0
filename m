Return-Path: <linux-fsdevel+bounces-60264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917FB439FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3503189E28E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BC2FF141;
	Thu,  4 Sep 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWXav/3u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NHTlqfL5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWXav/3u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NHTlqfL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429072FE59C
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984997; cv=none; b=Tl7Kckn3+t7XMFJj8861lHhiepLdFGJe7RyguCCltFvQ6LUf0yi3ogQfUr8akvTcidLRC0hnSkyM8SqYdlbbUt0LVvueUEDwNXAnX03kfMzTRyJwHBofRCUht+nyUZb8KziWcJDRZX7twzdszSJ8icSV4A6rLYJdJdnM3ehNHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984997; c=relaxed/simple;
	bh=sxayn1asl0bKi0flZbfV2SZy2eFidZ6j62NxSqJGJ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqvlUjUpwYF+7qNHRVbBxbnfzKzAbOaPM/mC6FwWSBFcvSJTPi0AWW5c8yDmb4+AHOyiqZQfF7m+SUzJEhcQIfL3uuJTtWU4yn1X1Np8GzVItQOypLwajuIE9MlPRPfjulvXt4pSc+cQk20vOGloVD51SgP4RcXWk41vIoktSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWXav/3u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NHTlqfL5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWXav/3u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NHTlqfL5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 467665D32C;
	Thu,  4 Sep 2025 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756984993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVIMoIb4b/8QipY4uAIDOSRHhRd/hvFR/UxA0AYn9xU=;
	b=mWXav/3uGIvN/vCoYIHQlMEzL0r+wh8b6tcpfpbSxbPKTLiI3vPiKmGjdvhEkkKIBl64QH
	BQ94l3MsAPUGF0nyYYEh8M+JZ+Q30o/xl6DQ4ryJSyFyaw1kxmwvO7cfd28Y1292ySPvTy
	0Gb6HCO3MmpPfJkITENosN6GAczmMS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756984993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVIMoIb4b/8QipY4uAIDOSRHhRd/hvFR/UxA0AYn9xU=;
	b=NHTlqfL54PnyrHrLITrdaERqeXfnWs+IPIIqfV5EQvnu6/V1EySAKse6telYPuCP/71eww
	Ww1ZDUf5nX0NXoAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mWXav/3u";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NHTlqfL5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756984993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVIMoIb4b/8QipY4uAIDOSRHhRd/hvFR/UxA0AYn9xU=;
	b=mWXav/3uGIvN/vCoYIHQlMEzL0r+wh8b6tcpfpbSxbPKTLiI3vPiKmGjdvhEkkKIBl64QH
	BQ94l3MsAPUGF0nyYYEh8M+JZ+Q30o/xl6DQ4ryJSyFyaw1kxmwvO7cfd28Y1292ySPvTy
	0Gb6HCO3MmpPfJkITENosN6GAczmMS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756984993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVIMoIb4b/8QipY4uAIDOSRHhRd/hvFR/UxA0AYn9xU=;
	b=NHTlqfL54PnyrHrLITrdaERqeXfnWs+IPIIqfV5EQvnu6/V1EySAKse6telYPuCP/71eww
	Ww1ZDUf5nX0NXoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31BE413AA0;
	Thu,  4 Sep 2025 11:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gHTDC6F2uWitPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Sep 2025 11:23:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C447CA0A2D; Thu,  4 Sep 2025 13:23:12 +0200 (CEST)
Date: Thu, 4 Sep 2025 13:23:12 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fhandle: use more consistent rules for decoding file
 handle from userns
Message-ID: <65b4bv4rs3m4pjx56ilcyxo3wh5ssyl4fs2icd6axm33l6qh53@kdmtibzk6yfy>
References: <20250827194309.1259650-1-amir73il@gmail.com>
 <xdvs4ljulkgkpdyuum2hwzhpy2jxb7g55lcup7jvlf6rfwjsjt@s63vk6mpyp5e>
 <CAOQ4uxi_3nzGf74vi1E3P9imatLv+t1d5FE=jm4YzyAUVEkNyA@mail.gmail.com>
 <6eyx4x65awtemsx7h63ghh2txuswg4wct4lt5nig3hmz2owter@ezhzwu4t6uwh>
 <CAOQ4uxij+V4mPRwZQ6UgKy=m-Nove1YsawTCmFG5ORzk=SvKaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxij+V4mPRwZQ6UgKy=m-Nove1YsawTCmFG5ORzk=SvKaQ@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 467665D32C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.01

On Mon 01-09-25 19:47:51, Amir Goldstein wrote:
> On Mon, Sep 1, 2025 at 11:44 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 29-08-25 14:55:13, Amir Goldstein wrote:
> > > On Fri, Aug 29, 2025 at 12:50 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 27-08-25 21:43:09, Amir Goldstein wrote:
> > > > > Commit 620c266f39493 ("fhandle: relax open_by_handle_at() permission
> > > > > checks") relaxed the coditions for decoding a file handle from non init
> > > > > userns.
> > > > >
> > > > > The conditions are that that decoded dentry is accessible from the user
> > > > > provided mountfd (or to fs root) and that all the ancestors along the
> > > > > path have a valid id mapping in the userns.
> > > > >
> > > > > These conditions are intentionally more strict than the condition that
> > > > > the decoded dentry should be "lookable" by path from the mountfd.
> > > > >
> > > > > For example, the path /home/amir/dir/subdir is lookable by path from
> > > > > unpriv userns of user amir, because /home perms is 755, but the owner of
> > > > > /home does not have a valid id mapping in unpriv userns of user amir.
> > > > >
> > > > > The current code did not check that the decoded dentry itself has a
> > > > > valid id mapping in the userns.  There is no security risk in that,
> > > > > because that final open still performs the needed permission checks,
> > > > > but this is inconsistent with the checks performed on the ancestors,
> > > > > so the behavior can be a bit confusing.
> > > > >
> > > > > Add the check for the decoded dentry itself, so that the entire path,
> > > > > including the last component has a valid id mapping in the userns.
> > > > >
> > > > > Fixes: 620c266f39493 ("fhandle: relax open_by_handle_at() permission checks")
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Yeah, probably it's less surprising this way. Feel free to add:
> > > >
> > >
> > > BTW, Jan, I was trying to think about whether we could do
> > > something useful with privileged_wrt_inode_uidgid() for filtering
> > > events that we queue by group->user_ns.
> > >
> > > Then users could allow something like:
> > > 1. Admin sets up privileged fanotify fd and filesystem watch on
> > >     /home filesystem
> > > 2. Enters userns of amir and does ioctl to change group->user_ns
> > >     to user ns of amir
> > > 3. Hands over fanotify fd to monitor process running in amir's userns
> > > 4. amir's monitor process gets all events on filesystem /home
> > >     whose directory and object uid/gid are mappable to amir's userns
> > > 5. With properly configured systems, that we be all the files/dirs under
> > >     /home/amir
> > >
> > > I have posted several POCs in the past trying different approaches
> > > for filtering by userns, but I have never tried to take this approach.
> > >
> > > Compared to subtree filtering, this could be quite pragmatic? Hmm?
> >
> > This is definitely relatively easy to implement in the kernel. I'm just not
> > sure about two things:
> >
> > 1) Will this be easy enough to use from userspace so that it will get used?
> > Mount watches have been created as a "partial" solution for subtree watches
> > as well. But in practice it didn't get very widespread use as subtree watch
> > replacement because setting up a mountpoint for subtree you want to watch is
> > not flexible enough. Setting up userns and id mappings and proper inode
> > ownership seems like a similar hassle for anything else than a full home
> > dir as well...
> 
> I would not suggest this if it were not for systemd-mountfsd which is
> designed to allow non-root users to mount "trusted" images (e.g. ext4).
> 
> I don't think this feature is already implemented, but an image auto
> generated for the user per demand by mkfs, should also be "trusted".
> 
> In theory, as user jack, you should be able to spawn an unpriv userns
> wherein user jack is uid 0 and get a mount of a freshly formatted ext4 fs
> idmapped in a way that only uids from the userns private range could
> write to that fs.

Ah, I see. Yes, I've heard of similar plans in systemd land.

> *if* this is possible and useful to users, then we will start seeing in
> the wild filesystems where all the inodes are owned by a private range of
> uids, all mappable to a specific userns.

Right. But I expect that the sb->s_user_ns will point to the user's
namespace in that case? So that all the possibly preexisting fs content
gets properly mapped to ids available to the user? If that's the case we'd
already allow placing filesystem mark on such superblocks and there's no
need for filtering?

But I think your original usecase mentioned a different situation with a
filesystem shared by multiple users (/home) but additional idmapping set in
the user namespace where the process is running.

> But TBH, I am not sure if this is already a reality or a likely future or not.
> I need to dig some more to understand the future plans for
> systemd-mountfsd use cases.
> 
> > 2) Filtering all events on the fs only by inode owner being mappable to
> > user ns looks somewhat dangerous to me. Sure you offload the responsibility
> > of the safe setup to userspace but the fact that this completely bypasses
> > any permission checks means that configuring the system so that it does not
> > leak any unintended information (like filenames or facts that some things
> > have changed user otherwise wouldn't be able to see) might be difficult.
> > Consider if e.g. maildir is on your monitored fs and for some reason the
> > UID of the postfix is mapped to your user ns (e.g. because the user needs
> > access to some file/dir managed by postfix). Then you could monitor all
> > fs activity of postfix possibly learning about emails to other persons in
> > the system.
> 
> Well, the rule should be that the user setting group->user_ns is ADMIN
> in that userns.
> 
> If someone has creates a userns where user amir is uid 0 and also
> mapped user postfix into the userns of amir, then that gives user amir
> full privs to access and modify user postfix owned files, so the privilege
> escalation, to the best of my understanding, has already happened way
> before user amir started the fanotify monitor.

Right, sorry, I didn't quite think this through. Indeed as I've checked
e.g. Kubernetes uses disjoint ranges of UIDs to map into user namespaces of
different containers. So filtering filesystem events to inodes whose id is
mappable in such user NS should be OK. But it would be good to verify with
somebody who has more experience with this namespacing stuff than me :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

