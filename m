Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640E959F01A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiHXALZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiHXALY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:11:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2129.outbound.protection.outlook.com [40.107.237.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441E754A5;
        Tue, 23 Aug 2022 17:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu4LY2//zf3BQKO2z85wFMShxIXi+KWnYJtdeAFD1UiaqZ1XOSW5qHwic3ythdrl900C53lsC/UpiJ/i15r9PPkyCsXrDST3v02WgaWq0OuvXa3Q/uJMQ1ubvndlKaZV3FG1w2wA5RyGYuA2tSmbuYugHUN9vRjUgHSKsU7hEWy+gDHRQFQy5qeRCge3AeziRg/J8m41IPBUuwdbW2aRmmnbti3msU/OsHuWiXqnqzwTGHDgiqhgrGJpbaAWC9iQPifEqHBSK8iISgGxs1DfUzsP2c2I5koQwMFtMLiwKgWyC0mOufjfvJ8duhoaLHKdO6VaAE5e5ARWZrawy8zZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8qL0waLgutFBSEyWsJ6/8xRL2I5K7B7CSItD5auKl0=;
 b=F53U1gFLxX8hvNhZPjWTGFkM4YoYhzJS9GDIPbulGGcrfN10Sf1d5RJneD0KUZVMYVbYjZfhmxXjtceCtHCtoNZEL43IMy1TIWDo/juJ9nl9vfOSWVd/sdH1UrVIg6fNIBtmZqryqqdm4EgdJjE5fV39QdPjhLR/KKAltB3ItJ3eetsCCaNns2vPIlQGUjyrHnsym2rpG4VKL4fO4ydJrQKDe8McifQHJrdR0syDoRKYZyS8o1NdCYtsHECpK2FDhBp1T5ivSPjUTVnTwumXfSCb3hs0jvAr6TglAOUt+fHU6E1K44uEKtBVQvugFCspEItjmAMCp/ls3Dg+Ed1oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8qL0waLgutFBSEyWsJ6/8xRL2I5K7B7CSItD5auKl0=;
 b=dLjkcqB3D3SJEkXfqgOy+00rbuvZNowRgLE/o+GZfZSCqLE23BFtcqXAAex7rW1cq2cqfnoB3hCQ8LUhxmqsMWAj1PPWTfkSPSDFh3rw4mnPk1FiD5yTVJMlfXIfhY/7oz/xDn8cgc2aG1xGT3IxYaDxJvpKls5IFrFRAwA5gl0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN6PR13MB2399.namprd13.prod.outlook.com (2603:10b6:805:62::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 00:11:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 00:11:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
Thread-Topic: [PATCH] iversion: update comments with info about atime updates
Thread-Index: AQHYtiu78BIi9dXZ8UOO9hQoVoU0MK27DreAgAALz4CAABV0AIAAC+oAgABWqoCAAMYdAIAABJ6AgAADrACAALEBgIAAEc8AgAAD2QCAAAgXgA==
Date:   Wed, 24 Aug 2022 00:11:17 +0000
Message-ID: <1aeecde587672ed4e9932e7cf4c62291308f37a6.camel@hammerspace.com>
References: <20220822133309.86005-1-jlayton@kernel.org> ,
 <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com> ,
 <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>    ,
 <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com> ,
 <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>    ,
 <20220822233231.GJ3600936@dread.disaster.area> ,
 <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>    ,
 <166125468756.23264.2859374883806269821@noble.neil.brown.name> ,
 <df469d936b2e1c1a8c9c947896fa8a160f33b0e8.camel@kernel.org>    ,
 <166129348704.23264.10381335282721356873@noble.neil.brown.name>        ,
 <20220823232832.GQ3600936@dread.disaster.area>
         <166129813890.23264.7939069509747685028@noble.neil.brown.name>
In-Reply-To: <166129813890.23264.7939069509747685028@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a50a3d-089c-4d19-0ab3-08da85652aa7
x-ms-traffictypediagnostic: SN6PR13MB2399:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ifSoU2sOIWknXFzqhjgIoy7YhmOcFrekO5bX8sVsBTNe7V0S2fXPoP7EdmkxecJLnkYvr9tB79KSukb/m538MI9Ja1MBvLGChLZCEIGTbYSLb1eETePAbBAU0ijKF7hhuAk1Z+NRmIEDM2AVEsmxFDXMImPHAPV61qLcECjgUZs9VHJ9wy+PyPwI6eyPDLIeiNo0hq/w9LXcrDJBYx0WPJE2Vz9VxTdEp9vyMrGCRBSRQusz0JOf62xZuaUEKavl+dgYJJd8yPBC1upnmhl9lJHbAct829STx8/zcoEFlU1FmBhej9EwZz3s443bjhJGgiArhjENVU7OVOKiCM0sxuIvTFOQ4wI3DDNSFvf+rybCY0O+3Y0nUn6eQ6vKCgnADa1uLd1HFDi25N3Y25m+eePeNJPYwYCFkUYjGPy6t42zXGIqa/KajfGKEiLHn7yC+BDJ9Pe2LBHz4BnOyBaB9jBuFzxHgDib7uqtlee/l1a45B11zeBIWa7F8KFEqHolePvsXokmurSJ+ckuD5JXWLD3hRn1KD4uAEK/02jzSXA6lTuf73nVHVHJZZthtNYWZsa39vQztI4xmkXQRD6ZSoh+PQH6onpc4GV1dHXkEzFN2WtFOAguSYfX2fSsWu9Ha5CV3AJW6qjMBIJi2Ivod2oImiMIteF7tXEoj0Jjiiq+aMUubhr2cyrInQRanOaFzRcDHPjjhu52ppKU+JdYrQTJZP+kxgdGa/ly508e8Uv8spyFmqdUHtGk6mHZ7PMmg7pXTe/lDfPZfmIUswuLFprMhN8fSqQTEkzoVJIkZ1iEJCHvBBVwMcOdvCqaRp29pRhkrMBVXzdWcqONzOXqgJLV65g6Yxmfq/4jdLBtQKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39840400004)(366004)(396003)(6512007)(6506007)(26005)(5660300002)(8936002)(2906002)(15650500001)(7416002)(71200400001)(41300700001)(86362001)(2616005)(186003)(38100700002)(83380400001)(122000001)(36756003)(54906003)(110136005)(66946007)(66446008)(66556008)(64756008)(38070700005)(8676002)(76116006)(66476007)(966005)(478600001)(4326008)(316002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNhVGpNSk1WWTNxKzhDRFZkOEtLMGR6YTdIY2dtMmxxWFhsOFFjYUp1cXF0?=
 =?utf-8?B?bkF2R0ZjeGVteTQxWnQ5VkNoaGR0aG8yUlNsU3orSmFqeU5uYU1hT3ltdEJD?=
 =?utf-8?B?OFlxTnpyUjRXOUM0NFlQN3V1ckdzQUJMaVlnTUg3cU9XUDErN1hPclZHcWxH?=
 =?utf-8?B?MUVtTElsNk8vQXpUU21JdkQ2OVdUQzVGNjNxTU1nN1hoZUE2dHh0ajZFaVJ1?=
 =?utf-8?B?M0JSSTZLcHFBM0JFWGF0RkR3TW9oc0kyMHZLWVJPNDBPSFJ5NnVuNlRFK2Ey?=
 =?utf-8?B?TGdkK2dJVDhuQ0VqS09HalR1QVlBVjNmWXdOS2J6TjdFRGVVL3l0UEpOREcv?=
 =?utf-8?B?TlR6RWtXQzcrb0pWVUxmMUFyNDdOYXJ0cVk0a2pPWGllZElsd3V2UDA2dzlP?=
 =?utf-8?B?ZVN4VFV6UStuRTFKdWRRcUJLa2txWEE4cnVpbE5ZRnora3ZmVmtVcHprWHY0?=
 =?utf-8?B?V2w1MjRPcjdEeG5oOHZLU0ZXa3phUmtGTUhMSkxSYkxWZ2Ric215YnJrNTNR?=
 =?utf-8?B?ZlhMcXYxcVJuYmZWNC9rNlFaQWNxWVNRdTNiVFhubXV2dUNWb25NZ01Fd1ZN?=
 =?utf-8?B?L1M5Ui95a28xbmdOaGdORmJsUkFvS1RpM3JXc29VQ3ByQStwSjNPY0w1VFJH?=
 =?utf-8?B?ZzAxYWpTUGRkUG1vZEhmcUdZU0dOaDRqUXpqOGN6RzZ0bE4zQ2RlTmJxQW9y?=
 =?utf-8?B?eUFOTlBWczN4c1JZKzFJVzhWM1N1Y3dIa2U3UnFENkpWa01ybFRFdGQyQ21S?=
 =?utf-8?B?bUpSWmw3bTl0ckYwTDNSTE9ybytaOXNtaFViZ25WR0RSYjg0dVQ4WG04VUpa?=
 =?utf-8?B?ZHNONnBlTzNaTTB3cmR1bE91amY5VG5JV1RhemIrSzRBOERhbERIWk5ORE16?=
 =?utf-8?B?dmMyZlF4N25iT2k1YU93SzVOalJvRFhTd21VMUdzVW5oWlllUVVzdEVVd040?=
 =?utf-8?B?YlRHeitIbWowNU10NXF2QW0zUDBsZC9oVG4zejA5RWRsL2QwcnhHZDVKNlBh?=
 =?utf-8?B?Q2lvcFkyclRqQ2FkaTlySVhnbmMwUlpVVW1SSnRhY1lNdHNqZmRweG9QbVdq?=
 =?utf-8?B?em9uZmo2YjJHYXFzd3pBL1RGL0R1TlNqbDFMMWpuUUlSOTZCR2IxdkNNblVG?=
 =?utf-8?B?RnlzSEJSbzJaemM0K0E2aXV4NjZ4U1FkOUZWWFpNdUlITmQ4cEU0Z1BLbWZq?=
 =?utf-8?B?STRTNmdraHNLd29zS0JwQXlRTnprV0RSOUo3eExNY2dUNERYM0ZNQ1R0c0R0?=
 =?utf-8?B?UittRlJoRVJrb1ZhTzU2bUJYQ0o3RVZYeGkvelp6ZElwL0l2bWlzM0tFWFJr?=
 =?utf-8?B?WXhONldMNDcxZWZ5OEZFMHdMRVJ1UTdUMTRxMlNIM2tsZWZIOWpYL2VPeXJp?=
 =?utf-8?B?enlDQk4yaC83cGxIeHdMUHovMFUreERGbTlTblNYZHlvVldUcEwvMjREVWYy?=
 =?utf-8?B?ZzBNcGZnMWhmcXdidERjNmxDMmZuYzlxY0hLR3JOWVgwZEZta0RIUTdCdmMv?=
 =?utf-8?B?Ulo4WTBkSEdKTzIza1hIaTQzODdLYzA4bzB6WWtVODhTRkY5NmNMeHVQbHha?=
 =?utf-8?B?enA4NlQraWpmamd2Y0EzNFljQXhtZldNeWtNZUN6cnNQeUlKNmlhMzJha29G?=
 =?utf-8?B?L2tEclIyQk9Cd3JvNnlPMTNycXRKc0ZWM1d1cWRHYkNGd2J4ZEJ0U3RYSnVS?=
 =?utf-8?B?c1N4dkZBU0ZXWDVKeVB1VWcra0s1SVFzLzc3RVVJYTNuWUhmY3BHL2dYRlUy?=
 =?utf-8?B?WHNEZkY0NEJHcDhmd2dLV0NxUXgvSEZXK1U4cHhKNGQzYytSZkJhNUpmSVk0?=
 =?utf-8?B?bWxhVFdCN2tzRE1oZUFwcE52YlVrZFpyV1FIblV1K3NtMHVad3RpY29tMnRr?=
 =?utf-8?B?NlN3WURHZmxFc2hXVFlUNk42RmFDTGxwNXZtQ1YvcHo4QzhnL1ZOdllhTHRr?=
 =?utf-8?B?cUNpVFJuZ2k4aUo5cjh1OTZ1aWZyYmE1TUxkeDFEM1g5bTNtZHlSK2h6Snd4?=
 =?utf-8?B?eG9PSStmV2lUR3dUdG1vTGNXd1diTFQvZDJDbkhPdG1GR2Z6RUFWNS9wR0RG?=
 =?utf-8?B?bzNKbFVzNTVMMzdtdmtoSzhoai9Gd3hpRStQZDloUU51RENTc0hSYWdsRFFu?=
 =?utf-8?B?VXJoekcraG1LeDdIbEpvSHNCbzdhY0FHVVVMREJheUlYN3VaRDc2ZUR5RnlJ?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <325C35D6EA03BA468CF5D4F04D5F37E5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a50a3d-089c-4d19-0ab3-08da85652aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 00:11:17.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d78YgBWnpGYZhHhhWl1KR2pQk4gJmiCr0y8kLZy0TI2gg6QtmXOLFfXNX/IfrrxQaTnH1MsNLPCsriSuJ9nnkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDA5OjQyICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMjQgQXVnIDIwMjIsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gPiBPbiBXZWQsIEF1ZyAy
NCwgMjAyMiBhdCAwODoyNDo0N0FNICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIDIzIEF1ZyAyMDIyLCBKZWZmIExheXRvbiB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIy
LTA4LTIzIGF0IDIxOjM4ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVl
LCAyMyBBdWcgMjAyMiwgSmVmZiBMYXl0b24gd3JvdGU6DQo+ID4gPiA+ID4gPiBTbywgd2UgY2Fu
IHJlZmVyIHRvIHRoYXQgYW5kIHNpbXBseSBzYXk6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ICJJZiB0aGUgZnVuY3Rpb24gdXBkYXRlcyB0aGUgbXRpbWUgb3IgY3RpbWUgb24gdGhlIGlub2Rl
LA0KPiA+ID4gPiA+ID4gdGhlbiB0aGUNCj4gPiA+ID4gPiA+IGlfdmVyc2lvbiBzaG91bGQgYmUg
aW5jcmVtZW50ZWQuIElmIG9ubHkgdGhlIGF0aW1lIGlzIGJlaW5nDQo+ID4gPiA+ID4gPiB1cGRh
dGVkLA0KPiA+ID4gPiA+ID4gdGhlbiB0aGUgaV92ZXJzaW9uIHNob3VsZCBub3QgYmUgaW5jcmVt
ZW50ZWQuIFRoZSBleGNlcHRpb24NCj4gPiA+ID4gPiA+IHRvIHRoaXMgcnVsZQ0KPiA+ID4gPiA+
ID4gaXMgZXhwbGljaXQgYXRpbWUgdXBkYXRlcyB2aWEgdXRpbWVzKCkgb3Igc2ltaWxhcg0KPiA+
ID4gPiA+ID4gbWVjaGFuaXNtLCB3aGljaA0KPiA+ID4gPiA+ID4gc2hvdWxkIHJlc3VsdCBpbiB0
aGUgaV92ZXJzaW9uIGJlaW5nIGluY3JlbWVudGVkLiINCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJ
cyB0aGF0IGV4Y2VwdGlvbiBuZWVkZWQ/wqAgdXRpbWVzKCkgdXBkYXRlcyBjdGltZS4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW4yL3V0
aW1lcy4yLmh0bWwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkb2Vzbid0IHNheSB0aGF0LCBidXQN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBodHRwczovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVw
dWJzLzAwNzkwNDg3NS9mdW5jdGlvbnMvdXRpbWVzLmh0bWwNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBkb2VzLCBhcyBkb2VzIHRoZSBjb2RlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
T2gsIGdvb2QgcG9pbnQhIEkgdGhpbmsgd2UgY2FuIGxlYXZlIHRoYXQgb3V0LiBFdmVuIGJldHRl
ciENCj4gPiA+IA0KPiA+ID4gRnVydGhlciwgaW1wbGljaXQgbXRpbWUgdXBkYXRlcyAoZmlsZV91
cGRhdGVfdGltZSgpKSBhbHNvIHVwZGF0ZQ0KPiA+ID4gY3RpbWUuDQo+ID4gPiBTbyBhbGwgeW91
IG5lZWQgaXMNCj4gPiA+IMKgwqAgSWYgdGhlIGZ1bmN0aW9uIHVwZGF0ZXMgdGhlIGN0aW1lLCB0
aGVuIGlfdmVyc2lvbiBzaG91bGQgYmUNCj4gPiA+IMKgwqAgaW5jcmVtZW50ZWQuDQo+ID4gPiAN
Cj4gPiA+IGFuZCBJIGhhdmUgdG8gYXNrIC0gd2h5IG5vdCBqdXN0IHVzZSB0aGUgY3RpbWU/wqAg
V2h5IGhhdmUgYW5vdGhlcg0KPiA+ID4gbnVtYmVyDQo+ID4gPiB0aGF0IGlzIHBhcmFsbGVsPw0K
PiA+ID4gDQo+ID4gPiBUaW1lc3RhbXBzIGFyZSB1cGRhdGVkIGF0IEhaIChrdGltZV9nZXRfY291
cnNlKSB3aGljaCBpcyBhdCBtb3N0DQo+ID4gPiBldmVyeQ0KPiA+ID4gbWlsbGlzZWNvbmQuDQo+
ID4gDQo+ID4gS2VybmVsIHRpbWUsIGFuZCB0aGVyZWZvcmUgdGltZXN0YW1wcywgY2FuIGdvIGJh
Y2t3YXJkcy4NCj4gDQo+IFllcywgYW5kIHdoZW4gdGhhdCBoYXBwZW5zIHlvdSBnZXQgdG8ga2Vl
cCBib3RoIGhhbHZlcy4uLg0KPiANCj4gRm9yIE5GU3Y0IEkgcmVhbGx5IGRvbid0IHRoaW5rIHRo
YXQgbWF0dGVycy7CoCBJZiBpdCBoYXBwZW5lZCBldmVyeQ0KPiBkYXksDQo+IHRoYXQgbWlnaHQg
YmUgYSBwcm9ibGVtLsKgIEV2ZW4gaWYgaXQgaGFwcGVucyBhcyBhIGNvbnNlcXVlbmNlIG9mDQo+
IG5vcm1hbA0KPiBvcGVyYXRpb25zIGl0IG1pZ2h0IGJlIGEgcHJvYmxlbS7CoCBCdXQgaXQgY2Fu
IG9ubHkgaGFwcGVuIGlmDQo+IHNvbWV0aGluZw0KPiBnb2VzIHdyb25nLg0KPiANCj4gTW9zdGx5
LCBORlN2NCBvbmx5IG5lZWRzIHRvIGNoYW5nZWlkIHRvIGNoYW5nZS7CoCBJZiB0aGUga2VybmVs
IHRpbWUNCj4gZ29lcw0KPiBiYWNrd2FyZHMgaXQgaXMgcG9zc2libGUgdGhhdCBhIGNoYW5nZWlk
IHdpbGwgcmVwZWF0LCB0aG91Z2gNCj4gdW5saWtlbHkuDQo+IEl0IGlzIGV2ZW4gcG9zc2libGUg
dGhhdCBhIGNsaWVudCB3aWxsIHNlZSB0aGUgZmlyc3QgYW5kIHNlY29uZA0KPiBpbnN0YW5jZXMg
b2YgdGhhdCByZXBlYXQsIGFuZCBhc3N1bWUgdGhlcmUgaXMgbm8gY2hhbmdlIGluIGJldHdlZW4g
LQ0KPiBidXQNCj4gdGhhdCBpcyBhc3Ryb25vbWljYWxseSB1bmxpa2VseS7CoCAidG91Y2giaW5n
IHRoZSBmaWxlIG9yIHJlbW91bnRpbmcNCj4gd2lsbA0KPiBmaXggdGhhdC4NCj4gDQo+IFdoZW4g
YSB3cml0ZSBkZWxlZ2F0aW9uIGlzIGluIGZvcmNlICh3aGljaCBMaW51eCBkb2Vzbid0IGN1cnJl
bnRseQ0KPiBvZmZlcg0KPiBhbmQgbm8tb25lIHNlZW1zIHRvIGNhcmUgYWJvdXQsIGJ1dCBtYXli
ZSBvbmUgZGF5KSwgdGhlIGNsaWVudCBpcw0KPiBhbGxvd2VkIHRvIHVwZGF0ZSB0aGUgY2hhbmdl
aWQsIGFuZCB3aGVuIHRoZSBkZWxlZ2F0aW9uIGlzIHJldHVybmVkLA0KPiB0aGUNCj4gc2VydmVy
IGlzIHN1cHBvc2VkIHRvIGVuc3VyZSB0aGUgbmV3IGNoYW5nZWlkIGlzIGF0IGxlYXN0IHRoZSBs
YXN0DQo+IG9uZQ0KPiBhc3NpZ25lZCBieSB0aGUgY2xpZW50LsKgIFRoaXMgaXMgdGhlIG9ubHkg
cmVhc29uIHRoYXQgaXQgaXMgZGVmaW5lZA0KPiBhcw0KPiBiZWluZyBtb25vdG9uaWMgKHJhdGhl
ciB0aGFuIGp1c3QgIm5vbi1yZXBlYXRpbmciKSAtIHNvIHRoZSBjbGllbnQNCj4gYW5kDQo+IHNl
cnZlciBjYW4gY2hhbmdlIGl0IGluIHRoZSBzYW1lIHdheS4NCj4gDQoNClNvcnQgb2YuLi4gTW9u
b3RvbmljaXR5IG9mIHRoZSBjaGFuZ2UgaWQgaXMgbm90IGEgcmVxdWlyZW1lbnQsIGV2ZW4gZm9y
DQp0aGF0IGNhc2UuDQoNClRoZSBleGFjdCBORlN2NCByZXF1aXJlbWVudCBpcyB0aGF0IGlmIHRo
ZSBzZXJ2ZXIgdXNlcyBhIGNhbGxiYWNrIHRvDQphc2sgdGhlIGNsaWVudCBmb3IgdGhlIGZpbGUg
YXR0cmlidXRlIGluZm9ybWF0aW9uLCB0aGVuIHRoZSBjbGllbnQgaXMNCnN1cHBvc2VkIHRvIGJ1
bXAgdGhlIHNlcnZlci1zdXBwbGllZCBjaGFuZ2UgaWQgdmFsdWUgYnkgMSB1bml0IGlmIGl0IGlz
DQpjYWNoaW5nIHdyaXRlcy4gVGhlIGludGVudGlvbiBpcyBzaW1wbHkgdG8gZW5zdXJlIHRoYXQg
dGhlcmUgaXMgYQ0Kbm90aWZpY2F0aW9uIG1lY2hhbmlzbSB0byBhbGxvdyB0aGUgc2VydmVyIHRv
IGtub3cgdGhhdCB3cml0ZXMgYXJlDQpiZWluZyBjYWNoZWQgKE5vdGU6IEkndmUgbm8gaWRlYSB3
aHkgd2UgZGlkbid0IGp1c3QgYWRkIGEgc2VwYXJhdGUgZmxhZw0KZm9yIHRoYXQgaW4gdGhlIGNh
bGxiYWNrIHJlcGx5KS4NCg0KPiBTbyB3aGlsZSBrZXJuZWwgdGltZSBnb2luZyBiYWNrd2FyZHMg
aXMgdGhlb3JldGljYWxseSBsZXNzIHRoYW4NCj4gaWRlYWwsDQo+IGl0IGlzIG5vdCBwcmFjdGlj
YWxseSBhIHByb2JsZW0uDQo+IA0KDQpJIGFncmVlIHdpdGggdGhhdC4gQXMgbG9uZyBhcyB0aGlz
IHJlc3VsdHMgaW4gZmV3IGNvbGxpc2lvbnMsIHNvIHRoYXQNCnZhbHVlIHVuaXF1ZW5lc3MgaXMg
Z3VhcmFudGVlZCB0aGVuIGFwcGxpY2F0aW9ucyAoTkZTIG9yIG90aGVyKSB3aWxsDQpoYXZlIGEg
d2F5IHRvIGRldGVybWluZSBpZiB0aGUgZmlsZXN5c3RlbSBvYmplY3QgaGFzIGNoYW5nZWQgc2lu
Y2UgdGhleQ0KbGFzdCBsb29rZWQgYXQgaXQuDQoNCklPVzogSSdtIG5vdCBzYXlpbmcgdGhpcyBp
cyB0aGUgcGVyZmVjdCB3YXkgdG8gaW1wbGVtZW50IGFuDQphcHBsaWNhdGlvbi12aXNpYmxlIGNo
YW5nZSBhdHRyaWJ1dGUsIGJ1dCBpdCB3b3VsZCBiZSBhIG1hc3NpdmUNCmltcHJvdmVtZW50IG92
ZXIgY3RpbWUsIGFuZCBtaWdodCBiZSBhIHByYWN0aWNhbCB3YXkgdG8gZ28gYWJvdXQgaXQuDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
