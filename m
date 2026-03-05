Return-Path: <linux-fsdevel+bounces-79515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OYMEG/PqWk+FgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 19:46:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D61CD2171BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 19:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DBB43083873
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15547288C22;
	Thu,  5 Mar 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blBtrORm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CC27816C;
	Thu,  5 Mar 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736356; cv=none; b=DlJM7jEbELibix8Fq+2eivhsQ5Ky0A+9XBCoStPPGrSbkX6ZgHrDUw/NpxhLA40ijvRNN6oku7uX4mZZ7+TTHMtie8RP4IFSUgvNAlg9OolSH+1Am5NHlibq4hMEoRfQWDUHP19ptaiFHABpwCjz71T9dJfdPIkJ5JqysaUZugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736356; c=relaxed/simple;
	bh=/JZtaGTNaubBIZLf2TxD2AYjHwTUAxj9GYdDzvsJ/2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YXfK9xNYSCWkTd0XZAaxhvpaC+uUGgmH45mG4W3BfTlb+mjhaNDwtgiuNasHynK/bltnW3gF/YFEJu4PceYjsPRb7wdwN/qoIrKyM/fXiIabBNEZOVGhiNTRSlW4Pxj/zByV7uJm0/FT2FuE4Pi0H1eSPL6j/zMydeeSdUg9oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blBtrORm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0B0C116C6;
	Thu,  5 Mar 2026 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736356;
	bh=/JZtaGTNaubBIZLf2TxD2AYjHwTUAxj9GYdDzvsJ/2U=;
	h=Date:From:To:Cc:Subject:From;
	b=blBtrORmnPJHME1UBrV396lAzBW2rhXDrM4PfytbGIIHjFWJMUw14xKlHvPvRIfCR
	 bG3Xa8m6aNU8I06LtgkneHcgzvu7T9np1QU5NmtxbYv/vdxwknY+egTq8j8QXjd1DG
	 9yOx1ORd3YPALcUpHqyKk48nXAFJ40wmtIP5bt4XJCEQJQzbIP0LOg9n6EYOBk2wR9
	 TvD2pt6DJEv4SFajraMdfBRv4cS4HWdvTbgFVMUSmXCBBc1hoGG1t7Chh7xEV80dYU
	 66zUbYJlYWjUAz6/76PemMEKCvm6sR83E7hJaSmt0b/fL5UztEBT6tTF95JgI3aou/
	 hd/WDtBRDGGGQ==
Date: Thu, 5 Mar 2026 10:45:54 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] fsverity fix for v7.0-rc3
Message-ID: <20260305184554.GB2796@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: D61CD2171BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79515-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to a300000233a9ff842e2fb450fb9a79f7827a586d:

  fsverity: add dependency on 64K or smaller pages (2026-03-02 21:05:34 -0800)

----------------------------------------------------------------

Prevent CONFIG_FS_VERITY from being enabled when the page size is 256K,
since it doesn't work in that case.

----------------------------------------------------------------
Eric Biggers (1):
      fsverity: add dependency on 64K or smaller pages

 fs/verity/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

