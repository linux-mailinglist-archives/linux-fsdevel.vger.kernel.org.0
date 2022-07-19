Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DD5793A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiGSG5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 02:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiGSG5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:57:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B326AF4;
        Mon, 18 Jul 2022 23:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSK892+wqISFcqqyAsimna9BVrrOyxffuh1GgR6+odu/qwLvFZlxD16wNeumyTxab6C5BI1cYnyTscJhrI4KnQn4g5aWQSV4I/YYqck8aukUYwGWXBD0cmEItDZI/WP4EAZdYASow62zy0Ef3t0DN8wLPki2XN2aoWBFsK8KnI0L9BvjVL9ZNUqq8tANcsy0yJqWTAjtnafT23uGDovdKHNTroclX7JjjDxqvP8Q4bAC/37erAv+zXVAs2QaOiaqoHsXPqPZDyATWXzj8iTa3CKU3RrnH3KxyZyt12y2tyCY4sj5g9nFX8KzHc+yNJLys+4nvslpgFyWNZxsoSAEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1Rm4IonEpjSZ8xNtsayYuTBonwhV2tsouZUqA+NyNo=;
 b=JyDIkmr3go8MdoUM4qwm8pxoyojD8ugZYpfc/wsXnCwFoqUQ/yjzQSrXP+UNL4XlQ6OZ4vjXSkhgg/u6MjSBXp2cYak+JFLSYOqk8bOPilkmC7Yi3MD7qV8jfVHNuzZaCaLFDi58bhTcnh2KHeoHxb60pfp6dMOVep0NE75fg3lbHQ6uH+sor8e2G9mrCD6dukk0iXKbQsE2e9hbakhdriX/RRo6nOOc+dHONhu4ga74hzqtuUswAFSUsOP4hKsLgsNYMKL1h/TJhIDayhCuneUKmbB6FfPZwGzi3PbiPuj38mL9yvbVdtnFn1+IDIYrcax0BDXYDz+RC0/c3x0Dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1Rm4IonEpjSZ8xNtsayYuTBonwhV2tsouZUqA+NyNo=;
 b=d2P21jrbBAl7j9P2g1ehIpzAZf/LXAVmvd2qK5jXEYWBLKT4Hh6y3wDZiDT/bWYqyifgBNhpPiWkzj53Qn86xjwCxbpKeXRWyvEqbrlaFSOJR1ZGVxhXWdWWMXqC4T3zl3s/TtM6LCZi8CKYfX5v68ZjKXrSeXt3Z50nuLlHVF6RWFqk/luI7T65UXBFXwgFUN02/aCc2hWY7fp2CddaNOxeZFIXgWmub6qGjJVRvlr2lqVt9EmKWpQdfHDU/GgA4q8NDDMNTRzO4S0PfrKgixo9kpSryBsiNz2QNw0bSIkZwZCreNGykzahrUSAgsc7XkHD4AJ/mYn/BXtI+Lyobw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 06:56:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 06:56:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iomap: remove iomap_writepage
Thread-Topic: [PATCH 4/4] iomap: remove iomap_writepage
Thread-Index: AQHYmyXxhK1od9xNkkO4RvdYwEAA662FQysA
Date:   Tue, 19 Jul 2022 06:56:56 +0000
Message-ID: <14beaab1-ac95-cef4-3f37-005c00e9b87d@nvidia.com>
References: <20220719041311.709250-1-hch@lst.de>
 <20220719041311.709250-5-hch@lst.de>
