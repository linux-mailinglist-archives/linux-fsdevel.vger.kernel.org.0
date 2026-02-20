Return-Path: <linux-fsdevel+bounces-77760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFLhJiiyl2mb6QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 02:00:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE691640AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 02:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07ECE3016CAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B601ADFE4;
	Fri, 20 Feb 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjwci2ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FB1A256B;
	Fri, 20 Feb 2026 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549210; cv=none; b=cobPKdjvZUV4HjFmNf/OFjHb5xOwPng02qfYFnyy+osMHypBM9KKu3YnpF4WEThNIhc7Lm+CIprIucarG8ewQsHb2wIvKBjP5awSaTVXcAedfzZCs1KJpIu7NrcwAwBK1sHHMwlxI96XJqhaMqRmrksYmIl5XXpW6xfHYhAPyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549210; c=relaxed/simple;
	bh=eOc4SSlLD4JQYuo8m1A8COM/4yzoLy66bYtJ+pqVGL8=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=u0aOsIhO6t7qSCxW4B3r9/GFC5oIG30FgRwAKCICoSNosnzse7LlEKtiEOmDL1RPkkZ5WKKBTLCOyETTjjftrR6pqeqdF2kejC+iGrxtNXZJXxUTmr9UlywiPzur9sXgTeIaC3ltgUEXCaxHk/qPmvTTACswaTKao13+sV6ciII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjwci2ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE5C4CEF7;
	Fri, 20 Feb 2026 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771549210;
	bh=eOc4SSlLD4JQYuo8m1A8COM/4yzoLy66bYtJ+pqVGL8=;
	h=Date:Subject:From:To:Cc:From;
	b=Pjwci2nyV76gtx1Jb8+7HyvX/mxA9RL50JxUWCPFpRgNafjQ9MjccqSbwAYjNmju3
	 fAuScPLQU1NpVaZCceENBgdoFh0utTS2WvT7P4A41dpCziokg8SrXe3iMW4lrc/HoU
	 Z1p3FpG6k60zCtnWg1zyN+p4+O4uCTx6XJyxV7OaDiDAdBk/49prrzFYPcCBNQEMZY
	 cDCMAU1SZar5nZHLk0KAnBgCnWpA9Wszs1zwnY6GDp9K/pRT6v9BTmRpJ8454ieH0f
	 vefM4u/3hZKxmQNeReoR82vLUwSgTA82hfRXSOuKQvjaTfX+SwaorilYKq5kOWiFpu
	 LYybwrZvrbSrA==
Date: Thu, 19 Feb 2026 17:00:09 -0800
Subject: [PATCHSET v2 2/2] fs: bug fixes for 7.0
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: jack@suse.cz, hch@lst.de, amir73il@gmail.com, hch@infradead.org,
 linux-xfs@vger.kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <177154903995.1351989.7277473944406826383.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,lst.de,gmail.com,infradead.org,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-77760-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FE691640AB
X-Rspamd-Action: no action

Hi all,

Bug fixes for 7.0.

v2: add rvbs

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=vfs-fixes-7.0
---
Commits in this patchset:
 * fsnotify: drop unused helper
 * fserror: fix lockdep complaint when igrabbing inode
---
 include/linux/fsnotify.h |   13 -------------
 fs/iomap/ioend.c         |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 13 deletions(-)


