Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F283B4925
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFYTPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 15:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhFYTPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624648366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mR7BPB7xUD+lHwXPAeAm7p/vk/MlEKiHZItlpMSs9TU=;
        b=am4Fl6c34Fj9gMajCJ9KY2OyTVLkYXHEKNWtzSFH/LsZQ8OBWp1de5u3jcnh16E1MkJuF3
        yfCtyWq9zEL7lAwWHGCIZ6M2FtQK/KN9OCw0KNdCJ0P8YJ1WuMeGZLMWI9Gs/XdZcTTZCJ
        xKuRwWUB0ltrv6owOZlVcHtfuhv5uIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-p5mUJjNIM6yt1lWjb4paHA-1; Fri, 25 Jun 2021 15:12:45 -0400
X-MC-Unique: p5mUJjNIM6yt1lWjb4paHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67BF41835AC8;
        Fri, 25 Jun 2021 19:12:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-161.rdu2.redhat.com [10.10.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC5B15D6A8;
        Fri, 25 Jun 2021 19:12:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 850BF223D99; Fri, 25 Jun 2021 15:12:40 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        berrange@redhat.com, vgoyal@redhat.com
Subject: [PATCH 1/1] xattr: Allow user.* xattr on symlink/special files with CAP_SYS_RESOURCE
Date:   Fri, 25 Jun 2021 15:12:29 -0400
Message-Id: <20210625191229.1752531-2-vgoyal@redhat.com>
In-Reply-To: <20210625191229.1752531-1-vgoyal@redhat.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As of now user.* xattrs are allowed only on regular files and directories.
And in case of directories if sticky bit is set, then it is allowed
only if caller is owner or has CAP_FOWNER.

"man xattr" suggests that primary reason behind this restrcition is that
users can set unlimited amount of "user.*" xattrs on symlinks and special
files and bypass quota checks. Following is from man page.

"These differences would allow users to consume filesystem resources  in
 a  way not controllable by disk quotas for group or world writable spe‐
 cial files and directories"

Capability CAP_SYS_RESOURCE allows for overriding disk quota limits. If
being able to bypass quota is primary reason behind these restrictions,
can we relax these restrictions if caller has CAP_SYS_RESOURCE.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..10bb918029dd 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -124,7 +124,8 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
 	 * extended attributes. For sticky directories, only the owner and
 	 * privileged users can write attributes.
 	 */
-	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
+	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
+	    !capable(CAP_SYS_RESOURCE)) {
 		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
-- 
2.25.4

