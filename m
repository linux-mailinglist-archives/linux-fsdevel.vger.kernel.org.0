Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05314597B75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 04:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbiHRCWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 22:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiHRCWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:22:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5533691096;
        Wed, 17 Aug 2022 19:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQjMeDn3Yy3N9oIgIctpAevlazEGNMjmSU33N+jWnZWYV0UA+IxRI04hro+bJXQRp7u/hqAkL8ExCL5NbxSnpYGLP1o5gIgkX/p2v8DzIpap7j7EKhholLzfK9mcpKD2gL9DSR86J85TZUJfjA0dUYYKEwV5WRDE4ZQliaXpKWhEgnqeldG78RfGoaQvTvzx0/wbXgzrdUNS7wVpBwOj9tkzwCyuRN7uMDpeltXQmcrkA0exQeUs7nuOg3ppxyjf0Z7urY5Xm/xxAxKVOSkuWjfgx+vCd0FN+nYYi8g9HN4IKkc7OoUDoa9GRtNttsXeU+1AO+TWjDVVJLPUltddJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN/O7fnpP0ho85XkySyozGNaLTLT+uDGn6c3Cyis/dM=;
 b=WGPkSxKTBUQFV0P7w6HErnk2oxtL//oZ1vtinLKrmLksYg+MvT3L5/0zqd4vBvu3B7O81IFYGSeRvdGhGOYW9XzUL6l1aCWoUUfZeEHcuZEPLt6QdcL3whmii0m+jLqDg9OLgnLrxplmkeo0BRVcnQmtDiQF/QgRKVqr16jvpPkh4h5tbAkOkE6CAjgeSJEWV8XnuicoDLSo9Cu0RAsZO52Ki9OEn5HeQGixC/Rk3+Q+Oo9jEMqeTbxS3YWpJ5k4xi7V7Qyr4wWxthJReyc2jAcqjc4yW4Bv0ms/sipdtA/5oxtwtWWVFEIIDlHUYOFKl9tExOAlXZWD6udoEMpkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN/O7fnpP0ho85XkySyozGNaLTLT+uDGn6c3Cyis/dM=;
 b=ApJx6QH1yylffqkfBwVu8Ylypr1w6EGyyw+iECPeZ8aYpb/iPwHyMxbzS4itO7PZYK8EbbGKCjESjiS5vWbsqU4iwY+AuZXbRAJE6aLYxqRZnMAZHd2sKVxYQ6sxcu6DnuJQSAmsARtB14ylUwCrdRdJAOtdsPcrL0lqKpg5nt4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN8PR13MB4323.namprd13.prod.outlook.com (2603:10b6:408:a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Thu, 18 Aug
 2022 02:22:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5566.004; Thu, 18 Aug 2022
 02:22:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Thread-Topic: [PATCH] xfs: fix i_version handling in xfs
Thread-Index: AQHYsXLXiDzQGb6SwE6W212lBryYZK2xqt0AgAAELwCAAHEdgIABsYwAgAAQQYCAAAVoAIAACGOA
Date:   Thu, 18 Aug 2022 02:22:15 +0000
Message-ID: <c77a3f07e45f0c99019517f3b92d0bdbecf884af.camel@hammerspace.com>
References: <20220816131736.42615-1-jlayton@kernel.org> ,
 <Yvu7DHDWl4g1KsI5@magnolia>    ,
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>    ,
 <20220816224257.GV3600936@dread.disaster.area> ,
 <166078288043.5425.8131814891435481157@noble.neil.brown.name>  ,
 <20220818013251.GC3600936@dread.disaster.area>
         <166078753200.5425.8997202026343224290@noble.neil.brown.name>
In-Reply-To: <166078753200.5425.8997202026343224290@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85cc0641-6342-4503-b0d2-08da80c077e8
x-ms-traffictypediagnostic: BN8PR13MB4323:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCHmsE11YMFGJH1b3WY669ueYdqftV3+kyiYsdo9nHqeLimJOcS71eKe4iIYO3dNsAmqfy9OUsP+Lkf2h3AQrrTOxQBVTGVliCoX82yFIPa8e2wLEfS/ojteVPD+WZiLFmq31/p5/TKx2sXtP3IJNbxcRzas7Skir5+I6DOVaJbgWq9kl+JIrMgcIlhXz0oHx9MUfC4F2ZlcXsea1ANox6hW5Mhx+RRdzMvqm19d0g4yE+07niRR4eOSnaEGN2UPLo5DOOKf3JD1+B2rYdaKNv3cRyuXm1FGrAtsGwle1GjQK39UvwVU4+sD7zQXR9rA8V9Z/LBrAuBWOUR+sdLFR6/pybl2AyjIkTZtsHp2JqK0VPIWzozAhECn9E9LzH+IuvcvjWEQCzcQI2CtOl96tkNZUHSFepAxKCpifxUKzOsopGA9L6AvjKM7je7CVRSSfBw8Ahu0QnedUdJA21A3tauKqs8teAU6a+g+kuLp2VKRKQUixhmcyFAbp0J4ssxdcuqDNPEHd4mSSnBdCACllz9o7kgjFG8Z47nMKW/dvUucWEZdCZb7AhHt/sxELLIXVmvqNzKbQ34nEAmR+Ojk1Lgt1ILm4LROBjdnT6L8DwkcIMX75umqcaVafF9CJrLv/V88LHYaj5M+ts5FxSnvi6tsAqBYrKGvORK1wxfIx6IsOB5FQpHTBJT5TUxrNxII1eI4HwSvvcSXp5WWSW7vpWne2PcXonc3y/4heKhvmpupfXcqcuNbzDrKyhgA90ZqoV3mtMxsyQnVOjyU5kc3EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39840400004)(396003)(136003)(366004)(38070700005)(38100700002)(122000001)(316002)(110136005)(54906003)(8936002)(5660300002)(2906002)(64756008)(8676002)(66946007)(4326008)(66556008)(66476007)(76116006)(2616005)(186003)(66446008)(83380400001)(6486002)(478600001)(41300700001)(71200400001)(26005)(86362001)(6506007)(36756003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZMMmwwUEtJUEZRMGxha210aVI1Zjl5SVlVSTBzYnFuVFdsUUxhNEozQVFM?=
 =?utf-8?B?Zk5XWFNxYWtRVUZMbks1UUMrdWhTZzRPMkZPMWxCUW02NCtrbXJzV3o2bHdN?=
 =?utf-8?B?MG4wNnAyeW9jak1ndmxwbW91NGRRUUE5aVAxc1FONG5JSzk5WHFFcWh3aTdG?=
 =?utf-8?B?dVFrSGJKUFZaRGdORmJlMHovaUNJdDZmbnpXbnh2QmhhVVF1dGtOVnlweHI1?=
 =?utf-8?B?S3Zoc0ViMFpxalZuUnE4OHVRRzVvMHVCY1ZKeUZmY1NyS2hHOGlPRTA5eDdC?=
 =?utf-8?B?RXAzcFhGaHF0ZHNjQVcvMTNBVXd5QU1QT0hpRVlPQUc1N2VLVlRKQis4UUg0?=
 =?utf-8?B?cTJPTS9JRUhaaWthV1pibjkrZmlPWERhaDRLZE8za2dEZ3pBNFBZTmMxL1BP?=
 =?utf-8?B?ZElRUFJMQjlkSFIzUThpOWJneG1WZUVCZm5KcU5RSXE1UkFad09vMjFPVG95?=
 =?utf-8?B?V3lmaitoSW4ra002OUk5MXFhMjEybkpyQ1JlOVU0OWFFNlBhSXN1TUx4bzhN?=
 =?utf-8?B?WjllRlFneldrTEtMUUd3cEhUVXo4dEdWSk9BcWxTYThNczZENFpWZXZRckp2?=
 =?utf-8?B?bjdobWVySnBzb1hJYkpUa0lCb3ZrWUNBTWdpamZ3RmNwaG1QL01hQTA0MHR1?=
 =?utf-8?B?QmQ3WGkrU0hadG0zRVF1VytFamhkNU5FNGE4S1YxMGlzYkhlT0ROOXFIYXBI?=
 =?utf-8?B?OEJiSDcyUnlNMVlKdzlSdVhSOVVaeUcyUGxPQlExRUdqd09tRGN0M0ppd1Ru?=
 =?utf-8?B?c3JEcDNxUGczNHBDZCtjMzAzZ3FSRGZjZmJCcjJYVGYyakt3VitzUHFuQ1BM?=
 =?utf-8?B?d2duQTdJQ3NSWjA0ZjVIcnA4UEYxM3FQQ1YyYXpETmJxbFdCQ3E4YWhET0ov?=
 =?utf-8?B?V1BRbUR3WXJ2bVRqZklFVXhlWE8wazU1dFN2UEZjTUt1UHdBemp5QlNQRktJ?=
 =?utf-8?B?WkRrdk5mUVZwTmlKVk5scjByMWxkNlFkdmxYSDBOQzdZKzdFQzM3VEJZRjNs?=
 =?utf-8?B?OVVBT0lnUTJOOHd6eS9yVUI5RWNYTHhtQ1cxaklrWmxkUTltU01TRmJ4RWJx?=
 =?utf-8?B?WkgzS2doeG5zWVE2RHhlN3I3QVR1V0gySzZRbjM1ZjQ3SWlOUUwwZmdnblAv?=
 =?utf-8?B?Vm9Tajg3MFpETTFPNGNQZ0Nzdmx0REJpaEhnNGV1d3M0YjZVRXUwS05QUU5L?=
 =?utf-8?B?OXhrZ0dpUnNMWWU1ZVc5Mjl6d3lpU3pSY0NOZmpuRzg2WXF3RlFQZDAwSEFE?=
 =?utf-8?B?czJWUmxjb3NhbkswbU5ob3RIZFdKVlQ5TW1wYzV1dlJnQ3pyVWJSYzlvSTdE?=
 =?utf-8?B?d1RQOGY4WHU4aWdZOTRwN2U1eGdHRVNWK1JiSmZEa0xDcEpUNUN0Y2NIb3Vj?=
 =?utf-8?B?Wlo4M0JNWUZFSWRGVCtJR0ZtN1J4N2QxWGFYdTU0TXl1YjQ4UXNHYW0veDFu?=
 =?utf-8?B?MWswR25WRm9NMW5RK0QwbTRiWjVkSFA3RDJXOW5JK3l0K1BYaktXQWhZWVFo?=
 =?utf-8?B?QzNtcHVRZzFsZEExdWsyQkVwdUpOKzhML0R3WlRoR0RvM2trTXBZRTdvTHdY?=
 =?utf-8?B?SnhubGEvbFRuSGloRVg4QlNrbWtIeHlJM2RSR20rK1NGMVpCT1VGbjFLTWxR?=
 =?utf-8?B?Q0xwaVZRdTVzbWV4NzhlaThSUkVIZHRVTythbnJUZHRlYzFCZENYdHFQR3dJ?=
 =?utf-8?B?S1RXMDJvOGNNR2ViUCtMNzhmZzdqenRmVUpwTDRoR1dqNGkxbldlTGVNNmZH?=
 =?utf-8?B?UnNIUjA4dFNzSVhaTis4VXVkMTRNOTMwdW11ZW5NbDBTMENSc2dsSFU3WndY?=
 =?utf-8?B?ZmJQdG1Gam15Q1FlbWRqMnJOeEdrR2NoUUpTYU1aNFVGZ1N3SlFoOHJ1aHVT?=
 =?utf-8?B?SWE4NS84VmorVm9hODk4d3d5U2Q1STJMVWdxQ2w5MUc5N2F2U0Y5Vm5YL1ph?=
 =?utf-8?B?Q3hQdGdGcnptZWZ1d0hmRUszZS9NMVM4R1U1UXBWUUFSeEtiRHpBV1hVVEtn?=
 =?utf-8?B?dHZCa1BBVFZnNHN6OFJ5M3E0Zk41YzhSUndBODFwcG9iNmt4elBIdlg5c3dG?=
 =?utf-8?B?NjBxZjVOM0kyejJtd0xlNHFpeitrR0drM2N6L09BSlBwRnhnUVdQd2Exc2po?=
 =?utf-8?B?dkR4ekx5bXh5ZDFyVXMyTFZVQjA2b01UM2ZoNk1SRzVWd0RkS2t1SEdzcEJ5?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <846845CA0792B74FB67B57E4570BCCBA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cc0641-6342-4503-b0d2-08da80c077e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 02:22:15.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3aw18iQmsU1URqBXoc+JIOOKkBD7adjWG5Yg9tHx/05U0ni2WgZuLVY4fWFICiA4LeVjb0sB/VSQd05yIR9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB4323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTE4IGF0IDExOjUyICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFRodSwgMTggQXVnIDIwMjIsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gPiANCj4gPiA+IE1heWJl
IHdlIHNob3VsZCBqdXN0IGdvIGJhY2sgdG8gdXNpbmcgY3RpbWUuwqAgY3RpbWUgaXMgKmV4YWN0
bHkqDQo+ID4gPiB3aGF0DQo+ID4gPiBORlN2NCB3YW50cywgYXMgbG9uZyBhcyBpdHMgZ3JhbnVs
YXJpdHkgaXMgc3VmZmljaWVudCB0byBjYXRjaA0KPiA+ID4gZXZlcnkNCj4gPiA+IHNpbmdsZSBj
aGFuZ2UuwqAgUHJlc3VtYWJseSBYRlMgZG9lc24ndCB0cnkgdG8gZW5zdXJlIHRoaXMuwqAgSG93
DQo+ID4gPiBoYXJkDQo+ID4gPiB3b3VsZCBpdCBiZSB0byBnZXQgYW55IGN0aW1lIHVwZGF0ZSB0
byBhZGQgYXQgbGVhc3Qgb25lDQo+ID4gPiBuYW5vc2Vjb25kPw0KPiA+ID4gVGhpcyB3b3VsZCBi
ZSBlbmFibGVkIGJ5IGEgbW91bnQgb3B0aW9uLCBvciBwb3NzaWJseSBiZSBhIGRpcmVjdA0KPiA+
ID4gcmVxdWVzdA0KPiA+ID4gZnJvbSBuZnNkLg0KPiA+IA0KPiA+IFdlIGNhbid0IHJlbHkgb24g
Y3RpbWUgdG8gYmUgY2hhbmdlZCBkdXJpbmcgYSBtb2RpZmljYXRpb24gYmVjYXVzZQ0KPiA+IE9f
Tk9DTVRJTUUgZXhpc3RzIHRvIGVuYWJsZSAidXNlciBpbnZpc2libGUiIG1vZGlmaWNhdGlvbnMg
dG8gYmUNCj4gPiBtYWRlLiBPbiBYRlMgdGhlc2Ugc3RpbGwgYnVtcCBpdmVyc2lvbiwgc28gd2hp
bGUgdGhleSBhcmUgaW52aXNpYmxlDQo+ID4gdG8gdGhlIHVzZXIsIHRoZXkgYXJlIHN0aWxsIHRy
YWNrZWQgYnkgdGhlIGZpbGVzeXN0ZW0gYW5kIGFueXRoaW5nDQo+ID4gdGhhdCB3YW50cyB0byBr
bm93IGlmIHRoZSBpbm9kZSBkYXRhL21ldGFkYXRhIGNoYW5nZWQuDQo+ID4gDQo+IA0KPiBPX05P
Q01USU1FIGlzbid0IG1lbnRpb25lZCBpbiB0aGUgbWFuIHBhZ2UsIHNvIGl0IGRvZXNuJ3QgZXhp
c3QgOi0oDQo+IA0KPiBJZiB0aGV5IGFyZSAidXNlciBpbnZpc2libGUiLCBzaG91bGQgdGhleSB0
aGVuIGFsc28gYmUgIk5GUw0KPiBpbnZpc2libGUiPw0KPiBJIHRoaW5rIHNvLg0KPiBBcyBJIHVu
ZGVyc3RhbmQgaXQsIHRoZSBwdXJwb3NlIG9mIE9fTk9DTVRJTUUgaXMgdG8gYWxsb3cNCj4gb3B0
aW1pc2F0aW9ucw0KPiAtIGRvIGEgbG90IG9mIHdyaXRlcywgdGhlbiB1cGRhdGUgdGhlIG10aW1l
LCB0aHVzIHJlZHVjaW5nIGxhdGVuY3kuwqANCj4gSQ0KPiB0aGluayBpdCBpcyBwZXJmZWN0bHkg
cmVhc29uYWJsZSBmb3IgYWxsIG9mIHRoYXQgdG8gYmUgaW52aXNpYmxlIHRvDQo+IE5GUy4NCg0K
VGhlIHBvaW50IGlzIHRoYXQgeW91IGNhbiBhbHdheXMgZGV0ZWN0IGFuIGltcGxpY2l0IG1ldGFk
YXRhIGNoYW5nZSBieQ0KanVzdCByZWFkaW5nIHRoZSBhdHRyaWJ1dGUgdGhhdCBjaGFuZ2VkLiBU
aGUgY2FzZSBvZiBhbiBleHBsaWNpdCBjaGFuZ2UNCmlzIGRpZmZlcmVudCwgYmVjYXVzZSB0aGUg
YXBwbGljYXRpb24gbWlnaHQgYmUgY2hhbmdpbmcgdGhlIHZhbHVlIGJhY2sNCnRvIGEgcHJldmlv
dXMgc2V0dGluZy4gVGhlIGVudGlyZSB2YWx1ZSBvZiBjdGltZSBpcyB0aGF0IGl0IGFsbG93cyB5
b3UNCnRvIGtub3cgbm90IHRvIHRydXN0IGFueSBjYWNoZXMgd2hlbiB0aGlzIG1pZ2h0IGJlIHRo
ZSBjYXNlIGJlY2F1c2UgaXQNCnJlY29yZHMgdGhlIGZhY3QgdGhhdCB0aGVyZSB3YXMgYW4gZXhw
bGljaXQgZGF0YSBvciBtZXRhZGF0YSBjaGFuZ2UNCnNvbWV3aGVyZSBhbG9uZyB0aGUgbGluZS4N
Cg0KQnkgZGlzY2FyZGluZyB0aGF0IGluZm9ybWF0aW9uIGFib3V0IGV4cGxpY2l0IHZzIGltcGxp
Y2l0IGNoYW5nZXMsIFhGUw0KaXMgbWFraW5nIHRoZSBpX3ZlcnNpb24gbGVzcyB1c2VmdWwgdG8g
YXBwbGljYXRpb25zIHRoYXQgbmVlZCB0byBjYWNoZQ0KZGF0YSBhbmQvb3IgbWV0YWRhdGEuIFNv
IHRoZSByZWFsIHF1ZXN0aW9uIGlzOiBmb3Igd2hpY2ggcmVhbCB3b3JsZA0KYXBwbGljYXRpb25z
IGlzIHRoaXMgYmVoYXZpb3VyIGFkZGluZyB2YWx1ZSB0aGF0IGNvdWxkIG5vdCBiZSBkZXJpdmVk
DQp0aHJvdWdoIG90aGVyIG1lYW5zPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
