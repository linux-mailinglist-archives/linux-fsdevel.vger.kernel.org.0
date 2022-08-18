Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17353597ADB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiHRBLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 21:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiHRBLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:11:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E888910A1;
        Wed, 17 Aug 2022 18:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqF59fyzGSuKSfYFVymhmuwg2o6DuUtkWScwc6okrfPYSKGLQgEsZL006KUq9bzu44KgNoT5j5t0Lo0VCZgoa010ChdrRMqL4QQjT0IPHn5tc1bA5rRNIBwLY9N+zLf2fA29KK/xvi9uW2j/PsDQZAImS8RRVNalVAEPKUO5CVS6LEHGS1bFUCdgOVk0UaD2CNPLVY0EQcTJJ32m6HIgeqJJiHESIGsaY1wzKZOzXRBUnkaaNOe/yTeb0IZtOCcwW/2YKVDuT7D2PXNiC3hPxoIXpdIofBOpJF2WoIa160SKPMfv52b9KPrb9+ZZ3W4VOAY0lj4p9oaj8F8deO90aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou4TCwG1aPb5kP4GygVMzIFl+mnEI6xwNWaeY9a0s+w=;
 b=Z4LVo05eKSrNbc0dKIsVumZq6831ghIWW3phgl2xNZ7grF57QewbaUlWipkrcTPWi3vN8XJac3XI/jD43+gd967mwZH5key/9fR1+TDrHmFtAcAUqqzATgD+2NIxIpqIqKufEmXdiIr/UbY/0tcOoNNMZMnH7XzoHC7K07bTU6JiNOF45h88GuwYa6Z1mVk03JN9TUrJo8YRPq/KXeSNxIUBY7BN1aWDoGcntTAUcZ0AUY3rH+USHCfAwSwy/yn22v7byElA74k8WowB3SACtbhOvM3QyE/JtBzObmX1kSBYtOlAf+zMY7eusc+bp9hBAY/CUv6MgZrSP5KqxEm1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou4TCwG1aPb5kP4GygVMzIFl+mnEI6xwNWaeY9a0s+w=;
 b=gXchDY1//BY352esbGPiphnjRszqdcKVjrqdnANm1YOXWsgG6CkQ0BhxU5leu57l1NfxsZXoFvsrYFOcJvUWS9BBkwCFFRThTRpIjnAkXBc0qVI79L/q4WlsH7bmL/XRl/dENpriHwqwxqEC5+wrl0NkC9T8MSLcSNMckOXgBZw=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BYAPR13MB2680.namprd13.prod.outlook.com (2603:10b6:a03:fd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.14; Thu, 18 Aug 2022 01:11:10 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2c2d:ad57:1de2:b42d]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2c2d:ad57:1de2:b42d%4]) with mapi id 15.20.5566.004; Thu, 18 Aug 2022
 01:11:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Thread-Topic: [PATCH] xfs: fix i_version handling in xfs
Thread-Index: AQHYsXLXiDzQGb6SwE6W212lBryYZK2xqt0AgAAELwCAAHEdgIABu7uA
Date:   Thu, 18 Aug 2022 01:11:09 +0000
Message-ID: <c61568de755fc9cd70c80c23d63c457918ab4643.camel@hammerspace.com>
References: <20220816131736.42615-1-jlayton@kernel.org>
         <Yvu7DHDWl4g1KsI5@magnolia>
         <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
         <20220816224257.GV3600936@dread.disaster.area>
