Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC696B4E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfGQDOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 23:14:36 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41475 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfGQDOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:14:36 -0400
Received: by mail-pf1-f201.google.com with SMTP id q14so13632047pff.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 20:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=;
        b=MEXCEEEPk/KuaWu/bxTbcr5Sv+ljjVJ5OJVxaekxPizc/h96zVyZZfexEYA9SVYpCV
         mjNK6v82DvgDgHKwdyC4kOKNH2VJ/VJDJ+Y8EGV/S4OPONugktXp7uenWF6BpIWIsCSn
         gk3QV/pTD0f1Ot1c4jFr0WyU7r3ZDFKJwWEsD3c0beg4TGWOT/qN2B8YjkmGYp7ZfOmq
         VZNWdX98/zP1yYpmKExnU7XInexP5ArSxTe3Q8MMV4Xbp5bv4dbT2Sr0GFZ3Fhvphn9r
         fMeA8QrxkD9RtLezfb49TUuBcKK3TcBeIUT8g6TVdU4YZSjYdoI3P20T9kvbW+psLYnL
         0yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=;
        b=tTT+bEuqNIk7ROBuimWoc5GlQ8XBpFWkdlQdWBQ2LdBZ8jjFQ8pGxUmw91XUKFSzic
         AXfU8U3pMiCAcBFtswHe90lKDYnQDGJ/HNBmiyLuNVW0eKbFH8N2t3cmcJWe2Itmxnf/
         nNHBBt9KREy4e+0ptATTTWjbh1TblGFImlyY/mtUs1IZHxDBtCYDgroygT04QJc+aKZX
         bD+NZpqLVrluhlFa33NjAVS/yWEbPZ1H/Ut7aaMAt0vEwp2nLbFzIvyeFSwim8xbHAbI
         kifoI61Nksi31Pg8AlCd34aqktdBoe1X6ZCJmiafbCl5Ck1PiUgNXprtNp5y4hloBvk3
         SYfw==
X-Gm-Message-State: APjAAAXKn9hLRk7ozXg58xstHukm1g9Ufj2hLNGUINh2tuBsDUbN4673
        hJ4Spj4sTjHFQtoTg6y0za4MTWtK/Ow=
X-Google-Smtp-Source: APXvYqx7EouYm/UBart6k3P8SNvF4Tt8Vrp1xqHYavJUzIKt18aw8pMHkXoYXAv17A98VxuiVijQcGClnME=
X-Received: by 2002:a65:55c7:: with SMTP id k7mr6163284pgs.305.1563333275476;
 Tue, 16 Jul 2019 20:14:35 -0700 (PDT)
Date:   Tue, 16 Jul 2019 20:14:06 -0700
Message-Id: <20190717031408.114104-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v2 0/2] Casefolding in F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are largely based on the casefolding patches for ext4
v2: Rebased patches again master, changed f2fs_msg to f2fs_info/f2fs_err

Daniel Rosenberg (2):
  f2fs: include charset encoding information in the superblock
  f2fs: Support case-insensitive file name lookups

 fs/f2fs/dir.c           | 133 ++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h          |  24 ++++++--
 fs/f2fs/file.c          |  10 ++-
 fs/f2fs/hash.c          |  34 +++++++++-
 fs/f2fs/inline.c        |   6 +-
 fs/f2fs/inode.c         |   4 +-
 fs/f2fs/namei.c         |  21 +++++++
 fs/f2fs/super.c         |  86 ++++++++++++++++++++++++++
 include/linux/f2fs_fs.h |   9 ++-
 9 files changed, 303 insertions(+), 24 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

