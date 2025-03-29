Return-Path: <linux-fsdevel+bounces-45255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E00A7552C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4946D171321
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43119DF98;
	Sat, 29 Mar 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3ZK7qz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5084149C55;
	Sat, 29 Mar 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743237803; cv=none; b=KKw5BmdAKVGMucoxAzhS5jl9ipvys5DNinmP3R8eyp3Mh/vgRunTwYrOitgp8mmVZAZWiBW2sjbIdZXPTvrw/NQBPlqOtXrJmgs4YLD/2C8FLX6PwBVqYJ3zGWC9Pjgnv5IKkwUP3UqG19c0Q7Nbxx+6UeErK0sU+U04x7Xv8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743237803; c=relaxed/simple;
	bh=wFN9OIyWwNbSBORPJ6nncMe0fBBQIRJE7fQ0HC06jkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPLfDI/6A0vqD8z2UttgQEfzzpRAxXhInGGNipvr6HbI5vSx4EMVfAjibhrLAQdZCHm/J76nT3vYn5RPmE3hP39/pQANhN1IHM3XbGq8Sh+9n1fduK+LsVcG9XTJ+pi21+UnKdgXDbkXj7NG1XkP0OqYCG8Dd8T2xAKYzfQp838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3ZK7qz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C689DC4CEE9;
	Sat, 29 Mar 2025 08:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743237803;
	bh=wFN9OIyWwNbSBORPJ6nncMe0fBBQIRJE7fQ0HC06jkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3ZK7qz+8MC0riPsZg0GYIUJk16oM1aewi0aV77yrkicsZUaGmi7+EGu4C7F2OeeM
	 QzMSuXEwrzkIVsvX8dCjS/9Je4H1b2l8jQF25RBlVY0/i6L1mBpd/H8F8DJKZ0rhpK
	 Y6l1Vib7vAKG5MdH4gCxlDhQi5sJdalCPMyCVmNX5oQObRRt8E6OdFHNIMDY06wLPW
	 Jq5eaXazghOVcEN+abZPRGuFyLDPaaQ02vv0WaPrdHdsszD/8vMDyA1Sabn78bEl9u
	 2GjfV/9mtdt5/M37gfQB610w0/PzUcZ+hSvrWl2yw/ysjT0DKmHj85kSxFUcLNRD26
	 z75CQD9x+lJRw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH v2 0/6] Extend freeze support to suspend and hibernate
Date: Sat, 29 Mar 2025 09:42:13 +0100
Message-ID: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250328-work-freeze-0a446869cd62
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=brauner@kernel.org; h=from:subject:message-id; bh=wFN9OIyWwNbSBORPJ6nncMe0fBBQIRJE7fQ0HC06jkA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/31TxmH2NYZN9u1jARb+aGyKuaRvWywoJ/ajO1w91y k7omqjXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEpdxj+ux4TdYydnLpGI9RM 5mFOTD338b7Pa6YVyd96o7FOheVfB8Mffj/VSboBXJadUlN+Ta+11/px4OSpBUFsi++tfVcf8HU vNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add the necessary infrastructure changes to support freezing for suspend
and hibernate.

Just got back from LSFMM. So still jetlagged and likelihood of bugs
increased. This should all that's needed to wire up power.

This will be in vfs-6.16.super shortly.

---
Changes in v2:
- Don't grab reference in the iterator make that a requirement for the
  callers that need custom behavior.
- Link to v1: https://lore.kernel.org/r/20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org

---
Christian Brauner (6):
      super: remove pointless s_root checks
      super: simplify user_get_super()
      super: skip dying superblocks early
      super: use a common iterator (Part 1)
      super: use common iterator (Part 2)
      super: add filesystem freezing helpers for suspend and hibernate

 fs/super.c         | 201 ++++++++++++++++++++++++++++++++---------------------
 include/linux/fs.h |   4 +-
 2 files changed, 126 insertions(+), 79 deletions(-)
---
base-commit: acb4f33713b9f6cadb6143f211714c343465411c
change-id: 20250328-work-freeze-0a446869cd62


