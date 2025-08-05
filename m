Return-Path: <linux-fsdevel+bounces-56726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A6B1AEF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334AC3A4F44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 06:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598C222560;
	Tue,  5 Aug 2025 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BSag1495";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jvVFDhYZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BSag1495";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jvVFDhYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E121FF2D
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377031; cv=none; b=B4MVGJOmH7ZjEFL5CGMkgD9OtrACozsi/idow9ESqwIzxpij0H+mBSVZZxiGkE226XGW/hIWWn3ZbuMGIAdGPH0CifZQeTR0zbsQJzeSwkzWnHahWy/iKIeJ0QZzwIPPBdX5IH5oBpqyfHPCHGejdabIRhB7nMjVUzRL7pkrpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377031; c=relaxed/simple;
	bh=sDRX3GOjzOFyJb1hlVaivfs0JLjbEAu6B/QAgvN7xcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPJVU55nJUGN2caXcHIGJ4nZ1PTYS7Cih1myUPIW16IXl/n/IiWg+FDVVEqsIZ2COmLQLzOiwwWXUEE5KE/SjfPhY0WYHEdD4tKzrWnXbgJsgJr8pOUYASjbCUAapHhjXgTFE93aSrBGjnWmI6pmRSX4MTWen7OLTim4MPEuZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BSag1495; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jvVFDhYZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BSag1495; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jvVFDhYZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AB521F387;
	Tue,  5 Aug 2025 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754377028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zAwcp48BVfi3+ZkJLuJVyOnVo+XL9a5AEOTUrphLlA=;
	b=BSag14956rIhHiFVrk7o5VkFqLAHmxWvu54bueoc8d/9/1z01hqtFLRVtRLr7sEatn8nzV
	+Bel1mxxVk7o5BipgWoOQGtAP4ajC+ZAySUx2g+dsXJ+z0RDxe9tyeR/sfJbZkrnqY7q8l
	2cTouLLQR+nj6CRhU3HSEox5k9zv8tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754377028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zAwcp48BVfi3+ZkJLuJVyOnVo+XL9a5AEOTUrphLlA=;
	b=jvVFDhYZ05QZ6tLktuNYkrzTIfNe3L/EVvkQ0Oq7H88Hd+DZTuxMd4V1fj0Utq1LGby4ju
	dvUlgA1iasLFHtBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754377028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zAwcp48BVfi3+ZkJLuJVyOnVo+XL9a5AEOTUrphLlA=;
	b=BSag14956rIhHiFVrk7o5VkFqLAHmxWvu54bueoc8d/9/1z01hqtFLRVtRLr7sEatn8nzV
	+Bel1mxxVk7o5BipgWoOQGtAP4ajC+ZAySUx2g+dsXJ+z0RDxe9tyeR/sfJbZkrnqY7q8l
	2cTouLLQR+nj6CRhU3HSEox5k9zv8tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754377028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zAwcp48BVfi3+ZkJLuJVyOnVo+XL9a5AEOTUrphLlA=;
	b=jvVFDhYZ05QZ6tLktuNYkrzTIfNe3L/EVvkQ0Oq7H88Hd+DZTuxMd4V1fj0Utq1LGby4ju
	dvUlgA1iasLFHtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E2E213A50;
	Tue,  5 Aug 2025 06:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ly76CUSrkWjHFwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 05 Aug 2025 06:57:08 +0000
Message-ID: <8c56e9f5-9e82-4a79-aa82-49099c1dda71@suse.de>
Date: Tue, 5 Aug 2025 08:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] block: simplify direct io validity check
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-4-kbusch@meta.com>
 <065d699a-1edb-4712-9857-021c58c5e5c2@suse.de> <aJDppvHXW8rspmVx@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aJDppvHXW8rspmVx@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/4/25 19:11, Keith Busch wrote:
> On Mon, Aug 04, 2025 at 08:55:36AM +0200, Hannes Reinecke wrote:
>> On 8/2/25 01:47, Keith Busch wrote:
>>>    static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
>>>    				struct iov_iter *iter)
>>>    {
>>> -	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
>>> -		!bdev_iter_is_aligned(bdev, iter);
>>> +	return (iocb->ki_pos | iov_iter_count(iter)) &
>>> +			(bdev_logical_block_size(bdev) - 1);
>>
>> Bitwise or? Sure?
> 
> Yep, this is correct. We need to return an error if either the size or
> offset are not aligned to the block size. "Or"ing the two together gets
> us a single check against the logical block size mask instead of doing
> each individually.

Oh, my. Wasn't aware that we're running an obfuscated C-contest ...

Anyway.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

