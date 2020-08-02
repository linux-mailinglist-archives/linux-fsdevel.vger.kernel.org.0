Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D102354E7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 04:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHBChx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 22:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHBChw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 22:37:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8F2C061756
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2020 19:37:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so30700553qkn.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 19:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=E0JAowe6RRiGLAAqLkisJ5hOzB42tZ2iwdO8AnpRtQs=;
        b=cwdgDJlgG6ALOxZek6jeL7JNtaTRAK6Hk53r5A5MS6760XTcVBF2koPSp1a1xlP4Sc
         sJEJ1QBzXbQBI399pgkYjikbp41/Uol9/5VfusZiJT2Mc91gcaaRy5ToLBrLA9kwUSGx
         TwKW8TlMerKtPeJDSDZylah1jkCbzTTRrPDhM1Z5c+OyI2CFp78Ld/kLCmNemaWXn3KQ
         F26LdbYlq1N1B/MWunqx04wybENNiHY7aAnkYeTggdTZgot2w48n41uW8DOCiQi/U6tS
         mcSlAGj1WcMaqDN2zAEHar9RvssqSJPBNk1vc8l56CMtcdiYzK5yAK2vgIAuI42+gAd6
         uLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=E0JAowe6RRiGLAAqLkisJ5hOzB42tZ2iwdO8AnpRtQs=;
        b=aPUe6zH7HWlfBorT4EV+2ssPmSYmmFwQbFpliKPbbgBSJgqkYjrAaRDgOkj4Cj+Ax7
         +6CGO01ekKy+Iz8RSj8mrO++CzfBWBjl1/kIAhmVXgsmSLFor7CFwGONK9At7g80kJ+g
         K5QjgPeGRaSoHWDVHrKGTQmHs/j1ARzxzrULdixSwaOWeoOgJHdv1PpehJaP0mFKTqqN
         YBzMr0s+Eh/UPQpvT5YFIq4+2nj6ZE3Vx3Bqb++whboghwe48yLNprhIZ0euFmBS+CxH
         rIyfiVVHxAEAwWmXAPsCSoSCuTG/4a7zFLSdF45tgbWQDP+rkoxOs1wFGmfpAfo54lYE
         OUYg==
X-Gm-Message-State: AOAM531nbj6fzhhgMU3uHcgE3C0NzShBRnYMRkZpaa2/Rw1OFPpLK21X
        NzSQAJaqhXnGxr06c4OiCcGxrQ==
X-Google-Smtp-Source: ABdhPJzTlr6qpiL6LFMSR2Lm2/r8BeKDVDE/wBUHQN/zA6BdFdp1AtGWqA3PK4Vpi1+a6hBZ5lwe5Q==
X-Received: by 2002:a37:8e42:: with SMTP id q63mr10681287qkd.16.1596335871060;
        Sat, 01 Aug 2020 19:37:51 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d198sm14284632qke.129.2020.08.01.19.37.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 01 Aug 2020 19:37:49 -0700 (PDT)
Date:   Sat, 1 Aug 2020 19:37:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>,
        Randy Dunlap <rdunlap@infradead.org>
cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH mmotm] tmpfs: support 64-bit inums per-sb fix
In-Reply-To: <alpine.LSU.2.11.2008011223120.10700@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008011928010.13320@eggly.anvils>
References: <cover.1594661218.git.chris@chrisdown.name> <8b23758d0c66b5e2263e08baf9c4b6a7565cbd8f.1594661218.git.chris@chrisdown.name> <alpine.LSU.2.11.2008011223120.10700@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expanded Chris's Documentation and Kconfig help on tmpfs inode64.
TMPFS_INODE64 still there, still default N, but writing down its very
limited limitation does make me wonder again if we want the option.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Andrew, please fold into tmpfs-support-64-bit-inums-per-sb.patch later.

Randy, you're very active on Documentation and linux-next: may I ask you
please to try applying this patch to latest, and see if tmpfs.rst comes
out looking right to you?  I'm an old dog still stuck in the days of
tmpfs.txt, hoping to avoid new tricks for a while.  Thanks!  (Bonus
points if you can explain what the "::" on line 122 is about. I started
out reading Documentation/doc-guide/sphinx.rst, but... got diverted.
Perhaps I should ask Mauro or Jon, but turning for help first to you.)

 Documentation/filesystems/tmpfs.rst |   13 ++++++++++---
 fs/Kconfig                          |   16 +++++++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

--- mmotm/Documentation/filesystems/tmpfs.rst	2020-07-27 18:54:51.116524795 -0700
+++ linux/Documentation/filesystems/tmpfs.rst	2020-08-01 18:37:07.719713987 -0700
@@ -153,11 +153,18 @@ parameters with chmod(1), chown(1) and c
 tmpfs has a mount option to select whether it will wrap at 32- or 64-bit inode
 numbers:
 
+=======   ========================
 inode64   Use 64-bit inode numbers
 inode32   Use 32-bit inode numbers
+=======   ========================
+
+On a 32-bit kernel, inode32 is implicit, and inode64 is refused at mount time.
+On a 64-bit kernel, CONFIG_TMPFS_INODE64 sets the default.  inode64 avoids the
+possibility of multiple files with the same inode number on a single device;
+but risks glibc failing with EOVERFLOW once 33-bit inode numbers are reached -
+if a long-lived tmpfs is accessed by 32-bit applications so ancient that
+opening a file larger than 2GiB fails with EINVAL.
 
-On 64-bit, the default is set by CONFIG_TMPFS_INODE64. On 32-bit, inode64 is
-not legal and will produce an error at mount time.
 
 So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
 will give you tmpfs instance on /mytmpfs which can allocate 10GB
@@ -170,5 +177,5 @@ RAM/SWAP in 10240 inodes and it is only
    Hugh Dickins, 4 June 2007
 :Updated:
    KOSAKI Motohiro, 16 Mar 2010
-Updated:
+:Updated:
    Chris Down, 13 July 2020
--- mmotm/fs/Kconfig	2020-07-27 18:54:59.384550639 -0700
+++ linux/fs/Kconfig	2020-08-01 18:11:33.749236321 -0700
@@ -223,12 +223,18 @@ config TMPFS_INODE64
 	default n
 	help
 	  tmpfs has historically used only inode numbers as wide as an unsigned
-	  int. In some cases this can cause wraparound, potentially resulting in
-	  multiple files with the same inode number on a single device. This option
-	  makes tmpfs use the full width of ino_t by default, similarly to the
-	  inode64 mount option.
+	  int. In some cases this can cause wraparound, potentially resulting
+	  in multiple files with the same inode number on a single device. This
+	  option makes tmpfs use the full width of ino_t by default, without
+	  needing to specify the inode64 option when mounting.
 
-	  To override this default, use the inode32 or inode64 mount options.
+	  But if a long-lived tmpfs is to be accessed by 32-bit applications so
+	  ancient that opening a file larger than 2GiB fails with EINVAL, then
+	  the INODE64 config option and inode64 mount option risk operations
+	  failing with EOVERFLOW once 33-bit inode numbers are reached.
+
+	  To override this configured default, use the inode32 or inode64
+	  option when mounting.
 
 	  If unsure, say N.
 
