Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F228D650848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 08:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLSH7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 02:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLSH7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:59:01 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF6BC2E;
        Sun, 18 Dec 2022 23:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671436740; x=1702972740;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LTCN5nc9sJT3ve1jNEbkwKdzxPjXUiJ2eqZmznP7zEs=;
  b=apUAziLsi1avXc90CdVu3Tk+ZAKwrXTAVhoVT0ukEOkXjTdgjaXvpsvi
   osNLiMEc0XIJif58bf6GTq2L9ayChJY4uf32rVYak1dX6eHTcDZJdKNN6
   XcGu3RjsWwmOyIwNkpkJpiMQ9I6D9DAk/dUo/ygVUkns9LYNxizqNRKPo
   bi+yFSclXObovu0qvSPAsePk9d70I6UwIlmbIr6I8hsTbtImyz2mGRVFj
   8mq0KpHdKs7xWCiunRLH+kYg4yN2AC0qNHcK0ZtW8SJBAFqyQbrLi1X/2
   yWrNLtXvUJCTzmKygHTIxQwkVS9YKxLuMi4Ts072Y2MpOwAx4TbI4Qr2V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="383638121"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="383638121"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 23:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="895959169"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="895959169"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga006.fm.intel.com with ESMTP; 18 Dec 2022 23:58:49 -0800
Date:   Mon, 19 Dec 2022 15:54:32 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "tabba@google.com" <tabba@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "qperret@google.com" <qperret@google.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH v10 6/9] KVM: Unmap existing mappings when change the
 memory attributes
Message-ID: <20221219075432.GC1691829@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-7-chao.p.peng@linux.intel.com>
 <0889bab999cbb464e63490bdb5b3c68c07791979.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0889bab999cbb464e63490bdb5b3c68c07791979.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:51:25PM +0000, Huang, Kai wrote:
> On Fri, 2022-12-02 at 14:13 +0800, Chao Peng wrote:
> >  
> > -	/* flags is currently not used. */
> > +	/* 'flags' is currently not used. */
> >  	if (attrs->flags)
> >  		return -EINVAL;
> 
> Unintended code change.

Yeah!

Chao
