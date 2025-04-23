Return-Path: <linux-fsdevel+bounces-47038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51190A97ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1824B440242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F40266595;
	Wed, 23 Apr 2025 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VUX8Jx4L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4X3aOQhd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VUX8Jx4L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4X3aOQhd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE82566DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388588; cv=none; b=mBbRg7pEt8mgKzy/72jZkPesVxx1TRrUoECNAFsUXkdaaaUrX96JwJyeFhYTxGx2WamF6sYsWeTFRmrO3rTbD1Jjok0Hbgh7u7ZBtRBdlPWo2C02sgBRY5xqmr9Tpu4/E2bJt2doB0UQmImJc5Ks1CwpIPT986wSCvk+2emV08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388588; c=relaxed/simple;
	bh=98G8cthcVqB96KBXSxfWVVeVI3nMqSHxjhMh6pVHuqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RM/DvoFHxyK8mFGT0wAh00wiGwzb0Jv22HFh1jllQjeLB1/kBFJwee5/aZwOPkWjTel3nYkVzjAvvCAfhmfV0A7QWAcWGGMs26df9ztHTl2N4l2QobzJMuN+/q5U0WWFCJl5XT3Pfce7WaxKLYRxo526OZi4MiWjyn462d4BRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VUX8Jx4L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4X3aOQhd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VUX8Jx4L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4X3aOQhd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40F29211A1;
	Wed, 23 Apr 2025 06:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cYBWEiLQzaufA3S6O7pC+MKl8PAErNuwkkjhdxNGjs=;
	b=VUX8Jx4Ltj41ATT1yxYovlkQrGKBkx1+8eMVNUUQNAYXoH96TmEcPNblOTwYqrgYzjTAPC
	ugLrxBcLs7HhQInkX54aFOEwn21hPmSqKIpQzChWt/iKb6pN3K5b0SG7+/vSBMK9H5FKl6
	eMpvg/3b72G3iGECMGOmTSIRhB+xuk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cYBWEiLQzaufA3S6O7pC+MKl8PAErNuwkkjhdxNGjs=;
	b=4X3aOQhdLVzDaM5VMm9NOr8C1kfpqFd++TRBqcHQUCEOyEEpblq3IecReRQrtGtpfs1Qtm
	YQWGITmaFwu5VODg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VUX8Jx4L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4X3aOQhd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cYBWEiLQzaufA3S6O7pC+MKl8PAErNuwkkjhdxNGjs=;
	b=VUX8Jx4Ltj41ATT1yxYovlkQrGKBkx1+8eMVNUUQNAYXoH96TmEcPNblOTwYqrgYzjTAPC
	ugLrxBcLs7HhQInkX54aFOEwn21hPmSqKIpQzChWt/iKb6pN3K5b0SG7+/vSBMK9H5FKl6
	eMpvg/3b72G3iGECMGOmTSIRhB+xuk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cYBWEiLQzaufA3S6O7pC+MKl8PAErNuwkkjhdxNGjs=;
	b=4X3aOQhdLVzDaM5VMm9NOr8C1kfpqFd++TRBqcHQUCEOyEEpblq3IecReRQrtGtpfs1Qtm
	YQWGITmaFwu5VODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CD6913691;
	Wed, 23 Apr 2025 06:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XZs7CCeECGi7TAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Apr 2025 06:09:43 +0000
Message-ID: <d79a34e8-3d63-49d8-aba4-167d5b4223d4@suse.de>
Date: Wed, 23 Apr 2025 08:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] block: add a bio_add_vmalloc helper
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
 <20250422142628.1553523-4-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250422142628.1553523-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40F29211A1
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL94xbwdgyorksiizmbcmor9ro)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/22/25 16:26, Christoph Hellwig wrote:
> Add a helper to add a vmalloc region to a bio, abstracting away the
> vmalloc addresses from the underlying pages.  Also add a helper to
> calculate how many segments need to be allocated for a vmalloc region.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c         | 27 +++++++++++++++++++++++++++
>   include/linux/bio.h | 17 +++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

