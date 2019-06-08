Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF0A3A01A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfFHN50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jun 2019 09:57:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39343 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHN50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:57:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so4351053wma.4;
        Sat, 08 Jun 2019 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DYLjIhzRxK+XxIrU946vdp+6Nek5FSAXbzyqK9hH/Bg=;
        b=NKNAD2d1OGJ3qcYwCl5xqWDAqNFvYpYYi6JR6NvrmcSL4JpcIBCH4YXXpouAZXTUCR
         L4tdasmMVkyuESeVo4qBiFgyrHNlGhr9w+zOTOMmJ5rJ1PydFOcwjWASNWJAy6WEvzFY
         jauNy46nYjAiAwCojtoy1Z1pfZpe3F6td4+U9rXk/LjaliQfDUx89qSegODML0YoKebf
         AG3lHvTY587zWlyCQG0nzQGzVmndSpgnTuMbPipkfuPKaX0gjSggRG9RcE4NA3hjIUow
         ByTjl2gGBXpszCQCkSevCMBjr/6u2UuE5sRYQfOcvrdX4VwUVuqZvcrdouEBXt/sY64B
         9eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DYLjIhzRxK+XxIrU946vdp+6Nek5FSAXbzyqK9hH/Bg=;
        b=Isk4nOoHBWEfPdTKcJBk6MXPXj7Hc8I1KDzfZcZVDi4U4cY0YL4IbjQygMI0HjYkoE
         BCeW5WuIizJ2S5URGxAkFydgAvhEe/xbgwU4KEEKxd2byf5wxh7jQnX/QLul2UFme5HZ
         afC/u/ywFdPERr/wlclJEg3u+kz7sJByDgJRT4sMVeeSFbbIgLqUQ3vmvG0Z+t8sHQUl
         KdcP/yfsBTTTbdGMbYHMbNtbnH+P7ifHeC2nZuONLa14/elCGA4fOrs7yqj4IZL+UpXN
         xpmGpWvO/lcVOEUJgGc+hvNcz0pt8nhv0yQl/xweeBV5HaWq2FF7z+phTc2zzu+KVofe
         7QuA==
X-Gm-Message-State: APjAAAWXJQvKAo609RM8rRfcGeKqOCKmcOTFg7KYA9h+qg1QFJRjknt/
        IOM61Yv3G5Mwl1cgJOIwHY1CrhSl
X-Google-Smtp-Source: APXvYqwEHQCtm3iMua7PKb/EvjfTNLbW14ujz+6JS/BZY146AH+Gv4Kl4gnkqpantdZkVUyCruEjxw==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr6994354wmh.103.1560002244142;
        Sat, 08 Jun 2019 06:57:24 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id j132sm9423463wmj.21.2019.06.08.06.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 06:57:23 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH 0/2] Fix write leases on overlayfs
Date:   Sat,  8 Jun 2019 16:57:15 +0300
Message-Id: <20190608135717.8472-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

This series fixes a v4.19 regression.

It also provides correct semantics w.r.t RDONLY open counter
that Bruce also needed for nfsd.

I marked both patches for stable v4.19.

I verified the changes using modified LTP fcntl tests [1],
which I ran over xfs and overlayfs.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/overlayfs-devel

Amir Goldstein (2):
  vfs: replace i_readcount with a biased i_count
  locks: eliminate false positive conflicts for write lease

 fs/locks.c                        | 26 ++++++++++++++----------
 include/linux/fs.h                | 33 +++++++++++++++++++------------
 security/integrity/ima/ima_main.c |  2 +-
 3 files changed, 37 insertions(+), 24 deletions(-)

-- 
2.17.1

