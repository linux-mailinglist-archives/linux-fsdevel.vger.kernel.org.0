Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A43DBFA54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 21:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfIZTwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 15:52:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728643AbfIZTwj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:52:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F75EB136;
        Thu, 26 Sep 2019 19:52:38 +0000 (UTC)
Date:   Thu, 26 Sep 2019 14:52:34 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     viro@zeniv.linux.org.uk
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] Don't propagate automount
Message-ID: <20190926195234.bipqpw5sbk5ojcna@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An access to automounted filesystem can deadlock if it is a bind
mount on shared mounts. A user program should not deadlock the kernel
while automount waits for propagation of the mount. This is explained
at https://bugzilla.redhat.com/show_bug.cgi?id=1358887#c10
I am not sure completely blocking automount is the best solution,
so please reply with what is the best course of action to do
in such a situation.

Propagation of dentry with DCACHE_NEED_AUTOMOUNT can lead to
propagation of mount points without automount maps and not under
automount control. So, do not propagate them.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/pnode.c b/fs/pnode.c
index 49f6d7ff2139..b960805d7954 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -292,6 +292,9 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	struct mount *m, *n;
 	int ret = 0;
 
+	if (source_mnt->mnt_mountpoint->d_flags & DCACHE_NEED_AUTOMOUNT)
+		return 0;
+
 	/*
 	 * we don't want to bother passing tons of arguments to
 	 * propagate_one(); everything is serialized by namespace_sem,

-- 
Goldwyn
