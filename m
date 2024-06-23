Return-Path: <linux-fsdevel+bounces-22211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227C913B7A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08EB1F2395C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B719DF6E;
	Sun, 23 Jun 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePeu8DFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8719DF47;
	Sun, 23 Jun 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150350; cv=none; b=BiZblf6e7DCZ3z0XgHZl5XFFf5vdrf025JEmNOLyzV16MJrRxPujXKKfheby4sLcBY7aWJMfQyKMfs3DhwsbWqhm4ns7eNyNxtdKMhAQlvZrZ/Jx8mBv5wadiRIAzaxdHHADiU+fHWsgbI44kr35AckL8+At5evxs6k/6liyylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150350; c=relaxed/simple;
	bh=1arlDtgHpguiccwBbCbrhGnXQBqQ3up1z1HOu96MpWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fy2Sj/rD1rylOb+WvFSzLtouhKC15EgpsGlM8MqFXwXUueW1SVwejRsDq2V11MOiTDTNbNnI9restyeTzuXwNQ/vIv6YjLZtiKLk/YgRdYfzrwpPWBsGBmzhDesRD2j72gZJt1sB3nQ4NYDmtNO96pd+rLIXfInJrKTCS5POwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePeu8DFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE14C32781;
	Sun, 23 Jun 2024 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150350;
	bh=1arlDtgHpguiccwBbCbrhGnXQBqQ3up1z1HOu96MpWE=;
	h=From:To:Cc:Subject:Date:From;
	b=ePeu8DFzS2ck/0P5aHOOZQWHUPukG1HoRy47N88LleS6tvLlPtnDezEdS+KA0lLVX
	 WUlDH+XLB++BxiRw7B0e6lDCsFQhk7aKx+pC0lHFq2y+SpKMl9H9JECphDRSAELMN8
	 irBHiEATW47jfMMVQmUGrV49uzNMAjA5D2j63Y/T3a6vnOXdcMrzDCVBpqokU6jFif
	 soK3mC3tDp4iNm0IJc50IJavi+k0lnYV/hJVzE2EKm41oi9gulUqPwzEco5TTzG2LF
	 Y0Zpy/Sv7KmiqQlcJLtT957mLvSQKIgx8WJd855ayBvM1atssSDndQmWjtNmJHQoj4
	 y49mAM9KlwIhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuntao Wang <yuntao.wang@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/2] fs/file: fix the check in find_next_fd()
Date: Sun, 23 Jun 2024 09:45:46 -0400
Message-ID: <20240623134548.810179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
Content-Transfer-Encoding: 8bit

From: Yuntao Wang <yuntao.wang@linux.dev>

[ Upstream commit ed8c7fbdfe117abbef81f65428ba263118ef298a ]

The maximum possible return value of find_next_zero_bit(fdt->full_fds_bits,
maxbit, bitbit) is maxbit. This return value, multiplied by BITS_PER_LONG,
gives the value of bitbit, which can never be greater than maxfd, it can
only be equal to maxfd at most, so the following check 'if (bitbit > maxfd)'
will never be true.

Moreover, when bitbit equals maxfd, it indicates that there are no unused
fds, and the function can directly return.

Fix this check.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
Link: https://lore.kernel.org/r/20240529160656.209352-1-yuntao.wang@linux.dev
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index e56059fa1b309..64892b7444191 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -462,12 +462,12 @@ struct files_struct init_files = {
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
-	unsigned int maxfd = fdt->max_fds;
+	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
 	unsigned int bitbit = start / BITS_PER_LONG;
 
 	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
-	if (bitbit > maxfd)
+	if (bitbit >= maxfd)
 		return maxfd;
 	if (bitbit > start)
 		start = bitbit;
-- 
2.43.0


