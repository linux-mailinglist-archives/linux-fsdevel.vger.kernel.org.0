Return-Path: <linux-fsdevel+bounces-23097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8B09270C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 09:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73401284510
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 07:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72601A254F;
	Thu,  4 Jul 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qaXQfcxg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HtuLcNHI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qaXQfcxg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HtuLcNHI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8B1482E8;
	Thu,  4 Jul 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078759; cv=none; b=F2cdeJ31gvJEASUnmabPGfVMXKT6q0ZYaasd2EOpIEqlUeG2NCzGy2USTcvbktIVAG4QXwJyF6chQyHmJYzZqGFhfgn1F/Ko3QAm4+1dTUYWKIzNx5LNuYakl3ICkwS1CMeEfPm8GYQ8dulTAE2I84OUsJ8J0pYIOcmnK3AP5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078759; c=relaxed/simple;
	bh=F24KkJLwPQYXk7vxe8vqLX6O1KAuxpNRaL1WRO/M1M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcsrMortidxUr59nFhYf2gDuXf0NVT74fg+YcTFJL96CJ2SkusaooExBlPRJ4EwYboeyrEuA1+xvyJ6+HwRiRVquhlaIdJwQzEEaFmLOXG+5Hlfo+8Szf5zhHQ408U4EzTYInk1WQj/5z5G9uaXDJU0uIQIRHumZjkUR0O2079I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qaXQfcxg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HtuLcNHI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qaXQfcxg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HtuLcNHI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CF6221990;
	Thu,  4 Jul 2024 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720078755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WNLRmPleVtl+fAz4qD+C2UqkheLv+LIaKAgdQTDh8VA=;
	b=qaXQfcxgjeDpVsGDbuWhatdUiMD5GddOcB8It02hjPXPVtOiTsoKMdL4/jZ8MOYEQ5Sdc/
	bZm3sy0Jhm3YbzhnnbxZriDj7ZnXmUN730PLseXb6ZMOYo2RdnEEWZ13Af3BQfGcRucLtB
	oVBuLWeNlKwfU2CENaZLBX8/2dgxNok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720078755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WNLRmPleVtl+fAz4qD+C2UqkheLv+LIaKAgdQTDh8VA=;
	b=HtuLcNHImQwn8QCjkVykYh35kGA1NQ3UMsMU47I7sOohMegIeqIxIBdv2NFlUcn1MjM66Q
	px3Q+4D/vVoYTPAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720078755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WNLRmPleVtl+fAz4qD+C2UqkheLv+LIaKAgdQTDh8VA=;
	b=qaXQfcxgjeDpVsGDbuWhatdUiMD5GddOcB8It02hjPXPVtOiTsoKMdL4/jZ8MOYEQ5Sdc/
	bZm3sy0Jhm3YbzhnnbxZriDj7ZnXmUN730PLseXb6ZMOYo2RdnEEWZ13Af3BQfGcRucLtB
	oVBuLWeNlKwfU2CENaZLBX8/2dgxNok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720078755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WNLRmPleVtl+fAz4qD+C2UqkheLv+LIaKAgdQTDh8VA=;
	b=HtuLcNHImQwn8QCjkVykYh35kGA1NQ3UMsMU47I7sOohMegIeqIxIBdv2NFlUcn1MjM66Q
	px3Q+4D/vVoYTPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A3E81369F;
	Thu,  4 Jul 2024 07:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dzqiEaNRhmbfNwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 04 Jul 2024 07:39:15 +0000
Message-ID: <a2d9d43b-9cc3-4668-8c87-46da90bd8752@suse.cz>
Date: Thu, 4 Jul 2024 09:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] MAINTAINERS: Add entry for new VMA files
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
 <7177e938f13dae3e44fd77d39f1f1b3e935e4908.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <7177e938f13dae3e44fd77d39f1f1b3e935e4908.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

On 7/3/24 1:57 PM, Lorenzo Stoakes wrote:
> The vma files contain logic split from mmap.c for the most part and are all
> relevant to VMA logic, so maintain the same reviewers for both.

But it's still related to mmap.c a lot, so why not just rename that existing
"MEMORY MAPPING" appropriately (how? haha) and expand it with the new files?

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 098d214f78d9..ff3e113ed081 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23971,6 +23971,19 @@ F:	include/uapi/linux/vsockmon.h
>  F:	net/vmw_vsock/
>  F:	tools/testing/vsock/
> 
> +VMA
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	https://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/vma.c
> +F:	mm/vma.h
> +F:	mm/vma_internal.h
> +
>  VMALLOC
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  R:	Uladzislau Rezki <urezki@gmail.com>
> --
> 2.45.2


