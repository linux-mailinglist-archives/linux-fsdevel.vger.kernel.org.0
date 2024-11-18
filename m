Return-Path: <linux-fsdevel+bounces-35101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246839D10FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 13:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABFA282F3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58E199EA1;
	Mon, 18 Nov 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcBwdbcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Pj6kFwX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xbPLruUq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9BYL6XBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D543173;
	Mon, 18 Nov 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934428; cv=none; b=g+9x0/sT46aejbauF2ILJXCe3woflnsPifjoi8m5KNwkUQSnmCEEHiAU2GGf+4onIyp+uiICVB0TFKOtrMAs1WsxBqZfdksC8+TNrvm4eA+uedTYiLmjHOnydaB4D5HnJ3qmyLrljW68cvLgi84usBW9DAjkko0gnAwtRbupTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934428; c=relaxed/simple;
	bh=7HUMOs0Yn6bQypZmiDJ12CLfjTG3zCZf7cLGa2kD+lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIUdKjXkOB7C1Ia8hCvW+b0IYOK+9xwA50FBkOcSXUNBdNldY0rLMKQ/bcVHRfD921zszepsMH5apuCho+1mi+gOMUAK7GhZrOmPWt4L4gzKiVGTEZ9g+CCBTKpijCm6D5HJ2sfJADHJ9ef1YMzwYwLCh8GF8v2vPMybtZ0qcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcBwdbcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Pj6kFwX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xbPLruUq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9BYL6XBF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4B151F441;
	Mon, 18 Nov 2024 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731934425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUIJyzl8hMjBfg4z8m29f4cxyc5jxiPHUIR7lmr+4lQ=;
	b=mcBwdbcVtWdj2aaHW/AfNmz4DNQdhKooY7WI6EFZqj/YLUW8RxVen0mXyZT2ovqI5u8Y8x
	iUX/RmXyturbwNo3AJRy/gSIPKcE9AjJeOfA+zxdm7nT8kYop1bfublAxt9YUC1rUlXFYY
	s7wDPBsRT36WkZn0JxNXDscwDU38k8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731934425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUIJyzl8hMjBfg4z8m29f4cxyc5jxiPHUIR7lmr+4lQ=;
	b=8Pj6kFwXdMgyq5hrhOww0NEWsf1na1FzjUo9JkCS4/2Xr4mpUx6ApZAwUj5EEFpVYS3p7V
	LVH5xVEqNKaOpCCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xbPLruUq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9BYL6XBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731934424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUIJyzl8hMjBfg4z8m29f4cxyc5jxiPHUIR7lmr+4lQ=;
	b=xbPLruUqRQwFQ0nwxlC9DaP7XjqbbIuJSV5f8Wp5COH2vK8UQ/RyssrD4XfNJ5KZXBKpe6
	oDdY7glW7f+NJkkYECYN9s6iRb907QLfZR/8TWGesCwi2hBACQJhx3Hp7gOozWSat2No89
	RA+EnAbGzheCPfTQVeWcFo5Q0b26QHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731934424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUIJyzl8hMjBfg4z8m29f4cxyc5jxiPHUIR7lmr+4lQ=;
	b=9BYL6XBF/IAA1M7AkiEXzZHrJxzUBe30svzZZb3UvO26HYmNfOAI2ZdzYBBDUo4Df49qcC
	+fqxEGRx1uJIhVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C94261376E;
	Mon, 18 Nov 2024 12:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pD8dMdg4O2efWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 12:53:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 834EBA0984; Mon, 18 Nov 2024 13:53:44 +0100 (CET)
Date: Mon, 18 Nov 2024 13:53:44 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>,
	Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
Message-ID: <20241118125344.a3n3kn6crvrixglb@quack3>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
 <20241115183449.2058590-2-ojaswin@linux.ibm.com>
 <87plmwcjcd.fsf@gmail.com>
 <ZzjdggicyuGqaVs8@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <7077c905-2a19-46f2-9f45-d82ed673d48b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7077c905-2a19-46f2-9f45-d82ed673d48b@huawei.com>
