Return-Path: <linux-fsdevel+bounces-8144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8927830329
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9DE1F259C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AD1EA7F;
	Wed, 17 Jan 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QeeU7ZZU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5IiQodCB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QeeU7ZZU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5IiQodCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19C15EA2;
	Wed, 17 Jan 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485674; cv=none; b=uE13oalEZbvNXlxrN9fC6FsUwiH8M/JOoWruqWH62K5EujDsUXk3hdBKqA0KwZtcxRF2J++kkH85MqDDM3qZh4PXTtx007nsq5zReNZosWglxFZ7KhsrN4YQ/mlZpFXx8OZq3Bz3ooDgnZEuwPLQJfNHPu33+YHqiEPbbREqbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485674; c=relaxed/simple;
	bh=twdgfNDdhF6Cbngn2QE0N1VbW0Ib+ZlzngmLLAEytFM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Spam-Level:
	 X-Spam-Score:X-Spam-Flag; b=MVkDpXBY0hNKs84G4jRi9l4tWabmICjT8uPECPEkpzZDIXC/TY1sJPBJ381DHivC11UDd7DDn/JH0xX98KLkOWL8Ada7S8vDPlrKhHgFs5PFlt9cL88jgdNfEEQKPJpi0q6ffuAHEmRugndtiRcS3icg6/O3Qt64PEsMHfNa3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QeeU7ZZU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5IiQodCB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QeeU7ZZU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5IiQodCB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA5E822210;
	Wed, 17 Jan 2024 10:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705485670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noMeLMpv/Ve0T6awG1lkzB4ii+xEPflaMDz+vuMhc80=;
	b=QeeU7ZZUYjU42k+mLtmorZsUXlFpzxSTEBCHT/BC3LLco7sbPYb+SwyNhQsvzMaYu2VGbY
	1Q82tUusuwBw2bW7Hx4uGzoSri3UtusE7JEPo0xoiyBEnRV7+ZWkaijIIEIkvzBiGAtG78
	comIkdv3fBq2vgKrcJiV923oC5U6CQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705485670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noMeLMpv/Ve0T6awG1lkzB4ii+xEPflaMDz+vuMhc80=;
	b=5IiQodCB1u8Ro6I49okcXns4nDtezTtASTdfxx53r73Buz9w6lqjaBEO6BWotbuLFaX1D6
	EQ10vqUY/UmI7EDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705485670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noMeLMpv/Ve0T6awG1lkzB4ii+xEPflaMDz+vuMhc80=;
	b=QeeU7ZZUYjU42k+mLtmorZsUXlFpzxSTEBCHT/BC3LLco7sbPYb+SwyNhQsvzMaYu2VGbY
	1Q82tUusuwBw2bW7Hx4uGzoSri3UtusE7JEPo0xoiyBEnRV7+ZWkaijIIEIkvzBiGAtG78
	comIkdv3fBq2vgKrcJiV923oC5U6CQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705485670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noMeLMpv/Ve0T6awG1lkzB4ii+xEPflaMDz+vuMhc80=;
	b=5IiQodCB1u8Ro6I49okcXns4nDtezTtASTdfxx53r73Buz9w6lqjaBEO6BWotbuLFaX1D6
	EQ10vqUY/UmI7EDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF559137EB;
	Wed, 17 Jan 2024 10:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cgPJKmalp2VCJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 10:01:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62FDCA0803; Wed, 17 Jan 2024 11:01:10 +0100 (CET)
Date: Wed, 17 Jan 2024 11:01:10 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+0ede990fe8e46cb5711d@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 do_mpage_readpage
Message-ID: <20240117100110.wdp6yqvrvsznzgwi@quack3>
References: <000000000000af650105f0e7a9e5@google.com>
 <000000000000d31227060f190634@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d31227060f190634@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[40.05%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd];
	 TAGGED_RCPT(0.00)[0ede990fe8e46cb5711d];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.90
X-Spam-Flag: NO

On Tue 16-01-24 16:07:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102de4dde80000
> start commit:   090472ed9c92 Merge tag 'usb-6.7-rc3' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ede990fe8e46cb5711d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d4a3cce80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ec6e8e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

