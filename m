Return-Path: <linux-fsdevel+bounces-21063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174018FD2B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AD81C23773
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E015A84D;
	Wed,  5 Jun 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dIkUGvpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eBIdPu1d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dIkUGvpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eBIdPu1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB619D899;
	Wed,  5 Jun 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604343; cv=none; b=Z1I7Ss3dHTVrFBZdFE98/Gga4CcgqcBGrwNm3yi19SkSaYOBo3D/ZOFAL3/clFRGcfUPUb8IT9BV2QsYZIgaNpV3561ziR2eBYJ+8oSlp/AO+YpD7WhtPBgCpRPk7DcHrPzgIsDU958++RZPEkL/j/+A4MssXdRYZqD4NnqcsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604343; c=relaxed/simple;
	bh=lHV5wwB9e3B2P0F3EVrAQ7ztBPk4L/SA7XMeetXBSy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA7syTEfQY+Le7J2mfOKNaR+Uk94+U+TjkBcUT4E+eNKoNt46+ZDxp8s+VXEAhKtoMJkwaGIOjkOnICGp6s49ALvvOtw4dGbZF/KxmKk/WX7ZlnQpGfWpdo4J040rge8ekHRNxiVwRe9oFSwzt48VKU7pgQG0MuHXia4CKyri9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dIkUGvpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eBIdPu1d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dIkUGvpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eBIdPu1d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63A0C21A7D;
	Wed,  5 Jun 2024 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717604339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVUQtlRLszCU94XAJg4Sr2x5/iksbWcHEIMrG0v+xrc=;
	b=dIkUGvpuXjyw8hWpX0TCGxHMJzIwndbSEfMyUR61koOqjgd3gZ87h85g3MqkIskdjfFUhX
	RfGyCNBpysOEG8Yfg11A7COSDlVYZlHWjP6s7NG2TPhAubquIL6p6vZFJV84M28B/iU1+P
	RCbTHGsS/AtYfbh7WwjAhQLmZqRucIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717604339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVUQtlRLszCU94XAJg4Sr2x5/iksbWcHEIMrG0v+xrc=;
	b=eBIdPu1dlG0VDL3zSNN9m6cB840iiZOKYWePAKCDOIGSz2dh7VNcU0mhxBhWYLGzUb99CX
	jeKIs2BwIBpH0xDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717604339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVUQtlRLszCU94XAJg4Sr2x5/iksbWcHEIMrG0v+xrc=;
	b=dIkUGvpuXjyw8hWpX0TCGxHMJzIwndbSEfMyUR61koOqjgd3gZ87h85g3MqkIskdjfFUhX
	RfGyCNBpysOEG8Yfg11A7COSDlVYZlHWjP6s7NG2TPhAubquIL6p6vZFJV84M28B/iU1+P
	RCbTHGsS/AtYfbh7WwjAhQLmZqRucIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717604339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVUQtlRLszCU94XAJg4Sr2x5/iksbWcHEIMrG0v+xrc=;
	b=eBIdPu1dlG0VDL3zSNN9m6cB840iiZOKYWePAKCDOIGSz2dh7VNcU0mhxBhWYLGzUb99CX
	jeKIs2BwIBpH0xDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5839013A24;
	Wed,  5 Jun 2024 16:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 23KFFfOPYGZoWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 16:18:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D355BA086C; Wed,  5 Jun 2024 18:18:58 +0200 (CEST)
Date: Wed, 5 Jun 2024 18:18:58 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, brauner@kernel.org,
	viro@zeniv.linux.org.uk, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/splice: don't block splice_direct_to_actor() after
 data was read
Message-ID: <20240605161858.w2izlcbhuixjhzoo@quack3>
References: <20240604092431.2183929-1-max.kellermann@ionos.com>
 <20240604104151.73n3zmn24hxmmwj6@quack3>
 <CAKPOu+9BEAOSDPM97uzHUoQoNZC064D-F2SWZR=BSxi-r-=2VA@mail.gmail.com>
 <20240604132737.rpo464bhikcvkusy@quack3>
 <CAKPOu+_Ry45cJYjje_WcGsjzN55uyfVqdbLvXJDO0OHbWL3FZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_Ry45cJYjje_WcGsjzN55uyfVqdbLvXJDO0OHbWL3FZQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 04-06-24 21:24:14, Max Kellermann wrote:
> On Tue, Jun 4, 2024 at 3:27 PM Jan Kara <jack@suse.cz> wrote:
> > OK, so that was not clear to me (and this may well be just my ignorance of
> > networking details). Do you say that your patch changes the behavior only
> > for this cornercase? Even if the socket fd is blocking? AFAIU with your
> > patch we'd return short write in that case as well (roughly 64k AFAICT
> > because that's the amount the internal splice pipe will take) but currently
> > we block waiting for more space in the socket bufs?
> 
> My patch changes only the file-read side, not the socket-write side.
> It adds IOCB_NOWAIT for reading from the file, just like
> filemap_read() does. Therefore, it does not matter whether the socket
> is non-blocking.
> 
> But thanks for the reply - this was very helpful input for me because
> I have to admit that part of my explanation was wrong:
> I misunderstood how sending to a blocking socket works. I thought that
> send() and sendfile() would return after sending at least one byte
> (only recv() works that way), but in fact both block until everything
> has been submitted.

Yeah, this was exactly what I was trying to point at...

> I could change this to only use IOCB_NOWAIT if the destination is
> non-blocking, but something about this sounds wrong - it changes the
> read side just because the write side is non-blocking.
> We can't change the behavior out of fear of breaking applications; but
> can we have a per-file flag so applications can opt into partial
> reads/writes? This would be useful for all I/O on regular files (and
> sockets and everything else). There would not be any guarantees, just
> allowing the kernel to use relaxed semantics for those who can deal
> with partial I/O.
> Maybe I'm overthinking things and I should just fast-track full
> io_uring support in my code...

Adding open flags is messy (because they are different on different
architectures AFAIR 8-|) and I'm not sure we have much left. In principle
it is possible and I agree it seems useful. But I'm not sure how widespread
use it would get as, as you write above, these days the time may be better
spent on converting code with such needs to io_uring...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

