Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F194D3FBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiCJDeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiCJDe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:34:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F95E141;
        Wed,  9 Mar 2022 19:33:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1dW9W022893;
        Thu, 10 Mar 2022 03:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1nU7DTvX985rBwp3e3pilhDbXr3n5q731pifMUW6XGU=;
 b=tMVnOYi8MTpIfePqUNnKZQe9F13OLAbiwq2z6MJzmaIvJREma1XNn+Hnn2yoDb4vwG/b
 Og1YwRsI9OBV2n78rJtE4iB+JKGWJZT6XIz/3+tIjDMunntJT4iWalIhrTyzMNNI/9HR
 rJrLVtvyB7NBJnicPeLaFKVbZApNMF+Y/C5pbpAPgmrFJrpwysQaTFOeGfoZmiGREUeO
 isq3bz5ZKo1F5wljWyPdhaG9SarGMd7V+7oPXESwEosICxoj+31cD+hWqFVrAvO1iMUV
 M+znAG4S06RhvW0ijEcWKSUqpw4Q+iLNJw5/PGjuMUvu4cUlTfL4/LHvfnt3k4ijKv32 EA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyraufkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:33:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A3FhBW189193;
        Thu, 10 Mar 2022 03:33:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3ekwwd5v88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:33:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS1FU5SvvruN9COiapeyb+RZ/ZZ/0VvwxYS2Qii3FGdEEq/AbcXdtrJ0QXaMt/uH7tnFnK647YPkStWiMLfHddwVoP33lMzFzBtwKWQbkjabOxhQ/GnUvqhp6Cm7sOpZHW8m+Wv9jf4Eswhi0rlze648qDCtNd6uecpSocmULQtfUQTqjBv7cEk8yOG2cLUlJarsJqCaNMWCYI0iogkbJCF5LH+1DAj3yQKMaKlXuqxP7nrOkD3kc2RUh9s3qHZToSWG6nLnMWLtEfDKjGE1TweN42sD9Ro8sMc0Lwuj2D12jPkvUECzEXnMzhAWuklGSy45PZz4yx4zpvut5faFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nU7DTvX985rBwp3e3pilhDbXr3n5q731pifMUW6XGU=;
 b=Iv1bE33+umOsLpuUJ3F5s0ExFPg6zH6pteAogHkpw3n1q6ocVTik16UyCeBE8l+vemObJXJT2ABhPw7fjtcSxXmX4JgKZeERNYaH+dRpIOmy+b2DwIrJQasS+iizfLq8srqA3df2J0MR8FiT9Aj1WFanLnq5FrpAdfDZwwisKqh5GGXgU4jgSP7HCyw7xhS7WzSBN7dV0oWOEJ1l0EvSXGi7xw9OyEIOvSGIOZfi3EclSaSmQ7gbHULvvd30vTnSVl+Egst3gzUdk0orBql4051i63bfchnDwACUCsH++v05q3Qj8aVg5S058ST3PSqhcoEsKmAjpobbLOHaCG7Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nU7DTvX985rBwp3e3pilhDbXr3n5q731pifMUW6XGU=;
 b=rBQsQ5oWF2FMVkSuvA8S1Z4O6jTjSrW5w16KtSbffD1kATrnkdN1QtOI4mg6BMhs5bIwabyifqGAepCmVzSgxFOmPbYGEIo1L4E1PdX6dC06A12pIqiOCDk2g+WaxdycWbyfsoEsqxKDkORcVBYV+EZIbDgMi/1XsSwYIOvywlo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2417.namprd10.prod.outlook.com (2603:10b6:406:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 03:33:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 03:33:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 07/11] NFSD: Update find_in_sessionid_hashtbl() to
 handle courtesy clients
Thread-Topic: [PATCH RFC v15 07/11] NFSD: Update find_in_sessionid_hashtbl()
 to handle courtesy clients
Thread-Index: AQHYMCkwQ/sQvlxXy0G/nHUfqC8/oqy3raCAgABLRYCAAAX2xQ==
Date:   Thu, 10 Mar 2022 03:33:20 +0000
Message-ID: <CDA6815A-D05A-4DE1-B065-4398ACF8AEF0@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-8-git-send-email-dai.ngo@oracle.com>
 <E3F16183-1407-430F-B408-A298D4C29401@oracle.com>
 <89b85e56-dee9-da2a-55f2-c0134a109f07@oracle.com>
