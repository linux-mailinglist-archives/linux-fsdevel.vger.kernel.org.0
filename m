Return-Path: <linux-fsdevel+bounces-50886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1561BAD0A6C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750D21898FED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB623FC68;
	Fri,  6 Jun 2025 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzhwtwdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A62241680;
	Fri,  6 Jun 2025 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253381; cv=none; b=pcnxtbw0n+HRPNhP/CVpyYv2PbS/eYos+UOjN7oyCNpdJUagJqEzOkRreR1dCEdIPk/X+KcePpFG/l7ye0WxCZJ68x1Ka0dkuLv0gAXkGccp1RGk7Q05J9NUPcmiEwwJFZ4IlcWqQ2efU+5ODBNZJw7VneimfvVxb/kQ9zh2DjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253381; c=relaxed/simple;
	bh=qQvLx5PcSgWdyo16h49wOe8B93mV27DvT37ecsaFjjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4FTGE8vvvD4Pi2T0kCIkQYAalvNV0aMq9eezMT+pbrv72u/OY5I+7fWNQXaOQeY7qFbs872p/cRZna9RL09DbPTBTniHVCJipuIqwi5NYG7ToMR+2p+g49bIBcACdOXdzDXcpTcM7npW9pZaDB0EoppNJpvVT1qojw5CBjsKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzhwtwdL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2869922b3a.2;
        Fri, 06 Jun 2025 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253379; x=1749858179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwX63nTAkDTtXDVrXAWK+8oRlCoyozsPxl88rGGrn9I=;
        b=gzhwtwdLrlWLAyo4DCYaLNu7LHVbkpD9NqgUJXU46GqQ45tRXerEua2Xo6On9/23Ma
         JAB9ZxLMxHxMQLj/RRqnTjGH/8e74asiA8K6pJcpnateXl5xUUGvX1PGfrtbJX94TpA3
         sIVPi8pVmjlu1xZfw9AmOt6w7KZeBO32t8wKJaEPAofhTp8x5RjqkQS/GjB7PSM8AYzz
         LcU9zfYXjsRtX44USdnn1wXOgljDTEJDJx5yj7U4opDrqKQKYNae1CVFVGon9uG/z2bZ
         BQ56HrHum3JsiZURzS6TfzTPJu3W+nMNaq7EZLGC52DRRbyGL8FJikYHC/3+Tu9rZXZn
         lmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253379; x=1749858179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwX63nTAkDTtXDVrXAWK+8oRlCoyozsPxl88rGGrn9I=;
        b=jZEQnGtd2MxKQALsjSENGwRrSSp6nPA1JAIIzkM5TjkbxTyZMoEnx+e8hJz/e8ZzAv
         lu9JTxXo/HrJO71G49MEr/OTiRlFnT3rFy1pRTst09ks1Kstvvb0Z4G1dGzwKvyz8+gd
         LT+8ssonvGmW89X4b00tjLCtsw8LAP2KLf+uZwGZeOsS8G9TOwB0yJDHTO5y8XXCF0uJ
         vwtLR+iHuzdYi+oMu3r4XYsRjmFjGj8y2n+017CROzhrMfvoM4evbvy4vaHUG6QME9Vi
         ofcGnkUymjOv1QxB1fixaeD4PxOur6VGHrX2SikGJok4ZzA5jHDIzYG95jRzH0mMXQEb
         Ch3A==
X-Forwarded-Encrypted: i=1; AJvYcCVU3IGnypINp91o+4+DUhgjBCb358MO+ePYrGAi4SnRnVAI7IPndH+v1+/yTdMXYlL9MAu2hvjKwD8m@vger.kernel.org, AJvYcCX6+P6fsGWcG5dEoNGAxF/AO17I3IPFVAzwQ9axAq9Ks2J6DWHQccyztzmqd3ryFLzSKFeIEWWPPEKmxvwz@vger.kernel.org
X-Gm-Message-State: AOJu0YznQGkC013jsjZdQ9E8xOsF5UehbDvrKQ/ZN+aHDGStuJ10eMHH
	gXVJSlnhGUw5HEHqkpICgLb3qcGDlWenqYXwdmIFhksd4jCGrcC2TWPy
X-Gm-Gg: ASbGncsFbwKp7QRehX7nl4ghSXYxY7nSahI5xbB6MkLaG4RFgBNuzNnlm9LU1pEYtJO
	Wix/xe/ys2uCvgJvnx2ZufeTBEcHEqGDLhnVHluHSr/4y/jUk/lpcKs6ZQ3dsmcRm+6Gojg//c3
	h43a0k2sMsL9ij/ga9Y6S6EIQHAE0CqBEGb19QLA5VFGJnQAOiBdcIO99VN/MjpMr/AeEDfwaIE
	s3suA6fdkBpVgb73GQbkteYW4W4DJwL3s1Ck5864F49Q400OU2PJE3IVOHmElLMSdmdKZc3iqHF
	XPScMWGvTK8ccp8uN1arbvn6M7vbOO5N3DJCNGlc2C0utg==
X-Google-Smtp-Source: AGHT+IFn2epV1JoXB9fJE+vrL3FM+pbijsZsB5xMnrlgR57cFNX+dl8pGtzNrkSjG4ug5VrJkshCWA==
X-Received: by 2002:a05:6a20:e605:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-21ee258bddfmr7720956637.8.1749253379369;
        Fri, 06 Jun 2025 16:42:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7a216sm1798139b3a.40.2025.06.06.16.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 8/8] fuse: use iomap for folio laundering
Date: Fri,  6 Jun 2025 16:38:03 -0700
Message-ID: <20250606233803.1421259-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iomap for folio laundering, which will do granular dirty
writeback when laundering a large folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 49 +++++++++----------------------------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 31842ee1ce0e..f88603c35354 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2060,45 +2060,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 	return wpa;
 }
 
-static int fuse_writepage_locked(struct folio *folio)
-{
-	struct address_space *mapping = folio->mapping;
-	struct inode *inode = mapping->host;
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_writepage_args *wpa;
-	struct fuse_args_pages *ap;
-	struct fuse_file *ff;
-	int error = -EIO;
-
-	ff = fuse_write_file_get(fi);
-	if (!ff)
-		goto err;
-
-	wpa = fuse_writepage_args_setup(folio, ff);
-	error = -ENOMEM;
-	if (!wpa)
-		goto err_writepage_args;
-
-	ap = &wpa->ia.ap;
-	ap->num_folios = 1;
-
-	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0);
-
-	spin_lock(&fi->lock);
-	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
-	fuse_flush_writepages(inode);
-	spin_unlock(&fi->lock);
-
-	return 0;
-
-err_writepage_args:
-	fuse_file_put(ff, false);
-err:
-	mapping_set_error(folio->mapping, error);
-	return error;
-}
-
 struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
@@ -2271,8 +2232,16 @@ static int fuse_writepages(struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
+	struct fuse_fill_wb_data data = {
+		.inode = folio->mapping->host,
+	};
+	struct iomap_writepage_ctx wpc = {
+		.iomap.type = IOMAP_IN_MEM,
+		.private = &data,
+	};
+
 	if (folio_clear_dirty_for_io(folio)) {
-		err = fuse_writepage_locked(folio);
+		err = iomap_writeback_dirty_folio(folio, NULL, &wpc, &fuse_writeback_ops);
 		if (!err)
 			folio_wait_writeback(folio);
 	}
-- 
2.47.1


