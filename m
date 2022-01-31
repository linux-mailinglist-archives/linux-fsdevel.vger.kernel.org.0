Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74504A4F40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359324AbiAaTOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 14:14:14 -0500
Received: from mail-dm3nam07on2125.outbound.protection.outlook.com ([40.107.95.125]:24166
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230501AbiAaTOI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:14:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaLl2WRFAYNlzvxHHjJf2IQeTDYdv96GYXy15gp/MBQf3t+Z6ZRKewYIrVYlwQDO9DS5813DTi5mNjxkENhvy28s0jDRc/XrLbgFseFhaMDmYb/7UKNUlMSbJlLJE3t9Pv1ZldQ9XmwAF481bBofEQyDcCVDNxmcD4fnF1uXhdgnISGAd+EZOSkykxhA/s1A3+WleUKOZ6nuU4u81Kv0WeGBA+Ln9t66SxX74rOLbH8ttln3yu0ry8C9Xqm0QcJe9vpiQOmGlvm/wE7tzDgfYy2xSE+VuMlz8VpMd6Er55rtvX490/rEi56NMBVgMssSp7CXgJ+wd63s0LFtZwz2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDXrRySr+OQgLQgTXTv9aki7zex/F72XqKVTa9VGvrI=;
 b=XPBmDGHOA0oqL9gjuuRZxrfZx4cvcENyxkO1qOFvXfZdLYDNynZe8RqaqsNnrZJv2VEwMX43UrEhr+8QqpCnsz9T7gUiXkAEAfwxmHmFGm+97WWQCcJkQryJNUZsX3hJXXSRdjasKqVaHa33nSh0D5Gbwlo0Yhy86fEi09TBMTgn9JrK60Lkfjaf1r2HoJUse7sGMeS+2Msjzfwv+93m9rJV5w9PTtckDR2bxzh9gTAN6FfEiSeHXU+tDhOY9gSrTdY0ApNoVijSRHBn5upUs9o+tWFTzlIpkBei7lkqw5N+be/GlelvAJlJoSgHfoUH+/YAyyYPcbaGHEPpgwHShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDXrRySr+OQgLQgTXTv9aki7zex/F72XqKVTa9VGvrI=;
 b=ciUfHcVed0NDy3/7BALaRRXttW+9hISumz/q9yql1bRgexFSY1ZNznitihwgd5Qxz+KMIcVLmzX/Gn4/KNYoSxhQE25CWFuS6M6XLI9lyIy4gDU/FDAKzYJfxabaNKNIBXI2NybYd1XuFhOir7JmA+f6B8JMQz6rzpvIlAYqfd8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB0997.namprd13.prod.outlook.com (2603:10b6:903:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 31 Jan
 2022 19:14:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%6]) with mapi id 15.20.4951.011; Mon, 31 Jan 2022
 19:14:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
Thread-Topic: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of
 large file sizes
Thread-Index: AQHYFs/ypcuQk9gPT06tiQmZ/LtqSax9da4AgAACkYCAAATJAIAAAsCA
Date:   Mon, 31 Jan 2022 19:14:03 +0000
Message-ID: <7b5a925466bbb5a9273e3458480d9880af1073e0.camel@hammerspace.com>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
         <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
         <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
         <0448eb0e136da9e8e24880411644f5fcb816e833.camel@hammerspace.com>
         <7B55FD48-0E59-4D9D-A06C-B8312BAEDC45@oracle.com>
