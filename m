Return-Path: <linux-fsdevel+bounces-47039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B886FA97ED4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769E01655E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB126267383;
	Wed, 23 Apr 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GVaoisPG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DrsDafqQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GVaoisPG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DrsDafqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56C266595
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388633; cv=none; b=JjHwRyM5zZKXOPukKROdASHjlfAnNbOZvr3W3ZOdTRz3AqkA5LX04nWPDr5ogEKVUb+i3hwPZn+jGT93ZNjrDgTSk1r2jvNXk0lfFE6iUiqUJK7lh8AfNz1awsqEcsAeApAgRyXdikooXFqCoxhNHt5s1gvEJZZZ4ePFUo31X8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388633; c=relaxed/simple;
	bh=EbHX2pqfLIXqqTxZyMQR8JgZ9wtZ6sMiN34KEYOGPGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swjV47zFCU0edpvysegJfsrNnNWiVkt0KQT/oX71YVDOftLNa5+0WdsDNydBsMZl1yd6Yj/FoZfp9xLHSbMxMfDpNadA1x6Xsu+hqQIj0Ucm5QOexyXvaeootISi36GRglhwRfKyO2GABF9OMGgkWGcwMeUU+w1swLTpKsctTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GVaoisPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DrsDafqQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GVaoisPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DrsDafqQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55275211A1;
	Wed, 23 Apr 2025 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFobj8lX3Ml2C2LAi0qNJRm+pTw/ntas95UA3ndI9yQ=;
	b=GVaoisPGH+pCkhJRVyfSkczTLcEMYKgPrMF4mYnQ8dO30oygguC5947ft/Xy4VL/UCJWNX
	bYShp1M51fjxLWKm7NnlMZLx0dDpFgTRbtBptQcbMaXLSoKFtNqZaJjYFeeCbkL/OwCrUz
	FOMcc0awShDxDbCtVFck7rPY4Sfvpos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFobj8lX3Ml2C2LAi0qNJRm+pTw/ntas95UA3ndI9yQ=;
	b=DrsDafqQSYTtR4LRe8SCWR4muKWr1YPSw3P34ELgDIVzFCq2quvuAyHIul86ixIGojJbEO
	e/1USji8QYzvbeAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GVaoisPG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DrsDafqQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFobj8lX3Ml2C2LAi0qNJRm+pTw/ntas95UA3ndI9yQ=;
	b=GVaoisPGH+pCkhJRVyfSkczTLcEMYKgPrMF4mYnQ8dO30oygguC5947ft/Xy4VL/UCJWNX
	bYShp1M51fjxLWKm7NnlMZLx0dDpFgTRbtBptQcbMaXLSoKFtNqZaJjYFeeCbkL/OwCrUz
	FOMcc0awShDxDbCtVFck7rPY4Sfvpos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFobj8lX3Ml2C2LAi0qNJRm+pTw/ntas95UA3ndI9yQ=;
	b=DrsDafqQSYTtR4LRe8SCWR4muKWr1YPSw3P34ELgDIVzFCq2quvuAyHIul86ixIGojJbEO
	e/1USji8QYzvbeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8294D13691;
	Wed, 23 Apr 2025 06:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lNxRHlSECGjnTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Apr 2025 06:10:28 +0000
Message-ID: <76ba8f63-b5d3-4e43-beb4-97dae085c5f2@suse.de>
Date: Wed, 23 Apr 2025 08:10:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] block: remove the q argument from blk_rq_map_kern
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-5-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250422142628.1553523-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55275211A1
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RL94xbwdgyorksiizmbcmor9ro)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,lst.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/22/25 16:26, Christoph Hellwig wrote:
> Remove the q argument from blk_rq_map_kern and the internal helpers
> called by it as the queue can trivially be derived from the request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-map.c            | 24 ++++++++++--------------
>   drivers/block/pktcdvd.c    |  2 +-
>   drivers/block/ublk_drv.c   |  3 +--
>   drivers/block/virtio_blk.c |  4 ++--
>   drivers/nvme/host/core.c   |  2 +-
>   drivers/scsi/scsi_ioctl.c  |  2 +-
>   drivers/scsi/scsi_lib.c    |  3 +--
>   include/linux/blk-mq.h     |  4 ++--
>   8 files changed, 19 insertions(+), 25 deletions(-)
> 
Good cleanup. I always wondered why we need to have it.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

