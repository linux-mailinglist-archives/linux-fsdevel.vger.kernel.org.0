Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49E24D565
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfFTRmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 13:42:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfFTRmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:42:44 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KHdcUn024973;
        Thu, 20 Jun 2019 10:42:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=x0vdkZunL9IfXEYc28/T8hr7b2Q35Kh/yS1RLSs3HQI=;
 b=XruAXWpUwRcz8jNKfDXZ0QeqpPWDZE7tOlp8aPVbAKx8b53bJCIor8gEgIDa+Z4GToSH
 PiaiqK4BzFXekBqsBbfC2tdtWanriKTGbC6d5fuCMZC4B883GXlJ2UoDECn61W9Wr6pn
 IgjvY7yX9eqI57Vw7a/9LilYL6abGTFeIOY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t85v8hv9a-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 10:42:38 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 20 Jun 2019 10:42:03 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Jun 2019 10:42:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0vdkZunL9IfXEYc28/T8hr7b2Q35Kh/yS1RLSs3HQI=;
 b=ApshshCG6UUg0rHxIrxyuQ8YdScn8SbnWo3AiHVwc7AJUZEx82XwurQh7qGAyJMn1Lzw3t1gb9z6chkE2SJ1foGsWGUPd5UzMuOkhlApg1mZXxG7T3kIuvXM4sn2WnWgPCg9G5983H/bKVdX5mvC9nDlcpvCNqgvcGuK5LNOd1Q=
Received: from BYAPR15MB3479.namprd15.prod.outlook.com (20.179.60.19) by
 BYAPR15MB3477.namprd15.prod.outlook.com (20.179.60.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Thu, 20 Jun 2019 17:42:02 +0000
Received: from BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2569:19ec:512f:fda9]) by BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2569:19ec:512f:fda9%5]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 17:42:02 +0000
From:   Rik van Riel <riel@fb.com>
To:     Song Liu <songliubraving@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 6/6] mm,thp: avoid writes to file with THP in pagecache
Thread-Topic: [PATCH v4 6/6] mm,thp: avoid writes to file with THP in
 pagecache
Thread-Index: AQHVJ42WlKpSo0vXAUuQuCQtIhxoiaakz86A
Date:   Thu, 20 Jun 2019 17:42:02 +0000
Message-ID: <c29e2daf2e3c9c8acbdfae62ba8090f572d88345.camel@fb.com>
References: <20190620172752.3300742-1-songliubraving@fb.com>
         <20190620172752.3300742-7-songliubraving@fb.com>
