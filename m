Return-Path: <linux-fsdevel+bounces-45646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A058FA7A4D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7F61899977
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8424EA92;
	Thu,  3 Apr 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVM0mIZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFF24BCF9;
	Thu,  3 Apr 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689367; cv=none; b=mBHZf6A084D8F2hoXi1s+/XBR1F8Mmv9bI0EF6xXE/0XohIMBM6QAcGg87Jq4i9Zs/QbXXpPLLd+qD4kdMAgyg6qNyngVBjjqWSycQMmVwVQfBAbKOv/8m76KExWPdQxvxZlR3jhgksucZH+bETuRAl/ofORgf/H8y1/HCFV0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689367; c=relaxed/simple;
	bh=sVzSWqusPxOyyV8D1tYxU5XLC8pqRwnYykgplHuHVU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O79nwixpwMQxhE+i8m7qoYsFiDgweV3fDRH87Ym898dbgByeNzXxVcp8H98KHxC15n06qkGI8x++/ty1vdRJ/qkV4oNNTSZIELmUnMOrUKMcQlshySqbYg/6yZkB96mA9Lq4ZRw6r6w+4/RE/ZQF23y2dj7Gk0jlZxVPnOHPDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVM0mIZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F8FC4CEE3;
	Thu,  3 Apr 2025 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743689366;
	bh=sVzSWqusPxOyyV8D1tYxU5XLC8pqRwnYykgplHuHVU8=;
	h=From:Subject:Date:To:Cc:From;
	b=uVM0mIZUMrK7Rn3twgUuK3SXqbm1RErHWIWFMX6UF4nONVKpzqGN/Fi1bu4HCZYWO
	 jEdrycWxoN1tyC2sMVPbVkikWByiKXSCZqv2J6SWUx8zYHfhOc67v+gmzpvlpXrmkt
	 DJx1U8B4fwm9ne/80P1AdqMeUohIVlAZjT3/VAXYMlhym5bFdTlEQeDJn03vhStEmB
	 M7Zc0shpiI3XRf8kgTheX1LHds8ZBCc8JsxvOSfGFy5dRfJVCqGXed6hxFsMUPMynX
	 BOL0kMpLrcfTflElIYMGzvTc1IY77BSjtRBV9Fym5ano2hjJgefJa9Edzp4N6tDH7W
	 ANmAo35Gc/pPg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/4] pidfd: improve uapi when task isn't found
Date: Thu, 03 Apr 2025 16:09:00 +0200
Message-Id: <20250403-work-pidfd-fixes-v1-0-a123b6ed6716@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHyW7mcC/zWMSwrCQBAFrxJ6bcvkMxu3ggdwG1zM58U0YhK6R
 YWQuzsKLus9qlYyqMDoUK2keIrJPBWodxWlMUxXsOTC1LjGu861/Jr1xovkIfMgbxj7LvlYt4A
 DqGiL4ncUq6fz6UiXMsZg4KhhSuO3dg/2gO7/Udq2D7XOOs2JAAAA
X-Change-ID: 20250403-work-pidfd-fixes-54c5b13ee0ee
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sVzSWqusPxOyyV8D1tYxU5XLC8pqRwnYykgplHuHVU8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/mzalrDh0e5nPJT/V6TXKv9c8Y41mS5fzMj0iWq1xL
 XOpDmthRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES0Whn+522Z0Zfa7nlIMuG8
 vZvIixSFzEWad17s3TnHjlvB00jekZFhaqDwIb/0ne2VTU0v+Sqkt8pcCuJd7aGW072g7Ws5cxg
 nAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Oleg,

We currently report EINVAL whenever a struct pid has no tasked attached
anymore thereby conflating two concepts:

(1) The task has already been reaped.
(2) The caller requested a pidfd for a thread-group leader but the pid
    actually references a struct pid that isn't used as a thread-group
    leader.

This is causing issues for non-threaded workloads as in [1] where they
expect ESRCH to be reported, not EINVAL. I think that's a very resonable
assumption.

This patch tries to allow userspace to distinguish between (1) and (2).
This is racy of course but that shouldn't matter.

Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (4):
      selftests/pidfd: adapt to recent changes
      pidfd: remove unneeded NULL check from pidfd_prepare()
      pidfd: improve uapi when task isn't found
      selftest/pidfd: add test for thread-group leader pidfd open for thread

 kernel/fork.c                                   | 31 ++++++++++++++++++++++---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 13 ++++++-----
 2 files changed, 35 insertions(+), 9 deletions(-)
---
base-commit: a2cc6ff5ec8f91bc463fd3b0c26b61166a07eb11
change-id: 20250403-work-pidfd-fixes-54c5b13ee0ee


