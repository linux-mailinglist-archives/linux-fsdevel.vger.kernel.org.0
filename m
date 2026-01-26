Return-Path: <linux-fsdevel+bounces-75477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I6BHfWOd2m9hgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:57:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2F8A661
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44948303EB91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306D33F368;
	Mon, 26 Jan 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IEAByBSX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oJovlz4g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IEAByBSX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oJovlz4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA66340DA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442984; cv=none; b=T0x/O/OrPFh3CBMGIhxOZxyoUtCXSTL+4onHAKl2b6i/d+bMRtjn4xtl+2PiPGCga3mlbqspw0N6jnHACILeaW5Ubp9VJsDV9uqjSJtN3t5cQqzOdjFGoHUhH01PGvBVFC7h/CY7trW62NYxsb0rkaSjUXLIsPgAUNjFOMM6Ysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442984; c=relaxed/simple;
	bh=V9yiuZ0QGOShCxUPOyrqOBtU5u3A8l46blVKs7PRAoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvnSI/Yik9ZtZel0AMmVTXkA/hGVmh/PduT2waNTQdvcDpPjPwEZjKlBXD+hwXh7HddmlAfR+4bkIT4B+eJkIx2BBTJLE2NaP0el9zUGOf84LXrw3pUdt624mP9D2DP7kFtsws1TH7+K6ae7MNb0MMQzZ7whj+Yip+A19+7ibYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IEAByBSX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oJovlz4g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IEAByBSX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oJovlz4g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79B355BCDE;
	Mon, 26 Jan 2026 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769442980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggnYOzMjuDISQjNpcGjU2Dgh7XI4vy281zRSAIOY4w=;
	b=IEAByBSXPqD03CH/R73LeAj0u34CuBML4RvmS/wg9vcfmAPr6MSlDJOk2GA1iru47c3A07
	7ZTl9ymvrv20tX3KCLiMwQ9X7LYym39skunIy2tN8iEKyZ92xzu7clHfVM7v66S9pEq1MI
	6eERkPDrrKAXAZqfjj9/jCfID2NENtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769442980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggnYOzMjuDISQjNpcGjU2Dgh7XI4vy281zRSAIOY4w=;
	b=oJovlz4g/GlPItB90D+cNMYuFNPm14Ztrc4QJnvrDRb0IYAgzxy4I5y/DDr5Oi2733DI7g
	Uj0Tv5xPt3vAAQCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IEAByBSX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oJovlz4g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769442980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggnYOzMjuDISQjNpcGjU2Dgh7XI4vy281zRSAIOY4w=;
	b=IEAByBSXPqD03CH/R73LeAj0u34CuBML4RvmS/wg9vcfmAPr6MSlDJOk2GA1iru47c3A07
	7ZTl9ymvrv20tX3KCLiMwQ9X7LYym39skunIy2tN8iEKyZ92xzu7clHfVM7v66S9pEq1MI
	6eERkPDrrKAXAZqfjj9/jCfID2NENtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769442980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggnYOzMjuDISQjNpcGjU2Dgh7XI4vy281zRSAIOY4w=;
	b=oJovlz4g/GlPItB90D+cNMYuFNPm14Ztrc4QJnvrDRb0IYAgzxy4I5y/DDr5Oi2733DI7g
	Uj0Tv5xPt3vAAQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60BDA139E9;
	Mon, 26 Jan 2026 15:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 93KXF6SOd2nOdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Jan 2026 15:56:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 045ADA0A1B; Mon, 26 Jan 2026 16:56:19 +0100 (CET)
Date: Mon, 26 Jan 2026 16:56:19 +0100
From: Jan Kara <jack@suse.cz>
To: The 8472 <kernel@infinite-source.de>
Cc: Jan Kara <jack@suse.cz>, Zack Weinberg <zack@owlfolio.org>, 
	Rich Felker <dalias@libc.org>, Alejandro Colomar <alx@kernel.org>, 
	Vincent Lefevre <vincent@vinc17.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <pt7hcmgnzwveyzxdfpxtrmz2bt5tki5wosu3kkboil7bjrolyr@hd4ctkpzzqzi>
