Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0D6F0A25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbjD0Qpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 12:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbjD0Qpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:45:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280F40DA;
        Thu, 27 Apr 2023 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682613935; x=1714149935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CHR31IdCwal0yUXcNr9mRrG5o4yzUESYoJmapQ/kSio=;
  b=ktOhNYCJAXtLJEmyy6mXWwSSWu6GI4w9tk6AFwNd/4Vn/JfZ5KWqQtkT
   TFBEWf9/KinVvol7mYK6vYBbagWypf/m0HincFX8sHInURo/Rtc7qq1IU
   51YjRPoBaYKh5boTuGV1ELHSmOKvkn9Rn+U3TT7m0UxkJhVu5zVa3LHXG
   2hWJw8FzT63SJv9DLbsQ0VqquYtCOQAjrErXkAe3SKw+gE6JLFgTj+4i8
   0cbYDscxwK1OEfpq//Gc3AdJSfuj2aRQIFkUcM1WSxzycPSQdIQ848QUG
   kkfn+7FEilSbqoLsHmQ34pf5EMuUSruh9QAeLUVK6sB2sjU702dGqC2WQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="347519235"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="347519235"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 09:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="727171153"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="727171153"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2023 09:45:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 09:45:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 09:45:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 09:45:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 09:45:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNJClBxl/jLFWAoXRDaBmqx3bQ5S0lo6oHuXagk0ApzdKH2m2qR7x2pHd9rPL0JodLrryX3ZHh1hcmXp1D3TOlSSQiJHwoSIDSxeLkb9mTHwAY070L0JK5Gd8YKGgpORg3TzO6oD0ktWk0uMsnzt1/d7HcBgqJ7BlMP62A5MtEmV3ODnRrWlJw81br/5iwYqttkrOpwm+T0mMCZ8C82FdbTU6xWpJkb915bJgTHSnk1v1usybwolYCPZkX7z+BT231mA9Jk+6vHct+tQUTV/hYbntCvbnvXOBAs1mcGcbOGfu6dW05+iI7jwoIwQP7ZSY5HR8SZMnseLBKRoGPRydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHR31IdCwal0yUXcNr9mRrG5o4yzUESYoJmapQ/kSio=;
 b=VQaSZSbcfpVcB0QAfuTMOhUjFUoiaHv1gRZf0Oy/7ryqMB6GIyVQMonri8ta3+ixhHI6OTD9ADtDtrN/vy50rAjT5gTVvOhs5HWj7/g5wsgGUnYZcs2aqoel0sfgj/BAQnWPhRWHp7/y8qemueswf2KkB0dzX+TpY4OsaFhMD8aWuva01QurETFuRtLmX3qUtaW6eehh1KFt8Cb+xgPggArsLPy7YYGvoog2gc9mCrSg80jvqSL1JM7Ulu3pxbEj8TtsY9n88ZaS5La0Rx5pNlQD+XEsHQw3K4XRT+SZyx84znPL1x2N0mCT/QN3KaUnf2MBFsEygbqEOZ1GFmscjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 16:45:26 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 16:45:25 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     "chu, jane" <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Topic: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Index: AQHZdBRFPZDWlOOp3UGtHDT7fo0Pga86CEYAgACeJYCAAKEtAIABAwhQgACIswCAAOwL8IAAoYwAgAAXkgCAAO3L4A==
Date:   Thu, 27 Apr 2023 16:45:25 +0000
Message-ID: <SJ1PR11MB6083E48452A7FE8D874F5CF0FC6A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
 <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
 <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB60833E08F3C3028F7463FE19FC679@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <316b5a9e-5d5f-3bcf-57c1-86fafe6681c3@huawei.com>
 <SJ1PR11MB6083452F5EB3F1812C0D2DFEFC649@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6b350187-a9a5-fb37-79b1-bf69068f0182@huawei.com>
 <SJ1PR11MB60833517FCAA19AC5F20FC3CFC659@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f345b2b4-73e5-a88d-6cff-767827ab57d0@huawei.com>
 <20230427023045.GA3499768@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20230427023045.GA3499768@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5488:EE_
