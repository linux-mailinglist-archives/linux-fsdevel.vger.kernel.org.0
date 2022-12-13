Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4A64ADD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiLMCjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiLMCiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:38:04 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680371E735;
        Mon, 12 Dec 2022 18:37:20 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCMKDkr027794;
        Tue, 13 Dec 2022 02:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=PSMaimujD+GcIpTakMpqfamqwhGTGdsLu8ggA+LdFq0=;
 b=Y1ebObPk+gwBPJ+nM78q4/8Oo4Q1s6THlTA1FIcB7qyc7MppMmrDC0E+pXS8Udsc+h5q
 WhvHVr9am5HB6MsLHMXMYd6yba6s4iAD2FeGgwEIfiAw34l74q7BZbSP2hu8sImXT8aq
 LuZ4lwGpHP7ZYGDuvuZXA5exOpR+SmzLRE3yuUE9pb14CMfXfFidz56xRD4pJa8KRTvJ
 +B3OVt5+mZKesE2ckg/Hs9/oAkvySdS3gLdqsWMBLwmKDF5qSpwhYjR5Qkl0SrbHIJoH
 ndzAcR/pF2wkfPn6T1dRGIEwE1eACsY71UnlsnxQZMgPWcJQt1yXOBExvj4NyNN1/lXU MA== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcfh5jkrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXWmK3hqarR7EZ9JTGLTWYQorv4lCTi07xttNomS0JMAsfGA/IHFqwbnPz3eLg+Cw0lXxPcuOBjijNu/59++5RloBfZbLtEI7Fet6Qnh3eG60oEikdxb3Rp4+irDpckLhGnKkwXd4Y4nSe+iiizxjA67JBbslkbW/Bcs0iWphPuNUBnVG/asq6J1I47/WtKnZAUthOgQszVoK9xduCUIwEgv7KnxozKTFJfcwU4fawGGq6+3JXzaXLPo0rHSYLHtUQMNEw2W+GT4KVkvnXtf3Y69h36jpagV28RVQ84ddMHR9OAkjpBb6ilHq8pzXaxAX+ZM95B4cS2G5PSbvdg08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSMaimujD+GcIpTakMpqfamqwhGTGdsLu8ggA+LdFq0=;
 b=EgG2hTxiEHmF34OxshaKUFa7GXxZWdwNIoRO1zs/abwf4zaesFwsDJa+MfAvumsrNqSXY/d/Om2MYFpOIhVt8EhhLRaYEWRP7LbcrcPBtqFxJp88+nR8DUu6YO2/wzCGiwzlW+7ICUebbXhi76vGh0SOiSSXVcteh9BUlzM0kGwB8IgI6mIn0yaV9jrZhr3eAHUU49iri/eki3LpG05XSYLnCKa+Dt3dN8q0wC2EzNC5C8vypDhrakdDCycqxM/0W5mdha+U+Tisz3o0nMpcDfNLRRDbxSRGdkVE/z5nF5CGGuM4pfnsKyX6hmn0C7HWSWDKxXQ4a9XOGfohewUA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:37:05 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:37:05 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 5/7] exfat: remove i_size_write() from __exfat_truncate()
Thread-Topic: [PATCH v2 5/7] exfat: remove i_size_write() from
 __exfat_truncate()
