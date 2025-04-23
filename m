Return-Path: <linux-fsdevel+bounces-47040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE63A97EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF317AF1F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CB266EEC;
	Wed, 23 Apr 2025 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sYxDmXma";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mke3fO3X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sYxDmXma";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mke3fO3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408026657E
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388718; cv=none; b=eG00CW9Z+nKYlw+7m3vIhlDw+cGVzB6G0fP5XsJQEsZt07+6Y0ZG0CPsEBOhBsvxlPVvfyaEIJHT7hQgS2YNPRZm53Y2FAE18P7SsCFKekZKot9lvDu1ZeNP23+27c6ooFQy1n0GIqQaRuhO7US7ns3XFeIsjzo66hxI2xn0G/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388718; c=relaxed/simple;
	bh=qKUS0OlQh7ppxHqMaAhWemJAUL7OpG0YSFPVwG8yJ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg80PkWBFTpu3IvYktYQe6Ege6TrZoH+110OxROddhQJqNqusrv4nY8SU2m1bJvC+5Mmm/nkf9/WwfpSr9g6RguPKlxG4QQnnoxk8g0lqmpDL6dZLEa5PfztjMRU1IUmAh6CeSN95xcjC/OA5bMHiPjZJj8ZZRzXn1EeBQ+I80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sYxDmXma; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mke3fO3X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sYxDmXma; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mke3fO3X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 848AE2119B;
	Wed, 23 Apr 2025 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WM/715GO+KtGi/yh21KTSS8MdkQS2XPSn6dCto89PWU=;
	b=sYxDmXmahJQqiotSPS6/bKgP9/mKW0ygYLVY6VhplZM4JkfS+lABuzHzf/JIpMRT326eHa
	L69DwU7u3cuV73ZHzguAkIJz+KUmo7QX+hvu+RX9Iv48oBBJLVhae3PhxBudI39PeNhMbx
	2oXtvUTpC3gZyMK6T2g1w2U8TAayiHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WM/715GO+KtGi/yh21KTSS8MdkQS2XPSn6dCto89PWU=;
	b=Mke3fO3XMJhHMswkgSklhhaO8ivK4HnchcsVw+CPDWl56X0PLatLuiIOjjyXcfuzp3mxNG
	X+mjZW5x5XxyPBAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sYxDmXma;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Mke3fO3X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745388714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WM/715GO+KtGi/yh21KTSS8MdkQS2XPSn6dCto89PWU=;
	b=sYxDmXmahJQqiotSPS6/bKgP9/mKW0ygYLVY6VhplZM4JkfS+lABuzHzf/JIpMRT326eHa
	L69DwU7u3cuV73ZHzguAkIJz+KUmo7QX+hvu+RX9Iv48oBBJLVhae3PhxBudI39PeNhMbx
	2oXtvUTpC3gZyMK6T2g1w2U8TAayiHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745388714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WM/715GO+KtGi/yh21KTSS8MdkQS2XPSn6dCto89PWU=;
	b=Mke3fO3XMJhHMswkgSklhhaO8ivK4HnchcsVw+CPDWl56X0PLatLuiIOjjyXcfuzp3mxNG
	X+mjZW5x5XxyPBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DAA913691;
	Wed, 23 Apr 2025 06:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id we/dG6mECGhGTQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 23 Apr 2025 06:11:53 +0000
Message-ID: <93dfbbd5-04a2-41f2-89e0-7d1ed4de614f@suse.de>
Date: Wed, 23 Apr 2025 08:11:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] block: pass the operation to bio_{map,copy}_kern
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
 <20250422142628.1553523-6-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250422142628.1553523-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 848AE2119B
X-Spam-Score: -4.51
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,lst.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/22/25 16:26, Christoph Hellwig wrote:
> That way the bio can be allocated with the right operation already
> set and there is no need to pass the separated 'reading' argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-map.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

