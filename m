Return-Path: <linux-fsdevel+bounces-8057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4582EE11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170621F21B5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D2E1B956;
	Tue, 16 Jan 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0lV9GplD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJ8JNLIB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A536vFk3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v+qwMeT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564D1B81D;
	Tue, 16 Jan 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC0C71FB9B;
	Tue, 16 Jan 2024 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705405520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83bL3UmsaprNcY7TPS07Y3PDh7YlqCXB9W2bN/Ht43U=;
	b=0lV9GplD+mrgk/IJ/S2gaAtFzBSuKKrJ6visLA/+I3aGzYt64sq9xjwivvNiaMs6Xbrc4t
	SYd+JuDz7KqNde53QcnysATItdd/NAaVS58RB3ENSjDrn4eI53ehE0mruRhjlaGJpl/TGS
	ldZeELRDfl1QCfcmw29baR5dyvsQErI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705405520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83bL3UmsaprNcY7TPS07Y3PDh7YlqCXB9W2bN/Ht43U=;
	b=yJ8JNLIBCs4W4fyuiZWd8Pa+fvn78mPygqgykOOZtsOdtFV/94D54u9+tFGKwWWLPLrfjU
	Ysv42yoIhJcGSKAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705405519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83bL3UmsaprNcY7TPS07Y3PDh7YlqCXB9W2bN/Ht43U=;
	b=A536vFk3gnTNijO4YYz0DzRs4FvEYHjMCeg6LgSJjwjeFdPdf1Hlp6lbYe/7u3zpfS+fkg
	EyBzQMgbK5HhMskOcPLhv/Sui+caIP+m1NKqVk01vNrm+hXkWgiOeuVm4yY2oIQdVTyzuS
	2pEz990omojyzSv6wyIHJQQIz30L7Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705405519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83bL3UmsaprNcY7TPS07Y3PDh7YlqCXB9W2bN/Ht43U=;
	b=v+qwMeT1ZH7wmyznf9FueLZTrIFbJTPEaZ4zJqJ2O5LskSHbcRUCryODHF74feC7IwgK8P
	TXpdlPMd79iGEhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D210A132FA;
	Tue, 16 Jan 2024 11:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ix/7Mk9spmWWPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jan 2024 11:45:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C3E8A0803; Tue, 16 Jan 2024 12:45:19 +0100 (CET)
Date: Tue, 16 Jan 2024 12:45:19 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240116114519.jcktectmk2thgagw@quack3>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A536vFk3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v+qwMeT1
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: EC0C71FB9B
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue 16-01-24 11:50:32, Christian Brauner wrote:

<snip the usecase details>

> My initial reaction is to give userspace an API to drop the page cache
> of a specific filesystem which may have additional uses. I initially had
> started drafting an ioctl() and then got swayed towards a
> posix_fadvise() flag. I found out that this was already proposed a few
> years ago but got rejected as it was suspected this might just be
> someone toying around without a real world use-case. I think this here
> might qualify as a real-world use-case.
> 
> This may at least help securing users with a regular dm-crypt setup
> where dm-crypt is the top layer. Users that stack additional layers on
> top of dm-crypt may still leak plaintext of course if they introduce
> additional caching. But that's on them.

Well, your usecase has one substantial difference from drop_caches. You
actually *require* pages to be evicted from the page cache for security
purposes. And giving any kind of guarantees is going to be tough. Think for
example when someone grabs page cache folio reference through vmsplice(2),
then you initiate your dmSuspend and want to evict page cache. What are you
going to do? You cannot free the folio while the refcount is elevated, you
could possibly detach it from the page cache so it isn't at least visible
but that has side effects too - after you resume the folio would remain
detached so it will not see changes happening to the file anymore. So IMHO
the only thing you could do without problematic side-effects is report
error. Which would be user unfriendly and could be actually surprisingly
frequent due to trasient folio references taken by various code paths.

Sure we could report error only if the page has pincount elevated, not only
refcount, but it needs some serious thinking how this would interact.

Also what is going to be the interaction with mlock(2)?

Overall this doesn't seem like "just tweak drop_caches a bit" kind of
work...

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

