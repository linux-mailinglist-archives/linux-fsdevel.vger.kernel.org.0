Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E644D2ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 09:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhKKIMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 03:12:02 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:43328
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229543AbhKKIL6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqCjJMDJZ6/3Y7/dQ31cg7hNBMwZEBy/JyHHf64KWdhlyZVYnruNpUbQSmTqxrfFfkGmQKVPut8NCl/tnGOV4mYgOswlgYzGTHgQiLkZlEy0/Z2jGj0aXqfCFahDBOhq3vZoRAhaIA3R2nQ4SmMee1pW2sQB5hhvrv2mtb3brKT43Jh+NFQqYbsGZOlRSESCgVqaJ5h/TSIx/rOy8TZrm+005Ysc9A9EU4yUFbFcwtQWvCw3miC/Y0baYYKQ9IFgqugY8NwfZcrsHZHMDVj+3U9Qg8YvFAiOnEUsMF+VlVe3Z3+wa7Jva+W25bhLmKk+DNPrfvBSJeXGmBSvCvZEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZbBoqp5lr1lzcynn8kSvjPt6jk322S/Hru4SfOcoiA=;
 b=KSuExRaLhkmCIN7f2C7sr1ACoOzEa7+R9vUauoihCgPkLz8JbS90hhg8Mt7uswplc4PLCAr0vhjnULJenULFJoIdUtHSUyAVqPmGyEdoQeP9jsBcX+c5+O3qVlGKRnNZkEk/Uuxx7bm5WIXpBS3YKXs4u5ULnXuojSHzDNRR4tuiqUNQO91uGW3KzdY1vbyh7/Ln7DoGp54yx7o5CqVzY9Gua4xCj89UpjDGVmA9MYieuhk84z/Nlby4qS0442WdpTQan40yWXc+AmU0y8fPgSMntpGJlz2bQE5/Vk/gapHbsmb9xP7GdVeMo4GMt1QVGqecexMv6by9d7ID+ldPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZbBoqp5lr1lzcynn8kSvjPt6jk322S/Hru4SfOcoiA=;
 b=UZOidQ4mAq4RpnEFQzJ5KlAwKHcu/96hFYNuF6hG5ogPiAftSEHsYvunrsjVaamtmKLiWR+pOZhnXyE24G2PbMetUDpk/HAG/s4TTOEEWBmXoTAf1kbOyN0GCnglmgGFd1/izuvt/Gym/chkUWnD2VF2WdM+w2ZySNnBoXc/r4IPRry2/mzSSp4uQYBKuaz2sRV3tIaANp0bqUhUZfvCbL5mcBon6+sraf0jOntp0V9QbHXywoCFCu3u7TZ8SLL6fpByWaE7e2xeCSeqXTYfSvOtPOlV8s5DsEWvAeCTWZJl67/1fcs3uy0IdUNTSGW/wiCQnnOLrZ20/NyATG8jBA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0224.namprd12.prod.outlook.com (2603:10b6:301:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Thu, 11 Nov
 2021 08:09:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 08:09:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [RFC PATCH 3/8] nvme: add support for the Verify command
Thread-Topic: [RFC PATCH 3/8] nvme: add support for the Verify command
Thread-Index: AQHX0Ufns/7MhUkEakq3YhkbprD95avz+KGAgAoLnYA=
Date:   Thu, 11 Nov 2021 08:09:07 +0000
Message-ID: <c8283a02-32df-5268-7526-7f1dbf2a15b2@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-4-chaitanyak@nvidia.com>
 <20211104224459.GB2655721@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211104224459.GB2655721@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78863056-8c90-49c5-1a03-08d9a4ea8934
x-ms-traffictypediagnostic: MWHPR1201MB0224:
x-microsoft-antispam-prvs: <MWHPR1201MB02245F4E76FFD4E1F357F8B5A3949@MWHPR1201MB0224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jcrfrqDjZZnPq4nHoz6kcCCktHn3Pi/yeRZmxReJunjQmBn1WPtgan/v5OMFogTtIu2e23uihSjWJ0dZi+eiIXI49OVhrPGU6VCH2piq9mW9fKL9811OdpUxsnkhUzelkgOmg/GnKXvuvjHAHFVSFp42dUiB9NV6yaBOyyKT8IjB5m0u0F0EPXbohMCs2ZC+2c2kI//oX+2S887pqltniVMn5jM1UOyP8ISrKROaxZq0g0wAThpUIwkTrd9mXurA7D6Vxbl75gOJL5f3uLWjBEaom/zDW3fd89tE6RwQo00RkM+7sCDbnYdgj71pEfKQIMBA5GCBrAcrT1l1XhCr3aUFzhnyJHnB3nzmw/+e/Rb5BITIRzVJFe5xK/oMDzAdkonM+4xcNQ00rSzhVURzLSBoqOKxPQzMMhUDYJw7YHlS5Ez7lPg4ZYVaiadw9zK9bGlk8hVtyQFmUnnMXY7vnFdvCZrRmAQlzaOQ+6CCEiBAIHsC6GcGRtzsiwbK93VDqdWrJZGp+0VrlIHqI4vL7jhzkaV5DQq5ycKOq9c9IuuYmBZJQ7LsHDjyxadvgVmyJm2FWL3W5LbstoKWx2GEqOe/LIGCw5+vBklI6LW4tyiaLBCPsbhOEkW1IH4YWqwBwroXDtdE3u1teC4Q2j+lkjeKqRTC1pBStQjOnMUiCQrJOnL+aFe2VBF+WR3F3iNY2tSSb7N7MgztkrsITmMXJXQ93AKpacSNwv2BQ1GCFIJD60xLipAe8VHB0fp74gPAzpCue+E7bQAF8FM6MgCj9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66446008)(8676002)(64756008)(8936002)(38070700005)(66476007)(54906003)(38100700002)(36756003)(122000001)(316002)(5660300002)(6512007)(6486002)(2616005)(4326008)(15650500001)(31696002)(508600001)(71200400001)(6506007)(53546011)(31686004)(66556008)(86362001)(76116006)(66946007)(6916009)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2x6elkrems1U2VRUEhZancrQy9HKzByNGRVQUViU3poY2c0ZGtoZ3N1OFpF?=
 =?utf-8?B?Z1BOZG1vQkorK20rSlo3Y0ZqdnVBQXpjOW5lb1VFVC84MWxlQmVyRXpzbnRi?=
 =?utf-8?B?a3RLM0NPUWcrMm5kVlIrVzFOdnZkTittNFd1K0NYaUlqL3FKNXBmM1pMRWV2?=
 =?utf-8?B?dXBuUWZyVHhYTlZJaVEvZUduaWxrUk4yNmJ1L0V4d1ZqN1dDY0crUXBoZzNr?=
 =?utf-8?B?dmp2d0dQRjdXdVUrdDlDaXQ0dksrNllheDFCY0VtTWdyYnQ0bWFyQXI4TmlO?=
 =?utf-8?B?SllveDc0c0M0ZUk5Um14QktnN1J5VXoxeFdla2xVdEhndkVBR1BHOElVTkpL?=
 =?utf-8?B?S2Z3WExEdUhMd004V2dHSHJaZWxod1BvMG52bkI5aHp4TTVSOXdkbTVWUERI?=
 =?utf-8?B?OUZNcVVZQ09iVktZOUtQK0ZjOG9NNDJ6a0Foc2cxMUN3cVRmbk5qcG9UMWQw?=
 =?utf-8?B?YU1iTEZZY1kwSHYyTDlkQ3IrMU81QTJ2TklNS3U5Z1hjWTAvQ0VvK2lPTWtz?=
 =?utf-8?B?VVRza2Z5dmlpa1V3dFAva292bWJ3em1sZit1TGlyWStVQjdFdU1zTmFxU0xL?=
 =?utf-8?B?ZzBUZ2NwTXhYT2xLYW1ubDZxN1ViMThrNW5ySE5ZOC9kR0xlTHhKSnV2a2dJ?=
 =?utf-8?B?MmJoZldHUjV3eTFIZDlFOHR4UzhwRE04cURlcFh6ekMzeEoxUjNxN3pDTXZu?=
 =?utf-8?B?TEJnbENqM3cwd1hoNDBiSnV3TjRrS1YvSEh6Sm5jalA1THJsZzhnTU9CdlBW?=
 =?utf-8?B?MEpvVHFhY3hjbFc5cVNPVGc0VjJZS3NKekNLekJQQVh4L0p5MTJ5b2JkNXc5?=
 =?utf-8?B?TTh3TDkzTkJSNTJtS01Dd0xRNjlERXRUZUk3dUF2V2pXYlVmNk1QSEVSMHJi?=
 =?utf-8?B?b2tqV2xHR3lnNFY3Rk9wOS9HKzdMQXhPTjVZRXMvNnZCdGk0dzZhaVd6SHp3?=
 =?utf-8?B?Qlp3enliUzV6Wk5lYm9PN0lIcktIenR2S3BpSDFJM1hkYWRyU3Fkd3N2MXQr?=
 =?utf-8?B?VUkxaWk3bmsrS0Nvc2tKTHhnTlF5ekh0SEhYZnlmSWl6eWc5SnYzZ1ErR1ov?=
 =?utf-8?B?T2M3UTRBWUhwVGpGdmQ3UTNTL05wOUFIbVNJRXVIWEtpUU92SElhL0NWNnRI?=
 =?utf-8?B?VFFMNUdYNnQyWG5jWG1Fam4vQlFIekt4UHVaMExPS0M5T3M5cFNQdXYrdllH?=
 =?utf-8?B?M3liQXBwQjRsOTYzQjFGVXZGVGtuNmVTYzdYQ1I2dW1xaHJGc0tBZ0kvbG15?=
 =?utf-8?B?aUs2Z2U5WkRQVjYvU1BBQU0yY1BtcGRGdFhDa0Q3Q3ZtRzlXMWRDbzcrWTBX?=
 =?utf-8?B?aWZmTkZ1Y2s1UFp3UFovWEVlaWxETE4zanpFUDIxSE8xRXZJVGxUc1dSZnll?=
 =?utf-8?B?aEJ2WXArRmV1R3dlYlVDNmdCZGlVTDJtNXIrRGllNGhDQ29aMHltWUl3Wm5a?=
 =?utf-8?B?UnRLbHVoMWp0ckJDN0k4SVI2WVk5d21IZitqdy9qZUR3UTIxWVowdVFUbzNF?=
 =?utf-8?B?YUZYUWNJOHF4alR0blloSTE0cGNML24vTkhKM25BME14ZXozZ3k0R1Y5ekVI?=
 =?utf-8?B?KzUvTUZNOWZXR2k5cWlqeHRGYW1pRHJrdk5qTHNGZklWak0xaEc3Ty9wN2pO?=
 =?utf-8?B?ZFEyNzE2dm8vcGxqdkZWSE1QRlhBb3hvamdTMlVGb0hCd2lJMm1ZOVYzaXZT?=
 =?utf-8?B?UHRhQ053RTlRbHcrbGdqZVlMV0lDZm00dG5iNGdBMEVZRjMxNGV4NUR2Q3Js?=
 =?utf-8?B?TXZ4a0x0YU4rMTh6UmM3ZWJlQkhQZENwSGIrRWN0UFRFbjBLaHFyR3lhUzRV?=
 =?utf-8?B?L09NUEVaYU10YTZNUTFpaldJRExlbk1WV0R2dGVUcGg2YlR6YUxVdW1BSzFQ?=
 =?utf-8?B?ZUNoZ0w0cGp3VXFJT2wzeDFUVVdIb3FsVjA2YkJsUE1GY1o5M3YzSytmQ3dL?=
 =?utf-8?B?UjNxTjZVdytOWndmcXN3NXFlVnpEcjBKaHNpcGRpWFR3ZEtWajd3RzE5TWZv?=
 =?utf-8?B?RFBKVDltVmhuZWJEbTVJWjY2cWRVcURITDRCQVpLc3cyekszeXV0MUFRcllo?=
 =?utf-8?B?cGhZQkRaK0poZ2pmM0NRckNMdFRNMEt6YVZNdlVPdXV4b2E1aDl2UWRsN2Nk?=
 =?utf-8?B?eDZMdVdzSnI2bW40UXVLOURhTVNtVDhuckwvSFBlcTJxZ04wQkhmSDRqQkFp?=
 =?utf-8?B?aWp2YUw0QkNOK0daMzRPWUNUYXo1TGpDOTVuWThpMjAzNlIzZGRyMksyb1dK?=
 =?utf-8?Q?mqIJibtJ0+5Rhi8kvvQFJTWRvqsrznoyZN2JlotfEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C19B3030F9D2544D889652BDB7F35519@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78863056-8c90-49c5-1a03-08d9a4ea8934
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 08:09:07.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gL5YzanYH0zT71oAtz6ugw0kjjU9SUbTgA+fZkQgtDg2BwIJLTBsRUuw/Uy7nvy1yj2KirChdCqsfsqPtq+qGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNC8yMDIxIDM6NDQgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9u
IFdlZCwgTm92IDAzLCAyMDIxIGF0IDExOjQ2OjI5UE0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJu
aSB3cm90ZToNCj4+ICtzdGF0aWMgaW5saW5lIGJsa19zdGF0dXNfdCBudm1lX3NldHVwX3Zlcmlm
eShzdHJ1Y3QgbnZtZV9ucyAqbnMsDQo+PiArICAgICAgICAgICAgIHN0cnVjdCByZXF1ZXN0ICpy
ZXEsIHN0cnVjdCBudm1lX2NvbW1hbmQgKmNtbmQpDQo+PiArew0KPiANCj4gRHVlIHRvIHJlY2Vu
dCBkcml2ZXIgY2hhbmdlcywgeW91IG5lZWQgYSAibWVtc2V0KGNtbmQsIDAsIHNpemVvZigqY21u
ZCkpIg0KPiBwcmlvciB0byBzZXR0aW5nIHVwIHRoZSByZXN0IG9mIHRoZSBjb21tYW5kLCBvciB5
b3UgbmVlZCB0byBzZXQgZWFjaA0KPiBjb21tYW5kIGR3b3JkIGluZGl2aWR1YWxseS4NCg0KQWdy
ZWUsIHdpbGwgZml4IHRoYXQgaW4gVjEuDQoNCj4gDQo+PiArICAgICBjbW5kLT52ZXJpZnkub3Bj
b2RlID0gbnZtZV9jbWRfdmVyaWZ5Ow0KPj4gKyAgICAgY21uZC0+dmVyaWZ5Lm5zaWQgPSBjcHVf
dG9fbGUzMihucy0+aGVhZC0+bnNfaWQpOw0KPj4gKyAgICAgY21uZC0+dmVyaWZ5LnNsYmEgPQ0K
Pj4gKyAgICAgICAgICAgICBjcHVfdG9fbGU2NChudm1lX3NlY3RfdG9fbGJhKG5zLCBibGtfcnFf
cG9zKHJlcSkpKTsNCj4+ICsgICAgIGNtbmQtPnZlcmlmeS5sZW5ndGggPQ0KPj4gKyAgICAgICAg
ICAgICBjcHVfdG9fbGUxNigoYmxrX3JxX2J5dGVzKHJlcSkgPj4gbnMtPmxiYV9zaGlmdCkgLSAx
KTsNCj4+ICsgICAgIGNtbmQtPnZlcmlmeS5jb250cm9sID0gMDsNCj4+ICsgICAgIHJldHVybiBC
TEtfU1RTX09LOw0KPj4gK30NCj4gDQo+PiArc3RhdGljIHZvaWQgbnZtZV9jb25maWdfdmVyaWZ5
KHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzdHJ1Y3QgbnZtZV9ucyAqbnMpDQo+PiArew0KPj4gKyAg
ICAgdTY0IG1heF9ibG9ja3M7DQo+PiArDQo+PiArICAgICBpZiAoIShucy0+Y3RybC0+b25jcyAm
IE5WTUVfQ1RSTF9PTkNTX1ZFUklGWSkpDQo+PiArICAgICAgICAgICAgIHJldHVybjsNCj4+ICsN
Cj4+ICsgICAgIGlmIChucy0+Y3RybC0+bWF4X2h3X3NlY3RvcnMgPT0gVUlOVF9NQVgpDQo+PiAr
ICAgICAgICAgICAgIG1heF9ibG9ja3MgPSAodTY0KVVTSFJUX01BWCArIDE7DQo+PiArICAgICBl
bHNlDQo+PiArICAgICAgICAgICAgIG1heF9ibG9ja3MgPSBucy0+Y3RybC0+bWF4X2h3X3NlY3Rv
cnMgKyAxOw0KPiANCj4gSWYgc3VwcG9ydGVkIGJ5IHRoZSBjb250cm9sbGVyLCB0aGlzIG1heGlt
dW0gaXMgZGVmaW5lZCBpbiB0aGUgbm9uLW1kdHMNCj4gY29tbWFuZCBsaW1pdHMgaW4gTlZNIGNv
bW1hbmQgc2V0IHNwZWNpZmljIElkZW50aWZ5IENvbnRyb2xsZXIgVlNMIGZpZWxkLg0KPiANCg0K
SSBuZWVkIHRha2UgYSBjbG9zZXIgbG9vayBhdCB0aGlzLiBJJ2xsIGZpeCB0aGF0IGluIFYxLg0K
DQo+PiArDQo+PiArICAgICAvKiBrZWVwIHNhbWUgYXMgZGlzY2FyZCAqLw0KPj4gKyAgICAgaWYg
KGJsa19xdWV1ZV9mbGFnX3Rlc3RfYW5kX3NldChRVUVVRV9GTEFHX1ZFUklGWSwgZGlzay0+cXVl
dWUpKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm47DQo+PiArDQo+PiArICAgICBibGtfcXVldWVf
bWF4X3ZlcmlmeV9zZWN0b3JzKGRpc2stPnF1ZXVlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBudm1lX2xiYV90b19zZWN0KG5zLCBtYXhfYmxvY2tzKSk7DQo+PiArDQo+
PiArfQ0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50IEtlaXRoLg0KDQoNCg==
