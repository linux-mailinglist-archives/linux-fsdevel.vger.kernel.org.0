Return-Path: <linux-fsdevel+bounces-43215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9928A4F7C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 08:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A71888F9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F361EA7F8;
	Wed,  5 Mar 2025 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QznafEv+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MBszmnW6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w6ZRFLk2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L6o3xhB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A681DE4EC
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159114; cv=none; b=ldSphNc6vlXdQfuznDdN++VkpnQnJ2PKCFBYaUPFgqrp7JIj7Hdwe0z6HKx6rYR0/Av3xft9/QYRDeuKuZvTM+NmQk7EfIPl1F2Rj/KIS4gM6j1koshLuC4JMpg0wG3g7AFUx9D0S06kBpV1N4xMfTUJY3hloNpLvIZ1uoTAy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159114; c=relaxed/simple;
	bh=7u1YqTcyeJXlmqAXzMP3SO3Bin2qzZsFYkFcXJ9kl+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkQJMs7sso6Z8/K3TBmtZDpyi0j6wm7fAkAr04e8rV888MlJ1ho+kepZs6+VvBbCMJfbBrEGZC5T7LTTl4SJOzm8RY4bHImsVoUtQWO/nrZoHQ3AEUPypoytUjyDXxHC0u0V8yf0qLxx7agRp5Hu2U0/BTh2HZ8JV77X+/xX/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QznafEv+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MBszmnW6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w6ZRFLk2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L6o3xhB+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD7DD1F38A;
	Wed,  5 Mar 2025 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741159111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggCM6iIwRGwJc80xu0g1Bp7a+92pIfiEEUnJ4UBDAM=;
	b=QznafEv+SRXFU699kRk6pO2U1HHOLeBm7OXSr7Yt5g+EjQlwngsWg7QHNhWZQ7TK+5oH/m
	5DDNGJF3/5MIZ80eMEyR1hFSCjx+yWP7RKceAko4bXTNTy2M4yasTIqy58zeXpke5gMwsU
	YuVrRh4G9fh6GDB+loNs5wnxQK4SiJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741159111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggCM6iIwRGwJc80xu0g1Bp7a+92pIfiEEUnJ4UBDAM=;
	b=MBszmnW6EXeDwskWYdg6HcMlM93Y1UHxfw9G4ra9JzTYW8k5ot1u9bnfwlwQ/nof69wZcR
	BwHLnoUYTrPwZvDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741159110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggCM6iIwRGwJc80xu0g1Bp7a+92pIfiEEUnJ4UBDAM=;
	b=w6ZRFLk2EeMWUm+DTOtmneSV31+s73CuypZKSvr2y/UDzZZZhhpX5AqPDp8ABZjkzmd+kx
	syDvL1FV8au3qHvoj1Ms4qV78RZm3by0osQ+C4ZRickK8aX/Ghw9PKB0OCsyAkQlq8mnSZ
	UveInMCv0Nrsu3lJMHl3Dt/vxB6vE4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741159110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mggCM6iIwRGwJc80xu0g1Bp7a+92pIfiEEUnJ4UBDAM=;
	b=L6o3xhB+VQswqzNd1pf3ImfmR7d7kwB4aT7hGas2H7mlMxoY2BqF9AUjhaPFiR4au6LWG/
	/dBj2qC/fMZM4CDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A37F13939;
	Wed,  5 Mar 2025 07:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S9bqC8b6x2cBRQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Mar 2025 07:18:30 +0000
Message-ID: <828e529d-3e42-4b9e-a0ce-a05516a7274d@suse.de>
Date: Wed, 5 Mar 2025 08:18:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
To: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
 willy@infradead.org, david@fromorbit.com, djwong@kernel.org
Cc: kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
 ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com,
 da.gomez@samsung.com, kernel@pankajraghav.com,
 Kent Overstreet <kent.overstreet@linux.dev>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250305015301.1610092-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,lst.de,gmail.com,vger.kernel.org,samsung.com,pankajraghav.com,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/5/25 02:53, Luis Chamberlain wrote:
> The commit titled "block/bdev: lift block size restrictions to 64k"
> lifted the block layer's max supported block size to 64k inside the
> helper blk_validate_block_size() now that we support large folios.
> However in lifting the block size we also removed the silly use
> cases many filesystems have to use sb_set_blocksize() to *verify*
> that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> happen in-kernel given mkfs utilities *can* create for example an
> ext4 32k block size filesystem on x86_64, the issue we want to prevent
> is mounting it on x86_64 unless the filesystem supports LBS.
> 
> While, we could argue that such checks should be filesystem specific,
> there are much more users of sb_set_blocksize() than LBS enabled
> filesystem on linux-next, so just do the easier thing and bring back
> the PAGE_SIZE check for sb_set_blocksize() users.
> 
> This will ensure that tests such as generic/466 when run in a loop
> against say, ext4, won't try to try to actually mount a filesystem with
> a block size larger than your filesystem supports given your PAGE_SIZE
> and in the worst case crash.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Christian, a small fixup for a crash when running generic/466 on ext4
> in a loop. The issue is obvious, and we just need to ensure we don't
> break old filesystem expectations of sb_set_blocksize().
> 
> This still allows XFS with 32k block size and I even tested with XFS
> with 32k block size and a 32k sector size set.
> 
>   block/bdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3bd948e6438d..de9ebc3e5d15 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -181,7 +181,7 @@ EXPORT_SYMBOL(set_blocksize);
>   
>   int sb_set_blocksize(struct super_block *sb, int size)
>   {
> -	if (set_blocksize(sb->s_bdev_file, size))
> +	if (size > PAGE_SIZE || set_blocksize(sb->s_bdev_file, size))
>   		return 0;
>   	/* If we get here, we know size is validated */
>   	sb->s_blocksize = size;

Can you add a comment stating why it's needed, even with LBS?
It's kinda non-obious, and we don't want to repeat the mistake
in the future.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

