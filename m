Return-Path: <linux-fsdevel+bounces-78486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IJxCd1RoGnriAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:59:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 380651A71EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EFAB307A831
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5CF396B66;
	Thu, 26 Feb 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1V3nzNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74138553F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113816; cv=none; b=PXLg0Soxpn/0cS1gHcXPm8VFTrMdCl8qvoGqZH5Iwn4eNvsEuIrE5r/lzxNINPMgJjVLEdGo1XAIvvp/wfxnre1AVPRT4l9cp5JlW2eB4Gpcat6fNPX0PTvPEHhqlM0pyLRe7eNbS6zgm7d8QRN7X/VYfBIBMqCQYenulZTEuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113816; c=relaxed/simple;
	bh=NfrJzT7rNZsBa3DySUgdQc/sjJ3Z4fiLFP6BFZcKCqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nbJwzKAvOA14RYroICRrlHApxrpsRVjTC9N6f2RFKY9o8UG7jQ68TR9HY2c2s9rl3t/F00zppO4TUd4Jd1ijZwftpLcKijo99CNRHGlGGFkWysVyZSL5nxiUhV1L+VTQWNJr6SbbVKyfJnCvTe9kQthUmh2q8uvg/I9DNv2cYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1V3nzNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D50C19422;
	Thu, 26 Feb 2026 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113815;
	bh=NfrJzT7rNZsBa3DySUgdQc/sjJ3Z4fiLFP6BFZcKCqQ=;
	h=From:Subject:Date:To:Cc:From;
	b=s1V3nzNtb1L37TkXz6MF0LI8IJS38/uSlnABtsJyT2cIsxX/bEakcy6D8NvaQMo9Q
	 R56+2WF4FN83SNbl+YwkyQXPr2UIDNanWDYCd4YAwBPL3r8o8J+ovEFy3qtrAKTn02
	 aFx9YbnNkeGt92USso+gFwCkj4SXp6nyGVKFSDvGwjk2MSoc87fs18d1WxC2g8QfS/
	 HLsNwnIG5k41ySrhp9T8gIIop/2CABULDcP3d9jZG1A8b71/3Zurgd++1iYbMJx5ze
	 tlAznx9pt0BYE26aVddWHGL3iR3mKypDY5z9n1ekmhHrRSUP50xbVhNS/BrlGjfkXT
	 BDAbW/rKHeXwQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] tighten nstree visibility checks
Date: Thu, 26 Feb 2026 14:50:08 +0100
Message-Id: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBPoGkC/yWMyQ7CMAxEf6XyGVdpVJXlVxCHLC41S4vsUEBV/
 50Ejm/mzSygJEwKh2oBoZmVpzFDs6kgDG48E3LMDNbYzljb4WuSKxbP843TB3t+k2IbQ2xj17v
 d3kDePoR+RZ4eT3/Wp79QSOWsGN4poRc3hqFEd6eJpJ63tUEJDazrF66UefKbAAAA
X-Change-ID: 20260226-work-visibility-fixes-4dcd4d6fa890
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NfrJzT7rNZsBa3DySUgdQc/sjJ3Z4fiLFP6BFZcKCqQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8J+6gUX2kXJ/waSsDbXTNme0BR57wKj697K+eMMEo
 4mndtR3dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkpTDD/yLpdMf6XX8ttjVx
 XPun80/mp/LF7akTr5ulT7p5nq1742xGhv7aU5uS1vi8u63u+ers0hTbXwcClCbaLEk445O3OvK
 eDicA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-78486-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 380651A71EF
X-Rspamd-Action: no action

Listing various namespaces is currently only scoped on owning namespace.
We can make this more fine-grained so that we scope visibility even
tighter. To make it possible to change behavior restrict visibility for
now. This shouldn't be a big deal as there aren't actual large users out
there and paves the way to make this even cleaner in the future.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (4):
      nsfs: tighten permission checks for ns iteration ioctls
      nsfs: tighten permission checks for handle opening
      nstree: tighten permission checks for listing
      selftests: fix mntns iteration selftests

 fs/nsfs.c                                          | 15 ++++++++++-
 include/linux/ns_common.h                          |  2 ++
 kernel/nscommon.c                                  |  6 +++++
 kernel/nstree.c                                    | 29 +++-------------------
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 25 +++++++++++--------
 5 files changed, 41 insertions(+), 36 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260226-work-visibility-fixes-4dcd4d6fa890


