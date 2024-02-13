Return-Path: <linux-fsdevel+bounces-11352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374B852E37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 11:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C5028321E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDA250FE;
	Tue, 13 Feb 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8S7Cipu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDEhimJU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8S7Cipu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDEhimJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC4249F3;
	Tue, 13 Feb 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820950; cv=none; b=N4O6lQxJanQMempNiBB1VgmlW+9MxZVlI+xjKBsnMmJ76dOtPZz8279eiaLnBaCfYgSODPR4PbrtLFZMG5O11tsoKyyDcJKytBFSts02nvbVpL663zVM+jv66gTfd0inZl+LILcheEVpkigWauGBqAyXkRHs68D/LnzbZsui4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820950; c=relaxed/simple;
	bh=1MPdSWwfruOrnSuLr0n9WPPbCXwNL77oYSgG5v0MEhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcX51MqWeHxJTWCR971ABbQTGod0QOBt0JaHpT3Yx+M2w52y4NxMpxQV8m0VWhUPmJ9sBl2kAok3pJJz7PeXdaf2xxTOf2PwOfLrgOQswkXHRkOarGEdgzdIoGltF4/Z0MuqWJHY0xCAgr0AtwMP/hXEaUXf3gp5Zs3xC7Nk1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8S7Cipu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDEhimJU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8S7Cipu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDEhimJU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B17D521DFF;
	Tue, 13 Feb 2024 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707820946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22pJvaIDPDvuC7d+Y5apFd3eebCKb0VWfUr3BiGLeUI=;
	b=B8S7CipuW50JcLfclu3kri69zjaKPYRnSH/KnRoOu+2/0A11Qqie9KHDuErDg7T5xT/0Rz
	eoBwkdpAnN0SQcnVLWbkGoe3WOWgjxMww4+ggRA/T/eBSzHPwDFO0xa8g9ahxZE1iQ4hTw
	CfqKufbfbanMK8ehQJZ75Gn22EPjGcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707820946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22pJvaIDPDvuC7d+Y5apFd3eebCKb0VWfUr3BiGLeUI=;
	b=qDEhimJUEKjzbBoLXQtiP/P8IUBbH+j9jYL2Buwhz5ZUwuajEtnuMMZjtqkhD+B53i5Tba
	nUW+ZJGrFdEvAmAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707820946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22pJvaIDPDvuC7d+Y5apFd3eebCKb0VWfUr3BiGLeUI=;
	b=B8S7CipuW50JcLfclu3kri69zjaKPYRnSH/KnRoOu+2/0A11Qqie9KHDuErDg7T5xT/0Rz
	eoBwkdpAnN0SQcnVLWbkGoe3WOWgjxMww4+ggRA/T/eBSzHPwDFO0xa8g9ahxZE1iQ4hTw
	CfqKufbfbanMK8ehQJZ75Gn22EPjGcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707820946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22pJvaIDPDvuC7d+Y5apFd3eebCKb0VWfUr3BiGLeUI=;
	b=qDEhimJUEKjzbBoLXQtiP/P8IUBbH+j9jYL2Buwhz5ZUwuajEtnuMMZjtqkhD+B53i5Tba
	nUW+ZJGrFdEvAmAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A32CD1329E;
	Tue, 13 Feb 2024 10:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id r/vPJ5JHy2UENQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 10:42:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4AC38A0809; Tue, 13 Feb 2024 11:42:18 +0100 (CET)
Date: Tue, 13 Feb 2024 11:42:18 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	ebiggers@google.com, ebiggers@kernel.org, jack@suse.cz,
	krisman@collabora.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] general protection fault in utf8nlookup
Message-ID: <20240213104218.utvf3t2abfgqdhbb@quack3>
References: <0000000000001f0b970605c39a7e@google.com>
 <000000000000600b5d06113869f0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000600b5d06113869f0@google.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B8S7Cipu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qDEhimJU
X-Spamd-Result: default: False [2.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLk8tmzebn37goht9666q8cjru)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[44.70%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122];
	 TAGGED_RCPT(0.00)[9cf75dc581fb4307d6dd];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[dilger.ca,kernel.dk,kernel.org,google.com,suse.cz,collabora.com,vger.kernel.org,googlegroups.com,gmail.com,mit.edu];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: B17D521DFF
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Mon 12-02-24 16:24:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17547fd4180000
> start commit:   e42bebf6db29 Merge tag 'efi-fixes-for-v6.6-1' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
> dashboard link: https://syzkaller.appspot.com/bug?extid=9cf75dc581fb4307d6dd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374a174680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b12928680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

The reproducer definitely does weird stuff like mmapping the loop device.
So makes sense:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

