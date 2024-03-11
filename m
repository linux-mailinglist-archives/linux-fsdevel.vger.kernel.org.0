Return-Path: <linux-fsdevel+bounces-14144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A137587857F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CD01C2200B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E24C601;
	Mon, 11 Mar 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EaSN6TUO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OlQ0bu9/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EaSN6TUO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OlQ0bu9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AB4D108;
	Mon, 11 Mar 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174607; cv=none; b=qyBCxE0OEO1OqP4UCOvrrYhwpYSS6+dla0TyNtvb1YDQdqjmjvFUXQvuPb6RqM1uYAaoVG28aJ3nKzgsifmYKCaiPTcUHsyXIsFbrCtOkSfY8DlQN+cNj+rJQs3Zq6MlYbFULgnDqjmHTzh94dMYg9acAm/BfttQhRB8OQ8zDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174607; c=relaxed/simple;
	bh=JZYSQDWTC59De3jYtmY7BFDt0aZ9x3X7vNzSjWmKyq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4DQ//GKcLN0/YHD1P+kDnB/DVrvOMXTdI68kPiBJuI7sjp/VMNhkOuPeiagHRsDQq2NT4RYCLtklNl3IQ3lL1BGjp5evjz2UZan4QuCeMmRQPnDhh2xq/cT/4u3C0KbCnsDZD6A186wc6lyMZmCaAzETMn6VWceB9c4iDi3tEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EaSN6TUO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OlQ0bu9/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EaSN6TUO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OlQ0bu9/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F363A5C935;
	Mon, 11 Mar 2024 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710174604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlY58PQIEZEdZ0oT4/HKEiEUKCBshfHvCO+3mj9Nk2Q=;
	b=EaSN6TUOiHhqpFiAXRpmZQ3LmmgBHPh6R0gFlvGGE5Ydh4I9/cPxviDw34MD4T7qLvqXDv
	grF3ISrVcjt7h2CewPTLQ9lvNSHGIFc3tVC2hcjOF4oCRlqO9+fpL4T2sgKaEztRHB8Mi+
	eRGcjHmH99rpY79tXU4nxgfsMkJGD5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710174604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlY58PQIEZEdZ0oT4/HKEiEUKCBshfHvCO+3mj9Nk2Q=;
	b=OlQ0bu9/b27YVVIWO0yK5y8hKCXGIpxbeAeirruUZb3P9z88zL7ShirGK+QPGThV86pxC8
	v3CsSXLqkZXV1uDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710174604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlY58PQIEZEdZ0oT4/HKEiEUKCBshfHvCO+3mj9Nk2Q=;
	b=EaSN6TUOiHhqpFiAXRpmZQ3LmmgBHPh6R0gFlvGGE5Ydh4I9/cPxviDw34MD4T7qLvqXDv
	grF3ISrVcjt7h2CewPTLQ9lvNSHGIFc3tVC2hcjOF4oCRlqO9+fpL4T2sgKaEztRHB8Mi+
	eRGcjHmH99rpY79tXU4nxgfsMkJGD5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710174604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlY58PQIEZEdZ0oT4/HKEiEUKCBshfHvCO+3mj9Nk2Q=;
	b=OlQ0bu9/b27YVVIWO0yK5y8hKCXGIpxbeAeirruUZb3P9z88zL7ShirGK+QPGThV86pxC8
	v3CsSXLqkZXV1uDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B2E136BA;
	Mon, 11 Mar 2024 16:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PBvJOIsx72VNFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 16:30:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7776A0807; Mon, 11 Mar 2024 17:29:59 +0100 (CET)
Date: Mon, 11 Mar 2024 17:29:59 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+cb1fdea540b46f0ce394@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] possible deadlock in map_mft_record
Message-ID: <20240311162959.odjj34j2vvypax6n@quack3>
References: <0000000000002a6cba05eb5c7fbd@google.com>
 <0000000000007c3484061344da08@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007c3484061344da08@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.67
X-Spamd-Result: default: False [1.67 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.03)[56.45%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4];
	 TAGGED_RCPT(0.00)[cb1fdea540b46f0ce394];
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

On Sat 09-03-24 18:05:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b28b99180000
> start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151db82a480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f0e670480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Looks good.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

