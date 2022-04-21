Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCD509842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385415AbiDUG6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385505AbiDUG5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:57:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32491165B3;
        Wed, 20 Apr 2022 23:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss+djg59GtoLMoNVKX2Omfi4S+9Mrrpq4lNoxtYNJ7+y2Qsxxzq20Cu/Ht0rRKSyPZW6qSQZv9pmLbgE2VUt3gorb7tcJmSajZucsIfA5oU6WDAxnfc4OmYQbfolSDu6aVkAKRObYtje9EDj+GaQjsMZ0UM4Wb8K1NgvnvKIR7HIidpZHt0zJVOihC+S5ziFc6Fa0jq4wJ5RwDuQ0Pdf9DZyrXKgiHnDl75rRARtKNfa4C3xP5kGVgHT4Vmgv5B3oVSdgUDKS80TiiOhcRm9BJ9QxqNQJuDI//Px78ChtDpdABNFw1pGJZo0FMt0uXNbaQaNzmbRU5xT1sKMjgOw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRuUO3rvmY1nlGua2B7xndQPyGbgQzxOLjKp1WzISOs=;
 b=A/Ssqyjv3X03slTEF1n6PQMVwPyYKOYgyPUNSEFuNOPs0ihc/1BcD3nXpg6lTapGqDXsk3uzSlq9O0GwvgwLt0GdrG0X+YCAVJQUGPKYwIYrLgpogYUntVYyJWL64q1L+eANdt2QswUlfOFnl760BbC6lDTLtqxnb5gfBRly19uGYaymBhBc2k2Y0j2r67ogu9A+QzfWXbLgp2NAZ46BS4w/JuGHTA/ALfsxvakahzm2383gUwp+u+ttCPuqJz4qgLW3lOtAd7rTlE0JGNWdJ5P17i40M806S7cqHf3Z0K99SPtyplICkLGSZ7oamKtXBEdhaoGNW7SCqjH0PAzu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRuUO3rvmY1nlGua2B7xndQPyGbgQzxOLjKp1WzISOs=;
 b=d0nzgDi2iJBdgaVQh9od5Na0zxiph1gXrNyDOWad0WWMt1MW2QlNzGQRW1tCwyZ+1Z9D+PiKNbsOqThmPZEw8G3fQX5GhXquPRaYRDXy9SuEhqosDEO1ySyjA8QcA3TMx9VqMyU+Dv1lyHDC9RQgtDXkpOLV6CzsJT+REECMUls=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB4582.jpnprd01.prod.outlook.com (2603:1096:604:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:54:31 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 06:54:30 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 3/7] pagemap,pmem: Introduce ->memory_failure()
