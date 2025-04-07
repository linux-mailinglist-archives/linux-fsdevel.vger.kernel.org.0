Return-Path: <linux-fsdevel+bounces-45909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B4A7EBA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731D07A1CF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7725A329;
	Mon,  7 Apr 2025 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARTtZ2RD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE9259C9E
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050085; cv=none; b=uo6alPFcu0WYmE3Y2peqWydB/jFtwssi7nGPfkYZV6pw721wTBuN8VT/zlDXpfuHRmaOb5uDgZR6dFh750sJblItmNpVDve8e2J+MRN/iQgYIxkC3RHVt5fyShpTv2qtQayZpM4rbI72euC1TfMN0UJjbRS4i5GiRc71nO67Zrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050085; c=relaxed/simple;
	bh=sBuyu8GDFSBAh8ocfuIg/uvXdPS+I0GpOEiqMXd2lww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwdivalyF+KieEuO0aEXONm7dibPwcGOP/X0ibpQuJfAAbtqFYsdVX9znyGirLKDctJreB3FuxYZd4mmJL1H8ErRaPYYxjupYaw0Ct/IJB/3sCxRvc4mjXNq/u/Oyg/1Ck108nfZp2+CX6Rjsifw1tfSk0QEmWeJ3HuTIUxn+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARTtZ2RD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744050082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r207ou57TRn4Q0BVpY2sMaqzJuM7STz+41u9bkzpKR4=;
	b=ARTtZ2RDpvXQeWIE77O1yzU0JJm5dD8OXCeGGTaKmCMNkNlr+RVhZZoCx9HfDiObh4+QDD
	+JyZ2H2tMa7WR7Hrl2nb2Aat3px4b29y4L9gnF8yB62RKOe9AowVeG74RuxMeNIhPV5t6U
	XlNv3nmfcLfDobKF+R2Ap97c//BSKGo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-K0TaAE15OlaiLMNeZtQo6Q-1; Mon,
 07 Apr 2025 14:21:18 -0400
X-MC-Unique: K0TaAE15OlaiLMNeZtQo6Q-1
X-Mimecast-MFC-AGG-ID: K0TaAE15OlaiLMNeZtQo6Q_1744050076
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7899318001F6;
	Mon,  7 Apr 2025 18:21:16 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 352CB1828AA8;
	Mon,  7 Apr 2025 18:21:12 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cgroups@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Rafael Aquini <aquini@redhat.com>,
	gfs2@lists.linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC 2/2] writeback: Fix false warning in inode_to_wb()
Date: Mon,  7 Apr 2025 20:21:02 +0200
Message-ID: <20250407182104.716631-3-agruenba@redhat.com>
In-Reply-To: <20250407182104.716631-1-agruenba@redhat.com>
References: <20250407182104.716631-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Jan Kara <jack@suse.cz>

inode_to_wb() is used also for filesystems that don't support cgroup
writeback. For these filesystems inode->i_wb is stable during the
lifetime of the inode (it points to bdi->wb) and there's no need to hold
locks protecting the inode->i_wb dereference. Improve the warning in
inode_to_wb() to not trigger for these filesystems.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/backing-dev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..4069a027582f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -245,10 +245,11 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
  * holding either @inode->i_lock, the i_pages lock, or the
  * associated wb's list_lock.
  */
-static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
+static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     inode_cgwb_enabled(inode) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));
-- 
2.48.1


