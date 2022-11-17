Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75F62D2E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiKQFs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiKQFrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:47:42 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158966F370;
        Wed, 16 Nov 2022 21:47:29 -0800 (PST)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH3XZBw009986;
        Thu, 17 Nov 2022 05:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=OP8r0h4lfQ8RDOW7N8mlx4Axv+AbuQVupQvi8Jy2mVE=;
 b=fwkkzGR8LJ7ZPZ6M18lRubwvTJQPUmotTioZNHk9zbRxzMxHjkigLQNMTizmDj+MxRLW
 6dR572/gnPKR3vBUq8myICsLjJPMR6NP0iFE1LUUI2wGruLI8m/OeZ8bE78G8Kpdx6uv
 HwqL50phCRNhl8+HpBZ8YkF6JOQUOxjyWdeVTJDWwIaZab1RWJZLguE7WX4YWSagSdlE
 +4Qrcx+GeU/Pbz3J41u9hnWGFC8X8/SnEH6HeW9cBq4bt+sIL76Q7OSKnO+B6oMRwJYv
 RaJeQIjb2e7xTiTI6LpQMeIGj7iIhW2BVtudev2249fO27UCmz/laWPeNPE9JgRdBgVz hQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2045.outbound.protection.outlook.com [104.47.26.45])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kvn8yhf2x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 05:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0dGGDV/d8WUVEV5Pk1r8qyPwzhVHlNa2ERsMdCwyAWcx7UQSF2CDpsKJMbk/wXOJ4laMR6WO0FHQSsJiRKHl50H6istnSR4/v2gT2olQp5S08TqqrtT4Xywhrq5bXj4QXmphzGLi8cZHOX7dA0fxTP4dJg9z4aGrp67gxdBHe5aJKlyExmYJM3N50Vx6lkNaJ/KD5g8Yz5Gs6xLvLRgBG1wpVs5lyLCOAX4xKCMQtmEIS1S/p5GJoESGrsVj75Zw61iu/T/cWWspPcF525Mo+w2ueOppm/L9iS4ZqOALXUwmqpAf3aoklWDkUMPRyMo2qgxm9Emxp1QMBQn/yupGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP8r0h4lfQ8RDOW7N8mlx4Axv+AbuQVupQvi8Jy2mVE=;
 b=lNc9pbkd+VG5BKc8/aa5QmUrvu9R2EusZvQ/5XOUbOAQzPldDdfpWFcR3RLRvhB6ihd2TLcRP8YjSEUIoSxiab0aTpqBpEnDk87flKgd8n1lWDHQGOdGJVOk3RLyBEs/GigLxR/axvXuMJjPvWry+mmauCXqN4xPAK08YiqRo+ScEvBhbp/eMtRTtsePErPgQxvb6y938oeClEdATsC3zw1w0hEYCvzI3y5VRJlov6xsbwP1V4HWdgJbwDnvzaeGtI9z6FPkw/ISA+GBnGm4r8UgXPu9iJ/j1n2GDWYEcpiExsYhOefs5hmb1G/CEugfWDORyxScEJ+DgyoH1CkwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4134.apcprd04.prod.outlook.com (2603:1096:301:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 17 Nov
 2022 05:47:14 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%7]) with mapi id 15.20.5834.007; Thu, 17 Nov 2022
 05:47:14 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 5/5] exfat: replace magic numbers with Macros
