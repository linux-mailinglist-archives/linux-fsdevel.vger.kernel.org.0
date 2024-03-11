Return-Path: <linux-fsdevel+bounces-14114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D8877CA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669E1280F8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD917745;
	Mon, 11 Mar 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5iWBydV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d/TDc1Ou";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5iWBydV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d/TDc1Ou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FB1A27D;
	Mon, 11 Mar 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149117; cv=none; b=EP/FXB4uhDIjTGe020WNQO2S2NbMpTwQmpz7L0ErUy8ndgfEVEDAEXgDVWj5HerJgy0lxDzdurKo9Je14nC2YY029TmvuDTngT9sNjx9yNXo36FvwMzJxRpKED4BXfwliDqByS1FZVoEomIq/F9huvjOLtc59yw02Ym9raB8eYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149117; c=relaxed/simple;
	bh=qAh1/pg2XENawq9x9zAF4/+ru0qiGEB1jqL5GI32dpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhhft9X/c9zBiVyhX+jZq2fgMbI3LSv6EHUSWDpQFD+JnBUU7nUy9b2LBI9XHsnC3I6ToPh3v4eYS8E581AMJHCIcFKTESLMSAbQq4IW7rGPgpPHJRU1oY6KK3oWe2lUMBJPWqQ1+YA4yD7eceutwErUOGMrJAlJE5fEdbvO/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5iWBydV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d/TDc1Ou; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5iWBydV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d/TDc1Ou; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05A805C485;
	Mon, 11 Mar 2024 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710149112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsEgkA1hBCPYUveqZbm1bnxBqR8bzX+PKYOhbea4gsU=;
	b=f5iWBydV747+IUnHFMNR7tAsPNWU+U0K3LntDl4yekraLNIDuwTtbBMZ3XfW0Tn9Zj1AT5
	IshmUbrNp8OSvzOLsWo/ZP6XDn+TuDB5S2bdcr2k9FsbVQsS0p4vHeuDMSpihzgb+Y2FcY
	DFY80ee/94P5YnbSQUeHP0RByCe2Fgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710149112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsEgkA1hBCPYUveqZbm1bnxBqR8bzX+PKYOhbea4gsU=;
	b=d/TDc1Ou19LfXj7XVYt06OUpyrhy4q1ee+B1mCTttoamfRkjyWbwxRPjmDXIF64ddvjzi6
	H2F6uvspMxcbk7Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710149112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsEgkA1hBCPYUveqZbm1bnxBqR8bzX+PKYOhbea4gsU=;
	b=f5iWBydV747+IUnHFMNR7tAsPNWU+U0K3LntDl4yekraLNIDuwTtbBMZ3XfW0Tn9Zj1AT5
	IshmUbrNp8OSvzOLsWo/ZP6XDn+TuDB5S2bdcr2k9FsbVQsS0p4vHeuDMSpihzgb+Y2FcY
	DFY80ee/94P5YnbSQUeHP0RByCe2Fgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710149112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsEgkA1hBCPYUveqZbm1bnxBqR8bzX+PKYOhbea4gsU=;
	b=d/TDc1Ou19LfXj7XVYt06OUpyrhy4q1ee+B1mCTttoamfRkjyWbwxRPjmDXIF64ddvjzi6
	H2F6uvspMxcbk7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB17113695;
	Mon, 11 Mar 2024 09:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fGBgOffN7mW/AwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 09:25:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D95EA0807; Mon, 11 Mar 2024 10:25:07 +0100 (CET)
Date: Mon, 11 Mar 2024 10:25:07 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	eadavis@qq.com, hch@lst.de, jack@suse.com, jack@suse.cz,
	linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [udf?] KASAN: slab-use-after-free Read in
 udf_free_blocks
Message-ID: <20240311092507.eyzqyrr6lkbqszvb@quack3>
References: <000000000000d40c3c05fdc05cd1@google.com>
 <0000000000004ff6580612af035e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004ff6580612af035e@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.70
X-Spamd-Result: default: False [1.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[39.07%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968];
	 TAGGED_RCPT(0.00)[0b7937459742a0a4cffd];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLt8atpzwu1a6up6bx38ctuzr7)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,qq.com,lst.de,suse.com,suse.cz,gmail.com,vger.kernel.org,kvack.org,googlegroups.com,infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sat 02-03-24 07:19:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11030516180000
> start commit:   f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bcb6b5280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fbcfd1280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks good.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

