Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD94C436A78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhJUSVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 14:21:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7528 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231433AbhJUSVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:21:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LHpEYb021105;
        Thu, 21 Oct 2021 18:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qqSpmkWQg9TTpBtBW8BqnLBkUiSeiaquYYU2vlVuYqY=;
 b=c6oi5S7V2A50OjJlRsoWCFwOwq2EpqJxHhhvHRWUCPC0aOsrNrwsX4WRXwZHejRBPJlF
 6IP+zc1m2GDB7Bpc5jCSxPa+osVE682zL3iCV5V4MDcI06KK840i1hcEvHD5j2+70JG2
 e56d7OKm/ejdRbsZmZhCn0hBf1Ee9dUHk6zVuzeHGFj7Y1VSBlS5l5cSll+VyfHR88wN
 0kD8VMSW2Rikn5+suxyzbSe9rHzS/uApjHtTXSmn61GABu7q9pwBo8R2/eR1JKt3VF1r
 5E4faj0/CaHk+bpVNhBESI9XJDll2rCASypVjEZUpESbaQW+zkOmrt2CMTlQWcfGTYZy pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btrfm6pk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 18:19:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LIFf8J195190;
        Thu, 21 Oct 2021 18:19:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3bqkv2bxau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 18:19:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/+yY9zinoLOm5QVtTv+i/apPmArRvTjqCp0vahOk1tor5Y8CtAff/EUCEJIWkBmbtdXJKkbOcs3wQZ/iIF6+CdlWFatSIupJzum62jNWgtCOi5G0tz+QdKDP3yy2OCjqFHBClLTAWO+V+oH7+w4GpEbpbxmbnYbmufUIR1msHKbjw6bzy1G7yl5nWlZ026tl1skXM3TS4EdEzSNe/ZPplprtzjADeYpqQPLC1BDCMoC+VWXNcaR1K9TATU7o9d7ys3mThSSyPLkK6KNfuPUutydYSUTOq8E5JZz9gNRS1uHY1LXe80QO5snYEGz9zIXVWHtlskgbuiacSn1NSjLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqSpmkWQg9TTpBtBW8BqnLBkUiSeiaquYYU2vlVuYqY=;
 b=FUB7psjrI3/DHr27oTnxE+31oYRWN0ZVHUU2qQka384OezA4m3A8JkelMNytOfhfJNBkw9KraCyMcBVcDa9Z5gDvGEf3nmDDZHAdc9QKHnXO1tNBT+9DoV8EKpJcoWJQ6VyE5s7VdEvgADwZZulLoFHb9GQ6gHStdYl07yAEM+0s7c6Uf9Dsf/LZOhRiIuH+SVP8+PX22AKuNwnTzps+p9218gh9Zs8FwsO5/4Iz/B/zcNwOEX2ZJctX32dGaAIENtEzgi09hE2dT2GpdSy/huOtxWBzG7qC9tD7syywwDO2QLU7Gf2InH4+UcFjrhNoL3s0BqAqeUXgZeCSkma0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqSpmkWQg9TTpBtBW8BqnLBkUiSeiaquYYU2vlVuYqY=;
 b=kzRrp4Rpt92VBETBuFg5qWObeXdGZK5ZWjLqdVOBP5j1ps/80UYC4dBecTgpVXHaMkNLg/q5XupwCGjMkzy8unW0QFeBUH53h9ItgThPa2HJwkHzAWh4hPFCiDrlu7qlKDBijrf7GNPGfoijGR0M4f6R7EIr/JIr+VxE6Iu8wrs=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:9c::17)
 by MW4PR10MB5751.namprd10.prod.outlook.com (2603:10b6:303:18f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 18:19:05 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::f12e:1d7a:66a3:3b1b]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::f12e:1d7a:66a3:3b1b%5]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 18:19:04 +0000
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
Subject: Re: [PATCH 2/6] dax: prepare dax_direct_access() API with
 DAXDEV_F_RECOVERY flag
