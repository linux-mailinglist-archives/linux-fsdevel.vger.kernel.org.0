Return-Path: <linux-fsdevel+bounces-16470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD1789E2DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A06DB22B35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B9E156F4A;
	Tue,  9 Apr 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZiO85bZT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f1omJmXM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZiO85bZT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f1omJmXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3FE157493;
	Tue,  9 Apr 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689225; cv=none; b=rKPq1jmz1Vv5X9lz7zIq3+rzeQnWtWHbQ2HwXrpasJ75wHRmMZsyhSoX6qJdLp2oxSFMYhiXK/H5YROz1oCHJXHzz8v6pfVNZZtfhnrDE8BzNvuPBkKTg+Z/moINmwdiZd6WY5EIKuWfiG2NlicWwSHnbCBOdC9EJlgz5xZqFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689225; c=relaxed/simple;
	bh=jPwLJzVcdbLlEJmrLWiVYS2JfNgre6a6iqSVy3TYJL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4MknI5zjGNSKkNluc3JD5Xi2XLEkWR9dHdtFAe3noQxHcXA2mAv3W4v00Dko7VXhr7tVHuTUOatV8j/oX+tVYrx1vcKdYxkpBM4gLgmfRvXR1DSPTAhbYtIuySQ7OAIrA5X1kFn6rddkOUxfWhKhY3l5wvKXy99qeK3iaQ0PuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZiO85bZT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f1omJmXM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZiO85bZT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f1omJmXM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 046CE20D39;
	Tue,  9 Apr 2024 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712689213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkz/tjuKwzj0hsC2vwRrgims6QQaXFZra4XY1I/2PHE=;
	b=ZiO85bZTJ5NcDo1xuqWSDg7GLJXfyqVZbQ+bvSdQjn4DRN+dZdUA8/32E+wnAnC7GIMtVg
	Y6NRbkInx2u7eY8W7iUUBxr0Sx0VjSfCVl2lZ6ap19D5oJ8XEIWc9wZpW9j+0CI5LwHEOo
	RP7/pCPGN9WBL1jyHqmTMGdtVeH3fz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712689213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkz/tjuKwzj0hsC2vwRrgims6QQaXFZra4XY1I/2PHE=;
	b=f1omJmXMA4qOuWHh9Axrs9wvhkelv9cz6Hsp8NZcytHBGucfEx42PFsEaOjfyFl+oNoQym
	LXVNbVvDheViYTCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZiO85bZT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f1omJmXM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712689213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkz/tjuKwzj0hsC2vwRrgims6QQaXFZra4XY1I/2PHE=;
	b=ZiO85bZTJ5NcDo1xuqWSDg7GLJXfyqVZbQ+bvSdQjn4DRN+dZdUA8/32E+wnAnC7GIMtVg
	Y6NRbkInx2u7eY8W7iUUBxr0Sx0VjSfCVl2lZ6ap19D5oJ8XEIWc9wZpW9j+0CI5LwHEOo
	RP7/pCPGN9WBL1jyHqmTMGdtVeH3fz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712689213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkz/tjuKwzj0hsC2vwRrgims6QQaXFZra4XY1I/2PHE=;
	b=f1omJmXMA4qOuWHh9Axrs9wvhkelv9cz6Hsp8NZcytHBGucfEx42PFsEaOjfyFl+oNoQym
	LXVNbVvDheViYTCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D330213253;
	Tue,  9 Apr 2024 19:00:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0Z9pMzyQFWafQwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 19:00:12 +0000
Date: Tue, 9 Apr 2024 20:52:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Qu Wenruo <wqu@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-doc@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 5/5] btrfs: fiemap: return extent physical size
Message-ID: <20240409185247.GJ3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1711588701.git.sweettea-kernel@dorminy.me>
 <93686d5c4467befe12f76e4921bfc20a13a74e2d.1711588701.git.sweettea-kernel@dorminy.me>
 <a2d3cdef-ed4e-41f0-b0d9-801c781f9512@suse.com>
 <ff320741-0516-410f-9aba-fc2d9d7a6b01@dorminy.me>
 <d01b4606-38fa-4f27-8fbd-31de505ba3a3@dorminy.me>
 <305008f4-9e17-4435-bb1d-a56b1de63c9b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <305008f4-9e17-4435-bb1d-a56b1de63c9b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 046CE20D39
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from]

