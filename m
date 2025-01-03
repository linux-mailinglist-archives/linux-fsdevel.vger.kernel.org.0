Return-Path: <linux-fsdevel+bounces-38364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E25A00A97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877A81636E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518261FA25D;
	Fri,  3 Jan 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGg0uN03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpt4/yJ2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGg0uN03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpt4/yJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0761F9405;
	Fri,  3 Jan 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914894; cv=none; b=WjcsKPHksaCja3CZfAnndlB6gbw3+VZEE51UMowzD4ivblmZy0hafxTL42ImaNfBnEz+H0WDUs9cpde7u7mHCaDTcs36T7SW1CrbWAIq8/Se/4MkfSWDZH0mDmiV2/5133SvJftJfWloWrZOz7Kg2jNZP2uzmzwjS8sUcBtZNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914894; c=relaxed/simple;
	bh=rAhXEWfGaQaPHAR3eMLyUnC01OO39rczaefmfHmFToI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmQoWHoH8NdQhYEPY1P3nyxv+mQOVTZr/vUT3R79+Qqoc2rRESzqzJa1IoZehtUsDOXE4rAtlqy+gL1ARXbC1IOFSFeybiIssz1yqstK2azt8Ywvec6sRdbLCSRNxfTLPs/z5INtsSLuVTmWR/6fyzNDN3i4j0bhG8jexGruz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGg0uN03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpt4/yJ2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGg0uN03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpt4/yJ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 662FB1F38E;
	Fri,  3 Jan 2025 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735914890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiGE0yHZuy+JyzwHFlaQMza/dvndIURW3Hv19uOrv5c=;
	b=bGg0uN03AJ9CA2+wmyU/WLN4lKqX1zqMsPzDb40Kk0zD6Ow0QyS1MgiuMVe9vcrbPZI4sk
	lxH/B2j2VU1LLD9prIPSM2zzh/lPLr+YheHCA8zgratEVEl5AMFn9d5BAnn2syf5mLCHJQ
	s/7WMPYTXMPmVfLzpf1qrCwlF6e5nZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735914890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiGE0yHZuy+JyzwHFlaQMza/dvndIURW3Hv19uOrv5c=;
	b=dpt4/yJ29uRYATzZaD5BJBzoLQ9L0AG+5zGvAgBK+dhXBflAFN/P3emUrheldzl3D0OkLb
	RKYrrdy7syvS6AAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bGg0uN03;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dpt4/yJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735914890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiGE0yHZuy+JyzwHFlaQMza/dvndIURW3Hv19uOrv5c=;
	b=bGg0uN03AJ9CA2+wmyU/WLN4lKqX1zqMsPzDb40Kk0zD6Ow0QyS1MgiuMVe9vcrbPZI4sk
	lxH/B2j2VU1LLD9prIPSM2zzh/lPLr+YheHCA8zgratEVEl5AMFn9d5BAnn2syf5mLCHJQ
	s/7WMPYTXMPmVfLzpf1qrCwlF6e5nZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735914890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiGE0yHZuy+JyzwHFlaQMza/dvndIURW3Hv19uOrv5c=;
	b=dpt4/yJ29uRYATzZaD5BJBzoLQ9L0AG+5zGvAgBK+dhXBflAFN/P3emUrheldzl3D0OkLb
	RKYrrdy7syvS6AAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44204134E4;
	Fri,  3 Jan 2025 14:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PIRNEIr1d2eqXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 14:34:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DD1DA0844; Fri,  3 Jan 2025 15:34:48 +0100 (CET)
Date: Fri, 3 Jan 2025 15:34:48 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Christian Brauner <brauner@kernel.org>, sunyongjian1@huawei.com, Yang Erkun <yangerkun@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [BUG REPORT] ext4: =?utf-8?B?4oCcZXJyb3JzPXJlbW91bnQtcm/igJ0g?=
 =?utf-8?B?aGFzIGJlY29tZSDigJxlcnJvcnM9c2h1dGRvd27igJ0/?=
Message-ID: <7zrjd67t2fyl6wre7t6fuudjn22edslce5xlgioqc7ovfjtwp7@wk44gob6kwwh>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
 <198ead4f-dba6-43d7-a4a5-06b92001518d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <198ead4f-dba6-43d7-a4a5-06b92001518d@huawei.com>