References: <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
 <20260124213934.GI6263@brightrain.aerifal.cx>
 <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
 <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
 <whaocgx6bopndbpag2wazn2ko4skxl4pe6owbavj3wblxjps4s@ntdfvzwggxv3>
 <c59361e4-ad50-4cdf-888e-3d9a4aa6f69b@infinite-source.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c59361e4-ad50-4cdf-888e-3d9a4aa6f69b@infinite-source.de>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75477-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: E9F2F8A661
X-Rspamd-Action: no action

On Mon 26-01-26 14:53:12, The 8472 wrote:
> On 26/01/2026 13:15, Jan Kara wrote:
> > On Sun 25-01-26 10:37:01, Zack Weinberg wrote:
> > > On Sat, Jan 24, 2026, at 4:57 PM, The 8472 wrote:
> > > > >       [QUERY: Do delayed errors ever happen in any of these situations?
> > > > > 
> > > > >          - The fd is not the last reference to the open file description
> > > > > 
> > > > >          - The OFD was opened with O_RDONLY
> > > > > 
> > > > >          - The OFD was opened with O_RDWR but has never actually
> > > > >            been written to
> > > > > 
> > > > >          - No data has been written to the OFD since the last call to
> > > > >            fsync() for that OFD
> > > > > 
> > > > >          - No data has been written to the OFD since the last call to
> > > > >            fdatasync() for that OFD
> > > > > 
> > > > >          If we can give some guidance about when people don’t need to
> > > > >          worry about delayed errors, it would be helpful.]
> > > 
> > > In particular, I really hope delayed errors *aren’t* ever reported
> > > when you close a file descriptor that *isn’t* the last reference
> > > to its open file description, because the thread-safe way to close
> > > stdout without losing write errors[2] depends on that not happening.
> > 
> > So I've checked and in Linux ->flush callback for the file is called
> > whenever you close a file descriptor (regardless whether there are other
> > file descriptors pointing to the same file description) so it's upto
> > filesystem implementation what it decides to do and which error it will
> > return... Checking the implementations e.g. FUSE and NFS *will* return
> > delayed writeback errors on *first* descriptor close even if there are
> > other still open descriptors for the description AFAICS.
> Regarding the "first", does that mean the errors only get delivered once?

I've added Jeff to CC who should be able to provide you with a more
authoritative answer but AFAIK the answer is yes.

E.g. NFS does:

static int
nfs_file_flush(struct file *file, fl_owner_t id)
{
...
        /* Flush writes to the server and return any errors */
        since = filemap_sample_wb_err(file->f_mapping);
        nfs_wb_all(inode);
        return filemap_check_wb_err(file->f_mapping, since);
}

which will writeback all outstanding data on the first close and report
error if it happened. Following close has nothing to flush and thus no
error to report.

That being said if you call fsync(2) you'll still get the error back again
because fsync uses a separate writeback error counter in the file
description. But again only the first fsync(2) will return the error.
Following fsyncs will report no error.

> I.e. if a concurrent fork/exec happens for process spawning and the
> fork-child closes the file descriptors then this closing may basically
> receive the errors and the parent will not see them (unless additional
> errors happen)?

Correct AFAICT.

> Or if _any_ part of the program dups the descriptor and then closes it
> without reporting errors then all uses of those descriptor must consider
> error delivery on close to be unreliable?

Correct as well AFAICT.

I should probably also add that traditional filesystems (classical local
disk based filesystems) don't bother with reporting delayed errors on
close(2) *at all*. So unless you call fsync(2) you will never learn there
was any writeback error. After all for these filesystems there are good
chances writeback didn't even start by the time you are calling close(2).
So overall I'd say that error reporting from close(2) is so random and
filesystem dependent that the errors are not worth paying attention to. If
you really care about data integrity (and thus writeback errors) you must
call fsync(2) in which case the kernel provides at least somewhat
consistent error reporting story. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

