Return-Path: <linux-fsdevel+bounces-41147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BACFA2B8C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DE81889610
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 02:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51968154433;
	Fri,  7 Feb 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SnWEa4SY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ekkKvSWb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0BKrocW0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TmUljUJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB52417D3;
	Fri,  7 Feb 2025 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894731; cv=none; b=jwTSTAKs2RoMEmb/E9QrAf/+UgcILcgnBUZ28T9FBdzstv78m90Qr6GOrZhIjdbnWM0y5+KvmmY16cq1pazsKazvef00jQuSc2s/ooNo1eFvthUM+DVjc9SxdVUf+9Kyx45wyh08PRWfgGNbDXm3dTJo2QL744IrpUGI5SMEUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894731; c=relaxed/simple;
	bh=eBJ4MKF2btEfRheuQVfnnfaWaVzA98jDYwckTrBPRxo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WwWTpbk237HFA5tskOE7dWY7YJWVGX4DA4WDLFG8FcudaQJzpH52WENEpbMK0+UO1WE1SSt4PAbRvekUi/x3rEpjFH4ylgh4kufVnWycJfCu9xwLMV3KLYTZ/t7H9mnsKkKB8qeyBCVT7M+qGbNHpo49i8Iggie58d3FBXSVkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SnWEa4SY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ekkKvSWb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0BKrocW0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TmUljUJE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B7AD1F38D;
	Fri,  7 Feb 2025 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738894728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ojTZ7GNZ4r0iEpy1ST+C4JokmOugEUMS5YPq/REzYE=;
	b=SnWEa4SY4NN1RgHpu2ryr9AlPmJkVA1/kge2BKjb1gWG8/IrjJc1G5N9UAoiByC9x5afk2
	5pV8HqRfuFmm5oFqnBsR6NznSGvcDjsDAFsjdTZUPV9BTeTI/zope9SWNan34CydF7kH21
	xCpQcPW0Zt1ShSrwX4UzmvynE2a2OAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738894728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ojTZ7GNZ4r0iEpy1ST+C4JokmOugEUMS5YPq/REzYE=;
	b=ekkKvSWbZhjYtAOMBOeg8AQAHtae4BHBp8Rvm0tm58i9ybCI2vW6kK38AN5zFSDga2EgSR
	ngbgfidC42iG+DDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738894727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ojTZ7GNZ4r0iEpy1ST+C4JokmOugEUMS5YPq/REzYE=;
	b=0BKrocW068cwt+ha6Am2uqLUa3Im5lp/77rvieMFphiEc5CaFVFpy0obiUc851nbnrDvN8
	SCnXz204ecXWSzEICvvTmzQQBVk1fRDKovNPnkugrlDnDx3vIUHqJfnUIZ3V7ttdr4njew
	PAIVINQPP7QHLwPD8DjhL7b1B+dcPDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738894727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ojTZ7GNZ4r0iEpy1ST+C4JokmOugEUMS5YPq/REzYE=;
	b=TmUljUJEwuXRF3GoXRADez/mSnxuJKfUTzHHGVD+K9r38pepsNgbDbEdbOx8uE6jbY9nvY
	SbC5Uh9+zw6GZcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F9C313806;
	Fri,  7 Feb 2025 02:18:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id onfmOINtpWdQawAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 02:18:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "John Stoffel" <john@stoffel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 00/19 v7?] RFC: Allow concurrent and async changes in a directory
In-reply-to: <26532.55014.864941.551897@quad.stoffel.home>
References: <20250206054504.2950516-1-neilb@suse.de>,
 <26532.55014.864941.551897@quad.stoffel.home>
Date: Fri, 07 Feb 2025 13:18:41 +1100
Message-id: <173889472120.22054.9081398929242818418@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, John Stoffel wrote:
> >>>>> "NeilBrown" == NeilBrown  <neilb@suse.de> writes:
> 
> > This is my latest attempt at removing the requirement for an exclusive
> > lock on a directory which performing updates in this.  This version,
> > inspired by Dave Chinner, goes a step further and allow async updates.
> 
> This initial sentence reads poorly to me.  I think you maybe are
> trying to say:
> 
>   This is my latest attempt to removing the requirement for writers to
>   have an exclusive lock on a directory when performing updates on
>   entries in that directory.  This allows for parallel updates by
>   multiple processes (connections? hosts? clients?) to improve scaling
>   of large filesystems. 
> 
> I get what you're trying to do here, and I applaud it!  I just
> struggled over the intro here.  

