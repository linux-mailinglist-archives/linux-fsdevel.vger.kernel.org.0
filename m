Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAC587451
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 01:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiHAXTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 19:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiHAXTw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:19:52 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064006.outbound.protection.outlook.com [52.101.64.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5782A40F;
        Mon,  1 Aug 2022 16:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/vpHL9Qp+WFR07KuWXYwsyzAnzzcgE2Xw71iWOLVjeh9BTGHdiNcZV4PnyzKSbvHyRofY4OhVUkEF4Q4HANS26Glzh2t8vbvdkBmTcbAyaZD5Uk3yZF+DxM3ecsORXxGJEiocpZ8sEG3/Ycw5bOcWc//+nF6XSW1aQDBWz01LtjWJJQocGOJSnSRORzxonVu+qgG6+h9FgJZ8nlYFV0NZx5mURoPvpYOKiiUlU7wOCqBTiUIOh7Igy5nhLRbpMS3IDY0j8BGQrbTYTzqfKOwLEEU3RptpCelLv2e1910Hj8qzlpnH+KKImmgchqT1uTISe24YfGvUTsPjN5YMBdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4ivXbwyhchz2gX03GAcBD6zzDIW5+sem5beLSjDLMY=;
 b=Hy3EN3kSoG6h+iFck+snW45nZi6ld0Pclbj4iN61cHFwBCpsHRWPQamWSfOqs49dslixyVlYGlEeulxHTj7zi5k5bfbYTG5W1dXvMK6tE7EAiJDQvofE7fJhIcBaXjtvqGHEibmZxozkVKIPpguTuetnH7Z5m4rz0QWYbVGLHpNywMqJTDmaTqlOPm2LWd1YE1fAFbCHxoO/y6ldRZ9Ixo01ryBl4PJX/XXMkzAY4LPk3OlqVihtw74iNYjAwOlgfMwzXypZ4mR5Qvx0Vp0/Y6UY0aM6siM9x/zyRR2RJcKT9RiHAKONQLaFMlw7ZxaoN3AdWYYveZ0JQ3/cKGhRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4ivXbwyhchz2gX03GAcBD6zzDIW5+sem5beLSjDLMY=;
 b=mYomdPqq/0wM7lqWYcgpEZpOs8apW3HbXjrwvkD5jmcjjFf9TbChQGM52jNUEo9KTrOiCFdhAwv2nK0xLfu7XiZAWg0XvhUTF3JH2MTx7ZglYZYtP1bKJlFzr5RzboA41KG0Fe0ogrtRACjrJL8xf2hYsgzsev7MwJPA/X0OHEU=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB8057.namprd05.prod.outlook.com (2603:10b6:510:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.12; Mon, 1 Aug
 2022 23:19:49 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%8]) with mapi id 15.20.5504.014; Mon, 1 Aug 2022
 23:19:48 +0000
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
Thread-Index: AQHYm6moVvUxeU2aLUSjhWg4PqcU4q2H1VIAgAANjICAAASjgIASdSEAgAAsz4CAADGMgIAACBIA
Date:   Mon, 1 Aug 2022 23:19:48 +0000
Message-ID: <858CC870-B061-4ADC-B5F4-C95E72F72CEC@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
 <CAJHvVchusMjvhLxYkWpa+iTaHvXYPFHcX7JGP=bW60e_O1jFGA@mail.gmail.com>
 <7EF50BE4-84EA-4D57-B58C-6697F1B74904@vmware.com>
 <CAJHvVcghaZjgU6YhoGMehQTDU36S-UL5djG+Bym6Uax=VVoX7g@mail.gmail.com>
 <DDE06635-71B4-46B9-9635-97E35E0B5482@vmware.com>
 <CAJHvVcgR63YNyGYj1Z-XAj5WP631P0DSEK8Mx=f9E=QGJBeRug@mail.gmail.com>
