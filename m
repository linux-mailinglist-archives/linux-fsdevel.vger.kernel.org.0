Return-Path: <linux-fsdevel+bounces-56621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711B5B19BD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD1318985C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4C235C17;
	Mon,  4 Aug 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="es9+hdOq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z3Jso8jA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="es9+hdOq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z3Jso8jA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479622AE5D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290661; cv=none; b=mBW5tDwuaxpe17fiROpyJWYtewPsQ1c9yrX2Dv1wsrO8heybofr6xbXLlfzeeCBm7HQQUcrp5VtxNgJrLdG0QBPHY3Ue7+vnGha+G7GuG2oOh3JhQ8656UuV1GHJzUkJGdF6noEg1lXG++d9bAyBP/4M4PY9Z/vwmD8XPxi7SQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290661; c=relaxed/simple;
	bh=Uj5ZRkHEm0UACOCSd3gdS+GFAoUQHBiQW3shxyZluxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXVEzNlrc6wt5QfCAL3hevDDsBE9vN2fTJzoM+08nQFgilVDa7lqgQdYW1W/VVAzWC9yRAHmOoPv+/eC9SBQyT5pS5AYplb2BUnFuPCzl+rfqg+duIkUSAmPrDswNEGuSaGs7hrxoAC6J2o7bXi9EOYKvxXm2eEkXHLeZ5rGBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=es9+hdOq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z3Jso8jA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=es9+hdOq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z3Jso8jA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2186219A6;
	Mon,  4 Aug 2025 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJb7cl3+kn8dQ4gPGIyphn6EVqjlHCwtPHJ/VLeWCmU=;
	b=es9+hdOq281jdc5shrTbYUgwIB2SvWpmcRoWCEzSjVQuS6Qjynlp7gU68Ac4YHgzsGTY2k
	Yc9jr/xudIL0QmMxCPdxFaQieOYdSAbS07Dp1Fn9VNnXHv/wc7vuVbwScD5VWYDI9/5Dax
	AHJSDHXoocyLP/lczpSg4zdX2rQ2KZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJb7cl3+kn8dQ4gPGIyphn6EVqjlHCwtPHJ/VLeWCmU=;
	b=z3Jso8jA+7D5qt8Fp7snD+nVaJhnwM84Z6+4LXJ4YKvEg4VKAHrVIYBQ4khSsErdBf7MWi
	UN7voyAxgpBjIVCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJb7cl3+kn8dQ4gPGIyphn6EVqjlHCwtPHJ/VLeWCmU=;
	b=es9+hdOq281jdc5shrTbYUgwIB2SvWpmcRoWCEzSjVQuS6Qjynlp7gU68Ac4YHgzsGTY2k
	Yc9jr/xudIL0QmMxCPdxFaQieOYdSAbS07Dp1Fn9VNnXHv/wc7vuVbwScD5VWYDI9/5Dax
	AHJSDHXoocyLP/lczpSg4zdX2rQ2KZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJb7cl3+kn8dQ4gPGIyphn6EVqjlHCwtPHJ/VLeWCmU=;
	b=z3Jso8jA+7D5qt8Fp7snD+nVaJhnwM84Z6+4LXJ4YKvEg4VKAHrVIYBQ4khSsErdBf7MWi
	UN7voyAxgpBjIVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 786B3133D1;
	Mon,  4 Aug 2025 06:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fctAG+BZkGi2UAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 06:57:36 +0000
Message-ID: <29b3e0ae-a0df-4856-9a15-ec515bf7ad8e@suse.de>
Date: Mon, 4 Aug 2025 08:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] block: remove bdev_iter_is_aligned
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-6-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801234736.1913170-6-kbusch@meta.com>
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

On 8/2/25 01:47, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> No more callers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   include/linux/blkdev.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

