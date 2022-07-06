Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D71568172
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiGFI1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiGFI11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:27:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FF240BF;
        Wed,  6 Jul 2022 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095997; x=1688631997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcUkjLL+YpWw11P834waxgWm/NgeT+vT/ACdu5U5CAo=;
  b=bXM4SmRunfF2UdZ6n2adSVce6ocOAHH1xRPLAz10BV2oKs9zugqpZkDy
   8i33755KPbazt9wepKm6IEY9asDygjbALi4nVDTUKElkJVhrytr9AY+iK
   DMtg4aMn8kiGYKQ7RxwoeO+ZVSKw/DE6Sjp0yXxFaFrmSlRLnyJ59JWqW
   cjfUGgcV7pYTkEupEnsOMoikiq642Z/9e8cVFbFRWfd57+w97Id6rkxlE
   94y5G41P/YmbhWo6wHoy7WDEtgDB0Kc0o2RORHR3+CCPMpgcTA6faftRQ
   9/d2CCGhHdmRTsZuRYjZLmND6Cb8Tax3SjIOkgKFBb0QbNGSwZ/WayQXC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272467402"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="272467402"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567968372"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:26:16 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 14/14] memfd_create.2: Describe MFD_INACCESSIBLE flag
Date:   Wed,  6 Jul 2022 16:20:16 +0800
Message-Id: <20220706082016.2603916-15-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 man2/memfd_create.2 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/man2/memfd_create.2 b/man2/memfd_create.2
index 89e9c4136..2698222ae 100644
--- a/man2/memfd_create.2
+++ b/man2/memfd_create.2
@@ -101,6 +101,19 @@ meaning that no other seals can be set on the file.
 .\" FIXME Why is the MFD_ALLOW_SEALING behavior not simply the default?
 .\" Is it worth adding some text explaining this?
 .TP
+.BR MFD_INACCESSIBLE
+Disallow userspace access through ordinary MMU accesses via
+.BR read (2),
+.BR write (2)
+and
+.BR mmap (2).
+The file size cannot be changed once initialized.
+This flag cannot coexist with
+.B MFD_ALLOW_SEALING
+and when this flag is set, the initial set of seals will be
+.B F_SEAL_SEAL,
+meaning that no other seals can be set on the file.
+.TP
 .BR MFD_HUGETLB " (since Linux 4.14)"
 .\" commit 749df87bd7bee5a79cef073f5d032ddb2b211de8
 The anonymous file will be created in the hugetlbfs filesystem using
-- 
2.17.1

