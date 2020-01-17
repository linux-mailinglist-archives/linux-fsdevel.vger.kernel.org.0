Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115DE140C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 15:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgAQOdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 09:33:05 -0500
Received: from mail-co1nam11on2115.outbound.protection.outlook.com ([40.107.220.115]:61249
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbgAQOdE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:33:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlNRIFJCGkDJh5ZAkBzXWpxMsHv2sNdkSWcb+Qg+fncRNhyEyekCDGfzOgJ66OAmYpI3J92XKqMf0Af/+EDsdZWV+X+teuMph0sqZxKqUFpo8C+yj2eI7oysUEcatGUiZ4rEPa41l9jm16i5vxXvN/sV51yk+j8jfH+1/TXiLOtV3keUCjvlMVwBs5ufSZfYaCYkuR8lTQpCcGCcu3mLg4udr9KIk0B1vVf2lEggjlJmT5nxHjHU8CR3FAC3N9w1IQJVXCiDpaltefmAkcvGnU75srAXlMcRWvnC0X00Pq6gsR4N/y3AsR6fXENGWmIvZ5ojK46It23rD7+C4VyUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQNXJ4vx3iudgzDf2j5kFY2dFvGzV1XptBRSk6i/ST0=;
 b=HIH9Fn8wR5ZyPOSxbaXjY13YtqblLRWPKPs1XgkLswVTP5wt+QKqMFw3OHtNeymMTvtolLqqZDSb2uz6whj4IcVN7UWb8vm/wKqYwXGv6EdnJU+D+TUq7qTPoU7qEd4tfpIKSTshYkUrW9VDj7XNDz02jxk0dHt6wh1b23AmnEAD16RLpEtqjV9PzWNtOoBpfy8VCt4TCv1DfkgqnvicEh1Vb5WrNoULd2FsML5A1awjx2J7C5HQVh75CesFwAOcnWWamXWr59fLLFDo02ke5QDKXCkLTvIvL6g6Q+lWAfuPW+MSfNDFEJgauJnhA+UU6uQbZH/uJShjhm4Vw2KOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQNXJ4vx3iudgzDf2j5kFY2dFvGzV1XptBRSk6i/ST0=;
 b=ZQLeOMnsjlIq4QOWa1Wrfs7BcFFDo9ebBlpPh28aw2xbSgwfNZSbEmQlPp0/RGo5yj9G4i1Lxjn4W/g6cY/LelCdL/ShmxCZFgO+KtS5TzNLGF9V4yHrBBWdTyO66hQBsgecY0hYcN9Jr+5oQ752FU+VakAZxQJ+dUXfDCs6pw0=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1930.namprd13.prod.outlook.com (10.174.187.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.12; Fri, 17 Jan 2020 14:33:02 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 14:33:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "osandov@osandov.com" <osandov@osandov.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "hch@lst.de" <hch@lst.de>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Thread-Topic: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Thread-Index: AQHVzTSO+0pwcPyVr0iwCBUjAesfDKfu658A
Date:   Fri, 17 Jan 2020 14:33:01 +0000
Message-ID: <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
References: <364531.1579265357@warthog.procyon.org.uk>
In-Reply-To: <364531.1579265357@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ca0d773-68ec-4f19-aa88-08d79b5a2839
x-ms-traffictypediagnostic: DM5PR1301MB1930:
x-microsoft-antispam-prvs: <DM5PR1301MB19306A65B0DF1E1F76439088B8310@DM5PR1301MB1930.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(39830400003)(366004)(189003)(199004)(91956017)(4326008)(54906003)(36756003)(110136005)(316002)(2616005)(966005)(66946007)(64756008)(71200400001)(478600001)(76116006)(66446008)(66556008)(66476007)(81166006)(6512007)(2906002)(4744005)(8676002)(5660300002)(186003)(81156014)(6506007)(26005)(86362001)(6486002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1930;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fGmEDlymblXMe1WieZ/h1D4W5fLq4iwjTny8H9cHygNg5/z3H+IqDH2vPwkblJwQMHFteqsZtWvj0qpE+AM1LIfh+FFm+09jxm9JYJlF4gBHDZZqvrUnZx4PswHyptjcOxIcSX1MQvdaBpqiD5Vz3iygzQ1hEqcZTyh4iJpp0dhOTcHQqoYzvIOBtOKFvh13aGh6rVulAaVklrtTix0R4EseL5kR14+SdkIdU3WkbXl0TEf16FpQq55aDdZuoxPXmdWSnwn8E6jUAPuHsAN04gm6HK85Cj0qms0Lh0CS5aVAIWmOXrvh9g9zREDa7MJkNxc4qTfgwuiQ6HCVo5Zd4zleeDMIUDRJ9+ik/cl390yIvdvclu/c8VTOfVlEuIF3JRwbfsDxP5r9iziSvtskiJSCX17mzIYXx25fL6F2BbbZAvbPSwl5Z6MOmNITKWdgUuFKnP6UrLBo86b1FjE/EG8tNmjs10dqd2I0sQW1tWo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EA3106F0C7FAB4DAFF770979749701A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca0d773-68ec-4f19-aa88-08d79b5a2839
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 14:33:01.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCiO8Bg4NRMiBFFz2WSLMAxdztofgDzLA3qN/L7EObSCDpqj4JELn9f0mqpkw7dqC1uT+4j0vzdAvZtvr/w0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1930
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDEyOjQ5ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBJdCBtYXkgYmUgd29ydGggYSBkaXNjdXNzaW9uIG9mIHdoZXRoZXIgbGlua2F0KCkgY291bGQg
YmUgZ2l2ZW4gYQ0KPiBmbGFnIHRvDQo+IGFsbG93IHRoZSBkZXN0aW5hdGlvbiB0byBiZSByZXBs
YWNlZCBvciBpZiBhIG5ldyBzeXNjYWxsIHNob3VsZCBiZQ0KPiBtYWRlIGZvcg0KPiB0aGlzIC0g
b3Igd2hldGhlciBpdCBzaG91bGQgYmUgZGlzYWxsb3dlZCBlbnRpcmVseS4NCj4gDQo+IEEgc2V0
IG9mIHBhdGNoZXMgaGFzIGJlZW4gcG9zdGVkIGJ5IE9tYXIgU2FuZG92YWwgdGhhdCBtYWtlcyB0
aGlzDQo+IHBvc3NpYmxlOg0KPiANCj4gICAgIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1mc2RldmVsL2NvdmVyLjE1MjQ1NDk1MTMuZ2l0Lm9zYW5kb3ZAZmIuY29tLw0KPiANCj4g
dGhvdWdoIGl0IG9ubHkgaW5jbHVkZXMgZmlsZXN5c3RlbSBzdXBwb3J0IGZvciBidHJmcy4NCj4g
DQo+IFRoaXMgY291bGQgYmUgdXNlZnVsIGZvciBjYWNoZWZpbGVzOg0KPiANCj4gCQ0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzMzMjYuMTU3OTAxOTY2NUB3YXJ0aG9n
LnByb2N5b24ub3JnLnVrLw0KPiANCj4gYW5kIG92ZXJsYXlmcy4NCj4gDQoNClRoYXQgc2VlbXMg
dG8gbWUgbGlrZSBhICJqdXN0IGdvIGFoZWFkIGFuZCBkbyBpdCBpZiB5b3UgY2FuIGp1c3RpZnkg
aXQiDQpraW5kIG9mIHRoaW5nLiBJdCBoYXMgcGxlbnR5IG9mIHByZWNlZGVudCwgYW5kIGZpdHMg
ZWFzaWx5IGludG8gdGhlDQpleGlzdGluZyBzeXNjYWxsLCBzbyB3aHkgZG8gd2UgbmVlZCBhIGZh
Y2UtdG8tZmFjZSBkaXNjdXNzaW9uPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
