Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7953FF073
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbhIBPsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345884AbhIBPsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630597657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WDx0PcjIEi7aaYT5qenMJpXUhrm6VH0waiqiPfuyEm4=;
        b=M3IH4uuXgfc44RHpXwZO0oCk19dQrEquY1Es7GhPF1G7iMsaHOcuThBgrvVVkHqzbbtZ4v
        9zV2aZN2oArWKv3Jjwqrr6fLVju7az+hy9fHivF3BbT6NbwDK8HkjK7OVANUEDZXWu5Yp9
        JWsn27NfrbPEQfgf8URDhldDJvx0QuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-WcbQxMzvPqGQVG_21Zq6JA-1; Thu, 02 Sep 2021 11:47:36 -0400
X-MC-Unique: WcbQxMzvPqGQVG_21Zq6JA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F03C0189C454;
        Thu,  2 Sep 2021 15:47:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A37B719C46;
        Thu,  2 Sep 2021 15:47:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 38BED220257; Thu,  2 Sep 2021 11:47:31 -0400 (EDT)
Date:   Thu, 2 Sep 2021 11:47:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com, viro@zeniv.linux.org.uk
Subject: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
Message-ID: <YTDyE9wVQQBxS77r@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902152228.665959-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


xfstests: generic/062: Do not run on newer kernels

This test has been written with assumption that setting user.* xattrs will
fail on symlink and special files. When newer kernels support setting
user.* xattrs on symlink and special files, this test starts failing.

Found it hard to change test in such a way that it works on both type of
kernels. Primary problem is 062.out file which hardcodes the output and
output will be different on old and new kernels.

So instead, do not run this test if kernel is new and is expected to
exhibit new behavior. Next patch will create a new test and run that
test on new kernel.

IOW, on old kernels run 062 and on new kernels run new test.

This is a proposed patch. Will need to be fixed if corresponding
kernel changes are merged upstream.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tests/generic/062 |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: xfstests-dev/tests/generic/062
===================================================================
--- xfstests-dev.orig/tests/generic/062	2021-08-31 15:51:08.160307982 -0400
+++ xfstests-dev/tests/generic/062	2021-08-31 16:27:41.678307982 -0400
@@ -55,6 +55,26 @@ _require_attrs
 _require_symlinks
 _require_mknod
 
+user_xattr_allowed()
+{
+	local kernel_version kernel_patchlevel
+
+	kernel_version=`uname -r | awk -F. '{print $1}'`
+	kernel_patchlevel=`uname -r | awk -F. '{print $2}'`
+
+	# Kernel version 5.14 onwards allow user xattr on symlink/special files.
+	[ $kernel_version -lt 5 ] && return 1
+	[ $kernel_patchlevel -lt 14 ] && return 1
+	return 0;
+}
+
+
+# Kernel version 5.14 onwards allow user xattr on symlink/special files.
+# Do not run this test on newer kernels. Instead run the new test
+# which has been written with the assumption that user.* xattr
+# will succeed on symlink and special files.
+user_xattr_allowed && _notrun "Kernel allows user.* xattrs on symlinks and special files. Skipping this test. Run newer test instead."
+
 rm -f $tmp.backup1 $tmp.backup2 $seqres.full
 
 # real QA test starts here

