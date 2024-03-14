Return-Path: <linux-fsdevel+bounces-14383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708087B9FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F16B22900
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3034C6CDA3;
	Thu, 14 Mar 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3V3KCei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zo9nTbrc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CcYRAtia";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UGfAoFwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4535DF23;
	Thu, 14 Mar 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407093; cv=none; b=VxhifxvW7X5X2/DZ0Yi73sPCacTr7Jdz61J750YB8Y26j2aBHmc8SvBnUhPT3LNmrqklxTYwwtAAnUqcqgaYgHOHEko2Fk0BvgO7kvXlAyLp3YBcVrhZ4rVSrwb6ciF0UlVoNvjalQ88ram/GxuG2EumXHR8I5iaU9VE+J+0E+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407093; c=relaxed/simple;
	bh=DuBppVI8OFsrfbLGUnALzgRGUl5SE/OwtzdG0tsOWV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1t9OqNK5GTmewHzpFGVdQT4jp8UhiB1+9/y7PjU5Wsa5pEknaWeDn+1GfjPHNyIe6ejd7MOEWZiniSMuysShUstBUSL3No3IO/ev7eCPOvcotEfV5l+pY/GenZczatzirQmbvaOD0cSA93HKilyUq2aWCixGoOptkD1/VfoNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3V3KCei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zo9nTbrc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CcYRAtia; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UGfAoFwK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDDF51F820;
	Thu, 14 Mar 2024 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710407090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjUToQBvuK37roPXQ8xxYeAqajyioZAA+CA1GnboRG8=;
	b=O3V3KCeivhETaQOXbqUmqsu2uDrPvqh4PTsn/KMwlWE7j0FitFW7y+YC9VvIID9fS/Y+Mr
	hO2H1a1rQNkPwU0ZW+O0GurU5S9vTBlm1gwt4ELh1Lh86StAvG16wVZoweJE+ldplICQrY
	LqUywyszXI4Q3hV4Q5fbDFy6LcdpQD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710407090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjUToQBvuK37roPXQ8xxYeAqajyioZAA+CA1GnboRG8=;
	b=Zo9nTbrci6+EtOtcrSbU3fqHQG2XWk2P/Zq99pUongjK04UtJWqhWdN9yoGYezPZ9Fc+31
	3Xt1wdOzCiQEZCDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710407089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjUToQBvuK37roPXQ8xxYeAqajyioZAA+CA1GnboRG8=;
	b=CcYRAtiaI2wcZPOb5EfFhNjPTme7h+F5B6f9/bsTXTND2FcPPjLLFNuJg/JfEB100WMP2a
	W6UQ2vyi8nZOgX1Q2rXYFy0Xb6xLqpM6LHtyElF6GPgqX5VZsLQzHIc1TVz8L8i9pbGCwL
	0Qh+U7Uj2q1jfrUAiRRNXL2wZTBBqJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710407089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjUToQBvuK37roPXQ8xxYeAqajyioZAA+CA1GnboRG8=;
	b=UGfAoFwKWx6kJqIZ9WB+PBHWYkL2whETnx9fnx6yMYmPtR+ILOvcmVAKg7sQV0+oLdyPkm
	6TzRkc22z8NEPGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E27C41386E;
	Thu, 14 Mar 2024 09:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WtlDN7G98mV0MQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 09:04:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A545CA07D9; Thu, 14 Mar 2024 10:04:49 +0100 (CET)
Date: Thu, 14 Mar 2024 10:04:49 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+3625b78845a725e80f61@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in
 ntfs_lookup_inode_by_name
Message-ID: <20240314090449.rsuwfxtszjbadypc@quack3>
References: <000000000000cc261105f10682eb@google.com>
 <000000000000fea5b1061252ab7d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fea5b1061252ab7d@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.64
X-Spamd-Result: default: False [1.64 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.06)[61.59%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b];
	 TAGGED_RCPT(0.00)[3625b78845a725e80f61];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Mon 26-02-24 17:09:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ae7a30180000
> start commit:   cc3c44c9fda2 Merge tag 'drm-fixes-2023-05-12' of git://ano..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3625b78845a725e80f61
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16eae776280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d273ea280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

No reproducer anymore.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

