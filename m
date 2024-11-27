Return-Path: <linux-fsdevel+bounces-35975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813389DA77E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06881B21623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092D1FA257;
	Wed, 27 Nov 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BkWU+T40";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PmsVLffv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BkWU+T40";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PmsVLffv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC421FA17F;
	Wed, 27 Nov 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708964; cv=none; b=dgqwnnmRPTabB74Zabe7gRZgbm5DCFuB9Etc1emmfMK6hpjIat1GhUnSe1Qd4bGj31ItU5VoBA6XjJCUZNCqMNPI0NWQAsxan9qdAdtYgofkxt6z7HqEgcUBi8LDVmLDNWjsu3L3WZ8dXqN/6SJY0pbgViJLiCxqUXdE5cy5jH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708964; c=relaxed/simple;
	bh=aOL4M8DLYUedNI0OP5gYrOnKNvDjqHbyv4TwLm4YOV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qvonav15cAsgM28mWcFgsGdLgQuCb0ZE2PxZx3OAGqbrFQu7bDXcY7EZX09+c4h5AuLLIxUzqzMcf08PSNj9J7PGxehE5l8JbBzLLOJuEPBHi7fAgENjwtiPSEqAPuOvXhutz66cZFJKfNoI6NgXOUuWIbDm1tKv7UosGKGqFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BkWU+T40; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PmsVLffv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BkWU+T40; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PmsVLffv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F1481F770;
	Wed, 27 Nov 2024 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732708959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKCN/jjYz46d2mr96flpQkyS6oKGUlfViaa4MefoOdQ=;
	b=BkWU+T40OTcpiOFVAuI8IgBkC8saI0/2jmRdJ2R//RCJ1+hd8Wf+QkoltRT5t2fkHPn/kE
	CUUCoXnm8CvM0XgQjWxypt3xn7R6olWvjXYBTMZ1ryilDD+Qu1iPaAUIIwdZgtuVjTNjkA
	SowtW4vkeBxxfNCkOgkj8Za7o2maTds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732708959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKCN/jjYz46d2mr96flpQkyS6oKGUlfViaa4MefoOdQ=;
	b=PmsVLffvB/Rc/f8b2X9VpJrTjNhOWn5YpTQ8kOpYTJ8MT8ECEHCU+88zhzlqtFto0z4X7L
	0AZRivafKLrpRvAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BkWU+T40;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PmsVLffv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732708959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKCN/jjYz46d2mr96flpQkyS6oKGUlfViaa4MefoOdQ=;
	b=BkWU+T40OTcpiOFVAuI8IgBkC8saI0/2jmRdJ2R//RCJ1+hd8Wf+QkoltRT5t2fkHPn/kE
	CUUCoXnm8CvM0XgQjWxypt3xn7R6olWvjXYBTMZ1ryilDD+Qu1iPaAUIIwdZgtuVjTNjkA
	SowtW4vkeBxxfNCkOgkj8Za7o2maTds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732708959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKCN/jjYz46d2mr96flpQkyS6oKGUlfViaa4MefoOdQ=;
	b=PmsVLffvB/Rc/f8b2X9VpJrTjNhOWn5YpTQ8kOpYTJ8MT8ECEHCU+88zhzlqtFto0z4X7L
	0AZRivafKLrpRvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E908139AA;
	Wed, 27 Nov 2024 12:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gor2Gl8KR2dAagAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 Nov 2024 12:02:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 27D23A08D6; Wed, 27 Nov 2024 13:02:35 +0100 (CET)
