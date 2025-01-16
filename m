Return-Path: <linux-fsdevel+bounces-39425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1697A140BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB25188E475
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FFB22F178;
	Thu, 16 Jan 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nHCLKFIT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1i1T6iP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AsAeUiTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6zrTRJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE222D4DC;
	Thu, 16 Jan 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048022; cv=none; b=dLRVIgrM5eQ2ZsqNtFxjjTQ4JMFHa13/dLsu9/2rfXeqG8bPEntJvdZjG08nGi+OQRBHZdg6Zsd9NhKVCn/vmgt+A9BAfiZ+Tz0M87necapG2p9mjJq17g9xa9AmUMetI5gOVNElESG/J29oPEfh/13nuig3m6zLm4pEzDsfLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048022; c=relaxed/simple;
	bh=ksGBLpr3OS3gcF/ZardsT0Q9A/X1TkwnEo8A2F6Hg6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJoUjg5NjGgHjIJAmcEYnBTDOk44ccHjyHg2Xu1nDpo5Eiz01g47UEJ8tzlUgEo2UZNiK8r8Xm72XsAdJTpSUCxc4dGwPMX0H8NwtroDXIN6sNv16KfPYYfvh0DGsLmY0UUjIIGFtT/U7Tz1+6PslR9Mt1jgfGUsH8uovJVb/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nHCLKFIT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m1i1T6iP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AsAeUiTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u6zrTRJl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57A911F37C;
	Thu, 16 Jan 2025 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737048017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBNa3EjadDudFIr8kxkw3Bz23nyM/hLfUpkyiAgFfAE=;
	b=nHCLKFIThZvYafca2ocZxgeRKIuOetYrNKOExTn22vK++PBO3cTxRKMN3nteUQGzDnqLW5
	7z9+hNcxWsN1MzMfGuO8RZTwcbNSG8zO0JJE7j2/7FivglqtempOLO+lb6mTY8q6/jM+TW
	786rjU5BUlwQSizyoreAjkMaNVd8jZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737048017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBNa3EjadDudFIr8kxkw3Bz23nyM/hLfUpkyiAgFfAE=;
	b=m1i1T6iPPvNqpTYh8MC5RsSGUisNsU3foEvBD3ebpElNlgtdE2HrE0HAJ2HhcbF0xsRIP9
	zCzhu3Einy/qZnDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AsAeUiTf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u6zrTRJl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737048016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBNa3EjadDudFIr8kxkw3Bz23nyM/hLfUpkyiAgFfAE=;
	b=AsAeUiTf0jUrM6W72rPc7VBybFx71g/wX3n69IYjwfz7UriWnsIIgoz6UxpdPhd425za3+
	oEU6Mrw5E1wjyw4XYegfjMXu6rRIlM0tFV0Kbn/hmMclsQcO7HDDVth4+0c67cvWO7KC9G
	q6YzA3RFgkUp3Aqo5z1KBa2oebtSrzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737048016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBNa3EjadDudFIr8kxkw3Bz23nyM/hLfUpkyiAgFfAE=;
	b=u6zrTRJlibqDDUyHjlDwZf44t6WP1cfprQ+zX0gSfSJ6PiXvseBX9sSshKAswDI8MkL63P
	1iF2Xkq9/TTKXYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46B3913332;
	Thu, 16 Jan 2025 17:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wrc7EdA/iWeqFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 17:20:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A44A1A08E0; Thu, 16 Jan 2025 18:20:15 +0100 (CET)
Date: Thu, 16 Jan 2025 18:20:15 +0100
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] time to reconsider tracepoints in
 the vfs?
Message-ID: <t46oippyv2ngyndiprssjxnw3s76gd47qt2djruonbaxjypwjn@epxwtyrqjdya>
References: <20250116124949.GA2446417@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116124949.GA2446417@mit.edu>
X-Rspamd-Queue-Id: 57A911F37C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 16-01-25 07:49:49, Theodore Ts'o wrote:
> Historically, we have avoided adding tracepoints to the VFS because of
> concerns that tracepoints would be considered a userspace-level
> interface, and would therefore potentially constrain our ability to
> improve an interface which has been extremely performance critical.
> 
> I'd like to discuss whether in 2025, it's time to reconsider our
> reticence in adding tracepoints in the VFS layer.  First, while there
> has been a single incident of a tracepoint being used by programs that
> were distributed far and wide (powertop) such that we had to revert a
> change to a tracepoint that broke it --- that was ***14** years ago,
> in 2011.  Across multiple other subsystems, many of
> which have added an extensive number of tracepoints, there has been
> only a single problem in over a decade, so I'd like to suggest that
> this concern may have not have been as serious as we had first
> thought.
> 
> In practice, most tracepoints are used by system administrators and
> they have to deal with enough changes that break backwards
> compatibility (e.g., bash 3 ->bash 4, bash 4 -> bash 5, python 2.7 ->
> python 3, etc.) that the ones who really care end up using an
> enterprise distribution, which goes to extreme length to maintain the
> stable ABI nonsense.  Maintaining tracepoints shouldn't be a big deal
> for them.
> 
> Secondly, we've had a very long time to let the dentry interface
> mature, and so (a) the fundamental architecture of the dcache hasn't
> been changing as much in the past few years, and (b) we should have
> enough understanding of the interface to understand where we could put
> tracepoints (e.g., close to the syscall interface) which would make it
> much less likely that there would be any need to make
> backwards-incompatible changes to tracepoints.
> 
> The benefits of this would be to make it much easier for users,
> developers, and kernel developers to use BPF to probe file
> system-related activities.  Today, people who want to do these sorts
> of things need to use fs-specific tracepoints (for example, ext4 has a
> very large number of tracepoints which can be used for this purpose)
> but this locks users into a single file system and makes it harder for
> them to switch to a different file system, or if they want to use
> different file systems for different use cases.
> 
> I'd like to propose that we experiment with adding tracepoints in
> early 2025, so that at the end of the year the year-end 2025 LTS
> kernels will have tracepoints that we are confident will be fit for
> purpose for BPF users.

So I personally have nothing against tracepoints in VFS. Occasionally they
are useful and so far userspace was pretty much accepting the fact that
they are a moving target. That being said with BPF and all the tooling
around it (bcc, bpftrace) userspace has in my experience very much adapted
to just attaching BPF programs to random functions through kprobes so they
are not even relying that much on tracepoints anymore. Just look through
bcc scripts collection... I have myself adopted to a lack of trace points
in VFS by just using kprobes. The learning curve is a bit steeper but after
that it's not a big deal.  I'm watching with a bit of concern developments
like BTF which try to provide some illusion of stability where there isn't
much of it. So some tool could spread wide enough without getting regularly
broken that breaking it will become a problem. But that is not really the
topic of this discussion.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