In-Reply-To: <CAJHvVcgR63YNyGYj1Z-XAj5WP631P0DSEK8Mx=f9E=QGJBeRug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07896e4f-26d5-47bd-0e3e-08da74145440
x-ms-traffictypediagnostic: PH0PR05MB8057:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMUTKgYo+obp60m9HklnU5bPaEOcDqw9foAxZMSAMzS8srNL1PzJr8tgIhQjUiyrqjhpxDHR80FHCnr3p4GrjjmGC31uUE52ThYuYyrrZcHZV4x7B48GA1UtckA7/PvswWbfF6H2B28PLYL3gm/T/w0kKEdh9MchbuSvzIpNNN2+Rq8Dr8pai0pavazAXCHuIi616thCIgJjklH92cBOtXBfhv/0CdsZ6i2LAagxO/fkrhZKqEJye8Ggi8XHNCOIspfswEUUi2+BZsBNj9XTRZhP3ghmLEvdxg5U2Fsyk3bXSjbfV1huYuTy5S/olJFUs7+wo4xH34WfUlp+V99FMUfZmiDpElDsBbq8dhC1JXL6AJaE+3aKO/7hw1+RYvPxxczL0E6u6vu5jlsB3Cb/ZuxGrtiAQw3wq/9RTY1xL/MSuT2b48WQnvCbdwUZP7xEcWWRymXX1M+htK6f6cCMY1Y3Qq8VVba6rvUcr8ZkYIlraXT6VQSmoin4x/vv8PNLx3Iu3U+9KnDNpnGs/1mx6Rc4kNUM480wijfcelGCYlpc5wtdmgPM/22y/Ul6M9GOZaSbgYGogqucbdSNz/czseJ4ouDsWFniE6O2fJzkQGNlqTOBxD8qC/vzbh33XFXa08plWv4ivhU8Mc8hl5dSzql62aGz1BAzM6Nx4Gg77jgHKjMyJQkYq82Vhjwcn0mV7rHqc9/HLNpiD/fcsOWqPpmGLV2/GwnGjEpilCDdUqcYNbJyoqw0cKMUUHpAPrFwHMZs64Oa4DMHyvTmMpqPfj852NzKZLjt4LUEyKTD9eHaNDBSuxnuodlZUzdN8I8lUjvQyhT4mLHlBfj10qAMsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(8936002)(66446008)(6486002)(64756008)(478600001)(66556008)(4326008)(8676002)(66476007)(71200400001)(186003)(83380400001)(7416002)(36756003)(86362001)(54906003)(6916009)(38070700005)(2616005)(2906002)(41300700001)(6506007)(316002)(53546011)(6512007)(33656002)(76116006)(5660300002)(66946007)(26005)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXFqUEh1cWpkU0ExaEhhU016MUlCU0RwZS9zTGlsYkpCOHFGMEk0N0Z6Vzdy?=
 =?utf-8?B?c1VzUWF3Vkxlc2xsZmZzdDZJdnRjREtyUFhIZXQvUEYzdmt3Wk41MFpKOVRH?=
 =?utf-8?B?NjlHdm5vWVZheXdUeDdCQUJ1cGUyV0Nud3dhaG1pS1YrdG4xeVN1MGRSYmJU?=
 =?utf-8?B?amFHYWoxZlJYa0pQNkE4TkRmeDVMb0theGo1Y2ZhRldvQ0dNUDFFbGZwZXln?=
 =?utf-8?B?T0JBd3RlM056YWRrSjcyaUtERW1RNTlIZ2xOSzMzR0xZenM5bzBVczZaTDF0?=
 =?utf-8?B?dGpRMTZBRlR4WktVamxCQnNqMXR2Z2dZdVFyc0RjWGxZbDJHWnAyT2kyU3FX?=
 =?utf-8?B?ZWttdVF3SFZGY3llYWtmWTJOT0Z5dGtkV0tZdVhud1kxUithYTZyaEVrL2Fw?=
 =?utf-8?B?Zk5HTEFQa2VRUXAxTk1QRHdIQ0xGRWpGaGFxVzFXd1prajZwR0tkcVlucnpY?=
 =?utf-8?B?Y3RtOG5zemhyRmxJZGcwWmZaNTR4MUhHUU80S0Zrc1RXQlNhK0h6MWQ1c0Js?=
 =?utf-8?B?cUd4ejdPTTc2SWV0WmpGTG9QQ2pHS2lQNHNXSWFjY0RRKzhSRUdHM21GWHF6?=
 =?utf-8?B?TndYaUF2TFZqUVNHQmtJakMvc3VJRE5rSDYyOUVVMTFrYUEwWG40M0lybzRW?=
 =?utf-8?B?Uk9JS3dWYVBINzhCUWNSaXhVV3M2Qmp6MHdVMEJ6RGtrRmVoUzllZ0xqdWVX?=
 =?utf-8?B?cDNSMkNOSnBuRWlZYnhvdTBJa2JPMkVnSVYyZytPYTVKV3NHcDF4Smh3eWJj?=
 =?utf-8?B?SXVlVEd3UUdxWnE5KzlncEVLMGRlUW1RNklzOFcrT0JQQnZrRUNHdnVTT1VC?=
 =?utf-8?B?SU1yQ0Y0WVpRSnhXTS9zcldwVWM0LzVtMThrYUpScHRmWDRXSFl2WEcyNDdY?=
 =?utf-8?B?SGVHL3kzU0RnNFI1ZllIVW0xMTkydmZNZG93Y01RVUZaVWtQOFJZbU5lbGJH?=
 =?utf-8?B?OVdIU2c3aUdjR0UvOVYvWHh6R1NNRFM5NkhCMHBNcWxjdDBSZ0VjbWhkSkRW?=
 =?utf-8?B?a2FuQk5VZVBWVkprL1o3VW1WZVVXeENyNTd1NGNucCtlRHVpdk9iMzR2Slp4?=
 =?utf-8?B?ZERLL3RGWTYwS1RDc0tsRk1HanFsMitjcjgrSy9MMkNsTDNiVGhkdG9CQ3BE?=
 =?utf-8?B?UWFEVUZGL1p3OXM5K3lJcWxOK1MvaFhRaHp0dUQ2eU44TFRlQ0xZZkVLREZL?=
 =?utf-8?B?MGxveWZRd2VoUTNhZTE0UVFoYkVyc3hTdXVmdGxWS0JMbExCaThnNkxrM1Rj?=
 =?utf-8?B?TW1ZV1hRQzRocW15aTRFMjBsNGNkamRtdm1aQUhWNVZzWFFmNHJ5b0pOVjNz?=
 =?utf-8?B?QUJFOFQ0WEYxZHhITGgrVVFSeTB0OHN4dmI2TU1HYklIeWNaMkI0RVR4bFZU?=
 =?utf-8?B?OGNFRFA1VjU2Mndpdk5iVW1ELzVEY1hVUHlNUUYwUW81Y00ySEpRVXdjcSt4?=
 =?utf-8?B?VGRFYUFRYXlBZjNlckFkV3BlbTAxOXFDNS9VdXExN3hYNHJVdHN0U21nbXZJ?=
 =?utf-8?B?ekNpbzBIZEo3MkZvWjdld01SbHcrYTNra1RMNk1zbk9TWDBjZm9nUU56T3lE?=
 =?utf-8?B?eVkvVXBlYWxEVzVjN0QxR3pjdEVGSFlCV2Y5K0pmQlFBaWh5ek9JYnRsdStO?=
 =?utf-8?B?YnZ4SkV3MFQ3ZzYvTGp1TmVPMFpYV1kwT1ltaTBkMWtGWEZCRTNwY2IxVEo0?=
 =?utf-8?B?L0FWQVY3Mm1KWElndHZBcjNXcmdBNmxobGFFNWdDSmROMXk5TWxhaVpOc3lS?=
 =?utf-8?B?TStwNHBlU1BvSi9hUDIyMmNzUjF2clROSm1hakhmaCs2aVkvTVpnc1ZBRDFY?=
 =?utf-8?B?dDhvVm9jVG5LQ0pxeHJuMmRBUmd6MDVMTlBmc0paSGhhS0hlWC9jVENwTDQ3?=
 =?utf-8?B?dkVEcTN1NG5zV2w3bkllS0lBNEZpdlphSTV4RWxMVkJzTzkwVmJ3Vi9xdVYx?=
 =?utf-8?B?QlZiQnN3aGFKZ2FxZnNXRjdSVlFCUmVoTGkzQW1tN24yaUhOcGVNOTVxcUJp?=
 =?utf-8?B?aE95bW03ZkxVS0xOR3BIOWs5cmdKMyt1ekxSMjdPbTdTYzZVbjNJTm1LSjZT?=
 =?utf-8?B?VDlOT3g0ZHFFTWVEdkJtSTNIYjJSUmx0VFoxc21IYXdPSzJveUY0TGZ0aUVE?=
 =?utf-8?Q?Kbx5fUuefrkRTwNsr8qlVWi3L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <216C0BC7B275ED4BBDC0BBACB713FDF3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07896e4f-26d5-47bd-0e3e-08da74145440
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 23:19:48.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjWv36TGD8mvMhoQcIxy8Nezi28+QFH4mhJe6sztoredkOwWZtXY8RyKG2I61U+u11sP8DwnA0W6t0sU1KsM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8057
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gQXVnIDEsIDIwMjIsIGF0IDM6NTAgUE0sIEF4ZWwgUmFzbXVzc2VuIDxheGVscmFzbXVzc2Vu
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gTW9u
LCBBdWcgMSwgMjAyMiBhdCAxMjo1MyBQTSBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3
cm90ZToNCj4+IE9uIEF1ZyAxLCAyMDIyLCBhdCAxMDoxMyBBTSwgQXhlbCBSYXNtdXNzZW4gPGF4
ZWxyYXNtdXNzZW5AZ29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBBaCwgdGhhdCBJIHRoaW5rIGlz
IG1vcmUgb3IgbGVzcyB3aGF0IG15IHNlcmllcyBhbHJlYWR5IHByb3Bvc2VzLCBpZiBJDQo+IHVu
ZGVyc3RhbmQgeW91IGNvcnJlY3RseS4NCj4gDQo+IFRoZSB1c2FnZSBpczoNCj4gDQo+IGZkID0g
b3BlbigvZGV2L3VzZXJmYXVsdGZkKSAvKiBUaGlzIEZEIGlzIG9ubHkgdXNlZnVsIGZvciBjcmVh
dGluZyBuZXcNCj4gdXNlcmZhdWx0ZmRzICovDQo+IHVmZmQgPSBpb2N0bChmZCwgVVNFUkZBVUxU
RkRfSU9DX05FVykgLyogTm93IHlvdSBnZXQgYSByZWFsIHVmZmQgKi8NCj4gY2xvc2UoZmQpOyAv
KiBObyBsb25nZXIgbmVlZGVkIG5vdyB0aGF0IHdlIGhhdmUgYSByZWFsIHVmZmQgKi8NCj4gDQo+
IC8qIFVzZSB1ZmZkIHRvIHJlZ2lzdGVyLCBDT1BZLCBDT05USU5VRSwgd2hhdGV2ZXIgKi8NCj4g
DQo+IE9uZSB0aGluZyB3ZSBjb3VsZCBkbyBub3cgb3IgaW4gdGhlIGZ1dHVyZSBpcyBleHRlbmQN
Cj4gVVNFUkZBVUxURkRfSU9DX05FVyB0byB0YWtlIGEgcGlkIGFzIGFuIGFyZ3VtZW50LCB0byBz
dXBwb3J0IGNyZWF0aW5nDQo+IHVmZmRzIGZvciByZW1vdGUgcHJvY2Vzc2VzLg0KPiANCj4gDQo+
IA0KPiBBbmQgdGhlbiB3ZSBnZXQgdGhlIGJlbmVmaXQgb2YgcGVybWlzc2lvbnMgZm9yIC9kZXYg
bm9kZXMgd29ya2luZyB2ZXJ5DQo+IG5hdHVyYWxseSAtIHRoZXkgZGVmYXVsdCB0byByb290LCBi
dXQgY2FuIGJlIGNvbmZpZ3VyZWQgYnkgdGhlDQo+IHN5c2FkbWluIHZpYSBjaG93bi9jaG1vZCwg
b3IgdWRldiBydWxlcywgb3Igd2hhdGV2ZXIuDQoNCk9oLiBTdHVwaWQgbWUuIFRoZW4geWVzLCB1
c2luZyB0aGUgL2Rldi91c2VyZmF1bHRmZCBpcyBpbiBsaW5lIHdpdGggb3RoZXINCnVzYWdlIG1v
ZGVscywgc3VjaCBhcyBLVk0uIEFuZCByZWFkaW5nIGZyb20gZWFjaCBmaWxlIGRlc2NyaXB0b3Ig
aXMgaW5kZWVkDQpwcm92aWRpbmcgZGlmZmVyZW50IG91dHB1dC4NCg0K
