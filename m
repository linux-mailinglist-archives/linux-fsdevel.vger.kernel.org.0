Return-Path: <linux-fsdevel+bounces-55594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9AFB0C3D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A306416CC4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E428C871;
	Mon, 21 Jul 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1yUgeSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bib1vZhj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1yUgeSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bib1vZhj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF32BEFEB
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099785; cv=none; b=aOYtp4uDNY7V410gIKZHZGeeLxirlEnAxsntcgJZ4jWswHll7bgmbiOEuadZ4K4GhekFLrP0TRpwrm/Yte4Hq4wwlf/qDOxOnJZPzZFOrH8zlMzRkanAjyzp+ZLC/d05mwnhfaZJbK33aRib8myg47T72y6jRAGBUCN/ydQaPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099785; c=relaxed/simple;
	bh=xOVNRilUUnpPzmkPg/DOGhbbJBWpV/SMFomibvawHaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlIWodmrVDV1q2EVJhKFssOx2Hjpj5l0Tkl2F5YKUdRcVK3UibJTiIJUtqWu8X/MqauwZRR28kSlxBhqAotiBo5+L1YV8qNhY48jLQ2MncadC6JhIxbORLAZr+liE7xaT1QQYb38e8A/Gl+BTYIArbpwHYs4RUBpFP/VoVdOAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1yUgeSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bib1vZhj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1yUgeSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bib1vZhj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CD141F791;
	Mon, 21 Jul 2025 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753099782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osODL1DXWanSL9NsdOi9EyKq6ii23SBPLkpGfiV+CAw=;
	b=W1yUgeSdPlLi65cJNL8g9kv3HgykSyNzKWtWuXXdWtYZu9pqHwoRmhka378b7ONuUwEmzK
	nr2VKXTLivmf4BU1o3jwy9ITdEY/rF0xXS2eWQvuhHnu0NIIX6BKq+pfsyZg9hmYNJkod2
	jJUCZV3qP5JYaYobsSK8V37ycWaFCBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753099782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osODL1DXWanSL9NsdOi9EyKq6ii23SBPLkpGfiV+CAw=;
	b=bib1vZhjKq0bLBlEJ17nHtI4DoakS2BhOpePnxgQfag5jiviOVXaUsJoZz7CIk2cbEaUmb
	P6jGJR2cTTfxIZCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753099782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osODL1DXWanSL9NsdOi9EyKq6ii23SBPLkpGfiV+CAw=;
	b=W1yUgeSdPlLi65cJNL8g9kv3HgykSyNzKWtWuXXdWtYZu9pqHwoRmhka378b7ONuUwEmzK
	nr2VKXTLivmf4BU1o3jwy9ITdEY/rF0xXS2eWQvuhHnu0NIIX6BKq+pfsyZg9hmYNJkod2
	jJUCZV3qP5JYaYobsSK8V37ycWaFCBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753099782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osODL1DXWanSL9NsdOi9EyKq6ii23SBPLkpGfiV+CAw=;
	b=bib1vZhjKq0bLBlEJ17nHtI4DoakS2BhOpePnxgQfag5jiviOVXaUsJoZz7CIk2cbEaUmb
	P6jGJR2cTTfxIZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6813913A88;
	Mon, 21 Jul 2025 12:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uTdhGQYufmhlOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Jul 2025 12:09:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14A73A0884; Mon, 21 Jul 2025 14:09:42 +0200 (CEST)
Date: Mon, 21 Jul 2025 14:09:42 +0200
From: Jan Kara <jack@suse.cz>
To: Askar Safin <safinaskar@zohomail.com>
Cc: brauner@kernel.org, James.Bottomley@hansenpartnership.com, 
	ardb@kernel.org, boqun.feng@gmail.com, david@fromorbit.com, djwong@kernel.org, 
	hch@infradead.org, jack@suse.cz, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, 
	mingo@redhat.com, pavel@kernel.org, peterz@infradead.org, rafael@kernel.org, 
	will@kernel.org
Subject: Re: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250720192336.4778-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720192336.4778-1-safinaskar@zohomail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,hansenpartnership.com,gmail.com,fromorbit.com,infradead.org,suse.cz,vger.kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

Hi!

On Sun 20-07-25 22:23:36, Askar Safin wrote:
> I did experiments on my laptop, and these experiments show that this
> patchset does not solve various longstanding problems related to suspend
> and filesystems. (Even if I enable /sys/power/freeze_filesystems )
> 
> Now let me describe problems I had in the past (and still have!) and then
> experiments I did and their results.
> 
> So, I had these 3 problems:
> 
> - Suspend doesn't work if fstrim in progress (note that I use btrfs as
> root file system)

Right, this is expected because the FITRIM ioctl (syscall as any other)
likely takes too long and so the suspend code looses its patience. There's
nothing VFS can do about this. You can talk to btrfs developers to
periodically check for pending signal / freezing event like e.g. ext4 does
in ext4_trim_interrupted() to avoid suspend failures when FITRIM is
running.

> - Suspend doesn't work if scrub in progress

Similar situation as with FITRIM. This is fully in control of the
filesystem and unless the filesystem adds checks and early abort paths, VFS
cannot do anything.

> - Suspend doesn't work if we try to read from fuse-sshfs filesystem while
> network is down

On the surface the problem is the same as the above two but the details
here are subtly different. Here I expect (although I'm not 100% sure) the
blocked process is inside the FUSE filesystem waiting for the FUSE daemon
to reply (a /proc/<pid>/stack of the blocked process would be useful here).
In theory, FUSE filesystem should be able to make the wait for reply in
TASK_FREEZABLE state which would fix your issue. In any case this is very
likely work for FUSE developers.

So I'm sorry but the patch set you speak about isn't supposed to fix any of
the above issues you hit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

