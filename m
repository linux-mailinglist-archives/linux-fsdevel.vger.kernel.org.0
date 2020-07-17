Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E50223B67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGQMbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQMbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:31:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C86C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:31:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bm28so7526983edb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7u2iFOgKHqjo41MgY1WBSWOfZtx91cQ+CoxSWh8TEdE=;
        b=lnFSVtvgG8oiTXOJPN6CxHa4rgsbI9h+cfxYx7tEKdxsvMB8ZUv7CwHmxdRRp/enVF
         NxIaAu+c4Ca4NtGj4LHuJu9Hy9uwG5K273O0sTBMGhkFuW5meHu/SefC9QHIRrJxN9tM
         97hiMyOM6lvE7iyMcAnCuJrYC5sP5aIRBYhXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7u2iFOgKHqjo41MgY1WBSWOfZtx91cQ+CoxSWh8TEdE=;
        b=mPtHLbe50mw6Nzw7OkJEr43w1viOJtEAxnoMaA6Ulm9tlyLgFlS78Ccg1OVJmbf7bC
         O4sXQy4LHISiMOlHUiY8fRxZqyfW7f3eGj6cE6+W2Ltc+TijsffNALzxg1VPSIcphLLx
         MK0JxedQ2A4YO6Ichkzc8E39u0gt8TKIbJkW/5Bk3vy/mloawvCejy6yc6G3Ta9jgyHe
         KUN+iF45EnYMgGifDAN2hd38coUu461/w3qD30Iow0ResU2ZqvEY/vt8ROWrCTPpfIum
         7bkU2QHWlfpqX1RNjrooDNvPvYukSxhsnQmpfSta5H6Mz4uz3k9EaIJcZTx8Y+VdA8Dp
         VcDA==
X-Gm-Message-State: AOAM5327sfvfLADrXoZypWuX78H6DCuaVMjT8zittRrd2A1RL0sIqO/6
        JPQH/fM+hvJMe03v+UYiXbuv4MZz+o8HnQ==
X-Google-Smtp-Source: ABdhPJzy8wuJ2wDhV9lC4jRJfSCnndOC5DlIe/EoPH7DxGGWieYtR8G5T2kKe5AniMqOb7E1aeq0Bg==
X-Received: by 2002:a50:bf09:: with SMTP id f9mr8792564edk.249.1594989102115;
        Fri, 17 Jul 2020 05:31:42 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id o15sm8099417edv.55.2020.07.17.05.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 05:31:41 -0700 (PDT)
Date:   Fri, 17 Jul 2020 14:31:39 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.8-rc6
Message-ID: <20200717123139.GE6171@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.8-rc6

Fix the following:

 - two regressions in this cycle caused by the conversion of writepage list
   to an rb_tree

 - two regressions in v5.4 cause by the conversion to the new mount API

 - saner behavior of fsconfig(2) for the reconfigure case

 - an ancient issue with FS_IOC_{GET,SET}FLAGS ioctls.


Thanks,
Miklos

----------------------------------------------------------------
Chirantan Ekbote (1):
      fuse: Fix parameter for FS_IOC_{GET,SET}FLAGS

Miklos Szeredi (6):
      fuse: move rb_erase() before tree_insert()
      fuse: fix warning in tree_insert() and clean up writepage insertion
      fuse: use ->reconfigure() instead of ->remount_fs()
      fuse: ignore 'data' argument of mount(..., MS_REMOUNT)
      fuse: reject options on reconfigure via fsconfig(2)
      fuse: clean up condition for writepage sending

Vasily Averin (1):
      fuse: don't ignore errors from fuse_writepages_fill()

---
 fs/fuse/file.c             | 132 ++++++++++++++++++++++++++-------------------
 fs/fuse/inode.c            |  19 +++++--
 fs/namespace.c             |   1 +
 include/linux/fs_context.h |   1 +
 4 files changed, 96 insertions(+), 57 deletions(-)
