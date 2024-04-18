Return-Path: <linux-fsdevel+bounces-17233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AD78A95D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 11:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2811F21A16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79615AD80;
	Thu, 18 Apr 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J8DLVORW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6V0yiVS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ld1kjLFx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="og1w4Vjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489815AAC2;
	Thu, 18 Apr 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431976; cv=none; b=MAcbn4LL1+dX2bjk6wkr/j/Ta4i4DzXabzBC//K0ajsgOU2a7GhNgck/bo/sDwUbCVrSWfL33xrZSOaNwRsl1U89/+t/Th9XxR+xkW+MxSooCPVeGtd2H/ehxNF/CkJ9k9YjJFXVT3Y7gZZ96N4afzSfMYwb3oCh5VnNK6uqoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431976; c=relaxed/simple;
	bh=iXqXXOh4PH5lcnxCJweGQjskoIsDRJC8r3gjoqqH/U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNgem0Lmkxkhxokvy7B+mmoA/fwib0TIGPK/q4ujdylL+yOWIBoCOMCerTZuS1KUpAZj+Wp1/igaNFG35/DcNck9Ud50hG+RDQlbjA45nLFctNgBK3FKobHCl5y+VmKdMRH30Yfmu+L2SWDrbTw6jynZ5iHx2fM9AwcDoCKDLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J8DLVORW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6V0yiVS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ld1kjLFx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=og1w4Vjs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F05275C7A7;
	Thu, 18 Apr 2024 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713431973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0y2dRyvoaZYZ98XqtXgkRT2AKE9iT8X2EM4kXBX9yQ=;
	b=J8DLVORWw0REOkO9KkvzgSu6NXMCTwuud7PzOUaYRqxr730B4LHaP+pyT1r2AOqZG5w3A8
	4qHMnXRSLv2bZHfKyk/50inf4YqW1v6RYK86Pe15QD0omX82TDaE6ZqNV+LiHSWhkgCQtw
	2B3urIuCP9qBAZv9vYv3TsTu6IxgL0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713431973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0y2dRyvoaZYZ98XqtXgkRT2AKE9iT8X2EM4kXBX9yQ=;
	b=p6V0yiVSm+mDG0P0ulMKa4YC2Ts0HY6HbTF4Glt2eZvj6JF+NK0Jl1OSBDao7DXGRcsIpG
	10S3nZP4oEbdGVDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713431971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0y2dRyvoaZYZ98XqtXgkRT2AKE9iT8X2EM4kXBX9yQ=;
	b=ld1kjLFxDZ1dDSrdB2I80YS/2Omrro1ZFpgtixh2/g9ztM1ODXphuCUqnn+dBS9Z6z0Dal
	77AnTog4jSGk7vo+2fHeNI/DIM0yU7eEFmm3wYZvYCe9jEADzLzJ8jljIjenf18l24RgS+
	GXXqrrhfSOKTd+UxSobFrGJxNEkVB+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713431971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0y2dRyvoaZYZ98XqtXgkRT2AKE9iT8X2EM4kXBX9yQ=;
	b=og1w4VjsT40HJV8VD7S6L8O8HYXRXtvnbFXvTkk3OE0ZiArjbgSr4kAb2zLpNFECHwgHw1
	wQpk2SrfVLbSTJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E27161384C;
	Thu, 18 Apr 2024 09:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DqkWN6PlIGaINQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 18 Apr 2024 09:19:31 +0000
Message-ID: <d0d118ed-88dd-4757-8693-f0730dc9727c@suse.cz>
Date: Thu, 18 Apr 2024 11:19:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: add fsstress + compaction test
To: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org,
 kdevops@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, david@redhat.com, linmiaohe@huawei.com,
 muchun.song@linux.dev, osalvador@suse.de
References: <20240418001356.95857-1-mcgrof@kernel.org>
 <ZiB5x-EKrmb1ZPuf@casper.infradead.org> <ZiDEYrY479OdZBq2@infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <ZiDEYrY479OdZBq2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.22
X-Spam-Level: 
X-Spamd-Result: default: False [-4.22 / 50.00];
	BAYES_HAM(-2.93)[99.71%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 4/18/24 08:57, Christoph Hellwig wrote:
> On Thu, Apr 18, 2024 at 02:39:19AM +0100, Matthew Wilcox wrote:
>>> Running compaction while we run fsstress can crash older kernels as per
>>> korg#218227 [0], the fix for that [0] has been posted [1] but that patch
>>> is not yet on v6.9-rc4 and the patch requires changes for v6.9.
>>
>> It doesn't require changes, it just has prerequisites:
>>
>> https://lore.kernel.org/all/ZgHhcojXc9QjynUI@casper.infradead.org/
> 
> How can we expedite getting this fix in?

It means moving patches 2,4,5 from the above (with their fixups) from
mm-unstable to mm-hotfixes-unstable so they are on track to mainline
before 6.9.

A quick local rebase of mm-unstable with reordering said patches to the
front (v6.9-rc4) suggests this is possible without causing conflicts,
and the intermediate result compiles, at least.


