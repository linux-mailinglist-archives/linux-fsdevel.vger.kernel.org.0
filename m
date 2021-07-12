Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734B83C669E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGLXE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:04:28 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:35493 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLXE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:04:28 -0400
Received: by mail-ej1-f44.google.com with SMTP id gn32so37807132ejc.2;
        Mon, 12 Jul 2021 16:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3JrpqLbXkOfBbNk0ELMh5a3qu8730rv0zgRTcWu+h8=;
        b=hoPCif4SqlhUnUOo2OgU8p+0GopdkE3D1n8c5FpGyBUo3HVXLOH8ZK6PXy/B8Sqo4M
         OuJBISb6m+BZisigysommeua0BouwHQEINvePys8xm0J9hQP+hYD5PgLupryifeirbml
         vwdOhObRggojYsPodX3ORaiX0ZsA0HKb0bx2HtrXkd0a2OVTu51c24EvRw5Wyw4eFBnY
         4I4X0xL/Jom1dPKMwdaHODjGilxsvwuyWojro9LTglUhHnOPWQv2+xT28J5z1hkdmpOc
         DXF7TiYTezTS8elOfGRFq7ExYPqA+vnxy7EBYOiZF7tFnV5/CMqYaomkkFEXqzaRYRJ/
         eNHw==
X-Gm-Message-State: AOAM531X2d3cEyLGAyI2J5dxy+qnqw+ole4epUq1oZQ/iKfoloYDld5t
        vJvPEpZGV+MfOnXR4OM7iRmrt2o4NLhDoA==
X-Google-Smtp-Source: ABdhPJyxLwoH8Va5Knv1+9gM+trG+cG+iu8REGL8OvlC2D6907WKiFstKeHe+In9muP470d7KZJtjQ==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr1662836ejc.180.1626130897088;
        Mon, 12 Jul 2021 16:01:37 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id c17sm4095895edv.6.2021.07.12.16.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:01:36 -0700 (PDT)
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
Subject: [PATCH v4 0/5] block: add a sequence number to disks
Date:   Tue, 13 Jul 2021 01:01:22 +0200
Message-Id: <20210712230128.29057-1-mcroce@linux.microsoft.com>
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

