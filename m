Return-Path: <linux-fsdevel+bounces-9338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D6C84017F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5D21F26D21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5055E4A;
	Mon, 29 Jan 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZDNBM9KY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cB0yyXiT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZDNBM9KY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cB0yyXiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C778955C05;
	Mon, 29 Jan 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520455; cv=none; b=gyzQre3F2MPvR2UQRtA0zuGuc6dACmpI+lKfNGle1ShQ8QLh+izzIReKOGatTFPMqAmWYe3gB/QgbPC+SnQqL0vU1/DxOxrCsoFo/pHu0Jf1wsfGwVvxHl0dIkpwRMN1k43jLjZj9+7KwdthPmy5ms/qy6U5SlNn6TSKl5Xwx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520455; c=relaxed/simple;
	bh=VsiVxzTbTaLu7R1Vjuj7c3jEKlCzr5I/cSPclERw6/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIgnvQARwm5lLN1Ctac4DeTjAhmHkj+BDBc5QVqQZaSj2FtfwrsYi1uZ6glseZfPpmrFiV9uhyHZio5X09qlB/lCQLs8xyoa4ZOJq3ClUGZzsOk0E5usU++C4skxu6xUJBcB6bBv5Vzax6jsNLiDQV8EHE35D9vBXPAx3OOpR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZDNBM9KY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cB0yyXiT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZDNBM9KY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cB0yyXiT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBF711F7DE;
	Mon, 29 Jan 2024 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706520451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNF1/TeRE/xduKFDk0e37ozpmkiTyLLOJA0349b6JaY=;
	b=ZDNBM9KYFX7JJ0kMoCLPXttTZewoecqxfHxdB/uVibt4fhMqnhBF9w9ikFEsgyr1xmRPEA
	BhKcRgXo4Ir0zjR44FvnGWf+td+7RlrFHmiNRMt1kdrPnaLX74zfTihILUiMU0jG6bh/Iw
	tZzAbtHAXAusdUiKKtnYNlHQmLfuePA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706520451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNF1/TeRE/xduKFDk0e37ozpmkiTyLLOJA0349b6JaY=;
	b=cB0yyXiTrIIuSzjPcGODnI6L0p80/Eu+qIzrf6ikkgGa87itYjccOAQbjOnpGUx3a6aBBd
	JL85ojTzA46dY4BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706520451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNF1/TeRE/xduKFDk0e37ozpmkiTyLLOJA0349b6JaY=;
	b=ZDNBM9KYFX7JJ0kMoCLPXttTZewoecqxfHxdB/uVibt4fhMqnhBF9w9ikFEsgyr1xmRPEA
	BhKcRgXo4Ir0zjR44FvnGWf+td+7RlrFHmiNRMt1kdrPnaLX74zfTihILUiMU0jG6bh/Iw
	tZzAbtHAXAusdUiKKtnYNlHQmLfuePA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706520451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNF1/TeRE/xduKFDk0e37ozpmkiTyLLOJA0349b6JaY=;
	b=cB0yyXiTrIIuSzjPcGODnI6L0p80/Eu+qIzrf6ikkgGa87itYjccOAQbjOnpGUx3a6aBBd
	JL85ojTzA46dY4BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AAEC113911;
	Mon, 29 Jan 2024 09:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vZZlKYNvt2VJQwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 09:27:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 52859A0807; Mon, 29 Jan 2024 10:27:27 +0100 (CET)
Date: Mon, 29 Jan 2024 10:27:27 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+cc717c6c5fee9ed6e41d@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] WARNING in udf_new_block
Message-ID: <20240129092727.s3smagmot77rmsud@quack3>
References: <000000000000e9e9ee05f716c445@google.com>
 <0000000000007bd31e060ff7d8f0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007bd31e060ff7d8f0@google.com>
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
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=11e478e28144788c];
	 TAGGED_RCPT(0.00)[cc717c6c5fee9ed6e41d];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sat 27-01-24 17:57:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fe39a7e80000
> start commit:   10a6e5feccb8 Merge tag 'drm-fixes-2023-10-13' of git://ano..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
> dashboard link: https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16700ae5680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f897f1680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Yes, I was suspecting this from my experiments for a long time :)

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

