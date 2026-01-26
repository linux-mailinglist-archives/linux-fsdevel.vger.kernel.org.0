Return-Path: <linux-fsdevel+bounces-75455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D5HKelad2maeQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:15:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EF48814E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8313014852
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20733556B;
	Mon, 26 Jan 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBBGKNNR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wNXMOnVN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBBGKNNR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wNXMOnVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DFE55C
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429734; cv=none; b=lvQOM7BxItvC3Uq3AIIEinF0P3UgwF+r+GhxV78R/IRWBrJ0fiKef8W9NPkdB9VXwAdwvhDkC8JlZPtFbqJua4JowLJ0PwPAELoXHENUQNzg/3laV23q8zCT49Gmj1MoAvL+B/tQmD+9UofU8reFkEcp5MCOikOfe6JfrzVdbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429734; c=relaxed/simple;
	bh=dvZd4e0ueOssZNRTtW/IvgYLTWVo3RlTNLOSXlG+RVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2XLb5/UAqjyFnNiLIwOOiEJ4oLoUE3SjWxhLkeIws4ts1BQvssmsKmGS1OtzIVCArPmkm9ufgN9PxL7FFkDlNmr/9u+EJaDm1k1lBlkkohWAjRLfL86eVo0ytLI5QZwJEKYUauLYjFF2rNOfASKer421cjC/omaN31unUvuSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBBGKNNR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wNXMOnVN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBBGKNNR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wNXMOnVN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B25105BCC9;
	Mon, 26 Jan 2026 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769429730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LYEoH3r0CsvPjqDVHLvMc0dFHOwWIp8k/GYhOMEFBA=;
	b=yBBGKNNRNC82vKVeF4t2GGXWOM41ykvTclkgFEB+iycfGYdUhmL4YbXHk04QpiGsNZwyvr
	2awIIczzjSMWh2yycPWRukLrN5GdZrp2PH753WMVqlhqBU46gGWgru1Nfzi5dmWgyiu6z4
	PuLqSqFgNBZxVZ0hYTf5189OKBiBS3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769429730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LYEoH3r0CsvPjqDVHLvMc0dFHOwWIp8k/GYhOMEFBA=;
	b=wNXMOnVNJJjunHMRDiSRBLncb0kh+3tYHqZXMTLLNoD0IRqQlp35Qv0+e6H5p3JCQg06hY
	Mc8kVxou0CMzG2BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769429730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LYEoH3r0CsvPjqDVHLvMc0dFHOwWIp8k/GYhOMEFBA=;
	b=yBBGKNNRNC82vKVeF4t2GGXWOM41ykvTclkgFEB+iycfGYdUhmL4YbXHk04QpiGsNZwyvr
	2awIIczzjSMWh2yycPWRukLrN5GdZrp2PH753WMVqlhqBU46gGWgru1Nfzi5dmWgyiu6z4
	PuLqSqFgNBZxVZ0hYTf5189OKBiBS3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769429730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LYEoH3r0CsvPjqDVHLvMc0dFHOwWIp8k/GYhOMEFBA=;
	b=wNXMOnVNJJjunHMRDiSRBLncb0kh+3tYHqZXMTLLNoD0IRqQlp35Qv0+e6H5p3JCQg06hY
	Mc8kVxou0CMzG2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98DCC139F0;
	Mon, 26 Jan 2026 12:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S4tMJeJad2mABQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Jan 2026 12:15:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39D8FA0A4F; Mon, 26 Jan 2026 13:15:30 +0100 (CET)
Date: Mon, 26 Jan 2026 13:15:30 +0100
From: Jan Kara <jack@suse.cz>
To: Zack Weinberg <zack@owlfolio.org>
Cc: The 8472 <kernel@infinite-source.de>, Rich Felker <dalias@libc.org>, 
	Alejandro Colomar <alx@kernel.org>, Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <whaocgx6bopndbpag2wazn2ko4skxl4pe6owbavj3wblxjps4s@ntdfvzwggxv3>
References: <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
 <20260124213934.GI6263@brightrain.aerifal.cx>
 <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
 <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-75455-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 20EF48814E
X-Rspamd-Action: no action

