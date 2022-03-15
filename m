Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159AE4DA3D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351641AbiCOUTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCOUTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:19:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860C1A809;
        Tue, 15 Mar 2022 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647375482; x=1678911482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A0S0recbfR0lN7an2K5m+iODUM7Djv92LfoqIfc3vRI=;
  b=EIOhu6K96/w+hp7gzESMHCzQv1r5dTDUh6RGGxiV8U35Ll2LLUhXZTrs
   r3dkQMciaesCxYSy+TvtIhgSZqnOEKbQsQihfE4d5ZS5VYIXmr1qYvEYN
   CY5oJjFjpHKUXdkm6ek7KK6ygexcArmQciesz8vlNwzx0zBZIEkqKf1Uv
   ZMSgLB7/Ye3g69+DowYCVY5jfttN6XB4AGvZjvsAppgtnDaXmgWN0LmsJ
   Qm3q0Sgm60dpuOXKg2aFcCevRlOE1iHsbb3YOqrLrI/y2d11tN+8MlD10
   vUSvzTUKNo6YUn6oXm8vhQ7hjC8x8wmiqsj9Vre30dFq9cam6UTFUxab+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319634452"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="319634452"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="598448297"
Received: from anirudhk-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.229.227])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:00 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Regset cleanups
Date:   Tue, 15 Mar 2022 13:17:03 -0700
Message-Id: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I’m looking for ack’s from Intel reviewer’s before this is ready for official
submission to x86 maintainers. Patch 3 is in core code, so also including
relevant MAINTAINERS file people for that one. If you are not an Intel reviewer,
feel free to ignore this until it has had more review. Glad for any feedback all
the same. I’m also, wondering if this is something that could go through the x86
tree all together or I should split it out.



While working on CET ptrace support, I found some suggested cleanups [0] [1] on
past postings of that patch. So this small series is doing those cleanups and
some related changes.

Way back then, it was noticed that CET ptrace patches were aliasing names in the
enum that indexes the regsets. It turns out this was partly because of a
limitation in core dump code that reads the registers for dumping. But excluding
gaps in the regset array also allows them to be smaller, so just fixing the core
dump code doesn’t remove all need for the specially crafted enum. So series
changes the way the enums are defined such that enum has to be less carefully
crafted, and also fixes the core dump code.

Patch 1 is improving the enums in x86 ptrace code.

Patch 2 is some x86 ptrace code formatting changes suggested by Ingo. [0]

Patch 3 is the fix to the core dump code. Just to be clear, there is no actual
bug fixed. It would only overflow an array if the regset views were not laid out
just so. But the regsets appear to be laid out so that the brittle code is not
broken, from a quick scan of the archs.

Testing consisted of doing some core dumps and seeing that notes were in the
same position, and verifying that the enum’s generated the same ints using
printks.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20180711102035.GB8574@gmail.com/
[1] https://lore.kernel.org/lkml/A7775E11-8837-4727-921A-C88566FA01AF@amacapital.net/

Rick Edgecombe (3):
  x86: Separate out x86_regset for 32 and 64 bit
  x86: Improve formatting of user_regset arrays
  elf: Don't write past end of notes for regset gap

 arch/x86/kernel/ptrace.c | 165 ++++++++++++++++++++++++---------------
 fs/binfmt_elf.c          |  15 ++--
 2 files changed, 111 insertions(+), 69 deletions(-)

base-commit: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
-- 
2.17.1

