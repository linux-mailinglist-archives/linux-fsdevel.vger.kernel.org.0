Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C994DCEAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbiCQTWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiCQTWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:22:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2AA217C4B;
        Thu, 17 Mar 2022 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647544851; x=1679080851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7fZWSqYlT9W3vSMplyjhxJl5j4ia2hf7ih8pbhdlhjg=;
  b=KXQAdkGCqDuduJ3/qb4cU8dNIFqHkonbR+UdpGl8WIkFbav1DlxvUvXG
   rw+P9ZzEcL0/6axzHi/0K71/HHk2gg1gVX/L7caydRJbA4XIFr6zmgucN
   ZwhFNjaTz0NNtgU2l4BrnBR3cQBoLXFq9oGUenXZKCj4v3ZZ6pzclCK5p
   dhrZGukGMQt+su9MvgzEkbgCrLEe9aVpV+2ZAdWlfKPRjlF5Y4nnMxQ//
   rIRcBQu19Tw4m7PaLn1U6hOwRnrt0vR4cPPuuyTjohD71hR+t0RiIVJn/
   f/Fvtb+HR6v4BNWltM9V0fxpHkyryp4TCxSJSuvRiSQwOJjlyg5AuT/AO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257150092"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="257150092"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="691054840"
Received: from awyatt-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.178.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:51 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Regset cleanups
Date:   Thu, 17 Mar 2022 12:20:10 -0700
Message-Id: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I’m looking for ack’s on the first two patches from Intel reviewer’s before
this is ready for official submission to x86 maintainers. Patch 3 is in core
code, and Kees has offered to take it separately or ack it with the feedback
on the previous version. The first posting of this already got some nice
community feedback. Changes from v1 are in the patches. If you are not an Intel
reviewer, feel free to ignore this until it has had more review.

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

 arch/x86/kernel/ptrace.c | 171 ++++++++++++++++++++++++---------------
 fs/binfmt_elf.c          |  24 +++---
 2 files changed, 120 insertions(+), 75 deletions(-)


base-commit: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
-- 
2.17.1

