Return-Path: <linux-fsdevel+bounces-9629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAE3843783
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 08:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4BEB2486C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE05158207;
	Wed, 31 Jan 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dr0NX+K2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M92LB/4t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dr0NX+K2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M92LB/4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E855C2D;
	Wed, 31 Jan 2024 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685380; cv=none; b=V6A0UBj6vjs3kbpc0Hxcy8aWu8U8D9rvoFe4Y5vCS1rhK+xStd6ukM8/rcU8ji0Cu8Uq0VbduWB7dD6OyVzJyVP2P/P+Qkpr6ovbLiYVK0xpX0fSJ7BC9MmrvzU8Ju53jJBajKfqRTPSlEV5XZba1FmnGS58BqKQTJIwaSze73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685380; c=relaxed/simple;
	bh=i8Dtp1GtkqN3EER9SaqGkDSft/BmatJH8PhtBzu0l58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwDqsh8KmscsUErQf/GQsp1f9fRqB7Cj4aelkT1k8c8Erx8Nd6IFcwEmhUMtp4rTmb2ojunRArPZXfBZ65eu7kv0E5WzNFUNdjrxFj4Py/ZCVZ9783APQtOAgcKSJMNqsFbz79wpF07FoMsC4TykoLawTY+yqW3x26Ce3JA7f14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dr0NX+K2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M92LB/4t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dr0NX+K2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M92LB/4t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5424F1FB61;
	Wed, 31 Jan 2024 07:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=Dr0NX+K2Wknc8HgmFJF3WsrkTyljOT0VAhD/if9Gwc6eh1skfoDnd2fNqoti8+OFa38FwW
	F++yDJEwFNzPkX17r3T1CqPb/q6vwya3tKTvpp3ruZwnDEeGdH2XdVDut18txQqCr4yG3g
	59F/vV7RqXHLsM/qAHvc0pwiDu1Qw3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=M92LB/4twMJGsx5maaY2j8FfPx3WEVqWrj7763vlJZHtVPWrLGgEYg6whL8WY/k4oSjmxD
	yNkkkd+RgIlsblCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=Dr0NX+K2Wknc8HgmFJF3WsrkTyljOT0VAhD/if9Gwc6eh1skfoDnd2fNqoti8+OFa38FwW
	F++yDJEwFNzPkX17r3T1CqPb/q6vwya3tKTvpp3ruZwnDEeGdH2XdVDut18txQqCr4yG3g
	59F/vV7RqXHLsM/qAHvc0pwiDu1Qw3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=M92LB/4twMJGsx5maaY2j8FfPx3WEVqWrj7763vlJZHtVPWrLGgEYg6whL8WY/k4oSjmxD
	yNkkkd+RgIlsblCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E743132FA;
	Wed, 31 Jan 2024 07:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mnPhBsDzuWV0CQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 07:16:16 +0000
Date: Wed, 31 Jan 2024 08:15:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
Message-ID: <20240131071550.GI31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Dr0NX+K2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="M92LB/4t"
X-Spamd-Result: default: False [-1.35 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.34)[90.40%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5424F1FB61
X-Spam-Level: 
X-Spam-Score: -1.35
X-Spam-Flag: NO

On Sun, Jan 28, 2024 at 11:52:18PM -0800, Johannes Thumshirn wrote:
> Add a memalloc_nofs scope around all calls to blkdev_zone_mgmt(). This
> allows us to further get rid of the GFP_NOFS argument for
> blkdev_zone_mgmt().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

