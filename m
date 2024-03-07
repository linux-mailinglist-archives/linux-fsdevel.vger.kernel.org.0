Return-Path: <linux-fsdevel+bounces-13849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D56874AED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAB5289656
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97283CCD;
	Thu,  7 Mar 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BH2bNC8h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jYgYr550";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BH2bNC8h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jYgYr550"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC183CAD;
	Thu,  7 Mar 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804118; cv=none; b=p2yqMQTLBlrbbjFz8qVjiCqznnHAaBm/d8uV5jt46AWMgygaAHD/n8qO8TMzZCbsHQCOXLgL/66i15MSsJ/+TmsXTe//fwopoyinPlk4zHeNx72V0E7k2b+J6Hykg2Qfucb3INZP9rpw45q2Hn9QsWITPIiV68MLOgFbnQ2zRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804118; c=relaxed/simple;
	bh=Uc5ZprYNcyPowd4Yw2OUt8/1zkND3NAFZkFcouMiRD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiO8BIEOqAhAInyqOEiwYcV+PDgqjrGs4eMyx1EolsPtw39aBrlpXE/Oy1sKXxSXfcA/MJ0Baw9//TqweLjtxVRI8kLSsKtETEQgbMB3EbeWB/AsFr6DRLN7/rl3sUcbmAzuTkM12W1Vodw3Byi6jHqCtjFbZtNrflFQSi9I09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BH2bNC8h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jYgYr550; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BH2bNC8h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jYgYr550; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B295D38451;
	Thu,  7 Mar 2024 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709804034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2ffif3HoV85jCDMYVvYbxmoEMlvsTn1OSr+PumVWrU=;
	b=BH2bNC8h0nt/s82r0bM3xqHETjC6ocLimIvsGBV3cnnx1vCkldUNcMSVDFjiJH377cMYPG
	kwnpYepqmXK/QgTVd5vArT+xkKPH4iU+jVYU6DXR0jwV3KXq0R9DXFRlOrZQfuZe/I8YBW
	gIQbQE4j6cM49KESbh5o7Un1bVyAtvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709804034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2ffif3HoV85jCDMYVvYbxmoEMlvsTn1OSr+PumVWrU=;
	b=jYgYr5504nqdZZxSuWdxJyU7WR0mNnzx8fXeJFEAuM9dEBoeAS4+GbADD6tiBoYwXJJ5aV
	eiEn+IW0E4lHMKBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709804034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2ffif3HoV85jCDMYVvYbxmoEMlvsTn1OSr+PumVWrU=;
	b=BH2bNC8h0nt/s82r0bM3xqHETjC6ocLimIvsGBV3cnnx1vCkldUNcMSVDFjiJH377cMYPG
	kwnpYepqmXK/QgTVd5vArT+xkKPH4iU+jVYU6DXR0jwV3KXq0R9DXFRlOrZQfuZe/I8YBW
	gIQbQE4j6cM49KESbh5o7Un1bVyAtvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709804034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2ffif3HoV85jCDMYVvYbxmoEMlvsTn1OSr+PumVWrU=;
	b=jYgYr5504nqdZZxSuWdxJyU7WR0mNnzx8fXeJFEAuM9dEBoeAS4+GbADD6tiBoYwXJJ5aV
	eiEn+IW0E4lHMKBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A5A6B132A4;
	Thu,  7 Mar 2024 09:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FrUuKAKK6WVBHQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Mar 2024 09:33:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 46780A0803; Thu,  7 Mar 2024 10:33:54 +0100 (CET)
Date: Thu, 7 Mar 2024 10:33:54 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+f328fbf8718edb712341@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in jfs_readdir
Message-ID: <20240307093354.x2u5agzzl7awypvd@quack3>
References: <000000000000c4c9f105f2107386@google.com>
 <00000000000099ff3f0612cda952@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000099ff3f0612cda952@google.com>
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BH2bNC8h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jYgYr550
X-Spamd-Result: default: False [2.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.06)[61.21%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9];
	 TAGGED_RCPT(0.00)[f328fbf8718edb712341];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:email,suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 2.63
X-Spam-Level: **
X-Rspamd-Queue-Id: B295D38451
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sun 03-03-24 19:53:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b9e3ca180000
> start commit:   2772d7df3c93 Merge tag 'riscv-for-linus-6.5-rc2' of git://..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=f328fbf8718edb712341
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10233f38a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d35c1aa80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Likely corrupted fs so that logdev == fsdev and this fixed it. We could
perhaps add some sanity checking but does anybody care enough about JFS?
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

