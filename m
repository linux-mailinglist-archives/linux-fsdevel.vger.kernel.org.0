Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD4C2EE7C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 22:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbhAGVov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 16:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbhAGVou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:44:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3DAC0612F4
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 13:44:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 3so6753282wmg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 13:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDuZB7RfLs+B/c5jQtrKB9X5LjeTmB5ZVUek8MCUgcA=;
        b=qCFIRo67/8jwbU0ufYIIud48pWcwccAd9nV61pMOk9vJ9wa2v5Alfd+AoIn9I+yqeU
         4viLFaR9OEcmNQwYGkUknLjbmJ6IavLottekGBv9136KXItUCyuqnGPwsyjVQwgqsjhB
         4vRbriYyNkkOO8F53wmhwFiDiutqDABeonoL/xRs47n9RjyZhhZwFmfIw7+/r4YwqlG+
         Zg+JnVQnCIkHv++m058xzTjHcpsCktCiAJ/95+Ho2BgSH+jgmVdxCqa+iWy1jy43hQow
         AKD1Y7N5IhN/J8okL78Ki/Dt5UOiVluAujK9GVGxJsp6nr+OE/rwhZvCM7APYn+Jbt47
         JuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDuZB7RfLs+B/c5jQtrKB9X5LjeTmB5ZVUek8MCUgcA=;
        b=erorhTVqQ1e1M7GUTy4+5JF4biEqHKR4o2SgBv2q+aQeUXLV0qoAtR5VfcwABfnEjS
         pbWHwQ6+qcotCCJMdpvCKnfyebMDxJnyyrOVOu9H3pkUCUYF/5CIOb2sQ56vVeXChvXJ
         Psq0s8qyJuhzqp1EpIy1syTKMgLABUCVdeREaQ2EEnIVXHFCpem/8ZarrzMxY9Nl7Mhk
         88uKpLSO+VscmNk5mGa80iEzVsIe+W/PTmYxCfgKLpV0RgKYh72ZLM27t11+21SUx7Mz
         xpECvjirEVr4qAIO4L7V+kqftgvnFb72PwaLogkwcsTorEQiXeCc4hE9a7iua//UKWI6
         2chA==
X-Gm-Message-State: AOAM533Sdh1JPZWG8qy3lEu8Xx999EFqbHnYlOJF+wOo3m+IJVX3P2ws
        XapaIRnEcKWeZ9o5N5nTautOzI0pzz4=
X-Google-Smtp-Source: ABdhPJxW45L9gmoAFPkPsTxkxbpBUR9a3cjZz9uydeOPV45uYC4hAfo2DNQps/rBtFTXf0OyFlz22g==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr407508wml.155.1610055843815;
        Thu, 07 Jan 2021 13:44:03 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id g1sm10084997wrq.30.2021.01.07.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:44:03 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/3] Generic per-mount io stats
Date:   Thu,  7 Jan 2021 23:43:58 +0200
Message-Id: <20210107214401.249416-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

I was trying to address the lack of iostat report for non-blockdev
filesystems such as overlayfs and fuse.

NFS has already addressed this with it own custom stats collection,
which is displayed in /proc/<pid>/mountstats.

When looking at the options, I found that a generic solution is quite
simple and could serve all filesystems that opt-in to use it.

This short patch set results in the following mountstats example report:

device overlay mounted on /mnt with fstype overlay
	times: 125 153
	rchar: 12
	wchar: 0
	syscr: 2
	syscw: 0

The choise to collect and report io stats by mount and not by sb is
quite arbitrary, because it was quite easy to implement and is natural
to the existing mountstats proc file.

I used the arbirtaty flag FS_USERNS_MOUNT as an example for a way for
filesystem to opt-in to mount io stats, but it could be either an FS_
SB_ or MNT_ flag.  I do not anticipate shortage of opinions on this
matter.

As for performance, the io accounting hooks are the existing hooks for
task io accounting.  mount io stats add a dereference to mnt_pcp for
the filesystems that opt-in and one per-cpu var update.  The dereference
to mnt_sb->s_type->fs_flags is temporary as we will probably want to
use an MNT_ flag, whether kernel internal or user controlled.

What do everyone think about this?

Al,

did I break any subtle rules of the vfs?

Thanks,
Amir.

Amir Goldstein (3):
  fs: add iostats counters to struct mount
  fs: collect per-mount io stats
  fs: report per-mount io stats

 fs/Kconfig          |  9 +++++
 fs/mount.h          | 54 ++++++++++++++++++++++++++++
 fs/namespace.c      | 19 ++++++++++
 fs/proc_namespace.c | 13 +++++++
 fs/read_write.c     | 87 ++++++++++++++++++++++++++++++++-------------
 5 files changed, 158 insertions(+), 24 deletions(-)

-- 
2.25.1

