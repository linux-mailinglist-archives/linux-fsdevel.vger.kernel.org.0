Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17D03C66AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGLXI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:08:29 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40740 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLXI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:08:28 -0400
Received: by mail-ed1-f46.google.com with SMTP id t3so30406332edc.7;
        Mon, 12 Jul 2021 16:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3JrpqLbXkOfBbNk0ELMh5a3qu8730rv0zgRTcWu+h8=;
        b=R1nW3ZIz3uBBTFzCGB5+A7q/5O95deGvIjcXa3SqBpNXZWMA0g/rQMLpzs3QBHzJHW
         G3xSfnrydr7Rsun0uevx2ZvsHzLMJtwRvSoUTQhecTSySfigZiunKlViWDAwEpHt5eqD
         rORcyzeUUF1NZk9BwsF7XyOdKZqzCxAN/EnLgElVlpUMEoSuQfK9rEFhmlYjF2PTXrL9
         xDz/g6KPvcuweRrihvrV+RrYda3CT1GZR5lZmHnL+1p4KgPk9JavqiGZWRsBmaAKt9HC
         3sqbCeXMwjNZq6Qdq9Hgobt+3yQVpIm7srg2N5Zrh2+7QaRRVTODsG+uN9TQBCSKupJQ
         SVjA==
X-Gm-Message-State: AOAM531ec20h83pJCf7DczZZrqyh16IPqX4BbtCz07J1QbdoYjGMH+y9
        bu6lRHh8xuFnvCjtW/kje6x8OGG2EBxjtw==
X-Google-Smtp-Source: ABdhPJwimR1qNwQDXHKQzN8ANzCar7siG8nyLREKVpLbcf9hNE96enjk/ataUWPpM/YKFeu7uVE4UQ==
X-Received: by 2002:aa7:c857:: with SMTP id g23mr1525462edt.100.1626131137643;
        Mon, 12 Jul 2021 16:05:37 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id h3sm5494111ejf.53.2021.07.12.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:05:37 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
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
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: [PATCH v5 0/5] block: add a sequence number to disks
Date:   Tue, 13 Jul 2021 01:05:24 +0200
Message-Id: <20210712230530.29323-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Associating uevents with block devices in userspace is difficult and racy:
the uevent netlink socket is lossy, and on slow and overloaded systems has
a very high latency. Block devices do not have exclusive owners in
userspace, any process can set one up (e.g. loop devices). Moreover, device
names can be reused (e.g. loop0 can be reused again and again). A userspace
process setting up a block device and watching for its events cannot thus
reliably tell whether an event relates to the device it just set up or
another earlier instance with the same name.

Being able to set a UUID on a loop device would solve the race conditions.
But it does not allow to derive orderings from uevents: if you see a uevent
with a UUID that does not match the device you are waiting for, you cannot
tell whether it's because the right uevent has not arrived yet, or it was
already sent and you missed it. So you cannot tell whether you should wait
for it or not.

Being able to set devices up in a namespace would solve the race conditions
too, but it can work only if being namespaced is feasible in the first
place. Many userspace processes need to set devices up for the root
namespace, so this solution cannot always work.

Changing the loop devices naming implementation to always use
monotonically increasing device numbers, instead of reusing the lowest
free number, would also solve the problem, but it would be very disruptive
to userspace and likely break many existing use cases. It would also be
quite awkward to use on long-running machines, as the loop device name
would quickly grow to many-digits length.

Furthermore, this problem does not affect only loop devices - partition
probing is asynchronous and very slow on busy systems. It is very easy to
enter races when using LO_FLAGS_PARTSCAN and watching for the partitions to
show up, as it can take a long time for the uevents to be delivered after
setting them up.

Associating a unique, monotonically increasing sequential number to the
lifetime of each block device, which can be retrieved with an ioctl
immediately upon setting it up, allows to solve the race conditions with
uevents, and also allows userspace processes to know whether they should
wait for the uevent they need or if it was dropped and thus they should
move on.

This does not benefit only loop devices and block devices with multiple
partitions, but for example also removable media such as USB sticks or
cdroms/dvdroms/etc.

The first patch is the core one, the 2..4 expose the information in
different ways, and the last one makes the loop device generate a media
changed event upon attach, detach or reconfigure, so the sequence number
is increased.

If merged, this feature will immediately used by the userspace:
https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

v4 -> v5:
- introduce a helper to raise media changed events
- use the new helper in loop instead of the full event code
- unexport inc_diskseq() which is only used by the block code now
- rebase on top of 5.14-rc1

v3 -> v4:
- rebased on top of 5.13
- hook the seqnum increase into the media change event
- make the loop device raise media change events
- merge 1/6 and 5/6
- move the uevent part of 1/6 into a separate one
- drop the now unneeded sysfs refactor
- change 'diskseq' to a global static variable
- add more comments
- refactor commit messages

v2 -> v3:
- rebased on top of 5.13-rc7
- resend because it appeared archived on patchwork

v1 -> v2:
- increase seqnum on media change
- increase on loop detach

Matteo Croce (6):
  block: add disk sequence number
  block: export the diskseq in uevents
  block: add ioctl to read the disk sequence number
  block: export diskseq in sysfs
  block: add a helper to raise a media changed event
  loop: raise media_change event

 Documentation/ABI/testing/sysfs-block | 12 ++++++
 block/disk-events.c                   | 62 +++++++++++++++++++++------
 block/genhd.c                         | 43 +++++++++++++++++++
 block/ioctl.c                         |  2 +
 drivers/block/loop.c                  |  5 +++
 include/linux/genhd.h                 |  3 ++
 include/uapi/linux/fs.h               |  1 +
 7 files changed, 114 insertions(+), 14 deletions(-)

-- 
2.31.1

