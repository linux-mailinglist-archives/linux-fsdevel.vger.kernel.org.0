Return-Path: <linux-fsdevel+bounces-20925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94768FAE2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E249B2399C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30423143722;
	Tue,  4 Jun 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqhKiiDx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ae1ke9fs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqhKiiDx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ae1ke9fs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3513F429;
	Tue,  4 Jun 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491528; cv=none; b=nXIaO1P9l5P2lVe8v7Ye9YLzC/4iLC+YL0rcZITREluRKGDDMQKh6Z4z/RL91II69yTY8tBQKZCNbzXwZzKZnFCUptDo72ZH1XE4rrvkT2xBL++FvYl8M3E7Y70AJ+2jRop2zpz/75aDwzMntOXuwimEbcketm3FhfLYrSrKXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491528; c=relaxed/simple;
	bh=A1Lu4/Qfn3NaKUnBD6gKWsAe453CczOZvm5HrikI3ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKmUtNssYtFQDQqDrOBquH3qWX4tRjlBvm9WNuYYapM1yk91zgSAgW6Gso0QFifzyIeuVq42TFy/FPcJOamyM7XQB3t3ntJe/qa76rqJfIXuqU4akJS8FQ9g6/pY/7K2m20m1Vr8ZrsadaVtwVHGkgvy9JtxN1NBV8LWglplX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kqhKiiDx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ae1ke9fs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kqhKiiDx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ae1ke9fs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49BA21F7DA;
	Tue,  4 Jun 2024 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717491524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YtUXYNhFm70jM6gspgn60VvPHtybnGMW4KH/IuVSUgo=;
	b=kqhKiiDx3OHD3PK0kbxs7as3MW9UmY1GVDcZyJ1VqT8T5t0Yni7sOP0XF6nvh5ufuKqId8
	a6aOZWAHsuVAtLykwB+tS3VqAJGP5d+DKO1y9Bog12U1JH1cXxD7IIBTPm0qpDbTzmbMyO
	Jl490vmsrTJOxcVwNCcOua3PITMNQu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717491524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YtUXYNhFm70jM6gspgn60VvPHtybnGMW4KH/IuVSUgo=;
	b=Ae1ke9fsASUD/Xxpx6bjIVpNbnemMaNqfx8bvHyyZuIHA3jrGYIrg/XvhjxyjkNq9lN/ub
	4O1+DEF0aDuEVVBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717491524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YtUXYNhFm70jM6gspgn60VvPHtybnGMW4KH/IuVSUgo=;
	b=kqhKiiDx3OHD3PK0kbxs7as3MW9UmY1GVDcZyJ1VqT8T5t0Yni7sOP0XF6nvh5ufuKqId8
	a6aOZWAHsuVAtLykwB+tS3VqAJGP5d+DKO1y9Bog12U1JH1cXxD7IIBTPm0qpDbTzmbMyO
	Jl490vmsrTJOxcVwNCcOua3PITMNQu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717491524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YtUXYNhFm70jM6gspgn60VvPHtybnGMW4KH/IuVSUgo=;
	b=Ae1ke9fsASUD/Xxpx6bjIVpNbnemMaNqfx8bvHyyZuIHA3jrGYIrg/XvhjxyjkNq9lN/ub
	4O1+DEF0aDuEVVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CDAB1398F;
	Tue,  4 Jun 2024 08:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KyrZDkTXXmZuIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Jun 2024 08:58:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC9F4A086D; Tue,  4 Jun 2024 10:58:43 +0200 (CEST)
Date: Tue, 4 Jun 2024 10:58:43 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240604085843.q6qtmtitgefioj5m@quack3>
References: <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3>
 <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603174259.GB52987@frogsfrogsfrogs>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> On Mon, Jun 03, 2024 at 06:28:47PM +0200, Andrey Albershteyn wrote:
> > On 2024-06-03 12:42:59, Jan Kara wrote:
> > > On Fri 31-05-24 07:52:04, Darrick J. Wong wrote:
> > > > On Fri, May 24, 2024 at 06:11:01PM +0200, Jan Kara wrote:
> > > > > On Thu 23-05-24 13:16:48, Andrey Albershteyn wrote:
> > > > > > On 2024-05-23 09:48:28, Jan Kara wrote:
> > > > > > > Hi!
> > > > > > > 
> > > > > > > On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > > > > > > > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > > > > > > > Hello!
> > > > > > > > > 
> > > > > > > > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > > > > > > > XFS has project quotas which could be attached to a directory. All
> > > > > > > > > > new inodes in these directories inherit project ID set on parent
> > > > > > > > > > directory.
> > > > > > > > > > 
> > > > > > > > > > The project is created from userspace by opening and calling
> > > > > > > > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > > > > > > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > > > > > > > > inode from VFS. Therefore, some inodes are left with empty project
> > > > > > > > > > ID. Those inodes then are not shown in the quota accounting but
> > > > > > > > > > still exist in the directory.
> > > > > > > > > > 
> > > > > > > > > > This patch adds two new ioctls which allows userspace, such as
> > > > > > > > > > xfs_quota, to set project ID on special files by using parent
> > > > > > > > > > directory to open FS inode. This will let xfs_quota set ID on all
> > > > > > > > > > inodes and also reset it when project is removed. Also, as
> > > > > > > > > > vfs_fileattr_set() is now will called on special files too, let's
> > > > > > > > > > forbid any other attributes except projid and nextents (symlink can
> > > > > > > > > > have one).
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > > > > > 
> > > > > > > > > I'd like to understand one thing. Is it practically useful to set project
> > > > > > > > > IDs for special inodes? There is no significant disk space usage associated
> > > > > > > > > with them so wrt quotas we are speaking only about the inode itself. So is
> > > > > > > > > the concern that user could escape inode project quota accounting and
> > > > > > > > > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > > > > > > > > for something that seems as a small corner case to me?
> > > > > > > > 
> > > > > > > > So there's few things:
> > > > > > > > - Quota accounting is missing only some special files. Special files
> > > > > > > >   created after quota project is setup inherit ID from the project
> > > > > > > >   directory.
> > > > > > > > - For special files created after the project is setup there's no
> > > > > > > >   way to make them project-less. Therefore, creating a new project
> > > > > > > >   over those will fail due to project ID miss match.
> > > > > > > > - It wasn't possible to hardlink/rename project-less special files
> > > > > > > >   inside a project due to ID miss match. The linking is fixed, and
> > > > > > > >   renaming is worked around in first patch.
> > > > > > > > 
> > > > > > > > The initial report I got was about second and last point, an
> > > > > > > > application was failing to create a new project after "restart" and
> > > > > > > > wasn't able to link special files created beforehand.
> > > > > > > 
> > > > > > > I see. OK, but wouldn't it then be an easier fix to make sure we *never*
> > > > > > > inherit project id for special inodes? And make sure inodes with unset
> > > > > > > project ID don't fail to be linked, renamed, etc...
> > > > > > 
> > > > > > But then, in set up project, you can cross-link between projects and
> > > > > > escape quota this way. During linking/renaming if source inode has
> > > > > > ID but target one doesn't, we won't be able to tell that this link
> > > > > > is within the project.
> > > > > 
> > > > > Well, I didn't want to charge these special inodes to project quota at all
> > > > > so "escaping quota" was pretty much what I suggested to do. But my point
> > > > > was that since the only thing that's really charged for these inodes is the
> > > > > inodes itself then does this small inaccuracy really matter in practice?
> > > > > Are we afraid the user is going to fill the filesystem with symlinks?
> > > > 
> > > > I thought the worry here is that you can't fully reassign the project
> > > > id for a directory tree unless you have an *at() version of the ioctl
> > > > to handle the special files that you can't open directly?
> > > > 
> > > > So you start with a directory tree that's (say) 2% symlinks and project
> > > > id 5.  Later you want to set project id 7 on that subtree, but after the
> > > > incomplete change, projid 7 is charged for 98% of the tree, and 2% are
> > > > still stuck on projid 5.  This is a mess, and if enforcement is enabled
> > > > you've just broken it in a way that can't be fixed aside from recreating
> > > > those files.
> > > 
> > > So the idea I'm trying to propose (and apparently I'm failing to explain it
> > > properly) is:
> > > 
> > > When creating special inode, set i_projid = 0 regardless of directory
> > > settings.
> > > 
> > > When creating hardlink or doing rename, if i_projid of dentry is 0, we
> > > allow the operation.
> > > 
> > > Teach fsck to set i_projid to 0 when inode is special.
> > > 
> > > As a result, AFAICT no problem with hardlinks, renames or similar. No need
> > > for special new ioctl or syscall. The downside is special inodes escape
> > > project quota accounting. Do we care?
> > 
> > I see. But is it fine to allow fill filesystem with special inodes?
> > Don't know if it can be used somehow but this is exception from
> > isoft/ihard limits then.
> > 
> > I don't see issues with this approach also, if others don't have
> > other points or other uses for those new syscalls, I can go with
> > this approach.
> 
> I do -- allowing unpriviledged users to create symlinks that consume
> icount (and possibly bcount) in the root project breaks the entire
> enforcement mechanism.  That's not the way that project quota has worked
> on xfs and it would be quite rude to nullify the PROJINHERIT flag bit
> only for these special cases.

OK, fair enough. I though someone will hate this. I'd just like to
understand one thing: Owner of the inode can change the project ID to 0
anyway so project quotas are more like a cooperative space tracking scheme
anyway. If you want to escape it, you can. So what are you exactly worried
about? Is it the container usecase where from within the user namespace you
cannot change project IDs?

Anyway I just wanted to have an explicit decision that the simple solution
is not good enough before we go the more complex route ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

