Return-Path: <linux-fsdevel+bounces-56619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9214BB19BC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72761776E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BE234973;
	Mon,  4 Aug 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nuY15u1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kOmhScM6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nuY15u1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kOmhScM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648672288CB
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290540; cv=none; b=daW/TokgUUAmuDLzvV9ncMsxCti1X98bLPOvAOchIngB0AeyUpT+OQi1DPUNLGHFt8Bs5yxYQ7lsrc+4WawgdzP1F5D+qw6GItOzgiw8YoXFC6PU8vBBJjCIYyt9Kp4LwtKwBe5bvfJgH6dZaDshqV3DpRrzmXvpPSbppjqS6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290540; c=relaxed/simple;
	bh=Ct3jNBBThk50ZJdJbUD3vzhuai/eG6JlXBH/SWctZh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4fIYmmkh0dWpDUWjyTusd+R0LQ78kG/y0ES/J9ol8xbS+QOkpHmHwud4lWXMnuMRWzut0VZWoxApEQCHAcfE3jMLf4GAqkv14dxkEIiZps7o5SoOcp82nuuVits6uzjphlF+r4gQaOPCVX4A8buKRJOo8ik6N5m59HhPdEKOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nuY15u1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kOmhScM6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nuY15u1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kOmhScM6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3D75219A7;
	Mon,  4 Aug 2025 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVFftAvBOhL7ZrrJRYuM8mD94HM8PtnBRYuCxscK5Rc=;
	b=nuY15u1QOey4X4pl6Jr6HYmk/ZbnFHxRasMmK+L4H0J9njulsDZs9EDRjHVJqVjdPelQ+/
	9NTtNETfd2328pqotHfnTgiaWeh++DgZz1XUwQQH+l2nPHvshbDTNzdXWs6IxmUeWNgNtU
	TpLYGObv6oB1w78scMD4+WmB1LexCIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVFftAvBOhL7ZrrJRYuM8mD94HM8PtnBRYuCxscK5Rc=;
	b=kOmhScM6VY610ObYA8AADHIqVAVvak5R69NtNCUuyDBT+mkHB+F/TsHyoxl0kqHrHJHrNz
	XDe2idxpNLpsG9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVFftAvBOhL7ZrrJRYuM8mD94HM8PtnBRYuCxscK5Rc=;
	b=nuY15u1QOey4X4pl6Jr6HYmk/ZbnFHxRasMmK+L4H0J9njulsDZs9EDRjHVJqVjdPelQ+/
	9NTtNETfd2328pqotHfnTgiaWeh++DgZz1XUwQQH+l2nPHvshbDTNzdXWs6IxmUeWNgNtU
	TpLYGObv6oB1w78scMD4+WmB1LexCIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVFftAvBOhL7ZrrJRYuM8mD94HM8PtnBRYuCxscK5Rc=;
	b=kOmhScM6VY610ObYA8AADHIqVAVvak5R69NtNCUuyDBT+mkHB+F/TsHyoxl0kqHrHJHrNz
	XDe2idxpNLpsG9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 607BE133D1;
	Mon,  4 Aug 2025 06:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ltj6FWhZkGgdUAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 06:55:36 +0000
Message-ID: <065d699a-1edb-4712-9857-021c58c5e5c2@suse.de>
Date: Mon, 4 Aug 2025 08:55:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] block: simplify direct io validity check
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-4-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801234736.1913170-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/2/25 01:47, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer checks all the segments for validity later, so no need
> for an early check. Just reduce it to a simple position and total length
> and defer the segment checks to the block layer.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/fops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 82451ac8ff25d..820902cf10730 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -38,8 +38,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
>   static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
>   				struct iov_iter *iter)
>   {
> -	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
> -		!bdev_iter_is_aligned(bdev, iter);
> +	return (iocb->ki_pos | iov_iter_count(iter)) &
> +			(bdev_logical_block_size(bdev) - 1);

Bitwise or? Sure?

>   }
>   
>   #define DIO_INLINE_BIO_VECS 4

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

