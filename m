Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B95B361E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIILQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIILQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5A130D12
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 04:16:48 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oWc03-0002dP-JI; Fri, 09 Sep 2022 13:16:43 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-fsdevel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RFC PATCH 0/5] GEM buffer memory tracking
Date:   Fri,  9 Sep 2022 13:16:35 +0200
Message-Id: <20220909111640.3789791-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi MM and DRM people,

during the discussions about per-file OOM badness [1] it repeatedly came up
that it should be possible to simply track the DRM GEM memory usage by some
new MM counters.

The basic problem statement is as follows: in the DRM subsystem drivers can
allocate buffer aka. GEM objects on behalf of a userspace process. In many
cases those buffers behave just like anonymous memory, but they may be used
only by the devices driven by the DRM drivers. As the buffers can be quite
large (multi-MB is the norm, rather than the exception) userspace will not
map/fault them into the process address space when it doesn't need access to
the content of the buffers. Thus the memory used by those buffers is not
accounted to any process and evades visibility by the usual userspace tools
and the OOM handling.

This series tries to remedy this situation by making such memory visible
by accounting it exclusively to the process that created the GEM object.
For now it only hooks up the tracking to the CMA helpers and the etnaviv
drivers, which was enough for me to prove the concept and see it actually
working, other drivers could follow if the proposal sounds sane.

Known shortcomings of this very simplistic implementation:

1. GEM objects can be shared between processes by exporting/importing them
as dma-bufs. When they are shared between multiple processes, killing the
process that got the memory accounted will not actually free the memory, as
the object is kept alive by the sharing process.

2. It currently only accounts the full size of them GEM object, more advanced
devices/drivers may only sparsely populate the backing storage of the object
as needed. This could be solved by having more granular accounting.

I would like to invite everyone to poke holes into this proposal to see if
this might get us on the right trajectory to finally track GEM memory usage
or if it (again) falls short and doesn't satisfy the requirements we have
for graphics memory tracking.

Regards,
Lucas

[1] https://lore.kernel.org/linux-mm/20220531100007.174649-1-christian.koenig@amd.com/

Lucas Stach (5):
  mm: add MM_DRIVERPAGES
  drm/gem: track mm struct of allocating process in gem object
  drm/gem: add functions to account GEM object memory usage
  drm/cma-helper: account memory used by CMA GEM objects
  drm/etnaviv: account memory used by GEM buffers

 drivers/gpu/drm/drm_gem.c             | 42 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_gem_cma_helper.c  |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  3 ++
 fs/proc/task_mmu.c                    |  6 ++--
 include/drm/drm_gem.h                 | 15 ++++++++++
 include/linux/mm.h                    |  3 +-
 include/linux/mm_types_task.h         |  1 +
 kernel/fork.c                         |  1 +
 8 files changed, 72 insertions(+), 3 deletions(-)

-- 
2.30.2

