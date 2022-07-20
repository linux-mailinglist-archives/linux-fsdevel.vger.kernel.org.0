Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ABF57BD05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiGTRm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGTRm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:42:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB8A43E55;
        Wed, 20 Jul 2022 10:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxOqmlm+TL8WPQyMeLXhLDoeVk5BZWuzpbgzaS9X1yCm4tiscNGWUj3fSfTqCtFFxWWqF3z7rGFUwqqo8qB1607r98uP9vD9iDeidd+WZVwzmnwZBF3lwgqHjSgeVC9jQvhGIPRpmjd/L6rXRN/xW8246lSam0jHbZ3W021WJrchyZey6QjHlkcR8hrhyeee/XAeyZhyoNF5uvJ2Dz7lir2+QecQTjEmhZRLEHqvYQvNe8iVzpHF8OrBw+9OaEj2zrfMZJfFR4ei53xRWlllzBqNvTfOyE6C2EJXAJjc907A1Wl3GcF/0JhS7d9V1muCOD85UV2hRTlUzZvP77YbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlp+y4AoIC3gEpIz3pafv6XAd+pBZ/Pz5eG25T0Ji6Y=;
 b=iXzN01/InAUJJgEM6ey+ZBiMPJXXLjOKShNsGKHOUE4l6D2pnxdRj9B6/zyhi6gAtPr2gyg4KcVNpg7+EN9B9wIlJGSI+I/hfqw1PLhVwuTfS19bwaGJxuu+IokUE742uYebuEmcfjybvrX8xim2SM2zZPCW7qOaL2PNPEHYNrEWjMV6+9Vu84pJljc7L8+WHkXJ3eAZX7vnvuX1eTjNDZC3KLU4bw9mBaKArzcaNLZsF0eIy6lbMJYRQQHOAfTN5fPrGD/7qsevvbYuqXbbpHcBI2wxr6ksTlGriBJVyd8IeQqFgdsJBToC6XR8YV538spPFLxc5VL2t5fW2KK5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlp+y4AoIC3gEpIz3pafv6XAd+pBZ/Pz5eG25T0Ji6Y=;
 b=0E+4PwVg8vcDIQfrypaT9p7p1l/4ZdMPlG3NtOmSlkVAEfAiySdqUCswaUASXu+SGf2+PhCSLjCfdj9pm3TYvQxfK3upanPC1ThjFqV1fk13FyWiBlql+xe7OnT9OnbrKvS2A+8NPUyoB4awabSIOCAh0tifjb7kNcp+IeetY/0=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN8PR05MB6052.namprd05.prod.outlook.com (2603:10b6:408:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.16; Wed, 20 Jul
 2022 17:42:51 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 17:42:51 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
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
Thread-Index: AQHYm6msXDLL/Bu+aECRDX4d27LWyK2GR2wAgAADx4CAABN8gIAAK+oAgAD+VgA=
Date:   Wed, 20 Jul 2022 17:42:51 +0000
Message-ID: <3C93275E-B3B8-45CA-808E-0C163DBBB32F@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
 <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
 <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
 <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com>
 <YtdpQBrAGJwMnssj@xz-m1.local>
In-Reply-To: <YtdpQBrAGJwMnssj@xz-m1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf064cac-8a54-440b-bc47-08da6a7744bf
x-ms-traffictypediagnostic: BN8PR05MB6052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsmQsX2ONHK2vx1K1DwRZjl5I0kzdx3L7AYhyt6s3KgxFKwwvHB/rxXq5UZjrZPv1esSBsdPmMPEWtMKSvBJ3akMgnfdjOwNxeOx2SQ5E5EZZOpnzBHGFMNAoipcRe3Iw0FBqNfpBgET3ApnBzGCTNq/JPKNVcKKeZlW4XZsmd5oB2nfjcU11uhQJdh6oNTvgdzP8uYsrVFwOLAgfkQaBdpcaUO04Jdorg5svFIGh+YdlL2ZIGqwC+1oV1X41BhNIGWevJ2OBbPBvAoPDbh86TfymvaNsUIJDHS6Gzv5GtvidCEHLNwxn6m54TzO3xPij+XpDRqi4jZIKbkXuzNrhlYGgPKHEQ+iXAlujlmcIyOaYnxhC7BCf7B9ddEDOV3MaF0ZoOtGBgEUVayZWdcbY7QJNLYgRIwO5b7Rraag8tuM/hhppFab9axrnDzXgnjwrvEwILaI0Q6iXegw8ZNDhOsOP8bRM0Lf924nUvs8RjkC9kWk09zPVqjWLcV066x1n2ZHzBp8jt3pJZf27sE2coxHnQW+BJxS2DT3HC/J+bUJmTP2vIltgZ9X5GXjt/7aUOFpTyPDqKQzYJ9osarMKyyUAjYbVzy2U7+VXY6VuKjzr54M1RNBrx3K/Zzr3RBVlkob43/y9p9tJkyvwhiOlhdFYwt3M9ugLmW9FBLCPkApP6K7rR5EOlMh5qYvXcdwph/SUe06ZN/EJgKMbatKFdpEHp+JN4XjdgPxxTjsxbMpk1yhDpVSvyKT5Y5Ean9zXBDnP1VAGcOrrBKzgnPj2aJSdiPWTkRRcEe1iZKpyPbvSphWi+ZP1dC8jhDa7ySbtTIxD589m9PBb5L+kTHIeCnXe4RhWrMfHhFTomifDY4IYWZrbtLdAZ2DbYYv2nKW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(8676002)(38100700002)(4326008)(71200400001)(33656002)(41300700001)(64756008)(66946007)(66556008)(66476007)(83380400001)(66446008)(122000001)(76116006)(6486002)(86362001)(36756003)(53546011)(6506007)(478600001)(26005)(5660300002)(2906002)(6512007)(8936002)(38070700005)(316002)(2616005)(54906003)(186003)(6916009)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlBzSWhzN3VoY3pOVG1TL05uaUZKcGROTHo3bitET1lCVUE5ZW16Nlc4aENT?=
 =?utf-8?B?OFZ1K2tuVVV6S2F6SnlHSUtFWEY4ZDBvTkFKdGp4N1pPQkZpRlRCcENQdzBi?=
 =?utf-8?B?OVlGeGU0QVdmRkNwV045SGYwWlpQWVFFeEJsVUk0cTI2ekZpdlFQakN6T2ln?=
 =?utf-8?B?aU5QZEk5VkkxNXBIMUlwYU5xM0NBS3hEdDBBZUtOem5mRlphMXpHdElHM080?=
 =?utf-8?B?UkI2UmtBYlVRVlZ3ODZEcCtRNVhOcWoxaDBlMUFBQmtOb2ZTOHgyKyszMHc3?=
 =?utf-8?B?aFMxdjBDN2ljTTNuYUpWdEU0NHRrbVdBUlJwRmt5cTlISGVjKzhlbml5L084?=
 =?utf-8?B?TFBwajdMZjY2eVFYSlBDdEZEdjlEVGFKaE40TkVzbmtLUmZ4M2pFUmpsa2Zv?=
 =?utf-8?B?Vy84K2tXR2pVczJmc3E1bDZXUGJuYktGWFFEREIrbitodWliQS9PTnpBUUpR?=
 =?utf-8?B?cnJiTUpvVEx2VnJJL3o5U0NyRHowY2xuWklTRUhod2Jma2x0UXRNWHhwYzdM?=
 =?utf-8?B?eFlLaS9PYUlxYTlJY1hkb3ZJbUFnTHRzdzJlM21GUm9BWkxTcVVLSmplL2JL?=
 =?utf-8?B?djZWNDRreWxsaXVqb1hGZG4yNTJpMWpvcXdjNEF5T0JOSStwcnBpWERMV25V?=
 =?utf-8?B?a0llb2duV0dMTXJjZXhjaE14eGdwSkNwZzRxaEwwNHJDb2llOFluaUhQWDVT?=
 =?utf-8?B?dDI0WFZZYm01alFZaHQ4R1JpZ0hJZkNCWklHN2lwQTVKZEljMTFZS0Fsazh5?=
 =?utf-8?B?Yk5uMFJaaFZ4KzhieXFQV0tZZWx4YklrREdkbC9VN294NVlGTmhUVnZXWW84?=
 =?utf-8?B?eC84Nmp3cVByOWk3UW5VSG51eC81Y0hZbzdIRWM1NW01YUJiV0N4TWlJUGJp?=
 =?utf-8?B?OWZoVUhXNWNlTGx5VUdBR3pJRkhmRFRUNm1GR01pNGV0SmpvM0lUdEpocFdF?=
 =?utf-8?B?OUU5RUhjSmllWTk5bXdGMVlzVVpZeFV6Z3pab1VqbW94NGdpTmt4eDQzaDlE?=
 =?utf-8?B?N0pzU0xuQW9La2V2UzJxWGZHWWZqL1lkZ2tMSnFrTmhRQmMxaWh4Mkk1NEF4?=
 =?utf-8?B?WkFNRHpTSEd0ZXFlUDBXZW5NeWJBcG9xeS9IZWg4cjAvYW1QVlVMdkFKS0hQ?=
 =?utf-8?B?RUx4enNxdWxpK3FISDNsMUw0bmU2bFMxQ2s5R204SmtTUDJ6QXdLOHQ2S1lQ?=
 =?utf-8?B?KzFDa3plU2tVVUpsckdJYUNsckUyblVYdUFseVc0SEtKejBPcE42aitKSmFL?=
 =?utf-8?B?N1F0d3pGNFZBQlF3WVBYY3FzOVBVekdJSHovQzNHMndPdlpuUjNtYVZlaW1Q?=
 =?utf-8?B?dzRjbkR5ZVJISGRVem42cG1SY0xFcXdkelIwS3hPZ1V5blJnMHZYUVF5OWdG?=
 =?utf-8?B?THp2dmUwZmFYS3BTU3Y4cXUreDhsRDhkZWJ1akxQVkpwbzZMZG5Sc0h3OEJZ?=
 =?utf-8?B?ZVdxV0RBRFc5eWhFT0pmaGNwZ1l3SkJ1TldlZUFqbGMwTkZvOWlrSW54aTB3?=
 =?utf-8?B?QVh3d3NJMWVrRE1HbU51WC8xTzNjQlVmT09UMVhKYXRJM1ZMTEozbDFNR2M4?=
 =?utf-8?B?a1FSaHVQK2V4Y0RSOS8yb1o5Y2ozR2JmZDFVb3A1ME9kRENXWThNQ3d5NHp5?=
 =?utf-8?B?dE9aa0xDeHR1bHcwZ2YzNmFtdjFwRHBYbjVmUExWRUtOSXNhMGpFc2crSVdo?=
 =?utf-8?B?eHQxT0VwRDlaVUVoUCt4VXFhM0FaZ0JPUnpjcjZ0RVN3Q3UyWGpBOEE0eWxw?=
 =?utf-8?B?Tm1jSkRoQUlWVUt0alNza2dhcy81QzdaZWg2dUtWOTB0QzRTSlUzQUlUZlhI?=
 =?utf-8?B?TFZPRzFEazZaNlNhWnRVU1FnY0U3RStneEVWQmlHcWptSEF5MDdsZ2pwcmVG?=
 =?utf-8?B?RkRTMTA3R2lFYStrOVhTRWZ2eTQ3aGtMQTkvWThudDA5dFR5YUQxSkp3S1Qr?=
 =?utf-8?B?blRKbzFCRHZSRlRQTEYzekVsdG4zVmRpUDRXQTJ3UFVVTFZXU1JleTJHR01K?=
 =?utf-8?B?QU8yZVlRL3lBRHFmd1ZVNFUyek11bjFYTURaTnUrQ09sVUtCQ1hTV2djVWhn?=
 =?utf-8?B?R21yb0pUR09mS0dBRlUyYVNoOUhVVEl2bmk2bngvMzdEZE5KZDVja2Z2Skw0?=
 =?utf-8?Q?YmfJjbXU4rOhmyF0izTmDGoTa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6061E1BA7BF384A96CB9238A6F905CF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf064cac-8a54-440b-bc47-08da6a7744bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 17:42:51.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /19bsLPbfgKi2es75FRfW2Afzx18u5q/OBYtMeR+7m1DdS8R8u3QbQ5FwrBU22xnvNj7XTrVqo3166HuK8M+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6052
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gSnVsIDE5LCAyMDIyLCBhdCA3OjMyIFBNLCBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+
IHdyb3RlOg0KDQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gVHVlLCBKdWwgMTksIDIw
MjIgYXQgMTE6NTU6MjFQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IEFueWhvdywgSSBk
byB3YW50IHRvIGNsYXJpZnkgYSBiaXQgYWJvdXQgdGhlIOKAnGNyb3NzLXByb2Nlc3Mgc3VwcG9y
dOKAnQ0KPj4gdXNlcmZhdWx0ZmQgc2l0dWF0aW9uLiBCYXNpY2FsbHksIHlvdSBjYW4gYWxyZWFk
eSBnZXQgY3Jvc3MtcHJvY2VzcyBzdXBwb3J0DQo+PiB0b2RheSwgYnkgdXNpbmcgY2FsbGluZyB1
c2VyZmF1bHRmZCgpIG9uIHRoZSBjb250cm9sbGVkIHByb2Nlc3MgYW5kIGNhbGxpbmcNCj4+IHBp
ZGZkX29wZW4oKSBmcm9tIGFub3RoZXIgcHJvY2Vzcy4gSXQgZG9lcyB3b3JrIGFuZCBJIGRvIG5v
dCByZW1lbWJlciBhbnkNCj4+IGlzc3VlcyB0aGF0IGl0IGludHJvZHVjZWQgKGluIGNvbnRyYXN0
LCBmb3IgaW5zdGFuY2UsIHRvIGlvLXVyaW5nLCB0aGF0DQo+PiB3b3VsZCBicmVhayBpZiB5b3Ug
dXNlIHVzZXJmYXVsdGZkK2lvdXJpbmcrZm9yayB0b2RheSkuDQo+IA0KPiBEbyB5b3UgbWVhbiB0
byBiYXNlIGl0IG9uIHBpZG9mX2dldGZkKCk/DQoNCmF1dG9jb3JyZWN0PyA6KQ0KDQpJIGRpZCBy
ZWZlciB0byBwaWRmZF9nZXRmZCgpIGFzIGEgc3lzY2FsbCB0aGF0IGNhbiBiZSB1c2VkIHRvZGF5
IGJ5IG9uZQ0KcHJvY2VzcyB0byBjb250cm9sIHRoZSBhZGRyZXNzIHNwYWNlIG9mIGFub3RoZXIg
cHJvY2Vzcy4gSSBkaWQgbm90IGludGVuZCB0bw0KdXNlIGl0IGZvciB0aGUgYWN0dWFsIGltcGxl
bWVudGF0aW9uLg0KDQo+IEp1c3Qgd2FudCB0byBtZW50aW9uIHRoYXQgdGhpcyB3aWxsIHN0aWxs
IG5lZWQgY29sbGFib3JhdGlvbiBvZiB0aGUgdGFyZ2V0DQo+IHByb2Nlc3MgYXMgdXNlcmZhdWx0
ZmQgbmVlZHMgdG8gYmUgY3JlYXRlZCBleHBsaWNpdGx5IHRoZXJlLiAgRnJvbSB0aGF0IFBPVg0K
PiBpdCdzIHN0aWxsIG1vcmUgc2ltaWxhciB0byBnZW5lcmFsIFNDTV9SSUdIVFMgdHJpY2sgdG8g
cGFzcyBvdmVyIHRoZSBmZCBidXQNCj4ganVzdCB0byBwYXNzIGl0IGluIGEgZGlmZmVyZW50IHdh
eS4NCg0KVGhlcmUgYXJlIGFsc28gc29tZSB0cmlja3MgeW91IGNhbiBkbyB3aXRoIHB0cmFjZSBp
biBvcmRlciBub3QgdG8gbmVlZCB0aGUNCmNvbGxhYm9yYXRpb24sIGJ1dCB0aGV5IGFyZSBhZG1p
dHRlZGx5IGZyYWdpbGUuDQoNCj4gSU1ITyB0aGUgY29yZSBjaGFuZ2UgYWJvdXQgaGF2aW5nIC9w
cm9jL3BpZC91c2VyZmF1bHRmZCBpcyBza2lwcGluZyB0aGF0DQo+IG9ubHkgbGFzdCBzdGVwIHRv
IGNyZWF0ZSB0aGUgaGFuZGxlLg0KDQpZZXMuIFRoZSBwb2ludCB0aGF0IEkgd2FzIHRyeWluZyB0
byBtYWtlIGlzIHRoYXQgdGhlcmUgYXJlIG5vIG9wZW4gaXNzdWVzDQp3aXRoIGFkZGluZyBzdXBw
b3J0IGZvciByZW1vdGUgcHJvY2VzcyBjb250cm9sIHRocm91Z2gNCi9wcm9jL3BpZC91c2VyZmF1
bHRmZC4gVGhpcyBpcyBpbiBjb250cmFzdCwgZm9yIGV4YW1wbGUsIGZvciB1c2luZyBpby11cmlu
Zw0Kd2l0aCB1c2VyZmF1bHRmZC4gRm9yIGluc3RhbmNlLCBpZiB5b3UgdHJ5IHRvIHVzZSBpby11
cmluZyBUT0RBWSB3aXRoDQp1c2VyZmF1bHRmZCAod2l0aG91dCB0aGUgYXN5bmMgc3VwcG9ydCB0
aGF0IEkgbmVlZCB0byBhZGQpLCBhbmQgeW91IHRyeSB0bw0KbW9uaXRvciB0aGUgZm9yayBldmVu
dCwgdGhpbmdzIHdvdWxkIGJyZWFrICh0aGUgbmV3IHVzZXJmYXVsdGZkIGZpbGUNCmRlc2NyaXB0
b3IgYWZ0ZXIgZm9yayB3b3VsZCBiZSBpbnN0YWxsZWQgb24gdGhlIGlvLXdvcmtlciB0aHJlYWQp
Lg0KDQpUaGlzIGlzIGFsbCB0byBzYXkgdGhhdCBpdCBpcyByZWFsbHkgc2ltcGxlIHRvIGFkZCBz
dXBwb3J0IGZvciBvbmUgcHJvY2Vzcw0KbW9uaXRvcmluZyB1c2VyZmF1bHRmZCBvZiBhbm90aGVy
IHByb2Nlc3MsIHNpbmNlIEkgdW5kZXJzdG9vZCB0aGF0IEF4ZWwgaGFkDQpjb25jZXJuZWQgdGhh
dCB0aGlzIG1pZ2h0IGJlIHV0dGVybHkgYnJva2Vu4oCm
