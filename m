Return-Path: <linux-fsdevel+bounces-14393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D3087BB9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7AE1C21B31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0F6EB49;
	Thu, 14 Mar 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fH4Ew/5E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DoIgMTFu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fH4Ew/5E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DoIgMTFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BCE6DCE3;
	Thu, 14 Mar 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413849; cv=none; b=jInkzaAruBH4XkWioFQ93xA/szjPcQqKjsz7M4Lka97AfQjKj1wTed2Voj3/2HuCCSOVE4bQGbXY+zBiYCgnDa952cnuOnD7ABTNo3YCZIaWW6II9DO5bmMymr5V5opNHoPggKtuS0B5kJeIkPKIhqRaxDo5M2A6A08XhA0YG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413849; c=relaxed/simple;
	bh=lN+o+sy/b4sSQ0Euh7pwJ3UNsh94+te5f88NY5XA2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNEhITc2XzJdnKPusu749VLpgHh3Q9pd2TV89NWyh5KpU92AlEsGswZj/UI0TNdmCu4QKmS1BQEb4GBXc/0FpCQZL49UUI3w1Fqebee9pNUpZpEUzXk8Y27TCwuRX8VNXZ+qiX42MIDk+zmJjTs7BrloIraEEqLF3O/tyDsNq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fH4Ew/5E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DoIgMTFu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fH4Ew/5E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DoIgMTFu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20DE821C83;
	Thu, 14 Mar 2024 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710413846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KB+QJfsxVWgzPlKw2RN08zlrokt0dFW1xGWyQPDlI34=;
	b=fH4Ew/5ET4pOBiR/SnFatadpCoyGZ2KTrIV0HI1JUX7Hu1pJSHzyXanjnlmfxJV+yzFRyp
	AfL9dEtyxPSBvUc+qn6cgq+bkMZEQ9vQW6jloKkmwLu2LiVLd+CrDlAiZcCEPMu9zMDPXa
	DFrTBep2VtlZBfpYCvIOOTdZtxlv3Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710413846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KB+QJfsxVWgzPlKw2RN08zlrokt0dFW1xGWyQPDlI34=;
	b=DoIgMTFuqvgI1uwzc9/XXnQ/l45LOO5PtatGEcPX1L0fq5glKtc4Dux/OIwKjwEOhOyoi0
	Ibdnys8bMtsdeSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710413846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KB+QJfsxVWgzPlKw2RN08zlrokt0dFW1xGWyQPDlI34=;
	b=fH4Ew/5ET4pOBiR/SnFatadpCoyGZ2KTrIV0HI1JUX7Hu1pJSHzyXanjnlmfxJV+yzFRyp
	AfL9dEtyxPSBvUc+qn6cgq+bkMZEQ9vQW6jloKkmwLu2LiVLd+CrDlAiZcCEPMu9zMDPXa
	DFrTBep2VtlZBfpYCvIOOTdZtxlv3Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710413846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KB+QJfsxVWgzPlKw2RN08zlrokt0dFW1xGWyQPDlI34=;
	b=DoIgMTFuqvgI1uwzc9/XXnQ/l45LOO5PtatGEcPX1L0fq5glKtc4Dux/OIwKjwEOhOyoi0
	Ibdnys8bMtsdeSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 118541386E;
	Thu, 14 Mar 2024 10:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r+ZBBBbY8mXTWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:57:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6A0DA07D9; Thu, 14 Mar 2024 11:57:21 +0100 (CET)
Date: Thu, 14 Mar 2024 11:57:21 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+d3cd38158cd7c8d1432c@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in ntfs_read_folio
Message-ID: <20240314105721.q2xd5zq3st7awjfh@quack3>
References: <0000000000009146bb05f71b03a0@google.com>
 <0000000000008414ba06125ba07f@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008414ba06125ba07f@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="fH4Ew/5E";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DoIgMTFu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.37 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.12)[66.89%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b];
	 TAGGED_RCPT(0.00)[d3cd38158cd7c8d1432c];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 1.37
X-Rspamd-Queue-Id: 20DE821C83
X-Spam-Flag: NO

On Tue 27-02-24 03:50:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a70f4a180000
> start commit:   ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
> dashboard link: https://syzkaller.appspot.com/bug?extid=d3cd38158cd7c8d1432c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12769ba5e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c2b97ee80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

No working reproducer so:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

