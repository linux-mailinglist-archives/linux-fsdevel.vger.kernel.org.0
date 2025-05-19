Return-Path: <linux-fsdevel+bounces-49461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CDABC8C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 22:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96323A50F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2E219A94;
	Mon, 19 May 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/7hFFvN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2z/2Q5RW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/7hFFvN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2z/2Q5RW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AD155335
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688203; cv=none; b=kxzZP89i8bShxiUEHVDytQTeBtjUmQFTgTV0blkNKMl1zj/0B/m+Cq9OfVjPtY0N3EnUuVAtfWal8i0V9gD0gfP0q274kKnybxyMVaTFDp14hfnR+nN0sJwyE5lth0Ru9zI/pdhefucBKKLcwUg3SJ/hnD0q1KiDVYsljwXutuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688203; c=relaxed/simple;
	bh=BF+3Mo5YfHKKNXMY0GA+nyL4dIscLdkg5TVWFTxqbn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bChwxVQutAPh8uU5jOQNraGuIggwwfOQMvtJ0BEELJwbVYJrLxljvQLr28HKxK/YonOZdLrixrEuyeRlVUIPz0Ak5k76RuFlysEWKYVxnfOvmknvLip5BOBQWGlwnMGCzQVToQ62W+0nBTYYJkgW9i+BObRmwlvvOSoiv9TNKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/7hFFvN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2z/2Q5RW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/7hFFvN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2z/2Q5RW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B1AF204CE;
	Mon, 19 May 2025 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747688199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+1uc0ijv8y3V31YyOzvKznzazA+ZDurgM62mkgHSl4=;
	b=K/7hFFvNxJjOLKE3YPIyilPSef+tGJgmlCu7zkf0NajNnxq6HhsZYU3FhMyDG1NdTigPFW
	7hYy5nx2rX/f96bj7pnTnxag+joqM9/MxLcvH9HghieYdLERgWBn12TjxhXXJXd3RX6xf2
	OJ/vDibduDleOi96sQbgwEVwgmYkltQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747688199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+1uc0ijv8y3V31YyOzvKznzazA+ZDurgM62mkgHSl4=;
	b=2z/2Q5RWfMB9J5Q5v8x3KBmOzIDJPv5tWWkHJRnk8YmyUwsNs8uSAjQuLx1uiZliazBet4
	Rl/JlTe6dylfp4BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747688199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+1uc0ijv8y3V31YyOzvKznzazA+ZDurgM62mkgHSl4=;
	b=K/7hFFvNxJjOLKE3YPIyilPSef+tGJgmlCu7zkf0NajNnxq6HhsZYU3FhMyDG1NdTigPFW
	7hYy5nx2rX/f96bj7pnTnxag+joqM9/MxLcvH9HghieYdLERgWBn12TjxhXXJXd3RX6xf2
	OJ/vDibduDleOi96sQbgwEVwgmYkltQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747688199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+1uc0ijv8y3V31YyOzvKznzazA+ZDurgM62mkgHSl4=;
	b=2z/2Q5RWfMB9J5Q5v8x3KBmOzIDJPv5tWWkHJRnk8YmyUwsNs8uSAjQuLx1uiZliazBet4
	Rl/JlTe6dylfp4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 821F613A30;
	Mon, 19 May 2025 20:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bY7AHwebK2glHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 May 2025 20:56:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EAD1A0A31; Mon, 19 May 2025 22:56:39 +0200 (CEST)
Date: Mon, 19 May 2025 22:56:39 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] User namespace aware fanotify
Message-ID: <ul2i56zhumflgg3lyi3wizl2f3m2araht5lnglmit7qgugio2l@e73xjbax2ajm>
References: <20250516192803.838659-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516192803.838659-1-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Fri 16-05-25 21:28:01, Amir Goldstein wrote:
> Jan,
> 
> Considering that the review discussion on v2 [1] did not yet converge
> and considering that the merge window is very close, I realized
> there is a way that we can simplify the controversial part.
> 
> There are two main use cases to allow setting marks inside user ns:
> 
> 1. Christian added support for open_by_handle_at(2) to admin inside
>    userns, which makes watching FS_USERNS_MOUNT sb more useful.
> 2. The mount events added by Miklos would be very useful also inside
>    userns.
> 
> The rule for watching mntns inside user ns is pretty obvious and so
> is the rule for watching an sb inside user ns.
> 
> The complexity discussed in review of v2 revolved around the more
> complicated rules for watching fs events on a specific mount inside
> users ns.
> 
> My realization is that watching fs events on a mount inside user ns
> is a less intersting use case and it is much easier to apply the same
> obvious rules as for watching an sb inside user ns and discuss
> relaxing them later if there is any interesting use case for that.
> 
> mntns watch inside user ns was tested with the mount-notify_test_ns
> selftest [2]. sb/mount watches inside user ns were tested manually
> with fsnotifywatch -S and -M with some changes to inotify-tools [3].
> 
> Thanks,
> Amir.

Thanks! Patches look good to me and they seem obvious enough now that I've
just picked them up.

								Honza

> 
> Changes since v2:
> - selftest merged to Christian's tree
> - Change mount mark to require capable sb user ns
> - Remove incorrect reference to FS_USERNS_MOUNT in comments (Miklos)
> - Avoid unneeded type casting to mntns (Miklos)
> 
> Changes since v1:
> - Split cleanup patch (Jan)
> - Logic simplified a bit
> - Add support for mntns marks inside userns
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250419100657.2654744-1-amir73il@gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/20250509133240.529330-1-amir73il@gmail.com/
> [3] https://github.com/amir73il/inotify-tools/commits/fanotify_userns/
> 
> Amir Goldstein (2):
>   fanotify: remove redundant permission checks
>   fanotify: support watching filesystems and mounts inside userns
> 
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 50 +++++++++++++++++-------------
>  include/linux/fanotify.h           |  5 ++-
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 33 insertions(+), 24 deletions(-)
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

