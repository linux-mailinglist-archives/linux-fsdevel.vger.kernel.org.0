Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0794B5BC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiBNU6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:58:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiBNU6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:58:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8F10E077;
        Mon, 14 Feb 2022 12:58:29 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21EIZBUr020780;
        Mon, 14 Feb 2022 11:26:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=T6V4LHXl7pWgVCb27a9AEG0pjFy0DCaQDbp6lhGgros=;
 b=baK1YHQWvYWgvZYRF7tQBz6PvcaVZSUqG1i+k+tcCyi7k15ZzZCpZ0vq7W0UoMkbZys7
 fBjd94lG92oW6yPijrkujtUuxKD3dzV/QMjrpKR9l/nxVMoVCbEnXEPXw8PkMt9pi3N2
 YtMS5aaRQvOi0+KMwvlnzqrGsky3fTI15VY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e7q2eb1tq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 11:26:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 11:26:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1aGt8oQmO2ZsXzJLyXQC2ars3dtJvgbW/N+9Bi0VhGlTHHatkvn2la/D/SZ9Obz9JcAhn0TbiE9YnAxOxVf99n3P+QpHgoIXHSWfge1XKFKibfNllf9Sn4D+VzEgimTIXqPVdpeZHaTiw8uclAYb5FT2oQV0fS1GPamOe5oTmv9jpqKhyBO9jnbuzag8xRSmxCApDFQQaOdUzq1QHjnS3d8+hN1yKkVJbDCMaqpJjagYj+dPakcUgtTwK8sv35+jrhdqhM15gnt6pzVasMQhYgi7g0/35iyCli8hM6wRXiX+piJhnzqJZbwvo3sB0CHDYIjpdYnGK5W+sQf1lt2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6V4LHXl7pWgVCb27a9AEG0pjFy0DCaQDbp6lhGgros=;
 b=dBjM28SmP3NM0DfNG8haN+NUaeLap6RGvUuovZGu5hbav8Km2QRuk89K/Va1gW3mUXBQ+TI1zjFV7K3CCLs8ag60Lj9kPsV5hjbionEHbLGsrXxwl875Uj+pJt76ZXp4Es/UrS6B/9s5h2uxBxPWxkb+SYWTnA5g2jWmUy7qzZquQLdrWWpSYwAeFMgEWh/nyoU6Yr9JT6AH7bZ2QCvMeupeTSedglNQmaLRzL7RGaTG585mIC2chI/06EdlYF27CMCi3AaIk7JmKmuBNMotDo0CspOqTMgVt5MqdHRsgvaO17dN9mXt87nFVu3trGNQv6hTCyfME41ovrvH9mg8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DM5PR15MB1867.namprd15.prod.outlook.com (2603:10b6:4:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Mon, 14 Feb
 2022 19:26:49 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::3102:7e69:9b1:3d30]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::3102:7e69:9b1:3d30%7]) with mapi id 15.20.4975.011; Mon, 14 Feb 2022
 19:26:49 +0000
