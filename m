Return-Path: <linux-fsdevel+bounces-11664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE440855E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419121F217E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FB1B962;
	Thu, 15 Feb 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnRSQqyA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZC1bZP3y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnRSQqyA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZC1bZP3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BF1B813;
	Thu, 15 Feb 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989439; cv=none; b=Iaiqsc7mnVNHUq8f5KO4pyuNISh/ahxYl49IgtXxljY5ZjboqOSDmdfdbs4WFJGrXyl1G3XNyv2dDuGgE23zGgQQyGffuF9ByN1T+Q+W6h3+11cGVk9d6v4xoVsBz8CRyfEPx+qa6Jn3hlTm5cNBHBngoVhg9ohi6wlKiJ5gE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989439; c=relaxed/simple;
	bh=Vh2gd6ngDtjO1rJZW1wQZO5uWpZIhxBTH7DSHMSUu00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvz7RgtRQX+ytjFMh+2mZnLhw/PUIxupW6cHiphKL0EynzS94PQnXdoYwrMyzipHDBAnh6ANCJXEIvYU3ecFhlK1EL5NonCJhQ5JGHSqSSXN1k5ibxR4uiUXFgC1aqKoQYTdXMYyXUUR7RyHO8CdkZURjWdFULLhTKT8m6enQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnRSQqyA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZC1bZP3y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnRSQqyA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZC1bZP3y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C81D91FD36;
	Thu, 15 Feb 2024 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umLEaeKsx5iGBwuJjVRTx740aOVu8YEqX6/CsogZlGk=;
	b=ZnRSQqyA1yb3Ht5FOghkDhSAsVg40jZYekQuYSMVloyX9FTe68zBV/O3MM/K4DGsnMpfjS
	eklzOFW9CLkpZx5XjwKBiO9nx+r1diTmLV3iUZqe2CpyFPeqMB4fH9+WFYl9c6Ye7hJNIu
	ARwaWx80XqvLRuhEbcVaWF9kq6cSFAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umLEaeKsx5iGBwuJjVRTx740aOVu8YEqX6/CsogZlGk=;
	b=ZC1bZP3ywF9gYux/IdsqxrA3wlILGBDHK82f1pjKPmgfseP1udMoxjMAY+HQSq+ndCQD1e
	kiPa9leZqd/EDPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umLEaeKsx5iGBwuJjVRTx740aOVu8YEqX6/CsogZlGk=;
	b=ZnRSQqyA1yb3Ht5FOghkDhSAsVg40jZYekQuYSMVloyX9FTe68zBV/O3MM/K4DGsnMpfjS
	eklzOFW9CLkpZx5XjwKBiO9nx+r1diTmLV3iUZqe2CpyFPeqMB4fH9+WFYl9c6Ye7hJNIu
	ARwaWx80XqvLRuhEbcVaWF9kq6cSFAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umLEaeKsx5iGBwuJjVRTx740aOVu8YEqX6/CsogZlGk=;
	b=ZC1bZP3ywF9gYux/IdsqxrA3wlILGBDHK82f1pjKPmgfseP1udMoxjMAY+HQSq+ndCQD1e
	kiPa9leZqd/EDPDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE08413A63;
	Thu, 15 Feb 2024 09:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4dxeLrvZzWXBZwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 09:30:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C7ADA0809; Thu, 15 Feb 2024 10:30:35 +0100 (CET)
Date: Thu, 15 Feb 2024 10:30:35 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+63cebbb27f598a7f901b@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, chouhan.shreyansh630@gmail.com,
	eadavis@qq.com, jack@suse.cz, jeffm@suse.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org, rkovhaev@gmail.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [reiserfs?] general protection fault in __fget_files (2)
Message-ID: <20240215093035.2xaftqkkgvtknc33@quack3>
References: <000000000000caa956060ddf5db1@google.com>
 <00000000000040a8cd061164b23a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000040a8cd061164b23a@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZnRSQqyA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZC1bZP3y
X-Spamd-Result: default: False [2.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLwie348cgjx4ytqam5abccdgw)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[28.06%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83];
	 TAGGED_RCPT(0.00)[63cebbb27f598a7f901b];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,gmail.com,qq.com,suse.cz,suse.com,vger.kernel.org,googlegroups.com,linutronix.de,zeniv.linux.org.uk];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: C81D91FD36
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Wed 14-02-24 21:14:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fbb3dc180000
> start commit:   f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
> dashboard link: https://syzkaller.appspot.com/bug?extid=63cebbb27f598a7f901b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230c7e9e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133d189ae80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks sensible.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

