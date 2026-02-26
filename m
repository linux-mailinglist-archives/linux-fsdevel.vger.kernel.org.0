Return-Path: <linux-fsdevel+bounces-78467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP2SErAuoGkrgAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 12:29:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B034D1A50D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 12:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6808E307AFDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF0369988;
	Thu, 26 Feb 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gcMXQ1K+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uoj7Ytir";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gcMXQ1K+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uoj7Ytir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897B369990
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105384; cv=none; b=mzPIEd+sRxFzFz7FBNEeRqXfKZ+jmRoOzOxB3AerNSbfwmt5JEcoGKmK9Nm7S6Gwdoe3gMo2wkdApRYuiRyGsKt64a1O1kHgWhvBVoRkdr8a+6PiE/5BAvYnfMlk3xvFwE9HVFizMEjPpkGOt21mzfWYo5HTiuP22J1vTNGLrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105384; c=relaxed/simple;
	bh=AndIrKyQHy+il0EwGoW2/aFvltHI4Xk44RYUVWnT4N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gadQp+1gE0tBzHJ5y4krsvLeZpzhcmgdJob5qucxBIbCdSLhrZyU8gD+TLTmJGlCuomvFfKw0d0n4CzNJ5DhcdUZN/wC9xiUsyjEcExjrZM/CdzXeVTi0c1RfseHUtZmHrncrVZEfYVWWQvjOn9dq6Rf89rBqlmd4Im/BEQZ8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gcMXQ1K+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uoj7Ytir; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gcMXQ1K+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uoj7Ytir; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69CC21FA7B;
	Thu, 26 Feb 2026 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772105381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuMgGX8SlMhcVTfISf0evxu3cUrTp/iLJp3o2AALQ24=;
	b=gcMXQ1K+K6+isb94DqG/NTJv0/S3mR9XaHs/VFa2jkMxAK6mUs9wt1NPsscgEIET1aujds
	oeMBxMAUNCtWVqIADOkXVR+IPYsqEG41SenZ9ciDj/bTE2vC+gXpfn1CKpwbChgzT/Voa6
	xsEoP3exT95ZlBZifc/jaqMPWGNmouk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772105381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuMgGX8SlMhcVTfISf0evxu3cUrTp/iLJp3o2AALQ24=;
	b=Uoj7YtirM+vpPj2ECwkEjhVNPWyXprLDLuPQBk4L3Q6zASclwwx6HVk2i9ssDy6VvtVvdj
	OZKv7tg8ESE0CaCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772105381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuMgGX8SlMhcVTfISf0evxu3cUrTp/iLJp3o2AALQ24=;
	b=gcMXQ1K+K6+isb94DqG/NTJv0/S3mR9XaHs/VFa2jkMxAK6mUs9wt1NPsscgEIET1aujds
	oeMBxMAUNCtWVqIADOkXVR+IPYsqEG41SenZ9ciDj/bTE2vC+gXpfn1CKpwbChgzT/Voa6
	xsEoP3exT95ZlBZifc/jaqMPWGNmouk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772105381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuMgGX8SlMhcVTfISf0evxu3cUrTp/iLJp3o2AALQ24=;
	b=Uoj7YtirM+vpPj2ECwkEjhVNPWyXprLDLuPQBk4L3Q6zASclwwx6HVk2i9ssDy6VvtVvdj
	OZKv7tg8ESE0CaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AE533EA62;
	Thu, 26 Feb 2026 11:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id toSJFaUuoGmQWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 11:29:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A9F0A0A27; Thu, 26 Feb 2026 12:29:33 +0100 (CET)
Date: Thu, 26 Feb 2026 12:29:33 +0100
From: Jan Kara <jack@suse.cz>
To: Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Generic approach to avoid truncation of file on pseudo fs
Message-ID: <nivmqedi2e4wgufmr74fed5jda24dmzj6kroufd5krqrnj4fdm@jnfkf27ncjy3>
References: <CAJ2a_Df6GOirF8TnNWTqNMpdWLHgjT9_v7G-PiL4e7LU2nr1PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2a_Df6GOirF8TnNWTqNMpdWLHgjT9_v7G-PiL4e7LU2nr1PA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[googlemail.com];
	TAGGED_FROM(0.00)[bounces-78467-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B034D1A50D0
X-Rspamd-Action: no action

On Thu 19-02-26 14:37:05, Christian Göttsche wrote:
> Hi all,
> 
> SELinux offers a memory mapping for userspace for status changes via
> the pseudo file /sys/fs/selinux/status.
> Currently this file can be truncated by a privileged process, leading
> to other userland processes getting signalled a bus error (SIGBUS).
> This affects for example systemd [1].
> I proposed a targeted fix [2], overriding the inode setattr handler
> and filtering O_TRUNC on open.
> 
> Is there there a general solution how to prevent truncation of pseudo
> files backed up by real memory?
> Are there more ways a file can be truncated that should be handled?
> 
> 
> If there is no generic way would the following patch be acceptable?

OK, since my knowledge about this code is limited, I did some research :).
Firstly, I've checked how other virtual filesystems behave and the answer
is "it depends". E.g. those that are based on kernfs (e.g. sysfs) have
their own .setattr handler which just ignores ATTR_SIZE. From those that
are based on simple_fill_super as is the case for selinux (but also
debugfs, nfsctl, tracefs, fusectl, binfmt) all of them just allow the file
size to be changed which likely has some potential for confusing userspace
for some of them. So I don't see a problem with allowing to pass
inode_operations to use by simple_fill_super() but I'm a bit undecided
whether it wouldn't be more sensible for pseudo_fs_fill_super() to just
set inode->i_op to inode operations that don't allow truncate because for
none of the filesystems using it, it looks useful to say the least.

								Honze

>  diff --git a/fs/libfs.c b/fs/libfs.c
> 
> index 9264523be85c..76f7fec136cb 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1089,6 +1089,7 @@ int simple_fill_super(struct super_block *s,
> unsigned long magic,
>                }
>                inode->i_mode = S_IFREG | files->mode;
>                simple_inode_init_ts(inode);
> +               inode->i_op = files->iops;
>                inode->i_fop = files->ops;
>                inode->i_ino = i;
>                d_make_persistent(dentry, inode);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 04ceeca12a0d..9f1a9f0a9b48 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3225,7 +3225,7 @@ extern const struct file_operations simple_dir_operations;
> extern const struct inode_operations simple_dir_inode_operations;
> extern void make_empty_dir_inode(struct inode *inode);
> extern bool is_empty_dir_inode(struct inode *inode);
> -struct tree_descr { const char *name; const struct file_operations
> *ops; int mode; };
> +struct tree_descr { const char *name; const struct file_operations
> *ops; int mode; const struct inode_operations *iops; };
> struct dentry *d_alloc_name(struct dentry *, const char *);
> extern int simple_fill_super(struct super_block *, unsigned long,
>                             const struct tree_descr *);
> 
> 
> and then adding the hook would just be
> 
> -               [SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
> +               [SEL_STATUS] = {"status", &sel_handle_status_ops,
> S_IRUGO, &sel_handle_status_iops},
> 
> 
> Best regards,
>        Christian Göttsche
> 
> 
> Link [1]: https://github.com/systemd/systemd/issues/37349
> Link [2]: https://lore.kernel.org/selinux/20260130171140.90966-1-cgoettsche@seltendoof.de/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

