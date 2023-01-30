Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A66805D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 07:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjA3GEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 01:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbjA3GEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:04:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0616338;
        Sun, 29 Jan 2023 22:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675058682; x=1706594682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5fmLvNRtAYCy0OTRAs8fs2gYH+k2mMKjDngDnqkE9o=;
  b=DjyhIEbr+47IW9dGNuEkMGxhuWVzLz3IB4KPU+fMGm0enAOGFCmoXLm/
   g/2k5kH27x5gPuALhBdoCxOzBn+8y4sSZGw/OQy8ZSyjaz0OqjH/fZdeT
   wrCugjomlL67DM1p1NbOjT5jBnne4AhrlMdkrwQLvMFCW0RsqHEGO1WoI
   zHTyRfgA0dkHamsTotRUprhUPhybJ0zec5ZQpTcdPTrrmecsiQZ1nPuQB
   2rUD4JU5E9E3TyU8JFDJSDrPjwbvAJd0TckliasJ+CFT2Qtpoqqd8QU5Q
   ZSSC25bHy0Z4epBL5jniy8uAIsr9NqXe8Vk23BEZXvU8Z+dYwHmtF228q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="392032309"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="392032309"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 22:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="787898171"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="787898171"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2023 22:04:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 22:04:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 22:04:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 22:04:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 22:04:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8+5kVIGE6NbU3j1o0dFGPHAAAd8eaFxLVWeUlVy3yEo3meaGLkkHggaX6T6QQeKHhmjc7WLl4bFEvS/DlUedYr8pKPyPMlmHVLgibHTnjP4DSWOEDB5mDP2AVNFc1Cmtcq2o2Vxj2ShgGnWy8V3Qr6QUCH9QhQ/1f20dtGRIfqjuZDsoi5OqzUtuSAh4b2LIlB+UI4e6VGtxO7zXDmHvuPmpOBG1Nox4tk9LnKiNsDrKHUoN1k4KAVKU+GyrNVTn/NbLsXX2JEeKmxeeC+OPSaK9/C9W4uPG6N3rUZvnkpamrqvHY8mfWHbsyOAxWw5y8yL+qqdHoTIFQKP7JePbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5fmLvNRtAYCy0OTRAs8fs2gYH+k2mMKjDngDnqkE9o=;
 b=ddxHrafppPXqcymZhdxhqeD8nYmxgoEpCOeglq577U0qkoWif5+J6DPHjxyGfqR0YSXNOg4dyJQNx5xzesxghauOlC0yRqXiIavgqiwT6iERNeKyAVZJfn9qpnSOCeHi8VyWmB4YPg5gH2zFiN+Zqwz3EoxshQgZI3b/tneQ3ylxyJX5O2VKTHF6+OWgY1FTMLoMogfM+iw+0smAjbjLMLXVQVq1nv1Wf1e/zBVuRJDhHZkEL5UA1/JEYc322hJXqOAljzLia2LFUM3cj6g+MuwLAQ+IQx/A4G0XuerhGraapN8AI+7rz46Psf+NLumjBlYAl5Dh9p/0Gl/8eue4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SJ0PR11MB5664.namprd11.prod.outlook.com (2603:10b6:a03:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:04:33 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::cf29:418d:2ed1:c1b9]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::cf29:418d:2ed1:c1b9%7]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 06:04:33 +0000
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hughd@google.com" <hughd@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "Annapurve, Vishal" <vannapurve@google.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "qperret@google.com" <qperret@google.com>,
        "tabba@google.com" <tabba@google.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>
Subject: RE: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Topic: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Index: AQHZNGtw73vDTEiM9EOftHR/UFkcZq62c6Rw
Date:   Mon, 30 Jan 2023 06:04:33 +0000
Message-ID: <DS0PR11MB6373D347AFCDD2A860BC9DEEDCD39@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20221202061347.1070246-2-chao.p.peng@linux.intel.com> (message
 from Chao Peng on Fri,  2 Dec 2022 14:13:39 +0800)
 <diqzzga0fv96.fsf@ackerleytng-cloudtop-sg.c.googlers.com>
