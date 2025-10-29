Return-Path: <linux-fsdevel+bounces-66189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C928C18A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C64E356D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A249311C05;
	Wed, 29 Oct 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KR4Xoiih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC83115A2;
	Wed, 29 Oct 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722155; cv=none; b=aHOhg52/7lkkpXwZE6IefeKtthfGI1QSI1F2x8w6Pky7tV1vxfWenjRBJWHABWsApEbZEcRoccG5kdrl+j3qp+1953goUZXKJftWa8JH23ffg250LU8gFhXSnOgAL/6y9UZZUYTqs85Y7kqQn7IL+zDxu/uqfe4fFbbSxV7P29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722155; c=relaxed/simple;
	bh=FkKxHXIMfSJ/TLwwukkIwq5sCApu5LuGbnJP+uUaDoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiWEhizFMdcC7Dn39f38nmu0svKG/ktp6fsfXvWqJBgzW8TeqExE0umVYJb0+6txXAskpi2wYIWPtbqyA//ZW+cvBvo+6O/9Kbpy65zDNoZ8xj2m5oZnKq+Qi6IqG9LVoUlJrItroh627/XnQ7w5AGtQBQK0bHdUmzNGNRoYfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KR4Xoiih; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g72UZ6fXHGAAN3TegEday6QsedQ9iw7iVg8yuyvKIGk=; b=KR4XoiihW1F8q7+XVcXJu+WGAl
	O5Q3qsIga1b2fhWxTboat9oGapZ4htPHjitIwYZuKqSGGatWoF/uR5G7Pad2GKEgVub0yeW3Il/y7
	+b52NngNYuTPrlkDfrGKYEO37TEPQE10jwC+jSMV2PxN65lpogm9ojfZVdglcvBIEarZI3pjjGBWZ
	qoVxqIE4w+rsoxXvS05IzLpVJdNsHmGwy9iCncBlE/XaLxPnMGSTbDWZnHs0o0u+mPLrVc++7E22I
	qA95SoeqMe1tTpfIos89KKnfAl+9I0oXA6MDvtqy2rVmLAb9jueAZZS+hAqtIYCx9mMi8S1UQ35RI
	N5cTqgDg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0PQ-000000002Wf-3CyD;
	Wed, 29 Oct 2025 07:15:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in generic_write_sync
Date: Wed, 29 Oct 2025 08:15:03 +0100
Message-ID: <20251029071537.1127397-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently generic_write_sync only kicks of writeback for IOCB_DONTCACHE
writes, but never looks at the writeback errors.  When using
IOCB_DONTCACHE as a fallback for IOCB_DIRECT for devcies that require
stable writes, this breaks a few xfstests test cases that expect instant
errors like removed devices to be directly propagated to the writer.
While I don't know of real applications that would expect this, trying to
keep the behavior as similar as possible sounds useful and can be
trivially done by checking for and returning writeback errors in
generic_write_sync.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 09b47effc55e..34a843cf4c1c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3047,9 +3047,13 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 			return ret;
 	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
+		int err;
 
 		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos - count,
 					      iocb->ki_pos - 1);
+		err = file_check_and_advance_wb_err(iocb->ki_filp);
+		if (err)
+			return err;
 	}
 
 	return count;
-- 
2.47.3


