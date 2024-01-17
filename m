Return-Path: <linux-fsdevel+bounces-8198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DF830DB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF61C21C8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4E24B26;
	Wed, 17 Jan 2024 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DxH57UwC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XaReb3Nt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DxH57UwC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XaReb3Nt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C6249F3;
	Wed, 17 Jan 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522127; cv=none; b=hy9HQNeAUb27yWm81LYOwv1QEUZ8Q1WIdtbvsY8+GMTlMSWRObhO/xtpTiWwnOaZtqkKPMfEtigUUyCxITc5m5m12jXSWowI2G6xvMrUiV/fv++Pk4nYhvcwTNqrsh0ip3Rn4xLNk2XGPtpobDlo7P8bOOWssR02qvJm6+1Q9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522127; c=relaxed/simple;
	bh=cJBSRVjP/I08r0Jgo3w2nkYK47VeBsQ/VGUIKeQwBvI=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spamd-Result:
	 X-Spam-Level:X-Spam-Flag:X-Spam-Score; b=K0q1WWtHH92YK0z+8u259z188K7uy9vBCkdxRIhocGyOfwxiCDVqS4w5hWk9TmmjZJ5dSKh3utyu2Vt2NJZkXya3NaoZv8cVrEc9hznhg2zvGa5SV5z3JmhZ+AW+ToPtmWLwVA4fDJsaNuk/DFiOaW3hG6W4E2m/f2to5bOY+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DxH57UwC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XaReb3Nt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DxH57UwC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XaReb3Nt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 658701FD60;
	Wed, 17 Jan 2024 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705522123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBFusp2e90JVXJXG409tSOTDSwNhaaPD9hhA0gagayk=;
	b=DxH57UwCaUh8rRctwsG6q8VSqM6zMRwpARpjRMPNOU0RLWRKbfMi2QYzelVofELqc7P59L
	eSspWRHH0rC8fXWP8mnljMrDr4rKFlBs+THOUM9XYZlHboBMy/i82nr1movr/2TVhfQOwP
	TtXi0afrtGJ73AM9vIpBJB/Kk4ZVpuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705522123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBFusp2e90JVXJXG409tSOTDSwNhaaPD9hhA0gagayk=;
	b=XaReb3NttmBxmdu6NCVYFV11x2ZakG/pdtvwdtVpNKA7sga7NvxRb5lkTFvqukNtqcWtxc
	loPHKueJLqUdLVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705522123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBFusp2e90JVXJXG409tSOTDSwNhaaPD9hhA0gagayk=;
	b=DxH57UwCaUh8rRctwsG6q8VSqM6zMRwpARpjRMPNOU0RLWRKbfMi2QYzelVofELqc7P59L
	eSspWRHH0rC8fXWP8mnljMrDr4rKFlBs+THOUM9XYZlHboBMy/i82nr1movr/2TVhfQOwP
	TtXi0afrtGJ73AM9vIpBJB/Kk4ZVpuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705522123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBFusp2e90JVXJXG409tSOTDSwNhaaPD9hhA0gagayk=;
	b=XaReb3NttmBxmdu6NCVYFV11x2ZakG/pdtvwdtVpNKA7sga7NvxRb5lkTFvqukNtqcWtxc
	loPHKueJLqUdLVCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AE8613310;
	Wed, 17 Jan 2024 20:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DSnkDcszqGXoZgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 20:08:43 +0000
Date: Wed, 17 Jan 2024 21:08:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: dsterba@suse.cz, clm@fb.com, daniel@iogearbox.net, dsterba@suse.com,
	john.fastabend@gmail.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, liujian56@huawei.com,
	syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
