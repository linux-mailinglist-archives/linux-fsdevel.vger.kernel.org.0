Return-Path: <linux-fsdevel+bounces-42388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C3A4167D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 08:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0653AF456
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 07:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C431BC3C;
	Mon, 24 Feb 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m1spmCwf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BabmiIEP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IJxaAq2p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y8bf96hv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB841898ED
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383051; cv=none; b=FYxRPCOXIkPpG6BJbAj7+XAT7gI1yug6SR6h9PNtIHAYZ79hajUTO6JABS83HOxZPcmsWz3XlF7YdgewjV+XMQCnMEuVQZShxIaHu/jGR1fwnG5s6p/xxo/qWXC3WKUi9O+WazArRpeW5cTIdMcL6vvl59uab0kLYOOuqwESKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383051; c=relaxed/simple;
	bh=EXipg85uWZvkSImx0/5SzPw6cIZutn+VWVHdenJ6bTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFgwjA2YJY+rGit2xktZoLnPB5JgQn98RfFuLF2VzLV51FddwijN9bM1Ce47Up4sEV1l452NSRN9E5QV3CgQb5Na35YzMu/CS2wyn2aBgs3OmUDQbaY3K0yxxcjIkPvGbfT3XC8cRC4ybw/aIAIflISGsXY2kbDJlhum0pjW+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m1spmCwf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BabmiIEP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IJxaAq2p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y8bf96hv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEF7021171;
	Mon, 24 Feb 2025 07:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740383048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWXS8JmPOEyuTcSWXxAAIEFmUJk1QrnZ6ccr5EFg9zM=;
	b=m1spmCwfs7XNK/xA9cFjLwDZe+HsdFMuqEa4pkN+MGehEJZJtSQL6VDdX63dKpyvZYujxa
	/71gPQLGNnQu/aCbS/qQRWqkE6RqfVmggSLGN/1+AEe2B0fNnf43NN0BvyiTxXiodzCJGH
	W+VXV1wKV6u0mrntOjKRCJNWaLqYhLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740383048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWXS8JmPOEyuTcSWXxAAIEFmUJk1QrnZ6ccr5EFg9zM=;
	b=BabmiIEPgs4ysbQewC3UCd4Qg73P/gx5CbxtTcJVAKosCBrsNjWMvxd847TrEAXh7RILNx
	8xXUJ0MnaORg7BBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IJxaAq2p;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y8bf96hv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740383047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWXS8JmPOEyuTcSWXxAAIEFmUJk1QrnZ6ccr5EFg9zM=;
	b=IJxaAq2pgu8YU+W1MCKZDIrFaob9C67qUn0+dB3KATsoryuI22qTLO6I/yljXStod4Bklu
	EeteFNsysIVkf0dF6odCBhL30eLW6lAtLUPtsuH6lNWlqnhCDqkbmLwuMd9RrgOGK9lbel
	1aoubYrcwmgQ1K7ZnYCPZb+dCYaXcPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740383047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWXS8JmPOEyuTcSWXxAAIEFmUJk1QrnZ6ccr5EFg9zM=;
	b=y8bf96hvjfIDovcNjOZ82J0TsSB2vrvf6IlI7DQA2xoJ5ZJ++twfO41l0iGYSTjOHgcsxB
	FFivQo43wz3LB5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2426113707;
	Mon, 24 Feb 2025 07:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aQrkBkcjvGf1QwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Feb 2025 07:44:07 +0000
Message-ID: <934358f5-ec6b-41b6-ae2c-09e9fb10fbb1@suse.de>
Date: Mon, 24 Feb 2025 08:44:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
To: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
 akpm@linux-foundation.org, willy@infradead.org, dave@stgolabs.net,
 david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org
Cc: john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250221223823.1680616-1-mcgrof@kernel.org>
 <20250221223823.1680616-5-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250221223823.1680616-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEF7021171
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/21/25 23:38, Luis Chamberlain wrote:
> Convert mpage to folios and adjust accounting for the number of blocks
> within a folio instead of a single page. This also adjusts the number
> of pages we should process to be the size of the folio to ensure we
> always read a full folio.
> 
> Note that the page cache code already ensures do_mpage_readpage() will
> work with folios respecting the address space min order, this ensures
> that so long as folio_size() is used for our requirements mpage will
> also now be able to process block sizes larger than the page size.
> 
> Originally-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---by: H
>   fs/mpage.c | 42 +++++++++++++++++++++---------------------
>   1 file changed, 21 insertions(+), 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

