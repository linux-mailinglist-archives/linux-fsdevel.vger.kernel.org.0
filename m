Return-Path: <linux-fsdevel+bounces-21112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0960B8FF1C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92328283070
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3F1991AB;
	Thu,  6 Jun 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZxP/pwjn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+pHhVxm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ku7WsUAF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ngZ6dvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F171990D1
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690226; cv=none; b=qCyveaXYauoy/0VGO0vGfHQu71rLt+U/2nV+czZFVjeGVSpmnkF/VcfRS9ZBIH8qyG57Y9DoJtp7QzKpShsrzD58VVzGolOX50/1uBz+wfb53tcsRiTB9oQpdengtbU3fFPR9JvUB6Esw7/nCXIMlqM3XS5cYh8/JD9/tl4zTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690226; c=relaxed/simple;
	bh=g/x4AhWAbTR/ZO0HdpbhxQfW1HVwjUt6UpPqUUOZJwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgbXR1bVEBZGpUMgFQT8wtQ63vYuHwSq9UbNAzZIza0gatA9R2o7zZl/QOCPsjqBS9tqI2SsTGV7kGW00VLFjsnhKGH4os6uIkYeX0c6DEjgAY15gfAS27r3odC0Noh3vQ8bFd2F/YgD0spq+E2BTPLYG1ToXkMYEb0sDVsfce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZxP/pwjn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+pHhVxm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ku7WsUAF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ngZ6dvX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B20CF21AFF;
	Thu,  6 Jun 2024 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717690222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+Fi+QJ7KUbRBwVKRWH+qTF8Sifv/Q3efkCPJTZir88=;
	b=ZxP/pwjnZC4P4aX3vZR6rX4/ri/bSpATvjS466492YYO1fFdHXrEJtBdJTI6Y3TDH3XxSz
	4myxDH0wUDXHHDxwOQn99+OCI42qIPByCP3/1RtrM15LKq0R+WXdzoM0qValpa+ab6z9bv
	DOBD23b1bZYYpt9IosDd6uu3Gtzg7fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717690222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+Fi+QJ7KUbRBwVKRWH+qTF8Sifv/Q3efkCPJTZir88=;
	b=1+pHhVxmxCIPjmCINL9cboAXkazgJ+q6puFH1XJI8sE7R+ygu7WoxvW3qHkCZ6O+P1ONGO
	nO9vcfQMt7HCuhAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ku7WsUAF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3ngZ6dvX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717690220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+Fi+QJ7KUbRBwVKRWH+qTF8Sifv/Q3efkCPJTZir88=;
	b=ku7WsUAF9GebXlNNijbqD4pMAlrvn3V+Kt340C9kdHgK9zCuKSiZwQiSwsiKGMO6J7CMvt
	1fpVTi5hy6mV5QnDdbsS56xbzL90ht1b4utfVY+BUiGq/eS0VtKuvWo/hwf7kAFnLD5b1R
	Bc/oxjHJjLiqElouMusTRZdPpXeLGHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717690220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+Fi+QJ7KUbRBwVKRWH+qTF8Sifv/Q3efkCPJTZir88=;
	b=3ngZ6dvXD1fFOnumhMLObGQheV4nhsD1THMNudjYEmcHZZPwwfnkn/n1nz7Wo0klQEbmuS
	ZQfmV9Ounjsm0DBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A67DC13A1E;
	Thu,  6 Jun 2024 16:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IpqiKGzfYWbzfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Jun 2024 16:10:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41687A0887; Thu,  6 Jun 2024 18:10:16 +0200 (CEST)
Date: Thu, 6 Jun 2024 18:10:16 +0200
From: Jan Kara <jack@suse.cz>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Is is reasonable to support quota in fuse?
Message-ID: <20240606161016.62eskqpsowwb5se2@quack3>
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
 <20240604092757.k5kkc67j3ssnc6um@quack3>
 <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
 <20240605102945.q4nu67xpdwfziiqd@quack3>
 <CAHB1NajZEy5kPXTcVu9G88WO-uZ5_Q6x3-EkFR4mfG0+XQWD3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NajZEy5kPXTcVu9G88WO-uZ5_Q6x3-EkFR4mfG0+XQWD3A@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B20CF21AFF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,szeredi.hu:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu 06-06-24 11:14:48, JunChao Sun wrote:
