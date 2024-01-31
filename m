Return-Path: <linux-fsdevel+bounces-9700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA484475F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F71C1F27666
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CFA21353;
	Wed, 31 Jan 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+X18Ij4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQOjuR8G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="blHeliCd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y1TNaRNA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCF18B00;
	Wed, 31 Jan 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726628; cv=none; b=CfH9NN616SKGA0oWgse2H2ODdWlzihYvUj6J6a4DZUzYX4/H1ylSij8T5NbQB0Q/amClht0kQOZD1hGq9r+YNRb523r5Gs/AgFkb3238qmOiZp92aYPKF+geFUMVT7YdR/t4Odzpuq9Iy2a5qcRA5fSbUA/r+twPfTKS6nbknOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726628; c=relaxed/simple;
	bh=nbd5D4P1LDjClXGE4BxCyxo7QxWJikjnSFwGLyX6+7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAvEqJZfX6k+NL+pXwFBLNXuwyKTkDYaFwb/K2wAe3tfYHIEJj5aMC34czL/8w84El8Ofn1Cw08cRxd3ETwaIVnesvA/UMIsDNqSX7F9JWQ+2RnNgcSboNpgr+Blpx8b5DeDnJ3ihZ9GsXdJoMOj5l5ukN/D1zAhcGYRbhS4hhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+X18Ij4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQOjuR8G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=blHeliCd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y1TNaRNA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4F6B22023;
	Wed, 31 Jan 2024 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706726625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sg1XafIwMbKF7i3pk6Jb1n12UMuHzyybZkq6XU2HGkw=;
	b=C+X18Ij4AL3GkZFyYdJ94kFPel6NEqVvPRCGZSBpSh6xPZd3VLk8svV0ikIdtmsLSp1oiA
	kTVC+lcPsVlQG+Ys6WlqpWpAWPBuzjYCBymk/0ERfPy48WDQpPcj8fKRrdtC72U2fR3YtB
	UkL0nGHlUPewKnQfi1k57aAr4cDNtd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706726625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sg1XafIwMbKF7i3pk6Jb1n12UMuHzyybZkq6XU2HGkw=;
	b=hQOjuR8GDY8s7Fs1i4CHzj2xYegkxgkqo1fsxSEi1A7c5K0zx4ozwaXMvaNutitm2y4Hje
	qSY9hgmcw2xDM0Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706726624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sg1XafIwMbKF7i3pk6Jb1n12UMuHzyybZkq6XU2HGkw=;
	b=blHeliCd5FbxsaggUl3GOtxR3D+cr55EFNnNuGAU51pelKJPkx+KkJFdRofcAtZL14ZszY
	bAKo8YBui7TYC/e9oKy9a9YyQ4Gq59XrBypusLnHYrTt8MQbnMeE2MyDLM7vMiIHBvqnb7
	zuL1+TGQPbTzd2oDG1sFbZkP8jpz2Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706726624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sg1XafIwMbKF7i3pk6Jb1n12UMuHzyybZkq6XU2HGkw=;
	b=Y1TNaRNA5uoUb6g+bsY//cTZEnX5JIbQKTbjUU0yR9HcZDbhjoQW7jy80TcLYx8p4OBD5/
	ka6MSedEm0n0peCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BC65C139D9;
	Wed, 31 Jan 2024 18:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EhbZLeCUumUbKgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 18:43:44 +0000
Date: Wed, 31 Jan 2024 19:43:18 +0100
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
Message-ID: <20240131184318.GQ31555@twin.jikos.cz>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=blHeliCd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y1TNaRNA
X-Spamd-Result: default: False [-1.51 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[qq.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[33f23b49ac24f986c9e8];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,qq.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[suse.cz,fb.com,iogearbox.net,suse.com,gmail.com,toxicpanda.com,vger.kernel.org,huawei.com,syzkaller.appspotmail.com,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D4F6B22023
X-Spam-Level: 
X-Spam-Score: -1.51
X-Spam-Flag: NO

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
> 2. strnlen should be used to confirm the presence of \0 in tgtdev_name
> 3. Input values should not be subjectively updated

Regarding that point I agree it's not the best handling and could be
confusing. There are multiple instances of that in the ioctl callbacks
so the proper fix is to add a helper doing the validity check (either
strnlen or memchr) and then use it.

The pattern to look for is "vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';"
in ioctl.c (at least).

Let me know if you'd want to implement that.

