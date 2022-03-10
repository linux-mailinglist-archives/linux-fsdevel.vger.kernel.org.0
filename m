Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334F4D48EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiCJOP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbiCJOOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:14:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316851390F8;
        Thu, 10 Mar 2022 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921516; x=1678457516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XcUkjLL+YpWw11P834waxgWm/NgeT+vT/ACdu5U5CAo=;
  b=F/sUjSpCuWk97h0sO46fD8jRuA5FWxvDd7aR3R7NaO1nE+jWvZXr0D6X
   7wV4dJPL83+hSaW5X+NXupMONaBK+cElKsWFL+e8KgMo050tAAXng81hQ
   lF8vP+Q/dzgF4dcZBWpHsqRa8oGrIPlmFkBhAM+2KckfcgAMk7+7kE5I0
   Oizkr9EPNs4pC1KYrd8PnQNMf6493I9na6tX9HBAV1LjccSeiGQ6luqTj
   ha3tiaEZDTNZK2PaAFfwJaX9xTmZeEBA5np1QiG01hLK02CewHfNNmUOW
   7vDoveF13QNAwosp2COiEYa9HBK2oj0CUjxpSmqVBGccZjPPJ5y4ieCqP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235206263"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="235206263"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554655270"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:11:12 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 13/13] memfd_create.2: Describe MFD_INACCESSIBLE flag
Date:   Thu, 10 Mar 2022 22:09:11 +0800
Message-Id: <20220310140911.50924-14-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

