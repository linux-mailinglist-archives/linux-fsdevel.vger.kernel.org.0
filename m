Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AA4820BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhL3WzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 17:55:19 -0500
Received: from mail-co1nam11on2091.outbound.protection.outlook.com ([40.107.220.91]:39328
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237492AbhL3WzS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:55:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHeaNc/xnNzik0FdYoCj5pdiTjsv6PaIYldVe6QFd7PMcyyKiI0Cm8yE9tkPX5mQUivEHzXjsJO0+cem4KKQ+ILaBy0RXyM7XCYgykimkehKvnY5fjY7k8qyLHw69OafakrXQre0p2cI90IpTD0fW5MJPjKprEyH3RaNuOUQjv8Gi7P8TVbwCpt46FZ3czHz5IOtgwlFl0JKv+wffAJ0hRV6NLodbW2hnUCn55+NfAZehe3IplIk8Rx6Nvj2Hdo5ShJFrxZBKjQzADZM1nzGj+7J4pAj4eb+HGvyoH3OdP6GwrXV6rlHD2STL2TUTBnoT325+ywKKJF4nWyWwtiXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hl/iFgPnXQ7T8IFrxDkbzoEwtA3Ziq9y/9mcA9L0jI=;
 b=cSfqoN/jr+7AnXZY7GNuprbgefZAx/YulwSubqT6BGQDvwseP6bMf4MsKiyfggubMngzZ5x4R+hgA9ChUrKDFUET/Vfa0lvts9D7B/tQNg/RzThxn+At4gS4XOzReg+6x9zi470v53O2LZe+nSlOQ1Rt+Q8qXYruwPWZE6fd9KMe50yiGz6VLNoOYfo6pWouHPfc/43icfToDSOqwCeqN6kaxN6J3F62aDe366sVVHCPi+2eRbYGbQp8VHypRSFOy32SRZZ2nXyGoxJia/y+cpNhgZiac3VcBusC/QyKEpnpjC/y3KYbb31GFndGaBPXxCePGOSg+4JDWbBjpChfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hl/iFgPnXQ7T8IFrxDkbzoEwtA3Ziq9y/9mcA9L0jI=;
 b=Rdz53sLu8fcFEGG0ARnDlG5nmAvSDRgWcbMegTVGpayKkfib5sUClPDl2SMuBxY8Uu/vwXe83Qe/u443GFmOuQ+bcQ3Lis6yWqIKOmFzLuQMimpy+S+ANr0DwXaJBWuwralqqNlaxM+McR3Tuw2cTRK7AaQh4kDSaizulWCR1G4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1497.namprd13.prod.outlook.com (2603:10b6:3:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4; Thu, 30 Dec
 2021 22:55:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 22:55:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xLi/aAgAAQ2YCAAACagIAAB8YA
Date:   Thu, 30 Dec 2021 22:55:13 +0000
Message-ID: <1454ac97baf146cf1796af6bb79691cce4f8cf19.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <05bac8cb-e36a-b043-5ac3-82c585f76bbe@kernel.dk>
         <a42acb06152b0ecba3e99aec38349e1f29304b1e.camel@hammerspace.com>
         <1801967a-e538-3edf-4af6-2336e2fcb4a2@kernel.dk>
In-Reply-To: <1801967a-e538-3edf-4af6-2336e2fcb4a2@kernel.dk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 062a11b9-6467-48f9-6e6b-08d9cbe770d5
x-ms-traffictypediagnostic: DM5PR13MB1497:EE_
x-microsoft-antispam-prvs: <DM5PR13MB14976EF6516C8850C42C12E3B8459@DM5PR13MB1497.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlsqaffbE+aMYfkkGHyt92eW/PMw8FTwvID9kMX9n+Vlz9X9e3E29XuFX9w7N6RlRUFDQWpIJPQN8JQ5eDAIdC0yjHWs+a3PrpwbcLWxF5H8iWKLe2QK/ynEzT8oBVifoX9x4V7vZdO5J1xCyDX5CXEoUiuGDTfhO/9vOE5icrlorCruVYSfBA7TSNzV8IZ9eEiKJmCXlhJyCRnQvhEsLp7kdk+SGFBpkTl5+BbGa8TjvTXYhRcib/gcLsmnOZwcxS5D+6bGJQE5EvvSnFHxy3JKrxLq2fYW9Gda5pdOBcS/xr84EnGy2KSqFbyfl3F9mQOzqY9gbWMI78CLIS6k2x4k2uWgJRLzJaUpWfSWPO+r7mUxywa5y4puvQRRWXMJ4RVttu+8jMxT2pMFswMxuGMgebPd9Dvg9BvrFspPoI3uknnf4moi1FfpMq0NVucx+1ortMQZSo3y4m5RDlofE0rM1QeUGpiNh70Z+uA2iE98VX4u09z8etcIR+hMna2g6mJ1hhl6atVFou+JghyeRGyM8c47vpuoo/SplNhcIjI4uqRvkcwCPidIT1Nz4j+hixwfRh8Giq4Ufun1jxT4VhOqShn8q4eCouLbQHpF3yU1LOe92zkQx4IrnPzO7tRsNczOu548uk6EbSHfns/qAhprpN79z4D0tiu1AcXp8WnmvRUdLMSfCkfV2NQbCbIspUJh7Hdmd9ZE1rsmAfOZ2r1Mf0cXHAF8ZG+WMeLIGcYrMQ0noqRsE6jHGKpsKCmL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(396003)(376002)(136003)(346002)(8936002)(122000001)(8676002)(2616005)(86362001)(5660300002)(71200400001)(186003)(26005)(38100700002)(66946007)(64756008)(66556008)(2906002)(45080400002)(66476007)(66446008)(4326008)(53546011)(6506007)(4001150100001)(6486002)(76116006)(38070700005)(316002)(6512007)(54906003)(36756003)(110136005)(83380400001)(508600001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWpHVDNhdTZhOGRvMU1tQkNCYU53TzlXQkdYZHY0ajVvQ1VzRkMyeTZWRGRF?=
 =?utf-8?B?MnFqNGtrK2dFNnBtc1A1NXYrMkFCQm5hV3QwT0lpU3ZzcEUwcWF0RnArTmEw?=
 =?utf-8?B?TjVKYnJIbnVyWk84VlVnVjNubkYzUTBXTVlpOFZjbzRwWjFxNmNxaThkRWRY?=
 =?utf-8?B?amZFd214MTlhRWRGamNTZ2FrSVZqbWgySmp0a0ZIT1NOeU9iNFl3aFhBeC9U?=
 =?utf-8?B?dmRrbyttK2FRbE1NRHNMc3ZIdUVUT3NERUFrbUprOUhoRy9ZVFB2bWg3eFF5?=
 =?utf-8?B?L2VwV3VzY29ueWY3U2xXcjJJdVRlbklod1lzNDdPTXI0QjBXMlZOREpqUTZG?=
 =?utf-8?B?NjUxZDFvQnpidnNMcHlDV1ZoZk54Zzl2UnZhMU1yRW9yeDR4WVlkeUp0OWlZ?=
 =?utf-8?B?MlhKR1Nhby83ZnY2b09mcVZlQjRDeTlJZGNsMm9tMm1LWkpUbVNmY3F5SmJI?=
 =?utf-8?B?dDVBWm1oako3WlRpcmVubzJwemNrWmxFWW5vbmtCRDNoZnNJVEdxUzd2S2V2?=
 =?utf-8?B?SXVBalJ4aUZ4UGlaY3VQc2NiT2xiV2VEOXR5SG1hR1VVcG11SXEySTg0amlO?=
 =?utf-8?B?cC9ITmtSWi9RcnQwWVRhQVd1dDlna3FaSFBlckQrQS95WFBmU1VERjF5M1Qy?=
 =?utf-8?B?Z1krNnZMUjR2d2VwQjVrT0hMQzhURVc0eHpDcTZnNXBlL21BcHlWVlZWa0Mx?=
 =?utf-8?B?cmxSc2JRVDNEemN6Qm1IdnBxVHpUek1xZTFaa2Fibkh1UmZncHZvV2IrNGI0?=
 =?utf-8?B?TExsdkUvN01YSTJOcG5LUGQyUFd4R3U0cHNnTFhxU1p6MVhSUmtzeTBmOWxk?=
 =?utf-8?B?VFhjRnRkNWI2d0txektrTDhTY3B4djJ5M1hBeHRGVzUwUHVJYzdQdFQ3eTA4?=
 =?utf-8?B?QkRLNkFtMHVZNjh2bjBjRVV6UW50VG5oaDlKMVFWS0pQOURFQTlncW1PNy9T?=
 =?utf-8?B?MittMVlvTXAzTWRkOFdwcUcvS1RJTFI3ZW12RXdtbXQvRllISmtwSWduc01y?=
 =?utf-8?B?Mi9lN0JrOHpyTlkzYTZTU2tiV3p5d0Zra2V2WnlVSU5jVEZzZmVGdUR5OGtj?=
 =?utf-8?B?RElkMEM0ZTMya2hjVWlCTkFmZGM0YTYrbjJ3VmdxTVZpcDdpTEJ1MVc2RVI3?=
 =?utf-8?B?RVRxcng5SFRKbi8yWll2bERKTUJhSFU5SGd5NjJHYUxGN2E4ZjE3czMxVzFX?=
 =?utf-8?B?bjBqMUVXVk1CMXp2dVJTUjBWSExud2VnMnRFcFMrUE1STHZ5dVloMkFsby9u?=
 =?utf-8?B?QTV2TFM0MXlhNTFMcUl3dnpBVERXYm5HcWdyOGhXWHdNMkJYVDVVdFEwYjlM?=
 =?utf-8?B?Mk9tZWd0YmgyMU1oS3BxY1FWWkhNcGlxQnZDZGNWc3JtM1NOQTdtYlFVUytL?=
 =?utf-8?B?aTFOMW1BN2N3RWNzVUJMVlB4d3pXYjVFSVJNWVNhM3hHL1lPK1FnSmE4ZVBL?=
 =?utf-8?B?aVZZd2tQQVZQa0p0dm91VENPa25POFpDQ3lBQlNxdEx1SE5DUFNVNE9mbVFB?=
 =?utf-8?B?M29URC8yVkZJYlRlRjBXSFlweWhtaFFZeU56ZU1uY1F2VldISUlJdzNxQ0ZU?=
 =?utf-8?B?TjNtZ2hQcmxHVWxtajVLcVlLcUpPUkY2SnpzdXUrbXdsUmFJVi9UODhaRGxZ?=
 =?utf-8?B?S2dWMWhTZlpkanVOZDQ3ekVIRzlZRGlaMTNvNlhoMkxYVUNPSjN4dWRlcUF0?=
 =?utf-8?B?S3p3aENNdnBUY2luQVN2Wkdjb1c0ZDRtRUdhSzRxTzlzM05abDJaeXcrUlBO?=
 =?utf-8?B?RTNLNnRia1hNakpMSy9FQ08vYmJvak16TmgzNzJpWlgvcEVJQ3RqeGxZcFZK?=
 =?utf-8?B?M0NjUXVndDZKV1NmQVJ3RVVTd0ZoN3ZTSzZERVljQW15L0ZSUEsyWUtraW5M?=
 =?utf-8?B?VDRnU0dyZktXRlJGREJmcTExdGVOMnBnNTNhUTVUaGY5cnZndXJPSEV4SUFr?=
 =?utf-8?B?VDRLdjBvTHZ3M1hTbE1FTk9CWDFRNnRYaEk2alkrTFNRQnczYmpkWlE5RU1H?=
 =?utf-8?B?aVpSSXRYWTVUMyt1NnEvdnFYazVPNVowVmxJNlV0clY2VmVFMVlXQWFHU0lD?=
 =?utf-8?B?Q0FmUTBaOVRBRWNRVldJSVI4NnFRUmdZaGlzTUR5U3QrTkFhOHB5eDZ5c0Ez?=
 =?utf-8?B?SmR0TXBNek1yUnNmNFczVTZsc2F6ZnFtRjY0ZTZVaGNTd0gyMEg4UlBMMzlx?=
 =?utf-8?Q?nqW7c52ZjQblojI4B9x6Xck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9931E97CA6AFEB4B9961A00CC00AA42C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062a11b9-6467-48f9-6e6b-08d9cbe770d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 22:55:13.9539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0an0OiLXMJHibMYgcJ+YT9TZ/SzIjahcw4O6jL8wI/mrexv4SCLmWHcBQ6eYxI6Ixv7XEWgJ4SRRV1vRF/MFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1497
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIxLTEyLTMwIGF0IDE0OjI3IC0wODAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxMi8zMC8yMSAyOjI1IFBNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gT24gVGh1LCAy
MDIxLTEyLTMwIGF0IDEzOjI0IC0wODAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiA+ID4gT24gMTIv
MzAvMjEgMTE6MzUgQU0sIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+IEZyb206
IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+
ID4gDQo+ID4gPiA+IFdlJ3JlIG9ic2VydmluZyB0aGUgZm9sbG93aW5nIHN0YWNrIHRyYWNlIHVz
aW5nIHZhcmlvdXMga2VybmVscw0KPiA+ID4gPiB3aGVuDQo+ID4gPiA+IHJ1bm5pbmcgaW4gdGhl
IEF6dXJlIGNsb3VkLg0KPiA+ID4gPiANCj4gPiA+ID4gwqB3YXRjaGRvZzogQlVHOiBzb2Z0IGxv
Y2t1cCAtIENQVSMxMiBzdHVjayBmb3IgMjNzIQ0KPiA+ID4gPiBba3dvcmtlci8xMjoxOjMxMDZd
DQo+ID4gPiA+IMKgTW9kdWxlcyBsaW5rZWQgaW46IHJhaWQwIGlwdF9NQVNRVUVSQURFIG5mX2Nv
bm50cmFja19uZXRsaW5rDQo+ID4gPiA+IHh0X2FkZHJ0eXBlIG5mdF9jaGFpbl9uYXQgbmZfbmF0
IGJyX25ldGZpbHRlciBicmlkZ2Ugc3RwIGxsYw0KPiA+ID4gPiBleHQ0DQo+ID4gPiA+IG1iY2Fj
aGUgamJkMiBvdmVybGF5IHh0X2Nvbm50cmFjayBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYN
Cj4gPiA+ID4gbmZfZGVmcmFnX2lwdjQgbmZ0X2NvdW50ZXIgcnBjcmRtYSByZG1hX3VjbSB4dF9v
d25lciBpYl9zcnB0DQo+ID4gPiA+IG5mdF9jb21wYXQgaW50ZWxfcmFwbF9tc3IgaWJfaXNlcnQg
aW50ZWxfcmFwbF9jb21tb24gbmZfdGFibGVzDQo+ID4gPiA+IGlzY3NpX3RhcmdldF9tb2QgaXNz
dF9pZl9tYm94X21zciBpc3N0X2lmX2NvbW1vbiBuZm5ldGxpbmsNCj4gPiA+ID4gdGFyZ2V0X2Nv
cmVfbW9kIG5maXQgaWJfaXNlciBsaWJudmRpbW0gbGliaXNjc2kNCj4gPiA+ID4gc2NzaV90cmFu
c3BvcnRfaXNjc2kgaWJfdW1hZCBrdm1faW50ZWwgaWJfaXBvaWIgcmRtYV9jbSBpd19jbQ0KPiA+
ID4gPiB2ZmF0DQo+ID4gPiA+IGliX2NtIGZhdCBrdm0gaXJxYnlwYXNzIGNyY3QxMGRpZl9wY2xt
dWwgY3JjMzJfcGNsbXVsIG1seDVfaWINCj4gPiA+ID4gZ2hhc2hfY2xtdWxuaV9pbnRlbCByYXBs
IGliX3V2ZXJicyBpYl9jb3JlIGkyY19waWl4NCBwY3Nwa3INCj4gPiA+ID4gaHlwZXJ2X2ZiIGh2
X2JhbGxvb24gaHZfdXRpbHMgam95ZGV2IG5mc2QgYXV0aF9ycGNnc3MgbmZzX2FjbA0KPiA+ID4g
PiBsb2NrZA0KPiA+ID4gPiBncmFjZSBzdW5ycGMgaXBfdGFibGVzIHhmcyBsaWJjcmMzMmMgbWx4
NV9jb3JlIG1seGZ3IHRscw0KPiA+ID4gPiBwY2lfaHlwZXJ2DQo+ID4gPiA+IHBjaV9oeXBlcnZf
aW50ZiBzZF9tb2QgdDEwX3BpIHNnIGF0YV9nZW5lcmljIGh2X3N0b3J2c2MNCj4gPiA+ID4gaHZf
bmV0dnNjDQo+ID4gPiA+IHNjc2lfdHJhbnNwb3J0X2ZjIGh5cGVydl9rZXlib2FyZCBoaWRfaHlw
ZXJ2IGF0YV9waWl4IGxpYmF0YQ0KPiA+ID4gPiBjcmMzMmNfaW50ZWwgaHZfdm1idXMgc2VyaW9f
cmF3IGZ1c2UNCj4gPiA+ID4gwqBDUFU6IDEyIFBJRDogMzEwNiBDb21tOiBrd29ya2VyLzEyOjEg
Tm90IHRhaW50ZWQgNC4xOC4wLQ0KPiA+ID4gPiAzMDUuMTAuMi5lbDhfNC54ODZfNjQgIzENCj4g
PiA+ID4gwqBIYXJkd2FyZSBuYW1lOiBNaWNyb3NvZnQgQ29ycG9yYXRpb24gVmlydHVhbCBNYWNo
aW5lL1ZpcnR1YWwNCj4gPiA+ID4gTWFjaGluZSwgQklPUyAwOTAwMDjCoCAxMi8wNy8yMDE4DQo+
ID4gPiA+IMKgV29ya3F1ZXVlOiB4ZnMtY29udi9tZDEyNyB4ZnNfZW5kX2lvIFt4ZnNdDQo+ID4g
PiA+IMKgUklQOiAwMDEwOl9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDExLzB4MjANCj4g
PiA+ID4gwqBDb2RlOiA3YyBmZiA0OCAyOSBlOCA0YyAzOSBlMCA3NiBjZiA4MCAwYiAwOCBlYiA4
YyA5MCA5MCA5MCA5MA0KPiA+ID4gPiA5MA0KPiA+ID4gPiA5MCA5MCA5MCA5MCA5MCAwZiAxZiA0
NCAwMCAwMCBlOCBlNiBkYiA3ZSBmZiA2NiA5MCA0OCA4OSBmNyA1Nw0KPiA+ID4gPiA5ZA0KPiA+
ID4gPiA8MGY+IDFmIDQ0IDAwIDAwIGMzIDY2IDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFm
IDQ0IDAwIDAwDQo+ID4gPiA+IDhiIDA3DQo+ID4gPiA+IMKgUlNQOiAwMDE4OmZmZmZhYzUxZDI2
ZGZkMTggRUZMQUdTOiAwMDAwMDIwMiBPUklHX1JBWDoNCj4gPiA+ID4gZmZmZmZmZmZmZmZmZmYx
Mg0KPiA+ID4gPiDCoFJBWDogMDAwMDAwMDAwMDAwMDAwMSBSQlg6IGZmZmZmZmZmOTgwMDg1YTAg
UkNYOg0KPiA+ID4gPiBkZWFkMDAwMDAwMDAwMjAwDQo+ID4gPiA+IMKgUkRYOiBmZmZmYWM1MWQz
ODkzYzQwIFJTSTogMDAwMDAwMDAwMDAwMDIwMiBSREk6DQo+ID4gPiA+IDAwMDAwMDAwMDAwMDAy
MDINCj4gPiA+ID4gwqBSQlA6IDAwMDAwMDAwMDAwMDAyMDIgUjA4OiBmZmZmYWM1MWQzODkzYzQw
IFIwOToNCj4gPiA+ID4gMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiDCoFIxMDogMDAwMDAwMDAw
MDAwMDBiOSBSMTE6IDAwMDAwMDAwMDAwMDA0YjMgUjEyOg0KPiA+ID4gPiAwMDAwMDAwMDAwMDAw
YTIwDQo+ID4gPiA+IMKgUjEzOiBmZmZmZDIyOGYzZTVhMjAwIFIxNDogZmZmZjk2M2NmN2Y1OGQx
MCBSMTU6DQo+ID4gPiA+IGZmZmZkMjI4ZjNlNWEyMDANCj4gPiA+ID4gwqBGUzrCoCAwMDAwMDAw
MDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5NjI1YmZiMDAwMDAoMDAwMCkNCj4gPiA+ID4ga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiDCoENTOsKgIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAg
Q1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+ID4gPiA+IMKgQ1IyOiAwMDAwN2Y1MDM1NDg3NTAwIENS
MzogMDAwMDAwMDQzMjgxMDAwNCBDUjQ6DQo+ID4gPiA+IDAwMDAwMDAwMDAzNzA2ZTANCj4gPiA+
ID4gwqBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjoNCj4g
PiA+ID4gMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiDCoERSMzogMDAwMDAwMDAwMDAwMDAwMCBE
UjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3Og0KPiA+ID4gPiAwMDAwMDAwMDAwMDAwNDAwDQo+ID4g
PiA+IMKgQ2FsbCBUcmFjZToNCj4gPiA+ID4gwqAgd2FrZV91cF9wYWdlX2JpdCsweDhhLzB4MTEw
DQo+ID4gPiA+IMKgIGlvbWFwX2ZpbmlzaF9pb2VuZCsweGQ3LzB4MWMwDQo+ID4gPiA+IMKgIGlv
bWFwX2ZpbmlzaF9pb2VuZHMrMHg3Zi8weGIwDQo+ID4gPiA+IMKgIHhmc19lbmRfaW9lbmQrMHg2
Yi8weDEwMCBbeGZzXQ0KPiA+ID4gPiDCoCA/IHhmc19zZXRmaWxlc2l6ZV9pb2VuZCsweDYwLzB4
NjAgW3hmc10NCj4gPiA+ID4gwqAgeGZzX2VuZF9pbysweGI5LzB4ZTAgW3hmc10NCj4gPiA+ID4g
wqAgcHJvY2Vzc19vbmVfd29yaysweDFhNy8weDM2MA0KPiA+ID4gPiDCoCB3b3JrZXJfdGhyZWFk
KzB4MWZhLzB4MzkwDQo+ID4gPiA+IMKgID8gY3JlYXRlX3dvcmtlcisweDFhMC8weDFhMA0KPiA+
ID4gPiDCoCBrdGhyZWFkKzB4MTE2LzB4MTMwDQo+ID4gPiA+IMKgID8ga3RocmVhZF9mbHVzaF93
b3JrX2ZuKzB4MTAvMHgxMA0KPiA+ID4gPiDCoCByZXRfZnJvbV9mb3JrKzB4MzUvMHg0MA0KPiA+
ID4gPiANCj4gPiA+ID4gSmVucyBzdWdnZXN0ZWQgYWRkaW5nIGEgbGF0ZW5jeS1yZWR1Y2luZyBj
b25kX3Jlc2NoZWQoKSB0byB0aGUNCj4gPiA+ID4gbG9vcA0KPiA+ID4gPiBpbg0KPiA+ID4gPiBp
b21hcF9maW5pc2hfaW9lbmRzKCkuDQo+ID4gPiANCj4gPiA+IFRoZSBwYXRjaCBkb2Vzbid0IGFk
ZCBpdCB0aGVyZSB0aG91Z2gsIEkgd2FzIHN1Z2dlc3Rpbmc6DQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9mcy9pb21hcC9idWZmZXJlZC1pby5jIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYw0K
PiA+ID4gaW5kZXggNzFhMzZhZTEyMGVlLi40YWQyNDM2YTkzNmEgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9mcy9pb21hcC9idWZmZXJlZC1pby5jDQo+ID4gPiArKysgYi9mcy9pb21hcC9idWZmZXJlZC1p
by5jDQo+ID4gPiBAQCAtMTA3OCw2ICsxMDc4LDcgQEAgaW9tYXBfZmluaXNoX2lvZW5kcyhzdHJ1
Y3QgaW9tYXBfaW9lbmQNCj4gPiA+ICppb2VuZCwNCj4gPiA+IGludCBlcnJvcikNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb2VuZCA9IGxpc3RfZmlyc3RfZW50cnkoJnRt
cCwgc3RydWN0DQo+ID4gPiBpb21hcF9pb2VuZCwNCj4gPiA+IGlvX2xpc3QpOw0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsX2luaXQoJmlvZW5kLT5pb19saXN0
KTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21hcF9maW5pc2hfaW9l
bmQoaW9lbmQsIGVycm9yKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bmRfcmVzY2hlZCgpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gwqB9DQo+ID4gPiDC
oEVYUE9SVF9TWU1CT0xfR1BMKGlvbWFwX2ZpbmlzaF9pb2VuZHMpOw0KPiA+ID4gDQo+ID4gPiBh
cyBJIGRvbid0IHRoaW5rIHlvdSBuZWVkIGl0IG9uY2UtcGVyLXZlYy4gQnV0IG5vdCBzdXJlIGlm
IHlvdQ0KPiA+ID4gdGVzdGVkDQo+ID4gPiB0aGF0IHZhcmlhbnQgb3Igbm90Li4uDQo+ID4gPiAN
Cj4gPiANCj4gPiBZZXMsIHdlIGRpZCB0ZXN0IHRoYXQgdmFyaWFudCwgYnV0IHdlcmUgc3RpbGwg
c2VlaW5nIHRoZSBzb2Z0DQo+ID4gbG9ja3Vwcw0KPiA+IG9uIEF6dXJlLCBoZW5jZSB3aHkgSSBt
b3ZlZCBpdCBpbnRvIHRoZSBpbm5lciBsb29wLg0KPiANCj4gR290Y2hhIC0gYnV0IG1heWJlIGp1
c3Qgb3V0c2lkZSB0aGUgdmVjIGxvb3AgdGhlbiwgYWZ0ZXIgdGhlDQo+IGJpb19wdXQoKT8NCj4g
T25jZSBwZXIgdmVjIHNlZW1zIGV4Y2Vzc2l2ZSwgZWFjaCB2ZWMgc2hvdWxkbid0IHRha2UgbG9u
ZywgYnV0IEkNCj4gZ3Vlc3MNCj4gdGhlIGlvZW5kIGlubGluZXMgY2FuIGJlIGxvbmc/DQo+IA0K
DQpUaGUgc3RhY2sgdHJhY2UgaXMgYWx3YXlzIHRoZSBzYW1lLCBhbmQgaXMgdHJpZ2dlcmluZyB3
aGVuIHJlbGVhc2luZw0KdGhlIHNwaW4gbG9jayBpbiB3YWtlX3VwX3BhZ2VfYml0KCkgaW4gdGhh
dCBpbm5lciBsb29wLiBJIGNhbiB0cnkNCm1vdmluZyB0aGUgY29uZF9yZXNjaGVkKCkgdG8gdGhh
dCBtaWRkbGUgbG9vcCBvdmVyIHRoZSBiaW9zIGFuZA0KcmV0ZXN0aW5nLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
