Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0A4A7A6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245236AbiBBV2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 16:28:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56130 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245186AbiBBV17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:27:59 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhJQ023474;
        Wed, 2 Feb 2022 21:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y8bISZxrg2QYsUb8qokbtYfB9Uag7XapprgGKVo24/U=;
 b=wVIsbJr55mt8z/cMh9y0EmpZuoUOf26ZSHviGWnWvoDoxtUhH7z6S4v95olF2zAZ9zi+
 2Cmy2YkhKOVRxrLhoE5N+1EFHkho2HfvGBosZ2vWNMGKCytz6dE7wHlkDF0RhXZoFoVa
 VYNJeRPfpIWZzHzph8BX3W9KLhjR8CfgcSukR0pX3YEa9bYpQyqRFwQB78qYJQTIlSjM
 73Ta7EiJHA/iIqzrbxX6Xm74W12jfczLTpjYH54MNWH2aHhNC7gvKjACqpOvbGyaY8MY
 Y0ncSVjVNijCYBG/PPXflIx4jF4jYfu0bnA+KONVIrUuhGxIXBoaNQxnAwJMkEH5RNtc kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2q089-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:27:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212LABS0152982;
        Wed, 2 Feb 2022 21:27:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by userp3020.oracle.com with ESMTP id 3dvy1tbdyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNpSbu08jb9SXqcq+o3ByPfsrv2kOOV8o3S+cHxruqQhbHtItT7bUw06kR5KH77HWj+AEb2gyHoI4NOZSrIXQhng8kABlEqPKl/SIUyN0GZokUu302wB7zRG/eeskdP+HpHHEXpazRygjaWb7Y61ReX+dVSc6NILW9zAnvMtCpy0OteL9L5XBwX90PDFFyUt2TUTrfO1SMmEeO6jZ/gsnK+38bRDet2roJUPd/zeBmnOJoVzB9izk+RVIJ8lZ9J1c/CtiTAUXRfE/lLLdQGjJo3y21XlohzPjLtxONkmCboOCu9aJsTQfQ8lnHt82XDbTSC+ennjPn4K+tRrBS1kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8bISZxrg2QYsUb8qokbtYfB9Uag7XapprgGKVo24/U=;
 b=PDBJwH1GnMFF8mdywuPiFD1Ys1Sa4it0LAblRU4E5Es258ZV9es8htQ9LMrcMkXaSyISFYxbAT/geqbvVEuC7ExQj0x9pIO7Gkp9qqJTLPZWIyqU5v5d5OCROJogPQop7t++vVdzubED0kvCy9nTsxX25k5Q4XD27DwfWP6wHXMZtq8IzNZ+c5jhIk6DY10D9iS8pcOdSQPO9+lvZ8IpddkTtaytF+wLxNAb/cBQDJ5px3muNXLRgr0An5HZoUyRt+dJo/TsiP2OhG0kUXdRhNVBj+ZtVshmSY0NKSirLO2qb4s/XMRy0bEndhSBTK7Hkb+lTkVrq5aDnbnyP7kGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bISZxrg2QYsUb8qokbtYfB9Uag7XapprgGKVo24/U=;
 b=xbk+Uv6MGyIBoi/r9M6Co4sq4o6hPmKMc/UZ7h4pw4OgYk/8KpvR1p18rFY70z56lJQ+MsVdI7P4cYsxdtR5vVrXZfkmxheTMfG34pJ+ZQ7QFO154XiwDNOrFEskjss/QU1BkUqvWNNLVh3jx0ZRbGnw5JRF6JnRnh3ZxkE6MPU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH0PR10MB5068.namprd10.prod.outlook.com (2603:10b6:610:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 21:27:43 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:27:43 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Thread-Topic: [PATCH v5 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Thread-Index: AQHYFI6IEi37NS8sIkiGyAObMdfpFKyARuiAgACHZgA=
Date:   Wed, 2 Feb 2022 21:27:42 +0000
Message-ID: <45b4a944-1fb1-73e2-b1f8-213e60e27a72@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-3-jane.chu@oracle.com>
 <YfqFuUsvuUUUWKfu@infradead.org>
In-Reply-To: <YfqFuUsvuUUUWKfu@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9641346-7d08-409b-be34-08d9e692d911
x-ms-traffictypediagnostic: CH0PR10MB5068:EE_
x-microsoft-antispam-prvs: <CH0PR10MB50686C8CD3F9AF60D62F0B26F3279@CH0PR10MB5068.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tq6DRJTqExx90NrBVbONNzh6GGfXHpMKmPS9RXFQtRXby6dTJTfeCRSfgCmAABb1FrmtzJhjqdz/XRYVmpxeIaDgOFKhTSXjqtS4mRBFOzTnYU9Y1dZ0Hk9OfE1RFbjMDojKdbilLVdjbiWk+b51/na7WyIG4yD3Urrt+TsIBwxu/uRqA62/jzbUWCG9ZrCkI1ELj4R61E5VULjbkKukNDzb0IZ/Tkupte3AtfbR2G6Nshm+dLm0y6dWAHgrVxcroZDjr045hLzpMBI/991F8crMOkMoqM9WzgBzgplFf2jKsKKHLrcVkJdDlK89Uz1hwuCck0tp9X5XZZIRS4Sz+wOoUfgHyGSKTNNcnSMYkwkbcVP+FmZCYWGT/uA2u8UDRReFVs0Bpix30VeeR4mopuaV+mCiQpexY8zRy3y0bxS5ArAKoBsc+3Q0zvYLy/uW7aSWBZjlRw3qH1ATbfjrAV9+dnPcqInz+7ZMuJVru2VWVK4w/8Jphr0GkDfuOynD0aGVue2Aj++7lBSJZ41Vwk3RRo02kIuisglw+c54Qkj9sBhbIjEHK4f9iHAJU1mJk5iDfqDWoAdPRMAoSD8c9ZfCbvoadYVwrQuxwHPlulE+HuuYmE9fNS7UAfVV0rmlUi3KSqiWfDYMKZP6WmX2pGyn87Peyxjs5M9lbHajqIQNhsIu5BAdzG9D8WSAwqGXifb9G1vhpXEEh30QTNvwvf5gvsQYVUwABIfAx6xNMy8b+xbjVf7M+yRV4NPh5blbYhJdz1I2Ir34yMpm+aSb4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(8676002)(8936002)(66476007)(5660300002)(66446008)(44832011)(91956017)(6916009)(316002)(76116006)(54906003)(4326008)(64756008)(6486002)(2906002)(31686004)(7416002)(4744005)(36756003)(38100700002)(53546011)(86362001)(6506007)(6512007)(122000001)(508600001)(26005)(71200400001)(186003)(31696002)(2616005)(83380400001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZMUHAwTkVPUGgvei9NUENiUHUxSnllbk04VDE1SXBBU2pWZXdSSzJuSmVE?=
 =?utf-8?B?UDcyL3hWR3BiMEc1Tndhb3dBZ28wa1VGNHBBSFRrb25jZkg4QlVWU01iUWQw?=
 =?utf-8?B?N2hlc0VWc01lUDAwT3k5NGhwb2tMcHMrbEo3OGFLeTNJbUlJb2FyTVlIck9L?=
 =?utf-8?B?d2RHMXlwZWxVUXpQaHBCeFArekRFcWhVR25xa1hsU1B5VGpJbWVGYWxBZUtj?=
 =?utf-8?B?bEdpdlltdmtlZTE5WWplaDMxajROQ29XU2dWOXJKakxTWC9EOVJSWGl4UU80?=
 =?utf-8?B?bFNlTVBjSDdIY2xDT3N2bHVHZXEwWml1WXpPSEcxenJiYlZiWUh3Y2lzaFpL?=
 =?utf-8?B?U3hXcTZ0VDdJQWFoNmgvOGZOZ3UvNmxka3FHalNRamdsNlBRMkpRSTNJMWti?=
 =?utf-8?B?SFprUUJiNE9XQ0g0ZkhLSisycjA1WmFucFhQMUdRak5BMkljTjc3c3Jxamcv?=
 =?utf-8?B?eWxwYmp6b05OQkM5WVhvQ3BZejJjcjFsVkxtcUFyWUhNSjl6bS9XK3haSHNR?=
 =?utf-8?B?RFdMS2szTDlXYmJyYWFKYTBEcEdJVmpNL0pnV2s0ZWMwY0lyQlBQRWkrREpQ?=
 =?utf-8?B?RnVBeGlwQ0FFdFdvTzBLTU8vcHRWeFN1SzZxdUdDZG5YZ3pmckk5U2hGZm94?=
 =?utf-8?B?KzRpQUhnZzVVOWZCUFJvbEcrdHZxaG5tN2pzQ1M4ZUVFY3VybERoNTFOK2pI?=
 =?utf-8?B?alpNSzFpM1JVWVNROXA2b2Z2ZjM4SmREVTlaOGQ4enFkdEllNE1JSmhCa3dv?=
 =?utf-8?B?YkF6amlMSjM4Rm8wa2xPR3hjNjdCWG12amJ0bWQwUWNGOWJ3MlpMQmwzMXdm?=
 =?utf-8?B?R1ptcTZ4VFo2ZGtpK25ZbEpyMU9FMCthTUZDQzRVeUFnZ1BKQmNsNWJwNE1w?=
 =?utf-8?B?QnNnYUUrWmRIRWJITGRyVm5hckVjT3poUzVIbTBURkVlb20rcWM5RThuK0c1?=
 =?utf-8?B?Sis2WVFlYjZDaVAwckNFd0RLUHEvbXp2Mnh2ck5uUEJLZjhVbzBMNTdVWlFC?=
 =?utf-8?B?QkRLTnNBQmN5Z2YyNjJ3QU1YbWJpc0xpQ1BDemx1NG9BRStvOENhdXJUU1V3?=
 =?utf-8?B?U0VJTVBrc0JMTVVlRWRuZUxEa3lLZXQvalNvd3RYNmw3RGx2NGo3OHVYQWdQ?=
 =?utf-8?B?NG9yRkR1ZFY2TGtiMnc5Vmtla3lWcVZTRkUyRERzdFZSK0RreXhJemdWTEJK?=
 =?utf-8?B?cFRJSUlhYW5vZTRYL1dMdU9rVndDY3h0c1NRektLNWE4UXdySEg2VCtNNlJH?=
 =?utf-8?B?Y29xNTJMbk9WcUo3dnluY1FsTTVldVRydVJINEk5Ykx0ODc4Ry8rQVIrZlV6?=
 =?utf-8?B?QW9xZU11Um1aVEFPN0lnYitTUXRIRThrd25nVWk5RVlCdEsxeG9wVGg4dnh3?=
 =?utf-8?B?aDlLMkhJUE0rMENmT2dnbzlSbW9JckRpS2IrTkNGMHpiNzZHQkIzM3Rkby95?=
 =?utf-8?B?UU4vS0x6ajEyS1U5cE1lek9NRTBGcEF1R3EwYUlVRERIMDY4aFcrLzBlWDB5?=
 =?utf-8?B?ei80V0ViZGY5RWxZYkhLcU5UdmR1ZGZDMzFDc0pPMnJYdFBHMWwyQklrcS8z?=
 =?utf-8?B?R3g2S1lmZXIxeHdqZGdxSS9lNWRyYmFzSkZiNUxYZXlxcFptdTFFSlJPblJw?=
 =?utf-8?B?eXpsVGF4eHpuamhwaG1lYUhhaDBpSURNUG93cUJDTzg5bmo2Tk9RQTYzN09O?=
 =?utf-8?B?NnVmT1QyVlRXTCtIa2M4R3dhZnZ0dkRnOGJ0d0ZnbTFwRjJRUXZyUVZaRFVn?=
 =?utf-8?B?cmFuTmphWENhemJwSFJSRXBnZVpUbTNlSGYxWkdaVHQvQlBEMmFNYVRFTzU4?=
 =?utf-8?B?OUt2N3VPUDY3WkYxU1dnWDIxa3E3WkdNVk9GeVZkMjMxLzBmeVdsMG1ZMVo2?=
 =?utf-8?B?R0ZpU0hyUHQ4ZWM0ODJ4WVlwMUxtVTl1THd6eUZMVjNva2ZlQmZvNDNjNE11?=
 =?utf-8?B?eVV3aHpMRUJ6aGgyNnNWNUlUMW5uaUJCclZtZFVoOE1EL2RNZXJRZFV0cVl6?=
 =?utf-8?B?RUVEekVhV210WTZ0bXhVSC9INmRGNTBsaUx6Q1FDZldmOXVCczVHMnpzRHAy?=
 =?utf-8?B?QUFLRFlLZlFENmFvbmlabEpxQW95dE8vYUhoVDY0b2RjM2ZKTnVlQk96Z0Ft?=
 =?utf-8?B?K1ZGYVdvTWF5U1F4RnBSUjEveTZOdmhaNCthdmJ2YWxEVUpiVTluOTl4WU9E?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E5C4E45A80E1B4C975D554F9015D57D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9641346-7d08-409b-be34-08d9e692d911
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 21:27:42.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSEPQd4svHGVnWXzj8iaHjGqGsTG1jfBMKDZGiS/cOetr6SNNXOy/m233nmoDL5RZLPiTeQnA4nlGZqmoa/kaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5068
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020116
X-Proofpoint-GUID: CRB1nRajlcCN2t77m3bZvgV67J7MzZPB
X-Proofpoint-ORIG-GUID: CRB1nRajlcCN2t77m3bZvgV67J7MzZPB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yLzIwMjIgNToyMyBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIEZyaSwg
SmFuIDI4LCAyMDIyIGF0IDAyOjMxOjQ1UE0gLTA3MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gK2lu
dCBkYXhfcHJlcF9yZWNvdmVyeShzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2Rldiwgdm9pZCAqKmth
ZGRyKQ0KPj4gK3sNCj4+ICsJaWYgKGRheF9yZWNvdmVyeV9jYXBhYmxlKGRheF9kZXYpKSB7DQo+
PiArCQlzZXRfYml0KERBWERFVl9SRUNPVkVSWSwgKHVuc2lnbmVkIGxvbmcgKilrYWRkcik7DQo+
PiArCQlyZXR1cm4gMDsNCj4+ICsJfQ0KPj4gKwlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IFNldHRp
bmcgYSByYW5kb20gYml0IG9uIGEgcGFzc2VkIGluIG1lbW9yeSBhZGRyZXNzIGxvb2tzIGEgbGl0
dGxlDQo+IGRhbmdlcm91cyB0byBtZS4NCg0KWWVhaCwgSSBzZWUuICBXb3VsZCB5b3Ugc3VnZ2Vz
dCBhIHdheSB0byBwYXNzIHRoZSBpbmRpY2F0aW9uIGZyb20NCmRheF9pb21hcF9pdGVyIHRvIGRh
eF9kaXJlY3RfYWNjZXNzIHRoYXQgdGhlIGNhbGxlciBpbnRlbmRzIHRoZQ0KY2FsbGVlIHRvIGln
bm9yZSBwb2lzb24gaW4gdGhlIHJhbmdlIGJlY2F1c2UgdGhlIGNhbGxlciBpbnRlbmRzDQp0byBk
byByZWNvdmVyeV93cml0ZT8gV2UgdHJpZWQgYWRkaW5nIGEgZmxhZyB0byBkYXhfZGlyZWN0X2Fj
Y2VzcywgYW5kIA0KdGhhdCB3YXNuJ3QgbGlrZWQgaWYgSSByZWNhbGwuDQoNCj4gDQo+IEFsc28g
SSdkIHJldHVybiBlYXJseSBmb3IgdGhlIEVJTlZBTCBjYXNlIHRvIG1ha2UgdGhlIGZsb3cgYSBs
aXR0bGUNCj4gbW9yZSBjbGVhci4NCg0KQWdyZWVkLCB3aWxsIGRvLg0KDQp0aGFua3MhDQotamFu
ZQ0K
