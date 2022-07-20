Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91C357BFF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 00:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiGTWQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 18:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGTWQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:16:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1182E68C;
        Wed, 20 Jul 2022 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658355381; x=1689891381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hF31tvq7w/wkh8CLvUdILYwTITC/UNeHRN+WE78LYzo=;
  b=h+m+K44QGXHr/ChOZCBEejnEm60GQ0sI4i5zb32gfXUlnNr5L2Q+IDlr
   plvb4yWlj8RsG4d610AA6e697/89NZl6MbQy3B+lU3vfFhZJ3EnQnvA+o
   X/FvCDZ5ObzJqo0f+lvA6dlz++oQIORAjhkV/3684JuX/FBy1VR7t3mIv
   NMy3pyTC/3ip4nD39tDMZFV2NEo4/xwlaspKSf/r22pESCNLAQK8P8k7j
   hhrlsTC70mxhWOvrFrrL7EBuuhXwOEfEdUsCn562cNxxuZQ3YnHCIqZJ4
   tXI7J/HJf2HOjb2cm2f2t1v6yPWFbPvkaPvfc07PUrJ51xq3SqZqfejF5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="266672752"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="266672752"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 15:16:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="573487162"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2022 15:16:20 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 15:16:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 15:16:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 20 Jul 2022 15:16:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Jul 2022 15:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBnTX683zGu7fKA6ELFXYXNWagwXdi4rdtwku+is46E0u9Uel1Tx6Sf1lak7cV9u/b0/cEnO2STorT9FPasHQFQ934/cHhzNXq6iWh4lr2+sErc8X8zSAuFg3D7cBhk9zY42gVXI1lr/IZuNNXJS7QzyEU7lbohi4k8uyVP2FnL7/956SgjNsKzJZCDqqJB6T/T3mxyUiIsftNQ9xxNoZpQO7BXmZp8h1IUusJLZQvKGPiQko9zs/QOt6YAMx4+AJqnxtNRInHHQ31Q0kXuO8EGEgmu161NbtS8Z9gtZ63OiIB+N3bYdL1I4wtN2XvC1K34zKXGDiAKOhI+fOB4zlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF31tvq7w/wkh8CLvUdILYwTITC/UNeHRN+WE78LYzo=;
 b=Sg3/djuHJQPqZFsw/OqIT03ZEciUprUX3ZA2PIhUgWMxOi4E0swfbld2w4fiO7VZyASXX4wt4z5E4WOaBxXIAP+ECIIFitOf5VusQ/FwvozpNZYMrdueetu50qNhR9m0/e7K4BJVcjXVB3VnuKvt73UzKK/J4dJfrd2S4hKuvbSzo5lL0iwvQiHZ+EJrfYC32peQfqsqJT6UgDQZy1NXOZHyaODWcysLqUiY9x6NlLkiQ6gjkDanmCQ04UPuufQQHQMpv/CQ8p7n/kPeuDLwWITu4zUbJXXYrCOIQB8X17e8PQNIN/xFPJkDItZVHe0t48X8/zvKacK+j6CLLUgR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8)
 by DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Wed, 20 Jul 2022 22:16:15 +0000
