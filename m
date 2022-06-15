Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2075A54D43E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 00:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349879AbiFOWIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 18:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349687AbiFOWIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:08:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD51FA63;
        Wed, 15 Jun 2022 15:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj7Nd6xwsu19Dvf7VqDbz6gsw7phR47WTA5senOssh1O1yi0S0NpS6Zl1LIUBSGqTnghYRkPnhDEBxGuzUUJwwJz69mVozfPSeo10DvnSuYVxG6ae9BK8BQZtkyWcE4jsKF3Rbvx7LXQiTq+w6HiXpMcXNjZ7yvrx2Y+X0A90mjcEqZSvylGlq0WWXf5jldGZ9/jJGqND07WmhOE/10LzSF06+VoinPIMSo+uDJPvym+x3syUltAAgdXXIqSZmUhzoB3p9qrin2+GC1Mo38X3dz49mOdeSYEFX+/deVsXLw1aja2QU1n6ET+3Im6+yCHE+avzeMbCpxn7cPso20huQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZYVQZy7I8wmjJVXXETX6VVH56bkWeEgOjVNOxBSpx8=;
 b=ihrXM0fQchJdtUaKeCtkh5c2+bGm12But9ZTFFl/qz1P6nYnvh0fSS1sRQaPR51iJYHXmCnnCQs/JfQ7qa7VjPL/1sbqIFy4iFCCKsuJ0ifFwlJCvuBDyghawPMHIViVgqawAhNhnOeKYaVi3/O0ppunnnJznNHj/+Wumq8TzIeX/6eTMENaMS/c0EpIcCHKvU54PxZjQjFVD7bcs4ar+2dpctqsBMrUyfwBNpnhooFXN906cqo/aM00Hrb6UWfUZhNJ89LfOW1lalI3t61cTHAWe/3bGATSflOUonfBIUbRgb/OXAJkxnV8jRgKhUNySl1aGbjpeaFlBNyhOvvQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZYVQZy7I8wmjJVXXETX6VVH56bkWeEgOjVNOxBSpx8=;
 b=NhIv4aID/uXmt1s1drRAZse57quqJcRN2U7Ql8cr6EEH9R9m6aPr8RL4Xd99LEF7/ISG/zQvxwoWpX7UJ8iqOCKlUnyxNOvtCgjYcUOrsnRvsH80TBlz0DI8S91VZnM6YIj5/AgfsuM/1ihGHN/AjZE8j4Md0CnYWqQ5dP5Mzc9x2ukwgsVpuWZPn3oH4+RdY2Xutk4RZcJwOLkaUWqwGV23MVNGH53HHzg8Xcv5gDpv6FWxmmJey8949tvUE3XSL16Pl42O0bWHLxJmwObvW6jTwdtHKzWg0JLhWzD+41wbx/ozviVm2N69mbCu2cMItyfOXOl3RkNEso075b9vGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4829.namprd12.prod.outlook.com (2603:10b6:208:1b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 22:08:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 22:07:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] iomap: set did_zero to true when zeroing successfully
