Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191234DA29D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347016AbiCOSsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 14:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiCOSsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:48:39 -0400
Received: from mx0b-003b2802.pphosted.com (mx0b-003b2802.pphosted.com [205.220.180.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2BC13F62;
        Tue, 15 Mar 2022 11:47:26 -0700 (PDT)
Received: from pps.filterd (m0278972.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FIcfQv009328;
        Tue, 15 Mar 2022 18:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZqT/OP6lFm1bZ0Adrrn1Dq/brnoIfiiWWvcMmmFaK80=;
 b=G8Hutc1AcJRQR8EWUXZhSJzT5y+nPUYnjGfYiSCfhfy5D/uFGoRp0SDlBu2NCke2gBv2
 BtPhnMx13q5IxgoeaWRixBcWxRzFacPe2vHvNZMu3UajOB3uAaLu1x6C/Vb76zK+HDn5
 omYZMHBDVFOMc3TxKwWrduUJQMCYiBHP2VSgSb5xBBhsvvy2h1kASFKuMStEFHeIYyqO
 jU7yp1ib/PXdKXnAxuLSXyVhjOYJH6ECqhF2YnVFYhhZhVb3kANrVm+WFwbkTZybwG24
 w0jeW+WUcu36zVpLw/tNdDivWQDZoa0dBf9tfOt7FHzYSb9vI98vNvcn/rMn+izHlaDg dA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3et6443a6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 18:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkfSP9c4CQk9F/t2V77YmWt+2Y0SuOMWKU+zPhjePqHWFLhz8pPHFGmj+ZKKEfymBezMUqdgOZ0IVjz7K1WXQivNey4K8HRfRHe/Uzo5aryGgr06ODd8NgsLiQNRbZO+AY9i6eAxbiigSueOJNna6JJcKyatH3Ml7bAwliclJaaxDkI6F14XyUN2Qld0i64W7fLsSVHryb2xA5ImPUO2L7A6DZm+rf2toINDXk/POyeemteQgbN+ClkNgCDIXfJxtxNyq/fTm2ZkIY/Sev2r+Ok0oTIhCoEfskM2YfJfxuQg/p8qX5Nxog1iASoJlxZaRGdxui/xTGnP07lQq/YXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqT/OP6lFm1bZ0Adrrn1Dq/brnoIfiiWWvcMmmFaK80=;
 b=m15E/ypegUqyidKrIvTV2YtvdKDx+t/1SLO7I1bNLuj9miVZeBZW46qA71L6asKvggKCxGpiaYiqVvVuuILDzgoQknb9jwOAxmInguKcBSFobDTGAsgG2aaTuPOgtMf/4oku/jJHHwr9hue9J3kMRVhAWmjC8zCcxuz1BCeKuKqXW/VoJKO96ON+oXtVcxbD96RX6FuxjQ+2CiB0tIpzxhP8m5FQGEFFzFbD2BzYoAGslCMUDQxgxQqNMbLgEkg2TO7okY9YLi0wSqlnbFnhK7Ez9VZe7nDwjVxC4F7xT4nz2xEfcBGXqbl4+VaRDeO8lziSSYMzSnxDhW1H/20tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from PH0PR08MB7889.namprd08.prod.outlook.com (2603:10b6:510:114::11)
 by MWHPR0801MB3738.namprd08.prod.outlook.com (2603:10b6:301:7e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 18:47:09 +0000
Received: from PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::486:49b8:9b7d:31a4]) by PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::486:49b8:9b7d:31a4%9]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 18:47:09 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: RE: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpnaM/oGinGMOEqzg/qq41aU3KzA0iCAgAAI0oCAAADIsA==
Date:   Tue, 15 Mar 2022 18:47:09 +0000
Message-ID: <PH0PR08MB7889A1EB0A223630E8747A53DB109@PH0PR08MB7889.namprd08.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <CO3PR08MB7975BCC4FF096DD6190DEF5DDC109@CO3PR08MB7975.namprd08.prod.outlook.com>
 <73adf81b-0bca-324e-9f4f-478171a1f617@acm.org>
In-Reply-To: <73adf81b-0bca-324e-9f4f-478171a1f617@acm.org>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2022-03-15T18:42:47Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=eb9586a8-b9ab-4cc5-b8ab-03c09b2f96f6;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
msip_label_37874100-6000-43b6-a204-2d77792600b9_enabled: true
msip_label_37874100-6000-43b6-a204-2d77792600b9_setdate: 2022-03-15T18:47:06Z
msip_label_37874100-6000-43b6-a204-2d77792600b9_method: Standard
msip_label_37874100-6000-43b6-a204-2d77792600b9_name: Confidential
msip_label_37874100-6000-43b6-a204-2d77792600b9_siteid: f38a5ecd-2813-4862-b11b-ac1d563c806f
msip_label_37874100-6000-43b6-a204-2d77792600b9_actionid: c4be5ef8-8467-4a02-a25b-e435816836d4
msip_label_37874100-6000-43b6-a204-2d77792600b9_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91c49179-850e-4fbd-0104-08da06b435b7
x-ms-traffictypediagnostic: MWHPR0801MB3738:EE_
x-microsoft-antispam-prvs: <MWHPR0801MB3738DCD1F47E61735C0993D7DB109@MWHPR0801MB3738.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QfdF0qo1BuFzQwk6QngyOXA7q62jEo6GJM2WCESdMkyuo6jWSQdDsqbr2bhnKZWbnckvB6RXWecUOYQRCrBc4c7Ekp9+LkBo3Sf1uaVSqDM6oD1gTGpyFWqVmwXndnVI4noyntsFBd4cLsLHFOlA4lTWhBCVxaBK/OsKAV4HXGtpZbOiRMnrib+6wecNXJWYeTQOWkLgxZIGJCYJlBpa9fiSXyRiiOuuxRVEDlRJH5YsGv6Axi/nB0ID2VwVfaT72iT//BIrjhT5y7yeDfZ6N3I8mOh1gFrqAhHholgkaozL9bK63mMzt5X1Cq2jkxmpv+n/UMtKw7iDDN+M8cgTIAuj09yiZSvXDsz/VVd6fjA4b7NfBydJeunTbX1pUagCiBCLy8huB26Pe/zMZeRJBbZfMSGwAZ46FPjg6fam83NxVBD+eUwNkLAU+GLu+mzVeuOH+g9rGjqgOQkkjEsUUNnZViNeeJnWCnbwTNfGDJrflk1yMWnnHL1QHXrc60JOk0dmRF6wMgBVbdPPfYCeOamF45TIXmGyPBDzmhDmAe+xcL1mtd/TrSoaCa19D+R5OajMC77h7/W2TNkhLVL5rGNS2nBIMsSv99GRyNAtkbJm0juBQBbZHj7paYmVfpB3v74jG2IUH/f0F9HQzFMUn7ZLdV16ACIt9x+yxWqSuM5sWP3wj6dLhq4EnKRmGgHbdvoEdxfgAY9sdfH6ZGy4i2aOKRXkTn8mRp8fhoDzHN6ELlF2tTZVUaXnPcTWxM3yLUDgLKJC6IN+rPM/MspZGB0kU95QkXPSPMlzsE6uH84=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7889.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(33656002)(66476007)(66556008)(64756008)(966005)(66446008)(9686003)(53546011)(6506007)(26005)(7696005)(186003)(508600001)(71200400001)(52536014)(5660300002)(8936002)(83380400001)(4326008)(7416002)(110136005)(2906002)(4744005)(54906003)(8676002)(122000001)(316002)(86362001)(38100700002)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWpxa3hkOFVrQ1VaSWdkMnJFdllsNDBwbU52TWxVWk1maWR4c3ZPbGZRY3d5?=
 =?utf-8?B?YWhYaU05WXNZbENpd05oSkdFRDgwMklnVlVDN0RqSEs5dERzYlNMekc1Rlp1?=
 =?utf-8?B?QUN5WTNFK0RSVHdnSHBvYzI3Y29RaVlQcVVJZkUxN3hVMHJBeEFWUE5FbnRG?=
 =?utf-8?B?dUVYd0d6eCs4Zlh3UDQ4VUVRQWJsYUhlbEFPSEJMZ2hUa3NtaS9nM0hlcUtX?=
 =?utf-8?B?UXFPYUdkQTJ3SnFBTGh6Tm9tV0ZZMkxpZzJIdCtEYWdYOHZlbzgwSitON2l6?=
 =?utf-8?B?eW1OTjdwNG9aclFUTEI5b3oyOUwzSWdEQlhVVEcxRmhuNzIyMHZvdHRlZ0FH?=
 =?utf-8?B?NTJOUTIzdVdRZDRsZEQwY0YwREZrYjZ5S0NDUnlGaDNtUDFJS2hyTlhUaENw?=
 =?utf-8?B?bXJhQml0eTFFbTB1bCtxcUhJMFJRbDR1a1FubzlDMUVxZ3dnWm10SFlvUzhE?=
 =?utf-8?B?UDlkRVM2aDRrOW1iMzdXUVZuN1dMMmY4ZUo4b0pvMWgwMzdiUk5hN2FLUmNB?=
 =?utf-8?B?L3FIMEM2SllSOUxKbG9mNDhLd0RDUTM2MDJNWWdPYWRVdFlMWGZYZHhwWWRp?=
 =?utf-8?B?R3pHRnVwS1ZBZEQ0ckR1Slh3UEpGc09ia2kzYWhTaHhvczJRK2dFckxxNDVD?=
 =?utf-8?B?SjRCWU9NeTVIeXI4aFJRRFNPZW9xTVYyMXladVIrUHdtWENpUzJVOStiNlgx?=
 =?utf-8?B?d0h4blpVU3VXdkJUd2NoVmVMdTNTcHE3Wi9TL2JZcFVERzBNQlUyOUJTdWVZ?=
 =?utf-8?B?bXBZNS9LZmdCNElzRWZBdEViYzNaVDJvOEJvNUgvWW1Bd05HbGQ1V21iR2ZQ?=
 =?utf-8?B?NzVBMzBMMEFGVlB4QUxyWmZXZVJKWTJicEpLK0NnTmxwaTkrQXFrVFRIQlRN?=
 =?utf-8?B?T0gwQU1QNnJjZ0lKYWFCUW1EemUxdE9kNUxQK2Yzd2JpUDhsM1VyR2V6Zk40?=
 =?utf-8?B?VzhsSEE2ejNMRDZMU3BTZlBHc012YWc4aXpxbDh3TzJQb0c3YTR2b21VQ0Vx?=
 =?utf-8?B?aGlNMlJXbFRjdGZSOVd5ZFYrcTZNRHBLQUFMUzdzUFh1eGs1Y00xY0FYK0xy?=
 =?utf-8?B?bGRMbVI2OE85c2xhUTBXa09YaVEreU5UZzhnRVpkMG90ZEN5ZWpRTjV5VU1F?=
 =?utf-8?B?Nit6UDBIVDRDY2I0QXlTZlB5bFFxamtzQ2dqNXFMQlU2bmppN2ppN1R4WGs4?=
 =?utf-8?B?SmFPMEJiVmNzeUNaSVVZaWQ5cGlnOElFQUg5QkZjcDN6YkhRQWpiSDNiME1R?=
 =?utf-8?B?V0ErM2pKM2s4d1JzUUNKcmRYUnpHWXg2dWRRN281dEQ5c1A5a3NEUFQ0T21J?=
 =?utf-8?B?aWxPdTJ5azVCbXFLNWdDTDRtQlV2cjNFMlRqMTN3TWErajAzV1ZMdnA0b1JD?=
 =?utf-8?B?SXpZZkVrRkpTTVVEdlkvaTRDOGc3S0M1VlJyWTVlUnpmSWV2NzhncjNjS2RF?=
 =?utf-8?B?bXIyYUdSMzBlbXNXalZFRlBVZzdmWW1OT2taWDNzWnVlazBkTlF0endqNGVZ?=
 =?utf-8?B?dUFDSEE0dndyZmh3Mkk1aDFDbU04M2R3ckYzOTVQZUFSbm5uL2lpQlZNOU5J?=
 =?utf-8?B?aDY2Tlk2NnhxU2pYSXgrZHRrZXc3c3FmMDYwWnVqRTdRTVFEWHRNUCtmeVky?=
 =?utf-8?B?MXMrQzYyODEyUklwL3owSkdGN1YvK3pJNnN5MjdqUFlwdUtuaVVsS2NQT1Y5?=
 =?utf-8?B?ekxsT2s5aE1BUXZhOWNXd3poOW02SjdMZGU2ZldpTXZkUTNWTDYwOElNNkpr?=
 =?utf-8?B?R2ZWTjFXV1lhVnlLd1lCT1orZVdWdUJBeGJEM2RncHhoSGdkNkVwN1dpTVRm?=
 =?utf-8?B?b2FYMjdWbDdUeHl1aHFWb2VRcjJ5T3pQZllFWDF1ZEpreiticlZhOHFpUlJn?=
 =?utf-8?B?MVZFazFYSHZuVldSY1EzdmxjN2p4M29BVDlVRStuUGN0SkdEb0VKbllWb2lk?=
 =?utf-8?Q?/kCGHR/fGprOoXNeUJZeh1sU0Fgqqy7h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7889.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c49179-850e-4fbd-0104-08da06b435b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 18:47:09.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMkRzQuarZAyOXCFUfqWKNM3+DmC5SZQqurN/A5MrafL0MQrG/U6k1dpKmOpmAiTyh0yf+FGGwrhgU5sL3LhGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0801MB3738
X-Proofpoint-GUID: bWgthZ8lh7rRsKD7yIspC_K9mrFMv_Y6
X-Proofpoint-ORIG-GUID: bWgthZ8lh7rRsKD7yIspC_K9mrFMv_Y6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TWljcm9uIENvbmZpZGVudGlhbA0KDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBbTFNGL01NL0JQRiBC
b0ZdIEJvRiBmb3IgWm9uZWQgU3RvcmFnZQ0KPiANCj4gQ0FVVElPTjogRVhURVJOQUwgRU1BSUwu
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4gcmVj
b2duaXplIHRoZSBzZW5kZXIgYW5kIHdlcmUgZXhwZWN0aW5nIHRoaXMgbWVzc2FnZS4NCj4gDQo+
IA0KPiBPbiAzLzE1LzIyIDExOjA4LCBMdWNhIFBvcnppbyAobHBvcnppbykgd3JvdGU6DQo+ID4g
Q2FuIEkgZ2V0IGludml0YXRpb24/DQo+IA0KPiBIaSBMdWNhLA0KPiANCj4gQSBsaW5rIHRvIHRo
ZSBmb3JtIHRvIHJlcXVlc3QgYXR0ZW5kYW5jZSBpcyBhdmFpbGFibGUgYXQNCj4gaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZaGVyV3ltaTFF
KjJGaFAqMkZzUw0KPiBAbG9jYWxob3N0LmxvY2FsZG9tYWluL19fO0pTVSEhS1pUZE9DamhndDRo
Z3chdEZScnFIbDVHamZ6MlZ5cndTNlcwYjdiU2lKDQo+IFRmcW54U0s4LXpQaWtJbEpsRlFtcGl6
WWpBQkpaTFRueU9nJA0KPiANCg0KQmFydCwNCg0KV2UgaGFkIHN1Ym1pdHRlZCB0aGUgcmVxdWVz
dCB2aWEgR29vZ2xlIEZvcm1zIGFuZCBJIHJlZ3JldCBpdCBhcHBlYXJzIHRvIGJlIGFmdGVyIHRo
ZSByZXF1ZXN0ZWQNCmRlYWRsaW5lIG9mIE1hcmNoIDFzdC4NCg0Ka2luZCByZWdhcmRzLA0KQmVh
bg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gDQo+IEJhcnQuDQoNCg0KTWljcm9uIENvbmZpZGVudGlh
bA0K
