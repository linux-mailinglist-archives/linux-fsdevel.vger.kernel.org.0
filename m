Return-Path: <linux-fsdevel+bounces-74345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB98D39AD3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41E793019979
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ABE30EF95;
	Sun, 18 Jan 2026 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="VJp7M3Sq";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="LyBx7VeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a48-184.smtp-out.amazonses.com (a48-184.smtp-out.amazonses.com [54.240.48.184])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D931ACEDF;
	Sun, 18 Jan 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775731; cv=none; b=jLsCXRExm5HFoVRbjaAAUki6dUfbC7IWGSIXIEXhCSgwiTaeJ43Wxc9tvzGXiOFkMKomovFPiEq18ZU6dxvuJ7V48ejSpY2Qx8C6yEr3CV++UUVAYD8FmGNtqEpgOdfRRhXAaAUYK0oOjNXc5tA3W3rZPX9Fho/akUsKs6xT+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775731; c=relaxed/simple;
	bh=suTO9TQP2OnSBnpJlw9W1iI0asVt8j1amz7828/UYqQ=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=e+6FcaIRGz7xNrW4LIVUkm5hRi/n3bq8AyBjmmQXdsmSXVuym8/RnVLyeEqzY5J3eI7ldgbONWEA0PF6/s0ZC+uY3JeXel8dOsEXfZV11FdOFHS2Are/vyECmAk6AN7JoJ4GSaji1ZYckFEvjjipRCOH45IAfpXjN1+E4K3kBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=VJp7M3Sq; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=LyBx7VeA; arc=none smtp.client-ip=54.240.48.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775726;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=suTO9TQP2OnSBnpJlw9W1iI0asVt8j1amz7828/UYqQ=;
	b=VJp7M3SqS4FGyandVMmXM52/tm9ujIXDNPpq2KJXKcgZMDRU5bQIE3UR/2rSXULJ
	wZvvm9zl3pF3Lho/zpTDyGzod0FXcx54UgHChMg/5ooK88wzYpC/cnN94p4zGv2t5d9
	f/4XQXenb/Fc6jcDDgZwRxebf59VBAXvQFdaLRyQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775726;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=suTO9TQP2OnSBnpJlw9W1iI0asVt8j1amz7828/UYqQ=;
	b=LyBx7VeAL1+JLuAotasxUl8goa631XgVqtARHAwMTd5R9RNx6/XjtCqeIHijm2HQ
	I+tl8Z3oxiymgb0zN41IBYziUv3e533EBs02gx6jrQ8dv0Gepqt8/J4Tu2AtanVIyTR
	KGMZv6EKYO4swtL4A1mEHN4sIjf0n2OixQmc2+Pc=
Subject: [PATCH V7 1/3] fuse_kernel.h: bring up to baseline 6.19
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
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Sun, 18 Jan 2026 22:35:26 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: 
 <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
References: 
 <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com> 
 <20260118223516.92753-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMq8xyBv3XTdQ46VZ1SIUL+znA==
Thread-Topic: [PATCH V7 1/3] fuse_kernel.h: bring up to baseline 6.19
X-Wm-Sent-Timestamp: 1768775725
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.48.184

From: John Groves <john@groves.net>

This is copied from include/uapi/linux/fuse.h in 6.19 with no changes.

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_kernel.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 94621f6..c13e1f9 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -239,6 +239,7 @@
  *  7.45
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
+ *  - add FUSE_NOTIFY_PRUNE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -680,7 +681,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
-	FUSE_NOTIFY_CODE_MAX,
+	FUSE_NOTIFY_PRUNE = 9,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_notify_prune_out {
+	uint32_t	count;
+	uint32_t	padding;
+	uint64_t	spare;
+};
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
@@ -1131,6 +1138,7 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.52.0


