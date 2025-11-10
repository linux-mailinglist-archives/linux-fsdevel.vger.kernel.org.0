Return-Path: <linux-fsdevel+bounces-67662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E843FC45DED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 517E54EA79C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC030506D;
	Mon, 10 Nov 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPcECu9h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ME3JoNIl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPcECu9h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ME3JoNIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA143303CA0
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769611; cv=none; b=SDkMNpD9RSotZ262I3JoYM81Wvr1MLRZqJfLiMUFW2SB3B6R4iE219tIKefHiJ6T4jfcii55XuyWqI0huOXbRjfIpROtbZ+3u7gqUw+nM+pDIwKfpOboDIyhGdinSb4De6SOIV5ROiM57qoXVXBQ2dkUI7FtKRRZv3kQB/SUFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769611; c=relaxed/simple;
	bh=6r3+j54nyKwVownR7KapugfNiNMxvXONIqyELoZMdu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHfpKmDDURef0zByefik4lenyAVhN1DJ0qe233GacrxBekjGKnttunjbk2rWokNL0QWNzs+t4O7GLHqSddWc6n8bG7gjSay1hEdsAFHJxZGpjdY/FW/i2xbXn9NJvvp1IWavdvjJwKxefVLEInYmoybXDMKcn8nosaBDdCbis1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPcECu9h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ME3JoNIl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPcECu9h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ME3JoNIl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79A621F397;
	Mon, 10 Nov 2025 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762769607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvh+XCJafqeUVSunEd+raRyN0k8OSWXEG3aHNUQ5kbA=;
	b=QPcECu9hLRuSudjMFhkwegcoE4q66+/0evbCCemii9/iqgoLPh2d59ykAwNVyS2thmqsCN
	aynH+FEZ/ahvTwgLza3VVR/9tP7iKhrbJs2Upa+qTLKlYvCfKb7CmU5dm22yEP1UM8frOx
	t8ARu/20n3DINNHRIWZv/wBXQQ36nvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762769607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvh+XCJafqeUVSunEd+raRyN0k8OSWXEG3aHNUQ5kbA=;
	b=ME3JoNIl8ST81NuYcvtcnWp7A5uIwmSAm1Qg5RgeCJyJ4SDVxcmaP1XXxjIC+uflSqtP9a
	eYH2GsVJp+XHDiAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762769607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvh+XCJafqeUVSunEd+raRyN0k8OSWXEG3aHNUQ5kbA=;
	b=QPcECu9hLRuSudjMFhkwegcoE4q66+/0evbCCemii9/iqgoLPh2d59ykAwNVyS2thmqsCN
	aynH+FEZ/ahvTwgLza3VVR/9tP7iKhrbJs2Upa+qTLKlYvCfKb7CmU5dm22yEP1UM8frOx
	t8ARu/20n3DINNHRIWZv/wBXQQ36nvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762769607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvh+XCJafqeUVSunEd+raRyN0k8OSWXEG3aHNUQ5kbA=;
	b=ME3JoNIl8ST81NuYcvtcnWp7A5uIwmSAm1Qg5RgeCJyJ4SDVxcmaP1XXxjIC+uflSqtP9a
	eYH2GsVJp+XHDiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C3F614336;
	Mon, 10 Nov 2025 10:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q/dnGse6EWntFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 10:13:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20E17A28B1; Mon, 10 Nov 2025 11:13:23 +0100 (CET)
Date: Mon, 10 Nov 2025 11:13:23 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of
 MAY_EXEC
Message-ID: <x4ngquwvecmlnbhesqowetnidvad57f34xnlhom6qurxr3qsng@uiy7hvlspfjd>
References: <20251107142149.989998-1-mjguzik@gmail.com>
 <20251107142149.989998-2-mjguzik@gmail.com>
 <qfoni4sufho6ruxsuxvcwnw4xryptydtt3wimsflf7kwfcortf@372gbykgkctf>
 <CAGudoHGz6PXi+DLiWjzwLuYq=c+oiA1cWTUt1RmHw5QOt6DAsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGz6PXi+DLiWjzwLuYq=c+oiA1cWTUt1RmHw5QOt6DAsA@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 10-11-25 10:46:38, Mateusz Guzik wrote:
> On Mon, Nov 10, 2025 at 10:32 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 07-11-25 15:21:47, Mateusz Guzik wrote:
> > > The generic inode_permission() routine does work which is known to be of
> > > no significance for lookup. There are checks for MAY_WRITE, while the
> > > requested permission is MAY_EXEC. Additionally devcgroup_inode_permission()
> > > is called to check for devices, but it is an invariant the inode is a
> > > directory.
> > >
> > > Absent a ->permission func, execution lands in generic_permission()
> > > which checks upfront if the requested permission is granted for
> > > everyone.
> > >
> > > We can elide the branches which are guaranteed to be false and cut
> > > straight to the check if everyone happens to be allowed MAY_EXEC on the
> > > inode (which holds true most of the time).
> > >
> > > Moreover, filesystems which provide their own ->permission routine can
> > > take advantage of the optimization by setting the IOP_FASTPERM_MAY_EXEC
> > > flag on their inodes, which they can legitimately do if their MAY_EXEC
> > > handling matches generic_permission().
> > >
> > > As a simple benchmark, as part of compilation gcc issues access(2) on
> > > numerous long paths, for example /usr/lib/gcc/x86_64-linux-gnu/12/crtendS.o
> > >
> > > Issuing access(2) on it in a loop on ext4 on Sapphire Rapids (ops/s):
> > > before: 3797556
> > > after:  3987789 (+5%)
> > >
> > > Note: this depends on the not-yet-landed ext4 patch to mark inodes with
> > > cache_no_acl()
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> >
> > The gain is nice. I'm just wondering where exactly is it coming from? I
> > don't see that we'd be saving some memory load or significant amount of
> > work. So is it really coming from the more compact code and saved several
> > unlikely branches and function calls?
> 
> That's several branches and 2 function calls per path component on the
> way to the terminal inode. In the path at hand, that's 10 function
> calls elided.

OK, the path lookup is really light so I guess 10 function calls are visible
enough. I guess this is hot enough path that the microoptimization is worth
the code duplication. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

