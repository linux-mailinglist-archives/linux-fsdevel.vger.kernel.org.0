Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7467E57C0CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 01:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiGTXVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 19:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiGTXVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:21:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1761D42AEF;
        Wed, 20 Jul 2022 16:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG9lJs6pYy1O45NLWEGj8Zt9U4MTso87LflEAmvs8dwWqo8NHHPMYT8t+a8FDuqOfcPCvkO6z4MJADmUk39Fnl0uw0cVHJVTJqL5B4S9m2K1wjPUkuwO2e1N6H1U004URg0d8XbO5keIxlzcO7+6ir/YV9IqrIJrnvgWCr7CP5VTkyC2Tu9MumFCrmPXSSTh7/MuEBDKP5TM2iui7ecMs9LUHds1y1MeEXBmjg1CtRgAuqSQQWIcKnwJik3n+b0qs+WTthI4cKzOVxplqyL1WlaGuWowwoyS8baTdl71kZiHoyGl+z8MlujW5lgWbL197u13g6xOd71bhYJjmgfzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eSNUzjDZlOwPej5fO+Jc+LCZWJp/sielUzVQaiHho8=;
 b=ZtEKTx8G9Ikm6TFtKexrci1Xb7wjMurW4HvbM4i9zj3lI8SRYDYPt4vg/Kc376JM2KzyB03Frz5mNYq8kCqkdVhyT9BivJvhBcRc5xFSMdllLLUIefmb6cTdOjRynENU6/4f2AErAitXbP4nYBsAL8jQ8rT6jH9EY9IdYW6u2grO1FiLgmAKk/DYFw6zfS/XMqIWpHsHglrDhANvV5Vjw9kxFQKoNzWCylv3eSPdNz8mWjtN33h1AfoabpPqIgBAKS11ObT1ecObxjz8CRyvw6FJA1MYkgddGmhl4FzXBRUUBOe5+kPrPOGi9tTuu1ZXiEmXuIyvxq9kRQSfE8nq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eSNUzjDZlOwPej5fO+Jc+LCZWJp/sielUzVQaiHho8=;
 b=VsJc/INI40eNN94heoCSYe0zBTeM1OPt+oXXsCuqXYvUNO3T7JieU45F4HhPdUYWYsQ5vlrBF038AmuA92KWZG0LOu8ylvN8cULQjcrlkdrBTa63GLep8flBpBXZupQlUCQ0pu+vF318YeWtNykSTmqhEKcQpOrjM8INKmNJ99M=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CY5PR05MB9045.namprd05.prod.outlook.com (2603:10b6:930:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.10; Wed, 20 Jul
 2022 23:21:27 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 23:21:20 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYm6moVvUxeU2aLUSjhWg4PqcU4q2H1VIAgAANjICAAASjgA==
Date:   Wed, 20 Jul 2022 23:21:20 +0000
Message-ID: <7EF50BE4-84EA-4D57-B58C-6697F1B74904@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
 <CAJHvVchusMjvhLxYkWpa+iTaHvXYPFHcX7JGP=bW60e_O1jFGA@mail.gmail.com>
In-Reply-To: <CAJHvVchusMjvhLxYkWpa+iTaHvXYPFHcX7JGP=bW60e_O1jFGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7dcd167-a8fc-4885-e134-08da6aa68e2c
x-ms-traffictypediagnostic: CY5PR05MB9045:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ss+9QZfi9tMEYG/IX+MCrisxOV1gDviF54q7E3CcWfR8PBrG6csexXadS9NIMko+bg+whEdrnq/xO7m6gfTavO5Vx2fFY6M5UchXnmng9i769jjPArAaWKMhggeBVbpwPLglwdPFhIhjoOzp12GPtX0e+lS2CaWXUuiZyGB+JIUmj7HomR4mFUNrOtCx6UKcm4YrSnZZMAzJJ+oRhODhYs3INAY3BoCM9NFfUA85Jazvj+gO6rcfS4+8V3/ulWzb98Mu8Vm2bj3osmpOPtY0tJdUXIotyfPhF94+qYpvJd/h9Qw2ru2OcOVu2FgcM8ubE56oJHoRz5DZxTkzOEFvkOJ2SkYqUV0YnLqfSg6TemkW0Z4JXiLAAo98X/l2VLA4JwAayhHHHT3NeVUGvwNL7Q2D3+YYjlllIrRAehDfJp7qBr9y9oUWZIH4XqYd8MwkM9UO4mYLaR8N51ILccqdyQwkN4ztWYlEXYLu2dQeDsFYxno4cANZcxOCiN25hCjkY6W0L9dC4dLsz3HHgmYkEWBpPaHg2PsxGsDpAKtyuuJDLndZXCBGfqHLrEuWjCbtifh03RJ2RuZaT9bbijqAQzR46k0txuFnzOAEJ2o8TOHbrr3HhaEZO+n+078SKL1XVgh9L1K6DILYb+BcabzH5o/tWh6F4C9kMWzPJIHj7wstKjY4rFLOF+DBZHpjH7rf+F9wWwwM3ts31oeylNtJ0WhR6w/5Y0Of4HybLKs1ji/7NLGdO82OjDmfcPX8hy/d8a0vJnN3chBTQveF+Dpb6wexWBWJ5c214yDk1Tf2KTX8/zEXdKYuntkpz/zaWSJyy6V04KobB8PJjV33tFjNLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(2616005)(6916009)(4326008)(8676002)(7416002)(66446008)(38100700002)(122000001)(316002)(33656002)(36756003)(54906003)(86362001)(5660300002)(186003)(478600001)(2906002)(41300700001)(8936002)(76116006)(6512007)(66556008)(26005)(6486002)(64756008)(66946007)(83380400001)(6506007)(53546011)(38070700005)(71200400001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1RJTkJOMnQ5QVp1U2dXMXJUUGZYbGZBVXgybWwyWC80QTV3cG9BMDN3L3RG?=
 =?utf-8?B?eVB0YTIraGZFUisxc2J1RFBqckNZakNwb2hmVk5GV1ZKZ1d0YTE5dE0wRWV4?=
 =?utf-8?B?cXY3RE1yek1XTnZ2eDZIL0FzeG92bEpTb1liTXIyTXkwT2dQZWtNNStxSjZ2?=
 =?utf-8?B?NytmcnBMRXE4dzErRWNCL3B6ZmQyaGJuNjBybmJOUFJwcUZ5MlQ4eTBKM0g5?=
 =?utf-8?B?UjhRNFhXTTNvSmlTRTlBT0RJNFZpZ1F1M1diYjUvdEFoSkk2WFJtcEJwSnhB?=
 =?utf-8?B?ZGo5R3RqMUR1aFBOZzZlKy9vUWxWUVBZSktZNnZoTkk4OU9HN25YY3VsU0hB?=
 =?utf-8?B?M2E5ZGRDaXZxTm9xNk5qRXdvZnYydWRyd00zZTcxNGNYL0dKRG1ueWZzZVhF?=
 =?utf-8?B?SEFhSFhvWnlhOVVtZ1BKUTlZVnJuTVMvcXVOUk5vSFlpbm5kUXNTM2RBVm5a?=
 =?utf-8?B?WitFN3h2Ykp0dVpGQlpTZ0NzeDZOYy8wd2VrVDFJSUo2OTdBVmJhN081N05l?=
 =?utf-8?B?bzNiTWVPUEV5MEpITGR4Z3pDbitBWHA5dnNnM214SmZJWVJnVmdJZDMwYXB5?=
 =?utf-8?B?dUN3anRFZEU0T1drS0JSTjlHd3Z3MjV3Y0V6b2g0Q0RzUHJPWjEvVFoybldN?=
 =?utf-8?B?U3pkSGR0cHEvcEY4VWVjYzBNWllqVHd2Q1JKUndhMDBUYXMxU2o3RStib2k1?=
 =?utf-8?B?TUw2c1dpMkN3WFBHdTNIOGVJcndjNU5iTGNSTGZHd3FObm03U0g1dWRPUTFh?=
 =?utf-8?B?ZDMydTBzNCtkNlRKQWcxS0lWQnlYcUZSRVp4RHJHWjlmbTh3eTJ6RVZVMm1a?=
 =?utf-8?B?YnVmZVRHWk5QQlBucUNxYnNJV2MxNDFlRGsvN0FNWXhCYUs0QTd2clUvTVZm?=
 =?utf-8?B?UVlML1BtSHNFZEF6Tk8xNkhSMEpNUSsxZkZGYVIyRnNyRytYbzhMTWh2NUpt?=
 =?utf-8?B?cytNRlUxMnlrMm8vYzNsY2pPSjJSVm5KTnF3Y2hvVDdxSG9xaXZmN242VE5i?=
 =?utf-8?B?WFRqVVlmbEdFM0RoR1hUdzJrUmw5T3JlMGgveFVmTXUvc3hMengxKzBSR093?=
 =?utf-8?B?VjhJWTVXRE9za3hCYVB4ZHVsbHVhTnRZUjQ2dkd4YTliek14OCtEOGhRT1dK?=
 =?utf-8?B?UHlSVXlnTnRiaXlRVVd0dEhPZkRySjIvMnF0NS94aWd1NkZrdy9pMzJRVlRx?=
 =?utf-8?B?WFNGNytNK3pBZkFFeThJRDkrdUJRVkNaKzJMZHlPTEVKT1VlNUhkVnlYdG0r?=
 =?utf-8?B?aTQ0UjRGeVJyYXNkcDlkWStvZUJwT2UvVkJKODVQKytYbHhmU2kyZTEwYWxE?=
 =?utf-8?B?cm5XWUFkdWJkMk5ZVENQRnVteTFaUS9pS3RyckJZQ00vTVZ1YTBKZk02d1Uv?=
 =?utf-8?B?NUd5dkRLSGtsM1VvZVBCVjJqL0tma3IwaCtiNFp2YjNiSnhVdUF4SkQxOFYx?=
 =?utf-8?B?Z0dieks3ck5VSjNmTERQZjhQTUw0ZFFPRGRDQVZ4dmZ0aHpNd0NIOG5zWjN1?=
 =?utf-8?B?RENuRU9Sem1kU3M5TWduaUVqcUlXdS9FOTFIV3VJSlhFaTFrUVc0UWx2d21J?=
 =?utf-8?B?ci9mUEZjUWpUTTZxeWdRQUZOUVZNbEIyL0ROVmEzMFRGTjZEZmgvTGY4Tkd0?=
 =?utf-8?B?cFlQb21HMnZZcit5ZkNycm93NWs3cXozaUs2MTZ4bWVYMGdFR2ZNRFVZMldx?=
 =?utf-8?B?VEczalVOWGpiZGkzMVpKMW16ZDdndWlJRzlQS0FrVnI0aW5ISFVYS09Gd2xZ?=
 =?utf-8?B?WlFvekZjWnBWS1p6SjJveGNXSjNveVJPNFdmb3o3azF1QUNWdXdmVG5NZklY?=
 =?utf-8?B?SjNFVk4wOGl2WmNTNTkxZ0x2akhsMjVTWE5rZnVIUkVJVmxnTWJVTE40bFRJ?=
 =?utf-8?B?NU1hZ2xCR3J0MXduckI5TUlWdkd1K3Y3OSt4Vkp1QXk5U1AycThMK3RzaWZq?=
 =?utf-8?B?QmFLaDNQOUlFYUQwQU5Gei9vV1llNG9pYnZzWktTeHkxc01wQ2ZqdEp5UGh6?=
 =?utf-8?B?a1F2UkY3cHhSU2FWZUdOUThWcmltdXFEQVJjclZNY2l1Z21taTFLUGhaUTZU?=
 =?utf-8?B?eStlQWdOSGFYZ1YrQStBeGNYZEoyRWxORFJGc1JuNXRDc1RzOEFSTE11U3hM?=
 =?utf-8?Q?TkThQSxI8QwxKi0HbvC5biUds?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6472E1FD32A7D3438D1D48698DCFF3DF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dcd167-a8fc-4885-e134-08da6aa68e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 23:21:20.8455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZs0rvSwynU0l/nMTZUvUxfLmMe5UWxqBxRMuKJ5t8/0rxgP5iq3nX3QdN+WvAUSYiliarrYuCRda/Ia4mNw3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR05MB9045
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gSnVsIDIwLCAyMDIyLCBhdCA0OjA0IFBNLCBBeGVsIFJhc211c3NlbiA8YXhlbHJhc211c3Nl
bkBnb29nbGUuY29tPiB3cm90ZToNCg0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIFdl
ZCwgSnVsIDIwLCAyMDIyIGF0IDM6MTYgUE0gU2NoYXVmbGVyLCBDYXNleQ0KPiA8Y2FzZXkuc2No
YXVmbGVyQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4+PiBGcm9tOiBBeGVsIFJhc211c3NlbiA8YXhlbHJhc211c3NlbkBnb29nbGUuY29tPg0KPj4+
IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTksIDIwMjIgMTI6NTYgUE0NCj4+PiBUbzogQWxleGFuZGVy
IFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPjsgQW5kcmV3IE1vcnRvbg0KPj4+IDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgRGF2ZSBIYW5zZW4NCj4+PiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgRG1pdHJ5IFYgLiBMZXZpbiA8bGR2QGFsdGxpbnV4Lm9yZz47IEdsZWIN
Cj4+PiBGb3RlbmdhdWVyLU1hbGlub3Zza2l5IDxnbGViZm1AYWx0bGludXgub3JnPjsgSHVnaCBE
aWNraW5zDQo+Pj4gPGh1Z2hkQGdvb2dsZS5jb20+OyBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pjsg
Sm9uYXRoYW4gQ29yYmV0DQo+Pj4gPGNvcmJldEBsd24ubmV0PjsgTWVsIEdvcm1hbiA8bWdvcm1h
bkB0ZWNoc2luZ3VsYXJpdHkubmV0PjsgTWlrZQ0KPj4+IEtyYXZldHogPG1pa2Uua3JhdmV0ekBv
cmFjbGUuY29tPjsgTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPjsNCj4+PiBBbWl0LCBO
YWRhdiA8bmFtaXRAdm13YXJlLmNvbT47IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47DQo+
Pj4gU2h1YWggS2hhbiA8c2h1YWhAa2VybmVsLm9yZz47IFN1cmVuIEJhZ2hkYXNhcnlhbg0KPj4+
IDxzdXJlbmJAZ29vZ2xlLmNvbT47IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+OyB6
aGFuZ3lpDQo+Pj4gPHlpLnpoYW5nQGh1YXdlaS5jb20+DQo+Pj4gQ2M6IEF4ZWwgUmFzbXVzc2Vu
IDxheGVscmFzbXVzc2VuQGdvb2dsZS5jb20+OyBsaW51eC0NCj4+PiBkb2NAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+Pj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC0NCj4+PiBrc2VsZnRlc3RA
dmdlci5rZXJuZWwub3JnDQo+Pj4gU3ViamVjdDogW1BBVENIIHY0IDAvNV0gdXNlcmZhdWx0ZmQ6
IGFkZCAvZGV2L3VzZXJmYXVsdGZkIGZvciBmaW5lIGdyYWluZWQNCj4+PiBhY2Nlc3MgY29udHJv
bA0KPj4gDQo+PiBJIGFzc3VtZSB0aGF0IGxlYXZpbmcgdGhlIExTTSBtYWlsaW5nIGxpc3Qgb2Zm
IG9mIHRoZSBDQyBpcyBwdXJlbHkNCj4+IGFjY2lkZW50YWwuIFBsZWFzZSwgcGxlYXNlIGluY2x1
ZGUgdXMgaW4gdGhlIG5leHQgcm91bmQuDQo+IA0KPiBIb25lc3RseSBpdCBqdXN0IGhhZG4ndCBv
Y2N1cnJlZCB0byBtZSwgYnV0IEknbSBtb3JlIHRoYW4gaGFwcHkgdG8gQ0MNCj4gaXQgb24gZnV0
dXJlIHJldmlzaW9ucy4NCj4gDQo+Pj4gVGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdG9ydmFsZHMv
bWFzdGVyLg0KPj4+IA0KPj4+IFRoZSBzZXJpZXMgaXMgc3BsaXQgdXAgbGlrZSBzbzoNCj4+PiAt
IFBhdGNoIDEgaXMgYSBzaW1wbGUgZml4dXAgd2hpY2ggd2Ugc2hvdWxkIHRha2UgaW4gYW55IGNh
c2UgKGV2ZW4gYnkgaXRzZWxmKS4NCj4+PiAtIFBhdGNoZXMgMi02IGFkZCB0aGUgZmVhdHVyZSwg
Y29uZmlndXJhYmxlIHNlbGZ0ZXN0IHN1cHBvcnQsIGFuZCBkb2NzLg0KPj4+IA0KPj4+IFdoeSBu
b3QgLi4uPw0KPj4+ID09PT09PT09PT09PQ0KPj4+IA0KPj4+IC0gV2h5IG5vdCAvcHJvYy9bcGlk
XS91c2VyZmF1bHRmZD8gVGhlIHByb3Bvc2VkIHVzZSBjYXNlIGZvciB0aGlzIGlzIGZvciBvbmUN
Cj4+PiBwcm9jZXNzIHRvIG9wZW4gYSB1c2VyZmF1bHRmZCB3aGljaCBjYW4gaW50ZXJjZXB0IGFu
b3RoZXIgcHJvY2VzcycgcGFnZQ0KPj4+IGZhdWx0cy4gVGhpcyBzZWVtcyB0byBtZSBsaWtlIGV4
YWN0bHkgd2hhdCBDQVBfU1lTX1BUUkFDRSBpcyBmb3IsIHRob3VnaCwNCj4+PiBzbyBJDQo+Pj4g
dGhpbmsgdGhpcyB1c2UgY2FzZSBjYW4gc2ltcGx5IHVzZSBhIHN5c2NhbGwgd2l0aG91dCB0aGUg
cG93ZXJzDQo+Pj4gQ0FQX1NZU19QVFJBQ0UNCj4+PiBncmFudHMgYmVpbmcgInRvbyBtdWNoIi4N
Cj4+PiANCj4+PiAtIFdoeSBub3QgdXNlIGEgc3lzY2FsbD8gQWNjZXNzIHRvIHN5c2NhbGxzIGlz
IGdlbmVyYWxseSBjb250cm9sbGVkIGJ5DQo+Pj4gY2FwYWJpbGl0aWVzLiBXZSBkb24ndCBoYXZl
IGEgY2FwYWJpbGl0eSB3aGljaCBpcyB1c2VkIGZvciB1c2VyZmF1bHRmZCBhY2Nlc3MNCj4+PiB3
aXRob3V0IGFsc28gZ3JhbnRpbmcgbW9yZSAvIG90aGVyIHBlcm1pc3Npb25zIGFzIHdlbGwsIGFu
ZCBhZGRpbmcgYSBuZXcNCj4+PiBjYXBhYmlsaXR5IHdhcyByZWplY3RlZCBbMV0uDQo+Pj4gDQo+
Pj4gLSBJdCdzIHBvc3NpYmxlIGEgTFNNIGNvdWxkIGJlIHVzZWQgdG8gY29udHJvbCBhY2Nlc3Mg
aW5zdGVhZC4gSSBzdXNwZWN0DQo+Pj4gYWRkaW5nIGEgYnJhbmQgbmV3IG9uZSBqdXN0IGZvciB0
aGlzIHdvdWxkIGJlIHJlamVjdGVkLA0KPj4gDQo+PiBZb3Ugd29uJ3Qga25vdyBpZiB5b3UgZG9u
J3QgYXNrLg0KPiANCj4gRmFpciBlbm91Z2ggLSBJIHdvbmRlciBpZiBNTSBmb2xrcyAoQW5kcmV3
LCBQZXRlciwgTmFkYXYgZXNwZWNpYWxseSkNCj4gd291bGQgZmluZCB0aGF0IGFwcHJvYWNoIG1v
cmUgcGFsYXRhYmxlIHRoYW4gL3Byb2MvW3BpZF0vdXNlcmZhdWx0ZmQ/DQo+IFdvdWxkIGl0IG1h
a2Ugc2Vuc2UgZnJvbSBvdXIgcGVyc3BlY3RpdmUgdG8gcHJvcG9zZSBhIHVzZXJmYXVsdGZkLSBv
cg0KPiBNTS1zcGVjaWZpYyBMU00gZm9yIGNvbnRyb2xsaW5nIGFjY2VzcyB0byBjZXJ0YWluIGZl
YXR1cmVzPw0KPiANCj4gSSByZW1lbWJlciArQW5kcmVhIHNheWluZyBSZWQgSGF0IHdhcyBhbHNv
IGludGVyZXN0ZWQgaW4gc29tZSBraW5kIG9mDQo+IGFjY2VzcyBjb250cm9sIG1lY2hhbmlzbSBs
aWtlIHRoaXMuIFdvdWxkIG9uZSBvciB0aGUgb3RoZXIgYXBwcm9hY2ggYmUNCj4gbW9yZSBjb252
ZW5pZW50IGZvciB5b3U/DQoNClRvIHJlaXRlcmF0ZSBteSBwb3NpdGlvbiAtIEkgdGhpbmsgdGhh
dCAvcHJvYy9bcGlkXS91c2VyZmF1bHRmZCBpcyB2ZXJ5DQpuYXR1cmFsIGFuZCBjYW4gYmUgZWFz
aWx5IGV4dGVuZGVkIHRvIHN1cHBvcnQgY3Jvc3MtcHJvY2VzcyBhY2Nlc3Mgb2YNCnVzZXJmYXVs
dGZkLiBUaGUgbmVjZXNzYXJ5IGFjY2VzcyBjb250cm9scyBhcmUgc2ltcGxlIGluIGFueSBjYXNl
LiBGb3INCmNyb3NzLXByb2Nlc3MgYWNjZXNzLCB0aGV5IGFyZSBzaW1pbGFyIHRvIHRob3NlIHRo
YXQgYXJlIHVzZWQgZm9yIG90aGVyDQovcHJvYy9bcGlkXS9YIHN1Y2ggYXMgcGFnZW1hcC4NCg0K
SSBoYXZlIGxpdHRsZSBleHBlcmllbmNlIHdpdGggTFNNIGFuZCBJIGRvIG5vdCBrbm93IGhvdyBy
ZWFsIGRlcGxveW1lbnRzIHVzZQ0KdGhlbS4gSWYgdGhleSBhcmUgZWFzaWVyIHRvIGRlcGxveSBh
bmQgcGVvcGxlIHByZWZlciB0aGVtIG92ZXIgc29tZQ0KcHNldWRvLWZpbGUsIEkgY2Fubm90IGFy
Z3VlIGFnYWluc3QgdGhlbS4NCg0KDQo=
