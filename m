Return-Path: <linux-fsdevel+bounces-46322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE802A86E2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E643A8DCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3BE205AB8;
	Sat, 12 Apr 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBLJeNkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4B1C5F18
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475972; cv=none; b=NzZvLaJ9NW/osjciVAjbhUpf57locxUlavtAjN0xDehdRtgieBesYV/s5pdz02PZaa6wjysQ5K94iijeXPJfSGxMgX6P3qXAbrAqmsNFZgaHSTHqSGy7+syFEaG6e06ATZLlmcclrowoey+QHk4BA799vRw9reUM309h1dOa0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475972; c=relaxed/simple;
	bh=KrifTKNbtTOpZjVsriJwHelBy/tOyNLz7rJCylrYNzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj17fFx5KVeOzTc95XOdazzp7jbJWXsnN90Z0dH20v3aYDZhKNlYMeGBDX4PdwWY398EiZYbK0Sl1DTo4wFCnm794qM6eVnHMBbJEZNpGXA24W8IFyswvgf2dwkYz/iLn4OYILeq3sbzuNX/8FJSEHGbmUAOb0T4bohs7kyTD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBLJeNkw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744475969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=as4CGAakZQuKhDm6Y+wA6IfY1weX2O0DARSrhX57YeI=;
	b=YBLJeNkwB+himribu+l/sVJyOhZz0Y+grHua4xPgaG6OlRtbLrqtqf7kFhbE3nFRj3Qm72
	Twkum9ArTze/6Y5swXhHML/oi0niI0jqk4BIzJBtZlzBvm2RmdkrinjJB/tw1bBeYiWobH
	yqvcQKHyfBWAJXnVebeJKhxaXiy7mS4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-xbQKs-d4M3a2WxYTFrA6YA-1; Sat,
 12 Apr 2025 12:39:28 -0400
X-MC-Unique: xbQKs-d4M3a2WxYTFrA6YA-1
X-Mimecast-MFC-AGG-ID: xbQKs-d4M3a2WxYTFrA6YA_1744475966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D6A3180049D;
	Sat, 12 Apr 2025 16:39:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69ACE180174E;
	Sat, 12 Apr 2025 16:39:23 +0000 (UTC)
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
Subject: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
Date: Sat, 12 Apr 2025 18:39:12 +0200
Message-ID: <20250412163914.3773459-3-agruenba@redhat.com>
In-Reply-To: <20250412163914.3773459-1-agruenba@redhat.com>
References: <20250412163914.3773459-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Jan Kara <jack@suse.cz>

inode_to_wb() is used also for filesystems that don't support cgroup
writeback. For these filesystems inode->i_wb is stable during the
lifetime of the inode (it points to bdi->wb) and there's no need to hold
locks protecting the inode->i_wb dereference. Improve the warning in
inode_to_wb() to not trigger for these filesystems.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/backing-dev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..e721148c95d0 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));
-- 
2.48.1


