Return-Path: <linux-fsdevel+bounces-47041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB7A97EF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0491188A312
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F946264638;
	Wed, 23 Apr 2025 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F8cAso5q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+s19Z0kv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F8cAso5q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+s19Z0kv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D08266567
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388853; cv=none; b=MVjfecmnzPO2Zt+WxCSuKY7Ae27hdKh6B2cGgCofwFrmV//TdF1PPaB1v8pIAgmDxKaMX7DfxVuccrsM8fee+nR3YwRSKlYOfAOHzWo8O31WcYHIYRam3rh5pLdztkezHiwJkIAAcvn0wS2lQ3TxeWDY29M943PmuYhQFs8gmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388853; c=relaxed/simple;
	bh=pwmo35Kc1fWuu5GDx2NmfXVpfRLvnNEHE8iHLNzgBtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ts8F73ixzrSAnu2FmfffItf2XF8dDhfLJhsa4qWEs7RwRxfqYb3+H1JIflQIK0Q+xEVjWqYMp00W1vSivnQGi/weyyCC88mhGBFg61jY2zwXNYpfI6iKoNtJnEAWRkyyzrNxEUq0Q8Y9r8SgjRVSARxmK1T14JVTT6LaG4/4BCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F8cAso5q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+s19Z0kv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F8cAso5q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+s19Z0kv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E64D1F38D;
	Wed, 23 Apr 2025 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwrW2MxJC76CZWFRTLUaCgGNQLEQh1XVj/R+ebNcNyo=;
	b=F8cAso5qfqiF8lfWAjIcaGNRSc/yudVVAA2MFq4/VoHcJlDUtQq56skPKslelj07VY1NKL
	F8PvWu6Z27zrzQhPT2Xej/efWn/kAzoljI1j+LNxR+BAHYiv93Qqgqtw7CKjYhQTCk1TOt
	0c9Xz77+2cnPjcgjpHzwOOQUKCbXdkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwrW2MxJC76CZWFRTLUaCgGNQLEQh1XVj/R+ebNcNyo=;
	b=+s19Z0kvIHaA05FA/gZlTkg/tDLa86qY/56Vgn0ODeo/8KSLt4M57B71ZGQbdNyMKw8wPA
	RFr3L8p248yx0eCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F8cAso5q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+s19Z0kv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwrW2MxJC76CZWFRTLUaCgGNQLEQh1XVj/R+ebNcNyo=;
	b=F8cAso5qfqiF8lfWAjIcaGNRSc/yudVVAA2MFq4/VoHcJlDUtQq56skPKslelj07VY1NKL
	F8PvWu6Z27zrzQhPT2Xej/efWn/kAzoljI1j+LNxR+BAHYiv93Qqgqtw7CKjYhQTCk1TOt
	0c9Xz77+2cnPjcgjpHzwOOQUKCbXdkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwrW2MxJC76CZWFRTLUaCgGNQLEQh1XVj/R+ebNcNyo=;
	b=+s19Z0kvIHaA05FA/gZlTkg/tDLa86qY/56Vgn0ODeo/8KSLt4M57B71ZGQbdNyMKw8wPA
	RFr3L8p248yx0eCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470F013691;
	Wed, 23 Apr 2025 06:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oh4eDy+FCGj4TQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Apr 2025 06:14:07 +0000
Message-ID: <c6107977-c8c6-4a28-8b53-d4d4c8951a65@suse.de>
Date: Wed, 23 Apr 2025 08:14:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] block: simplify bio_map_kern
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
 <20250422142628.1553523-7-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250422142628.1553523-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E64D1F38D
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/22/25 16:26, Christoph Hellwig wrote:
> Split bio_map_kern into a simple version that can use bio_add_virt_nofail
> for kernel direct mapping addresses and a more complex bio_map_vmalloc
> with the logic to chunk up and map vmalloc ranges using the
> bio_add_vmalloc helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-map.c | 74 +++++++++++++++++++------------------------------
>   1 file changed, 29 insertions(+), 45 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

