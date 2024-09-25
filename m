Return-Path: <linux-fsdevel+bounces-30130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F5F9869ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 01:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB96F1C2472E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 23:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4761A3BB3;
	Wed, 25 Sep 2024 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJnnkDgp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+ekCn4w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJnnkDgp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+ekCn4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138F4A00;
	Wed, 25 Sep 2024 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307992; cv=none; b=LjwKG0J4M9rnpsW/SsqqQFdZ021DSVxkQv8MupU/gMGQ1uYXsFcjHi6QHE8mNk3HPK1SBooxcO3dHClzwrTd+3W0Cgj4chVtkgLtFVCN9Uq/xuBg1nE3xoLMuuIhlcUTJMSL7WiUkB3S5zvtJAvC7ENaro0rxdgaZwJSXjmpYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307992; c=relaxed/simple;
	bh=aAzCmZGcG1KVQTOp9gQdfKF3W4d9B2Eb0NL3I9vrEVE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=G1QvWBoX9r9ISnoZoChgnQf1KeAvJAggtYwqNVRWTVFRzKmEpLPIT0MCKuiWY5fAmpM6YAJz7ueKyOEoEptjDHM/RJ+JGqfvyTHos4xHOk1q5U0ZJ87t4dTxBePYdu7AlVd9+9rLYbpQVSThv6ZB7gNC7CreNoieI2ZJ2vJ/ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJnnkDgp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+ekCn4w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJnnkDgp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+ekCn4w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D580A1FC81;
	Wed, 25 Sep 2024 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727307987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+glDLPW6ncnO4s0TTCoLiSBvqjEXH47mXfmnqsflvU=;
	b=HJnnkDgpQflfeyls1g8zVvhtIVKc5obRo+buZBpGPO9UEIKRU5qBaX85aP7U5d4LUkVSiJ
	svftutZUEZ6rlglUv92UUcbm1L0ggn7mop9g4jjG6Oc/onWFUjpMWoOHU80YOQ0/dqkQlx
	GNP9KedXc3Sr8Q4TljKadCL0dbXCerU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727307987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+glDLPW6ncnO4s0TTCoLiSBvqjEXH47mXfmnqsflvU=;
	b=j+ekCn4w/WV5cX0mHxihDXCFMb2oaw/t9WCPr5dNVTnoiFHu0dETf2BRqWqZYvFmzCjDp6
	VlfzCpbbG5YzZZBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727307987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+glDLPW6ncnO4s0TTCoLiSBvqjEXH47mXfmnqsflvU=;
	b=HJnnkDgpQflfeyls1g8zVvhtIVKc5obRo+buZBpGPO9UEIKRU5qBaX85aP7U5d4LUkVSiJ
	svftutZUEZ6rlglUv92UUcbm1L0ggn7mop9g4jjG6Oc/onWFUjpMWoOHU80YOQ0/dqkQlx
	GNP9KedXc3Sr8Q4TljKadCL0dbXCerU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727307987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+glDLPW6ncnO4s0TTCoLiSBvqjEXH47mXfmnqsflvU=;
	b=j+ekCn4w/WV5cX0mHxihDXCFMb2oaw/t9WCPr5dNVTnoiFHu0dETf2BRqWqZYvFmzCjDp6
	VlfzCpbbG5YzZZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2795513793;
	Wed, 25 Sep 2024 23:46:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bFZWM9Cg9GbZBAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 23:46:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH - RFC] VFS: disable new delegations during
 delegation-breaking operations
In-reply-to: <20240925230640.GN3550746@ZenIV>
References: <>, <20240925230640.GN3550746@ZenIV>
Date: Thu, 26 Sep 2024 09:46:16 +1000
Message-id: <172730797623.17050.16390098481361439815@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 26 Sep 2024, Al Viro wrote:
> On Thu, Sep 26, 2024 at 08:42:06AM +1000, NeilBrown wrote:
> 
> > I don't think so.
> > The old delegated_inode_new will be carried in to vfs_rename() and
> > passed to try_break_deleg() which will notice that it is not-NULL and
> > will "do the right thing".
> > 
> > Both _old and _new are initialised to zero at the start of
> > do_renameat2(), Both are passed to break_deleg_wait() on the last time
> > through the retry_deleg loop which will drop the references - or will
> > preserve the reference if it isn't the last time - and both are only set
> > by try_break_deleg() which is careful to check if a prior value exists.
> > So I think there are no leaks.
> 
> Yecchhhh...  What happens if break_deleg() in there returns e.g. -ENOMEM
> when try_break_deleg() finds a matching inode?

I don't see that that changes the calculus at all.

> 
> I'm not even saying it won't work, but it's way too brittle for my taste ;-/
> 

I accept that the interactions are not immediately obvious and that is a
problem.  Maybe that could be fixed with documentation/code-comments.
I'm certainly open to suggestions for restructuring the code to make it
more obvious but as yet I cannot see a good alternative.  The separation
of responsibility between do_renameat2 and vfs_rename seems about right
as between do_linkat and vfs_link etc.  We want to keep the delegation
blocked all around the loop to the next retry.  Doing that through
delegated_inode (or _new and _old versions) seems to work....

What particularly seems brittle to you?  Maybe if I have one detail to
focus on.

Thanks,
NeilBrown


