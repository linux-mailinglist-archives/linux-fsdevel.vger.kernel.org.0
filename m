Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFEF6B1865
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 02:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCIBDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 20:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIBDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:03:33 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95D62873;
        Wed,  8 Mar 2023 17:03:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V96lEws3kenQCoO0Vc5gwasWbvCXzUOjKbGq2LQ3a2yabiuC7M7Fkn+9ERIP0jncnh6w6djtNaYVURuv+wZWD3hq4+TilaBAhLa/wivkPJ9fxB7AoIMDIQWxwSlgJsJdkrBzEoNweYKOw8m0NCC/H1Nv5kj3QERxWQP2dO4GxG75pafyvvMsVo5N62sP6zCVSDVTeCXVKNXX7RbdCMJPs9feoQgtUKJo5/E+Lt1Bx2+sPx6/wBomfqufgJs/UbetvpqKvY7mSccXnZcqzlubft9AdfiPUDykGKmpC+QdQkKVIpTlnAWIzQTBojj+X1AJZjM/VWLLIL74fLgzeVt/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdSMggKDt2IfsUu3VrgpTm0RzzlA6Bllu+Bk6EhFTvY=;
 b=AG/jinBQmmPPIvkUXCtjbkp0QqZnQYKUGy05a1vP9iS3hIQVtaq4IKBTm0mci/h2zDhIZI+jbRqJ7NKrOP6BiE3Ew6ATwhCqoIWCi9e9r+D1vupwugf0kW0sPXfpReiI2/cczDMascnCdAlwfEIItQL+7qLpASePmYH9RP4YTbkCvHoUeosodEO78f/W7veIhAd1b5Mfe/gZhXsKz+P/iqeJoH0zEIf0bZaZCywDLWGCavOTqfikQ/lp6ANv8f5+pjSQfKNdtgTx/lQCUxBMkPGKTL5ANvr4MpD1fDcwF1U0pxOw6BxXYYEbOQJ5cWXWtWoCe9VjrU7LarNkhFmNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdSMggKDt2IfsUu3VrgpTm0RzzlA6Bllu+Bk6EhFTvY=;
 b=aTvvnoALYP8eMAq4i4+WDOmzemOFOm+PCoAn0WnctYjr8EdpkmdpWHsvrBANAYRf83OVjmZVNGVxrmv/GrEWxK4nSvKMJfb39KFIJKkYG4PTv4q27+/I9DJuO32PMBvqwA9AGoVoMB8Rw9xrd3lwog4fzyenczIsTeWGZzgucTrkDr54Qoq8zBu51NRuGKmDDU7+29wEh4mSYyu6PS4Yju0LSVIeZmn1BAwxrdK7rn9euS22qIKXIoLDNoSgUvpND/JD+CgtfxANyu5vNjy4pIr/ID7Lc4fyvPaLdYT8m6/+LqX/1ImR87KsV+XcBXaswuIU8vljo9SVA7ugLsbawA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 01:03:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 01:03:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] splice: Remove redundant assignment to ret
