Return-Path: <linux-fsdevel+bounces-63579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF459BC4853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46593BFBA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5032F656C;
	Wed,  8 Oct 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kVw51J2j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="33peweNC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kZPVtsqf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uN3dwGld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1C2F60CC
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922082; cv=none; b=cqp0qvFXmC0M4emxtntyBRtzJ+cmE+CV6Z8ZgvorMqXI2ksglPLNp4gY4I5sE4QpoXyFBtLjK33EUsKLniRj1XAux4pWjdOtxHQw4yGqYFi0XiZHTtxbWtZP0NxUpWDXJn56OPzUVlFjdlZY/+gThjaii8GuTV31CiALmd5ddU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922082; c=relaxed/simple;
	bh=6DQNYqui5CozLrzJOv+yfVgFFIg4Lgpaj3p9yDDWsoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzMe6WXRN3IQaTWszB3rwVtduPQfKFLciHkHElj+BR6kuy604xjEk2DX8s1RW0SuDX4RAtK64t8PvkDsu2qkGneBzZdrBw16X9ySlmVoYKsEzJljPmNQGfUGbF3WsinMNy2bosBw8q8Oldi5QwklCy+zDH8DXxaPOLSNXFi7stA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kVw51J2j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=33peweNC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kZPVtsqf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uN3dwGld; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C73731F395;
	Wed,  8 Oct 2025 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc/04qoN/PMDbssSJP/92cG5yZ5biHITDhDiKMO97Aw=;
	b=kVw51J2j/E7tVEzyyLxqoBAdREbgmWnsf7WzPsMcIJapYif0H4STyvrK1SMgv22387PxqI
	iWllC/fTDgNaYsMzOPRNJfRU3i4BtM2copjCIkvFfrTnaixx906B7oZvwmlwWnEEGV8mq8
	pyBciYIPSqmTg15kLuNUZr0lw252dXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc/04qoN/PMDbssSJP/92cG5yZ5biHITDhDiKMO97Aw=;
	b=33peweNCNeyqrEz6ctw6e1p+yxnDOi1e0j0cOxH6XAGtg1VtpaoD0rsyURzQ+lsAPoG63b
	GUvKBK03sGptvNBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kZPVtsqf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uN3dwGld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc/04qoN/PMDbssSJP/92cG5yZ5biHITDhDiKMO97Aw=;
	b=kZPVtsqfdZ2/Jrw2DnxoypL8H4w9ijLGDAr+bd4fOEHIR4vWQsag1GLODvhW7ST0+TQyd+
	mmTSJVnAtnPbRi9kA8G1rWBUOg5Sst6e7vlnCo7sJrO9qOAg0nV5CVBlj0dj+p20nyq50o
	V5jHx7B+iVqolmZVQzvgXCx31OFC+cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fc/04qoN/PMDbssSJP/92cG5yZ5biHITDhDiKMO97Aw=;
	b=uN3dwGld1DTLfMpItq+thAviWSsxYb24QSwhOHDw+hd5D1u1kB8cdEE+PF4kP/EqVXs1lc
	fZvmJxbm3ZmFkTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B498713693;
	Wed,  8 Oct 2025 11:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YQ0FLJ1H5mizIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:14:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 386DDA0ACD; Wed,  8 Oct 2025 13:14:37 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:14:37 +0200
From: Jan Kara <jack@suse.cz>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: jimzhao.ai@gmail.com, akpm@linux-foundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
Message-ID: <ywwhwyc4el6vikghnd5yoejteld6dudemta7lsrtacvecshst5@avvpac27felp>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <20251007161711.468149-1-JPEWhacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007161711.468149-1-JPEWhacker@gmail.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,suse.cz,vger.kernel.org,kvack.org,infradead.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C73731F395
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

Hello!

On Tue 07-10-25 10:17:11, Joshua Watt wrote:
> From: Joshua Watt <jpewhacker@gmail.com>
> 
> This patch strangely breaks NFS 4 clients for me. The behavior is that a
> client will start getting an I/O error which in turn is caused by the client
> getting a NFS3ERR_BADSESSION when attempting to write data to the server. I
> bisected the kernel from the latest master
> (9029dc666353504ea7c1ebfdf09bc1aab40f6147) to this commit (log below). Also,
> when I revert this commit on master the bug disappears.
> 
> The server is running kernel 5.4.161, and the client that exhibits the
> behavior is running in qemux86, and has mounted the server with the options
> rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,port=52049,timeo=600,retrans=2,sec=null,clientaddr=172.16.6.90,local_lock=none,addr=172.16.6.0
> 
> The program that I wrote to reproduce this is pretty simple; it does a file
> lock over NFS, then writes data to the file once per second. After about 32
> seconds, it receives the I/O error, and this reproduced every time. I can
> provide the sample program if necessary.

This is indeed rather curious.

> I also captured the NFS traffic both in the passing case and the failure case,
> and can provide them if useful.
> 
> I did look at the two dumps and I'm not exactly sure what the difference is,
> other than with this patch the client tries to write every 30 seconds (and
> fails), where as without it attempts to write back every 5 seconds. I have no
> idea why this patch would cause this problem.

So the change in writeback behavior is not surprising. The commit does
modify the logic computing dirty limits in some corner cases and your
description matches the fact that previously the computed limits were lower
so we've started writeback after 5s (dirty_writeback_interval) while with
the patch we didn't cross the threshold and thus started writeback only
once the dirty data was old enough, which is 30s (dirty_expire_interval).

But that's all, you should be able to observe exactly the same writeback
behavior if you write less even without this patch. So I suspect that the
different writeback behavior is just triggering some bug in the NFS (either
on the client or the server side). The NFS3ERR_BADSESSION error you're
getting back sounds like something times out somewhere, falls out of cache
and reports this error (which doesn't happen if we writeback after 5s
instead of 30s). NFS guys maybe have better idea what's going on here.

You could possibly workaround this problem (and verify my theory) by tuning
/proc/sys/vm/dirty_expire_centisecs to a lower value (say 500). This will
make inode writeback start earlier and thus should effectively mask the
problem again.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

