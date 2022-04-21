Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8130A50A001
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385821AbiDUMxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383558AbiDUMxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:53:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2062.outbound.protection.outlook.com [40.107.113.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBA32F3BD;
        Thu, 21 Apr 2022 05:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bvkxpse2yp/VVYSIiIFyIHwDMXHubeOiPJAj1N8QvKllS2b0vWKuliLODEr2J8n90y0SCjehqly5ETldwXrloB/7bIa4QMQ1YZ8skmSFVc/+wnq04K+5+a5sI9cBwhleeLcL7nIw48xWpJxpsTAlIrDdfU9wxv3fYAwq76B1+jwXSngI9oNp9ZVD9CoEze3GvBGskKfaY+kpGCA2DC9ImSJ4xLftSLFdGdJvjdK/kGU1T2J7of0/ot+/UYK7j2Pqo5WuAUkwJMiYXo7FpfNs1xTqXvd4+NU5Zscd995dUTdmlwl4owP9CUcVoq26g77mI2pSg3ydK1vsufaXI6U8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFiS7X82pfZRJGqthG6dlOK2qZvwVlpKWB6onOJouBo=;
 b=BJeAlkGtLkXB6vfS0KOq5xxYgcNKrWeV8/6SBBvEskhqVctLVJhM8S2d+fHXMi9PJe6SuTNgk4XRlANp64D/gzCro5w1vBdZpnH0ueL802yNFp3VIdkED7q9+aIdtFosO5VGuKOuXti1siYP3bS0LGCfDX3er/r+XGD6xDTLg2XLWMvJbHO0mli7/ubPNIuV7TsHrABEk5bHFkjUFjVHWi0IS7r1diZzOTOWSTF0H5mTMM1xLEjmnNGHVF6YklvS4wxaKnB36ITg4rXoMZpv5QWRRDYvVLrCs7IV08JDVNpVZ7sIhEOAD3BDQAJPlMYhWtjFOJP1yHvCkTkm79H2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFiS7X82pfZRJGqthG6dlOK2qZvwVlpKWB6onOJouBo=;
 b=d+OxG8r9FjkZzz4MFULV/NAM9COAQj3YAMUZ0MD4C8iiAZiMFy5vRZyjQlpX2AkpOsXOVuh0ktkpbLu++aghM9y2y1+W5aJ++XgjkieUeLX4RAp2+w9a/xoj2tr8u6VKQ1GBvTI1PxY/C4uQAMdzUWExwemOIrtcvh3g88YsLkQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB2436.jpnprd01.prod.outlook.com (2603:1096:603:3b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 12:50:14 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 12:50:13 +0000
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
Subject: Re: [PATCH v13 5/7] mm: Introduce mf_dax_kill_procs() for fsdax case
Thread-Topic: [PATCH v13 5/7] mm: Introduce mf_dax_kill_procs() for fsdax case
Thread-Index: AQHYVUNrG5HoNEVEwEi5JRdOqeVANaz6UicA
Date:   Thu, 21 Apr 2022 12:50:13 +0000
Message-ID: <20220421125012.GA3612199@hori.linux.bs1.fc.nec.co.jp>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-6-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220419045045.1664996-6-ruansy.fnst@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bab84720-eeda-4e5c-2ea6-08da23957a6d
x-ms-traffictypediagnostic: OSAPR01MB2436:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2436C88BF3E0D7AC822B43D3E7F49@OSAPR01MB2436.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vl6rUWOjz3PtDAgxJJteL0JP7oiN2qiVvapiN5463hVul4xci5gbbrtbc81hGrvuH85lmxdKV3DNesTr22bMBeurpKy8DlD7ZYF/1dLDgjOEdqbpXUMrR++S8prChn56syT/7+MaYKGpGX/M9+D4iajgkOlZ47HA3wD7JTf+t3pFGxGYSh9S+EpwcaqChaQj/jpqNj1BQsLSSpMOBluXnZb+dFkkPOfX10qrWDcHiZxnzLO1c2NVs9Ng6haMgPji9xHa7vQIpdC/RuW3ZQvsfsTa+5ZsOg7eumgTU0Fz9GPHzhx+2AM2wB1B88dqbJFL132ZrsdENAiVSRKS022GvXlxIvnVnVmqy/9Qp+EsNDVO7S134o+QQf2JyEf5Klb+qUxEX+fnd4Sr8ZBcnpnQZIkMzLkSuBl41vAkhsXocwHrbPQnVEUgfSWuckibP996SRjKgQJNGFFaw0D6k0PXUl8F/6E3+gvGFxMhZYUviBC59XvHYh1Qfe6T7CH3LLxDlDxfVqz2LUNoX6LW0/xJbylce5g1XiIyPZTZOKXfDX9tX8QWBZ+nJME+0HligLX8CdikUblLEjdo3ZbMrQumEwX3DbUa06/Zr7HcUNuxuyWV9S4J8TULkrww9PuDEyxsqORhIPW7OlJeSbMG2lMRz95XqRYe0ipbNEsp7IA3jkjTIJoRHwXMPAfVslxTDJv6765PJRJn4w/p5Yl0w0q0qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(64756008)(4326008)(7416002)(71200400001)(66946007)(85182001)(76116006)(66476007)(66556008)(86362001)(66446008)(5660300002)(82960400001)(2906002)(38070700005)(6486002)(54906003)(186003)(6916009)(55236004)(83380400001)(26005)(316002)(508600001)(122000001)(9686003)(6506007)(38100700002)(6512007)(33656002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0sya2s0NWY3dGR4STVJMjVCTnQraWY4bU1ENkx2Z1l0SkowTHRuS29YSVZi?=
 =?utf-8?B?ZnlVSXlBVHU3cTM3MEdubWhXVmdWaGhhQXZVREgycTBhV25aUmZUR2FMUG92?=
 =?utf-8?B?KzdsQlF6Y3IwdU5mbHZuQzhJNnUySklveldReCtDRGx6S2FVZDJHa2FMV0Fs?=
 =?utf-8?B?aWo4b1IwNXhvQjNpaCs1aDZsVSt4Sm1zTGxWdFA1bFFDWVRYYnVmWkhXcC9D?=
 =?utf-8?B?bUxzNXp5T1JieE43Zk56MzJNdGR6RmdVTTJ3eUJuUXpyeWlXREZGR0hCc3U3?=
 =?utf-8?B?cnAxKzJkSXVUZEFteTFkNXdMd3NZRzl3NlBjUXlCNnQvWUFDbUtESXdhOHNR?=
 =?utf-8?B?NkYzV0p4TTMyYWFXUm8yVTNubm53NkxhZEF6U2NmVlVXcElUWUxlb0FYTVJa?=
 =?utf-8?B?aWdXdmpWK3piR1RLZFhYTUozckVvMXFnYUV1aFNmTnRiRUs1SVUrR2tFUkxR?=
 =?utf-8?B?RVJWTHdGbWJ3OEFKbEJ6WDY0bnVMRVcxRDJsdHlBOWFUbmJyNVErU2JyN3BG?=
 =?utf-8?B?ZTZ6K2t1VzhYL1FhUlRZUDdYb0hmZldIZ2FJMGg1SHBXTkEvMDJPVVlCV0RL?=
 =?utf-8?B?NzNrU2FsUVlrVGxiUE1JeWoyMXZvUGEwQ2NpTjNMTnRNaTk3NmtocHhaR3Ex?=
 =?utf-8?B?ZXJoRWQreVM0R0hhUHdCbUpxaDJwU0hYUkNZTktvYXExRzJ6SEMyZldoODFL?=
 =?utf-8?B?cVVnblpQNEdqS0xPUUxGM2ZmQW9CNjNTQStKNHVXbmp6S3lueHgzcS9MMGt6?=
 =?utf-8?B?YUdnQnhUSkxZRUMxYkhSd1RjbW1MSHI5KzJzRURaRXUxSDF2UDg4U2w1YWo1?=
 =?utf-8?B?SGlBZ0NIbzlHR0lrVjdQZ0g5RytiQzJ5K0l1OFpscks2T3ZOZlNjT2RDaEgx?=
 =?utf-8?B?RlJCc0pXOXRoQ1YzTksvODk2Z2hwMENjL1hVaHY0ZjZ1T2tnVG9FSHFiWVk2?=
 =?utf-8?B?WHVuVXNIZzNac1FsTXRDc1o2T3pUcWVYZjZNa0JzWGlKcVBJNThHcndnNmdu?=
 =?utf-8?B?aUhocllQcjRZbGM4ZitvYTc2QW5QK3BYMTFYWnpXd3M0Z1lFR0JnS3pwWXEx?=
 =?utf-8?B?eEpTOHJMblkvV3p0ZE9sVy9GL3JhQ21FdE5rNVFpcThmeng4V3VzKzFZb2R2?=
 =?utf-8?B?MDQ0U1grb1RER2RkazJJdVlJOGlFS1grV1loWlVZQ1RFSzRPdTFlZlhPQ3pz?=
 =?utf-8?B?NG1tYjZVdHFpbDFCbWFzNWdPZE91aU4zRGVTTWpYcUt4TXNTYUo5YXhyekxy?=
 =?utf-8?B?N0o2MjUvbEFKbHVFZVdHVjYrU0pFcmpHRUdVVEJPK0pWYmJPa094TnBQV2Nw?=
 =?utf-8?B?WmxRa2Q0MEFoRVNyNnI1Q0E3N29WNzRsemtGV2IvaStmY1pFTWc0R3RHNUYw?=
 =?utf-8?B?bUlwalQrc2ZWY3FsZHhhYnprOHJKVDNEVlE1eFdiM3d3K29rS3NjYWpWOEZq?=
 =?utf-8?B?UzVWWnhIU1FXTE9uOFd0d01Vb09sUTU3Ry9Kd0F3MzYxSVpSMk04K3lxdWFI?=
 =?utf-8?B?MnRweDRaQk5MdkpMYnE1czFBZGR2cGtVMWFrR3BJTjMwL3R6cnJzbk9ScWFw?=
 =?utf-8?B?bzJvM0taUUZHejE4SjZia2RNWEhNR2E2Um9Cb3pjMGNNZzZ4aGV4eGR6ZHdv?=
 =?utf-8?B?K0IrQUxKTjVBeThDVFlQUDM1YmN2SUJOTEpra0Fnbm4xTkl0ZDZOTzl6b0pZ?=
 =?utf-8?B?bVJuQXJXNmVyejdSZHdzdGQvaXZ0cWVJakd5MmJjQUE5SWtQWFFBWlUzQUtZ?=
 =?utf-8?B?bGxDWVNlWVJZT0dybk1GRzRSWFdvQWRjWUdXaFhMU2E1RkFxY3lCUTA0aERi?=
 =?utf-8?B?Z2hZTHdrcWN2dmxEYklRRDdUZnBFbjVxaEdLZHZ6L28wNk1GSUdocUNFOUtX?=
 =?utf-8?B?bUw5KzEwUi9PeGF1aVpDeXBXNGYxY1A3Slh6UDAzZmUvY2dyZmJDUlljZ1ZO?=
 =?utf-8?B?eHRmWElFSC9CRWFYNWpxTHNPblB5dHJFSU9PL3pIcndUNWo1eHl4QUViVWFu?=
 =?utf-8?B?c0JnVmRVcXppVVpIbmh0c1lJL0E1eVp4djBwbmR1aUpXS2VVdnpYWThua0Jt?=
 =?utf-8?B?QSs3bC9yWUdCRjA5dHc5WnZHRkpKbml2MmpUQXBVWXVubUY5TFc0K085anJY?=
 =?utf-8?B?QWVza1hrenNHTitmZ1BkQnRCWHFVbk1jK0luc1JJU3V4amQybGIrV3pMS0I5?=
 =?utf-8?B?MEZRUUIrWW5CS1doKzJQdjlEK25zNllwUFBNL0RwNlNHTnVXVHFkbDRCY0l3?=
 =?utf-8?B?WW4zMUMzR2dLLzNkUkhONEpPUVJBYVJhS2g0RDZxQ0hSc1gzV3grZm1PVjhQ?=
 =?utf-8?B?VzhUS3M2blFvRnF4bHozNHFoQ3ZiT25jTXF5VmdvbWRVbzBjYzhTK2d0L1pV?=
 =?utf-8?Q?b5cRThdqZFs4uCDU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6280750FD4CB3418B97E527E88AEC3A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab84720-eeda-4e5c-2ea6-08da23957a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 12:50:13.5859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3xAFvgjW3Uk2JshE2Bd/KO5EV4N9FOPoEcIyTGjh5dU/kkQIZKJ9eZa1Onfok2f+FizMa1wWU3gQKnHO0amhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMTI6NTA6NDNQTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdy
b3RlOg0KPiBUaGlzIG5ldyBmdW5jdGlvbiBpcyBhIHZhcmlhbnQgb2YgbWZfZ2VuZXJpY19raWxs
X3Byb2NzIHRoYXQgYWNjZXB0cyBhDQo+IGZpbGUsIG9mZnNldCBwYWlyIGluc3RlYWQgb2YgYSBz
dHJ1Y3QgdG8gc3VwcG9ydCBtdWx0aXBsZSBmaWxlcyBzaGFyaW5nDQo+IGEgREFYIG1hcHBpbmcu
ICBJdCBpcyBpbnRlbmRlZCB0byBiZSBjYWxsZWQgYnkgdGhlIGZpbGUgc3lzdGVtcyBhcyBwYXJ0
DQo+IG9mIHRoZSBtZW1vcnlfZmFpbHVyZSBoYW5kbGVyIGFmdGVyIHRoZSBmaWxlIHN5c3RlbSBw
ZXJmb3JtZWQgYSByZXZlcnNlDQo+IG1hcHBpbmcgZnJvbSB0aGUgc3RvcmFnZSBhZGRyZXNzIHRv
IHRoZSBmaWxlIGFuZCBmaWxlIG9mZnNldC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcg
UnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+IFJldmlld2VkLWJ5OiBEYW4gV2lsbGlh
bXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCi4uLg0KDQo+IEBAIC01MzksMTMgKzU0OCw0MSBA
QCBzdGF0aWMgdm9pZCBjb2xsZWN0X3Byb2NzX2ZpbGUoc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVj
dCBsaXN0X2hlYWQgKnRvX2tpbGwsDQo+ICAJCQkgKiB0byBiZSBpbmZvcm1lZCBvZiBhbGwgc3Vj
aCBkYXRhIGNvcnJ1cHRpb25zLg0KPiAgCQkJICovDQo+ICAJCQlpZiAodm1hLT52bV9tbSA9PSB0
LT5tbSkNCj4gLQkJCQlhZGRfdG9fa2lsbCh0LCBwYWdlLCB2bWEsIHRvX2tpbGwpOw0KPiArCQkJ
CWFkZF90b19raWxsKHQsIHBhZ2UsIDAsIHZtYSwgdG9fa2lsbCk7DQo+ICAJCX0NCj4gIAl9DQo+
ICAJcmVhZF91bmxvY2soJnRhc2tsaXN0X2xvY2spOw0KPiAgCWlfbW1hcF91bmxvY2tfcmVhZCht
YXBwaW5nKTsNCj4gIH0NCj4gIA0KPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0ZTX0RBWCkNCg0K
VGhpcyBtYWNybyBpcyBlcXVpdmFsZW50IHdpdGggIiNpZmRlZiBDT05GSUdfRlNfREFYIiwgYW5k
IHlvdSBhbHNvIGFkZCAiI2lmZGVmIiBiZWxvdywNCnNvIGFsaWduaW5nIHRvIGVpdGhlciAoSSBw
cmVmZXIgIiNpZmRlZiIpIG1pZ2h0IGJlIGJldHRlci4NCg0KPiArLyoNCj4gKyAqIENvbGxlY3Qg
cHJvY2Vzc2VzIHdoZW4gdGhlIGVycm9yIGhpdCBhIGZzZGF4IHBhZ2UuDQo+ICsgKi8NCj4gK3N0
YXRpYyB2b2lkIGNvbGxlY3RfcHJvY3NfZnNkYXgoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ICsJCXN0
cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IHBnb2ZmLA0KPiArCQlzdHJ1Y3Qg
bGlzdF9oZWFkICp0b19raWxsKQ0KDQpVbmxpa2UgY29sbGVjdF9wcm9jc19maWxlKCksIHRoaXMg
bmV3IGZ1bmN0aW9uIGRvZXMgbm90IGhhdmUgcGFyYW1ldGVyDQpmb3JjZV9lYXJseSwgYW5kIHBh
c3NlcyB0cnVlIHVuY29uZGl0aW9uYWxseSB0byB0YXNrX2Vhcmx5X2tpbGwoKS4NCg0KTG9va2lu
ZyBhdCB0aGUgY3VycmVudCBjb2RlLCBJIG5vdGljZWQgdGhlIGZvbGxvd2luZyBjb2RlIGFuZCBj
b21tZW50Og0KDQoJLyoNCgkgKiBVbmxpa2UgU3lzdGVtLVJBTSB0aGVyZSBpcyBubyBwb3NzaWJp
bGl0eSB0byBzd2FwIGluIGENCgkgKiBkaWZmZXJlbnQgcGh5c2ljYWwgcGFnZSBhdCBhIGdpdmVu
IHZpcnR1YWwgYWRkcmVzcywgc28gYWxsDQoJICogdXNlcnNwYWNlIGNvbnN1bXB0aW9uIG9mIFpP
TkVfREVWSUNFIG1lbW9yeSBuZWNlc3NpdGF0ZXMNCgkgKiBTSUdCVVMgKGkuZS4gTUZfTVVTVF9L
SUxMKQ0KCSAqLw0KCWZsYWdzIHw9IE1GX0FDVElPTl9SRVFVSVJFRCB8IE1GX01VU1RfS0lMTDsN
Cg0KLCB3aGljaCBmb3JjaWJseSBzZXRzIE1GX0FDVElPTl9SRVFVSVJFRCBhbmQgSSBndWVzcyB0
aGF0IHRoaXMgaXMgdGhlIHJlYXNvbg0KZm9yIHBhc3NpbmcgdHJ1ZSBhYm92ZS4gIEJ1dCBub3cg
SSdtIG5vdCBzdXJlIHRoYXQgc2V0dGluZyB0aGVzZSBmbGFncyBmb3INCmFsbCBlcnJvciBldmVu
dHMgb24gTlZESU1NIGlzIHJlYWxseSByaWdodCB0aGluZy4gIFRoZSBhYm92ZSBjb21tZW50IHNv
dW5kcyB0bw0KbWUgdGhhdCBtZW1vcnlfZmFpbHVyZV9kZXZfcGFnZW1hcCgpIGlzIGNhbGxlZCB0
byBoYW5kbGUgdGhlIGV2ZW50IHdoZW4gdGhlIGRhdGENCm9uIFpPTkVfREVWSUNFIG1lbW9yeSBp
cyBhYm91dCB0byBiZSBhY2Nlc3NlZC9jb25zdW1lZCwgYnV0IGlzIHRoYXQgdGhlIG9ubHkgY2Fz
ZT8NCg0KSSB0aG91Z2h0IHRoYXQgbWVtb3J5X2ZhaWx1cmUoKSBjYW4gYmUgY2FsbGVkIGJ5IG1l
bW9yeSBzY3J1YmJpbmcgKmJlZm9yZSoNCnNvbWUgcHJvY2VzcyBhY3R1YWxseSBhY2Nlc3MgdG8g
aXQsIGFuZCBNQ0UgaGFuZGxlciBqdWRnZXMgd2hldGhlciBhY3Rpb24gaXMNCnJlcXVpcmVkIG9y
IG5vdCBiYXNlZCBvbiBNU1JzLiAgRG9lcyB0aGlzIG5vdCBoYXBwZW4gb24gTlZESU1NIGVycm9y
Pw0KDQpBbnl3YXkgdGhpcyBxdWVzdGlvbiBtaWdodCBiZSBhIGxpdHRsZSBvZmYtdG9waWMsIHNv
IG5vdCB0byBiZSBhIGJsb2NrZXIgZm9yDQp0aGlzIHBhdGNoc2V0Lg0KDQpUaGFua3MsDQpOYW95
YSBIb3JpZ3VjaGk=
