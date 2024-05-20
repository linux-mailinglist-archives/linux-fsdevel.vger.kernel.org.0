Return-Path: <linux-fsdevel+bounces-19765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871498C9A1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42117281D8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D801CA9E;
	Mon, 20 May 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="VX1XD5fH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A68208A0;
	Mon, 20 May 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196213; cv=none; b=U1nYfwB642mM0eCzjALpHOZRY2gUXZChwyEVk1AZO5WYiOHVz55nILxlzKJE6sLQpmaiAhpmEdZNoN+tc4ZwgK3+CPkcCqX+jP+F9xy0ntjSH/Q8stqJvKn+7uyI846fw6dKyYtL7zkTum6wmOqUhTP5uULdkUkMenagT2Iy2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196213; c=relaxed/simple;
	bh=545Z9tkN34N0Dsh1Q1qIJ26oe7owU6dG5nZ3IvZTHz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzQi+WamN/WOHJhNfVvZcm8vpuqsofZJF26ktCLec0ZLvlUNEwxjiSFNpFwHIaz5Q6arjEiWulBrOe0eTQyz103D0B3tbfb1DLImGRrGMrUffbh5Jlu4z89sga6RDPSdDLS1sfmRsd9ZyWRaeWxDDGQIfYA8o7d5pavvneIoPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=VX1XD5fH; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1046C407853B;
	Mon, 20 May 2024 09:10:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1046C407853B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1716196201;
	bh=ITagZGQ3VHzpt1AUxt0LwozxAebgPmFLksDrhcMgLC8=;
	h=From:To:Cc:Subject:Date:From;
	b=VX1XD5fHx8v2bAF4FE179K/dueE5KZaWO5YqetmsajbMQTTHnHcsB1v2Y7OE1vsL5
	 RmH+FDOFJzdssBBoXv8Lz8IgsqQrVp71nBMfZFZr88CNq36dqUPV2Cp8ANun0wKtCp
	 W7U8qCNUesiy1syEDlUVMWeIqi2wJPSw72t4xqcA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 1/2] signalfd: fix error return code
Date: Mon, 20 May 2024 12:08:18 +0300
Message-Id: <20240520090819.76342-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If anon_inode_getfile() fails, return appropriate error code. This looks
like a single typo: the similar code changes in timerfd and userfaultfd
are okay.

Found by Linux Verification Center (linuxtesting.org).

Fixes: fbe38120eb1d ("signalfd: convert to ->read_iter()")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/signalfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 4a5614442dbf..65fe5eed0be4 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -282,7 +282,7 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 		if (IS_ERR(file)) {
 			put_unused_fd(ufd);
 			kfree(ctx);
-			return ufd;
+			return PTR_ERR(file);
 		}
 		file->f_mode |= FMODE_NOWAIT;
 
-- 
2.39.2


