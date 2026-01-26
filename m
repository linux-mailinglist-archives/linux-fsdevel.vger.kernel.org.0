Return-Path: <linux-fsdevel+bounces-75525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDGSE+vId2lOkwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:04:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917698CDE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF9F3013249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4D2BEFFF;
	Mon, 26 Jan 2026 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hu6UvO5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8F288C08;
	Mon, 26 Jan 2026 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457892; cv=none; b=Azw1MEVxtNcQdMuvXgJOOG23JM9svYSvnPkJeUBfT1m8kZzGaVxn8lis5d4oesf/EyouOreeTzv0plgdaOAFPkHgjvBMEeAYiP4/l6LlPKPH5ngKUa/rJYjQsJL8zljxNmzaqLT65RrJCLtUQmVhM1jyr8BaS9+374it1sItm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457892; c=relaxed/simple;
	bh=Qgitda7HeemsJndbjdX5t1c7WSfPT3w4xoT/j8RNL44=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pcZXT/iuD4iNbZAYbjPgz+FzS43Gjh8TADlYKizRFhkxwnoLLASEQQMBFCoO3tTpjDMO1LhDKejhA7JMj+0qNkoD94+T/wwp5a14peYj0Q3sMzEIzzu+XwrzDBO03ghjJLkXv4WbTVQ2wfFwhCaHTHVZoXHAsZC/v06r7/rp2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hu6UvO5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FE5C19422;
	Mon, 26 Jan 2026 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769457892;
	bh=Qgitda7HeemsJndbjdX5t1c7WSfPT3w4xoT/j8RNL44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hu6UvO5xnqQiH3CnmvkFr/5tCKZy2ceKq0jxtcpi559Chj5lkWBPtWjnW19p3MWQV
	 6InR5lpiDQaQBKzN0eQbX5GAAcHMnXNdbsZRmtsH6vHgNPcpGxQu2d0nGAbSJQ7FIp
	 dxN7nzl45vL1Yoj24Tx89+XNVu2RCmvl/mXP84Bk=
Date: Mon, 26 Jan 2026 12:04:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shardul B <shardul.b@mpiricsoftware.com>
Cc: <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dev.jain@arm.com>, <david@kernel.org>, <janak@mpiricsoftware.com>,
 <tujinjiang@huawei.com>, <shardulsb08@gmail.com>
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
Message-Id: <20260126120451.0c28a6deb3ab532dfae40a24@linux-foundation.org>
In-Reply-To: <19bf8d68cdb.ae2c0d37126486.8380742359510867201@mpiricsoftware.com>
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
	<b2b99877afef36d9c79777846d19beeb14c81159.camel@mpiricsoftware.com>
	<19bf8d68cdb.ae2c0d37126486.8380742359510867201@mpiricsoftware.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75525-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[infradead.org,kvack.org,vger.kernel.org,arm.com,kernel.org,mpiricsoftware.com,huawei.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpiricsoftware.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 917698CDE2
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 11:16:08 +0530 Shardul B <shardul.b@mpiricsoftware.com> wrote:

> Hi Matthew, Andrew,
> 
> 
> Gently pinging this patch. I’ve checked the latest linux-next (next-20260123) and the akpm-unstable branches, and it doesn't appear to have been picked up yet.
> 
> 
> The patch has a Reviewed-by from David Hildenbrand and fixes a memory leak in the XArray library identified by syzbot.
> 
> 
> If there are no further concerns, could you please let me know if this is queued for the next cycle?

There are comments from Jinjiang Tu and Dev Jain which remain
unaddressed, please.

The leak is a rare and this is a minor problem, I believe?

I'll queue the patch for some exposure and testing but it appears that
some additional consideration is needed before it should be progressed
further.

