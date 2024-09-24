Return-Path: <linux-fsdevel+bounces-29969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8425984314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F66B29797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B51741D4;
	Tue, 24 Sep 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fckLcgVX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A8OYA3AD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fckLcgVX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A8OYA3AD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A44166F13;
	Tue, 24 Sep 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172360; cv=none; b=TnQnpQYTbBNFPuhiWR4pVrcmlASRcA1bT1RM5ZWHZLy7w3iqLVwooUG/PmtvQFUAhelxOC52YhCmTUQ3u/VOB1tJ/pxQ7/VhKX6FjEq9u1+sooJC+clAvP5lqQCt5cUxWR64RU2iw+jfCvQH9eQQgira+WWgY0MMyXKCB4AfM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172360; c=relaxed/simple;
	bh=1eqBaHKwaUr6BfNn9UO1x2HFnLfcw+wW1EANwKY/gl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3JkyXzjjunMnQSK9giGk4DQPIm9fWlQVhudKWfxZfDN5bW7hdMi8JCenLqZqynermK9r/vX3s7llBqt2O9zMp4xvvIk0/6HEd5Vf2RWHv8+VFENYopiOOmx9ipX9xrZ+S0ev7oC7oJrXPyiteUjUDmtpwjD2qh9c5eDbnQxlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fckLcgVX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A8OYA3AD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fckLcgVX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A8OYA3AD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1AE021A0B;
	Tue, 24 Sep 2024 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727172356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeyLWK7GQH/dEUztjXSVliab+VG2CypIiF2jkfjS0ZY=;
	b=fckLcgVXMv6FR1aBA+g6wpVKHVxIzrPJdB7qf88nai5DmZ0biCpVPyIVrrYuifbr6fXKvS
	v442Qb1jsSu9Ywesczg6yd0YuSCYSKtALTVXGe5l32pPysboLuNao1RahJPA3qXJg2VInd
	PfP0DquSNyKOmTXdcsOXdAz3HCmDuiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727172356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeyLWK7GQH/dEUztjXSVliab+VG2CypIiF2jkfjS0ZY=;
	b=A8OYA3ADFAJDEImHLLfu1WQB7NL8Ohv2TQfj7Bh1KhAsgNMIbUIYJpPirIc3R8a/PR3Afo
	gE4hx4PzWVaTWSAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727172356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeyLWK7GQH/dEUztjXSVliab+VG2CypIiF2jkfjS0ZY=;
	b=fckLcgVXMv6FR1aBA+g6wpVKHVxIzrPJdB7qf88nai5DmZ0biCpVPyIVrrYuifbr6fXKvS
	v442Qb1jsSu9Ywesczg6yd0YuSCYSKtALTVXGe5l32pPysboLuNao1RahJPA3qXJg2VInd
	PfP0DquSNyKOmTXdcsOXdAz3HCmDuiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727172356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeyLWK7GQH/dEUztjXSVliab+VG2CypIiF2jkfjS0ZY=;
	b=A8OYA3ADFAJDEImHLLfu1WQB7NL8Ohv2TQfj7Bh1KhAsgNMIbUIYJpPirIc3R8a/PR3Afo
	gE4hx4PzWVaTWSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8566613AA8;
	Tue, 24 Sep 2024 10:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id te56IASP8mYeFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Sep 2024 10:05:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 31661A088D; Tue, 24 Sep 2024 12:05:52 +0200 (CEST)
Date: Tue, 24 Sep 2024 12:05:52 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 10/10] ext4: factor out a common helper to lock and
 flush data before fallocate
Message-ID: <20240924100552.zcx57qyqg62taszl@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-11-yi.zhang@huaweicloud.com>
 <20240923085402.amto7pryy67eadpj@quack3>
 <e6cceeee-9ff1-4638-8521-19ab40593693@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6cceeee-9ff1-4638-8521-19ab40593693@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 24-09-24 16:11:08, Zhang Yi wrote:
> On 2024/9/23 16:54, Jan Kara wrote:
> > On Wed 04-09-24 14:29:25, Zhang Yi wrote:
> > Also the range is wrong for collapse
> > and insert range. There we need to writeout data upto the EOF because we
> > truncate it below.
> > 
> 
> For collapse and insert range, I passed the length LLONG_MAX, which is
> the same as before, this should've upto the EOF, so I think it's
> right, or am I missing something?
> 
> ext4_collapse_range():
> 
> -	start = round_down(offset, PAGE_SIZE);
> -	/* Write out all dirty pages */
> -	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
> +	ret = ext4_prepare_falloc(file, round_down(offset, PAGE_SIZE),
> +				  LLONG_MAX, FALLOC_FL_COLLAPSE_RANGE);
> 
> 
> ext4_insert_range():
> 
> -	start = round_down(offset, PAGE_SIZE);
> -	/* Write out all dirty pages */
> -	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
> +	ret = ext4_prepare_falloc(file, round_down(offset, PAGE_SIZE),
> +				  LLONG_MAX, FALLOC_FL_INSERT_RANGE);
> 

Ah sorry, I've missed these bits. So we should be fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

