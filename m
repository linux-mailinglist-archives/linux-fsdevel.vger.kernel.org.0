Return-Path: <linux-fsdevel+bounces-53288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AEAED2B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535141685A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37571C1AAA;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sl9KT2LB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23117A2E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251985; cv=none; b=uveWWtzy6t8biEbO8NEP8F5/IqdtCqhpulnZtRnRgJQHZop8m1MClAVCptLckbXIFCdeCJxwka9G6/CqqVw0F4rxNkgW8JYPTKkzMaZjgVgmTdPmw5xwB2P4KauSx3+vzSjMi9/1QqUDjsH8sA8mKuRDCpL2Wurp+oWnu7RSgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251985; c=relaxed/simple;
	bh=wEQ8ok02THNF5ZlGK3RUReIGCqa+Tl860xuEzqtzjEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XENiHXMXf9SzAZgoH6AiTFnuTeLCRuiSgB6x+Rknic3rFMD7DTCV1dsg9/Ln8yW4hTR1rpLxSjSCYzuQ2IBjVmK8YiuceAIOjwmENOKXzRp9wDawv6dlNskKkmlvNXYdZYkf4yRAHPXx/zAixxfwowOvFSeIxlJlRWXgtKvZOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sl9KT2LB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=99nY4IYw9m7r+n44gsDOrifOeRvpLGU3gO8TZMPaaKE=; b=sl9KT2LBrEowFo20s2kS0d3MFl
	ACqjgpd1x+gLVCvTOVz3w2/bhFeoyM+i5L8xJUw0UpHyRFA00sumM5DrfsLaJgwHBrb5gMCQ5oQ/S
	QTXs/7oaInPzySlcJq6luiFrtD0uUGnLR1oSQvIcb/f6qgh6ztSCX7Xl8p/6oiY+QlMaGJSEVZEmi
	kpP9Pw+Rxug6BPgbojBZdxS/Ii1xFfDHq4jH5woPjpttfutfVDIf+CWSe3W2J7QMoR6oCrrzt9zdf
	cJF8QtHQY53+Eb9+Lm7swLDAr6XFbh6be6EGDQHbY5C2qQPqGh484mwxiZPNIQrjKTHsRa8ABe3HC
	1e3Qh3rg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dh-00000005p5R-1U8O;
	Mon, 30 Jun 2025 02:53:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 48/48] statmount_mnt_basic(): simplify the logics for group id
Date: Mon, 30 Jun 2025 03:52:55 +0100
Message-ID: <20250630025255.1387419-48-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We are holding namespace_sem shared and we have not done any group
id allocations since we grabbed it.  Therefore IS_MNT_SHARED(m)
is equivalent to non-zero m->mnt_group_id.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a75438121417..c549bd39c210 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5298,7 +5298,7 @@ static void statmount_mnt_basic(struct kstatmount *s)
 	s->sm.mnt_parent_id_old = m->mnt_parent->mnt_id;
 	s->sm.mnt_attr = mnt_to_attr_flags(&m->mnt);
 	s->sm.mnt_propagation = mnt_to_propagation_flags(m);
-	s->sm.mnt_peer_group = IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
+	s->sm.mnt_peer_group = m->mnt_group_id;
 	s->sm.mnt_master = IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_id : 0;
 }
 
-- 
2.39.5


