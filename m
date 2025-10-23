Return-Path: <linux-fsdevel+bounces-65286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B43C0049C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B3019A2A11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6593093CD;
	Thu, 23 Oct 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LU/5yS3R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uL1pIUmR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hny0RdB4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t7GXBfMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995B3090EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212257; cv=none; b=GLY4FQMDo98ZaNfVdJBxyCTpRGOYpOEHXdSX78JHYcZwuGHMC9TwoBSGP/0AiFJdSaFWQ/K8Xx8GncG0WplcxWvG3wny+spP8ESvLHiYCw4A9m7P23C9MUHP+9rTjTHOlHtGQt1r4qeHsI8+dOWWv2Hm/YhSV0FfLppNsvmH4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212257; c=relaxed/simple;
	bh=o5BtFZIm837qddv5i2fr1EKRdue0SPouZ8RzRp+CGfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRRz8m6M9hdeiOzKnvFFuMXCIGYjmE3IhvJ9aVgpz9If54FVZKqUXqSG1VJVd6k2MfNsf+oEs8BizVl2o9jiVKzffSfz9XpSN5P3toRMS2vUnXwxUjCUjjxWtvWI7HfBV/kQ2JsqTXD/fHOSwqEYtROz6oSWT7swfwq7cVb8TSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LU/5yS3R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uL1pIUmR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hny0RdB4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t7GXBfMY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB9F1F388;
	Thu, 23 Oct 2025 09:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761212249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxP+/O6Wpl//xRTgUvAUeHTOU3h8ER8X0cqpJ8cKmpk=;
	b=LU/5yS3RC8FrIC0QpaOAIilIPVo0TLduOY3AWCPGA6BobFE13lTDpn9+SV11lJn77agCcE
	vEnPPmZhYkQfdWV36//PsiBLWrlST69ajpllUQejLV4wcMewonZiPDPhTJgbY4eeOJajff
	sWQlnfK4uOKW1bSkXzv/aHDYPSCcwhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761212249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxP+/O6Wpl//xRTgUvAUeHTOU3h8ER8X0cqpJ8cKmpk=;
	b=uL1pIUmRTNpECOZgs8QebhRKXbKiSIfrdEkqBgjXzUuHEluM4CX4BmxRWl10xHD2+jvCCO
	o6EbLcyHQ1IYQsCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761212245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxP+/O6Wpl//xRTgUvAUeHTOU3h8ER8X0cqpJ8cKmpk=;
	b=hny0RdB44tCxXfVG5kXbxljg2OduQjTiDJvUtB3QjYmX442ek9QsNEGU8MdsY1l1zC+p12
	lOs2MdTGzr/j1ZUidiC4CE7KFg0XDJLIBa03Nslhgf+bEKdSFiTbj6wlEDSnTeqlK+lobV
	YoOOkUPOMjIBXOPGz3lFDjIbiqqgkCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761212245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxP+/O6Wpl//xRTgUvAUeHTOU3h8ER8X0cqpJ8cKmpk=;
	b=t7GXBfMY7/0bvXiEGsumtSau/j3cPXl0f1UuZvT6uW5Zspqndd1KD40xRT7otK/IxMmgTh
	CqtbykZbOZK+WXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4078813285;
	Thu, 23 Oct 2025 09:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Abi6D1X3+WgsSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 23 Oct 2025 09:37:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D80CBA054D; Thu, 23 Oct 2025 11:37:24 +0200 (CEST)
Date: Thu, 23 Oct 2025 11:37:24 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <dupgze7vl2vvndyasmm34ebhzxzumv3sz425qvbquruzvqgf4r@q66h2eeaxs7h>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
 <aPgZthYaP7Flda0z@dread.disaster.area>
 <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
 <aPiPG1-VDV7ZV2_F@dread.disaster.area>
 <CAHk-=wjVOhYTtT9pjzAqXoXdinrV9+uiYfUyoQ5RFmTEvua-Jg@mail.gmail.com>
 <aPneVmBuuTHGQBgl@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPneVmBuuTHGQBgl@dread.disaster.area>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 23-10-25 18:50:46, Dave Chinner wrote:
