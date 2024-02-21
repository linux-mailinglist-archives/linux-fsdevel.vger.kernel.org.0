Return-Path: <linux-fsdevel+bounces-12252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877C585D574
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6F41C204DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66C3E483;
	Wed, 21 Feb 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJZmMTFo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="chhiuuHy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJZmMTFo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="chhiuuHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A545953;
	Wed, 21 Feb 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511025; cv=none; b=bSUG3t+C8aD+rPhxYxKFB0SgT2GoTcYRnASjii6EbJLsxaNfaTd/PICcli/AjVYVXJZ3sduqW9nDGDlqL/QCFkSNY0qmNBx0BwQt8687GJYEo3l/eFNvgWasvy84vHIFiK6Lv7rxIRYFrhh4kxEasHDlIp1Fl/H+d/UkAMVUv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511025; c=relaxed/simple;
	bh=Z7dZOMSEeCCP4d4SObybf4oqxbV8KdCpxT5f5whhQBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc8Grx4y5KAO1qhP+rn9hOXVlggHfHM3vjmyRXIo/L+TBegXVX5zLu8foXruU4RCOsvwFXefmoTNNJM+VSKW+wYtxNQlxFhdqoXPr1Wj62BA5pDv6jFh0AlVnHk2knb+wIVTWCC7l0+ptslAFus+gbxUpGiVngfMNk2QoTjzk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJZmMTFo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=chhiuuHy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJZmMTFo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=chhiuuHy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8575821F49;
	Wed, 21 Feb 2024 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708511020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwRKoQNdU7TokTyqWSCOhiUQb31LjSPweEvssF3ptLA=;
	b=AJZmMTFoK97KEnefobpzstz3Rtx5JO9oBlzA8DY4iv28XS/zYghLJSGBAhjbQ7v+hl2iYL
	+UYtR0gMhvrc487ZnoFvLIwyxaSqGCcIuAOptpRjv4qLe6M1tqMnRZg9kQS+6XjLJ1mrgJ
	BmoO3bITdfDdnc8qw4Ryljc+b7zt1CA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708511020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwRKoQNdU7TokTyqWSCOhiUQb31LjSPweEvssF3ptLA=;
	b=chhiuuHyVF+6lDFEB7X/S0GQFETJxoFWbql+Zga5Tx7V/AI/HWIx9Cg6RPX1KNBg21i8cE
	EEPhoVaoofW6CvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708511020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwRKoQNdU7TokTyqWSCOhiUQb31LjSPweEvssF3ptLA=;
	b=AJZmMTFoK97KEnefobpzstz3Rtx5JO9oBlzA8DY4iv28XS/zYghLJSGBAhjbQ7v+hl2iYL
	+UYtR0gMhvrc487ZnoFvLIwyxaSqGCcIuAOptpRjv4qLe6M1tqMnRZg9kQS+6XjLJ1mrgJ
	BmoO3bITdfDdnc8qw4Ryljc+b7zt1CA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708511020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwRKoQNdU7TokTyqWSCOhiUQb31LjSPweEvssF3ptLA=;
	b=chhiuuHyVF+6lDFEB7X/S0GQFETJxoFWbql+Zga5Tx7V/AI/HWIx9Cg6RPX1KNBg21i8cE
	EEPhoVaoofW6CvBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7939D139D1;
	Wed, 21 Feb 2024 10:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NomTHSzP1WXnFAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 10:23:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28F45A0807; Wed, 21 Feb 2024 11:23:40 +0100 (CET)
Date: Wed, 21 Feb 2024 11:23:40 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+ba698041fcdf4d0214bb@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	yuran.pereira@hotmail.com
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in
 run_unpack_ex
Message-ID: <20240221102340.auf7ltb7yikmysf4@quack3>
References: <000000000000bdf37505f1a7fc09@google.com>
 <0000000000007a3b2a0611d18c03@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007a3b2a0611d18c03@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[45.14%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[hotmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8cdb1e7bec4b955a];
	 TAGGED_RCPT(0.00)[ba698041fcdf4d0214bb];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[paragon-software.com,kernel.dk,kernel.org,suse.cz,vger.kernel.org,lists.linux.dev,googlegroups.com,zeniv.linux.org.uk,hotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.89
X-Spam-Flag: NO

On Tue 20-02-24 07:06:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149d61e8180000
> start commit:   41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdb1e7bec4b955a
> dashboard link: https://syzkaller.appspot.com/bug?extid=ba698041fcdf4d0214bb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e43f56480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fbabea480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

