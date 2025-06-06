Return-Path: <linux-fsdevel+bounces-50824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E7ACFF8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB748173F6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4C286893;
	Fri,  6 Jun 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyIhiWfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2B286430;
	Fri,  6 Jun 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203129; cv=none; b=QdQWb+EChmJuVPfhwOrsJPLm5gSLY4yiU/bipoktlhH/AKt42cBqQ/xboRPrOSdE9zOlVnXFWZgMQDvnl9YH3dlY/7U5zHIBDkaix519ACawhfGFfaR8gpE+ZGerEBIerpByfeyHGbKjsr3ttgpG7t4nlU8beAdaTtE8BWxNVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203129; c=relaxed/simple;
	bh=C2RRds8EgB1dUIwe24NZgwNpsYUwXxUtmiAokwmmiBE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IRH45Kvyu8OHxa66EehdD2KZPDH9cFA8mbFJLsjadSjPlQjzxuJ3w3kCXvEttk/DxrkwX+Rdl2euvtPjBeXx8e9kbLlA+t9RcjMeQ7ojvIPtjdoBo7boRkZfBRbd26ok1Zt5XcyuB43S+5UKDJ4wBqt8waSexCtHDLABKNx6N/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyIhiWfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45CCC4CEEB;
	Fri,  6 Jun 2025 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749203129;
	bh=C2RRds8EgB1dUIwe24NZgwNpsYUwXxUtmiAokwmmiBE=;
	h=From:Subject:Date:To:Cc:From;
	b=RyIhiWfzwrFu+UandOGhaZtai524vpoFhSAeJQm0QI99ryA3VJzFJFwhvV85CWkZS
	 fAjDLxkG514X9FPmNr3434EioSFF53fFhotvgGldHTjXZpjEgj5PBxEwv9kUgZKAAH
	 ZPZ20l6zMytzU0xn5mF35rKOA2lX7LeJk4ijCPMQB63L7bkrVULeOxM8VcZYRNCVxb
	 g5HVicH4vj5jH2vG3jM3zrUszSYwBE+Li9FFwoPI9x6pLyRY/oagfpOZCwVNQVLnSh
	 12JjU/hJZwj3jS28vWxPaovhRg18u6AHjQAhxO1j5576uLQg4MY0gwxXNVmoCZRnLs
	 YBNv8Vw9/mOKA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] nsfs: expose the stable inode numbers in a public
 header
Date: Fri, 06 Jun 2025 11:45:06 +0200
Message-Id: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKO4QmgC/x3MTQqDQAxA4atI1g0dFWX0KsVFtJkaxFES+wPi3
 Tu6/ODxdjBWYYM220H5IyZLTMhvGQwjxRejPJOhcEXlalfjd9EJowXDkpsqD9770jWQ+lU5yO9
 6PbrknoyxV4rDeB7eq23KNN9nso0VjuMP6ZoalH0AAAA=
X-Change-ID: 20250606-work-nsfs-3e951f888309
To: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C2RRds8EgB1dUIwe24NZgwNpsYUwXxUtmiAokwmmiBE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ47dg+2+1PaGzYL7lNimapNp1aDP8Vjx2+t1dkjdWbe
 yrTWm7t7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI+wWG//4VHpfqig/q8Fau
 PyzHPXGh67dDpw7u81OeJvRZcO2O6B6Gf/p+UgtVmm5+3F+Zt1vTKcShRzOb8YnjSz6Ox8JZ7Ku
 /sQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Userspace heavily relies on the root inode numbers for namespaces to
identify the initial namespaces. That's already a hard dependency. So we
cannot change that anymore. Move the initial inode numbers to a public
header and align the only two namespaces that currently don't do that
with all the other namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      nsfs: move root inode number to uapi
      netns: use stable inode number for initial mount ns
      mntns: use stable inode number for initial mount ns

 fs/namespace.c            |  4 +++-
 include/linux/proc_ns.h   | 15 +++++++++------
 include/uapi/linux/nsfs.h | 11 +++++++++++
 net/core/net_namespace.c  |  8 ++++++++
 4 files changed, 31 insertions(+), 7 deletions(-)
---
base-commit: ec7714e4947909190ffb3041a03311a975350fe0
change-id: 20250606-work-nsfs-3e951f888309


