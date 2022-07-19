Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF857AABA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 01:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiGSXzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 19:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGSXzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:55:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE1286F0;
        Tue, 19 Jul 2022 16:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z95fgVZlUYh2TrcJSurzP77FPWh9CgO3bCQVlsbBM2Gsru9Z/5lUOPj2ZMYmlfsVCnq4/b3K2FlTd5KrbKX10XBdNTynJb6sbgxgXGoIkhv7AnPkor+1NPooKGLd7Psq+nCLJAIpvKM1MJF36aPgLvwC0pqdbcyAQ2WPENAGFHoKK5KVbdzCHGoU970PMMV9tev8zrAGSL/E2Dy46sSp9GjCKtDpnCFwSjXMLKEvqUIcvqzN1tyjbBztAwKC3EU2Gg8SzZwnBk19y8Yo4aYKumqJ9OvHi4Ixyxvd1aZppj4ZTeGCHpP9TzKOmpmlX6ZluFJhImF1+LSi76aMXMsEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t8PoXi8jR3Cge1lNKLAnYHnHZAR7b0HNhK4UiUc+90=;
 b=IMlmlgyKtny3a+8sh/syqfAX1oPVt3e+rf30jLeJiYOnCYiuKz07Tl3tilZPXq89z6tSqzfypT4Zq/pgwdLjDoqmjA9RKI8rS5wOAAY9E1apyjtyqvaaSxbjYRDidpz95vk0ujhb7YbUGcW14e2x4DSDtjrEAJBlJyQycUXrYRlIwrE15Z0HwKdcZe8onZjd3RFL4dZBwCbpfNtqQDZaXWzH2LO3xTDaXS4HyGK+e9OcdHvo261tQe7p35nJsMVzmBOTzkj+5aq6bTSVuNdHgXUcJIHI1ajzLHEbcI/pepLFmKT2XRf+OpMZ7Y+ipL4UgbQhzH2PA+THdO1zuHEFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t8PoXi8jR3Cge1lNKLAnYHnHZAR7b0HNhK4UiUc+90=;
 b=1onlhOkpx3x9o0mr4pp1/VeVYR93CgXo+wrzBVu9abLp/AcCUbqTIulkEDh3riLq/x1L9wSJCip+PDnK9PlozM/dwxMyhz0PmKAsgVvwfCb4p2vVXbnrYLheOg/L8gTYETG917jcScx7ZCP3kx5a5O9u/R963oewaoEdtMhGlDo=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN8PR05MB6370.namprd05.prod.outlook.com (2603:10b6:408:56::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.16; Tue, 19 Jul
 2022 23:55:21 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Tue, 19 Jul 2022
 23:55:21 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYm6msXDLL/Bu+aECRDX4d27LWyK2GR2wAgAADx4CAABN8gA==
Date:   Tue, 19 Jul 2022 23:55:21 +0000
Message-ID: <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
 <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
 <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
In-Reply-To: <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99cfbe3f-73de-485c-3e53-08da69e22417
x-ms-traffictypediagnostic: BN8PR05MB6370:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0dTaUAx4iZEaR+0cYY0XLnQiqZJmwB4lMuY9/bJmVnKYB1z1JqQZCZJbioNsxvVJVrmg9RqrjG4KrpLMxEhfKi9FPo5Wi7nmz/edRsp7FTVW4USmFzfz6JW+5HBTZmX3E33dmOIW9dOnq1A/j9tDYxsqtSwVUCiQcq5Nqsb9eR9qiUkfHk+WrqMyREj+JHEtbgHsx0mynuizOQBVyhh6ywTHOvKIDFB861++H9DFcm7/l6AaoPdvyPVQ+dtX1RMKwNvbf8tgtVXW8/mnpgO5X7ExQ9FWrgtzog8GHEzwurGB21z9wIt5wJD+Ye+3CO3OGGXQ9i83l9RbQzxNxiUBNj8lgVLYyqtpjRiz8MguKUcOZeJr64SD0K3hW4RAvZWLDz/CJJbTJrXxYfRLIc+SgcDjOILQlERSp1Wt1hdsYRFlE5cDt+dgFqeo6M71DX6K0qN5dIuTluQ8CR0YvLrnzfKZbKqcQu/6AOvsP5hU9TSem2sJC71lCckk4YgxjMiTCtszIj/a0wcanyBZ5oq/6TRXjmILAcnxI4h2oEf0/puodmWfnfBwvx+YBRLd2+3hmVlCoZpL3SetTUVVD3Y6hSItIakMdQJF3+oEwKCKwy0ehboYSGyoaaNSvRkXYqPvWvSv0c0J6zIEuh3lKi2r0+Ph7T2A8C+GtIc8TKE2XNkn9tLADSZSIx+oqQl+RwXyEYm9msS49C7qTXF+AlcDUNHFtbUBTLQfbLlxXe6Umb0DMBlvhsSjAzlZD1r5yR8gbfBH2v/NXYMZ238AOEefGDNVxILDGM94zjPl5efdF6wwMjZ7Y/QzGSKYua0PqQ5gyCngCHGcu+UG7/BwXmJ9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(7416002)(5660300002)(8936002)(66946007)(8676002)(66556008)(66476007)(4326008)(76116006)(2906002)(38100700002)(64756008)(66446008)(33656002)(36756003)(122000001)(2616005)(478600001)(71200400001)(6486002)(38070700005)(6512007)(6916009)(316002)(6506007)(186003)(86362001)(83380400001)(53546011)(26005)(54906003)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW5nK25xUHluTWhkNVlGSGRDWDVXRWdTRkgvaFpTZnVSSUk2d1ZzZzRBOFo4?=
 =?utf-8?B?OW9aVGhBUGRuRk5zYVRXeFBiSWZFV2hrVXVUS1orN01XUEFHd0pMK2lEYjhs?=
 =?utf-8?B?WVRUK3lvaE5IbkpNMjZkU2Z4NmhDU2pkeVYwV202Y20xL0ZpbmRET3pjUDA1?=
 =?utf-8?B?aDc5NTQ5ektHOW5TTExpVURwV1pINXdtTC9VR21IUjZrMlk5T284MTlzUkV0?=
 =?utf-8?B?YkF6STZ1NXJkS2czaGFrc3E5ZWxnY3Y5V2RvVHlEdHovUWtQd00rdmpBSjIx?=
 =?utf-8?B?TlZHcUIvdlpaZnkySFRvdURHSTFkWDF5MThwbEtVaWRqSWtGazlURCs1eDNW?=
 =?utf-8?B?d1NxNXd1UWc5QzRBaTg4QStwVzFOZEVMOUkxUVIzc2swMW5BZXdPRitNMFlN?=
 =?utf-8?B?cUlxWFduY3JWVFRvd3lwLzM2NVBmYk8vREdYc1N2ODJxdjM4clZZdmJKQVBI?=
 =?utf-8?B?aFdKMUQrcVQzYjd3WlJqMXVURUJFMGRBclJXK0tFcEo4TlZyeEtNUDN6OU9k?=
 =?utf-8?B?ZG82amFzcmRxNHhwMW8yRnV2VDd4cjJSOEtRbE1DcWRXbFNjQ0ZSTkd3NUtH?=
 =?utf-8?B?Y09QaWxwNVBiVllxVzFsdmMvbm9qTDdQdXJCanJaNkJhQ2dCVjZrdG5nY3lv?=
 =?utf-8?B?UmkrcVJ5dXZRdXQ1TTNyaFVkbGo0Q20wdC9yTFhJcTd0UWlFdURkUFEvUDVP?=
 =?utf-8?B?cTFQMlM2Qnh1MUVncFF0dTUwNkVPNmlNTnZCbGkzemRQd0YwYlZ0VEtYSUVE?=
 =?utf-8?B?QU9vZ2lzUTJ4OGIxRk5LZGNPclMwby9wZVJDM3Ixak5RTkVRblFneDVjY3Fm?=
 =?utf-8?B?elo3eXdpbjNWTlVvL0ZjWmZiN0FGNzZQMW8vTS9Hd1BLbjZLZC9CV2M2a3FH?=
 =?utf-8?B?NnZwb0RqL3ZSdVBodXhGRFNmdHpTcnhwb2lPbkh4YmdCTzFqNWg4bVdjZDRa?=
 =?utf-8?B?engza0JnNXNQbkZEWE9tUDcyajUyVFprQXFZK1VGY3pxRTJBaUVBMTRjMFRy?=
 =?utf-8?B?a2dqbmVaZlRSdStPUmRnekN1UmJPZ0pjR2hFc011NEtLOElLV3JrY1BXa1JE?=
 =?utf-8?B?a3pGTWUvbHVVSW9kT2V4M1dkOEZZRExiSHlGUWpQdkFnNHNCaVY2VGlrVmdT?=
 =?utf-8?B?ckZwZFF5SDFDYzhxZzg1R21lM2R6ek1zRHI1RHdFSnR2aW50d2dHanBlTTdp?=
 =?utf-8?B?RlQzb0llOUxuc3Y1YUhsUUREcTV6MEs3RWFvWGM1S1NDZDZIZGJNdGY5Y2FZ?=
 =?utf-8?B?TU5SWE9aaUlrRUM0cEJiREVoRXlZTVA2S3pYUHpFWkI4VEZCSTJIUW9Wd2sr?=
 =?utf-8?B?K2l4LzJvcGVNQy8zSUIrU1ozRUVxTVk0MVBiTGplMTd5bk04UHV0cWZKYncw?=
 =?utf-8?B?dCtHL2xRTUpHNnU5RXVaZ2VlUnBPaUZReUh4bE9Dc1lKaElPbUJTRWFDL0Jm?=
 =?utf-8?B?TVFYclVEYVJlcndsUFk0dWlkbVVLODY4WktZVW9DRDF4WjV6UWs3dDBFbGdD?=
 =?utf-8?B?S29uOTczMmVYZVN3cmd5aW1LeUIrYWs0Si9ETFJOUHZwNjdSSWlCZnVpV1RS?=
 =?utf-8?B?WlpNTUJGYU12TG9TUEpPSEQxa1NUeWdOdGo2OWNsUEdKWk1mbzdnc2I4TDlO?=
 =?utf-8?B?MTFLbTZLUEJMRTVBbTZHRTRtS2YrVkd1SFU5MmV0bHRxSjhmTVRySjVabnBL?=
 =?utf-8?B?T0FZczRlQXZacmtMenRySS91L2NwMEk2MUZ2TnlYa0FjSlFGSzIxSU54UVB3?=
 =?utf-8?B?YjNvZWYrc0ZFOG53Tm5maDU1L2MrU1VBOVRaK0VueDZwZi9mY2crMkl2NVpJ?=
 =?utf-8?B?UVFMUStOSncwRXNqRlFmUDcxRml0M2M1dWxGN0tzN3JVM3htcVJBeGdUSGEr?=
 =?utf-8?B?WXhwSWtNUHBqak9TZkxYV3IrVkp2bng4SU11MDJpcFZlVVJJNVBWL2dITC9q?=
 =?utf-8?B?eEFTNkFtSVpUUFg0ZnNUcmNmaUYzcXBWNndhRTdnV296dm40RGxQRGkrdTc1?=
 =?utf-8?B?bDdXVzNrdHNvYmo0R1AzYk9ENWhlNkJHRVFkSlJiMzU1Y3ozM0RMeWR3MVFk?=
 =?utf-8?B?dGlhT0dLTnAyVUFqcEZJUGJ6Ky9IRUZzaHpGT1Z2UEhEbGpvRzhTK1o5YWNH?=
 =?utf-8?Q?hHow0J9BvJptcrc6WehKlRvAf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFE487309CEDB141931C6BEEA296CA3A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cfbe3f-73de-485c-3e53-08da69e22417
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 23:55:21.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICbt905jAdCf5zcBj/Afi2cAhmMol1cUjK0S0ZkdclMXdoGXmOI18aK8I5uc2H4v+OdULndzdwx1Y1bpokQgng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6370
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gSnVsIDE5LCAyMDIyLCBhdCAzOjQ1IFBNLCBBeGVsIFJhc211c3NlbiA8YXhlbHJhc211c3Nl
bkBnb29nbGUuY29tPiB3cm90ZToNCg0KPiBPbiBUdWUsIEp1bCAxOSwgMjAyMiBhdCAzOjMyIFBN
IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gT24gSnVsIDE5LCAyMDIy
LCBhdCAxMjo1NiBQTSwgQXhlbCBSYXNtdXNzZW4gPGF4ZWxyYXNtdXNzZW5AZ29vZ2xlLmNvbT4g
d3JvdGU6DQo+PiANCj4+PiBIaXN0b3JpY2FsbHksIGl0IGhhcyBiZWVuIHNob3duIHRoYXQgaW50
ZXJjZXB0aW5nIGtlcm5lbCBmYXVsdHMgd2l0aA0KPj4+IHVzZXJmYXVsdGZkICh0aGVyZWJ5IGZv
cmNpbmcgdGhlIGtlcm5lbCB0byB3YWl0IGZvciBhbiBhcmJpdHJhcnkgYW1vdW50DQo+Pj4gb2Yg
dGltZSkgY2FuIGJlIGV4cGxvaXRlZCwgb3IgYXQgbGVhc3QgY2FuIG1ha2Ugc29tZSBraW5kcyBv
ZiBleHBsb2l0cw0KPj4+IGVhc2llci4gU28sIGluIDM3Y2QwNTc1YjggInVzZXJmYXVsdGZkOiBh
ZGQgVUZGRF9VU0VSX01PREVfT05MWSIgd2UNCj4+PiBjaGFuZ2VkIHRoaW5ncyBzbywgaW4gb3Jk
ZXIgZm9yIGtlcm5lbCBmYXVsdHMgdG8gYmUgaGFuZGxlZCBieQ0KPj4+IHVzZXJmYXVsdGZkLCBl
aXRoZXIgdGhlIHByb2Nlc3MgbmVlZHMgQ0FQX1NZU19QVFJBQ0UsIG9yIHRoaXMgc3lzY3RsDQo+
Pj4gbXVzdCBiZSBjb25maWd1cmVkIHNvIHRoYXQgYW55IHVucHJpdmlsZWdlZCB1c2VyIGNhbiBk
byBpdC4NCj4+PiANCj4+PiBJbiBhIHR5cGljYWwgaW1wbGVtZW50YXRpb24gb2YgYSBoeXBlcnZp
c29yIHdpdGggbGl2ZSBtaWdyYXRpb24gKHRha2UNCj4+PiBRRU1VL0tWTSBhcyBvbmUgc3VjaCBl
eGFtcGxlKSwgd2UgZG8gaW5kZWVkIG5lZWQgdG8gYmUgYWJsZSB0byBoYW5kbGUNCj4+PiBrZXJu
ZWwgZmF1bHRzLiBCdXQsIGJvdGggb3B0aW9ucyBhYm92ZSBhcmUgbGVzcyB0aGFuIGlkZWFsOg0K
Pj4+IA0KPj4+IC0gVG9nZ2xpbmcgdGhlIHN5c2N0bCBpbmNyZWFzZXMgYXR0YWNrIHN1cmZhY2Ug
YnkgYWxsb3dpbmcgYW55DQo+Pj4gdW5wcml2aWxlZ2VkIHVzZXIgdG8gZG8gaXQuDQo+Pj4gDQo+
Pj4gLSBHcmFudGluZyB0aGUgbGl2ZSBtaWdyYXRpb24gcHJvY2VzcyBDQVBfU1lTX1BUUkFDRSBn
aXZlcyBpdCB0aGlzDQo+Pj4gYWJpbGl0eSwgYnV0ICphbHNvKiB0aGUgYWJpbGl0eSB0byAib2Jz
ZXJ2ZSBhbmQgY29udHJvbCB0aGUNCj4+PiBleGVjdXRpb24gb2YgYW5vdGhlciBwcm9jZXNzIFsu
Li5dLCBhbmQgZXhhbWluZSBhbmQgY2hhbmdlIFtpdHNdDQo+Pj4gbWVtb3J5IGFuZCByZWdpc3Rl
cnMiIChmcm9tIHB0cmFjZSgyKSkuIFRoaXMgaXNuJ3Qgc29tZXRoaW5nIHdlIG5lZWQNCj4+PiBv
ciB3YW50IHRvIGJlIGFibGUgdG8gZG8sIHNvIGdyYW50aW5nIHRoaXMgcGVybWlzc2lvbiB2aW9s
YXRlcyB0aGUNCj4+PiAicHJpbmNpcGxlIG9mIGxlYXN0IHByaXZpbGVnZSIuDQo+Pj4gDQo+Pj4g
VGhpcyBpcyBhbGwgYSBsb25nIHdpbmRlZCB3YXkgdG8gc2F5OiB3ZSB3YW50IGEgbW9yZSBmaW5l
LWdyYWluZWQgd2F5IHRvDQo+Pj4gZ3JhbnQgYWNjZXNzIHRvIHVzZXJmYXVsdGZkLCB3aXRob3V0
IGdyYW50aW5nIG90aGVyIGFkZGl0aW9uYWwNCj4+PiBwZXJtaXNzaW9ucyBhdCB0aGUgc2FtZSB0
aW1lLg0KPj4+IA0KPj4+IFRvIGFjaGlldmUgdGhpcywgYWRkIGEgL2Rldi91c2VyZmF1bHRmZCBt
aXNjIGRldmljZS4gVGhpcyBkZXZpY2UNCj4+PiBwcm92aWRlcyBhbiBhbHRlcm5hdGl2ZSB0byB0
aGUgdXNlcmZhdWx0ZmQoMikgc3lzY2FsbCBmb3IgdGhlIGNyZWF0aW9uDQo+Pj4gb2YgbmV3IHVz
ZXJmYXVsdGZkcy4gVGhlIGlkZWEgaXMsIGFueSB1c2VyZmF1bHRmZHMgY3JlYXRlZCB0aGlzIHdh
eSB3aWxsDQo+Pj4gYmUgYWJsZSB0byBoYW5kbGUga2VybmVsIGZhdWx0cywgd2l0aG91dCB0aGUg
Y2FsbGVyIGhhdmluZyBhbnkgc3BlY2lhbA0KPj4+IGNhcGFiaWxpdGllcy4gQWNjZXNzIHRvIHRo
aXMgbWVjaGFuaXNtIGlzIGluc3RlYWQgcmVzdHJpY3RlZCB1c2luZyBlLmcuDQo+Pj4gc3RhbmRh
cmQgZmlsZXN5c3RlbSBwZXJtaXNzaW9ucy4NCj4+IA0KPj4gQXJlIHRoZXJlIGFueSBvdGhlciDi
gJxkZXZpY2VzIiB0aGF0IHdoZW4gb3BlbmVkIGJ5IGRpZmZlcmVudCBwcm9jZXNzZXMNCj4+IHBy
b3ZpZGUgc3VjaCBpc29sYXRlZCBpbnRlcmZhY2VzIGluIGVhY2ggcHJvY2Vzcz8gSS5lLiwgZGV2
aWNlcyB0aGF0IGlmIHlvdQ0KPj4gcmVhZCBmcm9tIHRoZW0gaW4gZGlmZmVyZW50IHByb2Nlc3Nl
cyB5b3UgZ2V0IGNvbXBsZXRlbHkgdW5yZWxhdGVkIGRhdGE/DQo+PiAocHV0dGluZyBhc2lkZSBu
YW1lc3BhY2VzKS4NCj4+IA0KPj4gSXQgYWxsIHNvdW5kcyBzbyB3cm9uZyB0byBtZSwgdGhhdCBJ
IGFtIGdvaW5nIHRvIHRyeSBhZ2FpbiB0byBwdXNoYmFjaw0KPj4gKHNvcnJ5KS4NCj4gDQo+IE5v
IG5lZWQgdG8gYmUgc29ycnkuIDopDQo+IA0KPj4gRnJvbSBhIHNlbWFudGljIHBvaW50IG9mIHZp
ZXcgLSB1c2VyZmF1bHRmZCBpcyBwcm9jZXNzIHNwZWNpZmljLiBJdCBpcw0KPj4gdGhlcmVmb3Jl
IHNpbWlsYXIgdG8gL3Byb2MvW3BpZF0vbWVtIChvciAvcHJvYy9bcGlkXS9wYWdlbWFwIGFuZCBz
byBvbikuDQo+PiANCj4+IFNvIHdoeSBjYW7igJl0IHdlIHB1dCBpdCB0aGVyZT8gSSBzYXcgdGhh
dCB5b3UgYXJndWVkIGFnYWluc3QgaXQgaW4geW91cg0KPj4gY292ZXItbGV0dGVyLCBhbmQgSSB0
aGluayB0aGF0IHlvdXIgYXJndW1lbnQgaXMgeW91IHdvdWxkIG5lZWQNCj4+IENBUF9TWVNfUFRS
QUNFIGlmIHlvdSB3YW50IHRvIGFjY2VzcyB1c2VyZmF1bHRmZCBvZiBvdGhlciBwcm9jZXNzZXMu
IEJ1dA0KPj4gdGhpcyBpcyBFWEFDVExZIHRoZSB3YXkgb3BlbmluZyAvcHJvYy9bcGlkXS9tZW0g
aXMgcGVyZm9ybWVkIC0gc2VlDQo+PiBwcm9jX21lbV9vcGVuKCkuDQo+PiANCj4+IFNvIGluc3Rl
YWQgb2YgaGF2aW5nIHNvbWUgc3RyYW5nZSBkZXZpY2UgdGhhdCBiZWhhdmVzIGRpZmZlcmVudGx5
IGluIHRoZQ0KPj4gY29udGV4dCBvZiBlYWNoIHByb2Nlc3MsIHlvdSBjYW4ganVzdCBoYXZlIC9w
cm9jL1twaWRdL3VzZXJmYXVsdGZkIGFuZCB0aGVuDQo+PiB1c2UgbW1fYWNjZXNzKCkgdG8gY2hl
Y2sgaWYgeW91IGhhdmUgcGVybWlzc2lvbnMgdG8gYWNjZXNzIHVzZXJmYXVsdGZkIChqdXN0DQo+
PiBsaWtlIHByb2NfbWVtX29wZW4oKSBkb2VzKS4gVGhpcyB3b3VsZCBiZSBtb3JlIGludHVpdGl2
ZSBmb3IgdXNlcnMgYXMgaXQgaXMNCj4+IHNpbWlsYXIgdG8gb3RoZXIgL3Byb2MvW3BpZF0vWCwg
YW5kIHdvdWxkIGNvdmVyIGJvdGggbG9jYWwgYW5kIHJlbW90ZQ0KPj4gdXNlLWNhc2VzLg0KPiAN
Cj4gQWgsIHNvIGFjdHVhbGx5IEkgZmluZCB0aGlzIGFyZ3VtZW50IG11Y2ggbW9yZSBjb21wZWxs
aW5nLg0KPiANCj4gSSBkb24ndCBmaW5kIGl0IHBlcnN1YXNpdmUgdGhhdCB3ZSBzaG91bGQgcHV0
IGl0IGluIC9wcm9jIGZvciB0aGUNCj4gcHVycG9zZSBvZiBzdXBwb3J0aW5nIGNyb3NzLXByb2Nl
c3MgbWVtb3J5IG1hbmlwdWxhdGlvbiwgYmVjYXVzZSBJDQo+IHRoaW5rIHRoZSBzeXNjYWxsIHdv
cmtzIGJldHRlciBmb3IgdGhhdCwgYW5kIGluIHRoYXQgY2FzZSB3ZSBkb24ndA0KPiBtaW5kIGRl
cGVuZGluZyBvbiBDQVBfU1lTX1BUUkFDRS4NCj4gDQo+IEJ1dCwgd2hhdCB5b3UndmUgYXJndWVk
IGhlcmUgSSBkbyBmaW5kIHBlcnN1YXNpdmUuIDopIFlvdSBhcmUgcmlnaHQsIEkNCj4gY2FuJ3Qg
dGhpbmsgb2YgYW55IG90aGVyIGV4YW1wbGUgb2YgYSBkZXZpY2Ugbm9kZSBpbiAvZGV2IHRoYXQg
d29ya3MNCj4gbGlrZSB0aGlzLCB3aGVyZSBpdCBpcyBjb21wbGV0ZWx5IGluZGVwZW5kZW50IG9u
IGEgcGVyLXByb2Nlc3MgYmFzaXMuDQo+IFRoZSBjbG9zZXN0IEkgY291bGQgY29tZSB1cCB3aXRo
IHdhcyAvZGV2L3plcm8gb3IgL2Rldi9udWxsIG9yDQo+IHNpbWlsYXIuIFlvdSB3b24ndCBhZmZl
Y3QgYW55IG90aGVyIHByb2Nlc3MgYnkgdG91Y2hpbmcgdGhlc2UsIGJ1dCBJDQo+IGRvbid0IHRo
aW5rIHRoZXNlIGFyZSBnb29kIGV4YW1wbGVzLg0KPiANCj4gSSdsbCBzZW5kIGEgdjUgd2hpY2gg
ZG9lcyB0aGlzLiBJIGRvIHdvcnJ5IHRoYXQgY3Jvc3MtcHJvY2VzcyBzdXBwb3J0DQo+IGlzIHBy
b2JhYmx5IGNvbXBsZXggdG8gZ2V0IHJpZ2h0LCBzbyBJIG1pZ2h0IGxlYXZlIHRoYXQgb3V0IGFu
ZCBvbmx5DQo+IGFsbG93IGEgcHJvY2VzcyB0byBvcGVuIGl0cyBvd24gZGV2aWNlIGZvciBub3cu
DQoNClNvIEkgZGlkbuKAmXQgd2FudCB0byBnZXQgaW50byBpdCwgYW5kIEkgYW0gZmluZSB0aGF0
IHlvdSBsZWF2ZSBpdCBvdXQsDQpzaW5jZSBzdWNoIGFuIGludGVyZmFjZSB3b3VsZCBzdGlsbCBl
bmFibGUgdG8gc3VwcG9ydCBpdCBsYXRlci4NCg0KQW55aG93LCBJIGRvIHdhbnQgdG8gY2xhcmlm
eSBhIGJpdCBhYm91dCB0aGUg4oCcY3Jvc3MtcHJvY2VzcyBzdXBwb3J04oCdDQp1c2VyZmF1bHRm
ZCBzaXR1YXRpb24uIEJhc2ljYWxseSwgeW91IGNhbiBhbHJlYWR5IGdldCBjcm9zcy1wcm9jZXNz
IHN1cHBvcnQNCnRvZGF5LCBieSB1c2luZyBjYWxsaW5nIHVzZXJmYXVsdGZkKCkgb24gdGhlIGNv
bnRyb2xsZWQgcHJvY2VzcyBhbmQgY2FsbGluZw0KcGlkZmRfb3BlbigpIGZyb20gYW5vdGhlciBw
cm9jZXNzLiBJdCBkb2VzIHdvcmsgYW5kIEkgZG8gbm90IHJlbWVtYmVyIGFueQ0KaXNzdWVzIHRo
YXQgaXQgaW50cm9kdWNlZCAoaW4gY29udHJhc3QsIGZvciBpbnN0YW5jZSwgdG8gaW8tdXJpbmcs
IHRoYXQNCndvdWxkIGJyZWFrIGlmIHlvdSB1c2UgdXNlcmZhdWx0ZmQraW91cmluZytmb3JrIHRv
ZGF5KS4NCg0KVGhhbmtzIGZvciB5b3VyIHJlY29uc2lkZXJhdGlvbi4NCg0KUmVnYXJkcywNCk5h
ZGF2