On Wed, Apr 03, 2024 at 05:49:42PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/4/3 16:32, Sweet Tea Dorminy 写道:
> >>> This means, we will emit a entry that uses the end to the physical
> >>> extent end.
> >>>
> >>> Considering a file layout like this:
> >>>
> >>>      item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
> >>>          generation 7 type 1 (regular)
> >>>          extent data disk byte 13631488 nr 65536
> >>>          extent data offset 0 nr 4096 ram 65536
> >>>          extent compression 0 (none)
> >>>      item 7 key (257 EXTENT_DATA 4096) itemoff 15763 itemsize 53
> >>>          generation 8 type 1 (regular)
> >>>          extent data disk byte 13697024 nr 4096
> >>>          extent data offset 0 nr 4096 ram 4096
> >>>          extent compression 0 (none)
> >>>      item 8 key (257 EXTENT_DATA 8192) itemoff 15710 itemsize 53
> >>>          generation 7 type 1 (regular)
> >>>          extent data disk byte 13631488 nr 65536
> >>>          extent data offset 8192 nr 57344 ram 65536
> >>>          extent compression 0 (none)
> >>>
> >>> For fiemap, we would got something like this:
> >>>
> >>> fileoff 0, logical len 4k, phy 13631488, phy len 64K
> >>> fileoff 4k, logical len 4k, phy 13697024, phy len 4k
> >>> fileoff 8k, logical len 56k, phy 13631488 + 8k, phylen 56k
> >>>
> >>> [HOW TO CALCULATE WASTED SPACE IN USER SPACE]
> >>> My concern is on the first entry. It indicates that we have wasted
> >>> 60K (phy len is 64K, while logical len is only 4K)
> >>>
> >>> But that information is not correct, as in reality we only wasted 4K,
> >>> the remaining 56K is still referred by file range [8K, 64K).
> >>>
> >>> Do you mean that user space program should maintain a mapping of each
> >>> utilized physical range, and when handling the reported file range
> >>> [8K, 64K), the user space program should find that the physical range
> >>> covers with one existing extent, and do calculation correctly?
> >>
> >> My goal is to give an unprivileged interface for tools like compsize
> >> to figure out how much space is used by a particular set of files.
> >> They report the total disk space referenced by the provided list of
> >> files, currently by doing a tree search (CAP_SYS_ADMIN) for all the
> >> extents pertaining to the requested files and deduplicating extents
> >> based on disk_bytenr.
> >>
> >> It seems simplest to me for userspace for the kernel to emit the
> >> entire extent for each part of it referenced in a file, and let
> >> userspace deal with deduplicating extents. This is also most similar
> >> to the existing tree-search based interface. Reporting whole extents
> >> gives more flexibility for userspace to figure out how to report
> >> bookend extents, or shared extents, or ...
> >>
> >> It does seem a little weird where if you request with fiemap only e.g.
> >> 4k-16k range in that example file you'll get reported all 68k
> >> involved, but I can't figure out a way to fix that without having the
> >> kernel keep track of used parts of the extents as part of reporting,
> >> which sounds expensive.
> >>
> >> You're right that I'm being inconsistent, taking off extent_offset
> >> from the reported disk size when that isn't what I should be doing, so
> >> I fixed that in v3.
> >
> > Ah, I think I grasp a point I'd missed before.
> > - Without setting disk_bytenr to the actual start of the data on disk,
> > there's no way to find the location of the actual data on disk within
> > the extent from fiemap alone
> 
> Yes, that's my point.
> 
> > - But reporting disk_bytenr + offset, to get actual start of data on
> > disk, means we need to report a physical size to figure out the end of
> > the extent and we can't know the beginning.
> 
> disk_bytenr + offset + disk_num_bytes, and with the existing things like
> length (aka, num_bytes), filepos (aka, key.offset) flags
> (compression/hole/preallocated etc), we have everything we need to know
> for regular extents.
> 
> For compressed extents, we also need ram_bytes.
> 
> If you ask me, I'd say put all the extra members into fiemap entry if we
> have the space...
> 
> It would be u64 * 4 if we go 1:1 on the file extent items, otherwise we
> may cheap on offset and ram_bytes (u32 is enough for btrfs at least), in
> that case it would be u64 * 2 + u32 * 2.
> 
> But I'm also 100% sure, the extra members would not be welcomed by other
> filesystems either.

That's probably right, too many btrfs-specific information in the
generic FIEMAP, but we may also do our own enhanced fiemap ioctl that
would provide all the information you suggest and we'd be free to put
the compression information there too.

