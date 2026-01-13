Return-Path: <linux-fsdevel+bounces-73357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB38D161F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36BB9302350D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F3258EDE;
	Tue, 13 Jan 2026 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pKv8z2ox";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6pcCcDm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pKv8z2ox";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6pcCcDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AC1F0994
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267008; cv=none; b=ZQfgqh10HJ/KDv7D2k/W90wF9DMSfJp62P28LsXUcWRW0Zu+qW/Hnb4QOC6to81VAYvujYi+or+K5KEbTmMPKZjA3a0muRtMcV2I58m3YRVblEHMxrlAMDYlIstHEx+qfSBdz3wKc2JwCWFK3Z9wJaKonvSDJu2uIAX6i7h/Tuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267008; c=relaxed/simple;
	bh=djBWa+XMlG8cwKTqK0P3z9WeEz5BN/jNopwApiz8rwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/6W1QqIlf2C6pJCtKDDcP4iC8hpsQJiCC2rkvDnHEvWKd6Q4ZIhWd2qpVCgtitLyvpqlVzAT1V9nsm0e9Id6N1Eo1NKQdNTi0Y1wcrlAfzvqp0ITGpxK2GgyjUhdps8S/euLbnLuwaoLqhPkRTdYlF5/ar5XtRWpZauReGKBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pKv8z2ox; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6pcCcDm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pKv8z2ox; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6pcCcDm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2451D5BCC1;
	Tue, 13 Jan 2026 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768267005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W/p8ddSWSauUZLbrkD75ylquNSpAXepQcyM6euHzLY=;
	b=pKv8z2oxIL//3ef0vEOQazP9eZgvqjJYCjiVgTjJ2L3jCNMizZTmTumzv/1TZHylZv8g7B
	zz84NMWspJ6JpnuVRNt8hswYCzqpI7/QARaQGyKPyR85URCnITLVyQzA3VrCkphWf3vZl2
	iynVqv5b3oIj/qU+QSUXZClavH0y7GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768267005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W/p8ddSWSauUZLbrkD75ylquNSpAXepQcyM6euHzLY=;
	b=p6pcCcDmH3/T/TeyBoQkEpu1p35uO/pg1mS/7sy8Thb5/GpoSbCxipWnCloUHl+qLO2Ng7
	AYRsJvEs4fPBCWDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pKv8z2ox;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p6pcCcDm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768267005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W/p8ddSWSauUZLbrkD75ylquNSpAXepQcyM6euHzLY=;
	b=pKv8z2oxIL//3ef0vEOQazP9eZgvqjJYCjiVgTjJ2L3jCNMizZTmTumzv/1TZHylZv8g7B
	zz84NMWspJ6JpnuVRNt8hswYCzqpI7/QARaQGyKPyR85URCnITLVyQzA3VrCkphWf3vZl2
	iynVqv5b3oIj/qU+QSUXZClavH0y7GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768267005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W/p8ddSWSauUZLbrkD75ylquNSpAXepQcyM6euHzLY=;
	b=p6pcCcDmH3/T/TeyBoQkEpu1p35uO/pg1mS/7sy8Thb5/GpoSbCxipWnCloUHl+qLO2Ng7
	AYRsJvEs4fPBCWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F64D3EA63;
	Tue, 13 Jan 2026 01:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pZqdA/2cZWnqUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Jan 2026 01:16:45 +0000
Date: Tue, 13 Jan 2026 02:16:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4] btrfs: stop duplicating VFS code for
 subvolume/snapshot dentry
Message-ID: <20260113011643.GY21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767801889.git.fdmanana@suse.com>
 <20260112-wonach-mochten-cd6c14b298ae@brauner>
 <CAL3q7H5xB1RFQK6fn1KL73AiGr-A+SoKCFH1pfwBTxHCkHPXCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5xB1RFQK6fn1KL73AiGr-A+SoKCFH1pfwBTxHCkHPXCg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 2451D5BCC1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Mon, Jan 12, 2026 at 01:49:07PM +0000, Filipe Manana wrote:
> On Mon, Jan 12, 2026 at 12:48 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jan 08, 2026 at 01:35:30PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Currently btrfs has copies of two unexported functions from fs/namei.c
> > > used in the snapshot/subvolume creation and deletion. This patchset
> > > exports those functions and makes btrfs use them, to avoid duplication
> > > and the burden of keeping the copies up to date.
> >
> > Seems like a good idea to me.
> > Let me know once it's ready and I'll give you a stable branch with the
> > VFS bits applied where you can apply the btrfs specific changes on top.
> 
> Right now what's missing is just an update to the changelog of patch
> 4/4 to mention that the btrfs copy is missing the audit_inode_child()
> call.
> 
> If there are no other comments, I can prepare a v2 with that update,
> and then you can pick the patches into a branch.
> For the btrfs patches, you can probably pick them too as they are
> trivial, though I'll defer to David in case he has a different
> preference.

I agree that this is relatively trivial, also it does not affect
anything in particular we have in for-next, so Christian feel free to
take it via the vfs trees. Thanks.

