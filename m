Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB33EBA2C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2019 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfIVNTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Sep 2019 09:19:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42668 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfIVNTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Sep 2019 09:19:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id w14so9684916qto.9;
        Sun, 22 Sep 2019 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uNO9UuhB7M6CiHUosVbc5HEwCkGc2F4p4dUUxU7OnMc=;
        b=itpkqRQ470AT0lxjFU6H1qesOezH2PykkOk8ndMezitG9w40XDq6VJxR+lqRz725JD
         Tt4+jzcyvcpeAswV0svLaY9Kq6dXmTMlHTGdA0lZ/Rt2xpDQ3Ei3AV5YXAbiYgB2Chi4
         jYLbwZyzYoh+AkIqhy82hFHhym1+ZzT5mjqk6W3CkFsxnPc44QytwTjXzLEYSxo0gXD+
         b+GOM4hsikKQtDgorfRcuc6IQ/oNTAcWtVove+2txD43As2MD7yPvLfIOat0cbxwZyxb
         hrdgVqf6Ca9O+vB2RZW/Ya5PPvBNXEbzDa2rPIE01TQ4CgPZ8WkTjHb0kv/7Wdf0JbjV
         +aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=uNO9UuhB7M6CiHUosVbc5HEwCkGc2F4p4dUUxU7OnMc=;
        b=OPsTsh/5WKePaR+mP1z62ViCHSSKTGU1sm0v6XBWd0OXMmzcTBvlXeKu1rwygeQRyy
         g7n12g6nhIVq/5LPIt5UyywGQIQ1Rr1eiLLtoLkECAtI5+Klf65FQXmV0RrR3Jcd3f2G
         t29YsNEkHFJeVPqSRVpyAGBYKfVF52dQx1RtZoTkk3x7xKJSfHQ2HNvtNByDacII2lGk
         xT1AdNwBOzfzYbjC2WgzvVTGAjpM+5WlvuKHjVLsCApohR6h0m0Wk+wvq/t3tLRf64ZZ
         XQqxSEwMdGsp/MdIj1If8/9i7TtGhTqGxc88ckLv0qYbEF0ZoKdMdXAFUMesmN2OBN6r
         HIWQ==
X-Gm-Message-State: APjAAAUMpIksxg1fOSZ80hO8PYuXadO/YoBWeTxbWXRtNiwMIjzpMnfC
        ryoyRHJ2K5Xyc1zRE0Mga0w=
X-Google-Smtp-Source: APXvYqzQE7aMzabm+ubBc3vvlI/+LrGJVWqwJUXtLS3LnJXSQfAaKw/kU5+qkfLDOpZP1CbA796Kyw==
X-Received: by 2002:ad4:5552:: with SMTP id v18mr20777945qvy.185.1569158380829;
        Sun, 22 Sep 2019 06:19:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::34ed])
        by smtp.gmail.com with ESMTPSA id d133sm4414760qkg.31.2019.09.22.06.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 06:19:39 -0700 (PDT)
Date:   Sun, 22 Sep 2019 06:19:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: fix beyond-end-of-page access in fuse_parse_cache()
Message-ID: <20190922131936.GE2233839@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With DEBUG_PAGEALLOC on, the following triggers.

  BUG: unable to handle page fault for address: ffff88859367c000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 3001067 P4D 3001067 PUD 406d3a8067 PMD 406d30c067 PTE 800ffffa6c983060
  Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
  CPU: 38 PID: 3110657 Comm: python2.7
  RIP: 0010:fuse_readdir+0x88f/0xe7a [fuse]
  Code: 49 8b 4d 08 49 39 4e 60 0f 84 44 04 00 00 48 8b 43 08 43 8d 1c 3c 4d 01 7e 68 49 89 dc 48 03 5c 24 38 49 89 46 60 8b 44 24 30 <8b> 4b 10 44 29 e0 48 89 ca 48 83 c1 1f 48 83 e1 f8 83 f8 17 49 89
  RSP: 0018:ffffc90035edbde0 EFLAGS: 00010286
  RAX: 0000000000001000 RBX: ffff88859367bff0 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffff88859367bfed RDI: 0000000000920907
  RBP: ffffc90035edbe90 R08: 000000000000014b R09: 0000000000000004
  R10: ffff88859367b000 R11: 0000000000000000 R12: 0000000000000ff0
  R13: ffffc90035edbee0 R14: ffff889fb8546180 R15: 0000000000000020
  FS:  00007f80b5f4a740(0000) GS:ffff889fffa00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff88859367c000 CR3: 0000001c170c2001 CR4: 00000000003606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   iterate_dir+0x122/0x180
   __x64_sys_getdents+0xa6/0x140
   do_syscall_64+0x42/0x100
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

faddr2line says

  fuse_readdir+0x88f/0x38fc9b:
  fuse_parse_cache at /builddir/build/BUILD/kernel-5.2.9-1992_g2c63931edbb0/fs/fuse/readdir.c:375
  (inlined by) fuse_readdir_cached at /builddir/build/BUILD/kernel-5.2.9-1992_g2c63931edbb0/fs/fuse/readdir.c:524
  (inlined by) fuse_readdir at /builddir/build/BUILD/kernel-5.2.9-1992_g2c63931edbb0/fs/fuse/readdir.c:562

It's in fuse_parse_cache().  %rbx (ffff88859367bff0) is fuse_dirent
pointer - addr + offset.  FUSE_DIRENT_SIZE() is trying to dereference
namelen off of it but that derefs into the next page which is disabled
by pagealloc debug causing a PF.

This is caused by dirent->namelen being accessed before ensuring that
there's enough bytes in the page for the dirent.  Fix it by pushing
down reclen calculation.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
Cc: stable@vger.kernel.org # v4.20+
---
 fs/fuse/readdir.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 574d03f8a573..b2da3de6a78e 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -372,11 +372,13 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 	for (;;) {
 		struct fuse_dirent *dirent = addr + offset;
 		unsigned int nbytes = size - offset;
-		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+		size_t reclen;
 
 		if (nbytes < FUSE_NAME_OFFSET || !dirent->namelen)
 			break;
 
+		reclen = FUSE_DIRENT_SIZE(dirent); /* derefs ->namelen */
+
 		if (WARN_ON(dirent->namelen > FUSE_NAME_MAX))
 			return FOUND_ERR;
 		if (WARN_ON(reclen > nbytes))
