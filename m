Return-Path: <linux-fsdevel+bounces-71006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B3CAF30E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 08:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 908583028DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 07:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CEB27E05A;
	Tue,  9 Dec 2025 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ArPWOzqr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+9kVsrjw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ArPWOzqr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+9kVsrjw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62519644B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266361; cv=none; b=HDmB5e0eUorc7bd2kx8ux+oPcUbBVOE6Z+HvDa6rcdvQwkTQCwlBuaFkaMG/52pg8Ts3kR8dsziwl6jk4pYpluJqNp8PCKlPnct/APmXFaX0N3uT8v+DLeYsxw/2jzuojh0/az0PJm7q89aNwgotd5Q/KLGdUC0PVbJGHLi4ndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266361; c=relaxed/simple;
	bh=vZmQQgQSfgYj39NR2qr1EGajAHIMTsQUDFbMNxPigKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbZboDjc7OWSUI1eyTjd8N7SrcGJ+sazB02nlNiPMkTzneQNQFNAje73btPNtgLdYDJI7uO8mt4WIkY6+5UuyFOCsdFYCGKthY5qoVhZ0C9M6CM/m5VP0TlM5h5Fk4ElqwGyxM3DXO6P3PQLR6GugI6zvtMt3+z0mJXTqcDhNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ArPWOzqr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+9kVsrjw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ArPWOzqr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+9kVsrjw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B4DA336F2;
	Tue,  9 Dec 2025 07:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765266358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyUMGUr5q6ydWbAZ/XOXlO9x9TXtSajw6bYZWYBs7sI=;
	b=ArPWOzqry+T5cOS2iVikGeqNVXifulv3jUvAKUVogE31EuolkmsjeMRLXsTaBOxwGZMcUc
	qpG8YvMRqQwec8zTBAGOMcP5J2AKV4dYpaOHriBSquVSOKEaBShD9pzx1FYgcHwvb1m7EA
	H0Ybd2V+4thyBWZGDjsksnWInyJrXB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765266358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyUMGUr5q6ydWbAZ/XOXlO9x9TXtSajw6bYZWYBs7sI=;
	b=+9kVsrjwBaPQ2mHtRbMqwr/v/yNzgQ1UlvsY4jHxYThD4kSrVmtqxCUNCU77H5BoOUIpuW
	C5fivGV17pWnFSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765266358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyUMGUr5q6ydWbAZ/XOXlO9x9TXtSajw6bYZWYBs7sI=;
	b=ArPWOzqry+T5cOS2iVikGeqNVXifulv3jUvAKUVogE31EuolkmsjeMRLXsTaBOxwGZMcUc
	qpG8YvMRqQwec8zTBAGOMcP5J2AKV4dYpaOHriBSquVSOKEaBShD9pzx1FYgcHwvb1m7EA
	H0Ybd2V+4thyBWZGDjsksnWInyJrXB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765266358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyUMGUr5q6ydWbAZ/XOXlO9x9TXtSajw6bYZWYBs7sI=;
	b=+9kVsrjwBaPQ2mHtRbMqwr/v/yNzgQ1UlvsY4jHxYThD4kSrVmtqxCUNCU77H5BoOUIpuW
	C5fivGV17pWnFSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D36D23EA63;
	Tue,  9 Dec 2025 07:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V+H0H63TN2nFWQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Dec 2025 07:45:49 +0000
Message-ID: <d395cf62-2066-4965-87e6-823a7bbde775@suse.de>
Date: Tue, 9 Dec 2025 08:45:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/3] filemap: set max order to be min order if THP is
 disabled
To: Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Michal Hocko <mhocko@suse.com>, Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, kernel@pankajraghav.com,
 tytso@mit.edu
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <20251206030858.1418814-2-p.raghav@samsung.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251206030858.1418814-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.848];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.27

On 12/6/25 04:08, Pankaj Raghav wrote:
> Large folios in the page cache depend on the splitting infrastructure from
> THP. To remove the dependency between large folios and
> CONFIG_TRANSPARENT_HUGEPAGE, set the min order == max order if THP is
> disabled. This will make sure the splitting code will not be required
> when THP is disabled, therefore, removing the dependency between large
> folios and THP.
> 
The description is actually misleading.
It's not that you remove the dependency from THP for large folios
_in general_ (the CONFIG_THP is retained in this patch).
Rather you remove the dependency for large folios _for the block layer_.
And that should be make explicit in the description, otherwise the
description and the patch doesn't match.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

