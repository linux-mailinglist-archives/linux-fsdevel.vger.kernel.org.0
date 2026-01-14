Return-Path: <linux-fsdevel+bounces-73752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE800D1F8CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C04ED30136F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960E238D42;
	Wed, 14 Jan 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBwzh37c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh04fvoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89832DCF61
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402433; cv=none; b=gQZYS0YGXFhoDhIlWwrtrPyFwGcENSttzg8aZLQTZTJyUg7nN1kuJANStDuyagN3YeELh/TP42A6wgmz5d8d55/GQfa5uMQWZyfd3XVen2Zk1YUIHkb4ZJ4mvKfLrewUA2yw39Y1JBvMMKi6Ap9qPrKSPBJfl70clIY767xAULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402433; c=relaxed/simple;
	bh=Moxbj7dLNSgnHE7NrBhQcSm54p2iYBZIQyjkF0wWRnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQIyuyR8KzfvDs+v2vWt8RctM0NZrdCxZeYzPRJBx4ieml+NIrDqak3UgxrtIWWOHRegNfnDNfr04SIzwrILpiTxQgxx2tbhVQHnvIYpRkRMMdbYEjBVPvbYDp58OEpMuTkPnJoSXA++RwSPuOR1hPOmEjf6BGpJHil9NLsJO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBwzh37c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fh04fvoB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPhMk58n4hj6bGOpT6QSKeFcIkqb6abCBGBK1mpwtW0=;
	b=JBwzh37c9ebGyNKWnMcExiJzbv2QwD/90sM/HsDdPMpbv9pqEx4SCe8V0a3mIhhz0t5m5c
	h6wpVh+STihB7S8d1mBdQp6wUwHwg3XEL+FHDOBn3mJi4nztr5Qhr4B8fpD/dhKaoStlt4
	OnvA8SXhxpRygkCd90yU+/IVW641104=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-QXATkgq_MiaUd9jJQoEn0w-1; Wed, 14 Jan 2026 09:53:49 -0500
X-MC-Unique: QXATkgq_MiaUd9jJQoEn0w-1
X-Mimecast-MFC-AGG-ID: QXATkgq_MiaUd9jJQoEn0w_1768402428
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6502d9e9ddbso1296940a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768402428; x=1769007228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPhMk58n4hj6bGOpT6QSKeFcIkqb6abCBGBK1mpwtW0=;
        b=Fh04fvoBGb0HNsdH6pSDsfJ5ho2Z2L2ZadhCo6FmsRXWh4IEA30sZ8zlhCziKFuIJZ
         oK/OS2YQscWosT+2cvjJlr+D4B1vqU+js/8mwq5uIgwbDv+xy/sIcvY5pRmwQBUUrxpx
         u3w4n36ejRj4vKdX4sU7auDzR+i2Wh0fPS5mfmJvpjvk8gKpB/cyfU6uj+1Md+OhSbLz
         K9muxxQ8d29j7lIMFH6aXwk/4ECSTQJzK4VaMil0i5cxwpAA7k+sVKy8oQGPFysxHJC2
         YZYWJZVEiBgrsc+xSk4pEs8mFqQnk0Gg1Pj9t2Rqu/lYh0FwxP1a7ovwzLfgi7ZIajGB
         Y3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402428; x=1769007228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPhMk58n4hj6bGOpT6QSKeFcIkqb6abCBGBK1mpwtW0=;
        b=vdItgL9jUgE3zDHfNhuoucNEk+1F7aji911uBErpDBm0GqhbHwoK4JjPonROwyTyV2
         HgSgEM3OjWwbXDkd1SH6yVzupuUdwFL/SNxY4VjzVTIgHIkdu9KLB07AA9jwjsgyP6mi
         g88iqYUqN6x5IdQQfVrSkPDE4ctk8keGL6Z3xws7cFP8J/zL4w8lWxwZ2MFy5up8EDeQ
         cqx1sJx+C5VIVTea64wyhz/LZ+9pm6zwi0SU4BmWW96V0B7Uz5dHg98gnjg+HuEU907R
         H28kk8kO1/+g7v2qiWItSirWx0gqC1ANRv2UIRUloiREfGMXvnNdlvK+6hEEy5+IAhiL
         0GRw==
