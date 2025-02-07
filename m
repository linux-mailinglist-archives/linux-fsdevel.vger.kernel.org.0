Return-Path: <linux-fsdevel+bounces-41197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7106AA2C3B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E812216B4BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392D1F561D;
	Fri,  7 Feb 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WX7zerXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8CD1DE89B;
	Fri,  7 Feb 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935314; cv=none; b=FHQVtQtCQhuCH+vvPaVUbCHuNk4QlZene1hD1r6cisRPYObn5KL+StoT81xdj7Csodurzh4nnMbWVvhjd6a9ZxmNol7LMRbKDI787d3VzG+GGhSbyIGhO3+tdL6kTRDm5i0RFdXoDmJeE+yhNRk1nkezuF1cZd6y8WXJJxCy5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935314; c=relaxed/simple;
	bh=8d/alkOiqYWk8/dvgN22uTZykuYv49MXHiQ+Vhcxz7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1/5pt3OQ668Wjb+0kh/fr7QS8rzwE+P9mzI731bJ7BnlggwNQNdpRBrDvHo859M5KKgaSb1FvOKDTGGOaeeynMcjRIs33sL43xJ2hYMHrZY905RfQm4+pxWrBEcXf1Hax4r1sLruBojvXRpavI0y+MrGUrWCtJhogIA9oaYwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WX7zerXX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MLIpvZkzFFyKPI7OoY68SAR7q1uURh6tXFwNkh5kNzk=; b=WX7zerXXuFRNHCXGywTeOQEjhe
	nQT4Ul2gzgF5+kqWw5o5jMXpjkZMIvU1mow3QgNdyMbbuYE6xSGXDJLu6QLGUoEXGutfUUNq3/qHq
	H8kE30RP/lxQcoUAuTB8LeG56tjG9vOCvLOetQq3VsQyqx0QYIx2lBXNFz2V3DFv4DUY7P+fhcKm0
	TxljRbORLcfUQ6LUD/Msy2pcLSCtDk+LRYCsf93hgHqvdLV7VelDcUYfWqIMmcI/6V+lDkl+7+cAv
	oCW4JSxgqBfC/x6YGrtlSwJGqX1bn0OElTRnghF6eGqJffrLkRV5plqaHRg3o7q3/WbwfjR2+4RuD
	uFp1Ek9Q==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tgOVY-005pd9-N9; Fri, 07 Feb 2025 14:35:06 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] fuse: removed unused function fuse_uring_create() from header
Date: Fri,  7 Feb 2025 13:35:02 +0000
Message-ID: <20250207133502.24209-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function fuse_uring_create() is used only from dev_uring.c and does not
need to be exposed in the header file.  Furthermore, it has the wrong
signature.

While there, also remove the 'struct fuse_ring' forward declaration.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dev_uring_i.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 2102b3d0c1ae..0d67738850c5 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -172,12 +172,6 @@ static inline bool fuse_uring_ready(struct fuse_conn *fc)
 
 #else /* CONFIG_FUSE_IO_URING */
 
-struct fuse_ring;
-
-static inline void fuse_uring_create(struct fuse_conn *fc)
-{
-}
-
 static inline void fuse_uring_destruct(struct fuse_conn *fc)
 {
 }

