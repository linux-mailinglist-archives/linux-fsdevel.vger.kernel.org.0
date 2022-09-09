Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705945B2BF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 04:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIICOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 22:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIICO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:14:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D94116C;
        Thu,  8 Sep 2022 19:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/JqXM5rU48/h/uCT+w1OvJYtNQyJqJDXKpJbVhY7BlMERuj6KPDV4vh7UHjziZKTRX1ZALS946RZgWUPTImODXzwUFp5mdkE+XnPpq5sJOkWP1TT2a5f+dm1Vwrje9yPTt+V+r3UoVeU9uNTSl3FggUKJh9NLlJ1s3AtQk0zIgYxqpMhXRnvR3XCPm8QYdZ3TOh4PWC/nzlqEFqqyJc1ZSv2CeTHkcClx0z8Ig+eq7VivaBqBt+xKxjYy2gs2W44xVF4ts4nHuVNn2dXqcUUo8ED/No/ISoj8vlROi//wUYjL/hMW1ducqKY44H8VV7ZCPY5SdWHRei/AZ3exdlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im5rYxp+He6Nm5p0nlXyodFgK8ztuKi9IGN619gtpq4=;
 b=HOTeLSGhtDjdHJZFe6pcjcHWjbPoKkoZnLXFvoCuVIMwEd5j9FlLp+oP2sy4+j+OMUyyB2hgPN2EB0vUVmu9rAqCepOrfnEL5ce3hiRJpiErcr8y40mpiJ7LIX817O/jp4EVKzPi3N3S3Guoxfumb85NmhKqtMYqJbsgJOBSlLikiYoPu+r7syF0W1E8CrHEeiJNODrbrYDd03cJAE7Nog9Q5HeK/aE4eyu2JQOK2vmehz9uDIrvQ/78chqtvNQWH1NQlmIP1iFBvEBVmrnlq5VT0b+73aVvpxjlVqh7X+iDb1qEdHq87NYrsl6rfMc1UFXtWob/wAQ8y3hTgTMuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im5rYxp+He6Nm5p0nlXyodFgK8ztuKi9IGN619gtpq4=;
 b=Vc8rT1nW3278lIuTPoG+p+zzzqxfC3CcLrfEpuVfc/7hbAwGlPtSuhf5WhUZ3aQtlmswmPLGeiwixhQJ1OAKrXBl5u8Yv0SAjut75/4XlYuGZ0pZc419fhNcjU21lviH8LaZoUxZa+FVOLBRAIvJ00EGEd/wHzItLxYX1mR4ZCI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB5043.namprd13.prod.outlook.com (2603:10b6:a03:369::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6; Fri, 9 Sep
 2022 02:14:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Fri, 9 Sep 2022
 02:14:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAeIiAgAARsICAAA6CgIAABKSAgAAA1wCAABG9gA==
Date:   Fri, 9 Sep 2022 02:14:19 +0000
Message-ID: <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>  ,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>  ,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>        ,
 <20220907125211.GB17729@fieldses.org>    ,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>        ,
 <20220907135153.qvgibskeuz427abw@quack3>              ,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>  ,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>      ,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>        ,
 <166267775728.30452.17640919701924887771@noble.neil.brown.name>                ,
 <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>              ,
 <166268467103.30452.1687952324107257676@noble.neil.brown.name>
         <166268566751.30452.13562507405746100242@noble.neil.brown.name>
         <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>
In-Reply-To: <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB5043:EE_
x-ms-office365-filtering-correlation-id: 71004a2d-e99f-47a8-4aac-08da92090122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pH4JGQQzVUpn93W7VvcDgXjGNVPbkKKfU6qH1mIih0e72oTe0guKACHiBrC+PT1fLdmkltJSY+cztTEAq/VQ3IG1z9DJCdliR9sE49+G1Xrxfk4qbo51eil/G2XnUawq3yhyQHKLogi/+M0Hft4VVL0jIPrbl1BlrjLkBAaulVIcdr/YQpP+la2vdTpdDbF0TmpRNj8kBZxC5afnxsUwNvCI6PYRB9ahRpOVJAKlt/WkJKEQE2+Lwt9arbvPkk7qI82+OF0ChBoHgBurAQOGwSfG4lF0bQLvsybjoUZr5wWw26VO3tmH8frEvqlw+3RgIybpAvVlAjReJZ/1LiKqic5n9TzX1xqItgTgvm8d21FsSvnNeX8DHykmgdDqslMNFfNbDI3mdL6p2lWiS9EoEEqCXcZrR2wu3NO1hdFHmZti314lVZnrtGtk47ww42fCe1ssRI0wsnMfMAz6DuVk3N27VijO7+Up94zKs8oOT4gjiNLZBujF1XuXLRm+jQZTMSpwQe9wRl9WlSrwRHvcOPBcDHhKhIzyiKkhIiRP2ae9Gh47bKU+Mplrjq5xVqhGuZbSYJYs80wBFti3Fx/e4qlg2hMokrbMWIiOcjnmHVO4iWLB17kkgW+SjYM4rKLLRCjk7ad4H1jM6+nZlTynnXGFps6sj5hrCrtgW8Wuhp7qwM630Wlkm5JKNtxU1ZIXqD9gkpGKrA+LBTbeAIRO1Pdv3tRfqLhAGWS+yvsZFX3a09bKpcy9+xuxd2nXzKXZQDqldpiYTwZgeZ2PU8vhqI7D17OngfHI6JCwq7UKSjEGtelmyX6Yq5XvvsXBLVnv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(376002)(136003)(39850400004)(86362001)(122000001)(38100700002)(66476007)(76116006)(64756008)(8676002)(4326008)(66946007)(66446008)(66556008)(36756003)(38070700005)(41300700001)(2616005)(83380400001)(71200400001)(26005)(6506007)(6486002)(478600001)(6512007)(186003)(6916009)(54906003)(316002)(2906002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ditKejQ0ckhVMXJGTEU3aUw2aGZJUFB5U3pRNWdTMVdHSWxyK1p2Y285Wkp4?=
 =?utf-8?B?SWZ0cjNubDd6YUFUT3ZGaDFlbGR1VWluOExnS0U2SytOMVdaNTRRMDBhNGR4?=
 =?utf-8?B?MDdEMXhuSG53OFFpbXFLbE5IUU5iMFl1aytCbmtYSzBEWkRPSnhSb0d5a1JD?=
 =?utf-8?B?OUtoK1dPajBpcWF6SVpaWlcrODhMNEs0NjN5N280SkVzcmFERjByQVBzMlBY?=
 =?utf-8?B?RTJlYnpRYStzbkFnNlhrbmY3dm5CcXprZVdrUWJBWlJLb3lqWkFXSGRiTFZE?=
 =?utf-8?B?NnNYOGNmQ1lRUXlvdVVNd1FrRUZQS3hKdVp5enF0STQ4Qml0MHRKWTlyeGRQ?=
 =?utf-8?B?NjNwQzk3NzdTRU4xanBFT2pYYWwyc3NUaWxWN3VCNkdmMFhSa1VxcXJTeWJU?=
 =?utf-8?B?S1JCM0hhZEVjTmZyWGNxaW9UYXBzRkVSbXZ5VTlyTVpZYUxJYW93S1ZtVkZt?=
 =?utf-8?B?dlU1SFZneER5Y3laU2ZDZEFpdU9NT0ducEt6RHF5eDlPNVZ2ZVl5cGZqTVdZ?=
 =?utf-8?B?THUxTk9MNW85TUg3a2M0OFhGU2JpZm0vS2ozNlNmai94YWt4WkhGVTgzd0lO?=
 =?utf-8?B?c245ZHQvbldCT3JWbjFCcGV4Y0tFb0cyeGRmZ0RXUW5WNTdmTTFUbHR2aUJP?=
 =?utf-8?B?S2wrM050SmRUeWgvMEcxb0Q2ZEZMZ3JLQjNoK04vWGtYQllNb1FtQTVFdXlC?=
 =?utf-8?B?OEpCU252T0g1cE5MY1l0YUdNUG12RFRFRnRFVmpsdjE0N21acU5ON1Y2NFdD?=
 =?utf-8?B?c25KVlM4L0pGd1NpcFZlRTZuSUNwdHY0NE91Qi95SWlyd2loQWZzYzFCejNi?=
 =?utf-8?B?SklyYUdPQXI5NlNhNkV4cWdweHlqRXB0d095bmxoYkJKYVRoOUdWbHVUNjdR?=
 =?utf-8?B?MXdpYlhuVHY1T3BkR3lxT2dwcVNoTXlrRTVsTTFpZFluTzhqRUF5WWpWNG1K?=
 =?utf-8?B?cU41WkVpOXkxSXFCMjVyKzhVczI4Mm5udVVmVmQ2M3I3TFlRalBLeENjMXp4?=
 =?utf-8?B?UWhVNTNMb1Fwdm9QSVNiakI3TmtRdXZ2Q0lESlhsVytWNlk5Vk9rRDB4clhJ?=
 =?utf-8?B?Vmpyd0E4N2lXT1RLdlZhc0ZKdkxJUDVnTlVXVWV6a3hkT0M4TTExUVFKUFRC?=
 =?utf-8?B?OS9EaVJscllWY0V3ajBOSWdIT0h4dzFlY0RlQWZYMG5xVll0OU4vUGUvR0pi?=
 =?utf-8?B?bDBTRHdWRFZ1NytIRGVCUGsyRWk2Q1EvWnkxR2Y4emJiUnZrL0VFNnNLWWR6?=
 =?utf-8?B?TDhiU3RXbFJrVE51NFljcEV2S0dGWW1hZGVEZXpQWFppbjZ5ekpKL3Ziandv?=
 =?utf-8?B?ajZsbkJUUi9uVk90enB6Zm1XYkpoUENiQVdBdGhLUVB4NjByU2h4TUNPbUh3?=
 =?utf-8?B?ZlhUYXlhc1VKUi9lQkxodkV1VmIwalNRRzNBVG0rYitUWkpPOW5mU2FtQjYz?=
 =?utf-8?B?Y2xYZ1Q3eTlCNDE5SnphYlNOMnlaZXEraTVja1piQ05VOGZSdnE1OVBHc3U4?=
 =?utf-8?B?VmZheWZLa0d3a3JkbTJ3Rm9zbkY3Y3FNTGxGOExtM3JON1Z2RFNKTVN0cG9q?=
 =?utf-8?B?d21aeVBkazYxS2h3SlMzUVZUNVZJV1gxTExQTC94bnJKd0NITDV6ZGs0S2l5?=
 =?utf-8?B?MWZRcllKY1F1Yi9YZk85OE1XeW5nck5SenhBL2xyaHl1RS9qNUVDallNY090?=
 =?utf-8?B?aGY5THdZajJhRC9YaHppTkxzSndhdkVrYWlOTFV4SUxDSDBtd3B1YU5VOEF2?=
 =?utf-8?B?ZnNKd2Y5cVVJSXMrVkdXUklXV1RnMXJLYWtyZFduRG5sc2NiamVnRG94UVIv?=
 =?utf-8?B?dytlNUY1cUgyandndTFPMU4rQU5NZ1lBVFhzQzBoQ2FWVUtVVmhUWmpBY01T?=
 =?utf-8?B?b3k2U2pIbXQ2M3NuenJCOE52amg3RTYwVXU1d3dhQjNVZ2RmSHhHcmxNMjI3?=
 =?utf-8?B?OG5aNWZMdGtVNXhaSDlPZmZBODhIdTFIOUxKT2MwRWtpY2hCSzhVSk1Nc09U?=
 =?utf-8?B?eWE1Z3hJSE1iRW9aTmZVNFJTTk01YXB3ZVNheSs1WWhkQnB3azgxUTlBL1RG?=
 =?utf-8?B?NnNDbnZUd3ZIK3FhQ09VQzVHQ2oweTJET0NKd0lKTWNFNUV6N3IrMXdXa1Vu?=
 =?utf-8?B?TE1laUJLSmplTEZ1TnZHb0tqTlM2WXgvRW1GeDE2VUlwbkQ0c3FUT1NQUFdr?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E66D2E8222ABF45965B8D45838F552C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB5043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDAxOjEwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMi0wOS0wOSBhdCAxMTowNyArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0K
PiA+IE9uIEZyaSwgMDkgU2VwIDIwMjIsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIEZyaSwg
MDkgU2VwIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gSU9XOiB0aGUgbWluaW1hbCBjb25kaXRpb24gbmVlZHMgdG8gYmUgdGhhdCBmb3IgYWxs
IGNhc2VzDQo+ID4gPiA+IGJlbG93LA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gYXBwbGljYXRpb24g
cmVhZHMgJ3N0YXRlIEInIGFzIGhhdmluZyBvY2N1cnJlZCBpZiBhbnkgZGF0YSB3YXMNCj4gPiA+
ID4gY29tbWl0dGVkIHRvIGRpc2sgYmVmb3JlIHRoZSBjcmFzaC4NCj4gPiA+ID4gDQo+ID4gPiA+
IEFwcGxpY2F0aW9uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoEZpbGVzeXN0ZW0NCj4gPiA+ID4gPT09PT09PT09PT3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPT09PT09PT09DQo+
ID4gPiA+IHJlYWQgY2hhbmdlIGF0dHIgPC0gJ3N0YXRlIEEnDQo+ID4gPiA+IHJlYWQgZGF0YSA8
LSAnc3RhdGUgQScNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3cml0ZSBkYXRhIC0+
ICdzdGF0ZSBCJw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDxjcmFzaD4rPHJlYm9v
dD4NCj4gPiA+ID4gcmVhZCBjaGFuZ2UgYXR0ciA8LSAnc3RhdGUgQicNCj4gPiA+IA0KPiA+ID4g
VGhlIGltcG9ydGFudCB0aGluZyBoZXJlIGlzIHRvIG5vdCBzZWUgJ3N0YXRlIEEnLsKgIFNlZWlu
ZyAnc3RhdGUNCj4gPiA+IEMnDQo+ID4gPiBzaG91bGQgYmUgYWNjZXB0YWJsZS7CoCBXb3JzdCBj
YXNlIHdlIGNvdWxkIG1lcmdlIGluIHdhbGwtY2xvY2sNCj4gPiA+IHRpbWUNCj4gPiA+IG9mDQo+
ID4gPiBzeXN0ZW0gYm9vdCwgYnV0IHRoZSBmaWxlc3lzdGVtIHNob3VsZCBiZSBhYmxlIHRvIGJl
IG1vcmUgaGVscGZ1bA0KPiA+ID4gdGhhbg0KPiA+ID4gdGhhdC4NCj4gPiA+IA0KPiA+IA0KPiA+
IEFjdHVhbGx5LCB3aXRob3V0IHRoZSBjcmFzaCtyZWJvb3QgaXQgd291bGQgc3RpbGwgYmUgYWNj
ZXB0YWJsZSB0bw0KPiA+IHNlZQ0KPiA+ICJzdGF0ZSBBIiBhdCB0aGUgZW5kIHRoZXJlIC0gYnV0
IHByZWZlcmFibHkgbm90IGZvciBsb25nLg0KPiA+IEZyb20gdGhlIE5GUyBwZXJzcGVjdGl2ZSwg
dGhlIGNoYW5nZWlkIG5lZWRzIHRvIHVwZGF0ZSBieSB0aGUgdGltZQ0KPiA+IG9mDQo+ID4gYQ0K
PiA+IGNsb3NlIG9yIHVubG9jayAoc28gaXQgaXMgdmlzaWJsZSB0byBvcGVuIG9yIGxvY2spLCBi
dXQgYmVmb3JlIHRoYXQNCj4gPiBpdA0KPiA+IGlzIGp1c3QgYmVzdC1lZmZvcnQuDQo+IA0KPiBO
b3BlLiBUaGF0IHdpbGwgaW5ldml0YWJseSBsZWFkIHRvIGRhdGEgY29ycnVwdGlvbiwgc2luY2Ug
dGhlDQo+IGFwcGxpY2F0aW9uIG1pZ2h0IGRlY2lkZSB0byB1c2UgdGhlIGRhdGEgZnJvbSBzdGF0
ZSBBIGluc3RlYWQgb2YNCj4gcmV2YWxpZGF0aW5nIGl0Lg0KPiANCg0KVGhlIHBvaW50IGlzLCBO
RlMgaXMgbm90IHRoZSBvbmx5IHBvdGVudGlhbCB1c2UgY2FzZSBmb3IgY2hhbmdlDQphdHRyaWJ1
dGVzLiBXZSB3b3VsZG4ndCBiZSBib3RoZXJpbmcgdG8gZGlzY3VzcyBzdGF0eCgpIGlmIGl0IHdh
cy4NCg0KSSBjb3VsZCBiZSB1c2luZyBPX0RJUkVDVCwgYW5kIGFsbCB0aGUgdHJpY2tzIGluIG9y
ZGVyIHRvIGVuc3VyZSB0aGF0DQpteSBzdG9jayBicm9rZXIgYXBwbGljYXRpb24gKHRvIGNob29z
ZSBvbmUgZXhhbXBsZSkgaGFzIGFjY2VzcyB0byB0aGUNCmFic29sdXRlIHZlcnkgbGF0ZXN0IHBy
aWNlcyB3aGVuIEknbSB0cnlpbmcgdG8gZXhlY3V0ZSBhIHRyYWRlLg0KV2hlbiB0aGUgZmlsZXN5
c3RlbSB0aGVuIHNheXMgJ3RoZSBwcmljZXMgaGF2ZW4ndCBjaGFuZ2VkIHNpbmNlIHlvdXINCmxh
c3QgcmVhZCBiZWNhdXNlIHRoZSBjaGFuZ2UgYXR0cmlidXRlIG9uIHRoZSBkYXRhYmFzZSBmaWxl
IGlzIHRoZQ0Kc2FtZScgaW4gcmVzcG9uc2UgdG8gYSBzdGF0eCgpIHJlcXVlc3Qgd2l0aCB0aGUg
QVRfU1RBVFhfRk9SQ0VfU1lOQw0KZmxhZyBzZXQsIHRoZW4gd2h5IHNob3VsZG4ndCBteSBhcHBs
aWNhdGlvbiBiZSBhYmxlIHRvIGFzc3VtZSBpdCBjYW4NCnNlcnZlIHRob3NlIHByaWNlcyByaWdo
dCBvdXQgb2YgbWVtb3J5IGluc3RlYWQgb2YgaGF2aW5nIHRvIGdvIHRvIGRpc2s/DQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
