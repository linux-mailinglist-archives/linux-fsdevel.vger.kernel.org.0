Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FD567BF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiGFCf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 22:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiGFCfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:35:16 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07581A046;
        Tue,  5 Jul 2022 19:35:15 -0700 (PDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265NgBh3003384;
        Wed, 6 Jul 2022 02:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=4QQoi3s9H62iOspt2lF7zTwpjvxISzs+X/s4Jk6b5iQ=;
 b=PTlhH9X1z6A/xUKrEsNwKRIRXPciMqQMpQWwQSENg4rGFG1Qn5AHYKY5tp3NtYwPwc8T
 OP7Tk541Ia+QC3OIi6fVov2l2UtoTQlc14lLyeMktCnzgWZ6s8w5Gn1p7QBQQEmWkC/L
 kDjN//VfTW3CKSKw2+5+5cNEyid2v8pVq07v4QjKgqIKlfyJAyFMOFCvtptiUZvSEqXF
 wP7Hs0gQWZ1/Kg+StmTE1235C0SNTcF+Zona8Qn15yYdc/psaVWFKVfgD6l0SuI15Hu9
 f7d+kNYjwyCeuz27bSdfNXEWhplva4yNQe6A38kujyENpXMUG1Cfq/nVsujhOoWdroHn BA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2105.outbound.protection.outlook.com [104.47.26.105])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3h4urcgab7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 02:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9jLlQh28lONrLgKn2Q+8L2lS90A8tXrouWqNoQJy2Trg0oaSlgjD/Aut81LBukQT0cgM54QzNTVZxx4HDDPUGZqqu28+jp8PIDXflTvcd+xhAKbqv0AmAUjMMSjE8G24NRe+i0qIrzhMXfwKleTxvQWRDl1a0VDEuIc2yOq4iG7Ir5wmUw8xH0xO8LKSjZnSe2B6u9MevB5qDC7BjyNrKgpHZcpfqjb0Eq33gwgZY3dTHZv+wUTrmn5WMIV0JE6dh+C7N70bCcNmcv3AQbRfwYC/3SWiJyOBDN6mX6eHsmYBNj1V0cbx6Cgra2uJ0dYQaE0ruwabpuyvYJJ679fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QQoi3s9H62iOspt2lF7zTwpjvxISzs+X/s4Jk6b5iQ=;
 b=LYhy4rcsfC0d8SCXD7dAYBtVHrLPuM5U7YsqIplsjjc85kdfns8hIH1wUmV/IWuJfHQMDzkBwmrajmTsfVNwmUy16A2LAJSpTLMu4EkWA1aUAMrZD1fXxnfy2wGsk3MbuEkLR/KoR73BoFO9UUM0PUdpR/jd+gVXR/YlaIWCorh+bjaIdhdgJQMwqtmLpeS+xcANJJFrLP6hdemJdngcTSGw2U46r1G+GU1p/TEPPFis++A18XpYZl+bUzEXYLX3s2gDE38ImRqhFP6wiV1efqUhs/neFgiQR8TfXC7EQFiFNglq0UUNW0K8rURLirLlN01BlrADSskN5joZJrjbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SG2PR04MB3899.apcprd04.prod.outlook.com (2603:1096:4:94::11) by
 SEZPR04MB5972.apcprd04.prod.outlook.com (2603:1096:101:65::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Wed, 6 Jul 2022 02:34:53 +0000
Received: from SG2PR04MB3899.apcprd04.prod.outlook.com
 ([fe80::9076:c0a7:6016:599a]) by SG2PR04MB3899.apcprd04.prod.outlook.com
 ([fe80::9076:c0a7:6016:599a%6]) with mapi id 15.20.5395.017; Wed, 6 Jul 2022
 02:34:52 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 2/3] exfat: remove duplicate write inode for truncating
 file
Thread-Topic: [PATCH v1 2/3] exfat: remove duplicate write inode for
 truncating file
