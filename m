Return-Path: <linux-fsdevel+bounces-20801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9B8D8039
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE76B25D43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73453839F7;
	Mon,  3 Jun 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0cpttzZx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KCTAZqXq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0cpttzZx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KCTAZqXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05919F;
	Mon,  3 Jun 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411382; cv=none; b=i3CUoKQF9CVZY3WGCjFadLqzG6AYYiYX0/eiaKKgMm46tU8oo9OfWLtAO/0HeLqem9QhAc7L6mi/7Ypd/ylR+2GL0NGgnrtrzK4cTGp3LhtfNf1UC6KcH2vBG2eVuMv07UB8qOF89NJ3bdoeZQ+D5XkBJ4hVX+plEG58xbWlX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411382; c=relaxed/simple;
	bh=QsyrXgK09ZdGKR3ba9FPn812tFkoX7Xmgb9ph5tGBHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJGb+veZtLemmJ41gzG9wpTgrpBR0KwNn3A2LS9JYuURvrhWoghCjYLzGLbFvKY1aGDXHDF2motqOIaRJ7IwJsotRfaZzf3gMFZc8bkiFOH0/YHYc1sQZn69JEo1A4b2/U7iT3EdYZclK4cH6i6e7uhRSQDkN3oM6hU55t74sEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0cpttzZx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KCTAZqXq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0cpttzZx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KCTAZqXq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68AFE20031;
	Mon,  3 Jun 2024 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717411379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgmW/P4BVMbnqcSwEIT0tbMiQvfXmL7hU8HZLIni90k=;
	b=0cpttzZxplYkfynItzcVOSeXXn4ssigAeOt6fhs1DGOaiiKwjwEN5TfjE/TobvHwKc1Tyt
	jBphXyy32LlDnGNDhAR6+u1l89mJg+BogYEaMVDlFqbcPVojJXeQe3TzliJXZPJOI1RZIS
	y2i3K5d+oWuQStvge4ia737vW1i9Pss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717411379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgmW/P4BVMbnqcSwEIT0tbMiQvfXmL7hU8HZLIni90k=;
	b=KCTAZqXq95iVD0ltVqfWpXfN9fUXZnG1LnhP2xVdESpFEZhwbaftnRDbkWyFHwHg7xM8Dq
	EqWTr5wqsPEPkDAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717411379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgmW/P4BVMbnqcSwEIT0tbMiQvfXmL7hU8HZLIni90k=;
	b=0cpttzZxplYkfynItzcVOSeXXn4ssigAeOt6fhs1DGOaiiKwjwEN5TfjE/TobvHwKc1Tyt
	jBphXyy32LlDnGNDhAR6+u1l89mJg+BogYEaMVDlFqbcPVojJXeQe3TzliJXZPJOI1RZIS
	y2i3K5d+oWuQStvge4ia737vW1i9Pss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717411379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgmW/P4BVMbnqcSwEIT0tbMiQvfXmL7hU8HZLIni90k=;
	b=KCTAZqXq95iVD0ltVqfWpXfN9fUXZnG1LnhP2xVdESpFEZhwbaftnRDbkWyFHwHg7xM8Dq
	EqWTr5wqsPEPkDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AB5913A93;
	Mon,  3 Jun 2024 10:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +qAfFjOeXWY2GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 10:42:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 122F1A087F; Mon,  3 Jun 2024 12:42:59 +0200 (CEST)
Date: Mon, 3 Jun 2024 12:42:59 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240603104259.gii7lfz2fg7lyrcw@quack3>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3>
 <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531145204.GJ52987@frogsfrogsfrogs>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 31-05-24 07:52:04, Darrick J. Wong wrote:
> On Fri, May 24, 2024 at 06:11:01PM +0200, Jan Kara wrote:
> > On Thu 23-05-24 13:16:48, Andrey Albershteyn wrote:
> > > On 2024-05-23 09:48:28, Jan Kara wrote:
> > > > Hi!
> > > > 
> > > > On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > > > > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > > > > Hello!
> > > > > > 
> > > > > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > > > > XFS has project quotas which could be attached to a directory. All
> > > > > > > new inodes in these directories inherit project ID set on parent
> > > > > > > directory.
> > > > > > > 
> > > > > > > The project is created from userspace by opening and calling
> > > > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > > > > ID. Those inodes then are not shown in the quota accounting but
> > > > > > > still exist in the directory.
> > > > > > > 
> > > > > > > This patch adds two new ioctls which allows userspace, such as
> > > > > > > xfs_quota, to set project ID on special files by using parent
> > > > > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > > > > inodes and also reset it when project is removed. Also, as
> > > > > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > > > > forbid any other attributes except projid and nextents (symlink can
> > > > > > > have one).
> > > > > > > 
> > > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > > 
> > > > > > I'd like to understand one thing. Is it practically useful to set project
> > > > > > IDs for special inodes? There is no significant disk space usage associated
> > > > > > with them so wrt quotas we are speaking only about the inode itself. So is
> > > > > > the concern that user could escape inode project quota accounting and
> > > > > > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > > > > > for something that seems as a small corner case to me?
> > > > > 
> > > > > So there's few things:
> > > > > - Quota accounting is missing only some special files. Special files
> > > > >   created after quota project is setup inherit ID from the project
> > > > >   directory.
> > > > > - For special files created after the project is setup there's no
> > > > >   way to make them project-less. Therefore, creating a new project
> > > > >   over those will fail due to project ID miss match.
> > > > > - It wasn't possible to hardlink/rename project-less special files
> > > > >   inside a project due to ID miss match. The linking is fixed, and
> > > > >   renaming is worked around in first patch.
> > > > > 
> > > > > The initial report I got was about second and last point, an
> > > > > application was failing to create a new project after "restart" and
> > > > > wasn't able to link special files created beforehand.
> > > > 
> > > > I see. OK, but wouldn't it then be an easier fix to make sure we *never*
> > > > inherit project id for special inodes? And make sure inodes with unset
> > > > project ID don't fail to be linked, renamed, etc...
> > > 
> > > But then, in set up project, you can cross-link between projects and
> > > escape quota this way. During linking/renaming if source inode has
> > > ID but target one doesn't, we won't be able to tell that this link
> > > is within the project.
> > 
> > Well, I didn't want to charge these special inodes to project quota at all
> > so "escaping quota" was pretty much what I suggested to do. But my point
> > was that since the only thing that's really charged for these inodes is the
> > inodes itself then does this small inaccuracy really matter in practice?
> > Are we afraid the user is going to fill the filesystem with symlinks?
> 
> I thought the worry here is that you can't fully reassign the project
> id for a directory tree unless you have an *at() version of the ioctl
> to handle the special files that you can't open directly?
> 
> So you start with a directory tree that's (say) 2% symlinks and project
> id 5.  Later you want to set project id 7 on that subtree, but after the
> incomplete change, projid 7 is charged for 98% of the tree, and 2% are
> still stuck on projid 5.  This is a mess, and if enforcement is enabled
> you've just broken it in a way that can't be fixed aside from recreating
> those files.

So the idea I'm trying to propose (and apparently I'm failing to explain it
properly) is:

When creating special inode, set i_projid = 0 regardless of directory
settings.

When creating hardlink or doing rename, if i_projid of dentry is 0, we
allow the operation.

Teach fsck to set i_projid to 0 when inode is special.

As a result, AFAICT no problem with hardlinks, renames or similar. No need
for special new ioctl or syscall. The downside is special inodes escape
project quota accounting. Do we care?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

