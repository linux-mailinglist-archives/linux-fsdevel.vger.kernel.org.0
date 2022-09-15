Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058BC5BA11C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIOTEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIOTEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:04:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0035A2F7;
        Thu, 15 Sep 2022 12:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9VcJhQ7VoYNnkxY4nNk/mBLd1X5fP36UOZuyRNVkFOeYi2e8kZNp9AeF8oz4zMcqHB/8iTo4YB1ySdZ0bn4TXeYOohpy3UQ47+fOzJ+Nvj8XyGjKLvE1jWn/IGAZa8vUJ5z8mWukkCF76w8vSahcNGpS39VWxHhGjV3OKR+4iFCb8GTh+jqMDpBp7g/+MvblHsPcqy9N/Bivtqb/zeCxG3HzDOhQKNPFJ/+ASSdhtVoxtD9yvDoV83giAHwPYdsJ5iqNswOqwrjiHO31yRLmoR1bksDUqlkHx7nhwiEB6CdwHTk7slNjjlOrEjday7OwiYAUnrYMSiqJ8f8bZmeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBkZOTkc1ZBZ0+vX3GAangA9vzArOA4v/ndfc+aZK30=;
 b=R87c/PGTxBNhU9OSbe6wUQ4Ww8KkqiTV7QhWgs30yprxxTyk775OsWpGGIjK1Tv0dQA/jWHCjTlm+ThwRw2nTh+2KQCj93MjKN2Ma0i3ltkwwxyqqGER2Wdrt8trlbzQMebK4+3dT0e51wMnvvUcaBx1AgcqC8ukBJ4MXTrHrvrz88hMysP0wQHg5/qSgO8Y8GU+lN++is+rXAPTFrBvPTQdjDp7CbWOMYfdMKK0Fl9kUlBKZdR0voMuJ4/OJCIQ4+rcDBqV1dmgO/38lYILqlX/95xfmdbwV3eZDg1yNK8EWkwDPc22FyKzwepG3W4KTGdpecMgAiwShqZRlTZnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBkZOTkc1ZBZ0+vX3GAangA9vzArOA4v/ndfc+aZK30=;
 b=JD9f6WafuZDliM+qhJsmECxXDdjkQDYmVNScRw/Lrr2IhDTbokh65ir74DJiUszNq9NXTFj9qU0L374hvakStbR5LNEV+xOJLkDNfrz7nFXGaQdqTCwf3eayLB0+hHfJSl4ReOFXiEtx3NBcTf7O+RmdrrnXOjQ6nHd9xrlidc4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5871.namprd13.prod.outlook.com (2603:10b6:a03:439::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 19:03:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5632.012; Thu, 15 Sep 2022
 19:03:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAAzmAgAAdFoCAAAvtAIAADJkAgANYaoCAApXgAIAAn+4AgAQd8ACAABFGgIAAGxkAgAARzACAAAYwgIAADquA
Date:   Thu, 15 Sep 2022 19:03:55 +0000
Message-ID: <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
References: <20220908083326.3xsanzk7hy3ff4qs@quack3>
         <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <166284799157.30452.4308111193560234334@noble.neil.brown.name>
         <20220912134208.GB9304@fieldses.org>
         <166302447257.30452.6751169887085269140@noble.neil.brown.name>
         <20220915140644.GA15754@fieldses.org>
         <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
         <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
         <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
         <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
In-Reply-To: <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5871:EE_
x-ms-office365-filtering-correlation-id: addda8c2-0c59-4b8c-cd0e-08da974d09d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYNbVdoyXjJduvjMSxmkzo8lk+tPwo3FkUwKH+hPTOBN1DJyJM9n7sz0qmjZ6iCTMoLZZwOq/UJMy7suesj0pkc19XMuV8Tthkgit7kDB9pn6XcPqoHy1EClWph9FDH59wWViqBed9sSXCNq9MaMnTbPUietrUx3PZ8DV092VCJ7SY/Hz5pDXhuHKyTN0mVGg+qRl51eJB1VkqbDLx6pfE7QikuQa7pHeeKpN7UYTxXZwAVwLv6t+TeDoIG+SBtRha/zq6Qy8dPLKvK+s2CUbxZmlDLBGzVOsEXJUEe/hVPEmBNiQ5u27l3g7NRc0Zt/Czq0JHR8RWSi/mRY+UEmKWQJoh5ITcX5iGukQZ+lq9RIHpg26PhLC+1RiCpNeZKBz1JQZizTtFQ6WaNrHCg+Zv5crHEqKQpPNzuy1NYIvuP1r2WEmaq6kHBTae3zfzuixBJfasbzCAJxLy4aVPVRsKoHetdezh70eg8Ht+BWtvD/CD0gBuu1RNGlgGxcMvi+SEJwhYFV5xMoucvfTfz5VBffL+SKhvIEdKO97Yr4lhRR9n6zILEfz425hGLwBlYzc3o8kXHBnS7sLr41K3bbqjEks6CuW0yHhTltmHCNOcbw4HPjvMy4VmxgPTJZ4Sbl57WIiTzaEHDQChYMacOWmHjS8yKJjqZPCiT1cSdLtOVri25PJSCU/CUcCOETf6gakFdWtqMaQ//ZtrZPsbwSd95I/1dlnEwol4vOFnfX7BQIYaps4fbGQvpEXTYtxcnGYuz7pHINOYQfBobc2Wv3ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39840400004)(346002)(396003)(136003)(376002)(451199015)(2906002)(26005)(122000001)(8676002)(91956017)(6506007)(316002)(36756003)(64756008)(86362001)(76116006)(66556008)(71200400001)(478600001)(110136005)(2616005)(83380400001)(38100700002)(66946007)(4326008)(66899012)(7416002)(38070700005)(66446008)(8936002)(186003)(6486002)(41300700001)(5660300002)(66476007)(6512007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTJtMktMVnpuUklxR1lzOWxnOWlRenFSTE5wL2F4dFNKcmV0SzNyOGVuYmZ2?=
 =?utf-8?B?M0dCY1p6THZONXNQUWtUblEvUUJNejBoZmptVHNXK01kTDF0NW94UFRoNnVy?=
 =?utf-8?B?UGM4blc2MVNuWDlmaTlhWE5va0dRakxTOUZtcUVBWXhlMUJQRlA3THVHWDlC?=
 =?utf-8?B?MEdCdEJLU2t1ZUp0Nko2SG9tWW1OeFNHc1ZVaTFuMDFybVJ1anBVSndaYVF0?=
 =?utf-8?B?dkppanNna2hmQmFMQXA4dktQT0RXWTFJT3VLSGNSdURKR2NwUEIwSWlONWU2?=
 =?utf-8?B?YWFVRzdpcXl1Y2dNajBvSGllczA1STJBYjNsSnJEQlcrSytmTktoSlNBMEZU?=
 =?utf-8?B?QnRadDhQKzBGNnRuY2o3ZlhTMXpKZTk0TlJWU0tZanFidWxrYmZXNnNxRUJz?=
 =?utf-8?B?WTBla0FOV01OYjB5d3pDSmEwS3hpUUt4blIzajEza3RRMXRpRGZ1RDRVL1JI?=
 =?utf-8?B?cGZCa0ZsQ3lzR25penpEaFZwM3RIakprZXBCQTJrUnJxbjhjamxhMUdGTEpz?=
 =?utf-8?B?UFUvY2VQRlFFL0ovK2UxaFpyZWMrWHlNcWtRQWp2N0hjN2Z4QTRCdnZBRDVF?=
 =?utf-8?B?Yk9IRkozM1ZEaTRBT2RDcFRsRU1DWklTUjFQckhIbkk4YzMyQmpHckYzNkJF?=
 =?utf-8?B?d0dNbjhtbVJKbFcxRFpzc25BY2hjVlNLSUJrblV0WkF0WVpUR280K3cva3cv?=
 =?utf-8?B?RE13L01mcFgwL0hEYklPNnozOG9XMTdVU2NYdjA4cC8ydlJhM1hleFBGdThC?=
 =?utf-8?B?T1k3OXdGdUkrQXlxWlNOUEhtQUtlc0RiMlZNTldRYk05VTF0VlVRbmJlQUZs?=
 =?utf-8?B?cklZOHE2WGplMUxxeVdQOHhmQ3BWL1JSUEdTUG1jV3J5UXBHOGNCdnFNclhP?=
 =?utf-8?B?NHBrZ2p1cnZXbVBmU3Y0YU5iODhkSHRwLzVJbjgvbW5JWklYRW82MXppZG5p?=
 =?utf-8?B?YmR4Qmt6elBnSDhmRnRMTDJPUDMxOXFUWFRhMy8zOVo5TDc4bjBjSmEwelNT?=
 =?utf-8?B?cUQwZ1Z4d0xOOSs1akg2ZUdLMFVmNnExZ1JKZjE4S01HSWVZNjExYnc3VURD?=
 =?utf-8?B?MzJ6L3BXTi9JTGY3MSt6cjJSSzQrWDJvc2dIZGZrbjF3VklCMjc2ZzdmOHBa?=
 =?utf-8?B?TExxUVlkaVd1U0duVmdhODgrbUZpUHg1enR0NGVvM08ydG5wbTFMYWtWSlVn?=
 =?utf-8?B?Nmtmc0tXamV3WitsMDRBZGx1NmpFY2RhVjErQ29vYlNRY28vaC9pTWdWME5F?=
 =?utf-8?B?Z1ZIc3Q3dit3QXAvejhHKzFzRkxabWhyR3ZkY2JmN1ZMTnVVYzFuYUZGZ1pq?=
 =?utf-8?B?ZGN5TWVJc05aZEpBZjBoK2tQQzRhUGtPdDNsMDBHdnI2VVc2V0Y2dUNJVzdq?=
 =?utf-8?B?R3FuRk1mTEZEUHhVN3d2ZVdIY2ZubUZJZ1Q4SmhPNlkzTlJVWlJ3SzZxbTFt?=
 =?utf-8?B?SzIycXpmYTVxMU9xSkloTG44dkFXMWIxb2dwT3BpejBrTmxZOFJpODlpSzlX?=
 =?utf-8?B?NWVoUFY0b1Qrb0hwaDdoNjN2THJrK2JJS2pWbVBKbHUxSkZGd3BFWGlac05x?=
 =?utf-8?B?NFZIenJLOHZGc04rcGZsSXMvbGxmc3hoNWV6c1owY2JiL0ttVFVsaTlrR1FO?=
 =?utf-8?B?OCtIUG1zWnpJS05IOVhXQjh5Vmlkd2lRVGl3YlA1QzRKSjlncEZ6WFVrTDd3?=
 =?utf-8?B?VzdqdHJSLzVqZTZ2cjZIL2RqY3l1VHRSdEljS1lYLzVaVGJIY25sV2xpTmRH?=
 =?utf-8?B?enVtdzBVWGxnVHF4Q2Z0QVhBMUlVaVkrc2VyUGY1SzdueUJ6WVExeUttdzJB?=
 =?utf-8?B?RDFNSXJPOXVMU3lhMlZGMk8rN3dGL0k2ZC80amR0N3pFbGhwVmFsZUdKNXpn?=
 =?utf-8?B?QXRVT0xJbDhjblJFOTd0WFNQQnhCRGJRdkNxOWRDUndzWUNHSU9wbFFCL0pO?=
 =?utf-8?B?aW5LTkw3dFl1UXlHYVJHNUxEcWhqVkgzV1JuaUpERU1VVWFzL0MwVGNSMnJl?=
 =?utf-8?B?a3dPa0xGcUMyU080RTdzeUpYV1RGK2FXU0MxcSt3TVBia0pFZTdpQXRBNDF4?=
 =?utf-8?B?TSt1WmpqUE9yZjJmZlB5eWU3RmZLTmJZWGlHeFhGY0xzdlU1OEx6ODdDVmMz?=
 =?utf-8?B?MG1XL2cyQ2ljNzhET3cxNVc1YlA0T2V2M2ZMNTliU284RElodmI1c3NDY3dt?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45232315C8107442937472C9F6613172@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTE1IGF0IDE0OjExIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDIyLTA5LTE1IGF0IDE3OjQ5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVGh1LCAyMDIyLTA5LTE1IGF0IDEyOjQ1IC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIFRodSwgMjAyMi0wOS0xNSBhdCAxNTowOCArMDAwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIDIwMjItMDktMTUgYXQgMTA6MDYgLTA0MDAsIEou
IEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIFNlcCAxMywgMjAyMiBhdCAw
OToxNDozMkFNICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBNb24sIDEy
IFNlcCAyMDIyLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIFN1biwg
U2VwIDExLCAyMDIyIGF0IDA4OjEzOjExQU0gKzEwMDAsIE5laWxCcm93bg0KPiA+ID4gPiA+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBPbiBGcmksIDA5IFNlcCAyMDIyLCBKZWZmIExheXRv
biB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gVGhlIG1hY2hp
bmUgY3Jhc2hlcyBhbmQgY29tZXMgYmFjayB1cCwgYW5kIHdlIGdldCBhDQo+ID4gPiA+ID4gPiA+
ID4gPiBxdWVyeQ0KPiA+ID4gPiA+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4gPiA+ID4gPiBpX3Zl
cnNpb24NCj4gPiA+ID4gPiA+ID4gPiA+IGFuZCBpdCBjb21lcyBiYWNrIGFzIFguIEZpbmUsIGl0
J3MgYW4gb2xkIHZlcnNpb24uDQo+ID4gPiA+ID4gPiA+ID4gPiBOb3cNCj4gPiA+ID4gPiA+ID4g
PiA+IHRoZXJlDQo+ID4gPiA+ID4gPiA+ID4gPiBpcyBhIHdyaXRlLg0KPiA+ID4gPiA+ID4gPiA+
ID4gV2hhdCBkbyB3ZSBkbyB0byBlbnN1cmUgdGhhdCB0aGUgbmV3IHZhbHVlIGRvZXNuJ3QNCj4g
PiA+ID4gPiA+ID4gPiA+IGNvbGxpZGUNCj4gPiA+ID4gPiA+ID4gPiA+IHdpdGggWCsxPyANCj4g
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiAoSSBtaXNzZWQgdGhpcyBiaXQgaW4gbXkg
ZWFybGllciByZXBseS4uKQ0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEhvdyBp
cyBpdCAiRmluZSIgdG8gc2VlIGFuIG9sZCB2ZXJzaW9uPw0KPiA+ID4gPiA+ID4gPiA+IFRoZSBm
aWxlIGNvdWxkIGhhdmUgY2hhbmdlZCB3aXRob3V0IHRoZSB2ZXJzaW9uDQo+ID4gPiA+ID4gPiA+
ID4gY2hhbmdpbmcuDQo+ID4gPiA+ID4gPiA+ID4gQW5kIEkgdGhvdWdodCBvbmUgb2YgdGhlIGdv
YWxzIG9mIHRoZSBjcmFzaC1jb3VudCB3YXMNCj4gPiA+ID4gPiA+ID4gPiB0byBiZQ0KPiA+ID4g
PiA+ID4gPiA+IGFibGUgdG8NCj4gPiA+ID4gPiA+ID4gPiBwcm92aWRlIGEgbW9ub3RvbmljIGNo
YW5nZSBpZC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEkgd2FzIHN0aWxsIG1haW5s
eSB0aGlua2luZyBhYm91dCBob3cgdG8gcHJvdmlkZSByZWxpYWJsZQ0KPiA+ID4gPiA+ID4gPiBj
bG9zZS0NCj4gPiA+ID4gPiA+ID4gdG8tb3Blbg0KPiA+ID4gPiA+ID4gPiBzZW1hbnRpY3MgYmV0
d2VlbiBORlMgY2xpZW50cy7CoCBJbiB0aGUgY2FzZSB0aGUgd3JpdGVyDQo+ID4gPiA+ID4gPiA+
IHdhcyBhbg0KPiA+ID4gPiA+ID4gPiBORlMNCj4gPiA+ID4gPiA+ID4gY2xpZW50LCBpdCB3YXNu
J3QgZG9uZSB3cml0aW5nIChvciBpdCB3b3VsZCBoYXZlDQo+ID4gPiA+ID4gPiA+IENPTU1JVHRl
ZCksDQo+ID4gPiA+ID4gPiA+IHNvDQo+ID4gPiA+ID4gPiA+IHRob3NlDQo+ID4gPiA+ID4gPiA+
IHdyaXRlcyB3aWxsIGNvbWUgaW4gYW5kIGJ1bXAgdGhlIGNoYW5nZSBhdHRyaWJ1dGUgc29vbiwN
Cj4gPiA+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gPiA+IGFzDQo+ID4gPiA+ID4gPiA+IGxvbmcg
YXMNCj4gPiA+ID4gPiA+ID4gd2UgYXZvaWQgdGhlIHNtYWxsIGNoYW5jZSBvZiByZXVzaW5nIGFu
IG9sZCBjaGFuZ2UNCj4gPiA+ID4gPiA+ID4gYXR0cmlidXRlLA0KPiA+ID4gPiA+ID4gPiB3ZSdy
ZSBPSywNCj4gPiA+ID4gPiA+ID4gYW5kIEkgdGhpbmsgaXQnZCBldmVuIHN0aWxsIGJlIE9LIHRv
IGFkdmVydGlzZQ0KPiA+ID4gPiA+ID4gPiBDSEFOR0VfVFlQRV9JU19NT05PVE9OSUNfSU5DUi4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gWW91IHNlZW0gdG8gYmUgYXNzdW1pbmcgdGhhdCB0
aGUgY2xpZW50IGRvZXNuJ3QgY3Jhc2ggYXQNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4g
c2FtZQ0KPiA+ID4gPiA+ID4gdGltZQ0KPiA+ID4gPiA+ID4gYXMgdGhlIHNlcnZlciAobWF5YmUg
dGhleSBhcmUgYm90aCBWTXMgb24gYSBob3N0IHRoYXQgbG9zdA0KPiA+ID4gPiA+ID4gcG93ZXIu
Li4pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElmIGNsaWVudCBBIHJlYWRzIGFuZCBjYWNo
ZXMsIGNsaWVudCBCIHdyaXRlcywgdGhlIHNlcnZlcg0KPiA+ID4gPiA+ID4gY3Jhc2hlcw0KPiA+
ID4gPiA+ID4gYWZ0ZXINCj4gPiA+ID4gPiA+IHdyaXRpbmcgc29tZSBkYXRhICh0byBhbHJlYWR5
IGFsbG9jYXRlZCBzcGFjZSBzbyBubyBpbm9kZQ0KPiA+ID4gPiA+ID4gdXBkYXRlDQo+ID4gPiA+
ID4gPiBuZWVkZWQpDQo+ID4gPiA+ID4gPiBidXQgYmVmb3JlIHdyaXRpbmcgdGhlIG5ldyBpX3Zl
cnNpb24sIHRoZW4gY2xpZW50IEINCj4gPiA+ID4gPiA+IGNyYXNoZXMuDQo+ID4gPiA+ID4gPiBX
aGVuIHNlcnZlciBjb21lcyBiYWNrIHRoZSBpX3ZlcnNpb24gd2lsbCBiZSB1bmNoYW5nZWQgYnV0
DQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+IGRhdGENCj4gPiA+ID4gPiA+IGhhcw0KPiA+
ID4gPiA+ID4gY2hhbmdlZC7CoCBDbGllbnQgQSB3aWxsIGNhY2hlIG9sZCBkYXRhIGluZGVmaW5p
dGVseS4uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgZ3Vlc3MgSSBhc3N1bWUgdGhhdCBpZiBh
bGwgd2UncmUgcHJvbWlzaW5nIGlzIGNsb3NlLXRvLQ0KPiA+ID4gPiA+IG9wZW4sDQo+ID4gPiA+
ID4gdGhlbiBhDQo+ID4gPiA+ID4gY2xpZW50IGlzbid0IGFsbG93ZWQgdG8gdHJ1c3QgaXRzIGNh
Y2hlIGluIHRoYXQgc2l0dWF0aW9uLsKgDQo+ID4gPiA+ID4gTWF5YmUNCj4gPiA+ID4gPiB0aGF0
J3MNCj4gPiA+ID4gPiBhbiBvdmVybHkgZHJhY29uaWFuIGludGVycHJldGF0aW9uIG9mIGNsb3Nl
LXRvLW9wZW4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQWxzbywgSSdtIHRyeWluZyB0byB0aGlu
ayBhYm91dCBob3cgdG8gaW1wcm92ZSB0aGluZ3MNCj4gPiA+ID4gPiBpbmNyZW1lbnRhbGx5Lg0K
PiA+ID4gPiA+IEluY29ycG9yYXRpbmcgc29tZXRoaW5nIGxpa2UgYSBjcmFzaCBjb3VudCBpbnRv
IHRoZSBvbi1kaXNrDQo+ID4gPiA+ID4gaV92ZXJzaW9uDQo+ID4gPiA+ID4gZml4ZXMgc29tZSBj
YXNlcyB3aXRob3V0IGludHJvZHVjaW5nIGFueSBuZXcgb25lcyBvcg0KPiA+ID4gPiA+IHJlZ3Jl
c3NpbmcNCj4gPiA+ID4gPiBwZXJmb3JtYW5jZSBhZnRlciBhIGNyYXNoLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IElmIHdlIHN1YnNlcXVlbnRseSB3YW50ZWQgdG8gY2xvc2UgdGhvc2UgcmVtYWlu
aW5nIGhvbGVzLCBJDQo+ID4gPiA+ID4gdGhpbmsNCj4gPiA+ID4gPiB3ZSdkDQo+ID4gPiA+ID4g
bmVlZCB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBpbmNyZW1lbnQgdG8gYmUgc2VlbiBhcyBhdG9taWMg
d2l0aA0KPiA+ID4gPiA+IHJlc3BlY3QNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IGl0cyBhc3Nv
Y2lhdGVkIGNoYW5nZSwgYm90aCB0byBjbGllbnRzIGFuZCAoc2VwYXJhdGVseSkgb24NCj4gPiA+
ID4gPiBkaXNrLsKgDQo+ID4gPiA+ID4gKFRoYXQNCj4gPiA+ID4gPiB3b3VsZCBzdGlsbCBhbGxv
dyB0aGUgY2hhbmdlIGF0dHJpYnV0ZSB0byBnbyBiYWNrd2FyZHMgYWZ0ZXINCj4gPiA+ID4gPiBh
DQo+ID4gPiA+ID4gY3Jhc2gsDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiB0aGUgdmFsdWUgaXQg
aGVsZCBhcyBvZiB0aGUgb24tZGlzayBzdGF0ZSBvZiB0aGUgZmlsZS7CoCBJDQo+ID4gPiA+ID4g
dGhpbmsNCj4gPiA+ID4gPiBjbGllbnRzDQo+ID4gPiA+ID4gc2hvdWxkIGJlIGFibGUgdG8gZGVh
bCB3aXRoIHRoYXQgY2FzZS4pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQnV0LCBJIGRvbid0IGtu
b3csIG1heWJlIGEgYmlnZ2VyIGhhbW1lciB3b3VsZCBiZSBPSzoNCj4gPiA+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IElmIHlvdSdyZSBub3QgZ29pbmcgdG8gbWVldCB0aGUgbWluaW11bSBiYXIg
b2YgZGF0YSBpbnRlZ3JpdHksDQo+ID4gPiA+IHRoZW4NCj4gPiA+ID4gdGhpcyB3aG9sZSBleGVy
Y2lzZSBpcyBqdXN0IGEgbWFzc2l2ZSB3YXN0ZSBvZiBldmVyeW9uZSdzIHRpbWUuDQo+ID4gPiA+
IFRoZQ0KPiA+ID4gPiBhbnN3ZXIgdGhlbiBnb2luZyBmb3J3YXJkIGlzIGp1c3QgdG8gcmVjb21t
ZW5kIG5ldmVyIHVzaW5nDQo+ID4gPiA+IExpbnV4IGFzDQo+ID4gPiA+IGFuDQo+ID4gPiA+IE5G
UyBzZXJ2ZXIuIE1ha2VzIG15IGxpZmUgbXVjaCBlYXNpZXIsIGJlY2F1c2UgSSBubyBsb25nZXIg
aGF2ZQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiBkZWJ1ZyBhbnkgb2YgdGhlIGlzc3Vlcy4NCj4gPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBUbyBiZSBjbGVhciwgeW91IGJlbGlldmUgYW55
IHNjaGVtZSB0aGF0IHdvdWxkIGFsbG93IHRoZSBjbGllbnQNCj4gPiA+IHRvDQo+ID4gPiBzZWUN
Cj4gPiA+IGFuIG9sZCBjaGFuZ2UgYXR0ciBhZnRlciBhIGNyYXNoIGlzIGluc3VmZmljaWVudD8N
Cj4gPiA+IA0KPiA+IA0KPiA+IENvcnJlY3QuIElmIGEgTkZTdjQgY2xpZW50IG9yIHVzZXJzcGFj
ZSBhcHBsaWNhdGlvbiBjYW5ub3QgdHJ1c3QNCj4gPiB0aGF0DQo+ID4gaXQgd2lsbCBhbHdheXMg
c2VlIGEgY2hhbmdlIHRvIHRoZSBjaGFuZ2UgYXR0cmlidXRlIHZhbHVlIHdoZW4gdGhlDQo+ID4g
ZmlsZQ0KPiA+IGRhdGEgY2hhbmdlcywgdGhlbiB5b3Ugd2lsbCBldmVudHVhbGx5IHNlZSBkYXRh
IGNvcnJ1cHRpb24gZHVlIHRvDQo+ID4gdGhlDQo+ID4gY2FjaGVkIGRhdGEgbm8gbG9uZ2VyIG1h
dGNoaW5nIHRoZSBzdG9yZWQgZGF0YS4NCj4gPiANCj4gPiBBIGZhbHNlIHBvc2l0aXZlIHVwZGF0
ZSBvZiB0aGUgY2hhbmdlIGF0dHJpYnV0ZSAoaS5lLiBhIGNhc2Ugd2hlcmUNCj4gPiB0aGUNCj4g
PiBjaGFuZ2UgYXR0cmlidXRlIGNoYW5nZXMgZGVzcGl0ZSB0aGUgZGF0YS9tZXRhZGF0YSBzdGF5
aW5nIHRoZQ0KPiA+IHNhbWUpIGlzDQo+ID4gbm90IGRlc2lyYWJsZSBiZWNhdXNlIGl0IGNhdXNl
cyBwZXJmb3JtYW5jZSBpc3N1ZXMsIGJ1dCBmYWxzZQ0KPiA+IG5lZ2F0aXZlcw0KPiA+IGFyZSBm
YXIgd29yc2UgYmVjYXVzZSB0aGV5IG1lYW4geW91ciBkYXRhIGJhY2t1cCwgY2FjaGUsIGV0Yy4u
LiBhcmUNCj4gPiBub3QNCj4gPiBjb25zaXN0ZW50LiBBcHBsaWNhdGlvbnMgdGhhdCBoYXZlIHN0
cm9uZyBjb25zaXN0ZW5jeSByZXF1aXJlbWVudHMNCj4gPiB3aWxsDQo+ID4gaGF2ZSBubyBvcHRp
b24gYnV0IHRvIHJldmFsaWRhdGUgYnkgYWx3YXlzIHJlYWRpbmcgdGhlIGVudGlyZSBmaWxlDQo+
ID4gZGF0YQ0KPiA+ICsgbWV0YWRhdGEuDQo+ID4gDQo+ID4gPiBUaGUgb25seSB3YXkgSSBjYW4g
c2VlIHRvIGZpeCB0aGF0IChhdCBsZWFzdCB3aXRoIG9ubHkgYSBjcmFzaA0KPiA+ID4gY291bnRl
cikNCj4gPiA+IHdvdWxkIGJlIHRvIGZhY3RvciBpdCBpbiBhdCBwcmVzZW50YXRpb24gdGltZSBs
aWtlIE5laWwNCj4gPiA+IHN1Z2dlc3RlZC4NCj4gPiA+IEJhc2ljYWxseSB3ZSdkIGp1c3QgbWFz
ayBvZmYgdGhlIHRvcCAxNiBiaXRzIGFuZCBwbG9wIHRoZSBjcmFzaA0KPiA+ID4gY291bnRlcg0K
PiA+ID4gaW4gdGhlcmUgYmVmb3JlIHByZXNlbnRpbmcgaXQuDQo+ID4gPiANCj4gPiA+IEluIHBy
aW5jaXBsZSwgSSBzdXBwb3NlIHdlIGNvdWxkIGRvIHRoYXQgYXQgdGhlIG5mc2QgbGV2ZWwgYXMN
Cj4gPiA+IHdlbGwNCj4gPiA+IChhbmQNCj4gPiA+IHRoYXQgbWlnaHQgYmUgdGhlIHNpbXBsZXN0
IHdheSB0byBmaXggdGhpcykuIFdlIHByb2JhYmx5IHdvdWxkbid0DQo+ID4gPiBiZQ0KPiA+ID4g
YWJsZSB0byBhZHZlcnRpc2UgYSBjaGFuZ2UgYXR0ciB0eXBlIG9mIE1PTk9UT05JQyB3aXRoIHRo
aXMNCj4gPiA+IHNjaGVtZQ0KPiA+ID4gdGhvdWdoLg0KPiA+IA0KPiA+IFdoeSB3b3VsZCB5b3Ug
d2FudCB0byBsaW1pdCB0aGUgY3Jhc2ggY291bnRlciB0byAxNiBiaXRzPw0KPiA+IA0KPiANCj4g
VG8gbGVhdmUgbW9yZSByb29tIGZvciB0aGUgInJlYWwiIGNvdW50ZXIuIE90aGVyd2lzZSwgYW4g
aW5vZGUgdGhhdA0KPiBnZXRzDQo+IGZyZXF1ZW50IHdyaXRlcyBhZnRlciBhIGxvbmcgcGVyaW9k
IG9mIG5vIGNyYXNoZXMgY291bGQgZXhwZXJpZW5jZQ0KPiB0aGUNCj4gY291bnRlciB3cmFwLg0K
PiANCj4gSU9XLCB3ZSBoYXZlIDYzIGJpdHMgdG8gcGxheSB3aXRoLiBXaGF0ZXZlciBwYXJ0IHdl
IGRlZGljYXRlIHRvIHRoZQ0KPiBjcmFzaCBjb3VudGVyIHdpbGwgbm90IGJlIGF2YWlsYWJsZSBm
b3IgdGhlIGFjdHVhbCB2ZXJzaW9uIGNvdW50ZXIuDQo+IA0KPiBJJ20gcHJvcG9zaW5nIGEgMTYr
NDcrMSBzcGxpdCwgYnV0IEknbSBoYXBweSB0byBoZWFyIGFyZ3VtZW50cyBmb3IgYQ0KPiBkaWZm
ZXJlbnQgb25lLg0KDQoNCldoYXQgaXMgdGhlIGV4cGVjdGF0aW9uIHdoZW4geW91IGhhdmUgYW4g
dW5jbGVhbiBzaHV0ZG93biBvciBjcmFzaD8gRG8NCmFsbCBjaGFuZ2UgYXR0cmlidXRlIHZhbHVl
cyBnZXQgdXBkYXRlZCB0byByZWZsZWN0IHRoZSBuZXcgY3Jhc2gNCmNvdW50ZXIgdmFsdWUsIG9y
IG9ubHkgc29tZT8NCg0KSWYgdGhlIGFuc3dlciBpcyB0aGF0ICdhbGwgdmFsdWVzIGNoYW5nZScs
IHRoZW4gd2h5IHN0b3JlIHRoZSBjcmFzaA0KY291bnRlciBpbiB0aGUgaW5vZGUgYXQgYWxsPyBX
aHkgbm90IGp1c3QgYWRkIGl0IGFzIGFuIG9mZnNldCB3aGVuDQp5b3UncmUgZ2VuZXJhdGluZyB0
aGUgdXNlci12aXNpYmxlIGNoYW5nZSBhdHRyaWJ1dGU/DQoNCmkuZS4gc3RhdHguY2hhbmdlX2F0
dHIgPSBpbm9kZS0+aV92ZXJzaW9uICsgKGNyYXNoIGNvdW50ZXIgKiBvZmZzZXQpDQoNCih3aGVy
ZSBvZmZzZXQgaXMgY2hvc2VuIHRvIGJlIGxhcmdlciB0aGFuIHRoZSBtYXggbnVtYmVyIG9mIGlu
b2RlLQ0KPmlfdmVyc2lvbiB1cGRhdGVzIHRoYXQgY291bGQgZ2V0IGxvc3QgYnkgYW4gaW5vZGUg
aW4gYSBjcmFzaCkuDQoNClByZXN1bWFibHkgdGhhdCBvZmZzZXQgY291bGQgYmUgc2lnbmlmaWNh
bnRseSBzbWFsbGVyIHRoYW4gMl42My4uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
