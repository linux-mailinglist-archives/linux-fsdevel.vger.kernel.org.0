Return-Path: <linux-fsdevel+bounces-8058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B982782EEA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A341F242C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E21B97D;
	Tue, 16 Jan 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ua4poBjq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/ZHgSZ1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ua4poBjq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/ZHgSZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9C1B940
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35F1F221CA;
	Tue, 16 Jan 2024 12:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705406677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=426GBAQuTynCoQF6W6FTJQV1wQtt1m4Edbnjix3XHsA=;
	b=ua4poBjqKTimui6UpMHXqvFMugoobhjFREbXx/IzeWQ48AYGSoX3mYoGWG55Z/qeflI5Q6
	yz97JK3gb9kwZMBoPEj/9dcDCdvH2kI7AyTpA9rkSU0a4nhGsXhsNIJ664+0Pmud7s+h2D
	ogJ8rd2tYixt0KyRcAsWbccKLGzfCZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705406677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=426GBAQuTynCoQF6W6FTJQV1wQtt1m4Edbnjix3XHsA=;
	b=l/ZHgSZ1xlzvC+u3aeHXXyKMPFYzyCDhgbD8f0QDbFgBZito7UBm7PBjl8ElyTzxErd/JJ
	HYycoiLq99wPdAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705406677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=426GBAQuTynCoQF6W6FTJQV1wQtt1m4Edbnjix3XHsA=;
	b=ua4poBjqKTimui6UpMHXqvFMugoobhjFREbXx/IzeWQ48AYGSoX3mYoGWG55Z/qeflI5Q6
	yz97JK3gb9kwZMBoPEj/9dcDCdvH2kI7AyTpA9rkSU0a4nhGsXhsNIJ664+0Pmud7s+h2D
	ogJ8rd2tYixt0KyRcAsWbccKLGzfCZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705406677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=426GBAQuTynCoQF6W6FTJQV1wQtt1m4Edbnjix3XHsA=;
	b=l/ZHgSZ1xlzvC+u3aeHXXyKMPFYzyCDhgbD8f0QDbFgBZito7UBm7PBjl8ElyTzxErd/JJ
	HYycoiLq99wPdAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 286B213751;
	Tue, 16 Jan 2024 12:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4XrYCdVwpmU8RAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jan 2024 12:04:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32E83A0803; Tue, 16 Jan 2024 13:04:34 +0100 (CET)
Date: Tue, 16 Jan 2024 13:04:34 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
Message-ID: <20240116120434.gsdg7lhb4pkcppfk@quack3>
References: <20240116113247.758848-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116113247.758848-1-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.07%]
X-Spam-Flag: NO

On Tue 16-01-24 13:32:47, Amir Goldstein wrote:
> If parent inode is not watching, check for the event in masks of
> sb/mount/inode masks early to optimize out most of the code in
> __fsnotify_parent() and avoid calling fsnotify().
> 
> Jens has reported that this optimization improves BW and IOPS in an
> io_uring benchmark by more than 10% and reduces perf reported CPU usage.
> 
> before:
> 
> +    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
> +    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> 
> after:
> 
> +    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> 
> Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> Link: https://lore.kernel.org/linux-fsdevel/b45bd8ff-5654-4e67-90a6-aad5e6759e0b@kernel.dk/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> Considering that this change looks like a clear win and it actually
> the change that you suggested, I cleaned it up a bit and posting for
> your consideration.

Agreed, I like this. What did you generate this patch against? It does not
apply on top of current Linus' tree (maybe it needs the change sitting in
VFS tree - which is fine I can wait until that gets merged)?

> I've kept the wrappers fsnotify_path() and fsnotify_sb_has_watchers()
> although they are not directly related to the optimization, because they
> makes the code a bit nicer IMO.

Yeah, these cleanups are fine. I would have prefered them as a separate
patch (some people might want the performance improvement to be backported
and this makes it unnecessarily more complex) but don't resend just because
of that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

