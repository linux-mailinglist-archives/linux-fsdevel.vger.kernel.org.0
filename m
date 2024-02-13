Return-Path: <linux-fsdevel+bounces-11379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F94785342D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AE61C27BE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F2A5DF1D;
	Tue, 13 Feb 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="amNn2S+6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ew4JhEA5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="amNn2S+6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ew4JhEA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1E56763;
	Tue, 13 Feb 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836591; cv=none; b=IAyLJCewdDGzc15Ch9LcUwX2QlKLMUd+Oy6aAo4Nbnyq8FDui5TBkadO1XBiNAr1BcPGAaz7cunaiwRLZ2XHEhXdvsC3Xt6Ej/KBXtb4MKigeGyftETNP5GGWerdDbzr156F/iFaMofPZSUlJLp6oNHCmhTRehFC3/oiL84NbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836591; c=relaxed/simple;
	bh=rxk0KyQWVjZoaN8wPKSKIZm8r5uFKZq672KgMX9dO2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV46NpnNKsYM7TLsmEG5T43QExmt5csgnCj8uIqW1bFcc/KRrTaSacsB948D0y4LeZ6bbitO0nt/FCH9oMzX7KNhZSWsSgu/CLygHgTBCf6JGtN4Ci+b64QUc25lcgkwJ01Sy1OhgkDjp9kxQ3HUBd8coBZjlZQMvR5BgXJUSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=amNn2S+6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ew4JhEA5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=amNn2S+6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ew4JhEA5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33EA121AFD;
	Tue, 13 Feb 2024 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDOFs0WO1Kh3sGEuSHtoM1IiBCKCvcC5tKE9PnzxSAc=;
	b=amNn2S+6fYUzk/ySzOvwbGH6bpgFqShjzqcZJkw046F3fn4x8reO1VIiATftIeOi7hao1M
	qb1ubQIJdJDp/OdU9SONWI/wxVgQG7AU0EGVfYappjYNwoEs+bS8sI02O3tjZtWw/lyQS+
	mqxYlxQoM9iOuAEPeaBE4kmcz6rGJgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDOFs0WO1Kh3sGEuSHtoM1IiBCKCvcC5tKE9PnzxSAc=;
	b=ew4JhEA54qq0tfcfRb84zmgW6AF8QZlNFASFRszuzB9FDZ1BsMWZwKyLeeHqD14ZDfU6+R
	JkGU7pvmkxt5TABA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDOFs0WO1Kh3sGEuSHtoM1IiBCKCvcC5tKE9PnzxSAc=;
	b=amNn2S+6fYUzk/ySzOvwbGH6bpgFqShjzqcZJkw046F3fn4x8reO1VIiATftIeOi7hao1M
	qb1ubQIJdJDp/OdU9SONWI/wxVgQG7AU0EGVfYappjYNwoEs+bS8sI02O3tjZtWw/lyQS+
	mqxYlxQoM9iOuAEPeaBE4kmcz6rGJgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDOFs0WO1Kh3sGEuSHtoM1IiBCKCvcC5tKE9PnzxSAc=;
	b=ew4JhEA54qq0tfcfRb84zmgW6AF8QZlNFASFRszuzB9FDZ1BsMWZwKyLeeHqD14ZDfU6+R
	JkGU7pvmkxt5TABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E774813404;
	Tue, 13 Feb 2024 15:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AM5kNquEy2VlMwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 15:03:07 +0000
Message-ID: <6fc4adcd-c7a3-4ca3-b309-13b484e75d12@suse.de>
Date: Tue, 13 Feb 2024 16:03:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 09/14] mm: Support order-1 folios in the page cache
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-10-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-10-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=amNn2S+6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ew4JhEA5
X-Spamd-Result: default: False [-0.35 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.05)[60.49%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.35
X-Rspamd-Queue-Id: 33EA121AFD
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Folios of order 1 have no space to store the deferred list.  This is
> not a problem for the page cache as file-backed folios are never
> placed on the deferred list.  All we need to do is prevent the core
> MM from touching the deferred list for order 1 folios and remove the
> code which prevented us from allocating order 1 folios.
> 
> Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/huge_mm.h |  7 +++++--
>   mm/filemap.c            |  2 --
>   mm/huge_memory.c        | 23 ++++++++++++++++++-----
>   mm/internal.h           |  4 +---
>   mm/readahead.c          |  3 ---
>   5 files changed, 24 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



