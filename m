Return-Path: <linux-fsdevel+bounces-28469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1B96B03D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8899B21659
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4386782488;
	Wed,  4 Sep 2024 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uD8Dl0ez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uiSdU6EO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uD8Dl0ez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uiSdU6EO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3D26AC3;
	Wed,  4 Sep 2024 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426119; cv=none; b=iZg2OxSH0t6NVYSHM1KQOclQAr0cy0xOR/sUU6YrR9LBC8mRj4vAe7JF3dVTjan9Ir8gRcqzbh9IZpXAzUaMJHdH0rhTxmW6SPb35pNDQTudOwz3q6khAiAYdNdJ7WPt5r0/QFPQgYB2TauvXrK9aRtSd1SEXb9KvTTBMk2OJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426119; c=relaxed/simple;
	bh=L4SmsfdSbQ/CACxT4/EzbAti9/EvpVqhJ5WjEBj6Wgg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=euW+AcaduP3ZnE17jwCf3Zwugoxr1pIM9TtiIv9KKkQBaNrGWyDl39xF+ICJyHDGdyo92D2K59egO8Hl4zpGCdB7oXNbN/JUehVq9bWMSNmMAo6pN1C+il8jcsr9pSx54qQdOS7AuRcCPKLmwB3vMIwjRbe0UYCDUBk681Uzbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uD8Dl0ez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uiSdU6EO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uD8Dl0ez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uiSdU6EO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1B1B21B3F;
	Wed,  4 Sep 2024 05:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725426115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DCKC1vUzbjPxbcJMU8GVyjZBWkNGVKM+7nqGXZ5ObE=;
	b=uD8Dl0ezRJuSwshFo/w0zUb7yRkwldC8PMoKjOGNqEFvo2iqQ3083yRE8MmZPWyD/cIkCF
	t55FrJBVq7N9oY3laMwWHaEBfMbno+CgXmY2HrDfOym581IH1A9UrDpiUDctOZBOB75rcH
	Wl8pZ3AW4CjkPbzOc9+qjg/w7kee6pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725426115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DCKC1vUzbjPxbcJMU8GVyjZBWkNGVKM+7nqGXZ5ObE=;
	b=uiSdU6EOjnOqJVQ31s6uAncFVAfJCKTo7ahCDVsXZGxXO2k6JzkGkPS4r6ezubj+4PZg5l
	h/n+p1XFDlnNfuBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uD8Dl0ez;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uiSdU6EO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725426115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DCKC1vUzbjPxbcJMU8GVyjZBWkNGVKM+7nqGXZ5ObE=;
	b=uD8Dl0ezRJuSwshFo/w0zUb7yRkwldC8PMoKjOGNqEFvo2iqQ3083yRE8MmZPWyD/cIkCF
	t55FrJBVq7N9oY3laMwWHaEBfMbno+CgXmY2HrDfOym581IH1A9UrDpiUDctOZBOB75rcH
	Wl8pZ3AW4CjkPbzOc9+qjg/w7kee6pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725426115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DCKC1vUzbjPxbcJMU8GVyjZBWkNGVKM+7nqGXZ5ObE=;
	b=uiSdU6EOjnOqJVQ31s6uAncFVAfJCKTo7ahCDVsXZGxXO2k6JzkGkPS4r6ezubj+4PZg5l
	h/n+p1XFDlnNfuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A8B7139E2;
	Wed,  4 Sep 2024 05:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QUq2BMHp12ZhRQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 04 Sep 2024 05:01:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
In-reply-to: <172540270112.4433.6741926579586461095@noble.neil.brown.name>
References: <>, <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>,
 <172540270112.4433.6741926579586461095@noble.neil.brown.name>
Date: Wed, 04 Sep 2024 15:01:46 +1000
Message-id: <172542610641.4433.9213915589635956986@noble.neil.brown.name>
X-Rspamd-Queue-Id: B1B1B21B3F
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 04 Sep 2024, NeilBrown wrote:
> 
> I agree that dropping and reclaiming a lock is an anti-pattern and in
> best avoided in general.  I cannot see a better alternative in this
> case.

It occurred to me what I should spell out the alternate that I DO see so
you have the option of disagreeing with my assessment that it isn't
"better".

We need RCU to call into nfsd, we need a per-cpu ref on the net (which
we can only get inside nfsd) and NOT RCU to call
nfsd_file_acquire_local().

The current code combines these (because they are only used together)
and so the need to drop rcu. 

I thought briefly that it could simply drop rcu and leave it dropped
(__releases(rcu)) but not only do I generally like that LESS than
dropping and reclaiming, I think it would be buggy.  While in the nfsd
module code we need to be holding either rcu or a ref on the server else
the code could disappear out from under the CPU.  So if we exit without
a ref on the server - which we do if nfsd_file_acquire_local() fails -
then we need to reclaim RCU *before* dropping the ref.  So the current
code is slightly buggy.

We could instead split the combined call into multiple nfs_to
interfaces.

So nfs_open_local_fh() in nfs_common/nfslocalio.c would be something
like:

 rcu_read_lock();
 net = READ_ONCE(uuid->net);
 if (!net || !nfs_to.get_net(net)) {
       rcu_read_unlock();
       return ERR_PTR(-ENXIO);
 }
 rcu_read_unlock();
 localio = nfs_to.nfsd_open_local_fh(....);
 if (IS_ERR(localio))
       nfs_to.put_net(net);
 return localio;

So we have 3 interfaces instead of 1, but no hidden unlock/lock.

As I said, I don't think this is a net win, but reasonable people might
disagree with me.

NeilBrown

