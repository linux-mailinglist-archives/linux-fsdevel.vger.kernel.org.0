Return-Path: <linux-fsdevel+bounces-12253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D59585D5A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 11:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7495281D11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0703DBBA;
	Wed, 21 Feb 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ENIgR1f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tQtXydgG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ENIgR1f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tQtXydgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F43C48F;
	Wed, 21 Feb 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511666; cv=none; b=KciOeTmd3GjSW0FZRGFEB4F3Nv9CMRiMr5G3H+C4hIsUNLVbPOcpXBMHpu2OKnS6LygVoE0njYx9M88clwxZsED/66XQ1Wk1byRQyEcZe0+VjiTLBlADCzq8CinRs/GhmW/P8i5GG9sZwk5eCbgR+1io1n+LMZjuiPMsglpYsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511666; c=relaxed/simple;
	bh=wUOqLBY9oKGjiFx5WoA63nIO1h1dNcTwHpYjQgN5GxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgCFVHwbALrR/LZcsgND9ZOfeA6I1Lptm/W462T4/X7zwPwlXOSIYpZLJPnRtq7p2uCyv7RPR9WZ0K/RhRtok8Z02IoWGweGNCCAzWAzFLqaIWQQB6v8lEuA+gy1w303OyyXu9QQnAokYGjXyDPJANe2aELr7dDDDE9adyY5jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ENIgR1f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tQtXydgG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ENIgR1f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tQtXydgG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0137C1FB4E;
	Wed, 21 Feb 2024 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708511662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCjnOHa77sD0Hwc3gx9J1PdVfdTw1xdGiol8HKEHfNI=;
	b=2ENIgR1fdsqjy0a5hEkVQTZadOfqraTfcm8fWl9HB/jCo9SaSshMmUVpgh+x5J8C04Fbd4
	6gH1MCoqiFHAnBzZr5OGL+tbDAMLqP9b246eHTPqlKCOlj7LhMBaiMzv8izXvpj3SWCg4U
	WOTDbmndjUpfwQHhVJCTH7oyxl/QX7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708511662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCjnOHa77sD0Hwc3gx9J1PdVfdTw1xdGiol8HKEHfNI=;
	b=tQtXydgGZrv69ajxmzvYd+UnVfBHcAnpOWwPywIVRiXk0B7i6d/Y7PDNEU+Y6Ge94C0Hby
	V2u7GkLuXD0uOKAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708511662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCjnOHa77sD0Hwc3gx9J1PdVfdTw1xdGiol8HKEHfNI=;
	b=2ENIgR1fdsqjy0a5hEkVQTZadOfqraTfcm8fWl9HB/jCo9SaSshMmUVpgh+x5J8C04Fbd4
	6gH1MCoqiFHAnBzZr5OGL+tbDAMLqP9b246eHTPqlKCOlj7LhMBaiMzv8izXvpj3SWCg4U
	WOTDbmndjUpfwQHhVJCTH7oyxl/QX7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708511662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCjnOHa77sD0Hwc3gx9J1PdVfdTw1xdGiol8HKEHfNI=;
	b=tQtXydgGZrv69ajxmzvYd+UnVfBHcAnpOWwPywIVRiXk0B7i6d/Y7PDNEU+Y6Ge94C0Hby
	V2u7GkLuXD0uOKAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E781B139D1;
	Wed, 21 Feb 2024 10:34:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Gyh6OK3R1WWPFwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 10:34:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D0F6A0807; Wed, 21 Feb 2024 11:34:17 +0100 (CET)
Date: Wed, 21 Feb 2024 11:34:17 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+cf96fe0f87933d5cd68a@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com,
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in lmLogClose (2)
Message-ID: <20240221103417.v4zrc2bzw6zq7npi@quack3>
References: <0000000000005f876b06075a4936@google.com>
 <0000000000004a34ce0611d33dfa@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004a34ce0611d33dfa@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2ENIgR1f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tQtXydgG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.48 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[45.73%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423];
	 TAGGED_RCPT(0.00)[cf96fe0f87933d5cd68a];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.48
X-Rspamd-Queue-Id: 0137C1FB4E
X-Spam-Flag: NO

On Tue 20-02-24 09:07:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cf63d0180000
> start commit:   b78b18fb8ee1 Merge tag 'erofs-for-6.6-rc5-fixes' of git://..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
> dashboard link: https://syzkaller.appspot.com/bug?extid=cf96fe0f87933d5cd68a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120a1c45680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1230440e680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

OK, no working repro.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

