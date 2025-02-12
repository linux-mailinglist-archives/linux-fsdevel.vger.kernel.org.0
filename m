Return-Path: <linux-fsdevel+bounces-41561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5303A31D83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 05:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3087A3CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 04:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED71EEA2D;
	Wed, 12 Feb 2025 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KEvSEq5h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="21TmhMUl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KEvSEq5h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="21TmhMUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A227183B;
	Wed, 12 Feb 2025 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335238; cv=none; b=a6F7DS5a4EhYGRIvma1573JoFrYt9/uoCu2YC7dtsvQMss6QLTeqCxnp8UDd5fiy4gcygbOF5feV1DTGTa1wU6z9EqN/4nzxqj+D15LFo7eq/y63Yn+6s9sUG6tCIZxqK8N0+a84X9WWdEm82dW0FJCeeP+Ax5DwVnMGrLPsOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335238; c=relaxed/simple;
	bh=nqFYJV2uNsxJEeayoxxsALSEgrHp+g4jfbsRm2VecSY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PjXmFXK3FInnbtoyiAD+/v5A/GWz6iYgwSPWhPRg59gqobjgW77BhyOvgOqLqSN3T6oY1tjem9STKX6RQHPRWsTYMQZCCdwZZiGc6KTS6iOBn6F2lGusSi+mPvTAW7ErCJXsq6dZyFnU5Ij8f/dnIp6LCrOuyFQstK1XQUMK7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KEvSEq5h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=21TmhMUl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KEvSEq5h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=21TmhMUl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 991B63377E;
	Wed, 12 Feb 2025 04:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739335234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51CME5rXo/EmOI0Q/jLXEbBiWw/2N/e9MU+fM+sd0Ws=;
	b=KEvSEq5hfKAxRvI2jzl1QLluvoRTgAZ6/9sc9VSW6eij64nK2G64GLNWFMO499/9O5rttP
	5SdzTdxPh3/tnlRQ6nC8Jm4dPMZifvAPutct+LatJMhgfWaSUx/brLc6ruKbeXFZrq/a93
	fKPotJwhhI730BVNRe7nIt+2tNFYnpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739335234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51CME5rXo/EmOI0Q/jLXEbBiWw/2N/e9MU+fM+sd0Ws=;
	b=21TmhMUltmR5TsytQf7ZnKJ4RWJyfgrZyF8NqVPk+NcTsTbsVIK8SQUmkvNge9A97v6NG8
	Lr+Mqd1vK/gyQUCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KEvSEq5h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=21TmhMUl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739335234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51CME5rXo/EmOI0Q/jLXEbBiWw/2N/e9MU+fM+sd0Ws=;
	b=KEvSEq5hfKAxRvI2jzl1QLluvoRTgAZ6/9sc9VSW6eij64nK2G64GLNWFMO499/9O5rttP
	5SdzTdxPh3/tnlRQ6nC8Jm4dPMZifvAPutct+LatJMhgfWaSUx/brLc6ruKbeXFZrq/a93
	fKPotJwhhI730BVNRe7nIt+2tNFYnpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739335234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51CME5rXo/EmOI0Q/jLXEbBiWw/2N/e9MU+fM+sd0Ws=;
	b=21TmhMUltmR5TsytQf7ZnKJ4RWJyfgrZyF8NqVPk+NcTsTbsVIK8SQUmkvNge9A97v6NG8
	Lr+Mqd1vK/gyQUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2CEA13874;
	Wed, 12 Feb 2025 04:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W452KTsmrGdzbAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 04:40:27 +0000
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
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject:
 Re: [PATCH 2/2] VFS: add common error checks to lookup_one_qstr_excl()
In-reply-to: <20250212040604.GN1977892@ZenIV>
References: <>, <20250212040604.GN1977892@ZenIV>
Date: Wed, 12 Feb 2025 15:40:24 +1100
Message-id: <173933522466.22054.10492497527270412453@noble.neil.brown.name>
X-Rspamd-Queue-Id: 991B63377E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 12 Feb 2025, Al Viro wrote:
> On Wed, Feb 12, 2025 at 02:45:04PM +1100, NeilBrown wrote:
> > On Wed, 12 Feb 2025, Al Viro wrote:
> 
> > I do see some value in the simplicity of this approach, though maybe not
> > as much value as you see.  But the above uses inode_lock_share(), rather
> > than the nested version, so lockdep will complain.
> 
> IDGI...  It doesn't grab any ->i_rwsem inside that one, so what's there to
> complain about?  And in that case it returns with no locks held, so...
> 

Sorry - my bad.  I saw the difference in nesting and jumped the wrong
way.

NeilBrown

