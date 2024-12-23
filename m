Return-Path: <linux-fsdevel+bounces-38011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18189FA9A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 04:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5FD162D60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1BA8624B;
	Mon, 23 Dec 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="InSththi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a6TJnzjs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="InSththi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a6TJnzjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F4E56C;
	Mon, 23 Dec 2024 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734923419; cv=none; b=tBIAQXoMEnoSaMqIZpS6O2r/oXRKjPj2ulW68zCopvODgTSIEphOHsu2//Iua/SAf5PDRhkAzn3IS25dF/rQ7eOBabeIktzr9FsEz/DXmx7Mo3LYmaKQ+gLwaQmaPYku0BmbIBy6o8Q8YtCq7yMzjq4vN5cS7V63exkIDxnJKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734923419; c=relaxed/simple;
	bh=08s5/yMikxWGd+nsFpjZQeZDxUSczQPgVF69pfK9AWA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=II75ZoAonHymVVF2HmcNDgrS6+YWq6tlSotWP464Yfb3Rf8tJe7KAucpkhLCr+qPnB4rUw6s4M9t+ev7d8X3aayfpD8Nr68KHGLGw+stlsTEOHHRhTIWuEwch6ki5o0IiRhbdYLPICIlw//7tIxuo9ZJknyjhxhD0toRn7m627c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=InSththi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a6TJnzjs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=InSththi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a6TJnzjs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BAE51F38D;
	Mon, 23 Dec 2024 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734923414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ddFWJy7zs9oCDYfpZsv0LCBYdrU1857cNzAeIpY0tY=;
	b=InSththiPsEp7jimIXJz14xqnA2K5u6R5tQCNwjvuMarKp1JEfp9XCn5Iz6PGIYMu2nwtT
	kx8OiIXHx3gHzGa2YyYdUkAZvlufS/QJMQaa9x4SPiGTqdkcbTv5trY5P6x1cbF8vo1bK8
	BCZQ//z0Xq4SesPu4bNZL06uo1QO5Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734923414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ddFWJy7zs9oCDYfpZsv0LCBYdrU1857cNzAeIpY0tY=;
	b=a6TJnzjs7l7EP5q/QYWgh65kZreareWkx4q4ttKhwJE/LI6VcpTGt1JQ/5TF69mfZoniZ2
	dBh6Kkrk71IvksBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=InSththi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a6TJnzjs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734923414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ddFWJy7zs9oCDYfpZsv0LCBYdrU1857cNzAeIpY0tY=;
	b=InSththiPsEp7jimIXJz14xqnA2K5u6R5tQCNwjvuMarKp1JEfp9XCn5Iz6PGIYMu2nwtT
	kx8OiIXHx3gHzGa2YyYdUkAZvlufS/QJMQaa9x4SPiGTqdkcbTv5trY5P6x1cbF8vo1bK8
	BCZQ//z0Xq4SesPu4bNZL06uo1QO5Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734923414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ddFWJy7zs9oCDYfpZsv0LCBYdrU1857cNzAeIpY0tY=;
	b=a6TJnzjs7l7EP5q/QYWgh65kZreareWkx4q4ttKhwJE/LI6VcpTGt1JQ/5TF69mfZoniZ2
	dBh6Kkrk71IvksBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDCAD13485;
	Mon, 23 Dec 2024 03:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U5U1HJPUaGc1FAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 23 Dec 2024 03:10:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Hillf Danton" <hdanton@sina.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] VFS: add inode_dir_lock/unlock
In-reply-to: <20241221012128.307-1-hdanton@sina.com>
References: <20241220030830.272429-1-neilb@suse.de>,
 <20241221012128.307-1-hdanton@sina.com>
Date: Mon, 23 Dec 2024 14:10:07 +1100
Message-id: <173492340768.11072.6052736961769187676@noble.neil.brown.name>
X-Rspamd-Queue-Id: 7BAE51F38D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[sina.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sina.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 21 Dec 2024, Hillf Danton wrote:
> On Fri, 20 Dec 2024 13:54:26 +1100 NeilBrown <neilb@suse.de>
> > During the transition from providing exclusive locking on the directory
> > for directory modifying operation to providing exclusive locking only on
> > the dentry with a shared lock on the directory - we need an alternate
> > way to provide exclusion on the directory for file systems which haven't
> > been converted.  This is provided by inode_dir_lock() and
> > inode_dir_inlock().
> > This uses a bit in i_state for locking, and wait_var_event_spinlock() for
> > waiting.
> > 
> Inventing anything like mutex sounds bad.

In general I would agree.  But when the cost of adding a mutex exceeds
the cost of using an alternate solution that only requires 2 bits, I
think the alternate solution is justified.

> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -722,6 +722,8 @@ struct inode {
> >  		void (*free_inode)(struct inode *);
> >  	};
> >  	struct file_lock_context	*i_flctx;
> > +
> > +	struct lockdep_map	i_dirlock_map;	/* For tracking I_DIR_LOCKED locks */
> 
> The cost of this map says no to any attempt inventing mutex in any form.
> 

"struct lockdep_map" is size-zero when lockdep is not enabled.  And when
it is enabled we accept the cost of larger structures to benefit from
deadlock detection.
So I don't think this is a sound argument.

Thanks for the review,
NeilBrown

