Return-Path: <linux-fsdevel+bounces-53501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1EFAEF946
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3EA1758AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C22741AB;
	Tue,  1 Jul 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zTQC2n53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dYnCPGq5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zTQC2n53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dYnCPGq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1525B301
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374385; cv=none; b=MAWdvVbHMp+GWZ7uL2v3FR+PkEl1zEyJq1L/s2tO7xzbgQq5QhtK2jsr9bWUi4g5qDny8OB/1O+t058f5LxZgZcNbHntoK9+AS8WwEdLeCGGJ4uXkps23Xeqfc66dqXjBJrAgLfqa+hkUSr/MpxE+EnFc6zHRMeE3c6HMbSOYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374385; c=relaxed/simple;
	bh=vYdlp4Z6RCPeTFgo9Kj+Ca3apINrxmJWElaVPlxLwBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsZ0ZlqNZ3qDAPi2/APlO9Ji95tdXjAk+8DcioMIuvYSYT3RtnP8p4MO2YoQwurmKl3xUbQHQqDrwv3uYcwcfzW+oANBpiaPoJSJ2MHOvuOzjvkhiW5fRM3/oxo7Ux9u7xdM0g1JN2MHqGECNaN0IGvAGe5iEdEWaIVLAZhfqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zTQC2n53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dYnCPGq5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zTQC2n53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dYnCPGq5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62C292116D;
	Tue,  1 Jul 2025 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751374382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PA1V2abM/P8oSZs6xHMV5WsqH1qOUBIxzO0VRP6dg70=;
	b=zTQC2n53/QBj3DQCoTQcCrTmYgkS8/TsVFoLKUfdoQDe00EPWZB/EmE5nZwMxH7Eu3Wo/P
	yjqTXHnAH/jjDYYGIMzEEvuAvUyCaxYnu0HqyszmbOrrp2uE+9dJwIadydquKZsqScRCBF
	8WindzPuCJVRSttF/Fe7E8pOn+Y56P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751374382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PA1V2abM/P8oSZs6xHMV5WsqH1qOUBIxzO0VRP6dg70=;
	b=dYnCPGq5/98HBSCbjs2BejzCPSlPvI0F+JuGWRvxgHHzcnheCChTCLQfRAkOYwLtMo0Oyf
	2dI8gYJswBvRB+Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751374382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PA1V2abM/P8oSZs6xHMV5WsqH1qOUBIxzO0VRP6dg70=;
	b=zTQC2n53/QBj3DQCoTQcCrTmYgkS8/TsVFoLKUfdoQDe00EPWZB/EmE5nZwMxH7Eu3Wo/P
	yjqTXHnAH/jjDYYGIMzEEvuAvUyCaxYnu0HqyszmbOrrp2uE+9dJwIadydquKZsqScRCBF
	8WindzPuCJVRSttF/Fe7E8pOn+Y56P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751374382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PA1V2abM/P8oSZs6xHMV5WsqH1qOUBIxzO0VRP6dg70=;
	b=dYnCPGq5/98HBSCbjs2BejzCPSlPvI0F+JuGWRvxgHHzcnheCChTCLQfRAkOYwLtMo0Oyf
	2dI8gYJswBvRB+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56D9813890;
	Tue,  1 Jul 2025 12:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L6cyFS7aY2iacAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 12:53:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94D3DA0A23; Tue,  1 Jul 2025 14:52:57 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:52:57 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Message-ID: <us4tut4gie736xav5lyiehh42uxnd4rodthmalte7gksuptknk@qeigxkbkpre4>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arndb.de,schaufler-ca.com,kernel.org,suse.cz,paul-moore.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 30-06-25 18:20:14, Andrey Albershteyn wrote:
> Future patches will add new syscalls which use these functions. As
> this interface won't be used for ioctls only, the EOPNOSUPP is more
> appropriate return code.
> 
> This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Modulo the small nits already pointed out this looks good to me. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

