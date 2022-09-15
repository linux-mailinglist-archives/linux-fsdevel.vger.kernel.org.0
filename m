Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6AA5B9E85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiIOPPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIOPO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:14:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8EC96FC2;
        Thu, 15 Sep 2022 08:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3MS3G62308tWXsTANYiJaQ+acNzcsmTuhDZNnCBkbOF9PXNODd8Y7WPn2oT/0I2v2tGjBY0nDI0iB1GlnguMiemQvMooJCYYSV2KdzpN6FPm/ZE9DUysREyn73wqT+kOl+4N6kR3PMTR52SMJOhznZ1cKyMsXj+M+8j3yPDQPbFiks2fAefX+ZHFvCJLqcAj6M7aGXG3Gc1AikLddpgh6jCNWZpjbo80Id2bEKHk1BCV1LDvblf8QNVn4jYwwxm99UGdROEKR/+zzrJ62NyF2I8qq8zjlA36mcWhB9VtGSNg7cNdC8NCwmojuLXLzWnXdOk/hPhDoSzFY0npCJl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niUI6ik+e3sJVSVSh/1xA9k3AWTERhlxJk1f9SpkbTY=;
 b=kXYYw6LLSq1TZyF6K0FLBPJNZxwxACcVj6wyd/tuv2h5B28b5x3EQO5lEBXnsLWzjvZC7hvyi3dfZQwX6U8+ueAOSLosFuB8ZIZgenYCWptsCJUCq9bwPiE6rZGSOPVCX3L5Yl4EI4jLSm6CVfYuh2r5lF4th8dO4PXsCUPwuLKomRTqxGPkR54uqb6g2a5VYAKGIWNn183TSHzrNX3RKdEqbkrb+lRPt2+ocmHtIMiRLKLeR4uVjGrMXd1QK5BBlpafX+jj8Nhd1gEj5exE0zkowoabeVcqVdKPX84+B4aA0vht28UqcJgxvMh4Sa7mEdTlWcdhWv2kE5FD42f+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niUI6ik+e3sJVSVSh/1xA9k3AWTERhlxJk1f9SpkbTY=;
 b=JSI/jMlL8QD4NK4zMmH76wd/r98ToDI+sAnD6lhNGY00v/qR8fcyGurXz55RV7UvPJ52F1AzpG8qisqRFItCsW6wzsDbn1YaH9bUZOPEu6FjOUgIMgq4FfsTB8DftWr8H17uYQfMWwpuJDB3j1RxS0saveV9yhelqnwew9x/6tY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5445.namprd13.prod.outlook.com (2603:10b6:510:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12; Thu, 15 Sep
 2022 15:08:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5632.012; Thu, 15 Sep 2022
 15:08:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAAzmAgAAdFoCAAAvtAIAADJkAgANYaoCAApXgAIAAn+4AgAQd8ACAABFGgA==
Date:   Thu, 15 Sep 2022 15:08:34 +0000
Message-ID: <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
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
In-Reply-To: <20220915140644.GA15754@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5445:EE_
x-ms-office365-filtering-correlation-id: 10dc1ef3-98b5-4320-a6a9-08da972c290f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlHVe6olJkCvmrtbJHiY/vBEGg5QRoq6px8x+Vxoi3IrXYh1OUgO3l63XyWW1YY5FGvfSRUfbRUxi6LK5IjChSofEgYXCHvpqhd4dRiHcL2kVfVlixYgnKohl/cRNJ6lZ8P2rO3HmWRtTqUf6zQpCajXYv3Z9wOQbIgCro4MHHIVOtE3tPO9dtG5l7MAS8JygXJgArFq08wT5eyP5yU5ulPIjdxEK/CBr2CbV99fkF+6vgciCQyXaDFmptMrxCbne8rQ5utVk+HpHxiNF4dGL+BB2UrYrBIIjTEdVECXrPKqB5z/c8Q0VnHGAtoQ/4jwINQlmcPY1Ueaje3LV9jgNavMCtxJuU/fQJqE8/B65iJj6O7Wf051UERENZts12ZTYMY2r3N3pL/LJ0NnHxOHGGB2I08AyLdMUPL8fRp+Tmi/GrSIq4gNkOweTFpox2SPoQI6tvYCErC4Q4dPxHKFQuZ4AS/1AdAL1rEKip/Z4b8la4JFUjpAFEWh1BaMU+bHXvaOFngqqRbeAyART/ZhEyJMlFuPFyhZAffhRi4V5ooRoFRJlVxslAaiotX9JRZaq+YQm4G/mJq56iII2mkb99zFa2ywKVngIT0rf9kr3gD8opJsRRUR98toctQv802hutdGjhAG5r2uTMVF9L8ftiN4OP/nykVn2sVL4K/G3VrxQKKfRG9yQHc9LCn4rniWY36rrU9fC1jd9tQZqfOwSK6emKTSfyooEcACh9+8M2K3Ex1aLNIKIlVcNrQSKCyYUeBstSbeFfG4/ozFbyxsV9Dz2WfCe53Ut+9ozydKOQWMgDp+YVqgYpHmZR7PUS8b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(346002)(376002)(136003)(396003)(366004)(451199015)(38070700005)(478600001)(66476007)(66946007)(86362001)(5660300002)(41300700001)(36756003)(6512007)(122000001)(110136005)(4326008)(8936002)(6506007)(316002)(2906002)(26005)(83380400001)(64756008)(38100700002)(66899012)(91956017)(66446008)(8676002)(76116006)(66556008)(71200400001)(54906003)(2616005)(7416002)(186003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djVRa3B2eUk0MFhOcU9tTWtxcUhzbUs0ckhzMWNNdXF6MldSdFFFdU1YaE9S?=
 =?utf-8?B?WWdhdU9uZ20xUjUxTmJVQnYvcmdKczFILytza3E4dWh5V05yMEs2bVg1ZnhC?=
 =?utf-8?B?bVRZQzllSjVWN1plWENha2RZalVKNmxpWkJkemdVK1hwSW9kUnZrOWxDSUcy?=
 =?utf-8?B?TEhiNGVGbUEyczBqR1dvUWVtWEt2Q05LRGR0ZVhlQlZKWWtjVlliQWJnSS9N?=
 =?utf-8?B?azByMUFqK3ZxUTJtRmhvWDcwYjBZb3paV0EyUUlnSC9UK01wWmZSdUxvRGln?=
 =?utf-8?B?Zlp4ekhJaDZIYkxRbFFtUE1CMFExUFBhQVozU0hYVVlxcWN3OGxDN2kxYy84?=
 =?utf-8?B?eHFEemJKcndSMlI0VHd1SWtEWVR6czNiMlpSbndzUEpVZ1gwejNhY21hU2dJ?=
 =?utf-8?B?dnNRL2xXZHduRGlua2RQNVVyRStDTStZT2xUamMxTTJ5QmNjSFo5Zjl4OHNo?=
 =?utf-8?B?U1I1RnRuTkhWMFdYVTVHVVE5cFdGTjg3WUpvU0tpYU43cjh6dU5yYWk0STI0?=
 =?utf-8?B?cmJ0STN6dzM4eHpIRnlTQmVZRmd6TEpVdytVVDg5SUdLb2NxNHJmRDdwSzRE?=
 =?utf-8?B?NTVjMXNBNnFIaGk5ZnRIOS8wQlFRajh5am5OYUtnMGdYVit4SDNFS25VYnZ5?=
 =?utf-8?B?SW80VHFlZi9wVXVkZU9ieThJSGtMMTVGRjNTV1dXTmRYd29icEhHeGd5b3Mx?=
 =?utf-8?B?TmFDRy9nWDZTNFkrV0RSbC9PNkROUlhsRlYxWGoyVS9WczJ5aWZxODdheU1r?=
 =?utf-8?B?b003VWVWRjhTZk1pMTRHNUZuTGF2WTdpUmhNemhVNmkrSnVQcitCYmJxTW1a?=
 =?utf-8?B?c2twQTVncldzdHRoS2FlVjUzMC9uYXlCVTl3OXpBZnJLVjVCOFplNmVLckxN?=
 =?utf-8?B?aTJ2cDc4QTNzTXN5MEtod01QY3QxTHY0L1ZRQW5QUFh3Y3pBaUVUbzRta1FC?=
 =?utf-8?B?N3NoSmRvL05OZXVqc0Fia1RlVEpVRTNIN0NabDRIMUtYamc1dURkTjhPQzl0?=
 =?utf-8?B?NTFhQ0tGd1ZRTEhDYzFzNEVzRXFpVVloRzFRSGI1S05FRU1CbkZnaW5UbGhF?=
 =?utf-8?B?YjJkek5WZHV4Y1hiNVBmNUdqcFpxOW9ic1dPOTFsbFJCRStMTkVzQlZyY1hJ?=
 =?utf-8?B?NW80Z3RjWEI3RGZxM2JpOWwxSEtmMXlVYWh2Q1pLRVVkUEdXR3dhdzM2aiti?=
 =?utf-8?B?clVFdkZnQ0FISVJ2TG1YWUlXSHVaZkZGYUgwZVgrcDRvcXBjS1VKbCtRc2py?=
 =?utf-8?B?bHZPZmNSRGxUVnRDOVcxNCtiY25GK0t0dGRvWWR1UTBHbVVyL283eGowZERJ?=
 =?utf-8?B?R291WjRQSllMMjNaaURyUGJ4WDFqV293WUVoeE8xckZGWGRLV0FBUWVWY2lZ?=
 =?utf-8?B?NUsvM0dnWUNvNHhUMDZRMGFRaHNoNVpnK2dDbkkzWHZ4STZObC9nYm1HZjJV?=
 =?utf-8?B?cm81L0xkQUgyVSt2bzhIenpnd3piNURHU0l1OS80ckFrTk1KeFRUWlptL3Ex?=
 =?utf-8?B?aE1yM2Q3cVZnUVRyeFZTWUN4cGswRG5iZ2NZckpoNWI5c0ZHQ3RhNFR3Z1RZ?=
 =?utf-8?B?SC9Zenl5a0xsNGp6cnJEd2x2SE9QTFh4amZ3RGhZZ2k1RlJBZUtlTTFyMndW?=
 =?utf-8?B?Q2QwUGd2OXdwYkhpeDVHZHN1amczWXA5cVBqMGFlN092SG01ZUlXUnJPQ1pz?=
 =?utf-8?B?TUJISjRUcEJHQ1pPUUZwRUt1VUc2ZXV5VldkRzgxVTJiWTNlMXdLM09xOFcx?=
 =?utf-8?B?K2lTUU1ZQlBTSU9xTjUxa25SRkpFK2pCZWtqWlBWSkdKeVRRMGZ1c1FwdHdB?=
 =?utf-8?B?QTUyNHI1T2NUVkN1N2lub0tNU0Zzdy9LNER2LzlVUHdqUGxocXlVbmc4NEJN?=
 =?utf-8?B?OUltNG1QQlo4MHdzU0FSeVpRQW1kZlFhZXcxNTVvU0lEQ2x5Wi94U29GaEVm?=
 =?utf-8?B?dVBHdFJES1J4aTRjdkRNQ1dKQ3luejhyY3R2NlJ2eU1nYmFsamJBYkdiZ05E?=
 =?utf-8?B?b2pTanRpbU5BZEFINXJ3dXo0M3UzT0pxcDFybW1iK0hWTzVhK1ZkUmlmNHkr?=
 =?utf-8?B?Uk1EWTNyVWRqeC9UZDFlTDFhbXpwWWpHclhqaDhGSytucmNPU2ZUb3NnWnlG?=
 =?utf-8?B?RmR5TFJycUhhQVNJUEZ1dXpQWit0RW1RbThzTjRPR2F2ZGNkWkVpMFQ1R0F6?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A47BAB8A3F98F7449B9319C9B86FF73F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTE1IGF0IDEwOjA2IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgU2VwIDEzLCAyMDIyIGF0IDA5OjE0OjMyQU0gKzEwMDAsIE5laWxCcm93biB3
cm90ZToNCj4gPiBPbiBNb24sIDEyIFNlcCAyMDIyLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
ID4gPiBPbiBTdW4sIFNlcCAxMSwgMjAyMiBhdCAwODoxMzoxMUFNICsxMDAwLCBOZWlsQnJvd24g
d3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgMDkgU2VwIDIwMjIsIEplZmYgTGF5dG9uIHdyb3RlOg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBtYWNoaW5lIGNyYXNoZXMgYW5kIGNvbWVzIGJhY2sg
dXAsIGFuZCB3ZSBnZXQgYSBxdWVyeSBmb3INCj4gPiA+ID4gPiBpX3ZlcnNpb24NCj4gPiA+ID4g
PiBhbmQgaXQgY29tZXMgYmFjayBhcyBYLiBGaW5lLCBpdCdzIGFuIG9sZCB2ZXJzaW9uLiBOb3cg
dGhlcmUNCj4gPiA+ID4gPiBpcyBhIHdyaXRlLg0KPiA+ID4gPiA+IFdoYXQgZG8gd2UgZG8gdG8g
ZW5zdXJlIHRoYXQgdGhlIG5ldyB2YWx1ZSBkb2Vzbid0IGNvbGxpZGUNCj4gPiA+ID4gPiB3aXRo
IFgrMT8gDQo+ID4gPiA+IA0KPiA+ID4gPiAoSSBtaXNzZWQgdGhpcyBiaXQgaW4gbXkgZWFybGll
ciByZXBseS4uKQ0KPiA+ID4gPiANCj4gPiA+ID4gSG93IGlzIGl0ICJGaW5lIiB0byBzZWUgYW4g
b2xkIHZlcnNpb24/DQo+ID4gPiA+IFRoZSBmaWxlIGNvdWxkIGhhdmUgY2hhbmdlZCB3aXRob3V0
IHRoZSB2ZXJzaW9uIGNoYW5naW5nLg0KPiA+ID4gPiBBbmQgSSB0aG91Z2h0IG9uZSBvZiB0aGUg
Z29hbHMgb2YgdGhlIGNyYXNoLWNvdW50IHdhcyB0byBiZQ0KPiA+ID4gPiBhYmxlIHRvDQo+ID4g
PiA+IHByb3ZpZGUgYSBtb25vdG9uaWMgY2hhbmdlIGlkLg0KPiA+ID4gDQo+ID4gPiBJIHdhcyBz
dGlsbCBtYWlubHkgdGhpbmtpbmcgYWJvdXQgaG93IHRvIHByb3ZpZGUgcmVsaWFibGUgY2xvc2Ut
DQo+ID4gPiB0by1vcGVuDQo+ID4gPiBzZW1hbnRpY3MgYmV0d2VlbiBORlMgY2xpZW50cy7CoCBJ
biB0aGUgY2FzZSB0aGUgd3JpdGVyIHdhcyBhbiBORlMNCj4gPiA+IGNsaWVudCwgaXQgd2Fzbid0
IGRvbmUgd3JpdGluZyAob3IgaXQgd291bGQgaGF2ZSBDT01NSVR0ZWQpLCBzbw0KPiA+ID4gdGhv
c2UNCj4gPiA+IHdyaXRlcyB3aWxsIGNvbWUgaW4gYW5kIGJ1bXAgdGhlIGNoYW5nZSBhdHRyaWJ1
dGUgc29vbiwgYW5kIGFzDQo+ID4gPiBsb25nIGFzDQo+ID4gPiB3ZSBhdm9pZCB0aGUgc21hbGwg
Y2hhbmNlIG9mIHJldXNpbmcgYW4gb2xkIGNoYW5nZSBhdHRyaWJ1dGUsDQo+ID4gPiB3ZSdyZSBP
SywNCj4gPiA+IGFuZCBJIHRoaW5rIGl0J2QgZXZlbiBzdGlsbCBiZSBPSyB0byBhZHZlcnRpc2UN
Cj4gPiA+IENIQU5HRV9UWVBFX0lTX01PTk9UT05JQ19JTkNSLg0KPiA+IA0KPiA+IFlvdSBzZWVt
IHRvIGJlIGFzc3VtaW5nIHRoYXQgdGhlIGNsaWVudCBkb2Vzbid0IGNyYXNoIGF0IHRoZSBzYW1l
DQo+ID4gdGltZQ0KPiA+IGFzIHRoZSBzZXJ2ZXIgKG1heWJlIHRoZXkgYXJlIGJvdGggVk1zIG9u
IGEgaG9zdCB0aGF0IGxvc3QNCj4gPiBwb3dlci4uLikNCj4gPiANCj4gPiBJZiBjbGllbnQgQSBy
ZWFkcyBhbmQgY2FjaGVzLCBjbGllbnQgQiB3cml0ZXMsIHRoZSBzZXJ2ZXIgY3Jhc2hlcw0KPiA+
IGFmdGVyDQo+ID4gd3JpdGluZyBzb21lIGRhdGEgKHRvIGFscmVhZHkgYWxsb2NhdGVkIHNwYWNl
IHNvIG5vIGlub2RlIHVwZGF0ZQ0KPiA+IG5lZWRlZCkNCj4gPiBidXQgYmVmb3JlIHdyaXRpbmcg
dGhlIG5ldyBpX3ZlcnNpb24sIHRoZW4gY2xpZW50IEIgY3Jhc2hlcy4NCj4gPiBXaGVuIHNlcnZl
ciBjb21lcyBiYWNrIHRoZSBpX3ZlcnNpb24gd2lsbCBiZSB1bmNoYW5nZWQgYnV0IHRoZSBkYXRh
DQo+ID4gaGFzDQo+ID4gY2hhbmdlZC7CoCBDbGllbnQgQSB3aWxsIGNhY2hlIG9sZCBkYXRhIGlu
ZGVmaW5pdGVseS4uLg0KPiANCj4gSSBndWVzcyBJIGFzc3VtZSB0aGF0IGlmIGFsbCB3ZSdyZSBw
cm9taXNpbmcgaXMgY2xvc2UtdG8tb3BlbiwgdGhlbiBhDQo+IGNsaWVudCBpc24ndCBhbGxvd2Vk
IHRvIHRydXN0IGl0cyBjYWNoZSBpbiB0aGF0IHNpdHVhdGlvbi7CoCBNYXliZQ0KPiB0aGF0J3MN
Cj4gYW4gb3Zlcmx5IGRyYWNvbmlhbiBpbnRlcnByZXRhdGlvbiBvZiBjbG9zZS10by1vcGVuLg0K
PiANCj4gQWxzbywgSSdtIHRyeWluZyB0byB0aGluayBhYm91dCBob3cgdG8gaW1wcm92ZSB0aGlu
Z3MgaW5jcmVtZW50YWxseS4NCj4gSW5jb3Jwb3JhdGluZyBzb21ldGhpbmcgbGlrZSBhIGNyYXNo
IGNvdW50IGludG8gdGhlIG9uLWRpc2sgaV92ZXJzaW9uDQo+IGZpeGVzIHNvbWUgY2FzZXMgd2l0
aG91dCBpbnRyb2R1Y2luZyBhbnkgbmV3IG9uZXMgb3IgcmVncmVzc2luZw0KPiBwZXJmb3JtYW5j
ZSBhZnRlciBhIGNyYXNoLg0KPiANCj4gSWYgd2Ugc3Vic2VxdWVudGx5IHdhbnRlZCB0byBjbG9z
ZSB0aG9zZSByZW1haW5pbmcgaG9sZXMsIEkgdGhpbmsNCj4gd2UnZA0KPiBuZWVkIHRoZSBjaGFu
Z2UgYXR0cmlidXRlIGluY3JlbWVudCB0byBiZSBzZWVuIGFzIGF0b21pYyB3aXRoIHJlc3BlY3QN
Cj4gdG8NCj4gaXRzIGFzc29jaWF0ZWQgY2hhbmdlLCBib3RoIHRvIGNsaWVudHMgYW5kIChzZXBh
cmF0ZWx5KSBvbiBkaXNrLsKgDQo+IChUaGF0DQo+IHdvdWxkIHN0aWxsIGFsbG93IHRoZSBjaGFu
Z2UgYXR0cmlidXRlIHRvIGdvIGJhY2t3YXJkcyBhZnRlciBhIGNyYXNoLA0KPiB0bw0KPiB0aGUg
dmFsdWUgaXQgaGVsZCBhcyBvZiB0aGUgb24tZGlzayBzdGF0ZSBvZiB0aGUgZmlsZS7CoCBJIHRo
aW5rDQo+IGNsaWVudHMNCj4gc2hvdWxkIGJlIGFibGUgdG8gZGVhbCB3aXRoIHRoYXQgY2FzZS4p
DQo+IA0KPiBCdXQsIEkgZG9uJ3Qga25vdywgbWF5YmUgYSBiaWdnZXIgaGFtbWVyIHdvdWxkIGJl
IE9LOg0KPiANCg0KSWYgeW91J3JlIG5vdCBnb2luZyB0byBtZWV0IHRoZSBtaW5pbXVtIGJhciBv
ZiBkYXRhIGludGVncml0eSwgdGhlbg0KdGhpcyB3aG9sZSBleGVyY2lzZSBpcyBqdXN0IGEgbWFz
c2l2ZSB3YXN0ZSBvZiBldmVyeW9uZSdzIHRpbWUuIFRoZQ0KYW5zd2VyIHRoZW4gZ29pbmcgZm9y
d2FyZCBpcyBqdXN0IHRvIHJlY29tbWVuZCBuZXZlciB1c2luZyBMaW51eCBhcyBhbg0KTkZTIHNl
cnZlci4gTWFrZXMgbXkgbGlmZSBtdWNoIGVhc2llciwgYmVjYXVzZSBJIG5vIGxvbmdlciBoYXZl
IHRvDQpkZWJ1ZyBhbnkgb2YgdGhlIGlzc3Vlcy4NCg0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
