Return-Path: <linux-fsdevel+bounces-68901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C6C67D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D967E34E00D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396672F90D5;
	Tue, 18 Nov 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U4gmDt7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C2226CFD
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449786; cv=none; b=bM4jKyKUrMsPdITIDSnbOXFXq2mNSW9ZyyXovMPZSt2X8vTeeRnKsluMzKgKPL2nHMLd7vlMIKsW0AbTv/P23eRSp4ZdsDlFDcxwz1cLEODdE3tnKfk79PECDD7JvtSy5M58w+J3dLorFXkR6xBSSbxeQflrVaNSAFnkYbjRleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449786; c=relaxed/simple;
	bh=ilcpuggLVYpIZCoQ+wwVsyocZdgqhinJ5DHM2/mFwDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Au5TfbTCehuPAGhO+EfV+ovVGKROaOAmrVrHZYbpgaWStz2K0p/3VGWnxV/BjwQRSIffTOq13MUFil2Gq3HAwDic1dpIX9v98Zc60nQZ6fZOrOqoG4fbSiU9SfkRo7g4Bq7u8Rz3CDUwWOZUgVq/1f2fw9odyNUq0zPv0ffCKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U4gmDt7X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PJIsCpwi4tmFtaV0er9VVHcRlZCsh4yyliH1L/Qv2Vk=; b=U4gmDt7XUBj8U7MCaWvodOu5DT
	LLQXYB90I41cJPel+ttVKPwCBNtdqDpk8yFWRbYX4x8gOJSGViB5Rk1vSqf2druqdi5d82jnEGzbo
	lgZE3MNa5uVnWjMqVh7t47sH4UFQJnTSTYBc2Ei5X+CviQBIpshPnYkvY7DoIQjaEQO8wq/rv5aDE
	NxoB1cV9MlvKlL8XHVQsOxPA5uEZL33Q5AJ47Spj0idYIAPZOJV/xl94/7mSbSan0j4HAN/ebBaUz
	lS891ptnQ7AqaLc3jhfeGmrIWFHxekSsFc5Ztqv0+GTvbdvuRNaFUg6DjvGPqqlkwwufAbjUO1/Ix
	9SNk/FMA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLFqS-0000000HXW2-0Q9G;
	Tue, 18 Nov 2025 07:09:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: unexport ioctl_getflags
Date: Tue, 18 Nov 2025 08:09:41 +0100
Message-ID: <20251118070941.2368011-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No modular users, nor should there be any for a dispatcher like this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/file_attr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 1dcec88c0680..63d62742fbb1 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -316,7 +316,6 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
 		err = put_user(fa.flags, argp);
 	return err;
 }
-EXPORT_SYMBOL(ioctl_getflags);
 
 int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
-- 
2.47.3


