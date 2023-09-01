Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5387903DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Sep 2023 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351054AbjIAWzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 18:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244369AbjIAWzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:55:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B81730;
        Fri,  1 Sep 2023 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693602368; x=1725138368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XHxocslFLQU8xD6gE26XwrfQlSg9WQxfvtoRwUmoXd4=;
  b=fs73fJm9bRJyKBZKwbD5mEgyXK9s/AowGNS+H0gXHA0EQQMa1nzj0JyO
   4ivvodVmSEvCTmNx1xrrPG92m1n7/EkRzmofX9AcXraGnN9/xc4Xh6ZG3
   r17c6FwtwVCMhafLGgi3Sd3anIHvouYoJWsbVtWB5atZgqa0tZ4kh6j80
   EFKQ+sRpiruArmeWkbRk9jIoYa/6oLBssZoPneaIcO7Ca9aqEuR30pD4j
   bKFwnbrDOw1uWI+bsld1+fUELpibsdIlhMv8O6msge/MjCVUs3juuNPv0
   Bu48qxjBE2vnB0/wR3uxxdkcZAipPR81Pe31J6LaK0FJtf82Ckk21l7eo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="379031042"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="379031042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 14:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070871974"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="1070871974"
Received: from jroorda-mobl4.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.32.118])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 14:05:58 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 94702104994; Sat,  2 Sep 2023 00:05:55 +0300 (+03)
Date:   Sat, 2 Sep 2023 00:05:55 +0300
From:   kirill.shutemov@linux.intel.com
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     seanjc@google.com, ackerleytng@google.com,
        akpm@linux-foundation.org, anup@brainfault.org,
        aou@eecs.berkeley.edu, chao.p.peng@linux.intel.com,
        chenhuacai@kernel.org, david@redhat.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, jmorris@namei.org,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, liam.merwick@oracle.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mail@maciej.szmigiero.name,
        maz@kernel.org, michael.roth@amd.com, mpe@ellerman.id.au,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, paul@paul-moore.com, pbonzini@redhat.com,
        qperret@google.com, serge@hallyn.com, tabba@google.com,
        vannapurve@google.com, wei.w.wang@intel.com, willy@infradead.org,
        yu.c.zhang@linux.intel.com
Subject: Re: [PATCH gmem FIXUP] mm, compaction: make testing
 mapping_unmovable() safe
Message-ID: <20230901210555.j5d5a4azmkxzlnn2@box.shutemov.name>
References: <20230901082025.20548-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901082025.20548-2-vbabka@suse.cz>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 01, 2023 at 10:20:26AM +0200, Vlastimil Babka wrote:
> As Kirill pointed out, mapping can be removed under us due to
> truncation. Test it under folio lock as already done for the async
> compaction / dirty folio case. To prevent locking every folio with
> mapping to do the test, do it only for unevictable folios, as we can
> expect the unmovable mapping folios are also unevictable - it is the
> case for guest memfd folios.
> 
> Also incorporate comment update suggested by Matthew.
> 
> Fixes: 3424873596ce ("mm: Add AS_UNMOVABLE to mark mapping as completely unmovable")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Superficially looks good to me. But I don't really understand this
code path to Ack.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
