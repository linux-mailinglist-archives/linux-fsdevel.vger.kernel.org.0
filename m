Return-Path: <linux-fsdevel+bounces-10269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2539849975
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE7AB27F44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433B1B94F;
	Mon,  5 Feb 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ScYfqAMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594C1B802
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134457; cv=none; b=sbOmSkM3C0usw9hMniSHO17dD7VLj0rw/wWdLM7URDWVFWjRbB9QfKYZ94VktS2zlZ3cHYxJdOYV1v2GPalAYCvt2rlOoIvH9aESXybiewMPJXTP0irVowMvZXGvcpSbRBnDnp10MA5NQiN/yTdEFE3tE/qsUrnN768KrD7h7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134457; c=relaxed/simple;
	bh=8yyxMSOs3qWOaGUw5qHXDfU3IDhvN5PI+y0YVXHZLhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxa2KKUqcewtmGJRVvC8/cJ8ApcfHZGpOVKqmHmhPHO1veUn9ZWTj6IZusploctCKPyo8oag3D2aoBXfG6W0ldbXUO2hy6FAJFhXCvILIHsmBD1gVmQTR6d9VVu1R1TsMHYB/v0lmrWGpNyVsjRBWrQ9E12qHzLySmo05cvjwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ScYfqAMn; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TT4hY4MLLz9t0W;
	Mon,  5 Feb 2024 13:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707134445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnPUfGz5HCEPrHdpxix6s8phXI5/yxsCHOSTi1sP9XY=;
	b=ScYfqAMnYwtJHz463Q1pp3iTre4db8Kod/U6A90QIpn2MI5ir900vZKUm4pPqkJddq883+
	+l6/uLUvD3oRi4GL32YOJzqE3724lQeOdU4BeweUukOOE+4/RER7vGw9SSMi1W6I0YKKbc
	kbX5Hx6YbKm5k14Sd4SAP1OUo8eAsXWhAhuU++4ZvQ3cbyl24rtXHBzHNaErr73Xupfc0o
	+R/b1bc3rgy0RK9hcEFy3QQ/U6VzCCyNQaTDu4F8Vy4S9V2kS1FQPP+Knp4HnOZgLs4R8R
	kDdpnxdqO8w9mxrT8GsBWZL/StPpu61gP5TI0kvGc8/9lixh5yQFVWIAg/aJ+Q==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	hare@suse.com,
	hughd@google.com,
	kirill.shutemov@linux.intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	mcgrof@kernel.org,
	slava@dubeyko.com,
	p.raghav@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH] mm: Support order-1 folios in the page cache
Date: Mon,  5 Feb 2024 13:00:39 +0100
Message-ID: <20240205120039.4053661-1-kernel@pankajraghav.com>
In-Reply-To: <20231206204442.771430-1-willy@infradead.org>
References: <20231206204442.771430-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TT4hY4MLLz9t0W

> Folios of order 1 have no space to store the deferred list.  This is
> not a problem for the page cache as file-backed folios are never
> placed on the deferred list.  All we need to do is prevent the core
> MM from touching the deferred list for order 1 folios and remove the
> code which prevented us from allocating order 1 folios.

I rebased this patch on top of the lbs tree[1] and ran 3 xfstests loop
with 8k XFS blocksize on a 4k PAGE_SIZE machine. The tests ran fine and
nothing stood out apart from some known failures.

Are you planning to send a new version of this patch (there are some conflicts
with the latest baseline)?
I can also add it along with the LBS minorder series that I will be sending
out in a week or so, if you are busy.

--
Pankaj

[1] https://github.com/Panky-codes/linux/commits/large-block-minorder-6.8.0-rc2-v1-8k/

