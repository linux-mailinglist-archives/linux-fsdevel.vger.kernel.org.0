Return-Path: <linux-fsdevel+bounces-9348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB984022E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7041F2176F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272225644B;
	Mon, 29 Jan 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="amJ79dXt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMKqoTVk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="amJ79dXt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMKqoTVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9D55E57;
	Mon, 29 Jan 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521920; cv=none; b=cJ9FmQcD2m0BDoPKsOhXnUuT/MOL1dr46QnrHLkA5UiMLPKQDek0TkdrvzfPfcxzBwGuLlNpu9Vc7/ilv35VID3tR0doX5qvRr+B4EqaVR1HhZX6BuL7iegCnlsse1HjkqTb/t2Qh3eUaxklOLSVBkE5zPRV5jOMICopSlPqaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521920; c=relaxed/simple;
	bh=BFbyfdiKFqxDFQ5/HrCwZaeLqbvvSo3t/+qb4kmca60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axqF0sVbq8lQVWsweRfNVIwFv/KazR7cZDUInczmzu0ChrTSMtUruChunSeSzVIgX76r+0nQVeB9hPxD554wxxEyA3Dy2T2YgQ5NSaNYuYkVrbhmULmv2rfT6SoXwHd/hwzxdzeM8n2k6U8CB/791OSfhffIvPUWbvHFYxEVTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=amJ79dXt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dMKqoTVk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=amJ79dXt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dMKqoTVk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ADBE1F7D8;
	Mon, 29 Jan 2024 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7o+LwWp1PDCgbUnQrD7nsD1am1jFJ+W2Mw249hS9eM=;
	b=amJ79dXtv7Rg4hoSfnbdVZC8fRYeg5t6ODeSH0hBaLV0j0haqkEvmBWUNZW3vdqQqJWq5L
	MOx3YY4ppLZi5kf7A8q0W8YgCTMfb/xcUcNhAk58Vkk3jlvK/Qb4lvsO1YrjB/Fu52exuE
	XdO7hFcMGzvMkIPtMRXQSDO8xYrFctE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7o+LwWp1PDCgbUnQrD7nsD1am1jFJ+W2Mw249hS9eM=;
	b=dMKqoTVkI2eBs0X3OdW5ulxXAcqeOdb4RSkJ6Hd4Cia6iy8bbyjeNMgmOHy5IQUl8hGZBY
	/qYYKImszeU46SCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7o+LwWp1PDCgbUnQrD7nsD1am1jFJ+W2Mw249hS9eM=;
	b=amJ79dXtv7Rg4hoSfnbdVZC8fRYeg5t6ODeSH0hBaLV0j0haqkEvmBWUNZW3vdqQqJWq5L
	MOx3YY4ppLZi5kf7A8q0W8YgCTMfb/xcUcNhAk58Vkk3jlvK/Qb4lvsO1YrjB/Fu52exuE
	XdO7hFcMGzvMkIPtMRXQSDO8xYrFctE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7o+LwWp1PDCgbUnQrD7nsD1am1jFJ+W2Mw249hS9eM=;
	b=dMKqoTVkI2eBs0X3OdW5ulxXAcqeOdb4RSkJ6Hd4Cia6iy8bbyjeNMgmOHy5IQUl8hGZBY
	/qYYKImszeU46SCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CE37132FA;
	Mon, 29 Jan 2024 09:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6iUkAzt1t2VOSQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 09:51:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE983A0807; Mon, 29 Jan 2024 10:51:54 +0100 (CET)
Date: Mon, 29 Jan 2024 10:51:54 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+a0767f147b6b55daede8@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfsplus_find_init
Message-ID: <20240129095154.snaura4su4wrci3u@quack3>
References: <0000000000009947800605891611@google.com>
 <000000000000152c13060fe84ca5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000152c13060fe84ca5@google.com>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=amJ79dXt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dMKqoTVk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122];
	 TAGGED_RCPT(0.00)[a0767f147b6b55daede8];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-1.99)[95.01%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -0.50
X-Rspamd-Queue-Id: 1ADBE1F7D8
X-Spam-Flag: NO

On Fri 26-01-24 23:24:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11dd6ea0180000
> start commit:   a747acc0b752 Merge tag 'linux-kselftest-next-6.6-rc2' of g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
> dashboard link: https://syzkaller.appspot.com/bug?extid=a0767f147b6b55daede8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb6508680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16473130680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

