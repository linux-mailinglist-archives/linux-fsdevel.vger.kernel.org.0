Return-Path: <linux-fsdevel+bounces-39762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3023A17C01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19BC160830
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4541EE036;
	Tue, 21 Jan 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWGP2vEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB81BD018;
	Tue, 21 Jan 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456001; cv=none; b=S8R3kW7Jn5f759s3EeYcXiEfC6cMr31BW5GJJ7y0fu48qxm1ufu8RXB6E+lCuNpRaPiIGQ55RTMn3QDPHx/84WZszVcRSwZDN/H06tOrjDK1vvv0FGw9AXuM89jaqD4h5lFH8LC1UdGuR8pC2yHajgtzI1O8+XtRULh+z8WvrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456001; c=relaxed/simple;
	bh=GNDHR5kJLcOvSrPrJL8f6HgDNoWUJEDZdMZe9QlhYy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LbORaF30sBSTc3sBH/jlNAMZkFVZn0/z3FoW2ScnnAVVVoQpToTcqH8w/E9yXHPoLUxiHHPCFGtEKvES1vgHYLDqkh+HJVSdqqYhLy78TSvVrMCBFhcKKPVni1IbzOxNKTllpZwQGZa7YEAtk6wgtjQr4lm+LnqWAEZ6Y5OGyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWGP2vEv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaef00ab172so833716166b.3;
        Tue, 21 Jan 2025 02:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737455998; x=1738060798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV/9hrVPJV3RaelYYu5oz+umVPhQLvZNKOkNGr0T2DE=;
        b=BWGP2vEvmPbLI5LmSOAcaWhrtlzKun54oR6IvWZitBTCNO6SLQLE3+lNbUQpdLGn4O
         c6bdLMzQJFL+bCc8KKhezZlR0Q4hZx2T8Gvyud3F+j5RqQEme2SqfhLxbyYAWDT05R5p
         y5re1wiyJy+x4T3lTE22RUshiORfz2x0lIXc4YipWDr9rs9e1Wa4DO3tbFWdi5MEhYgb
         rhR0hq63Knfjv0ku1+2CUuuR1iAdnt7UoTIgYqDvbkjOedIe67PQN5zmsWJl4tp0DPG+
         wcEUGdYzXkXgnV0QPYlbz73FlNC91SDwfdkzpt5hfczqGWwTtv8A1dnz9LppEfDNFmcv
         N6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737455998; x=1738060798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qV/9hrVPJV3RaelYYu5oz+umVPhQLvZNKOkNGr0T2DE=;
        b=bs0ug9frCyGI9C8xQy5kFid59C4sztGBN5HfefZcQrmNI56rhNFAlmX50UmDEtoLIJ
         0h9O7MyUv28NEyqB9VW0cf45N0KzCaxD5ZTy38NGVETzjqZlPVaNRJIySs2ztPqpEky6
         tsb5STsjUYGuy5rRV5BQYsj6TFxESyLIqmrZmmgCkexMaTsJ90QUD3Suw1VuusVzFLF9
         C+qJ8quFHWsitPVWFAVd2HUgDVGIElPJ6Pck//ELchnQ68pCRcQYM326vKPhb2hIFBqz
         kV47FsJDRPB6dHnJlAJLROGRt+uDSh+Jvz53ZkvLKU19eQ4kFpRZsRwIYflThdUPp94S
         pvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMbOtIoLoDxrpE7mtftZRlrm87gRX8FMQsu8KlHLfZBRz09oUoyjL60feaRwbzsVPLfvU8OcIgS2jE@vger.kernel.org, AJvYcCVu/tdvRA9UzDD6pDTp/Oh8gterGUWN5JP/8hdEwkEx/vpd17AVfT6qA5t3VG4nWEhM3g0TkLunavTIHnrK@vger.kernel.org
X-Gm-Message-State: AOJu0YwAS0nMvNIsm6/hV+baTtrIYroeCj818JTHzC1pwjJmLvqp8Seq
	eY8YkOHmSYIcvqYuDZy31rMP6G1cCCVUmohYmhqYfVEknlL07HH9Ruffu4DX
X-Gm-Gg: ASbGncsZ9ogAbW4OdNC6ZyPq8mhbGVj3cQyLf9P4sBEE55T6Y99gUqmK1QsHZdTksm5
	Ca/fT7NFks+wtpCcJHs01gvdV7YbFcPD1qoMb9a+E5UEgaxvlESUDkj0WdbP2I4yOgWt+1qSOSB
	d8g/g+5UOkEm6e23bUgmnl2kA6x/wRX/M0UYVaUIzDlXIQ5KhPxrR091NafxbzQBCnEYLmC/QwB
	HiMq3++rzM/ENVG9oOha+Iqmbya3MxntpSY0m+2wVBCEmsjbo9x1NYq6WeY3d+J8+6hAX7iHoR8
	Rd5zB9kHFv4G5W5FpBUURzfYQodEm4HfJUGTDckYqH2vYtbhzG6tRdf3AbEohHj7eDc=
X-Google-Smtp-Source: AGHT+IEy/nffdkkMTaf84P1+qIaSeELhgP+Gp1BQtti4JuECvSpctp6NtnXfq9tGRKSEstUaEzih8A==
X-Received: by 2002:a05:6402:2791:b0:5d0:abb8:7a3 with SMTP id 4fb4d7f45d1cf-5db7d2dc6bcmr45154847a12.6.1737455998069;
        Tue, 21 Jan 2025 02:39:58 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c60767sm731587566b.25.2025.01.21.02.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:39:57 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
Date: Tue, 21 Jan 2025 11:39:54 +0100
Message-Id: <20250121103954.415462-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
mapped EBUSY host error from rmdir/unlink operation to avoid unknown
error server warning.

The same reason that casued the reported EBUSY on rmdir() (dir is a
local mount point in some other bind mount) could also cause EBUSY on
rename and some filesystems (e.g. FUSE) can return EBUSY on other
operations like open().

Therefore, to avoid unknown error warning in server, we need to map
EBUSY for all operations.

The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
to NFS4ERR_ACCESS in v2/v3 server.

During the discussion on this issue, Trond claimed that the mapping
made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
for directories.

To keep things simple and consistent and avoid the server warning,
map EBUSY to NFS4ERR_ACCESS for all operations in all protocol versions.

Note that the mapping of NFS4ERR_FILE_OPEN to NFSERR_ACCESS in
nfsd3_map_status() and nfsd_map_status() remains for possible future
return of NFS4ERR_FILE_OPEN in a more specific use case (e.g. an unlink
of a sillyrenamed non-dir).

Fixes: 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
Link: https://lore.kernel.org/linux-nfs/20250120172016.397916-1-amir73il@gmail.com/
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: NeilBrown <neilb@suse.de>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/vfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d713..290c7db8a6180 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -69,6 +69,7 @@ nfserrno (int errno)
 		{ nfserr_fbig, -E2BIG },
 		{ nfserr_stale, -EBADF },
 		{ nfserr_acces, -EACCES },
+		{ nfserr_acces, -EBUSY},
 		{ nfserr_exist, -EEXIST },
 		{ nfserr_xdev, -EXDEV },
 		{ nfserr_mlink, -EMLINK },
@@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 out_drop_write:
 	fh_drop_write(fhp);
 out_nfserr:
-	if (host_err == -EBUSY) {
-		/* name is mounted-on. There is no perfect
-		 * error status.
-		 */
-		err = nfserr_file_open;
-	} else {
-		err = nfserrno(host_err);
-	}
+	err = nfserrno(host_err);
 out:
 	return err;
 out_unlock:
-- 
2.34.1


