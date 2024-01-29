Return-Path: <linux-fsdevel+bounces-9326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99D683FFB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70952B2329F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9052F7D;
	Mon, 29 Jan 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="CvaSyzMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A2524D1;
	Mon, 29 Jan 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515793; cv=none; b=DyDkCZ6yJWhWhDh16vjIrxeGHutEzoVDCE8pE+ZmnUsqj/xLa03kE3ZkFOceras0oHGTUX4LokfHrSmH/riuqWQ2fzRucXccoSoTJ5ODEg0tfvQXM1iHJ4bzeLN+hEm6I7rQbDJr7nBXl//b6J+ZFuSylwAOfaOh8Arnx4frMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515793; c=relaxed/simple;
	bh=KX95JtnfIp7j8VPbIRjew5/zzGHwozjZO+7zxqvr6n4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=MaQJhnH63sIoVgy6pw1smoRMH5aHXeREmjNlOOnCuyLsxh6n7sVp8EWnED+nDx8Ql8KBdRke5LrVsGLQmaF0VuOJk0X5MbkgCwSfrMjqckT0DzHoEREM8IZVwgNYPDBpEJvjMEhGMA8HV+9kJcOoJIVCJN/1ycuS7We+obto2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=CvaSyzMn; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E9FB3211A;
	Mon, 29 Jan 2024 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515380;
	bh=OOsG9oL5dHVVYoMwTwA8sDDvVQSxjrxSXBRzmTmF2nw=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=CvaSyzMnnyoXfENdmRZuDjgsGfGg6Hucbb6A9eG1C8gZkkMh7b9EryaYA41RJvThq
	 FmGP4pdlWQtHvkJ93jZSeYSYg0cl5IZgxk9D6r8exkhSv638R3/uK4eDlhQN2NW9ay
	 Gzy+6XGAMsTuGr36+5vxEm3RsJGusY68D3f6I7/w=
Received: from [192.168.211.199] (192.168.211.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 29 Jan 2024 11:09:49 +0300
Message-ID: <75e61877-b616-4227-bca6-83580442d822@paragon-software.com>
Date: Mon, 29 Jan 2024 11:09:49 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/5] fs/ntfs3: Update inode->i_size after success write into
 compressed file
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
In-Reply-To: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Reported-by: Giovanni Santini <giovannisantini93@yahoo.it>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b702543a8795..691b0c9b95ae 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1054,6 +1054,8 @@ static ssize_t ntfs_compress_write(struct kiocb 
*iocb, struct iov_iter *from)
      iocb->ki_pos += written;
      if (iocb->ki_pos > ni->i_valid)
          ni->i_valid = iocb->ki_pos;
+    if (iocb->ki_pos > i_size)
+        i_size_write(inode, iocb->ki_pos);

      return written;
  }
-- 
2.34.1


