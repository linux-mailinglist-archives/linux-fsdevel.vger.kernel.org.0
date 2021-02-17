Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE031D405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBQCtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:49:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:4703 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhBQCtQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:49:16 -0500
IronPort-SDR: IEP3g+if30TnAvR8/lTZB4FobmAK1BN9Q/g5vkmeq4v8HBb4m6SnVLnI9itgAkCpStql+TYp2b
 ma5OI9lSsI0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="162219822"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="162219822"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:32 -0800
IronPort-SDR: 83LWfHuLlja+9QoccJ8EJbXvRgeuyQr6Fvnop3h0hxn7cXGXNm1038JR4Fk8KCfwbmVaJ50cS+
 Q+6yGJ2TEtQg==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="439191725"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:32 -0800
From:   ira.weiny@intel.com
To:     David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] btrfs: Convert more kmaps to kmap_local_page()
Date:   Tue, 16 Feb 2021 18:48:22 -0800
Message-Id: <20210217024826.3466046-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

I am submitting these for 5.13.

Further work to remove more kmap() calls in favor of the kmap_local_page() this
series converts those calls which required more than a common pattern which
were covered in my previous series[1].  This is the second of what I hope to be
3 series to fully convert btrfs.  However, the 3rd series is going to be an RFC
because I need to have more eyes on it before I'm sure about what to do.  For
now this series should be good to go for 5.13.

Also this series converts the kmaps in the raid5/6 code which required a fix to
the kmap'ings which was submitted in [2].

Thanks,
Ira

[1] https://lore.kernel.org/lkml/20210210062221.3023586-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20210205163943.GD5033@iweiny-DESK2.sc.intel.com/


Ira Weiny (4):
  fs/btrfs: Convert kmap to kmap_local_page() using coccinelle
  fs/btrfs: Convert raid5/6 kmaps to kmap_local_page()
  fs/btrfs: Use kmap_local_page() in __btrfsic_submit_bio()
  fs/btrfs: Convert block context kmap's to kmap_local_page()

 fs/btrfs/check-integrity.c | 12 ++++----
 fs/btrfs/compression.c     |  4 +--
 fs/btrfs/inode.c           |  4 +--
 fs/btrfs/lzo.c             |  9 +++---
 fs/btrfs/raid56.c          | 61 +++++++++++++++++++-------------------
 5 files changed, 44 insertions(+), 46 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

