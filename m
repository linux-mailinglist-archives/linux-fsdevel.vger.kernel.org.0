Return-Path: <linux-fsdevel+bounces-14142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66232878562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896B31C21AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F953E35;
	Mon, 11 Mar 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrShw5xI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cWWnh340";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrShw5xI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cWWnh340"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A014537E3;
	Mon, 11 Mar 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174197; cv=none; b=lHz2ekXbu3RbZ5VPxa2IIW4KIH0qUEsh+D5aZ0a+qA+AKJ3+T9ZlzuqHjE1y36jKX6Mqz2CVURwiF2Fy+RFnE2HVGcG4cfjOrjIVURcoIzgOcCqRLpXhhT/PIaRTjheARVlvVfy6hPVKu1tVhppBoykwcyo83JgqvaynZXz30D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174197; c=relaxed/simple;
	bh=LeTUeB66NNu07Tu8xsCZA3P+skWgHcjg+bPmt2EoaRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQvvSIONxislLP9wHHCdJfgNCyMkcGV2IIVvZTG7WE49sOEhFl0caKFuzEHDuIuQMfSPloFohWMN/mUKtfQuJ5AAhhTBcET1gNOTI7kOmd97fQytfsjahGWgzxuWu8iO7qUgDyvObl+vb8hniXIbtUXmOc9rMS6v2pFhaOanLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrShw5xI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cWWnh340; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrShw5xI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cWWnh340; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BB7534E6C;
	Mon, 11 Mar 2024 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710174193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IOg3na/OLp5fyJbplID3ln+wXJxKBoSEVF2V/6Zion4=;
	b=XrShw5xIa+HdMtPCyG18NvKeWQ1ySMJ9R9fV3fHVOO2Gu3V7pNbPVg/YtxqcrRAQHyzJyZ
	39GaK6hw0+6OM1Xrbj79/xRxsvpAOgrpLnHMK6OVQbtwWm12ijEFjO4BmZ+o3xz6bd/NBc
	IkQCHS98lEJAMxUzeQocjETlluIfGFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710174193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IOg3na/OLp5fyJbplID3ln+wXJxKBoSEVF2V/6Zion4=;
	b=cWWnh340wwD0aWr9/7TYO3K0HNnBZt9D3rWeDbA+7emmjzOxpCiw7wb3D8hpuhZEdDtijo
	Xh6PdV1nDvHfApDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710174193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IOg3na/OLp5fyJbplID3ln+wXJxKBoSEVF2V/6Zion4=;
	b=XrShw5xIa+HdMtPCyG18NvKeWQ1ySMJ9R9fV3fHVOO2Gu3V7pNbPVg/YtxqcrRAQHyzJyZ
	39GaK6hw0+6OM1Xrbj79/xRxsvpAOgrpLnHMK6OVQbtwWm12ijEFjO4BmZ+o3xz6bd/NBc
	IkQCHS98lEJAMxUzeQocjETlluIfGFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710174193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IOg3na/OLp5fyJbplID3ln+wXJxKBoSEVF2V/6Zion4=;
	b=cWWnh340wwD0aWr9/7TYO3K0HNnBZt9D3rWeDbA+7emmjzOxpCiw7wb3D8hpuhZEdDtijo
	Xh6PdV1nDvHfApDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C185136BA;
	Mon, 11 Mar 2024 16:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZcVHHvEv72UVFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 16:23:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1BE05A0807; Mon, 11 Mar 2024 17:23:13 +0100 (CET)
Date: Mon, 11 Mar 2024 17:23:13 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+b4084c18420f9fad0b4f@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk,
	brauner@kernel.org, jack@suse.cz, kari.argillander@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
	trix@redhat.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in ntfs_iget5
Message-ID: <20240311162313.yjwhfp7xxjynksih@quack3>
References: <0000000000000149eb05dd3de8cc@google.com>
 <000000000000a9c150061340dbc9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a9c150061340dbc9@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XrShw5xI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cWWnh340
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.48 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLeyet8kb1p6pwtwqxkq31mbep)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[50.68%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=755695d26ad09807];
	 TAGGED_RCPT(0.00)[b4084c18420f9fad0b4f];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[paragon-software.com,kernel.dk,kernel.org,suse.cz,gmail.com,vger.kernel.org,lists.linux.dev,google.com,googlegroups.com,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.48
X-Rspamd-Queue-Id: 8BB7534E6C
X-Spam-Flag: NO

On Sat 09-03-24 13:19:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1649668e180000
> start commit:   3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ccc59c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10928774880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

