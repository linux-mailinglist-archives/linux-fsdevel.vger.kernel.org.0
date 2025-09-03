Return-Path: <linux-fsdevel+bounces-60080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91247B413EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E081BA138D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C22D9493;
	Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jwyNNmmc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9332D7DE1
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875348; cv=none; b=fGaFuk8/YdnQFT/15/8uLGpL8e0joD87KaYJ9E1eRTP2QFTeoELBEr5auzm4SPKJW54BYGmUc+ftMcR8tgikVV/OxxNw/SNLnPkJsiB6oVzODl4TM5fGo1t8OqzOH8VzRNTiuLjt/UEiJ3roe/3OQQi9kNDy9l3ORC0gtnmW608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875348; c=relaxed/simple;
	bh=VqvfQ9QQMuoS9SLWGE4TFB4GaG2mVceot0R6MZmpxrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbSRZEkHtHAWJzhqAlk87m9aYXXgk1hf+3oEtcPX7i4uPL/e+39yK30NlWfDcDvhC476X10lnRY8WCoYaTB2Jptae9IWYmOxEGMG1iFsRajCUOVZuYvcBgShiHzpMtWfVx/5b0A9ow/qHBroxx9JwmGM775KmqkZBoiwUtFC9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jwyNNmmc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qPoarpJtJspHJl7or5UBxccKQ2kiBEqcUcSihQ5uwX4=; b=jwyNNmmc/5XEyF5l963ItNv59U
	6FqaVLxTYBm5SmPtdI5fUStPQXkwyy+JNQ8nWr546E8Qf/iULVbRXCBcgJC4J7PZEaXy2Dxkcz5fC
	1dikWZ1mUPEIYs5Jll8hN/iic2/6Q0tjJqmHInDJSm07sIifscY/H6Cs/LGghlVKeISJc401Dyi9e
	VXl2ZxKpVI3VbDEBXnoaDVsz15QybEtFB0NC1759WUY4wL79m0FQU44TD8tO734YQdJ1pVg5pTMPN
	MfSryy0gKlXqOMAOVu3JHRqLf1CvH0BoUUEDA5eQM46+dDOz4zO/02XLgw3nUUcw4us+tfJbclwUQ
	36oPnfSQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX6-0000000ApBo-2ItZ;
	Wed, 03 Sep 2025 04:55:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 36/65] constify check_mnt()
Date: Wed,  3 Sep 2025 05:54:58 +0100
Message-ID: <20250903045537.2579614-37-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c2e074f66bd1..511e49fd7c27 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1010,7 +1010,7 @@ static void unpin_mountpoint(struct pinned_mountpoint *m)
 	}
 }
 
-static inline int check_mnt(struct mount *mnt)
+static inline int check_mnt(const struct mount *mnt)
 {
 	return mnt->mnt_ns == current->nsproxy->mnt_ns;
 }
-- 
2.47.2


