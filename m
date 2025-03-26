Return-Path: <linux-fsdevel+bounces-45085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF3A717C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 14:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E557A5976
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB71F2C3B;
	Wed, 26 Mar 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hfCx/SlJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9f+4W7sk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EphIdENI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="weRtWAKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64F1F130F
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996880; cv=none; b=CiR7reKpYA7N3vZaASFuZT10eJFUqJsVNx4QPHQ55mAnUVIy1lMEehunAj9FSk2GwYWleY45WXgG4YIdlBXn7Hk4l1JboxHC+r30KP9QMTZaYha5u7nHAexGxzwQi6AvGDpWOwI3f0sxWMSBtLbOztsuwIciKz7lQt98IVzOOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996880; c=relaxed/simple;
	bh=1dtOfPd1grZ8FZiU2HSezoxWtSTXPWaZ7iGKFkps7PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYA9Zl258H5JnlZpyaiyv3Itq92QOjqVjsvyXDOHc+kmtp+cdU5tVUYN7MXYbMBh6nWQg4NyudfVYaJll5oFBwD3Q1t97j6iauZXyx403tQ0voQj312bI5TMgC/whOLGG8j+4i3DRjkqysKWaFwVVMDYR3cfK/R4LzueAPTAOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hfCx/SlJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9f+4W7sk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EphIdENI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=weRtWAKL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80A1921194;
	Wed, 26 Mar 2025 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742996876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdmZiXEyh3XUCxG9Tb3RBsn5eUfWAO0Nz+jMxRAFVqI=;
	b=hfCx/SlJdowrKBmqYc/F5rdHQRrxegUCPNF+Sqxggwsigi62Yb7z/fumbzAdmuoQzoplN3
	Z/eXEmo0KAQWGqCC7KpOPwQr+Ey6/IKrj+/JTzKbklCneRECSl6IQA//kkam2xrJWl+RXd
	cO90B5IgH8YQj/v45xm5hyDDDfnMdv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742996876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdmZiXEyh3XUCxG9Tb3RBsn5eUfWAO0Nz+jMxRAFVqI=;
	b=9f+4W7skWroaSFCFMv/8yb3rYba+SEOTAUEHzXDGWjxfyMN8d/gZeqSCdjuGOh3pRn6JsU
	snh70HVEupIq/WAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742996875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdmZiXEyh3XUCxG9Tb3RBsn5eUfWAO0Nz+jMxRAFVqI=;
	b=EphIdENI5r2z3U2HMUP+ybB12j94itXt6uM4p3R04paKKxNKMiznIry96nBml1jBXVZxqc
	IdAWe7QVShdF2l7BdXmVRJaug7aMmMFXsC6zA8cNC/NqoeryA0Gzg9b289thbHdrchrVif
	VEbqxolkTp9moOx7KPB+yamyE6WnNVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742996875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdmZiXEyh3XUCxG9Tb3RBsn5eUfWAO0Nz+jMxRAFVqI=;
	b=weRtWAKLvNG16scx/HCtwiZFGLUR+fAej4vVYDf1uqtf97eucLrnuHPXzZeH4Xro9FYvSM
	jE2AcARjkfbR/WBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4727E1374A;
	Wed, 26 Mar 2025 13:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PSfyD4sF5GemOQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 26 Mar 2025 13:47:55 +0000
Date: Wed, 26 Mar 2025 14:47:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: ltp@lists.linux.it, Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
Message-ID: <20250326134749.GA45449@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi all,

[ Cc Kent and other filesystem folks to be sure we don't hide a bug ]

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Make sure that capabilities requirements are satisfied when accessing
> immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> following error due to missing capabilities:

> tst_test.c:1833: TINFO: === Testing on bcachefs ===
> ..
> ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

> Introduce CAP_LINUX_IMMUTABLE capability to make sure that test won't
> fail on other systems as well.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> index 6a9d270d9fb56f3a263f0aed976f62c4576e6a5f..6716423d9c96d9fc1d433f28e0ae1511b912ae2c 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> @@ -122,5 +122,9 @@ static struct tst_test test = {
>  	.bufs = (struct tst_buffers []) {
>  		{&clone_range, .size = sizeof(struct file_clone_range)},
>  		{},
> -	}
> +	},
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_REQ, CAP_LINUX_IMMUTABLE),
> +		{}
> +	},

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, obviously it is CAP_LINUX_IMMUTABLE related.

This looks like fs/bcachefs/fs-ioctl.c

static int bch2_inode_flags_set(struct btree_trans *trans,
				struct bch_inode_info *inode,
				struct bch_inode_unpacked *bi,
				void *p)
{
	...
	if (((newflags ^ oldflags) & (BCH_INODE_append|BCH_INODE_immutable)) &&
	    !capable(CAP_LINUX_IMMUTABLE))
		return -EPERM;


We don't test on vfat and exfat. If I try to do it fail the same way (bcachefs,
fat, exfat and ocfs2 use custom handler for FAT_IOCTL_SET_ATTRIBUTES).

I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:

/*
 * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
 * any invalid configurations.
 *
 * Note: must be called with inode lock held.
 */
static int fileattr_set_prepare(struct inode *inode,
			      const struct fileattr *old_ma,
			      struct fileattr *fa)
{
	int err;

	/*
	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
	 * the relevant capability.
	 */
	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
	    !capable(CAP_LINUX_IMMUTABLE))
		return -EPERM;


Kind regards,
Petr

>  };

> ---
> base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
> change-id: 20250326-fix_ioctl_ficlone03_32bit_bcachefs-2ec15bd6c0c6

> Best regards,

