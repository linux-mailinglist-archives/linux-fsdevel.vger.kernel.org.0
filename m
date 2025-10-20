Return-Path: <linux-fsdevel+bounces-64657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4BBF0128
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE1F189EC7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128827B4FB;
	Mon, 20 Oct 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lU3CryP+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4X3srvF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPB0Xh5y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Clx35wG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA41643B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950857; cv=none; b=NlaUd2gMeKWZr9vSBYXVePf/16ljY5oTo9awNloDAHTBvrVZvGlHw1g84ErZSk8kva/OL4V5wCGXFEWc88tI03V1RlG57/2M/W57CMgh3mSBOVYC69CMpxxuysdeBbkP5JfY6l7o4b9PHLvZ0LJMCNz5tsQG1nvU5416/p7JHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950857; c=relaxed/simple;
	bh=ht8FrgJLqZYgBlst0VGk5ZkdCnPkc6OSRfYtH6Bj5Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYdy4nu9HaaJI470KCjyalqGrylMgWxcoWUTbazzbUVhnW24YQq36Puz/oTpW+BdT7Nxcpnv+5KlblfhqVQeJUm+y9dJdUsxPT3GrHaj6yzL3/CQHyhW0GosmBsiC3UzgUnmWtxDcbNNPfWNd/NtvYrRUCG7lgj1KyszOwKMiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lU3CryP+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4X3srvF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPB0Xh5y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Clx35wG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5511211C7;
	Mon, 20 Oct 2025 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spt+Q350xMBUJO+VVVuuZJNgPaTA5Z/WSvdNIk02g0U=;
	b=lU3CryP+8SKeqjTMqYvFgAFK0stFL4ilD7QC4/7+ztc1FEqhLQuyBFCsUW9sfxOTR3lBzG
	BwII5yqQRvynicjBPxWhkdE6IIRrJ3aED32hd5t5mmisNLp0HmQckMUkPuv6pcmawVOyeV
	iaRwJ1ad7NGhDi9u8CfRwQHETlj6c8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spt+Q350xMBUJO+VVVuuZJNgPaTA5Z/WSvdNIk02g0U=;
	b=n4X3srvFH/ry4lFWV+3uJGinWq+cl114+1RnzrHMKX+KswFplui8TPoAKR0pm+tlZoaprN
	AK/HbxFcOwiyUeDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spt+Q350xMBUJO+VVVuuZJNgPaTA5Z/WSvdNIk02g0U=;
	b=XPB0Xh5yNcqjuP1CmwWsfnLMTEVswgJ5vysBT1Eg7xzNK4l2AG+waDuBXPzUdU944uBYer
	Mb24lxOFDzhL2PptCJnx0u6GQqhrHY0yq3taUdhw/zwaaiOCep6f0+nHCcv91yCzM9e+sE
	QeBJNP+zbYs4sFJmZgE3QrWpOk5qrg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spt+Q350xMBUJO+VVVuuZJNgPaTA5Z/WSvdNIk02g0U=;
	b=2Clx35wGGo0Qo69vPoJVhmEcWXvu0BaLrt/dgDZKntJWQjK6dnOWOjEWMR4IGgFABCSG5Q
	J/hApIf/rQcBp4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DABBB13AAD;
	Mon, 20 Oct 2025 09:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1xtcNT369WiCagAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:00:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86BA4A0856; Mon, 20 Oct 2025 11:00:45 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:00:45 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fsnotify fixes for 6.18-rc2
Message-ID: <fknebttinqqb7hmr5uondnvxcgeoyrmz6velflutkvj3is2lzw@bwrcslquk7i6>
References: <7bf2q6fzfuohm5av45waq54oo5p6xl5qabb4kwpqmnodpo34im@cevzjaj65izz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf2q6fzfuohm5av45waq54oo5p6xl5qabb4kwpqmnodpo34im@cevzjaj65izz>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

Hello Linus,

I've just noticed my password on the outgoing mail server expired and so
this email didn't go out. Meanwhile Andrew also merged one of the fixes
in this PR through his tree. So please just ignore this PR and I'll send a
new one for rc3 in a moment.

								Honza

On Wed 15-10-25 10:11:54, Jan Kara wrote:
>   Hello Linus,
> 
>   could you please pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.18-rc2
> 
> to get:
>   * kind of a stop-gap solution for a race between unmount of a filesystem
>     with fsnotify marks and someone inspecting fdinfo of fsnotify group
>     with those marks in procfs. Proper solution is in the works but it will
>     get a while to settle.
>   * a fix of braino in fsnotify mmap hook 
>   * a fix for non-decodable file handles (used by unprivileged apps using
>     fanotify).
> 
> Top of the tree is 4d4bf496e66a. The full shortlog is:
> 
> Jakub Acs (1):
>       fs/notify: call exportfs_encode_fid with s_umount
> 
> Jan Kara (1):
>       expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID
> 
> Ryan Roberts (1):
>       fsnotify: Pass correct offset to fsnotify_mmap_perm()
> 
> The diffstat is
> 
>  fs/notify/fdinfo.c       | 6 ++++++
>  include/linux/exportfs.h | 7 ++++---
>  mm/util.c                | 3 ++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> 							Thanks
> 								Honza
> 
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