In-Reply-To: <20220719041311.709250-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10cf3d76-7454-4a95-42ab-08da6953de90
x-ms-traffictypediagnostic: BN9PR12MB5307:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3E6eincLJYswC4AhwiDBXSwskRImBC9+NYQtqmFmFdlVORMtw7O1DSIPLb6Q2f1001p956rRqu4N7B34NMax+zz3SrqBhEdArSThJPbpVeTZq0CmFw28dQgr/El24fw6PDwcikfZbJ8BHaZHjyfowisjWRt1AsVbBWaw/n+wNZ02z5EBbOKUzlhPCCQfUReQgKzpfL7VAPLJ9OmN3pN+DI4uzZAMBc5ggGjY20W6tH70/RSyY5bRnWIRZOPDW55vanSkwimj6NEa2JNNUWt1VCC9XFUK9GJpWxY13r+3uYh3S0mfiGu7fXeSSSa1sRKANlyJFcDsXt38D48ey4te/bUcEs1QviH062f5ZwDUT4mA++RTfFAHPhXkFq4IAvHzoyH74Fhdt1aGsORvNf6J11nMKiemZUcDqBk2x9Hw3HHUblvvo3BvsWWlevRyMpBvLlLXbNq0DVFzYw/etz5ktcjd5/4Y3qdnOSWEn0IH8lbf/aEA0qlxiQ8CG0PMVAJ3bXbLV6G56XM06B1Ev48s+5rGIR35HLe8t6/Pq7xSmwtlzTv2l+zh7+pzPtsHJRD+8O+/wHCsKBZrUQMKtxurpqsqk6WPePRDoPk1BIlBr/sgjygYLDyt+nG7mgjj2o2srFIDs3HBZmRv0WfG+okBavrs86So8/fWJI/3kGncxsU+FFZqPL8h1CYX6RQ7d9wpdimFkiL+hX+2OwZgD5CMBTgevXiw8FFWytDpddiZboPW8ergIxWKeC+e52zZkN2OH60fkUSltMDr/13NGmK2dshpuXRGp/A6XsyL2j2qWpl6tW3/NLRy2q/3dXPuiTWxHeCyBvBzxAPITnXnm/rTNu3ds15f8nNPWpwbKrJUiKmFTvwTcDPTmE0t+nEARmi8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(54906003)(64756008)(53546011)(91956017)(41300700001)(6506007)(6486002)(71200400001)(2906002)(6512007)(110136005)(8676002)(66476007)(66556008)(7416002)(66946007)(316002)(66446008)(478600001)(5660300002)(4326008)(8936002)(38100700002)(31686004)(122000001)(2616005)(36756003)(38070700005)(86362001)(76116006)(558084003)(186003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmtSdWt1WE1YNllqbXpXaDkwaC9MZ0Q0VjAyQ3l6d3FOYWR6YkVNU00vSDRB?=
 =?utf-8?B?YWYvWFdoT1lzRDdxZVFwclZDQmVZa2wvQWpGMGZTZ21ta00yZ01NVU9rd0py?=
 =?utf-8?B?YTFJYmJIT2xIMHVudEZuR3pxbS9SZFVzNjkwYkkvN0tUZ2VnTkhrNEZFUGsy?=
 =?utf-8?B?dG9PbC92VEpQcGpnMHVuK3pvVXZZUVlSYUd5TloxdmRJaE5MeWkzR2xUNlNO?=
 =?utf-8?B?Wit0SHIxT3laTmI0Z2k4Z0d1bjBkN0hmYVNyOG8raWxnUjd5aVdURktURkxo?=
 =?utf-8?B?bHgvbnRpdm95UlhEZERzbUMzWlVoWitjRUpqSzBSMmNKN2pnL1pmTFBxdjBI?=
 =?utf-8?B?eUM4U096cW5qKzhFNG92SmxFd2YrcjhZOHkrQ0FaOURORStBVFE5a1RSZFU2?=
 =?utf-8?B?bmFCU1BQcWxiMm5QWEZnczNZaUpmakZCVjh6QVJtdDdsUS9oVXlOa0FzUkQ3?=
 =?utf-8?B?R005WWZJNitMLys0YWRMUDdhWk4ybHpVQ2lYaHhsa1NXL1J3RWt1VTNhRXpU?=
 =?utf-8?B?U0w1UW9EYitHUko5THZqUGNFSEhuTGxiZThZRUU3ekFGTzFtRXd2K3hxOTF2?=
 =?utf-8?B?V21YVzhPMlJuVHFObEFUc3UrZkR5LzVWaDVBMGNXUnNYU0JmUHYvdXdReFMx?=
 =?utf-8?B?Qis3MkZ1dFpjRk56bXBPYm5SYkdhWURRTUxwU2RGZkY4LzlSc3Q1eHpTRGd1?=
 =?utf-8?B?RzBFeXMyMUU5NEE5dWNqSUxSQmQyQ0JGZUJlMk5aTW9yai9GNWVxZzR5Q0pE?=
 =?utf-8?B?VUlhOGhuRTZPWGV1RVM0d3lCdkd0cDlONzdVeHg3eE5SU1p3bEJKaE1hUFg0?=
 =?utf-8?B?bUEyekw1QUFpb3Z6Ty9ybGJzZ0VWbG1aZTZEejZnZVdUbXE5TTBwWE5xaS84?=
 =?utf-8?B?NmZ6ajZsM0FZQWNRMndqMXFweDBlemhPTzBCbDBUS1ZHeVM0YmNPclIzSGNJ?=
 =?utf-8?B?aW9nNUNZeFRoWG9mSmpMOWRKN3ZaWXg5YXpxNVpVTnZwYWtJWGNtcTBGeHJ4?=
 =?utf-8?B?SVlLbHBiZ0t2MGlvNW5aZ00zSXRyZVlYU21PSkVqTlNQN09LUkloWkYyV3Fi?=
 =?utf-8?B?dFpPYStqa3l5cVg5VVBFbGwwcHp1YnZRZjNRdC9Bd2QvSGpxUWhzOGVOME9u?=
 =?utf-8?B?VndRM3pMQzJadHYzTHlWR1ZFcmxOSGJtRER6OUUyR0t6Z1EybThXMUtpenRJ?=
 =?utf-8?B?YU5ETGw2bmhSMFpJWVBJTVRTNit3RjBJTFptL0d5aXlCSThkeElmQ0RVdlkw?=
 =?utf-8?B?c21KZS8xYlkzSXdtaWU5QlRUZlo5bVJUVENla3VNOSt5ZHhGTDBuODJvaVFO?=
 =?utf-8?B?a2czWmNvYlVsN3hIY2NBZTVLN290U0lLWWV2ZDk5SXUwMWluV0MrM250Y3RV?=
 =?utf-8?B?Vk1EcEdwSTE1bUJWb1NTMU1iamFtMDVDRnQrRGY4SU4zZjRyeFYwWXRGeEYx?=
 =?utf-8?B?d1YrcEl0MDlMRkRaakZaY2FDS1orMk1ha3VlRm1WaXpTSGx2dEloK1F4dE52?=
 =?utf-8?B?L21zcG05OVZhRkNlc29oRDMweGlOQjBLUXhJbnNLbmdqQjJteTBGMkowNFcw?=
 =?utf-8?B?bnRnd1VSdHN0ZGpneDNlRGplNStmdFZqd1BzRUc1bW5tRlMzZXc4RE1kYWM4?=
 =?utf-8?B?SVJRR1B2RWJRMm5ZQWpDbzk0Q0d4VWx5SWhKWVJOVWZGRTl6a2NRM3l2SVhC?=
 =?utf-8?B?TFVlV2pNbUFjS0JxbjFkU0JhSHlYNjBFTUFzb2FXYU9hK2tyQnJsYytMd0d1?=
 =?utf-8?B?a25SWHpDZDFNUExERHlUd2xCQ0NqK3h4RWFMSXJBTmxTaSt4NzVzSnFkcFdI?=
 =?utf-8?B?V3B1anY5RldySVJLa0VpWENuakVZbkFzSDJZbmtoV1g5d3d3cEJSY0pSTnY5?=
 =?utf-8?B?YkV1UVUyWUgyTGZ5ekJacUp5amZYV1ptTnE0cG4rbG04TnFkSVBvZDQ5aEZV?=
 =?utf-8?B?di9hMVA1bVhzRmVoSUpkQjVibU1Tc1Zaa1ZMMmF3cFB2VDhDMGs5WmxXeG5Y?=
 =?utf-8?B?STVSMXVMRVcxRWtTUXE5Mm5yODNVSVBDY0RINFpmczVjeHRRNDh0NGN2QVpG?=
 =?utf-8?B?b3V1ZDE1aHAzM3kvOTlGR0FaT1BMRXEyU2Z4UEZQeDRyMDM2MlVxb0N2ZzNL?=
 =?utf-8?B?TzBrN3lsY1ptVmZxK2xvVWFza29pVnhPQmtCYlE4NHNqTkI5VldtYW5KYk5H?=
 =?utf-8?Q?01A2msTHSN5a2Yjf/v5rAijTdcLCUXaddacfWYsG9jp5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5870620A071C454E980852670C1410C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf3d76-7454-4a95-42ab-08da6953de90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 06:56:56.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1T2s7OCGjmV8iK+PzRJuXOGujT0q2UHp3Ni46RwzZTbRHLFk2i02OBxrHQIXdUnxc7keHHd8mqpU/C0/vzCgaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xOC8yMiAyMToxMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVudXNlZCBub3cu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4g
UmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2Rj
LmNvbT4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
