Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41304DA8DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 04:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbiCPDYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 23:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348399AbiCPDYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:24:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079FC273A;
        Tue, 15 Mar 2022 20:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvXHRmE1rQ+STLXVvRsqhg5Q/iCUNKCqZvOYZx4YMPDvhVgM0qnxrSUqViPq8lsF09h6mfykZ3errSAdJcOb0WjgDR26Qca+CMsuEo+VcUDtme9TBjzGNVQWySuzl2BFXcC5P2W/l4SZdI/hVS1OllPAi0HVUmYJ3Tu/qNNxVsiD0oPHyuSKS05VaXx4RMY+2zQ23Uc5L6udai3loJnMXtMQSQbAVQzf9gNxhmvUEah5pS161dSPksdxPUx0X+hA625Sx6q7s8XUrZGWTryS3Mcb37N0X+w2fitq0ZB1IW91winhdA2WkAd8T1ClEgtloH9tBsAe8n7iX0Q6P96BMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9ij71SPbmyauFY/HynOvRiy4ay+81z7gM/9+EmlARU=;
 b=A75lVcSbhGflHbmDF/JWBStHJJV7vM52QeullLL8KKIbIHFLFZDmgQ4T5Oe/H/75Rh61Fp5WZUUhwI2PyG38QaUIBEdi3XBBRof0Jxdl/3IK7JdDsMlrz1UY3pYnVVgyJkT8SOLcodIKW933ny6mFjOjIEK3kOmDG2viDJYgATfDlcqyB3Mif2w2drRlUAvcGiAH2SetO0kFZewV/E1VIbMDu2LystG0JZfrW/f436hz1dYXRpI4A3BmOk6ghKvUtDRuWFp5rOOt0Ks3J98Cxh2i4kvALW9ffQ9oVS01F1FwRobOQqwGrrBlJUVn9MmSk8ANSZ2psLtUNTBv8zlSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9ij71SPbmyauFY/HynOvRiy4ay+81z7gM/9+EmlARU=;
 b=QDgZJF53RlN64SO4WKnLP1afoiPWjSDRGTSMEIrqSDtZPjn7cBUg3gh8rZuKstfVnovIKdob0a+1kVo6iS6g+K91mTNRSq7cLoUp2UJNawLHzb4LCmIhU1i52kF8QFuKSBXih+8fTBu2u4EW0wehRicxfOCkAxdC1fbyXPlpVMw2B+v6IfycbNfEtCwGnFY4Ty+T4ENGIbkibfUUXFyKwbqj10ePW3hoQhcRjRINkuR42Hjwq4yL57JybH8Y2CuS6tePrqPRiC4zpe6gcHDoWcDBcrb65oIqeCyjjCiYYf0t9xisNvfHqi8coCfUJXJCxhGA7AzHTSKaJtE0vKOx6Q==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 03:23:08 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::f8dd:8669:b6e0:8433]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::f8dd:8669:b6e0:8433%4]) with mapi id 15.20.5061.026; Wed, 16 Mar 2022
 03:23:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] mm: proc: remove redundant page validation of pte_page
