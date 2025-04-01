Return-Path: <linux-fsdevel+bounces-45420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCCBA777CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C191D1884597
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C36F1EF38A;
	Tue,  1 Apr 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VA+JZzTW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnW83aDc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VA+JZzTW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnW83aDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599C1E5B8B
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499977; cv=none; b=YlpG6qyZWQ2DdQAXgMzTHuo7LurbUhRDBsVphaMcjQ7as8c3R0Hv8m6iJj6nvXvjlf4otsYrEDhvW+GsW4SrnWX9JbteiZjLKnHHkb1fbHtLCzFhJy6OYD7AIf79J/U9qZfAR7kRo82+7fbxeIYaBnSnlbRZjQGMLMXu0HQ5Emc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499977; c=relaxed/simple;
	bh=N5t4yjja/8jUnHgzzCz6rkqZsDgJK8T6UC+vLgFnHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgesWMTuJmmEhrIONqUNxOLMfMQ4RArZhsRhSB4auYQVTgoOhqlAf+A3i3Q2Gi+h4ge87RV99f5KjXUwO0z0sW4mkorsfPJk8ckqmBnH+g+7RBPoMSvQWqHBi+vAavNieVTKgvQV6xR4qzNvFMC0lLg2EYmZ4zbDGVLrZSdpE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VA+JZzTW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnW83aDc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VA+JZzTW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnW83aDc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8AA41F38E;
	Tue,  1 Apr 2025 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743499973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOsoADBWW0dlWBJVZr0kPDbyqmr+yFOyiGnaXhozHDk=;
	b=VA+JZzTWgT+ebk1SNeJQUmWq9U/tMWf9fHx5vVwAZoocBL+ob+o24VYo8AXZNStdX7H2gX
	age3tOJ3I+Wr71F0EjWQGDapq8+x5Xi/o1P4h4d2yYVNQlt8HYeJzVg+kTSyXx8FGUy2H+
	Wscicp71qfAoTSV0LqzvgTobo3ig3Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743499973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOsoADBWW0dlWBJVZr0kPDbyqmr+yFOyiGnaXhozHDk=;
	b=RnW83aDcemWvbgLZTi6g64os6WOCV4BXDzk9VwiMvyi97tCdRPw01VJK4ElEsKjN5hYW1T
	+OYpYHEw64opYyCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743499973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOsoADBWW0dlWBJVZr0kPDbyqmr+yFOyiGnaXhozHDk=;
	b=VA+JZzTWgT+ebk1SNeJQUmWq9U/tMWf9fHx5vVwAZoocBL+ob+o24VYo8AXZNStdX7H2gX
	age3tOJ3I+Wr71F0EjWQGDapq8+x5Xi/o1P4h4d2yYVNQlt8HYeJzVg+kTSyXx8FGUy2H+
	Wscicp71qfAoTSV0LqzvgTobo3ig3Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743499973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOsoADBWW0dlWBJVZr0kPDbyqmr+yFOyiGnaXhozHDk=;
	b=RnW83aDcemWvbgLZTi6g64os6WOCV4BXDzk9VwiMvyi97tCdRPw01VJK4ElEsKjN5hYW1T
	+OYpYHEw64opYyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA8E1138A5;
	Tue,  1 Apr 2025 09:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2viGLcWy62daAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Apr 2025 09:32:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 780EFA07E6; Tue,  1 Apr 2025 11:32:49 +0200 (CEST)
Date: Tue, 1 Apr 2025 11:32:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, rafael@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <s6rnz3ysjlu3rp6m56vua3vnlj53hbgxbbe3nj7v2ib5fg4l2i@py4pkvsgk2lr>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 01-04-25 02:32:45, Christian Brauner wrote:
> The whole shebang can also be found at:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> 
> I know nothing about power or hibernation. I've tested it as best as I
> could. Works for me (TM).
> 
> I need to catch some actual sleep now...
> 
> ---
> 
> Now all the pieces are in place to actually allow the power subsystem to
> freeze/thaw filesystems during suspend/resume. Filesystems are only
> frozen and thawed if the power subsystem does actually own the freeze.
> 
> Othwerwise it risks thawing filesystems it didn't own. This could be
> done differently be e.g., keeping the filesystems that were actually
> frozen on a list and then unfreezing them from that list. This is
> disgustingly unclean though and reeks of an ugly hack.
> 
> If the filesystem is already frozen by the time we've frozen all
> userspace processes we don't care to freeze it again. That's userspace's
> job once the process resumes. We only actually freeze filesystems if we
> absolutely have to and we ignore other failures to freeze.

Hum, I don't follow here. I supposed we'll use FREEZE_MAY_NEST |
FREEZE_HOLDER_KERNEL for freezing from power subsystem. As far as I
remember we have specifically designed nesting of freeze counters so that
this way power subsystem can be sure freezing succeeds even if the
filesystem is already frozen (by userspace or the kernel) and similarly
power subsystem cannot thaw a filesystem frozen by somebody else. It will
just drop its freeze refcount... What am I missing?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

