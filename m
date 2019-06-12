Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A342153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437621AbfFLJro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 05:47:44 -0400
Received: from mail-eopbgr670101.outbound.protection.outlook.com ([40.107.67.101]:21776
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437315AbfFLJro (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHwinwiRTyd7elaRQ4eGRyuD4IaBeL0SL6+sc7DP3fM=;
 b=PERUtsr91lOIUSqI2dLSpvwFl02mrftBVEbeIWRRWDbF5L+MVhSNAAUj8NYs8eynisF2RjxJFJBA+o9gtmA4woXocapUcjRZAgqyscF+/dy0+pN+DV41zdQxoPhENhiY1hBB1TNsphQ5bnchGjNPcXRbgJJ9ftfzvttBVxEYumk=
Received: from YQXPR0101MB0792.CANPRD01.PROD.OUTLOOK.COM (52.132.75.161) by
 YQXPR0101MB1797.CANPRD01.PROD.OUTLOOK.COM (52.132.78.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Wed, 12 Jun 2019 09:47:40 +0000
Received: from YQXPR0101MB0792.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dc19:eb46:8b29:e502]) by YQXPR0101MB0792.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dc19:eb46:8b29:e502%6]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 09:47:40 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu check
Thread-Topic: [PATCH] io_uring: fix SQPOLL cpu check
Thread-Index: AQHVILE8MKvlFSwx2kqc/AjEamoMkaaXv8UAgAAXWoA=
Date:   Wed, 12 Jun 2019 09:47:40 +0000
Message-ID: <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
References: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
 <20190612092403.GA38578@lakrids.cambridge.arm.com>
In-Reply-To: <20190612092403.GA38578@lakrids.cambridge.arm.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [2001:bb6:a2c:ed58:2ca3:41e6:9240:e71d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1fe94ea-82a4-494d-2714-08d6ef1b0258
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YQXPR0101MB1797;
x-ms-traffictypediagnostic: YQXPR0101MB1797:
x-microsoft-antispam-prvs: <YQXPR0101MB17971289C5E96B4B10091EEDAAEC0@YQXPR0101MB1797.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(376002)(396003)(366004)(136003)(199004)(189003)(4744005)(76176011)(81156014)(54906003)(508600001)(6116002)(2906002)(8936002)(446003)(486006)(14444005)(36756003)(102836004)(99286004)(6506007)(71200400001)(14454004)(5660300002)(25786009)(33656002)(256004)(71190400001)(4326008)(2616005)(229853002)(6916009)(186003)(6246003)(7736002)(58126008)(305945005)(53936002)(8676002)(6486002)(11346002)(476003)(86362001)(66446008)(66476007)(68736007)(316002)(81166006)(73956011)(6512007)(46003)(66556008)(64756008)(76116006)(91956017)(66946007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:YQXPR0101MB1797;H:YQXPR0101MB0792.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gj87e061HACEbkw7MSULW6nHSxRBzrrGWMJtYXQtiaG34stO+gtjL5UG9y/pjB0x7JGB5pSdkW2dq1VacqyQf6A7+kd/RPlRzPd6mkePxgY22D1NsOFhyjdpHVWU8xpH4Q47OPNgwE/FM6La2qkrsuxmWjqhWde1n0lkLnFo59pIf8StX6FF1SYIkcaU662IlyRCqDACUr3ZkaFYj+cxcBivjAqwmypyvvNvw9mzWHJEbGoY2vo/nTrLNDa+DKJe5RRjA97Ba2f5X1+Dkd5eoL3VXdJFZyX/cuLIyg/B1Il82wIsLeurw1mtnPB/aD0mJI4AzNquoiLO7rxYqndWJFo5uI6pUGyxIvch1OB6x2Oct09TMxUxUKxmLcDorExtdhgilgNcLWq2wPp2hlvM9SSGNNUg0AhvGgp9gg8/3Go=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F256B79C2DC9584FBE3C0FEB46796B20@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fe94ea-82a4-494d-2714-08d6ef1b0258
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 09:47:40.1021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1797
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBBYXJnaC4gTXkgb3JpZ2luYWwgcGF0Y2ggWzFdIGhhbmRsZWQgdGhhdCBjb3JyZWN0bHksIGFu
ZCB0aGlzIGNhc2Ugd2FzDQo+IGV4cGxpY2l0bHkgY2FsbGVkIG91dCBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UsIHdoaWNoIHdhcyByZXRhaW5lZCBldmVuDQo+IHdoZW4gdGhlIHBhdGNoIHdhcyAic2lt
cGxpZmllZCIuIFRoYXQncyByYXRoZXIgZGlzYXBwb2ludGluZy4gOi8NCiAgDQpJdCBsb29rcyBs
aWtlIEplbnMgZGlkIGEgZml4IGZvciB0aGlzICg0NGE5YmQxOGEwZjA2YmJhIA0KIiBpb191cmlu
ZzogZml4IGZhaWx1cmUgdG8gdmVyaWZ5IFNRX0FGRiBjcHUiKSB3aGljaCBpcyBpbiB0aGUgNS4y
LXJjIHNlcmllcyANCmJ1dCB3aGljaCBoYXNu4oCZdCBiZWVuIGFwcGxpZWQgdG8gdGhlIHN0YWJs
ZSBzZXJpZXMgeWV0LiBJIGFtIG5vdCBzdXJlIGhvdyANCkkgbWlzc2VkIHRoYXQgYnV0IGl0IG1h
a2VzIG15IHBhdGNoIHJlZHVuZGFudC4NCg0KSmVucywgd2lsbCA0NGE5YmQxOGEwZjA2YmJhIGJl
IGFwcGxpZWQgdG8gc3RhYmxlIGtlcm5lbHM/DQoNClN0ZXBoZW4NCg0K