From:   Chris Mason <clm@fb.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
CC:     "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Thread-Topic: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Thread-Index: AQHYIdXuUKIGLuECw02OdpDhd3P0HqyTbfIA
Date:   Mon, 14 Feb 2022 19:26:49 +0000
Message-ID: <C88FC9A7-D6AD-4382-B74A-175922F57852@fb.com>
References: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2ca3dbc-7606-450b-d184-08d9efeff282
x-ms-traffictypediagnostic: DM5PR15MB1867:EE_
x-microsoft-antispam-prvs: <DM5PR15MB18674F9C0EE4BE2D35BDD3EFD3339@DM5PR15MB1867.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBxF2M0f7PWoxThUVrGlgwe+CJ+uZqPvKgDu2EkHVXAfc/bBLOcj3kvwzMxotq3Mw0bKD/KkwJ2UwgijC5F2d5BRad8oKaGSE65HCXFer6AZ5VCeFQt0U1wdSNhWaN/Z03hmR5XfWjl4nZrXBlByvveRoG3CYPydypFXBTQ/aOwNoYzWjkfP+VyvjwVftNVuLDCy9HQeSJBUt/V+Rr+5OsK1VhpH+jGI0+iO1I19nsAA/PFZ/r7OrdJNiZGxsJ41UHbtWujbVymad5lDLAaHnVKhLuJLZCJoFC92YjWGGWF5agy909UNKePCrucAPICRbgNL3mlkilimHlQAPNPBdHgpbrEmWPMTJS338WOqnZfC9WFc3Is/RGQnoUbSo+Ezc+tm1uQi9Qh29RL8rws0uHRaPk9dzuH29/h/7DsrOrkW4/pCvxQC7HMCXWUqM+4lR5hJkFph0iKB/G86C+8uVUXeTY7reA0fnu+nJFXMIJ8dpxlaFET/pZvtJFcrzIY5Swg8d/Z+iUeIhU8a4BUg8W/XpIQ42Asc2KLhgi+KEObaTFux8O57fHCOmVsTwjWXmg/CDgyhVzWP0AgY8W4h8TvEO2hFL5lKFJt2oKtOHkEoVDjSGi2l5vzCEqqL0/4njuJTJAFRNyehW/nZ1e9QZQ7qI4n98HiWIt57AhGv9T29m0jwg3fESqRWH8e7dgaIZEQ6nTf/jxn0lopyDLvjgeOkYEB/kllJ44ZFTs7FMRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(6506007)(71200400001)(53546011)(6486002)(6512007)(8936002)(186003)(4326008)(8676002)(86362001)(4744005)(66556008)(76116006)(66476007)(66946007)(64756008)(66446008)(5660300002)(33656002)(2906002)(36756003)(316002)(110136005)(38100700002)(54906003)(38070700005)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXU2aUx6ekgxcUtBVUJRSmpOdTE5a2xZWVVEOUJPTWgxTHo5WkZUUEp3MEdS?=
 =?utf-8?B?MWo4c1RPYk9yZ01uMG8xSkt2MUVCcDI5Z2tidVFvUzVSa3V0Vmk5bVhyeVhw?=
 =?utf-8?B?S1BzTEtzNmlmYkdpdzA5OHJHMUQwWURWYzh1WVJYNFZlbFNNMVRFNENCUlhq?=
 =?utf-8?B?aS8vUU1YV0FEdGppc1JPTTd1OFVnT2JKVFlDY2VTL0o0VlJ1ZnJhRjVHOUs0?=
 =?utf-8?B?SVh5S0FKN2tRV3pacHNucVpiMGJSQVdRampRV3RyM3pVM0laYnFiaVZWY1Vs?=
 =?utf-8?B?VFgxcytERkpxK2lROEVCcjFrT0NMVkdESW9CcWY3bU5kdlRBQmdNcjQxWEJX?=
 =?utf-8?B?czNnSllpMEx4anJ5YUg4Z2RuNXlqZmI5U1VuNXNzNGF6RmphSGV1dGZrVTVV?=
 =?utf-8?B?bjBMS21hVXU3WEM2cnhTdmpzL3lpdDBHRDBuZFJUM0k4UE1KZm5PbnZLb21p?=
 =?utf-8?B?TFBNb29vKzRmajJkNW42eG1yMTJ0QXljM3RqMW5DS0ZJOVF6S2hISWhvdGZX?=
 =?utf-8?B?bCtneTFqdnRHSnJiQytzMktTejh0YlhMVnZDNXIralk1cUl6azlIdFdDUDRu?=
 =?utf-8?B?c2s0dVlXYUNUTy9qNnprLzBncm9VUGxrTFhSSDVqUE5SOUJiWk5tZEg0b05W?=
 =?utf-8?B?SkxyN050VkVFWW9QY05yQ1NLL3VSSmVuYkYzL0pGNk9vbkxpYytzNjhPYlBQ?=
 =?utf-8?B?RFM5S0xtN0ZiRWFONE80MVFaRi80RlZJdWR0V0t6YXFkMmFkSUxIZUJHRGFv?=
 =?utf-8?B?UFBoV3NOVW43UEFYZkxOUnNsNWlIamYvYUlnQmNLbU4xU2l5U2JZQkRuSEN4?=
 =?utf-8?B?eU5mY2htV1FRbURDbEE1ME5MN0xOVVRIbTFKaytUQnFSdGVNa0xVUFlhWUtM?=
 =?utf-8?B?cVU3cCt2cm5uQ3FzazhaUjQvUEs2WlJDQnRlUWZtRE5vQmF2K01tb0VINDZV?=
 =?utf-8?B?cmFtWVF0UmhPWnRPRlRMa29oT1dRd2NMRlE3WGhhaVByNzJmWklJaHNrdVhS?=
 =?utf-8?B?T0k4SmQ5TW9Wa1pqMVgxY1hNMWZQYnlETjkwVVY5S2FzRFdKcHBhaTdoYU5B?=
 =?utf-8?B?ZFhIVTZVdk53a3lqQlpzWVJtR3VXRFZXMi96Y2ZkMmpZbVlJK2tYNlN3dVJR?=
 =?utf-8?B?Nm41UUZOMGlLV3d5Mlp4OEhBZU5kK0cxRXJtekFaRC9vS2t5TTcwSGIyS2Zo?=
 =?utf-8?B?eWkvWHp5elliSnVwTnI5dGNLQmlPZklacm5oYTlPd2ZnSmpZOW9iZXdCeWds?=
 =?utf-8?B?UjZsV0h5TjE0UnJNUDR4RVNLdHVOamZUNVRjbkQ1N0NCamw5eDAxZ0VNbnhv?=
 =?utf-8?B?UnR1LzFSRythNzYvT3BZWXplaEgwamxub01kRXhwbzdlaWFPcE9ObGwxQm9w?=
 =?utf-8?B?d0hvejV1TUxjbGtkUjVCb2pSd3h1c3NaWnlSenFMZTlzbUpzVnVqR01yN3FK?=
 =?utf-8?B?ZExsNEthZGZCU1Q0K08wQktObDlqSyszNEdIMTBtTDFON3VHSno5cVlmZWI1?=
 =?utf-8?B?SHFJV0dWNjM0WDVUR0d6MnA2N3JDSWdWYitVSXEvMDdyVGp0NmNSNVVHSjlL?=
 =?utf-8?B?Q0NZT3RmbTFkZVlFVmZHMnJYa3VkZHREc2JtTW1rS1pSOU10bGczTFljOXBu?=
 =?utf-8?B?dmJJeDJVNHhMdS9rN1RhMFBsbGxwQi9GNkZzT2JzMHo0NGdxTU1QRmVuRVZC?=
 =?utf-8?B?KzluaUkzdTQza0ZOR0VScUJnZ0V1Kzc5YmVuczRWYzlqaTg4M1NHRVhTRmd5?=
 =?utf-8?B?WU9sVENBcTV6UW9qL0plVklhUnBuWkZlc0hXcDl1WVlGdGk3Z0tyV2tpMlYz?=
 =?utf-8?B?d2ZpMCtjMlBWUHBCZ3hGRkFtQkhlZ2pnNzdxODNRSjh2bnV3WFd2YUgzaFl0?=
 =?utf-8?B?dnhxVjBrbUpMRU9CT0JwV1AweUxZd3ZnRXQ2SXk1Y1hBRlFHVEkzbHpuL01L?=
 =?utf-8?B?d25oNmdVbXZEVHc2K2t0SVRweTBmMUJuY051ZjVwbVQ4TER1bWtSVjBVYmE1?=
 =?utf-8?B?QnhDY3MwSGwrZHR6d2IvS2hGRUowNlM1d1c4ZHJuQTRJdkc3Z3dJdENPTStM?=
 =?utf-8?B?QmZ0YjdpczJHZWRhek1EV1RPL01HV3oxLzJDQ0xMdnZjT2pRUTc3WHRmeld4?=
 =?utf-8?B?M040MFJrVjVnM3JDL0NSVmNkRytWMWpPaDJ1RWhkbWxFV3pabThFUGYxSTdX?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4987A87D5718E745936F69498BD6F09D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca3dbc-7606-450b-d184-08d9efeff282
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 19:26:49.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qdk38fp+08GUGDZ8KKYnDBHA+FHnHeNFUYCH9td2oVEHbz2idU1BrC+s6ztf5ZH2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1867
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8Q7DPKQzkZCztscReXGfHJRGIrhMhYLE
X-Proofpoint-ORIG-GUID: 8Q7DPKQzkZCztscReXGfHJRGIrhMhYLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=1 mlxscore=1
 suspectscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=229 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140113
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRmViIDE0LCAyMDIyLCBhdCAyOjA1IFBNLCBQYXVsIEUuIE1jS2VubmV5IDxwYXVs
bWNrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gRXhwZXJpbWVudGFsLiAgTm90IGZvciBpbmNs
dXNpb24uICBZZXQsIGFueXdheS4NCj4gDQo+IEZyZWVpbmcgbGFyZ2UgbnVtYmVycyBvZiBuYW1l
c3BhY2VzIGluIHF1aWNrIHN1Y2Nlc3Npb24gY2FuIHJlc3VsdCBpbg0KPiBhIGJvdHRsZW5lY2sg
b24gdGhlIHN5bmNocm9uaXplX3JjdSgpIGludm9rZWQgZnJvbSBrZXJuX3VubW91bnQoKS4NCj4g
VGhpcyBwYXRjaCBhcHBsaWVzIHRoZSBzeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgaGFtbWVy
IHRvIGFsbG93DQo+IGZ1cnRoZXIgdGVzdGluZyBhbmQgZmF1bHQgaXNvbGF0aW9uLg0KPiANCj4g
SGV5LCBhdCBsZWFzdCB0aGVyZSB3YXMgbm8gbmVlZCB0byBjaGFuZ2UgdGhlIGNvbW1lbnQhICA7
LSkNCj4gDQoNCkkgZG9u4oCZdCB0aGluayB0aGlzIHdpbGwgYmUgZmFzdCBlbm91Z2guICBJIHRo
aW5rIHRoZSBwcm9ibGVtIGlzIHRoYXQgY29tbWl0IGUxZWIyNmZhNjJkMDRlYzA5NTU0MzJiZTFh
YTg3MjJhOTdjYjUyZTcgaXMgcHV0dGluZyBhbGwgb2YgdGhlIGlwYyBuYW1lc3BhY2UgZnJlZXMg
b250byBhIGxpc3QsIGFuZCBldmVyeSBmcmVlIGluY2x1ZGVzIG9uZSBjYWxsIHRvIHN5bmNocm9u
aXplX3JjdSgpDQoNClRoZSBlbmQgcmVzdWx0IGlzIHRoYXQgd2UgY2FuIGNyZWF0ZSBuZXcgbmFt
ZXNwYWNlcyBtdWNoIG11Y2ggZmFzdGVyIHRoYW4gd2UgY2FuIGZyZWUgdGhlbSwgYW5kIGV2ZW50
dWFsbHkgd2UgcnVuIG91dC4gIEkgZm91bmQgdGhpcyB3aGlsZSBkZWJ1Z2dpbmcgY2xvbmUoKSBy
ZXR1cm5pbmcgRU5PU1BDIGJlY2F1c2UgY3JlYXRlX2lwY19ucygpIHdhcyByZXR1cm5pbmcgRU5P
U1BDLg0KDQotY2hyaXM=
