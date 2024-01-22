Return-Path: <linux-fsdevel+bounces-8472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F283734A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED32293EEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7723FE54;
	Mon, 22 Jan 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dFP10img";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZ/Dtf1l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dFP10img";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZ/Dtf1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8F3FB1E;
	Mon, 22 Jan 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953270; cv=none; b=uiEcmyUjAkT69ROMUn8oFOBdFq1t9x8Z6XLb5QaFNV8xSyYGsZlfFH3zdtIgu2vSVaMjrZWwHhmBBBNAgsy5SqbTBO1oSQU1uVFVvBi7adL/zqfmzBNGZ6C0R9gYQSNxkBlDoF+KTP5AwcjPWJhxpqnz7kTh3zLYY21FgzIdyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953270; c=relaxed/simple;
	bh=i1B7kKkGPxHTcsk33Z8XJqC9IbrP4KlqaJmncPv16y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiP6JnBellhLogIna7nc1qEGavuiYq7QJC962uTp+0ajF3HaJAu8o1UdNZM7rTwgNqwrog0uqrPBNNvN5I9On6Tbh1vqdDH2skBwtFWUtYymVFbxEr1YATUVGx0EyQe8m6ZarDTzElrlBTuYDIEjGf2q1MVPWrw2B7uY0GNOIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dFP10img; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZ/Dtf1l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dFP10img; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZ/Dtf1l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11F9521F90;
	Mon, 22 Jan 2024 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705953267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vx5KP9WvB2n2v4NgVdU3sYb+/jhVLCOVyTS0uakstFU=;
	b=dFP10imgNaRtvioUzNMGkTKC5oFVN7Q38tjfuJc2o+5jCDTB68/OOI0KNBTAFx9BxzN7Nw
	6wKEbSmTw2mcKR5agje9tuBpnkKdkOFkMdFq62DAnQg3u42aDY0b3w8u9rDwbiDw88Xeoh
	IlyZVFFP6PFn+VPjQWP8KhPY0CPqNJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705953267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vx5KP9WvB2n2v4NgVdU3sYb+/jhVLCOVyTS0uakstFU=;
	b=QZ/Dtf1l8ttro/rS/gasA8apm4AINK+aug5FesMn69g3GU7IU8Uv0YPudFGjMruEwxGbDT
	wMSCbyIChDRoEDAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705953267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vx5KP9WvB2n2v4NgVdU3sYb+/jhVLCOVyTS0uakstFU=;
	b=dFP10imgNaRtvioUzNMGkTKC5oFVN7Q38tjfuJc2o+5jCDTB68/OOI0KNBTAFx9BxzN7Nw
	6wKEbSmTw2mcKR5agje9tuBpnkKdkOFkMdFq62DAnQg3u42aDY0b3w8u9rDwbiDw88Xeoh
	IlyZVFFP6PFn+VPjQWP8KhPY0CPqNJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705953267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vx5KP9WvB2n2v4NgVdU3sYb+/jhVLCOVyTS0uakstFU=;
	b=QZ/Dtf1l8ttro/rS/gasA8apm4AINK+aug5FesMn69g3GU7IU8Uv0YPudFGjMruEwxGbDT
	wMSCbyIChDRoEDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05BE413995;
	Mon, 22 Jan 2024 19:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4XtlAfPHrmW5OAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jan 2024 19:54:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 785B8A0803; Mon, 22 Jan 2024 20:54:22 +0100 (CET)
Date: Mon, 22 Jan 2024 20:54:22 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+6a0877ace12bfad107fc@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	yijiangshan@kylinos.cn
Subject: Re: [syzbot] [reiserfs?] kernel BUG in balance_leaf
Message-ID: <20240122195422.45jfvwcu7pdscv3u@quack3>
References: <0000000000001eae4605f16be009@google.com>
 <000000000000a8f68a060f6c259f@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a8f68a060f6c259f@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.69
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[47.77%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0];
	 TAGGED_RCPT(0.00)[6a0877ace12bfad107fc];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sat 20-01-24 19:17:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cc8ee7e80000
> start commit:   88603b6dc419 Linux 6.2-rc2
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=6a0877ace12bfad107fc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdb82a480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108acc94480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

