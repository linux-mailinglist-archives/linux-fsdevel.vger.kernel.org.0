Return-Path: <linux-fsdevel+bounces-15866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E78951FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CF01F22B29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C767C46;
	Tue,  2 Apr 2024 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OGjH+Mkt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y5JmAN8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93DA1F619;
	Tue,  2 Apr 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057843; cv=none; b=PLjre1ffg1rHCJAG3u4OZE3Mvi3p9+2jLJanfY25Ivch54zWIytT6thg1rOe1mopqkSW6F9pMgkEItdtxQ3xsJIH10+3g+SEYXKpg+WfSO3oXkpDb9Vek3d1VawIXcWJDHc3SV4Nha+PMXYQLh/ukMNGly8drKynDtQT6WopFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057843; c=relaxed/simple;
	bh=QHARwJ1KIzwTbtjx/NTMLbBPMx6OM8GPMOChTbRB+Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frd/freEOUv0bppShFf3S9mX8heZCuEuF02eRmrmR9ix0JvV4y1pJslmgelmtCdHRwrOJwdsW2UG0WrlbzkJfE7SrZX0Foj6FmjVS7Ny5eWb8P78Q7wkhkrw00/E4C4zxYvEIDzgkim2A6qDFx5ihOZ+NMX5TllrnB4JDmJWymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OGjH+Mkt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y5JmAN8i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E35C834628;
	Tue,  2 Apr 2024 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712057839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJ3ZFU1RiRJTIMmOESh+Awufpt2n1eMVYEYTzVGB6g4=;
	b=OGjH+MktKXWEul8I1KyU8ep16udkrlXbCthAaMI2G5VUaCK6l5MkeFdjRNZq0UZS9PE3BK
	8Wsuud2vX32NcAxswYe6bKlIQE0PAKK91ubkMCaw+QxIhErO6wWoRO+ir6YL4r1wfeIg+n
	itaVcfIdUxYbskAmkVvwP0J4W/S7zQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712057839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJ3ZFU1RiRJTIMmOESh+Awufpt2n1eMVYEYTzVGB6g4=;
	b=Y5JmAN8i5adaqxqs7GO3BpwghDSBKVAm7H4N01pAJARZBIBXq6v5r0gGLusmJMVl8bkkc/
	8Jx64dPs7Qd9+0Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BFE9213A90;
	Tue,  2 Apr 2024 11:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8whwLu/tC2btLQAAn2gu4w
	(envelope-from <hare@suse.de>); Tue, 02 Apr 2024 11:37:19 +0000
Message-ID: <7fbfdcf6-22ee-48f4-be80-92b465067216@suse.de>
Date: Tue, 2 Apr 2024 13:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Content-Language: en-US
To: Dongyang Li <dongyangli@ddn.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
 <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
 <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E35C834628
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

On 4/2/24 12:45, Dongyang Li wrote:
> Martin, Kanchan,
>>
>> Kanchan,
>>
>>> - Generic user interface that user-space can use to exchange meta.
>>> A new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible
>>> for direct IO.
>>
>> Yep. I'm interested in this too. Reviving this effort is near the top
>> of my todo list so I'm happy to collaborate.
> If we are going to have a interface to exchange meta/integrity to user-
> space, we could also have a interface in kernel to do the same?
> 
> It would be useful for some network filesystem/block device drivers
> like nbd/drbd/NVMe-oF to use blk-integrity as network checksum, and the
> same checksum covers the I/O on the server as well.
> 
> The integrity can be generated on the client and send over network,
> on server blk-integrity can just offload to storage.
> Verify follows the same principle: on server blk-integrity gets
> the PI from storage using the interface, and send over network,
> on client we can do the usual verify.
> 
> In the past we tried to achieve this, there's patch to add optional
> generate/verify functions and they take priority over the ones from the
> integrity profile, and the optional generate/verify functions does the
> meta/PI exchange, but that didn't get traction. It would be much better
> if we can have an bio interface for this.
> 
Not sure if I understand.
Key point of PI is that there _is_ hardware interaction on the disk 
side, and that you can store/offload PI to the hardware.
That PI data can be transferred via the transport up to the application,
and the application can validate it.
I do see the case for nbd (in the sense that nbd should be enabled to 
hand down PI information if it receives them). NVMe-oF is trying to use
PI (which is what this topic is about).
But drbd?
What do you want to achieve? Sure drbd should be PI enabled, but I can't 
really see how it would forward PI information; essentially drbd is a
network-based RAID1, so what should happen with the PI information?
Should drbd try to combine PI information from both legs?
Is the PI information from both legs required to be the same?
Incidentally, the same question would apply to 'normal' RAID1.
In the end, I'm tempted to declare PI to be terminated at that
level to treat everything the same.
But I'd be open to discussion here.

Cheers,

Hannes


