Return-Path: <linux-fsdevel+bounces-30334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126AC989EFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB541C21DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39393191F82;
	Mon, 30 Sep 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gEClIPl/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzfgXMXM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gEClIPl/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzfgXMXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A019190497;
	Mon, 30 Sep 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690165; cv=none; b=fQuNbCjilR9nLbv808lBlDxQcmKaToF6eDPZL4dd+DVcgGprS0zggTKmD1tvaRu+wCwcpyt6sWyNnvTUopoYRWtwPSh/T3u95MXqHfrLL14z+mB122R31lAM68boDPGEAtq56+oIS8P6+HNTZg0amNSKn/V7S1At9DGHSo5pnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690165; c=relaxed/simple;
	bh=gnBJBCW+qI7IoYGB45XZ495lYAcX04yoJWuiFKPsDtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXRSq/sqTaP3kvK3s2wq3bJCAdeSTxzTzTt5C7KJrj+1pKFa1ZNBNFQQcz0V430h8RVztFoEQ1XEErPislKlnHJoIP2nwYoDv0CTD7GI6XcqLdnmPOfvIKisjbgMfJIjyv1P4J4sICGMlbSF1lblbscRcI/YILHvopwzledw8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gEClIPl/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzfgXMXM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gEClIPl/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzfgXMXM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE67C21982;
	Mon, 30 Sep 2024 09:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727690161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecK9RWVhfnMj9sHyvPLPlMFBEWiyO29qs4MRNMFhoLk=;
	b=gEClIPl/3teTHMDqvx31s+FiFLD7ZbAfrDv5Q6veLnnCiFXwulVkVhqlop+Amshfycb0qp
	ApO5lWwRuyHnFx7HZJmDW/OwirznV84J+P4gfDQPCyUmh1M9iPMdLJJ7QKY5Kau2+BBpX4
	U25JdXKkJY7f8VHDCU5btUgzsk4BE0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727690161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecK9RWVhfnMj9sHyvPLPlMFBEWiyO29qs4MRNMFhoLk=;
	b=gzfgXMXM4rtacDzsUWiVjMbGLfTHl9joj/ANx0pI3RpQ/PAIvGeLJVfq6X05NEnCMzIdqQ
	LeiegCiIP49wP1AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727690161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecK9RWVhfnMj9sHyvPLPlMFBEWiyO29qs4MRNMFhoLk=;
	b=gEClIPl/3teTHMDqvx31s+FiFLD7ZbAfrDv5Q6veLnnCiFXwulVkVhqlop+Amshfycb0qp
	ApO5lWwRuyHnFx7HZJmDW/OwirznV84J+P4gfDQPCyUmh1M9iPMdLJJ7QKY5Kau2+BBpX4
	U25JdXKkJY7f8VHDCU5btUgzsk4BE0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727690161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecK9RWVhfnMj9sHyvPLPlMFBEWiyO29qs4MRNMFhoLk=;
	b=gzfgXMXM4rtacDzsUWiVjMbGLfTHl9joj/ANx0pI3RpQ/PAIvGeLJVfq6X05NEnCMzIdqQ
	LeiegCiIP49wP1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2FF913A8B;
	Mon, 30 Sep 2024 09:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9sjQJ7F1+maMNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 09:56:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E1B3A0845; Mon, 30 Sep 2024 11:56:01 +0200 (CEST)
Date: Mon, 30 Sep 2024 11:56:01 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Max Brener <linmaxi@gmail.com>, adilger.kernel@dilger.ca,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] vfs/ext4: Fixed a potential problem related to
 an infinite loop
Message-ID: <20240930095601.x66iqw74bxffytgq@quack3>
References: <20240926221103.24423-1-linmaxi@gmail.com>
 <20240927155019.GA365622@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927155019.GA365622@mit.edu>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,dilger.ca,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 27-09-24 08:50:19, Theodore Ts'o wrote:
> On Fri, Sep 27, 2024 at 01:11:03AM +0300, Max Brener wrote:
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219306
> > 
> > This patch fixes a potential infinite journal-truncate-print
> > problem.  When systemd's journald is called, ftruncate syscall is
> > called. If anywhere down the call stack of ftruncate a printk of
> > some sort happens, it triggers journald again therefore an infinite
> > loop is established.
> 
> This isn't a good justification for this change; in general, whenever
> you have code paths which get triggered when a logging daemon is
> triggered, whether it's systemd-journald, or syslog, and this can
> cause this kind of infinite loop.  For example, suppose you are using
> remote logging (where a log message gets sent over the network via the
> remote syslog facility), and anything in the networking stack triggers
> a printk, that will also trigger an "infinite loop".  This falls in
> the "Doctor, doctor, it hurts when I do that --- so don't do that!"
> 
> In this particular situation, journald is doing something silly/stupid
> which is whenver a message is logged, it is issuing a no-op ftruncate
> to the journald log file.  It's also worth noting that ext4's truncate
> path does *not* trigger a printk unless something really haw gone
> wrong (e.g., a WARN_ON when a kernel bug has happened and flags in the
> in-memory get erronously set, or the file system gets corrupted and
> this gets reported via ext4_error()).  The reporter discovered this by
> explicitly adding a printk in their privatea kernel sources, and in
> general, when you add random changes to the kernel, any unfortunate
> consequences are not something that upstream code can be expected to
> defend against.
> 
> For context, see: https://bugzilla.kernel.org/show_bug.cgi?id=219306

Right, loops like these are not something we should be fixing in the
kernel.

> We can justify an optimization here so that in the case of
> silly/stupid userspace programs which are constnatly calling
> truncate(2) which are no-ops, we can optimize ext4's handling of these
> silly/stupid programs.  The ext4_truncate() code path causes starting
> a journal handle, adding the inode to the orphan list, and then
> removing it at the end of the truncate.  In the case where sopme
> program calls truncate() in a tight loop, we can optimize the
> behaviour.  It's not a high priority optimization, but if given that
> we can't necessarily change silly/stupid userspace programmers, it can
> be something that we can do if the patch is too invasive.
> 
> HOWEVER....
> 
> 
> > To fix this issue:
> > Add  a new inode flag S_TRUNCATED which helps in stopping such an infinite loop by marking an in-memory inode as already truncated.
> 
> Adding a generic VFS-level flag is not something that we can justify
> here.  The VFS maintainers would NACK such a change, and deservedly
> so.
> 
> What I had in mind was to define a new EXT4 state flag, say,
> EXT4_STATE_TRUNCATED, and then test, set, and clear it using
> ext4_{test,set,clear}_inode_state().

Agreed as well. I'll also note that keeping such flag uptodate is not as
simple as it seems because there are various places that may be allocating
blocks beyond EOF (for example extending writes) and that rely on
ext4_truncate() removing them so one needs to be careful to capture all the
places where the "truncated" state needs to be cleared.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

