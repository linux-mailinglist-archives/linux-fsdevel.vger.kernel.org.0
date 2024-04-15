Return-Path: <linux-fsdevel+bounces-16961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BC8A57A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 18:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA46E1C23004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F380C04;
	Mon, 15 Apr 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6OsQ5WJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZEE3JAn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cMYxHnXv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zkm/33Kc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A480055;
	Mon, 15 Apr 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198141; cv=none; b=ZupKpTZlz8GZo39cPBj/vdaqZSh5GXQz0vteXQsG3SgcXdsh9GsVywFw7C+3Y7gwL/t7QI6LWhE2LBdnjfK9w9kDYeAPwRFuUX1TtluNy1T55aE+uXt3j7lup7rgn5itr6y5rrUiqh1krA5yIhD32z6n7DDyXMoJ9bGy3IdwysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198141; c=relaxed/simple;
	bh=4D7YDo8WyLmas+2iL6PKKZth++C7DB2cOeWPTEnBO8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKpYj5m3CoqlpkYQgfFfGb6UUaJeXi1yduUG5VrxU57Z5wfFzMlrDkoBZ2eqBjTglffsGmbL7BA5plsS9MZmj87XWouVBZo1UzuluPM5LrVSUGIK//RgvnWn/3+vQG9ZbobMcWVgzKUmGAK3e2ZzqJ1Cssrde4vOmpRH15gGGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6OsQ5WJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZEE3JAn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cMYxHnXv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zkm/33Kc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4625D5D203;
	Mon, 15 Apr 2024 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713198136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSFrElYhgRSxGTyq+kKn6PgXtDmzDwIL8wSe3ioMwc=;
	b=Y6OsQ5WJbv6aFy82vuJvCMuOTxmiiv5gatgGv+Kf1kiGlrFwsKx2gqCAp03Kl+eKPd8BQZ
	fMHytzp9eSBIPSbM53ZDloxN05uLcaQxdcsuzwv62lqxGLy4xNsdQLSep73+yfoXG8I5af
	gBiqkM9eJQE4073veaQ+exPnRUGMPSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713198136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSFrElYhgRSxGTyq+kKn6PgXtDmzDwIL8wSe3ioMwc=;
	b=1ZEE3JAnqpMeoktivS9Babk+35pFmM/7874hVi1oHWKGaHFUewffrqiUwxkRnuJHHb4NvG
	mAO+zlkD68Uve/CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cMYxHnXv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Zkm/33Kc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713198135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSFrElYhgRSxGTyq+kKn6PgXtDmzDwIL8wSe3ioMwc=;
	b=cMYxHnXv9AqOloP1WsxLgQjXRywuHpytX9GUKA2Z8IzNAKjPWUsMdsas3doaeZf5tgoT1O
	4ijaJRCqX/LdSVZBDP6oEI0r4Q2N/BUys+xNS/svTOQ12E4EgUXJmY4BYjFaZTyxrxNVxR
	4uTNq1NhdYCNWvy+N2xruiGCmSRkSTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713198135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vSFrElYhgRSxGTyq+kKn6PgXtDmzDwIL8wSe3ioMwc=;
	b=Zkm/33KcWUHUv2Et6sZG9T7SdR93mDi0SpKtS34tXHTrL5k2wz2ZBhTJrvC31pIveLeCyM
	qrBClf89SSqzZLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32F941386E;
	Mon, 15 Apr 2024 16:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +kRsDDdUHWbGTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Apr 2024 16:22:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C955BA0817; Mon, 15 Apr 2024 18:22:10 +0200 (CEST)