Date: Wed, 27 Nov 2024 13:02:35 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Bharata B Rao <bharata@amd.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nikunj@amd.com, willy@infradead.org,
	vbabka@suse.cz, david@redhat.com, akpm@linux-foundation.org,
	yuzhao@google.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, joshdon@google.com, clm@meta.com
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
Message-ID: <20241127120235.ejpvpks3fosbzbkr@quack3>
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
X-Rspamd-Queue-Id: 7F1481F770
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 27-11-24 07:19:59, Mateusz Guzik wrote:
> On Wed, Nov 27, 2024 at 7:13 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Wed, Nov 27, 2024 at 6:48 AM Bharata B Rao <bharata@amd.com> wrote:
> > >
> > > Recently we discussed the scalability issues while running large
> > > instances of FIO with buffered IO option on NVME block devices here:
> > >
> > > https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
> > >
> > > One of the suggestions Chris Mason gave (during private discussions) was
> > > to enable large folios in block buffered IO path as that could
> > > improve the scalability problems and improve the lock contention
> > > scenarios.
> > >
> >
> > I have no basis to comment on the idea.
> >
> > However, it is pretty apparent whatever the situation it is being
> > heavily disfigured by lock contention in blkdev_llseek:
> >
> > > perf-lock contention output
> > > ---------------------------
> > > The lock contention data doesn't look all that conclusive but for 30% rwmixwrite
> > > mix it looks like this:
> > >
> > > perf-lock contention default
> > >  contended   total wait     max wait     avg wait         type   caller
> > >
> > > 1337359017     64.69 h     769.04 us    174.14 us     spinlock   rwsem_wake.isra.0+0x42
> > >                         0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
> > >                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
> > >                         0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
> > >                         0xffffffff8f39e88f  up_write+0x4f
> > >                         0xffffffff8f9d598e  blkdev_llseek+0x4e
> > >                         0xffffffff8f703322  ksys_lseek+0x72
> > >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
> > >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
> > >    2665573     64.38 h       1.98 s      86.95 ms      rwsem:W   blkdev_llseek+0x31
> > >                         0xffffffff903f15bc  rwsem_down_write_slowpath+0x36c
> > >                         0xffffffff903f18fb  down_write+0x5b
> > >                         0xffffffff8f9d5971  blkdev_llseek+0x31
> > >                         0xffffffff8f703322  ksys_lseek+0x72
> > >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
> > >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
> > >                         0xffffffff903dce5e  do_syscall_64+0x7e
> > >                         0xffffffff9040012b  entry_SYSCALL_64_after_hwframe+0x76
> >
> > Admittedly I'm not familiar with this code, but at a quick glance the
> > lock can be just straight up removed here?
> >
> >   534 static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
> >   535 {
> >   536 │       struct inode *bd_inode = bdev_file_inode(file);
> >   537 │       loff_t retval;
> >   538 │
> >   539 │       inode_lock(bd_inode);
> >   540 │       retval = fixed_size_llseek(file, offset, whence,
> > i_size_read(bd_inode));
> >   541 │       inode_unlock(bd_inode);
> >   542 │       return retval;
> >   543 }
> >
> > At best it stabilizes the size for the duration of the call. Sounds
> > like it helps nothing since if the size can change, the file offset
> > will still be altered as if there was no locking?
> >
> > Suppose this cannot be avoided to grab the size for whatever reason.
> >
> > While the above fio invocation did not work for me, I ran some crapper
> > which I had in my shell history and according to strace:
> > [pid 271829] lseek(7, 0, SEEK_SET)      = 0
> > [pid 271829] lseek(7, 0, SEEK_SET)      = 0
> > [pid 271830] lseek(7, 0, SEEK_SET)      = 0
> >
> > ... the lseeks just rewind to the beginning, *definitely* not needing
> > to know the size. One would have to check but this is most likely the
> > case in your test as well.
> >
> > And for that there is 0 need to grab the size, and consequently the inode lock.
> 
> That is to say bare minimum this needs to be benchmarked before/after
> with the lock removed from the picture, like so:

Yeah, I've noticed this in the locking profiles as well and I agree
bd_inode locking seems unnecessary here. Even some filesystems (e.g. ext4)
get away without using inode lock in their llseek handler...

								Honza

> diff --git a/block/fops.c b/block/fops.c
> index 2d01c9007681..7f9e9e2f9081 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -534,12 +534,8 @@ const struct address_space_operations def_blk_aops = {
>  static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
>  {
>         struct inode *bd_inode = bdev_file_inode(file);
> -       loff_t retval;
> 
> -       inode_lock(bd_inode);
> -       retval = fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
> -       inode_unlock(bd_inode);
> -       return retval;
> +       return fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
>  }
> 
>  static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
> 
> To be aborted if it blows up (but I don't see why it would).
> 
> -- 
> Mateusz Guzik <mjguzik gmail.com>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

