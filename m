Return-Path: <linux-fsdevel+bounces-26592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443995A8BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B001C21E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722E614A96;
	Thu, 22 Aug 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QYMYcJCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA324C8D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286175; cv=none; b=Aa6yA/HuKdVSAjhm7sk1uuh8DovU9L8Rtt+6z2cg4bcrzEGtbA/Xuur7qS467Zx8QRntM/g2EaUIAgmB7kqSTmOtn9caXfpXJoa91gM9aWK17aasM4/+MdKck6CwW5nZdwJ8lsH/RX1kjURo4Ht9gUJddOMQGx27SCnyHWpVTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286175; c=relaxed/simple;
	bh=sfrC2AHYyWSrM/CDBfGSrhMBHsFxZSLXetdkILEepgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5TEhA3fNkyK/cWypeAUOFJQaB4McDVbVTA8Ui5shLbYd2yuRAnuQZvnvzD5QZ/kxl2YTOOdOE2zzpvZrNZa49mN5jbrlTC93RguVsRw+HA3iGo6V+flfbSXno6yYNAm+nj4BSYd9Q2DkJpekCFk1lvFj9D/kRpWgJSRmWmqByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QYMYcJCA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HZNQPH/GNSU0e/ykZjoZ4vKojkk4PzK5fqTAISuh+9I=; b=QYMYcJCADazNpaUligxbf/Z9jF
	dhqLqLpqYz3Hta5B9d2EyKkLvvVdracaOzVjhrWLqcxBs/YHAy6SpmYfgPElscqmHQsU0W+mr6PL0
	EE1ZHvuTP6hIKJ6GO5qjKoeh8+usxBB/Fb76gRi/nFKblPSNgm9Db9XIu25MEjFE3xb50btNso1Fo
	nZu1jQA8I2viv+sNs6XFeJ2YXQsEGDr1ylrOozK9h1Yp964pXNRjnKrM6uKbbz/k8Oz4LZqMg5jX+
	MYG3rOP4jFhtLnB/nJL8ASVxypC0iz9SBqnZlbK8dewXzDIhQP7Yxlt1oSmZOQNTJQ6sn7puZ+qs2
	SE0nvINA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbH-00000003w7z-0Z2Q;
	Thu, 22 Aug 2024 00:22:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 07/12] fs/file.c: conditionally clear full_fds
Date: Thu, 22 Aug 2024 01:22:45 +0100
Message-ID: <20240822002250.938396-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Yu Ma <yu.ma@intel.com>

64 bits in open_fds are mapped to a common bit in full_fds_bits. It is very
likely that a bit in full_fds_bits has been cleared before in
__clear_open_fds()'s operation. Check the clear bit in full_fds_bits before
clearing to avoid unnecessary write and cache bouncing. See commit fc90888d07b8
("vfs: conditionally clear close-on-exec flag") for a similar optimization.
take stock kernel with patch 1 as baseline, it improves pts/blogbench-1.1.0
read for 13%, and write for 5% on Intel ICX 160 cores configuration with
v6.10-rc7.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
Link: https://lore.kernel.org/r/20240717145018.3972922-3-yu.ma@intel.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 9b8df3bc6fea..d6f5add1a786 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -264,7 +264,9 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
 static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 {
 	__clear_bit(fd, fdt->open_fds);
-	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
+	fd /= BITS_PER_LONG;
+	if (test_bit(fd, fdt->full_fds_bits))
+		__clear_bit(fd, fdt->full_fds_bits);
 }
 
 static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
-- 
2.39.2