Thread-Topic: [PATCH v1 5/5] exfat: replace magic numbers with Macros
Thread-Index: Adj6RyeHIwRrcVQ8RsKCnq84QMZMWQ==
Date:   Thu, 17 Nov 2022 05:47:14 +0000
Message-ID: <PUZPR04MB631665163A31A7AC1EB7165F81069@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4134:EE_
x-ms-office365-filtering-correlation-id: e696b092-dad3-4c0d-b146-08dac85f2e24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Re+pSLU1WNONfELGLacRQbk2cK0Sw5mLtU+3G/JNFqVttVhyKVDefbOer1/GsYWfi2b3ETg9APtxwMlSfzyyY238Du0wcCecuEfZQ+Egph7TR8a/Z/xQNPAWqVszN6oaoJBmzSrcRRY1sl/RPtX2IdFKGA3iO+qD6Ayj/yUC9zOJt//ucL8kd+7COoA0nchnnYK1PbSEyzMQ27CC1zUmH4JhtReJQIuyyGtQsy0h1EdsBXPT7fhu1kFPK0M4T7PgV/OyJwMqx5H9kjPiy56I+dFuW1+qyzfASZRfZcJcF7ISd3YDx8ynCnNDPWFC3kNSBC4JvH0m7FV0Z9CiDOG+cHdHkeuM1gQZeERy8yOHNOhzzCbc9xaba/VyUjmLSMbDoDm6Wsu0fNeqEAg6NolPAQNNlw+iG9QPP7v+Xytl4mGA0TsraHkT9DKFbZL9yMWg9I9mBZRo1YnrVwUuTXssa/RTKw4B9jGckv3ZIk5swrxIpt59rMlQ2QBtkVNNNyPKp8PZozXRs6SvOMoP4K/8dO08jFRr0GptR/YMcpYX+adaxyhy1+flPuq0vcfVV5S7ZS5ebk9Uh1oJjZcExM7ksLnqz+FFjGLYqwiDu4O46wZoPP/luVnPB2loOoS3S9X5HI6dVvwq7L5ckdeV34vNDNbWhsb+VCbtircYsBxFxHuRYWJ5PnZtQGcFUQc4iSBaft9/Kjgx0Sgsi/6/eoULQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(33656002)(316002)(110136005)(186003)(38070700005)(54906003)(71200400001)(107886003)(83380400001)(6506007)(26005)(478600001)(7696005)(9686003)(2906002)(86362001)(55016003)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(8676002)(5660300002)(4326008)(8936002)(52536014)(38100700002)(82960400001)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEpmdmsyWGR6UGllZDlXSHBndnRkN2RHM1BERTJ3bnBOaVJDVEVITTNxYlY4?=
 =?utf-8?B?RmFkM09pVi94dEtmeGE3TXJ2SGFBemN3YjRlVEs4cTlDRUl3ZnR2S3FZclF3?=
 =?utf-8?B?WTV6bllqUzltTG1UMncvN012c0U0cjd5dlVoWXE2SVZ4bEVsRnFzZVJqQVp3?=
 =?utf-8?B?NUp3N3ZOR0JENUJZODBsUEw0ZmdwNC9TZmNkU2VkSW1wdHBGcGhYTVh1MHBQ?=
 =?utf-8?B?N2I0WFQ4aEVkSUdUVGJ4UEt6ZStaYVA5MGh2QVRFc0lWYm5vVDZkM1hTTHZV?=
 =?utf-8?B?b1E2cVN4Lys1b1QvbE9vTWlTc2FrQ0UvN2pIcFEzbGRONVhOajh5QkxEbXdW?=
 =?utf-8?B?ZHdZMDYwTlJRTXE0VWorTVUvaFVUNC9CZ0xLcFYvSU1MRDg1ajVtWGxybHZR?=
 =?utf-8?B?SVRPNy85RndUWU4zcXl0YktIWlJobU9BR1FRQU01emx1Sk5WZkhsdlZadXpp?=
 =?utf-8?B?ZG1hL1dzSEFEL21jVHFoNDljSHRjWWkwaGUrYVpCdHdrU3RZeWI2WHRodU0r?=
 =?utf-8?B?Z0EwMkxMaWxBY1IybDU3d002ckFPakNIRzNMNVVOMGtSaWVWZDVpUWVOODA2?=
 =?utf-8?B?OHI5dU1FeHAxMmNUOVFFUFhoSHU2b1Q0WWFXR1dFSklLMDdWampUdzFhMDQ1?=
 =?utf-8?B?bGorUUNmMUZ1N1F0NVVCM1JsTDh1ODFkdWhqUFZMdDVTcEx6RDJYS0F0TWZB?=
 =?utf-8?B?eHRhYWVvbU01bUxtd21DeUw4RzlXSmxIcWhEaGdHZ0I3NmFSUGtTS3BOMGRh?=
 =?utf-8?B?b2NYS3JVSTdrK0p5WXovMHhzRCtWMzVudllHeGpwSk82TmttOGFkVHU2TXBO?=
 =?utf-8?B?bzdCeVVwV2hpQ2NIWkdSTnVWVm5rSDVsS1lOaUl5VHNTcjdSN0pNTDE4WSth?=
 =?utf-8?B?d3YvTm5OTWFOWktvZWtzSVNndHJkWHlMcjVVdEFObHBlcVlJbFppckhScXpG?=
 =?utf-8?B?QUdDNU1xVFYybWxQek4wSFRqejMzdFlvYUhFWlQxdVdldHJmZnBaRlJrdVY4?=
 =?utf-8?B?RG41YXg5V3VJNldFV2RmYU8rWFQrNHo5RVYvaUZ2MkRDTUt5RXZueGI5MmQ2?=
 =?utf-8?B?V3ZrUXpMNENaWDF5UEpiWWMwWXpnaWIzb3AvNklxNkxEYzg4TDR2R2F0OVl3?=
 =?utf-8?B?L2ZqOURkQVZaaFZtYlNEbmZXcHU0aUI0dFdsdWxia0pSQTh4bjRUd1lYcUM4?=
 =?utf-8?B?RVJkVDlZZ3NHRDVkbjh6ZDJyQ0ZHUTRDWGtLMHBHdHd0NDEzR01vdGRlYmht?=
 =?utf-8?B?cWNOUkRRYWZMbjhUMncraHhyYndOT05sV1IrejVRMUV3SDEvM0Y0alVHNDl3?=
 =?utf-8?B?Um1oa001Q012Ump4NTlSY2tIUGhLVjJKTDVPd21NRUdEeWJNUlgxTnp6UUll?=
 =?utf-8?B?MURhcUF2TDRGOFNya00wUTA1Ti9rKzJubHpUNDQ3KytOZ3d1MFRUeHpyaklO?=
 =?utf-8?B?cWNqaENING1aVnk4eDluMUJkbEhJcmhRcU5ZdXdqMi9aMTZ2Yk4rdmw2aU5a?=
 =?utf-8?B?U0JIdW5SYzU3clNHUmNPaUxPSjF1UG5iTUNWai9KWG5hb3ljUGJzK2M2dTUz?=
 =?utf-8?B?clN0dUJ4OWFPZVpNY3hqS1dYcExVdlI4eFBXWG1PM0thcitwbkVJWmk4SmRy?=
 =?utf-8?B?anRoaUJZOUZ5cFZpSVBrNDFOdlFBbGdWbGQ1VFBvT1JmNTZob1ZqTmtJU0Jm?=
 =?utf-8?B?cHdBYzVFZE5la25kT0lZSEhidnIxTHg5K2NVV2d4SHRmZG9YWGpObjIzMGtK?=
 =?utf-8?B?bG9ReHd2bWJ2aUN4ZkVXR1ZQeVVPS09zcHBqa0VFY2JSMEovVnBSUWdxOS9m?=
 =?utf-8?B?b1hUL1VGQnZIR3l0NGhSNUxBWWIxcnFhWDJ2YXoybHNKN2s1ZlgwbG9oanQr?=
 =?utf-8?B?alVJNGV2YzYzVGlJUFp0cllVdS9mNGUxMTAwQk9XcTJwU2NmdDREa0tBT1ZZ?=
 =?utf-8?B?TGNFcHYxMkVDVWN5bGtUR01uVkUxZm96dUpab0FpRmw5L29MUnBWczhBNEhz?=
 =?utf-8?B?NUprUFFuUWRPOU9NMmxvZEJPR3h4cUYwT0puVjhqb21sVW1TN1VjQ3kvcDFF?=
 =?utf-8?B?Ymd5UDl1WVlDQ3ZuMDdsT285TVR0TW5lQXI3TlhRRFFseXRvek96dktETjdM?=
 =?utf-8?Q?cFET6C+CKncOV/f95mSHJMIOP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hq7IDWwq3aA4v534gwYKwWo9liHSeRb0Xqw0IG/qub2gxWh9wMFrBRXZUIuJKKlamq/VEokEslkYjx2uAJ6qACs+XFoCoyEL0tA1rpaT5AATy+dohACBefIHkn0jH3CCnMXVY4FB9GVXaj6iCgtvgUpMMg5hXDLBVnAEWiBPEtb8v5Jq2g/S6+NHhbEoobLI8zbS/UAUVIEAbFKuk51Rc59fZGc71TXgCSmfXrEK3QgvhPrFYw3sKBr3ugNEXSmOdZdFnCzuqNNt19AvpeL8WLN4M3vaLBXpq+yC3xeIBH6qdK0ALj+AUSzksTmulgbB2gRNKwXIc6VTFvUFY0rgW3Lr+Gr0dWTn2OPBm6ZqZgbcHKmxYevIjGN9NaCi4BHlGGMBPiIDnlWc+jxvtP/TG1P/CCtWyoCm50TZ0I+TCReZgMZAd6lumnu2WTXGzDXFc8WYG/n2xeyYJz2TCbbBOC94uAdnbmDF0zEOj5ez5tM8VCJKa1m7EIo6niwIygt2NAHHROXGabVXlm3qLhuBJ6ConoGcfhAy9HSHr51nszjKcGiEJ1xJgI8oVKTNNfSFsFt0k+95u9xGOYToRD1/IYoP0I+RqmhWNqGZG38sZxXsFuJqYOkEYNQPCxn/j+okImFv43vVSqc8WWgvslF/qN/d+uHRwkKNiFjU+h+EbHYgDHArkGQ1/jcDeHrPF090qkLzQyUwo51HMRLXSgRz98kINcKaDRLbHiSIeC92R2VIJW+jfGrmPNsBQ3l1YUzCNS7/MGEn7ex24q1TToaXX/IZZz2SPFPxQYnHbZtJqCtfyd9Od5I1sCdblxA8dmdA18qZCgs8QbTs8+cgyhq+Gn8+tx0Y9N2oh+0aSVwvKjkwozgQQ/bzyTeXyoYL/zyL
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e696b092-dad3-4c0d-b146-08dac85f2e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:47:14.7795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LV4lbI4L8Szq/DbcwvBGx/D/DV9l8YgWYlV9MJQBFuS1+HH+4EnDxc9uBsDnCElWNfq3wbwlpqF6HpOnld2kVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4134
X-Proofpoint-ORIG-GUID: lU3S9UJPozDUj2iFYFXArBKd4b0Di_UB
X-Proofpoint-GUID: lU3S9UJPozDUj2iFYFXArBKd4b0Di_UB
X-Sony-Outbound-GUID: lU3S9UJPozDUj2iFYFXArBKd4b0Di_UB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_02,2022-11-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Q29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQoNClNpZ25lZC1vZmYtYnk6
IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1
IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5h
b3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgIHwgMTAgKysrKystLS0tLQ0K
IGZzL2V4ZmF0L2lub2RlLmMgfCAgNCArKy0tDQogZnMvZXhmYXQvbmFtZWkuYyB8ICA0ICsrLS0N
CiAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IGE5YTBiM2U0
NmFmMi4uZjUwYzQ2Y2NkMGQwIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2Zz
L2V4ZmF0L2Rpci5jDQpAQCAtNDQsNyArNDQsNyBAQCBzdGF0aWMgdm9pZCBleGZhdF9nZXRfdW5p
bmFtZV9mcm9tX2V4dF9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KIAkgKiBUaGlyZCBl
bnRyeSAgOiBmaXJzdCBmaWxlLW5hbWUgZW50cnkNCiAJICogU28sIHRoZSBpbmRleCBvZiBmaXJz
dCBmaWxlLW5hbWUgZGVudHJ5IHNob3VsZCBzdGFydCBmcm9tIDIuDQogCSAqLw0KLQlmb3IgKGkg
PSAyOyBpIDwgZXMubnVtX2VudHJpZXM7IGkrKykgew0KKwlmb3IgKGkgPSBFU19GSVJTVF9GSUxF
TkFNRV9FTlRSWTsgaSA8IGVzLm51bV9lbnRyaWVzOyBpKyspIHsNCiAJCXN0cnVjdCBleGZhdF9k
ZW50cnkgKmVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoJmVzLCBpKTsNCiANCiAJCS8qIGVu
ZCBvZiBuYW1lIGVudHJ5ICovDQpAQCAtNTkxLDEzICs1OTEsMTMgQEAgdm9pZCBleGZhdF91cGRh
dGVfZGlyX2Noa3N1bV93aXRoX2VudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hl
ICplcykNCiAJdW5zaWduZWQgc2hvcnQgY2hrc3VtID0gMDsNCiAJc3RydWN0IGV4ZmF0X2RlbnRy
eSAqZXA7DQogDQotCWZvciAoaSA9IDA7IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgew0KKwlm
b3IgKGkgPSBFU19GSUxFX0VOVFJZOyBpIDwgZXMtPm51bV9lbnRyaWVzOyBpKyspIHsNCiAJCWVw
ID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIGkpOw0KIAkJY2hrc3VtID0gZXhmYXRfY2Fs
Y19jaGtzdW0xNihlcCwgREVOVFJZX1NJWkUsIGNoa3N1bSwNCiAJCQkJCSAgICAgY2hrc3VtX3R5
cGUpOw0KIAkJY2hrc3VtX3R5cGUgPSBDU19ERUZBVUxUOw0KIAl9DQotCWVwID0gZXhmYXRfZ2V0
X2RlbnRyeV9jYWNoZWQoZXMsIDApOw0KKwllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKGVz
LCBFU19GSUxFX0VOVFJZKTsNCiAJZXAtPmRlbnRyeS5maWxlLmNoZWNrc3VtID0gY3B1X3RvX2xl
MTYoY2hrc3VtKTsNCiAJZXMtPm1vZGlmaWVkID0gdHJ1ZTsNCiB9DQpAQCAtODU4LDcgKzg1OCw3
IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hl
ICplcywNCiAJCXJldHVybiAtRUlPOw0KIAllcy0+YmhbZXMtPm51bV9iaCsrXSA9IGJoOw0KIA0K
LQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKGVzLCAwKTsNCisJZXAgPSBleGZhdF9nZXRf
ZGVudHJ5X2NhY2hlZChlcywgRVNfRklMRV9FTlRSWSk7DQogCWlmICghZXhmYXRfdmFsaWRhdGVf
ZW50cnkoZXhmYXRfZ2V0X2VudHJ5X3R5cGUoZXApLCAmbW9kZSkpDQogCQlnb3RvIHB1dF9lczsN
CiANCkBAIC04OTUsNyArODk1LDcgQEAgaW50IGV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBl
eGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAl9DQogDQogCS8qIHZhbGlkYXRlIGNhY2hlZCBk
ZW50cmllcyAqLw0KLQlmb3IgKGkgPSAxOyBpIDwgbnVtX2VudHJpZXM7IGkrKykgew0KKwlmb3Ig
KGkgPSBFU19TVFJFQU1fRU5UUlk7IGkgPCBudW1fZW50cmllczsgaSsrKSB7DQogCQllcCA9IGV4
ZmF0X2dldF9kZW50cnlfY2FjaGVkKGVzLCBpKTsNCiAJCWlmICghZXhmYXRfdmFsaWRhdGVfZW50
cnkoZXhmYXRfZ2V0X2VudHJ5X3R5cGUoZXApLCAmbW9kZSkpDQogCQkJZ290byBwdXRfZXM7DQpk
aWZmIC0tZ2l0IGEvZnMvZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IGE4
NGVhZTcyNTU2ZC4uNjJmMWM3YmZiNWQxIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0K
KysrIGIvZnMvZXhmYXQvaW5vZGUuYw0KQEAgLTQ0LDggKzQ0LDggQEAgaW50IF9fZXhmYXRfd3Jp
dGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgaW50IHN5bmMpDQogCS8qIGdldCB0aGUgZGly
ZWN0b3J5IGVudHJ5IG9mIGdpdmVuIGZpbGUgb3IgZGlyZWN0b3J5ICovDQogCWlmIChleGZhdF9n
ZXRfZGVudHJ5X3NldCgmZXMsIHNiLCAmKGVpLT5kaXIpLCBlaS0+ZW50cnksIEVTX0FMTF9FTlRS
SUVTKSkNCiAJCXJldHVybiAtRUlPOw0KLQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKCZl
cywgMCk7DQotCWVwMiA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKCZlcywgMSk7DQorCWVwID0g
ZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoJmVzLCBFU19GSUxFX0VOVFJZKTsNCisJZXAyID0gZXhm
YXRfZ2V0X2RlbnRyeV9jYWNoZWQoJmVzLCBFU19TVFJFQU1fRU5UUlkpOw0KIA0KIAllcC0+ZGVu
dHJ5LmZpbGUuYXR0ciA9IGNwdV90b19sZTE2KGV4ZmF0X21ha2VfYXR0cihpbm9kZSkpOw0KIA0K
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCA1
NzUxMGQ3ZjU4Y2YuLjM4YWQzMWI3ZWVmMiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMN
CisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC02NDYsOCArNjQ2LDggQEAgc3RhdGljIGludCBl
eGZhdF9maW5kKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgcXN0ciAqcW5hbWUsDQogCWRlbnRy
eSA9IGhpbnRfb3B0LmVpZHg7DQogCWlmIChleGZhdF9nZXRfZGVudHJ5X3NldCgmZXMsIHNiLCAm
Y2RpciwgZGVudHJ5LCBFU18yX0VOVFJJRVMpKQ0KIAkJcmV0dXJuIC1FSU87DQotCWVwID0gZXhm
YXRfZ2V0X2RlbnRyeV9jYWNoZWQoJmVzLCAwKTsNCi0JZXAyID0gZXhmYXRfZ2V0X2RlbnRyeV9j
YWNoZWQoJmVzLCAxKTsNCisJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgmZXMsIEVTX0ZJ
TEVfRU5UUlkpOw0KKwllcDIgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgmZXMsIEVTX1NUUkVB
TV9FTlRSWSk7DQogDQogCWluZm8tPnR5cGUgPSBleGZhdF9nZXRfZW50cnlfdHlwZShlcCk7DQog
CWluZm8tPmF0dHIgPSBsZTE2X3RvX2NwdShlcC0+ZGVudHJ5LmZpbGUuYXR0cik7DQotLSANCjIu
MjUuMQ0KDQo=
