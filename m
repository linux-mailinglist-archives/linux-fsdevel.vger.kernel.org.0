Return-Path: <linux-fsdevel+bounces-38360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7268DA007F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 11:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84FA7A1C1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36F1F9438;
	Fri,  3 Jan 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sLHAa9x6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9MJsOEd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sLHAa9x6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9MJsOEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04D1B0F10;
	Fri,  3 Jan 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735900938; cv=none; b=uzaGF7QxX4TywBjTq6Q2FdBhr+RW8XplupMwWWrlluSLuCCoJ6iAZDD9y4xjuUI5XChc7/Fqt7XY4zdMY1xzU+FVh5v0CcVjknZ8XUnx+nfhyZ8BOSuxujRyorkik2CoyEtpTUcCLvbDTBam5Oy7V/JXCtHsQaDSk15bOlmKEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735900938; c=relaxed/simple;
	bh=dorcDa35yhY1Hs66Hpaw6clpdwLnUilma1xH9QhbUNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWl2NGYHQV0333QCo1Pu2LFALWzsvogt21cLEoQ1WoPkwUR/4WotG/IOYDa1qbLbASVTUiS/MsfqU0kjNb4/opUVs38JH+tXT1w5/IniW0821jtP70AV99ZjosaCoiw4O//HDBuXS8jh4XyG2hK5yOovCArg+LpRvnhNKjq2vPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sLHAa9x6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9MJsOEd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sLHAa9x6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9MJsOEd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CFB92115E;
	Fri,  3 Jan 2025 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735900934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miaBMrDkILlR6QAvtnUXCsuS5js5uoHgLUwGA1D1dIo=;
	b=sLHAa9x6I2OcZpMvldZJD7VoTbf7MBU+//arm2LcOPnwBrs921bOiYnbos+Sdt98lnNXUH
	RZpivnGpyUCREdu+r8yTl4Q70wFt/Tx+r3Yw3JADdGvuRk0VH837GbaXrrdNMiQUdZwszt
	myKwNenDMzDR3lJac3zY4kKzxJ4SWgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735900934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miaBMrDkILlR6QAvtnUXCsuS5js5uoHgLUwGA1D1dIo=;
	b=h9MJsOEdgckOQsPzzbXBGW6V5m85Bp3Nc+LIoa4zjf17MyLqaagU6lDTlvq2LHWh8EFUsL
	gZ0mbgaO4HMsZBAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sLHAa9x6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h9MJsOEd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735900934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miaBMrDkILlR6QAvtnUXCsuS5js5uoHgLUwGA1D1dIo=;
	b=sLHAa9x6I2OcZpMvldZJD7VoTbf7MBU+//arm2LcOPnwBrs921bOiYnbos+Sdt98lnNXUH
	RZpivnGpyUCREdu+r8yTl4Q70wFt/Tx+r3Yw3JADdGvuRk0VH837GbaXrrdNMiQUdZwszt
	myKwNenDMzDR3lJac3zY4kKzxJ4SWgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735900934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miaBMrDkILlR6QAvtnUXCsuS5js5uoHgLUwGA1D1dIo=;
	b=h9MJsOEdgckOQsPzzbXBGW6V5m85Bp3Nc+LIoa4zjf17MyLqaagU6lDTlvq2LHWh8EFUsL
	gZ0mbgaO4HMsZBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B9F0134E4;
	Fri,  3 Jan 2025 10:42:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CyM0Ega/d2d4IgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 10:42:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BED45A0844; Fri,  3 Jan 2025 11:42:13 +0100 (CET)
Date: Fri, 3 Jan 2025 11:42:13 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Christian Brauner <brauner@kernel.org>, sunyongjian1@huawei.com, Yang Erkun <yangerkun@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [BUG REPORT] ext4: =?utf-8?B?4oCcZXJyb3JzPXJlbW91bnQtcm/igJ0g?=
 =?utf-8?B?aGFzIGJlY29tZSDigJxlcnJvcnM9c2h1dGRvd27igJ0/?=
Message-ID: <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
X-Rspamd-Queue-Id: 5CFB92115E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CCed XFS and fsdevel list in case people have opinion what would be the
best interface to know the fs has shutdown]
 
On Fri 03-01-25 17:26:58, Baokun Li wrote:
> Hi Honza，
> 
> Happy New Year!

Thanks!

