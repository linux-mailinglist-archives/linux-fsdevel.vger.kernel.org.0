Return-Path: <linux-fsdevel+bounces-10630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE684CF53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A611F235D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3D823D9;
	Wed,  7 Feb 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IchEwQbe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0p9BYUK2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IchEwQbe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0p9BYUK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60F823A6;
	Wed,  7 Feb 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325368; cv=none; b=Dew6nkK7tApDnD5tWEsqnCNhZaG84ZFRHX14Y0BOl21l0jUa5tY6/IIHn6yBxXOAPHlZfGLoostcHphRLK/vZMbdLnfyfgdhHY/+5HJr2vfatj3i3q9HJEQHdV2M3p31H+CVeDfTMWBcrvtYWo1trGCGVL5apgTTMciY2pINh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325368; c=relaxed/simple;
	bh=WgD1NhEQjsL++ZYh/RfI+iB5inPBUdnV7Z8lEE2yr7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQMnegRSXAiO8/nudWGzSh43JkqV7NWtEa19SLYQ756JmWZ5acY6NziPDfM8379XoSPU3+P5p/1CW68UkJ1/G9QAVZnMf7TI5NzDKoqq73VHNrVhMA/rzwlsnKu2eW4KrUwOHc22/pCEbd1Fg44KWUlNZ8+qa+0lBgpQgEotr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IchEwQbe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0p9BYUK2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IchEwQbe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0p9BYUK2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9339B222BE;
	Wed,  7 Feb 2024 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707325364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrZhZlhxqXLYEkbdk4VPL60MymfHMgRveGBli/w4prU=;
	b=IchEwQbek5eJuciXztHCVOT7ob/EnnUFsLWQo2JcsiDx9A1vrA6kJOIMrg4+MO4FZT5/cQ
	36dWdkuVCUAebmrkYTpKzRbuDdEmVgcx5yYhGlnL+gjEhP+QcJ4ieQOAQTu7MwfMuwyQkI
	Rbdzhl9C51GCM39XYk+haCC210YlWvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707325364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrZhZlhxqXLYEkbdk4VPL60MymfHMgRveGBli/w4prU=;
	b=0p9BYUK2//btrZIakwH6JQSmeajGmqZ6HUIc0WsSRaNMi+d7aZPuUzhcSjyVYGD/QkyRSN
	bcV5ELab88p91HAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707325364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrZhZlhxqXLYEkbdk4VPL60MymfHMgRveGBli/w4prU=;
	b=IchEwQbek5eJuciXztHCVOT7ob/EnnUFsLWQo2JcsiDx9A1vrA6kJOIMrg4+MO4FZT5/cQ
	36dWdkuVCUAebmrkYTpKzRbuDdEmVgcx5yYhGlnL+gjEhP+QcJ4ieQOAQTu7MwfMuwyQkI
	Rbdzhl9C51GCM39XYk+haCC210YlWvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707325364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrZhZlhxqXLYEkbdk4VPL60MymfHMgRveGBli/w4prU=;
	b=0p9BYUK2//btrZIakwH6JQSmeajGmqZ6HUIc0WsSRaNMi+d7aZPuUzhcSjyVYGD/QkyRSN
	bcV5ELab88p91HAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 865C913931;
	Wed,  7 Feb 2024 17:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kr7FILS3w2XUWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 17:02:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A843A0809; Wed,  7 Feb 2024 18:02:44 +0100 (CET)
Date: Wed, 7 Feb 2024 18:02:44 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+3969ffae9388a369bab8@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] KASAN: use-after-free Read in
 set_de_name_and_namelen
Message-ID: <20240207170244.unipov7cbfbrupnb@quack3>
References: <000000000000a5f23f05ee4865cf@google.com>
 <000000000000027e150610c8b964@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000027e150610c8b964@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[45.88%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd];
	 TAGGED_RCPT(0.00)[3969ffae9388a369bab8];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.89
X-Spam-Flag: NO

On Wed 07-02-24 03:09:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fffd6c180000
> start commit:   c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3969ffae9388a369bab8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1615d7e5880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f20981880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

