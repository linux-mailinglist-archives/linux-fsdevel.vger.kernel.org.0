Return-Path: <linux-fsdevel+bounces-45890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D30BCA7E2AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA04414F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACAE1FC0FB;
	Mon,  7 Apr 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfsdsK3u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/3Fw7+xX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfsdsK3u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/3Fw7+xX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81C1FC109
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036802; cv=none; b=RLzC11an72ZANRzYuoG7LdFHQ/qGGpzbpqEjAdjK/hi58+Gl1/kENcDjwp/H+3fMvQJooBqppsNlbaoBfQ0dlmcmj7HuEXhZKi2YjU4bZ9G7McxGk8CWLOVsxN3YMbjMxg6W3tU65jyYD88ZZDXoeMK9Br97wQBqzUGKVFh6XGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036802; c=relaxed/simple;
	bh=mahuABa9BsWNmDpwYvQzqeQJiUDCtdlnHBdMJTp564E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G20U3jzfq147qx2inY9We4A3Uibr+w4MCwDCfOA+GwIDef4XNrvcpAcQFxxS6/SGTYg2OO42ppy/GmcGh02mA+tLhPuVf6lUOwP5hfquDiW8EW5HTofZwF/Cb3CLxSQopAA/sIn01FTjisTYcL5dhWv3PEPoww83eofInci6IGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfsdsK3u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/3Fw7+xX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfsdsK3u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/3Fw7+xX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7D4A1F388;
	Mon,  7 Apr 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744036798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LruWl4eJ0JlNHMKuaJVskJNCYwZgsFSiYDpKj+uzrGQ=;
	b=kfsdsK3u71JqoUU7ZvKAPkWqikCt5/s/kgdNzVYLNMqL618q5JQVVgvBp07zRtd0cTRYp3
	FyVs62ZNKd4ubm17ymstF2yL3b/NX5OLhDpJufUaNSk4uUCOlcQzNyGQTRPy1glakQf1mb
	MTSz8j9od0S+YuOlVrln+N4yGTaNUBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744036798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LruWl4eJ0JlNHMKuaJVskJNCYwZgsFSiYDpKj+uzrGQ=;
	b=/3Fw7+xXiCpLXm2KTyhyMZ5n/KoIRQnrInrArFT8v5vYX/el9dWaiUjL6vT6b493WFZa88
	fui/HNC7QOv7yEDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kfsdsK3u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/3Fw7+xX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744036798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LruWl4eJ0JlNHMKuaJVskJNCYwZgsFSiYDpKj+uzrGQ=;
	b=kfsdsK3u71JqoUU7ZvKAPkWqikCt5/s/kgdNzVYLNMqL618q5JQVVgvBp07zRtd0cTRYp3
	FyVs62ZNKd4ubm17ymstF2yL3b/NX5OLhDpJufUaNSk4uUCOlcQzNyGQTRPy1glakQf1mb
	MTSz8j9od0S+YuOlVrln+N4yGTaNUBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744036798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LruWl4eJ0JlNHMKuaJVskJNCYwZgsFSiYDpKj+uzrGQ=;
	b=/3Fw7+xXiCpLXm2KTyhyMZ5n/KoIRQnrInrArFT8v5vYX/el9dWaiUjL6vT6b493WFZa88
	fui/HNC7QOv7yEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA59413691;
	Mon,  7 Apr 2025 14:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1Y6Lb7j82dWLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:39:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57AE3A08D2; Mon,  7 Apr 2025 16:39:58 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:39:58 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: report FAN_PRE_MODIFY event before write to
 file range
Message-ID: <aqagpfsdqt3prcruoypvcehtvux3qbzbz22wbirgftnp66i7ig@or2ntpsizmri>
References: <20250331165231.1466680-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331165231.1466680-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: C7D4A1F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 31-03-25 18:52:31, Amir Goldstein wrote:
> In addition to FAN_PRE_ACCESS event before any access to a file range,
> also report the FAN_PRE_MODIFY event in case of a write access.
> 
> This will allow userspace to subscribe only to pre-write access
> notifications and to respond with error codes associated with write
> operations using the FAN_DENY_ERRNO macro.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> I was looking on th list for the reason we decided to drop FAN_PRE_MODIFY
> from the pre-content patch set and I couldn't find it. It may have been
> related to complications ot page fault hooks that are not not relevant?

Two reasons really:
1) Defining semantics of FAN_PRE_MODIFY when it is generated on page fault
was hard and was making the changes even more complex.

2) Without a real user of the event in userspace, I have doubts we'll get
the semantics right.

> I did find the decision to generate FAN_PRE_ACCESS on both read()/write(),
> so maybe we thought there was no clear value for the FAN_PRE_MODIFY event?
> 
> In any case, I realized that we allowed returning custom errors with
> FAN_DENY_ERRNO(ENOSPC), but that chosing the right error does require
> knowing whether the call was read() or write().

I see your point but if someone wants to read a file, your HSM server
fetches the data and wants to store them in the filesystem and gets ENOSPC,
then what do you want to return? I agree returning ENOSPC is confusing but
OTOH anything else will be confusing even more (in the sense "why did I get
this error?")?

> Becaue mmap() cannot return write() errors like ENOSPC, I decided not
> to generate FAN_PRE_MODIFY for writably-shared maps, but maybe we should
> consider this.

Generally, the semantics of events for mmap needs a careful thinking so
that we provide all the needed events while maintaining sensible
performance. And for that I think we need a better formulated understanding
of what is the event going to be used for? For example for FAN_PRE_ACCESS
event we now generate the event on mmap(2). Now what should userspace do if
it wants to move some file to "slow tier" and get the event again when the
file is used again? Is that even something we plan to support?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

