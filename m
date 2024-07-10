Return-Path: <linux-fsdevel+bounces-23526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C637F92DC28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 00:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F112813DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558614C587;
	Wed, 10 Jul 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8gKaQ4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEDC1411ED;
	Wed, 10 Jul 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652256; cv=none; b=b3e1uJeYI0eH/nxkACE0MhmP09sG7obxEjHyNWPc2yD6mJnLiZq4xsaJZOz/iFF0yPXBTJwqNFVfSLMT+3KFF/yqyku3tK35lrwgQeAoZpIr81CZlM4H8S7HiBYcIaZexkdl6gOHnCkgKuiNrouyKDapiKl9qOK11+6fQTECoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652256; c=relaxed/simple;
	bh=xHfQpE3xnJF7fWEh0n0J1QrO+PZas6vV4ZW3I9ZtpZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQOCFdMvOqySSXo40XnFonnA9g63XdBlNWPR4qcNwbUG/py9IaxLG67QvxjzZ557zsCg+pHVOjqwwYin17q6hPPZ6g2YxDM2Ji53r4cfhFifsHgze/gKPczdoMW6sJVwD5bOhM7n+1F7vplFTOT9laGn/49A5Oo7ozMBLFL2ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8gKaQ4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C36AC32781;
	Wed, 10 Jul 2024 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720652256;
	bh=xHfQpE3xnJF7fWEh0n0J1QrO+PZas6vV4ZW3I9ZtpZI=;
	h=From:To:Cc:Subject:Date:From;
	b=Z8gKaQ4mTKgEhNCOJKOba/oe1stgdcATlXWJX2XHnfRn7gt9HtKcefChc+F6GuMiS
	 MI91x6J43ntE6Kob9FZ0cdGtFi8vo31137jai2GGsfkjO3J2fiaLkqvI8gfbcrZofI
	 ww4Ahlaxkw6TFgb3AnRUJZHlZAf4d3R4XOIXn3GuLaEmVQcmE/5sJs2qQayNibxGAn
	 Wuwr8hGn2LizhfoYG97zWEFKkafr3wfxRVWNnbd/Q5AiLA0Ms0VBPPqXjvOIn1Y/yC
	 GoDK3PfCnOsmn1WdHEephrAf9DXlkdA76PmDmRd4+/af4/USZT/Rb5MP2yG6Da2NAb
	 LFtecA1KPqFxw==
From: Kees Cook <kees@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs/affs: struct slink_front: Replace 1-element array with flexible array
Date: Wed, 10 Jul 2024 15:57:34 -0700
Message-Id: <20240710225734.work.823-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=kees@kernel.org; h=from:subject:message-id; bh=xHfQpE3xnJF7fWEh0n0J1QrO+PZas6vV4ZW3I9ZtpZI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjxHeHmcuQywgqLp8HMdNBeLul7wqgYoZ1uj89 wp1bnIf+VuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo8R3gAKCRCJcvTf3G3A Jg6ED/9c9uqVWx9EySx9CD+/gkUqazxEwzIeT7Xy8xGSHekpK1WaxjU0Bcj3rJhYspgaWNDnWtb Hrd9ScHA1k/K2CNvwf4GKaKoc5LErlQoNt6QrY6HWKXNY3po/VaPoQnlqYW+287aK+Qh8rU9fG4 /XWYLPqNbNj/Oan4FyiaUJjZ8bDRNMpsMWvQzDsZNFA5+HcME9mD4RqS8kmbPY4oGV2xVwHqMZ4 lFqso/phiW5zJvkJdFLvdHbDqQ9IegLtHAraM+tFhnP/zdVu+HLCsCZRn974Ig0rYYBZdYlHVMo UxUvU6WMRoLWJ2ajyNdV7qMheAvW/KQ44Bi/7UV32KMC+LnEjbo+cpirmrX4OazlZlc4AGGLA1a S81ZQ+bbQ3npTklsLe1OsEllyL6ZJFp03Y9RMo9ySe0rkgslOS1De7te8VDTP6acY1xBdk7XS1/ aWfgSQQhtyTzDlKguxnaiAaODBX/JuzVIEwdlrLRQnXXRfsxGbhJqFSBMVHeJQMbISTnXU+WND/ Fx9kvluC8OZsTZZqwvk5dGa56Rk1yphj5asmIfgsEE5yOg6KYTpRmA/KJXQbeTmTI+O5LEDjh7V R9c/2k/eDUSxmF96d92hKpFINDkxjBs3+TeWgVgksax3j5O9CaVht55JnTm1+Zekpkxky/pUdx8 YHvZ0RTWpOI7iD
 A==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] use of a 1-element array in
struct slink_front with a modern flexible array.

No binary differences are present after this conversion.

Link: https://github.com/KSPP/linux/issues/79 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/affs/amigaffs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
index 81fb396d4dfa..5509fbc98bc0 100644
--- a/fs/affs/amigaffs.h
+++ b/fs/affs/amigaffs.h
@@ -108,7 +108,7 @@ struct slink_front
 	__be32 key;
 	__be32 spare1[3];
 	__be32 checksum;
-	u8 symname[1];	/* depends on block size */
+	u8 symname[];	/* depends on block size */
 };
 
 struct affs_data_head
-- 
2.34.1


