Return-Path: <linux-fsdevel+bounces-9867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D284564F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 12:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3168828FB26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6415D5B3;
	Thu,  1 Feb 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OSBoJz5G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HsGmnHL1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t0TpuvFv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zidozr88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E984F51A;
	Thu,  1 Feb 2024 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787270; cv=none; b=NOGdEU9VJuJFyRY5K66+TTnO8CznbMxNauc3uBvUTmn+Hv3BEuUe7ytGvxXawCuZbLaFwkICm4j+lV6oyWsqwJBFn5rAwwWQy0t01cwoePboDaSlCXY7ln6sGNPmGSu96dCmH0oSXzEFUg+7ZfgLh/iowKhGq9Tr5OvVPzZlGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787270; c=relaxed/simple;
	bh=aXpAK4tj1EFfMG7ih98fawOOmK4LJe8i5Ppug0n+TKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqzHyLzWoHh6K507uAzkvPcc7DXzBrl5d8aT/FItEAP5p0gyPkyDI/0UgM6BwUElJbzrTo0sgF87CzynMaZ4EuYhZPv2AHt+sBapFNBmUBdKASFZXPlDLapQCToh2scBX9ZYiiWEhleAGVcVhtzCXGwCeT5OflreJG5xLeblFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OSBoJz5G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HsGmnHL1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t0TpuvFv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zidozr88; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DB77221C1;
	Thu,  1 Feb 2024 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706787266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a78fyv5096pBiP+VBS0+j2E+pgVQnv+5/ICuN/FGT/w=;
	b=OSBoJz5Gh7IZRXaxCF8tWFYwafM8hukAMDSs8YOKyt4E2ckPdUIRQpYURYczHrsWL0mHcS
	ZyaGDbjiGi19JmN21dFQ3crFKALIO2SOx95PIyyjF/0keptLpFvbzw6EK3/qkbBArp2kt9
	V1ZKX0WrYfFe9qpzZDvkn/6bQTGshSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706787266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a78fyv5096pBiP+VBS0+j2E+pgVQnv+5/ICuN/FGT/w=;
	b=HsGmnHL16qYRn4BADkgaGEUgaFt5/RlZE4wOn7JL739xzL0HSfZvVkleCk6sJeilt+r4TK
	2OqTaQjU/DGPsVBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706787265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a78fyv5096pBiP+VBS0+j2E+pgVQnv+5/ICuN/FGT/w=;
	b=t0TpuvFvXcTjkpATCrzQVRir0/enkS9AR97ONdQ+1kbTmXWguwRosOpipuWOyDQ6cFw6G4
	u7BfO5ct954RedwibTFU2GnWwyQzogPol52MMU6SHih1tpAM0d3k3ZbdinIpwdojQ8PJV4
	E5nBg5jiUXIHcGR/EZC0vKUdAoyO00I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706787265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a78fyv5096pBiP+VBS0+j2E+pgVQnv+5/ICuN/FGT/w=;
	b=Zidozr88bVAS2CmwEMGf3hzltFDgCPoO5fGB7LTNXTLf34Rfz/+HPsKYpsMFQ7D22RcHr3
	qpfucOD3MoWAlCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B464139B1;
	Thu,  1 Feb 2024 11:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XPRMCsGBu2WAJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 11:34:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A502BA0809; Thu,  1 Feb 2024 12:34:24 +0100 (CET)
Date: Thu, 1 Feb 2024 12:34:24 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 34/34] ext4: rely on sb->f_bdev only
Message-ID: <20240201113424.xyoeubrywa3vdgxt@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-34-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-34-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 23-01-24 14:26:51, Christian Brauner wrote:
> (1) Instead of bdev->bd_inode->i_mapping we do f_bdev->f_mapping
> (2) Instead of bdev->bd_inode we could do f_bdev->f_inode
> 
> I mention this explicitly because (1) is dependent on how the block
> device is opened while (2) isn't. Consider:
> 
> mount -t tmpfs tmpfs /mnt
> mknod /mnt/foo b <minor> <major>
> open("/mnt/foo", O_RDWR);
> 
> then (1) doesn't work because f_bdev->f_inode is a tmpfs inode _not_ the
> actual bdev filesystem inode. But (2) is still the bd_inode->i_mapping
> as that's set up during bdev_open().
> 
> IOW, I'm explicitly _not_ going via f_bdev->f_inode but via
> f_bdev->f_mapping->host aka bdev_file_inode(f_bdev). Currently this
> isn't a problem because sb->s_bdev_file stashes the a block device file
> opened via bdev_open_by_*() which is always a file on the bdev
> filesystem.
> 
> _If_ we ever wanted to allow userspace to pass a block device file
> descriptor during superblock creation. Say:
> 
> fsconfig(fs_fd, FSCONFIG_CMD_CREATE_EXCL, "source", bdev_fd);
> 
> then using f_bdev->f_inode would be very wrong. Another thing to keep in
> mind there would be that this would implicitly pin another filesystem.
> Say:
> 
> mount -t ext4 /dev/sda /mnt
> mknod /mnt/foo b <minor> <major>
> bdev_fd = open("/mnt/foo", O_RDWR);
> 
> fd_fs = fsopen("xfs")
> fsconfig(fd_fs, FSCONFIG_CMD_CREATE, "source", bdev_fd);
> fd_mnt = fsmount(fd_fs);
> move_mount(fd_mnt, "/mnt2");
> 
> umount /mnt # EBUSY
> 
> Because the xfs filesystem now pins the ext4 filesystem via the
> bdev_file we're keeping. In other words, this is probably a bad idea and
> if we allow userspace to do this then we should only use the provided fd
> to lookup the block device and open our own handle to it.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I suppose this is more or less a sample how to get rid of sb->s_bdev /
bd_inode dereferences AFAICT? Because otherwise I'm not sure why it was
included in this series...

> @@ -5576,7 +5576,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 * used to detect the metadata async write error.
>  	 */
>  	spin_lock_init(&sbi->s_bdev_wb_lock);
> -	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> +	errseq_check_and_advance(&sb->s_bdev_file->f_mapping->wb_err,
>  				 &sbi->s_bdev_wb_err);

So when we have struct file, it would be actually nicer to drop
EXT4_SB(sb)->s_bdev_wb_err completely and instead use
file_check_and_advance_wb_err(sb->s_bdev_file). But that's a separate
cleanup I suppose.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