Thread-Topic: [PATCH] splice: Remove redundant assignment to ret
Thread-Index: AQHZUNG8E042L+4ihkmLXF77Zg+jgq7xpEYA
Date:   Thu, 9 Mar 2023 01:03:28 +0000
Message-ID: <7dc1cdeb-f2f4-617a-cc6c-934f4780f23c@nvidia.com>
References: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6713:EE_
x-ms-office365-filtering-correlation-id: bea4f141-4fb5-421d-c4ea-08db203a1814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HrYJD4tTXP+tqeDm6FWN+GT5CuSlqW0iPsEP8KGRM1Jl0kwG0KnKheKPqrMBrGziDtafP3LqrO2CMW2jzhJ2imeL9d2XRQ8h9D3aw3nv8I1Pif8Ysdz9LqraFTjonKr5ui0z09zBoqo1YvFLWQKvugdiPSIinGXXNgRuFW3n21HtcLZlLGTYuA138Ecrz8+wEqgpFLULisaXGZGsS7/cJp3FCW39POidrbyFGeLiJaUGzUFGH3tpH9EHnF+gQYTcA7PZ8TBPYJQsbQEzKuCdamt2ILuOz34P9NxnL26gSF2qvpUlInT6MsjYVOVNQdbnP8OiX6KYc70Os+Dww4fRGw1E0IQN9LrsS0B8bGdA+GmlJdQmSP6fTjuvu7i4PYNugh+k+t3qRiv/msrLaQ3jyVUyJ3gAhb6KT/Fsxjg3Et8Nsww5m7Pez9kgxO7Ila/i1rJjeL9NNFbE7FasXDIzfzGrKVLXgKKaxLfYCBqGaknsQFr4e9+JQO1yNZW/fZN2bjV3IUU3V7c50p8u7O5Aj+UtXYA/LGScbO1g6z2pvFeKDkJj18Ppi5X8Ol0q2i7H8TUBpZMmm3G1nTnt0OSyR+uPrlZURW9w0dHp8P37/+E1x0GP5T/UcA1VpzblwBEqF3tB0ZqueKf5PGlhWGiLkmyosynx6s+0U9Rw65LZBDRVQg3PCFBYplAnxRa3TAjrCgBP/zgqtYk8SrcPJIgqrq+9WCUahSzTCO5Ndq4cfGw2X3IH0dMGT4hlPQk4E6WXqVork/HOQTZFDwJFRw3L7SJFQyIeuy7dGmtXgmEP9KhvPiZmM31tsg7r3NR07qDo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(38100700002)(31696002)(31686004)(316002)(86362001)(110136005)(54906003)(66556008)(8676002)(66476007)(66946007)(64756008)(66446008)(122000001)(76116006)(8936002)(4326008)(91956017)(36756003)(6486002)(38070700005)(966005)(2616005)(478600001)(4744005)(5660300002)(41300700001)(71200400001)(83380400001)(2906002)(186003)(53546011)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnRhdlczMVVMci9wMUJHRE5CbDBuNW01cGFQT0EydDVTQ3JMVkxSZUNOQjBP?=
 =?utf-8?B?YmJMeU0vdm1RcDJDREZKYk1HT2U1NTl3QXhBMEFEVXJaWGgzbyswQmUvNFY4?=
 =?utf-8?B?YkNxYWR0dWhXcTAxM2gwa1VjMzVVRzIwN25KR0Q5L09TSGw0MlVEVkFIbEpH?=
 =?utf-8?B?ME1WWXYwUTJiMWM1S0JIVEEvVXRkSnJGeFZLaGZld3ZnZjM2aU1WckcxazdZ?=
 =?utf-8?B?ZjRBN0VxaTgrd1NGVFBhZUl4WkVJb1V0SiswOXhLRFFjQnRyczI2Z2ZZVVY3?=
 =?utf-8?B?NmhhTDBTMXdNdHhZMURicis0bURCZThkdnBxVjBBVWJlMU5HV0pYTDJTTVlT?=
 =?utf-8?B?ZEtiMU4vREJQMnpFV0xVc2RtY2pERk9xTmw1TmJaYmIvMWpUQ1Jza3UyK1Rl?=
 =?utf-8?B?VWRQVWEyeElPMlNYdFNwTFhRN1oyOWlBRzNZY05zejJOc2pUNXM2VGVaTVlN?=
 =?utf-8?B?VDJFNjJUSU0rcFhxWHZONUwzUW9iQ2RQVFFmQ0UzajN6SnprdlNkbXN2TDZX?=
 =?utf-8?B?ZERPOWp0cW1lLzQxU2ptNks5VThYcmJXRlladVdZellRNjRRZ2FFeWl2SkQv?=
 =?utf-8?B?clJFRnYrMExOV3l1YW1QbVh1WGVwWHptazF2cFNHcnk2NVJCOEVGQi9XOERs?=
 =?utf-8?B?VnBReEpZWkFUQURjZTFYcXBhNDBLdVhEekRDTWoyOHJQVnI0Q0xMQ3RncDQw?=
 =?utf-8?B?cElmbVdiWDZZaHhmU1pPYmZUVGh5NWxWcXlIdC95VzM0SUhtdE90QTlnSjQ4?=
 =?utf-8?B?NERDc1RpemlpWTlQQ0ZRUFhHbDZQRXNya2h5U1FXc3RlYnZjRFFCakwrYlBl?=
 =?utf-8?B?eUk4aEtSYWhNbEM1cXBvaHNhMGJTZzYvZFpLVXNkZDlGYklleTc5N0FQWnhP?=
 =?utf-8?B?di9aWHYrRE91SlEwVTV0Sk92MUN2YThPT2U0RXBYdlpPUktNRHF1VkU0ZHZ2?=
 =?utf-8?B?eFV2bFovYldZdGkxTUpYTzZsWVVEQU5kMVRKeHROVEJETnN6eXhNaU4vUnBX?=
 =?utf-8?B?TVpJY1FsOE0wdGlsL2dSV2J0WndXd3ZxVkMzSTJML0k0UVRCdy91MjU3MU5m?=
 =?utf-8?B?TWo2aGhhVURDQmVCaDhYRE1FYTVQdHdIL3Z0Q3daMVMxTmlQaytCWExWamFl?=
 =?utf-8?B?cjNnU0U5aSs4OXJ1NWxFVWZZSWRpckFTSW1ha2VkSWpYUUJUU3crbUdxKzc3?=
 =?utf-8?B?dVpJbnVuVkhUUitEYTl1Q29mbmoyM0lDRGx6ZmpEdTRkTFAwRCthNDJ6aEll?=
 =?utf-8?B?YURrbFhCcGdDR1ZxZ1J0WVFkQ3RoekVlR3R0UUtOY29JNnRQVElaMmZoaFVQ?=
 =?utf-8?B?djlNZEdITkI4QXg4a1NyRzdMUy9lRHo1UXJHQUxwdmJ1alZDTk9DdC9JZlZE?=
 =?utf-8?B?bjRXeDlFWlFXdytOcEd4SDVOOWM5VVc0VnhBekM3aEhwWkRGTTU3NnVGV3J0?=
 =?utf-8?B?V1h4TTdWQmVod0pqaUpERTZKSkpLaU5IaXVLMjljSkpoNEFMbmpXdmdOSWFu?=
 =?utf-8?B?WTkvNUxXRVpYMjhuNHh6RnlMT0JXc09PVFpkT0plNWQwemEwMEExbHZ4V1FR?=
 =?utf-8?B?Y1Vkd1JnWDBsRER5bTNpcnc3Slc3WmZDSFJxdEYzdTAxc2wzeER0Y3EyUGRK?=
 =?utf-8?B?RlFveEVRZFV1d2J3UENlUkpCc003aXV6eG5Ec3BHam1Ub2NWTkFoNlJDZmN2?=
 =?utf-8?B?OVF1QnR1WnpDcGpadlNocGptY2tWMDNMZHNvU29kZWZIRzR0VzFJd1FyOGwx?=
 =?utf-8?B?a0h2cUlycTd3NjJsaWQyZGIrZkxpZUZMSWg4TzUxWFdWK2NaYmpqcGxETmNJ?=
 =?utf-8?B?dU9sQlZ4QjdGaG8vWkhqNFhIOEZxL2F4Z2taOE5pN09kdkZObmRKU2pBd3hY?=
 =?utf-8?B?N010MlNFaDF6TFJuNEN3NDBHMHZtWHZSWEFsVkZkYTFiOExZcXJNUDBiczZN?=
 =?utf-8?B?S3N1Z1ptUXJIVGYrR0dhM0dXaG0zVXVXaXpyQWQ0T1NiNWk1UXlxb0h6KzBR?=
 =?utf-8?B?SHBCTUtTeWtTbTNMaStYbzk1NjV3M2pXdTF3Q1lXaFRzMlNHN21YcmoyVHkr?=
 =?utf-8?B?dkE4M2RuZUZvVDNzSEtuRnYrWFdqdnNJVEk3SVZXakN5QUlobVpVMk1XQWV2?=
 =?utf-8?Q?Z33doIK9ASFddiQXqJCU/ET7g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3329F05C98A794E92819FAB7919702C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea4f141-4fb5-421d-c4ea-08db203a1814
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:03:28.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvHRgJfrT8v2KYVvEwKkjojDxZnXj1SLQ1zLxHiMCEW9zctC8jivKl3eRP7ptieo1koPRhBsxSL6WEwDiYqo7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy83LzIzIDAwOjQ5LCBKaWFwZW5nIENob25nIHdyb3RlOg0KPiBUaGUgdmFyaWFibGUgcmV0
IGJlbG9uZ3MgdG8gcmVkdW5kYW50IGFzc2lnbm1lbnQgYW5kIGNhbiBiZSBkZWxldGVkLg0KPg0K
PiBmcy9zcGxpY2UuYzo5NDA6Mjogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdyZXQnIGlzIG5l
dmVyIHJlYWQuDQo+DQo+IFJlcG9ydGVkLWJ5OiBBYmFjaSBSb2JvdCA8YWJhY2lAbGludXguYWxp
YmFiYS5jb20+DQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEub3BlbmFub2xpcy5jbi9zaG93X2J1
Zy5jZ2k/aWQ9NDQwNg0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFwZW5nIENob25nIDxqaWFwZW5nLmNo
b25nQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gICBmcy9zcGxpY2UuYyB8IDEgLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9zcGxp
Y2UuYyBiL2ZzL3NwbGljZS5jDQo+IGluZGV4IDJlNzZkYmI4MWE4Zi4uMmMzZGVjMmI2ZGZhIDEw
MDY0NA0KPiAtLS0gYS9mcy9zcGxpY2UuYw0KPiArKysgYi9mcy9zcGxpY2UuYw0KPiBAQCAtOTM3
LDcgKzkzNyw2IEBAIHNzaXplX3Qgc3BsaWNlX2RpcmVjdF90b19hY3RvcihzdHJ1Y3QgZmlsZSAq
aW4sIHN0cnVjdCBzcGxpY2VfZGVzYyAqc2QsDQo+ICAgCS8qDQo+ICAgCSAqIERvIHRoZSBzcGxp
Y2UuDQo+ICAgCSAqLw0KPiAtCXJldCA9IDA7DQo+ICAgCWJ5dGVzID0gMDsNCj4gICAJbGVuID0g
c2QtPnRvdGFsX2xlbjsNCj4gICAJZmxhZ3MgPSBzZC0+ZmxhZ3M7DQoNClRoZSB2YXJpYWJsZSBy
ZXR1cm4gaXMgb25seSB1c2VkIGluIHRoZSB3aGlsZSBsb29wIHR3aWNlLA0KZWFjaCB0aW1lIGl0
IGlzIGluaXRpYWxpemVkIGZyb20gdGhlIGZ1bmN0aW9uJ3MgcmV0dXJuIHZhbHVlLg0KDQotY2sN
Cg0KDQo=
