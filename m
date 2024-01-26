Return-Path: <linux-fsdevel+bounces-9061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7183DB81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C3B1C22605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196051C695;
	Fri, 26 Jan 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sw1IYy2s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+PTk/i5y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sw1IYy2s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+PTk/i5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBAA1C68A;
	Fri, 26 Jan 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278269; cv=none; b=XtMgJJMcdc1dAsRZRi7D2tnU2EYwL8rxe8rLSTNVm4zJhYxtol+bMC2KnBHONtUzVKXosDioMbG8RA4vLaqtebA46ngkFf+aml+/0OzneYamppcGgSihzQNe9hk9FvgcTllCMWPK+aGOkKu9WKIrtpXTbYoiiqGocypkwyBP5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278269; c=relaxed/simple;
	bh=qGBAAeWbUe+Aj38Gk6sQP9MwEOJVNnsKQt0ttT1weRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHG2HLHyVH2LN4aWQXSZW17jYSJXzRjV8DqrMOQ5R9pUejH7Xs7ToZVkDMCcuH7g9Fm9sAxNaPmVnIgU8Kh3xVez69FaXtsJH8oq/xqjjIHgpioRszG2SMcjZ+oIptCQ+mk6sdlQMuLGd9fe19u42NtiQjKdS9NBHGC2WN6kcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sw1IYy2s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+PTk/i5y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sw1IYy2s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+PTk/i5y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9F8F21E6D;
	Fri, 26 Jan 2024 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706278262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPcOSR/E3TI//PCWMaoAPwAv977b5GCgRXOjxXLXLX4=;
	b=sw1IYy2s1KN05rKcWIfXJr/v/ppcZx4ZOOzkpjzry0IGx+QaTlQP8egQiMyOEa+GgPqPL8
	MbPPWlv6B/GcIRVCJ5EJ6sb6vHOTKsy97M+99XJsgR/zGsK1jU/vQ5TIxUtiLjCvQ2SIjR
	BRr9DPkzXYMwUmYpkv9NOe2apEte60U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706278262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPcOSR/E3TI//PCWMaoAPwAv977b5GCgRXOjxXLXLX4=;
	b=+PTk/i5y5JVn1jX3eoWb06VAjdbzrI+fyeSOILElvwyGQZ4D05SgkKdXS45DdotZvielO8
	KMij6NwZ8bW2M4AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706278262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPcOSR/E3TI//PCWMaoAPwAv977b5GCgRXOjxXLXLX4=;
	b=sw1IYy2s1KN05rKcWIfXJr/v/ppcZx4ZOOzkpjzry0IGx+QaTlQP8egQiMyOEa+GgPqPL8
	MbPPWlv6B/GcIRVCJ5EJ6sb6vHOTKsy97M+99XJsgR/zGsK1jU/vQ5TIxUtiLjCvQ2SIjR
	BRr9DPkzXYMwUmYpkv9NOe2apEte60U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706278262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPcOSR/E3TI//PCWMaoAPwAv977b5GCgRXOjxXLXLX4=;
	b=+PTk/i5y5JVn1jX3eoWb06VAjdbzrI+fyeSOILElvwyGQZ4D05SgkKdXS45DdotZvielO8
	KMij6NwZ8bW2M4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99B9A13A22;
	Fri, 26 Jan 2024 14:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xRR/JXa9s2VbawAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Jan 2024 14:11:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DF22A0805; Fri, 26 Jan 2024 15:11:00 +0100 (CET)
Date: Fri, 26 Jan 2024 15:11:00 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+d8fc21bfa138a5ae916d@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in crc_itu_t
Message-ID: <20240126141100.s6hphczfikjbbrm5@quack3>
References: <000000000000f8389205e9f9ec5f@google.com>
 <000000000000d227b6060fd90a48@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d227b6060fd90a48@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.67 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.23)[96.38%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4];
	 TAGGED_RCPT(0.00)[d8fc21bfa138a5ae916d];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.67

On Fri 26-01-24 05:12:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1204f1efe80000
> start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
> dashboard link: https://syzkaller.appspot.com/bug?extid=d8fc21bfa138a5ae916d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1442e70b280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16db80dd280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Looks good:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

