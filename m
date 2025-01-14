Return-Path: <linux-fsdevel+bounces-39134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD84A1078F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FF81689C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7862361EC;
	Tue, 14 Jan 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMEAedVv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRR5q83r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMEAedVv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRR5q83r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA6229633;
	Tue, 14 Jan 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860753; cv=none; b=rf0Ubed4Nr9DEwjExWxlaPQjOu2wxRB//5ZTgwwLnWhEkCzD767huYFh5XunjuijdNkhpsbhGzoIAItbc27m3qMduRLDyh3liArv816DQxrykewpl86gPGAVu3xOvzx3PyTUO9DJ/csLPbPbQMFiv5obHU1f7mrMS8u68hLsmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860753; c=relaxed/simple;
	bh=cr7LNMNJOY7C+nQ+pDvLo/qEfePbhgqHqwTfTyAWorA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKL+HSZlqFIWgPhDaQKsuV0NdDh/HCPawdGIib7ciM2HeVQeUWK0xO4oRPXmDABrnsMzgAaL1TtU+RAgyyRlGjg9FsMsDzx/d3lzAZ1uyWaKIFBl29FER/62MUJFJa4vZ/fWQdTVLhh52A7ZMWQovASp39FmMexmJUVneV/72K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMEAedVv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRR5q83r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMEAedVv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRR5q83r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 701AF1F37C;
	Tue, 14 Jan 2025 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736860749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/u0m2Pp0oheGATsO4++yz537rog6jJuLIbNZvYrAA+Q=;
	b=QMEAedVvug7QfLUZgEkGdTLA6nJu0gsPJljxnEoBFaDJm42jKpwGFU6FuvmSzGkP4dpQEC
	zPKiJYp2lyXdgEHbGtX3cai0aYX4vOk57xr6PXkRoiTnlviGA0xRuNFbiDDSoBmqi7T5q0
	CTPOtg//cnS5PdUQefdCR6eq1bBgaZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736860749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/u0m2Pp0oheGATsO4++yz537rog6jJuLIbNZvYrAA+Q=;
	b=uRR5q83rELjAcL1LJ/8f5lxZmqpC8F0WHKbFnBX7lLuD/uPVSlz+fWPevA0kQvJ3zth8te
	957lTnpIeOmpj3AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736860749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/u0m2Pp0oheGATsO4++yz537rog6jJuLIbNZvYrAA+Q=;
	b=QMEAedVvug7QfLUZgEkGdTLA6nJu0gsPJljxnEoBFaDJm42jKpwGFU6FuvmSzGkP4dpQEC
	zPKiJYp2lyXdgEHbGtX3cai0aYX4vOk57xr6PXkRoiTnlviGA0xRuNFbiDDSoBmqi7T5q0
	CTPOtg//cnS5PdUQefdCR6eq1bBgaZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736860749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/u0m2Pp0oheGATsO4++yz537rog6jJuLIbNZvYrAA+Q=;
	b=uRR5q83rELjAcL1LJ/8f5lxZmqpC8F0WHKbFnBX7lLuD/uPVSlz+fWPevA0kQvJ3zth8te
	957lTnpIeOmpj3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52731139CB;
	Tue, 14 Jan 2025 13:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8jwaFE1khmdYQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jan 2025 13:19:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FA22A08CD; Tue, 14 Jan 2025 14:19:01 +0100 (CET)
Date: Tue, 14 Jan 2025 14:19:01 +0100
From: Jan Kara <jack@suse.cz>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jim Zhao <jimzhao.ai@gmail.com>, akpm@linux-foundation.org, 
	jack@suse.cz, willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
Message-ID: <b4m3w6wuw3h6ke7qlvimly7nok4ymjvnej2vx3lnds3vysyopr@6b5bnifyst24>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,suse.cz,infradead.org,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 13-01-25 15:05:25, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Nov 21, 2024 at 06:05:39PM +0800, Jim Zhao wrote:
> > Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
> > write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
> > The wb_thresh bumping logic is scattered across wb_position_ratio,
> > __wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
> > consolidate all wb_thresh bumping logic into __wb_calc_thresh.
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> 
> This patch triggers a boot failure with one of my 'sheb' boot tests.
> It is seen when trying to boot from flash (mtd). The log says
> 
> ...
> Starting network: 8139cp 0000:00:02.0 eth0: link down
> udhcpc: started, v1.33.0
> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
> udhcpc: sending discover
> udhcpc: sending discover
> udhcpc: sending discover
> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2

Thanks for report! Uh, I have to say I'm very confused by this. It is clear
than when ext2 detects the directory corruption (we fail checking directory
inode 363 which is likely /etc/init.d/), the boot fails in interesting
ways. What is unclear is how the commit can possibly cause ext2 directory
corruption.  If you didn't verify reverting the commit fixes the issue, I'd
be suspecting bad bisection but that obviously isn't the case :-)

Ext2 is storing directory data in the page cache so at least it uses the
subsystem which the patch impacts but how writeback throttling can cause
ext2 directory corruption is beyond me. BTW, do you recreate the root
filesystem before each boot? How exactly?

								Honza

> udhcpc: no lease, failing
> FAIL
> /etc/init.d/S55runtest: line 29: awk: Permission denied
> Found console ttySC1
> /etc/init.d/S55runtest: line 45: awk: Permission denied
> can't run '/sbin/getty': No such device or address
> 
> and boot stalls from there. There is no obvious kernel log message
> associated with the problem. Reverting this patch fixes the problem.
> 
> Bisect log is attached for reference.
> 
> Guenter
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

