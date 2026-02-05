Return-Path: <linux-fsdevel+bounces-76380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DddG5ZkhGkh2wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:36:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A63F0E06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76366300CC04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1BE39902A;
	Thu,  5 Feb 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfME6CXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="paFpYUP5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfME6CXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="paFpYUP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158738F948
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284062; cv=none; b=MGBkx1ldTJ2cJNZ+yg5PLJ2frWBPrZRcojYXfZn72aT4XLKLEkrMMuFtt647Yo2Arfnt3mmFgZWYOtY20BKuRCM++mad+lTtb3X5Nm/IDJ6Qjjo9SXODyaqNcmJ7iOxyVT49d9rmHkEWji/uDvVHx9IaA5zPDEFu+O3EW2ntDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284062; c=relaxed/simple;
	bh=QTaoBSokYmxJnJuWu9PDFHpiTqvfzjc0kDzkTBOFRyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbI2xFIjtPsjBi961dR4k0+103q1DI9ZZDD6PB1fGGqVbKakc2nD6NBIJPAhCKzPmwVbBMHSu8/FIEaPcV7AFQeO7bNsaAKMc5QnPr40xnyauFi4iRRFLomkxwAM4xqNL4A5Mx+DoQrlcsnqkQWHATdDMFZ1476kAZvbvll8pgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfME6CXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=paFpYUP5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfME6CXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=paFpYUP5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 027323E781;
	Thu,  5 Feb 2026 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770284060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO9x/6tLF2RcY0bTenK0aeS6bPxO41BHI96qRcw4P50=;
	b=BfME6CXXVri7hlMyfPN6EjbLzA+bj8dwLx01zhm48sG/3V914QEnQ/nlpypjtoA7iCLpDR
	LjnmDyVH/HqLC068OgZQL58yzIo80xB4zCXPs3l7RmB+3qvsPld6RVMJDEKvJotmQfWGEq
	UCzP60skyGyR0lirpzuAzGCAtk9+XzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770284060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO9x/6tLF2RcY0bTenK0aeS6bPxO41BHI96qRcw4P50=;
	b=paFpYUP5inZ1miQnyDlvbLcFTJ7RiD8q2+WKNku6XEjP2uv4HWj2QIwtutol+z03Lpz2bf
	x9HLnMamfSCZvkBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BfME6CXX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=paFpYUP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770284060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO9x/6tLF2RcY0bTenK0aeS6bPxO41BHI96qRcw4P50=;
	b=BfME6CXXVri7hlMyfPN6EjbLzA+bj8dwLx01zhm48sG/3V914QEnQ/nlpypjtoA7iCLpDR
	LjnmDyVH/HqLC068OgZQL58yzIo80xB4zCXPs3l7RmB+3qvsPld6RVMJDEKvJotmQfWGEq
	UCzP60skyGyR0lirpzuAzGCAtk9+XzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770284060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO9x/6tLF2RcY0bTenK0aeS6bPxO41BHI96qRcw4P50=;
	b=paFpYUP5inZ1miQnyDlvbLcFTJ7RiD8q2+WKNku6XEjP2uv4HWj2QIwtutol+z03Lpz2bf
	x9HLnMamfSCZvkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD06B3EA63;
	Thu,  5 Feb 2026 09:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OWvtNRtkhGmMWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 09:34:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9943EA09D8; Thu,  5 Feb 2026 10:34:19 +0100 (CET)
Date: Thu, 5 Feb 2026 10:34:19 +0100
From: Jan Kara <jack@suse.cz>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Jeff Layton <jlayton@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Jan Kara <jack@suse.cz>, The 8472 <kernel@infinite-source.de>, 
	Rich Felker <dalias@libc.org>, Alejandro Colomar <alx@kernel.org>, 
	Vincent Lefevre <vincent@vinc17.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <oyavezfglq7rp7pz6rbftzgi22zgdgtdsqglpsdmyqcbes5umy@y3n4hdtwncb6>
References: <20260124213934.GI6263@brightrain.aerifal.cx>
 <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
 <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
 <whaocgx6bopndbpag2wazn2ko4skxl4pe6owbavj3wblxjps4s@ntdfvzwggxv3>
 <c59361e4-ad50-4cdf-888e-3d9a4aa6f69b@infinite-source.de>
 <pt7hcmgnzwveyzxdfpxtrmz2bt5tki5wosu3kkboil7bjrolyr@hd4ctkpzzqzi>
 <72100ec4b1ec0e77623bfdb927746dddc77ed116.camel@kernel.org>
 <DFYW8O4499ZS.2L1ABA5T5XFF2@umich.edu>
 <2d6276fca349357f56733268681424b0de5179f7.camel@kernel.org>
 <037a7546-cbbf-4c00-bebd-57cee38785e1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <037a7546-cbbf-4c00-bebd-57cee38785e1@app.fastmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76380-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8A63F0E06