Thread-Index: AdiQ32NodxpH5hhMTdGIdMWLRFebXg==
Date:   Wed, 6 Jul 2022 02:34:52 +0000
Message-ID: <SG2PR04MB3899966B6BCE88B9A629789181809@SG2PR04MB3899.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e16485-f0d4-4aca-e030-08da5ef81b42
x-ms-traffictypediagnostic: SEZPR04MB5972:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: juHTuDmNpR1JkCdXqZeqpDikrLvxqfAkEoIQlvhXyJp7W362kL6awbHOR0+3yWwa/QtrzZvxTCSOSai+ccuikV+agGSM2aWcDIXD7IdNKNgxKUnHAAHz7rwgPVFQx75Qz/SBT7mJlTIMlZl9iaP5FhG6MfewwsaBBOVPo48u39EGBKj/bd5PjSEQuguTZmRVwomA3u/hohf4P3Mjo9mumkD5W0sngqODswFv4SXJSI8m5Zh28mOcqstvnpbdvusNF+jrC85f72WLk8cyQUwFoO9FjdU0hVIDM6DXvasExk5XAetvATs9Qz0gVfRUj/OHdEX5nYgboPf69yqvgMprOUCL4UG3f8x74kmiG1JJHK/220GITMUW7dF6bIh+1sxxnn0cd9cszFEqZYBVR1uak+EsrDTcLFvkWC4qmAkJQ+98xjLbCa23dd5dFIGkDwrmF6V/kgXnpFzKeyjXtg3iR3pAqbkQk0WPdbniglUIv5r7AhM4bKwjKWOwHrWwmbRnkqusvocNlSVNIVIx+oBt1fpBvx2M80y9/EX235NcK8kf7P8IQQzVToBpy99EGfXNonh9laetdZ1rD7BfnnWFdfY2f+EAleyn1HoQesl1uirGIhqwtR5u4FM9C51V3NU/gHcn4pqNOOBz6kldCLuk22fzXgSLVnlJGcyAmsPIfG2JTTqQpX+PAGws3ZS0jpXa/hIJ432ZARWY4+hxh6601YeqkRkfvKnk+TMfV5EH1vn3ihM1JwakuRibO22S17VA3xxBJYWVGU5xHQK2EdLvR9F6IIq5kmej5CHNbLB/kjStsH01SJ4xDhWuGTuxDeD8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR04MB3899.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(83380400001)(99936003)(82960400001)(122000001)(38070700005)(38100700002)(54906003)(110136005)(316002)(71200400001)(52536014)(8936002)(5660300002)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(107886003)(9686003)(186003)(26005)(2906002)(478600001)(6506007)(41300700001)(7696005)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlNtMWY2bUhGenN3NUpXRHkwamxTYkFFcmlUU2tiVUlDa0djWnBYbGNSelps?=
 =?utf-8?B?S1NSSk50N3laUzB5V09ZYlNpQnBudkZiWVBXOXFhbStPK1hDR1JtaFlxVjZa?=
 =?utf-8?B?OE01MEZSYU9LN1o4SGRqQnQvdXR1YUZiWjNJT1kzNkZ2U0JEdDhUVHowb1do?=
 =?utf-8?B?WFNDTG1JM2pURmxvVmUyVjdRTFZFS2pwUzdEMzNvRnJqTUVNTEl5b3A4Wlh5?=
 =?utf-8?B?YkRqOW5ZWjFmSXd0Zjlab21RNU5QVnJtYjRKdUMySEVhNzFaT0YwM2ZWUkFR?=
 =?utf-8?B?N0tjZ2FHdjJ6bFIxYUxPYzJzSkdSajVCWEt6dU1TQXp4RDBLaWdvTklBaFJC?=
 =?utf-8?B?bVNiWnVyRENXUURUSis4MEJMbWptcWVWYnFWMXhGbXBBdUI1WWp4bUFYR2Zp?=
 =?utf-8?B?MTF3cnU1WlJuMy9IUTRKL0F6bUVjT3IvOEhHeFJJOWFXM2ozMUwwMUhlZVJy?=
 =?utf-8?B?U2tQN2Z4OFZXZHUrY28xSnMyOHlpTE56NEg1bkJUK0s0Nkt3aitzYVBiNXNZ?=
 =?utf-8?B?ZERrOGs3MG81NHE1SWZsMzg1b0RCczRpVzRMYzBhNEVOczBDYWQ1T0lwcHVX?=
 =?utf-8?B?UGNwbW0xL1VHdHNYb0YrN0EwYkdjcnN2ZkhEYzhnTWk5TUt5ZXZGRXpHVi9x?=
 =?utf-8?B?eFdRR2FmUXk5cDlMS2xZV0Mxa2ZkcituTnNvMC9acVFaQm1iMFFyN1RXc0d1?=
 =?utf-8?B?Zy93dW0yeS83MTNCUWJqdVBLdjdTQUp2K0laK1MxN094bjR1azhzSnRRZHVG?=
 =?utf-8?B?WloxejBucldEdEVPN1FJeDZmOEloV1BCVUVNeGhyMVFlUDV2TW85Q3A1VGJH?=
 =?utf-8?B?YWltU1NGZFZBS0hjQ0dOc1gza1l6SCsyc2ZqSy9RdlFzNzBCSkJQMjYzbCs0?=
 =?utf-8?B?QnRvQUZ1cFhXZDVVLzBScW9EMURBd1B5Vkx5WnplQ3N4UWMwY2I3VWtCN3ZQ?=
 =?utf-8?B?ckRwamtDa0U4QTZreHdXRmllN1VWZkpUZzVKWjl4djFQd1lCelRvbVR6Q2VK?=
 =?utf-8?B?VmlueitscHJ4TUNXM29vbERtR1p1U3psTE16dnlKVi9pVENNRmdKMUF1Y0dK?=
 =?utf-8?B?ZmFydy9iS3JUOWN5SGY0aTlyR1VuaWxOMUlrcFd5dzhNWUIxZGJueXhYMkxx?=
 =?utf-8?B?QmZyaDZrRXY1VERZR1grd1YraDFicVpaZGpQWlFlei92ME0rQ2F0WGEwUXRT?=
 =?utf-8?B?ZVZkdzBLTXZoVjdGUjdyVEg5MFZ4SHQxRWhYYVJHRDFZYkZRZzh4MHN4dmgv?=
 =?utf-8?B?WGMyRWxtZDR2T1F5WCsvSjdBbUZGNC9lWE00anVtdHN2WDllVG9YdlROT3pu?=
 =?utf-8?B?U0Q0Y09xYTNYQjd6eEVuMnBaNU56aFM2SEtYUXBJOXFoYVUySEtmWUZOa1pq?=
 =?utf-8?B?R2tTVU9mYzZQbnBBZGFhRUhvZnIwblZHZmtWeGVSYUhaYmlzdzdrQy80ZzBa?=
 =?utf-8?B?c01WNGhDa2I3VkNKMFRhRFpGZnFhVE1PZHVDOGlhaHVsUHQvUHJybVk4R1Bn?=
 =?utf-8?B?RnNKWkZnNkNaeWdxRUs2RkFGSElJVFJ5aHl2aW05dVBHNE1DZWxJNTFGSUVB?=
 =?utf-8?B?VGRURFVib1hXem9jYmkybVRYSHdKZTNndXp2dTlOUEJOaVc1TnhqTEFydUpM?=
 =?utf-8?B?Q1kwNjhHYnQ1UVU5TlBPYm5QSmE0Z2VRL1hZZ0VRM0E5RDdFODI3VEFLelE1?=
 =?utf-8?B?Ni9xVHNIaHBXUTdDSkh1eTFOZ1pSa3hQeGQ4alNTQmFrL3NNWmlGa1NiQ0xi?=
 =?utf-8?B?ZnRWcnVhVnJuNmVBZXVrbWpuS2hoVGxPSXNQTU16Ujh3R0x0WFNJbXNRM3BR?=
 =?utf-8?B?OHdKQ3lXWXRiK2FkMG5BVUVQYk1CS3FRaWI3dVVEblJ5V1dnYUtVU25pRnVP?=
 =?utf-8?B?Wmd6bnZ1aytnZ0VkUGI4UnFxT3huQ0RwVlljYVBtYStPMTBnbGNPSDgzTnJI?=
 =?utf-8?B?M21OdkJQekhMMkhQSDlqUEttbHpzRWdNSVA2aUIySUVJenlQM2c4eHFRaFNj?=
 =?utf-8?B?SXNiMjk4Zms0a3pIaUZiR0MwL241SUtkd0IvbFFON2h1V2x6TDV4b0NJQkZm?=
 =?utf-8?B?SmR4cm1TM1c3VzZlZ1ZNcmtMS0QzTWk4WGtKa215MjFHNXBiWjlYUXp5V3pE?=
 =?utf-8?Q?/ODir8bG8DmLWjjteK0F/N1Zv?=