X-Rspamd-Queue-Id: D4B151F441
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,gmail.com,vger.kernel.org,suse.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 18-11-24 09:29:19, Baokun Li wrote:
> On 2024/11/17 1:59, Ojaswin Mujoo wrote:
> > On Sat, Nov 16, 2024 at 02:20:26AM +0530, Ritesh Harjani wrote:
> > > Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > > 
> > > > One of the paths quota writeback is called from is:
> > > > 
> > > > freeze_super()
> > > >    sync_filesystem()
> > > >      ext4_sync_fs()
> > > >        dquot_writeback_dquots()
> > > > 
> > > > Since we currently don't always flush the quota_release_work queue in
> > > > this path, we can end up with the following race:
> > > > 
> > > >   1. dquot are added to releasing_dquots list during regular operations.
> > > >   2. FS freeze starts, however, this does not flush the quota_release_work queue.
> > > >   3. Freeze completes.
> > > >   4. Kernel eventually tries to flush the workqueue while FS is frozen which
> > > >      hits a WARN_ON since transaction gets started during frozen state:
> > > > 
> > > >    ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
> > > >    __ext4_journal_start_sb+0x64/0x1c0 [ext4]
> > > >    ext4_release_dquot+0x90/0x1d0 [ext4]
> > > >    quota_release_workfn+0x43c/0x4d0
> > > > 
> > > > Which is the following line:
> > > > 
> > > >    WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> > > > 
> > > > Which ultimately results in generic/390 failing due to dmesg
> > > > noise. This was detected on powerpc machine 15 cores.
> > > > 
> > > > To avoid this, make sure to flush the workqueue during
> > > > dquot_writeback_dquots() so we dont have any pending workitems after
> > > > freeze.
> > > Not just that, sync_filesystem can also be called from other places and
> > > quota_release_workfn() could write out and and release the dquot
> > > structures if such are found during processing of releasing_dquots list.
> > > IIUC, this was earlier done in the same dqput() context but had races
> > > with dquot_mark_dquot_dirty(). Hence the final dqput() will now add the
> > > dquot structures to releasing_dquots list and will schedule a delayed
> > > workfn which will process the releasing_dquots list.
> > Hi Ritesh,
> > 
> > Ohh right, thanks for the context. I see this was done here:
> > 
> >    dabc8b207566 quota: fix dqput() to follow the guarantees dquot_srcu
> >    should provide

Yup.

> Nice catch! Thanks for fixing this up!
> 
> Have you tested the performance impact of this patch? It looks like the
> unconditional call to flush_delayed_work() in dquot_writeback_dquots()
> may have some performance impact for frequent chown/sync scenarios.

Well, but sync(2) or so is expensive anyway. Also dquot_writeback_dquots()
should persist all pending quota modifications and it is true that pending
dquot_release() calls can remove quota structures from the quota file and
thus are by definition pending modifications. So I agree with Ojaswin that
putting the workqueue flush there makes sense and is practically required
for data consistency guarantees.

> When calling release_dquot(), we will only remove the quota of an object
> (user/group/project) from disk if it is not quota-limited and does not
> use any inode or block.
> 
> Asynchronous removal is now much more performance friendly, not only does
> it make full use of the multi-core, but for scenarios where we have to
> repeatedly chown between two objects, delayed release avoids the need to
> repeatedly allocate/free space in memory and on disk.

True, but unless you call sync(2) in between these two calls this is going
to still hold.

> Overall, since the actual dirty data is already on the disk, there is no
> consistency issue here as it is just clearing unreferenced quota on the
> disk, so I thought maybe it would be better to call flush_delayed_work()
> in the freeze context.

To summarise, I don't think real-life workloads are going to observe the
benefit and conceptually the call really belongs more to
dquot_writeback_dquots().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

