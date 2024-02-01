Return-Path: <linux-fsdevel+bounces-9818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68BE845388
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655C41F2925F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC3D15B96B;
	Thu,  1 Feb 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbaHIs4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBPUU3Uo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbaHIs4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBPUU3Uo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E515B0F9;
	Thu,  1 Feb 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778862; cv=none; b=UoNteyjtewwn+0AC0wOAfCdUTgmGalQY/h44Y0SsO/CtXBpNvPK6l2Yw5UkHuurZYnfpdfrGwQYpnl1eXJLbASRIhmWOcP32qD2oE8T1YGG4nBp7VwIsNprFK6+7KliemcF9cd/CPYKTMO4e4MXq2ZgJtk53/YwD7BgFpEqfiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778862; c=relaxed/simple;
	bh=35I/4ETFMVgxg6CJT0uJUyv5QL43GJzyjJq4wVkwSxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH8IvM3wwgs1atKJMbneRs/uD0aQhYEE2bNQhM3Ma1HZICZ1GzYHzmRqtd1b3PH5uD21b6BGAsRsimrJn8lR6/59EdL0wfkWUfY3o7NVs8SHNgMltGtgGbsbUrb3NDQ4W9uFJhL5eAFJatAi9ed/EMzQDY5BGKdeIUGxw0TW6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbaHIs4a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBPUU3Uo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbaHIs4a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBPUU3Uo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24EC51FB82;
	Thu,  1 Feb 2024 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706778859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0lhF+jRm2+GaFMUA9qvbMYRCg3c9XzJlwSiMwmPEKM=;
	b=rbaHIs4amEgm58hLkh8H3XIBvpDAC0lCSbNOW2mNriWBaMjqbp2Z663HVIot7H/CsMNlGT
	wuTUrRlyuAy6A48k/ENwgZsGHF88J60aeKVbk0/ABHf4eIESxp2SLG2JfEBQRNY962APMI
	4sv3oJ2yXAksBWhAW88vZT5l9iKpgBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706778859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0lhF+jRm2+GaFMUA9qvbMYRCg3c9XzJlwSiMwmPEKM=;
	b=XBPUU3UoGMr5C8RvsW0EE9t4ciVC68M8T5KiM6x9+1k4XZum+neQb3uZmRJTpMPsTNTjkI
	1nzj/S5/ctjpoZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706778859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0lhF+jRm2+GaFMUA9qvbMYRCg3c9XzJlwSiMwmPEKM=;
	b=rbaHIs4amEgm58hLkh8H3XIBvpDAC0lCSbNOW2mNriWBaMjqbp2Z663HVIot7H/CsMNlGT
	wuTUrRlyuAy6A48k/ENwgZsGHF88J60aeKVbk0/ABHf4eIESxp2SLG2JfEBQRNY962APMI
	4sv3oJ2yXAksBWhAW88vZT5l9iKpgBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706778859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0lhF+jRm2+GaFMUA9qvbMYRCg3c9XzJlwSiMwmPEKM=;
	b=XBPUU3UoGMr5C8RvsW0EE9t4ciVC68M8T5KiM6x9+1k4XZum+neQb3uZmRJTpMPsTNTjkI
	1nzj/S5/ctjpoZCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 162CA13594;
	Thu,  1 Feb 2024 09:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wgllBetgu2XbTgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:14:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0DE2A0809; Thu,  1 Feb 2024 10:14:18 +0100 (CET)
Date: Thu, 1 Feb 2024 10:14:18 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, groeck@google.com,
	hdanton@sina.com, jack@suse.com, jack@suse.cz, kernel@collabora.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	shreeya.patel@collabora.com, steve.magnani@digidescorp.com,
	steve@digidescorp.com, syzkaller-bugs@googlegroups.com,
	zsm@google.com
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_sync_fs
Message-ID: <20240201091418.rqapa3fbc563jeyk@quack3>
References: <00000000000024d7f70602b705e9@google.com>
 <000000000000d33080061046ed47@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d33080061046ed47@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d];
	 TAGGED_RCPT(0.00)[82df44ede2faca24c729];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLnp55o5df8f6i9gmhay37f8wn)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,google.com,sina.com,suse.com,suse.cz,collabora.com,vger.kernel.org,digidescorp.com,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Wed 31-01-24 16:18:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11282540180000
> start commit:   55cb5f43689d Merge tag 'trace-v6.7-rc6' of git://git.kerne..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
> dashboard link: https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dbd63ee80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1534bed1e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks good.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

