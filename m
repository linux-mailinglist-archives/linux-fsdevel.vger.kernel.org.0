Return-Path: <linux-fsdevel+bounces-7722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C2829E07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52721F252D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77324C601;
	Wed, 10 Jan 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IwkwTOZt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vRFh6QaK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LxJpvf6b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4djvRbWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195C4BAB0;
	Wed, 10 Jan 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D5D921DAA;
	Wed, 10 Jan 2024 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704902167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdRDAcSG2IDlJ6wJ1MdreWcR1qBg5i+HYtCzFm8Eaw4=;
	b=IwkwTOZtv7ajVhA/5CvKHdyniAKga32pMta2wOp8nXr3cudKUgTomYjcSG3gs3b9rRMg4d
	PhAWUJll8pYexlQuBSWuZnhzihzmXwM+w/jRiD54/f/TliUVxmy8HMte1F0fQ912ZfVajK
	MF0uVflO1BO8vtRry6RXx1Nv2VwzaK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704902167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdRDAcSG2IDlJ6wJ1MdreWcR1qBg5i+HYtCzFm8Eaw4=;
	b=vRFh6QaKZLCtewgzrn/xS+Xef4VEaTfMmB/vzV7jc4JfDCgf/yj1YGJ8I1nciByEJ6p2Zb
	ktPAj0XOfIWfwiCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704902165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdRDAcSG2IDlJ6wJ1MdreWcR1qBg5i+HYtCzFm8Eaw4=;
	b=LxJpvf6bvAJILRNeexKQvYPfazdQ+6AL1IsUmFMkQvMUE/CxCxBDYRSVn/USsWZfujmMOb
	ZxlrLJ/oML+5dZsfegyh8QVFa6BrqZ1+od/YoMhCSJuKDxAKoRKRXvgzMo5VR3tUT9hioI
	k7xn69NRi2tflzKdFyF9qiRteXdwfmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704902165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdRDAcSG2IDlJ6wJ1MdreWcR1qBg5i+HYtCzFm8Eaw4=;
	b=4djvRbWro38jKXhPTJlPnJNlJrXQrB0GBsZGY6L7MyexqJ2BtloG2vvxYJFe3F/5A+eQEW
	VqVoETZCx2gYDDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D86EE13786;
	Wed, 10 Jan 2024 15:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y6pxNBS+nmWmHgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 15:56:04 +0000
Date: Wed, 10 Jan 2024 16:55:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com, clm@fb.com,
	daniel@iogearbox.net, dsterba@suse.com, john.fastabend@gmail.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	liujian56@huawei.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: fix oob Read in getname_kernel
Message-ID: <20240110155545.GW28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.71 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[qq.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[33f23b49ac24f986c9e8];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,qq.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,fb.com,iogearbox.net,suse.com,gmail.com,toxicpanda.com,vger.kernel.org,huawei.com,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.71
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0D5D921DAA
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LxJpvf6b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4djvRbWr

On Tue, Dec 19, 2023 at 06:19:10PM +0800, Edward Adam Davis wrote:
> If ioctl does not pass in the correct tgtdev_name string, oob will occur because
> "\0" cannot be found.
> 
> Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/btrfs/dev-replace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index f9544fda38e9..e7e96e57f682 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -730,7 +730,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
>  int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
>  			    struct btrfs_ioctl_dev_replace_args *args)
>  {
> -	int ret;
> +	int ret, len;
>  
>  	switch (args->start.cont_reading_from_srcdev_mode) {
>  	case BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS:
> @@ -740,8 +740,10 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
>  		return -EINVAL;
>  	}
>  
> +	len = strnlen(args->start.tgtdev_name, BTRFS_DEVICE_PATH_NAME_MAX + 1);
>  	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
> -	    args->start.tgtdev_name[0] == '\0')
> +	    args->start.tgtdev_name[0] == '\0' ||
> +	    len == BTRFS_DEVICE_PATH_NAME_MAX + 1)

I think srcdev_name would have to be checked the same way, but instead
of strnlen I'd do memchr(name, 0, BTRFS_DEVICE_PATH_NAME_MAX). The check
for 0 in [0] is probably pointless, it's just a shortcut for an empty
buffer. We expect a valid 0-terminated string, which could be an invalid
path but that will be found out later when opening the block device.

