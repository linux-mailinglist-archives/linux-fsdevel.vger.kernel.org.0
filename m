Return-Path: <linux-fsdevel+bounces-20913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC208FAB86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043B21F25D18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B988140370;
	Tue,  4 Jun 2024 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sl7jBzFC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AFVXQxZO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="INz8m3Ee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uTR7uXGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78A136E26;
	Tue,  4 Jun 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484715; cv=none; b=UQDVBXB4+QD37KXmnv+D6+Tabp9djydjmxTCqvhpX2QVZgNXGLwPNEaXIz5TduzpeFLsWroAoGyskvx9vjb/EZtZv1SfEa5Jc/JfnoM11nit9CWjl2rdbR4+On2HpQbHS0XfiqsU+WbXD4rx3ROhURmRfqG6pBEweJdIrvKGna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484715; c=relaxed/simple;
	bh=6YjCOtIMMpmHYUB0A2aaJ0tEDYTwFB1kJALsKeFtJX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N96lAtLphGPCyptK4cVdKnIncPUYc2fyZHC5OeoX9ReczoW8L+V76nLh4Id2OHHLeDdCDIC6TBnD/OebFoYYpDgTWdq0Eg6lCxupeJiMGnOq9cvhfaB7aFeNWHIjZrCCDJUMpPoDfxIdUr81Jz9Cj1h7lWQ0APIec41L5XZUqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sl7jBzFC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AFVXQxZO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=INz8m3Ee; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uTR7uXGc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD31C1F7CE;
	Tue,  4 Jun 2024 07:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717484707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDT6GhXGpfXEjkHCaC3Z+bPiL1jRB5MV+f27ny2SJ9E=;
	b=Sl7jBzFCymnzrp32z3FfkYZ/N+eUMowpBmnAqlbaHyCOPQceFkkAv10+ZwB/X/F3ZjHB7z
	ayps09TK5SDogDSpcLXRyty8qDavg6CfyGXLYNNpIQUVoLLdHVKnSi55dlw+hCjIBPw5fK
	VduBKdg+jR+ZIBGShx4cmc/5ETdpNHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717484707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDT6GhXGpfXEjkHCaC3Z+bPiL1jRB5MV+f27ny2SJ9E=;
	b=AFVXQxZOKCUvDxWC2EeMEtc9AEFeeMVom+/VqX3bZMgWraRJz6P7aNOE+agsMcvV4guubq
	D7wBBb7WRE4aJQCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=INz8m3Ee;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uTR7uXGc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717484705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDT6GhXGpfXEjkHCaC3Z+bPiL1jRB5MV+f27ny2SJ9E=;
	b=INz8m3EegbIggjSKHCWb4e0H3mnc35kxALDTGQ2uttJRiskHVcoNm7xcLQDHwks3hUdjFR
	KrHD8hgTDdLCk2L2a21jK+47Squti4UhtKpXqBGLVzz+scAXb0Ca6Yk95CxgUc0FU6ifyV
	8KLSUNfdxCVWb+KN2GzSMQU6jkVvo2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717484705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDT6GhXGpfXEjkHCaC3Z+bPiL1jRB5MV+f27ny2SJ9E=;
	b=uTR7uXGcxkyc2MiucpQv1kMvw+tOdyiRza1QlJhCzefQVLcIUlGE1Slk4kAlV2tXH8COtT
	k8QGnh9LCbfDBBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF24A1398F;
	Tue,  4 Jun 2024 07:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEcTL5+8XmbhewAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Jun 2024 07:05:03 +0000
Message-ID: <93f6bb98-e9b4-481e-afae-c2b4d90e686b@suse.de>
Date: Tue, 4 Jun 2024 09:05:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240604043142.GB28886@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240604043142.GB28886@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,lwn.net,redhat.com,kernel.org,grimberg.me,nvidia.com,zeniv.linux.org.uk,suse.cz,oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLghztw5pzjjmtx4kirkcu9cad)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AD31C1F7CE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.50

On 6/4/24 06:31, Christoph Hellwig wrote:
> On Mon, Jun 03, 2024 at 06:43:56AM +0000, Nitesh Shetty wrote:
>>> Also most block limits are in kb.  Not that I really know why we are
>>> doing that, but is there a good reason to deviate from that scheme?
>>>
>> We followed discard as a reference, but we can move to kb, if that helps
>> with overall readability.
> 
> I'm not really sure what is better.  Does anyone remember why we did
> the _kb version?  Either way some amount of consistency would be nice.
> 
If memory serves correctly we introduced the _kb versions as a 
convenience to the user; exposing values in 512 bytes increments tended
to be confusing, especially when it comes to LBA values (is the size in 
units of hardware sector size? 512 increments? kilobytes?)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


