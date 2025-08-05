Return-Path: <linux-fsdevel+bounces-56784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74825B1B8BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFCB3B313B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4E292B40;
	Tue,  5 Aug 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="roDjajwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B119D092;
	Tue,  5 Aug 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412330; cv=none; b=d38NtF5SnaoII4UoEnxdjqUqOBaTF33Gb32bmVqBbRnXirh/qdeqoohqzmsSVEfP+D1l5KUExX+jEWBJ7Sp1doc7pt97361vq2QlnM7Na/X1b62sTHa466OKkPaWebk5+bsDpMI6OIT6VkIB4aZLKBYn7bC3c/15C4kh0G2+BjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412330; c=relaxed/simple;
	bh=LFg7MFcO0J0LZb/wEhiYWa4wNLbYTp0vBBrkKJI+3ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqFRSXHKSG2Dz/z4MYNwGIwmdm+1qznv7IDCKIf8Ta7aOB20WuJF59HdSvMmSMBeJ4WGIYri8udoiZ/YC5F1A7OKdCfZ/TyjW4CZ/6kjZ/qdnIx919Kv38F9aLxZOQ4NmuMxgcQ45I+B10Vj1rmSHixAQ5dEJolNHsHN7O+85qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=roDjajwj; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxK6X5ck1z9sdC;
	Tue,  5 Aug 2025 18:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754412324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poZwT6MblsVSRVpERcjhs5+NftgumjYF35dZqBxHGO8=;
	b=roDjajwjxXKIMJil0XdOl9b4ozggpon82xjydVUtx4IOopOMhsTZssDGKgwqqk1YTURTMa
	JAmzsckHUMC4XyAAGzLbWtNRn9QtxGs65Yh98kpnoXnaR9hEFbezMn1OV8bt3/BVPSJeDP
	ZY6ymsqbESsyZa3wQFzCG0zVWqexoVQaw4VZSunzclHOsjmAA7gysdAGVQ5vHY2NXT3CU0
	uncLyannIsWEuzhYdLgrAg8z0tb+4eeW3BhGQ5ElxnQwB/V9m6IE6bzEPITqabeQhDZS19
	oq9t4m5rJWaXBFlnscxNDcB8ye2DhkMxZJcZU9QHL+r23z93jGuJtOIobIhkWQ==
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH 1/5] Add manpage for open_tree(2)
Date: Wed,  6 Aug 2025 02:45:01 +1000
Message-ID: <2025-08-05.1754412136-new-crusaders-selfless-clones-granite-belches-fVzACz@cyphar.com>
In-Reply-To: <20250201024322.2625842-1-safinaskar@zohomail.com>
References: <20250201024322.2625842-1-safinaskar@zohomail.com>, <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2025-02-01, Askar Safin said:
> David Howells, ping! You still didn't add all these manpages.

In case you're interested, Christian Brauner maintained these man pages
in a markdown format from 2024[1]. I sat down this last weekend and
rewrote them mostly from scratch as man pages, and resubmitted them to
man-pages again today[2].

PTAL.

[1]: https://github.com/brauner/man-pages-md
[2]: https://lore.kernel.org/all/20250806-new-mount-api-v1-0-8678f56c6ee0@cyphar.com/

-- 
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

