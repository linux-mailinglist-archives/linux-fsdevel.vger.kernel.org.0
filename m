Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C255A16C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbiHYQiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHYQit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:38:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A35B9F84;
        Thu, 25 Aug 2022 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661445529; x=1692981529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zAouvVhGGQU1mycPi0W4g/pSkl96QhPOemhs9ryS1uE=;
  b=hr8oU0Rcs/LXqfs86EyIBdryqxqDT2AUTC7Z5yRNvBRZfkPZqgqiJ5Gs
   i+7FL+QxY6LIJXb8mQhuZAODIlJ+FMI4Cu8tCoiGNqADyAw7wHnLGDEO3
   yMvyN3H+nOsZXu1KCnr+qL8oN1EwGWtmKYZLglfJGblU7Te+dcAtEamWd
   s3jHMPnaYUEDV0z9grWmj/qkC3IKdiCaWXvusge7x7T2UOuVCB+FH8ywC
   B5OmBavJXlTNqvvJXpJzMU8C5RYyklhdiQZJILQDDHYNvZMFXLQAoVwq5
   LyaNLczkeNQca1ACjBg3OjfRnx705Oi0lQ4TyVhnwkG2l6e2UkjjVc03i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293034889"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="293034889"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="671070402"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2022 09:38:45 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 0/2] libfs: Introduce tokenize_user_input()
Date:   Thu, 25 Aug 2022 18:48:31 +0200
Message-Id: <20220825164833.3923454-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Continuation of recent upstream discussion [1] regarding user string
tokenization.

First, tokenize_user_input() is introduced to allow for splitting
specified user string into a sequence of integers. Makes use of
get_options() internally so the parsing logic is not duplicated.

With that done, redundant parts of the sound driver are removed.

Originally similar functionality was added for the SOF sound driver. As
more users are on the horizon, it is desirable to update existing fs
code and provide a unified solution.


Changes in v2:
- reused get_options() so no parsing logic is duplicated
- simplified __user variant with help of memdup_user_nul()
  Both suggested by Andy, thanks for thourough review


[1]: https://lore.kernel.org/alsa-devel/20220707091301.1282291-1-cezary.rojewski@intel.com/


Cezary Rojewski (2):
  libfs: Introduce tokenize_user_input()
  ASoC: SOF: Remove strsplit_u32() and tokenize_input()

 fs/libfs.c                        | 45 +++++++++++++++
 include/linux/fs.h                |  1 +
 sound/soc/sof/sof-client-probes.c | 92 ++++---------------------------
 3 files changed, 57 insertions(+), 81 deletions(-)

-- 
2.25.1

