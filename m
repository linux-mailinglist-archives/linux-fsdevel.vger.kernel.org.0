Return-Path: <linux-fsdevel+bounces-36462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C766A9E3D41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D200CB29A93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C900D1FDE2A;
	Wed,  4 Dec 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QwVOoBAr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+LOObUuD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QwVOoBAr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+LOObUuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC7198A05;
	Wed,  4 Dec 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321789; cv=none; b=J2YdmHIrArro6Z8mo1wEQHR4xLjkuQs41GeoaQSOfLQLOJfaFIIDBcO1WsJzJJ5F+1d98mbX/+q9mP1I7ewSCatA5NQzz/jpKvgcALD+KdoPMUletJwkUZpJbwOeH40ng2mPbi1WEpupjCx021d39eu3+coz9pKuvBjakWW0ec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321789; c=relaxed/simple;
	bh=2NphvdYGP+L8TFS0HvJb+8sv55gVIVlXhNiYd4mpN4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXD+i8jANayF4sRu8Ap0se7QnGfZXBB7URbolGgBUOpNA7Q14LIgQa65K1AN51iOdEzkpy6GNlwvY5DTiIw3deY+NIPDF0y8AAVnWx6xQcxFtjWLJNF2fvB/stYsheDuHqakTZ/qrhL5jSSGpeWf769TRF3oRdNDz/zh/SSUIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QwVOoBAr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+LOObUuD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QwVOoBAr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+LOObUuD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EBC21F45E;
	Wed,  4 Dec 2024 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733321785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVkF49mdhG2bNkwqIFQoszmuhSLJBjghgd/zVPLuZAk=;
	b=QwVOoBArMEYC4SsZ8VqzQpiUpwxzfI5bGUtLBplUQnKzf3DYAkGo+i4oIVIlnum0o7NWTI
	iATaeaXNdPz0QMKOJiX+589fT7gIWpG1swRwRXr+IWejfqiIbbapgROiKnmhpwiWJurr1D
	3oV/O2qCDuaYAHVby7dcb6/vvdsI4IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733321785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVkF49mdhG2bNkwqIFQoszmuhSLJBjghgd/zVPLuZAk=;
	b=+LOObUuDLjZ5NFPY3efFduuyFwRPImtJAH+iKR7BVOhkXpKkIICA1QEwDcZMZz1hzFnQN8
	+nLSy+NDGepJ/2AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QwVOoBAr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+LOObUuD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733321785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVkF49mdhG2bNkwqIFQoszmuhSLJBjghgd/zVPLuZAk=;
	b=QwVOoBArMEYC4SsZ8VqzQpiUpwxzfI5bGUtLBplUQnKzf3DYAkGo+i4oIVIlnum0o7NWTI
	iATaeaXNdPz0QMKOJiX+589fT7gIWpG1swRwRXr+IWejfqiIbbapgROiKnmhpwiWJurr1D
	3oV/O2qCDuaYAHVby7dcb6/vvdsI4IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733321785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVkF49mdhG2bNkwqIFQoszmuhSLJBjghgd/zVPLuZAk=;
	b=+LOObUuDLjZ5NFPY3efFduuyFwRPImtJAH+iKR7BVOhkXpKkIICA1QEwDcZMZz1hzFnQN8
	+nLSy+NDGepJ/2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A0CB1396E;
	Wed,  4 Dec 2024 14:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W8TiBTlkUGcPSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 14:16:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ADEECA0918; Wed,  4 Dec 2024 15:16:20 +0100 (CET)
Date: Wed, 4 Dec 2024 15:16:20 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, agruenba@redhat.com,
	gfs2@lists.linux.dev, amir73il@gmail.com, mic@digikod.net,
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-security-module@vger.kernel.org,
	yebin10@huawei.com, zhangxiaoxu5@huawei.com,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 10/11] fs: fix hungtask due to repeated traversal of
 inodes list
Message-ID: <20241204141620.vgklclfh5guezcvb@quack3>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
 <20241118114508.1405494-11-yebin@huaweicloud.com>
 <20241204-worden-tontechnik-3ce77e9f3bad@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-worden-tontechnik-3ce77e9f3bad@brauner>
