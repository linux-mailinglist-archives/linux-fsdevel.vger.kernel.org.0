Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1392982114
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfHEQDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:03:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41595 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfHEQDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:03:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so39888276pff.8;
        Mon, 05 Aug 2019 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7x08fTlAtcnJHaKw1+e2ULk6svbbNjTrbJD6jGnKHoU=;
        b=LXIe/by2g8kAwhGpudayPYt5k4zTt+DTH7eiJZJUVf2itRT6HQq4sn4Ws3xaPHxVRD
         xv7xHYX47Okgaw/wFYmtEptJBEoLWieQBcyqgIIJaa1D2ZDdLPXJcYaM4jLrJb/ZV+RH
         L7rARzY6mu2H7isDPRKcCQdsj6qwz3EQS9zkFNx9jzV4DlNETmF5nYwv2ex4Rd+tybu9
         d5n7+iZJhlfDD3c9IN8ovsJgXXBzRqYCgszYSKQHqy2lUEiWy0WNOTQBsBtXA7igWoeG
         kYhvQcOQlOdvTtmJV5l2qLr8ZyP/ioVuDaWoCK7X3o/PvNE//bSDgGgZa92yiUi4OUko
         sqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7x08fTlAtcnJHaKw1+e2ULk6svbbNjTrbJD6jGnKHoU=;
        b=kaaJ4PBzadXCh4jlC/P1dBbfjDVa5XhxHPyQc8nzwksUqWoSmTku2cFo06q+f/YGEG
         BduJzd0rP8igkUxbaevMnuj1Q4TVSdi0WcTwzNZozs7x8qYtC0L7BfW2Dm76kaqVkY7Q
         BotoW4635jleYqXhpzgRlDqx1K8tlPe452exZ86pe9uY3ruN1z0Gcp0GD+x2juvcLxH9
         AeRCGA8nNeGl7sqNAsH8VnLuRhXzqqoYPtXkIrK6RhZiJsdmTwKTdpw4cLYv1Sj7mG5V
         uph9oVBDyPq0819Hc4xsp4PU/DXJV8TtAb0u7K09JPx99fXoZ01yNJVEWGwnq1EIWl70
         3z3w==
X-Gm-Message-State: APjAAAXJWhzHImwjA3rRvkZyW0CPHBpW7/Z/CnvJ1tA9EqYyuuTTfi0g
        q1y8DL6TLFRa2yEN5IDrbOE=
X-Google-Smtp-Source: APXvYqwlHzkEPNzjitM9BToseCozyRr+rvToOJ8jvZ3PWs8FMHpCuKXerfW7x1RWyGNI8w806urviA==
X-Received: by 2002:a17:90b:d8f:: with SMTP id bg15mr18692229pjb.65.1565020996027;
        Mon, 05 Aug 2019 09:03:16 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n98sm17061262pjc.26.2019.08.05.09.03.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:03:15 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 0/3] convert i915 to new mount API
Date:   Tue,  6 Aug 2019 01:03:04 +0900
Message-Id: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Hello,

Convert i915 to a new mount API and fix i915_gemfs_init() kernel Oops.

It also appears that we need to EXPORTs put_filesystem(), so i915
can properly put filesystem after it is done with kern_mount().

v2:
- export put_filesystem() [Chris]
- always put_filesystem() in i915_gemfs_init() [Chris]
- improve i915_gemfs_init() error message [Chris]

Sergey Senozhatsky (3):
  fs: export put_filesystem()
  i915: convert to new mount API
  i915: do not leak module ref counter

 drivers/gpu/drm/i915/gem/i915_gemfs.c | 33 +++++++++++++++++++--------
 fs/filesystems.c                      |  1 +
 2 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.22.0

