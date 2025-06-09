Return-Path: <linux-fsdevel+bounces-50997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6BAD1A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6C93A2074
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510A24E4B4;
	Mon,  9 Jun 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0BjHCyEH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/kMv1nz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HWGQ3IT2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cGqP0nJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D720F093
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459101; cv=none; b=TdH64oxVUH+7Z+GPYQKof9mkS60v0UoK95BzWa6KGNzzCKsAuB+njbPC65mYx+VYRthcjKiwfXwKvRVyqSE7xD/hQJE0NB0GhqUJvGsdlhuTHLeiaf32nPPCM8S+eNHePLpymuyEtnb7XXm54sB5BZ1DBSXpSRgdlw5OTlzgrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459101; c=relaxed/simple;
	bh=BSgUDmJHtvbnj7e/USJVPC50HyAIZQPsIFsKd/DGRrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpEgtXMMKVBr+BDcH5VccmzbajUx8I3ixQyiQ4J/IEm311rqrzLlUN6cIrc8AwEACEFql2Afb7Bi0ur1qJeEZWw160b82nJ6UePM52h2MAoKOShVXiuBCB8GTMBGPK7yto5HqnY6XcA8tePGmWLrXMCD81/pvcjBn19t/25kogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0BjHCyEH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/kMv1nz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HWGQ3IT2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cGqP0nJH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7EE01F38F;
	Mon,  9 Jun 2025 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749459098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgR2BzCbct66ZHEIawKMv8NgM12xLoogIKYqWadljGQ=;
	b=0BjHCyEHWe9OphSDAUw3zUMcCQhODaUpjZRbQLJ7R6VHHb9CYmSeCQ69vW/GnaCYPV8ChU
	3Z6hd2SLY+PaF4SL95wp6p83fiCqOMtfw0MxY3tN8SGJ4bWtcGWabDcOME7pwRXG7SkBo5
	L6XsMgpfwHDuzV7H25iTlcugX3RAReU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749459098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgR2BzCbct66ZHEIawKMv8NgM12xLoogIKYqWadljGQ=;
	b=U/kMv1nzhTVmWT1NWjxIKr4qzABlwt2g22K43X3St5430+8BzM43mMZZB1ngSfcAHSTr65
	vuTvToK4FJJxPZCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749459097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgR2BzCbct66ZHEIawKMv8NgM12xLoogIKYqWadljGQ=;
	b=HWGQ3IT2OCeR+46Hax1CirA8yPt6lNr0WdYuwYqbX5wZsiuUvVrejoBgLqpVCob9Kj9fRr
	HYUspybKxESUC7NAYmSIo0ssmgyNHn6/VV4W6fUxDxV56MGQ7uRiXv5Ec0S4Sxssz9N4UL
	g/KVFT50LUnXQZXSkXhp2N1Xhf+aDx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749459097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgR2BzCbct66ZHEIawKMv8NgM12xLoogIKYqWadljGQ=;
	b=cGqP0nJHBvx3bgozqQtTnF7pYQtDMGpN3zhgVg6aJI0LEsOBju18B+57KsS8bv9MvnH2/W
	7alVDx/pOB0pAXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6BFC137FE;
	Mon,  9 Jun 2025 08:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x0kdKJmgRmieEAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Jun 2025 08:51:37 +0000
Message-ID: <4c113d58-c858-4ef8-a7f1-bae05c293edf@suse.cz>
Date: Mon, 9 Jun 2025 10:52:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, david@redhat.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
 sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
 <87bjqx4h82.fsf@gmail.com> <aEaOzpQElnG2I3Tz@tiehlicka>
 <890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
 <87a56h48ow.fsf@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <87a56h48ow.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,suse.com];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,alibaba.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 6/9/25 10:31 AM, Ritesh Harjani (IBM) wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 2025/6/9 15:35, Michal Hocko wrote:
>>> On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
>>>>
>>>> Any reason why we dropped the Fixes tag? I see there were a series of
>>>> discussion on v1 and it got concluded that the fix was correct, then why
>>>> drop the fixes tag?
>>>
>>> This seems more like an improvement than a bug fix.
>>
>> Yes. I don't have a strong opinion on this, but we (Alibaba) will 
>> backport it manually,
>>
>> because some of user-space monitoring tools depend 
>> on these statistics.
> 
> That sounds like a regression then, isn't it?

Hm if counters were accurate before f1a7941243c1 and not afterwards, and
this is making them accurate again, and some userspace depends on it,
then Fixes: and stable is probably warranted then. If this was just a
perf improvement, then not. But AFAIU f1a7941243c1 was the perf
improvement...

> -ritesh


