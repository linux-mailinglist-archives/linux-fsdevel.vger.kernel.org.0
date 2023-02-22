Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FAB69EC32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 02:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBVBE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 20:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBVBE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:04:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052C93F1;
        Tue, 21 Feb 2023 17:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677027865; x=1708563865;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=LOZAvauTBVXSHkNwf9NULS0f0XiM5osi+19XTZiW0Jg=;
  b=l0wzCfqxz4SflglolfhDlrfvlAqhDXMdCbpeExCeQ2sINQcrCHoazjUG
   KTfXMytTgoan/BAD82/RWRIuD/IybYZLqD/wsHN5IAzDs+9PAN51IXP+5
   g/vAb6oGzpaqLtvYfrU+NmU77xnroaZeDkgP43petYVgOua9BY0NVZuGB
   Pa6LjdfDAwix4bI+pATeB3H1FSj+JRyWkvzTzjWiS7Jhy/FsCT77Bt7l0
   7/OoD1w5lvvpOj7XTVV/Wkw0wn1RqEcmimPgDfaUWIqcYCWXPgnLG7EDN
   gih2jjrwp30gCSHs8AHYEITEqAxsaSTH+1L8d9tJQU8HYo7gi1WsMdYOn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="332803712"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="332803712"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:03:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="704271120"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="704271120"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:03:44 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v5 0/9] migrate_pages(): batch TLB flushing
References: <20230213123444.155149-1-ying.huang@intel.com>
        <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com>
        <874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com>
        <871qmjdsj0.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20f1628e-96a7-3a5d-fef5-dae31f8eb196@google.com>
Date:   Wed, 22 Feb 2023 09:02:41 +0800
In-Reply-To: <20f1628e-96a7-3a5d-fef5-dae31f8eb196@google.com> (Hugh Dickins's
        message of "Tue, 21 Feb 2023 14:25:41 -0800 (PST)")
Message-ID: <87wn4acy1a.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

> On Tue, 21 Feb 2023, Huang, Ying wrote:
>> 
>> On second thought, I think that it may be better to provide a fix as
>> simple as possible firstly.  Then we can work on a more complex fix as
>> we discussed above.  The simple fix is easy to review now.  And, we will
>> have more time to test and review the complex fix.
>> 
>> In the following fix, I disabled the migration batching except for the
>> MIGRATE_ASYNC mode, or the split folios of a THP folio.  After that, I
>> will work on the complex fix to enable migration batching for all modes.
>> 
>> What do you think about that?
>
> I don't think there's a need to rush in the wrong fix so quickly.
> Your series was in (though sometimes out of) linux-next for some
> while, without causing any widespread problems.  Andrew did send
> it to Linus yesterday, I expect he'll be pushing it out later today
> or tomorrow, but I don't think it's going to cause big problems.
> Aiming for a fix in -rc2 would be good.

Sure, I will target to fix in -rc2.  Thanks for suggestion!

> Why would it be complex?

Now, I think the big picture could be,

if (MIGRATE_ASYNC) {
        migrate_pages_batch(from,);
} else {
        migrate_pages_batch(from,, MIGRATE_ASYNC,);
        list_for_each_entry_safe (folio,, from) {
                migrate_pages_batch(one_folio, , MIGRATE_SYNC,);
        }
}

That is, for synchronous migration, try asynchronous batched migration
firstly, then fall back to synchronous migration one by one.  This will
make the retry logic easier to be understood.

This needs some code change.  Anyway, I will try to do that and show the
code.

Best Regards,
Huang, Ying
