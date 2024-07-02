Return-Path: <linux-fsdevel+bounces-22922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFF923B3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB3BB24BE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4D15885D;
	Tue,  2 Jul 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j7fuXjZk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZn2I7tN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j7fuXjZk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZn2I7tN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDC157E84;
	Tue,  2 Jul 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915548; cv=none; b=lUZ/x/u6IIn+Eo3KGerCVGDEffHZNNTeEHuPo2qLkZgc3hUMCoK/9eu1TIJCHtMVdhKps2sV7nwEGWFFHNJtrx+9gcEQq2UzhVaxJy+Lyn4oCp0vXowuLQ9WTAJzpnDBH/A7Z8x8FcUWBdcc8Jh2vbU6UDioLGesXKV/Fa6dn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915548; c=relaxed/simple;
	bh=14fl0hG2i0eIiGJZ4fDwGiWtU7bkyFt1BvazraR5F/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lswljfr38T7GS0w3sF/nJhj7o9ahih414KViK03BeRg1NkVccx8VdV8n6PmKxBWZNQ3CZ7QCT1dM/9Lpk606vVmLstvaDjyygaWtFdqNawquAZFHYCybtsp2zq6sncIfeXWwV6/6r6OQhSHYjDq5Hu7GAMV8cIIgyx5+Cbu9Pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j7fuXjZk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZn2I7tN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j7fuXjZk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZn2I7tN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C13D621AA1;
	Tue,  2 Jul 2024 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719915542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QgfEvG+VBe8fgiEqH2xll6Fjp3VI8MfOXpkPTjxvqU=;
	b=j7fuXjZkmiE8Ag2HgL272opB8gC348U1vxjpTBOtY6LE+6BtsWFohG7inTzCArFz3+/Y2A
	fsagrkuxeYfZ8SNgIRc8ho8lY829gEzTHrEt6cB9TicadUdIHt122lBAeI7D6DiGbUVJHp
	ABYPmNo0+u1Ybzt2b8ywZJKWmP+nEvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719915542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QgfEvG+VBe8fgiEqH2xll6Fjp3VI8MfOXpkPTjxvqU=;
	b=gZn2I7tNyT6UFDx6bdQBhB0nr4VJsWmxq/IWXZIsvrb6DqDNA3HlA+g+TnuOiGJ/cdZZBe
	+buovUNEnvNclaAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j7fuXjZk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gZn2I7tN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719915542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QgfEvG+VBe8fgiEqH2xll6Fjp3VI8MfOXpkPTjxvqU=;
	b=j7fuXjZkmiE8Ag2HgL272opB8gC348U1vxjpTBOtY6LE+6BtsWFohG7inTzCArFz3+/Y2A
	fsagrkuxeYfZ8SNgIRc8ho8lY829gEzTHrEt6cB9TicadUdIHt122lBAeI7D6DiGbUVJHp
	ABYPmNo0+u1Ybzt2b8ywZJKWmP+nEvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719915542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QgfEvG+VBe8fgiEqH2xll6Fjp3VI8MfOXpkPTjxvqU=;
	b=gZn2I7tNyT6UFDx6bdQBhB0nr4VJsWmxq/IWXZIsvrb6DqDNA3HlA+g+TnuOiGJ/cdZZBe
	+buovUNEnvNclaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B253413A9A;
	Tue,  2 Jul 2024 10:19:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N46DKxbUg2bdPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jul 2024 10:19:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7219DA08A6; Tue,  2 Jul 2024 12:19:02 +0200 (CEST)
Date: Tue, 2 Jul 2024 12:19:02 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <20240702101902.qcx73xgae2sqoso7@quack3>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
 <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
 <20240701224941.GE612460@frogsfrogsfrogs>
 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
 <ZoOuSxRlvEQ5rOqn@infradead.org>
 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
X-Rspamd-Queue-Id: C13D621AA1
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 02-07-24 05:56:37, Jeff Layton wrote:
> On Tue, 2024-07-02 at 00:37 -0700, Christoph Hellwig wrote:
> > On Mon, Jul 01, 2024 at 08:22:07PM -0400, Jeff Layton wrote:
> > > 2) the filesystem has been altered (fuzzing? deliberate doctoring?).
> > > 
> > > None of these seem like legitimate use cases so I'm arguing that we
> > > shouldn't worry about them.
> > 
> > Not worry seems like the wrong answer here.  Either we decide they
> > are legitimate enough and we preserve them, or we decide they are
> > bogus and refuse reading the inode.  But we'll need to consciously
> > deal with the case.
> > 
> 
> Is there a problem with consciously dealing with it by clamping the
> time at KTIME_MAX? If I had a fs with corrupt timestamps, the last
> thing I'd want is the filesystem refusing to let me at my data because
> of them.

Well, you could also view it differently: If I have a fs that corrupts time
stamps, the last thing I'd like is that the kernel silently accepts it
without telling me about it :)

But more seriously, my filesystem development experience shows that if the
kernel silently tries to accept and fixup the breakage, it is nice in the
short term (no complaining users) but it tends to get ugly in the long term
(where tend people come up with nasty cases where it was wrong to fix it
up). So I think Christoph's idea of refusing to load inodes with ctimes out
of range makes sense. Or at least complain about it if nothing else (which
has some precedens in the year 2038 problem).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