Received: from PH7PR11MB6353.namprd11.prod.outlook.com
 ([fe80::fd5a:9383:ba83:bd0d]) by PH7PR11MB6353.namprd11.prod.outlook.com
 ([fe80::fd5a:9383:ba83:bd0d%4]) with mapi id 15.20.5417.023; Wed, 20 Jul 2022
 22:16:14 +0000
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Amit, Nadav" <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYm6myUVhfa/YKCEKYNr9shx4Vk62H1DbQ
Date:   Wed, 20 Jul 2022 22:16:14 +0000
Message-ID: <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
In-Reply-To: <20220719195628.3415852-1-axelrasmussen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1581d30-7585-4b0f-e688-08da6a9d75ff
x-ms-traffictypediagnostic: DM5PR11MB1435:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWJckn6Jj3At7INspc61De/eaVRjr118NvlHzCbM5hKdjkZoVGmEgkC01QXqSBeVdWTVvPmrLafZ5rwFsU5bsN0yHsEVDDLbWO/sIbLZHBQ7ZqkvcuqjyNTWP7pKEMGzkxTzy5TI7EWKOjgZWl6+3Ne4KLJdl8vCar+DeW39CAsvJBwnZx9jMfCMf/CkllYgoz0il7F9NtxUGoJDr+AEJ5yCXxtyge3iRuZVNCVQYTr9WRxQYs+C+NqSESqZXd7NXQPXj6zvsjHcWNyyvR3F7//VKA0lERhRobmD7as1kmUX5ixjfbIJOSv0hgGxqJoa1cCZJ+PRMhHS9DyDumWDS/Vs49moMmVx1ZqTGB6KLtlI+qIJmuH/pSHZZ/h/neafBNea6tIpXi5/x9S426O774AYq4kL+KhOfcdS9q9yti4z9tr0pJIASCEha4ZREf2Xh4pigrIABBOjdVs8/DPOWBOyggEgFw737v5IGKvdaIGiSYZpXn5ZJpbAwKmEuvTNlA9cgh/gUiaLO19/QsxTBTJrRLXdaooANDSsqCR2EQV6K22MGY04a/acR6y12NrRiGn5LXL5klTYF1StfFOktNZ06FpecYdoge0sLJvs+WOXtD2i0rgwUvup5CV1QNkR8rB0szndhNB/+LVz8hwzWSoy6gr8Ns/ALTuZh7PcJqoFYC7qLI66qPs6Z4eMBgw9t1zMaJ3tgkkBwNAuRb41TF5yygFj+9XR7EhGsUQ6PheANcf6Nao6xRtDqaQrvwjJz/YMGZExy3jJ9lN6Ox2O++my1KE1iQV9ob7Z+NVPaKnLC2+Y04Ti1qYZGDpaOGMKjtvZVDNyoexcp07oY0rlV/wrgBDcnK+38IAJDh5SrnA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6353.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(346002)(396003)(366004)(8676002)(122000001)(38070700005)(7696005)(83380400001)(55016003)(33656002)(66476007)(41300700001)(6506007)(66556008)(186003)(66946007)(9686003)(64756008)(2906002)(76116006)(26005)(4326008)(53546011)(66446008)(86362001)(52536014)(966005)(54906003)(316002)(110136005)(8936002)(5660300002)(921005)(71200400001)(478600001)(38100700002)(82960400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2ZYSXlEWHNzSFQxbzBwUkdWWmQyL3lOWWZnWEZ1a25yUmNUd1oySVVPeDdk?=
 =?utf-8?B?aFNyZFFhRHJxejA3T21ML3VJTlEzSk1vV1ZGWGlTeVd2ckZEYURTeWFFWTcx?=
 =?utf-8?B?M3hmZzVHM2RUak45M1VsRnlTVWR1VmkyUDlZTTVnNnZkM05kQzRKZTNFT3p1?=
 =?utf-8?B?WVpNS3lUQ3pDa1RVQ1ZBQTJteUVXVTNmd01GTVFhWjJlUnhDOENPcll1Z3E4?=
 =?utf-8?B?REROaEhqbU1JazNsQ25UUlVyK2tmRGV5dlJlNmNpT2IvTW1tc3EwUUZxMmVa?=
 =?utf-8?B?YmdLR0hpZHNVZEJNOUk4aUs0ejh0dW1ialFpWFgvd0IydFpFNUtKd3dnYklL?=
 =?utf-8?B?azNUK25TT0d1Uy9nMitkVG81OVc4QkFXQzhKTHZvUUJQd1hvR0piZEhXRjVH?=
 =?utf-8?B?YVk2K1E5QVJtOVhOQjNzV2J5SlkxalhSUHdLb1BobmhGMnhkUHZUbVQ1c1Bk?=
 =?utf-8?B?Vm9FQjlnMTVqd0p3RFhxVE0xOTU1cWNUS2ZPQlFsSXp3K1p1M29Xc0hGektT?=
 =?utf-8?B?VjU1Q2lOUGplbGJOREFsOXdPa3R2RW11NlNId1Y0MGw3QTQ1V2NkRW1CYnhh?=
 =?utf-8?B?ajFhaFhBT2doUFpRQ1BzRm9qMFJiWFdwbXk0VW43NFZ0RjJwWllZZjdJamZz?=
 =?utf-8?B?VkFUWld0QzQyREN4VlhSU3pnaUpxNUt0c0RPdURibjhmeUthTklYOXpQRXBi?=
 =?utf-8?B?RlI4UXBYck9JQXVwaXg2QnlGK3U5MU9jZVF2aERCaWhxWFZlbU9lMXAzTjlj?=
 =?utf-8?B?TWhEVGNLVW02Mmxhb3BpcXdmVzl6b2prZ2tFQThPVWNjSkx4SjNldHdtNHor?=
 =?utf-8?B?MVBIcXluYVh0dEFyRDhtUzhtUXU3TVQrRzNic2V2ZVlqNElBdnB6eWhuRysw?=
 =?utf-8?B?WlJ6VVRJaUk4Rml3dmVvRzdyemp4Wmdvd0hqMmRqM3RpWEJBcWpzTjZYdFc2?=
 =?utf-8?B?ZlJPWEJ1d20zbnU2bUoxL25sbXM0bEh2c05wenhUb2swMHdSaytMVDNYTDNz?=
 =?utf-8?B?bHp0SHVCcWs2QnliUzhFZUhmS3Z6RTNFUjlzbDhWY21Mc3N3cmxYd3g0MTB0?=
 =?utf-8?B?Q0NPTFNjR3lnaFQ3aEhBblNxQVVNcFFlRm5GYmF5WENKMHBiSHlDTWFTcENj?=
 =?utf-8?B?MDE4TndQYzFxTTFvUDhaZ3RmVEs0UHl0c0hZcGthVXZEN1BOdjVvUGpWSTJT?=
 =?utf-8?B?bUxKckJhWmdPRTRBbkxNMGVLN2FpNVdsVE13QWNMRzdxeS84eTl1VmpPQm1K?=
 =?utf-8?B?bmRnSjJhVDE1eEFmZWk1amVYODVYZHJVeFVDVnZmK0JiMUE1bWxvZHBUcVlW?=
 =?utf-8?B?Q2tBOXVuaENvcTVyTHBOb0E5b2tCQm5PM2ZLTXJyMzdOeE9YRGtrenJES1Np?=
 =?utf-8?B?aFgvNlpsNjJkc3Rwa1JtREdQNFg2bjc1WGNqa0c0UXlxaS9DUEJVN1Jkc3I2?=
 =?utf-8?B?Sm40MWQ2VENoZ0JJZVQrT0tnZFFjWldFLzNxWGFZZDFjS2hVdEpXWDhjZFdl?=
 =?utf-8?B?ZUJaVVJYVmxjMi95bGlJNmdqcEFNK0R5SllhQm1oNkEzRUFxZk9QNE5qcTJn?=
 =?utf-8?B?T1o0Qk9MeThaM0FXeW9hTWNMRVVTOWdXb3dzK20zWEpFOUVGT3FQeGJzR3RQ?=
 =?utf-8?B?SC9SU0V2UlB3Z1ljNzJOWTI3bjNqYndDSmdMazZ1d0p6UlRWeUxONjVrMzYz?=
 =?utf-8?B?V2tjeTF6aWdBY0x1Qy9nQnBGRmdsM2t4bWwrWWJUNnczZTZqeFYvSkV6MmVz?=
 =?utf-8?B?eVBaSlExeWtoOWpWcnJYSUl3ZGhqSGoyeFlMOTdXb0tDUkpNT2RKRWFPOGJm?=
 =?utf-8?B?dGRSTGU1ajJiYUxtajJPdGh0WDZQVkprS2c2Ui9uRVdJWFBkbzd2RFBiMjR6?=
 =?utf-8?B?cG9COCt2ZGJtc2ROWDQ1QUVHdng0RmJvdE05T0hIYjZsV0REUEdaY0lpMmFQ?=
 =?utf-8?B?ckY1dGZHRmd5aXRRbHJLUVRydzFxNmlNOUF1RTB0ZWZqZmxrU1JGZ2QxVk91?=
 =?utf-8?B?eVhucnJ3dkIwd2JIcXRzemJERnREZWFWclNWc3h6c05WYk13ZkNpVWo4eUVm?=
 =?utf-8?B?amY4Z3hMVW8rSWZZUnRxcmpXYW5CcEdEQTNvS1Z4cGFKRDRZUWFFNExMZ1RZ?=
 =?utf-8?Q?jF8XcYfZpn2pHdkLW5WMWl0x3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6353.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1581d30-7585-4b0f-e688-08da6a9d75ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 22:16:14.7836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJ9gsmlymoK25Bx/+DmKPr6BWeySkrvTVNll1HR4LSKaKPzxC2GuKCXQpES2BL9Yw0TyygRwiln1NNNoGoTzl2j5hc065aUYtrQ3jwpaECM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBeGVsIFJhc211c3NlbiA8YXhl
