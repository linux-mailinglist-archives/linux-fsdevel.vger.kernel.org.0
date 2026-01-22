Return-Path: <linux-fsdevel+bounces-75011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPBKMmIDcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:00:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4792465A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC558A3312
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B15732142A;
	Thu, 22 Jan 2026 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEtULGIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21543E8C40
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078939; cv=none; b=LjPV3S8Iul09IwrfpOt6opF6iiMFSzHkVypwavncUNFOzWXLNz71eRXQ18gRtBau0QpSaOEBZS99pbyQzOV2SvTgBqKZTU0TwClB74nJIpxv5hA8hi8NtfJKNGctaJOgyyVvvR7PUjLsYN6tPvMq6UolU3ic1lqeTCtSOlmrZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078939; c=relaxed/simple;
	bh=sspAAtMZsqmtR7yZWADYRsHQ8mHeLdMfskSoahlJDxQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hw2+cbAlxCYY1Q2IUwNoR5nTcBpjT6LS84NB9HYeNHnFKUe9lCgjHZ0ajlQKkj2+W7g44x0IAlxzM34b+PdlJSmQ7USuXgIN1hh+qIF9lvVWRp1s2bj3QJRgxMjcBoN09xMl0065Gcil4tuT0RnJP2MHMdVIMbL4ONxWbvFBqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEtULGIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A44C116C6;
	Thu, 22 Jan 2026 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078939;
	bh=sspAAtMZsqmtR7yZWADYRsHQ8mHeLdMfskSoahlJDxQ=;
	h=From:Subject:Date:To:Cc:From;
	b=fEtULGIN8yEU6xj4VAr153pAUS1m1TE+KtOeYW+uoYw6wpPRnqtjElIoDtuydLcee
	 9C4svi9ZncRqeNc7lG7yn5UkUn8eEwY4HE/HBKwc1y7ZSfOA1VoxRaEpUmYRFbV5Xa
	 XC1StkgpArbQ4GZdM5IhW6snm9P93uGB1cZM9AetiE+yHKA9h5CeRg/CquSEzojqKM
	 qvW3yrMmzYAhkRcrgHoIiOkrpfqQHVSEptWHDY9eIE45V3eioOYSfW5lijs6AE59gT
	 29ZAIJZoBc6o3h/oP0Hyo7VBAkQ8+O8q5lb5tbnz7Eu5uCeR9l5+Fi8SCGPNNZo5tH
	 sG6+mzgeDetBw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/7] fsmount: add FSMOUNT_NAMESPACE
Date: Thu, 22 Jan 2026 11:48:45 +0100
Message-Id: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI0AcmkC/z3MQQ6CMBBA0auQWTtIC2r0KsZFKVOYCFPSUTQh3
 N3qwuVb/L+CUmJSuBQrJFpYOUqG2RXgByc9IXfZYCt7rIw1+IrpjkGn+JQHiptIZ+cJG9tYqrt
 QH84EOZ4TBX7/xtdbduuUsE1O/PDdxcQ9C7px3C9B8VRW5f8F2/YBKnRU9pcAAAA=
X-Change-ID: 20260121-work-fsmount-namespace-4242e3df359e
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sspAAtMZsqmtR7yZWADYRsHQ8mHeLdMfskSoahlJDxQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWMczY9U1x4YWJM0QndXPO2VResUCSuWWxyZ2wN6UNH
 56UH9Zc31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR6g2MDCdOHj+zJ/T9lcd2
 374WfImZt87Q6uBJvR3WzMq/5tW/2XODkWH9nyI11tCUE8y66S+mZXLP31X+XPuNecndYjNnlSt
 vFNkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,gmail.com,toxicpanda.com,cyphar.com];
	TAGGED_FROM(0.00)[bounces-75011-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4792465A3D
X-Rspamd-Action: no action

Add FSMOUNT_NAMESPACE flag to fsmount() that creates a new mount
namespace with the newly created filesystem attached to a copy of the
real rootfs. This returns a namespace file descriptor instead of an
O_PATH mount fd, similar to how OPEN_TREE_NAMESPACE works for
open_tree().

This allows creating a new filesystem and immediately placing it in a
new mount namespace in a single operation, which is useful for container
runtimes and other namespace-based isolation mechanisms.

This accompanies OPEN_TREE_NAMESPACE and avoids a needless detour via
OPEN_TREE_NAMESPACE to get the same effect. Will be especially useful
when you mount an actual filesystem to be used as the container rootfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (7):
      mount: start iterating from start of rbtree
      mount: simplify __do_loopback()
      mount: add FSMOUNT_NAMESPACE
      tools: update mount.h header
      selftests/statmount: add statmount_alloc() helper
      selftests: add FSMOUNT_NAMESPACE tests
      selftests/open_tree_ns: fix compilation

 fs/namespace.c                                     |   84 +-
 include/uapi/linux/mount.h                         |    1 +
 tools/include/uapi/linux/mount.h                   |   14 +-
 .../selftests/filesystems/fsmount_ns/.gitignore    |    1 +
 .../selftests/filesystems/fsmount_ns/Makefile      |   10 +
 .../filesystems/fsmount_ns/fsmount_ns_test.c       | 1138 ++++++++++++++++++++
 .../selftests/filesystems/open_tree_ns/Makefile    |    2 +-
 .../filesystems/open_tree_ns/open_tree_ns_test.c   |   33 +-
 .../selftests/filesystems/statmount/statmount.h    |   27 +
 9 files changed, 1242 insertions(+), 68 deletions(-)
---
base-commit: 1bce1a664ac25d37a327c433a01bc347f0a81bd6
change-id: 20260121-work-fsmount-namespace-4242e3df359e


