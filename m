Return-Path: <linux-fsdevel+bounces-42850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F92A499B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B4617314E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E726D5AD;
	Fri, 28 Feb 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvOTZ+sa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3E26B2A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746675; cv=none; b=B2ppMXeZnbWeuYHN+di/xNCsjU0SgrNWixdFuTUl9H1XMrNky4QaGoFe3U1mmqK8YqHW2up4fQYo+yGJvxYU+SAlxQqZ0ouoVYwjFuNdaDA9gPIMuxGS8dfeNLsn3HQs+Mm5zvw/r1nx/EADI06glEN1BxZgCdFcjJNoYvIe6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746675; c=relaxed/simple;
	bh=EwGgtj+ZxbdaCKJagQ3OOvYL6faT/y2Jn1BsqvSUDmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1zaArGy+WD1TNUAvkg4M1uIv8rVrIc2UbfuT6ZdEaESonpayHBCcK8g2wQxb4V/xHlySUxXwvzsVoQp+7N8Ox1Y6D5I7lfHuQkBYbinTLDmcNE4nk7uEgO0xuzlP+S5Xt+nqPTLkenAIb9MquwSc85LaUAK3jkYgW1VSyA4vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvOTZ+sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D87C4CED6;
	Fri, 28 Feb 2025 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746674;
	bh=EwGgtj+ZxbdaCKJagQ3OOvYL6faT/y2Jn1BsqvSUDmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HvOTZ+sa3DecZxR3IusUnrEwwhvrijf2IqqPnI1y1HEaziLv6Z7C6o8k2kZRXBf5+
	 zuNAu/ysFONJm1A7dY4PWoHYzUxiwNrTvXQKFpVqUT91U3wFdAzSbjYFJuXxttoaCq
	 gvZDdpB2TY6mugmMDTehBYkR6P+Qzt85DnZmTI/D7gLEhUcs9gAslAS36xfFl+GMPz
	 TaW9t/0MXbZZCokfPFSNUWrsYYVJWYe3uj8m7wUwBVu/S0oLjjPHZdNW9v05NZyaTQ
	 Grx3RLGNOzd+N6tcmKIwgTN0MuRBKQe53u6+NkjlA+BzIlf6pmy3kyOgB25qkdv0K5
	 nPrnK3MvQFCEw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:07 +0100
Subject: [PATCH RFC 07/10] selftests/pidfd: fix header inclusion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-7-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=652; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EwGgtj+ZxbdaCKJagQ3OOvYL6faT/y2Jn1BsqvSUDmE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL/osNEFNsOiVktdvu9f7G0O3WiuOXc8ne/L4ccBk
 eKXA3WqO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi9IXhn9KUlPrQRzlc55wN
 LtwWyLuV9lDoQEyw6OnZB8+KbIuJvc3IcPqFKq9KI+/DI313tp3gklzKeZD7+GTeiMcvOhr/cqt
 vZwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that necessary defines are present.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..f718aac75068 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"

-- 
2.47.2


