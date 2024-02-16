Return-Path: <linux-fsdevel+bounces-11837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F48579A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13B71C20B3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0362C190;
	Fri, 16 Feb 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFdaR3B2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q1u5265l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U68w4s5s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hUFQkUFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDA286AD;
	Fri, 16 Feb 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077377; cv=none; b=OwKK+kOfuv+qRtWGrEzFuAuepESIrrOTCB+OLrJHdYt7hMjEohRfmTTJ7/d/0mobz3qaSkG1p7nhOYcWHpw+O4a1CDY3lSXsRQTEtnuw+BN9PTZIcO1h9tZ68zhzie58UJGSreLrr1fQ1jLIeBGj3gwgweCGSG9NyDJyxxihTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077377; c=relaxed/simple;
	bh=qgM1IbsvGzczAw5jKcy/6Q9s0+/lUCgswwXcIJQTBxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMHtqI/crBLLOFUeIuc/a/GwNhpzxM+xZDFYYz8O5SycmNHGbsQhrIysG+cU2BnR02Jd+ZjYXhnApsBVLlWew9dmT6eiZ9rxJWHM8iNu+LUvdrrxU6XLnDV1XNr/U//HdcMJaF2OvpFMQ+paTergCWpAPdn+DSPgYq6Cjq408K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFdaR3B2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q1u5265l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U68w4s5s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hUFQkUFy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 068471FD76;
	Fri, 16 Feb 2024 09:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708077374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNCgQz/H7sNNYdQvBrUS+xmQz09BZKChFVLuwjEdyzo=;
	b=sFdaR3B2F/c4/C9vdJjb5tpPLGCRCsVtOza5Vs/rchdT2YuxOVFgqbo29eZQFRZ0epbTRk
	zrayHjgjx24loTZaRbzTo94YxXmqe8ZHhH4QrR4rKVghu1ao1gNnAb2G8XnLWoWcSo8VGM
	Ox6dZC4VY6hPPT+VDnR9jkNJEDjS6bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708077374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNCgQz/H7sNNYdQvBrUS+xmQz09BZKChFVLuwjEdyzo=;
	b=q1u5265lt3L+BLmK4qcsM6nhmIzrCguj+x5xAp8ZGAULrWTHtRl3GNtg0nhquv4IvrM8NO
	ZvCoRvFhln7MaRBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708077372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNCgQz/H7sNNYdQvBrUS+xmQz09BZKChFVLuwjEdyzo=;
	b=U68w4s5sd0ck087sZcyeF+kWHg6W6d8MhxXdfC7kYKRFzZJ3cs26gCojoSO1T3pH8Czejb
	K3kqII4z0NNaBAiFpof8PMyprokMl3TfwnCpm4MpsYV55Sq1u2TC2Lv5yWgM3mRF7oQu1s
	FuBuHuDgEMJFCUcdAxGUEt30jmpa8LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708077372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNCgQz/H7sNNYdQvBrUS+xmQz09BZKChFVLuwjEdyzo=;
	b=hUFQkUFy+hBBC85M+zi0X10ZJdNZKjhg91zVQcedSMJCXMntROXVj+fpkid/9Xvkj9xai/
	9pxCymfOYoljLxCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F214913421;
	Fri, 16 Feb 2024 09:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TB8UOzsxz2XJAQAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 16 Feb 2024 09:56:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2E43A0807; Fri, 16 Feb 2024 10:56:07 +0100 (CET)
Date: Fri, 16 Feb 2024 10:56:07 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+628e71e1cb809306030f@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tintinm2017@gmail.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING in ext4_discard_allocated_blocks
Message-ID: <20240216095607.zj3iqh4f7xkfy5ni@quack3>
References: <000000000000d8f8c20605156732@google.com>
 <000000000000457fc50611782483@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000457fc50611782483@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U68w4s5s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hUFQkUFy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[42.37%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ed626705db308b2d];
	 TAGGED_RCPT(0.00)[628e71e1cb809306030f];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[dilger.ca,kernel.dk,kernel.org,suse.cz,vger.kernel.org,googlegroups.com,gmail.com,mit.edu];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 068471FD76
X-Spam-Flag: NO

On Thu 15-02-24 20:26:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e72f42180000
> start commit:   7ba2090ca64e Merge tag 'ceph-for-6.6-rc1' of https://githu..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ed626705db308b2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=628e71e1cb809306030f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111acb20680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112d9f34680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks sensible.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

