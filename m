Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA8673D88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjASPcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 10:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjASPcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:32:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C8582D49;
        Thu, 19 Jan 2023 07:32:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3205512wmb.0;
        Thu, 19 Jan 2023 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FT7eqe6MLyQ7xafND32p75X/BdvWAVCLwDSIWMtedok=;
        b=nR/M009m99yjBn6j3srQMHQ1GEe7IlYMEC7ENOxGqa3DunGT0VbAxm+1RuYB+doZT2
         UjWojMZ4Lx4cEcirgWCWW4ubUIL8AYR0fTy3KKX+tmdS5umtgJwU81WCglRyjP8D5ue/
         wCu6dUJfgpZ+18SHJcVeem+XjOqNwgw/iYf1eD+hzy/x4PfTGFo6MkJAQlOVX0ciM7W3
         lnEunBXQZgrfOlfn7wsByvBI8yqivRbCDAXLRK/jOMpp7uDl22J0MihsHSlNd66XfweP
         +PmH/2v0iblBd13TkQMKhQMXVDA3FujQTPRwMGvrgKx0mwp6ozlqin/7Rgfw7LAnjWbs
         cZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT7eqe6MLyQ7xafND32p75X/BdvWAVCLwDSIWMtedok=;
        b=gROALywG1b30hjfX8/O3vz2vfCFO02CjTKq0MJIDj5PI05dnXPG2LXHOoqeBWyneef
         TNLemWIMWI4LXyCfzq31WAxY5U+y9dFU22bjgjh84ktFCpNKpQZswfxJezQn6BMDIREN
         62tCX3/4zBMwH8c+5IUhLERKl2Jf4VKaRuK373XAfPoBmlfUzX4qzhsq3/Gci8027mi8
         iUeGTpndMELkVseiIAlARLvyWcMn43qTHaJWsY7BAzeDXvCaWkz/7jlesrjk1P/m7eZc
         bzHkJiQvj3A7M6QomkKD1RVL5HzfHMUVmS7mAEdlu+6ZE0rc8tmrxNnX67jht7k0zfz4
         /scg==
X-Gm-Message-State: AFqh2kq11e89NihHG6tzOL1DoGsbXnglUmR44413v06zb+dNCxlIIMz+
        2uVnUO+24ofllDC5fwzHaDc=
X-Google-Smtp-Source: AMrXdXtVWZat571QlCHPwMHq5oMBND4xUsumqOQHg/ijCY8wdFQd7Yj2jaYwLKYJiN361ha5eqwjAg==
X-Received: by 2002:a05:600c:3c86:b0:3da:2a59:8a4f with SMTP id bg6-20020a05600c3c8600b003da2a598a4fmr10698010wmb.38.1674142356754;
        Thu, 19 Jan 2023 07:32:36 -0800 (PST)
Received: from localhost.localdomain (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003cfd4e6400csm5827815wms.19.2023.01.19.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:32:36 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/4] fs/sysv: Replace kmap() with kmap_local_page() 
Date:   Thu, 19 Jan 2023 16:32:28 +0100
Message-Id: <20230119153232.29750-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

kmap_local_page() in fs/sysv does not violate any of the strict rules of
its use, therefore it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/sysv. kunmap_local()
requires the mapping address, so return that address from dir_get_page()
to be used in dir_put_page().

I had submitted a patch with the same purpose but it has been replaced
by this series.[1] This is based on a long series of very appreciated
comments and suggestions kindly provided by Al Viro (again thanks!).[2][3][4]

Changes from v1:[5]
	1/4 - No changes.
	2/4 - Delete an unnecessary assignment (thanks to Dan Carpenter).
	3/4 - No changes.
	4/4 - No changes.

Changes from v2:[6]
	1/4 - No changes.
	2/4 - Remove a redundant assignment in sysv_dotdot() and add a
	      comment (thanks to Al Viro for both suggestions).
	3/4 - No changes.
	4/4 - No changes.

[1] https://lore.kernel.org/lkml/20221016164636.8696-1-fmdefrancesco@gmail.com/
[2] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/#t
[3] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/#t
[4] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/#t
[5] https://lore.kernel.org/lkml/20221231075717.10258-1-fmdefrancesco@gmail.com/
[6] https://lore.kernel.org/lkml/20230109170639.19757-1-fmdefrancesco@gmail.com/

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Fabio M. De Francesco (4):
  fs/sysv: Use the offset_in_page() helper
  fs/sysv: Change the signature of dir_get_page()
  fs/sysv: Use dir_put_page() in sysv_rename()
  fs/sysv: Replace kmap() with kmap_local_page()

 fs/sysv/dir.c   | 120 +++++++++++++++++++++++++++---------------------
 fs/sysv/namei.c |   9 ++--
 fs/sysv/sysv.h  |   1 +
 3 files changed, 71 insertions(+), 59 deletions(-)

-- 
2.39.0