Thread-Topic: [PATCH] iomap: set did_zero to true when zeroing successfully
Thread-Index: AQHYf880DMY9PWiyM0OMC2jpqIQfjq1RCSCA
Date:   Wed, 15 Jun 2022 22:07:59 +0000
Message-ID: <58acd948-4c28-123f-14a3-fef95f4315e9@nvidia.com>
References: <1655198062-13288-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1655198062-13288-1-git-send-email-kaixuxia@tencent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 814aeb90-5eff-49ad-fe6f-08da4f1b8283
x-ms-traffictypediagnostic: MN2PR12MB4829:EE_
x-microsoft-antispam-prvs: <MN2PR12MB48298E488ADA989A39A89CBCA3AD9@MN2PR12MB4829.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enPzGPgyr/LoOUkoTfLvCdL3CaVFkMsUnm/bwRkvboXgwFuOyS/Qs+IicbEVx7GP5vIimQmbKS56lwI9eVX54b1VDPu6EgZVE/9xWS9s9wJN6t/Ue8PzwBepLbtqC59ERkiO2tRNMyaKEe/L4SIBetkIDwRitpDs+aJBZanv1erZiON9LYsHsToAfkEfgPfg3fe6yN0DF1xNrKgnt3onQCT+WueTnlPAK2LK+2PGYqnEp/CLOQUTNgPUANqORf4mjYyE6Or4HA0YW1veV94xsDMQn3vOlIlRaTuIcrNYF7Y0tp04jvcpHGNCk5Fac4PghhLjAfztc64wGg++xJIucbMrn3N78BUnsgSHYGjKsgCOF8N5btqwVqz6Dxz4nU6E253Aw5rNSw3Sp+bIr6D0OMMm+eUB+HkdBDH3OFa/gm5DagEfED2uch1E2YQgLwQAA90Xv1voo2qXqVdt46jognNR528K/ed+B3mJTpVaL+A2BfgaoXr++LLaIFuI3PRX+r/ql8QJXM3JgHt9P2IoJlnUC3XJORSFKqBBonDvUVLH7NPPR+1o4Jdm3DB1k+rn3FWHLmi477LB0J5iRL3RYooAh3gPdbhTWucGPZ/pwjW1S89+pphKDtPSyVn2Geg37PE9mpjCiLLdRJaUjmDOSIc9AialGc3CkpAeg4sMffPpXRL3GviXwI2TEZwA+IsKur7K3lfhWLSDisLWbPXp0VhWUEtQtq9h5HFP/n5JnncvimXzQsQBR1YwTiy7AxtBfoOjH2lhR2rKKwcSNDETrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6506007)(71200400001)(2616005)(186003)(6486002)(508600001)(316002)(36756003)(54906003)(6916009)(31686004)(76116006)(38070700005)(66476007)(66946007)(2906002)(122000001)(91956017)(6512007)(53546011)(558084003)(66556008)(66446008)(64756008)(31696002)(86362001)(8676002)(8936002)(38100700002)(4326008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0h1L084VjdDc21OY1lsemFKbzJJUFBFbDlmeXlOUWFNTWluYUNKZ1pCTCtZ?=
 =?utf-8?B?WWRvUzBGNHcvS1NRY1REK09DZmZ2cGJ2UDJmRnZ2QlF1b0xHajJKWUdSVjY1?=
 =?utf-8?B?UllXSHVUZmZVY0ZrMzJWWHl1V0R0UWhMSnhQdGI1aE9BSmhlYlpvTnZpNkty?=
 =?utf-8?B?dG9SamMvdEFCYUpJdU5NLzFtQkVtMVZ4ajJ1KzRTZHpGWDBreDRJNUdiZDNs?=
 =?utf-8?B?aG5VV1dZSUF3QlBWUE5lcFJMcmZDYkhlVFkrMG12ZFFaek5pT0JHdWRHdXRU?=
 =?utf-8?B?OGRuWmFIL3ZoN0J0eHR5eS9Gb0l6TUc1c3FmcTViMWs3eko0cjFHWmYzT3RU?=
 =?utf-8?B?U2FHbGd1eDd4bVUwRWl1dXdCVVNqenlSa0VtRVJ5ZWZ2VlEzSlVseGluQldz?=
 =?utf-8?B?RHYvazg2MEtmZDlLaDdab2xLQk5wa0dnMWVNTktOcHlxVHZveVo4Q3Z2TG5Z?=
 =?utf-8?B?MWVqK1VQc0xMMXk0dmI3dHBEVlJRSW80TlQ3am1rcFZKYmdsZmhxbDVleTQx?=
 =?utf-8?B?MnlYR1lEYmVMTWoyNUpWZ2NGNnJ4d3JFcFpCTFhTRHdyaDUwTkRqRlNIWWNi?=
 =?utf-8?B?aDVTODdoVENHWE5QOGhlZUZLWDJBbUxyMjJnNHlBd0JJRUFFeTJlN2tSRXJ3?=
 =?utf-8?B?U0NTcTJvWGlKMitjK2I0QzlFMWMvbzh4VEgyZ2xEdnRnZmtRdDBGVXFOZGgx?=
 =?utf-8?B?Vy9VSnBXeWN4TENtZEE4M0hrUkxNSlRHVGJZV1RPV3lFZmNjemtMMGl2ckNm?=
 =?utf-8?B?UEg4WEkveDB5OUN4NlI1RE1GWUVXalNWOTA3VUY2LzdTOE5yU3NuVUM5NjF0?=
 =?utf-8?B?VTZRSGNOeHd3cU52RnFWRFI1TjFFM2dha2F2V0t4ak9MbFNHd2VqdUJEbkJ6?=
 =?utf-8?B?SVg5Mlc3dmVnWWZLdjZ0UGgxUFZXdTZ6bHQ0d0J3emd4QlhzN0tXVS9FUUdt?=
 =?utf-8?B?cEtnY0lIeGhYVVlpcFc0Qml3Tmh3M2c1N0VyR1ZnaGRWTklFWFpNZGJ6UTF0?=
 =?utf-8?B?QUxmV0JzNk9USW1VNEc3WGp0blFWMWRkVklQWGtMM1phbDlwLzVkRGhJc3JV?=
 =?utf-8?B?eU1IRk1JTHNJbEZTU3Z3QjdWUko0SkRZZkNMUGFEa0d5Q3laRWtKempCMXNY?=
 =?utf-8?B?YVJrclVRTHZVbGNMa0VuWDZ3TDVudHQ0R1F2OXNINmMvMUJEMWhlcERVTzR4?=
 =?utf-8?B?L0VaalJ0NCt5azFtTkN2UC9YdThad1A3OTVwSG5HaEhRK2YzRHdZOHo5d0Fz?=
 =?utf-8?B?ZWszMVNOMHNId1FvbUE2eVpTU0M5MDBaUHhIQ2ErOEFVMWM2UGs2ekdUR1RI?=
 =?utf-8?B?c0JXVWFHVElHNy9TQUJhYlh4U1I5U0h3Mm51dlI2SmtpTWRRQ2JxbHFTMDM4?=
 =?utf-8?B?VG5iclNBMlNFTzM1U0JiTXVqd1NuSEgxNXRiSEFJdkVoRXR0dzhOaERac1h0?=
 =?utf-8?B?bjhQOTFuYWE4MzJ6b292am5OK3BsVTREZmVZUFRKOHdnclV3WFRzUzJ6SEJ6?=
 =?utf-8?B?SENxakhaOHFoWXNiYTF4b1dZRm1ETnpGNVN4ellIb1VjTDdoWXMvOHdrNXZF?=
 =?utf-8?B?N3dibXEwSzFGZVJGaHFUOU9VQjNuVC9Rbi9Zc0x3d0x0Y0NveFpXRXdBVk1j?=
 =?utf-8?B?ZVNWaWRmWU1NWHh1cGFGZTRSNS9uSTd2aWxDS1lyNTRWczZmRWRFNUFjdGll?=
 =?utf-8?B?bUliVjZBMXRKZjBVUEpjYWlFUnIxdFlCRFBOM3Vab2FzL3l5Y1psa0tzTElG?=
 =?utf-8?B?VGRIdTJDOHVYc0tuNjVjandPOCtSaGIzWFNIaTNqTElzNHhpSmdRc3FVblhq?=
 =?utf-8?B?dnQwdi82MjhBWWVSVVpwaDVmNFl4dGprS1NvZWdhV0hoYTZMNDg4TjB0N1Ru?=
 =?utf-8?B?TE5HRm9jMElwdHJWa0UwckJUTWw4WDBLYVBVa1puL0pLcE5tOUpaa3Y1emNO?=
 =?utf-8?B?Vmo5Um1qSWZPMzhYb1QwRTdUeVVNWmpjRHRKTmJwMi9nYlVnNDF2WEsxU0xw?=
 =?utf-8?B?V0dDYmdIcnZNSytpcDZIOTZxamQ0SllQUDMyenpqdTFjNFpOcEtmN2hXSElZ?=
 =?utf-8?B?MUxrL20wcTlHbWF6ZzZ2eXlzK3JYOVVET2dxQmI1M0NoYmE3Z2todmd3Q29V?=
 =?utf-8?B?T2JKRmdzUkNCRFEzaEVUT1ROQWhSWGIyb0cxRGlLSjJZUlJUdTYvYkZzY0dR?=
 =?utf-8?B?MTZYalo0emd5MUZnbzhZYmxkYWdVUmovRU1POHRYWXR1cW1TOVlDcjVVYzVv?=
 =?utf-8?B?dWlnZ3lMTzNHSGRWY1d3cFZtYUNsT3NmaWNYa3NCWG9JNkcwTERFbFNUUllh?=
 =?utf-8?B?R3FhMXlwY1YxWjIwUTBnWnVGNGwveC84WFZzNjlTUTVmY29jMVhobGtURFN1?=
 =?utf-8?Q?RH9HmsR24zFjpaEY1kuWUwwxCyTY3Gv19gdynGXXktBAs?=
x-ms-exchange-antispam-messagedata-1: 3PUgDfBx3uiWDQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <17FD540497FB7E4B94840BBF7714C0A2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814aeb90-5eff-49ad-fe6f-08da4f1b8283
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 22:07:59.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECx15b82gQ8h3pBvRxjlwQiW7tBj6BOC2/FrMHmaDsZG5BR0iOeCp64pnldQ/Z5UZsbmQtxpYdZFaszNVyRHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4829
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNi8xNC8yMiAwMjoxNCwgeGlha2FpeHUxOTg3QGdtYWlsLmNvbSB3cm90ZToNCj4gRnJvbTog
S2FpeHUgWGlhIDxrYWl4dXhpYUB0ZW5jZW50LmNvbT4NCj4gDQo+IEl0IGlzIHVubmVjZXNzYXJ5
IHRvIGNoZWNrIGFuZCBzZXQgZGlkX3plcm8gdmFsdWUgaW4gd2hpbGUoKSBsb29wLA0KPiB3ZSBj
YW4gc2V0IGRpZF96ZXJvIHRvIHRydWUgb25seSB3aGVuIHplcm9pbmcgc3VjY2Vzc2Z1bGx5IGF0
IGxhc3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYWl4dSBYaWEgPGthaXh1eGlhQHRlbmNlbnQu
Y29tPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
