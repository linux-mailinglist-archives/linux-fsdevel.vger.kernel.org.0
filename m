Return-Path: <linux-fsdevel+bounces-51170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326FAD3A26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9173ACA79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706E2951C8;
	Tue, 10 Jun 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kkRxdeBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11179293443
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564026; cv=none; b=qIwUO7yStdoCu56MriH88YKaCjhN2XRtIbYjelL6yhxfu5d25B0WPrNKH5D8Qu03iAzyp+PazDCBnkLdzsZq274C+akE0lans7ppqy2JUR4HgW3MQkrUifblNA7o0kU6MyrOoDEgV6+r/Fby3C5eD1ErPepDZ0iYRPXWF4GZiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564026; c=relaxed/simple;
	bh=7RTBoVe9/Ap1CoCSGFKqkHZhDNBJFKq+wDQkbpDehDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDMkYajloIOfdzLSAl2JSudw5dETVqdW6GN1qw1dcdxIGXpaTO8FycrxJvQHoQ9Ga2U9k71dUEH10iXylJ6945JLEBofg1um573uQlhG4O3WkV/YdsyQxYVfzPn1e6/a4RHPDsczHIfqi2IcJpYCxH7E16zLXPDpxDxzwgV1SU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kkRxdeBM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7XiA5nevZP8GISvc6PEpJFZzXPiKjigfq+ZtVl4RJZo=; b=kkRxdeBMhs9ihaYbauSf8AE9kB
	m+ByvNb2pOtjidm6GtO5BrE1LM8bdUSAE7mV9W4mvRBPV32LU/bCvdwpRniC/N+N9pc5eM+mKnPz2
	1uQCLlZWzjm1fv6OjZjQBB5O6nd/H5/fBNPPcTdA/YCQlV9kUtopogYUbAEbXZYB98ZE3YwlN4SZD
	YBkW/dBn82luPwVrg+y2ks6DpE4+gLOiNxadOkUSf6WMNYrFh48gJublwUMGp1+UVfu/4/ckW5C1V
	TG+tI5cpLupGR8uj5Ih+M2vEPxM+DygcV3nxiWAHmUL/UrIvxvJLH+FJV9aCrJyE3Ymsp/vRtGNwt
	cCz8xa4g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOzWa-0000000744U-09qG;
	Tue, 10 Jun 2025 14:00:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: add missing values to TRACE_IOCB_STRINGS
Date: Tue, 10 Jun 2025 16:00:20 +0200
Message-ID: <20250610140020.2227932-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Make sure all values are covered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..d27c402f1162 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -399,7 +399,9 @@ struct readahead_control;
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
 	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
-	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }
+	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }, \
+	{ IOCB_AIO_RW,		"AIO_RW" }, \
+	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }
 
 struct kiocb {
 	struct file		*ki_filp;
-- 
2.47.2


