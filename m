Return-Path: <linux-fsdevel+bounces-33519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE79B9CF5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4D6283070
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E81714C6;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f7IG9YX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA314A0A3;
	Sat,  2 Nov 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524113; cv=none; b=NwYbiiabsGTr3i1S7c95dHJFju7n5nQmXJpi3hCy6U51vgBH6AkSgrOz84nmKzK1uc4fUkrRn9JbowPZjQSXzt0FZVRbgVPam9gs1gLbhchdUUvgJQQYvEqZMcww0AT1Lkcal6WDbIK07Ek+ojAQbol524SStxrrtudLhv9ihgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524113; c=relaxed/simple;
	bh=kmP/O8pMiDqzuhxnSC8Jj6kuvHOB5P5vsPnSc+Fu76U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIVQvbPoAxjxJoB76dPVZnrZx8hyaq9PLGRk74FFle4Rl8zy6zX3K96yqYRCimOaqgpbL7jWoYZhfe/+WPVXBNOb8aUNpsL+rm4kuaS2vHpcGoSpanTRHBxGx0nOKEQ8P4DyzHvEN+ktEM41zug264/tXxEgJ8Qk+o24WlpCFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f7IG9YX3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OlO3jEyVcPM9sCrMEEkt+tbalx/lSQNjgIEnXISohIU=; b=f7IG9YX32GPRyNKlAJ3fKC0L9p
	n+SY+6XjNOH/UFvTuzzCkiiLKhZNOhhhYL6XBDO4ZXbEcTKsili1Z7nwEQfvM8gtdNrEdy1FFrMht
	uDfpepnkxKcAmTZc67583DcI4NmRXrmuIViSl7eMncOl5nJF14Nnulrk3UoaEgqegUMNEfNbEmB58
	jLkoSDOcLHFm66t082ff7B+f+lPTeBKsusdkA7ExQ9Q/Xe5kclIqLmLmBMBq2WQiKDJNhVCP4F5K2
	NjGnJupYrImx5GZiOtGTdUDZuhO2j7Z0LWbPfkJ9TUEWP/IPjN9NUSEYdpxxE5PJhGGl/05JPZ0Xb
	BHYgGM6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NB-0000000AHnN-2JVQ;
	Sat, 02 Nov 2024 05:08:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 17/28] convert cachestat(2)
Date: Sat,  2 Nov 2024 05:08:15 +0000
Message-ID: <20241102050827.2451599-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fdput() can be transposed with copy_to_user()

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/filemap.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 36d22968be9a..5f2504428f3d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4421,31 +4421,25 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 		struct cachestat_range __user *, cstat_range,
 		struct cachestat __user *, cstat, unsigned int, flags)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	struct address_space *mapping;
 	struct cachestat_range csr;
 	struct cachestat cs;
 	pgoff_t first_index, last_index;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	if (copy_from_user(&csr, cstat_range,
-			sizeof(struct cachestat_range))) {
-		fdput(f);
+			sizeof(struct cachestat_range)))
 		return -EFAULT;
-	}
 
 	/* hugetlbfs is not supported */
-	if (is_file_hugepages(fd_file(f))) {
-		fdput(f);
+	if (is_file_hugepages(fd_file(f)))
 		return -EOPNOTSUPP;
-	}
 
-	if (flags != 0) {
-		fdput(f);
+	if (flags != 0)
 		return -EINVAL;
-	}
 
 	first_index = csr.off >> PAGE_SHIFT;
 	last_index =
@@ -4453,7 +4447,6 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 	memset(&cs, 0, sizeof(struct cachestat));
 	mapping = fd_file(f)->f_mapping;
 	filemap_cachestat(mapping, first_index, last_index, &cs);
-	fdput(f);
 
 	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
 		return -EFAULT;
-- 
2.39.5


