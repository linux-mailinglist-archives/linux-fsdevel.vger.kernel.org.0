Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292615B2C13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIICU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 22:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIICUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:20:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4989752E;
        Thu,  8 Sep 2022 19:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662690053; x=1694226053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OdMYeu3KhOhU/zz3RvTa7hJVA+wlquSZxYlXBYDUS10=;
  b=kjeKbpI54HuU/jj1atJpmKDp8iGZd2zlFRcsW9JfvLzGhHZetuRWPq1L
   ZglXSsF7kG5hYc7jLFj0lZtUSR/hsmrx6BDgyAsi/B/ct3Jw0PgZSdjg0
   Bb8OxQEYdBI5hFEjpwjxMIFDulYhM3+Bd3u2KDZINd1X6EIrN2OtKQ0H0
   TCB+W3fTc+OUj3+Ml042RA/WViiuTCYkj25+pFRpj8bBq6M5d45c3BtJM
   w14tACbaZiEAFPENdimBx/Bt1IPliz3gzVpFZT8gfkxJw1sbZv2EsV7Ib
   JWVfmh3vrDWy2uoe6KV3GSQCuKGP0FiC3B0cqcEyEwPCmokpkVwd6a2e7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323579285"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="323579285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 19:20:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="676968127"
Received: from zhichao2-mobl1.ccr.corp.intel.com (HELO jiezho4x-mobl1.ccr.corp.intel.com) ([10.255.31.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 19:20:50 -0700
From:   Jie2x Zhou <jie2x.zhou@intel.com>
To:     jie2x.zhou@intel.com, shuah@kernel.org, adobriyan@gmail.com,
        guozhengkui@vivo.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Philip Li <philip.li@intel.com>
Subject: make run_tests -C proc: proc-pid-vm assertion failed.
Date:   Fri,  9 Sep 2022 10:19:16 +0800
Message-Id: <20220909021916.43293-1-jie2x.zhou@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,

The test error is caused by g_vsyscall set failed.

Error output:
 selftests: proc: proc-pid-vm
 proc-pid-vm: proc-pid-vm.c:389: main: Assertion `rv == len' failed.
 Aborted

g_vsyscall is set to 0.
In proc-pid-vm.c:
/*
 * 0: vsyscall VMA doesn't exist        vsyscall=none
 * 1: vsyscall VMA is r-xp              vsyscall=emulate
 * 2: vsyscall VMA is --xp              vsyscall=xonly
 */
static int g_vsyscall;
static const char *str_vsyscall;

static const char str_vsyscall_0[] = "";
static const char str_vsyscall_1[] =
"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
static const char str_vsyscall_2[] =
"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";

The /proc/%u/maps output is:
buf=100000000-100001000 r-xp 00000000 00:2d 2                                /tmp/#2 (deleted)
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]

So the g_vsyscall should be 2 according to commentary(2: vsyscall VMA is --xp).
Is it a bug?

best regards,