X-Rspamd-Action: no action

I've noticed we didn't reply to one question here:

On Wed 28-01-26 11:58:07, Zack Weinberg wrote:
> On Mon, Jan 26, 2026, at 7:49 PM, Jeff Layton wrote:
> > Checking the implementations e.g. FUSE and NFS *will* return delayed
> > writeback errors on *first* descriptor close even if there are other
> > still open descriptors for the description AFAICS.
> ...
> > fsync(2) must make sure data is persistently stored and return error if
> > it was not. Thus as a VFS person I'd consider it a filesystem bug if an
> > error preveting reading data later was not returned from fsync(2). OTOH
> > that doesn't necessarily mean that later close doesn't return an error -
> > e.g. FUSE does communicate with the server on close that can fail and
> > error can be returned.
> >
> > With this in mind let me now try to answer your remaining questions:
> >
> >> >>         - The OFD was opened with O_RDONLY
> >
> > If the filesystem supports atime, close can in principle report that atime
> > update failed.
> >
> >> >>         - The OFD was opened with O_RDWR but has never actually
> >> >>           been written to
> >
> > The same as above but with inode mtime updates.
> >
> >> >>         - No data has been written to the OFD since the last call to
> >> >>           fsync() for that OFD
> >
> > No writeback errors should happen in this case. As I wrote above I'd
> > consider this a filesystem bug.
> >
> >> >>
> >> >>         - No data has been written to the OFD since the last call to
> >> >>           fdatasync() for that OFD
> >
> > Errors can happen because some inode metadata (in practice probably only
> > inode time stamps) may still need to be written out.
> >
> > So in the cases described above (except for fsync()) you may get delayed
> > errors on close. But since in all those cases no data is lost, I don't
> > think 99.9% of applications care at all...
> 
> ... regrettably I think this does mean the close(3) manpage still needs
> to tell people to watch out for errors, and should probably say that
> errors _can_ happen even if the file wasn’t written to, but are much
> less likely to be important in that case.
> 
> And my “how to close stdout in a thread-safe manner” sample code is
> wrong, because I was wrong to think that the error reporting only
> happened on the _final_ close, when the OFD is destroyed.
> 
> ... What happens if the close is implicit in a dup2() operation? Here’s
> that erroneous “how to close stdout” fragment, with comments
> indicating what I thought could and could not fail at the time I wrote
> it:
> 
>     // These allocate new fds, which can always fail, e.g. because
>     // the program already has too many files open.
>     int new_stdout = open("/dev/null", O_WRONLY);
>     if (new_stdout == -1) perror_exit("/dev/null");
>     int old_stdout = dup(1);
>     if (old_stdout == -1) perror_exit("dup(1)");
> 
>     flockfile(stdout);
>     if (fflush(stdout)) perror_exit("stdout: write error");
>     dup2(new_stdout, 1); // cannot fail, atomically replaces fd 1
>     funlockfile(stdout);
> 
>     // this close may receive delayed write errors from previous writes
>     // to stdout
>     if (close(old_stdout)) perror_exit("stdout: write error");
> 
>     // this close cannot fail, because it only drops an alternative
>     // reference to the open file description now installed as fd 1
>     close(new_stdout);
> 
> Note in particular that the first close _operation_ on fd 1 is in
> consequence of dup2(new_stdout, 1).  The dup2() manpage specifically
> says “the close is performed silently (i.e. any errors during the
> close are not reported by dup()” but, if stdout points to a file on
> an NFS mount, are those errors _lost_, or will they actually be
> reported by the subsequent close(old_stdout)?

It is simply lost (the error is propagated from the filesystem to VFS which
just ignores it).

> Incidentally, the dup2() manpage has a very similar example in its
> NOTES section, also presuming that close only reports errors on the
> _final_ close, not when it “merely” drops reference >=2 to an OFD.
> 
> (I’m starting to think we need dup3(old, new, O_SWAP_FDS).  Or is that
> already a thing somehow?)

I don't think a functionality like this currently exists.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

