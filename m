Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA83FB92D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhH3Pml convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 11:42:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:48073 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237460AbhH3Pmk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:42:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="197860326"
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="scan'208";a="197860326"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 08:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="scan'208";a="427871610"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2021 08:41:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 08:41:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 08:41:45 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Mon, 30 Aug 2021 08:41:45 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Borislav Petkov <bp@alien8.de>, X86-ML <x86@kernel.org>
Subject: RE: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Thread-Topic: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Thread-Index: AQHXm5pzAH4qSaa/BkWiD/swcmZu0auJ6p2AgAAE7YCAAAHvAP//xYSWgAJ7rdA=
Date:   Mon, 30 Aug 2021 15:41:45 +0000
Message-ID: <65cdd5f19431423dac13fbb13719ba55@intel.com>
References: <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx> <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
 <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
 <CA+8MBbLLze0siip=h-2hR3XiceBFQCN7uh5BPvqYRyBXgT318g@mail.gmail.com>
 <YSrlq41Ytw7q8fCR@casper.infradead.org>
In-Reply-To: <YSrlq41Ytw7q8fCR@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> No #MC on stores. Just on loads. Note that you can't clear poison
>> state with a series of small writes to the cache line. But a single
>> 64-byte store might do it (architects didn't want to guarantee that
>> it would work when I asked about avx512 stores to clear poison
>> many years ago).
>
> Dave Jiang thinks MOVDIR64B clears poison.
>
> http://archive.lwn.net:8080/linux-kernel/157617505636.42350.1170110675242558018.stgit@djiang5-desk3.ch.intel.com/

MOVDIR64B has some explicit guarantees (does a write-back invalidate if the target is already
in the cache) that a 64-byte avx512 write doesn't.

Of course it would stop working if some future CPU were to have a longer than 64 bytes cache line.

-Tony

