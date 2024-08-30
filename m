Return-Path: <linux-fsdevel+bounces-27982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB3965761
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 08:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BAE1C23114
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D853389;
	Fri, 30 Aug 2024 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JDfMqMoD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zUVLLfle";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JDfMqMoD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zUVLLfle"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E714C596;
	Fri, 30 Aug 2024 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998264; cv=none; b=grx4TdPsfhVI40vFJ2aXRI4hFbr3E5pjeY3GzjRNykes/yBTsnMdZrJHZM8Wspb5uaUGwlYHyBn4dWi+731WGWwc+b5vMLCovHUDbVafHNxX/7AB4x44ihJrZ24I+nHsiyKJQDzIDRU5Lv1cltFBQV8dFS6oMws3g3jn6Hi3TCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998264; c=relaxed/simple;
	bh=g5qiXH6/WtVjU3jF2wRxOveJ9MIcV4A0/6sKE7TEqiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA0Y0vdKDYFNHNG0Kh1jCSlA9KQAgh2aAFiqVLO6cRkYZs3JsvzN5CTcpRwePIq21oPB+gsamMfn9pOC8PsXR1ISn4Ne5oysBXa7rpmwGVs75WyhmJAleNzOYg+DZeXuZJIDpOdQ/JUjTerhzu8a8dtDsF4eLMPvzZyO22ml9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JDfMqMoD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zUVLLfle; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JDfMqMoD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zUVLLfle; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5AB1F7A0;
	Fri, 30 Aug 2024 06:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724998261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwD1A+dPCAQTtJUtxAfsvK6ToX4dZSDfYvcEiw+etw4=;
	b=JDfMqMoDN3c6QjxNybEbVOAxAyTIMbjnFSsak255GdZM+fsIXxggkCrMx5NOn/tq8LIrM9
	H7BRPyZkKBfhWMMhTHMZOrRoLFf0iNYNnrS4j8wtHS73lbW54I23fkhc5aa1Lf28aiCIQE
	bHW6GRFwLfibWZkVHGJnsz/uj7wkgkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724998261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwD1A+dPCAQTtJUtxAfsvK6ToX4dZSDfYvcEiw+etw4=;
	b=zUVLLfleivqOuGeSvJTH7GvjB4icviBsxydl1mNXu1N+xYMn48Amd+PjTIgLVBQYFC1zHF
	PucOn+V7bEmJ5OAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724998261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwD1A+dPCAQTtJUtxAfsvK6ToX4dZSDfYvcEiw+etw4=;
	b=JDfMqMoDN3c6QjxNybEbVOAxAyTIMbjnFSsak255GdZM+fsIXxggkCrMx5NOn/tq8LIrM9
	H7BRPyZkKBfhWMMhTHMZOrRoLFf0iNYNnrS4j8wtHS73lbW54I23fkhc5aa1Lf28aiCIQE
	bHW6GRFwLfibWZkVHGJnsz/uj7wkgkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724998261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwD1A+dPCAQTtJUtxAfsvK6ToX4dZSDfYvcEiw+etw4=;
	b=zUVLLfleivqOuGeSvJTH7GvjB4icviBsxydl1mNXu1N+xYMn48Amd+PjTIgLVBQYFC1zHF
	PucOn+V7bEmJ5OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C905513A3D;
	Fri, 30 Aug 2024 06:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xq8TL3Ri0WYoTQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 30 Aug 2024 06:11:00 +0000
Message-ID: <4dfed593-5b0c-4565-a6dd-108f1b1fe961@suse.de>
Date: Fri, 30 Aug 2024 08:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: drop GFP_NOFAIL mode from alloc_page_buffers
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Michal Hocko <mhocko@suse.com>
References: <20240829130640.1397970-1-mhocko@kernel.org>
 <20240829191746.tsrojxj3kntt4jhp@quack3>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240829191746.tsrojxj3kntt4jhp@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 8/29/24 21:17, Jan Kara wrote:
> On Thu 29-08-24 15:06:40, Michal Hocko wrote:
>> From: Michal Hocko <mhocko@suse.com>
>>
>> There is only one called of alloc_page_buffers and it doesn't require
>> __GFP_NOFAIL so drop this allocation mode.
>>
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Although even better fix would be to convert the last remaining caller of
> alloc_page_buffers() to folio_alloc_buffers()... But that may be more
> difficult.
> 
Already done by Pankajs large-block patchset, currently staged in vfs.git.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