In-Reply-To: <89b85e56-dee9-da2a-55f2-c0134a109f07@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b537927a-c2c5-4f90-f7df-08da0246b978
x-ms-traffictypediagnostic: BN7PR10MB2417:EE_
x-microsoft-antispam-prvs: <BN7PR10MB24179DCF35589EC84D14CCB7930B9@BN7PR10MB2417.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPd3R7EXUUxM1nTLbLKmmUk46la8zzxEQBsQKLQ77oq8JOS8pp/9mCpkfVQL++P/qzGFWseabTJj9wcLVfXcPuDwe1670MS1yVr65xyMXvjmOVVcTEPX8YK3esmyQMB4caSzJi0WQD2ysoCSS/vxhgYhrRnmsY4aoQV485BS+Ur/vffT18QauSrfXEtOhNa3EyvLGYybYQJB47hC62Mda6WGEHrXS5903+9X68Jtdx9y45TQYgTuNk+SofRSyZ1sAMfpOrddkGZGpOhEePec3R357bRpC9MbtcFDy/U6ge3qp6fLofNIwPj/Bn1Ljo4hjnvUOOxKDPqq1yOLrMr/JB6vfFluoneDOqd3siJWEBb0nOMaWzgSX+v2ouqDVCneZtgnRVeSLCPUkXw7hr7Nt5jZ/fpVEOur7xcQCuz4Ienm2YfrNIArLtzN7Rm4M6MKxeJyNscKfCgI7juqjPtznNjLZR8d/yx24hSwvWXfbhr4Row5lhGwdXBfR9UERCx5euJdYljlCgmLBrSAQeK608QMi0FBasPqxBZWD5oyqb1Bme6hdBMjlvXm9oxkiPAcqf/TP9JF7xDw+AWFNB9GSXclK7ElCaiNcUs/BVBQS/COohwJHM4lIWC6P/C9Yizxk+4qLa+8TmJBapVXBFBgIzo0B6p8apzUvCkUA6i6ZwKhCTAg/wR3Bt1kPfnGoE6Rwgi6eeprSv+tnc7HV+Yj9GAtMZOowKOfQKugW7KtSnlUd87KQdMgV+pnQVxZtfyi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(76116006)(83380400001)(6512007)(6636002)(5660300002)(8936002)(36756003)(8676002)(4326008)(6862004)(66556008)(66446008)(66946007)(66476007)(15650500001)(91956017)(64756008)(2906002)(54906003)(37006003)(33656002)(316002)(53546011)(2616005)(186003)(26005)(6506007)(6486002)(122000001)(38100700002)(508600001)(71200400001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRGQTZNMmNmL2RXaXpDZWpmMVJtNkQwUmg4cUF1bzIwOUtOUEtuaERBZVEv?=
 =?utf-8?B?aEN2RHJaMFFSNWRWd3QybTRtRjk0WExDazh3MnRCc1JIYXIvNjVaWWZYbm5a?=
 =?utf-8?B?MTcrN1hjYno5TGlmaE1WTnJvSktpYWtqYVYvdVZnTkI2R2srWk10Y1VILzIv?=
 =?utf-8?B?ZEF2Q1RNNGhlTW43LytKWHhYWDdxdjBhTFBvTTR6dFhJMEwrRDNmczNpNVRN?=
 =?utf-8?B?TGROa3Zzc2FPLzFOOEhEVGl2NXNJVDhGR1RXVXJnTjRtZE1OVWdZNnZLb0Ir?=
 =?utf-8?B?MENmVFdzTzdqaWZPYmJIRkJpWm5OSDdHaklhLzlqanVkdlZoV1MxZlF4RjFJ?=
 =?utf-8?B?czhhMHlaVmhuUDRMZEtaa3dJZFdMVjVhWm5OMVdyKzNQM0tWL01rbGR3MFpZ?=
 =?utf-8?B?Z25nT2c3b1hkVWtKeWs3d0VQMllQK0xuTVZrZ0tUTUxBbUFRNlFyYmdqdU00?=
 =?utf-8?B?RmRMTldRSSsrQkpTbW9vWmZUK1Jwd2lEVUNURUlGOFNiM01YaW1kQWljNHN6?=
 =?utf-8?B?SlBRNFdlMDZFMHloTTZuOS84SHQ5WEZDSFNUUWx3dkczMEpGYUE4T0hTRTQw?=
 =?utf-8?B?eDJ4UGovNTFBSWJwSEprRnhReUtmRnZ0ckd2WkJYL01Cb1NaaEhwRkZxRWQv?=
 =?utf-8?B?TThCVys5YjVpYUFkZHlQTDlZanBtLzI2Y2J6ajJLTTVtNXVzbTljRldacUcv?=
 =?utf-8?B?RFJOWFNvZkt2K3VadUdNbWV6amtReXBZYisxdk5MZUs5Mms3ZWJPaWNvQVMy?=
 =?utf-8?B?UlhMMWFPNklITFZuV1ZTazBzRHdpVnRKaUd4cGRWQ0RKUWk5YWpMNDRhQWxv?=
 =?utf-8?B?NFdONVYwcTA2R2lPbUtNc0QwTGRFMGpXWGJIYUtGNDNhQ0VhVDhMQ0RrT2pr?=
 =?utf-8?B?WSs2azdJYWVWUkVFSkRPMTA4SU9sTWlpZlhBWnEyMy9lZUpNSWFJUGx5RHdO?=
 =?utf-8?B?RTM3VE1EeFpDNHk0WkxPbUsxZGtkNWIyN3ZMUFZtaEJLQ2FoaWlOOEZWZ0ZJ?=
 =?utf-8?B?dm5UajhiaFpqV2lUbjloRXBkUDUvRnVQVkNpYnhwSGljLyswUjJ4LzZsRnVC?=
 =?utf-8?B?b3JtQmplREYvSGJVUXdwemdIZTZ4ZzRuRk45aWcwSnBjRmpZMnFZWHdSWkRT?=
 =?utf-8?B?V1psZCtVUnFZMlhnQTNuN0lHQSs4VCt4OHQzdXE2aWJHckNyRmNNMHo4VDFj?=
 =?utf-8?B?M3B4TGMxTml1UDV1V2ExQVNaVVNDaTliYzdRdm5xNklycVBBMTdSWGZxZ3lu?=
 =?utf-8?B?b203VzRyWEt6WGEwUUpCRlU3VWU0L2dFYU1lMkRZaVZsUmlLckNHdUgzRk9B?=
 =?utf-8?B?RXQwL1pnTi9aTWx3Y1Rjb0pZM1h4N3JQYUtpYjRPRiswQnYwa3lKanRsb0Zj?=
 =?utf-8?B?ZWFUSGlONFNaSm5PKytOYWt0aWFLMFdBZVRML1VJd0REOEJqa3I4bDgwQlhK?=
 =?utf-8?B?UWZFTXBNRVg5d2E4Snd5Qlk1TkpqL0w1bUR4NkRrTEZqQTdpWktHWmNRYW9z?=
 =?utf-8?B?ZE44YjIwZFVYS0pWazRCMFhiVEI2RGFFbXpiQzh0VTNnTWRHNHZEMlNta2dO?=
 =?utf-8?B?ZUErQzB1NE9FbWtMZXdaYTg0MVpNdTNFcmp6bGtySDYxd0Z3YmppNiswaTI4?=
 =?utf-8?B?N0VROTdyWEtNR0JudDdoWDVLR0VFNHI2VCt6cXZ0aEN3S09jeUR0eS8yZDd6?=
 =?utf-8?B?T20yenMrMzZXTklwdElUUFJQUXNzcWx4d0NGRThRb29OOXRFWW9kWUEvZTc4?=
 =?utf-8?B?Z3A3bjU5TExmTXU5MWVxWUJlYlFNSFUwT1dNeXhpVFFDa1NmYWFPZ29wVjFZ?=
 =?utf-8?B?RU95ajFVS09zeTVuQnVyZnUxUGpOTDZFNEZCMjd6NWRKUHJLVkJHK0xwTmdj?=
 =?utf-8?B?Wkh3ekZXZFY1REwyQWEra3B5MDd1OEVhS1RiYWR4dkVnZVhrZ2NqSUV0T0xi?=
 =?utf-8?B?VmI5OXRkWXFMc2o0L2VWcThSRTdBRFQ2cTRTNTAxL29ta1piQUFDQ2ZxV2J2?=
 =?utf-8?B?N0RKR0dOenJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b537927a-c2c5-4f90-f7df-08da0246b978
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 03:33:20.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8y75C/alVYmLmFFnL87fmo5HJutb8CUQrHZN/9dyL/ESY0MGD7+YDiqyIzwDC8Xu9H9tewkHw9hM2fAVpHUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2417
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100015
X-Proofpoint-GUID: sK07g9N5Z0n-q1ZEdHcQd_paNL2CdebC
X-Proofpoint-ORIG-GUID: sK07g9N5Z0n-q1ZEdHcQd_paNL2CdebC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE1hciA5LCAyMDIyLCBhdCAxMDoxMiBQTSwgRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUu
Y29tPiB3cm90ZToNCj4gDQo+IO+7vw0KPj4gT24gMy85LzIyIDI6NDIgUE0sIENodWNrIExldmVy
IElJSSB3cm90ZToNCj4+IA0KPj4+PiBPbiBNYXIgNCwgMjAyMiwgYXQgNzozNyBQTSwgRGFpIE5n
byA8ZGFpLm5nb0BvcmFjbGUuY29tPiB3cm90ZToNCj4+PiANCj4+PiBVcGRhdGUgZmluZF9pbl9z
ZXNzaW9uaWRfaGFzaHRibCB0bzoNCj4+PiAuIHNraXAgY2xpZW50IHdpdGggQ0xJRU5UX0VYUElS
RUQgZmxhZzsgZGlzY2FyZGVkIGNvdXJ0ZXN5IGNsaWVudC4NCj4+PiAuIGlmIGNvdXJ0ZXN5IGNs
aWVudCB3YXMgZm91bmQgdGhlbiBjbGVhciBDTElFTlRfQ09VUlRFU1kgYW5kDQo+Pj4gICBzZXQg
Q0xJRU5UX1JFQ09OTkVDVEVEIHNvIGNhbGxlcnMgY2FuIHRha2UgYXBwcm9wcmlhdGUgYWN0aW9u
Lg0KPj4+IA0KPj4+IFVwZGF0ZSBuZnNkNF9zZXF1ZW5jZSBhbmQgbmZzZDRfYmluZF9jb25uX3Rv
X3Nlc3Npb24gdG8gY3JlYXRlIGNsaWVudA0KPj4+IHJlY29yZCBmb3IgY2xpZW50IHdpdGggQ0xJ
RU5UX1JFQ09OTkVDVEVEIHNldC4NCj4+PiANCj4+PiBVcGRhdGUgbmZzZDRfZGVzdHJveV9zZXNz
aW9uIHRvIGRpc2NhcmQgY2xpZW50IHdpdGggQ0xJRU5UX1JFQ09OTkVDVEVEDQo+Pj4gc2V0Lg0K
Pj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4+
PiAtLS0NCj4+PiBmcy9uZnNkL25mczRzdGF0ZS5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIv
ZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+IGluZGV4IGY0MmQ3MmE4ZjVjYS4uMzRhNTljNmY0NDZj
IDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+PiArKysgYi9mcy9uZnNk
L25mczRzdGF0ZS5jDQo+Pj4gQEAgLTE5NjMsMTMgKzE5NjMsMjIgQEAgZmluZF9pbl9zZXNzaW9u
aWRfaGFzaHRibChzdHJ1Y3QgbmZzNF9zZXNzaW9uaWQgKnNlc3Npb25pZCwgc3RydWN0IG5ldCAq
bmV0LA0KPj4+IHsNCj4+PiAgICBzdHJ1Y3QgbmZzZDRfc2Vzc2lvbiAqc2Vzc2lvbjsNCj4+PiAg
ICBfX2JlMzIgc3RhdHVzID0gbmZzZXJyX2JhZHNlc3Npb247DQo+Pj4gKyAgICBzdHJ1Y3QgbmZz
NF9jbGllbnQgKmNscDsNCj4+PiANCj4+PiAgICBzZXNzaW9uID0gX19maW5kX2luX3Nlc3Npb25p
ZF9oYXNodGJsKHNlc3Npb25pZCwgbmV0KTsNCj4+PiAgICBpZiAoIXNlc3Npb24pDQo+Pj4gICAg
ICAgIGdvdG8gb3V0Ow0KPj4+ICsgICAgY2xwID0gc2Vzc2lvbi0+c2VfY2xpZW50Ow0KPj4+ICsg
ICAgaWYgKGNscCAmJiBuZnM0X2lzX2NvdXJ0ZXN5X2NsaWVudF9leHBpcmVkKGNscCkpIHsNCj4+
PiArICAgICAgICBzZXNzaW9uID0gTlVMTDsNCj4+PiArICAgICAgICBnb3RvIG91dDsNCj4+PiAr
ICAgIH0NCj4+PiAgICBzdGF0dXMgPSBuZnNkNF9nZXRfc2Vzc2lvbl9sb2NrZWQoc2Vzc2lvbik7
DQo+Pj4gLSAgICBpZiAoc3RhdHVzKQ0KPj4+ICsgICAgaWYgKHN0YXR1cykgew0KPj4+ICAgICAg
ICBzZXNzaW9uID0gTlVMTDsNCj4+PiArICAgICAgICBpZiAoY2xwICYmIHRlc3RfYml0KE5GU0Q0
X0NMSUVOVF9DT1VSVEVTWSwgJmNscC0+Y2xfZmxhZ3MpKQ0KDQpCeSB0aGUgd2F5LCBJIGRvbuKA
mXQgdW5kZXJzdGFuZCB3aHkgdGhpcyBjaGVja3MgQ0xJRU5UX0NPVVJURVNZIHRvIHNlZSBpZiB0
aGUgY2xwIHNob3VsZCBiZSBkaXNjYXJkZWQuIFNob3VsZG7igJl0IGl0IGNoZWNrIENMSUVOVF9S
RUNPTk5FQ1RFRCBsaWtlIHRoZSBvdGhlciBzaXRlcz8NCg0KDQo+Pj4gKyAgICAgICAgICAgIG5m
c2Q0X2Rpc2NhcmRfY291cnRlc3lfY2xudChjbHApOw0KPj4+ICsgICAgfQ0KPj4gSGVyZSBhbmQg
YWJvdmU6IEknbSBub3Qgc2VlaW5nIGhvdyBAY2xwIGNhbiBiZSBOVUxMLCBidXQgSSdtIGtpbmQN
Cj4+IG9mIG5ldyB0byBmcy9uZnNkL25mczRzdGF0ZS5jLg0KPiANCj4gaXQgc2VlbXMgbGlrZSBA
Y2xwIGNhbiBub3QgYmUgTlVMTCBzaW5jZSBleGlzdGluZyBjb2RlIGRvZXMgbm90DQo+IGNoZWNr
IGZvciBpdC4gSSB3aWxsIHJlbW92ZSBpdCB0byBhdm9pZCBhbnkgY29uZnVzaW9uLiBDYW4gdGhp
cw0KPiBiZSBkb25lIGFzIGEgc2VwYXJhdGUgY2xlYW4gdXAgcGF0Y2g/DQoNCkkgZG9u4oCZdCB0
aGluayB0aGlzIHNlcmllcyBpcyBnb2luZyB0byBtYWtlIHY1LjE4LiBXZSBjYW4ga2VlcCB3b3Jr
aW5nIG9uIGltcHJvdmluZyBlYWNoIG9mIHRoZSBwYXRjaGVzLiBBbmQgSSB3b3VsZCByYXRoZXIg
ZW5zdXJlIHRoYXQgdGhlIHNlcmllcyBpcyBwcm9wZXJseSBiaXNlY3RhYmxlLiBJIGRvbuKAmXQg
dGhpbmsgd2XigJlyZSBhdCBhIHBvaW50IHdoZXJlIHRoZSBwYXRjaGVzIGFyZSBpbW11dGFibGUu
DQoNCg0KPiBUaGFua3MsDQo+IC1EYWkNCj4gDQo+PiANCj4+IA0KPj4gLS0NCj4+IENodWNrIExl
dmVyDQo+PiANCj4+IA0KPj4gDQo=
