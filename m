Return-Path: <linux-fsdevel+bounces-43063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C69A4D8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3411787E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698AA1FDE35;
	Tue,  4 Mar 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJIG2tUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73031FAC56
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081292; cv=none; b=aCFHc0nLyIWS7aDrl9ncBfK1sTl2oq57EzIXTtl4wivR1DfrKpB0PF79DnuQfswxpB5vpY808XW5NwWy5gsqVrCRvnA0GYGQ1+jFiRiYtIfG8wOSbdl0ep6/TOG3H2i620Fj8RoDZkHD0EU7Cuk4eVeaQ0PZOn2c/IPbr7xpfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081292; c=relaxed/simple;
	bh=EwGgtj+ZxbdaCKJagQ3OOvYL6faT/y2Jn1BsqvSUDmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXuYhAgiNHzlFsUn4Bz8VlWlKvUqmaJB+YUQ2KFAbNFQ4D/a95qzu+SBPhuQaYdg7Q5Fz2apWFZ2XRRwPxvj2zzCBFlz42PEyeVrtwlR7tNZFUmfr91RXHvFjxSejgCtryRDB94UqFCXjFzKjvYyW5TyoFHpDiddM3ws/235+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJIG2tUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C67C4CEE8;
	Tue,  4 Mar 2025 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081291;
	bh=EwGgtj+ZxbdaCKJagQ3OOvYL6faT/y2Jn1BsqvSUDmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oJIG2tUZjXAAjZCwrgKTM7R+K5yQz/t7DtG2pPgF+eCqSM4ENfM9zpwGtVXh5gDD6
	 pxcGkOiwolgV+9J53fDdX/V34ZGi56apLWrvQAC0C7XifmNJuoCcreZh+iUVUl+l/l
	 pxASoIv9eis5IKm+yixRqWq3gRGm+fEGfo5Eqtun7e27b5FNG4slWOJeKFpC+j+EXv
	 YW7UyqOnDd08w4vKcdMeMu92+0yaTBSg24wbamkjZwf4orcG05XwBdeFsUKoapdzER
	 Gw16uvLIymj6Rpqdj0qj622ReYfuGioqUJbUIglg/y1oemCrpMOUhs9ZeF82oFfBUI
	 3pM734jY76icQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:07 +0100
Subject: [PATCH v2 07/15] selftests/pidfd: fix header inclusion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-7-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=652; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EwGgtj+ZxbdaCKJagQ3OOvYL6faT/y2Jn1BsqvSUDmE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7UrrLH82VXJoi1e3J+Drh85r63LnBPYbfrTpnLTi
 gent82o7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIlWRGho8b42vnOEVdFz/3
 j73ld/d3zZ386ybJuJb9m6rapyE4pYSR4Q7/0521m2r32O7rXThj9oF/q5KdFH/c/RurfTh9hv+
 CSF4A
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


