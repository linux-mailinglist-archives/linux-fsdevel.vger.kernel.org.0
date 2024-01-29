Return-Path: <linux-fsdevel+bounces-9343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1084020B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FD2B21C24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAF855C3C;
	Mon, 29 Jan 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NF/PHnH9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zcSeZM1P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tbGJlGRx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Rbc9reI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746954FB2;
	Mon, 29 Jan 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521696; cv=none; b=p/G74dFskDpJL+n1/rUNm6Xlv5B059GbLP70Ph1VWy4D6cdJWK3Z4En5JN8/JL0vWkWOdARVGKYBiKhYj/EYxmVVGQZd/CUeRRARYnCID4D3YkxMUxQ4+F6N1MkRLzavxw0mkNKXJCXxJJmAI5jwGyzcboHzTeUjrYFc5qhqm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521696; c=relaxed/simple;
	bh=lZp4B8/X7iGeRGYaF4h7VrLKqQ3yRb5lMoBK1NDEm90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9/crc4H7Fk2T/cY51XmBi82299HqK7ylnyLZ6AFQmXwlUJJ4TbYd2cnYL+fNTvl4mIlI8T3ama10HEj/jlS9RkpMS5YMnnbeH+XjPXTirUFCtOhTLkAVvxDG0hs3Ra1xwjuNnQGLkrsfjxC2OGKOHXQ+oVWM7ttJjHnGq0Yjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NF/PHnH9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zcSeZM1P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tbGJlGRx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Rbc9reI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED2C41F7D9;
	Mon, 29 Jan 2024 09:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmpTTia17vyEaKGYUUOvxtVzozWeZCTbooCnzwEKXbc=;
	b=NF/PHnH9XE1aAeTVJPh1xj0pW17LsYtUGGi6DXLWChkYOyQ3MlrqdOMrXI4+iZ/gyWVfEH
	yM98ni+nT5+EdSyNfDm5X+PFUaa6D8HZxLGKb427x6bta5N9Al9HaMnTFFbZNvZoecSRL9
	04O8imtZ6R8Ol3/jFkVe2DB2kC+TaBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmpTTia17vyEaKGYUUOvxtVzozWeZCTbooCnzwEKXbc=;
	b=zcSeZM1PfrSYYEQrdvk7hRpx2uPJ894PuwbW1RKQYjjlR0F/GZHdn7IwRjdpkk2XYmmgqe
	N686iZZd50yXOzBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706521691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmpTTia17vyEaKGYUUOvxtVzozWeZCTbooCnzwEKXbc=;
	b=tbGJlGRxGOHBIfyWK1gIi0YOs/tWLdVXXWIpYc30p/HAOXe8shLae86iQPOWsZjpSe3Yuo
	ZAhu5/uVMgF7Tby4K6AlsXWX8q58ctYlPcf4wNxXT1N2sMJHg0WxB/zsTbixx82x8qCY1A
	55Us/wsv55lQbZaGY9bLHAnVm5+CNJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706521691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmpTTia17vyEaKGYUUOvxtVzozWeZCTbooCnzwEKXbc=;
	b=9Rbc9reIIEMPwFgkN1XZTTi+xAkZhNdD7enl3kkj27sfanIZxAxAZc0k2VGAYzO/imWt3L
	Vm+/YNBFCG75HYDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E151B13911;
	Mon, 29 Jan 2024 09:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TiH5Nlt0t2UiSAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 09:48:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92301A0807; Mon, 29 Jan 2024 10:48:11 +0100 (CET)
Date: Mon, 29 Jan 2024 10:48:11 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+04e8b36eaa27ecf7f840@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] KASAN: use-after-free Read in
 reiserfs_get_unused_objectid
Message-ID: <20240129094811.injplexrobjjcu6l@quack3>
References: <0000000000007584ba05f80047bb@google.com>
 <000000000000baabe1060ffd60b0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000baabe1060ffd60b0@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5];
	 TAGGED_RCPT(0.00)[04e8b36eaa27ecf7f840];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Sun 28-01-24 00:33:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116501efe80000
> start commit:   1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
> dashboard link: https://syzkaller.appspot.com/bug?extid=04e8b36eaa27ecf7f840
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d5c261c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eba51c80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

So this somewhat surprises me because all the reproducer does is that it
just mounts the created image. I'm not sure how blocking of writers to
a mounted device could change the behavior of this reproducer.

But given the reproducer no longer works and this is reiserfs where nobody
is likely to look into the bug, even more so without a reproducer I guess:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

