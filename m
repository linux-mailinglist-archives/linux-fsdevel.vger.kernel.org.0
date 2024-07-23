Return-Path: <linux-fsdevel+bounces-24156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2E93A8D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 23:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4931F23433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 21:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4FD14658F;
	Tue, 23 Jul 2024 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MvVDBFWx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EnqrR8br";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MvVDBFWx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EnqrR8br"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF8143C63;
	Tue, 23 Jul 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771239; cv=none; b=PvdE10TgsCLOzZ8SGfRqU3D5DhxQ6WY2M4nkgh8KC+3OHaFNTMe5pdEboFFj3DA65giC+22N3AwQtBqSsGmPclMYrCNZtCDmhu7zCEWnKneG9I5qmoX8UEG155/c3v/K34DM9WdBCn1WjKqYzTuuhxJazDxH0L/E7EZX5O12oEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771239; c=relaxed/simple;
	bh=qJpSDf001uPC+i6s07gErslq6MFzol67hVMny6D9g4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLCARy8v+sXrbzIek7s7xS0QHR3aa3YUIZIZouNtwCk0qeqT6Dk9M9KAw0Hp6FL8mVCX5SKCF6rQrLRNrJ4Au0l18J3hkJsKe6EolQ9/fmhOgcEerhXVFvOLvRtpozLdHgXPFhbh7Mz/QmYFkNIpHVu8rAFhUUP2EE4pIReawz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MvVDBFWx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EnqrR8br; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MvVDBFWx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EnqrR8br; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8753C21AF9;
	Tue, 23 Jul 2024 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721771233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=MvVDBFWx8TP0Aw1w7Plsn7VZRZjB6ToX2pWntC9kYuOAG2+AgHA7RczvZZAC8pwlNNfxcd
	MrNjUG5KmgxsymPs9ioBUFsaZyIabYqSVot/4ozkvBK+Q3Wj0pgXfIF/dJFjcqQZEavjxn
	aga8dD5qgnUaoG31DDfWYmqQePcQgow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721771233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=EnqrR8br+BjFqzxIiJJKZcDrdDbacIFPywX/la6d3y1+PSx70T6x5PfnbNVPd4ZD7r4fdY
	AZxAQA5owXe4hUDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MvVDBFWx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EnqrR8br
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721771233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=MvVDBFWx8TP0Aw1w7Plsn7VZRZjB6ToX2pWntC9kYuOAG2+AgHA7RczvZZAC8pwlNNfxcd
	MrNjUG5KmgxsymPs9ioBUFsaZyIabYqSVot/4ozkvBK+Q3Wj0pgXfIF/dJFjcqQZEavjxn
	aga8dD5qgnUaoG31DDfWYmqQePcQgow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721771233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpHcZwTJx2XsG9I5Zbrs4QADhHKv8JRyCztbBfSL5dU=;
	b=EnqrR8br+BjFqzxIiJJKZcDrdDbacIFPywX/la6d3y1+PSx70T6x5PfnbNVPd4ZD7r4fdY
	AZxAQA5owXe4hUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F0131377F;
	Tue, 23 Jul 2024 21:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eo2tGuEkoGY+QAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jul 2024 21:47:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A56B7A08C6; Tue, 23 Jul 2024 14:57:10 +0200 (CEST)
Date: Tue, 23 Jul 2024 14:57:10 +0200
From: Jan Kara <jack@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240723125710.mtnfaycuvdi4dpdy@quack3>
References: <2136178.1721725194@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2136178.1721725194@warthog.procyon.org.uk>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8753C21AF9
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

Regarding the contents of the change itself:

On Tue 23-07-24 09:59:54, David Howells wrote:
> @@ -954,15 +952,23 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
>  SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
>  {
>  	struct fd f = fdget(fd);
> +	char kname[XATTR_NAME_MAX + 1];
>  	int error = -EBADF;
>  
>  	if (!f.file)
>  		return error;
>  	audit_file(f.file);
> +
> +	error = strncpy_from_user(kname, name, sizeof(kname));
> +	if (error == 0 || error == sizeof(kname))
> +		error = -ERANGE;
> +	if (error < 0)
> +		return error;

Missing fdput() here.

> +
>  	error = mnt_want_write_file(f.file);
>  	if (!error) {
>  		error = removexattr(file_mnt_idmap(f.file),
> -				    f.file->f_path.dentry, name);
> +				    f.file->f_path.dentry, kname);
>  		mnt_drop_write_file(f.file);
>  	}
>  	fdput(f);

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

