Return-Path: <linux-fsdevel+bounces-47036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB8A97EA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A017F640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030B91BD517;
	Wed, 23 Apr 2025 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CmTl5vO3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j3xXW7/z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CmTl5vO3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j3xXW7/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A401C8631
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388360; cv=none; b=jUIqbl73MG3YnSQ0F71xSNBWGt1YJ49wecoImvCn3Eo4csZsxXEbp7Q0oa+lWT2O2lYIS6jE6BTDP6W/TDpUtFwIWPVwB3Cn203lUzz2+NI/FJhstXS0lvaaROfUZIHq7kgj9m5AVbe88/W7MSBumJ7h/XTAHyyVM2pFVh6Z2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388360; c=relaxed/simple;
	bh=GYzMHLcAsVWzyWn3po2G26RuijsKguDyw9DQZzgjWQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed+m3OFmWc9H2ro9upMWjb87LEaVTKaAVTB8IygDCh6Wg6Uq0fDOPq3v/7aIAkRWKoBmUIwykki0py1ww4pcLhWWuGbQQQ06wqfgklVHs2GC6k1Uyac98uCvfad3ANbrxfak1iiLYOSLv9vS9K1o1/C0HqizEydPlegYrMW+fIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CmTl5vO3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j3xXW7/z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CmTl5vO3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j3xXW7/z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80BB31F38D;
	Wed, 23 Apr 2025 06:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkzb5x8KFVWrmch90shf5Lt4wD8+BB40ntGSkZkdBzM=;
	b=CmTl5vO3dxQW9RSc/336cz1fh0uZ+Kg4+K0acCigDMBg7VpjlT1RpgXh92XW4kfTNn91C5
	uQs9nCX/ydFdhjGKL+NUu0cGeS1KnpljFLnJGs4d6AXx4r9VlTYUNy1JGOBcq7FOVBIXar
	yPLguBBogvP0MHmmKTwxOuAH54lvusE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkzb5x8KFVWrmch90shf5Lt4wD8+BB40ntGSkZkdBzM=;
	b=j3xXW7/z2Ton30OQVWplDQcCwDFad7mIt5H3jpq1faEPWa5W6V3y5/IstHTl4Fm64MXxbz
	P6Ugc0vJJODcabBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkzb5x8KFVWrmch90shf5Lt4wD8+BB40ntGSkZkdBzM=;
	b=CmTl5vO3dxQW9RSc/336cz1fh0uZ+Kg4+K0acCigDMBg7VpjlT1RpgXh92XW4kfTNn91C5
	uQs9nCX/ydFdhjGKL+NUu0cGeS1KnpljFLnJGs4d6AXx4r9VlTYUNy1JGOBcq7FOVBIXar
	yPLguBBogvP0MHmmKTwxOuAH54lvusE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkzb5x8KFVWrmch90shf5Lt4wD8+BB40ntGSkZkdBzM=;
	b=j3xXW7/z2Ton30OQVWplDQcCwDFad7mIt5H3jpq1faEPWa5W6V3y5/IstHTl4Fm64MXxbz
	P6Ugc0vJJODcabBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8588E13691;
	Wed, 23 Apr 2025 06:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iZOvHkODCGi+SwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Apr 2025 06:05:55 +0000
Message-ID: <8ec98935-fac7-44d1-a9ba-d5d8688bcf4a@suse.de>
Date: Wed, 23 Apr 2025 08:05:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] block: add a bio_add_virt_nofail helper
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
 <20250422142628.1553523-2-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250422142628.1553523-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL4dj9zzjoqkf1d3y4dfoejhya)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/22/25 16:26, Christoph Hellwig wrote:
> Add a helper to add a directly mapped kernel virtual address to a
> bio so that callers don't have to convert to pages or folios.
> 
> For now only the _nofail variant is provided as that is what all the
> obvious callers want.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/bio.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