X-Gm-Message-State: AOJu0YzRbKytRQjMpK5anbUkgq4vC8mcu5/aeWNKzP3dHZjUL2BhdlsT
	riDRUaD21bukLlWpBXsmOizQOkh8r1TtpHebt9S9dI1VlnAN915rbmefJ0SVONgyq1Ebucyyp2P
	oc8W9ZNpTiBENkMUsP/BgMlIc8WnGLr50sIQQit0awbR4FIMzVm64cijkXUyWBd6vt8ubm075Zp
	+0hxlMGh3NO8R4QPy1MzTRtszvSBc4LCNWog+Wkhkj7Z0Gpm/XARY=
X-Gm-Gg: AY/fxX4CAwOhF/CD8BEY6etGXo4JUsTsturh8rP5eIuQoslQ/p9VXqDfYZSYzoasrwr
	AlGFZ49+H/alGFRfPrKqi7Cc7ejPctRz9yfB9UlLBU0vJrO/tXFhrS8d0UJN2W30Y6YAuOf3F3X
	560pReZbsceG3pGiI600+2VoeRGCK5P/X5smI/xtuwcSOZywNiXDPyRIYjDSDflTIGF8JTsAIwE
	H2KVAg15WeavPvxgHHi6DqnNiiKxEQ0vkMRXyJsBVSsBoDulwXTHzEiQV5nTLnzvA/7yeJr2R0e
	SvVFhq69VZ38MaowxSvA/iIMmYyLrY1Sa1KhPZJwzBB9dF8+COD3L3i/p5opvZehhK2eNncV785
	iIWB86mzGcgsYaThwknzAEwBwCpPLOM494Jgf/cdjAGB5Svcrw3ouPQ4F5FrNCS+0
X-Received: by 2002:a05:6402:3487:b0:636:2699:3812 with SMTP id 4fb4d7f45d1cf-653ebedc568mr2535734a12.0.1768402428124;
        Wed, 14 Jan 2026 06:53:48 -0800 (PST)
X-Received: by 2002:a05:6402:3487:b0:636:2699:3812 with SMTP id 4fb4d7f45d1cf-653ebedc568mr2535707a12.0.1768402427609;
        Wed, 14 Jan 2026 06:53:47 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm23059608a12.33.2026.01.14.06.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:53:47 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/6] fuse: fix race when disposing stale dentries
Date: Wed, 14 Jan 2026 15:53:38 +0100
Message-ID: <20260114145344.468856-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fuse_dentry_tree_work() just before d_dispose_if_unused() the dentry
could get evicted, resulting in UAF.

Move unlocking dentry_hash[i].lock to after the dispose.  To do this,
fuse_dentry_tree_del_node() needs to be moved from fuse_dentry_prune() to
fuse_dentry_release() to prevent an ABBA deadlock.

The lock ordering becomes:

 -> dentry_bucket.lock
    -> dentry.d_lock

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Closes: https://lore.kernel.org/all/20251206014242.GO1712166@ZenIV/
Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..2f89804b9ff3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -172,8 +172,8 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 			if (time_after64(get_jiffies_64(), fd->time)) {
 				rb_erase(&fd->node, &dentry_hash[i].tree);
 				RB_CLEAR_NODE(&fd->node);
-				spin_unlock(&dentry_hash[i].lock);
 				d_dispose_if_unused(fd->dentry, &dispose);
+				spin_unlock(&dentry_hash[i].lock);
 				cond_resched();
 				spin_lock(&dentry_hash[i].lock);
 			} else
@@ -479,18 +479,12 @@ static int fuse_dentry_init(struct dentry *dentry)
 	return 0;
 }
 
-static void fuse_dentry_prune(struct dentry *dentry)
+static void fuse_dentry_release(struct dentry *dentry)
 {
 	struct fuse_dentry *fd = dentry->d_fsdata;
 
 	if (!RB_EMPTY_NODE(&fd->node))
 		fuse_dentry_tree_del_node(dentry);
-}
-
-static void fuse_dentry_release(struct dentry *dentry)
-{
-	struct fuse_dentry *fd = dentry->d_fsdata;
-
 	kfree_rcu(fd, rcu);
 }
 
@@ -527,7 +521,6 @@ const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 	.d_delete	= fuse_dentry_delete,
 	.d_init		= fuse_dentry_init,
-	.d_prune	= fuse_dentry_prune,
 	.d_release	= fuse_dentry_release,
 	.d_automount	= fuse_dentry_automount,
 };
-- 
2.52.0


