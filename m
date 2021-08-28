Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8883FA31D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 04:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhH1CVB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 22:21:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:18581 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233053AbhH1CU6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 22:20:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="240282552"
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; 
   d="scan'208";a="240282552"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 19:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; 
   d="scan'208";a="528533365"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2021 19:20:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 27 Aug 2021 19:20:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 27 Aug 2021 19:20:06 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Fri, 27 Aug 2021 19:20:06 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: RE: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Thread-Topic: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Thread-Index: AQHXm5pzAH4qSaa/BkWiD/swcmZu0auILsxw
Date:   Sat, 28 Aug 2021 02:20:05 +0000
Message-ID: <ace2140100e6409a876984fafbb9cbde@intel.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
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

> But if your kernel code loops and tries again without a return to user,
> then your get another #MC.

I've been trying to push this patch:

https://lore.kernel.org/linux-edac/20210818002942.1607544-1-tony.luck@intel.com/

which turns the infinite loops of machine checks into a panic.

-Tony
