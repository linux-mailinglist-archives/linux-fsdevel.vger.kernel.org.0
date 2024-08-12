Return-Path: <linux-fsdevel+bounces-25697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C935294F511
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3933FB2554D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBC7187328;
	Mon, 12 Aug 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="u3z/wIxm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+ZDiPYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A715C127
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480676; cv=none; b=KhktLxUgHaQpqyOivEaLLoUmSMlRmNaTbrr9QccKIMyR7854znNlFDSvqOXoKXbjKAmySCYRS+kgMmCchCX771otbkDGzccnKg8MPs3n/jU/xzUE9O86QCq5+d7gALPJSb3bA73+D9sSrInm0PYDwAfNccrg+qajkEmlReRog84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480676; c=relaxed/simple;
	bh=kMFanYLUv0ZkFeKs53pSlrxleQlmCmYbHI2xnwQGRGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+hCWv6fPKZpuIYJq/iDVDZ3rZeTdjXZX5/K5pTrqX/MJS+cg1gBl/NW4MsJQvOEH4LZPMvqyGxHaPbRPO6ZLblka+oHLmKlBd2e3GndeUwZZwRLbK1nRMJz1eybUWyvg+RIYAmDVVMR3a2XFVE9KU1QOcFOaYe9JX9Clb180U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=u3z/wIxm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+ZDiPYK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C8FE6114B020;
	Mon, 12 Aug 2024 12:37:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by compute8.internal (MEProxy); Mon, 12 Aug 2024 12:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723480672;
	 x=1723567072; bh=G0roSU3u/Kbps71rUk2gawjUKPSfhbcb7JVPKHw+844=; b=
	u3z/wIxmoXV9jATIy98RRlb9WjPq9RsEAtZVOd8QlWcU1CzSFBFCK1aVF4TEEhvw
	eI0tKEIwXgtBdJd/aEKhX0XsBm+XAX3KCQCwd85n4P9yIpTwdL9BDcOCtVaXCdjD
	mANIpSAtU6w3f5tixVPhPoay9UMiHEeyBG2gyTMs1h9R1kDwzuuIYiCf820rJeo/
	Sa1GLbJIhhWhlTyQO2MXLshrznrtWxQmcdGYIHJd551Fkn+5JLSha8mV/dSY/JBK
	sNQu4I69iPOHzdhmYd0kikoPC1UXU5QBWy3fyWEcqivXoj/VUV4wfdc5teaoFtT+
	X5H6OhR/zNvHWSgwLNuPvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723480672; x=
	1723567072; bh=G0roSU3u/Kbps71rUk2gawjUKPSfhbcb7JVPKHw+844=; b=l
	+ZDiPYKGtnw79YoB9h9lgI95i1piFimRfZwMVK8QyjOaFThJE7jLxhFVvJCcPwYY
	cmD7OTwCNfpEHW3wLL7ox7YDsWWPBYvtxq/2s6UfM2YGOwGViIs3TWlq1RVVlp0z
	in59BfMimHNrg1O6BZF5CmZVHVpgSpa5aAb7aTW/hCm1ge0V/BheJsr0TxDAM5Kl
	VQbkSYBIvFixKDco4nTFKb6GVKyQBDvC/tkfQr1ky/C5noL02snYNQEGOSOByd6J
	6+chsMZLVFD9x7GQnzSCllIxNvOah5f4KyxaToGLuoIovxWKk/ocuSjHl8z677m8
	4a5T31wVy7QdwZPiwwYBw==
X-ME-Sender: <xms:YDq6Zl-PyVh8zKIannfyLC2XdtCKOE5lQSP3smfBLSGMu4XdJfJnRw>
    <xme:YDq6ZpuBK7rZY9YqH4EsjdqQQqTxcF4FOJ10Fk6JsUcGjLByVSHdQG6XRe8sV8Qjg
    abU7RxJnTu0z7Gn>
X-ME-Received: <xmr:YDq6ZjDJOzcg_tCrJEySCyaMZmAuR1h27CPfkZep8Jqw8WvCsRt3oIHjbiDBPLdrk0yadbu3_TT15MkSnKcTsi2ot89BBYfCO2CmKwxwbcq3vABbYKSGaOVEmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgg
    gfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgs
    vghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecugg
    ftrfgrthhtvghrnheptddugefgjeefkedtgefhheegvddtfeejheehueeufffhfeelfeeu
    heetfedutdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthho
    pehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfseht
    ohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:YDq6Zpc1WZhBXP_2eDHJnI92h5kv3tlFbsb0y84XsHKvMFs_VopcdA>
    <xmx:YDq6ZqM_mZlU8oGOY5u7AQ3Apn1WcqpaWvjJk7GntbDJPhoSkrpbBQ>
    <xmx:YDq6Zrkml5pMLr7gozezaesxi_-b1T2bc7mHesizhHy40WmNokf8LA>
    <xmx:YDq6ZktETzLUidUyUSrVAcLJFgGtvNQpJBhdocuUTIqWDsPQ99YWUA>
    <xmx:YDq6Zh1jPV_dCD33Sz4SIWOo5r7pNkpupUrY7yzEBF3QG-74QOu8pERd>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 12:37:51 -0400 (EDT)
Message-ID: <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
Date: Mon, 12 Aug 2024 18:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
To: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 joannelkoong@gmail.com
References: <20240812161839.1961311-1-bschubert@ddn.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240812161839.1961311-1-bschubert@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry, I had sent out the wrong/old patch file - it doesn't have one change
(handling of already aligned buffers). 
Shall I sent v4? The correct version is below

