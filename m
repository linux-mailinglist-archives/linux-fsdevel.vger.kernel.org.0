Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B33D8E33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhG1Mro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 08:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236221AbhG1Mrl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627476459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnQBX0jQrXqx6HiP9TW1YM3F0zAsy1/0i/tnCnd26/s=;
        b=AmlZ8fwAcB/QIHGatLUuz0zbDFuwuhR5T3J7GjwH+1XJ80oZWLsNGOy8DsEK4pNtn5vEX/
        5hAlmuQpSbcYihacs/4Is5plAf+Ft0VAOMLDpIxYvaoWoPwRH1t9odD/b5wjeZRbq/U0JG
        K46/qHltwcqd85nL56jNPRwotPMkuQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-_Zf42Ne9PQCiRgMRpl8_lg-1; Wed, 28 Jul 2021 08:47:37 -0400
X-MC-Unique: _Zf42Ne9PQCiRgMRpl8_lg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5BCB107ACF5;
        Wed, 28 Jul 2021 12:47:36 +0000 (UTC)
Received: from vishnu.redhat.com (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A735B5C1BB;
        Wed, 28 Jul 2021 12:47:36 +0000 (UTC)
From:   Bob Peterson <rpeterso@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [vfs PATCH 2/2] gfs2: Switch to may_setattr in gfs2_setattr
Date:   Wed, 28 Jul 2021 07:47:34 -0500
Message-Id: <20210728124734.227375-3-rpeterso@redhat.com>
In-Reply-To: <20210728124734.227375-1-rpeterso@redhat.com>
References: <20210728124734.227375-1-rpeterso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

The permission check in gfs2_setattr is an old and outdated version of
may_setattr().  Switch to the updated version.

Fixes fstest generic/079.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 6e15434b23ac..3130f85d2b3f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1985,8 +1985,8 @@ static int gfs2_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		goto out;
 
-	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+	error = may_setattr(&init_user_ns, inode, attr->ia_valid);
+	if (error)
 		goto error;
 
 	error = setattr_prepare(&init_user_ns, dentry, attr);
-- 
2.31.1

