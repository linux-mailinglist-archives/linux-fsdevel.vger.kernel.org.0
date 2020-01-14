Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA713AD4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgANPRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:17:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37976 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:17:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so12562438wrh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=88H3jRep6vG6sxRNlrGRPzfb1JAw/CyGb6Ld2B5Ry1Y=;
        b=eSgjcdh82QFrz0QEODEPxpyhcAYZytHdxt0U8gstGgpU26aJXZKfWugWq8h2PSOcea
         tyqgEtOoToezYJCG+Y8tek63RUL31f4qKtdrUP5RgfgXzru49IpgBf62+Sj1TdrPXw+O
         hrr+FVj0PetqbsWaQK48+44qw+nt0pbCwBkhNg0CNkmQlxOYnJKLPcxUxDULcyIaOIai
         ItiNObW4ToDqbrXa39KQPDY44olrCSoJrd7R70zFTzbeChT8bOzE87hGx3r+afmmWWb+
         +g7hZar+cIoo7UlrkYSFtn5s3zkgD2XdeekJrKicXPZ+DzE/zoEIRIOsi50E/EQPKKaN
         0BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=88H3jRep6vG6sxRNlrGRPzfb1JAw/CyGb6Ld2B5Ry1Y=;
        b=LJXeKGeCb1jJJZkYgt61LDax/GKgAi+yyIJDcCtlzQ3RkLq8LTtbDzMWDIRr0WTDTI
         RfOTXFpxbBgiJETLth5yzdF4jPOWSTsnumlnAVetAL9xlyRpDyUW6ukoBvTXEe/pGzWG
         qmgKr2ilsGOdiiPA4kHSIVXUJ4VMEgNMhPcQydKqOw0AQOzf16miHv9W6bneiv7wwoVa
         p+0+I66v4AAlEH/n2wizbQDBvigMH1fQR9Srv4epvMWYDubuQ4dma4G0xEQ/SqjMBYQX
         4Gm/zsiIwBVNQ4TYHT17fC0gGp3CA7cHnHEEi9hudDPyfITNXfWt99wBscA1oh333zpq
         bpcg==
X-Gm-Message-State: APjAAAWwjpti3j+10+zTrmL1wqgU19nqbDIQMZCzjLaQ0nRi/E3mqS3I
        UVIS9ArelQNEFewiyXi7z7DgiBb1
X-Google-Smtp-Source: APXvYqyTi5HvF59Dsd2JeVPceiU2np3QyyPsIh8+aO7jVXK/EItxmVXcCR9nksvAEFAWIHQZGqxlmA==
X-Received: by 2002:adf:90e1:: with SMTP id i88mr24506588wri.95.1579015022044;
        Tue, 14 Jan 2020 07:17:02 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s19sm18276993wmj.33.2020.01.14.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:17:01 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] Prepare for fanotify name events
Date:   Tue, 14 Jan 2020 17:16:49 +0200
Message-Id: <20200114151655.29473-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Fanotify name event patches are ready at [1].
I am still updating the tests and the demo.

In the mean while, I wanted to post these few prep patches including
two bug fixes, so perhaps you will be able to process them in time for
v5.6-rc1.

Patches 1-4 are just cleanup and minor re-factoring in prep for the
name event patches.

Patches 5-6 are fixes for minor bug that I found during the work.
I improved ltp tests fanotify09 and fanotify15 to cover these bugs [2].

I did not mark those patches for stable, because backporting is not
trivial and the bugs are really minor.  For the same reason, I did
not bother to provide bug fix patches that are not dependent on the
cleanup patches, although that might have been possible to do.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_name
[2] https://github.com/amir73il/ltp/commits/fsnotify-fixes

Amir Goldstein (6):
  fsnotify: tidy up FS_ and FAN_ constants
  fsnotify: pass dentry instead of inode for events possible on child
  fsnotify: simplify arguments passing to fsnotify_parent()
  fsnotify: replace inode pointer with tag
  fanotify: merge duplicate events on parent and child
  fanotify: fix merging marks masks with FAN_ONDIR

 fs/notify/fanotify/fanotify.c        | 36 ++++++++++++++++++++--------
 fs/notify/fsnotify.c                 | 21 ++++++++--------
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 include/linux/fsnotify.h             | 26 ++++++++------------
 include/linux/fsnotify_backend.h     | 34 +++++++++++++-------------
 include/uapi/linux/fanotify.h        |  4 ++--
 kernel/audit_fsnotify.c              |  5 +++-
 kernel/audit_watch.c                 |  5 +++-
 8 files changed, 73 insertions(+), 60 deletions(-)

-- 
2.17.1

