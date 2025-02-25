Return-Path: <linux-fsdevel+bounces-42620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564BA450FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D1C3B1010
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC12397B9;
	Tue, 25 Feb 2025 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b0Z8Q6dE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TMJ48QRy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g/NmvE+S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xGh/dqoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE069213E8A
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526850; cv=none; b=kl9Z7VNdxT29eK9hw4WcEeTJKpSGofOLnt2mZJBrQWTzYJS3VoOprIWDZ/2b1fZa+QBH+IdCH/9ffUea0FNXINL6PjKAuKfPeqCKDwPpx7PIfs5HdUJUECN9llnJ9fU+ifapjCjParSSxMtjDQOSh74/XTeZGxoYs8rHNk+FGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526850; c=relaxed/simple;
	bh=i7SxX0xNLBff0AWCQaga4UIjHUiWqCNFiJzwI9/PH/c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AxIlQHXEgPuODb/zay77T7pLYkc3m/8YkQthpBE9U2zdkfZ57RGZ/EB41Y+kucXyF82ctAbhBbmxnSFxbmbSesJ5RB904kyEN/dv2pMKdRe2WosJScDSRHiy2brjDZ+wa16C/QK7ooYRPfjOSxSqsljYDUewfYVVl/vc4XqBZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b0Z8Q6dE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TMJ48QRy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g/NmvE+S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xGh/dqoi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD5431F45E;
	Tue, 25 Feb 2025 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740526847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB8Say7WCeSNzFaOwDcDvQZqUH8Z57djXSpx+ls4sLg=;
	b=b0Z8Q6dEo/ld/ANncpWuyyIPrHVP2yINRI7NduBf86BskKIrNmO1QayobXo/64vJl5WMvC
	SLkQHP5G+bVEH7MRwKVTJK5uEyDKhwAr+WddPWBnehsokO4Wp5MI5kSbtzBaFpXbS/2jiE
	tKAB4tN6PORP0/qTzTMCh9cB2g1A2Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740526847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB8Say7WCeSNzFaOwDcDvQZqUH8Z57djXSpx+ls4sLg=;
	b=TMJ48QRyWMo1g5/RsSJn6wkzJyV8HG/BVs1IBN6AvYFrkB2we64Hrutoa+dUfOSp4ZdAhQ
	KVUIDtDIS0m4PtBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="g/NmvE+S";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="xGh/dqoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740526845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB8Say7WCeSNzFaOwDcDvQZqUH8Z57djXSpx+ls4sLg=;
	b=g/NmvE+SitEcy3XdQGTn/cylyazcr9lwmPTQvsFRg8uiFgHEeGV97whnZBQ88Inl3xF4pK
	XZkgoSKOFCGHVYN0ZTO6NLtAdLt/aDZK8XB6IymuOB8MaBq9S54a6cU2C/zd2eFd0uKfX4
	9nIXBi8YjYbEkJPmMMANz8kIe4voonM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740526845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB8Say7WCeSNzFaOwDcDvQZqUH8Z57djXSpx+ls4sLg=;
	b=xGh/dqoiuMCONbWrP27eGAKpUoShO9tXB38aknl1LDgVtIcHjXHqY4Kntbd121mnaf2BBZ
	9PPNAErelOLIjWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 692BE13332;
	Tue, 25 Feb 2025 23:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZW7MB/tUvmcKNQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Feb 2025 23:40:43 +0000
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
Cc: linux-fsdevel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 16/21] ramfs, hugetlbfs, mqueue: set DCACHE_DONTCACHE
In-reply-to: <20250225233600.GB2023217@ZenIV>
References: <>, <20250225233600.GB2023217@ZenIV>
Date: Wed, 26 Feb 2025 10:40:40 +1100
Message-id: <174052684023.102979.4006311879980189488@noble.neil.brown.name>
X-Rspamd-Queue-Id: BD5431F45E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 26 Feb 2025, Al Viro wrote:
> On Wed, Feb 26, 2025 at 10:25:12AM +1100, NeilBrown wrote:
> > On Tue, 25 Feb 2025, Al Viro wrote:
> > > makes simple_lookup() slightly cheaper there.
> > 
> > I think the patch make sense because there is no point keeping negative
> > dentries for these filesystems - and positive dentries get an extra
> > refcount so DCACHE_DONTCACHE doesn't apply.
> > 
> > But I don't see how this makes simple_lookup() cheaper.  It means that
> > if someone repeatedly looks up the same non-existent name then
> > simple_lookup() will be called more often (because we didn't cache the
> > result of the previous time) but otherwise I don't see the relevance to
> > simple_lookup().  Am I missing something?
> 
> This:
>         if (!(dentry->d_flags & DCACHE_DONTCACHE)) {
> 		spin_lock(&dentry->d_lock);
> 		dentry->d_flags |= DCACHE_DONTCACHE;
> 		spin_unlock(&dentry->d_lock);
> 	}

Ah - right.  Thanks.

NeilBrown


> 
> IOW, no need to mark that sucker as "don't retain past the moment when
> its refcount drops to zero" - they'll all be marked that way since
> they'd been created.
> 
> Note that we used to switch then to ->d_op that had ->d_delete always
> returning true.  That had been replaced with setting DCACHE_DONTCACHE;
> that was an equivalent transformation.  So retention rules have not changed;
> the only change here is that this flag doesn't need to be set.
> 


