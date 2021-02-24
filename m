Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BCB324080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 16:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhBXPJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 10:09:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:33460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236564AbhBXOW6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:22:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99E5BADCD;
        Wed, 24 Feb 2021 14:22:04 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 1f03fb81;
        Wed, 24 Feb 2021 14:23:09 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-man@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Subject: [PATCH] copy_file_range.2: Kernel v5.12 updates
Date:   Wed, 24 Feb 2021 14:23:07 +0000
Message-Id: <20210224142307.7284-1-lhenriques@suse.de>
In-Reply-To: <20210222102456.6692-1-lhenriques@suse.de>
References: <20210222102456.6692-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update man-page with recent changes to this syscall.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Hi!

Here's a suggestion for fixing the manpage for copy_file_range().  Note that
I've assumed the fix will hit 5.12.

 man2/copy_file_range.2 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index 611a39b8026b..b0fd85e2631e 100644
--- a/man2/copy_file_range.2
+++ b/man2/copy_file_range.2
@@ -169,6 +169,9 @@ Out of memory.
 .B ENOSPC
 There is not enough space on the target filesystem to complete the copy.
 .TP
+.B EOPNOTSUPP
+The filesystem does not support this operation.
+.TP
 .B EOVERFLOW
 The requested source or destination range is too large to represent in the
 specified data types.
@@ -187,7 +190,7 @@ refers to an active swap file.
 .B EXDEV
 The files referred to by
 .IR fd_in " and " fd_out
-are not on the same mounted filesystem (pre Linux 5.3).
+are not on the same mounted filesystem (pre Linux 5.3 and post Linux 5.12).
 .SH VERSIONS
 The
 .BR copy_file_range ()
@@ -202,6 +205,11 @@ Applications should target the behaviour and requirements of 5.3 kernels.
 .PP
 First support for cross-filesystem copies was introduced in Linux 5.3.
 Older kernels will return -EXDEV when cross-filesystem copies are attempted.
+.PP
+After Linux 5.12, support for copies between different filesystems was dropped.
+However, individual filesystems may still provide
+.BR copy_file_range ()
+implementations that allow copies across different devices.
 .SH CONFORMING TO
 The
 .BR copy_file_range ()