> Jan Kara <jack@suse.cz> 于2024年6月5日周三 18:29写道：
> >
> > On Tue 04-06-24 21:49:20, JunChao Sun wrote:
> > > Jan Kara <jack@suse.cz> 于2024年6月4日周二 17:27写道：
> > > > On Tue 04-06-24 14:54:01, JunChao Sun wrote:
> > > > > Miklos Szeredi <miklos@szeredi.hu> 于2024年6月4日周二 14:40写道：
> > > > > >
> > > > > > On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmail.com> wrote:
> > > > > >
> > > > > > > Given these challenges, I would like to inquire about the community's
> > > > > > > perspective on implementing quota functionality at the FUSE kernel
> > > > > > > part. Is it feasible to implement quota functionality in the FUSE
> > > > > > > kernel module, allowing users to set quotas for FUSE just as they
> > > > > > > would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> > > > > > > quotaset /mnt/fusefs)?  Would the community consider accepting patches
> > > > > > > for this feature?
> > > > > >
> > > > > >
> > > > > > > I would say yes, but I have no experience with quota in any way, so
> > > > > > > cannot help with the details.
> > > > >
> > > > > Thanks for your reply. I'd like try to implement this feature.
> > > >
> > > > Nice idea! But before you go and spend a lot of time trying to implement
> > > > something, I suggest that you write down a design how you imagine all this
> > > > to work and we can talk about it. Questions like: Do you have particular
> > > > usecases in mind? Where do you plan to perform the accounting /
> > > > enforcement? Where do you want to store quota information? How do you want
> > > > to recover from unclean shutdowns? Etc...
> > >
> > > Thanks a lot for your suggestions.
> > >
> > > I am reviewing the quota code of ext4 and the fuse code to determine
> > > if the implementation method used in ext4 can be ported to fuse. Based
> > > on my current understanding, the key issue is that ext4 reserves
> > > several inodes for quotas and can manage the disk itself, allowing it
> > > to directly flush quota data to the disk blocks corresponding to the
> > > quota inodes within the kernel.
> >
> > Yes.
> >
> > > However, fuse does not seem to manage
> > > the disk itself; it sends all read and write requests to user space
> > > for completion. Therefore, it may not be possible to directly flush
> > > the data in the quota inode to the disk in fuse.
> >
> > Yes, ext4 uses journalling to keep filesystem state consistent with quota
> > information. Doing this within FUSE would be rather difficult (essentially
> > you would have to implement journal within FUSE with will have rather high
> > performace overhead).
> >
> >
> > > But that's why I'm asking for usecases. For some usecases it may be fine
> > > that in case of unclean shutdown you run quotacheck program to update quota
> > > information based on current usage - non-journalling filesystems use this
> > > method. So where do you want to use quotas on a FUSE filesystem?
> 
> Please allow me to ask a silly question. I'm not sure if I correctly
> understand what you mean by 'unclean shutdown'. Do you mean an
> inconsistent state that requires using fsck to repair, like in ext4
> after a sudden power loss, or is it something else only about quota?

No, I mean cases like sudden power loss or kernel crash or similar. However
note that journalling filesystems (such as ext4 or xfs or many others) do
not require fsck after such event. The journal allows them to recover
automatically.

> In my scenario, FUSE (both the kernel and user space parts) acts
> merely as a proxy. FUSE is based on multiple file systems, and a
> user's file and directory exists in only one of these file systems. It
> does not even have its own superblock or inode metadata. When a user
> performs read or write operations on a specific file, FUSE checks the
> directory corresponding to this file on each file system to see if the
> user's file is there; if one is not, it continues to check the next
> file system.

I see. So your usecase is kind of a filesystem unioning solution and you
want to add quotas on top of that?
 
> > > I am considering whether it would be feasible to implement the quota
> > > inode in user space in a similar manner. For example, users could
> > > reserve a few regular files that are invisible to actual file system
> > > users to store the contents of quota. When updating the quota, the
> > > user would be notified to flush the quota data to the disk. The
> > > benefit of this approach is that it can directly reuse the quota
> > > metadata format from the kernel, users do not need to redesign
> > > metadata. However, performance might be an issue with this approach.
> >
> > Yes, storing quota data in some files inside the filesystem is probably the
> > easiest way to go. I'd just not bother with flushing because as you say
> > the performance would suck in that case.
> 
> What about using caching and asynchronous updates? For example, in
> FUSE, allocate some pages to cache the quota data. When updating quota
> data, write to the cache first and then place the task in a work
> queue. The work queue will then send the request to user space to
> complete the actual disk write operation. When there are read
> requests, the content is read directly from the cache.

So how quota works for filesystems without journaling is that we keep quota
information for cached inodes in memory (struct dquot - this is per ID
(uid/gid/projid) structure). The quota information is written back to quota
file on events like sync(2) (which also handles unmount) or when last inode
referencing particular dquot structure is reclaimed from memory. There is
no periodic background writeback for quota structures.

> The problem with this approach is that asynchronous updates might lead
> to loss of quota data in the event of a sudden power failure. This
> seems acceptable to me, but I am not sure if it aligns with the
> definition of quota. Additionally, this assumes that the quota file
> will not be very large, which I believe is a reasonable
> assumption.Perhaps there are some drawbacks I haven't considered?

Yes, quota files are pretty small (for today's standards) as they scale
with the number of filesystem users which isn't generally too big. As you
observe, quota information will not be uptodate in the event of powerfail
or similar. That is the reason why administrator (or init scripts) are
responsible for calling quotacheck(8) for filesystems when unclean shutdown
is detected. Quotacheck(8) scans the whole filesystem, summarizes disk
usage for each user, group, etc. and updates the information in the quota
file.

> Regarding the enforcement of quota limits, I plan to perform this in
> the kernel. For project quotas, the kernel can know how much space and
> how many inodes are being used by the corresponding project ID. For
> now, I only want to implement project quota because I believe that
> user and group quotas can be simulated using project quotas.

This is not true. First and formost, owner of a file can arbitrarily change
its projid while unpriviledged user cannot set file's owner. So there is no
way for user to escape user quota accounting while project quota accounting
is more or less cooperative space tracking feature (this is different with
user namespaces but your usecase does not sound like it depends on them).
Similarly file's group can be set only to groups user is a member of.
Finally you can have smaller user limits and bigger group limits which
constrain a group of users which is not possible to do just with project
quotas.

> Additionally, users' definitions of file system users and groups might
> differ from file UID and GID. Users can freely use project IDs to
> define file system users and groups.

Well, if UIDs in the filesystem do not match current system view of users,
you have a larger problem be permission checking etc. So I'm not sure I
understand your comment here. But anyway if you are convinced project
quotas are the right solution for your usecase then I don't object. From
kernel POV there's no fundamental difference.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

