Return-Path: <linux-fsdevel+bounces-25010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE8947B21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 14:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8FC280D81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3037158DD8;
	Mon,  5 Aug 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gn2qZT7r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/F1BLqOn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gn2qZT7r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/F1BLqOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1618026;
	Mon,  5 Aug 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861776; cv=none; b=HJ+NcvHynJoQMSY15VIM7jDPw06kUBimPpc7GDidxzVajIwoayRl+w9LhBpgx/6FD73VmOipPWHntv21Xe6VR5NF85eTBogD80BuVLbsv2NAoLUETFbS+yv+KurbKqYB35HIB31j47tCb6/ig4ZE6cZNv/XXbIsTOYkcVcToHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861776; c=relaxed/simple;
	bh=kjmeKz/OfVogGP+6vAYsMaB/wg0M5wnmxNsUhLfS/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOVAdoYc50/wnsMsbS2vnEKnS98WwC9yZz9IIBmAAezXUBtMyGA0TDLGRUVWmLlMMIjhWhZAhZAPVUVyEozOBAh7ItbWs/Gw6jgLSAVw0YuH3i3T8PJ+tgb71x3BaRcoDP1MfyTnU/4lRk4oasD7a/s/4ROpD4gcjTcQ32pkKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gn2qZT7r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/F1BLqOn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gn2qZT7r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/F1BLqOn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9741621B8A;
	Mon,  5 Aug 2024 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722861772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPG1VezWkgtCgPL3X6l78ZFt5UmbLU4dQV3QwNEO/s0=;
	b=gn2qZT7r2UUCgYBm6VUb7AAppbAEV2IQk3E6HBPSIgbr74ajkl7fu08RnP3bjEsBZ5LTsn
	ivUQTgDeuFz+fHHzo5HF+BXelb1KVzFKrlMRbKXJFTb0jUSAfKy7VQwvIA2VQPrIHcQdXG
	UjXulExW/0UAo7R8w7ZotXetkVTygGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722861772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPG1VezWkgtCgPL3X6l78ZFt5UmbLU4dQV3QwNEO/s0=;
	b=/F1BLqOnsuLww9qbwUEx6bPd84zeCyflS6Z0IRx248qMkbdkONqDor2XrVJ+PCKjDOHDRD
	0O90eSnsfdHTYhDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722861772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPG1VezWkgtCgPL3X6l78ZFt5UmbLU4dQV3QwNEO/s0=;
	b=gn2qZT7r2UUCgYBm6VUb7AAppbAEV2IQk3E6HBPSIgbr74ajkl7fu08RnP3bjEsBZ5LTsn
	ivUQTgDeuFz+fHHzo5HF+BXelb1KVzFKrlMRbKXJFTb0jUSAfKy7VQwvIA2VQPrIHcQdXG
	UjXulExW/0UAo7R8w7ZotXetkVTygGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722861772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPG1VezWkgtCgPL3X6l78ZFt5UmbLU4dQV3QwNEO/s0=;
	b=/F1BLqOnsuLww9qbwUEx6bPd84zeCyflS6Z0IRx248qMkbdkONqDor2XrVJ+PCKjDOHDRD
	0O90eSnsfdHTYhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A06413ACF;
	Mon,  5 Aug 2024 12:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id luivIczIsGYBKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 12:42:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4895DA0897; Mon,  5 Aug 2024 14:42:52 +0200 (CEST)
Date: Mon, 5 Aug 2024 14:42:52 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
Message-ID: <20240805124252.nco2rblmgf6x7z4s@quack3>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <Zqwi48H74g2EX56c@dread.disaster.area>
 <b40a510d-37b3-da50-79db-d56ebd870bf0@huaweicloud.com>
 <Zqx824ty5yvwdvXO@dread.disaster.area>
 <1b99e874-e9df-0b06-c856-edb94eca16dc@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b99e874-e9df-0b06-c856-edb94eca16dc@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Fri 02-08-24 19:13:11, Zhang Yi wrote:
> On 2024/8/2 14:29, Dave Chinner wrote:
> > On Fri, Aug 02, 2024 at 10:57:41AM +0800, Zhang Yi wrote:
> >> On 2024/8/2 8:05, Dave Chinner wrote:
> >>> On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
> >>> Making this change also misses the elephant in the room: the
> >>> buffered write path still needs the ifs->state_lock to update the
> >>> dirty bitmap. Hence we're effectively changing the serialisation
> >>> mechanism for only one of the two ifs state bitmaps that the
> >>> buffered write path has to update.
> >>>
> >>> Indeed, we can't get rid of the ifs->state_lock from the dirty range
> >>> updates because iomap_dirty_folio() can be called without the folio
> >>> being locked through folio_mark_dirty() calling the ->dirty_folio()
> >>> aop.
> >>>
> >>
> >> Sorry, I don't understand, why folio_mark_dirty() could be called without
> >> folio lock (isn't this supposed to be a bug)?  IIUC, all the file backed
> >> folios must be locked before marking dirty. Are there any exceptions or am
> >> I missing something?
> > 
> > Yes: reading the code I pointed you at.
> > 
> > /**
> >  * folio_mark_dirty - Mark a folio as being modified.
> >  * @folio: The folio.
> >  *
> >  * The folio may not be truncated while this function is running.
> >  * Holding the folio lock is sufficient to prevent truncation, but some
> >  * callers cannot acquire a sleeping lock.  These callers instead hold
> >  * the page table lock for a page table which contains at least one page
> >  * in this folio.  Truncation will block on the page table lock as it
> >  * unmaps pages before removing the folio from its mapping.
> >  *
> >  * Return: True if the folio was newly dirtied, false if it was already dirty.
> >  */
> > 
> > So, yes, ->dirty_folio() can indeed be called without the folio
> > being locked and it is not a bug.
> 
> Ha, right, I missed the comments of this function, it means that there are
> some special callers that hold table lock instead of folio lock, is it
> pte_alloc_map_lock?
> 
> I checked all the filesystem related callers and didn't find any real
> caller that mark folio dirty without holding folio lock and that could
> affect current filesystems which are using iomap framework, it's just
> a potential possibility in the future, am I right?

There used to be quite a few places doing that. Now that I've checked all I
places was aware of got actually converted to call folio_mark_dirty() under
a folio lock (in particular all the cases happening on IO completion, folio
unmap etc.). Matthew, are you aware of any place where folio_mark_dirty()
would be called for regular file page cache (block device page cache is in a
different situation obviously) without folio lock held?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

