Return-Path: <linux-fsdevel+bounces-11738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A142C856B26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582A02859E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5178E1369A5;
	Thu, 15 Feb 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zj43VBWf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yb1lv4cJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0CgoOr31";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SLzVhLAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4016341F;
	Thu, 15 Feb 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018647; cv=none; b=n/tSfwMJJIHPMomRbGwtwcL+fIbrm3kyFXKEx0dimUeMRb4ZF1LTBtDvobgjMxJapsHLUPEzTuv2oGcfohOzDAI8khLhpImzJcQL7BYxOg3DuU8XBL03EKdR7Dcdje8DSGTZn1h+Wfqa7Q1c5Nxvyz0SfmNbno+/y58ukznTAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018647; c=relaxed/simple;
	bh=K865F9Yq9c8+7XUP7G6+muwUilhZSdjhnMzub2Bz0TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbE6kcUAbgBXbbrs/vW8jpCdeM1bhseAm+2MLXn7zOMwogyZ+k6OP/72q7UVN/dfe5zu1/TXqTTCbP8W5xTpZVYcIN5fblk0B5BKYC1al1cgoCxkJvGAl4gt0hLVvC8PU+LsyxSBDq/m1furTCECxNRNz2Xq9B/INqz9/yQP2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zj43VBWf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yb1lv4cJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0CgoOr31; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SLzVhLAm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF2651F8BE;
	Thu, 15 Feb 2024 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708018644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ3XwzuJ/s0K1I/FmXtk4ovuVAj4aJMTuF4cFMIFjqA=;
	b=zj43VBWfOreASQ43v5g5RKgoQkDg+p/Sp/J9Pldm+PTJe9RViQNUKcgKyMDQvsBuo8+FPF
	ZiQ8rcm74hA7qOON3bIqb/2admEX6WrcUzYHRnFCns6zb/6l0+4CifaJ7tKMvEo6GiEfpt
	atX6rayYTuXg7vQlCKxnTSEmxYRWuKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708018644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ3XwzuJ/s0K1I/FmXtk4ovuVAj4aJMTuF4cFMIFjqA=;
	b=Yb1lv4cJgflLMgP2HRl3BGBghcyeSl7J5faNHjdClFqDi4N9I6r4sKiPzJ98siu6nCxE4s
	bPkgazy8muMOicDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708018643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ3XwzuJ/s0K1I/FmXtk4ovuVAj4aJMTuF4cFMIFjqA=;
	b=0CgoOr31CziJ7bdAN2INwpvO69NadbOlLL+FkFJFsvbRe8JI9MgyBEin8AqBhA2vdKwGXT
	/63OUKeyfCoQ2cZkNjiLen8/5Hu05qZQ12PrQwBU3pSPZq0gnunCZ0rTbFc1VscSxAn6NK
	esZafPSFzmIUtCha1pJ/UjgfwRken8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708018643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ3XwzuJ/s0K1I/FmXtk4ovuVAj4aJMTuF4cFMIFjqA=;
	b=SLzVhLAmKmoVzNd33Afo5Lw6DXchTrI/xVksGIrjD+vFUOA5EqYj1bKw/MaJcs8H7MeCL/
	t8B28s8f2TA36nAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E404A139D0;
	Thu, 15 Feb 2024 17:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MW2lN9NLzmXLUAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 17:37:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89E56A0809; Thu, 15 Feb 2024 18:37:23 +0100 (CET)
Date: Thu, 15 Feb 2024 18:37:23 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	osmtendev@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] UBSAN: array-index-out-of-bounds in
 udf_process_sequence
Message-ID: <20240215173723.qomaaju7mkytcu7c@quack3>
References: <0000000000000fdc630601cd9825@google.com>
 <00000000000037dfd406116efacd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000037dfd406116efacd@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0CgoOr31;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SLzVhLAm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[32.71%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d];
	 TAGGED_RCPT(0.00)[abb7222a58e4ebc930ad];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,suse.com,suse.cz,vger.kernel.org,gmail.com,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: EF2651F8BE
X-Spam-Flag: NO

On Thu 15-02-24 09:30:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ef13dc180000
> start commit:   9e6c269de404 Merge tag 'i2c-for-6.5-rc7' of git://git.kern..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175ed6bba80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146c8923a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

