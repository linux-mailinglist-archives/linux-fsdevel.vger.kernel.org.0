Return-Path: <linux-fsdevel+bounces-63497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70704BBE3B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A55A1892451
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCBF2D46DA;
	Mon,  6 Oct 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRNdRPlS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUK46W1G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="265bKRdl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ABrEXBxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80D2D374A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758727; cv=none; b=uMFd53QCfTbrTu4KLigCjahVxvujuanv+V1gN1GlQGR2EdsdmhsAdm06XgJQSUp+otynXl821VPmZBEnJoHQenmT1/MHwII017ESrZWlmJXfyEo/nUylYb9Qpvrdnduq76Zw7yj4CXo+UVvtbg2yDR6iqTpX9vYkl9elzyU55Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758727; c=relaxed/simple;
	bh=FSSI7T28/5nGLrzHnqI4wkLx/x5cgaJTMHAEzO99lmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apSe5sN2qKVwgOoMp90+euDPCF+uv6fPw6zTW25jCenwGGvnWVoX67Cau9SgPinDc8OkMVYDfvmizj1HrJUSsEL0vYUypY0BzndzEFZ1RIXrz47bCG7OeHRMkcdSEuS3sCSanc7SFJEd3veSvn0D5j/QEA2sY7POiXY0j9min8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XRNdRPlS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUK46W1G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=265bKRdl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ABrEXBxS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 812F61F451;
	Mon,  6 Oct 2025 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759758723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AipBtX5SHCGh8rxdgPoJALPEAq4mP96kjbl6iC4fBQ=;
	b=XRNdRPlSI7p/wO9RMInYBkwsSvYlDCNMWsvjBy05zl4QKhAnwNvnGW61ngAKutupjJatTF
	qG1HQe7XuepNUpcK3ym2drF75HxAm/MnY4dnYakHtQOOW1KAqubtHcYIzV92S7wBoCL9qe
	pvlhP11E1f7bwCM7DvppJJpVRBeOxl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759758723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AipBtX5SHCGh8rxdgPoJALPEAq4mP96kjbl6iC4fBQ=;
	b=NUK46W1Gtevn6jXHuUSYSefAxcwqpTXNTOTXA76QnPUkIYL7a3cfufHVfoP7kb88dAW8My
	KfBf8GP64xLEivCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=265bKRdl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ABrEXBxS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759758722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AipBtX5SHCGh8rxdgPoJALPEAq4mP96kjbl6iC4fBQ=;
	b=265bKRdlxuJRpzHLUt+7Wjk+CAOQqYwgTY8P6qjDTtPyu9H6Bl5tqsmcxAURXquDxVCInM
	7V3Aun5k+gqKlTSd0W+LCfYNuHgsWFux49viSNLeXavBuZmUEATBqmvxBpUG13c3MrI+xK
	UKgbI06HBmw+53LBm4wirdQJIRT8sp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759758722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AipBtX5SHCGh8rxdgPoJALPEAq4mP96kjbl6iC4fBQ=;
	b=ABrEXBxSYoP8KepcsAXec5ziQbln6xKyRZevWK3Hda08SotNdGHqDK+N7eCCKl68BRs3Iw
	MU9fizVHll6X0nBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CE1213700;
	Mon,  6 Oct 2025 13:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r8yPGoLJ42hEEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 13:52:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3341A0AB6; Mon,  6 Oct 2025 15:52:01 +0200 (CEST)
Date: Mon, 6 Oct 2025 15:52:01 +0200
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 0/2] ext4: fix an data corruption issue in nojournal mode
Message-ID: <5vukrmwjsvvucw7ugpirmetr2inzgimkap4fhevb77dxqa7uff@yutnpju2e472>
References: <20250916093337.3161016-1-yi.zhang@huaweicloud.com>
 <4a152e1b-c468-4fbf-ac0b-dbb76fa1e2ac@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a152e1b-c468-4fbf-ac0b-dbb76fa1e2ac@linux.alibaba.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 812F61F451
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

Hi Ted!

I think this patch series has fallen through the cracks. Can you please
push it to Linus? Given there are real users hitting the data corruption,
we should do it soon (although it isn't a new issue so it isn't
supercritical).

On Thu 02-10-25 19:42:34, Gao Xiang wrote:
> On 2025/9/16 17:33, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Hello!
> > 
> > This series fixes an data corruption issue reported by Gao Xiang in
> > nojournal mode. The problem is happened after a metadata block is freed,
> > it can be immediately reallocated as a data block. However, the metadata
> > on this block may still be in the process of being written back, which
> > means the new data in this block could potentially be overwritten by the
> > stale metadata and trigger a data corruption issue. Please see below
> > discussion with Jan for more details:
> > 
> >    https://lore.kernel.org/linux-ext4/a9417096-9549-4441-9878-b1955b899b4e@huaweicloud.com/
> > 
> > Patch 1 strengthens the same case in ordered journal mode, theoretically
> > preventing the occurrence of stale data issues.
> > Patch 2 fix this issue in nojournal mode.
> 
> It seems this series is not applied, is it ignored?

Well, likely Ted just missed it when collecting patches for his PR.

> When ext4 nojournal mode is used, it is actually a very
> serious bug since data corruption can happen very easily
> in specific conditions (we actually have a specific
> environment which can reproduce the issue very quickly)

This is good to know so that we can prioritize accordingly.

> Also it seems AWS folks reported this issue years ago
> (2021), the phenomenon was almost the same, but the issue
> still exists until now:
> https://lore.kernel.org/linux-ext4/20211108173520.xp6xphodfhcen2sy@u87e72aa3c6c25c.ant.amazon.com/

Likely yes, but back then we weren't able to figure out the root cause.

> Some of our internal businesses actually rely on EXT4
> no_journal mode and when they upgrade the kernel from
> 4.19 to 5.10, they actually read corrupted data after
> page cache memory is reclaimed (actually the on-disk
> data was corrupted even earlier).
> 
> So personally I wonder what's the current status of
> EXT4 no_journal mode since this issue has been existing
> for more than 5 years but some people may need
> an extent-enabled ext2 so they selected this mode.

The nojournal mode is fully supported. There are many enterprise customers
(mostly cloud vendors) that depend on it. Including Ted's employer ;)

> We already released an announcement to advise customers
> not using no_journal mode because it seems lack of
> enough maintainence (yet many end users are interested
> in this mode):
> https://www.alibabacloud.com/help/en/alinux/support/data-corruption-risk-and-solution-in-ext4-nojounral-mode

Well, it's good to be cautious but the reality is that data corruption
issues do happen from time to time. Both in nojournal mode and in normal
journalled mode. And this one exists since the beginning when nojournal
mode was implemented. So it apparently requires rather specific conditions
to hit.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

