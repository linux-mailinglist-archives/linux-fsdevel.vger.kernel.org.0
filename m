Return-Path: <linux-fsdevel+bounces-39481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2F0A14E96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 12:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113D43A8A0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274B1FE451;
	Fri, 17 Jan 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcvQLdKg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+FsKBYIY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcvQLdKg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+FsKBYIY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21219992C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114019; cv=none; b=VI6D+l73LagglT6Lw0LOqJFpzizRGSn17XwB+aMO15aTF+9/cdMcD7FbeTzf62fam5eVoaneqqfSe1q79MqBSFIWP4V1ULFB2V+iGYpsHe89jMFGWYKAHd9RVoDrGTTzA4z+yxCj4RXkdeIDm4PS0qvGb60f78t3pPZ69MTjKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114019; c=relaxed/simple;
	bh=yDF6K/UJl4w/mlvAO6F9a79S+FzvKguRY+ufMaFrF4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u26OJi5r+jG0fVQDYxzpxHZY5Pq2keD+sFGg8H8KoHhhG7IkQQA0icSKxQyhQraOtidlgTovD0IIiiExi3ZsFlYaSMfYt/FIbticC9HLMwnlvTC+yuwpCcwhRkn7RLowm1z2v0dT/XdQfd2L58cW0/e3PkLBYVPZ766pUlJRYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcvQLdKg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+FsKBYIY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcvQLdKg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+FsKBYIY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB94C1F387;
	Fri, 17 Jan 2025 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737114015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qk+MlsSzhydQRbKsTOiT8hCBIsqm8GiDAuTyUhXXqso=;
	b=LcvQLdKgklVsXGu6NCwD8I5XfPbxO3FScNOvglWrxxNCaKRdTd8R3emDCKUebbY5vVJt6E
	wiaiEIzSlv4DhqYUjKNO4HHZR7dddUklyYohINyObnl1Wr4qzEJPFje28SyCs5HKcUG0nj
	I8BGEHbjJvufrWSaPoLXVzaxYEARGhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737114015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qk+MlsSzhydQRbKsTOiT8hCBIsqm8GiDAuTyUhXXqso=;
	b=+FsKBYIYnlba3t/BMgsTSvCPvLTsahePapGeOHzgLWTByTgEtyGqmgcdrx6Oj1ZBXHWZiz
	DdHjAEWsaN9AhwDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737114015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qk+MlsSzhydQRbKsTOiT8hCBIsqm8GiDAuTyUhXXqso=;
	b=LcvQLdKgklVsXGu6NCwD8I5XfPbxO3FScNOvglWrxxNCaKRdTd8R3emDCKUebbY5vVJt6E
	wiaiEIzSlv4DhqYUjKNO4HHZR7dddUklyYohINyObnl1Wr4qzEJPFje28SyCs5HKcUG0nj
	I8BGEHbjJvufrWSaPoLXVzaxYEARGhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737114015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qk+MlsSzhydQRbKsTOiT8hCBIsqm8GiDAuTyUhXXqso=;
	b=+FsKBYIYnlba3t/BMgsTSvCPvLTsahePapGeOHzgLWTByTgEtyGqmgcdrx6Oj1ZBXHWZiz
	DdHjAEWsaN9AhwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD863139CB;
	Fri, 17 Jan 2025 11:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xtP2LZ9BimdGfAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 17 Jan 2025 11:40:15 +0000
Message-ID: <73eb82d2-1a43-4e88-a5e3-6083a04318c1@suse.cz>
Date: Fri, 17 Jan 2025 12:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving large folio writeback performance
To: Joanne Koong <joannelkoong@gmail.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,lists.linux-foundation.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 1/15/25 01:50, Joanne Koong wrote:
> Hi all,
> 
> I would like to propose a discussion topic about improving large folio
> writeback performance. As more filesystems adopt large folios, it
> becomes increasingly important that writeback is made to be as
> performant as possible. There are two areas I'd like to discuss:
> 
> 
> == Granularity of dirty pages writeback ==
> Currently, the granularity of writeback is at the folio level. If one
> byte in a folio is dirty, the entire folio will be written back. This
> becomes unscalable for larger folios and significantly degrades
> performance, especially for workloads that employ random writes.
> 
> One idea is to track dirty pages at a smaller granularity using a
> 64-bit bitmap stored inside the folio struct where each bit tracks a
> smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> pages), and only write back dirty chunks rather than the entire folio.

I think this might be tricky in some cases? I.e. with 2 MB and pmd-mapped
folio, it's possible to write-protect only the whole pmd, not individual 32k
chunks in order to catch the first write to a chunk to mark it dirty.