> On Wed, Oct 22, 2025 at 05:31:12AM -1000, Linus Torvalds wrote:
> > On Tue, 21 Oct 2025 at 22:00, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, Oct 21, 2025 at 06:25:30PM -1000, Linus Torvalds wrote:
> > > >
> > > > The sequence number check should take care of anything like that. Do
> > > > you have any reason to believe it doesn't?
> > >
> > > Invalidation doing partial folio zeroing isn't covered by the page
> > > cache delete sequence number.
> > 
> > Correct - but neither is it covered by anything else in the *regular* read path.
> > 
> > So the sequence number protects against the same case that the
> > reference count protects against: hole punching removing the whole
> > page.
> > 
> > Partial page hole-punching will fundamentally show half-way things.
> 
> Only when you have a busted implementation of the spec.
> 
> Think about it: if I said "partial page truncation will
> fundamentally show half-way things", you would shout at me that
> truncate must -never- expose half-way things to buffered reads.
> This is how truncate is specified to behave, and we don't violate
> the spec just because it is hard to implement it.

Well, as a matter of fact we can expose part-way results of truncate for
ext4 and similar filesystems not serializing reads to truncate with inode
lock. In particular for ext4 there's the i_size check in filemap_read() but
if that passes before the truncate starts, the code copying out data from
the pages can race with truncate zeroing out tail of the last page.

> We've broken truncate repeatedly over the past 20+ years in ways
> that have exposed stale data to users. This is always considered a
> critical bug that needs to be fixed ASAP.

Exposing data that was never in the file is certainly a critical bug.
Showing a mix of old and new data is not great but less severe and it seems
over the years userspace on Linux learned to live with it and reap the
performance benefit (e.g. for mixed read-write workloads to one file)...

<snip>

> Hence there is really only one behaviour that is required: whilst
> the low level operation is taking place, no external IO (read,
> write, discard, etc) can be performed over that range of the file
> being zeroed because the data andor metadata is not stable until the
> whole operation is completed by the filesystem.
> 
> Now, this doesn't obviously read on the initial invalidation races
> that are the issue being discussed here because zero's written by
> invalidation could be considered "valid" for hole punch, zero range,
> etc.
> 
> However, consider COLLAPSE_RANGE.  Page cache invalidation
> writing zeros and reads racing with that is a problem, because
> the old data at a given offset is non-zero, whilst the new data at
> the same offset is alos non-zero.
> 
> Hence if we allow the initial page cache invalidation to race with
> buffered reads, there is the possibility of random zeros appearing
> in the data being read. Because this is not old or new data, it is
> -corrupt- data.

Well, reasons like this are why for operations like COLLAPSE_RANGE ext4
reclaims the whole interval of the page cache starting with the first
affected folio to the end. So again user will either see old data (if it
managed to get the page before we invalidated the page cache) or the new
data (when it needs to read from the disk which is properly synchronized
with COLLAPSE_RANGE through invalidate_lock). I don't see these speculative
accesses changing anything in this case either.
 
> Put simply, these fallocate operations should *never* see partial
> invalidation data, and so the "old or new data" rule *must* apply to
> the initial page cache invalidation these fallocate() operations do.
> 
> Hence various fallocate() operations need to act as a full IO
> barrier. Buffered IO, page faults and direct IO all must be blocked
> and drained before the invalidation of the range begins, and must
> not be allowed to start again until after the whole operation
> completes.

Hum, I'm not sure I follow you correctly but what you describe doesn't seem
like how ext4 works. There are two different things - zeroing out of
partial folios affected by truncate, hole punch, zero range (other
fallocate operations don't zero out) and invalidation of the page cache
folios. For ext4 it is actually the removal of folios from the page cache
during invalidation + holding invalidate_lock that synchronizes with reads.
As such zeroing of partial folios *can* actually race with reads within
these partial folios and so you can get a mix of zeros and old data from
reads.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