On Sun 25-01-26 10:37:01, Zack Weinberg wrote:
> On Sat, Jan 24, 2026, at 4:57 PM, The 8472 wrote:
> >>     Delayed errors reported by close()
> >>
> >>         In a variety of situations, most notably when writing to a file
> >>         that is hosted on a network file server, write(2) operations may
> >>         “optimistically” return successfully as soon as the write has
> >>         been queued for processing.
> >>
> >>         close(2) waits for confirmation that *most* of the processing
> >>         for previous writes to a file has been completed, and reports
> >>         any errors that the earlier write() calls *would have* reported,
> >>         if they hadn’t returned optimistically.  Especially, close()
> >>         will report “disk full” (ENOSPC) and “disk quota exceeded”
> >>         (EDQUOT) errors that write() didn’t wait for.
> >
> > The Rust standard library team is also interested in this topic, there
> > is lively discussion[1] whether it makes sense to surface errors from
> > close at all. Our current default is to ignore them.
> > It is my understanding that errors may not have happened yet at
> > the time of close due to delayed writeback or additional descriptors
> > pointing to the description, e.g. in a forked child, and thus
> > close() is not a reliable mechanism for error detection and
> > fsync() is the only available option.
> >
> > [1] https://github.com/rust-lang/libs-team/issues/705
> 
> This is something I care about a lot as well, but I currently don’t
> have an *opinion*.  To form an informed opinion, I need the answers
> to these questions:
> 
> >>      [QUERY: Do delayed errors ever happen in any of these situations?
> >>
> >>         - The fd is not the last reference to the open file description
> >>
> >>         - The OFD was opened with O_RDONLY
> >>
> >>         - The OFD was opened with O_RDWR but has never actually
> >>           been written to
> >>
> >>         - No data has been written to the OFD since the last call to
> >>           fsync() for that OFD
> >>
> >>         - No data has been written to the OFD since the last call to
> >>           fdatasync() for that OFD
> >>
> >>         If we can give some guidance about when people don’t need to
> >>         worry about delayed errors, it would be helpful.]
> 
> In particular, I really hope delayed errors *aren’t* ever reported
> when you close a file descriptor that *isn’t* the last reference
> to its open file description, because the thread-safe way to close
> stdout without losing write errors[2] depends on that not happening.

So I've checked and in Linux ->flush callback for the file is called
whenever you close a file descriptor (regardless whether there are other
file descriptors pointing to the same file description) so it's upto
filesystem implementation what it decides to do and which error it will
return... Checking the implementations e.g. FUSE and NFS *will* return
delayed writeback errors on *first* descriptor close even if there are
other still open descriptors for the description AFAICS.

> And whether the Rust stdlib can legitimately say “leaving aside the
> additional cost of calling fsync(), you do not *need* the error return
> from close() because you can call fsync() first,” depends on whether
> it’s actually true that you *won’t* ever get a delayed error from
> close() if you called fsync() first and didn’t do any more output in
> between (assume the fd has no duplicates here).  I would not be
> surprised at all if those FUSE guys insisted on their right to make
> 
>     char msg[] = "soon I will be invincible\n";
>     int fd = open("/test-fuse-fs/test.txt", O_WRONLY, 0666);
>     write(fd, msg, sizeof(msg) - 1);
>     fsync(fd);
>     close(fd);
> 
> return an error *only* from the close, not the write or the fsync.

So fsync(2) must make sure data is persistently stored and return error if
it was not. Thus as a VFS person I'd consider it a filesystem bug if an
error preveting reading data later was not returned from fsync(2). OTOH
that doesn't necessarily mean that later close doesn't return an error -
e.g. FUSE does communicate with the server on close that can fail and
error can be returned.

With this in mind let me now try to answer your remaining questions:

> >>         - The OFD was opened with O_RDONLY

If the filesystem supports atime, close can in principle report that atime
update failed. 

> >>         - The OFD was opened with O_RDWR but has never actually
> >>           been written to

The same as above but with inode mtime updates.

> >>         - No data has been written to the OFD since the last call to
> >>           fsync() for that OFD

No writeback errors should happen in this case. As I wrote above I'd
consider this a filesystem bug.

> >>
> >>         - No data has been written to the OFD since the last call to
> >>           fdatasync() for that OFD

Errors can happen because some inode metadata (in practice probably only
inode time stamps) may still need to be written out.

So in the cases described above (except for fsync()) you may get delayed
errors on close. But since in all those cases no data is lost, I don't
think 99.9% of applications care at all...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

