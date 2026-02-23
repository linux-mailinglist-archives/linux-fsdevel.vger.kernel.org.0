Return-Path: <linux-fsdevel+bounces-78016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sETpOjjcnGkrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888C117EAC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A204B306C7EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546337D110;
	Mon, 23 Feb 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjSAYEg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7243330B22;
	Mon, 23 Feb 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887651; cv=none; b=KG6Dkoow1Pq0QolLQmBDbv1NqBA9rscMijGqUTrlxopYaYCtuIxASXQ8lKxxvONAZALS6FnyPJ6Ma13N7UY+qBW0a872iPsy3ourZ57kwL99I7iPkc5isEybSp4Djvxit9tAxlN8xkivcAjCmp8CcplyTorLgeser+OeKqMvI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887651; c=relaxed/simple;
	bh=9HVAzDb00eNGfsPwVwJCwiFQi56si2iPirb9y1aaOc4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7Yzv+8jGzexo0+jcCaR4TU24jmL8ECFqyC3KfzzgZLSo8kVkCO1Azxs1wJDUvLNnuGEk4qrHtYWRQCnNb5/PK6Wz9RqLmngYneS7dlq4sUUf6AvhnwYn4O3cylBBIy7tcgeA3dNYIvu0mGHuPe0w7Bu6wcyNNtbfWZWeZyEmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjSAYEg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62423C116C6;
	Mon, 23 Feb 2026 23:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887651;
	bh=9HVAzDb00eNGfsPwVwJCwiFQi56si2iPirb9y1aaOc4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RjSAYEg9ylqcfSrdOX65Iq+avufhDTittqvac5FkVWLdeYmIOtsS15uLFz8/kNWF5
	 CPb/wvZbJSBgg05jMbo5rTtbouNrHeHjuLO4Xlw2yESR07DS7zCoqRVMf5kSvqpY8S
	 ZSdnV5P5lJopajP3U/TkDSkxWw3u1ADCBc9CtVFnqSGmRr8zNQeZl18LU321xzLKG7
	 T6cM8R8fuuqnU81OXnhb3H6MXFxZi0KLwWF+0KgXbg2GeoWmhu6c823ZweBUPsPxTz
	 0Rk0I+55Ksu0QrxPmbq9hr1+J5ZchonWizbBd5GH75xggziyXpQEGDecE9KMfmT2I7
	 22C86N7pGKjFQ==
Date: Mon, 23 Feb 2026 15:00:50 -0800
Subject: [PATCHSET v7 2/9] iomap: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org
Cc: bpf@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78016-lists,linux-fsdevel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 888C117EAC1
X-Rspamd-Action: no action

Hi all,

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.
These patches can go in immediately.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=iomap-fuse-prep
---
Commits in this patchset:
 * iomap: allow directio callers to supply _COMP_WORK
 * iomap: allow NULL swap info bdev when activating swapfile
---
 include/linux/iomap.h |    3 +++
 fs/iomap/direct-io.c  |    5 +++--
 fs/iomap/swapfile.c   |   17 +++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)


