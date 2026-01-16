Return-Path: <linux-fsdevel+bounces-74214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13ED38554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478D33143F67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D303A0B3F;
	Fri, 16 Jan 2026 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="dhGGRDqs";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Fetr9cGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-71.smtp-out.amazonses.com (a11-71.smtp-out.amazonses.com [54.240.11.71])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911FA92E;
	Fri, 16 Jan 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590267; cv=none; b=jLZq1rceQJScTU6fGMN+rC/KuLQkCRycXSqLeM5SLLlZPup62tHSRd7Pq+Zio4AyCBJ3S+C19Wf5qM/JSRpboO7lLJLAt1dEEwRNnzLHN3qauq5RFqt+wNKdttD8rlSRAQeGqyGfAaR7LGDNjeZB1dz8MXzDF+RIMist/JJROxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590267; c=relaxed/simple;
	bh=ATl+sn+w8krnV+PUf8aB0KMnl1nZkb6LxA4UkIrR3Ng=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=PDqsxWSABXSz9Mqd4mFPVbWDg1GtujSKC1kME9PhG7jwDlTUCVEhv0nB5/r+SE6+g/xiqXrT+0KcbYq97IXtX4pD9IrbilVb8Y6SeYikBb3dmR/v2sUUHTzsCl3xLaAh/iq1UOErKTgQ+081XwMRyGBMSxd6UZbzTSbHg4do544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=dhGGRDqs; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Fetr9cGj; arc=none smtp.client-ip=54.240.11.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590264;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=ATl+sn+w8krnV+PUf8aB0KMnl1nZkb6LxA4UkIrR3Ng=;
	b=dhGGRDqsyItUnprtvnQdCnni3Rw/W8+nSrTBQGqcduP1bClT0K4EUKmIo4rQb0/d
	HNRe0dsUXw3uCog9ijHKFS+XugC+od8hWytWFP+iJJSO7bgGOrs8PCQBv+UhIMZjutO
	9svHMwsoUDi9+wZczePn4fXkOOUhY3UNMAVi6pgU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590264;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=ATl+sn+w8krnV+PUf8aB0KMnl1nZkb6LxA4UkIrR3Ng=;
	b=Fetr9cGjj/+U78NdPPLdps8KM5HTQqrDcyfq30bBDcMtqhKxybtBvx8YKx3XBZqO
	+Ga/ttZD8/G/V2MNYQRzeGlPnIz7V1v1yvBbxfFTWSrSo/c9eRdk7pM43YFLWg/YzH8
	c5hadI8EuTC6F2RbCo2kGqUlBlJbyKWfqvVaaY3I=
Subject: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:04:24 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260116185911.1005-1-john@jagalactic.com>
References: <20260116125831.953.compound@groves.net> 
 <20260116185911.1005-1-john@jagalactic.com> 
 <20260116185911.1005-10-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAAAzqQg=
Thread-Topic: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
X-Wm-Sent-Timestamp: 1768590263
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.71

From: John Groves <john@groves.net>

Famfs distinguishes between its on-media and in-memory superblocks. This
reserves the numbers, but they are only used by the user space
components of famfs.

Signed-off-by: John Groves <john@groves.net>
---
 include/uapi/linux/magic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 638ca21b7a90..712b097bf2a5 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -38,6 +38,8 @@
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
 #define BCACHEFS_SUPER_MAGIC	0xca451a4e
+#define FAMFS_SUPER_MAGIC	0x87b282ff
+#define FAMFS_STATFS_MAGIC      0x87b282fd
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.52.0


