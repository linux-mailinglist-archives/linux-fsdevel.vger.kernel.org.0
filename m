Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B655BA9D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIPJ7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiIPJ7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:59:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D8AA4D9;
        Fri, 16 Sep 2022 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663322353; x=1694858353;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=+GGngsOt+mHhqh1Zhh4O/6JETM5+xIHPKtlncj1KbqA=;
  b=jCk6G/BbCxqBSmqRYtWMEGvZ3X4Rcvi2rc7Rc1TuMfkOZBoLIuAQYXjd
   pj9VK+SQ197Gqm+34E4mB2lBeJxWnI4kVyAOaluo3qcFVZ+zGgVVJPtwx
   2WbXyXeVSxs5aRB8YY96VBintdJkvDPw3+HWTd3DLMzEUKTkd+Ezu8Dbj
   g6+S3k0G+1wkn+Rv6JUAHW9NOjEvestgc11oK8Y/r+/Au3IrWOsNCSNFp
   g8P/K7UDQ6m78sDkJHdhzVNl5uzBfRWGrzH7c4WBPRmilWSGmtilC88Ne
   35GKh+OgpgRM+wRQt1XHC6m5NxaFmiOhNsW5/NsbTggKPpXIxErJl91hn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325230069"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="325230069"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 02:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="620036737"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga007.fm.intel.com with ESMTP; 16 Sep 2022 02:59:03 -0700
Date:   Fri, 16 Sep 2022 17:54:24 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <20220916095424.GB2261402@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-4-chao.p.peng@linux.intel.com>
 <YyQ/PHZHkDSgjH/v@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyQ/PHZHkDSgjH/v@debian.me>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 04:17:48PM +0700, Bagas Sanjaya wrote:
> On Thu, Sep 15, 2022 at 10:29:08PM +0800, Chao Peng wrote:
> > + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> > +   private memory access when the bit is set otherwise the memory error is
> > +   caused by shared memory access when the bit is clear.
> 
> s/set otherwise/set. Otherwise,

Thanks.

> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


