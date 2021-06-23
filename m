Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD52C3B1849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 12:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFWLBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:01:36 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37683 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhFWLBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:01:36 -0400
Received: by mail-wr1-f44.google.com with SMTP id i94so2149443wri.4;
        Wed, 23 Jun 2021 03:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AlY4fiYgbrXorQsx3xst03zsKqKyrjxSHIbQdEZSgE=;
        b=EPVJbEpjPZM9ePdJqCAfBXfKlWHOFI99qegabS4EiLfOPGiYLvS+zZVw5fOENkhCGp
         4Ys0B5QlSYgIo5pJ61tTaf8SfJkfxxPT8hl98Pj6ADTEfnBJLhwUxBuK/jNqRLC5LPDE
         JrcX5kv5Ufclvu30jm/MT9Vn8VM6hTGThanxjsNQTdYDstXLbZAJ8kYCUdZ7TgTkrkWf
         /UHtjvZQHtsd9hWYyHuma8EWvuIXr4NmEzMG5h0ZJwYk8SJuj/S27GqRe+6HSR2XmdzB
         WOSMDxKuR3CfqlvWxLRjZbsLvgZckmGmBpuWBFYbed+I0d7fR1UPT4xJJ+pA7zlv189w
         5Y5w==
X-Gm-Message-State: AOAM530G5ILl/QHVlNOfQZBE1+ukCZmEMUiT+MRhLfQ3UfIAJ+7vHtPl
        ucr59KQ9Ii8vsM0faQWBf2wj6cT1V3xhOw==
X-Google-Smtp-Source: ABdhPJxMm1yvcS4hPM6aJ7GXE0Kew/P0LFO8c4NCuyHxk20Gk0prI065PGUL0Dhp3O4MIDyeBc84bg==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr10621296wrx.347.1624445956594;
        Wed, 23 Jun 2021 03:59:16 -0700 (PDT)
Received: from msft-t490s.. (mob-176-246-29-26.net.vodafone.it. [176.246.29.26])
        by smtp.gmail.com with ESMTPSA id r2sm2659458wrv.39.2021.06.23.03.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:59:16 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: [PATCH v3 0/6] block: add a sequence number to disks
Date:   Wed, 23 Jun 2021 12:58:52 +0200
Message-Id: <20210623105858.6978-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

With this series a monotonically increasing number is added to disks,
precisely in the genhd struct, and it's exported in sysfs and uevent.

This helps the userspace correlate events for devices that reuse the
same device, like loop.

The first patch is the core one, the 2..4 expose the information in
different ways, the 5th increases the seqnum on media change and
the last one increases the sequence number for loop devices upon
attach, detach or reconfigure.

If merged, this feature will immediately used by the userspace:
https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

v2 -> v3:
- rebased on top of 5.13-rc7
- resend because it appeared archived on patchwork

v1 -> v2:
- increase seqnum on media change
- increase on loop detach

Matteo Croce (6):
  block: add disk sequence number
  block: add ioctl to read the disk sequence number
  block: refactor sysfs code
  block: export diskseq in sysfs
  block: increment sequence number
  loop: increment sequence number

 Documentation/ABI/testing/sysfs-block | 12 +++++++
 block/genhd.c                         | 46 ++++++++++++++++++++++++---
 block/ioctl.c                         |  2 ++
 drivers/block/loop.c                  |  5 +++
 include/linux/genhd.h                 |  2 ++
 include/uapi/linux/fs.h               |  1 +
 6 files changed, 64 insertions(+), 4 deletions(-)

-- 
2.31.1

