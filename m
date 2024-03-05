Return-Path: <linux-fsdevel+bounces-13666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A55872A10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 23:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332D8B24359
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8FF12E1E3;
	Tue,  5 Mar 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdimvUrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8912E1C5;
	Tue,  5 Mar 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677129; cv=none; b=X9vFW1pQR32BkkEx6tCoyujsBdQ0FKpoG2vJjN1VVvovUqc/ClqN0p9oTf/zmd/9SJUUhQPH0DGPsXD7IwPdDykM21okjmdMaD5ZRum6zgYUMLFPZWuqkEOMEpZJnL1KJinR00oZejReQJhA/dOpBetznb7IdiYnH8TMr9MmINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677129; c=relaxed/simple;
	bh=iTV6eJf8dPD4YV3fq9RsQkZcP6Jo/J8HHPmDs3eIbuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ea/URaHRxAzGBbs3E5zvvZvsFDmp9uC4VSdMKJJ8CVs8Bu6NSR5kkObGU3AaxnqXDTpaG5Z4t0XH3qLMkfA0WtRrXXEQXiFt8ZcVJGhfkmncgOpJCD1YJUEcz9Z+RdOFy7Nl7+sgkFatO81mlG3NKhQNFGXtLToOkt4pz38dk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdimvUrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451E6C43394;
	Tue,  5 Mar 2024 22:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709677129;
	bh=iTV6eJf8dPD4YV3fq9RsQkZcP6Jo/J8HHPmDs3eIbuA=;
	h=Date:From:To:Cc:Subject:From;
	b=IdimvUrNFp9Jf7lRs7ECBbFx7mh+9YgqxFqBEfQKxNR8viJm6rZnc/RTYXac8Diu1
	 63Itc3bLl3E6o3lqXS8sBG4g9gzajZmRm/IusPKLHEn72SIdpBtls1VcTquwyIgi0H
	 TWHbNNbjjsOimHLa11fUe5RwjF+lJAMpr785GQ/rULMiqVcsACg5StUYC6ye6/BLK7
	 VLea6ydfrvu4qjqyLJ775bq7aYR7mZqX7tu8C7JNkGtTQosUUxrPs8fveKr1QTTZuJ
	 aUsNydoBRNU05f4/1UHhIBl6I2D0c5XQD3M/aov/ynUqC7RCInxq2KzsNdbDdXREcz
	 yroGEG5ulIthQ==
Date: Tue, 5 Mar 2024 16:18:46 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] fsnotify: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <ZeeaRuTpuxInH6ZB@neat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There is currently a local structure `f` that is using a flexible
`struct file_handle` as header for an on-stack place-holder for the
flexible-array member `unsigned char f_handle[];`.

struct {
	struct file_handle handle;
	u8 pad[MAX_HANDLE_SZ];
} f;

However, we are deprecating flexible arrays in the middle of another
struct. So, in order to avoid this, we use the `struct_group_tagged()`
helper to separate the flexible array from the rest of the members in
the flexible structure:

struct file_handle {
        struct_group_tagged(file_handle_hdr, hdr,
		... the rest of the members
        );
        unsigned char f_handle[];
};

With the change described above, we can now declare an object of the
type of the tagged struct, without embedding the flexible array in the
middle of another struct:

struct {
        struct file_handle_hdr handle;
        u8 pad[MAX_HANDLE_SZ];
} f;

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which the flexible-array member can be
accessed, as in this case.

So, with these changes, fix the following warning:

fs/notify/fdinfo.c: In function ‘show_mark_fhandle’:
fs/notify/fdinfo.c:45:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
   45 |                 struct file_handle handle;
      |                                    ^~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/notify/fdinfo.c | 8 +++++---
 include/linux/fs.h | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 5c430736ec12..740f5e68b397 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -42,15 +42,17 @@ static void show_fdinfo(struct seq_file *m, struct file *f,
 static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 {
 	struct {
-		struct file_handle handle;
+		struct file_handle_hdr handle;
 		u8 pad[MAX_HANDLE_SZ];
 	} f;
+	struct file_handle *handle = container_of(&f.handle,
+						  struct file_handle, hdr);
 	int size, ret, i;
 
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
-	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
+	ret = exportfs_encode_fid(inode, (struct fid *)handle->f_handle, &size);
 	if ((ret == FILEID_INVALID) || (ret < 0)) {
 		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
 		return;
@@ -63,7 +65,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 		   f.handle.handle_bytes, f.handle.handle_type);
 
 	for (i = 0; i < f.handle.handle_bytes; i++)
-		seq_printf(m, "%02x", (int)f.handle.f_handle[i]);
+		seq_printf(m, "%02x", (int)handle->f_handle[i]);
 }
 #else
 static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..7c131bcd948f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1030,8 +1030,10 @@ struct file {
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
 struct file_handle {
-	__u32 handle_bytes;
-	int handle_type;
+	struct_group_tagged(file_handle_hdr, hdr,
+		__u32 handle_bytes;
+		int handle_type;
+	);
 	/* file identifier */
 	unsigned char f_handle[];
 };
-- 
2.34.1


