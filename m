Return-Path: <linux-fsdevel+bounces-37882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194759F8795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 23:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA9E16F3FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 22:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1D1CD1F6;
	Thu, 19 Dec 2024 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOqu2148"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE274189BB5;
	Thu, 19 Dec 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646310; cv=none; b=Cw90AzbF7j1w8nNx8OOqQ8z2wuUl7tn8YrfGZMn5HoUP8Du2mbPgVwJ0R4sBV5wPK4sAE71nrw1W2g8KWTYznHhkh1K1U4U7FRBrMJEuWr5Xwq+5At2l3Y2L3EZc0mpDo+j1oLVMarFf73VeeGUKU3u/fmkjSL6UTz+J+v1RGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646310; c=relaxed/simple;
	bh=CwQO2tuAbFruVfWpVEOsLSkckT/e9nIDGitbrWb7Aas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sd4mq2ZFPTqTsGsjDdWs+MQFXhI1a60TQFOzzLTjE50IxHYC3ZiXxxWJcy8p24oHRhlhU1nsu9hVDhuUPcX61ndRJCi135ow+r0PFYlM+K3008ffO/tGaNQBdTunCodwaZgG2NXjItDZU3R6/YCCJ6vVNMmVOx1XNZO4tay+HNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOqu2148; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064AFC4CECE;
	Thu, 19 Dec 2024 22:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734646309;
	bh=CwQO2tuAbFruVfWpVEOsLSkckT/e9nIDGitbrWb7Aas=;
	h=From:Date:Subject:To:Cc:From;
	b=HOqu2148/tCzC5/wtEP+Yy7uUNvkZfHFdDiYfW/DLqUEvJFgTZ5cBHOYk5Um9LnVB
	 gvODeDPdlb9ks7PwypDoj+ETdS+bqwDcVdFhdloZdDKaMiTS83gFbHJs9sHudYZMRt
	 AI3ybZaF+It/EGO1sw4gh0M4OMnL+2cJX6jnM6q9zwhTS2lUmk2aiRkXnEARv30hxh
	 4qr674gdO5OS8RJP6JyuUH7O0NgpomYzxwN535apKCwx1I2/BUY1K3y14zT1MZXouM
	 oNBYzVVW8/SV50piKy3NyBUH72Cfvlku1lsnzic8hQxmZHcsl8fKOQWkRFNetLuFZg
	 WA78H/gwH8k+Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 19 Dec 2024 17:11:40 -0500
Subject: [PATCH] samples/vfs: add __SANE_USERSPACE_TYPES__ to mountinfo
 program
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-statmount-v1-1-9fd8eab3cf0c@kernel.org>
X-B4-Tracking: v=1; b=H4sIABuaZGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0NL3eKSxJLc/NK8El0DAyNjU8NE48REMwsloPqCotS0zAqwWdGxtbU
 AysshIFsAAAA=
X-Change-ID: 20241219-statmount-002351a3aa68
To: Christian Brauner <brauner@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CwQO2tuAbFruVfWpVEOsLSkckT/e9nIDGitbrWb7Aas=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnZJokIb9iomv5XV0hKRlDaAmbF7TXd7PluLvKZ
 xs5vZX/A9iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ2SaJAAKCRAADmhBGVaC
 FZoSEADDyJfwyoxZXeJzahMKzTUw/mYp4oyZxRVwvDWO/jEcg3McBDS+dzN//Fg714vGtqOmfbD
 AuQZX9s9u5WS39lOulBBDl6YRxVaR7vkaKcwafY48fGcfbjK6AFprU0cYMeCUivn7rslLronW60
 SFnk6OElijDjnhJ5935yQm0/YGCZYzG8SaHxDut+kW3MOQR31YzAQYAA8CIIVshXxlyRMNQHNUV
 bIyt9b6P/mi32vIHGx876qRCEMhbv34jyYRt42TT4auumcX4aNrcbvoAvSuXXjpmFhxvjSLA+hu
 25IqIauR+QBzMU79/HyRozEffExM7zmssAQslDpuXlj0tT18GNWZIQulU4YStDk99/G3sqDVqpd
 aqVDyv04MKooPbJ3CjMU5oaWLk8pU8ABlLtHEFQmPKNRz9VAr+fHVD+Dm525bstvxJp77mvl74r
 ioFgKo4RoDL139b4NOkZWk/gj+zzSSA3veuew2D9xmAXUM3G+pDytu5YjcjUFAqxxebg6xJ6H/g
 /nSN4WXLlGGjbuSno92UV4ntQRNPH7zf7ysz2E00Wkk3uhz6DrS1Tkr0P5GnGHBZ9d8yJIBURH5
 bb8bLhZGYF2s8cYRWbjzIpDVMJH0JMJvXHoaRQ0Gu5XGruozh2iFcrervZtPsUqUp2Lf96vwazZ
 bpbtYEqec5IBBJA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

mountinfo.c is throwing compiler warnings on ppc64. The comment over
__SANE_USERSPACE_TYPES__ says:

 * This is here because we used to use l64 for 64bit powerpc
 * and we don't want to impact user mode with our change to ll64
 * in the kernel.
 *
 * However, some user programs are fine with this.  They can
 * flag __SANE_USERSPACE_TYPES__ to get int-ll64.h here.

That is the case with mountinfo.c, so define it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20241211143701.5cfc95a7@canb.auug.org.au/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Feel free to fold this into an earlier patch if that's easier. Also, I
wonder if samples/vfs/test-list-all-mounts.c needs similar treatment?
---
 samples/vfs/mountinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/vfs/mountinfo.c b/samples/vfs/mountinfo.c
index 349aaade4de53912b96eadb35bf1b7457b4b04fa..2b17d244d321ee759543cefa3c9e84e7cd489c9a 100644
--- a/samples/vfs/mountinfo.c
+++ b/samples/vfs/mountinfo.c
@@ -5,6 +5,7 @@
  * contents of /proc/self/mountinfo.
  */
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
 #include <stdio.h>
 #include <stdint.h>
 #include <sys/ioctl.h>

---
base-commit: ef5bbd2a286805b0f97b5fa8616d28a84336ee7b
change-id: 20241219-statmount-002351a3aa68

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


