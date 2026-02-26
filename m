Return-Path: <linux-fsdevel+bounces-78485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OtUMTZRoGnriAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:57:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B41A718B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3351230EFB99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41683815C5;
	Thu, 26 Feb 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPDf0StV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E136EAA5;
	Thu, 26 Feb 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113529; cv=none; b=DfLd44K7qPYA34fx/AEB0e1AX0L1hx/WiL2P7d5pDkhhCb5pvupR0Z1WDbX/VIt1REPAOtgjFb9WejV1t6j8EAZJgJe30m2bB+Ynm2e/KXhwTuEIPoFR3NFeLiLn5dl9BkEoLTM8bDM9djrirkC7QTfrFssMyX2TaEXw9rHQOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113529; c=relaxed/simple;
	bh=rup12gGR0lyxuLpKZ73Um4PeGi0DSjgis8QpTEBii28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lR9RtHM5h/bzSlCpsqg7XWR2oLZFfNRsWBgT0fP599IJibSs0M2bovrZVaR1Ywl9yOUoZfTQjq+MZ+vrp7jNw+JwQg1nDIDnPkOglIxHmYa6qTsM6aFlD/CZ/vNaTHzA5RnmVYknieBZklTyl9+qWgmf2kA43Lv5mBurt3YNO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPDf0StV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7D8C19422;
	Thu, 26 Feb 2026 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113528;
	bh=rup12gGR0lyxuLpKZ73Um4PeGi0DSjgis8QpTEBii28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPDf0StVaoSLPNm1xoZwu9cVQA0rURYYuysiCd/sywaJXA8p10TQVE85xkG39f+RO
	 F3KDI/t1Hh7fqjDgxWlNpeTNhcf9RQi1ZjHZlt4xUIyEvFEDvOHbbwJJFN9FgxFNtQ
	 ziEzZmBrQp+DShfAfyahbaxXdcyckoREY8KG2nQO3opU1w8OITu+O7fVX586d+ooKV
	 J3l8Fo9I16dBEtv1O728RKjJ2OWrai3n1nZe8596x2adRfWIxPJKPRod4IxHRe8ocF
	 UnLL/6yVvOoYsm4ZwLSvR8RLQXFGjNwMaaGbnZm8tH6z0jeBpXMfWAb2GyYgR5I0zA
	 VcqoXYObIL/jw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence
Date: Thu, 26 Feb 2026 14:45:20 +0100
Message-ID: <20260226-kursieren-aneinander-ee650cc41d58@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <58526.1772112753@warthog.procyon.org.uk>
References: <58526.1772112753@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=brauner@kernel.org; h=from:subject:message-id; bh=rup12gGR0lyxuLpKZ73Um4PeGi0DSjgis8QpTEBii28=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8Cs6HJtSv0l7W2zAhOn/e/2Y2TUiTnPoLuW5czVvz XJz3q9HOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCPJmRYZvA91miBy362lZv 90t4PWU2k+cdt5iYGd7PpWp8TLKWXmL4K/b392K91gVNFxOPTjvG61zUqznB0JGp/amf4YFzq5L duQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78485-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B8B41A718B
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 13:32:33 +0000, David Howells wrote:
> 
> Fix netfslib such that when it's making an unbuffered or DIO write, to make
> sure that it sends each subrequest strictly sequentially, waiting till the
> previous one is 'committed' before sending the next so that we don't have
> pieces landing out of order and potentially leaving a hole if an error
> occurs (ENOSPC for example).
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence
      https://git.kernel.org/vfs/vfs/c/a0b4c7a49137