Date: Mon, 15 Apr 2024 18:22:10 +0200
From: Jan Kara <jack@suse.cz>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <20240415162210.zyoolbj27usnhk56@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
 <Zhzyu6pQYkSNgvuh@fedora>
 <20240415-haufen-demolieren-8c6da8159586@brauner>
 <Zh07Sc3lYStOWK8J@fedora>
 <20240415-neujahr-schummeln-c334634ab5ad@brauner>
 <Zh1Dtvs8nst9P4J2@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh1Dtvs8nst9P4J2@fedora>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4625D5D203
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Mon 15-04-24 23:11:50, Ming Lei wrote:
> On Mon, Apr 15, 2024 at 04:53:42PM +0200, Christian Brauner wrote:
> > On Mon, Apr 15, 2024 at 10:35:53PM +0800, Ming Lei wrote:
> > > On Mon, Apr 15, 2024 at 02:35:17PM +0200, Christian Brauner wrote:
> > > > On Mon, Apr 15, 2024 at 05:26:19PM +0800, Ming Lei wrote:
> > > > > Hello,
> > > > > 
> > > > > On Tue, Jan 23, 2024 at 02:26:21PM +0100, Christian Brauner wrote:
> > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > ---
> > > > > >  drivers/md/dm.c               | 23 +++++++++++++----------
> > > > > >  drivers/md/md.c               | 12 ++++++------
> > > > > >  drivers/md/md.h               |  2 +-
> > > > > >  include/linux/device-mapper.h |  2 +-
> > > > > >  4 files changed, 21 insertions(+), 18 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > > > index 8dcabf84d866..87de5b5682ad 100644
> > > > > > --- a/drivers/md/dm.c
> > > > > > +++ b/drivers/md/dm.c
> > > > > 
> > > > > ...
> > > > > 
> > > > > > @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
> > > > > >  {
> > > > > >  	if (md->disk->slave_dir)
> > > > > >  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> > > > > > -	bdev_release(td->dm_dev.bdev_handle);
> > > > > > +	fput(td->dm_dev.bdev_file);
> > > > > 
> > > > > The above change caused regression on 'dmsetup remove_all'.
> > > > > 
> > > > > blkdev_release() is delayed because of fput(), so dm_lock_for_deletion
> > > > > returns -EBUSY, then this dm disk is skipped in remove_all().
> > > > > 
> > > > > Force to mark DMF_DEFERRED_REMOVE might solve it, but need our device
> > > > > mapper guys to check if it is safe.
> > > > > 
> > > > > Or other better solution?
> > > > 
> > > > Yeah, I think there is. You can just switch all fput() instances in
> > > > device mapper to bdev_fput() which is mainline now. This will yield the
> > > > device and make it able to be reclaimed. Should be as simple as the
> > > > patch below. Could you test this and send a patch based on this (I'm on
> > > > a prolonged vacation so I don't have time right now.):
> > > 
> > > Unfortunately it doesn't work.
> > > 
> > > Here the problem is that blkdev_release() is delayed, which changes
> > > 'dmsetup remove_all' behavior, and causes that some of dm disks aren't
> > > removed.
> > > 
> > > Please see dm_lock_for_deletion() and dm_blk_open()/dm_blk_close().
> > 
> > So you really need blkdev_release() itself to be synchronous? Groan, in
> 
> At least the current dm implementation relies on this way sort of, and
> it could be addressed by forcing to mark DMF_DEFERRED_REMOVE in
> remove_all().
> 
> > that case use __fput_sync() instead of fput() which ensures that this
> > file is closed synchronously.
> 
> I tried __fput_sync(), but the following panic is caused:
> 
> [  113.486522] ------------[ cut here ]------------
> [  113.486524] kernel BUG at fs/file_table.c:453!
> [  113.486531] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [  113.488878] CPU: 6 PID: 1919 Comm: dmsetup Kdump: loaded Not tainted 5.14.0+ #23

Wait, how come this is 5.14 kernel? Apparently you're crashing on:

BUG_ON(!(task->flags & PF_KTHREAD));

but that is not present in current upstream (BUG_ON was removed in 6.6-rc1
by commit 021a160abf62c).

								Honza

> [  113.490114] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> [  113.491661] RIP: 0010:__fput_sync+0x25/0x30
> [  113.492562] Code: 90 90 90 90 90 0f 1f 44 00 00 f0 48 ff 4f 38 75 14 65 48 8b 04 25 40 25 03 00 f6 40 36 20 74 0a e9 20 fd ff ff c3 cc cc cc cc <0f0
> [  113.493926] RSP: 0018:ffffb76581003c20 EFLAGS: 00010246
> [  113.494220] RAX: ffff92eca6ef8000 RBX: ffff92ed176c3c18 RCX: 000000008080007c
> [  113.494632] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff92ec844cac00
> [  113.495033] RBP: ffff92ed176c3c00 R08: 0000000000000001 R09: 0000000000000000
> [  113.495378] R10: ffffb76581003b00 R11: ffffb76581003b68 R12: ffff92ec8fccec20
> [  113.495723] R13: ffff92ec8431b400 R14: ffff92ec8431b508 R15: ffff92ec8fccec00
> [  113.496108] FS:  00007f5be5638840(0000) GS:ffff92f0ebb80000(0000) knlGS:0000000000000000
> [  113.496581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  113.496907] CR2: 00007f5be54694b0 CR3: 0000000108e54003 CR4: 0000000000770ef0
> [  113.497308] PKRU: 55555554
> [  113.497469] Call Trace:
> [  113.497613]  <TASK>
> [  113.497741]  ? show_trace_log_lvl+0x1c4/0x2df
> [  113.497997]  ? show_trace_log_lvl+0x1c4/0x2df
> [  113.498251]  ? dm_put_table_device+0x64/0xd0 [dm_mod]
> [  113.498553]  ? __die_body.cold+0x8/0xd
> [  113.498768]  ? die+0x2b/0x50
> [  113.498937]  ? do_trap+0xce/0x120
> [  113.499129]  ? __fput_sync+0x25/0x30
> [  113.499337]  ? do_error_trap+0x65/0x80
> [  113.499577]  ? __fput_sync+0x25/0x30
> [  113.499787]  ? exc_invalid_op+0x4e/0x70
> [  113.500011]  ? __fput_sync+0x25/0x30
> [  113.500239]  ? asm_exc_invalid_op+0x16/0x20
> [  113.500842]  ? __fput_sync+0x25/0x30
> [  113.501387]  dm_put_table_device+0x64/0xd0 [dm_mod]
> [  113.502047]  dm_put_device+0x80/0x110 [dm_mod]
> [  113.502650]  stripe_dtr+0x2f/0x50 [dm_mod]
> [  113.503218]  dm_table_destroy+0x59/0x120 [dm_mod]
> [  113.503842]  __dm_destroy+0x114/0x1e0 [dm_mod]
> [  113.504402]  dm_hash_remove_all+0x63/0x160 [dm_mod]
> [  113.505028]  remove_all+0x1e/0x30 [dm_mod]
> [  113.505602]  ctl_ioctl+0x19f/0x290 [dm_mod]
> [  113.506146]  dm_ctl_ioctl+0xa/0x20 [dm_mod]
> [  113.506717]  __x64_sys_ioctl+0x87/0xc0
> [  113.507230]  do_syscall_64+0x5c/0xf0
> [  113.507755]  ? exc_page_fault+0x62/0x150
> [  113.508309]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [  113.508945] RIP: 0033:0x7f5be543ec6b
> 
> 
> 
> Thanks. 
> Ming
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

