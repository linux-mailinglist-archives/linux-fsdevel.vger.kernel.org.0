Return-Path: <linux-fsdevel+bounces-19871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E48CA850
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 09:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBE3B21E25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEA44AEF0;
	Tue, 21 May 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yH2f3qVG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+CrOKUZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yH2f3qVG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+CrOKUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8D1E876;
	Tue, 21 May 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274921; cv=none; b=Cfn/SeNyqwWmpxAQ1ChqxqSPzv/sWA2KW+1v/NKYkI7SVGQkFgxX3KpUfVmtA+geqzSUBHUQI+DLLVXOHBw+5xkMXLwS71lpbbVuloo+kFnKvL8lxaAXNagBCpHP9siEBYSKgy7ymJ3Z233XALWx75GO3oPRPE+oG5jL2W//0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274921; c=relaxed/simple;
	bh=aGacCwVy1sJgCqHv8jgzaxIHXbfrWkMkcqTwY7lep7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR/H6RN+AGsI6jEkjKzlJmrTgoHle+Ouh+5hixa5ide0RzV73y9iW7YLQAmdiOY/35JMr5egM21Dk+OKiWbku8ZDUbMJ1BS+Ure59A/QKFnJtaHHXjUrTm+zEh63RBBZOwslzCHgei5jacpAdsbewUKIJiDJkgzG+MS+Kk9fSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yH2f3qVG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+CrOKUZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yH2f3qVG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+CrOKUZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B1125BF17;
	Tue, 21 May 2024 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716274918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfwNeirqJErZbK+9uvkbq+97VsJL1e7zcTxFG4saEj8=;
	b=yH2f3qVG8nLYLNx9u1imARwL2LjRJgomwkLYfnsdOHlpEXEs/696DEqd3LInz7RSo+0eCD
	AardD1TtJhL4QUHHO1ezR+wlyijMZxCEGdypAn8SdZIEap3+zUFAen4Obcx8T5H2oRpOQk
	lv08KVa2SZtnHXM9P70JtfXlXcQnyOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716274918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfwNeirqJErZbK+9uvkbq+97VsJL1e7zcTxFG4saEj8=;
	b=D+CrOKUZlwWuQXrpqq6BtzpeILUBNp1rJiHYF7CBffkiQ+0tM5lTzezG/onZQ0PL5lKUSw
	GED5gg6bobS18ZAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yH2f3qVG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D+CrOKUZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716274918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfwNeirqJErZbK+9uvkbq+97VsJL1e7zcTxFG4saEj8=;
	b=yH2f3qVG8nLYLNx9u1imARwL2LjRJgomwkLYfnsdOHlpEXEs/696DEqd3LInz7RSo+0eCD
	AardD1TtJhL4QUHHO1ezR+wlyijMZxCEGdypAn8SdZIEap3+zUFAen4Obcx8T5H2oRpOQk
	lv08KVa2SZtnHXM9P70JtfXlXcQnyOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716274918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfwNeirqJErZbK+9uvkbq+97VsJL1e7zcTxFG4saEj8=;
	b=D+CrOKUZlwWuQXrpqq6BtzpeILUBNp1rJiHYF7CBffkiQ+0tM5lTzezG/onZQ0PL5lKUSw
	GED5gg6bobS18ZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B8F213A1E;
	Tue, 21 May 2024 07:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fka0F+VGTGZjDQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 May 2024 07:01:57 +0000
Message-ID: <f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>
Date: Tue, 21 May 2024 09:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
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
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8B1125BF17
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/20/24 12:20, Nitesh Shetty wrote:
> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
> Since copy is a composite operation involving src and dst sectors/lba,
> each needs to be represented by a separate bio to make it compatible
> with device mapper.
> We expect caller to take a plug and send bio with destination information,
> followed by bio with source information.
> Once the dst bio arrives we form a request and wait for source
> bio. Upon arrival of source bio we merge these two bio's and send
> corresponding request down to device driver.
> Merging non copy offload bio is avoided by checking for copy specific
> opcodes in merge function.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   block/blk-core.c          |  7 +++++++
>   block/blk-merge.c         | 41 +++++++++++++++++++++++++++++++++++++++
>   block/blk.h               | 16 +++++++++++++++
>   block/elevator.h          |  1 +
>   include/linux/bio.h       |  6 +-----
>   include/linux/blk_types.h | 10 ++++++++++
>   6 files changed, 76 insertions(+), 5 deletions(-)
> 
I am a bit unsure about leveraging 'merge' here. As Bart pointed out, 
this is arguably as mis-use of the 'merge' functionality as we don't
actually merge bios, but rather use the information from these bios to
form the actual request.
Wouldn't it be better to use bio_chain here, and send out the eventual
request from the end_io function of the bio chain?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


