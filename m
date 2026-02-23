Return-Path: <linux-fsdevel+bounces-78031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP6UFRndnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0F17EC15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C131C30576F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95037D132;
	Mon, 23 Feb 2026 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjgGGWU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7E34EF00;
	Mon, 23 Feb 2026 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887886; cv=none; b=oICl056rpz7YtA5/XHutV18kyS9DEt1R+f71MQX78+jiTQvRZklwjY/6mHSemKl0KhMLSoUOfagG6JAxUfhNPbehVjzCT1vs6xie8QUKOvLEnXiSfLN/d9v6uamHdvM4FscQ7UFQgjDqVPh1QO5aFli0TMOJKBbs7/BAClppdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887886; c=relaxed/simple;
	bh=ho5QpTGPUg+JgNvlZf0ECao5lpqMW1MMb8MIkYM1m1Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8zPsAlPWO4f6p3rE/Mma0Jn78SHYgjHRXlCQ86lSslN4+GqbL+NpFX7DLOVZKlkieoKaGNSYYs1fILxMEEBLdHb6F3Jh1jWNechXeshQ7RiWGBLGqzpAjh1QY5z/iP1AQBVn2Dx3w42ldFlYrwoyUZfSR5f7HwZW6E9Tp1X7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjgGGWU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24375C116C6;
	Mon, 23 Feb 2026 23:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887886;
	bh=ho5QpTGPUg+JgNvlZf0ECao5lpqMW1MMb8MIkYM1m1Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UjgGGWU+OfALias2fLtVdAfOsRzsm8Vzuto+mHG853cAzAdjVln1qfLfqAprdEEoz
	 VYNi0zcc8xuODKsOpkCDUJg1AXSBtKzhu9XzIRppcztlMQtTeKlCPD+m7USB/ZIqaD
	 08rx09w4hbLC89XgXPsaOsituvCGSOJDjwfjzXfYFRPXIbbKi89h7e1p1nmllG5rOO
	 N86qE3JEdi6cIQMgvwFMHDKnb4PW6OxYuU+mGVHXVz/yXGAm7cTi9HmksVmoSkL5ra
	 RhO8Kbbz337IyARKz5xN53K5nEHhU+kEO7B1DLWEzOnM1yGUloLNc9VNejzQ6FsQFE
	 lWQITcHnGNB3Q==
Date: Mon, 23 Feb 2026 15:04:45 -0800
Subject: [PATCHSET v7 2/8] fuse4fs: specify the root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744965.3943927.10298806606780785317.stgit@frogsfrogsfrogs>
In-Reply-To: <20260223224617.GA2390314@frogsfrogsfrogs>
References: <20260223224617.GA2390314@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78031-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2F0F17EC15
X-Rspamd-Action: no action

Hi all,


If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-root-nodeid
---
Commits in this patchset:
 * fuse4fs: don't use inode number translation when possible
---
 fuse4fs/fuse4fs.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)


