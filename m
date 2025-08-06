Return-Path: <linux-fsdevel+bounces-56821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2828DB1C04D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6DD3A6C18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951E20E6E2;
	Wed,  6 Aug 2025 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GDIBCtZP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zqlPaUN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GDIBCtZP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zqlPaUN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63DB20B7F9
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460471; cv=none; b=h7ARAq4lCX3kjwAehkGw8mKSRm/3htAXEgFS8srph4MiR9TwrhNW9Z8l5dktuqRVPlSuR09FdT0eyNBIRhHtnDkxxb0dj8IxGEe1gHqy9B7HRXBK1FcxY3ELi7kKmWx/Yy2XrV264E5JOOwNjfRMzN4T7OJ6CbrZYq8zNQgcgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460471; c=relaxed/simple;
	bh=YEoXTgflyViWV+iE4UpuelYMtsDizsth8fz5HtDUXO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b51BRqavl6FZZzqndQj04FT34PqfxGZUZeUjLFceyVbANtHBiCnDdiZx68OA0pFBRzMzmS34X2N9E/+k1UTtntIiFAxPTSFh7Qqn+BValYDDTEgB6AJClcF51Kpif1bMN3GS4GgZAVAqDOqshVdgWFLBO6qym9C01kzIsltFpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GDIBCtZP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zqlPaUN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GDIBCtZP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zqlPaUN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21D382127A;
	Wed,  6 Aug 2025 06:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7qWzlczDYIRoOLhC1u4f/h/YuNrOxV11ZhWBvkGNo0=;
	b=GDIBCtZPiBNF2jIc0cBbfm55M+sqmJerbI9UXlckk3tTVzgL/j0mhBngJSRdJ0RNsDOGxy
	BxWDJbbzcfCNIyhADitxELI18MqlCqzFyzERMjyAkH68mhtP1LiUaP6sSVZx+7EB/5T63g
	i322k4Z5nJKfhGWe8A8SevXE7ZHl6qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7qWzlczDYIRoOLhC1u4f/h/YuNrOxV11ZhWBvkGNo0=;
	b=5zqlPaUNdax1P5kxuyU8h8ScHl0+9meCUkowCQuOgghXsmL5bHosZVw76qmZgcJD9UBMer
	INP4Fb6/4cT0bJAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7qWzlczDYIRoOLhC1u4f/h/YuNrOxV11ZhWBvkGNo0=;
	b=GDIBCtZPiBNF2jIc0cBbfm55M+sqmJerbI9UXlckk3tTVzgL/j0mhBngJSRdJ0RNsDOGxy
	BxWDJbbzcfCNIyhADitxELI18MqlCqzFyzERMjyAkH68mhtP1LiUaP6sSVZx+7EB/5T63g
	i322k4Z5nJKfhGWe8A8SevXE7ZHl6qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7qWzlczDYIRoOLhC1u4f/h/YuNrOxV11ZhWBvkGNo0=;
	b=5zqlPaUNdax1P5kxuyU8h8ScHl0+9meCUkowCQuOgghXsmL5bHosZVw76qmZgcJD9UBMer
	INP4Fb6/4cT0bJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73C9C13AB5;
	Wed,  6 Aug 2025 06:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QtUYGjPxkmiSXAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Aug 2025 06:07:47 +0000
Message-ID: <41ebc34d-9d9c-462a-93c2-95deb6aab811@suse.de>
Date: Wed, 6 Aug 2025 08:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/7] iomap: simplify direct io validity check
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-5-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250805141123.332298-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/5/25 16:11, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer checks all the segments for validity later, so no need
> for an early check. Just reduce it to a simple position and total length
> and defer the segment checks to the block layer.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   fs/iomap/direct-io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

