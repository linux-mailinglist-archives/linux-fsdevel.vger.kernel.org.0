Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1873810B5D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfK0Sit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 13:38:49 -0500
Received: from mail-eopbgr730137.outbound.protection.outlook.com ([40.107.73.137]:13923
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0Sit (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:38:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLNXSrq9pwZttaZzfDfICdUacm9E4yXgjiXUaxU+xuixAxQyX8dg6lNIQ/hnJuLVCLM+kA8b3WzWyvKOCSn3H6n2NARFM6FP6dSrtIzLd6CQ6gDrHOi3lR63PM8OVJ6MUmHgmduFZ7G68D21mbVkbrUv4F+PStbUChYu2554P0dHcGDBldi5OjJO8nXA3DnGyS//aEcMVGjUswG8jlghkS/U2y/i+7lsoRHFhCcC4FnPjgqxGthZlCfRfCN1Box9p25KpWIaI4/K0W2asjLPdkBXyaHwWclE6ztF4hPUgpURdTfRrRriSZu/7T90cM/iuSnn6QW3BE1Ub0nffgpVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUKpvzVPA/I7Cgl/77OcmbdAjaS5eNpYn4szoXBK5Pk=;
 b=H0BTJlFyiE9awjZcBjMIGbTSZ4nhGTQw1XGgK+SJxqmBCmdUepHgWwY27eMpXbzApV2mscLGt5uO0Wn6z5WCSM6DcDAH/vhPhumzKcST6bN3jw6p1B7AcIZzQK//ULNOmKv6ouaJjrKnKMYo9FLvhQ1gdvmdc2kZ7T279EhBVrmJsC1WwXD0Hd6msO4vcAt10STOccMySmw3nRheGXqsVPJQr03uB2QOhpVKbh74sLMReLsaOSL9jiD1AzMxgAL9925VUzNt5CS/uW4hlEJFUlySTu7qljskUd6Id3Z+iug3aTsnGpYQO7xRgvR2Go/Q8bs4Xcarg7sQz2Txap9LeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUKpvzVPA/I7Cgl/77OcmbdAjaS5eNpYn4szoXBK5Pk=;
 b=Q2mPxYe8SQAcY+ZsiKb3Hup0YC3X0aCuXYhnQnXb66kuuecw3cqVDzCJUAcTrKL0FQ3uw4HQZmTuIroTBr7QM9Y+UJA87xsrT9sU0q/FlkrqcpYAndajo/eSI1xRg6kCtdOyFwA5V9wBVAdDOaOf6hT7HNKyEl3FDejXQQdQkOY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2105.namprd13.prod.outlook.com (10.174.185.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.10; Wed, 27 Nov 2019 18:38:46 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 18:38:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Question about clone_range() metadata stability
Thread-Topic: Question about clone_range() metadata stability
Thread-Index: AQHVpVHnjYPZ0FhJIUe2yp+YUANojA==
Date:   Wed, 27 Nov 2019 18:38:46 +0000
Message-ID: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da50a3c1-888b-412e-8f86-08d773690995
x-ms-traffictypediagnostic: DM5PR1301MB2105:
x-microsoft-antispam-prvs: <DM5PR1301MB2105F5E696D5632F53F32712B8440@DM5PR1301MB2105.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(53754006)(66556008)(66476007)(64756008)(2616005)(508600001)(4326008)(66946007)(256004)(118296001)(76116006)(81166006)(91956017)(66446008)(86362001)(14444005)(316002)(81156014)(450100002)(6486002)(25786009)(6512007)(5640700003)(8676002)(71190400001)(14454004)(71200400001)(8936002)(3846002)(5660300002)(4744005)(2906002)(99286004)(186003)(2351001)(6916009)(36756003)(2501003)(6506007)(6116002)(102836004)(26005)(305945005)(7736002)(66066001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2105;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQxTcVhpHVbLw6bXNjrYz9vYEwCHDZ3SL+uWmd2ri1qWo7Lpr19h5zxkIp0LdjuWbg4EoHQciDNeAlTYiUMSBA/naGTIlRWIF8InDudJlfhPcuJGC8AJk+xjs8f3SNbFyAUfC+lNnFxnR17N6BJmpBl0utK0jUa6BL5nlEaBYE+FapiHnBYaHN/PE+su0p+Vs2Px+bw2GI06iFuq/bQednyQ/feg47pfstRNnrd2CToNq0RDH229W5juFgIIoBHZOq4qeGBrLk1MRNpbwp0Dh5SS6lr/fkvYSjDHbWMALvwZXl8uUF/g7u56MjHr7/WOF2Dfm/o/oZEMfoJErNohhG2/gCPtA18lisQmEcXqcu61yXLeefAOYfwDa3t42aZxvgMtzpu9Bu1RXVZ+L2/WDpaAaQ8z5MxzdRboSeTh1KiMvrBlBLDpqjUN1Nufmy/u
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA0837BF5E1A494D8A9B8379D3B3947C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da50a3c1-888b-412e-8f86-08d773690995
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 18:38:46.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nVQMzQpShS3z3mpjaQZ2p+hbz7vxd+2h3kcBumKCzJzttXr5Wf3wUjz7PFCBAoZ/2zanZJpOCOJhz2On8470A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2105
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgYWxsDQoNCkEgcXVpY2sgcXVlc3Rpb24gYWJvdXQgY2xvbmVfcmFuZ2UoKSBhbmQgZ3VhcmFu
dGVlcyBhcm91bmQgbWV0YWRhdGENCnN0YWJpbGl0eS4NCg0KQXJlIHVzZXJzIHJlcXVpcmVkIHRv
IGNhbGwgZnN5bmMvZnN5bmNfcmFuZ2UoKSBhZnRlciBjYWxsaW5nDQpjbG9uZV9yYW5nZSgpIGlu
IG9yZGVyIHRvIGd1YXJhbnRlZSB0aGF0IHRoZSBjbG9uZWQgcmFuZ2UgbWV0YWRhdGEgaXMNCnBl
cnNpc3RlZD8gSSdtIGFzc3VtaW5nIHRoYXQgaXQgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gZ3Vh
cmFudGVlIHRoYXQNCmRhdGEgaXMgcGVyc2lzdGVkLg0KDQpJJ20gYXNraW5nIGJlY2F1c2Uga25m
c2QgY3VycmVudGx5IGp1c3QgZG9lcyBhIGNhbGwgdG8NCnZmc19jbG9uZV9maWxlX3JhbmdlKCkg
d2hlbiBwYXJzaW5nIGEgTkZTdjQuMiBDTE9ORSBvcGVyYXRpb24uIEl0IGRvZXMNCm5vdCBjYWxs
IGZzeW5jKCkvZnN5bmNfcmFuZ2UoKSBvbiB0aGUgZGVzdGluYXRpb24gZmlsZSwgYW5kIHNpbmNl
IHRoZQ0KTkZTdjQuMiBwcm90b2NvbCBkb2VzIG5vdCByZXF1aXJlIHlvdSB0byBwZXJmb3JtIGFu
eSBvdGhlciBvcGVyYXRpb24gaW4NCm9yZGVyIHRvIHBlcnNpc3QgZGF0YS9tZXRhZGF0YSwgSSdt
IHdvcnJpZWQgdGhhdCB3ZSBtYXkgYmUgY29ycnVwdGluZw0KdGhlIGNsb25lZCBmaWxlIGlmIHRo
ZSBORlMgc2VydmVyIGNyYXNoZXMgYXQgdGhlIHdyb25nIG1vbWVudCBhZnRlciB0aGUNCmNsaWVu
dCBoYXMgYmVlbiB0b2xkIHRoZSBjbG9uZSBjb21wbGV0ZWQuDQoNCkNoZWVycw0KICBUcm9uZA0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
