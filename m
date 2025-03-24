Return-Path: <linux-fsdevel+bounces-44895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767DA6E384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2E9188B3C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851519C54A;
	Mon, 24 Mar 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WrGOfM93";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4F6Qmlq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WrGOfM93";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4F6Qmlq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C819539F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844542; cv=none; b=tBiY06Vqt1Lp3VqksuUJSUfh65o1CNs52tZKh4vqzu2h2Bnjn6ifRbTOuHQZNY3X1g3zg01J4cnRaU1ucRZf97dILDd6sMi5vifkv/9Bp3ru/UTXFjbWmYESgVAP+RKS86f95Bkdh3DoOsofIDspEqJImnujnvWO8lMTn1/DcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844542; c=relaxed/simple;
	bh=XNg+LNi2K2eeCtKxyyvCMOFI1BWkciSsUfOTFxVtEbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYYlZcGfGLlz+jFqDNsuCuKiwAVjmrMbWwDs5WT9vdAWCTlOyuEYgC20G55nUeFX4ieP5nCa6qqaJ9us7d+qNVbCnsquFGa9aCBE1G6dQmcw8eMQmJdAkTGYoNMUI+bfbNDaiu/QRMMF0uONQAtVqnSaFIb4IEdk/INuZwQkC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WrGOfM93; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4F6Qmlq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WrGOfM93; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4F6Qmlq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE8A31F391;
	Mon, 24 Mar 2025 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742844538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WIe+aW55w3GUihCgD/R92wsulm9AHVCAYpzTFIDJw=;
	b=WrGOfM93aEF7jIiX5XR6PgSKBpXpyRo2hvZP8qSbYwpsp8umXT5NIjXRE6VPQ3iz69mu+M
	VbH6FFN3UkoHt7EpKTWrz3WSfxJs/q2iNoGhH3Vko4g+pnG2LRLWcNbSjz2fZVc0qBWhd6
	iO1Oc4cccR1wib146oJo+MF0zS43rt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742844538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WIe+aW55w3GUihCgD/R92wsulm9AHVCAYpzTFIDJw=;
	b=x4F6QmlqSRYQ8fikygfo90FQ5j+WJC/WJgB/zqLr5GzX2Iro4v6GWAnAmA2/6zI27Nu8O3
	KBv8XlPnJgbltoCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742844538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WIe+aW55w3GUihCgD/R92wsulm9AHVCAYpzTFIDJw=;
	b=WrGOfM93aEF7jIiX5XR6PgSKBpXpyRo2hvZP8qSbYwpsp8umXT5NIjXRE6VPQ3iz69mu+M
	VbH6FFN3UkoHt7EpKTWrz3WSfxJs/q2iNoGhH3Vko4g+pnG2LRLWcNbSjz2fZVc0qBWhd6
	iO1Oc4cccR1wib146oJo+MF0zS43rt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742844538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WIe+aW55w3GUihCgD/R92wsulm9AHVCAYpzTFIDJw=;
	b=x4F6QmlqSRYQ8fikygfo90FQ5j+WJC/WJgB/zqLr5GzX2Iro4v6GWAnAmA2/6zI27Nu8O3
	KBv8XlPnJgbltoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A173413874;
	Mon, 24 Mar 2025 19:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9NVkJ3qy4Wc0KQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Mar 2025 19:28:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03B81A076A; Mon, 24 Mar 2025 20:28:57 +0100 (CET)
Date: Mon, 24 Mar 2025 20:28:57 +0100
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <jlnc33bmqefx3273msuzq3yyei7la2ttwzqyyavohzm2k66sl6@gtqq6jpueipz>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 24-03-25 10:34:56, James Bottomley wrote:
> On Mon, 2025-03-24 at 12:38 +0100, Jan Kara wrote:
> > On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> > > On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> > > [...]
> > > > Let me digest all that and see if we have more hope this time
> > > > around.
> > > 
> > > OK, I think I've gone over it all.  The biggest problem with
> > > resurrecting the patch was bugs in ext3, which isn't a problem now.
> > > Most of the suspend system has been rearchitected to separate
> > > suspending user space processes from kernel ones.  The sync it
> > > currently does occurs before even user processes are frozen.  I
> > > think
> > > (as most of the original proposals did) that we just do freeze all
> > > supers (using the reverse list) after user processes are frozen but
> > > just before kernel threads are (this shouldn't perturb the image
> > > allocation in hibernate, which was another source of bugs in xfs).
> > 
> > So as far as my memory serves the fundamental problem with this
> > approach was FUSE - once userspace is frozen, you cannot write to
> > FUSE filesystems so filesystem freezing of FUSE would block if
> > userspace is already suspended. You may even have a setup like:
> > 
> > bdev <- fs <- FUSE filesystem <- loopback file <- loop device <-
> > another fs
> > 
> > So you really have to be careful to freeze this stack without causing
> > deadlocks.
> 
> Ah, so that explains why the sys_sync() sits in suspend resume *before*
> freezing userspace ... that always appeared odd to me.
> 
> >  So you need to be freezing userspace after filesystems are
> > frozen but then you have to deal with the fact that parts of your
> > userspace will be blocked in the kernel (trying to do some write)
> > waiting for the filesystem to thaw. But it might be tractable these
> > days since I have a vague recollection that system suspend is now
> > able to gracefully handle even tasks in uninterruptible sleep.
> 
> There is another thing I thought about: we don't actually have to
> freeze across the sleep.  It might be possible simply to invoke
> freeze/thaw where sys_sync() is now done to get a better on stable
> storage image?  That should have fewer deadlock issues.

Well, there's not going to be a huge difference between doing sync(2) and
doing freeze+thaw for each filesystem. After you thaw the filesystem
drivers usually mark that the fs is in inconsistent state and that triggers
journal replay / fsck on next mount.
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

