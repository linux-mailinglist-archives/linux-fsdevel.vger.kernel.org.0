Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458FE703867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 19:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbjEORcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244220AbjEORbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 13:31:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2097.outbound.protection.outlook.com [40.107.223.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD5DDBB;
        Mon, 15 May 2023 10:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4WPA+BEYbJxydewQe2jN626MC+do9JQY15g5raAqm8UTz11lz4WE2exFt0zDLru8WUapZbSXglSEVd+Jwqu7laJUwyXcyn/BfbkwNk/Rcop2+o1lwN75FXOjlkAWHa46/c9UJP8NOetga+igyHSryXgKZn2f7L2nMLOxgWOIron0EmERsdZwI//4VNW6NWfZxwPKDEqB53NGM+EAaKZtL8Lx9wqoWg29qhFMK9LzaV8pvnHVuvE3F5L13+rDGmpU0b4coP0rAZ+H56a0RqYGytIIxRY8xVg9dGn9StpdgGsYVr3v2ONFOBwuYWAx9Y89GB1rXs2cbLLfvlStLCuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37yrSHk+VbCPHq5wuP0X/Z7I+EcOgn+ol23s/iOZlKo=;
 b=PTnAnde3bVZ1Tf06laqCegnP3XJgR5p43/9w5bD/NAe+qGERYe6YFvnL8t1PwIUCf1SaJepL2nGshnTUwG33SRoYj9vCSeDCNHILhxwPuQB32ugCvi8gc+s/4v7jv40t3Jp//Cfrx0GZ/39BrM+H/GZIRz5JB4Pfnp7t3R5SI82zVYNU4BZrTWLwZW8g+LuS5Y8F62fUJ+CIgIDb7fJD3fX4SnTMsloLhvVRQ8AKdNmYxuDMI9kuToaMUMsRFcNzP7/s0rF2Qv1vacjCusNkR21XxKvbA+EQhVt/gnCLdNUrBrIv07DEf1qgio0zkLVk5wIfBo7eSwGyW5EImVt6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37yrSHk+VbCPHq5wuP0X/Z7I+EcOgn+ol23s/iOZlKo=;
 b=dp+FQ529nRSfqcsi0LCxBxhzoB4CIHWhz3Xa+5P5GX0OVWGNkmLq+P5685wpkIdY4qluqb1VSXYSVOKaXJMvu4TKoWqfchkw8Rkex0tBROYADRf9rS1AyDsrkEviHZA36JGfsLr5S0Juq6GHE7P+m+UipxO3vEnjPQD3sNqxhSk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN4PR13MB5312.namprd13.prod.outlook.com (2603:10b6:806:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:28:39 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:28:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "eggert@cs.ucla.edu" <eggert@cs.ucla.edu>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "bruno@clisp.org" <bruno@clisp.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>,
        "brauner@kernel.org" <brauner@kernel.org>
CC:     "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] fix NFSv4 acl detection on F39
Thread-Topic: [PATCH] fix NFSv4 acl detection on F39
Thread-Index: AQHZh1C3kpBoUTLtAEenGrrL6g3A8q9blrwA
Date:   Mon, 15 May 2023 17:28:39 +0000
Message-ID: <f967cbcc1620d1a5e68d7f005571dc569c8b5bb4.camel@hammerspace.com>
References: <20230501194321.57983-1-ondrej.valousek.xm@renesas.com>
         <c955ee20-371c-5dde-fcb5-26d573f69cd9@cs.ucla.edu>
         <TYXPR01MB1854B3C3B8215DD0FA7B83CCD96D9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <17355394.lhrHg4fidi@nimes>
         <32edbaf1-d3b1-6057-aefc-d83df3266c20@cs.ucla.edu>
         <4f1519d8-bda1-1b15-4a78-a8072ba1551a@cs.ucla.edu>
         <TYXPR01MB18547A591663A4934B5D4D82D9789@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <fb005d7e29f1167b83acf7b10800ff3124ee2a50.camel@redhat.com>
In-Reply-To: <fb005d7e29f1167b83acf7b10800ff3124ee2a50.camel@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN4PR13MB5312:EE_
x-ms-office365-filtering-correlation-id: b5ca8834-5c7e-475d-8795-08db5569d28c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaW+wdOzSMKaZ62++ebH5bO0c7i4M9mXwR5FVQxLnOWgOxYdFf8z+Ckbqb+gr5JGaWjLJ7x4wFLCC7Hu57SvGLmq54U4hMzaRbhPI6NHMaHjPipP85riqCSMgof2ZPOtqdRoLvSsLJ61LiMnUg0WtrrmipwwmIN8IzcbszBqS5Xkn6LKmKb1CHLl5agbNtOvGLbarZVlaofzph9ISoX+Vtqy6X0FlhxKOwtDik23+iPYQvS9nI3Z4pmiTDFBFKJyl1nb3zOsJGHIupvelNRhyquiG079O8BzoES+T/D81P0YSaF4kO5Hj1bd3G0swsdQTGF4XZwyGAIou1ieXCZzNr/zjgIQMbg7oPOEcibA+qws+LPZ3/FlU9yLqTzYPqoqoavGYpmzEICBh7+qpfz9VjOjFAysoE3AtYHAgjTBjvTNci4Yl40EPIjbWn9eZpRZ9areT2DUSYOAeJkyhNODG7U9OzHBDiQjYpZb0RlgB1isMZ4r8MqnIGPRKEjWNGzTws+z46UVeMtn+TU2WjMwW4mkghzkaGNpiHSF+jrpgRlClTIJvN2F7xG/69FnbOiPt+V2mlB+2kta9M+k1W9WqRWoeYzFcmA0yxYTeQVT2k3xkqtJD2eguGE9zeMoQxIEo8llkZnlEThcsAco5+HFKw+/0g9unhFXWquJh6tkKfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(346002)(136003)(366004)(376002)(396003)(451199021)(36756003)(110136005)(54906003)(38070700005)(478600001)(41300700001)(122000001)(8676002)(8936002)(38100700002)(5660300002)(2906002)(316002)(4326008)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(6506007)(6512007)(26005)(86362001)(186003)(83380400001)(2616005)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXFJUkNKa1RqV0QzQS9KSWVudjd6bTBWTzNlSFI3NXRUU1FXcVhDVnRSbnVn?=
 =?utf-8?B?RVBod1kwbEdhTXh1TlRqN3hWMzN2STQrOG9ISHgrbFdGOGRHZmwyMWpPSC80?=
 =?utf-8?B?T3dZdERZVkoxUW5XczhxUjMwd2luU1EwVWVuNjYwdGxHSnlTUzhIRzVZZmVE?=
 =?utf-8?B?R3lxNU1CTjFQMitlNDU5MGRrOS9BejFuaFNKU2MrRHlCSU1NMi9JSlpkL3VR?=
 =?utf-8?B?YTdPTHpQRVBIWHVEYTA0QmNXNXBRcE8ySlk0ZlE2bmd2eUhBS25vTUovVlR0?=
 =?utf-8?B?d1ZtUlplL2QyUUsvUnJIVlVhSkhyNW8rRjdwV0FnY0wzWDRHaUZzWWxyZXFl?=
 =?utf-8?B?ZjgzQlhwb0ZqT0FGTTFoeE9vYVFPN1IzYllmcTU5eTZGTWl6QzQyR3M3STRE?=
 =?utf-8?B?dG4raVplOG5JRFNTT1FEb2l3UnhHUklHNG5Cc2pGeit5TUF1dmJIdjZwak9C?=
 =?utf-8?B?Q0E0T1dhN2Vadkw3SG1hd0lHKzBEMVlHVFloQ2wzOFkxdzAxZnJBdmE3WDd1?=
 =?utf-8?B?Nnc4OGs3SllGS00zVllCWDNaYUR0N1Y5YWFhc0UrNUhyaGF1M3F5MzdjbldC?=
 =?utf-8?B?U1craDBBd1gzTmRGMEs1ekxHKzU5Zi9iU2tKV1JpVzNqSmo5dTh3eEVmbUdo?=
 =?utf-8?B?dVFvdFl1TUNtNGFiYWJFTjZlV1ZETHEwS1laRzVZckN1Z3NRSFlzSEVlR25K?=
 =?utf-8?B?d05oQ3dLTGJhS0NmS2hhbGgxOFh3ckxkWVAyZGJPbC94NHUvTGsrSnhQT3Rn?=
 =?utf-8?B?Zk5PUmxJNkpaQTViYlJYcUs0bTY2WkhjSFppaUdQck5wd0RRTzB5ZmhNdTNw?=
 =?utf-8?B?c3FmL2JPTVMwdjl3RGRza1FHdDZsNERJV2tZckNvbjZra1ZHalNnR2kyM045?=
 =?utf-8?B?RVFKNzE2cFFkZ3NGSUY1a0RXaEVhbGUrRndqc2I1NmV2QkIvRFZrR2NVWE04?=
 =?utf-8?B?RDltaTJBcjlQcnV4WHBid2ZpUnAvRWlSUkQzUjRLdms3eTFrSklPVmFmVTFS?=
 =?utf-8?B?MGlJRzBxRXYzVWtVaEhhR1Q3cGtzdFlpNkI3ZlRrWFhXVE5DKzBIL2t0R3Bv?=
 =?utf-8?B?VG1qR1ozMDVxUjlrYldlTVUyMk1MOHFDRzJOZWJOQXZVVC9kODMzNDFsL2hF?=
 =?utf-8?B?MFowWWdwY0gwWjNlZWdzVXV2L2REZGlqUHZzdTBUWDhVcmVTNFR3bng1ZnRt?=
 =?utf-8?B?KzJqOFNsSEw3U1JCemhSalZSQTV1QzNYTi83VVNHbzVZWEdwL25jZUFZN3Y5?=
 =?utf-8?B?dmpUSlB1MXVmQUVvSVExaElwb1JKc1hCOVpMazk2TGdiMnBWVUYyZWZsOWFs?=
 =?utf-8?B?UzVqcmhVNWpOeU5zYllpeGxSbXBSVGd4WlBzYWZ6aGtHVklRYVdhQkZPclB0?=
 =?utf-8?B?cjlrRHFIYjIwM0xDRjEwa2NOOEYzd25DWStmdjBpSlVNdDB3bW1JcHZEZXpQ?=
 =?utf-8?B?MGN0a2tHeG80UStUeitnczdOTWJSTTdtdnlLaXp6N1V4WkdEcGl4anJGZ1dC?=
 =?utf-8?B?L2RKZGVQV2NXa1RiM0NZRUszZnl6ejBOdFRNd3krM216bENDdHkrdklEcENY?=
 =?utf-8?B?OUpUM2xXSEJpRG1UZEZGYjY0SFBhMUliR3BBN3ZpTGhia2Rsd2ZCVFNDVzlC?=
 =?utf-8?B?WHFYMWx6UWtBbVN3aTMzK0EyUXNOamVJTTJBcXM1a2FKSStSQWdLWVJWYlRU?=
 =?utf-8?B?aFNPdkVUZXdkcENEOVRNQ0ZxaXBYVGNEazBFN2JpR1I1N3BZTDg1R3FWSEM2?=
 =?utf-8?B?SHZPeUg4Skhnb2tHak10KzlQbGdEcXpMNFZOMWYyYWpTSHU1VGlVYXFQL2ZD?=
 =?utf-8?B?WmNCME92YjVSRitZVjVQdTFHQjIvU09UMEhMSFJiMCsyOVZ4SUlROU4xMlRl?=
 =?utf-8?B?ZE1jeGsweG5IZW8wYXM2L3NYbnNBOUlDcExGYldhZFk3NjQvbDN2cEdUNUxh?=
 =?utf-8?B?cXQ4UzNybFlRaCtORTB4Wm5HVVRyUTU4Y3FSYWpISWhqMDYrRnN6U3R5bS84?=
 =?utf-8?B?Q2RTbG1Gd3pxcnpacHF0VDJ0d2VnSldhUDM2Z1lsdHlYNk1JNEtXQmVkVlFS?=
 =?utf-8?B?bzhlTmp6Z1lDVWNvazE3NjFSYk00STA3RHp1OG1tbHpPaTlEK0pkMlRIY3FY?=
 =?utf-8?B?THJaU3F0RTBkM0FqSmx1b1o1RTB1WUExeVVhcUkzdFZDM2dMMUpsbDhLSXBK?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24FB69D12AB553448DD2987C228E2CD6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ca8834-5c7e-475d-8795-08db5569d28c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 17:28:39.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kU7MpkllqtBVG2C030UR2Ur5LH14qNedPOn37/dy4xwVvqKxAEc3/cNUw2WuMoP9J+SDBN1l5iCf04YnQv3f/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTE1IGF0IDEzOjExIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gTW9uLCAyMDIzLTA1LTE1IGF0IDExOjUwICswMDAwLCBPbmRyZWogVmFsb3VzZWsgd3JvdGU6
DQo+ID4gSGkgUGF1bCwNCj4gPiANCj4gPiBPayBmaXJzdCBvZiBhbGwsIHRoYW5rcyBmb3IgdGFr
aW5nIGluaXRpYXRpdmUgb24gdGhpcywgSSBhbSB1bmFibGUNCj4gPiB0byBwcm9jZWVkIG9uIHRo
aXMgb24gbXkgb3duIGF0IHRoZSBtb21lbnQuDQo+ID4gSSBzZWUgZmV3IHByb2JsZW1zIHdpdGgg
dGhpczoNCj4gPiANCj4gPiAxLiBUaGUgY2FsY3VsYXRpb24gb2YgdGhlICdsaXN0YnVmc2l6ZScg
aXMgaW5jb3JyZWN0IGluIHlvdXIgcGF0Y2guDQo+ID4gSXQgd2lsbCBfbm90X3dvcmsgYXMgeW91
IGV4cGVjdGVkIGFuZCB3b24ndCBsaW1pdCB0aGUgbnVtYmVyIG9mDQo+ID4gc3lzY2FsbHMgKHdo
aWNoIGlzIHdoeSB3ZSBjYW1lIHVwIHdpdGggdGhpcyBwYXRjaCwgcmlnaHQ/KS4gQ2hlY2sNCj4g
PiB3aXRoIG15IG9yaWdpbmFsIHByb3Bvc2FsLCB3ZSByZWFsbHkgbmVlZCB0byBjaGVjayBmb3IN
Cj4gPiAnc3lzdGVtLm5mczQnIHhhdHRyIG5hbWUgcHJlc2VuY2UgaGVyZQ0KPiA+IDIuIEl0IG1p
c3Rha2VubHkgZGV0ZWN0cyBhbiBBQ0wgcHJlc2VuY2Ugb24gZmlsZXMgd2hpY2ggZG8gbm90IGhh
dmUNCj4gPiBhbnkgQUNMIG9uIE5GU3Y0IGZpbGVzeXN0ZW0uIERpZ2dpbmcgZnVydGhlciBpdCBz
ZWVtcyB0aGF0IGtlcm5lbA0KPiA+IGluIEYzOSBiZWhhdmVzIGRpZmZlcmVudGx5IHRvIHRoZSBw
cmV2aW91cyBrZXJuZWxzOg0KPiA+IA0KPiA+IEYzODogDQo+ID4gIyBnZXRmYXR0ciAtbSAuIC9w
YXRoX3RvX25mczRfZmlsZQ0KPiA+ICMgZmlsZTogcGF0aF90b19uZnM0X2ZpbGUNCj4gPiBzeXN0
ZW0ubmZzNF9hY2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwtLS0tIG9ubHkNCj4gPiBzaW5nbGUgeGF0dHIgZGV0
ZWN0ZWQNCj4gPiANCj4gPiBGMzk6DQo+ID4gIyBnZXRmYXR0ciAtbSAuIC9wYXRoX3RvX25mczRf
ZmlsZQ0KPiA+ICMgZmlsZTogcGF0aF90b19uZnM0X2ZpbGUNCj4gPiBzeXN0ZW0ubmZzNF9hY2wN
Cj4gPiBzeXN0ZW0ucG9zaXhfYWNsX2RlZmF1bHQNCj4gPiAvKiBTT01FVElNRVMgZXZlbiBzaG93
cyB0aGlzICovDQo+ID4gc3lzdGVtLnBvc2l4X2FjbF9kZWZhdWx0DQo+IA0KPiAoY2MnaW5nIENo
cmlzdGlhbiBhbmQgcmVsZXZhbnQga2VybmVsIGxpc3RzKQ0KPiANCj4gSSBhc3N1bWUgdGhlIEYz
OSBrZXJuZWwgaXMgdjYuNC1yYyBiYXNlZD8gSWYgc28sIHRoZW4gSSB0aGluayB0aGF0J3MNCj4g
YQ0KPiByZWdyZXNzaW9uLiBORlN2NCBjbGllbnQgaW5vZGVzIHNob3VsZCBfbm90XyByZXBvcnQg
YSBQT1NJWCBBQ0wNCj4gYXR0cmlidXRlIHNpbmNlIHRoZSBwcm90b2NvbCBkb2Vzbid0IHN1cHBv
cnQgdGhlbS4NCj4gDQo+IEluIGZhY3QsIEkgdGhpbmsgdGhlIHJhdGlvbmFsZSBpbiB0aGUga2Vy
bmVsIGNvbW1pdCBiZWxvdyBpcyB3cm9uZy4NCj4gTkZTdjQgaGFzIGEgbGlzdHhhdHRyIG9wZXJh
dGlvbiwgYnV0IGRvZXNuJ3Qgc3VwcG9ydCBQT1NJWCBBQ0xzLg0KPiANCj4gQ2hyaXN0aWFuLCBk
byB3ZSBuZWVkIHRvIHJldmVydCB0aGlzPw0KPiANCj4gY29tbWl0IGU0OTkyMTRjZTNlZjUwYzUw
NTIyNzE5ZTc1M2ExZmZjOTI4YzJlYzENCj4gQXV0aG9yOiBDaHJpc3RpYW4gQnJhdW5lciA8YnJh
dW5lckBrZXJuZWwub3JnPg0KPiBEYXRlOsKgwqAgV2VkIEZlYiAxIDE0OjE1OjAxIDIwMjMgKzAx
MDANCj4gDQo+IMKgwqDCoCBhY2w6IGRvbid0IGRlcGVuZCBvbiBJT1BfWEFUVFINCj4gwqDCoMKg
IA0KPiANCg0KDQpOby4gVGhlIHByb2JsZW0gaXMgY29tbWl0IGYyNjIwZjE2NmUyYSAoInhhdHRy
OiBzaW1wbGlmeSBsaXN0eGF0dHINCmhlbHBlcnMiKSB3aGljaCBoZWxwZnVsbHkgaW5zZXJ0cyBw
b3NpeCBhY2wgaGFuZGxlcnMgaW50bw0KZ2VuZXJpY19saXN0eGF0dHIoKSwgYW5kIG1ha2VzIGl0
IGltcG9zc2libGUgdG8gY2FsbCBmcm9tDQpuZnM0X2xpc3R4YXR0cigpLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
