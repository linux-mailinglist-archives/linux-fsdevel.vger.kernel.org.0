Return-Path: <linux-fsdevel+bounces-19872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8F8CA866
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 09:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A613A1F22449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0044C3C3;
	Tue, 21 May 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lkYoiFQK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LzZM6u+0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lkYoiFQK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LzZM6u+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C783FB8B;
	Tue, 21 May 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275209; cv=none; b=iz4G1tQQaSVfUR3cCVApSiIJ3h+y03sBss2fs2fHpM9UmXV9Mafq4u90iu+5ittYy1K5jLMUUTj0A2IZhNk9yxQW3GxUaWdLxZkIc3atrFtwfgXL68Vh+qs37tgOTuwP7llAj1u8kaXF2XR6/ZiAI3zNT0PWMN+PTcA/QUdJJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275209; c=relaxed/simple;
	bh=2ZY/PSAzoW1ZOz6dI6RDJtEq54XyjN4jqvcdtBtMkYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMsN97qy2nmaD3XMEN3o9nuD6Lb5pb0WSzpHWA7W7EC+eSto9TVsovLdN2tlHpUOBOHIQu6JeD/LytVivZ1fN4y+5dD2+PAUVGNBgWRVWPnJlEp33Lfi1lyXAWeWO4a4B72S1LhG/j1/nZ48zYyqyhlQLub/SQXwNUXpZrjZuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lkYoiFQK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LzZM6u+0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lkYoiFQK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LzZM6u+0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 303545BF13;
	Tue, 21 May 2024 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716275205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+x/MszspGfaxPeUMNwt99V1Aq3KDkqnswX/iPLB774=;
	b=lkYoiFQKZmKC+ZXYy1QE+LlPKIKD6HPyZi7R4V0VCniW9Z3jYQlGvB8AlItyWFTUH0vhvk
	kx7xgT5zz6jCbuxC5/t6L8S5Jx66CtUqWJMljoRTuR5ECeDMXdYGwhAppk161LFPtGBkYH
	ydWcq1NIn/G3os7CarT8KbKE9zKqock=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716275205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+x/MszspGfaxPeUMNwt99V1Aq3KDkqnswX/iPLB774=;
	b=LzZM6u+0gBsii5yIjl6R2k1CYDzZkOJUHm4SONegMmAuPbmVe7T1o/K3urJMWXKHZPMhtG
	NjKWll4f87/0bcAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lkYoiFQK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LzZM6u+0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716275205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+x/MszspGfaxPeUMNwt99V1Aq3KDkqnswX/iPLB774=;
	b=lkYoiFQKZmKC+ZXYy1QE+LlPKIKD6HPyZi7R4V0VCniW9Z3jYQlGvB8AlItyWFTUH0vhvk
	kx7xgT5zz6jCbuxC5/t6L8S5Jx66CtUqWJMljoRTuR5ECeDMXdYGwhAppk161LFPtGBkYH
	ydWcq1NIn/G3os7CarT8KbKE9zKqock=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716275205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+x/MszspGfaxPeUMNwt99V1Aq3KDkqnswX/iPLB774=;
	b=LzZM6u+0gBsii5yIjl6R2k1CYDzZkOJUHm4SONegMmAuPbmVe7T1o/K3urJMWXKHZPMhtG
	NjKWll4f87/0bcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3095B13A1E;
	Tue, 21 May 2024 07:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7vEPCgRITGZpZgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 May 2024 07:06:44 +0000
Message-ID: <cf6929e1-0dea-4216-bbc5-c00d963372f7@suse.de>
Date: Tue, 21 May 2024 09:06:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 04/12] block: add emulation for copy
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb@epcas5p1.samsung.com>
 <20240520102033.9361-5-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240520102033.9361-5-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 303545BF13
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 5/20/24 12:20, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is
> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination.
> At present in kernel user of emulation is fabrics.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   block/blk-lib.c        | 223 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/blkdev.h |   4 +
>   2 files changed, 227 insertions(+)
> 
Again, I'm not sure if we need this.
After all, copy offload _is_optional, so we need to be prepared to 
handle systems where it's not supported. In the end, the caller might
decide to do something else entirely; having an in-kernel emulation 
would defeat that.
And with adding an emulation to nullblk we already have an emulation
target to try if people will want to start experimenting.
So I'd rather not have this but rather let the caller deal with the
fact that copy offload is optional.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


