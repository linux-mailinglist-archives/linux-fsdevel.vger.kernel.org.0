Return-Path: <linux-fsdevel+bounces-20917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF658FABAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4C7B21316
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345D51411C3;
	Tue,  4 Jun 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PeaVrnWm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xEyjkD38";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PeaVrnWm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xEyjkD38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0201384B3;
	Tue,  4 Jun 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485409; cv=none; b=qMqV7Drhlw3t7U9KG8rRZKVXLTG3MgueNL6YeXXd3+jDnXAumtSbB1c0glH6Lc23Yp2ydx3eKV0QUscP2tccroRzZcPEKyNfjOSxzPTxKy5WihUrD8G8E+BUOaLO4SpNXpfddAcG9kmibEDajBR0+StM8dpD5/EWcjuGOJchYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485409; c=relaxed/simple;
	bh=bBRRn4Q8xFyuLdpYYMuNlS5Dy6btxoAKS7E2El76tyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqHpCS/X6FZaTIg9t6Spaq77hVEdDLlLCAgS1la3tQw0LbpZimta1sAtwZcs2f8SDMsLMbigkkwyE+9NSgY/QeObuvONSGb3PkKMHwkmJztvQDN2+5wiDMORc/+R6oH6LJSy6+6MLD1CLYR62GgYtJ96LJEARNaWch6lMvkVN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PeaVrnWm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xEyjkD38; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PeaVrnWm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xEyjkD38; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40D38219F6;
	Tue,  4 Jun 2024 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717485400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=PeaVrnWmFeIaZb46cpPOJiQ128oEJZuC2J0qgbQpYCLF0/0gie7vAYjjfLIASP9fHyZ1Sn
	ywGhly3CvhxL6W8eXOz6NVEGQr29+mgyvv0fDAvEj59FKvFnUJFQYFBLgY3e9g0a7e2rSh
	JQ+5mxwxotCKdVP+ebV96Bb7yYzsXVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717485400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=xEyjkD38sr1vjKaXC2qn39sYnxlDyGVRjpdi+k4ElG8uyu4urxqQIDrJcO7+G6yjDcivZ9
	QKYni5Tl5A8UzgCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717485400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=PeaVrnWmFeIaZb46cpPOJiQ128oEJZuC2J0qgbQpYCLF0/0gie7vAYjjfLIASP9fHyZ1Sn
	ywGhly3CvhxL6W8eXOz6NVEGQr29+mgyvv0fDAvEj59FKvFnUJFQYFBLgY3e9g0a7e2rSh
	JQ+5mxwxotCKdVP+ebV96Bb7yYzsXVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717485400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbJsXJg0tltZiedNmfW574yl7kKUv3QYajAj48s+Gk=;
	b=xEyjkD38sr1vjKaXC2qn39sYnxlDyGVRjpdi+k4ElG8uyu4urxqQIDrJcO7+G6yjDcivZ9
	QKYni5Tl5A8UzgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 668251398F;
	Tue,  4 Jun 2024 07:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYyJFFW/XmZJfwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Jun 2024 07:16:37 +0000
Message-ID: <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de>
Date: Tue, 4 Jun 2024 09:16:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/12] Implement copy offload support
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
References: <20240604043242.GC28886@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240604043242.GC28886@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lwn.net,redhat.com,kernel.org,grimberg.me,nvidia.com,zeniv.linux.org.uk,suse.cz,oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On 6/4/24 06:32, Christoph Hellwig wrote:
> On Mon, Jun 03, 2024 at 10:53:39AM +0000, Nitesh Shetty wrote:
>> The major benefit of this copy-offload/emulation framework is
>> observed in fabrics setup, for copy workloads across the network.
>> The host will send offload command over the network and actual copy
>> can be achieved using emulation on the target (hence patch 4).
>> This results in higher performance and lower network consumption,
>> as compared to read and write travelling across the network.
>> With this design of copy-offload/emulation we are able to see the
>> following improvements as compared to userspace read + write on a
>> NVMeOF TCP setup:
> 
> What is the use case of this?   What workloads does raw copies a lot
> of data inside a single block device?
> 

The canonical example would be VM provisioning from a master copy.
That's not within a single block device, mind; that's more for copying 
the contents of one device to another.
But I wasn't aware that this approach is limited to copying within a 
single block devices; that would be quite pointless indeed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


