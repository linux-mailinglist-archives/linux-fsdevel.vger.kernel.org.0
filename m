Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8C4E8E06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 08:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiC1GUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 02:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiC1GUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:20:48 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8F4161D;
        Sun, 27 Mar 2022 23:19:06 -0700 (PDT)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S0krAJ006541;
        Mon, 28 Mar 2022 06:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=AVicoMf/kbGxKcbWCIOIOX/xHFmlQpb+YfevK8L9mFQ=;
 b=bdoKPHb68Z23bnLHJanRvMWQnqXmTmzygX7mEppqzTK8+OgPFmwU/ld8T0Xprrvpb9xz
 Fqru5lH6uGkUgdE5WP4Pk/znfdOnVV7ZnyvnjkiCJbGdIMkGT9OMldgA9bQr/QxvUv4O
 +lYyrOrVHfXMnhfKVFUTF0NvbmiiixnPndtJyxcaTOU/JycTclZYJEOp9x4dbHkqlOtM
 c/YYoHJR4ANVE+OQ8NZLS5/0NCEigFvJOE21SuyC8zK4zlUCjmgani2leaMQZNFCe8ml
 +rlGL8Q/d9Eyn64MwIqx/plpbEvN0Gm+UMsiNoYrnogCssujUoACxV6312X5aXmw40/j 8A== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2042.outbound.protection.outlook.com [104.47.110.42])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f1sq01ces-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 06:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPMwwuar7+4ebqDxH9/GsBWP9+hl+ZdhpKYrG5xaQpFBCiuqpQ747QcIadZnWNYIAfGWX7HmE8D+L6a/QWcMTcwgJ4jmecwgBCwoCjRki+cGjQ1yO0IigiZuDot9Uu89eel2TYr1uQmR3ga5v9qT9ciadG42k4OWRuInCFN0BPpHYk0vpp4ePbAcKC56iWI/FyvTbaCsMJaF4ETuROPJR09Lx8IJQFSCkDwIOOZFfezJqvDBzGwKE4SQx2oTbYJEr0ELaInXlCAggjIXnZjR83jAvVfVVNZJcWMrVJzWeaQ+eIKPcH22Qi1KL7TD0KcxoB3prS0Y2XzD6jo7MaHbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVicoMf/kbGxKcbWCIOIOX/xHFmlQpb+YfevK8L9mFQ=;
 b=ltfkdHgEYbesSZFqI8i3exbdAkP08DJz/ebKbNLsVn3pS6iZ6t+lAuJRybEjWP3Uopi2rWCMxVPq2cxYgQ1pVvDKMmy3/tRwzz/99uRlpmZ6IB5y9nkfIDJlr2ys/q9ZicHvYM+jxwcmCqmfnsHXs/8D3n5870AWAGviFROZtorYtX6oM9m020esuH+ky+OZC3cmg3klAx45va7ThYR+xsehC/QJVuwNxvjVYlArMuz4xJF5QCLHYp7sTCs+lMOoxAtGgJuteV8gSNCWPj1ZMB1r3nK7qV5il4+s+1WjKoV/eyx74fa3epHCJTnQucngZ7UNOYEmeGNu/gQGhBMtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by KL1PR0401MB4989.apcprd04.prod.outlook.com (2603:1096:820:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 06:18:28 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 06:18:28 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Subject: RE: [PATCH 1/2] exfat: fix referencing wrong parent directory
 information after renaming
Thread-Topic: [PATCH 1/2] exfat: fix referencing wrong parent directory
 information after renaming
Thread-Index: AdhAKsEtthO71fDaRs2uNUmwvcqVmwCGn4mAAAfpBIA=
Date:   Mon, 28 Mar 2022 06:18:28 +0000
Message-ID: <HK2PR04MB3891ED2DAACF2FC5066746C2811D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <CAKYAXd8Q7-1O9PQ693stmLjoG99KME__FSm0gPtvndi4xxoVcA@mail.gmail.com>
In-Reply-To: <CAKYAXd8Q7-1O9PQ693stmLjoG99KME__FSm0gPtvndi4xxoVcA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a6f21df-4882-4fb6-1ee1-08da1082c665
x-ms-traffictypediagnostic: KL1PR0401MB4989:EE_
x-microsoft-antispam-prvs: <KL1PR0401MB498981950FE6DCEED93A2D90811D9@KL1PR0401MB4989.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMP4vefCCIXFlTIgVOeFzE2bfOQ7Yhr6evZV4pGPt9hbdlBPeL1J3kN9Mrtid+a7TXKCK949EBNnqNI6z7YJP+TEQF5tYKEbr21T/xfMRpcTiaU699OpXTQF8R84IhdXnJj77/OOxq9E5VPIImjwvQyHMgM539g2fk71+ERmt9l61X8fDtjMDuWKcL6G8k2xo8BVTV7B7NHgIKr19KDOjUwAUwQvs1hFlLLw+2cLajeSIAHLEh+Y2Pf+8BNRwwZWkyz11IjG1OSbk4OvIDLRAn9LvI7f5bptVbyEJU8AeyvGakU/n4E5LNf+32cr5EkmRPt0VK9pJmYHKIMTyMWJ0Zzjqnh89/yH+KLYZXrEztgxeMXpHq7n7lXzUcbsW9n7Ab9xPOP81HTut6OkDunV2IvZj8+oXnxHFTEF979ga1xtRoFCBboM5AOkdQTrmcEz7vkbL7T3+x57B0O/79E976J8RjCM89HbFSzQL+qCWSL6QPrIKTjmtiM1DUIC7KQRTudOMM2noTH++1Z8JcgrxlRCg7/tOn2+BSwlEblkzBbgS9t4z7VYC2hqKCu1v7BxnVwaWtTKL91cPS80KquyDXSHqZCSs+5xSQJZy27K9ltiBshVrBHRHii5mv6xO3S4q1Gz543aRYou/aDj8z0Vg2tq5muQRBpgXGohItnrVvgMpAxBUj5JQFhvKrNDOYb/RfJmYqpBn4jZq6jm9KRVLzIXw9khv4dHVNK0LrGLzyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(8936002)(52536014)(6506007)(7696005)(86362001)(38100700002)(316002)(71200400001)(5660300002)(82960400001)(508600001)(186003)(26005)(122000001)(76116006)(4326008)(8676002)(83380400001)(33656002)(54906003)(64756008)(66946007)(6916009)(2906002)(66556008)(55016003)(9686003)(66476007)(66446008)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk4rWjlmYnpBMWhkemxSYjRnQkRmdzBVb0VHNGlLS0doaUd3a0ZDREJkMmhj?=
 =?utf-8?B?dDI0TGFXeXBzL0QrS1BCRlVwazlIRGkwalNMSWlaUzZnWGNqZjNRQnhpQnhE?=
 =?utf-8?B?TURPczBlTlYxV2l6Z2JSZlFrNzJzOHVjTGFkZTZuVG9iMS9OcFprVWl3RW1t?=
 =?utf-8?B?cE1IZlFaYU5FSE1tZ0w5WjRvWUJiSDE1bHc2SkloaXlkcm9BNTFlUkhDbDZh?=
 =?utf-8?B?cEFiVXg3bDV0TlZxYWFCL3V2TytNT0IzWTZKcFhicVF4WG14T1JBYUZKd1VE?=
 =?utf-8?B?bHpkeDNjUW9FbXkxL29VaXd2WnltWWZVUHRQTFdTa2hSZy9MYWwrYkxUZXZl?=
 =?utf-8?B?aUE2U05CWEY1UmNuRmhrU0FpS2c3Zjk0bHp2ZGx0czhQS2ZXaExpOGs4d3V6?=
 =?utf-8?B?SlZpYkJhbHYxVWQ0b2VrMC9JUjZNRTVXb0dDbkZ2ejdkY1lPWm5TOHBnK01Q?=
 =?utf-8?B?YmxKV0FIRjBZVFJRaCtib3VBOGxVMFY2VTZBVENRdmVEdzQ2L0NTQmpvNHVr?=
 =?utf-8?B?YjZ6eWV2bnQrR3Q1anFmMEM4Ym1veWZzWVlBbnh5eHR6Mlc3cXpjazRRb1ky?=
 =?utf-8?B?Q1ZLM04rSFBXY0VlcHhackxmMXhHQllmUUhrckk4RDVkY2lLRUFiaHVWVzZI?=
 =?utf-8?B?Nzd2aVZGMzN5b00yUHBxSUI5Qm5LckZSZW43RFI3M0RSSWpIb0JRQUFBM21i?=
 =?utf-8?B?MGFtUEtDWkZiTTIvN2g1U0dJOTlmUVVsdDlYZ0lFdUdIV202M3NNSUVTdFdJ?=
 =?utf-8?B?QmtVYzVqRmNLcHBDYVQ1amcxL0RXd3RoZU01Z0xVTVVBL2pxNi9KWERVMldJ?=
 =?utf-8?B?Nm5DOExZN0hkSDlHVVZuNzFuMFVOOVp6YWJuekpoaVIxeDkrNVl3a3JjZWdU?=
 =?utf-8?B?REQvM2E1SUxoc1BlbzVqR1pycTRLUkNSQytOTnZ0Q1Q1TVpuOGhac1A3TjlS?=
 =?utf-8?B?OWFDWnpIUGRvN2ZKK29SbVVuK1JTbENDbGdlcm82eTg0M0F3eTdEL2tYZHUv?=
 =?utf-8?B?OWE5TE1MekROb3B6bFVGYkk2a2ZDUGp4SVJVdFRSQmpOMk9iUmhxOThFZDJR?=
 =?utf-8?B?V1VEUVB0S0tsTldrRnBsZXEwU0c4LzZ2SSs5NWpDbzRyVk9RdHdlNkEyWHBW?=
 =?utf-8?B?UkNNYi8zSnByMlp6NzRISjQwMVBRSUQyWWZhRFhXZWl4SU1wZVdIMlBHb2ty?=
 =?utf-8?B?eWJRSUFycURlSEEyQlpyRTcvdERaYmZkbkovMTgvUk9hdXZ6Q3AwcmtEUFZ1?=
 =?utf-8?B?N0NHcERHRStWY0t0YVQrazJ1UHFiekh3R0xJVm93NHU3NFozK1FGYUFSV28w?=
 =?utf-8?B?WUx2bU9YUm1PUno5ZzlMMjhhVExvUmZhREJtUG1rZXFUN1k1THZIemdqUFJO?=
 =?utf-8?B?S2h2UWh0LzhnY2l6cFJhbmFudWd6S3FDdGJmWWZhclcxbUd2aFl6aVV4NmtS?=
 =?utf-8?B?Ly91dkxBUWNHRFdyWUdCNnB4eHhIOHIzckt5Q2dxbjIwVjcrYzQ5WERCS3lI?=
 =?utf-8?B?UURRUmtTRnFVNUswT1ZRRWVVcnB3bUo3ZjY0d0RLRHIrcFhhV0dhZytEUmxr?=
 =?utf-8?B?WjFKUlNCbjBXQThxRlVLSTJGdjMxUU4xMFJYMzlQa3psK2pYWVdCNGZTTDEv?=
 =?utf-8?B?RVlZUHpHVnBGWVpHeCs3WTQ4OU8yK2VXdjFXUDBBSVpRVVVqZ0U4SFgxY2V5?=
 =?utf-8?B?MkVDbGE0Q2UyV3dKakIvSnNRY1ZqS2NqR3JieTJBbGRwbGxLUUZrOUxBVWdN?=
 =?utf-8?B?Mk1sWEFzU1NCTVNSTEljYUpuWnFTdGZzWXN5cmhiNUphQ214U010c1p3ZVR5?=
 =?utf-8?B?Vm1jblQ2Q0Uza2xDZXdiRGlaYWZHRnNjVW9FU2ZGdnYrdnM0U0Z6aGk5c0w1?=
 =?utf-8?B?YnMyUzdhK2JKZUtWZGNFK3Z0Qm1XYlo4by9kZGd4eVVnL1VaVmh6WmtPRFlJ?=
 =?utf-8?B?dzZZaUtqM1ZLS2FuTWQ4b3MrUjE3a2Q0b2taNVJBK3NIQ1hPR3ZZVkFkS2ky?=
 =?utf-8?B?QVNSZi9VL1RXcEIrbm1mYkNmSUlKZzJrZ3N3MmRRQ2JrVU1EYnJUdlFHSjRm?=
 =?utf-8?B?Qjk5eVRvcGV0WG11RGxQU0IwUG5LaHVzQnFzRVNpUXJaK0F3UzVYbjBsemFP?=
 =?utf-8?B?SUczZ1UxbTRSZEdkbGEzVTE1ODdxbGh1V2t5NUNOcnNxemtwbllHRkU1WXhp?=
 =?utf-8?B?MUpYc2ZmT0UrWjJzY01wMDRFWjZZYmZNUVd5TnFydTNDdGNHT3NsWXVlWmFm?=
 =?utf-8?B?RkNYdXU1Q2V0eXNIaCtNL3JXZmMvZnAzYTdKb2VQS3VYbkRNQWpSc0sweTJ4?=
 =?utf-8?B?cjE2SEZrVjQwU0xTV2ZENnVpcjQ2TWNJZlRoYTJiR2xWRi90NW9Pdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6f21df-4882-4fb6-1ee1-08da1082c665
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 06:18:28.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1kSUfFa6kk2Ug0/mNnjs1KpRJgxAQMlBDqPjr/lYf6I9ipHBxIq0uQpByCCrQxHwsNi/ATqJdFDpVhW1q7psw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4989
X-Proofpoint-GUID: S62sFuj8vTX03mnV6CRhoPUMj-QatEbi
X-Proofpoint-ORIG-GUID: S62sFuj8vTX03mnV6CRhoPUMj-QatEbi
X-Sony-Outbound-GUID: S62sFuj8vTX03mnV6CRhoPUMj-QatEbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_01,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203280037
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTmFtamFlIEplb24sDQoNClRoZSBpc3N1ZSBjYW4gYmUgcmVwcm9kdWNlZCBieQ0KDQpTdGVw
IDE6IGNyZWF0ZSBhbmQgcmVuYW1lIHRoZSBmaWxlIGFzOg0KDQpkaXI9JHttb3VudF9wb2ludH0v
ZGlyDQoNCnJtIC1mciAke21vdW50X3BvaW50fS8qDQpta2RpciAke2Rpcn0NCmRpcnNpemU9JChk
dSAtYiAke2Rpcn0gfCBhd2sgJ3twcmludCAkMX0nKQ0KDQpmb3IgKChpID0gMTsgaSA8PSBkaXJz
aXplIC8gKDMyICogMyk7IGkrKykpOyBkbw0KICAgICAgICB0b3VjaCAke2Rpcn0vZmlsZS0kaQ0K
ZG9uZQ0KDQpta2RpciAke21vdW50X3BvaW50fS9kaXIyDQoNCm12ICR7ZGlyfS9maWxlLTEgJHtk
aXJ9L2xvbmctZmlsZS1uYW1lLTEyMzQ1Njc4OTAtMTIzNDU2Nzg5MA0KDQo+ID4gKDEpIFRoZSBy
ZW5hbWVkIGZpbGUgY2FuIG5vdCBiZSB3cml0dGVuLg0KPiA+DQo+ID4gICAgIFsxMDc2OC4xNzUx
NzJdIGV4RkFULWZzIChzZGExKTogZXJyb3IsIGZhaWxlZCB0byBibWFwIChpbm9kZSA6DQo+ID4g
N2FmZDUwZTQgaWJsb2NrIDogMCwgZXJyIDogLTUpDQo+ID4gICAgIFsxMDc2OC4xODQyODVdIGV4
RkFULWZzIChzZGExKTogRmlsZXN5c3RlbSBoYXMgYmVlbiBzZXQgcmVhZC1vbmx5DQo+ID4gICAg
IGFzaDogd3JpdGUgZXJyb3I6IElucHV0L291dHB1dCBlcnJvcg0KPiBDb3VsZCB5b3UgcGxlYXNl
IGVsYWJvcmF0ZSBob3cgdG8gcmVwcm9kdWNlIGl0ID8NCg0KU3RlcCAyOiBXcml0ZSBkYXRhIHRv
IHRoZSByZW5hbWVkIGZpbGUsIHN1Y2ggYXM6DQoNCmVjaG8geHh4ID4gJHtkaXJ9L2ZpbGUtMSAk
e2Rpcn0vbG9uZy1maWxlLW5hbWUtMTIzNDU2Nzg5MC0xMjM0NTY3ODkwDQoNCj4gPiAoMikgU29t
ZSBkZW50cmllcyBvZiB0aGUgcmVuYW1lZCBmaWxlL2RpcmVjdG9yeSBhcmUgbm90IHNldA0KPiA+
ICAgICB0byBkZWxldGVkIGFmdGVyIHJlbW92aW5nIHRoZSBmaWxlL2RpcmVjdG9yeS4NCg0KQWZ0
ZXIgYXBwbHlpbmcgdGhlIGRlYnVnIHBhdGNoLA0KYGBgZGlmZg0KLS0tIGEvZnMvZXhmYXQvbmFt
ZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFtZWkuYw0KQEAgLTgyNCw2ICs4MjQsMTEgQEAgc3RhdGlj
IGludCBleGZhdF91bmxpbmsoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRy
eSkNCiAgICAgICAgbnVtX2VudHJpZXMrKzsNCiAgICAgICAgYnJlbHNlKGJoKTsNCiANCisgICAg
ICAgaWYgKG51bV9lbnRyaWVzICE9IGVwLT5kZW50cnkuZmlsZS5udW1fZXh0ICsgMSkgew0KKyAg
ICAgICAgICAgICAgIHByX2VycigiZmlsZSBoYXMgJWQgZW50cmllc1xuIiwgZXAtPmRlbnRyeS5m
aWxlLm51bV9leHQgKyAxKTsNCisgICAgICAgICAgICAgICBwcl9lcnIoIkJ1dCBvbmx5IHNldCAl
ZCBlbnRyaWVzIHRvIGRlbGV0ZWRcbiIsIG51bV9lbnRyaWVzKTsNCisgICAgICAgfQ0KKw0KICAg
ICAgICBleGZhdF9zZXRfdm9sdW1lX2RpcnR5KHNiKTsNCiAgICAgICAgLyogdXBkYXRlIHRoZSBk
aXJlY3RvcnkgZW50cnkgKi8NCiAgICAgICAgaWYgKGV4ZmF0X3JlbW92ZV9lbnRyaWVzKGRpciwg
JmNkaXIsIGVudHJ5LCAwLCBudW1fZW50cmllcykpIHsNCmBgYA0KDQpXZSBjYW4gZmluZCB0aGF0
IDQgZW50cmllcyBhcmUgbm90IHNldCB0byBkZWxldGUuIA0KDQpbICAzODguMTQwODAyXSBmaWxl
IGhhcyA1IGVudHJpZXMNClsgIDM4OC4xNDQyMDBdIEJ1dCBvbmx5IHNldCAxIGVudHJpZXMgdG8g
ZGVsZXRlZA0K
