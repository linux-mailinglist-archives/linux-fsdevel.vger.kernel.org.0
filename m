Return-Path: <linux-fsdevel+bounces-52320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32BAE1BBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182777A3778
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDCC28C2AC;
	Fri, 20 Jun 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqTcX6yN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q6VshcEs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqTcX6yN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q6VshcEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CC21C194
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425077; cv=none; b=RhmIcdi+1TOuGV7tcfOPdi2HybgQiF3QvLqlincys91QB0soGjVsZzb3LMZVTMNZx6sWDNgFAdG/NrG8aqJnj4odPfRtyBSGXOsDdbbVkWNLnqQsAsh6NQOcDK4XWQ8lXH6IfmGOFoDjwt+KFadGp5HN5YYAR6T2ajqERVXUq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425077; c=relaxed/simple;
	bh=l1mgRgTkN8ibyOmrI2U8ICgqZ8jNCJjf4AXIG5UKOOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA0OrpZyT9BIsZUZeVm8bvdHOrtv/mTc0ZwzYDh5LSUwidXv3OzMj94px6oCoRjgUWnpeR/p0L4DPjzq3O1rpW44XLuiSKy1nwaIN069HfeqaHZt+ZQ7WsibkqvTY8TKZeIms1Egx6mdCXujo0yAvtN/8/0xF2I3l9zOWPeF6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqTcX6yN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q6VshcEs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqTcX6yN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q6VshcEs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B885D1F38D;
	Fri, 20 Jun 2025 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750425074;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSQXIummGGVNzlsCGgVT9IBcq7nID/B+kiJMu01+1Kc=;
	b=AqTcX6yNIvUhKCT7xKzzK4cJ9OZC+8hvr7JazK7ra76Qb0agPjyZGm2fpL4Aq+shHiFuDI
	nLNt6hbsyoBhTj8GqVElhyIe7e4Jwq0OYzX1IPFISzAYPLwWfBIsLdcHY6cec6BQuKcAyY
	E4F80bw/j/HuT2GyA2uAtRZFy+VIfrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750425074;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSQXIummGGVNzlsCGgVT9IBcq7nID/B+kiJMu01+1Kc=;
	b=q6VshcEsnXYQ2mHJ6DHA7swlulYtuzBtCLUQynWeRTK/5PVKdVm1Lt+A9rf7chlec4s/ag
	bgZMcYF3K17taMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750425074;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSQXIummGGVNzlsCGgVT9IBcq7nID/B+kiJMu01+1Kc=;
	b=AqTcX6yNIvUhKCT7xKzzK4cJ9OZC+8hvr7JazK7ra76Qb0agPjyZGm2fpL4Aq+shHiFuDI
	nLNt6hbsyoBhTj8GqVElhyIe7e4Jwq0OYzX1IPFISzAYPLwWfBIsLdcHY6cec6BQuKcAyY
	E4F80bw/j/HuT2GyA2uAtRZFy+VIfrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750425074;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSQXIummGGVNzlsCGgVT9IBcq7nID/B+kiJMu01+1Kc=;
	b=q6VshcEsnXYQ2mHJ6DHA7swlulYtuzBtCLUQynWeRTK/5PVKdVm1Lt+A9rf7chlec4s/ag
	bgZMcYF3K17taMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D62136BA;
	Fri, 20 Jun 2025 13:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FOw3JPJdVWiRNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 13:11:14 +0000
Date: Fri, 20 Jun 2025 15:11:13 +0200
From: David Sterba <dsterba@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] Folio conversions in extent-io-tests
Message-ID: <20250620131113.GV4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250613190705.3166969-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613190705.3166969-1-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Level: 

On Fri, Jun 13, 2025 at 08:06:59PM +0100, Matthew Wilcox (Oracle) wrote:
> extent-io-tests is the last user of find_lock_page() in my tree, so
> let's convert these two functions.  test_find_delalloc() is quite a big
> function, so I split the conversion up.  We could combine these two
> patches if anyone has a strong opinion.  There's no more use of 'struct
> page' in extent-io-tests after this.  Compile tested only.

Thanks, the patch splitting is OK. The conversion is straightforward,
we'll fix the tests so it works in the incomplete environment.