In-Reply-To: <20190620172752.3300742-7-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:301:1::15) To BYAPR15MB3479.namprd15.prod.outlook.com
 (2603:10b6:a03:112::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:f51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669ceda0-af1a-4109-49e9-08d6f5a69a0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3477;
x-ms-traffictypediagnostic: BYAPR15MB3477:
x-microsoft-antispam-prvs: <BYAPR15MB3477FBF380B43E021063380BA3E40@BYAPR15MB3477.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(71190400001)(36756003)(229853002)(6246003)(118296001)(4326008)(54906003)(110136005)(316002)(99286004)(25786009)(6512007)(52116002)(6116002)(2906002)(6436002)(6486002)(256004)(53936002)(446003)(46003)(102836004)(2501003)(11346002)(8676002)(305945005)(2616005)(476003)(386003)(7736002)(6506007)(186003)(2201001)(66946007)(68736007)(14444005)(86362001)(76176011)(5660300002)(73956011)(486006)(66446008)(81156014)(64756008)(66556008)(66476007)(478600001)(14454004)(8936002)(71200400001)(81166006)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3477;H:BYAPR15MB3479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +nOx2LLcEtCHczR0yW4whiONcBwCZN3KEGmuhEWbDqPHSEyjvyiCgYwLMMoYG6RDouyE58f0296Y1MtSoREZcHAsZ65JcZw4BAnkyEHYIGEHDz5xc+HLDA6XyaS1XvxBDUnBk9FxLkwZ8rJd495NR1Ah77yADCrPPM665gpeeVzLdxvf22hUUU2tS23vvB1L6XbjkgIRRz+dxc7Z6bWyWZKJNzkgaiR4bzTHhy8y9z+udVBAlufUgJBqStspcvuUZ5FaqrqPJIZvWdUHVm1VJJZ2t/g3wmgg5DbdEHz1CYyhGhlM0XQCQLf/Rg1MUMpikaVNt+wNflYVPFUa6FwQOgF6Nd1yb5hnCeHkXG7D6YX1svmOJhAZhgr/Hclw7zUIdtwUvpAMB3PXRufmatzi8ZH571E4G93xAIi34Dsrt+A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <282599B8798A4C4C9C2909D41B9A1221@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 669ceda0-af1a-4109-49e9-08d6f5a69a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 17:42:02.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riel@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3477
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200126
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDE5LTA2LTIwIGF0IDEwOjI3IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCg0KPiAr
KysgYi9tbS9tbWFwLmMNCj4gQEAgLTMwODgsNiArMzA4OCwxOCBAQCBpbnQgdm1fYnJrKHVuc2ln
bmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZw0KPiBsZW4pDQo+ICB9DQo+ICBFWFBPUlRfU1lN
Qk9MKHZtX2Jyayk7DQo+ICANCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCByZWxlYXNlX2ZpbGVfdGhw
KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiArew0KPiArI2lmZGVmIENPTkZJR19SRUFE
X09OTFlfVEhQX0ZPUl9GUw0KPiArCXN0cnVjdCBmaWxlICpmaWxlID0gdm1hLT52bV9maWxlOw0K
PiArDQo+ICsJaWYgKGZpbGUgJiYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9ERU5ZV1JJVEUpICYmDQo+
ICsJICAgIGF0b21pY19yZWFkKCZmaWxlX2lub2RlKGZpbGUpLT5pX3dyaXRlY291bnQpID09IDAg
JiYNCj4gKwkgICAgZmlsZW1hcF9ucl90aHBzKGZpbGVfaW5vZGUoZmlsZSktPmlfbWFwcGluZykp
DQo+ICsJCXRydW5jYXRlX3BhZ2VjYWNoZShmaWxlX2lub2RlKGZpbGUpLCAwKTsNCj4gKyNlbmRp
Zg0KPiArfQ0KPiArDQo+ICAvKiBSZWxlYXNlIGFsbCBtbWFwcy4gKi8NCj4gIHZvaWQgZXhpdF9t
bWFwKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPiAgew0KPiBAQCAtMzE1Myw2ICszMTY1LDggQEAg
dm9pZCBleGl0X21tYXAoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQo+ICAJd2hpbGUgKHZtYSkgew0K
PiAgCQlpZiAodm1hLT52bV9mbGFncyAmIFZNX0FDQ09VTlQpDQo+ICAJCQlucl9hY2NvdW50ZWQg
Kz0gdm1hX3BhZ2VzKHZtYSk7DQo+ICsNCj4gKwkJcmVsZWFzZV9maWxlX3RocCh2bWEpOw0KPiAg
CQl2bWEgPSByZW1vdmVfdm1hKHZtYSk7DQo+ICAJfQ0KPiAgCXZtX3VuYWNjdF9tZW1vcnkobnJf
YWNjb3VudGVkKTsNCg0KSSBsaWtlIGhvdyB5b3UgbWFrZSB0aGUgZmlsZSBhY2Nlc3NpYmxlIGFn
YWluIHRvIG90aGVyDQp1c2VycywgYnV0IGFtIHNvbWV3aGF0IHVuc3VyZSBhYm91dCB0aGUgbWVj
aGFuaXNtIHVzZWQuDQoNCkZpcnN0LCBpZiBtdWx0aXBsZSBwcm9jZXNzZXMgaGF2ZSB0aGUgc2Ft
ZSBmaWxlIG1tYXBwZWQsDQpkbyB5b3UgcmVhbGx5IHdhbnQgdG8gYmxvdyBhd2F5IHRoZSBwYWdl
IGNhY2hlPw0KDQpTZWNvbmRseSwgYnkgaG9va2luZyBpbnRvIGV4aXRfbW1hcCwgeW91IG1pc3Mg
bWFraW5nDQpmaWxlcyB3cml0YWJsZSBhZ2FpbiB0aGF0IGdldCB1bm1hcHBlZCB0aHJvdWdoIG11
bm1hcC4NCg0KV291bGQgaXQgYmUgYmV0dGVyIHRvIGJsb3cgYXdheSB0aGUgcGFnZSBjYWNoZSB3
aGVuDQp0aGUgbGFzdCBtbWFwIHVzZXIgdW5tYXBzIGl0Pw0KDQpUaGUgcGFnZS0+bWFwcGluZy0+
aV9tbWFwIGludGVydmFsIHRyZWUgd2lsbCBiZSBlbXB0eQ0Kd2hlbiBub2JvZHkgaGFzIHRoZSBm
aWxlIG1tYXAoKWQuDQoNCkFsdGVybmF0aXZlbHksIG9wZW4oKSBjb3VsZCBjaGVjayB3aGV0aGVy
IHRoZSBmaWxlIGlzDQpjdXJyZW50bHkgbW1hcGVkLCBhbmQgYmxvdyBhd2F5IHRoZSBwYWdlIGNh
Y2hlIHRoZW4uDQpUaGF0IHdvdWxkIGxlYXZlIHRoZSBwYWdlIGNhY2hlIGludGFjdCBpZiB0aGUg
c2FtZSBmaWxlIA0KZ2V0cyBleGVjdmUoKWQgc2V2ZXJhbCB0aW1lcyBpbiBhIHJvdyB3aXRob3V0
IGFueSB3cml0ZXMNCmluLWJldHdlZW4sIHdoaWNoIHNlZW1zIGxpa2UgaXQgbWlnaHQgYmUgYSBy
ZWxhdGl2ZWx5DQpjb21tb24gY2FzZS4NCg0KDQoNCg==
