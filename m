Return-Path: <linux-fsdevel+bounces-4250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF317FE127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BE2281FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395760EE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQwqVlfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16F10C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:07:19 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so1123925e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701288438; x=1701893238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu+FvYJP4hLa4bumSUKSMjyLY9zr55bzmXAW4NgivPE=;
        b=AQwqVlfRMk1lAn+V2EfhGSzGq8Mgur/Q65CFr1hcOw3DUAgvnGzhKVUVB9zXnLtmwA
         WCT/SS65BnvtDOo2mRWfwoKAlSRvV4jU85NhCVdKzC4qtaBtQ175QJvT7S+H/aYddQOe
         OSJCRim3oPHhH+axo8HF+bCI5X/AdWDDayNXUdIq8Za4247c/DewkCBeuw3gvk03LNyc
         fZxYsFnurvTtFf9hrQv82eQqZh6yT6qUw3lGu31584U2EHehfNOlh/m7ddcijMYhLxCS
         pR+l+o4husN1RCjqL5SIe/cN4oDmAbih+pGA2VTBBID496ABqRn7PRWlFqk4dQrh8Wkf
         boWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288438; x=1701893238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mu+FvYJP4hLa4bumSUKSMjyLY9zr55bzmXAW4NgivPE=;
        b=GRo4X8AnAXLNdKM682nsDyHxCH7OcB1pfkERBJHnkyMdFpZl/sJetU9JFKYwwlJTFI
         7182xN9U+t3dQvWdeFnBgTgdrlpmbEAjtbJXQfgrRNe48JduoV1Ym759v6z67BDQRJLa
         +TumkUDlUA9e8phhCmB2RF5W2GzGOKHb+sAWF+/rb7jXLvQLj51ZGISaW/eTlihx7KaO
         AUz49Z2wJlbNcQtz3wNksFtcd4QNOHJxPiS4Dr9xnTFA6j5i1s97SKHw8jyiy3ywE+NX
         NRlROXkmSuhoJZEMwfDoDCE0Ru00DD3Im+Ve37vXska5ORBGU4kflS1GB56Wxs6GHhSF
         aCpQ==
X-Gm-Message-State: AOJu0YzcPUBgAZvEIYMh97J6WWIsZZ5ggxxwa2at44sP+70DXvABliad
	oDQw5uv/OIe7mcEAE4yXvq8=
X-Google-Smtp-Source: AGHT+IEOYql683V6Aav6wdj0xIQgh66wVr7OgojCFV+fc5DQBGNBgB2dQHLupZq87klcgB77FMwD3g==
X-Received: by 2002:a05:600c:524a:b0:40b:4ba1:c502 with SMTP id fc10-20020a05600c524a00b0040b4ba1c502mr4870341wmb.37.1701288438016;
        Wed, 29 Nov 2023 12:07:18 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a8-20020adffb88000000b00333083a20e5sm7412719wrr.113.2023.11.29.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:07:17 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs: move file_start_write() into direct_splice_actor()
Date: Wed, 29 Nov 2023 22:07:09 +0200
Message-Id: <20231129200709.3154370-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129200709.3154370-1-amir73il@gmail.com>
References: <20231129200709.3154370-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two callers of do_splice_direct() hold file_start_write() on the
output file.

This may cause file permission hooks to be called indirectly on an
overlayfs lower layer, which is on the same filesystem of the output
file and could lead to deadlock with fanotify permission events.

To fix this potential deadlock, move file_start_write() from the callers
into the direct_splice_actor(), so file_start_write() will not be held
while reading the input file.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231128214258.GA2398475@perftesting/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 2 --
 fs/read_write.c        | 2 --
 fs/splice.c            | 8 +++++++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7a44c8212331..294b330aba9f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -333,11 +333,9 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 		if (error)
 			break;
 
-		ovl_start_write(dentry);
 		bytes = do_splice_direct(old_file, &old_pos,
 					 new_file, &new_pos,
 					 this_len, SPLICE_F_MOVE);
-		ovl_end_write(dentry);
 		if (bytes <= 0) {
 			error = bytes;
 			break;
diff --git a/fs/read_write.c b/fs/read_write.c
index 555514cdad53..b7110ee77c1c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1286,10 +1286,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
 		if (retval < 0)
 			goto fput_out;
-		file_start_write(out.file);
 		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
 					  count, fl);
-		file_end_write(out.file);
 	} else {
 		if (out.file->f_flags & O_NONBLOCK)
 			fl |= SPLICE_F_NONBLOCK;
diff --git a/fs/splice.c b/fs/splice.c
index 3bb4936f8b70..261adfdfed9d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1157,8 +1157,12 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 			       struct splice_desc *sd)
 {
 	struct file *file = sd->u.file;
+	long ret;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	file_start_write(file);
+	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	file_end_write(file);
+	return ret;
 }
 
 static int copy_file_range_splice_actor(struct pipe_inode_info *pipe,
@@ -1240,6 +1244,8 @@ EXPORT_SYMBOL(do_splice_direct);
  *
  * Description:
  *    For use by generic_copy_file_range() and ->copy_file_range() methods.
+ *    Like do_splice_direct(), but vfs_copy_file_range() already called
+ *    start_file_write() on @out file.
  *
  * Callers already called rw_verify_area() on the entire range.
  */
-- 
2.34.1


