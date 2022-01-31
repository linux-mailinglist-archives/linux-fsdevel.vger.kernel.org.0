Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58134A4E96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356788AbiAaSh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:37:59 -0500
Received: from mail-dm6nam11on2098.outbound.protection.outlook.com ([40.107.223.98]:11945
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356713AbiAaSh5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:37:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFnA/zohbY0caBqMuTorM3uEuqdJ5PgixssDfl8yxHQwgJICsGfh2wowP3Wui/4LvFwdEkbfh+EiRX1L6M75X4ZbOSheyUjj2ltG1szn62t3TrW+gPNXnY2SRwVH/2wXrH9D5q0uinP5TR1YKX40IuiWcfl7bnlpnR+UhGw7jhsJklPZYB3RpeURnbJ4oJK+dA2uZJrRNMZ9Bnkj93e3X7VRTownrFHW32FhGGhG05zBzYijI89Brwj3k4TWncMisKcJdygALH71j64lRvm2mYBP7sugLzeiopa+wYjg/pfgXdW6jMrllwE84qjqd+p61gXBVnoTRJbwf/aLhNOVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WHdQGvJb5pCtV67CB/r0CnE1damJB0Dojrc5rZ17U0=;
 b=Q93eFgWlVRHJI03Duh99Ai2xhWW7BFSqBYdh8OGTJBKRFiwsTcwX0keiK71xjcyGjGa0+tU8lysmFSymTb71IYCOThZX87Rneh6cq+mLy8SqPxdnzxKEMtKBQPBXdW3CE/Mr33+5l/xVf2PsrTGYEnd+Yq1Vfw3SoNUCLr+t8UMUHgWv4AnGO/D1IVDXttz3nAtHkaueVH+CYfXxHvRmG2Y8cZX7/2uye/pUiPBLy9m7v3/TTIl3Kl3bIKv+y0S7ILv2+sdiqS6/ccJGMxIVw25OW2tnFha83+UtSWvLI4K8GrLWltQRgE1yD3IOepaIqWkI0wsSOWazunuZ5YFMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WHdQGvJb5pCtV67CB/r0CnE1damJB0Dojrc5rZ17U0=;
 b=Z/c3bp8BGQw4gBrpofv4/YRwUnQQcl8lrw2071d5Muw/KZwKjjOt/DVbM9+1LmwuZ9xpG2xXknD5Yd001wN69JYsNCnbIFNLrViEX7ui61/rZNf98QeDwY1vgl+WdyW/gt/8OCIoQhDbpysNsSenElN2+nF3q0pvMKYWIxyhzxo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB2917.namprd13.prod.outlook.com (2603:10b6:a03:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.7; Mon, 31 Jan
 2022 18:37:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%6]) with mapi id 15.20.4951.011; Mon, 31 Jan 2022
 18:37:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
Thread-Topic: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of
 large file sizes
Thread-Index: AQHYFs/ypcuQk9gPT06tiQmZ/LtqSax9da4A
Date:   Mon, 31 Jan 2022 18:37:54 +0000
Message-ID: <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
         <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
