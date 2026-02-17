Return-Path: <linux-fsdevel+bounces-77359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFJuN7dZlGkXDAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:06:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C814BC72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05EB3027329
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CEB3358DA;
	Tue, 17 Feb 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tj4JYsK0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etN8cHi2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tj4JYsK0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etN8cHi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98E335549
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329967; cv=none; b=Kr3TkU/TbLq3Pdzmc1/uXGVe1v9JonkS7ODyjOoGYYyhjl68OeJmGyCVD25OGoNz0pkvM7zLwOhi8CV+7S0y6hPChHq/TCKhoz2zKaWLE8i4hZrEs7iZvkP99k6SwG7rQeVo0NRIq30bL0Co2z4OnMNXeZhhjMk0rO1ObJMJPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329967; c=relaxed/simple;
	bh=c46h7rfrJ4CQbGFQLzUmTdfzEYEZ/a4r5Fw/52ZBJjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auCr05vuaXSZSPTJC9k9RyIcxK0qkG2P+SUwY1Gj+bl8zGA9Ibo5NwdU0R70RRbRzrN2XlxxLeSp5dOtG3DuFNEFbMV1jcUXb+LSedsv8RbLFJ3UPZPgQTJL2a2qySbHQ0ITC1h05tMqBfJQAZps9RhTijiA44O0b6W7XV1YFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tj4JYsK0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etN8cHi2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tj4JYsK0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etN8cHi2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 699583E6E3;
	Tue, 17 Feb 2026 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771329964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxkqPNgkdCosp0/W0/1gwJfHUSCYabVKYzC0gST4xVs=;
	b=Tj4JYsK0howQT9SoGnbXDmFratK/bokiECr7iooUakYXlGgRQwNzuv0YraZX61LfeqVKGF
	Dp+wWZ3u0etC1Fxkl5SuIjWnSH8aE2FGrAbtBjTBPacIMvpkPtdwhu0RwvZC46FToQpUhI
	ctwdVA3XIN/DkqcKNmznF+i7pkvla5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771329964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxkqPNgkdCosp0/W0/1gwJfHUSCYabVKYzC0gST4xVs=;
	b=etN8cHi2zKQJDOMOzLxSV1Q5EuWC25+n+s47IHcmvF0HtHA8i1MbBaQ+DTKCtL+uoDd80f
	bKJwWS8rN1RtF6Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tj4JYsK0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=etN8cHi2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771329964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxkqPNgkdCosp0/W0/1gwJfHUSCYabVKYzC0gST4xVs=;
	b=Tj4JYsK0howQT9SoGnbXDmFratK/bokiECr7iooUakYXlGgRQwNzuv0YraZX61LfeqVKGF
	Dp+wWZ3u0etC1Fxkl5SuIjWnSH8aE2FGrAbtBjTBPacIMvpkPtdwhu0RwvZC46FToQpUhI
	ctwdVA3XIN/DkqcKNmznF+i7pkvla5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771329964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxkqPNgkdCosp0/W0/1gwJfHUSCYabVKYzC0gST4xVs=;
	b=etN8cHi2zKQJDOMOzLxSV1Q5EuWC25+n+s47IHcmvF0HtHA8i1MbBaQ+DTKCtL+uoDd80f
	bKJwWS8rN1RtF6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50B283EA65;
	Tue, 17 Feb 2026 12:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gPKoE6xZlGmPTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Feb 2026 12:06:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0F5C3A08CF; Tue, 17 Feb 2026 13:06:04 +0100 (CET)
Date: Tue, 17 Feb 2026 13:06:04 +0100
From: Jan Kara <jack@suse.cz>
To: Andres Freund <andres@anarazel.de>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, ritesh.list@gmail.com, 
	jack@suse.cz, Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, 
	Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, 
	vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77359-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux.dev,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,redhat.com,samsung.com,mit.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 537C814BC72
X-Rspamd-Action: no action