> On 2025/1/2 23:58, Jan Kara wrote:
> > On Mon 30-12-24 15:27:01, Baokun Li wrote:
> > > We reported similar issues to the community in 2020,
> > > https://lore.kernel.org/all/20210104160457.GG4018@quack2.suse.cz/
> > > Jan Kara provides a simple and effective patch. This patch somehow
> > > didn't end up merged into upstream, but this patch has been merged into
> > > our internal version for a couple years now and it works fine, is it
> > > possible to revert the patch that no longer sets SB_RDONLY and use
> > > the patch in the link above?
> > Well, the problem with filesystem freezing was just the immediate trigger
> > for the changes. But the setting of SB_RDONLY bit by ext4 behind the VFS'
> > back (as VFS is generally in charge of manipulating that bit and you must
> > hold s_umount for that which we cannot get in ext4 when handling errors)
> > was always problematic and I'm almost sure syzbot would find more problems
> > with that than just fs freezing. As such I don't think we should really
> > return to doing that in ext4 but we need to find other ways how to make
> > your error injection to work...
> I believe this is actually a bug in the evolution of the freeze
> functionality. In v2.6.35-rc1 with commit 18e9e5104fcd ("Introduce
> freeze_super and thaw_super for the fsfreeze ioctl"), the introduction
> of freeze_super/thaw_super did not cause any problems when setting the
> irreversible read-only (ro) bit without locking, because at that time
> we used the flag in sb->s_frozen to determine the file system's state.
> It was not until v4.3-rc1 with commit 8129ed29644b ("change sb_writers
> to use percpu_rw_semaphore") introduced locking into
> freeze_super/thaw_super that setting the irreversible ro without locking
> caused thaw_super to fail to release the locks that should have been
> released, eventually leading to hangs or other issues.
> 
> Therefore, I believe that the patch discussed in the previous link is
> the correct one, and it has a smaller impact and does not introduce any
> mechanism changes. Furthermore, after roughly reviewing the code using
> SB_RDONLY, I did not find any logic where setting the irreversible ro
> without locking could cause problems. If I have overlooked anything,
> please let me know.

Well, I don't remember the details but I think there were issues when
remount between ro/rw state raced with ext4 error setting the filesystem
read-only. ext4_remount() isn't really prepared for SB_RDONLY changing
under it and VFS could possibly get confused as well. Also if nothing else
the unlocked update (or the properly locked one!) to sb->s_flags can get
lost due to a racing read-modify-write cycle of sb->s_flags from other
process.

All these could possibly be fixed but in general it is a rather fragile
design that the SB_RDONLY flag can change under you at any moment.
Basically two following sb_rdonly() checks have to be prepared to get
different results regardless of locks they hold. And this is very easy to
forget. So I still think moving away from that is a good direction.

> > > What's worse is that after commit
> > >    95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
> > > was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
> > > ext4_handle_error(). This causes the file system to not be read-only
> > > when an error is triggered in "errors=remount-ro" mode, because
> > > EXT4_FLAGS_SHUTDOWN prevents both writing and reading.
> > Here I don't understand what is really the problem with EXT4_MF_FS_ABORTED
> > removal. What do you exactly mean by "causes the file system to not be
> > read-only"? We still return EROFS where we used to, we disallow writing as
> > we used to. Can you perhaps give an example what changed with this commit?
> Sorry for the lack of clarity in my previous explanation. The key point
> is not about removing EXT4_MF_FS_ABORTED, but rather we will set
> EXT4_FLAGS_SHUTDOWN bit, which not only prevents writes but also prevents
> reads. Therefore, saying it's not read-only actually means it's completely
> unreadable.

Ah, I see. I didn't think about that. Is it that you really want reading to
work from a filesystem after error? Can you share why (I'm just trying to
understand the usecase)? Or is this mostly a theoretical usecase?

I think we could introduce "shutdown modifications" state which would still
allow pure reads to succeed if there's a usecase for such functionality.

> > So how does your framework detect that the filesystem has failed with
> > errors=remount-ro? By parsing /proc/mounts or otherwise querying current
> > filesystem mount options?
> In most cases, run the mount command and filter related options.
> > Would it be acceptable for you to look at some
> > other mount option (e.g. "shutdown") to detect that state? We could easily
> > implement that.
> We do need to add a shutdown hint, but that's not the point.
> 
> We've discussed this internally, and now if the logs are flushed,
> we have no way of knowing if the current filesystem is shutdown. We don't
> know if the -EIO from the filesystem is a hardware problem or if the
> filesystem is already shutdown. So even if there is no current problem,
> we should add some kind of hint to let the user know that the current
> filesystem is shutdown.
> 
> The changes to display shutdown are as follows, so that we can see if the
> current filesystem has been shutdown in the mount command.

Yes, I think this would be a good addition regardless of other changes we
might need to do. It would be preferable to be able to come up with
something that's acceptable for querying of shutdown state also for other
filesystems - I've CCed fsdevel and XFS in particular since it has much
longer history of fs shutdown implementation.

								Honza

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 3955bec9245d..ba28ef0f662e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3157,6 +3157,9 @@ static int _ext4_show_options(struct seq_file *seq,
> struct super_block *sb,
>         if (nodefs && !test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
>                 SEQ_OPTS_PUTS("prefetch_block_bitmaps");
> 
> +       if (!nodefs && ext4_forced_shutdown(sb))
> +               SEQ_OPTS_PUTS("shutdown");
> +
>         ext4_show_quota_options(seq, sb);
>         return 0;
>  }
> > I'm sorry again for causing you trouble.
> 
> Never mind, thank you for your reply!
> 
> 
> Regards,
> Baokun
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

