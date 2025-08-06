Return-Path: <linux-fsdevel+bounces-56822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCBB1C051
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D8118A5743
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A721171D;
	Wed,  6 Aug 2025 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F+puW178";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WaaXPpGl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F+puW178";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WaaXPpGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4F1F4C9F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460508; cv=none; b=X9Y5VtXjQbEQ82dvBiSwz/Q7jivHoF6hU52Sivx3WUUU9Op1elgWxm23DimJsZaJrhxukG2g8s48Yq3zTpS8koWUXiURJqV2uiWiI7pDnkZcqVzwFTvUpcZ8SkHd+2AosC6/7FSQdrFaOnsTpEfI9jhMCv9YeXyV1Jw30bDQK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460508; c=relaxed/simple;
	bh=6/YFONmESefuzRDaOczVWNxTaeujlq4PdFb6ngHj+lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9GlPTVfwqUszND/Yvo4wmhkVxgHtrV8Xv0E+Fy4R3ViJslY46QwbR/0fKzgC5RpMIyRJ1zpGDfY6NUjTZ6pzcGsba46UZsq8czwyTE7YOn3Kzclkqix9Qh5b4756SoKE63p6KTL4inIcvj6lxapZrkwxydyOCMaX0NdivCFTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F+puW178; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WaaXPpGl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F+puW178; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WaaXPpGl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BCB11F393;
	Wed,  6 Aug 2025 06:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlj31V+I2rhAc2cuvPugTV5kP/JYxKPyx1/hsFGXsPg=;
	b=F+puW178aDq2ymOn5lTpg9gZQ9w1URg9MxHA6WFH8OwuXwHTh/7rVhUmp2Sytp+7JsmtHp
	TRhalZUDico0qYJfNI+wu7tnckyH4+aceeQpSY5Ux+20UANdRshMbLtgR3y77bvfJmMlph
	3KP78LLmYevhanPMxZYIYaFvGDMoiVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlj31V+I2rhAc2cuvPugTV5kP/JYxKPyx1/hsFGXsPg=;
	b=WaaXPpGlI8Wew8ZYzas/Q78zAIAQ5htEUUDwJr0zZLk88fRbhY0A7zelambiV6fKp57DWg
	uR728BXEcgYGAdCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlj31V+I2rhAc2cuvPugTV5kP/JYxKPyx1/hsFGXsPg=;
	b=F+puW178aDq2ymOn5lTpg9gZQ9w1URg9MxHA6WFH8OwuXwHTh/7rVhUmp2Sytp+7JsmtHp
	TRhalZUDico0qYJfNI+wu7tnckyH4+aceeQpSY5Ux+20UANdRshMbLtgR3y77bvfJmMlph
	3KP78LLmYevhanPMxZYIYaFvGDMoiVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlj31V+I2rhAc2cuvPugTV5kP/JYxKPyx1/hsFGXsPg=;
	b=WaaXPpGlI8Wew8ZYzas/Q78zAIAQ5htEUUDwJr0zZLk88fRbhY0A7zelambiV6fKp57DWg
	uR728BXEcgYGAdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD6113AB5;
	Wed,  6 Aug 2025 06:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qtLuM1jxkmivXAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Aug 2025 06:08:24 +0000
Message-ID: <37289ec1-998f-470e-b250-a507266db96e@suse.de>
Date: Wed, 6 Aug 2025 08:08:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 7/7] iov_iter: remove iov_iter_is_aligned
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-8-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250805141123.332298-8-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/5/25 16:11, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> No more callers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> ---
>   include/linux/uio.h |  2 -
>   lib/iov_iter.c      | 95 ---------------------------------------------
>   2 files changed, 97 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