X-Rspamd-Queue-Id: 662FB1F38E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 03-01-25 21:19:27, Baokun Li wrote:
> On 2025/1/3 18:42, Jan Kara wrote:
> > > > > What's worse is that after commit
> > > > >     95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
> > > > > was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
> > > > > ext4_handle_error(). This causes the file system to not be read-only
> > > > > when an error is triggered in "errors=remount-ro" mode, because
> > > > > EXT4_FLAGS_SHUTDOWN prevents both writing and reading.
> > > > Here I don't understand what is really the problem with EXT4_MF_FS_ABORTED
> > > > removal. What do you exactly mean by "causes the file system to not be
> > > > read-only"? We still return EROFS where we used to, we disallow writing as
> > > > we used to. Can you perhaps give an example what changed with this commit?
> > > Sorry for the lack of clarity in my previous explanation. The key point
> > > is not about removing EXT4_MF_FS_ABORTED, but rather we will set
> > > EXT4_FLAGS_SHUTDOWN bit, which not only prevents writes but also prevents
> > > reads. Therefore, saying it's not read-only actually means it's completely
> > > unreadable.
> > Ah, I see. I didn't think about that. Is it that you really want reading to
> > work from a filesystem after error? Can you share why (I'm just trying to
> > understand the usecase)? Or is this mostly a theoretical usecase?
> Switching to read-only mode after an error is a common practice for most
> file systems (ext4/btrfs/affs/fat/jfs/nilfs/nilfs2/ocfs2/ubifs/ufs, etc.).
> There are two main benefits to doing this:
>  * Read-only processes can continue to run unaffected after the error.
>  * Shutting down after an error would lose some data in memory that has
>    not been written to disk. If the file system is read-only, we can back
>    up these data to another location in time and then exit gracefully.
> > I think we could introduce "shutdown modifications" state which would still
> > allow pure reads to succeed if there's a usecase for such functionality.
> I agree that maintaining a flag like EXT4_FLAGS_RDONLY within ext4 seems
> to be a good solution at this point. It avoids both introducing mechanism
> changes and VFS coupling. If no one has a better idea, I will implement it.

Yeah, let's go with a separate "emergency RO" ext4 flag then. I think we
could just enhance the ext4_forced_shutdown() checks to take a flag whether
the operation is a modification or not and when it is a modification, it
would additionally trigger also when EMERGENCY_RO flag is set (which would
get set by ext4_handle_error()).

Thanks for having a look into this.

								Honza

> > > > So how does your framework detect that the filesystem has failed with
> > > > errors=remount-ro? By parsing /proc/mounts or otherwise querying current
> > > > filesystem mount options?
> > > In most cases, run the mount command and filter related options.
> > > > Would it be acceptable for you to look at some
> > > > other mount option (e.g. "shutdown") to detect that state? We could easily
> > > > implement that.
> > > We do need to add a shutdown hint, but that's not the point.
> > > 
> > > We've discussed this internally, and now if the logs are flushed,
> > > we have no way of knowing if the current filesystem is shutdown. We don't
> > > know if the -EIO from the filesystem is a hardware problem or if the
> > > filesystem is already shutdown. So even if there is no current problem,
> > > we should add some kind of hint to let the user know that the current
> > > filesystem is shutdown.
> > > 
> > > The changes to display shutdown are as follows, so that we can see if the
> > > current filesystem has been shutdown in the mount command.
> > Yes, I think this would be a good addition regardless of other changes we
> > might need to do. It would be preferable to be able to come up with
> > something that's acceptable for querying of shutdown state also for other
> > filesystems - I've CCed fsdevel and XFS in particular since it has much
> > longer history of fs shutdown implementation.
> > 
> > 								Honza
> > 
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 3955bec9245d..ba28ef0f662e 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -3157,6 +3157,9 @@ static int _ext4_show_options(struct seq_file *seq,
> > > struct super_block *sb,
> > >          if (nodefs && !test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
> > >                  SEQ_OPTS_PUTS("prefetch_block_bitmaps");
> > > 
> > > +       if (!nodefs && ext4_forced_shutdown(sb))
> > > +               SEQ_OPTS_PUTS("shutdown");
> > > +
> > >          ext4_show_quota_options(seq, sb);
> > >          return 0;
> > >   }
> > > > I'm sorry again for causing you trouble.
> > > Never mind, thank you for your reply!
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