Thread-Index: AdkOmkJ0uiTVDE8BQKmjN/VSAzn0eg==
Date:   Tue, 13 Dec 2022 02:37:05 +0000
Message-ID: <PUZPR04MB631658A52C2575161BB97BE481E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: feb30d9e-2b7d-4d92-4d7b-08dadcb2eca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hjfPxKoevsSQodnVEDgt0HXLl7Oo0rKXK47kYgoBGuGnImFOxs0v390aKHZGGz27kHNlmcBF2gZNetGhK41Z6HN/XcJ6EW4ZcwmqZyoy82bh/HZZQbgzBKU9Cw0+57aYV43zO+KYQPlR+MnfKAyxVigoAIfLeLh24/0tE0aqI0lwIl83p/JSbFtbIAO64E4E4000VueczBVotZ8QtvtX+2c6LEwi8l5t7CEsAzIlx+HPyv2T5XhvgHxbS+yVzshN531HnSDLpbJyE80Qrx14mvE/yxNjPW4+gXQa8P/zRA64kteuN84o+IPPj9bS4RDFoJ/YNSwMVwgq8CQSUfiadJMk15iLwiZ0kuBTqQECQ9u4sqvk6KU4nzLzwA5pysjp5WuxPj22x0SZ+vj/bGRJdn8n+IuHgCu1xIOGuGo4tLq0efrv6rwoEkuslGRmZ0G18jpfMe9SxOdNR0jrmL28IZWOluXR0+Fbsy02Y77SA+j0srKrmiLWyYcVDDuwvx4VwyFZfpnpkPXml3Iz7Y2DZYdCska0vDOTdXm9KvGmDJE7xlksvgnrI63wl3qyjLNz4rv2kQCIfRtzn5x2zsJSgWkWaCcj0NTyb2N3Wjho+qZvDrtJXQNK7EGHICgkl3uXujfElUU+9oLXw5vCNL9V3huYJziHxQ6AFGWsKKL2m3AY77HLcOrYl81yQ2e1AySbYSEYVCwwvXM4XFRwqpcNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjVzV3VzVzNNLy9HaEtEVlBXeE4yYlNwVUFRZlVzV3pvcVNMc1ZCdTAzUnM5?=
 =?utf-8?B?ZE1XYmhldkFrZVAyTzJxdyt5WTVqQWJVMDJ3MU5ZOTErUVRON2tudlNmWi9F?=
 =?utf-8?B?WjRzUVZENFFlc2MzL3pWZ0ROcXZQT3ExczQzblp3R3QvTTNaZ2FNVHcxVFgz?=
 =?utf-8?B?L0dLd2tvMXZQMm9EU05vMkxqZDgzQ1dLNUJjQUlkcGQyS3I4dzhrZGhtTUtw?=
 =?utf-8?B?dDZIdHlEZ1dkeUNyOXgwL1ZtUHRNdVJmMEpPenBrb3VhU0xpMk1sMlo2QnIv?=
 =?utf-8?B?UlFhV0hlbXczTnlSSk0yMzhSbVFzdjh5cnlqdUEwbWxkQUxEMG9uNDNVNTU1?=
 =?utf-8?B?VFp0bjRJUDNvVGVSNVZiOXdvNTVVcHV4eEJFRW56TTNDLzNKaitsS1RZOWg0?=
 =?utf-8?B?ZFhUKzRDQklvci9kU2NNSWYwbjNvcWJsN25NTjZEdkU2QVpDTldPc1FpYVBN?=
 =?utf-8?B?NnJza1Y3MmxIQnJnYmZIQUMvZkNiSm4zZFVOWitHTkxHb1l6SE04dytnUDky?=
 =?utf-8?B?UEFNcHBzQ1NtdjExRysvdVYvakRwZ282Z0p5S3dIRzF3WVBFelJ3bHhvRVNk?=
 =?utf-8?B?MG56djB4QWExcEVpM1UyK2cwMkI5ZzBMNlpoYkIvZDc1VG1pYzFTYVF1TUJJ?=
 =?utf-8?B?N2NTamNPZGlEcGJCb3ROYkhFd1ZKWHJLdC9LT05NSHB2UkJiUVVuTngydzVS?=
 =?utf-8?B?T2kvNU1xckF3SER4dkZ1Z1lqSW9HK29OQmxGdE5hZ2FaS1VzVzFKdGRnb0JG?=
 =?utf-8?B?SzJEVHFNV2N1RlZCSFliY3gwTkxFQU81UWVsSmNRSkt4c0xsNTV5VlJvWmxy?=
 =?utf-8?B?V1B2QkRTVWEvSTFVT0Mzb2xTTTdld05RbzlzTXROMG5uOHF5a2x5NWxnemJU?=
 =?utf-8?B?YmRnS243b0VwWEpDTENSdmpVWndlWnhMa0NJVWZkQ1lSSGZxcmJEQ3RiY1do?=
 =?utf-8?B?ekVVbzhOaDZUcVpVT0h3ekhHNHVrOTNsWlFuVWErT1RHamJ5YzN6OW5FeTdv?=
 =?utf-8?B?c2JCc0RSbHZhZDROQmk2eFB3Tm5qSERPUnNDZU9DMEIzb0dpaWFPRW85ZlJz?=
 =?utf-8?B?T0krNzZ1RnlKY1BmTWFmeHd2dXhZS0ZKSjB0UjF1SXpGNGQ4MHVCa21BZ08x?=
 =?utf-8?B?OTZZYmNGOEI1Uko2cHlKUDZYS3pWZ3RXOENYODdvdGE3bmpPelRYMmd0TFow?=
 =?utf-8?B?MmZzZkxXMU5jNnN3TWNGSnk4aHB0d0k0RVI0WXltOUF0R3hCbTRzWUJueXJI?=
 =?utf-8?B?WjVmbTd3UDF6Qi9rS3IvMG8xcHZ1eXFsUTVsUE5rWjZVaElxbWZqMUZveXVw?=
 =?utf-8?B?b21tNE15ZGJkVWR4NjhKYTYzWWtzSituaVFFTTd1S2NGNGc3blF5dFRpZ29F?=
 =?utf-8?B?a0IzbG01ZDQyVGs2cWYzb2Nmc005NVFtNDZHQ3FRVkJjQzRYN1FkN1U5aWIy?=
 =?utf-8?B?VnQzS0pNM1BNanN6N2VEcVp2aGJidjhidFlNRWRiUURKSHUrOVk5M1VCengz?=
 =?utf-8?B?cWRHV3BSdnZlRDlFTFJ1WUZLWWlXRXpVbTMzZ3pKNTNyRUpYVmlMNW5QcTQ0?=
 =?utf-8?B?ZnZpVXVNNnZQK1BncnJ1U2VtOHFSRnY3dFI0ekZ3dlZUajlDTXZTSDQyT3hD?=
 =?utf-8?B?c24zdCttZ2gvRVlLWVBLNStRWmZUdExEb3pwYVJZeGY3Y1FObUdNRVNja0w1?=
 =?utf-8?B?RlFmQ2FPb0c2RjJ4VWZ1Zlo3SXoxcXQ3alc0enJnbCtNR2NkUHp5T25aNWhL?=
 =?utf-8?B?RElWYmNtZndlYnZYUVZabHJramxLOWJwMHZnSTFzQUlOL2FDRjJKd0MwT3BP?=
 =?utf-8?B?cUYrajdUM1FaY3BuUy9OQzI0WVBVdzRnS09WQnV1bUw2WkRyUExLdkVHN2Rl?=
 =?utf-8?B?c0hMTkVNclpGRm9uU1dQZG1LaVFOTlR3TUdCN2JCZWlVV0tEZTVlcG13S2Iw?=
 =?utf-8?B?ektYOVRxbk92RVRwY1IvNnU3aklXbUZSR1U4TmF3RHJScHh3ZU5WcDJBWG82?=
 =?utf-8?B?bmJnNy8wSWpYQmdqSE9USmZzNlZTR0FaYkRLcVFEWURjZEdjdFpKSXE0Uy9s?=
 =?utf-8?B?VW16eEh5emk0WlRpK3Jkai9lRWNWRlE3VmxJYlZZS3dOTk5mRGFJNmQ3Mm5T?=
 =?utf-8?Q?KaqC+NHm3ukTTsUv2AsLwQriX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb30d9e-2b7d-4d92-4d7b-08dadcb2eca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:37:05.8867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CP5Ok2Qe22XZugFx3bz3PuPVjMM0/wPaJ10hBkMJEwn2nUkWRXZNDxMCZxduF2JdmHUJbsbkxEjonjFbrtaY5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-GUID: SvMlE44TsVIeAfjjT2GCEAm92TCn90ap
