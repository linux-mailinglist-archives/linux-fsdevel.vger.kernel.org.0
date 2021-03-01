Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1459E32813D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 15:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhCAOqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 09:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhCAOq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:46:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD86C061756;
        Mon,  1 Mar 2021 06:45:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u125so14734627wmg.4;
        Mon, 01 Mar 2021 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYBI7jz6ns7pLz3Y73sCKgdtYcZS6QQFIR4ATeR/I40=;
        b=E96OumwCtC8SkRV4dqje6H5zWMLStVVfdEU+FKEPsF92kFDZHl1ejYwdvoa0s1hl+N
         7QdlGsKKH0V20SfPeZNJj875Z7SN3V5YNdYARPV9sDhAN2zBd0AJWiUAIOHnLJQLafyH
         ZlMKRGmejnTQytuUUP2Ye6730iB1AJjLT3CfRoeGV1fYyW5sUZDsD6MdJImEQRc2IgI6
         E1mfiz6j3zfQmaXSG4oIKJ5nHN3P2YQ5w3Nsv+tB64KGmpvn8Z6blkJ9Ykx6NagfOUok
         RV8YfWijYZsWuS0H8q0ciijhiswSjpqjQ2/gyY+pHJFE3FMd6GISowtGxOAsCTCIV9Zs
         oMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYBI7jz6ns7pLz3Y73sCKgdtYcZS6QQFIR4ATeR/I40=;
        b=bcthja4FsV//aNXK2+0CP48XoJj5gV5hBVRyhKDvI+2VLEe4Rpi5cM5Vi1nMEBQuL8
         BCaeShbt2dDmqojdMR5BQkMg/d/53oAjcaY3WGHzNL1862hNvlsBcD+3bfKGDC40CtjC
         0nzG4V+nXey9O6YOrdJXvGG8Oo/NAEAn7y4HOVrJPPMW027lIuddmIZhq8l+otLdyRRb
         Gs0WBI4ifK2JDUxdAVHqEoYVKV5sQxHxdcZfn8MxNcw3oUCLyWoJr/EDd6NsjKl3y8Yz
         G5whlkb4bn19vjZo1WZFz98s+exMYbpX/noZCN6zB+TV8ZlZfYNtuWhiiwxsxYuzCjA8
         97KQ==
X-Gm-Message-State: AOAM5314Uy4pHxwmseCYW4bvJUr2yNGBY3FEe4EXhN37Ps99on+c6jPG
        H+eULT/LART4xVe6IXoml6ipjffQAMPB8A==
X-Google-Smtp-Source: ABdhPJyLivptqs2O5zbK+QyUexmiVo7F27TaQJOYgi+j19h4KRG+TEUss33BSxdRV6Jbz1pGonxvlw==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr15864884wmj.73.1614609944419;
        Mon, 01 Mar 2021 06:45:44 -0800 (PST)
Received: from localhost.localdomain ([170.253.51.130])
        by smtp.googlemail.com with ESMTPSA id t7sm20968500wmq.44.2021.03.01.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:45:43 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     linux-man@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Luis Henriques <lhenriques@suse.de>,
        Steve French <sfrench@samba.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
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
Subject: [RFC v3] copy_file_range.2: Update cross-filesystem support for 5.12
Date:   Mon,  1 Mar 2021 15:41:05 +0100
Message-Id: <20210301144104.75545-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.30.1.721.g45526154a5
In-Reply-To: <20210224142307.7284-1-lhenriques@suse.de>
References: <20210224142307.7284-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linux 5.12 fixes a regression.

Cross-filesystem (introduced in 5.3) copies were buggy.

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

v3:
	- Don't remove some important text.
	- Reword BUGS.

---
Hi Amir,

I covered your comments.  I may need to add something else after your
discussion with Steve; please comment.

I tried to reword BUGS so that it's as specific and understandable as I can.
If you still find it not good enough, please comment :)

Thanks,

Alex

---
 man2/copy_file_range.2 | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index 611a39b80..1c0df3f74 100644
--- a/man2/copy_file_range.2
+++ b/man2/copy_file_range.2
@@ -169,6 +169,9 @@ Out of memory.
 .B ENOSPC
 There is not enough space on the target filesystem to complete the copy.
 .TP
+.BR EOPNOTSUPP " (since Linux 5.12)"
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
+The files referred to by
+.IR fd_in " and " fd_out
+are not on the same filesystem.
+.TP
+.BR EXDEV " (since Linux 5.12)"
 The files referred to by
 .IR fd_in " and " fd_out
-are not on the same mounted filesystem (pre Linux 5.3).
+are not on the same filesystem,
+and the source and target filesystems are not of the same type,
+or do not support cross-filesystem copy.
 .SH VERSIONS
 The
 .BR copy_file_range ()
@@ -200,8 +210,10 @@ Areas of the API that weren't clearly defined were clarified and the API bounds
 are much more strictly checked than on earlier kernels.
 Applications should target the behaviour and requirements of 5.3 kernels.
 .PP
-First support for cross-filesystem copies was introduced in Linux 5.3.
-Older kernels will return -EXDEV when cross-filesystem copies are attempted.
+Since 5.12,
+cross-filesystem copies can be achieved
+when both filesystems are of the same type,
+and that filesystem implements support for it.
 .SH CONFORMING TO
 The
 .BR copy_file_range ()
@@ -226,6 +238,12 @@ gives filesystems an opportunity to implement "copy acceleration" techniques,
 such as the use of reflinks (i.e., two or more inodes that share
 pointers to the same copy-on-write disk blocks)
 or server-side-copy (in the case of NFS).
+.SH BUGS
+In Linux kernels 5.3 to 5.11,
+cross-filesystem copies were supported by the kernel,
+instead of being supported by individual filesystems.
+However, on some virtual filesystems,
+the call failed to copy, while still reporting success.
 .SH EXAMPLES
 .EX
 #define _GNU_SOURCE
-- 
2.30.1.721.g45526154a5

