Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCDC38B0A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhETN6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 09:58:22 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:37855 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhETN6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 09:58:09 -0400
Received: by mail-ej1-f44.google.com with SMTP id et19so18391830ejc.4;
        Thu, 20 May 2021 06:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cCjGAR1fwsHjmVjT+mJq9iT2Slj8TG7dawqGnOR4Jg=;
        b=QcqnpNiJQVNSChWMYorJtidlN4+o15TpvmLpV6nkGXEmj7g18gKvtz6Qkgb938YXEk
         NN53X1JNIOsn1Mi8yw3BE1N25+LkCic3GECgG2k/p+jzQVRZL23r+HvJAoFW0YS7X4vX
         pQI79COzui6zym1juK2PW6k0jiRPLEAEwOvI7Cm5ygpSTg9cxZlttdZORREBkVu7w2TI
         FiPVUUvgSbiGEMHcsPjx7+Y6RsOoHna0jPqNCgHRNfFDcpW156KIN1+LQd2Fk9LYrfNB
         nMnPyjTP2L17jXKoIrd3p41BElrvhByqaY0oi4nIBkZZI5KLdaGgju/kMkNqQ/bqyQ+f
         FrVw==
X-Gm-Message-State: AOAM530DmeNzry3stKBxnyIDZbRl0zUEdygi8NVgrAASEXZZRLXmiChj
        kDQUmRTvgS2N/3A1dOqsnuT860kYrmWgbFQn
X-Google-Smtp-Source: ABdhPJxmRv/ruW/AF9XQ/nYomWyyla0gvlr1PVtMisWyjWr0B0e3h1c7stVRJKxVuk0CVve2IBx0HQ==
X-Received: by 2002:a17:907:a06d:: with SMTP id ia13mr4935283ejc.484.1621519006413;
        Thu, 20 May 2021 06:56:46 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id 9sm1434492ejv.73.2021.05.20.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:56:45 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH v2 0/6] block: add a sequence number to disks
Date:   Thu, 20 May 2021 15:56:16 +0200
Message-Id: <20210520135622.44625-1-mcroce@linux.microsoft.com>
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

