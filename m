Return-Path: <linux-fsdevel+bounces-9347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F0840228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503BF1C2169D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5608855E4F;
	Mon, 29 Jan 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j/VFXs98";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bY/0bByW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExOiFmRN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PViUZ3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420A55C27;
	Mon, 29 Jan 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521824; cv=none; b=e/4kniKtRUq3hw/96SJQYRl+WOvlOxlX8PokOJJkPhjsAL7kwmzr1Ht4yG2LEoPB/eTW6iDk7DINfaJzsbALTlQ58IO+6/nHGOze6CAzM7RY6GtYWWpXpuvma/a2z95sy2/X3UK7OmGUm7px/QNIi6vfGbZ0cpYxD144bfUV6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521824; c=relaxed/simple;
	bh=1LDs/1149/gzs8FgijuSz/Ne/XnXJo+5DP6uHCC0Jhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbD3VlUfIVwqO2l8r3oChjN5e2+nHreO3X2TkfZ8FCTkgX/OaBho5e5d+X5AjWNwk//9OMN2Wnk3xIXJ/IecyaLPeYfNPLSLOfEZd3wmHFGE2efwEJpV8+fWvRqEA851/DNgOYuP7NY0Te2/+8RUGDjct6ypKz3LvmoVcssXzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j/VFXs98; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bY/0bByW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExOiFmRN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PViUZ3f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4724621D0A;
	Mon, 29 Jan 2024 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXgjna/jwVDjAWCN2RHebYLXvndhQa9XD3OSaauQ8OE=;
	b=j/VFXs98b3YMFfLwPl7nmsQ7fTKfc4M7vI/D5RlpSMLmBHHoxLsAdUZPAaWcF1+t8IL9tZ
	nRE4U+RBn9EkK4MYSZU5ta4MnsJxQK89Hp4ILppw3MmeID/Wf+LqvvB/npv3qY8i3dZZA2
	EyFJtxSlqUVdKXfyAZsdsOAZgdb2orc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXgjna/jwVDjAWCN2RHebYLXvndhQa9XD3OSaauQ8OE=;
	b=bY/0bByWMHLtUT2v77fz1263z0d7hJ+eRDS4V3+Q//pBLpwOHjto12+O4jEFXWiJnkq/ph
	pS+N3XpanoKF+9AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXgjna/jwVDjAWCN2RHebYLXvndhQa9XD3OSaauQ8OE=;
	b=ExOiFmRNRWF+xBf6a8rw31jZTqaeKNMf7J7K1gTmxHt+cK2yIcy9J3VQ/eNiHM01ny25YL
	LjCMqS6mTdneCfDIlxMZ7+dzmBUtTCY2TG9AraGT4jMDCFjEIKLOUvNM//Gt9xxFOCrPLK
	SKzVJ28/sV6LNn6BxgWDwmRawR50ukc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXgjna/jwVDjAWCN2RHebYLXvndhQa9XD3OSaauQ8OE=;
	b=1PViUZ3fHAEwY71oIjQ6JnkMdsg21PS8L04yKateieJmlP2yY6AzB9wz80ccRNEud6nDym
	OBDmKn+4xQJe6gCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B2F0132FA;
	Mon, 29 Jan 2024 09:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zl5vDtt0t2WtSAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 09:50:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2171A0807; Mon, 29 Jan 2024 10:50:18 +0100 (CET)
Date: Mon, 29 Jan 2024 10:50:18 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+22e381af27f7921a2642@syzkaller.appspotmail.com>
Cc: anton@tuxera.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs?] kernel BUG in ntfs_truncate
Message-ID: <20240129095018.2epmpxstumyhzrc7@quack3>
References: <000000000000a213d505f1472cbe@google.com>
 <000000000000582e37060fefac1a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000582e37060fefac1a@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.98 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.92)[94.57%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4];
	 TAGGED_RCPT(0.00)[22e381af27f7921a2642];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.98

On Sat 27-01-24 08:12:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179a855fe80000
> start commit:   bff687b3dad6 Merge tag 'block-6.2-2022-12-29' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=22e381af27f7921a2642
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175a9dbc480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1542c884480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

