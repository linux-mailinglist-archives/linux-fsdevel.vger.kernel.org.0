Return-Path: <linux-fsdevel+bounces-12000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAA85A291
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92841C2178B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F22D61B;
	Mon, 19 Feb 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gMfhQGjO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CW3k+AAS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="buau6+K+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t31G6cyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121F2D604;
	Mon, 19 Feb 2024 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343779; cv=none; b=sM5cbThLK/xi8i6g0uww9T7F53Vt+okY9Rr9FPL/bVuA6OIDHjprOXHwF/fzHYKH9uLU/3Saa4N4/seZwaPeKE50vMWJV3KqnseMXuoeb4P8c60l5opSGnp4ugtYeJdbji2IKc3YOzcqKQXfHsqiZRVx941hX9GGd5Sa+ISwRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343779; c=relaxed/simple;
	bh=6EisK76yYaXOwsl5YMYWUtUhlQhrvrxsUxnJoTcUV9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgZCQ6SddtqiN+lYB5NS3L1nrlMrHr5d/N9ECM+gL3jyuoq4Oy3Oklus9CQXEOEpUckdjS3wjdQ8Ft0a3ksab96Uclsj8RqIuizXCxw73LMkQFD2dlYkP0t0B/6JYmj9+1wiDrv0CbMoOPNS2xbj6e2BmGz542KDPRRQ6ndpV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gMfhQGjO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CW3k+AAS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=buau6+K+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t31G6cyP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB9582231D;
	Mon, 19 Feb 2024 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0IoGNXF9cQZCZYZwVTpF79rld9vp/bZIPPNKytiUpQ=;
	b=gMfhQGjOI+lbem8SkpG7abYXZG/YGgsbr5mfhTFEt32zW1Limui820XncUd3JP4Jf/4cjb
	Ki2fipqnH6aZNqggQcrRBpvej5RFxm3Gf1k4azm8OzeBA2Zjorl5by+Ny2VFQpP4sFWCTW
	VqPFtogMpHtYR6RLlotNkKPFguE/0+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0IoGNXF9cQZCZYZwVTpF79rld9vp/bZIPPNKytiUpQ=;
	b=CW3k+AASubWZUsX7BEFpJjYNb6M0up0wqB5uWYsyR6VxJvrC9ZCwXfu8YryV9Fd8VAXOri
	5XB31zaQdMHLrYBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0IoGNXF9cQZCZYZwVTpF79rld9vp/bZIPPNKytiUpQ=;
	b=buau6+K+bHQBAEbQguScoIcRxtFI0j7HwT8gHAUdxEJUUcZwmnLmx902BD6L4pg2FD/uw8
	iCK1i7I3hf+0dC8b2q7Hc5ZRYKfDNUhrLEW5N2oQRMZEqKm6yoU+zPYXXkCHXnUVuq6BV7
	/ZFSsvDjjx6glmdQ6+bnmSX5XxMvZto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0IoGNXF9cQZCZYZwVTpF79rld9vp/bZIPPNKytiUpQ=;
	b=t31G6cyP2MTxAh//4JyTp9UpLAj2jDCsgF5zz0fCnkkhDX77LFRDdUwQO793OeIuKrM0Lb
	wjIs1K4uYH4qxVAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DE64213585;
	Mon, 19 Feb 2024 11:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gFdGNt1B02U2cAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:56:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92E02A0806; Mon, 19 Feb 2024 12:56:13 +0100 (CET)
Date: Mon, 19 Feb 2024 12:56:13 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+84c274731411665e6c52@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, damien.lemoal@opensource.wdc.com,
	jack@suse.cz, jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org, kch@nvidia.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [jfs?] INFO: task hung in __get_metapage
Message-ID: <20240219115613.frzm7ttf7vfdy3xo@quack3>
References: <0000000000004f9dd605eabee6dc@google.com>
 <00000000000056790c0611b5548c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000056790c0611b5548c@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.69
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[47.63%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4];
	 TAGGED_RCPT(0.00)[84c274731411665e6c52];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 R_RATELIMIT(0.00)[to_ip_from(RLpdan7qhx516wxzbnn3a3f9z9)];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sun 18-02-24 21:26:01, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13310158180000
> start commit:   1b929c02afd3 Linux 6.2-rc1
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=84c274731411665e6c52
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1702dc54480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b9eaf4480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

No working repro and this is JFS. So:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

