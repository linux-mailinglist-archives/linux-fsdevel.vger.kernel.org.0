Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8C436F2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 02:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhJVBAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:00:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18986 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhJVBAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:00:36 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LNig9I019201;
        Fri, 22 Oct 2021 00:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3q4aq28zDil9W54o5RHkP3LwxKhIyey1aCGTl9ibBaM=;
 b=A9nsaUYcfBnDJmTv7ms6UoLL6uGAr8q8nglEDlL70FQN7a41lidyhzxF1O5krNm8SOfn
 W/TD2dFb0zA4IYGKJJ/VaZFCoYC3p0q0BUjWbNEnMN4hBxVozDfeTz6aknRl3SLIY1IZ
 nNhLS8jzctmeFyHM+wzPojg0OaaI9pNcO1QRSQ65GV5PmFrxmJF4XJ2HDOfXmFNxE2mQ
 1eBMbKpjgiZoNMY0envA5nRI/W7OPkcLxHjEbs8ut3QqCHCObCurrYHgJA1jv6NrH6NN
 XMNQ7V9QTxnm696H3699SHsslk6lgYUU5EBk+l3XsONGAoFVexqV0ELoo/xLv/aKKvGK fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btqp2rddp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 00:58:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19M0u2Fd009049;
        Fri, 22 Oct 2021 00:58:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by userp3020.oracle.com with ESMTP id 3br8gx11n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 00:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RABVwPQ8fX0Y9PoAJVneF1aMlstXT8l7Jd7HaiFdLstPuBjc3qkBalSZbXcZabFwNMCtCMc4prlW7oL2Xazud4+SKYgSBjf+DslKsRwBKDuaWZVMsP81wkJ7qLMV0ww3joukzV7HxntsM/AE9W/xgEJX+xOdRLaMK/JmZs2MmtVLaT5a9uTJAFjrLKvyw7VFpk/TXkwauXcB7IJpL7UNHnbTk0UVSY1Msq3/wEvww4PgAnR8AvngXYcsoq1Sr04MZ+MRBjW5B9miAD1cK79v/ocoeBUuRZYNBsw5FBntqtukmOtwrkPW4T9Pv+WYHrVeihbOVIXW106EagSGDrjUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q4aq28zDil9W54o5RHkP3LwxKhIyey1aCGTl9ibBaM=;
 b=Tp3E7aRwuzVe9u4ordepQdeOG3CI2T2i05UzUTQSdGeMb5ttREspp3Hl4HQvf7IkfyRm5apqZ/ZtmvkNNzmqGJSVyps3XQlN3hyBQ/u9dsmWbZokOGlJTRhe2IpZfhXtFp0FYlmyWqXcddBIHUQUIy+880ptcMeiIwEzEJ+RxgcRpRiVvrC9iz7ysz/dIapDNt/41cA8oUAgzaCDMIBL2vDySm7zJDE8mEbkR2TyRIRF+Evqp07WE+nmfN5sEWgAtFdNcrZXJU9yXhyXeIIdNFKwJKl8HDxsDZyJLR5h3jV+PyVyW29TrvVJWhs1NcEGPdsOrj4QLYMnhMuHkEKKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q4aq28zDil9W54o5RHkP3LwxKhIyey1aCGTl9ibBaM=;
 b=pw4JxJvEqXhUtBDJ+keNazJjHLGeQVqIIlxYkoFheWDuFWjS+WkEzaHClAa71VJejjLuu9kYmg5iK8Yb8SRJlNV2OMZQtjcKBr4JPJqmHNjyTJ8yGFS+ViZFtV4PbOavYqrY/N1KSiqontQ4R51mtT3EfXdXZcx6NNaSoA/iteY=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5533.namprd10.prod.outlook.com (2603:10b6:a03:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 00:58:05 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 00:58:05 +0000
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
Subject: Re: [PATCH 5/6] dax,pmem: Add data recovery feature to
 pmem_copy_to/from_iter()
Thread-Topic: [PATCH 5/6] dax,pmem: Add data recovery feature to
 pmem_copy_to/from_iter()
Thread-Index: AQHXxhBDZf3mWOFAa0+X1X7SVQR1/KvdUYMAgADiGQA=
Date:   Fri, 22 Oct 2021 00:58:04 +0000
Message-ID: <7dc2445e-4cf0-307c-8ab6-48b886bcf34b@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-6-jane.chu@oracle.com>
 <YXFO8uCgIDoIqTgC@infradead.org>
In-Reply-To: <YXFO8uCgIDoIqTgC@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6d8d44b-407b-4b92-aa5e-08d994f70160
x-ms-traffictypediagnostic: SJ0PR10MB5533:
x-microsoft-antispam-prvs: <SJ0PR10MB55339D39C4EBCFDBA7017F0AF3809@SJ0PR10MB5533.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOgi0DyGwbH35sv/oFAWMdNCy7O87RRueT7u3ksIQ48Ycx7HrFSu1Vn+cAhG6wCvskw4E95YHVKDGLF/98/67Z4hzlSKm7CF86JtDYUIr4qkGkpPEKPBgDAW11YUdQC+VRC9zBWwqvvYbPWuiUbi9JTQ1gYXs18sVmDM0RP1wzTmkhEOWpIMKAInvujPHi5zcFl8MoWrhyd/P94Mlbe4dR/1V8trXCf3LS9+jHDJ49ymVD3FVMcnzL9ypuiEfdNhgi5T8KyQynvUamBLU+6PLupMYBXv3g+Fas/QyGxoyWjM00/mxjmXFPftbxQo0/RZDwqycCzfzTgn/ungMI7ysfrMThvtvnyEP/dYjh1zGKet6BKyJ7XbK4l4TeitIpjh/T9MuDV1GXbm8vH4kGrmhpSf0RIsF6YurVA5Uhioh4pcTJTbHfHayz9/xfSUJX9JLMfS3PeHe39zwETzaZkLe4510zsVfHPSCj3T7E8422AJhm3byq6lCO08jfKP209UIlZmdAeuXmYrTYOV7oIhbgChRnxPLpyuRxhS0dtjdDDVCW0cL6oqus2xByI+Oe/iHmFzVUsnSDoHvO2mObYnHf7dSF8v6D2ZZRC2hcUUH9tHO/ukr+AYXcdwvwOLkVWAzUhueZty8z2/EQmhGj9U7uIYkB4u+dvZZndM5uwoNFNBGLma9vDNzrbJuvp0+rFUoEIQ/ZOcOlCjJ+L5bnhCfNtdVPVFe46vFplG/Hzkeg5Gs2zNtQOT0qXEAsHkbKHgI8R72P6AOzfG91OHzs8ipA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(6506007)(4326008)(66446008)(66946007)(66476007)(53546011)(66556008)(71200400001)(186003)(6512007)(2616005)(26005)(4744005)(122000001)(44832011)(508600001)(38100700002)(54906003)(6486002)(5660300002)(38070700005)(86362001)(83380400001)(316002)(2906002)(31696002)(8936002)(7416002)(31686004)(76116006)(6916009)(8676002)(36756003)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZaWXNlUkw3cFp5UkxGZUtVZ1VWaEhnZ21lMWUrKyt6WFEwS012ZkVqcU9q?=
 =?utf-8?B?amc4ZFhVMzQ1Y3Y4RnlsSjN0Q3h3eW9ML05lelN1c2hsU2dkNXd1STA0Y0Ev?=
 =?utf-8?B?NGgvd1FmT2hmNkdqR2MvTCtKYUhndDNwWEloMXpmNXJzOGpUOFhqSWFJK0tl?=
 =?utf-8?B?WVdXUTdtb1NrR3k0SXRteG55aXNHUjhPTm1YQmc2UVBOdm9GbUF0M3JpTGN0?=
 =?utf-8?B?ZDQwNG9DN2Fjc1NHMlkySWZER3hMZk1yS2RJeTQrOVRDd2RoZ3lvYklsbXBl?=
 =?utf-8?B?NmYzV3I2RWt0STI4QUlySG9xbVB0QTQ2b0d6K2ZwOFY3SUx0NlBvMDFzaDRy?=
 =?utf-8?B?a2xUMTJJejdyMENmSEVVZ2ROOXhidDNqOW5RMUFVbXQrc1poSGVBd2l5cWti?=
 =?utf-8?B?RWZhTFV0N0g1djFwNnA3Y1V0aDRFSzdYYU40ZTJwODJCZmo3WHJhSEhNanM2?=
 =?utf-8?B?RnY5RFJXa3o0VG9Fc2ZiK3ZSSitMOTB5YnRUVFdObU80eXB2ajFVWlJCaHNY?=
 =?utf-8?B?Z0s3dzkxSTJPNVVmT3JTNjdKUytwZEp5TURwZERDLzlBaXRlYnppdFFkZDEr?=
 =?utf-8?B?MjBpV1RMK0tkZXNWS2gwVEtmZ1QwL3Z1Z0FrTnRKWmh4S0lKOFpvUkJHYzJx?=
 =?utf-8?B?V0tQMGVremJTQ2xUVnpKSHZYNUJFUTlUTVpOc0VzTWNyQ1pMUFpVRCtkRWRI?=
 =?utf-8?B?dzBnOHlqYTQvbTY3VkduQlVSZzhTVk5sOXFWNUZzNm5yejN3djRGQ3l3blZO?=
 =?utf-8?B?Z0hlZm9iS2JJZTI1ZEVKUjh1Sk5kWkxRdHp1T2VoNEZDOFp2eEpueTIxNU9u?=
 =?utf-8?B?Z1R1d2loSWphQWplaGVYNTgvTVdOTnZaM050Zk9vamROS1RhSnEwczcvdC9n?=
 =?utf-8?B?MVVjSmN1RzVhMXFUU05nV2h5UlkxWjFyMXczTzcyZ3ZKRUdjNDFRdjN4Znc5?=
 =?utf-8?B?Vjg1dlN1RUZZSXlLVTFRT2czVCtBNW1mUUZ0YmUvaEFDMUV1Q1kycDllUFhX?=
 =?utf-8?B?SkFBeUo2Sy9OWFFxL1RRcFpXbXlmOFFYNHY4OUxEdndNTG1jNThoeitHbGZH?=
 =?utf-8?B?TXZCRVJwck1UQ0o1UXJwUjVwT3FGZlVKaWRJQnA3VkRKRURLZkI1WkRKOTlw?=
 =?utf-8?B?VVpaNllyNGk0Y1E2ME5CUFpZSDRrV1VTQkFMcTJsYVFuTkY3MXZNcGNubjF4?=
 =?utf-8?B?ZUZnc2FKdjdYOWsxajBGcWljR0FOL2pCRWV3Mkg1bUVBbWdkaGZpUGF1L210?=
 =?utf-8?B?M1FpTXp5UUxWS1N5L2pMK1BBS1VkOFVBdjZHSE1taHhMWk9ZSWxvUXBPbjdX?=
 =?utf-8?B?c0VLaTFPZ3hHRzc0QWYwVHNCTExNemJmeUMvRzF6cHNscGtrRUVuMDFKMmRz?=
 =?utf-8?B?VXNEN2ZrRnkwalZST1RzOVBFdWJMaEVMOGVha2l2NU5YTGdRK0h4ZDFJWC9i?=
 =?utf-8?B?aFk1ZFlneFNESkRnbHlITGEyOXo0Q1IzSkNMOFJTdG5wSUFZbWphOVBoQis1?=
 =?utf-8?B?L0t6NEtxQm5POUxOMjVaRVIzQUlROVgza2NMNlFFMHVPb0tZa00vMUZSUmdM?=
 =?utf-8?B?cXZxS09RNGYzeFlkbGVmR2FKSXlwaWlLRjh1M3lQT0plZ1pOTXRiRFJnK0J2?=
 =?utf-8?B?WCtmYnFTZFZNQ25MY1BVdnhwT1FlZ2JkL04rWWREK1lYV2FLNU5jekxSakVW?=
 =?utf-8?B?Q0VrTVB2US9sTFNzcjl2cExKYW9DVkEzSk1aQnhpNlNZMlFJeG9WVmtKZVl5?=
 =?utf-8?B?RzFuZGNWR1VSTDFsQnVMbW9PT3JMOUdHNi9BWCtqOHpVTzBoc1oxSVZ1clFK?=
 =?utf-8?B?S0VIZ3N3TVNvRHh6QzI4Q25WSW0rOTYxOHp6ZGx4TTE5MDBYeU1CekhJUlBN?=
 =?utf-8?B?cjBUMldsL1BvaktJSnZJSy9rNlk5ME9laFNFV1FsdDMreUhCUGxlMXlCTnN2?=
 =?utf-8?Q?AexZfnBC4Rg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78623CBF5E60C147ABCF78F18FF23386@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d8d44b-407b-4b92-aa5e-08d994f70160
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 00:58:04.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5533
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220003
X-Proofpoint-ORIG-GUID: Ij43I3ZdzYUBLXJy0ohdiKNp1otPnKOt
X-Proofpoint-GUID: Ij43I3ZdzYUBLXJy0ohdiKNp1otPnKOt
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjEvMjAyMSA0OjI4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+ICsJaWYg
KGZsYWdzICYgREFYREVWX0ZfUkVDT1ZFUlkpIHsNCj4+ICsJCWxlYWRfb2ZmID0gKHVuc2lnbmVk
IGxvbmcpYWRkciAmIH5QQUdFX01BU0s7DQo+PiArCQlsZW4gPSBQRk5fUEhZUyhQRk5fVVAobGVh
ZF9vZmYgKyBieXRlcykpOw0KPj4gKwkJaWYgKGlzX2JhZF9wbWVtKCZwbWVtLT5iYiwgUEZOX1BI
WVMocGdvZmYpIC8gNTEyLCBsZW4pKSB7DQo+PiArCQkJaWYgKGxlYWRfb2ZmIHx8ICEoUEFHRV9B
TElHTkVEKGJ5dGVzKSkpIHsNCj4+ICsJCQkJZGV2X3dhcm4oZGV2LCAiRm91bmQgcG9pc29uLCBi
dXQgYWRkciglcCkgYW5kL29yIGJ5dGVzKCUjbHgpIG5vdCBwYWdlIGFsaWduZWRcbiIsDQo+PiAr
CQkJCQlhZGRyLCBieXRlcyk7DQo+PiArCQkJCXJldHVybiAoc2l6ZV90KSAtRUlPOw0KPj4gKwkJ
CX0NCj4+ICsJCQlwbWVtX29mZiA9IFBGTl9QSFlTKHBnb2ZmKSArIHBtZW0tPmRhdGFfb2Zmc2V0
Ow0KPj4gKwkJCWlmIChwbWVtX2NsZWFyX3BvaXNvbihwbWVtLCBwbWVtX29mZiwgYnl0ZXMpICE9
DQo+PiArCQkJCQlCTEtfU1RTX09LKQ0KPj4gKwkJCQlyZXR1cm4gKHNpemVfdCkgLUVJTzsNCj4+
ICsJCX0NCj4gDQo+IFNob3VsZG4ndCB0aGlzIGp1c3QgZ28gZG93biBpbiBhIHNlcGFyZSAtPmNs
ZWFyX3BvaXNvbiBvcGVyYXRpb24NCj4gdG8gbWFrZSB0aGUgd2hvbGUgdGhpbmcgYSBsaXR0bGUg
ZWFzaWVyIHRvIGZvbGxvdz8NCj4gDQoNCkRvIHlvdSBtZWFuIHRvIGxpZnQgb3IgcmVmYWN0b3Ig
dGhlIGFib3ZlIHRvIGEgaGVscGVyIGZ1bmN0aW9uIHNvIGFzDQp0byBpbXByb3ZlIHRoZSByZWFk
YWJpbGl0eSBvZiB0aGUgY29kZT8gIEkgY2FuIGRvIHRoYXQsIGp1c3QgdG8gY29uZmlybS4NCk9u
IHRoZSBzYW1lIG5vdGUsIHdvdWxkIHlvdSBwcmVmZXIgdG8gcmVmYWN0b3IgdGhlIHJlYWQgcGF0
aCBhcyB3ZWxsPw0KDQp0aGFua3MhDQotamFuZQ0KDQo=