Content-Type: multipart/mixed;
        boundary="_002_SG2PR04MB3899966B6BCE88B9A629789181809SG2PR04MB3899apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR04MB3899.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e16485-f0d4-4aca-e030-08da5ef81b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 02:34:52.8145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9q9EA/10eZKK8+0wj0pxWVAXPGkjX/P+9snXPG0RrlIp3p+ZB4p2TEdkIjFCUcGElB2qFOEQl/9imcwGwPgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5972
X-Proofpoint-GUID: CBIvfy6bHPAanbx2Ktzjup9zWTAeBtAP
X-Proofpoint-ORIG-GUID: CBIvfy6bHPAanbx2Ktzjup9zWTAeBtAP
X-Sony-Outbound-GUID: CBIvfy6bHPAanbx2Ktzjup9zWTAeBtAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_02,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_SG2PR04MB3899966B6BCE88B9A629789181809SG2PR04MB3899apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhpcyBjb21taXQgbW92ZXMgdXBkYXRpbmcgZmlsZSBhdHRyaWJ1dGVzIGFuZCB0aW1lc3RhbXBz
IGJlZm9yZQ0KY2FsbGluZyBfX2V4ZmF0X3dyaXRlX2lub2RlKCksIHNvIHRoYXQgYWxsIHVwZGF0
ZXMgb2YgdGhlIGlub2RlDQpoYWQgYmVlbiB3cml0dGVuIGJ5IF9fZXhmYXRfd3JpdGVfaW5vZGUo
KSwgbWFya19pbm9kZV9kaXJ0eSgpIGlzDQp1bm5lZWRlZC4NCg0KU2lnbmVkLW9mZi1ieTogWXVl
emhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFu
ZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFt
YUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBEYW5pZWwgUGFsbWVyIDxkYW5pZWwucGFsbWVyQHNv
bnkuY29tPg0KLS0tDQogZnMvZXhmYXQvZmlsZS5jICB8IDM3ICsrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0NCiBmcy9leGZhdC9pbm9kZS5jIHwgIDEgKw0KIDIgZmlsZXMgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9m
cy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMNCmluZGV4IDA4ZTVmZmQ3OGIxMC4uNGUw
NzkzZjM1ZThmIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZmlsZS5jDQorKysgYi9mcy9leGZhdC9m
aWxlLmMNCkBAIC0xNDgsOCArMTQ4LDE3IEBAIGludCBfX2V4ZmF0X3RydW5jYXRlKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIGxvZmZfdCBuZXdfc2l6ZSkNCiAJaWYgKGVpLT50eXBlID09IFRZUEVfRklM
RSkNCiAJCWVpLT5hdHRyIHw9IEFUVFJfQVJDSElWRTsNCiANCi0JLyogdXBkYXRlIHRoZSBkaXJl
Y3RvcnkgZW50cnkgKi8NCi0JaW5vZGUtPmlfbXRpbWUgPSBjdXJyZW50X3RpbWUoaW5vZGUpOw0K
KwkvKg0KKwkgKiB1cGRhdGUgdGhlIGRpcmVjdG9yeSBlbnRyeQ0KKwkgKg0KKwkgKiBJZiB0aGUg
ZGlyZWN0b3J5IGVudHJ5IGlzIHVwZGF0ZWQgYnkgbWFya19pbm9kZV9kaXJ0eSgpLCB0aGUNCisJ
ICogZGlyZWN0b3J5IGVudHJ5IHdpbGwgYmUgd3JpdHRlbiBhZnRlciBhIHdyaXRlYmFjayBjeWNs
ZSBvZg0KKwkgKiB1cGRhdGluZyB0aGUgYml0bWFwL0ZBVCwgd2hpY2ggbWF5IHJlc3VsdCBpbiBj
bHVzdGVycyBiZWluZw0KKwkgKiBmcmVlZCBidXQgcmVmZXJlbmNlZCBieSB0aGUgZGlyZWN0b3J5
IGVudHJ5IGluIHRoZSBldmVudCBvZiBhDQorCSAqIHN1ZGRlbiBwb3dlciBmYWlsdXJlLg0KKwkg
KiBfX2V4ZmF0X3dyaXRlX2lub2RlKCkgaXMgY2FsbGVkIGZvciBkaXJlY3RvcnkgZW50cnksIGJp
dG1hcA0KKwkgKiBhbmQgRkFUIHRvIGJlIHdyaXR0ZW4gaW4gYSBzYW1lIHdyaXRlYmFjay4NCisJ
ICovDQogCWlmIChfX2V4ZmF0X3dyaXRlX2lub2RlKGlub2RlLCBpbm9kZV9uZWVkc19zeW5jKGlu
b2RlKSkpDQogCQlyZXR1cm4gLUVJTzsNCiANCkBAIC0yMDIsMTIgKzIxMSw2IEBAIHZvaWQgZXhm
YXRfdHJ1bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IHNpemUpDQogCWlmIChlcnIp
DQogCQlnb3RvIHdyaXRlX3NpemU7DQogDQotCWlub2RlLT5pX2N0aW1lID0gaW5vZGUtPmlfbXRp
bWUgPSBjdXJyZW50X3RpbWUoaW5vZGUpOw0KLQlpZiAoSVNfRElSU1lOQyhpbm9kZSkpDQotCQll
eGZhdF9zeW5jX2lub2RlKGlub2RlKTsNCi0JZWxzZQ0KLQkJbWFya19pbm9kZV9kaXJ0eShpbm9k
ZSk7DQotDQogCWlub2RlLT5pX2Jsb2NrcyA9IHJvdW5kX3VwKGlfc2l6ZV9yZWFkKGlub2RlKSwg
c2JpLT5jbHVzdGVyX3NpemUpID4+DQogCQkJCWlub2RlLT5pX2Jsa2JpdHM7DQogd3JpdGVfc2l6
ZToNCkBAIC0yODksNiArMjkyLDEyIEBAIGludCBleGZhdF9zZXRhdHRyKHN0cnVjdCB1c2VyX25h
bWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KIAkJCWF0dHItPmlh
X3ZhbGlkICY9IH5BVFRSX01PREU7DQogCX0NCiANCisJaWYgKGF0dHItPmlhX3ZhbGlkICYgQVRU
Ul9TSVpFKQ0KKwkJaW5vZGUtPmlfbXRpbWUgPSBpbm9kZS0+aV9jdGltZSA9IGN1cnJlbnRfdGlt
ZShpbm9kZSk7DQorDQorCXNldGF0dHJfY29weSgmaW5pdF91c2VyX25zLCBpbm9kZSwgYXR0cik7
DQorCWV4ZmF0X3RydW5jYXRlX2F0aW1lKCZpbm9kZS0+aV9hdGltZSk7DQorDQogCWlmIChhdHRy
LT5pYV92YWxpZCAmIEFUVFJfU0laRSkgew0KIAkJZXJyb3IgPSBleGZhdF9ibG9ja190cnVuY2F0
ZV9wYWdlKGlub2RlLCBhdHRyLT5pYV9zaXplKTsNCiAJCWlmIChlcnJvcikNCkBAIC0yOTYsMTMg
KzMwNSwxNSBAQCBpbnQgZXhmYXRfc2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91
c2VybnMsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCiANCiAJCWRvd25fd3JpdGUoJkVYRkFUX0ko
aW5vZGUpLT50cnVuY2F0ZV9sb2NrKTsNCiAJCXRydW5jYXRlX3NldHNpemUoaW5vZGUsIGF0dHIt
PmlhX3NpemUpOw0KKw0KKwkJLyoNCisJCSAqIF9fZXhmYXRfd3JpdGVfaW5vZGUoKSBpcyBjYWxs
ZWQgZnJvbSBleGZhdF90cnVuY2F0ZSgpLCBpbm9kZQ0KKwkJICogaXMgYWxyZWFkeSB3cml0dGVu
IGJ5IGl0LCBzbyBtYXJrX2lub2RlX2RpcnR5KCkgaXMgdW5uZWVkZWQuDQorCQkgKi8NCiAJCWV4
ZmF0X3RydW5jYXRlKGlub2RlLCBhdHRyLT5pYV9zaXplKTsNCiAJCXVwX3dyaXRlKCZFWEZBVF9J
KGlub2RlKS0+dHJ1bmNhdGVfbG9jayk7DQotCX0NCi0NCi0Jc2V0YXR0cl9jb3B5KCZpbml0X3Vz
ZXJfbnMsIGlub2RlLCBhdHRyKTsNCi0JZXhmYXRfdHJ1bmNhdGVfYXRpbWUoJmlub2RlLT5pX2F0
aW1lKTsNCi0JbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7DQorCX0gZWxzZQ0KKwkJbWFya19pbm9k
ZV9kaXJ0eShpbm9kZSk7DQogDQogb3V0Og0KIAlyZXR1cm4gZXJyb3I7DQpkaWZmIC0tZ2l0IGEv
ZnMvZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IGViYzY0ZmE1YzJkZS4u
M2FjZmJlYzFhMGQ0IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhm
YXQvaW5vZGUuYw0KQEAgLTM2OSw2ICszNjksNyBAQCBzdGF0aWMgdm9pZCBleGZhdF93cml0ZV9m
YWlsZWQoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsIGxvZmZfdCB0bykNCiANCiAJaWYg
KHRvID4gaV9zaXplX3JlYWQoaW5vZGUpKSB7DQogCQl0cnVuY2F0ZV9wYWdlY2FjaGUoaW5vZGUs
IGlfc2l6ZV9yZWFkKGlub2RlKSk7DQorCQlpbm9kZS0+aV9tdGltZSA9IGlub2RlLT5pX2N0aW1l
ID0gY3VycmVudF90aW1lKGlub2RlKTsNCiAJCWV4ZmF0X3RydW5jYXRlKGlub2RlLCBFWEZBVF9J
KGlub2RlKS0+aV9zaXplX2FsaWduZWQpOw0KIAl9DQogfQ0KLS0gDQoyLjI1LjENCg==

