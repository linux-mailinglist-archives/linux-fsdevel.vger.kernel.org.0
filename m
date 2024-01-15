Return-Path: <linux-fsdevel+bounces-7992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0BD82E06C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC171F22745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EF518C35;
	Mon, 15 Jan 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZwSw0CF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nFgLacu4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZwSw0CF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nFgLacu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B418C01;
	Mon, 15 Jan 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CB191FD3E;
	Mon, 15 Jan 2024 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705345723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXqG9tpDXOuq5pm5OTaGvyKE6oX/ladrg2W+JHdkSeI=;
	b=dZwSw0CFBj2OUJUusoZfn5JO6NPs4vwC+ecrRAnAOVZRsG9+clFSNNqtsfJUhJ57s9w00Z
	mK3Ww/G4y3Yb5zMpp0Pxv44MkQzkhdo+I9xTyCE99Egsm1caw6PorLnkb5h4fXMN5VmMDc
	VmfW20iouHWQHEEbkNxdhYl94jU7Q/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705345723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXqG9tpDXOuq5pm5OTaGvyKE6oX/ladrg2W+JHdkSeI=;
	b=nFgLacu4Yloox2cbPLv2Syy8y9GPgU+henqjrd4QjHnDs+Wbf5oWGy2fBYWI8hx5lQzZjk
	P6hSVI4JUnYA+9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705345723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXqG9tpDXOuq5pm5OTaGvyKE6oX/ladrg2W+JHdkSeI=;
	b=dZwSw0CFBj2OUJUusoZfn5JO6NPs4vwC+ecrRAnAOVZRsG9+clFSNNqtsfJUhJ57s9w00Z
	mK3Ww/G4y3Yb5zMpp0Pxv44MkQzkhdo+I9xTyCE99Egsm1caw6PorLnkb5h4fXMN5VmMDc
	VmfW20iouHWQHEEbkNxdhYl94jU7Q/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705345723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXqG9tpDXOuq5pm5OTaGvyKE6oX/ladrg2W+JHdkSeI=;
	b=nFgLacu4Yloox2cbPLv2Syy8y9GPgU+henqjrd4QjHnDs+Wbf5oWGy2fBYWI8hx5lQzZjk
	P6hSVI4JUnYA+9DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EEC11139D2;
	Mon, 15 Jan 2024 19:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MfwfObqCpWXyEAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 15 Jan 2024 19:08:42 +0000
Date: Mon, 15 Jan 2024 20:08:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: David Sterba <dsterba@suse.cz>,
	syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com, clm@fb.com,
	daniel@iogearbox.net, dsterba@suse.com, john.fastabend@gmail.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	liujian56@huawei.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: fix oob Read in getname_kernel
Message-ID: <20240115190824.GV31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com>
 <20240110155545.GW28693@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110155545.GW28693@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[33f23b49ac24f986c9e8];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.00)[-0.022];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email];
	 FREEMAIL_TO(0.00)[qq.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.cz,syzkaller.appspotmail.com,fb.com,iogearbox.net,suse.com,gmail.com,toxicpanda.com,vger.kernel.org,huawei.com,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed, Jan 10, 2024 at 04:55:46PM +0100, David Sterba wrote:
> On Tue, Dec 19, 2023 at 06:19:10PM +0800, Edward Adam Davis wrote:
> > If ioctl does not pass in the correct tgtdev_name string, oob will occur because
> > "\0" cannot be found.
> > 
> > Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/btrfs/dev-replace.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> > index f9544fda38e9..e7e96e57f682 100644
> > --- a/fs/btrfs/dev-replace.c
> > +++ b/fs/btrfs/dev-replace.c
> > @@ -730,7 +730,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
> >  int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
> >  			    struct btrfs_ioctl_dev_replace_args *args)
> >  {
> > -	int ret;
> > +	int ret, len;
> >  
> >  	switch (args->start.cont_reading_from_srcdev_mode) {
> >  	case BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS:
> > @@ -740,8 +740,10 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
> >  		return -EINVAL;
> >  	}
> >  
> > +	len = strnlen(args->start.tgtdev_name, BTRFS_DEVICE_PATH_NAME_MAX + 1);
> >  	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
> > -	    args->start.tgtdev_name[0] == '\0')
> > +	    args->start.tgtdev_name[0] == '\0' ||
> > +	    len == BTRFS_DEVICE_PATH_NAME_MAX + 1)
> 
> I think srcdev_name would have to be checked the same way, but instead
> of strnlen I'd do memchr(name, 0, BTRFS_DEVICE_PATH_NAME_MAX). The check
> for 0 in [0] is probably pointless, it's just a shortcut for an empty
> buffer. We expect a valid 0-terminated string, which could be an invalid
> path but that will be found out later when opening the block device.

Please let me know if you're going to send an updated fix. I'd like to
get this fixed to close the syzbot report but also want to give you the
credit for debugging and fix.

The preferred fix is something like that:

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -741,6 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
        if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
            args->start.tgtdev_name[0] == '\0')
                return -EINVAL;
+       args->start.srcdev_name[BTRFS_PATH_NAME_MAX] = 0;
+       args->start.tgtdev_name[BTRFS_PATH_NAME_MAX] = 0;
 
        ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
                                        args->start.srcdevid,