X-Rspamd-Queue-Id: 2EBC21F45E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huaweicloud.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.dk,redhat.com,lists.linux.dev,gmail.com,digikod.net,google.com,paul-moore.com,namei.org,hallyn.com,huawei.com,fromorbit.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 04-12-24 12:17:49, Christian Brauner wrote:
> On Mon, Nov 18, 2024 at 07:45:07PM +0800, Ye Bin wrote:
> > From: Ye Bin <yebin10@huawei.com>
> > 
> > There's a issue when remove scsi disk, the invalidate_inodes() function
> > cannot exit for a long time, then trigger hungtask:
> > INFO: task kworker/56:0:1391396 blocked for more than 122 seconds.
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > Workqueue: events_freezable virtscsi_handle_event [virtio_scsi]
> > Call Trace:
> >  __schedule+0x33c/0x7f0
> >  schedule+0x46/0xb0
> >  schedule_preempt_disabled+0xa/0x10
> >  __mutex_lock.constprop.0+0x22b/0x490
> >  mutex_lock+0x52/0x70
> >  scsi_scan_target+0x6d/0xf0
> >  virtscsi_handle_event+0x152/0x1a0 [virtio_scsi]
> >  process_one_work+0x1b2/0x350
> >  worker_thread+0x49/0x310
> >  kthread+0xfb/0x140
> >  ret_from_fork+0x1f/0x30
> > 
> > PID: 540499  TASK: ffff9b15e504c080  CPU: 44  COMMAND: "kworker/44:0"
> > Call trace:
> >  invalidate_inodes at ffffffff8f3b4784
> >  __invalidate_device at ffffffff8f3dfea3
> >  invalidate_partition at ffffffff8f526b49
> >  del_gendisk at ffffffff8f5280fb
> >  sd_remove at ffffffffc0186455 [sd_mod]
> >  __device_release_driver at ffffffff8f738ab2
> >  device_release_driver at ffffffff8f738bc4
> >  bus_remove_device at ffffffff8f737f66
> >  device_del at ffffffff8f73341b
> >  __scsi_remove_device at ffffffff8f780340
> >  scsi_remove_device at ffffffff8f7803a2
> >  virtscsi_handle_event at ffffffffc017204f [virtio_scsi]
> >  process_one_work at ffffffff8f1041f2
> >  worker_thread at ffffffff8f104789
> >  kthread at ffffffff8f109abb
> >  ret_from_fork at ffffffff8f001d6f
> > 
> > As commit 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
> > introduces the retry logic. In the problem environment, the 'i_count'
> > of millions of files is not zero. As a result, the time slice for each
> > traversal to the matching inode process is almost used up, and then the
> > traversal is started from scratch. The worst-case scenario is that only
> > one inode can be processed after each wakeup. Because this process holds
> > a lock, other processes will be stuck for a long time, causing a series
> > of problems.
> > To solve the problem of repeated traversal from the beginning, each time
> > the CPU needs to be freed, a cursor is inserted into the linked list, and
> > the traversal continues from the cursor next time.
> > 
> > Fixes: 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  fs/inode.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index dc966990bda6..b78895af8779 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -857,11 +857,16 @@ static void dispose_list(struct list_head *head)
> >  void evict_inodes(struct super_block *sb)
> >  {
> >  	struct inode *inode, *next;
> > +	struct inode cursor;
> 
> It seems pretty adventurous to me to just add in a random inode whose
> only fiels that is initialized is i_state. That would need a proper
> analysis and argument that this is safe to do and won't cause trouble
> for any filesystem.
> 
> Jan, do you have thoughts on this?

Yeah, I think in the current state where there are several instances of
hand-crafted inode iteration code it is somewhat fragile to use the cursor
approach. I was staying silent because I was hoping Dave Chinner's patches
to clean up inode iteration get to a more ready state. Then either we have
well consolidated inode iteration code so additions like this can be easily
verified for correctness or we could even get as far as removing
sb->s_inodes list altogether as Dave outlined [1] which would nicely deal
with the issue solved here as well. Sadly that patch series seems to have
lost traction. Hopefully we can either revive it or at least scavenge the
nice preparatory cleanups...

								Honza

[1] https://lore.kernel.org/all/ZwRvshM65rxXTwxd@dread.disaster.area
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

