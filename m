Return-Path: <linux-fsdevel+bounces-11120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4C85154C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 14:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127D11F21D94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B593FB26;
	Mon, 12 Feb 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqVzJaxC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAWNKNui";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QenqSsS6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z2CxIUZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23A3EA6C;
	Mon, 12 Feb 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744234; cv=none; b=mHJC2Y4Rjhp+G8df3NxKr2uPHTlc2z1agubHzp50+5pEWaddm0soC4OXkb/ePLNnaOYwqs/ea2zgfDhRi942yMTyulbMKsFUTa6gawJysklVIuxEHQdT1pBAKG50yTyA+4dcTaYH+78sN0ssGzKFUnMk4HH1yEgczQfidkOxDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744234; c=relaxed/simple;
	bh=wSQR6gsLt3mG1V9dqLVK5pFi2KxJsal8RGKoLPtALr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn12mqPRbA1SLU/N7hp2YzQBolq70qrerdX+4jaWusaYB/x98AAS7FvvsdVruaydP5ykM04IDuO5jhrYRhJO/hAOctov5ZGetpR0Ug8fw2/5xYck2VGZKL/56tIomdSCR5f8TAuaqADu14+JazHkkegwf6RKAPS2/5QnM5xtAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqVzJaxC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAWNKNui; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QenqSsS6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z2CxIUZW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D65AC1F769;
	Mon, 12 Feb 2024 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707744231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JkVcVZxZODTrdG1g0ooZoXOZDuPkKduhykZYkAPZq0=;
	b=rqVzJaxCdss1LH04Ym0CSvcK1bTB8gJFNIk2lAhgvX5fjUFzj7Dg3DdLLCCOg0V4lYdLWs
	CgkoAWZdqii+TPi8rkGW/iyTNDtzCagSFSYUzFL9aza2gPvsnBLkGbbagpydFIpmdgP7B5
	xcAYcxkNug71WtwxO/W5QaYO2p757e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707744231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JkVcVZxZODTrdG1g0ooZoXOZDuPkKduhykZYkAPZq0=;
	b=LAWNKNuiVW4v0he9H+338pFeDaR3AkSJbgtJM4XXJN4C7PNo0dRI+DqZTaVNile5q4A09o
	m9fcthPQed1LZlCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707744230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JkVcVZxZODTrdG1g0ooZoXOZDuPkKduhykZYkAPZq0=;
	b=QenqSsS6WZz7R2n1edat8BSuvZw7dvJwhuZ12pO0+w9nLYSI81tVqJFvo6R4qT/RV34PrQ
	pnVoCp8yq9M5m0//ZOn2aFY9hbTpcDgNZMESiR7YACmh4F/Qn/tjq3LKO3UbQVvpTPEpOx
	vk5/M9VPy/x2M+FRFp8FmUCwTwwjt84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707744230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JkVcVZxZODTrdG1g0ooZoXOZDuPkKduhykZYkAPZq0=;
	b=Z2CxIUZWdkji8Ocyn1ByKhfdkz5/yPGJBn/RAhpLA4pnQldJ1LqF9DLBe3a4SRqEvN6j5D
	/jKnZ7TshS67a2Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C5C0213212;
	Mon, 12 Feb 2024 13:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vdoEMOYbymUtMwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 12 Feb 2024 13:23:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56EA3A0809; Mon, 12 Feb 2024 14:23:50 +0100 (CET)
Date: Mon, 12 Feb 2024 14:23:50 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+693985588d7a5e439483@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_enable_quotas
Message-ID: <20240212132350.ipdht3ttxyivl33p@quack3>
References: <0000000000000126ec05ffd5a528@google.com>
 <0000000000002903a406110849e9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002903a406110849e9@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.69
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[51.36%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c];
	 TAGGED_RCPT(0.00)[693985588d7a5e439483];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL9mptuuj8f371ag1nhgyt86ac)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sat 10-02-24 06:59:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147e5b20180000
> start commit:   89bf6209cad6 Merge tag 'devicetree-fixes-for-6.5-2' of git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
> dashboard link: https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ba1fefa80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1636640fa80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
The syzbot reproducer seems to mess with multiple ext4 mounts stacked on
one another and the loop device as well. Quite likely it managed to corrupt
the mounted filesystem. So:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

