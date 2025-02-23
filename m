Return-Path: <linux-fsdevel+bounces-42357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E712BA40D86
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 09:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664307A8590
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787331FF1B2;
	Sun, 23 Feb 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F1cr2hMk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K6TEnLYA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F1cr2hMk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K6TEnLYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50728F4
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740301074; cv=none; b=DR27Se+Oolmz7/OYTo2A0uTtwLN1geKR1OiGqdo/Itsf4LeEAFLvm0XLNVAOft6azh+Ytji+ib6OIsHfrCAVZDlTKUQbJrmFJTHuwfErzC8XiFBnyb9pk7ie72m2oq8n97dYjjo/8wQlHL21kNreKnlAMwm91A2GjVtXATyegSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740301074; c=relaxed/simple;
	bh=INjiuX0s8zbJDPhY7KvZU1bUkdXPOrjP237jXIKQC/s=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=QR+SKca9twqZBRNFcu6AyuAS4s/kpHJUMISZ/fMQyrurmTRii2uW82GAd7uUGJFOCxzmLQ8cE1L6jG5lg+vxnjkKcEtTRBNGLzGTLd/YlYWF+l7JwWLIQByN6DBCimOmo6E6AJAcCfcN5xoGCgGjrVEPA725TxfuRB2w4w6J3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F1cr2hMk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K6TEnLYA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F1cr2hMk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K6TEnLYA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 516021F37E;
	Sun, 23 Feb 2025 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740300494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GbBYIM/WA/qYNouilSrPkrp0XFFUlo0zfOOCJeQJt7I=;
	b=F1cr2hMkRUI4clFIT44Wr4FxBFIOKelzlYVyXgL5qFdlYsk2MzDgiGiIi1CT+I/LpfYw9O
	k5katMZWSmejm9VJMXVy5c3/s3+0xLk4tPRS5nzOYfx3R1yyUOfOaFXnsj5nlGPsd1TDQM
	bjSByw176N6vbtVHC9YsxbYErlEp9UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740300494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GbBYIM/WA/qYNouilSrPkrp0XFFUlo0zfOOCJeQJt7I=;
	b=K6TEnLYATffT1TG/fpWYykl+pxF75rEdPEYveja0o5PAyh+7or9ZyrPg5cNL5rFpGq1o6T
	Uvjcx41M+jfkN1BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F1cr2hMk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K6TEnLYA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740300494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GbBYIM/WA/qYNouilSrPkrp0XFFUlo0zfOOCJeQJt7I=;
	b=F1cr2hMkRUI4clFIT44Wr4FxBFIOKelzlYVyXgL5qFdlYsk2MzDgiGiIi1CT+I/LpfYw9O
	k5katMZWSmejm9VJMXVy5c3/s3+0xLk4tPRS5nzOYfx3R1yyUOfOaFXnsj5nlGPsd1TDQM
	bjSByw176N6vbtVHC9YsxbYErlEp9UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740300494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GbBYIM/WA/qYNouilSrPkrp0XFFUlo0zfOOCJeQJt7I=;
	b=K6TEnLYATffT1TG/fpWYykl+pxF75rEdPEYveja0o5PAyh+7or9ZyrPg5cNL5rFpGq1o6T
	Uvjcx41M+jfkN1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9A2C13A39;
	Sun, 23 Feb 2025 08:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J9k5Nc3gumevegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 23 Feb 2025 08:48:13 +0000
Date: Sun, 23 Feb 2025 09:48:08 +0100
Message-ID: <875xl1vygn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: regressions@list.linux.dev,
    linux-fsdevel@vger.kernel.org,
    stable@vger.kernel.org
Subject: [REGRESSION] Chrome and VSCode breakage with the commit b9b588f22a0c
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 516021F37E
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.com:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

we received a bug report showing the regression on 6.13.1 kernel
against 6.13.0.  The symptom is that Chrome and VSCode stopped working
with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
  https://bugzilla.suse.com/show_bug.cgi?id=1236943

Quoting from there:
"""
I use the latest TW on Gnome with a 4K display and 150%
scaling. Everything has been working fine, but recently both Chrome
and VSCode (installed from official non-openSUSE channels) stopped
working with Scaling.
....
I am using VSCode with:
`--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
"""

Surprisingly, the bisection pointed to the backport of the commit
b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
to iterate simple_offset directories").

Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
fix the issue.  Also, the reporter verified that the latest 6.14-rc
release is still affected, too.

For now I have no concrete idea how the patch could break the behavior
of a graphical application like the above.  Let us know if you need
something for debugging.  (Or at easiest, join to the bugzilla entry
and ask there; or open another bug report at whatever you like.)

BTW, I'll be traveling tomorrow, so my reply will be delayed.


thanks,

Takashi

#regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
#regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943

