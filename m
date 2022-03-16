Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4128E4DB8F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiCPToS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbiCPToR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:44:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD78E19;
        Wed, 16 Mar 2022 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647459781; x=1678995781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c4qvEhEy+Pc5p6lcyyE0ggR8P976izS9wq4oqEcOcRU=;
  b=O4Yn6cJjB13EJ6J+8nSeeCsQMDcbzxRTxTY4WTOB01GEBSUYmCvfOX+j
   d7EWyKuxGbYCFq7hVRSOPwSO4IYgl5gKpdaBloDHLOfC6hxuYeipLjMRd
   aHH3v18hZp4PTY1aKySkzJPY0rdaQcnGssLdRs+xRqddceE9cgggd8j9S
   4U/LtfH/VSDQqJN1q/iPK4HUuFw+Ky4OuwVIyXMo0PYXNm5ii/IiXlFHV
   FGl2KUuVtoOQKWIcI1RxQtPRCN2RvyGJeKFa9vjRf8Xr/L+DQ+l5sllT8
   DXgbO6r86B024XSmuv3IsTLCf68nongsOWW//qdY1EhT71xWZRxdFuGYa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236643963"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="236643963"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613762121"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2022 12:43:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 12:43:00 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 12:43:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 12:43:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 12:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCdrTDbPYk4AP2kSLSoEXxVAXnRonohzYhvvGIr44QML2f7+APP64RIijsL4UO5F0WNhi+oP/2vLkzVbGWgu9T9o7O9Nyog1o/DnrUwYn29E4nRdbxT5ATYHLw5kuTzQqW0p60Uj/H6EVAQpcqZ94RSBD9Hp7wskbk4Ka1fg8VsN2/MD38BgR+xXwXVfpIpBXpr7QbNJ5OfuDvTe8LC5Ke03RCg/KBvX0MxazEZ/Ojx+fXPesmJ8lQnRJCvPWMegSUohr9M6Sn4EJWmZzBTZnvErp+Cf/Bz/XcMLRLPCkJnN0cWXXictUeeyJJRA+pr5mIWVff8o9qollsbdCiKEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4qvEhEy+Pc5p6lcyyE0ggR8P976izS9wq4oqEcOcRU=;
 b=JT9i/YZeycg9keKGbehxCZ64gosnEbT+yjXMGEktt8yeSg1Ch6XIuguOIrXc6xQaDz4Yjv6XUTYqa52p4efUtiH3Hh/ZskAmOGKT+wYBd7AJj+zyM4JhPwcWTKosDBUUvQgpmnL8EoWfZ6zTifrDQnkH21gNMaFShq52pH3LzwANe9buLV+p0WWcFk8i+XFyZ0m0CGgP607T/6L6tJv7cJkVDTyXvW7jPaqxWGVnq9B9EmMNm2lTBKN1T7Eq0DJd7CMbQnaTojk3Osp6ibDfpa0tlMCY0LLlb21mtUw6SRFHT+xpKrb6YSc+1jYZyGwo0q17N+kxNd0PdWPJQ9XnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR11MB1736.namprd11.prod.outlook.com (2603:10b6:903:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 19:42:58 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 19:42:57 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Topic: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Index: AQHYOKnIB2wsd8uW6EiQs+9kCgApRqzA6N8AgAAT7wCAAFKbAIABETqAgAAKGgA=
Date:   Wed, 16 Mar 2022 19:42:57 +0000
Message-ID: <80b0882f77d267293ea8b8d040bffe6032e1285e.camel@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
         <20220315201706.7576-2-rick.p.edgecombe@intel.com>
         <202203151340.7447F75BDC@keescook>
         <fe7ce2ae1011b240e3a6ee8b0425ff3e2c675b6d.camel@intel.com>
         <202203151948.E5076F4BB@keescook>
         <b5f9ce3c70d202834e0a76ed30966e2c81eb28dc.camel@intel.com>
In-Reply-To: <b5f9ce3c70d202834e0a76ed30966e2c81eb28dc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 986c9d97-63c3-44aa-cc97-08da07852c2d
x-ms-traffictypediagnostic: CY4PR11MB1736:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CY4PR11MB17366558F73B3C6D4CF7BEE6C9119@CY4PR11MB1736.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f0h9mZrCkzvP42FglPatXnmLTYlasQHa+KRxlILqrU9KAKerrYCMUeVs+kvqXLoFn9boRpeNdBSdag3KSPwLFITrMEm6GNH/WspsAqF5PJclFLYrn519K2ev1Db0VItCyRsYa70o4tUbx1Xp1sCG9ZZsq2nb0IKK/Cqh0XV74sOUV9Ns+mhRcCSGGQBboNNWkWxP8nUbzWVTB8cGb0HQMyY29dWJAC3EmWu3xeLI8GCxhB6D8P4m95eL7K2tXA8U9+k4WAk9s7B9fDaJY4cAoNIY0J+f5nDK6lMHoW9YJ8RX2ArYelmXS2MbXnKQVKgSsTjW2ePWtFOg9tSEWxAM7vJNTPz7V954q209i+uWabcXCCK9EFuyGP+2+VbjLyJ91AZqhYxe4wPfdh0tRJtZEToIcNVmCDpHRdvfSgYbomzDjrr1JIgWL1sAjkarAxC66fpbHZfsHCO6vda+mzUQWChFLZT3cFUuRrnsJyX61dXzDYfak9zaPhl4GodrfaQMiE4YS/H6WysXK8V6e12r4sZuv7rPy5YoHNaWVqCknUD+kgTjHPVq3XmepiB54lQUSlp8+a6KXQa+xV7nO5t3IRXGhK4+JF9AFwzPNFF3mtlbHgSLn/6tgKescFhKZdLKsan3txsx6o9cWHDmG0xYtHKscyjCg9Hu6bSsnO7xMo6SlUsWtWTnW3n4ESitdaopNDFjAq9MMEbciudPEbBIc4bxd/ajbEvgszNp+ANrrWs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(4744005)(8936002)(71200400001)(122000001)(6486002)(6916009)(36756003)(5660300002)(6506007)(6512007)(82960400001)(316002)(2906002)(54906003)(76116006)(8676002)(66476007)(66946007)(66446008)(64756008)(66556008)(186003)(26005)(4326008)(38070700005)(86362001)(38100700002)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2NSTC8zcU1CU0RkaEdqOXZZNVR5cThmM0dRZkcyTjVtbU0rS3ptalBTMEpx?=
 =?utf-8?B?OXJuY3Rra3BnaDFtWDl0NTRYR0dxTk9yb1YrQXdBbkxsVVFmdXVXQ3ZVeHBH?=
 =?utf-8?B?MjNSV1RXTTdpaC9FWTJuOXV1Sm9CcHl2dUs3V1VxeENOTnVsVVVHc3EvWmdD?=
 =?utf-8?B?N3B0Y0dpSzE2R2hEZkVpZjBOZUhSdlhVNktxL1V1L3FZZjR2aWR4MVJNczUr?=
 =?utf-8?B?VjRsU0VEUWV4dldOTy94cHVKM1RXZkVnTDMxRHBLRGhCUXBRUmNyOHlVVGlh?=
 =?utf-8?B?MUc1aVdPVE9RaHNGeG5TOUZ5VWJmYVlqY1RpaElYVytEZXp0L0daZm9NR1ZS?=
 =?utf-8?B?VXFzYllBS1UxWS9MTUJZUTJRL0ZCenczWUlIcWNPMSsrQlgrUlZDS0ZlSUo3?=
 =?utf-8?B?djg1dXFBZWNDUXZSaXRMcjA5R0pmV3B3aEwwWWk4YnlxcmJobFR4QTliTlg4?=
 =?utf-8?B?VVNpRWcvck92cXFEbGtTaCtKRWc4d25vZEtZbVhmd1RoSUJnNEJydGt5aWFi?=
 =?utf-8?B?NFJlcFl2MEJNQk1uUDQ1d2VENlpxSFk5K3RaZHFFdTcyZk1LcHplNFRocmxK?=
 =?utf-8?B?ZllpYjRUYTFlK2JwRlFKWnNUU2xKdENYTStSMHV0S2QwTnNJdGJNM1ZnWXI4?=
 =?utf-8?B?aDhTTC84UnFvVVRwSCs0U0RwbXpBRThxL2NiWmN1eU1LNkJEWVFNcmtrOFFD?=
 =?utf-8?B?ZE9xVzhWSVpmbHprdmQzVlYzeFlCQWJDVEIxSkdoNVB6UXNMYUY2MlVOYmVl?=
 =?utf-8?B?clhSbi9wTUlKd2NUSGxucGlJR2F5UVZ3MVdDUnZ2RHc4V2ovQ0ppR1NJV1hW?=
 =?utf-8?B?eFJpT242T0VSMm1nTnNEczYxUGFYU2gvSHN5ME1GZTlUZ2YrUEVaQWt3eUI5?=
 =?utf-8?B?ZGVabGJNNkhud3J0WTIvN2hMamQ4MG5nSjNONlFKNE5sTzZyMC9YWkd3akNa?=
 =?utf-8?B?Z3pGYXJWMmp3M1pHcFN3RXFDNE1PTk1PU3VlT3hraUQvSWZhemxvVGpZdExH?=
 =?utf-8?B?RDFBTko3SUVyTWoxUmtVNnBGOThWcEZXV0NoM1gvdVltaGpneVlRaFc3cTdJ?=
 =?utf-8?B?OXVQMGV6cEdLRVY4cis0ZVllSitMSk41elBISEVITFJyYzc4SExqM3pvY0xO?=
 =?utf-8?B?TzdPQkFIem1Qd3hSeTNZdTJLN005V0J6MStldVZ5UGtSRFRxdkd1ZzRzNWFt?=
 =?utf-8?B?a0ZFd2dWK3AwQ05ueGZXeDBDdjJKdWduM2pRbFdnSlJqaVdIamFUZi9TTS9u?=
 =?utf-8?B?c1psU01Qb1dWOGhaVnIxNUNMclB3REdvMVhPRlR2V3M2TXNNTmg5WTBJdXdj?=
 =?utf-8?B?MTNLYUp5NERGdG9ZQUlFdUJ2YzdRQmEyazFSdThhUWh6eUtrYklONHI2SlA4?=
 =?utf-8?B?ajZHQXg1eGJ6MW8zWnhjQUhEU2ovSWVWSGpyRHpYSHhSUUJiOEFzd1B6NW9o?=
 =?utf-8?B?QjYvMno2MHl1UVE4MCt4dUhYbGFJOVo2QXkzay9ISVFWazRMZXVTR0ZQd2o2?=
 =?utf-8?B?ZDBSTnpUQ1c3eURqT0c4TVlvdTBlSWNWc1BUSzdidXg2czFmZCthWWY1elNN?=
 =?utf-8?B?Qkw5ei83NG1NRTBvUCtTOWJHdVdYVUZuVFozeW1mVHJPZ3RxQmQzdjcxVTBF?=
 =?utf-8?B?OUNOQ0ZIbWxhd0tuY1BkTUdKbGR3Q3h0dVNLQXpubTA4VDU2OGVOR0Znd25Q?=
 =?utf-8?B?STFWQnkrT0hVTEo3cG1NalVRRnoyVGxWSVVmMVpuYXpIZ0NVUXpCOWErSGhv?=
 =?utf-8?B?dUZGVkJFaEc5T2xteFo0WktseU8rWFRKNi9DQ21Eckp1ei9ySzVLZVk3V2Zl?=
 =?utf-8?B?VVFqdzJjaTNpRGczTEt6VGdvN09ZeEUzRHVQbXlCamFlUzc2WjB0ZzlFVzZ2?=
 =?utf-8?B?Y3dlSGlxSVZKYVMwa2pIbVZ1YndkTnJBUUZndlduUm5paVQzd09saTgrWFVy?=
 =?utf-8?B?RjBtZ05xWmZpdXM4Mk9pVUl3eWMwbVNkN3FFc2Mzakw1a0R1S3ZPSkZ5WlFi?=
 =?utf-8?Q?SJtplnLYzYMxh9Os20xkw2CuZ9vyVs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF742FF03D85074FAAF67C6241A523AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986c9d97-63c3-44aa-cc97-08da07852c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 19:42:57.8184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvg8NT0c6FlJgJ40hPdXF4lw1n5oNxiPFijF1rDdpy+tafvRJ9W6YfcL/bSVdCwrTiR+xss44uG1djqJW99pVrrixudwbNf5qskiH+N6JfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1736
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTE2IGF0IDEyOjA2IC0wNzAwLCBFZGdlY29tYmUsIFJpY2hhcmQgUCB3
cm90ZToNCj4gQnV0IGV2ZW4gYWRkaW5nIGEgY29tbWVudCB0byB0aGUgYmFzZSBmaWxlIGhhcyBz
dXJwcmlzaW5nbHkgd2lkZQ0KPiBlZmZlY3RzLiBJdCBjYXVzZWQgdGhlIF9fYnVnX3RhYmxlIHNl
Y3Rpb24gdGFibGUgdG8gZ2V0IGNvZGUNCj4gZ2VuZXJhdGVkDQo+IHdpdGggZGlmZmVyZW50IGlu
c3RydWN0aW9ucywgbm90IGp1c3QgbGluZSBudW1iZXJzIGNvbnN0YW50cw0KPiBjaGFuZ2luZy4N
Cg0KRXJyLi4uIEkgc3VwcG9zZSB0aGlzIGlzIHByb2JhYmx5IGJlY2F1c2UgdGhleSBhcmUgbm90
IGFjdHVhbGx5DQppbnN0cnVjdGlvbnMgYW5kIHNvIHNob3VsZCBiZSBleHBlY3RlZCwgZHVoLg0K
