Return-Path: <linux-fsdevel+bounces-45740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FCFA7B99F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C623B6AD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85931A315C;
	Fri,  4 Apr 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bbUOMP2t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SBUolRlj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFY1hGgJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2r3TDU1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95091A2393
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757781; cv=none; b=PVLPAwgxND/vhGAcS2rQuNP8SkccXpCSCcnz+V1zRVknsRzJF86RTS8V1U9rQgk56iKQLTpCeHYkTWBW3qOtU7f2E6HwUJvBbbi5QoGOL0wj5mOmKgXWiRpn3JheKSgVVbSAUVuFzKX1DvSIqLgw9+XUC2CrZVyKumkZETjJUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757781; c=relaxed/simple;
	bh=xRhh91DIyRAUo3LsDmS/xvomtv4de/pK6MLY94wbvyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfJy4VgaHGtTzGrpxts8AoY8BgXSSdfHOs47V0Ge6dBbXnzncznLVr5mHjBDMct5e0ETYJ5C/bRzNjhrHohMlzFVuEG/+qxEl4u0StKfyHQxtwGiMdlSnjyZzJGwTQIbNfFLetinM0L4MlPN+9mBhuQ5YkmkO4KtnbUlqsR/X8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bbUOMP2t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SBUolRlj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFY1hGgJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2r3TDU1l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB5E61F385;
	Fri,  4 Apr 2025 09:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743757778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKInD56e0AOZxjyXASXarYwfeLkmZUcVHsDa4PAeMHs=;
	b=bbUOMP2tjK8IXTCJh4i/u0N+WjzQC/vaDLj3GzreavKtHT2pdUWGiIjcLWP55/DMujiVzt
	z+/NSiard5TBZduU2w0rsIiPphKCBELVmdH8gCZDP7PWSx6CC2pj2SEWYL7UDcFjMjakTr
	AxqVbhflbZGmM23CoDFhBIIHv7HqnMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743757778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKInD56e0AOZxjyXASXarYwfeLkmZUcVHsDa4PAeMHs=;
	b=SBUolRljcNb8TbKwDRwuecMN860fiUs2u9jud6r3CHEtf4IvnIdsmacP4NcckirPhyES6V
	D2OFzrx6fQBI3hAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743757777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKInD56e0AOZxjyXASXarYwfeLkmZUcVHsDa4PAeMHs=;
	b=aFY1hGgJfg8i0e/djJRElR2nYPgno+1KIw8QzwOtU0rx2y3OAQXR4ymxYRfsPi+sxmK3Qu
	plzkVRLQMI2w8pmXPQmVnAB/T7x9s5hxR7plHFPkEP0SVFuYdKq42PNvi2BFF8ionYJqCM
	JiGYfwV63A5P5zEaO4mo0sA0JP8YKFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743757777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKInD56e0AOZxjyXASXarYwfeLkmZUcVHsDa4PAeMHs=;
	b=2r3TDU1lWiv/omvmcMpYcOZLK4/0lworNmvcxkE1CnYblgOUf1fVVPVc4nwvhehOTrDL3f
	1XmR01ZhAnJ9s9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C29B613691;
	Fri,  4 Apr 2025 09:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yYgrL9Gh72fxBwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 04 Apr 2025 09:09:37 +0000
Message-ID: <aadb65f3-7656-4051-99a4-909fc1f61fc7@suse.cz>
Date: Fri, 4 Apr 2025 11:09:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Matt Fleming <matt@readmodwrite.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, luka.2016.cs@gmail.com,
 tytso@mit.edu, Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
 <20250326105914.3803197-1-matt@readmodwrite.com>
 <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
 <Z-7BengoC1j6WQBE@casper.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z-7BengoC1j6WQBE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,linux-foundation.org,vger.kernel.org,kvack.org,gmail.com,mit.edu,kernel.org,cloudflare.com,szeredi.hu,fromorbit.com,bytedance.com,linux.dev,HansenPartnership.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 4/3/25 19:12, Matthew Wilcox wrote:
> Ideas still on the table:
> 
>  - Convert all filesystems to use the XFS inode management scheme.
>    Nobody is thrilled by this large amount of work.
>  - Find a simpler version of the XFS scheme to implement for other
>    filesystems.

I don't know the XFS scheme, but this situation seems like a match for the
mempool semantics? (I assume it's also a lot of work to implement)

