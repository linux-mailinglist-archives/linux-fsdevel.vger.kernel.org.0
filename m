Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D93326D54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 15:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhB0OAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhB0OAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 09:00:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB68C061756;
        Sat, 27 Feb 2021 05:59:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u11so3991085wmq.5;
        Sat, 27 Feb 2021 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvAI4IdeCO4sgAZNtE9xDAeulh8mRYshdjpgF2TPJtQ=;
        b=b3FMrX8YKqdozH2POjKQ+nxkWJquvm5hRtl3h1dXTQJoPlINIRcY6gEeQWkGu4UwTf
         3JgyqYgejIWxklabYKU1NL1rsXaPWtA6qB/9OGWxoUuCGMQ2ga9eyaUTow9ROHIPX6s1
         gO9PUHl5oM30m63BL+b5iWtgPAIPSCgup+sieUe8U/PEJwCIIObPyKuTCxjx36guplVJ
         AcUt8MXyc60m7K1uFQA25F63QMDHrzDrQ9gYprwbfkoBBmZj0FNxFxS6F29Zn5UzOl11
         ILjHw9/94z7IjKjZEQAI5zaeCmA8kq6AcBom8vo5MsdIQSg/h7eYKD4z2Wt/jmJEahdQ
         Yv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvAI4IdeCO4sgAZNtE9xDAeulh8mRYshdjpgF2TPJtQ=;
        b=e6COPEbP0AD+vm1rh50eRl/LIhmz48No6XhS5JgWoOp3hxcOHVAkZDNe752dCCG6QA
         XUnu45K6xgrpch+EKUTk34wprterSmerkUhxq5RTDDKFdKzXPzJhEDz7qwJVHS5RRn1o
         4f/QrsC6dfcNIzOBaR3hnVMvuLLAJE/0KUhIsITCf7OOi9ykK8acrX/2Z/0Mw64K5JvU
         geQDf0pvMMqFGlS1oTsgrlTuqyvzjLXHvGMjzxZR+PAqthFoledR5NX+AYHvooqu/UsT
         ANQ6czEvrm718NmDq6lO3Y2mpg8zYplQfarhwCxTnC39lhILL16+TaCLYfofVLO2Svc+
         NzWw==
X-Gm-Message-State: AOAM5319eAKKY6JwHco5G7omM37djwLWc+y6drjXt1X5EBYgap0PIopM
        +CCOsPvhkIMgRbiG5VWj6s8=
X-Google-Smtp-Source: ABdhPJwYoK9qHMRToQ8OSAFFvjw3ofxdQdQc+A0olkG2RZQTSwYLePQCK0BRbAbiYqgeGFJSaZF0fA==
X-Received: by 2002:a05:600c:350c:: with SMTP id h12mr7336570wmq.39.1614434367999;
        Sat, 27 Feb 2021 05:59:27 -0800 (PST)
Received: from localhost.localdomain ([170.253.51.130])
        by smtp.googlemail.com with ESMTPSA id f22sm3871680wmc.33.2021.02.27.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 05:59:27 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Subject: [RFC v2] copy_file_range.2: Update cross-filesystem support for 5.12
Date:   Sat, 27 Feb 2021 14:49:23 +0100
Message-Id: <20210227134922.5706-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.30.1.721.g45526154a5
In-Reply-To: <ffd92bb4-8f72-cbec-045f-a2ad7869ab3b@gmail.com>
References: <ffd92bb4-8f72-cbec-045f-a2ad7869ab3b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linux 5.12 fixes a regression.

Cross-filesystem copies (introduced in 5.3) were buggy.

Move the statements documenting cross-fs to BUGS.
Kernels 5.3..5.11 should be patched soon.

State version information for some errors related to this.

Reported-by: Luis Henriques <lhenriques@suse.de>
Reported-by: Amir Goldstein <amir73il@gmail.com>
Related: <https://lwn.net/Articles/846403/>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Steve French <sfrench@samba.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Ian Lance Taylor <iant@google.com>
Cc: Luis Lozano <llozano@chromium.org>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Olga Kornievskaia <aglo@umich.edu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Cc: CIFS <linux-cifs@vger.kernel.org>
Cc: samba-technical <samba-technical@lists.samba.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Walter Harms <wharms@bfs.de>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---

Hi all,

Please check that this is correct.
I wrote it as I understood copy_file_range() from the LWN article,
and the conversation on this thread,
but maybe someone with more experience on this syscall find bugs in my patch.

When kernels 5.3..5.11 fix this, some info could be compacted a bit more,
and maybe the BUGS section could be removed.

Also, I'd like to know which filesystems support cross-fs, and since when.

Amir, you said that it was only cifs and nfs (since when? 5.3? 5.12?).

Also, I'm a bit surprised that <5.3 could fail with EOPNOTSUPP
and it wasn't documented.  Is that for sure, Amir?

Thanks,

Alex

---
 man2/copy_file_range.2 | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index 611a39b80..93f54889d 100644
--- a/man2/copy_file_range.2
+++ b/man2/copy_file_range.2
@@ -169,6 +169,9 @@ Out of memory.
 .B ENOSPC
 There is not enough space on the target filesystem to complete the copy.
 .TP
+.BR EOPNOTSUPP " (before Linux 5.3; or since Linux 5.12)"
+The filesystem does not support this operation.
+.TP
 .B EOVERFLOW
 The requested source or destination range is too large to represent in the
 specified data types.
@@ -184,10 +187,17 @@ or
 .I fd_out
 refers to an active swap file.
 .TP
-.B EXDEV
+.BR EXDEV " (before Linux 5.3)"
 The files referred to by
 .IR fd_in " and " fd_out
-are not on the same mounted filesystem (pre Linux 5.3).
+are not on the same filesystem.
+.TP
+.BR EXDEV " (or since Linux 5.12)"
+The files referred to by
+.IR fd_in " and " fd_out
+are not on the same filesystem,
+and the source and target filesystems are not of the same type,
+or do not support cross-filesystem copy.
 .SH VERSIONS
 The
 .BR copy_file_range ()
@@ -195,13 +205,10 @@ system call first appeared in Linux 4.5, but glibc 2.27 provides a user-space
 emulation when it is not available.
 .\" https://sourceware.org/git/?p=glibc.git;a=commit;f=posix/unistd.h;h=bad7a0c81f501fbbcc79af9eaa4b8254441c4a1f
 .PP
-A major rework of the kernel implementation occurred in 5.3.
-Areas of the API that weren't clearly defined were clarified and the API bounds
-are much more strictly checked than on earlier kernels.
-Applications should target the behaviour and requirements of 5.3 kernels.
-.PP
-First support for cross-filesystem copies was introduced in Linux 5.3.
-Older kernels will return -EXDEV when cross-filesystem copies are attempted.
+Since 5.12,
+cross-filesystem copies can be achieved
+when both filesystems are of the same type,
+and that filesystem implements support for it.
 .SH CONFORMING TO
 The
 .BR copy_file_range ()
@@ -226,6 +233,10 @@ gives filesystems an opportunity to implement "copy acceleration" techniques,
 such as the use of reflinks (i.e., two or more inodes that share
 pointers to the same copy-on-write disk blocks)
 or server-side-copy (in the case of NFS).
+.SH BUGS
+In Linux kernels 5.3 to 5.11, cross-filesystem copies were supported.
+However, on some virtual filesystems, the call failed to copy,
+eventhough it may have reported success.
 .SH EXAMPLES
 .EX
 #define _GNU_SOURCE
-- 
2.30.1.721.g45526154a5

