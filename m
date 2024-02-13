Return-Path: <linux-fsdevel+bounces-11377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEFE85341E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1D1C27EED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3725F863;
	Tue, 13 Feb 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oWOrnzXu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7a//jKg7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X/31pJW5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MeyY5nCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487385F846;
	Tue, 13 Feb 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836522; cv=none; b=AVGfjPQSjS1drom6A6CfFd+7OsxN3isbLziS2qLPL+WjEyeEmR/quGHDyuYyk81KgyShCX2QTaBKPQOSkl+1qeaR3KNCiZlafWed0cp3ayhwymDq3MWQiK9gX7076b3k9YB+1HRpn8zA84HHI3PYA2udrGrV2Vdm/h981gxFLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836522; c=relaxed/simple;
	bh=qhoqzhpmJpODRmRyCiLuBtSU8aBNlY/1JCdwnaiexVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgSPXPimC7xSHhJzgI1ZucOC8vgSj/2JD+zXH0jdP7Qs7H7g5QF8NDg6zL925LEodejhjFt1YTaSbl1JA/uZvwE7VlNpGRhfBJSAWl/uxLzTO/xvbKv2q9cuOzuZyuKRjVxS8K6yG2yoc9hn+d3iZlceNMBJJXKO5DEBRQpq/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oWOrnzXu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7a//jKg7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X/31pJW5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MeyY5nCo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57FBE21AFD;
	Tue, 13 Feb 2024 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVkykv12MFKPdThDh6lN+pM1JK/YrodY6SRWBlH3aw4=;
	b=oWOrnzXu5nB5a1ZbcRyT5SCvVAxxYXSCsp3KymtDhYJF7ZCHjWzsmaP+CWptv7brwwfPq2
	ZIVzPC4I0RkkjghVXCJn9P+M2DdK8iAUXhPvkwaVNz9/F/1pkNiU+GBof+hhfOZXk5Lx95
	wTSHUcc8iYakUORMXDZp53rKNNeQg/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVkykv12MFKPdThDh6lN+pM1JK/YrodY6SRWBlH3aw4=;
	b=7a//jKg7fUda4nJv2F19lonZvcJ4oc/mSsc4jT3YlD7077Mu1CvtUK1jkbPzUqm7CrGI28
	HN01KxlpSnzqSPCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVkykv12MFKPdThDh6lN+pM1JK/YrodY6SRWBlH3aw4=;
	b=X/31pJW5XkcUxYxNjdsjz0rWnC/DnOJ8dl/7UI7Pq4GX4cFZbnYCqmAUd2FuIuu8BMrJh0
	Q6l7FpW3Ml3Q5hbCXVTV5uZQyZoni7CzyzA/6xS33gQaV2iXOiXtiJfy2/XdU2RzoDk415
	cI4OyoHViJNo+7V0xDM0TCPToP6MLVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVkykv12MFKPdThDh6lN+pM1JK/YrodY6SRWBlH3aw4=;
	b=MeyY5nCo1r2t8+xXGtNekShIW+kZzzuyVU/2FkSeWF7XwuOqFi9y40ItBGtKW9S+hUuSAB
	iTrYywfH9NFlE1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1793C13404;
	Tue, 13 Feb 2024 15:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aLCmBGaEy2VlMwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 15:01:58 +0000
Message-ID: <77196ea8-2d31-420e-bb8c-fabc734bcb36@suse.de>
Date: Tue, 13 Feb 2024 16:01:58 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 07/14] readahead: allocate folios with mapping_min_order
 in ra_(unbounded|order)
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-8-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-8-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.43
X-Spamd-Result: default: False [-3.43 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.14)[95.88%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Allocate folios with at least mapping_min_order in
> page_cache_ra_unbounded() and page_cache_ra_order() as we need to
> guarantee a minimum order in the page cache.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/readahead.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