In-Reply-To: <20220816224257.GV3600936@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f4b12cf-66c7-44d9-1e55-08da80b688f3
x-ms-traffictypediagnostic: BYAPR13MB2680:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 28x0aU62eIpfKWh1gVIpISiE1v+/f0xxuvH9U9FzJpS9ladH7Qe5oFY3lQOaiEP16EKChWich4dBGZ5clSJ6j9igWoxbGtTMZfD9XVL1QdZOipk9p9jPSCvLzatBQ/41mvECO0MR8QdIPWkZelfdR9B7skJj6O9swmRw/xaWw3U1azwMKXDhCAFwpg5gHubTFn8FLOigmQFxBj4EwEJEHuE/SFIJ/45BOR/pQ2FEUJoWehxrQWpkPjiOHteh7EVO6EBJbp8aswNUv2DWsfgYgaX7vI5QTyNwkqky6qYbopJKQTibuMFuSw8RCzfiX487tfd9hY8t0M4rdv5uXUNTkSM+EWEi0n29KBjtpceK0NVJlYgqYA12gNHXHBvHsfIubw23DePq9lyQxkUuZUbvIyvTqhQcBW1T1tTqXkSlgx6M6HY0ejicCT3eq36IQSy2fiCVRth0MjnMTUpVAiQksRS025FvLbhTgO8z1LUbFAefVaThmFMduStorEJXeHhch3vivCzdgRI3xAh7SbjHwFfxguMFIyQg0dad+DN7UunaSDTPQA2JS7Ty0UnoiE8CjxEGsPToPKKOmlbcSzuecbmBl3JkikzVMRvD/v4mhhzrRbadaYjrKHB5Y8KIE/aGuxz4snWlpvFbwqD+2DOD786QhfCGpIv+fWH7U8yiIjm3zoloJ3wcocQ706Oh414zh6nulIeRKEM3qcUMfFRn/Ru3SKMOAjGcOYkzngwSXZ0aiCsULgwdItakPi9JXrzr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(366004)(376002)(39840400004)(71200400001)(38100700002)(83380400001)(66476007)(91956017)(36756003)(4326008)(316002)(6486002)(66946007)(66556008)(66446008)(54906003)(76116006)(110136005)(64756008)(8676002)(6506007)(26005)(2616005)(6512007)(8936002)(186003)(478600001)(86362001)(38070700005)(5660300002)(41300700001)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJJaFNYVm5uV3NjczJPWE5WenV0VVdDMEl4ZEdBajZGOFNyVVFXTjlaMUhF?=
 =?utf-8?B?bmxkNjYwZlFTM2l6R1h3bUZ6QUMyemtqWHNtcU9ZR1J3YktGNnFIajA3VkFK?=
 =?utf-8?B?NVZvNit4emx6Q2M1K1ZXTnV6cFRoMHhRR0NtdjdaN3JwQVBybTFYTjNUbnNN?=
 =?utf-8?B?bXRQM1VHdlliUThqbTIyNjB5M0ZwTjEzYmx2Yk5mdE4xMFN3M0tvOUNBand0?=
 =?utf-8?B?T0w5R0tKMVVFbkRSM252azFNdHpmanhwZ0FRdzltaytkYVlEYXFtWjBrbGNm?=
 =?utf-8?B?Ulg5YkluN0ZlNHhlMmx0Z0tvTjJGampsVWtPTnJoNnZOKy9jSWdacWRTNito?=
 =?utf-8?B?dGVobUp3eHBOeUhwSndqS2FuRDFqSTdoNUtRN0NmcXMvaFphNmg5VnlSMXhY?=
 =?utf-8?B?b014eUF4MVlzV3BqN3c0S09KeTlJN0V0QlVNWUlEY1ZnUUdEUkIvblN3LzY1?=
 =?utf-8?B?TXVlN09VbFNROGNteGhvNEN2Ulp6bVpxMEwrTVJ2TlJ3aW1zTzJkWjBjajNu?=
 =?utf-8?B?VFpTTmpkL0pLeCtFSXNpUElDbExBV2I5Z2h6Sm1RY1BHWGY3TjRIbGJBUUxa?=
 =?utf-8?B?Tisxa3pncmJ4SVh1bXoxaHloQWdXRTk2OGFLaTVnMm0vanhJQnNwY0JGVnNN?=
 =?utf-8?B?T0UxMnVqOVZVMnluZVhVY0ozTzlzeUVoNjdsRnI3b0dMN2NxLzFrS3daMVIx?=
 =?utf-8?B?ZjJKWE5WY3VyZXFrWlZ6V3MrcE4xaXd5Y1F1Tkpjb1BlQlFNNXQ0THIrTGY0?=
 =?utf-8?B?YzJQa3liUFYzajdKWEhPL1RBczhQTjFGaUZvQ1JzNFlwdy9uUXg1cUlsaEZl?=
 =?utf-8?B?MmEzQzc0UkpWVVNhTExSc0QyazZXcDR4YjUrNDFRWitMK0lCTVA1OGtRTVB5?=
 =?utf-8?B?YTM5Y0xYS21oVkF2RTh1a0F5MithcU1ucGN6NHVZdG9GK1JKTUZEYWp5K2Zv?=
 =?utf-8?B?VG1aQVQxMWo0c1J4b0JSK3Zsc0V0NTBnMmFha2tuOHlvYzNPUjZOTGJOTExQ?=
 =?utf-8?B?OXNOdVRYLzYrVTZxRDk0Uk81K3FaM3hYT1c0K0NuNG5BcG5Yd215R3NnNDhL?=
 =?utf-8?B?TXlaSjNiZ0JVSm40ZHNzL3RWZC9CdTl2em1zb3A5a0szb0hGb3lRRTVRc0ZG?=
 =?utf-8?B?SHdjd1B3WWtsb0MvdEFFL2NzYStTVVFCdzAyV1VnUlZ3SUdCN1NiT1JlREFR?=
 =?utf-8?B?M0U4QVFoU2tXNVdHdXFLSTRiNXF4djc3Mk9kaXo4ZktXRGVCcTF3VEZaNlZl?=
 =?utf-8?B?SDhhRHkvVkpkKy9yTDkzaGVyVmRUZlZ3a1dyWi9Hdi9hbFJTRmw5MG5MUFNj?=
 =?utf-8?B?KzRTYUN5YWRZK3krb0pxbFhJdlQ2b3lVc2VkY3pUU2RiM2IvNnB4cFNuU3hw?=
 =?utf-8?B?Z2VtaE5NSTdETHB3ZU1GVDdicEJPN2ZkYms3eTlOeUFiZGxmSlZqdTExSnYv?=
 =?utf-8?B?Qm5oeFF2Y3JDa2NDWktpUkpubW1QUGkyUEN6SGhWZ28yOFN1dklHWVNSMjBI?=
 =?utf-8?B?UjdHaCsyenJvQXJYeXJNQ1o2cHJWb0pibXBuQ25VVmFHTEQwQlFxTWM0Vzln?=
 =?utf-8?B?RGtyamdsSmo2d3VMOXV2L3BZVTZzeW5wTnNDVXJDdnR1Ymt3MWc3SU5hOXh5?=
 =?utf-8?B?SjFwUzYyd3ZjaXcrRHNucENjQyt1RUtWYlYrMFgrWVYrVzhRVHY4UGovUnVm?=
 =?utf-8?B?UUpETlNqUG0vTHZST1RQUTJRREhhSENlUVFYSExVSnFFWHgwU0N6WjdwRHJ2?=
 =?utf-8?B?MWVGUTdCQTl0VGNlOTZMNnBoemFtYVRNSGFneUJ3VVZnR2JIQVFoa0FNUlIy?=
 =?utf-8?B?elh3SndyQXJJY05iSzZmaWxMZ05TN3B3dkhHL0NKVC8vQnFodVh3RjBueWxn?=
 =?utf-8?B?d0trRWgrT2RaaE84Uy9sZlowR002UHZDMXVJU0Qremw4NVp1WWxoWmVDM1cv?=
 =?utf-8?B?elZ2aUlaaUI4c00xczZQWGdWdXhDZVNrNnNzcFR5ZWlaQnlHanVsZG9ITXNo?=
 =?utf-8?B?S0Qrb1ZGaW5saXZJeHRPSFVYZnJRZUQ4bTVSeGpBR0x5TFNneUNTbE5zSXhD?=
 =?utf-8?B?Mm5vNHBWbWhmUnNPWUJ6VWRPelhHNEk1OXYzL214MW8rN2gwK0wvYU9EVm44?=
 =?utf-8?B?WTZEd25WZ2xUbjk5QVA1TjhCa2U1OVJXYkVrcTN1OXBHdHVxWmRMZWlTMHpj?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E023DE15875E14AADFD3B76E8F33E05@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4b12cf-66c7-44d9-1e55-08da80b688f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 01:11:09.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18HQTnl1Fdzn1maCfHDx3dVEcor5Cv5krudcdG3UaM+xt5k9DTkqhInsOlb3Vfy2Pic1zTiu2811tiMZ3VUViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTE3IGF0IDA4OjQyICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IA0KPiBJbiBYRlMsIHdlJ3ZlIGRlZmluZWQgdGhlIG9uLWRpc2sgaV92ZXJzaW9uIGZpZWxkIHRv