On Mon 16-02-26 10:45:40, Andres Freund wrote:
> > Hmm, IIUC, postgres will write their dirty buffer cache by combining
> > multiple DB pages based on `io_combine_limit` (typically 128kb).
> 
> We will try to do that, but it's obviously far from always possible, in some
> workloads [parts of ]the data in the buffer pool rarely will be dirtied in
> consecutive blocks.
> 
> FWIW, postgres already tries to force some just-written pages into
> writeback. For sources of writes that can be plentiful and are done in the
> background, we default to issuing sync_file_range(SYNC_FILE_RANGE_WRITE),
> after 256kB-512kB of writes, as otherwise foreground latency can be
> significantly impacted by the kernel deciding to suddenly write back (due to
> dirty_writeback_centisecs, dirty_background_bytes, ...) and because otherwise
> the fsyncs at the end of a checkpoint can be unpredictably slow.  For
> foreground writes we do not default to that, as there are users that won't
> (because they don't know, because they overcommit hardware, ...) size
> postgres' buffer pool to be big enough and thus will often re-dirty pages that
> have already recently been written out to the operating systems.  But for many
> workloads it's recommened that users turn on
> sync_file_range(SYNC_FILE_RANGE_WRITE) for foreground writes as well (*).
> 
> So for many workloads it'd be fine to just always start writeback for atomic
> writes immediately. It's possible, but I am not at all sure, that for most of
> the other workloads, the gains from atomic writes will outstrip the cost of
> more frequently writing data back.

OK, good. Then I think it's worth a try.

> (*) As it turns out, it often seems to improves write throughput as well, if
> writeback is triggered by memory pressure instead of SYNC_FILE_RANGE_WRITE,
> linux seems to often trigger a lot more small random IO.
> 
> > So immediately writing them might be ok as long as we don't remove those
> > pages from the page cache like we do in RWF_UNCACHED.
> 
> Yes, it might.  I actually often have wished for something like a
> RWF_WRITEBACK flag...

I'd call it RWF_WRITETHROUGH but otherwise it makes sense.

> > > An argument against this however is that it is user's responsibility to
> > > not do non atomic IO over an atomic range and this shall be considered a
> > > userspace usage error. This is similar to how there are ways users can
> > > tear a dio if they perform overlapping writes. [1].
> 
> Hm, the scope of the prohibition here is not clear to me. Would it just
> be forbidden to do:
> 
> P1: start pwritev(fd, [blocks 1-10], RWF_ATOMIC)
> P2: pwrite(fd, [any block in 1-10]), non-atomically
> P1: complete pwritev(fd, ...)
> 
> or is it also forbidden to do:
> 
> P1: pwritev(fd, [blocks 1-10], RWF_ATOMIC) start & completes
> Kernel: starts writeback but doesn't complete it
> P1: pwrite(fd, [any block in 1-10]), non-atomically
> Kernel: completes writeback
> 
> The former is not at all an issue for postgres' use case, the pages in
> our buffer pool that are undergoing IO are locked, preventing additional
> IO (be it reads or writes) to those blocks.
> 
> The latter would be a problem, since userspace wouldn't even know that
> here is still "atomic writeback" going on, afaict the only way we could
> avoid it would be to issue an f[data]sync(), which likely would be
> prohibitively expensive.

It somewhat depends on what outcome you expect in terms of crash safety :)
Unless we are careful, the RWF_ATOMIC write in your latter example can end
up writing some bits of the data from the second write because the second
write may be copying data to the pages as we issue DMA from them to the
device. I expect this isn't really acceptable because if you crash before
the second write fully makes it to the disk, you will have inconsistent
data. So what we can offer is to enable "stable pages" feature for the
filesystem (support for buffered atomic writes would be conditioned by
that) - that will block the second write until the IO is done so torn
writes cannot happen. If quick overwrites are rare, this should be a fine
option. If they are frequent, we'd need to come up with some bounce
buffering but things get ugly quickly there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

