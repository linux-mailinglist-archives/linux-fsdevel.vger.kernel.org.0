Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2233FF057
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbhIBPj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345767AbhIBPjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630597135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dThrFUEauS0PVKV2QOhWb7PoGtgPW3EHRoCBlNIp8ng=;
        b=GdV4Q3M/yb5GB8iBS1zWk5RORuPPol5m8SZsaCmciWDmRkUkVid3OH9ce6so5VoXKgyLC8
        Fd8OXuGwQNWKRuuJcW5RiFG9Hg9mSLHjDu286eyMeMoZtKZIyCPdlH2UtUVzjHv3FZGaJE
        32b1qzSuvNhTHyZMyAUS09jZ2xgDO4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-fWh-sNzWP9GaIwZRi3O0-A-1; Thu, 02 Sep 2021 11:38:54 -0400
X-MC-Unique: fWh-sNzWP9GaIwZRi3O0-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C0A6801AE3;
        Thu,  2 Sep 2021 15:38:52 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2AF728554;
        Thu,  2 Sep 2021 15:38:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 52139220257; Thu,  2 Sep 2021 11:38:48 -0400 (EDT)
Date:   Thu, 2 Sep 2021 11:38:48 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-api@vger.kernel.org, mtk.manpages@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com, viro@zeniv.linux.org.uk
Subject: [PATCH 2/1] man-pages: xattr.7: Update text for user extended xattr
 behavior change
Message-ID: <YTDwCFbO9Jl6a7vP@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902152228.665959-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have proposed a patch to relax restrictions on user extended xattrs and
allow file owner (or CAP_FOWNER) to get/set user extended xattrs on symlink
and device files.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 man7/xattr.7 |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: man-pages/man7/xattr.7
===================================================================
--- man-pages.orig/man7/xattr.7	2021-09-01 13:46:16.165016463 -0400
+++ man-pages/man7/xattr.7	2021-09-01 16:31:51.038016463 -0400
@@ -129,8 +129,13 @@ a way not controllable by disk quotas fo
 special files and directories.
 .PP
 For this reason,
-user extended attributes are allowed only for regular files and directories,
-and access to user extended attributes is restricted to the
+user extended attributes are allowed only for regular files and directories
+till kernel 5.14. In newer kernel (5.15 onwards), restrictions have been
+relaxed a bit and user extended attributes are also allowed on symlinks
+and special files as long as caller is either owner of the file or is
+privileged (CAP_FOWNER).
+
+Access to user extended attributes is restricted to the
 owner and to users with appropriate capabilities for directories with the
 sticky bit set (see the
 .BR chmod (1)