Thread-Topic: [PATCH v13 3/7] pagemap,pmem: Introduce ->memory_failure()
Thread-Index: AQHYVUNrgHX/pyb9f0eVCu65lIyhG6z57sSA
Date:   Thu, 21 Apr 2022 06:54:30 +0000
Message-ID: <20220421065429.GB3607858@hori.linux.bs1.fc.nec.co.jp>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-4-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220419045045.1664996-4-ruansy.fnst@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f69be9-991d-4239-dc85-08da2363c8e1
x-ms-traffictypediagnostic: OSBPR01MB4582:EE_
x-microsoft-antispam-prvs: <OSBPR01MB4582407B5B10E30CC31F3DD2E7F49@OSBPR01MB4582.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MaFoWiNq+CrGGNocMisDHMyeGCBfQ33CgOvh4Xr7VMVWceSY5+BYQZ/VKMnEx/PBEBH+xSXHGoww3qccTnXn+YjkkKz8UiTnc0yAmykq1vD0JYqfrxNcHJlab28j8y9duAXqEGc0saWJgxtHZnU7d1+HfxFiNq9zXhKFzvoXuvH9E+3GdHSgf3AbdFvD8ycEC2C2Q2NlrCIaEiPOmwdsTxIRzBXzwnXCdWlzjdSymF8TFvMNyLhiCLayipqZSgNapA5TWYVRbCndvXby0khr/zWi0s1V+kuNq0tzwZ15KdVTm5W6G5y2rMblytoNrubyKTGJGkJwSjA/AZAxvtoMQcZQucVRyc5DGRrIoTy7LF+NUnPgF1XEVhpaaHs3Csvi7O+bjjKmkZf0tvUC+m9y4bBBR3X4mrCUPPFazTX61jJTn89BYD97ZPYHxt59m4CNrFPZjmUzktXFYT6Zyg94BaNxY2UHd/7K3FDFxoezPVMs1VAXacb6SjCHsXxnfbxdo6hRK1c1j9yexV3vtvYZZhiGygdZaqNrZK+JfjZnYr45na5Aj5HQh2qh1vUnFmJgGBRsOlcpWvm++OybMjjVLmo1Dup42AKkO9SjGL1je87IfmS+El3eLcO/VNck4bgC5h2dolexwKHGxBI0LVF82MKNz684I9eAs1yQqTgp9Px2wN4rAaPJyMvap5RzXgH20aMg+5Ul6GqRx+XKERzFOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(6916009)(26005)(186003)(85182001)(54906003)(38100700002)(82960400001)(122000001)(83380400001)(2906002)(55236004)(6486002)(9686003)(38070700005)(6512007)(6506007)(316002)(4744005)(71200400001)(5660300002)(33656002)(86362001)(8936002)(66446008)(64756008)(66476007)(508600001)(4326008)(8676002)(66556008)(76116006)(7416002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE1KUnJWeXV6a2JXcWM1NXlWZDI5RU9iWUpuVlFyeW1OWWFROGJrYnVjaVVu?=
 =?utf-8?B?dFdQcmFya0MzbnRpTVZSMFRZb3dxSS93Y3FxUlBvWXRSWEUzaVE1SXJpK0xE?=
 =?utf-8?B?ZXZ3dVVqV0FVQXpRNEdBaDNVYk9zTm9vTi9aUHJObVhGWFpJaEZuWjk2SElR?=
 =?utf-8?B?cTl3Z0tKaEVRbno5bkMwZTljRThqMi92OWVyRzg1eUFYSWdDb2JLK3gvZnJo?=
 =?utf-8?B?NTBaMmYwTm81RW5JeWw3SzM5R2JlOWx1M21PMXNJbmNTbHNqV1FLNDdsVGdH?=
 =?utf-8?B?WWwzUTVEekV5TmpLbEV2cEFHOW1KNUFPeGZGbjJ1SGdhQXBWYlN5UFEwcEEr?=
 =?utf-8?B?czBuWDYrOVQ0dC94WUFnb09QT1Bha0JFTDRGWWx1cWV1czN0MWQ4VnNsNWo3?=
 =?utf-8?B?dzZXWlhUQ2o3TEE0Z0MrTEhOK1FFY3lrWitMVGt6c2tJMnh4ZnR0dFE5c2Fs?=
 =?utf-8?B?eFpYaFBlbEUwaldPYm5iQ05WNWU1VlByYm0vaU5hekREZ3RNTWhVTkEvTTJk?=
 =?utf-8?B?OWI1bzlpMzF3cGVVZHRCWmpYUm5Ha2ovcUNVQXhwRUFmdWx4bTU5SWNQamtQ?=
 =?utf-8?B?Z0xlY1FaWkNXRWRUTVlmbkpiNGxnU1E4WUhtbmpPVy9FNk9WQk04OFg5S1BN?=
 =?utf-8?B?SEpTZGFiNTFubkZkR3R0RHo1OHljOEtWNVF2UXByWkJVZFdoWENqQXJmcGRQ?=
 =?utf-8?B?bHcxWUhJWHA1NTBlVXhMRkpQV1lZYVhQL0w1S0pFSzRpR0RiSzZ2aE83YVYz?=
 =?utf-8?B?YUdOR2d3MGdLaUhLU29hTEtmdm5nOW9UUldzL1Jpcml4cHVVSWx5SUFMWElW?=
 =?utf-8?B?allIVExaZjcxaVFPaTR6dmlKeVQrTzBiNWxSY1lpYWJaQVEydXhOQ3U0Ymgw?=
 =?utf-8?B?MTIwdy9FdEJac1hzUEFRRFUxbnhwbkR6MUhIamVoaC9IUC8wejR6S2RZY0JE?=
 =?utf-8?B?c0VvYUc2QWMwd2xpei9xakpubHhRb25pbE1zK0hFVC9NSjFJZ0lFMXRhcEFJ?=
 =?utf-8?B?RTM4M284KzQyZ2lGcWo5anAvTyt6eEVCSlEwY2dJc1h2RFNKbVl5K0pLVjNm?=
 =?utf-8?B?RjQraE1yQ1YrSW40NFlNbVM1SVI0aTcrTDlDK2Q2Q2h4VUt2R215V2JEVDdH?=
 =?utf-8?B?cXExaldTdnJPWW9hQXlOelRMREdsSndWaTRVT2dTbTRESDNMbEQya2Qyckt1?=
 =?utf-8?B?Nmk2NEhVNE1wT0RMeENrZ1plenVnOURMQzFjUWcxOVB4SXpURTIyZzZSeVJw?=
 =?utf-8?B?TFpSTC9qeFRweUdiNko0dnJtaXJqOEtsa1lBSVdGZXhYeC8xVWdQd3p3MVRt?=
 =?utf-8?B?VUZya0dhOHFac0NBdFZoYXdPNENlazk1M0NRNjQ4eFlQellHWXNzZmVCdzVX?=
 =?utf-8?B?NDR1L2RHdkZGbEZEZFkvdk5uSDNsK2Nybm0wbnBCR3hnMkN5djJaTGwvb1Jr?=
 =?utf-8?B?anhPRlBjc3YzaUZjUktlaDFXbzFHZUVFaGplMHJwUWR4UXNmbGMvSmFuNzZ0?=
 =?utf-8?B?ckVUZ2RVT0lWS2dzVGNWeENjN2pueDdXRjUveWlZVmhZeHRmYmFjUUJObDVZ?=
 =?utf-8?B?YjFNdHE4WGc5dlJtbHI0U1BpNGkxNmJpZkdXajNUTDdIRHZyUHNSK1luQ3RP?=
 =?utf-8?B?djBINlNCNi8vc2d2Ymg1aXhNUWNUOU5tWGMwVDVtSGRqdUJ3REh5MTEwRkNZ?=
 =?utf-8?B?eWRWN3dBbGRsN2ROMVRrUE1Xb1VJUEVjUWIxVk8zbTY1cGtTWGc4dzY4T2ZJ?=
 =?utf-8?B?YXFDZHdXUDJXbUdTWWdPNU9wd3A3Y0lWL2hhUFd1bFFPUzdoeXlUVWdPSVZn?=
 =?utf-8?B?MTIyVSswOE1UOXExdytqaVhiNDlJQVljY3FjRFRWVW5jMnl3TzFzNjhhN2N5?=
 =?utf-8?B?TkZNMEgzb2QvbTlScHE1TjlrMDVaNFFKWndGWjBUVFUwcERWY3R5d2ZwTmNG?=
 =?utf-8?B?M2I0Nm1EeDNSOUZLZ1ZpYjcycmkzYUxQbUpuNXhxWXhvclRyT2lvV3FaYTQw?=
 =?utf-8?B?ZWpKK3BvK3NwN0xpNFRsYTBFaHIrWEpQY2hsVTRQWWFnT1l0Ylg5R1Q1QW41?=
 =?utf-8?B?Y1RMRlczMlhYQ2dpa0lTUUMzdEdVcWdLQ3hxVC9JUlNBREYxenFDVXVJeGFK?=
 =?utf-8?B?THdTUDh1RjB2dlFseG9CditjNE9lMnQwOXJLdFdyNURMSWtzWEpPRHQ3TkVo?=
 =?utf-8?B?Zk81bm1pVzQxU3NkQ0hkbFFzSmM3OEJjVlNKTDhyV2xTTHdVb2xwR3BDZkR4?=
 =?utf-8?B?YkFaMEc2R0U1ekhuSDZ3ODVrbnl5QzRnZXpDV1BiY3h1ZUhiTkl1N3NjdFp3?=
 =?utf-8?B?VG9HZDgyWEJUd3hISzFFZVMxdk5HVmZYeStpb0hFclAwUzd0SndnQmhyTXpD?=
 =?utf-8?Q?CQonpQL0cc2F8ax8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4D4AE22B0AC9345921A8005212CD911@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f69be9-991d-4239-dc85-08da2363c8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 06:54:30.2514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCiIRkePOnigFX0qrU18EYo79JkM69sRalEsjxTJ7LJkAtW775PZ+DDhHsPxfLSzbHJTAiz8FdyfyRhQhL3xvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMTI6NTA6NDFQTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdy
b3RlOg0KPiBXaGVuIG1lbW9yeS1mYWlsdXJlIG9jY3Vycywgd2UgY2FsbCB0aGlzIGZ1bmN0aW9u
IHdoaWNoIGlzIGltcGxlbWVudGVkDQo+IGJ5IGVhY2gga2luZCBvZiBkZXZpY2VzLiAgRm9yIHRo
ZSBmc2RheCBjYXNlLCBwbWVtIGRldmljZSBkcml2ZXINCj4gaW1wbGVtZW50cyBpdC4gIFBtZW0g
ZGV2aWNlIGRyaXZlciB3aWxsIGZpbmQgb3V0IHRoZSBmaWxlc3lzdGVtIGluIHdoaWNoDQo+IHRo
ZSBjb3JydXB0ZWQgcGFnZSBsb2NhdGVkIGluLg0KPiANCj4gV2l0aCBkYXhfaG9sZGVyIG5vdGlm
eSBzdXBwb3J0LCB3ZSBhcmUgYWJsZSB0byBub3RpZnkgdGhlIG1lbW9yeSBmYWlsdXJlDQo+IGZy
b20gcG1lbSBkcml2ZXIgdG8gdXBwZXIgbGF5ZXJzLiAgSWYgdGhlcmUgaXMgc29tZXRoaW5nIG5v
dCBzdXBwb3J0IGluDQo+IHRoZSBub3RpZnkgcm91dGluZSwgbWVtb3J5X2ZhaWx1cmUgd2lsbCBm
YWxsIGJhY2sgdG8gdGhlIGdlbmVyaWMgaGFubGRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNo
aXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+IFJldmlld2VkLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IERhbiBXaWxsaWFtcyA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lLCB0aGFuayB5b3Uu
DQoNClJldmlld2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29t
Pg==