In-Reply-To: <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd8852d4-b532-4d21-cbd6-08d9e4e8cb5c
x-ms-traffictypediagnostic: BY5PR13MB2917:EE_
x-microsoft-antispam-prvs: <BY5PR13MB2917CD153CA2171AB498BB2FB8259@BY5PR13MB2917.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mabh5VQuPecGsJDvSRkVyaZtAKxX+bQRxBLduziHj+KrAtnSaa0+sn6pLiioaisy3dcH9sP9allygZD7vKbma9dyrWbdGO/nAJ2ECVqVdCW1GIPSU/g/rVuD6Cxl7OmgXhZVKDq1yfh2ljB3W0cvNs5K/VgKIVpeo30wRl9LFfv34S7fiWUqkL4f6useBJndaGsgy5hu1/7KhjZ7cpqmhoVFhEk92dby6qRkIKpz1wQmSu2xK8Ddlcq7BMSrzzujsb181gEHiU03k/9R/v+T/75o6S1rncHWye/vXv8KfCcugABBL4ehyfo9QDqfMHa3Lth2DnBt8PKNrXcSGhU2kqYplU9REV4eLdzLpGpL+/b9yT1VwprNoumUDQFbeYVViLABafGavqRIKXqGgtNW4EHyu1T6ZWAbzTHRy2cVbmabeORfO94jmpj0aCHWukO44ngS6+3rTyFDAMUoy7qnnpG9LFN/ee2USZld0EtXHCILq+50Wo0yum1wj06YtM6SgvfMdJbEriqGVxdwbocrltRyuZzrA/6mvbjeihz0b/R1WiefqbbcdjFXrlpg7i6BBIefnCL1s9iSBCXPxCQ/cOouT21eUN5unk73nh/aONVf1GBzfGO85zyiIV8Rkp2trsCr8E1eRrzcmOhZX8qAUHH9XZ0EEUqO3nuYoUh1ck11QUpXSEfEKYOaLyz6H4pM0gnFImLmxKXhNVJPqDPpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(346002)(136003)(376002)(39830400003)(396003)(38070700005)(2616005)(2906002)(316002)(66946007)(26005)(186003)(76116006)(66556008)(122000001)(66476007)(71200400001)(8676002)(64756008)(86362001)(66446008)(8936002)(83380400001)(36756003)(5660300002)(6512007)(6486002)(38100700002)(508600001)(110136005)(6506007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkxBSnVsRHRkYWljdVJCbWZTbkQ5eHVVQlBTUkhSWFNGQ010T2VpRFRVbnlH?=
 =?utf-8?B?ZW50QVNjMHdDb3ovL3dRVjRjVlJuK2daVDhzazNOaldCN3dtdTRsaHhkMW1m?=
 =?utf-8?B?T2VOanQyb3dwV2lwQTFFd2VManZnSysxTWgvNFdRcis1L1FpSHNEalNjTnhz?=
 =?utf-8?B?OXQ5U29UVnFKYUVTeVpVU01mN2FBREU0RzY5T3RNUzJSQWk2N0hWQVYvcjhZ?=
 =?utf-8?B?N1hHUFJWai90eitNUzZMSDU2SDF0U0xqaEtrZWRSYmJocGplaDBjTkk3cHJh?=
 =?utf-8?B?Ky8zL3ZtVUVJNkpydWNXN0RRaDZQNkgzMmg2alJSVzZ0TE1PdFdLaElqVmpy?=
 =?utf-8?B?UkhNdGVjeGxjQzBWZHYyWTF3UjBsd1V3LzFUb1ZtbmZQR2Zxa3Z2WXVDeWlB?=
 =?utf-8?B?TWpLM0NVK21xRGp3UmtuOFRwMEFmUnBoYjdWNzRjdWdjUEpVWnhkVHl4MWtP?=
 =?utf-8?B?clRZdWJGRElsVkFScGl4SEJtQ2VweVdyM2JSbUl3YllXYi9sVFZYWVNjMldH?=
 =?utf-8?B?dmlncG43ZDNZYkxDSWVhUHJ1MmozSkgxZ0pCWmlXWVljWUNKdndsYzl5cFdx?=
 =?utf-8?B?bUNaT1hjUm9aVjJSek9uUHFiZjROMkF5eXJFemxGNC9uTXJGaS9oVElPRXdT?=
 =?utf-8?B?WjVNYmh0cjZZL0FFaE40c1lZK0xqS1NXN0hHb2x3MVFNRU53ekVOUkEzYjJw?=
 =?utf-8?B?dWV4SjgxMGNscGxnZ2NDSnZlZER3SGxSVTVKeVNSUEdlL0dSQmprMVJvWXNK?=
 =?utf-8?B?V3RQa3h0ZEprSWNHaWthUC9wa01hMFRuS0tmcVNkT0JMbXpXeWJ5aTA3UDYy?=
 =?utf-8?B?WmRDVEFsOXpiS0dXdXE0SCtSSjVWdzZjdHVuQTBidC9YYVI4NmMxRkV4d3JL?=
 =?utf-8?B?ZlRFUkFBZ0lCeVRRcG0yS2FUMVZSNHlIbTRuRGxVOEIvUkpsa1pqVlBxb25E?=
 =?utf-8?B?VjBQWEd0SzlkaUFCNm5GZHZoLzhIUEVpdEMvNnJMdkV2bmU1OUp3VGRPTTRX?=
 =?utf-8?B?MEszbHNYYzFYc0NXMGpqSE0zWlA3UWpUOXNSYS9pSGsybDdZbHFYYzFYYk5Z?=
 =?utf-8?B?dzRFaXlBUUc0ZnJmdncyaStIc2tzVzErVWlVMUd6TTVJN0ZDTGozZDloQ3NQ?=
 =?utf-8?B?ODlXNE9FVTFtSFNEMFhJSWxvRjNCVzgrQ2c4VlVrejQ0MElmd1FmZnNtL3Jr?=
 =?utf-8?B?NFgvU1NORUhTU3A4R0Nha3V2RDlIYzZoLzFwWlZvK3RJbDFlbzl3ajMwMnFJ?=
 =?utf-8?B?MkcyUi9OQ3RmTGhaWDNwUlEyc0tWMzM1SkdUNUJ2OHB5L3hQZitrNVlYb3h0?=
 =?utf-8?B?N0pqWUJQNFYxUXYxdDlpUUd1K0hySERCVm95cEh3WTBRZmQwZnBKTFVjZTFN?=
 =?utf-8?B?MEJxeVJkM1FwSlZZcjFnMGVXSWxjQ090Z3prcHh3ZytublVrOTQvRHRXMGZH?=
 =?utf-8?B?VWxHSDlaQy8yZzc3Ym92SUJTeWFIVEhvcHFnNWdNZVhGbHZwZW1UTC9sRUhn?=
 =?utf-8?B?cjlPZWxDbS9yb1pHSGk1MGtVbmMrbDN5d0s0RVBYRjdLcVh1Y3hUMjFMSGt5?=
 =?utf-8?B?YkQvQVJML2Q4cVQwK1AvQUtBQStSeEZiNzM1eEJnTG9MQ3pwNHRhaWV6dm4z?=
 =?utf-8?B?VzN1d1BwVWh5ZjJJRm9oWlMvUi9Eb3dxdlM2QWM3NzdrRVZEc2dXaDRmQmt4?=
 =?utf-8?B?R1Via3IvbGF2L29BM3hyVUVCdWxiZHVSRHNrR1cvd1lkVCtyZ0Q4d202RHJO?=
 =?utf-8?B?SmFJeklQa0QxcUNKQlF0Y01YZVdLQXNRN2tscnNCanJlU3paMm1aRjNRSzJR?=
 =?utf-8?B?UkdyOC80MllORmIyZ0U4WmNRMU90aUo4dzhVMFdiUnRIbGN1ZTFJemlvK0JL?=
 =?utf-8?B?RzN2d0Rwb04xOVVQT1BHOUROekFEWnJqdWNIVkRZL1BUSlVTZWdRT2ZrdGFp?=
 =?utf-8?B?bWo4QnIzcEs3WHM3T210R0h5RzE1amI3Z0dkS2VhUnlkcDF5ZEdaMGc5QWp4?=
 =?utf-8?B?R3piTEVLQ3RUczhlYjFhZExmd3VIVXlUVk1XNUxUUWtrak44ZGt2MEQyVVZY?=
 =?utf-8?B?cncvRnhuZkQrMVQzVTRPeGMwTVpoYTF5Ymhrd05JdU0wRmNjRGhuZjBnWGZ0?=
 =?utf-8?B?YitrVzBnZERTbWNpbFFMaWovZVJwUDRIdm5tWnNNZHRCemlSeGpaMmVIWWxU?=
 =?utf-8?Q?1RcWWVRhtE8uK1RnUqWaAgw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <091AD53BFCD753428B0AAD7DFE0D349D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8852d4-b532-4d21-cbd6-08d9e4e8cb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 18:37:54.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMp5lLppwtgwOPrKR0AdAKqNO0UWkK3qZdjlTsvuKfPvvi4oNbOZXI9P5FNSqaCTgqDJabROi+JjDkBhuEcebw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB2917
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTMxIGF0IDEzOjI0IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToKPiBp
YXR0cjo6aWFfc2l6ZSBpcyBhIGxvZmZfdCwgc28gdGhlc2UgTkZTdjMgcHJvY2VkdXJlcyBtdXN0
IGJlCj4gY2FyZWZ1bCB0byBkZWFsIHdpdGggaW5jb21pbmcgY2xpZW50IHNpemUgdmFsdWVzIHRo
YXQgYXJlIGxhcmdlcgo+IHRoYW4gczY0X21heCB3aXRob3V0IGNvcnJ1cHRpbmcgdGhlIHZhbHVl
Lgo+IAo+IFNpbGVudGx5IGNhcHBpbmcgdGhlIHZhbHVlIHJlc3VsdHMgaW4gc3RvcmluZyBhIGRp
ZmZlcmVudCB2YWx1ZQo+IHRoYW4gdGhlIGNsaWVudCBwYXNzZWQgaW4gd2hpY2ggaXMgdW5leHBl
Y3RlZCBiZWhhdmlvciwgc28gcmVtb3ZlCj4gdGhlIG1pbl90KCkgY2hlY2sgaW4gZGVjb2RlX3Nh
dHRyMygpLgo+IAo+IE1vcmVvdmVyLCBhIGxhcmdlIGZpbGUgc2l6ZSBpcyBub3QgYW4gWERSIGVy
cm9yLCBzaW5jZSBhbnl0aGluZyB1cAo+IHRvIFU2NF9NQVggaXMgcGVybWl0dGVkIGZvciBORlN2
MyBmaWxlIHNpemUgdmFsdWVzLiBTbyBpdCBoYXMgdG8gYmUKPiBkZWFsdCB3aXRoIGluIG5mczNw
cm9jLmMsIG5vdCBpbiB0aGUgWERSIGRlY29kZXIuCj4gCj4gU2l6ZSBjb21wYXJpc29ucyBsaWtl
IGluIGlub2RlX25ld3NpemVfb2sgc2hvdWxkIG5vdyB3b3JrIGFzCj4gZXhwZWN0ZWQgLS0gdGhl
IFZGUyByZXR1cm5zIC1FRkJJRyBpZiB0aGUgbmV3IHNpemUgaXMgbGFyZ2VyIHRoYW4KPiB0aGUg
dW5kZXJseWluZyBmaWxlc3lzdGVtJ3Mgc19tYXhieXRlcy4KPiAKPiBIb3dldmVyLCBSRkMgMTgx
MyBwZXJtaXRzIG9ubHkgdGhlIFdSSVRFIHByb2NlZHVyZSB0byByZXR1cm4KPiBORlMzRVJSX0ZC
SUcuIEV4dHJhIGNoZWNrcyBhcmUgbmVlZGVkIHRvIHByZXZlbnQgTkZTdjMgU0VUQVRUUiBhbmQK
PiBDUkVBVEUgZnJvbSByZXR1cm5pbmcgRkJJRy4gVW5mb3J0dW5hdGVseSBSRkMgMTgxMyBkb2Vz
IG5vdCBwcm92aWRlCj4gYSBzcGVjaWZpYyBzdGF0dXMgY29kZSBmb3IgZWl0aGVyIHByb2NlZHVy
ZSB0byBpbmRpY2F0ZSB0aGlzCj4gc3BlY2lmaWMgZmFpbHVyZSwgc28gSSd2ZSBjaG9zZW4gTkZT
M0VSUl9JTlZBTCBmb3IgU0VUQVRUUiBhbmQKPiBORlMzRVJSX0lPIGZvciBDUkVBVEUuCj4gCj4g
QXBwbGljYXRpb25zIGFuZCBORlMgY2xpZW50cyBtaWdodCBiZSBiZXR0ZXIgc2VydmVkIGlmIHRo
ZSBzZXJ2ZXIKPiBzdHVjayB3aXRoIE5GUzNFUlJfRkJJRyBkZXNwaXRlIHdoYXQgUkZDIDE4MTMg
c2F5cy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xl
LmNvbT4KPiAtLS0KPiDCoGZzL25mc2QvbmZzM3Byb2MuYyB8wqDCoMKgIDkgKysrKysrKysrCj4g
wqBmcy9uZnNkL25mczN4ZHIuY8KgIHzCoMKgwqAgMiArLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2ZzL25mc2Qv
bmZzM3Byb2MuYyBiL2ZzL25mc2QvbmZzM3Byb2MuYwo+IGluZGV4IDhlZjUzZjY3MjZlYy4uMDJl
ZGM3MDc0ZDA2IDEwMDY0NAo+IC0tLSBhL2ZzL25mc2QvbmZzM3Byb2MuYwo+ICsrKyBiL2ZzL25m
c2QvbmZzM3Byb2MuYwo+IEBAIC03Myw2ICs3MywxMCBAQCBuZnNkM19wcm9jX3NldGF0dHIoc3Ry
dWN0IHN2Y19ycXN0ICpycXN0cCkKPiDCoMKgwqDCoMKgwqDCoMKgZmhfY29weSgmcmVzcC0+Zmgs
ICZhcmdwLT5maCk7Cj4gwqDCoMKgwqDCoMKgwqDCoHJlc3AtPnN0YXR1cyA9IG5mc2Rfc2V0YXR0
cihycXN0cCwgJnJlc3AtPmZoLCAmYXJncC0+YXR0cnMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmdwLT5j
aGVja19ndWFyZCwgYXJncC0KPiA+Z3VhcmR0aW1lKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYg
KHJlc3AtPnN0YXR1cyA9PSBuZnNlcnJfZmJpZykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmVzcC0+c3RhdHVzID0gbmZzZXJyX2ludmFsOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIHJwY19zdWNjZXNzOwo+IMKgfQo+IMKgCj4gQEAgLTI0NSw2ICsyNDksMTEgQEAgbmZz
ZDNfcHJvY19jcmVhdGUoc3RydWN0IHN2Y19ycXN0ICpycXN0cCkKPiDCoMKgwqDCoMKgwqDCoMKg
cmVzcC0+c3RhdHVzID0gZG9fbmZzZF9jcmVhdGUocnFzdHAsIGRpcmZocCwgYXJncC0+bmFtZSwK
PiBhcmdwLT5sZW4sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXR0ciwgbmV3ZmhwLCBhcmdwLT5jcmVh
dGVtb2RlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh1MzIgKilhcmdwLT52ZXJmLCBOVUxMLCBOVUxM
KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgLyogQ1JFQVRFIG11c3Qgbm90IHJldHVybiBORlMzRVJS
X0ZCSUcgKi8KPiArwqDCoMKgwqDCoMKgwqBpZiAocmVzcC0+c3RhdHVzID09IG5mc2Vycl9mYmln
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXNwLT5zdGF0dXMgPSBuZnNlcnJf
aW87Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcnBjX3N1Y2Nlc3M7Cj4gwqB9Cj4gwqAK
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnMzeGRyLmMgYi9mcy9uZnNkL25mczN4ZHIuYwo+IGlu
ZGV4IDdjNDViYTRkYjYxYi4uMmU0N2EwNzAyOWYxIDEwMDY0NAo+IC0tLSBhL2ZzL25mc2QvbmZz
M3hkci5jCj4gKysrIGIvZnMvbmZzZC9uZnMzeGRyLmMKPiBAQCAtMjU0LDcgKzI1NCw3IEBAIHN2
Y3hkcl9kZWNvZGVfc2F0dHIzKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsCj4gc3RydWN0IHhkcl9z
dHJlYW0gKnhkciwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh4ZHJfc3Ry
ZWFtX2RlY29kZV91NjQoeGRyLCAmbmV3c2l6ZSkgPCAwKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlhcC0+aWFfdmFsaWQgfD0gQVRUUl9TSVpFOwo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpYXAtPmlhX3NpemUgPSBtaW5fdCh1NjQsIG5ld3NpemUs
IE5GU19PRkZTRVRfTUFYKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWFwLT5p
YV9zaXplID0gbmV3c2l6ZTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAoeGRyX3N0cmVhbV9kZWNvZGVfdTMyKHhkciwgJnNldF9pdCkgPCAwKTAKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKPiAKPiAKCk5BQ0suCgpVbmxpa2Ug
TkZTVjQsIE5GU3YzIGhhcyByZWZlcmVuY2UgaW1wbGVtZW50YXRpb25zLCBub3QgYSByZWZlcmVu
Y2UKc3BlY2lmaWNhdGlvbiBkb2N1bWVudC4gVGhlcmUgaXMgbm8gbmVlZCB0byBjaGFuZ2UgdGhv
c2UKaW1wbGVtZW50YXRpb25zIHRvIGRlYWwgd2l0aCB0aGUgZmFjdCB0aGF0IFJGQzE4MTMgaXMg
dW5kZXJzcGVjaWZpZWQuCgpUaGlzIGNoYW5nZSB3b3VsZCBqdXN0IHNlcnZlIHRvIGJyZWFrIGNs
aWVudCBiZWhhdmlvdXIsIGZvciBubyBnb29kCnJlYXNvbi4KCi0tIApUcm9uZCBNeWtsZWJ1c3QK
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tCgoK
