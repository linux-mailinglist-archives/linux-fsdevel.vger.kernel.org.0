Return-Path: <linux-fsdevel+bounces-55525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B4B0B3F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 08:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F633BDF9C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BA1E521F;
	Sun, 20 Jul 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q68R1ure"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672717AE11;
	Sun, 20 Jul 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994385; cv=none; b=mmqGq600NLvlwCGSH9doDZnfad2Fvb23opW0HXmOOs2OTu9IRts+ygCpLYFMoIpGBAwGUh8td0QuIfgpwK+QNwmBSb2cuzlFBnlYXnlm+ElFpWwzugA7L2SLrWtd0Si14PAKCRY0MJkDzq3xeQnnZpxwQtrjo26hjNVGDuFXgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994385; c=relaxed/simple;
	bh=fMOnU1vIlgsMCZglmwZ0ph96wItjQj2xjA0Cfh/E07w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAEWdym53arz25mxehhN6pjHBHRXJ4kqQCTiewv80PNrfmBB67niLMveJ/tnjutaF5wlgfIhlgOMcPea6BJXDVc2phoqWA5vo1mXUWkJ7e1AIf8xlDBJqPxVR6LqWTllbUSVw8lGs7pi+JlXK9mqqQxAW/Yf6mMtKGKxsbzU58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Q68R1ure; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9484:f04a:f27d:fd66:5c61])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56K6oq0a3555973
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 19 Jul 2025 23:51:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56K6oq0a3555973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752994271;
	bh=i1EZz1OSt3xG8CoWOY7eDgddm0jsJfUpAwtxMUdpTU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q68R1ure0GwuzF4YIqOSL83GEH/lWXB6KFfNBH0xpmFPSZukTpkm3VEj33YET0zis
	 NkKHKcK9XpBx5SELo5EevjrEMnDlZ4h2Yds9RqEvVfP4kdxSTO4u16aKnRSMO6ElZT
	 tMlgQ9gypvEKLNdKnuD66J6qoWjNyQrfHOiSCKAQIcIXING6Mf5YidmEINGqnGlJwi
	 yBREITLC7W7A5HJNBM8N2TLew3bTlw+hrmYEKyJFMIbcwSsniSe75OOa0mmDxZU+3S
	 yika893X8LfexsYEiA5FNVEco0u/ocDaroyJpB8dMMrjGUxXLu2tRURNbzp3yVlZAf
	 sRjCmIt2TbmVw==
From: "H. Peter Anvin" <hpa@zytor.com>
To: 
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        David Lechner <dlechner@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Gatlin Newhouse <gatlin.newhouse@gmail.com>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marc Herbert <Marc.Herbert@linux.intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
        Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Uros Bizjak <ubizjak@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
        virtualization@lists.linux.dev, x86@kernel.org
Subject: [PATCH v2 3/7] fs/proc: replace "__auto_type" with "const auto"
Date: Sat, 19 Jul 2025 23:50:40 -0700
Message-ID: <20250720065045.2859105-4-hpa@zytor.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720065045.2859105-1-hpa@zytor.com>
References: <20250720065045.2859105-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace use of "__auto_type" in fs/proc/inode.c with "const auto".

Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 3604b616311c..1afa2dd2285b 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -303,7 +303,7 @@ static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	__auto_type read = pde->proc_ops->proc_read;
+	const auto read = pde->proc_ops->proc_read;
 	if (read)
 		return read(file, buf, count, ppos);
 	return -EIO;
@@ -325,7 +325,7 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 
 static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	__auto_type write = pde->proc_ops->proc_write;
+	auto write = pde->proc_ops->proc_write;
 	if (write)
 		return write(file, buf, count, ppos);
 	return -EIO;
@@ -347,7 +347,7 @@ static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t
 
 static __poll_t pde_poll(struct proc_dir_entry *pde, struct file *file, struct poll_table_struct *pts)
 {
-	__auto_type poll = pde->proc_ops->proc_poll;
+	auto poll = pde->proc_ops->proc_poll;
 	if (poll)
 		return poll(file, pts);
 	return DEFAULT_POLLMASK;
@@ -369,7 +369,7 @@ static __poll_t proc_reg_poll(struct file *file, struct poll_table_struct *pts)
 
 static long pde_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	__auto_type ioctl = pde->proc_ops->proc_ioctl;
+	auto ioctl = pde->proc_ops->proc_ioctl;
 	if (ioctl)
 		return ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -392,7 +392,7 @@ static long proc_reg_unlocked_ioctl(struct file *file, unsigned int cmd, unsigne
 #ifdef CONFIG_COMPAT
 static long pde_compat_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	__auto_type compat_ioctl = pde->proc_ops->proc_compat_ioctl;
+	auto compat_ioctl = pde->proc_ops->proc_compat_ioctl;
 	if (compat_ioctl)
 		return compat_ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -414,7 +414,7 @@ static long proc_reg_compat_ioctl(struct file *file, unsigned int cmd, unsigned
 
 static int pde_mmap(struct proc_dir_entry *pde, struct file *file, struct vm_area_struct *vma)
 {
-	__auto_type mmap = pde->proc_ops->proc_mmap;
+	auto mmap = pde->proc_ops->proc_mmap;
 	if (mmap)
 		return mmap(file, vma);
 	return -EIO;
@@ -497,7 +497,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	if (!use_pde(pde))
 		return -ENOENT;
 
-	__auto_type release = pde->proc_ops->proc_release;
+	auto release = pde->proc_ops->proc_release;
 	if (release) {
 		pdeo = kmem_cache_alloc(pde_opener_cache, GFP_KERNEL);
 		if (!pdeo) {
@@ -534,7 +534,7 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 	struct pde_opener *pdeo;
 
 	if (pde_is_permanent(pde)) {
-		__auto_type release = pde->proc_ops->proc_release;
+		auto release = pde->proc_ops->proc_release;
 		if (release) {
 			return release(inode, file);
 		}
-- 
2.50.1


