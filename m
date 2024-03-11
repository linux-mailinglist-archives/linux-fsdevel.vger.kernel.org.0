Return-Path: <linux-fsdevel+bounces-14116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A9877CCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B90AB20A90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D518C01;
	Mon, 11 Mar 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoWVN3bk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcYOR2Ic";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoWVN3bk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcYOR2Ic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4F182C5;
	Mon, 11 Mar 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149582; cv=none; b=qH3J+uAwFZpahMc2nXRHwXeJdPvCBgwDEzVBXS2OMiqG+2mIUjfZyJBEXuQ48P80W1T1NgynU0cOous9E7LZ7C/QEWGM/qMtw0M4/n1JciJ/tRNJtR10OjhLN6g92qaGmrD8mmenDZeG6uI+b68tlCpvNLcOpZzZiHQPtyjzxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149582; c=relaxed/simple;
	bh=wZb6/msMUpx9BpcFnxh9NohbHQHNlbgzy+qJSs5hmJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpCfB/t7FspePifgsMoiDZD0zRNpk24y5gTA0ETD52QXycHqOOebjHUV3eNT+sESApDTkP0c1E1/o4/fSB2MU+7637wHhs7EyFwtSkg9tomrYqPYS1JK31LVgbo3K4nEKiJqZRM7YHde+HWJEPPOv9OojzeTb4smwAEhYbX/aMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoWVN3bk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcYOR2Ic; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoWVN3bk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcYOR2Ic; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D3265C498;
	Mon, 11 Mar 2024 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710149579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puIqP+LeA+BJf1r3+7qBhUyJGd7JnBzX8pvlrc45KkY=;
	b=QoWVN3bkZXh2m3+udeVWG+YAHXgfIunWrFI2sUsnZW4YYpKAvK9fyapKsbVpnqbdSJ9G+P
	5zrYtdWvq/lVTcPEdPTDDNBKmS5m93LpGK+S7AdWoU+ZRAJB9f3xiUBJgYXrmqTp3UZu41
	hY7vdojUxMiUDmk0hZlwLJz2naCdpXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710149579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puIqP+LeA+BJf1r3+7qBhUyJGd7JnBzX8pvlrc45KkY=;
	b=LcYOR2IcrjXk7vEiGqvkN9JDjBO158L9OKz/kJjtQZDNn+Fnm32WOMI0lwHgxAav051TOn
	deFKf2Tt6+FlhWAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710149579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puIqP+LeA+BJf1r3+7qBhUyJGd7JnBzX8pvlrc45KkY=;
	b=QoWVN3bkZXh2m3+udeVWG+YAHXgfIunWrFI2sUsnZW4YYpKAvK9fyapKsbVpnqbdSJ9G+P
	5zrYtdWvq/lVTcPEdPTDDNBKmS5m93LpGK+S7AdWoU+ZRAJB9f3xiUBJgYXrmqTp3UZu41
	hY7vdojUxMiUDmk0hZlwLJz2naCdpXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710149579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puIqP+LeA+BJf1r3+7qBhUyJGd7JnBzX8pvlrc45KkY=;
	b=LcYOR2IcrjXk7vEiGqvkN9JDjBO158L9OKz/kJjtQZDNn+Fnm32WOMI0lwHgxAav051TOn
	deFKf2Tt6+FlhWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 617B4136BA;
	Mon, 11 Mar 2024 09:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +yjGF8vP7mXOBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 09:32:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0169AA0807; Mon, 11 Mar 2024 10:32:58 +0100 (CET)
Date: Mon, 11 Mar 2024 10:32:58 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	hch@infradead.org, hch@lst.de, jack@suse.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	liushixin2@huawei.com, nogikh@google.com,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [udf] WARNING in invalidate_bh_lru
Message-ID: <20240311093258.2oc6siuzmntx5jqk@quack3>
References: <000000000000eccdc505f061d47f@google.com>
 <000000000000af5c290612ac6d86@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000af5c290612ac6d86@google.com>
X-Spam-Level: **
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.03)[55.48%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=11e478e28144788c];
	 TAGGED_RCPT(0.00)[9743a41f74f00e50fc77];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 2.87
X-Spam-Flag: NO

On Sat 02-03-24 04:14:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a093ce180000
> start commit:   9a3dad63edbe Merge tag '6.6-rc5-ksmbd-server-fixes' of git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
> dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ebc3c5680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e8275680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

UDF is fixed but sysv still seems to trigger the warning so:

#syz set subsystems: fs

(we don't seem to have separate category for sysv bugs).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

