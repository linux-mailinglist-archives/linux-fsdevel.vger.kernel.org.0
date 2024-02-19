Return-Path: <linux-fsdevel+bounces-11999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DA885A280
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74041F241CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721A2D043;
	Mon, 19 Feb 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3blMAsfy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="63s8R0A+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3blMAsfy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="63s8R0A+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B992C85D;
	Mon, 19 Feb 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343489; cv=none; b=CdgEag18D2LFFaKoIcZyJZLlap3BX06BkpIkXt2ZjQE5YODfK9cGvPJ1IVyKhRD3F0tVsmji0cWbtuZ3EVmoFDa/lwBto1qxFEntxELzTX73c1W7cK5/590uZkfsRaOBFzYhJ/XMSJsLwaFmN2T+VfvMflzOkRQkIgk1QERelBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343489; c=relaxed/simple;
	bh=VwlINYWevdcc4Z0zWcYwkpbY2yvrQuAvpy3xhEmaPBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnYLoqkGA33EZ6gXu4dK1WGRcxeApb2adFc4K2HyAh5ECQeoInw/4MhWzS9NKGtsJU+cLpYEJBKIIYFlJTlJkHyyVanVYn4DQNmJ+rjZNiDP8w/rfav1GLYDV4EyrV2540uh776+oJ/EoJWmwoDcl6dAH36uIEW4BfMPX+N3/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3blMAsfy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=63s8R0A+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3blMAsfy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=63s8R0A+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8961A22327;
	Mon, 19 Feb 2024 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7TlYTChgUQHqfVflRagycL28iht36dZG/E2FUR5QhU=;
	b=3blMAsfyqBNfXzZVEyrHjljMwT9ob8KBFCP6BncOiqZz/Vywt09pU6BG6RUSweso7oq1Ps
	PKj+6GkClCIEe3iq6ZQfTiKKWBoZF++KSPNX/DiK1zvleOjgcps5/9pgMhYCdMhDclk2wJ
	62cVcnZrPpPGvVo9cdW+8zTerb0gcMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7TlYTChgUQHqfVflRagycL28iht36dZG/E2FUR5QhU=;
	b=63s8R0A+kifxo11DwJPfj2KUhoFdzMvyIS+RM+gkfEmyxTQWexpSRFB4+gVxFIzAsfxmgu
	gwPcLFBeoIBCqvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7TlYTChgUQHqfVflRagycL28iht36dZG/E2FUR5QhU=;
	b=3blMAsfyqBNfXzZVEyrHjljMwT9ob8KBFCP6BncOiqZz/Vywt09pU6BG6RUSweso7oq1Ps
	PKj+6GkClCIEe3iq6ZQfTiKKWBoZF++KSPNX/DiK1zvleOjgcps5/9pgMhYCdMhDclk2wJ
	62cVcnZrPpPGvVo9cdW+8zTerb0gcMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7TlYTChgUQHqfVflRagycL28iht36dZG/E2FUR5QhU=;
	b=63s8R0A+kifxo11DwJPfj2KUhoFdzMvyIS+RM+gkfEmyxTQWexpSRFB4+gVxFIzAsfxmgu
	gwPcLFBeoIBCqvBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 69BD513585;
	Mon, 19 Feb 2024 11:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DTp9Gb5A02UBbwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:51:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17925A0806; Mon, 19 Feb 2024 12:51:22 +0100 (CET)
Date: Mon, 19 Feb 2024 12:51:22 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, alden.tondettar@gmail.com, axboe@kernel.dk,
	brauner@kernel.org, dvyukov@google.com, hch@infradead.org,
	hdanton@sina.com, jack@suse.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pali@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Write in udf_close_lvid
Message-ID: <20240219115122.eejm7qvpalwqxxg7@quack3>
References: <00000000000056e02f05dfb6e11a@google.com>
 <000000000000aaf29f0611ac0603@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000aaf29f0611ac0603@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[47.74%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4];
	 TAGGED_RCPT(0.00)[60864ed35b1073540d57];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL5pfjehet7nrftwm4gcjwdrsk)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.dk,kernel.org,google.com,infradead.org,sina.com,suse.com,suse.cz,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.89
X-Spam-Flag: NO

On Sun 18-02-24 10:20:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c941c2180000
> start commit:   f016f7547aee Merge tag 'gpio-fixes-for-v6.7-rc8' of git://..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c2caf9e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f518f9e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Yes, this was expected :)
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