Thread-Topic: [PATCH] mm: proc: remove redundant page validation of pte_page
Thread-Index: AQHYOOHt6TqlLzdogUet5xik3GPOmqzBWIuA
Date:   Wed, 16 Mar 2022 03:23:07 +0000
Message-ID: <9432db52-e9a5-be3f-ceb7-36ac8c5bed25@nvidia.com>
References: <20220316025947.328276-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220316025947.328276-1-xianting.tian@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e202dea2-1dd8-4b46-684c-08da06fc4ab4
x-ms-traffictypediagnostic: BY5PR12MB5016:EE_
x-microsoft-antispam-prvs: <BY5PR12MB50162DEBEF0B187E42B9BB84A3119@BY5PR12MB5016.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwpcWKzdZ5j5Zj9LEaE4KeJN1XuraAebfWRc5KgGCvbF/SJxFGDMt1GASObO1s0J9ckXD1i/Sch/9ygqtG4Vq29CqOzy3UtvIw1OFnns07fi8Ctk8xIP2za+sexFF40TwfUjnGLabFCu/cOaD3uNNadyEREaNLpojzsPSBD36CDhB5PWSgAKX+95OwWC2L69yFNtQ7r9is2Bz1q00oZ/5W2jFSKj7NnElJuKfw79vv47j5+j/B627UtCRIk4Jaej8i4/52KrmjC5OWg0vu4Rd0HFfVZNtw99tEY/buKRJVobB6XY6OINUmjcV3el8dYxx4c+hRTS76rulifLg6xLjB9uAmSji3fuAwbusrnoqz5QEAjOYvTdiuTEChCCEMt2AAKqpd5g83jn1BBW1bnWderxIgOvdAv78uWnQ50y9RKAScPhVsEoR+2ESCDVvRmnRb9FsE84hAKL1ZO4rSXxRE3wmZR8gS5JNCRmpPbRg51lTip1kSGtOi0K2G7GIV8saGlgKh/dhzv4VbthGFRdKYQ9gOCv4mQrTsLJMV0RsjdcY88oxQxiB7CHZpNupQ9tDdbCRAyr5tE05WVv8/ofxQAo/fhBJtep30bwGDqHvFdYLj8esOJ0Ra5QJJ4UatIfq1bfPb2nfGF2Ent/FQvt53W/ZiJR0URKlVszjwwHkvt/TY1J86pDDLn1RJRtKMfxEgjwuATAIL45uqQRJCSjerzXSJjR/WvXn9LKNnOWLBi2CJi8LnmWvbizALwQ/NkDlYKpqS8V0v0ygZ5wyHsY5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(38070700005)(31696002)(186003)(2616005)(558084003)(53546011)(86362001)(6512007)(6506007)(8936002)(5660300002)(71200400001)(2906002)(316002)(54906003)(110136005)(66476007)(66556008)(66946007)(66446008)(76116006)(91956017)(64756008)(4326008)(8676002)(31686004)(6486002)(38100700002)(122000001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpNekNqMkNJb3k1bVZta2hPWUFDUUk3TlJUYzNqUGtVTVBYRStES0NhY3Zl?=
 =?utf-8?B?VDhpbm4vOWRzakZ2VDJOb3VGVGxvMU9FU1ljR1VDSEVUS3FBOWxYY0FLZi80?=
 =?utf-8?B?R2VYRGd3WndnY21TTEF2dWR4a3ZKcHJaenpRVzJSTnBrQWRqVFFOdlRZbWNx?=
 =?utf-8?B?NkN5OC9xRTJmcngxdm0vNGFVRlBmUkhhN3duYmJKbDl4SmtRcG9KRndLRFJS?=
 =?utf-8?B?R1B1dDZaVDBPalZYM0hoZGJCZStoK1JiYXkraSs5RTU4M1NHaU5TbWJKSFVw?=
 =?utf-8?B?Wm5IQm9YTGtUbTU2Q3lPTmtzTXFZWVFVOENObWNVT0RPdVM3Rkl2MS8rNGhO?=
 =?utf-8?B?cDBQeklZT0NkRzdwcFF6RENGeFBHTDNTVWR3RlU4ZUM3MlIwV2RKRGtXYkFV?=
 =?utf-8?B?c20wcm5LcjY0RlJFcDFxVzd5WlBwL2ZJV2pkV0hxSlhGbGpEUzFnd3FxYmlE?=
 =?utf-8?B?cTV5R3Q1VHZpc2NkYXV3MFB4NjQwS1J2WjNvOFFCVVNCWVFrelFxaXI2ek0x?=
 =?utf-8?B?aDZTN2VUR0FlbW9yNlVTY0tjaHJnTEdEWG9oOEZYdElkclMwQXRaUDViMVQ3?=
 =?utf-8?B?bXNuMCs2Q0hYSHQyZk03NUxPby9iZU5EdVczY1lBRUxJL3pKWDdEOHlibkc3?=
 =?utf-8?B?cm13YjNXd1cvZ3RXM2JhRGpvVkxPUDNncytyQ1hKcFhoVjBLMmVFSUQydDY1?=
 =?utf-8?B?d0lHZEFVdDJ0UzJPOFdtZjJpR2JvKzFDVzgxUWUxME9iTHFzaElucmMwaTZL?=
 =?utf-8?B?ZTlBTmVnSVpIRUxYdWpiZUFDV1o1VkxaM1B3S2tNWXV5NVE2amhFdlN0UUFz?=
 =?utf-8?B?cXZRczR4RUFDSGRMTTlGb0lKczNlY09Dald1S3FFWk91S09TM0ZjVFpGZzlt?=
 =?utf-8?B?ci9zR2E2dTdqaUYra0N4OEtMRXY0ekVtT05SWnhDM1pyVzJtVWhXekhvakk0?=
 =?utf-8?B?a2RWMnlGbmRYNUVvdGc4TFVIb0Z1bW1kM2xnWCszV1Vwb0ZZUHpjeENSRTRJ?=
 =?utf-8?B?R1QrYlViNDVwM3RJeW9VTEYrOUxiOGlPb1Y3ZGUva0NyVTl5b2I4MHV3cWRt?=
 =?utf-8?B?RjExdmVyVmxsYWU0eDNydFJERzdXMHhFYnNqRFZzNWpiSjlwaU9jM2VuTFFG?=
 =?utf-8?B?ZklZVGdESGxleTRsdDRta1VJNTFwRGwrcThiT3hTcjU5U0dJOE5nVnZRUmIx?=
 =?utf-8?B?bVhVQXc2S1BaaVllZ3d2UlF5ZGxZeEdxdW9KZkpXdmhKeSthaEVhNmpJcnpq?=
 =?utf-8?B?OTN3V2F0N1RvN3hPa0Y5V1E1Sjh2NFNMQndka0RHd2R1TXNFRy9nSk9TR1NS?=
 =?utf-8?B?MU84STluK2NOVXQyeWxqQjZIRFZka3V3bmtzZ1gzbkJ2L2V4djhPVE1xbTNi?=
 =?utf-8?B?R2N1RzhVL0ozeUllWDk5aE1XRnVTckp4STNBenJkZENmM2RqSmRKRXFMNngy?=
 =?utf-8?B?TDdiNVY4Z0UrMzg4WUU1ZjRQeFlRcGdIRlNvL2VPQS95dmJRcFRIeFpqMjR5?=
 =?utf-8?B?d0lFWHc3Tll0aHgzQy9aMzd0K2VETTY1eFEwK3E2cGhxcGlzZXAvQm5yOG9l?=
 =?utf-8?B?MkN5eTF2ODNzbWkvQmwxYWttL2FHY3VCRzhGczlkL1JSNmtyM21ONDl6OW8y?=
 =?utf-8?B?SEFHcXg1Q3hsWmEyTS9vN3FqMWlWWjR2OWdBQTVTN0hZQjE2dmNOYmE0VWZI?=
 =?utf-8?B?RGFwMFNTSUEzU0JHTytuVFRNWFRWSEtRZ0QwSVhTcmxFWkx0aGdZb1JjT2wz?=
 =?utf-8?B?bXZsWGdQdks1M3lXR0UyZ2tsTVBmZE5GRmR4NTVXZnViTHhKamtjcmhTMVh5?=
 =?utf-8?B?MnNKS0VZMTBVYlNJVXhVL2RTT3RMTHV2d1dyRDRWeWRMbFlUTVVBdkhSNW9F?=
 =?utf-8?B?TmFNcHZvMVRrby9kUm80dThORVBROGVlS2NmalR5ajBMandlZFcrdi96clhz?=
 =?utf-8?B?eWdsQVRkNTl0cFB1UkZGWFN1cy80blY5YUVKSnF6YndhdlRjczg3ajdRd1lm?=
 =?utf-8?B?R3hCUEc3UmNxSGlUNFZtVVQ4aU1SM1lOZnE0Nk1xbXZPL1lYNUFVMlVmTG1G?=
 =?utf-8?Q?SMIhe4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4E1E2654BB9554090FD239CCFFE529F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e202dea2-1dd8-4b46-684c-08da06fc4ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 03:23:08.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72VEw7q0UHUxh57HujB/u89UOYNszFBZKMbs4bFPuAoYsNVVo5xTMZFgsVnUkdS1RTZpD6WhIqBh+XH5KBu9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8xNS8yMiAxOTo1OSwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gcHRlX3BhZ2UoKSBhbHdh
eXMgcmV0dXJucyBhIHZhbGlkIHBhZ2UsIHNvIHJlbW92ZSB0aGUgcmVkdW5kYW50DQo+IHBhZ2Ug
dmFsaWRhdGlvbiwgYXMgd2UgZGlkIGluIG1hbnkgb3RoZXIgcGxhY2VzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbT4N
Cj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
