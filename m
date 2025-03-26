Return-Path: <linux-fsdevel+bounces-45090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0DA719BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D689C17755E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67E15199A;
	Wed, 26 Mar 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UPed4qDW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZ+O2RX3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UPed4qDW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZ+O2RX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB701DED5F
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001180; cv=none; b=EndS+9O1qfhtRrRQTdAu4YrAUlcTkCk9aD66++lkvd7xV86REVJnmce1H7264F/v55Fw3rbGfEirl1BfwMaZs/ekaTfqgFWmgSpy8CzRvz05fjA/ImK385hE70SfzKoQkIO5Ft5S2qjRG5sK0UgMqm2Sr+sGbBOydFSoxraB4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001180; c=relaxed/simple;
	bh=4EMwqAjp2xuwlSoW1yzAXiuCjA85mTNhACjbmWCpSMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EapXbHwFEUA0HKDbx5PhbQIUx65KehWVGYKFP7wzbPRFvl74H/I17ORWk2sxkSIY7P8MWbKqEnfhBVinm7p0reT0Dtsuueu5WEQ/Kuo+49+vaY3sQQcdOl9U6qkwXI3FVMOzTbJaxac2RPfBT9Cga5t84a6rzWRc06e4BK5aU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UPed4qDW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZ+O2RX3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UPed4qDW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZ+O2RX3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 951B01F449;
	Wed, 26 Mar 2025 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743001176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQA8++I8fEYtCn7Y0UzFYWmoWfjCwWdwgkHlqc8FbI=;
	b=UPed4qDWARs76TUUvm3ZvUnOX6jgOdVdnI2Kh+yZAn9fBhPfxFvbYtj2IK0OA/5dSfAUFS
	hVK7HJEJhh8ws2bWt2/FN+NppBIeXdSeogvGxZpvkBKgmqP0Yx5mi8dJq1Kud4q3SkAZb5
	UyoLvCmRljtp6FKvV19gCSsr898Bxd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743001176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQA8++I8fEYtCn7Y0UzFYWmoWfjCwWdwgkHlqc8FbI=;
	b=gZ+O2RX3yJg0lzF0UJTbrDvFbSKp8rV3pHaFftqFdH4MOAq6F3LoPipXUglTZ9+tN9Qbq1
	VrhiNtCY+s9yhjBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UPed4qDW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gZ+O2RX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743001176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQA8++I8fEYtCn7Y0UzFYWmoWfjCwWdwgkHlqc8FbI=;
	b=UPed4qDWARs76TUUvm3ZvUnOX6jgOdVdnI2Kh+yZAn9fBhPfxFvbYtj2IK0OA/5dSfAUFS
	hVK7HJEJhh8ws2bWt2/FN+NppBIeXdSeogvGxZpvkBKgmqP0Yx5mi8dJq1Kud4q3SkAZb5
	UyoLvCmRljtp6FKvV19gCSsr898Bxd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743001176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQA8++I8fEYtCn7Y0UzFYWmoWfjCwWdwgkHlqc8FbI=;
	b=gZ+O2RX3yJg0lzF0UJTbrDvFbSKp8rV3pHaFftqFdH4MOAq6F3LoPipXUglTZ9+tN9Qbq1
	VrhiNtCY+s9yhjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8461E13927;
	Wed, 26 Mar 2025 14:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yZ5LIFgW5GeIUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Mar 2025 14:59:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 211E0A082A; Wed, 26 Mar 2025 15:59:36 +0100 (CET)
Date: Wed, 26 Mar 2025 15:59:36 +0100
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <vhwrsep5wa5j5mn3gads2tw7b2aeo6j6p3nffvxumknfuwhdva@pohjz7u45nwc>
References: <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <Z-HFjTGaOnOjnhLP@dread.disaster.area>
 <7f3eddf89f8fd128ffeb643bc582e45a7d13c216.camel@HansenPartnership.com>
 <Z-HJqLI7Bi4iHWKU@dread.disaster.area>
 <l6qesrzfadpiknnpy7dare7pfnxyfjljseuxvhjcajszymktu3@oitqnbt6fwvr>
 <1af829aa7a65eb5ebc0614a00f7019615ed0f62b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af829aa7a65eb5ebc0614a00f7019615ed0f62b.camel@HansenPartnership.com>
X-Rspamd-Queue-Id: 951B01F449
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 25-03-25 22:36:56, James Bottomley wrote:
> On Tue, 2025-03-25 at 14:42 +0100, Jan Kara wrote:
> [...]
> > If I remember correctly, the problem in the past was, that if you
> > leave userspace running while freezing filesystems, some processes
> > may enter uninterruptible sleep waiting for fs to be thawed and in
> > the past suspend code was not able to hibernate such processes. But I
> > think this obstacle has been removed couple of years ago as now we
> > could use TASK_FREEZABLE flag in sb_start_write() ->
> > percpu_rwsem_wait and thus allow tasks blocked on frozen filesystem
> > to be hibernated.
> 
> I tested this and we do indeed deadlock hibernation on the processes
> touching the filesystem (systemd-journald actually).   But if I make
> this change:
> 
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 6083883c4fe0..720418720bbc 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -156,7 +156,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
>  	spin_unlock_irq(&sem->waiters.lock);
>  
>  	while (wait) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
>  		if (!smp_load_acquire(&wq_entry.private))
>  			break;
>  		schedule();
> 
> Then everything will work, with no lockdep problems (thanks,
> Christian).  Is that the change you want me to make or should
> sb_start_write be using a special freezable version of
> percpu_rwsem_wait()?

I was thinking about this. The possible problem with this may be that a
task waiting in percpu_rwsem_wait() is hibernated and if it holds another
lock (e.g. some mutex) and there's another task waiting for this mutex,
then hibernation fails because that other task cannot be hibernated. With
sb_start_write() specifically, this is usually not a problem because this
is the outermoust lock we take. The only catch here would be if a process
is blocked in a write page fault for a frozen filesystem. Then we are
holding mmap_sem for the process so hibernation could fail this way. But
I'd guess this is rare enough that we could live with that possibility.

So to summarize I think we may need to introduce freezable variant of
percpu_rwsem_down_read() and use it in sb_start_write().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

