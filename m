Return-Path: <linux-fsdevel+bounces-25644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D253F94E70A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B4C1C21D25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62D163A9B;
	Mon, 12 Aug 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X2LdiexZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8E1509B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445072; cv=none; b=Uz1Zsc6P/Hqd3te5605avJyLAR3/DZg6187L8n1mHDiC+m18uofhuqmSI0Io2piFSltx2zbotHuGzhhLTROwB9TxrnJBfxJZlFFf9uOkOsREldfv5P52bKBcUz5dHgTOJMJrVzgUBRLzoTsAxNWIwBu7mGZdp9nPYSO6fRVkgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445072; c=relaxed/simple;
	bh=OoMkfFG7NYPDQeGPh9F2RtPQfrI1qGuFCoG97+Vpxlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSkaVlns0yQuMaXyyflVUZ1BPksrlOUBd0decQs3bV4muEA6+nGoAJifuDGTcXAwZU/BRtSzIr8SbHh8NyUK6eP4odugeeCYyg+jOdCmumUMwhWLuzCKZJ9wYyzuzQBADqy0tAim8OOHIYXbFTbbldqk4C8FWfQy+tunTXmgQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X2LdiexZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ea9+Pbrzm8vZKUAnqdPEgFi3DlFNn7sRdg4QsDGH8vo=; b=X2LdiexZGykV5tsG9z/QJ7jpYt
	71m9sDxd8ft05mT8jaNo3ZATYjHCkGsvWF33nq/gTdtnIlEfhmaxoni+stegIc5jcdYDb8WaDVduK
	uJCM3IlgYb1Z/4sZwABWwnAFqaEzqgriVsSEkJQFlfhstDTPDvfgF5dzTranWJwV/gHfwBWzFsi0J
	qA2OAuo9UufnnwSyWI3J/L7ql3aI1ZkS8dcFMc94cCgGs/eNvs0q/q7unRn+XZMxOhx0I4SFwfALm
	smpOjL/C4rq5o2CCZqeTENTlVcUoqyjEPLdcSC+fbo7h5G4RcAmTf8sJ9tMbReVpMxxhj/fLBSHyk
	IJDCMRpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn6-000000010Uo-1zvF;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] fs/file.c: conditionally clear full_fds
Date: Mon, 12 Aug 2024 07:44:24 +0100
Message-ID: <20240812064427.240190-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812064427.240190-1-viro@zeniv.linux.org.uk>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
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
index e217247006a2..0340c811b22a 100644
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


