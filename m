Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41DE523B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 19:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbiEKRR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbiEKRRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 13:17:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BC130F71;
        Wed, 11 May 2022 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652289443; x=1683825443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WHDdURNms3aWfdEJX5KkrqUkQcS2EWtnqEvYYDuGX0w=;
  b=Xtz+u/eQOQ/mQueXE6vq3Vk3ZOmrQFWFEKW8yuiNkEiCC+RrT8dEMFrk
   o0GcL62sAMS39vUUHzqRVA344/GNhRjPrIfhdpWT76gxBOUzuR07mW49E
   0lD3ajNvZzc5dDAmHXkls0mGgAGIluZsmsJSn5evTXlIBmzmgn1I/hr3X
   apRBymW7oRFIWXXKjS9HEOvU4Spl5QB+THLtUt0xtzZhh2TZ+TolLmppC
   JX9ALB1MILvgvYxxzNiT5CuXM8F7gNyEiuh9PQiEd0YZCPe+GnxFUs/0p
   peuRSyb1C+BzH9u9kNGozTMvTwLJ//FDJzbwyl8iagqVGURjjb+ixuO5z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="250288454"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="250288454"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="636495042"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2022 10:17:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 10:17:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 10:17:21 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 11 May 2022 10:17:21 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     Jane Chu <jane.chu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>, Jue Wang <juew@google.com>
Subject: RE: [PATCH v9 3/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v9 3/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYVqBhtO9kfcaX30Okv6G3eRqhwq0Znj6AgABQagCAABkaEA==
Date:   Wed, 11 May 2022 17:17:21 +0000
Message-ID: <5aa1c9aacc5a4086a904440641062669@intel.com>
References: <20220422224508.440670-1-jane.chu@oracle.com>
 <20220422224508.440670-4-jane.chu@oracle.com>
 <CAPcyv4i7xi=5O=HSeBEzvoLvsmBB_GdEncbasMmYKf3vATNy0A@mail.gmail.com>
 <CAPcyv4id8AbTFpO7ED_DAPren=eJQHwcdY8Mjx18LhW+u4MdNQ@mail.gmail.com>
 <Ynt3WlpcJwuqffDX@zn.tnic>
In-Reply-To: <Ynt3WlpcJwuqffDX@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBJIC0ganVzdCBsaWtlIHlvdSAtIGFtIHdhaXRpbmcgZm9yIFRvbnkgdG8gc2F5IHdoZXRoZXIg
aGUgc3RpbGwgbmVlZHMNCj4gdGhpcyB3aG9sZV9wYWdlKCkgdGhpbmcuIEkgYWxyZWFkeSBzdWdn
ZXN0ZWQgcmVtb3ZpbmcgaXQgc28gSSdtIGZpbmUNCj4gd2l0aCB0aGlzIHBhdGNoLg0KDQpJSVJD
IHRoaXMgbmV3IHBhdGNoIGVmZmVjdGl2ZWx5IHJldmVydHMgYmFjayB0byB0aGUgb3JpZ2luYWwg
YmVoYXZpb3IgdGhhdA0KSSBpbXBsZW1lbnRlZCBiYWNrIGF0IHRoZSBkYXduIG9mIHRpbWUuIEku
ZS4ganVzdCBhbHdheXMgbWFyayB0aGUgd2hvbGUNCnBhZ2UgIm5vdCBwcmVzZW50IiBhbmQgZG9u
J3QgdHJ5IHRvIG1lc3Mgd2l0aCBVQyBtYXBwaW5ncyB0byBhbGxvdw0KcGFydGlhbCAoYnV0IG5v
bi1zcGVjdWxhdGl2ZSkgYWNjZXNzIHRvIHRoZSBub3QtcG9pc29uZWQgcGFydHMgb2YgdGhlDQpw
YWdlLg0KDQpJZiB0aGF0IGlzIHRoZSBjYXNlIC4uLiB0aGVuIEFja2VkLWJ5OiBUb255IEx1Y2sg
PHRvbnkubHVja0BpbnRlbC5jb20+DQoNCklmIEkndmUgbWlzdW5kZXJzdG9vZCAuLi4gdGhlbiBw
bGVhc2UgZXhwbGFpbiB3aGF0IGl0IGlzIGRvaW5nLg0KDQpUaGFua3MNCg0KLVRvbnkNCg==
