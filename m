Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB94DE31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 02:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUAxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 20:53:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfFUAxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:53:10 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5L0n6pb024860;
        Thu, 20 Jun 2019 17:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rfFkiPShQzEVfsAfv0mVYmmcOwxF+CykIiBpbVFSyeA=;
 b=IVw3LaAlpegWPd0PIAanikm4sqlmhvNGhJWzLoeO0xgoRuAZpAF2p/TlvoXqLSlHezra
 4XgG36C3tGlXFNWCtaIkL4q8RpJzL+YHTb0Xux9mri5eiGVDryOPM1+Zmaq+bhSlagA9
 uf1fPg1uQfi4yv+R+/P3bDSDEVMiiCMfx7U= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t8f1n1aa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 17:53:05 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 20 Jun 2019 17:53:03 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 20 Jun 2019 17:53:03 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Jun 2019 17:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfFkiPShQzEVfsAfv0mVYmmcOwxF+CykIiBpbVFSyeA=;
 b=nfOPxpQ/nrTzy5ywCY4U1BRQYFn44sTATCQfAjVqDt6dVUHHcfMaR2j3jD0UB7nxVucNP0s8wumD74l6KcFEd+Q3Md/BKhOJvMz3Uc18goPlUbg9otBKub378sjuO9bN6N5+ruLM1UcC02LI/hCvayvDQPELPkgX53o4pxt9cqo=
Received: from BYAPR15MB3479.namprd15.prod.outlook.com (20.179.60.19) by
 BYAPR15MB2533.namprd15.prod.outlook.com (20.179.154.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 21 Jun 2019 00:52:48 +0000
Received: from BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2569:19ec:512f:fda9]) by BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2569:19ec:512f:fda9%5]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 00:52:48 +0000
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
Subject: Re: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in pagecache
Thread-Topic: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in
 pagecache
Thread-Index: AQHVJ6psGciqfymLkEuGvdXzLhHMCqalR+4A
Date:   Fri, 21 Jun 2019 00:52:48 +0000
Message-ID: <7bbcb43070c5b07e5862e2dbdc7155efcae3eb4a.camel@fb.com>
References: <20190620205348.3980213-1-songliubraving@fb.com>
         <20190620205348.3980213-7-songliubraving@fb.com>
In-Reply-To: <20190620205348.3980213-7-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0076.namprd19.prod.outlook.com
 (2603:10b6:320:1f::14) To BYAPR15MB3479.namprd15.prod.outlook.com
 (2603:10b6:a03:112::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:f51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fccf7c6c-d0f6-44aa-c8d5-08d6f5e2c7cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2533;
x-ms-traffictypediagnostic: BYAPR15MB2533:
x-microsoft-antispam-prvs: <BYAPR15MB25339DF7C5C11D7549513032A3E70@BYAPR15MB2533.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(110136005)(6116002)(2616005)(5660300002)(2201001)(186003)(446003)(2501003)(102836004)(71190400001)(476003)(8676002)(71200400001)(81156014)(386003)(229853002)(118296001)(8936002)(11346002)(6506007)(486006)(86362001)(2906002)(76176011)(54906003)(46003)(81166006)(316002)(53936002)(256004)(7736002)(305945005)(66476007)(66556008)(52116002)(64756008)(66446008)(6512007)(478600001)(4326008)(68736007)(73956011)(25786009)(6486002)(4744005)(99286004)(6246003)(14454004)(66946007)(6436002)(36756003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2533;H:BYAPR15MB3479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XKEnWkzkIzoTog/oB1OYOCaSjWGhPL0sIgHQlqoy3qrJ67Ns7uv+N/becLyUpdCLDTAZTnP9RP526P+nvFPB1qLEbBYrTChyUWnRYjHrUw+4XHqZLFvTW8yATvSmAe6KjLBRALGZxAdarSjuwcxFScBdn4TVG5Kc1suDueNRxa3GqPqVxyNYzY/8mWZNWG56iiLGTkrOpnYhWFgbs7fKFjQ92RWuGai7ZhGN7+yq6XyzsKNMqKxDMpKQBh3l2jWkH0f3EUnw2dmjE+YFglGYMewP6YKPiNWBtwgkWCfxLdniiBpVtw6dUhF0E07jllzSi8lXAVLIDLl7Unqs+ez2mEfqAZQ0IOaT8o1mn4qkiJupYy8cidM61L7G22NOpK7pu+N36jEMpXEX5m7B6ysin7rrnzdEpyMn6nFLm6tVOow=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1972BBF60920C347B831CB04AD0C27EA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fccf7c6c-d0f6-44aa-c8d5-08d6f5e2c7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 00:52:48.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riel@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2533
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=711 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210005
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDE5LTA2LTIwIGF0IDEzOjUzIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gSW4g
cHJldmlvdXMgcGF0Y2gsIGFuIGFwcGxpY2F0aW9uIGNvdWxkIHB1dCBwYXJ0IG9mIGl0cyB0ZXh0
IHNlY3Rpb24NCj4gaW4NCj4gVEhQIHZpYSBtYWR2aXNlKCkuIFRoZXNlIFRIUHMgd2lsbCBiZSBw
cm90ZWN0ZWQgZnJvbSB3cml0ZXMgd2hlbiB0aGUNCj4gYXBwbGljYXRpb24gaXMgc3RpbGwgcnVu
bmluZyAoVFhUQlNZKS4gSG93ZXZlciwgYWZ0ZXIgdGhlIGFwcGxpY2F0aW9uDQo+IGV4aXRzLCB0
aGUgZmlsZSBpcyBhdmFpbGFibGUgZm9yIHdyaXRlcy4NCj4gDQo+IFRoaXMgcGF0Y2ggYXZvaWRz
IHdyaXRlcyB0byBmaWxlIFRIUCBieSBkcm9wcGluZyBwYWdlIGNhY2hlIGZvciB0aGUNCj4gZmls
ZQ0KPiB3aGVuIHRoZSBmaWxlIGlzIG9wZW4gZm9yIHdyaXRlLiBBIG5ldyBjb3VudGVyIG5yX3Ro
cHMgaXMgYWRkZWQgdG8NCj4gc3RydWN0DQo+IGFkZHJlc3Nfc3BhY2UuIEluIGRvX2xhc3QoKSwg
aWYgdGhlIGZpbGUgaXMgb3BlbiBmb3Igd3JpdGUgYW5kDQo+IG5yX3RocHMNCj4gaXMgbm9uLXpl
cm8sIHdlIGRyb3AgcGFnZSBjYWNoZSBmb3IgdGhlIHdob2xlIGZpbGUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPg0KDQpBY2tlZC1ieTogUmlr
IHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KDQoNClRoZSBjb21tZW50IGZvciByZWxlYXNl
X2ZpbGVfdGhwKCkgaXMgYSBsaXR0bGUgaW1wbGVtZW50YXRpb24NCnNwZWNpZmljLCB3aGljaCBp
cyBub3JtYWxseSBhIGJhZCB0aGluZyAoZm9yIGNvZGUgd2UgZXhwZWN0DQp0byBzdGljayBhcm91
bmQgZm9yIHllYXJzKSwgYnV0IHByb2JhYmx5IHRoZSByaWdodCB0aGluZyBmb3INCmNvZGUgdGhh
dCBpcyBqdXN0IGEgc3RlcCBpbiB0aGUgZGlyZWN0aW9uIHdlIHdhbnQgdG8gZ28uDQoNClRoYW5r
IHlvdSBmb3IgcmV3b3JraW5nIHRoZXNlIHBhdGNoZXMgc28gcXVpY2tseS4NCg0K