X-Proofpoint-ORIG-GUID: SvMlE44TsVIeAfjjT2GCEAm92TCn90ap
X-Sony-Outbound-GUID: SvMlE44TsVIeAfjjT2GCEAm92TCn90ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhlIGZpbGUvZGlyZWN0b3J5IHNpemUgaXMgdXBkYXRlZCBpbnRvIGlub2RlIGJ5IGlfc2l6ZV93
cml0ZSgpDQpiZWZvcmUgX19leGZhdF90cnVuY2F0ZSgpIGlzIGNhbGxlZCwgc28gaXQgaXMgcmVk
dW5kYW50IHRvDQpyZS11cGRhdGUgYnkgaV9zaXplX3dyaXRlKCkgaW4gX19leGZhdF90cnVuY2F0
ZSgpLg0KDQpDb2RlIHJlZmluZW1lbnQsIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAyICst
DQogZnMvZXhmYXQvZmlsZS5jICAgICB8IDggKysrLS0tLS0NCiBmcy9leGZhdC9pbm9kZS5jICAg
IHwgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBiL2ZzL2V4ZmF0L2V4ZmF0X2Zz
LmgNCmluZGV4IGFlMDQ4ODAyZjlkYi4uYTFlN2ZlYjIyMDc5IDEwMDY0NA0KLS0tIGEvZnMvZXhm
YXQvZXhmYXRfZnMuaA0KKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KQEAgLTQ0OCw3ICs0NDgs
NyBAQCBpbnQgZXhmYXRfdHJpbV9mcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZnN0cmlt
X3JhbmdlICpyYW5nZSk7DQogDQogLyogZmlsZS5jICovDQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBm
aWxlX29wZXJhdGlvbnMgZXhmYXRfZmlsZV9vcGVyYXRpb25zOw0KLWludCBfX2V4ZmF0X3RydW5j
YXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBuZXdfc2l6ZSk7DQoraW50IF9fZXhmYXRf
dHJ1bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSk7DQogdm9pZCBleGZhdF90cnVuY2F0ZShzdHJ1
Y3QgaW5vZGUgKmlub2RlKTsNCiBpbnQgZXhmYXRfc2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3Bh
Y2UgKm1udF91c2VybnMsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCiAJCSAgc3RydWN0IGlhdHRy
ICphdHRyKTsNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMN
CmluZGV4IDdjOTdjMWRmMTMwNS4uZjViMjkwNzI3NzVkIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQv
ZmlsZS5jDQorKysgYi9mcy9leGZhdC9maWxlLmMNCkBAIC05Myw3ICs5Myw3IEBAIHN0YXRpYyBp
bnQgZXhmYXRfc2FuaXRpemVfbW9kZShjb25zdCBzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpLA0K
IH0NCiANCiAvKiByZXNpemUgdGhlIGZpbGUgbGVuZ3RoICovDQotaW50IF9fZXhmYXRfdHJ1bmNh
dGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG5ld19zaXplKQ0KK2ludCBfX2V4ZmF0X3Ry
dW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogew0KIAl1bnNpZ25lZCBpbnQgbnVtX2NsdXN0
ZXJzX25ldywgbnVtX2NsdXN0ZXJzX3BoeXM7DQogCXVuc2lnbmVkIGludCBsYXN0X2NsdSA9IEVY
RkFUX0ZSRUVfQ0xVU1RFUjsNCkBAIC0xMTMsNyArMTEzLDcgQEAgaW50IF9fZXhmYXRfdHJ1bmNh
dGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG5ld19zaXplKQ0KIA0KIAlleGZhdF9jaGFp
bl9zZXQoJmNsdSwgZWktPnN0YXJ0X2NsdSwgbnVtX2NsdXN0ZXJzX3BoeXMsIGVpLT5mbGFncyk7
DQogDQotCWlmIChuZXdfc2l6ZSA+IDApIHsNCisJaWYgKGlfc2l6ZV9yZWFkKGlub2RlKSA+IDAp
IHsNCiAJCS8qDQogCQkgKiBUcnVuY2F0ZSBGQVQgY2hhaW4gbnVtX2NsdXN0ZXJzIGFmdGVyIHRo
ZSBmaXJzdCBjbHVzdGVyDQogCQkgKiBudW1fY2x1c3RlcnMgPSBtaW4obmV3LCBwaHlzKTsNCkBA
IC0xNDMsOCArMTQzLDYgQEAgaW50IF9fZXhmYXRfdHJ1bmNhdGUoc3RydWN0IGlub2RlICppbm9k
ZSwgbG9mZl90IG5ld19zaXplKQ0KIAkJZWktPnN0YXJ0X2NsdSA9IEVYRkFUX0VPRl9DTFVTVEVS
Ow0KIAl9DQogDQotCWlfc2l6ZV93cml0ZShpbm9kZSwgbmV3X3NpemUpOw0KLQ0KIAlpZiAoZWkt
PnR5cGUgPT0gVFlQRV9GSUxFKQ0KIAkJZWktPmF0dHIgfD0gQVRUUl9BUkNISVZFOw0KIA0KQEAg
LTIwNyw3ICsyMDUsNyBAQCB2b2lkIGV4ZmF0X3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUp
DQogCQlnb3RvIHdyaXRlX3NpemU7DQogCX0NCiANCi0JZXJyID0gX19leGZhdF90cnVuY2F0ZShp
bm9kZSwgaV9zaXplX3JlYWQoaW5vZGUpKTsNCisJZXJyID0gX19leGZhdF90cnVuY2F0ZShpbm9k
ZSk7DQogCWlmIChlcnIpDQogCQlnb3RvIHdyaXRlX3NpemU7DQogDQpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IDBkMTQ3ZjhhMWY3Yy4uOTVh
ZGM0YjJlNDM2IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhmYXQv
aW5vZGUuYw0KQEAgLTYyNiw3ICs2MjYsNyBAQCB2b2lkIGV4ZmF0X2V2aWN0X2lub2RlKHN0cnVj
dCBpbm9kZSAqaW5vZGUpDQogCWlmICghaW5vZGUtPmlfbmxpbmspIHsNCiAJCWlfc2l6ZV93cml0
ZShpbm9kZSwgMCk7DQogCQltdXRleF9sb2NrKCZFWEZBVF9TQihpbm9kZS0+aV9zYiktPnNfbG9j
ayk7DQotCQlfX2V4ZmF0X3RydW5jYXRlKGlub2RlLCAwKTsNCisJCV9fZXhmYXRfdHJ1bmNhdGUo
aW5vZGUpOw0KIAkJbXV0ZXhfdW5sb2NrKCZFWEZBVF9TQihpbm9kZS0+aV9zYiktPnNfbG9jayk7
DQogCX0NCiANCi0tIA0KMi4yNS4xDQo=