Message-ID: <20240117200824.GO31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240115190824.GV31555@twin.jikos.cz>
 <tencent_29BA3BBBE933849E2C1B404BE21BA525FB08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_29BA3BBBE933849E2C1B404BE21BA525FB08@qq.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[33f23b49ac24f986c9e8];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FREEMAIL_TO(0.00)[qq.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.cz,fb.com,iogearbox.net,suse.com,gmail.com,toxicpanda.com,vger.kernel.org,huawei.com,syzkaller.appspotmail.com,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30

On Tue, Jan 16, 2024 at 09:09:47AM +0800, Edward Adam Davis wrote:
> On Mon, 15 Jan 2024 20:08:25 +0100, David Sterba wrote:
> > > > If ioctl does not pass in the correct tgtdev_name string, oob will occur because
> > > > "\0" cannot be found.
> > > >
> > > > Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > >  fs/btrfs/dev-replace.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> > > > index f9544fda38e9..e7e96e57f682 100644
> > > > --- a/fs/btrfs/dev-replace.c
> > > > +++ b/fs/btrfs/dev-replace.c
> > > > @@ -730,7 +730,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
> > > >  int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
> > > >  			    struct btrfs_ioctl_dev_replace_args *args)
> > > >  {
> > > > -	int ret;
> > > > +	int ret, len;
> > > >
> > > >  	switch (args->start.cont_reading_from_srcdev_mode) {
> > > >  	case BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS:
> > > > @@ -740,8 +740,10 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
> > > >  		return -EINVAL;
> > > >  	}
> > > >
> > > > +	len = strnlen(args->start.tgtdev_name, BTRFS_DEVICE_PATH_NAME_MAX + 1);
> > > >  	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
> > > > -	    args->start.tgtdev_name[0] == '\0')
> > > > +	    args->start.tgtdev_name[0] == '\0' ||
> > > > +	    len == BTRFS_DEVICE_PATH_NAME_MAX + 1)
> > >
> > > I think srcdev_name would have to be checked the same way, but instead
> > > of strnlen I'd do memchr(name, 0, BTRFS_DEVICE_PATH_NAME_MAX). The check
> > > for 0 in [0] is probably pointless, it's just a shortcut for an empty
> > > buffer. We expect a valid 0-terminated string, which could be an invalid
> > > path but that will be found out later when opening the block device.
> > 
> > Please let me know if you're going to send an updated fix. I'd like to
> > get this fixed to close the syzbot report but also want to give you the
> > credit for debugging and fix.
> > 
> > The preferred fix is something like that:
> > 
> > --- a/fs/btrfs/dev-replace.c
> > +++ b/fs/btrfs/dev-replace.c
> > @@ -741,6 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
> >         if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
> >             args->start.tgtdev_name[0] == '\0')
> >                 return -EINVAL;
> > +       args->start.srcdev_name[BTRFS_PATH_NAME_MAX] = 0;
> > +       args->start.tgtdev_name[BTRFS_PATH_NAME_MAX] = 0;
> This is not correct,
> 1. The maximum length of tgtdev_name is BTRFS_DEVICE_PATH_NAME_MAX + 1

Yes, so if the array size is N + 1 then writing to offset N is valid.
It's a bit confusing that the paths using BTRFS_PATH_NAME_MAX are +1
bigger so it's not folling the patterns using N as the limit.

> 2. strnlen should be used to confirm the presence of \0 in tgtdev_name

Yes, this would work, with the slight difference that memchr looks for
the 0 character regardless of any other, while strnlen also looks for
any intermediate 0. memchr is an optimization, for input parameter
validation it does not matter.

> 3. Input values should not be subjectively updated

Yeah, this is indeed subjective, I propsed that because we already do
that for subvolume ioctls. This probably would never show up in
practice, the paths are not that long and even if the real linux limit
is PATH_MAX (4096) and BTRFS_PATH_NAME_MAX was originally set to a lower
value it's still enough for everybody.

From practiacal perspective I don't see any difference between
overwriting the last place of NUL or checking it by strnlen/memchr.

> 4. The current issue only involves tgtdev_name

Right, that needs to be fixed. With bugs like that it's always good to
look around for similar cases or audit everything of similar pattern,
here it's an ioctl taking a user-specified path. If the target path is
fixed, we need the source path fixed too. It can be a separate patch, no
problem.

