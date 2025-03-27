Return-Path: <linux-fsdevel+bounces-45127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED6A73122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 12:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7C5188EA65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4E213E6D;
	Thu, 27 Mar 2025 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0WmmS6iH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pIotN3XF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0WmmS6iH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pIotN3XF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085D2135B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076414; cv=none; b=posZ/rnZcwyibyJjyIV85qZfrYNQTeVHKqitS8s5QlEIrzEh631KtC9dhMtlhx7SnS8/1ou+5WlsNCpxHNdsblnF/ok9iA4IkXFsbw7+o2bEzmdJzYE25lLo6M6gBdQQE2frbHSblcCua/i4gOMrOcGrLgNDvx1xi0PwvGiz7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076414; c=relaxed/simple;
	bh=XABOlLOdb+GYGihfxxXpKbRns0kIKcDt7XDQoGxdyfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyhUfT2PSOZ88yHp0fbT/fYfBzKU3DAf5q4jla8JXFEbRX6vFVBseYEf7hbcEFfWetIZ0SN54q0TVSoxDH9t8aDUFRyzbXlp2M5HxWBERxzOhQU+tnjZ3DfgYMxdEG45RHFPjlu6/Q8rabdLEQdmjVuTFU22FaaDEVDiNVoolfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0WmmS6iH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pIotN3XF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0WmmS6iH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pIotN3XF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2A181F449;
	Thu, 27 Mar 2025 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743076410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+QxkDVy5JRXbW51kJ2F9UVtUHbBkep2u9RXAqpaoBw=;
	b=0WmmS6iHlw/gOs91YI8HSX8we1JIoZSAW6ycjBmd9yfK0HSf1J+h20t4Z96p3NQL4EgvLy
	pqVLrN6Hm1zJlzxIuQ4gqZGmb2fGiZFJ/KjnMFQiPTnM3hIGCP4XyrnCBa1aTDa4jL1LK7
	HJfIKZQ8nZ1pjFXGLmphhZqpXOIIL9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743076410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+QxkDVy5JRXbW51kJ2F9UVtUHbBkep2u9RXAqpaoBw=;
	b=pIotN3XFDhfuYS4qF+/VXHQh4jiW8JPxvUg9Zao5zvzq318vz6yZH7IPHfymstt2WoLJK5
	9gpWYqRYiKvLeaBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0WmmS6iH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pIotN3XF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743076410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+QxkDVy5JRXbW51kJ2F9UVtUHbBkep2u9RXAqpaoBw=;
	b=0WmmS6iHlw/gOs91YI8HSX8we1JIoZSAW6ycjBmd9yfK0HSf1J+h20t4Z96p3NQL4EgvLy
	pqVLrN6Hm1zJlzxIuQ4gqZGmb2fGiZFJ/KjnMFQiPTnM3hIGCP4XyrnCBa1aTDa4jL1LK7
	HJfIKZQ8nZ1pjFXGLmphhZqpXOIIL9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743076410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+QxkDVy5JRXbW51kJ2F9UVtUHbBkep2u9RXAqpaoBw=;
	b=pIotN3XFDhfuYS4qF+/VXHQh4jiW8JPxvUg9Zao5zvzq318vz6yZH7IPHfymstt2WoLJK5
	9gpWYqRYiKvLeaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 941D9139D4;
	Thu, 27 Mar 2025 11:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CNgjJDo85WdlMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Mar 2025 11:53:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49C00A082A; Thu, 27 Mar 2025 12:53:30 +0100 (CET)
Date: Thu, 27 Mar 2025 12:53:30 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, oliver.sang@intel.com, 
	hannes@cmpxchg.org, willy@infradead.org, jack@suse.cz, apopple@nvidia.com, 
	brauner@kernel.org, hare@suse.de, oe-lkp@lists.linux.dev, lkp@intel.com, 
	john.g.garry@oracle.com, p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net, 
	riel@surriel.com, krisman@suse.de, boris@bur.io, jackmanb@google.com, 
	gost.dev@samsung.com
Subject: Re: [PATCH] generic/764: fsstress + migrate_pages() test
Message-ID: <pociwdgfqbzw4mjass6u6wcnvmqlh3ddqzoeoiwiyqs64pl6yu@5ad7ne7rgwe2>
References: <20250326185101.2237319-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326185101.2237319-1-mcgrof@kernel.org>
X-Rspamd-Queue-Id: A2A181F449
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 26-03-25 11:50:55, Luis Chamberlain wrote:
> 0-day reported a page migration kernel warning with folios which happen
> to be buffer-heads [0]. I'm having a terribly hard time reproducing the bug
> and so I wrote this test to force page migration filesystems.
> 
> It turns out we have have no tests for page migration on fstests or ltp,
> and its no surprise, other than compaction covered by generic/750 there
> is no easy way to trigger page migration right now unless you have a
> numa system.
> 
> We should evaluate if we want to help stress test page migration
> artificially by later implementing a way to do page migration on simple
> systems to an artificial target.
> 
> So far, this doesn't trigger any kernel splats, not even warnings for me.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

So when I was testing page migration in the past MM guys advised me to use
THP compaction as a way to trigger page migration. You can manually
trigger compaction by:

echo 1 >/proc/sys/vm/compact_memory

So you first mess with the page cache a bit to fragment memory and then
call the above to try to compact it back...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

