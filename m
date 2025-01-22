Return-Path: <linux-fsdevel+bounces-39813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B0A18954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 02:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545A9161B3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0539FCE;
	Wed, 22 Jan 2025 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1c/qMyxX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1zUMpqS1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1c/qMyxX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1zUMpqS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8911BC41
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737507862; cv=none; b=QzalNUP4kvRKTIkPLptx0DCGiS8/fNsOyhX/ucBd88YlTC+ThRK9XCDZt/taKEFDm14u6Cr7Lw4Sjwv/1sI4U6aGgpu7AdiMc2O5cFG5TxPBBU6EJdsrNJBoBn5Tgf1HQDjwm8y+TE80VgTP5ixO0LsWpNYwhixRnPN3GHqfiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737507862; c=relaxed/simple;
	bh=B7NvvO11/hU8l+rCjA6Uo0g1A6Q36NqaSES5JNXLmp8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FzvWLBF6dgeGB37XNeOyzmm+T/fAymjQX2ZWPLYxYZy16WRrl8dT5PhLf2qpw7IjmdHqgo7JEApiTDTrmKB3nARI8mUEicTp08dy4yhaRq/h7qGojLC7N0fX5LnmACcoB4XVqysGL57dWrLWKDlrE6NJGNtXm4D+oLkLZZm6e6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1c/qMyxX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1zUMpqS1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1c/qMyxX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1zUMpqS1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B5C01F76C;
	Wed, 22 Jan 2025 01:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737507858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF5u+ntZa9FE72IZoiG+WP+p3Qbsnt4h0JVpMz640iQ=;
	b=1c/qMyxX7a4xwZmVgBYu7BK3a+54Zq/bQI8khC+jHHsp1M8KICIBiy2P37W0iRpS0vblad
	SVDvuRiwM09N+nfLmdvmVV71LHWk3yFZqo5t+hfRYYFfT4v2p07OhZGGtmmNeVUx+up+Uv
	WtINwuxs+1tv8N1Jr9kE62R4BoDzBn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737507858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF5u+ntZa9FE72IZoiG+WP+p3Qbsnt4h0JVpMz640iQ=;
	b=1zUMpqS14g66PSqqZ4u8gce8YxCgSr3hIMN0N3c+9m8d7vHrKRbaq6QE8YL2BuYRgN7a7i
	sL/7egtiWypfLqDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737507858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF5u+ntZa9FE72IZoiG+WP+p3Qbsnt4h0JVpMz640iQ=;
	b=1c/qMyxX7a4xwZmVgBYu7BK3a+54Zq/bQI8khC+jHHsp1M8KICIBiy2P37W0iRpS0vblad
	SVDvuRiwM09N+nfLmdvmVV71LHWk3yFZqo5t+hfRYYFfT4v2p07OhZGGtmmNeVUx+up+Uv
	WtINwuxs+1tv8N1Jr9kE62R4BoDzBn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737507858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF5u+ntZa9FE72IZoiG+WP+p3Qbsnt4h0JVpMz640iQ=;
	b=1zUMpqS14g66PSqqZ4u8gce8YxCgSr3hIMN0N3c+9m8d7vHrKRbaq6QE8YL2BuYRgN7a7i
	sL/7egtiWypfLqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EB251387C;
	Wed, 22 Jan 2025 01:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UT2VFBBEkGfaVQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 01:04:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, lsf-pc@lists.linuxfoundation.org,
 "Al Viro" <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
In-reply-to: <Z5A6KtmOMoWk20xM@dread.disaster.area>
References: <>, <Z5A6KtmOMoWk20xM@dread.disaster.area>
Date: Wed, 22 Jan 2025 12:04:13 +1100
Message-id: <173750785326.22054.5037117181033985400@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 22 Jan 2025, Dave Chinner wrote:
> 
> Anyone who has been following io_uring development should know all
> these things about async processing already. There's a reason that
> that infrastructure exists: async processing is more efficient and
> faster than the concurrent synchronous processing model being
> proposed here....

I understand that asynchronous is best.  I think we are a long way from
achieving that.  I think shared locking is still a good step in that
direction.

Shared locking allows the exclusion to be pushed down into the
filesystem to whatever extend the filesystem needs.  That will be needed
for an async approach too.

We already have a hint of async in the dcache in that ->lookup() can
complete without a result if an intent flag is set.  The actually lookup
might then happen any time before the intended operation completes.  For
NFS exclusive open, that lookup is combined with the create/open.  For
unlink (which doesn't have an intent flag yet) it could be combined with
the nfs REMOVE operation (if that seemed like a good idea).  Other
filesystems could do other things.  But this is just a hint of aysnc as
yet.

I imagine that in the longer term we could drop the i_rwsem completely
for directories.  The VFS would set up a locked dentry much like it does
before ->lookup and then calls into the filesystem.  The filesystem
might do the op synchronously or might take note of what is needed and
schedule the relevant changes or whatever.  When the op finished it does
clear_and_wake_up_bit() (or similar) after stashing the result ...
somewhere.

For synchronous operations like syscalls, an on-stack result struct would
be passed which contains an error status and optionally a new dentry (if
e.g. mkdir found it needed to splice in an existing dentry).

For async operations io_uring would allocate the result struct and would
store in it a callback function to be called after the
clear_and_wake_up_bit(). 

Rather than using i_rwsem to block additions to a directory while it is
being removed, we would lock the dentry (so no more locked children can
be added) and wait for any locked children to be unlocked.

There are doubtless details that I have missed but it is clear that to
allow async dirops we need to remove the need for i_rwsem, and I think
transitioning from exclusive to shared is a useful step in that
direction.

I'm almost tempted to add the result struct to the new _shared
inode_operations that I want to add, but that would likely be premature.

Thanks,
NeilBrown

