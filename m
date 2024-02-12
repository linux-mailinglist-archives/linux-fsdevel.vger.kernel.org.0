Return-Path: <linux-fsdevel+bounces-11118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C08513D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2042826D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919E3A1CA;
	Mon, 12 Feb 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="blBBnxsI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x6Mtn4sn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="blBBnxsI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x6Mtn4sn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C233A1A0;
	Mon, 12 Feb 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742436; cv=none; b=VwUxRLtOyF6/2zltGc6183fCt+RHNDNZ58SOHxSJeUcDHJeH7LD9ntxIzYpSBVlsFxrWbU28haqKm6Yjt8cdFaqdre/zstPlhPUsukPahPgLEVu0rlwjGiikbthRFBmhyAosI3RkrhkKO+aE28Y5xpofg6nJYz1YDDLtcNNrL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742436; c=relaxed/simple;
	bh=zEEPERWAdTrhjwmxXlHsS+ZYiXFEbsEpCzMvbKm3akY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJgSVZgK2EbZW5/eUHKzgEK8O/MzAXEAxvBrQieg97RS/lyaDZXnUVFkGAKWXV8s6BGGvdhkNEIWR6zWTwfnAIwJjW1KG9g/QEZh/Zg+662YZ5VjxUJztyk/tfa64ppYeuAl4bFitIGpaiARIYuUJomsSoCBKRhoVRXCd/qFToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=blBBnxsI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x6Mtn4sn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=blBBnxsI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x6Mtn4sn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D9BD1FD5C;
	Mon, 12 Feb 2024 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707742433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAZ/gYikrs8yVuOIp6nlbQr7mCVwrUgtlMKBFaRKkS4=;
	b=blBBnxsIXJEGXACREy0dKQe2pdgz8fnzp0LY8wGmhh2wAapQXieoeLilClmecppNEEFEHM
	IbwN7PlcRBiZ7Pfni8SxzDAf7+e9YsgXR3d9nwogpvqGXn2R4By2vjzY4flExae/6tpmKT
	w4+wG2PLzTpugd98S7SN+1T8pLBpab8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707742433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAZ/gYikrs8yVuOIp6nlbQr7mCVwrUgtlMKBFaRKkS4=;
	b=x6Mtn4snmCNIvFZceNEKhiX/5lW2/JqdktFeMquGGhqBesZ2eLjq/XeaRZbWakWr0xEniE
	YlNQNoblx3niJpDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707742433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAZ/gYikrs8yVuOIp6nlbQr7mCVwrUgtlMKBFaRKkS4=;
	b=blBBnxsIXJEGXACREy0dKQe2pdgz8fnzp0LY8wGmhh2wAapQXieoeLilClmecppNEEFEHM
	IbwN7PlcRBiZ7Pfni8SxzDAf7+e9YsgXR3d9nwogpvqGXn2R4By2vjzY4flExae/6tpmKT
	w4+wG2PLzTpugd98S7SN+1T8pLBpab8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707742433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAZ/gYikrs8yVuOIp6nlbQr7mCVwrUgtlMKBFaRKkS4=;
	b=x6Mtn4snmCNIvFZceNEKhiX/5lW2/JqdktFeMquGGhqBesZ2eLjq/XeaRZbWakWr0xEniE
	YlNQNoblx3niJpDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 05F9913212;
	Mon, 12 Feb 2024 12:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eMlpAeEUymWiKwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 12 Feb 2024 12:53:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B92AFA0809; Mon, 12 Feb 2024 13:53:52 +0100 (CET)
Date: Mon, 12 Feb 2024 13:53:52 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+174ea873dedcd7fb6de3@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	neilb@suse.de, reiserfs-devel@vger.kernel.org, song@kernel.org,
	syzkaller-bugs@googlegroups.com, willy@infradead.org,
	yi.zhang@huawei.com
Subject: Re: [syzbot] [reiserfs?] KASAN: vmalloc-out-of-bounds Read in
 cleanup_bitmap_list
Message-ID: <20240212125352.tbaqzi7uphz66igg@quack3>
References: <000000000000cc796105ec1e4c7b@google.com>
 <00000000000098e3db0610fdf2a5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000098e3db0610fdf2a5@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLj5qg6pr6odqsqbkcmx7r3up3)];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[34.73%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4];
	 TAGGED_RCPT(0.00)[174ea873dedcd7fb6de3];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.90
X-Spam-Flag: NO

On Fri 09-02-24 18:39:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1257a6ec180000
> start commit:   f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=174ea873dedcd7fb6de3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14db6ca1e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12159e5ee80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

