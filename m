Return-Path: <linux-fsdevel+bounces-37311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EA9F0F43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A728266D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494581E231A;
	Fri, 13 Dec 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpQN9J9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB11E1A2D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100472; cv=none; b=aE8gjFn+FscJ6kqC3uXndaO23gV7JkwFRpgwMgK06EqLo6DlVmATs+UmqhoQ+qKn5xy8MY7eeh5BxnrLeDVta+BO/qTKzYOdellVFTSzTJn498X7JrJcDNk2zptCITOqwHF+UciKRfNFEOuQ8P+tZ3bzQRxQYh9GnD6T/jLoyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100472; c=relaxed/simple;
	bh=iOgQQylLMrtcvG6U9Yq+SXyo5Ad4O/vHOE1AWCM7Syw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiTE3KDfARinAWGtYAnCazTN9VaZYeHx9FUhOkAbCyvix5/IR2sH9WllD1cCxy17g7ptL/JdUu1xIMlNvrqCoaIBWsedcFz5rjt76ZzWKCH821vJNXM4dTYIY/ya4EQF3BuLQRxojsK4gKa3Jm1uIhagDSJO3YWPX/YsNrkCkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpQN9J9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734100470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+pyrgRUSK030l+dOQQ2M+Rf2PxL5PCacIPzx7MI32c=;
	b=dpQN9J9x1cV/+UtokqzzDpM717U9n++lqbDrtGiF74Qvqu3sDJa0RBFUDPKyha87TNKlgl
	tq1G0HAKeBVtvrYWo7Zzpr3rno7MV1hLZ7RcU3pT6wPhZSWrt/UNQKpHT4or77vXUjK1O7
	fyERcgNZFLxo853JUcm6Dcn73PanS/U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-nuVn901UOy2hjXBLI5VTpg-1; Fri,
 13 Dec 2024 09:34:27 -0500
X-MC-Unique: nuVn901UOy2hjXBLI5VTpg-1
X-Mimecast-MFC-AGG-ID: nuVn901UOy2hjXBLI5VTpg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BFD319560AA;
	Fri, 13 Dec 2024 14:34:25 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 707A9195605A;
	Fri, 13 Dec 2024 14:34:24 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 2/6] iomap: factor out iomap length helper
Date: Fri, 13 Dec 2024 09:36:06 -0500
Message-ID: <20241213143610.1002526-3-bfoster@redhat.com>
In-Reply-To: <20241213143610.1002526-1-bfoster@redhat.com>
References: <20241213143610.1002526-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In preparation to support more granular iomap iter advancing, factor
the pos/len values as parameters to length calculation.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 include/linux/iomap.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5675af6b740c..cbacccb3fb14 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -236,13 +236,19 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
  *
  * Returns the length that the operation applies to for the current iteration.
  */
-static inline u64 iomap_length(const struct iomap_iter *iter)
+static inline u64 __iomap_length(const struct iomap_iter *iter, loff_t pos,
+		u64 len)
 {
 	u64 end = iter->iomap.offset + iter->iomap.length;
 
 	if (iter->srcmap.type != IOMAP_HOLE)
 		end = min(end, iter->srcmap.offset + iter->srcmap.length);
-	return min(iter->len, end - iter->pos);
+	return min(len, end - pos);
+}
+
+static inline u64 iomap_length(const struct iomap_iter *iter)
+{
+	return __iomap_length(iter, iter->pos, iter->len);
 }
 
 /**
-- 
2.47.0


