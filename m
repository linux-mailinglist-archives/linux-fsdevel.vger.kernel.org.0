Return-Path: <linux-fsdevel+bounces-59968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52626B3FCAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C883BE522
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D62ECD2A;
	Tue,  2 Sep 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8jZ7rpN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZF70tiVO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i60ctUKR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NnxglyTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD52EB844
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809388; cv=none; b=pqfndwH6y33eqgI2bDDwg5DUeu552VJqfv2l3GJ0KHk+nbULr+tCbLy7S3rLpVeTICi8WvQ2lV54lNxyYsbn1cjBOz08ibpVnCX01g4qJE0b9+TcSCvlb3aaRc61iBrmrZTIuNASqhc85APA6ABU2mT6ntgp+q562r2dZ5u8DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809388; c=relaxed/simple;
	bh=z/DkBHWCsksinkid/yEWQ6NEzin1QMKddy8KvjLHB2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXIixswwslGGmS2vrzNsP/ih3PvHZUNZjqKefrWOPp3G5QffBGcczZPIODTQyKxEYMA1yoxS634i79DexyhCGhislN+TW73K5C8jINQZ/2+dYq/G8JjVdgx320TJ8UfZwYBjthfoWKSNtj8WA35lXkuvpCvoA7Jdyh7SyCDDzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8jZ7rpN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZF70tiVO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i60ctUKR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NnxglyTh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62DF8211CA;
	Tue,  2 Sep 2025 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756809385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtO7zAnOvCwq9g9hrG/MGCutScXQJeq07padKfwDdGs=;
	b=G8jZ7rpNY6L002wSSCcvRxWvYFtLoXylWbF//8FzSAn4oS3hI3MyX8xoQo0QpuSoHiJZgr
	dXn7tS00yEHyOchDgLOBEsFD5e47jlDKaeVAaqD54gRYM0bTWkwoBlxnvQKKg18JTf/vpl
	f9sm3YNeOxaDN/sAf0tHBcuLSnbgVro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756809385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtO7zAnOvCwq9g9hrG/MGCutScXQJeq07padKfwDdGs=;
	b=ZF70tiVO1YCG6oI7MIftjo8yRd674ZPiZ+bKGnEJReSNoqX8WEHf9mvgbaK61rr4lNs1aB
	2I9MI+z8oK6S9KCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i60ctUKR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NnxglyTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756809384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtO7zAnOvCwq9g9hrG/MGCutScXQJeq07padKfwDdGs=;
	b=i60ctUKRopJiaoQJYMaz5k2B8Hp4+BTzHra4A60Krom2u0jGZ2iuQppUG0AlGBsh60K5mr
	2KjBcQr/cW/L+X1mV2mgdkeucYnvoN/lCIrcVklfO63SoSXM1eMro0ctTnl6dKe8nazuy6
	bEh3LaLDY0o57iDLE9Qrgp6tNEdevow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756809384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtO7zAnOvCwq9g9hrG/MGCutScXQJeq07padKfwDdGs=;
	b=NnxglyThfqzwd7pCq6bwZxi3Uqp4y5QGdowXgHxI0hdsw9nxqyy1eHw0jiHIk5kPsZ3mqH
	uerjFyzYU/0zgeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5117813888;
	Tue,  2 Sep 2025 10:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XLZrE6jItmjzIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Sep 2025 10:36:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5B63A0A9F; Tue,  2 Sep 2025 12:36:19 +0200 (CEST)
Date: Tue, 2 Sep 2025 12:36:19 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <hfc7hcs72ugsuqhmta23ykjxomiuavsuynylj54muq7qbzrs3m@yvyypsaqftua>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru>
 <20250829-diskette-landbrot-aa01bc844435@brauner>
 <e7110cd2-289a-127e-a8c1-f191e346d38d@ispras.ru>
 <20250829-therapieren-datteln-13c31741c856@brauner>
 <9d492620-1a58-68c0-2b47-c8b16c99b113@ispras.ru>
 <fkq7gvtjqx4jilgu75nbmckmwdndl7d7fzljuycqfzmvumdft2@jiycade6gzgo>
 <68c99812-e933-ce93-17c0-3fe3ab01afb8@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c99812-e933-ce93-17c0-3fe3ab01afb8@ispras.ru>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 62DF8211CA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 01-09-25 20:53:38, Alexander Monakov wrote:
> 
> On Fri, 29 Aug 2025, Jan Kara wrote:
> 
> > Umount (may_umount_tree()) looks at mnt->mnt_count which is decremented by
> > mntput() completely at the end of __fput(). I tend to agree with Christian
> > here: We've never promised that all effects of open fd are cleaned up
> > before the flock is released and as Christian explained it will be actually
> > pretty hard to implement such behavior. So attempts to wait for fd to close
> > by waiting for its flock are racy...
> 
> (flock is not a Linux invention, if BSD implementations offered that guarantee,
> I'd expect Linux to follow, but I'm not sure if they did)
> 
> That's unfortunate. If the remount/unmount issues are not convincing, shall we
> try to get this issue called out in the Linux man pages? Would you help me with
> wordsmithing?
> 
> How about adding the following to the NOTES section in flock.2?
> 
> Releasing the lock when a file descriptor is closed is not sequenced
> after all observable effects of close(). For example, when one process
> places an exclusive lock on a file, writes to it, then closes it, and
> another process waits on a shared lock for the file to be closed, it may
> observe that subsequent execve() fails with ETXTBSY, and umount() of the
> underlying filesystem fails with EBUSY, as if the file is still open in
> the first process.

The paragraph sounds good to me. Thanks for writing it!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