In-Reply-To: <7B55FD48-0E59-4D9D-A06C-B8312BAEDC45@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb3e7479-807b-4763-1177-08d9e4edd849
x-ms-traffictypediagnostic: CY4PR13MB0997:EE_
x-microsoft-antispam-prvs: <CY4PR13MB0997F3935FABC2702D4D5A7DB8259@CY4PR13MB0997.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZXin5V3ZSEmUPk00zJXMVTEDkh6E3NbYsiK1zvfg7Yyjk3cjLYNuOXgsVaamBmAifIaw1Lc8+7nfxFHYeEoRtfbLgbA4tbGxkmZIUN9Qis6dElZ6Uhmll6w4Bwhqn898jJvtG1hLy/tKYFG4ysAaVmBW+UXw+P/6Itb6JBYKu0jQ9jRyDRIqatuilc7rRXK6QKoAw6x56/YKI/DSkaxo+6++1I6nNP3NLz01Enbrg4XL2OlncuY9xTmjRT5Ly48JvOeIWqoOtRGDiucnh0EWDC/n7oTaF7m8jCfKOGLlt5BWstxOxbb2loRu3ICLlRAXZ7uXn8weZIKM+U5UrR0CIHdvA17twiRHA9I0Cf+Ti0MW9lRffoSL0pCflH2jBZfqenbgPY+Lr8A808Xm3xDN4KHNJoe576m8NpF5Cyo7dUYJIORtguYXqlj6jwD2ql9HjGpX/JZbyt6V0wQU9MgiU/HrN0cc3yIvzo6EEOdGxL/lV+KMbvhPqaRkvCP/WcixxVIDJDVngcE+UCUgmBWlDMVYj62heryFinEWU9F16lTOYohygL/h1C/ZVJh+6r8C3nGNOpnNftw7bfnlVMgjrQcry+DvhKO5e6a+gmYf/RfWAEzYX4LvBaWfWwCR37jfb1sQ0vLd3mHB73IN2kF8eoMJMvcNAuVmNfzvlXVhAJ4zquRuwT4aeNTDU6P4fclIK8MTBUZgdjfcWj/TA5f3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(136003)(396003)(39840400004)(366004)(64756008)(6506007)(8676002)(76116006)(66946007)(4326008)(8936002)(66556008)(186003)(26005)(66446008)(66476007)(53546011)(86362001)(71200400001)(508600001)(6486002)(83380400001)(6916009)(6512007)(54906003)(2616005)(316002)(38100700002)(36756003)(2906002)(122000001)(5660300002)(38070700005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUVZQlIxQnRTb3pMZ2d4eGFHVFJUVEk5SW9Ed09lZ0xNWVJTTUNabXF6TnVJ?=
 =?utf-8?B?Y0U5RFlYM3ppbXJNUkx5SFo4VXJKbmdUSkMrbXM1VEExaEp4KzhmTTlHcllQ?=
 =?utf-8?B?R0txdzBCSUZUbjFzVGRJcjhhdzB3dDZqcDJWbStYRHcrNjhtNkxjckhvUkVP?=
 =?utf-8?B?cnVabU9YS0NsWm5oTGhYMUYyYVUxMmh3SGlLWWRUREIySUVHcVZmVkhadVZj?=
 =?utf-8?B?RWo1UmRrbU9MWWFPeXk5bUxnd2kzVkVNeDlpLzRxenhxZ3BFMGowczl2MXZE?=
 =?utf-8?B?ZU93UkRNMXQzS3REV0FQVzdkZW9ITWpXRHR4ZDZ5YlBrLzJhODV0d0ZaSS9R?=
 =?utf-8?B?WFc2NFNzTEgvV3QzVEtHNmhXMGRYVGRCOTFFeWRvSDZZRXc1eTlzMmVmaExy?=
 =?utf-8?B?dCtIYmFCeHpEeHJWOUFmMCtua0xpNXl4OVIwSlhCU280Q3dEaUpEaWN0ZEEz?=
 =?utf-8?B?bTJ3QWU0TFlrS2owQnFteEFuckNjNXBIT1hsMlBmSCtrQXhoRzVsNVI1NFhP?=
 =?utf-8?B?RU1wUHFDTUpnc2hXc3dKcmxabno5cW1oeUZOR01HdlVoSUxaQ0N1SThPdGRu?=
 =?utf-8?B?QmpLWUwyQWZDdmVyMlA5MEhCdnM2UHdHVDRVaHRWYzdKYlBPdHpGSk9oVWN0?=
 =?utf-8?B?U24vcG8zT3JwSysxNGd3RFhXRk4rQWtVY3Y2bXNJNC9DaTRpcGFTc3lQSVpW?=
 =?utf-8?B?SjV6VXc2NHB1WHJMN25ZVS9WbmxvYTMyQnduSEx5SVBqR0F6bzBFUDJyemtT?=
 =?utf-8?B?YUZ1V3kwMVp1eTA3VlNjaGh1UkROWDg2azlTWkM3Qm1lWXdRRDZGbHhaKzdX?=
 =?utf-8?B?amQ1TVN1TXUzUnlYWTdqRmorVnl5aWxOWVlkaGp3eFlYZXV1VG9udnNrWnRV?=
 =?utf-8?B?WkZocm9uMDRxRmJTYmQ0NzNqZ014TUdmbmZhVTlCMXl2Y1BTdGtoN0NlcmRh?=
 =?utf-8?B?anZHK3AzRmNIR0Y5UzV4WWlHNlpuWHRWSWtpOUNGMVBXNUlwYkVUVlNGbmxv?=
 =?utf-8?B?WU50bnY1K0RnSnZoMkJVQnlYalNVNHM4UTF5U01rc1AzK0sxeUhtVVppczc5?=
 =?utf-8?B?WTZWK0prR3VNR0ZuNi9Sb0NJSXZLOVdZL3ZtUjJaVjRMbEUrYW50RmlQQVZU?=
 =?utf-8?B?U0dxMnpGcVg0ckwyTkdSNE4rTUtaK0xkbUg0OVc2cjBSL0duOWdza0tCNjRD?=
 =?utf-8?B?TjRlOW15eVBnMTdLaW1ud3VYQ0wzcVRxczhkNkcwZEYxcjlBM0c5K3VHSVMy?=
 =?utf-8?B?U09GQnpFQ2lyM3Fwc21ncjM1bGJUQ2EwU0wwUSt0OHFDTWM2ajY0SGx5aEVZ?=
 =?utf-8?B?L25TdDBZeUdZeE0zUlBhLzdrVjBsQll0NmwwdmttckN5TzNwVzJmRlljZUZh?=
 =?utf-8?B?cTJycndxTWxrQW83OHVhOHR1V0xkVHVsRytRTnJ5ajY4TDB4bU1EWGMwOXFY?=
 =?utf-8?B?TGp0dzB3TSs3VGZRYXBhY2I1WlhzWVJyTFhsVC91N25uUmJCVEwyV1NGU3c2?=
 =?utf-8?B?RXNZdC8yQlhhRk9UUG51SkxtcEtNYXY1Q2tQbWxFN1poSTYwRlpXMC9yc20y?=
 =?utf-8?B?RVdxRDMvK2pXN2xDVmR4L0pkWmNBTVJEcmVFU3pXdmlSOS9IWHJHSVZVcXl6?=
 =?utf-8?B?bytnYWhHekFicDNQUE95SFBDVmJYY29wUWFYZ3dMamJXbW9icytiNjJJcHhS?=
 =?utf-8?B?a2VvZDhWTVIyaWN0U1FhK2RSLzNMRW92RldxaWxIalJCdVV5cDhMVHhwTkkx?=
 =?utf-8?B?UmdUU1h0L2tacCthblFVZE9wS21OZlE4ZWJOMWphYXd2ZDJwUmFVVm9HRDJE?=
 =?utf-8?B?bFVRNVpJNkhiQXhmWnNpYTVFcTF4b1ZSWU5QR1Y1djlYSklucFMyR1pZMzZ6?=
 =?utf-8?B?U28vOUhqSFREOStadi9ZMEtWZHN0cmp3WmRwOXFzWElpc1JINmoyaUxZazMz?=
 =?utf-8?B?UTZlNFJaMmNGVkdOVFE4UXlEV1Y3NndzTyswM0I0WnlLTVpOQ3o0NlY4WHM0?=
 =?utf-8?B?RDRzblVKZ2s2ZGFmbTQxdDd4V2V1YjYwd1Y4aTdQbHZUZkNIMEp1eFRJb1dj?=
 =?utf-8?B?NGFaZGIrUDNQODRUTHM5aDlpdmZhY2FRUEFVUSt0ajZNaTN1U1ZGRmM4QW9B?=
 =?utf-8?B?NTBGK2tkMmtiNFRXSVo5eHlwRzdZc3QxcmZpSmRWUVk3clk2NUNBOWJYNWNS?=
 =?utf-8?Q?ZuvMsLUnWCgqup7A9VZDtvY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <570E0501FAB6824F86316BC2EEDE5707@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3e7479-807b-4763-1177-08d9e4edd849
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 19:14:03.5435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZbxJgAZjA0pl9Xj12SELF7bjUoDr99dzTuCZtCtFsxEr4gKvhWf181XFUllCeAOBrhhOjt1EElMLSM4MRmvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB0997
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTMxIGF0IDE5OjA0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKYW4gMzEsIDIwMjIsIGF0IDE6NDcgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9u
LCAyMDIyLTAxLTMxIGF0IDEzOjM3IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4g
PiBPbiBNb24sIDIwMjItMDEtMzEgYXQgMTM6MjQgLTA1MDAsIENodWNrIExldmVyIHdyb3RlOg0K
PiA+ID4gPiBpYXR0cjo6aWFfc2l6ZSBpcyBhIGxvZmZfdCwgc28gdGhlc2UgTkZTdjMgcHJvY2Vk
dXJlcyBtdXN0IGJlDQo+ID4gPiA+IGNhcmVmdWwgdG8gZGVhbCB3aXRoIGluY29taW5nIGNsaWVu
dCBzaXplIHZhbHVlcyB0aGF0IGFyZQ0KPiA+ID4gPiBsYXJnZXINCj4gPiA+ID4gdGhhbiBzNjRf
bWF4IHdpdGhvdXQgY29ycnVwdGluZyB0aGUgdmFsdWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWxl
bnRseSBjYXBwaW5nIHRoZSB2YWx1ZSByZXN1bHRzIGluIHN0b3JpbmcgYSBkaWZmZXJlbnQgdmFs
dWUNCj4gPiA+ID4gdGhhbiB0aGUgY2xpZW50IHBhc3NlZCBpbiB3aGljaCBpcyB1bmV4cGVjdGVk
IGJlaGF2aW9yLCBzbw0KPiA+ID4gPiByZW1vdmUNCj4gPiA+ID4gdGhlIG1pbl90KCkgY2hlY2sg
aW4gZGVjb2RlX3NhdHRyMygpLg0KPiA+ID4gPiANCj4gPiA+ID4gTW9yZW92ZXIsIGEgbGFyZ2Ug
ZmlsZSBzaXplIGlzIG5vdCBhbiBYRFIgZXJyb3IsIHNpbmNlIGFueXRoaW5nDQo+ID4gPiA+IHVw
DQo+ID4gPiA+IHRvIFU2NF9NQVggaXMgcGVybWl0dGVkIGZvciBORlN2MyBmaWxlIHNpemUgdmFs
dWVzLiBTbyBpdCBoYXMNCj4gPiA+ID4gdG8gYmUNCj4gPiA+ID4gZGVhbHQgd2l0aCBpbiBuZnMz
cHJvYy5jLCBub3QgaW4gdGhlIFhEUiBkZWNvZGVyLg0KPiA+ID4gPiANCj4gPiA+ID4gU2l6ZSBj
b21wYXJpc29ucyBsaWtlIGluIGlub2RlX25ld3NpemVfb2sgc2hvdWxkIG5vdyB3b3JrIGFzDQo+
ID4gPiA+IGV4cGVjdGVkIC0tIHRoZSBWRlMgcmV0dXJucyAtRUZCSUcgaWYgdGhlIG5ldyBzaXpl
IGlzIGxhcmdlcg0KPiA+ID4gPiB0aGFuDQo+ID4gPiA+IHRoZSB1bmRlcmx5aW5nIGZpbGVzeXN0
ZW0ncyBzX21heGJ5dGVzLg0KPiA+ID4gPiANCj4gPiA+ID4gSG93ZXZlciwgUkZDIDE4MTMgcGVy
bWl0cyBvbmx5IHRoZSBXUklURSBwcm9jZWR1cmUgdG8gcmV0dXJuDQo+ID4gPiA+IE5GUzNFUlJf
RkJJRy4gRXh0cmEgY2hlY2tzIGFyZSBuZWVkZWQgdG8gcHJldmVudCBORlN2MyBTRVRBVFRSDQo+
ID4gPiA+IGFuZA0KPiA+ID4gPiBDUkVBVEUgZnJvbSByZXR1cm5pbmcgRkJJRy4gVW5mb3J0dW5h
dGVseSBSRkMgMTgxMyBkb2VzIG5vdA0KPiA+ID4gPiBwcm92aWRlDQo+ID4gPiA+IGEgc3BlY2lm
aWMgc3RhdHVzIGNvZGUgZm9yIGVpdGhlciBwcm9jZWR1cmUgdG8gaW5kaWNhdGUgdGhpcw0KPiA+
ID4gPiBzcGVjaWZpYyBmYWlsdXJlLCBzbyBJJ3ZlIGNob3NlbiBORlMzRVJSX0lOVkFMIGZvciBT
RVRBVFRSIGFuZA0KPiA+ID4gPiBORlMzRVJSX0lPIGZvciBDUkVBVEUuDQo+ID4gPiA+IA0KPiA+
ID4gPiBBcHBsaWNhdGlvbnMgYW5kIE5GUyBjbGllbnRzIG1pZ2h0IGJlIGJldHRlciBzZXJ2ZWQg
aWYgdGhlDQo+ID4gPiA+IHNlcnZlcg0KPiA+ID4gPiBzdHVjayB3aXRoIE5GUzNFUlJfRkJJRyBk
ZXNwaXRlIHdoYXQgUkZDIDE4MTMgc2F5cy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gwqBmcy9uZnNkL25mczNwcm9jLmMgfMKgwqDCoCA5ICsrKysrKysrKw0KPiA+ID4gPiDC
oGZzL25mc2QvbmZzM3hkci5jwqAgfMKgwqDCoCAyICstDQo+ID4gPiA+IMKgMiBmaWxlcyBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnMzcHJvYy5jIGIvZnMvbmZzZC9uZnMzcHJvYy5jDQo+ID4g
PiA+IGluZGV4IDhlZjUzZjY3MjZlYy4uMDJlZGM3MDc0ZDA2IDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9mcy9uZnNkL25mczNwcm9jLmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzZC9uZnMzcHJvYy5jDQo+
ID4gPiA+IEBAIC03Myw2ICs3MywxMCBAQCBuZnNkM19wcm9jX3NldGF0dHIoc3RydWN0IHN2Y19y
cXN0ICpycXN0cCkNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgZmhfY29weSgmcmVzcC0+ZmgsICZh
cmdwLT5maCk7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJlc3AtPnN0YXR1cyA9IG5mc2Rfc2V0
YXR0cihycXN0cCwgJnJlc3AtPmZoLCAmYXJncC0NCj4gPiA+ID4gPmF0dHJzLA0KPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGFyZ3AtPmNoZWNrX2d1YXJkLCBhcmdwLQ0KPiA+ID4gPiA+IGd1YXJkdGlt
ZSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAocmVzcC0+c3RhdHVzID09
IG5mc2Vycl9mYmlnKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXNw
LT5zdGF0dXMgPSBuZnNlcnJfaW52YWw7DQo+ID4gPiA+ICsNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHJwY19zdWNjZXNzOw0KPiA+ID4gPiDCoH0NCj4gPiA+ID4gwqANCj4gPiA+ID4g
QEAgLTI0NSw2ICsyNDksMTEgQEAgbmZzZDNfcHJvY19jcmVhdGUoc3RydWN0IHN2Y19ycXN0ICpy
cXN0cCkNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgcmVzcC0+c3RhdHVzID0gZG9fbmZzZF9jcmVh
dGUocnFzdHAsIGRpcmZocCwgYXJncC0NCj4gPiA+ID4gPm5hbWUsDQo+ID4gPiA+IGFyZ3AtPmxl
biwNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXR0ciwgbmV3ZmhwLCBhcmdwLQ0KPiA+ID4g
PiA+IGNyZWF0ZW1vZGUsDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh1MzIgKilhcmdwLT52
ZXJmLCBOVUxMLA0KPiA+ID4gPiBOVUxMKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgIC8qIENSRUFURSBtdXN0IG5vdCByZXR1cm4gTkZTM0VSUl9GQklHICovDQo+ID4gPiA+ICvC
oMKgwqDCoMKgwqAgaWYgKHJlc3AtPnN0YXR1cyA9PSBuZnNlcnJfZmJpZykNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzcC0+c3RhdHVzID0gbmZzZXJyX2lvOw0KPiA+
IA0KPiA+IEJUVzogVGhpcyBFRkJJRyAvIEVPVkVSRkxPVyBjYXNlIGNvdWxkIG9ubHkgcG9zc2li
bHkgaGFwcGVuIGR1ZSB0bw0KPiA+IGFuDQo+ID4gaW50ZXJuYWwgc2VydmVyIGVycm9yLg0KPiA+
IA0KPiA+IMKgwqDCoMKgwqAgRUZCSUfCoCBTZWUgRU9WRVJGTE9XLg0KPiA+IA0KPiA+IMKgwqDC
oMKgwqAgRU9WRVJGTE9XDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhdGhuYW1lwqAg
cmVmZXJzwqAgdG/CoCBhwqAgcmVndWxhcsKgIGZpbGXCoCB0aGF0wqAgaXMgdG9vDQo+ID4gbGFy
Z2UgdG8gYmUNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3BlbmVkLsKgIFRoZSB1c3Vh
bCBzY2VuYXJpbyBoZXJlIGlzIHRoYXQgYW4NCj4gPiBhcHBsaWNhdGlvbiBjb21waWxlZA0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvbsKgIGHCoCAzMi1iaXTCoCBwbGF0Zm9ybcKgIHdp
dGhvdXQgLQ0KPiA+IERfRklMRV9PRkZTRVRfQklUUz02NCB0cmllZCB0bw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBvcGVuIGHCoCBmaWxlwqAgd2hvc2XCoCBzaXplwqAgZXhjZWVkc8Kg
ICgxPDwzMSktMcKgIGJ5dGVzO8KgDQo+ID4gc2VlwqAgYWxzbw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBPX0xBUkdFRklMRcKgIGFib3ZlLsKgwqAgVGhpcyBpcyB0aGUgZXJyb3Igc3Bl
Y2lmaWVkIGJ5DQo+ID4gUE9TSVguMTsgaW4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
a2VybmVscyBiZWZvcmUgMi42LjI0LCBMaW51eCBnYXZlIHRoZSBlcnJvciBFRkJJRyBmb3INCj4g
PiB0aGlzIGNhc2UuDQo+IA0KPiBXaGF0IGlmIHRoZSBjbGllbnQgaGFzIHNlbnQgYSBDUkVBVEUg
d2l0aCBhdHRyaWJ1dGVzIHRoYXQNCj4gaGFzIGEgZmlsZXNpemUgdGhhdCBpcyBzbWFsbGVyIHRo
YW4gT0ZGU0VUX01BWCBidXQgbGFyZ2VyDQo+IHRoYW4gdGhlIGZpbGVzeXN0ZW0ncyBzX21heGJ5
dGVzPyBJIGJlbGlldmUgbm90aWZ5X2NoYW5nZSgpDQo+IHdpbGwgcmV0dXJuIC1FRkJJRyBpbiB0
aGlzIGNhc2UsIGFuZCBjb3JyZWN0bHkgc28uDQo+IA0KDQpUaGVyZSBpcyBubyBQT1NJWCBvciBC
U0QgZnVuY3Rpb24gdGhhdCBhbGxvd3MgeW91IHRvIGRvIHRoaXMsIHNvIHRoYXQNCndvdWxkIGJl
IGEgdmVyeSB1bnVzdWFsIGNsaWVudC4gUHJldHR5IHN1cmUgdGhhdCBXaW5kb3dzIHdvbid0IGFs
bG93IGl0DQplaXRoZXIuDQoNCj4gTkZTRCdzIE5GU3YzIFNFVEFUVFIgaW1wbGVtZW50YXRpb24g
d2lsbCBsZWFrIEZCSUcgaW4NCj4gc29tZSBjYXNlcy4gSWYgdGhhdCdzIGdvaW5nIHRvIGJlIGEg
cHJvYmxlbSBmb3IgY2VydGFpbg0KPiBpbXBvcnRhbnQgY2xpZW50cywgdGhlbiBJJ2QgbGlrZSBp
dCBub3QgdG8gZG8gdGhhdC4NCj4gDQoNCkFzIEkgc2FpZCwgY2hhbmdpbmcgdGhlIGJlaGF2aW91
ciBhdCB0aGlzIHBvaW50LCBpdCBmYXIgbW9yZSBsaWtlbHkgdG8NCmNhdXNlIGJyZWFrYWdlIHRo
YW4ga2VlcGluZyBpdCB3b3VsZC4gU28gSSBzdHJvbmdseSBkaXNhZ3JlZSB3aXRoIHRoaXMNCmFy
Z3VtZW50Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