Thread-Topic: [PATCH 2/6] dax: prepare dax_direct_access() API with
 DAXDEV_F_RECOVERY flag
Thread-Index: AQHXxhA7j61ucpXWPEWf3Oh2VcDl4qvdTxiAgAB1CIA=
Date:   Thu, 21 Oct 2021 18:19:04 +0000
Message-ID: <92423340-311b-0799-7a23-2a89201700ed@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-3-jane.chu@oracle.com>
 <YXFM64mFLN8dagrY@infradead.org>
In-Reply-To: <YXFM64mFLN8dagrY@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8502a437-5472-4bbe-5e78-08d994bf43f7
x-ms-traffictypediagnostic: MW4PR10MB5751:
x-microsoft-antispam-prvs: <MW4PR10MB5751A45E7422D8009314F55EF3BF9@MW4PR10MB5751.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sF4xhCMbE5zwf8iTc+/z7cSzO8DiDm7oW9uBXPM5wwX5rCfyNaZLoO1eWcaFkaaBxO2/6lL6mPVYcHCvPnWN5QnFYr1UJozFGfQTcsxMkwiUyTpSCA4RMzest24RHie2n2XWFpkYouc/pwzm2uzdHR2fZ4wrQasHx152zXhXPJdVDum95zPP1/TZ8m1X6dqH5qqHoQ8r1eeN3V7FHsdjLE5Tg/Q/pmZIV1Li70hgcWc4BClqKMrWvuAKaTyq8UV2rR/T1qNR1keOIoknp0xO9Im765Jua/tm2b6gf3h3HMg2PnKGtgqRwdvyy3YjqBY4ZtoWTHWzecwKY9aXg3QMmtW2UpJh5FtgNkTIWyqbY4FpPZvQaR8DyxN4BC5HTsFg+fcxFmCtYNYrJXHtmvVujh0bLISwXTSyArtKtC2bPgYQk5mbD+iUCM1JAXcGkyeKevf/smkWhDs/8XmCjNJHi+0cnQZWxFPVLJRluDrmBRXScDU9UBQS2RwD+4jZnyx/qEiV1OY9tYK2Y5fmwxbk9iFwB2JIkFO+td8g5xHJ5rxJLlokX/X7g06unGgEL44z+PQQLXgdMGCTJaAx/smGa/i6bJhji2Y7705cjWCzpaqwh6si6IPA0KG7iU9Re0k1qw94xtuXg6JifvY+Uf1i1Jb4cLXzqmdFxfnsp+Tdd80gk5ywDTBe9bhdz9namcehdgFFhb8cKrGhMZaWVykLvQDBUvNSx40qgv2D8Q37twnzPo5PjxtcUEbc+yvqrE1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(38100700002)(36756003)(122000001)(66446008)(44832011)(8936002)(316002)(66476007)(26005)(86362001)(71200400001)(38070700005)(83380400001)(2616005)(4744005)(54906003)(8676002)(53546011)(64756008)(91956017)(76116006)(4326008)(5660300002)(508600001)(6486002)(31696002)(186003)(6512007)(2906002)(7416002)(66946007)(6506007)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmU2NVVYK29Qc244YXc4cFNNR1Nxd3RkcE00OHdvL0ltK2ovbDNid3NCYUlW?=
 =?utf-8?B?R2xVQlFMYm50QSt6ck5URXlnK0xndm5KU0xkRWVzK2tUZVk1amMyVEhMT0RK?=
 =?utf-8?B?VlZkQzhqaEM5ejRGblJUTGt1ajd4ZTZ2NlRpSitBNngycVNwaXBnOTdtU0Zx?=
 =?utf-8?B?R1o1cEovL0FtS21qaTh0dmlvWEV5dmlrT2tiZGJuMG1QamN1bTdYQmUvWlBR?=
 =?utf-8?B?bWZTUDQySEUvZ1pwNERTQVdGWmFERy9hVlhlaG1JcWtQSVFZeVFyd1h6Tm5s?=
 =?utf-8?B?N2I2ZGZnNUZXOFFvZnpkNWdVWWRTRzRKTDhBcTExWFh2YnRIOTFZYjN4MkJZ?=
 =?utf-8?B?bisxQS9UQVZEUm5MUk5RSVpqVkxZd2VTajE4TmsxVGVlclJTNkJjT1Q1L0Ja?=
 =?utf-8?B?NGNkcHZwUnVCamkwc3YwTmp5SWdXVjVGd0xXTGNYTTVUQXF5NlVNcjFFc2Y1?=
 =?utf-8?B?RUdQRTZENXZuWUhWNEMyVm02aS9xWnNMaHdma1ozVEZnZUZuN1hlSUVzNk9w?=
 =?utf-8?B?bUtBR04vWmw5eUJ2QzJTdjFDT3dpTnowY3F6aDhENFpsV1ZwUFk2eE5ScEp1?=
 =?utf-8?B?b3Y2SUlQbm9OWmZTZTliUnFHdm4xb0NSSDN4OTJEMXd4RTNZTzg3bUxZYkdH?=
 =?utf-8?B?dXRQVUFlSkhFTVIwQ0QzYlBqVjBldGJ2TldFSXVObTlvSWk5M0svcktuNXQ1?=
 =?utf-8?B?amdXTXMxUlBkOXZNWmNsWlNLY3lLUkJSUHoyWUtkeEJxa3NoQm9qblhka0ZL?=
 =?utf-8?B?aFdObWtsVjR6Z3M0ZU02WnFTdXl1bnU1L3psVGp3KzhRSk5TMzZJVHNyL2Q1?=
 =?utf-8?B?T2JXd2JtR3pWN2Ezd25kS3FSN3hIMFNIUTc0U0c5dkdNVG5PVUppMU4zQ1da?=
 =?utf-8?B?cGZXS0l3elBhMkRTTUpETVVRajU0QXliMjF5NUNvUERQdHd2SlMraU41S1hh?=
 =?utf-8?B?c0R0VEZKTzk5Y1pKZkF1OUVoKzU1VENJdGkzZXExRXFFdGJVTE5wOFQ5MlBw?=
 =?utf-8?B?WHk5TzcvZ0pzdkdKUG4yci9MaElVL00zR2hzRzNqOWxPckp2emJ6SjBZWUY0?=
 =?utf-8?B?NFpZc1lYZitxeXFoQzB6SXd6NnpSbFBXZkxhOE5wRjQ4dVBZR2luY21WamV5?=
 =?utf-8?B?WHRsL1psdFlPZVRqUFBEU3FXY1BZMlJUL1c2aEVRaTh4TW8zN1M4NTllcFNz?=
 =?utf-8?B?dkxCWVo5SDJGaDJ4SzdSRk1lWG5yVzlTMldMM1haTGFyK2wwbk9CcUg1d01p?=
 =?utf-8?B?R2N2MXRUSStwYmNkd2oza1Vqbmw2UGNPZkFOZmlBTWU1MnJhcGxTNXlteVJa?=
 =?utf-8?B?cFBkbjMweGcrcUV6NGVtS2o3cEFnaEZKZjNGdTRUbzFlMEthNGZMcmFoZEt3?=
 =?utf-8?B?N3VkYVhPbXdFckZZWTNiOEFOc1lLY09SR3VMV3pjR3hTeHZ2K2NNNGJuNlNL?=
 =?utf-8?B?bk1FeXhQeXhyNDc2YnIxR2lqb3VpdHRjMmZDRmUvcyt5SGROeUJ6WkxwalN4?=
 =?utf-8?B?V1d4dnJsRlhxbE55V1Y2T2YvTEJhOUU4NFB0blFkOEFZUUkrc0lKVlF5cTl1?=
 =?utf-8?B?Qk5UdmhlWm95SUEyYlhreWpHMlM4WnV0VkF6NlpzanFtbEhhTFdtN2dCbG1p?=
 =?utf-8?B?WThRbVR4eFpSSVlqWnB1M0QxcC9iTGxwZEZ0NXNLc0pWa1Jhbkt0Z3V1ajIz?=
 =?utf-8?B?aXc0SFhLZ2Z2T05kTWdOTEpPWmlLS3JQekJBTHA4QjdBZ2RxTjYrQTlITXhY?=
 =?utf-8?B?ZzNoU1VkVE9VYSs0OHROSTZwd3YybHpXUVJ0YlJEaEwzR2FTVi9oSVBJcUlX?=
 =?utf-8?B?cEQ3ai80SEFZVWF0ZENLS1owU1NHdEtsdklsMXIxRk9hV1pjRkRtalZvNVNl?=
 =?utf-8?B?NTRXZStvL2lhMy9LNnlrSk9CS3E3dzJCSndyZEtsQjBoVWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66308170408652458EA23C26F716B0EC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8502a437-5472-4bbe-5e78-08d994bf43f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 18:19:04.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5751
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210092
X-Proofpoint-GUID: f7J5gCBM4XqEoks4YqtXR0VagJcOVeT4
X-Proofpoint-ORIG-GUID: f7J5gCBM4XqEoks4YqtXR0VagJcOVeT4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSA0OjIwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gV2Vk
LCBPY3QgMjAsIDIwMjEgYXQgMDY6MTA6NTVQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBA
QCAtMTU2LDggKzE1Niw4IEBAIGJvb2wgZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQoc3RydWN0IGRh
eF9kZXZpY2UgKmRheF9kZXYsDQo+PiAgIAl9DQo+PiAgIA0KPj4gICAJaWQgPSBkYXhfcmVhZF9s
b2NrKCk7DQo+PiAtCWxlbiA9IGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCAxLCAm
a2FkZHIsICZwZm4pOw0KPj4gLQlsZW4yID0gZGF4X2RpcmVjdF9hY2Nlc3MoZGF4X2RldiwgcGdv
ZmZfZW5kLCAxLCAmZW5kX2thZGRyLCAmZW5kX3Bmbik7DQo+PiArCWxlbiA9IGRheF9kaXJlY3Rf
YWNjZXNzKGRheF9kZXYsIHBnb2ZmLCAxLCAma2FkZHIsICZwZm4sIDApOw0KPj4gKwlsZW4yID0g
ZGF4X2RpcmVjdF9hY2Nlc3MoZGF4X2RldiwgcGdvZmZfZW5kLCAxLCAmZW5kX2thZGRyLCAmZW5k
X3BmbiwgMCk7DQo+IA0KPiBGWUksIEkgaGF2ZSBhIHNlcmllcyBraWxsaW5nIHRoaXMgY29kZS4g
IEJ1dCBlaXRoZXIgd2F5IHBsZWFzZSBhdm9pZA0KPiB0aGVzZSBvdmVybHkgbG9uZyBsaW5lcy4N
Cj4gDQo+PiAgIGxvbmcgZGF4X2RpcmVjdF9hY2Nlc3Moc3RydWN0IGRheF9kZXZpY2UgKmRheF9k
ZXYsIHBnb2ZmX3QgcGdvZmYsIGxvbmcgbnJfcGFnZXMsDQo+PiAtCQl2b2lkICoqa2FkZHIsIHBm
bl90ICpwZm4pDQo+PiArCQl2b2lkICoqa2FkZHIsIHBmbl90ICpwZm4sIHVuc2lnbmVkIGxvbmcg
ZmxhZ3MpDQo+IA0KPiBBUEkgZGVzaWduOiBJJ2QgdXN1YWxseSBleHBlY3QgZmxhZ3MgYmVmb3Jl
IG91dHB1dCBwYXJhbXRlcnMuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBoZWFkcyB1cC4NClN1cmUs
IHdpbGwgYnJlYWsgbG9uZyBsaW5lcyBhbmQgbW92ZSAnZmxhZ3MnIGFoZWFkIG9mIG91dHB1dCBw
YXJhbWV0ZXJzLg0KDQp0aGFua3MsDQpqYW5lDQo=
