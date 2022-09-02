Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FB5AAFAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiIBMmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbiIBMlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:41:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3798E868D;
        Fri,  2 Sep 2022 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662121886; x=1693657886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fDpXS+mwMN4S7KTgnVwvjs5feZwWXlXraJAIEBzDX2M=;
  b=X5d4yMTdb9rqtJD/vFsu0rl5cEeihbax9+NUBhn3Tz/9DdE4C77fA9/x
   GoZxapb2TGuT6GuW9i0/rpEFS202ZVzf43K/cWLgLOHFal5NcV2llukp5
   hX93eW6BqcrWARumP4aPweBKwUO4zGhuhVSB1mVvFnix2jUoMwJODE0A3
   IjSrGO3s0+ewxi+P4F9JbmuTxkYsiRVkI6qi7Zqs2115FRKiEpVRzjmmR
   4CGGTnIPsPPChV5v0UoXcmiamjo+uaDcv5GNc24O8JU0Y1KkhBbb/xVJn
   RW0T3o4nBWLF0srw1o5c96COprmU6l6nr/Z5RnWNsI2MP8/yLkYTGjHeu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="382268005"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382268005"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:30:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674338766"
Received: from azmijews-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.45.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:30:12 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5AC6D10484B; Fri,  2 Sep 2022 15:30:10 +0300 (+03)
Date:   Fri, 2 Sep 2022 15:30:10 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220902123010.zfyv6apmo3v67a2i@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <c194262b-b634-4baf-abf0-dc727e8f1d7@google.com>
 <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
 <20220902102757.GB1712673@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902102757.GB1712673@chaop.bj.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 06:27:57PM +0800, Chao Peng wrote:
> > +	if (flags & MFD_INACCESSIBLE) {
> > +		struct file *inaccessible_file;
> > +
> > +		inaccessible_file = memfd_mkinaccessible(file);
> > +		if (IS_ERR(inaccessible_file)) {
> > +			error = PTR_ERR(inaccessible_file);
> > +			goto err_file;
> > +		}
> 
> The new file should alse be marked as O_LARGEFILE otherwise setting the
> initial size greater than 2^31 on the fd will be refused by ftruncate().
> 
> +               inaccessible_file->f_flags |= O_LARGEFILE;
> +

Good catch. Thanks.

I will modify memfd_mkinaccessible() to do this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
