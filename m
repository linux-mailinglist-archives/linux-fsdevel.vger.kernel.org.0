Return-Path: <linux-fsdevel+bounces-41213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18522A2C556
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8477167984
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757D23F27A;
	Fri,  7 Feb 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/+6JnNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0BE2405E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938639; cv=none; b=Ww2y952nuPtJceybt4X8zTboTBWBNlhnHb9eupWZII5qDaQSlUBfphDQ3iuz5usrGGQKlDFKywyUAFSf6SplHDJf2pne2IelFPowC7YidwMGU1K+3DKOsjJUrMoF5xsU/GzfZqnQEMV9uQy41ZtEUIAsqfRpC0oYwJok6hXepGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938639; c=relaxed/simple;
	bh=Yy2t5zxuzzeOlFYEfiw1gfeB8osO4HR/elyRJ/TS87s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQqE9gc6I7DOTB57QWZV6wtuM8lAQisiWTHZlzL2tRQ4cSCOLYy8FLl/dhwj+jSpYKKWHHjv9PnDNjqeR7w994X86ACTlSTxOEZyDhuZQJQb/cgEQwcWReohQjj4pd+lDK4yjySJDZHHR2YeHMK2ADAe2LQZKmyGwlPRnxa/2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/+6JnNV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBER2SSTWKVCzN2tmH5sWjG12sEGTNj3zK7QdpNhe3M=;
	b=A/+6JnNVm1R3FvtNZ68/4Rvj9oUyf77OwmVzgB7iTsORcY6O2pHNPDiITQudleDRRbnfNN
	Wct184DBtsAWiT77oMW86Gq+lHbaLsd+gZakm+sTy1+i2VAf9hb1wczzrbT5hbPZPCcusI
	D0qhZJ7Syb8lWHlioVoGiUEwE3Zins8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-2kqwtLDRNqur3nMUYYoBtA-1; Fri,
 07 Feb 2025 09:30:32 -0500
X-MC-Unique: 2kqwtLDRNqur3nMUYYoBtA-1
X-Mimecast-MFC-AGG-ID: 2kqwtLDRNqur3nMUYYoBtA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42F281801BD6;
	Fri,  7 Feb 2025 14:30:31 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58DA21800352;
	Fri,  7 Feb 2025 14:30:30 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v6 03/10] iomap: refactor iomap_iter() length check and tracepoint
Date: Fri,  7 Feb 2025 09:32:46 -0500
Message-ID: <20250207143253.314068-4-bfoster@redhat.com>
In-Reply-To: <20250207143253.314068-1-bfoster@redhat.com>
References: <20250207143253.314068-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

iomap_iter() checks iomap.length to skip individual code blocks not
appropriate for the initial case where there is no mapping in the
iter. To prepare for upcoming changes, refactor the code to jump
straight to the ->iomap_begin() handler in the initial case and move
the tracepoint to the top of the function so it always executes.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/iter.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 731ea7267f27..a2ae99fe6431 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -73,7 +73,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
 	int ret;
 
-	if (iter->iomap.length && ops->iomap_end) {
+	trace_iomap_iter(iter, ops, _RET_IP_);
+
+	if (!iter->iomap.length)
+		goto begin;
+
+	if (ops->iomap_end) {
 		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
 				iter->processed > 0 ? iter->processed : 0,
 				iter->flags, &iter->iomap);
@@ -82,14 +87,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	}
 
 	/* advance and clear state from the previous iteration */
-	trace_iomap_iter(iter, ops, _RET_IP_);
-	if (iter->iomap.length) {
-		ret = iomap_iter_advance(iter, iter->processed);
-		iomap_iter_reset_iomap(iter);
-		if (ret <= 0)
-			return ret;
-	}
+	ret = iomap_iter_advance(iter, iter->processed);
+	iomap_iter_reset_iomap(iter);
+	if (ret <= 0)
+		return ret;
 
+begin:
 	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
 			       &iter->iomap, &iter->srcmap);
 	if (ret < 0)
-- 
2.48.1