---

From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 21 Jun 2024 11:51:23 +0200
Subject: [PATCH v3] fuse: Allow page aligned writes

Write IOs should be page aligned as fuse server
might need to copy data to another buffer otherwise in
order to fulfill network or device storage requirements.

Simple reproducer is with libfuse, example/passthrough*
and opening a file with O_DIRECT - without this change
writing to that file failed with -EINVAL if the underlying
file system was requiring alignment.

Required server side changes:
Server needs to seek to the next page, without splice that is
just page size buffer alignment, with splice another splice
syscall is needed to seek over the unaligned area.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>

---

Changes since v2:
- Added a no-op return in fuse_copy_align for buffers that are
  already aligned (cs->len == PAGE_SIZE && cs->offset == 0). Some
  server implementations actually do that to compensate for fuse client
  misalignment. And it could also happen by accident for non aligned
  server allocation.
Added suggestions from Joannes review:
- Removed two sanity checks in fuse_copy_align() to have it
  generic.
- Moved from args->in_args[0].align to args->in_args[1].align
  to have it in the arg that actually needs the alignment
  (for FUSE_WRITE) and updated fuse_copy_args() to align that arg.
- Slight update in the commit body (removed "Reads").

libfuse patch:
https://github.com/libfuse/libfuse/pull/983

From implmentation point of view it is debatable if request type
parsing should be done in fuse_copy_args() (or fuse_dev_do_read()
or if alignment should be stored in struct fuse_arg / fuse_in_arg.
There are pros and cons for both, I kept it in args as it is
more generic and also allows to later on align other request
types, for example FUSE_SETXATTR.
---
 fs/fuse/dev.c             | 29 +++++++++++++++++++++++++++--
 fs/fuse/file.c            |  6 ++++++
 fs/fuse/fuse_i.h          |  6 ++++--
 include/uapi/linux/fuse.h |  9 ++++++++-
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..072c7bacc4a7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1009,6 +1009,25 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 	return 0;
 }
 
+/* Align to the next page */
+static int fuse_copy_align(struct fuse_copy_state *cs)
+{
+	/*
+	 * This could happen if the userspace buffer is aligned in a way that
+	 * it compensates fuse headers.
+	 */
+	if (cs->len == PAGE_SIZE && cs->offset == 0)
+		return 0;
+
+	if (WARN_ON(cs->len == PAGE_SIZE || cs->offset == 0))
+		return -EIO;
+
+	/* Seek to the next page */
+	cs->offset += cs->len;
+	cs->len = 0;
+	return 0;
+}
+
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
@@ -1019,10 +1038,16 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
-		if (i == numargs - 1 && argpages)
+		if (i == numargs - 1 && argpages) {
+			if (arg->align) {
+				err = fuse_copy_align(cs);
+				if (err)
+					break;
+			}
 			err = fuse_copy_pages(cs, arg->size, zeroing);
-		else
+		} else {
 			err = fuse_copy_one(cs, arg->value, arg->size);
+		}
 	}
 	return err;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..9783d5809ec3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1062,6 +1062,12 @@ static void fuse_write_args_fill(struct fuse_io_args *ia, struct fuse_file *ff,
 		args->in_args[0].size = FUSE_COMPAT_WRITE_IN_SIZE;
 	else
 		args->in_args[0].size = sizeof(ia->write.in);
+
+	if (ff->open_flags & FOPEN_ALIGNED_WRITES) {
+		args->in_args[1].align = 1;
+		ia->write.in.write_flags |= FUSE_WRITE_ALIGNED;
+	}
+
 	args->in_args[0].value = &ia->write.in;
 	args->in_args[1].size = count;
 	args->out_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..1600bd7b1d0d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -275,13 +275,15 @@ struct fuse_file {
 
 /** One input argument of a request */
 struct fuse_in_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align:1;
 	const void *value;
 };
 
 /** One output argument of a request */
 struct fuse_arg {
-	unsigned size;
+	unsigned int size;
+	unsigned int align:1;
 	void *value;
 };
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..742262c7c1eb 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,9 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ * 7.41
+ *  - add FOPEN_ALIGNED_WRITES open flag and FUSE_WRITE_ALIGNED write flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -252,7 +255,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 40
+#define FUSE_KERNEL_MINOR_VERSION 41
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -360,6 +363,7 @@ struct fuse_file_lock {
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
+ * FOPEN_ALIGNED_WRITES: Page align write io data
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -369,6 +373,7 @@ struct fuse_file_lock {
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 #define FOPEN_PASSTHROUGH	(1 << 7)
+#define FOPEN_ALIGNED_WRITES	(1 << 8)
 
 /**
  * INIT request/reply flags
@@ -496,10 +501,12 @@ struct fuse_file_lock {
  * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
  * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
  * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
+ * FUSE_WRITE_ALIGNED: Write io data are page aligned
  */
 #define FUSE_WRITE_CACHE	(1 << 0)
 #define FUSE_WRITE_LOCKOWNER	(1 << 1)
 #define FUSE_WRITE_KILL_SUIDGID (1 << 2)
+#define FUSE_WRITE_ALIGNED      (1 << 3)
 
 /* Obsolete alias; this flag implies killing suid/sgid only. */
 #define FUSE_WRITE_KILL_PRIV	FUSE_WRITE_KILL_SUIDGID
-- 
2.43.0