IG1lYW4NCj4gImluY3JlbWVudHMgd2l0aCBhbnkgcGVyc2lzdGVudCBpbm9kZSBkYXRhIG9yIG1l
dGFkYXRhIGNoYW5nZSIsDQo+IHJlZ2FyZGxlc3Mgb2Ygd2hhdCB0aGUgaGlnaCBsZXZlbCBhcHBs
aWNhdGlvbnMgdGhhdCB1c2UgaV92ZXJzaW9uDQo+IG1pZ2h0IGFjdHVhbGx5IHJlcXVpcmUuDQo+
IA0KPiBUaGF0IHNvbWUgbmV0d29yayBmaWxlc3lzdGVtIG1pZ2h0IG9ubHkgbmVlZCBhIHN1YnNl
dCBvZiB0aGUNCj4gbWV0YWRhdGEgdG8gYmUgY292ZXJlZCBieSBpX3ZlcnNpb24gaXMgbGFyZ2Vs
eSBpcnJlbGV2YW50IC0gaWYgd2UNCj4gZG9uJ3QgY292ZXIgZXZlcnkgcGVyc2lzdGVudCBpbm9k
ZSBtZXRhZGF0YSBjaGFuZ2Ugd2l0aCBpX3ZlcnNpb24sDQo+IHRoZW4gYXBwbGljYXRpb25zIHRo
YXQgKm5lZWQqIHN0dWZmIGxpa2UgYXRpbWUgY2hhbmdlIG5vdGlmaWNhdGlvbg0KPiBjYW4ndCBi
ZSBzdXBwb3J0ZWQuDQoNCk9LLCBJJ2xsIGJpdGUuLi4NCg0KV2hhdCByZWFsIHdvcmxkIGFwcGxp
Y2F0aW9uIGFyZSB3ZSB0YWxraW5nIGFib3V0IGhlcmUsIGFuZCB3aHkgY2FuJ3QgaXQNCmp1c3Qg
cmVhZCBib3RoIHRoZSBhdGltZSArIGlfdmVyc2lvbiBpZiBpdCBjYXJlcz8NCg0KVGhlIHZhbHVl
IG9mIHRoZSBjaGFuZ2UgYXR0cmlidXRlIGxpZXMgaW4gdGhlIGZhY3QgdGhhdCBpdCBnaXZlcyB5
b3UNCmN0aW1lIHNlbWFudGljcyB3aXRob3V0IHRoZSB0aW1lIHJlc29sdXRpb24gbGltaXRhdGlv
bi4NCmkuZS4gaWYgdGhlIGNoYW5nZSBhdHRyaWJ1dGUgaGFzIGNoYW5nZWQsIHRoZW4geW91IGtu
b3cgdGhhdCBzb21lb25lDQpoYXMgZXhwbGljaXRseSBtb2RpZmllZCBlaXRoZXIgdGhlIGZpbGUg
ZGF0YSBvciB0aGUgZmlsZSBtZXRhZGF0YSAod2l0aA0KdGhlIGVtcGhhc2lzIGJlaW5nIG9uIHRo
ZSB3b3JkICJleHBsaWNpdGx5IikuDQpJbXBsaWNpdCBjaGFuZ2VzIHN1Y2ggYXMgdGhlIG10aW1l
IGNoYW5nZSBkdWUgdG8gYSB3cml0ZSBhcmUgcmVmbGVjdGVkDQpvbmx5IGJlY2F1c2UgdGhleSBh
cmUgbmVjZXNzYXJpbHkgYWxzbyBhY2NvbXBhbmllZCBieSBhbiBleHBsaWNpdA0KY2hhbmdlIHRv
IHRoZSBkYXRhIGNvbnRlbnRzIG9mIHRoZSBmaWxlLg0KSW1wbGljaXQgY2hhbmdlcywgc3VjaCBh
cyB0aGUgYXRpbWUgY2hhbmdlcyBkdWUgdG8gYSByZWFkIGFyZSBub3QNCnJlZmxlY3RlZCBpbiB0
aGUgY2hhbmdlIGF0dHJpYnV0ZSBiZWNhdXNlIHRoZXJlIGlzIG5vIGV4cGxpY2l0IGNoYW5nZQ0K
YmVpbmcgbWFkZSBieSBhbiBhcHBsaWNhdGlvbi4NCg0KQW55IGltcGxpY2l0IGNoYW5nZSBpbiB0
aGUgbWV0YWRhdGEgY2FuIGJlIGRlcml2ZWQgYnkganVzdCByZWFkaW5nIHRoZQ0KYXR0cmlidXRl
IGluIHF1ZXN0aW9uOiB0aGVyZSBpcyBvbmx5IDEgKGF0aW1lKSBhbmQgaXQgaXMgc3VwcG9zZWQg
dG8gYmUNCm1vbm90b25pY2FsbHkgaW5jcmVhc2luZywgaGVuY2UgaXMgZGVhZCBzaW1wbGUgdG8g
ZGV0ZWN0Lg0KDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