x-ms-office365-filtering-correlation-id: 0b40576c-8cb1-4591-2caf-08db473ecd23
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWGvcc8z+a2xeVacGLH8xWXoL9mrkQQHHAvtM9ATVYxb8XVje0xXuHBkm524pjXIlE57S9IrBtrHqhnr84RwSRVVbqOhaZiSyqDvvI3wb4lGEylhTQ5sI1Fs29968dQ4hwADI7FjPfRHmDviZ02pPDqN8TegWEnJvDJTyhHPZgXZvEaPJ9w7FyjXJl6zphJj+LxXb4mHhtgSESMuBb20go+/R67mle3lo0lH1T0p6Bj4Wm3MOpB6Ww32lPEHqYcHBwczGxw2ySFcc7btF77aonjR/N2Wj6elaegp/CAAFO5zJYFPFAsOR7bX90sosgv0MI6dZKoLkx3mxMgSX6lYHhweqh4Nta5QNGrAJb5Kv0gQq6s8NsFB9zEw16MzYO8hTa9fQ18cQJoHA0Guan1IpMHNLjLBfpUdkKH5W6oj3qeQtTcaamyEglkyYOE949GJ8ujhPpXkv6Fi9xS+oHqe2NBe2TWQGeRRqzC70uIc/uISSq+Xoeg98g2xMS6PhkJCwaDZVTVLkgb6LBAjG9yLF3nfAYEwE6nH/JIDgsRr2IiDP7QFWxaqxGwU1rFPIiHyICKfFGihvO2kyRefZzdVlUq0YrYL4UzwnItUtJj+HPj+qEi49zOwH3GUlWK6NC5V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(33656002)(83380400001)(86362001)(9686003)(6506007)(26005)(71200400001)(7696005)(478600001)(54906003)(7416002)(66476007)(316002)(64756008)(76116006)(66946007)(66556008)(66446008)(4326008)(110136005)(8936002)(41300700001)(8676002)(38070700005)(122000001)(52536014)(38100700002)(2906002)(186003)(5660300002)(55016003)(82960400001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3JKZ3FEOGJ3QXdzd3ROcnhMcFh3amc2OTBNZ2FTNDdHRWJaeU0ySlJEaG5u?=
 =?utf-8?B?V1RTR2syZ2RGRExYcGxhUEk5cGtUaGdrK2s1ajhyMGczTnd0RGwvQmdjdFFs?=
 =?utf-8?B?WE1lRUNYRDhCMi8wcnRlSWVHRThoZjVFczJDMVdLRDBQekpBMkVjRnhxTWlO?=
 =?utf-8?B?UEFaODQwMmpPazVpS3VXdFFad1hzVHNYVnJidFNiUHp3VmpDa0FibGtMditr?=
 =?utf-8?B?WHY0R1c3bXJpY0ZUVjhCV1NablUrRG4vRWg5R2VOb2kwM0pEMHNmU0hLa2E3?=
 =?utf-8?B?azUrVUJHSUtId1JWOUJMVFlXc0tObWs0ak01VlRiV0JONFN0WUk2VnNldXlD?=
 =?utf-8?B?enNNSFI0TGczUEZQeUR1QWVxWkpJWC9HTnpYQUdKeUFDa0Zxb0VNSHFSOWh5?=
 =?utf-8?B?OHZBcWdRWDJrNzJiSEhmd0RWUEdzalhDZEgvZlRUaTJqMXMrN1M1SGEwQjho?=
 =?utf-8?B?aEQ4NnlrWnFsTmUrampZc3BIUENNYllRSjd1UGcrRGIyOGJ0R0ZpdWFTSHk2?=
 =?utf-8?B?cEE3TzNwOExiMWJNTC84K21uSThTS0hNSTlleGk1RWRROERIWkttenBLRnlo?=
 =?utf-8?B?U2t6Sm5xR2hSdGU1Nms0OW5DaW5pcjM1Tk13QjR0eDRsTWRrdVREYUI3QVlS?=
 =?utf-8?B?TmE1QW14a1k4ZGpCLzZsQy9aQmNnYktSdWNFVTdST0JQOEQzTXZ0YkNpcWY4?=
 =?utf-8?B?NWlEd25RQ0xhbWFncUh0UGNydkFGY0ZPRnNTcjZCcDA5WUFtTVpyNzR2ZWho?=
 =?utf-8?B?cndLeTJUcHR1aUZ5dWtMYUwwUFJTa0w3QzRtbWMrT2VHbU5aTWNTT0EwRGV4?=
 =?utf-8?B?WWJsSHdTMnlITWFFRTlSanZaUmVIRUNhN0VveTFoS1Q0WkFuOHJJMHNkdWpu?=
 =?utf-8?B?bXlCa29pYVN3ZFNSNy91aGdWUnZxaDh5cWNUZUwzSS9DM0FodDFoeGlMMU1G?=
 =?utf-8?B?MEl0UURXeGFSaGp4NWF3bXV0ODg2QVFaVnhZNmMvZGxhTGtKOS91ZTg2b3VR?=
 =?utf-8?B?NTZVZUdNcElweU0rbTVaeG85ei90cXpxd0lLS2wycjRVZjNkenkvSitNRFRW?=
 =?utf-8?B?ODNQZWZTczRDZWYveUswN0xLYTRuaWtzUU96emcwVlZaZDZreDFISjM3Zm1H?=
 =?utf-8?B?VTVpNy8rS3lteEpnejc4UDhheWpIZi9hc2JkaXZGcm9IZENBUDBueGFQWXh4?=
 =?utf-8?B?VVBoMFhGRDVFVFhEREZDODVxTVI5b0FKMklOMGp4Rm4ySnRJa3owd29Ba0dT?=
 =?utf-8?B?WkFPMVo5Z3A2cFUydDVocld1UXUyeThzdUxRVnhBejVEUk5LTmtkY2EwbllK?=
 =?utf-8?B?SEhqSmVndXczdy85eHRtLzJJRHloeVJtTEQzK3QwMS9vbGJoUm5SS2x3NXky?=
 =?utf-8?B?eHhsMlRXK0NVbzlSNHVlY1puUmYwNHI2ZlBrcmRza1g0eGhEdjhIWlpNc2Fz?=
 =?utf-8?B?c09IdXZNN292NjVlamwyeEcwNSsvT0pWTDVZblpKemdKL1lpaW9oU0c1UVNo?=
 =?utf-8?B?N2JPdXpRZUhPNVVCRUNlckVTUFF0MnhiUmdLZ1pQNzFLUkZJbWlLbWdmUWM0?=
 =?utf-8?B?a1o1bUg3eUhBOVU2b2J5VXE2SFJUZXlNMXdadVpiOGZlQUsrelh0UXBBOTBP?=
 =?utf-8?B?QmNxNUt6WkNqOW55REpVd1IzRndOU1dFWVdrdTQ5cUs1cXVxRFhwOXZBOXY1?=
 =?utf-8?B?aDlJOERvWVFoSlVJYnpUMktiRzk2SzV5RHNBZjhiam1aN2RGS3JWWkxUNXhE?=
 =?utf-8?B?QlkzNGFVSW9aZ2N5SnlzenBiQ2Yvc0FlUXRDeGxEbFRIa2F0bkdFVzhDNmtQ?=
 =?utf-8?B?NjlsT01XZ0VnajcxREhGb3lIUkN2NWtseEp4RDIvNXh2L1pXVm1vbnpzWDlZ?=
 =?utf-8?B?RC9wS21vb3FYdzJxeURHcVFoQnQ4TEZxaW81WnRTSjRmbzk2WE01Snllekph?=
 =?utf-8?B?eFJWTWdZeGp0eHlxV200TkU0OGlvd0MxMDFFcyt6RTd6aWZUcDZYNWNlK01n?=
 =?utf-8?B?OEtpNkgrUWw1R1FGOXNNd2FnYXcrVFJBOStzZTVmT3NlS1RZWG15TjdRcDhx?=
 =?utf-8?B?VXU0TVNOSGgzY2FiYWE3TnM3QW9ya2NWNFBCSHpUM0NhQVF4engyZVVFbFNB?=
 =?utf-8?Q?03p4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b40576c-8cb1-4591-2caf-08db473ecd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 16:45:25.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PbqXKe2nlZ8PTbIIK5Tcb0IGlbarYJ7v3knMs6kqq6Fge8/oMTyKfXcrzWYXCsmyYc39ZDJmwYYRV0RhvXt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5488
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IEJ1dCBpbiB0aGUgY29yZSBkdW1wIGNhc2UgdGhlcmUgaXMgbm8gcmV0dXJuIHRvIHVzZXIu
IFRoZSBwcm9jZXNzIGlzIGJlaW5nDQo+ID4gdGVybWluYXRlZCBieSB0aGUgc2lnbmFsIHRoYXQg
bGVhZHMgdG8gdGhpcyBjb3JlIGR1bXAuIFNvIGV2ZW4gdGhvdWdoIHlvdQ0KPiA+IG1heSBjb25z
aWRlciB0aGUgcGFnZSBiZWluZyBhY2Nlc3NlZCB0byBiZSBhICJ1c2VyIiBwYWdlLCB5b3UgY2Fu
J3QgZml4DQo+ID4gaXQgYnkgcXVldWVpbmcgd29yayB0byBydW4gb24gcmV0dXJuIHRvIHVzZXIu
DQo+IA0KPiBGb3IgY29yZWR1bXDvvIx0aGUgdGFzayB3b3JrIHdpbGwgYmUgY2FsbGVkIHRvbywg
c2VlIGZvbGxvd2luZyBjb2RlLA0KPiANCj4gZ2V0X3NpZ25hbA0KPiAJc2lnX2tlcm5lbF9jb3Jl
ZHVtcA0KPiAJCWVsZl9jb3JlX2R1bXANCj4gCQkJZHVtcF91c2VyX3JhbmdlDQo+IAkJCQlfY29w
eV9mcm9tX2l0ZXIgLy8gd2l0aCBNQy1zYWZlIGNvcHksIHJldHVybiB3aXRob3V0IHBhbmljDQo+
IAlkb19ncm91cF9leGl0KGtzaWctPmluZm8uc2lfc2lnbm8pOw0KPiAJCWRvX2V4aXQNCj4gCQkJ
ZXhpdF90YXNrX3dvcmsNCj4gCQkJCXRhc2tfd29ya19ydW4NCj4gCQkJCQlraWxsX21lX25ldmVy
DQo+IAkJCQkJCW1lbW9yeV9mYWlsdXJlDQo+IA0KDQpOaWNlLiBJIGRpZG4ndCByZWFsaXplIHRo
YXQgdGhlIGV4aXQgY29kZSBwYXRoIHdvdWxkIGNsZWFyIGFueSBwZW5kaW5nIHRhc2tfd29yaygp
IHJlcXVlc3RzLg0KQnV0IGl0IG1ha2VzIHNlbnNlIHRoYXQgdGhpcyBoYXBwZW5zLiBUaGFua3Mg
Zm9yIGZpbGxpbmcgYSBnYXAgaW4gbXkga25vd2xlZGdlLg0KDQotVG9ueQ0K
