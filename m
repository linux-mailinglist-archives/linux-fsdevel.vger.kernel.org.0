Return-Path: <linux-fsdevel+bounces-43064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ABBA4D92E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788103B85F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0461FE463;
	Tue,  4 Mar 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L78yF2mU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166D1FECB0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081293; cv=none; b=TXE+WLs0+0hQ9ySHSELnWzwNNnv/LbHy7YdsjcWOAV1lulL+lAafoUyS2msLW9FkdwH05I2CN5RZyUIR5jDKttqJGYC2vQJnSsl2IqdRzv0ylfMyFaxvNL1zauFdQ+OazBDZP7Bli1vJvMzirzOUL2h53hPPZrrS59udx+OIw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081293; c=relaxed/simple;
	bh=/DPEsZvaOBJV0BlsE7mEEfJBsCIwh9zyCd6k4r1+RVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lc2ZrlLjxFJJ5tyNGUG7Cv7QYgWmlrEuVrJU909NZA9GDMSzDOMDOuVVPYvd5GzJmU471sYOvPrXyKOc79N7wD240vdY53Y0U0ftvXoUAWzG53RclDyZD4+2twrcqqcvOfbja3WDOSrAr32IFRHCbJRt+unfSGsTBNp5Q61O1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L78yF2mU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B763DC4CEEC;
	Tue,  4 Mar 2025 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081293;
	bh=/DPEsZvaOBJV0BlsE7mEEfJBsCIwh9zyCd6k4r1+RVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L78yF2mUMd9R12k6jQJ4pdwfU1DBTcSOvHqb43ONt8f8dqEUmoMs98tGQk76UWcza
	 qYLnF2jMAPSaC13zfOjiT88D9NfaKTGJT22MHQChHTaZR6RO+LhqQpDGU2Rrwk4efu
	 RCJGyEzMJ9R6TUwxM9CqUgOJus+9qmbnWblXv3dZh6NjAW4NhMGq/8wMkk96ayhHcl
	 y3lvs86IIHP7BBoyBxA6zDcCJa0ni5hleolVX2fCTFFD03+iF/3LbiuvTVx/tUmavF
	 yq2W4u8xSFNsr3kXsWMOG7aaXhzaVuiXKPkohILA/EbTs5dry67EY9a2A177sPt0vz
	 JkJcVbpaOE1bQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:08 +0100
Subject: [PATCH v2 08/15] pidfs/selftests: ensure correct headers for ioctl
 handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-8-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=653; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/DPEsZvaOBJV0BlsE7mEEfJBsCIwh9zyCd6k4r1+RVU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7V7YuqaV7vf5ptv+8BzjOHspzP3Vz1pY9hQtCnpe
 3gHXwdHYEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBExNgY/vtejq8z/KjLmSFz
 yuORiPvftD3nJvMoiD9ekVK0IXDRy0UMf8UN9KZURHyW93NdINy1rzxUUW7RPKNtR1nDTrJ82l4
 iwQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 222f8131283b..d9e715de68b3 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,7 +16,7 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <linux/ioctl.h>
+#include <sys/ioctl.h>
 
 #include "pidfd.h"
 #include "../kselftest_harness.h"

-- 
2.47.2