bHJhc211c3NlbkBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDE5LCAyMDIyIDEy
OjU2IFBNDQo+IFRvOiBBbGV4YW5kZXIgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+OyBB
bmRyZXcgTW9ydG9uDQo+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgRGF2ZSBIYW5zZW4N
Cj4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IERtaXRyeSBWIC4gTGV2aW4gPGxkdkBh
bHRsaW51eC5vcmc+OyBHbGViDQo+IEZvdGVuZ2F1ZXItTWFsaW5vdnNraXkgPGdsZWJmbUBhbHRs
aW51eC5vcmc+OyBIdWdoIERpY2tpbnMNCj4gPGh1Z2hkQGdvb2dsZS5jb20+OyBKYW4gS2FyYSA8
amFja0BzdXNlLmN6PjsgSm9uYXRoYW4gQ29yYmV0DQo+IDxjb3JiZXRAbHduLm5ldD47IE1lbCBH
b3JtYW4gPG1nb3JtYW5AdGVjaHNpbmd1bGFyaXR5Lm5ldD47IE1pa2UNCj4gS3JhdmV0eiA8bWlr
ZS5rcmF2ZXR6QG9yYWNsZS5jb20+OyBNaWtlIFJhcG9wb3J0IDxycHB0QGtlcm5lbC5vcmc+Ow0K
PiBBbWl0LCBOYWRhdiA8bmFtaXRAdm13YXJlLmNvbT47IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT47DQo+IFNodWFoIEtoYW4gPHNodWFoQGtlcm5lbC5vcmc+OyBTdXJlbiBCYWdoZGFzYXJ5
YW4NCj4gPHN1cmVuYkBnb29nbGUuY29tPjsgVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5j
ej47IHpoYW5neWkNCj4gPHlpLnpoYW5nQGh1YXdlaS5jb20+DQo+IENjOiBBeGVsIFJhc211c3Nl
biA8YXhlbHJhc211c3NlbkBnb29nbGUuY29tPjsgbGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC0NCj4ga3NlbGZ0ZXN0QHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMC81XSB1c2VyZmF1bHRmZDogYWRkIC9k
ZXYvdXNlcmZhdWx0ZmQgZm9yIGZpbmUgZ3JhaW5lZA0KPiBhY2Nlc3MgY29udHJvbA0KDQpJIGFz
c3VtZSB0aGF0IGxlYXZpbmcgdGhlIExTTSBtYWlsaW5nIGxpc3Qgb2ZmIG9mIHRoZSBDQyBpcyBw
dXJlbHkNCmFjY2lkZW50YWwuIFBsZWFzZSwgcGxlYXNlIGluY2x1ZGUgdXMgaW4gdGhlIG5leHQg
cm91bmQuDQoNCj4gDQo+IFRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIHRvcnZhbGRzL21hc3Rlci4N
Cj4gDQo+IFRoZSBzZXJpZXMgaXMgc3BsaXQgdXAgbGlrZSBzbzoNCj4gLSBQYXRjaCAxIGlzIGEg
c2ltcGxlIGZpeHVwIHdoaWNoIHdlIHNob3VsZCB0YWtlIGluIGFueSBjYXNlIChldmVuIGJ5IGl0
c2VsZikuDQo+IC0gUGF0Y2hlcyAyLTYgYWRkIHRoZSBmZWF0dXJlLCBjb25maWd1cmFibGUgc2Vs
ZnRlc3Qgc3VwcG9ydCwgYW5kIGRvY3MuDQo+IA0KPiBXaHkgbm90IC4uLj8NCj4gPT09PT09PT09
PT09DQo+IA0KPiAtIFdoeSBub3QgL3Byb2MvW3BpZF0vdXNlcmZhdWx0ZmQ/IFRoZSBwcm9wb3Nl
ZCB1c2UgY2FzZSBmb3IgdGhpcyBpcyBmb3Igb25lDQo+ICAgcHJvY2VzcyB0byBvcGVuIGEgdXNl
cmZhdWx0ZmQgd2hpY2ggY2FuIGludGVyY2VwdCBhbm90aGVyIHByb2Nlc3MnIHBhZ2UNCj4gICBm
YXVsdHMuIFRoaXMgc2VlbXMgdG8gbWUgbGlrZSBleGFjdGx5IHdoYXQgQ0FQX1NZU19QVFJBQ0Ug
aXMgZm9yLCB0aG91Z2gsDQo+IHNvIEkNCj4gICB0aGluayB0aGlzIHVzZSBjYXNlIGNhbiBzaW1w
bHkgdXNlIGEgc3lzY2FsbCB3aXRob3V0IHRoZSBwb3dlcnMNCj4gQ0FQX1NZU19QVFJBQ0UNCj4g
ICBncmFudHMgYmVpbmcgInRvbyBtdWNoIi4NCj4gDQo+IC0gV2h5IG5vdCB1c2UgYSBzeXNjYWxs
PyBBY2Nlc3MgdG8gc3lzY2FsbHMgaXMgZ2VuZXJhbGx5IGNvbnRyb2xsZWQgYnkNCj4gICBjYXBh
YmlsaXRpZXMuIFdlIGRvbid0IGhhdmUgYSBjYXBhYmlsaXR5IHdoaWNoIGlzIHVzZWQgZm9yIHVz
ZXJmYXVsdGZkIGFjY2Vzcw0KPiAgIHdpdGhvdXQgYWxzbyBncmFudGluZyBtb3JlIC8gb3RoZXIg
cGVybWlzc2lvbnMgYXMgd2VsbCwgYW5kIGFkZGluZyBhIG5ldw0KPiAgIGNhcGFiaWxpdHkgd2Fz
IHJlamVjdGVkIFsxXS4NCj4gDQo+ICAgICAtIEl0J3MgcG9zc2libGUgYSBMU00gY291bGQgYmUg
dXNlZCB0byBjb250cm9sIGFjY2VzcyBpbnN0ZWFkLiBJIHN1c3BlY3QNCj4gICAgICAgYWRkaW5n
IGEgYnJhbmQgbmV3IG9uZSBqdXN0IGZvciB0aGlzIHdvdWxkIGJlIHJlamVjdGVkLA0KDQpZb3Ug
d29uJ3Qga25vdyBpZiB5b3UgZG9uJ3QgYXNrLg0KDQo+ICAgICAgIGJ1dCBJIHRoaW5rIHNvbWUN
Cj4gICAgICAgZXhpc3Rpbmcgb25lcyBsaWtlIFNFTGludXggY2FuIGJlIHVzZWQgdG8gZmlsdGVy
IHN5c2NhbGwgYWNjZXNzLiBFbmFibGluZw0KPiAgICAgICBTRUxpbnV4IGZvciBsYXJnZSBwcm9k
dWN0aW9uIGRlcGxveW1lbnRzIHdoaWNoIGRvbid0IGFscmVhZHkgdXNlIGl0IGlzDQo+ICAgICAg
IGxpa2VseSB0byBiZSBhIGh1Z2UgdW5kZXJ0YWtpbmcgdGhvdWdoLCBhbmQgSSBkb24ndCB0aGlu
ayB0aGlzIHVzZSBjYXNlIGJ5DQo+ICAgICAgIGl0c2VsZiBpcyBlbm91Z2ggdG8gbW90aXZhdGUg
dGhhdCBraW5kIG9mIGFyY2hpdGVjdHVyYWwgY2hhbmdlLg0KPiANCj4gQ2hhbmdlbG9nDQo+ID09
PT09PT09PQ0KPiANCj4gdjMtPnY0Og0KPiAgIC0gUGlja2VkIHVwIGFuIEFja2VkLWJ5IG9uIDUv
NS4NCj4gICAtIFVwZGF0ZWQgY292ZXIgbGV0dGVyIHRvIGNvdmVyICJ3aHkgbm90IC4uLiIuDQo+
ICAgLSBSZWZhY3RvcmVkIHVzZXJmYXVsdGZkX2FsbG93ZWQoKSBpbnRvIHVzZXJmYXVsdGZkX3N5
c2NhbGxfYWxsb3dlZCgpLg0KPiBbUGV0ZXJdDQo+ICAgLSBSZW1vdmVkIG9ic29sZXRlIGNvbW1l
bnQgZnJvbSBhIHByZXZpb3VzIHZlcnNpb24uIFtQZXRlcl0NCj4gICAtIFJlZmFjdG9yZWQgdXNl
cmZhdWx0ZmRfb3BlbigpIGluIHNlbGZ0ZXN0LiBbUGV0ZXJdDQo+ICAgLSBSZXdvcmRlZCBhZG1p
bi1ndWlkZSBkb2N1bWVudGF0aW9uLiBbTWlrZSwgUGV0ZXJdDQo+ICAgLSBTcXVhc2hlZCAyIGNv
bW1pdHMgYWRkaW5nIC9kZXYvdXNlcmZhdWx0ZmQgdG8gc2VsZnRlc3QgYW5kIG1ha2luZw0KPiBz
ZWxmdGVzdA0KPiAgICAgY29uZmlndXJhYmxlLiBbUGV0ZXJdDQo+ICAgLSBBZGRlZCAic3lzY2Fs
bCIgdGVzdCBtb2RpZmllciAodGhlIGRlZmF1bHQgYmVoYXZpb3IpIHRvIHNlbGZ0ZXN0LiBbUGV0
ZXJdDQo+IA0KPiB2Mi0+djM6DQo+ICAgLSBSZWJhc2VkIG9udG8gbGludXgtbmV4dC9ha3BtLWJh
c2UsIGluIG9yZGVyIHRvIGJlIGJhc2VkIG9uIHRvcCBvZiB0aGUNCj4gICAgIHJ1bl92bXRlc3Rz
LnNoIHJlZmFjdG9yIHdoaWNoIHdhcyBtZXJnZWQgcHJldmlvdXNseS4NCj4gICAtIFBpY2tlZCB1
cCBzb21lIFJldmlld2VkLWJ5J3MuDQo+ICAgLSBGaXhlZCBpb2N0bCBkZWZpbml0aW9uIChfSU8g
aW5zdGVhZCBvZiBfSU9XUiksIGFuZCBzdG9wcGVkIHVzaW5nDQo+ICAgICBjb21wYXRfcHRyX2lv
Y3RsIHNpbmNlIGl0IGlzIHVubmVlZGVkIGZvciBpb2N0bHMgd2hpY2ggZG9uJ3QgdGFrZSBhIHBv
aW50ZXIuDQo+ICAgLSBSZW1vdmVkIHRoZSAiaGFuZGxlX2tlcm5lbF9mYXVsdHMiIGJvb2wsIHNp
bXBsaWZ5aW5nIHRoZSBjb2RlLiBUaGUgcmVzdWx0DQo+IGlzDQo+ICAgICBsb2dpY2FsbHkgZXF1
aXZhbGVudCwgYnV0IHNpbXBsZXIuDQo+ICAgLSBGaXhlZCB1c2VyZmF1bHRmZCBzZWxmdGVzdCBz
byBpdCByZXR1cm5zIEtTRlRfU0tJUCBhcHByb3ByaWF0ZWx5Lg0KPiAgIC0gUmV3b3JkZWQgZG9j
dW1lbnRhdGlvbiBwZXIgU2h1YWgncyBmZWVkYmFjayBvbiB2Mi4NCj4gICAtIEltcHJvdmVkIGV4
YW1wbGUgdXNhZ2UgZm9yIHVzZXJmYXVsdGZkIHNlbGZ0ZXN0Lg0KPiANCj4gdjEtPnYyOg0KPiAg
IC0gQWRkIGRvY3VtZW50YXRpb24gdXBkYXRlLg0KPiAgIC0gVGVzdCAqYm90aCogdXNlcmZhdWx0
ZmQoMikgYW5kIC9kZXYvdXNlcmZhdWx0ZmQgdmlhIHRoZSBzZWxmdGVzdC4NCj4gDQo+IFsxXTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82ODYyNzZiOS00NTMwLTIwNDUtNmJkOC0NCj4g
MTcwZTU5NDNhYmU0QHNjaGF1Zmxlci1jYS5jb20vVC8NCj4gDQo+IEF4ZWwgUmFzbXVzc2VuICg1
KToNCj4gICBzZWxmdGVzdHM6IHZtOiBhZGQgaHVnZXRsYl9zaGFyZWQgdXNlcmZhdWx0ZmQgdGVz
dCB0byBydW5fdm10ZXN0cy5zaA0KPiAgIHVzZXJmYXVsdGZkOiBhZGQgL2Rldi91c2VyZmF1bHRm
ZCBmb3IgZmluZSBncmFpbmVkIGFjY2VzcyBjb250cm9sDQo+ICAgdXNlcmZhdWx0ZmQ6IHNlbGZ0
ZXN0czogbW9kaWZ5IHNlbGZ0ZXN0IHRvIHVzZSAvZGV2L3VzZXJmYXVsdGZkDQo+ICAgdXNlcmZh
dWx0ZmQ6IHVwZGF0ZSBkb2N1bWVudGF0aW9uIHRvIGRlc2NyaWJlIC9kZXYvdXNlcmZhdWx0ZmQN
Cj4gICBzZWxmdGVzdHM6IHZtOiBhZGQgL2Rldi91c2VyZmF1bHRmZCB0ZXN0IGNhc2VzIHRvIHJ1
bl92bXRlc3RzLnNoDQo+IA0KPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS91c2VyZmF1
bHRmZC5yc3QgfCA0MSArKysrKysrKysrKy0NCj4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUv
c3lzY3RsL3ZtLnJzdCAgICAgIHwgIDMgKw0KPiAgZnMvdXNlcmZhdWx0ZmQuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCA2OSArKysrKysrKysrKysrKysrLS0tLQ0KPiAgaW5jbHVkZS91
YXBpL2xpbnV4L3VzZXJmYXVsdGZkLmggICAgICAgICAgICAgfCAgNCArKw0KPiAgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdm0vcnVuX3ZtdGVzdHMuc2ggICAgfCAxMSArKystDQo+ICB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy92bS91c2VyZmF1bHRmZC5jICAgICB8IDY5ICsrKysrKysrKysrKysr
KysrLS0tDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDE2OSBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlv
bnMoLSkNCj4gDQo+IC0tDQo+IDIuMzcuMC4xNzAuZzQ0NGQxZWFiZDAtZ29vZw0KDQo=
