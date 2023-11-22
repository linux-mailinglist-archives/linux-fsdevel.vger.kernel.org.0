Return-Path: <linux-fsdevel+bounces-3405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003637F4625
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30441C20AA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E11A58E;
	Wed, 22 Nov 2023 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFL7mgeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A07D69
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so85463261fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656042; x=1701260842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+QF6uKC8YtRGB7BtCuFu9zr93E6M01rnQS6SDNvYGk=;
        b=jFL7mgeY4vCxCuDiiI0p9GBiN6fORpXq5Rk3yw6857MD0SrOPPxWshvyl7kEEwwGXX
         Xg/6q4ryAA2QMOEcmnLCg6I6BlmhNe81UVFhIxRygnYxfDcvQX0VoOYG3oYMX7he/SYS
         e/cIli0EhCHVfpLJeVPqCTbbTN8C90TJwTIdK0enqdrwaQvZJ3ODdxwPjbKxypXFPWHN
         6p4HdAw4iAmcq+IfmYEOZ4xwkQlPZ1LFWIp8l0KIwlCA1kVCBxmr3QrRwOb5aAii0p9f
         phwGXd8EtHa19PT42pDLOrOI7OF69brfE39OPQlw/q/f3/D5UmlYLZ1kfyl7AgM7eVjZ
         bEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656042; x=1701260842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+QF6uKC8YtRGB7BtCuFu9zr93E6M01rnQS6SDNvYGk=;
        b=UjkW7IFdD06ZVdsM/aMzJhemck/IynGchv982dvmbqjGczSe4q1L5ZcUmhs2BWQr3I
         D60fnqBAKar/sBw9IzUb+LAJqvXPO3LJGwiiIljMBpvIGorwvvQ7RRXdjlJtcYaLFjd6
         tMyBKKYh7VW/PrtjhIw8WSeRFqVzf5ZtNrYchyysbdMmFUtlbmnwr0Ywz+XLziEDA7HO
         zmjCTCVkXqBrWh4ryGmuEG0AGR8SefyW3kRXrADkV1QtkRNFDER6y+WNejO2oRMtueAw
         v3iUJtpFxusztn9Qd/M7tp56tlRXmb23vz249ZNK6rjt/Lr4IIyWANECKwb+05skI7DX
         ox/g==
X-Gm-Message-State: AOJu0YxrEa3rVlmsf60qisHzOZaC4/FclkA8mqJMtuK7tcvuXLLMFybu
	VWfz7ZgvdDo5+DzmoZojNBs=
X-Google-Smtp-Source: AGHT+IEBAxWOVBl+vQMEt3D2dqixxSEjeezS0dHhR0NDZx4rWyH/CddkRE1a0c3FUaAM0ojwmPhBuA==
X-Received: by 2002:a2e:7306:0:b0:2c8:35fb:af1d with SMTP id o6-20020a2e7306000000b002c835fbaf1dmr1680387ljc.6.1700656042021;
        Wed, 22 Nov 2023 04:27:22 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:21 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/16] ovl: add permission hooks outside of do_splice_direct()
Date: Wed, 22 Nov 2023 14:27:00 +0200
Message-Id: <20231122122715.2561213-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main callers of do_splice_direct() also call rw_verify_area() for
the entire range that is being copied, e.g. by vfs_copy_file_range()
or do_sendfile() before calling do_splice_direct().

The only caller that does not have those checks for entire range is
ovl_copy_up_file().  In preparation for removing the checks inside
do_splice_direct(), add rw_verify_area() call in ovl_copy_up_file().

For extra safety, perform minimal sanity checks from rw_verify_area()
for non negative offsets also in the copy up do_splice_direct() loop
without calling the file permission hooks.

This is needed for fanotify "pre content" events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..106f8643af3b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -230,6 +230,19 @@ static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
 	return ovl_real_fileattr_set(new, &newfa);
 }
 
+static int ovl_verify_area(loff_t pos, loff_t pos2, loff_t len, loff_t totlen)
+{
+	loff_t tmp;
+
+	if (WARN_ON_ONCE(pos != pos2))
+		return -EIO;
+	if (WARN_ON_ONCE(pos < 0 || len < 0 || totlen < 0))
+		return -EIO;
+	if (WARN_ON_ONCE(check_add_overflow(pos, len, &tmp)))
+		return -EIO;
+	return 0;
+}
+
 static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 			    struct file *new_file, loff_t len)
 {
@@ -244,13 +257,20 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 	int error = 0;
 
 	ovl_path_lowerdata(dentry, &datapath);
-	if (WARN_ON(datapath.dentry == NULL))
+	if (WARN_ON_ONCE(datapath.dentry == NULL) ||
+	    WARN_ON_ONCE(len < 0))
 		return -EIO;
 
 	old_file = ovl_path_open(&datapath, O_LARGEFILE | O_RDONLY);
 	if (IS_ERR(old_file))
 		return PTR_ERR(old_file);
 
+	error = rw_verify_area(READ, old_file, &old_pos, len);
+	if (!error)
+		error = rw_verify_area(WRITE, new_file, &new_pos, len);
+	if (error)
+		goto out_fput;
+
 	/* Try to use clone_file_range to clone up within the same fs */
 	ovl_start_write(dentry);
 	cloned = do_clone_file_range(old_file, 0, new_file, 0, len, 0);
@@ -309,6 +329,10 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 			}
 		}
 
+		error = ovl_verify_area(old_pos, new_pos, this_len, len);
+		if (error)
+			break;
+
 		ovl_start_write(dentry);
 		bytes = do_splice_direct(old_file, &old_pos,
 					 new_file, &new_pos,
-- 
2.34.1


