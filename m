Return-Path: <linux-fsdevel+bounces-29845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9014697ECD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21834B214C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22CF19CC1F;
	Mon, 23 Sep 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hhYytb/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27881AC6;
	Mon, 23 Sep 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100409; cv=none; b=I3kn6vTNUOrmYzzmL1GuTfW6NI1Q0VVHseOTYSLQM6EbOvVMIAmBXYo+nXR8rRjV83WJus5/7ueUC0KF//ADPvm421HTu9O6nia3TeQmrzITwVRjGSXfMXBSkbCwjCXD34b06AMWJ9o+rVdMWNhH6kLJZMWhiTiYix0NYJSMWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100409; c=relaxed/simple;
	bh=amYk76ox76gJLUUut7K6mpi34lPE4CePWuLirmUPGAQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qiFOFxVwNz4wvtDwhV7jdbe1MzmdCAjPe/3GAxXaBxc1YVtzJazxSbJnJF95WTB/nbZHdNfgzS7jP2aFg48HKkvuM0sY7qywim9l9e3vOaqy6VTxexy8sEAMa24pQ3rXDaQ/aGXUHDClwMzTyGuUI8X8ddbHJS7NBNmYvLJvHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hhYytb/o; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727100392; bh=tEta8O3+3KmFyhduT/iL/N1Z/7jFQgZWLhvul/eqDVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhYytb/ovDWeHpvnfCG1yrwqTbgabcR2KClHLeBRkNUNJD0oRMuoSBPdPau0o+a7N
	 y4u+X9tMDtZvE8M9gOBwOdKT6NCuDINm+SP9NZVk9Y2ydrGcciGzmELMq3tMlyPuAQ
	 X61dtw0RPbQs6zwJftlMmysKF00D/qHbFTKUjl+o=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 150B9038; Mon, 23 Sep 2024 22:05:16 +0800
X-QQ-mid: xmsmtpt1727100316tbjv39guc
Message-ID: <tencent_E58DB7922A5DF0DDAB19394FA78D84A5FC07@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J29T6jwAe0wk440ePxrnwkamRGpbnOFtjdbWrBPgRgs5m//TIIG+
	 49QMQ9brBDQJ0944GmTIP9QWwcOz/1eIA02aBGk0UJnGRkO3ccGmFWwP65+SF/2pmGaVI1iBy1zz
	 tqK4hVNM3aglPTNeZOYOYFNiZotkM9vvizCYS5WHfxzRzmX05RSlmjzUdEILeg0yR7joGTT0x/86
	 ssISIiSXXyUzxA6PHVuUNCiGGpZ4RMaU95PcO0fNqNJ/Jyk/r+a4SgrBsXmSR84Rh/Bb4OqJPmp2
	 5HiwLCYnPAIjpR+qipvbokrd++21bUVI3buKmoh2Sjt9bAUkHqx/jWjJbcWCncKK0Y4okLjik5VG
	 H2fVy7EkSssMW6K8ZoqEPkHr7uiqb8bHfDRSWIKwYIX9GY3ayhZ+mCCx17RdsfXYCNTCE/0fHlpI
	 pfBAyCHz6NblBNhw+/6E0sFWZiG1+KZ5jR7g0K7tu5DU6HizKzvW1oCvKAN+Dmg18LKX9PoN1RG1
	 NU166g2GuECZhHgE/E04aYzuOB9lPj8kz6ja1OAhwc4iUN5Y8GrhLkbzVn9Ii6lACwtMpmX0lx5/
	 OgpKZtaupeyM9QOGRG823jSesyBncNIej6oZk33sfn68bCOh58POPr3GRoIGyIj9deCat9KTFs3y
	 +YNdNJJsR4djw5ZRk7l/tLTlDMbp2RYyhEWnJqwVBuO1gDncxd1TE+3kAVNcuvHWC/LGA8c9xtbU
	 UCzCI2vMRgBSJu+he4f+ZcEXihD6/ReQJnpejnRescBYsVPVPvdesFK4I+cLhXa+8MJW0uNtTz4m
	 QTj+VWHCauiJ3iGkxRhumnIRrG5TwLXQQSXjrvaGGxewHv0hBdkH24fWtLUn97sV9rUVtacX371+
	 /E4mdGw59jKLCyP1A2933soJJEQ8iXbS/jMdqVR18jj/64VsVtp+P04nOC3ANIWg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_iget
Date: Mon, 23 Sep 2024 22:05:17 +0800
X-OQ-MSGID: <20240923140516.2437463-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66f11c57.050a0220.c23dd.000b.GAE@google.com>
References: <66f11c57.050a0220.c23dd.000b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the read data is insufficient to fill the rec, use 0 to fill it

#syz test

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..f0292b76e3d4 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -168,6 +168,8 @@ int hfs_brec_read(struct hfs_find_data *fd, void *rec, int rec_len)
 	if (fd->entrylength > rec_len)
 		return -EINVAL;
 	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd->entrylength);
+	if (rec_len > fd->entrylength)
+		memset(rec + fd->entrylength, 0, rec_len - fd->entrylength);
 	return 0;
 }
 