--_002_SG2PR04MB3899966B6BCE88B9A629789181809SG2PR04MB3899apcp_
Content-Type: application/octet-stream;
	name="v1-0002-exfat-remove-duplicate-write-inode-for-truncating.patch"
Content-Description: 
 v1-0002-exfat-remove-duplicate-write-inode-for-truncating.patch
Content-Disposition: attachment;
	filename="v1-0002-exfat-remove-duplicate-write-inode-for-truncating.patch";
	size=3257; creation-date="Wed, 06 Jul 2022 02:24:50 GMT";
	modification-date="Wed, 06 Jul 2022 02:34:52 GMT"
Content-Transfer-Encoding: base64

VGhpcyBjb21taXQgbW92ZXMgdXBkYXRpbmcgZmlsZSBhdHRyaWJ1dGVzIGFuZCB0aW1lc3RhbXBz
IGJlZm9yZQpjYWxsaW5nIF9fZXhmYXRfd3JpdGVfaW5vZGUoKSwgc28gdGhhdCBhbGwgdXBkYXRl
cyBvZiB0aGUgaW5vZGUKaGFkIGJlZW4gd3JpdHRlbiBieSBfX2V4ZmF0X3dyaXRlX2lub2RlKCks
IG1hcmtfaW5vZGVfZGlydHkoKSBpcwp1bm5lZWRlZC4KClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5n
IE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VA
c29ueS5jb20+ClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnku
Y29tPgpSZXZpZXdlZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4K
LS0tCiBmcy9leGZhdC9maWxlLmMgIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQogZnMvZXhmYXQvaW5vZGUuYyB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5j
IGIvZnMvZXhmYXQvZmlsZS5jCmluZGV4IDA4ZTVmZmQ3OGIxMC4uNGUwNzkzZjM1ZThmIDEwMDY0
NAotLS0gYS9mcy9leGZhdC9maWxlLmMKKysrIGIvZnMvZXhmYXQvZmlsZS5jCkBAIC0xNDgsOCAr
MTQ4LDE3IEBAIGludCBfX2V4ZmF0X3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZf
dCBuZXdfc2l6ZSkKIAlpZiAoZWktPnR5cGUgPT0gVFlQRV9GSUxFKQogCQllaS0+YXR0ciB8PSBB
VFRSX0FSQ0hJVkU7CiAKLQkvKiB1cGRhdGUgdGhlIGRpcmVjdG9yeSBlbnRyeSAqLwotCWlub2Rl
LT5pX210aW1lID0gY3VycmVudF90aW1lKGlub2RlKTsKKwkvKgorCSAqIHVwZGF0ZSB0aGUgZGly
ZWN0b3J5IGVudHJ5CisJICoKKwkgKiBJZiB0aGUgZGlyZWN0b3J5IGVudHJ5IGlzIHVwZGF0ZWQg
YnkgbWFya19pbm9kZV9kaXJ0eSgpLCB0aGUKKwkgKiBkaXJlY3RvcnkgZW50cnkgd2lsbCBiZSB3
cml0dGVuIGFmdGVyIGEgd3JpdGViYWNrIGN5Y2xlIG9mCisJICogdXBkYXRpbmcgdGhlIGJpdG1h
cC9GQVQsIHdoaWNoIG1heSByZXN1bHQgaW4gY2x1c3RlcnMgYmVpbmcKKwkgKiBmcmVlZCBidXQg
cmVmZXJlbmNlZCBieSB0aGUgZGlyZWN0b3J5IGVudHJ5IGluIHRoZSBldmVudCBvZiBhCisJICog
c3VkZGVuIHBvd2VyIGZhaWx1cmUuCisJICogX19leGZhdF93cml0ZV9pbm9kZSgpIGlzIGNhbGxl
ZCBmb3IgZGlyZWN0b3J5IGVudHJ5LCBiaXRtYXAKKwkgKiBhbmQgRkFUIHRvIGJlIHdyaXR0ZW4g
aW4gYSBzYW1lIHdyaXRlYmFjay4KKwkgKi8KIAlpZiAoX19leGZhdF93cml0ZV9pbm9kZShpbm9k
ZSwgaW5vZGVfbmVlZHNfc3luYyhpbm9kZSkpKQogCQlyZXR1cm4gLUVJTzsKIApAQCAtMjAyLDEy
ICsyMTEsNiBAQCB2b2lkIGV4ZmF0X3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZf
dCBzaXplKQogCWlmIChlcnIpCiAJCWdvdG8gd3JpdGVfc2l6ZTsKIAotCWlub2RlLT5pX2N0aW1l
ID0gaW5vZGUtPmlfbXRpbWUgPSBjdXJyZW50X3RpbWUoaW5vZGUpOwotCWlmIChJU19ESVJTWU5D
KGlub2RlKSkKLQkJZXhmYXRfc3luY19pbm9kZShpbm9kZSk7Ci0JZWxzZQotCQltYXJrX2lub2Rl
X2RpcnR5KGlub2RlKTsKLQogCWlub2RlLT5pX2Jsb2NrcyA9IHJvdW5kX3VwKGlfc2l6ZV9yZWFk
KGlub2RlKSwgc2JpLT5jbHVzdGVyX3NpemUpID4+CiAJCQkJaW5vZGUtPmlfYmxrYml0czsKIHdy
aXRlX3NpemU6CkBAIC0yODksNiArMjkyLDEyIEBAIGludCBleGZhdF9zZXRhdHRyKHN0cnVjdCB1
c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCQkJYXR0
ci0+aWFfdmFsaWQgJj0gfkFUVFJfTU9ERTsKIAl9CiAKKwlpZiAoYXR0ci0+aWFfdmFsaWQgJiBB
VFRSX1NJWkUpCisJCWlub2RlLT5pX210aW1lID0gaW5vZGUtPmlfY3RpbWUgPSBjdXJyZW50X3Rp
bWUoaW5vZGUpOworCisJc2V0YXR0cl9jb3B5KCZpbml0X3VzZXJfbnMsIGlub2RlLCBhdHRyKTsK
KwlleGZhdF90cnVuY2F0ZV9hdGltZSgmaW5vZGUtPmlfYXRpbWUpOworCiAJaWYgKGF0dHItPmlh
X3ZhbGlkICYgQVRUUl9TSVpFKSB7CiAJCWVycm9yID0gZXhmYXRfYmxvY2tfdHJ1bmNhdGVfcGFn
ZShpbm9kZSwgYXR0ci0+aWFfc2l6ZSk7CiAJCWlmIChlcnJvcikKQEAgLTI5NiwxMyArMzA1LDE1
IEBAIGludCBleGZhdF9zZXRhdHRyKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywg
c3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCiAJCWRvd25fd3JpdGUoJkVYRkFUX0koaW5vZGUpLT50
cnVuY2F0ZV9sb2NrKTsKIAkJdHJ1bmNhdGVfc2V0c2l6ZShpbm9kZSwgYXR0ci0+aWFfc2l6ZSk7
CisKKwkJLyoKKwkJICogX19leGZhdF93cml0ZV9pbm9kZSgpIGlzIGNhbGxlZCBmcm9tIGV4ZmF0
X3RydW5jYXRlKCksIGlub2RlCisJCSAqIGlzIGFscmVhZHkgd3JpdHRlbiBieSBpdCwgc28gbWFy
a19pbm9kZV9kaXJ0eSgpIGlzIHVubmVlZGVkLgorCQkgKi8KIAkJZXhmYXRfdHJ1bmNhdGUoaW5v
ZGUsIGF0dHItPmlhX3NpemUpOwogCQl1cF93cml0ZSgmRVhGQVRfSShpbm9kZSktPnRydW5jYXRl
X2xvY2spOwotCX0KLQotCXNldGF0dHJfY29weSgmaW5pdF91c2VyX25zLCBpbm9kZSwgYXR0cik7
Ci0JZXhmYXRfdHJ1bmNhdGVfYXRpbWUoJmlub2RlLT5pX2F0aW1lKTsKLQltYXJrX2lub2RlX2Rp
cnR5KGlub2RlKTsKKwl9IGVsc2UKKwkJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7CiAKIG91dDoK
IAlyZXR1cm4gZXJyb3I7CmRpZmYgLS1naXQgYS9mcy9leGZhdC9pbm9kZS5jIGIvZnMvZXhmYXQv
aW5vZGUuYwppbmRleCBlYmM2NGZhNWMyZGUuLjNhY2ZiZWMxYTBkNCAxMDA2NDQKLS0tIGEvZnMv
ZXhmYXQvaW5vZGUuYworKysgYi9mcy9leGZhdC9pbm9kZS5jCkBAIC0zNjksNiArMzY5LDcgQEAg
c3RhdGljIHZvaWQgZXhmYXRfd3JpdGVfZmFpbGVkKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBw
aW5nLCBsb2ZmX3QgdG8pCiAKIAlpZiAodG8gPiBpX3NpemVfcmVhZChpbm9kZSkpIHsKIAkJdHJ1
bmNhdGVfcGFnZWNhY2hlKGlub2RlLCBpX3NpemVfcmVhZChpbm9kZSkpOworCQlpbm9kZS0+aV9t
dGltZSA9IGlub2RlLT5pX2N0aW1lID0gY3VycmVudF90aW1lKGlub2RlKTsKIAkJZXhmYXRfdHJ1
bmNhdGUoaW5vZGUsIEVYRkFUX0koaW5vZGUpLT5pX3NpemVfYWxpZ25lZCk7CiAJfQogfQotLSAK
Mi4yNS4xCgo=

--_002_SG2PR04MB3899966B6BCE88B9A629789181809SG2PR04MB3899apcp_--