Yes, my intro was rather poorly worded.  I think your version is much
better.  Thanks.

NeilBrown

> 
> 
> > The inode operation still requires the inode lock, at least a shared
> > lock, but may return -EINPROGRES and then continue asynchronously
> > without needing any ongoing lock on the directory.
> 
> > An exclusive lock on the dentry is held across the entire operation.
> 
> > This change requires various extra checks.  rmdir must ensure there is
> > no async creation still happening.  rename between directories must
> > ensure non of the relevant ancestors are undergoing async rename.  There
> > may be or checks that I need to consider - mounting?
> 
> > One other important change since my previous posting is that I've
> > dropped the idea of taking a separate exclusive lock on the directory
> > when the fs doesn't support shared locking.  This cannot work as it
> > doeesn't prevent lookups and filesystems don't expect a lookup while
> > they are changing a directory.  So instead we need to choose between
> > exclusive or shared for the inode on a case-by-case basis.
> 
> > To make this choice we divide all ops into four groups: create, remove,
> > rename, open/create.  If an inode has no operations in the group that
> > require an exclusive lock, then a flag is set on the inode so that
> > various code knows that a shared lock is sufficient.  If the flag is not
> > set, an exclusive lock is obtained.
> 
> > I've also added rename handling and converted NFS to use all _async ops.
> 
> > The motivation for this comes from the general increase in scale of
> > systems.  We can support very large directories and many-core systems
> > and applications that choose to use large directories can hit
> > unnecessary contention.
> 
> > NFS can easily hit this when used over a high-latency link.
> > Lustre already has code to allow concurrent directory updates in the
> > back-end filesystem (ldiskfs - a slightly modified ext4).
> > Lustre developers believe this would also benefit the client-side
> > filesystem with large core counts.
> 
> > The idea behind the async support is to eventually connect this to
> > io_uring so that one process can launch several concurrent directory
> > operations.  I have not looked deeply into io_uring and cannot be
> > certain that the interface I've provided will be able to be used.  I
> > would welcome any advice on that matter, though I hope to find time to
> > explore myself.  For now if any _async op returns -EINPROGRESS we simply
> > wait for the callback to indicate completion.
> 
> > Test status:  only light testing.  It doesn't easily blow up, but lockdep
> > complains that repeated calls to d_update_wait() are bad, even though
> > it has balanced acquire and release calls. Weird?
> 
> > Thanks,
> > NeilBrown
> 
> >  [PATCH 01/19] VFS: introduce vfs_mkdir_return()
> >  [PATCH 02/19] VFS: use global wait-queue table for d_alloc_parallel()
> >  [PATCH 03/19] VFS: use d_alloc_parallel() in lookup_one_qstr_excl()
> >  [PATCH 04/19] VFS: change kern_path_locked() and
> >  [PATCH 05/19] VFS: add common error checks to lookup_one_qstr()
> >  [PATCH 06/19] VFS: repack DENTRY_ flags.
> >  [PATCH 07/19] VFS: repack LOOKUP_ bit flags.
> >  [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
> >  [PATCH 09/19] VFS: add _async versions of the various directory
> >  [PATCH 10/19] VFS: introduce inode flags to report locking needs for
> >  [PATCH 11/19] VFS: Add ability to exclusively lock a dentry and use
> >  [PATCH 12/19] VFS: enhance d_splice_alias to accommodate shared-lock
> >  [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races with
> >  [PATCH 14/19] VFS: Ensure no async updates happening in directory
> >  [PATCH 15/19] VFS: Change lookup_and_lock() to use shared lock when
> >  [PATCH 16/19] VFS: add lookup_and_lock_rename()
> >  [PATCH 17/19] nfsd: use lookup_and_lock_one() and
> >  [PATCH 18/19] nfs: change mkdir inode_operation to mkdir_async
> >  [PATCH 19/19] nfs: switch to _async for all directory ops.
> 
> 


