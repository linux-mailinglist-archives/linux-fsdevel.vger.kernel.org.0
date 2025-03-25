Return-Path: <linux-fsdevel+bounces-45016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D57A70298
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FB816B92E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D41A317A;
	Tue, 25 Mar 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RAAB1lV3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xki1MZq4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RAAB1lV3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xki1MZq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0C18BC3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910171; cv=none; b=j3cs3PbNdzHxDcTcvlmHCrQHmaqp/nQRNth7ly05i9juuo/W+ZV6jd0iGlYbo88sDTbfcv67F47crZPMXFg7VC2dwMgNyqIF011ykN1PkBi1tJwnjfics2nYoQ0dQ1YdRH8bF3UKyplaykyje0/M1nG8Do8BdXHXZU1Deqh8IsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910171; c=relaxed/simple;
	bh=2FLRT0Z9gzT0KHelUyeQE9+ZmPajFGdhfFDcCXoRiFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAt0Q7nfFE1g0xh4YXF4/GSsXtUYkcR2ClJIuOp2mi0/V4NrKZ3oCZLVQwc4gaoNwiAsYOmHm9AjsgxFfNsXNw+F95B0kOPUTSe88Y3d9wQorZT5PJD72lwaf/iS3lS/Pzl4kAxrIwz4H0BK2e7VQP7eliMaZ4olwIG3yzJh6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RAAB1lV3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xki1MZq4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RAAB1lV3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xki1MZq4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99ED11F445;
	Tue, 25 Mar 2025 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742910161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89zlWdUkkhkDJ3fTIQjE5Aa9v+qsos4UINRkoHMtlzQ=;
	b=RAAB1lV3xOMKkFhWsDrHJQCVmu3t/cceS3IogrUTXFkWLa200ovbCJGBFueqOnY1vTPTIg
	Adug3T5G6B2lAn9NQkNRinYwerOq8+demhpT99s2nsScoeVWm6ABIB9+2bdfkFrB8dgmi/
	RWSA9hv2/xAnpJopw5XCT4UHeubXZvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742910161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89zlWdUkkhkDJ3fTIQjE5Aa9v+qsos4UINRkoHMtlzQ=;
	b=Xki1MZq42cXH+bJZ+XsoXarxnw3aur4mS5l5tgzElGT02OyT4/38QZPOs7MxGRIcD15gZI
	I2fvuv8U8Crl44CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742910161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89zlWdUkkhkDJ3fTIQjE5Aa9v+qsos4UINRkoHMtlzQ=;
	b=RAAB1lV3xOMKkFhWsDrHJQCVmu3t/cceS3IogrUTXFkWLa200ovbCJGBFueqOnY1vTPTIg
	Adug3T5G6B2lAn9NQkNRinYwerOq8+demhpT99s2nsScoeVWm6ABIB9+2bdfkFrB8dgmi/
	RWSA9hv2/xAnpJopw5XCT4UHeubXZvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742910161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89zlWdUkkhkDJ3fTIQjE5Aa9v+qsos4UINRkoHMtlzQ=;
	b=Xki1MZq42cXH+bJZ+XsoXarxnw3aur4mS5l5tgzElGT02OyT4/38QZPOs7MxGRIcD15gZI
	I2fvuv8U8Crl44CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B79C13957;
	Tue, 25 Mar 2025 13:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PSULItGy4mfNDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Mar 2025 13:42:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F41BA0838; Tue, 25 Mar 2025 14:42:41 +0100 (CET)
Date: Tue, 25 Mar 2025 14:42:41 +0100
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <l6qesrzfadpiknnpy7dare7pfnxyfjljseuxvhjcajszymktu3@oitqnbt6fwvr>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <Z-HFjTGaOnOjnhLP@dread.disaster.area>
 <7f3eddf89f8fd128ffeb643bc582e45a7d13c216.camel@HansenPartnership.com>
 <Z-HJqLI7Bi4iHWKU@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-HJqLI7Bi4iHWKU@dread.disaster.area>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 25-03-25 08:07:52, Dave Chinner wrote:
> On Mon, Mar 24, 2025 at 05:02:54PM -0400, James Bottomley wrote:
> > On Tue, 2025-03-25 at 07:50 +1100, Dave Chinner wrote:
> > > On Mon, Mar 24, 2025 at 12:38:20PM +0100, Jan Kara wrote:
> > > > On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> > > > > On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> > > > > [...]
> > > > > > Let me digest all that and see if we have more hope this time
> > > > > > around.
> > > > > 
> > > > > OK, I think I've gone over it all.  The biggest problem with
> > > > > resurrecting the patch was bugs in ext3, which isn't a problem
> > > > > now.  Most of the suspend system has been rearchitected to
> > > > > separate suspending user space processes from kernel ones.  The
> > > > > sync it currently does occurs before even user processes are
> > > > > frozen.  I think (as most of the original proposals did) that we
> > > > > just do freeze all supers (using the reverse list) after user
> > > > > processes are frozen but just before kernel threads are (this
> > > > > shouldn't perturb the image allocation in hibernate, which was
> > > > > another source of bugs in xfs).
> > > > 
> > > > So as far as my memory serves the fundamental problem with this
> > > > approach was FUSE - once userspace is frozen, you cannot write to
> > > > FUSE filesystems so filesystem freezing of FUSE would block if
> > > > userspace is already suspended. You may even have a setup like:
> > > > 
> > > > bdev <- fs <- FUSE filesystem <- loopback file <- loop device <-
> > > > another fs
> > > > 
> > > > So you really have to be careful to freeze this stack without
> > > > causing deadlocks. So you need to be freezing userspace after
> > > > filesystems are frozen but then you have to deal with the fact that
> > > > parts of your userspace will be blocked in the kernel (trying to do
> > > > some write) waiting for the filesystem to thaw. But it might be
> > > > tractable these days since I have a vague recollection that system
> > > > suspend is now able to gracefully handle even tasks in
> > > > uninterruptible sleep.
> > > 
> > > I thought we largely solved this problem with userspace flusher
> > > threads being able to call prctl(PR_IO_FLUSHER) to tell the kernel
> > > they are part of the IO stack and so need to be considered
> > > special from the POV of memory allocation and write (dirty page)
> > > throttling.
> > > 
> > > Maybe hibernate needs to be aware of these userspace flusher
> > > tasks and only suspend them after filesystems are frozen instead
> > > of when userspace is initially halted?
> > 
> > I can confirm it's not.  Its check for kernel thread is in
> > kernel/power/process.c:try_to_freeze_tasks().  It really only uses the
> > PF_KTHREAD flag in differentiating between user and kernel threads.
> > 
> > But what I heard in the session was that we should freeze filesystems
> > before any tasks because that means tasks touching the frozen fs freeze
> > themselves.
> 
> But that's exactly the behaviour that leads to FUSE based deadlocks,
> is it not? i.e. freeze the backing fs, then try to freeze the FUSE
> filesystem and the freeze blocks forever trying to write to the
> frozen backing fs....
> 
> What am I missing here?

I don't think that creates FUSE based deadlocks. Whan you describe is
generally a problem with the order of how filesystems are frozen and can
happen with loop devices as well. If you leave userspace running and freeze
filesystems in proper order (happens to be reverse ordering of superblock
list), then you should freeze all filesystems without deadlocking.

If I remember correctly, the problem in the past was, that if you leave
userspace running while freezing filesystems, some processes may enter
uninterruptible sleep waiting for fs to be thawed and in the past suspend
code was not able to hibernate such processes. But I think this obstacle
has been removed couple of years ago as now we could use TASK_FREEZABLE
flag in sb_start_write() -> percpu_rwsem_wait and thus allow tasks blocked
on frozen filesystem to be hibernated.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