In-Reply-To: <diqzzga0fv96.fsf@ackerleytng-cloudtop-sg.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SJ0PR11MB5664:EE_
x-ms-office365-filtering-correlation-id: 9d29fe4e-92f8-4cd8-237e-08db0287dbdd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6KfdEC5uOFZ6l7wVSwDEITVH5ANUKxDq82ufZI6Ux1w8eIKik4KOhLEudCDmAt4e5+lUDa+60fAcn7mOYak8SLluaqanbcQEqua3sqnMGsi9U+fwe4sOGNv5xrs5U5EHMnSFQqesY2lK+eAC/J1jLzrpmgPjRopz+NAoxh/8geZL2v+I7jkHSMRWu39CsH/ccKuPXgmeAciL+csV74VoyXBw232fNa8w+7fESQtW3HmjDA/NQpGt/Ed4X4A2nz/x/t7m/B8Qmvb/tXlTbuMuPhX1Kd1sNY8rAgG6w1xpn2ylSKEL3YNBWgtjE22Dwth4AF0e/tjEAFRrqJEqzcDlwL0cTay25lgy+6JDQ0CX2BXsrnPx1yq8634I1/iF/Y4G/evJGMXLZWzTJTNKa+klLhZhkX7vuFVHUJWF8Dj94JoyRYuK2+5pErZMZBA/wPtPfzsGuEByqaxDH6qUXblvCuPMyX7uPMPqLDILKHsANceRbKqGWFxq4oW6M01ICzrDGvSRXzN1w+wtqL6XWma/ynSH3D1MHf6D6Cc00godr5n4y8hBskMkJIfJy0ZiczYZR2FiUWuE2Ym9gk4q3sTp8br5NJfc12sWmkstYLYw3yUV4QkFY7t5zveVDvgfndxRDEUZzyNtmU0vULdojSSehO4dAClPiFpaRein4oEtMuTp06heAYxrTb2thX2ZlJvrcqNjjYoEIFcGfcIjiEDeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(33656002)(86362001)(38070700005)(82960400001)(38100700002)(122000001)(41300700001)(8936002)(5660300002)(52536014)(54906003)(110136005)(316002)(7406005)(66946007)(64756008)(66446008)(76116006)(66556008)(66476007)(4326008)(8676002)(55016003)(2906002)(7416002)(83380400001)(7696005)(478600001)(71200400001)(53546011)(9686003)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmE2WkdyYldoTkRzNG55SC8veGxPaVN2NlcyUmtJcURlTG4yVkJPTkNxdDJ6?=
 =?utf-8?B?R0RtSnVUNGpoWGpXS3NsUVhzWHJvWDViKzR4cnFwNXZRbWsrUDdtRHMyRGZE?=
 =?utf-8?B?cTJzcHpKYTJOelVaZ0huU2VSMksxZmJIVmJWRjJGRFo0K0lKOGNnWERIalRZ?=
 =?utf-8?B?LzZEMDdZdVFwMWZrUUVFSjdQYTJ6L3dkTmtMMFpDY2xNRU5pNERlQUpWOHQz?=
 =?utf-8?B?UDRHSWk3MWkyTE0wekRNQ25zK0ZCMTE5cHM3ajRZT29Oc1VrNS9hNzJqNUxB?=
 =?utf-8?B?Wm1xRFQxZURaYkVGbkJIeWE0OVJLNFpoQzY4b09CSVRWMnZsS24veDU1ekx1?=
 =?utf-8?B?NEw4TFUxZit2TFkybFBGdmhqQVpTK3hNWktBc0FGc05DUXh4RkwzOTFhak9B?=
 =?utf-8?B?aXV2SXBEWnN5UWpLV0hReTBrYjhoZHl4Y0VWRHZkc3lZdVQyOFJOeDA3cGVM?=
 =?utf-8?B?a3U3RThUc0RYRFk3c0hvT1pxQ25IMWdaYitHTGQ5MFhNSHpDTG8zREwxQ3hj?=
 =?utf-8?B?TzQ4WFBycjRvQWUrR1NDYXZQUlRzWnk4WTdQbWd6eWhkVndvOVpEeDRxbThy?=
 =?utf-8?B?a1FaTFFuVGQrUUg0WEttbXhlQVdkR2NjQXg1dVhleFR1Ynl6TVJ3emQwRFRX?=
 =?utf-8?B?V0ZYa2lGSkk2Wm1Ha29PbUVCWDNhTFZCM2svd3RycHN6dEtuNkxrbGp5S1NP?=
 =?utf-8?B?WVhUcExIZjJYSzIyQ2dtNXRLa1NoY3crbUJUNzJnSGExelMxQ05HRXk4dlRz?=
 =?utf-8?B?TlhBNHVqZGFRd21IKzltN1FmeUVWcGhLT2JXejQ1UVFDOC9DVnpiRExpZnRy?=
 =?utf-8?B?bmZjcmxXcHBFL1dKYUhGa2JCTUJyaXlOb3pDMHpwenMvWjViYWxYT0d2MUcv?=
 =?utf-8?B?emxqdURKcCt1dkxtZ1lTb2FzaTV0b29kN3pmOGhxNHh6U1VFS3FWV0h0Y3RG?=
 =?utf-8?B?NVo0Z1MwQUFGWXpQVkVkbG1zWkNoeFpMcThsWmJaakVxY1FONFlXTVZUYUk5?=
 =?utf-8?B?RWxmSXp6MTZsYlVFbzlkN0t1c3pmVFZvQ1JqS0pTeWVkVFRITDd1b1dlV0wx?=
 =?utf-8?B?SXB4cE5VZFBtdWpzUkl6OE5paUJpVXdtMGN3Z0NPSUhYUDQ4aG11dkNKSUs5?=
 =?utf-8?B?d0g2QlBPVy95Z1ZXRGQwY000dkRWcTloaFBvTEthRVFLR0QvWURxUWF5RFZn?=
 =?utf-8?B?MENLRzNaMDJVS0FUS3BybDg0UHA1emVJTkVEMXl1SnQ3RlVyL2xnK25IRzZ2?=
 =?utf-8?B?a3dhcGluZEdvaDFSbFhuRktWb0VnMjJSTFRESlR4elNqTlM0OG0rZ1ppeVNt?=
 =?utf-8?B?dXBMUFptaTJtVUcwQWcreEx2RENDYlF5cFp4VEdKNVpUekM3R1NhMlY2cDlH?=
 =?utf-8?B?ZXJhaUIvV2xmQVRjRlJIV0ZxRlV5VUxmdDRNbldqdm1OeERsRkg4VlR4ck9J?=
 =?utf-8?B?T2F2NHV0ZlY2QzV3bjJGZlBxOG5hRUtxWG92ak5NRFpjay9pdi9uMENrOU43?=
 =?utf-8?B?eGxsbWRYYjBXVlJhUnBhUG5KT2M5dW9lKzdJNlBhMU1tQ2dhLzROdWlHTGsx?=
 =?utf-8?B?d0IybENQWnp4Sm9pbGk1VmpINE5RdW4rL0I2b3hFN0VVanZaUGxJMHJ2M3Bn?=
 =?utf-8?B?clBLMXVyRFpGQk9QTmRhUGlOejRENVlaMVNFcUl1VStnU2gzVzU2NDQwa2lX?=
 =?utf-8?B?cjZUd3I1Z2pNZVFYWnlBOHBvMGM0QS9aL2FIbXlUUlJOTmlQREVyN2t4MllY?=
 =?utf-8?B?VFY2SFFobVp1cWJ6V1B1WEprSmY2aGFrK01yQldIbGZLZXNTSE8reEtwc1hW?=
 =?utf-8?B?UEtpb0VKYlZ0emZNcEZoN00xN3ZGaWZHNEdPanBvNW4yUnpJZ1c2Nm5YVnNa?=
 =?utf-8?B?UkkyWmlTdCtaQWRHU3l6N0VibjhmZVMwU0ZHb3BpTElkVVhlT2pMTmpxYlZC?=
 =?utf-8?B?RjJWZ1QwSFRxb2xCUlVhMWMwckJ2L3hQRWF4azE2ZHo2SmhpUFN3citzdHlR?=
 =?utf-8?B?ZjliVGxKejFISENSd2szd3l4bnFEb2pMVVpxL2trSEpUdjhFODJ4b0VGeFZY?=
 =?utf-8?B?eVpDM2pUa2NFVHhKVWxiUW51RDZtQ1VkcGNURmtlQ2VHSjZHU2kyM01UMmpO?=
 =?utf-8?Q?MyevNh7sPAc4rsng+J/gGKDNz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d29fe4e-92f8-4cd8-237e-08db0287dbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 06:04:33.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c28tr2qW5B0SanQn7jk0D3iUhvypzGdDsHflDEhfMOMSxfcSBaCM1rKoAjPnetanMp2vNUSvlrodv9Lzrqrrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5664
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uZGF5LCBKYW51YXJ5IDMwLCAyMDIzIDE6MjYgUE0sIEFja2VybGV5IFRuZyB3cm90ZToN
Cj4gDQo+ID4gK3N0YXRpYyBpbnQgcmVzdHJpY3RlZG1lbV9nZXRhdHRyKHN0cnVjdCB1c2VyX25h
bWVzcGFjZSAqbW50X3VzZXJucywNCj4gPiArCQkJCSBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwg
c3RydWN0IGtzdGF0ICpzdGF0LA0KPiA+ICsJCQkJIHUzMiByZXF1ZXN0X21hc2ssIHVuc2lnbmVk
IGludCBxdWVyeV9mbGFncykNCj4gew0KPiA+ICsJc3RydWN0IGlub2RlICppbm9kZSA9IGRfaW5v
ZGUocGF0aC0+ZGVudHJ5KTsNCj4gPiArCXN0cnVjdCByZXN0cmljdGVkbWVtX2RhdGEgKmRhdGEg
PSBpbm9kZS0+aV9tYXBwaW5nLQ0KPiA+cHJpdmF0ZV9kYXRhOw0KPiA+ICsJc3RydWN0IGZpbGUg
Km1lbWZkID0gZGF0YS0+bWVtZmQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIG1lbWZkLT5mX2lub2Rl
LT5pX29wLT5nZXRhdHRyKG1udF91c2VybnMsIHBhdGgsIHN0YXQsDQo+ID4gKwkJCQkJICAgICBy
ZXF1ZXN0X21hc2ssIHF1ZXJ5X2ZsYWdzKTsNCj4gDQo+IEluc3RlYWQgb2YgY2FsbGluZyBzaG1l
bSdzIGdldGF0dHIoKSB3aXRoIHBhdGgsIHdlIHNob3VsZCBiZSB1c2luZyB0aGUgdGhlDQo+IG1l
bWZkJ3MgcGF0aC4NCj4gDQo+IE90aGVyd2lzZSwgc2htZW0ncyBnZXRhdHRyKCkgd2lsbCB1c2Ug
cmVzdHJpY3RlZG1lbSdzIGlub2RlIGluc3RlYWQgb2YNCj4gc2htZW0ncyBpbm9kZS4gVGhlIHBy
aXZhdGUgZmllbGRzIHdpbGwgYmUgb2YgdGhlIHdyb25nIHR5cGUsIGFuZCB0aGUgaG9zdCB3aWxs
DQo+IGNyYXNoIHdoZW4gc2htZW1faXNfaHVnZSgpIGRvZXMgU0hNRU1fU0IoaW5vZGUtPmlfc2Ip
LT5odWdlKSwgc2luY2UNCj4gaW5vZGUtPmlfc2ItPnNfZnNfaW5mbyBpcyBOVUxMIGZvciB0aGUg
cmVzdHJpY3RlZG1lbSdzIHN1cGVyYmxvY2suDQo+IA0KPiBIZXJlJ3MgdGhlIHBhdGNoOg0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21tL3Jlc3RyaWN0ZWRtZW0uYyBiL21tL3Jlc3RyaWN0ZWRtZW0uYyBp
bmRleA0KPiAzNzE5MWNkOWVlZDEuLjA2YjcyZDU5M2JkOCAxMDA2NDQNCj4gLS0tIGEvbW0vcmVz
dHJpY3RlZG1lbS5jDQo+ICsrKyBiL21tL3Jlc3RyaWN0ZWRtZW0uYw0KPiBAQCAtODQsNyArODQs
NyBAQCBzdGF0aWMgaW50IHJlc3RyaWN0ZWRtZW1fZ2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3Bh
Y2UNCj4gKm1udF91c2VybnMsDQo+ICAgCXN0cnVjdCByZXN0cmljdGVkbWVtICpybSA9IGlub2Rl
LT5pX21hcHBpbmctPnByaXZhdGVfZGF0YTsNCj4gICAJc3RydWN0IGZpbGUgKm1lbWZkID0gcm0t
Pm1lbWZkOw0KPiANCj4gLQlyZXR1cm4gbWVtZmQtPmZfaW5vZGUtPmlfb3AtPmdldGF0dHIobW50
X3VzZXJucywgcGF0aCwgc3RhdCwNCj4gKwlyZXR1cm4gbWVtZmQtPmZfaW5vZGUtPmlfb3AtPmdl
dGF0dHIobW50X3VzZXJucywgJm1lbWZkLQ0KPiA+Zl9wYXRoLCBzdGF0LA0KPiAgIAkJCQkJICAg
ICByZXF1ZXN0X21hc2ssIHF1ZXJ5X2ZsYWdzKTsNCj4gICB9DQo+IA0KDQpOaWNlIGNhdGNoLiBJ
IGFsc28gZW5jb3VudGVyZWQgdGhpcyBpc3N1ZSBkdXJpbmcgbXkgd29yay4NClRoZSBmaXggY2Fu
IGZ1cnRoZXIgYmUgZW5mb3JjZWQgYnkgc2htZW06DQoNCmluZGV4IGMzMDE0ODdiZTVmYi4uZDg1
MGMwMTkwMzU5IDEwMDY0NA0KLS0tIGEvbW0vc2htZW0uYw0KKysrIGIvbW0vc2htZW0uYw0KQEAg
LTQ3Miw4ICs0NzIsOSBAQCBib29sIHNobWVtX2lzX2h1Z2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsIHN0cnVjdCBpbm9kZSAqaW5vZGUsDQogICAgICAgICAgICAgICAgICAgcGdvZmZfdCBp
bmRleCwgYm9vbCBzaG1lbV9odWdlX2ZvcmNlKQ0KIHsNCiAgICAgICAgbG9mZl90IGlfc2l6ZTsN
CisgICAgICAgc3RydWN0IHNobWVtX3NiX2luZm8gKnNiaW5mbyA9IFNITUVNX1NCKGlub2RlLT5p
X3NiKTsNCg0KLSAgICAgICBpZiAoIVNfSVNSRUcoaW5vZGUtPmlfbW9kZSkpDQorICAgICAgIGlm
ICghc2JpbmZvIHx8ICFTX0lTUkVHKGlub2RlLT5pX21vZGUpKQ0KICAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsNCiAgICAgICAgaWYgKHZtYSAmJiAoKHZtYS0+dm1fZmxhZ3MgJiBWTV9OT0hV
R0VQQUdFKSB8fA0KICAgICAgICAgICAgdGVzdF9iaXQoTU1GX0RJU0FCTEVfVEhQLCAmdm1hLT52
bV9tbS0+ZmxhZ3MpKSkNCkBAIC00ODUsNyArNDg2LDcgQEAgYm9vbCBzaG1lbV9pc19odWdlKHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KICAgICAgICBp
ZiAoc2htZW1faHVnZSA9PSBTSE1FTV9IVUdFX0RFTlkpDQogICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KDQotICAgICAgIHN3aXRjaCAoU0hNRU1fU0IoaW5vZGUtPmlfc2IpLT5odWdlKSB7
DQorICAgICAgIHN3aXRjaCAoc2JpbmZvLT5odWdlKSB7DQogICAgICAgIGNhc2UgU0hNRU1fSFVH
RV9BTFdBWVM6DQogICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQogICAgICAgIGNhc2UgU0hN
RU1fSFVHRV9XSVRISU5fU0laRToNCg==
