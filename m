Return-Path: <linux-fsdevel+bounces-12782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAAC8671A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AED1F2C04C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B71EB5B;
	Mon, 26 Feb 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="emMYFyxr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pI0eBKqh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="emMYFyxr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pI0eBKqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DC1BC30;
	Mon, 26 Feb 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943643; cv=none; b=OpuWzRdYYFY/3Ru8BfAWEK8deBIBHgTx9GffCZ55q9Z1UggnszULWRF7t70KH9uFrRDqeBzA0ridv0Su8sJyc6m/xt2PkFMnAg2uBFNJib0vkDn1GC+MzkAw1L9+Yp6BY017x5Me5vZEUyj01px/UpvrSTDdWhIHaoh/Bftgcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943643; c=relaxed/simple;
	bh=NduwPV4+D3ms76rP3yAd5Za/nf/swp2AsEN4c8u1fkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsBSupwx+P3ioMhaQfCh7SI7uZdFfMMHjjCsWnvor6k88IyYitz2sWAEqzm3hQAk640a/3BsHGdhfpxKoFxOXDzi3j6A+QOibInWb9jTE33nM5nJZoRCLfzTngH8FxaidYXwTg+yARvSp0hf25qz30mPJ4lsrPIolmYN0SzQPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=emMYFyxr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pI0eBKqh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=emMYFyxr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pI0eBKqh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A887224F5;
	Mon, 26 Feb 2024 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708943640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEwJNRe5EAwrN8KzGSyLKzC1mGilSe1zlUux9IJ9hCM=;
	b=emMYFyxrO2WgkXpZ68+/sFaHBxFsKF8GNkEr04x5tOHJS0T7GxAcX2yQ++U2KcSU43k49K
	P4yXNi/qyzUTK4QpBrfqhMVugK5hiulIx2/jeTyv4oIcquB5Ve4HnAQkxDxZ+RBxyySq6I
	bTlXV9jQ9DX4WKSl2UDvRn/2uPquwUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708943640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEwJNRe5EAwrN8KzGSyLKzC1mGilSe1zlUux9IJ9hCM=;
	b=pI0eBKqhlCaxFLR0ns1aurRv0b/VAOBu8ORhr5Gje0qUfLmEOEkxDPRk7DxEnkDI210+pW
	wJH3nK9F0VCwX5Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708943640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEwJNRe5EAwrN8KzGSyLKzC1mGilSe1zlUux9IJ9hCM=;
	b=emMYFyxrO2WgkXpZ68+/sFaHBxFsKF8GNkEr04x5tOHJS0T7GxAcX2yQ++U2KcSU43k49K
	P4yXNi/qyzUTK4QpBrfqhMVugK5hiulIx2/jeTyv4oIcquB5Ve4HnAQkxDxZ+RBxyySq6I
	bTlXV9jQ9DX4WKSl2UDvRn/2uPquwUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708943640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEwJNRe5EAwrN8KzGSyLKzC1mGilSe1zlUux9IJ9hCM=;
	b=pI0eBKqhlCaxFLR0ns1aurRv0b/VAOBu8ORhr5Gje0qUfLmEOEkxDPRk7DxEnkDI210+pW
	wJH3nK9F0VCwX5Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E36301329E;
	Mon, 26 Feb 2024 10:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5IxWNxdp3GW3IwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 26 Feb 2024 10:33:59 +0000
Date: Mon, 26 Feb 2024 11:33:20 +0100
From: David Sterba <dsterba@suse.cz>
To: chengming.zhou@linux.dev
Cc: dsterba@suse.com, zhouchengming@bytedance.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] affs: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240226103320.GR355@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240224134637.829075-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224134637.829075-1-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.41 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.61)[98.27%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.41

On Sat, Feb 24, 2024 at 01:46:37PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks, I'll pick it for the next merge window.

