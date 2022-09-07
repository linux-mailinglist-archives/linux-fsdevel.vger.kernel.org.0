Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D915B07E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiIGPE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIGPEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:04:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2122.outbound.protection.outlook.com [40.107.96.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A004722F;
        Wed,  7 Sep 2022 08:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG9t1iFLJUpTNMTKEUKY4sSOZXBffVvBx4YOv2JU74s1s7oZ1tTEdMk3nnetdmcpPbTw6sEo61oT8WFJPjYH3016k6rGdNkNwE0V8VXZWAvFb93NNf3M0xSiPUKP3HAIaJIKp9LKE3e8cNiRTWI1h5/mMyy4BjrZKRB7lRiHI2eBvrO5lTAEHJqNWKjxI4K5jmYFUy2g9M8drfSfG44qGQgGWYXK49mPt+V+MprNFtOsP3rBVGRbNWXQP7mMsYNS0hu8946SiEwaOxY7lVqizQJKeyHrQsvZUxpVYn9AUNkPv23ZScbg5TIOR0VIGGZfVrXFHhTb1vI/TslrxS558w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIsK5YXWf0Axszuu2If7pi6KvWFwO7ibH/BSSbgFjfs=;
 b=DyvCQJkzVJYQ6OirF4W0HzHiF0ZJVv33yxtrtw8UJY8c58e3G1F8Xx8Zl8WQrHY4AEqxsj+Vtm05xkdQRYbZ1BUQckQUkFDxfY6uTUEpCm7o0k8yUoCbRjiBHvj68S0dX1jK+0wcfhHPjvd20jf/lIx+ZL7FH+El8da6zUJy6P6nrV0laIvCcRrDeRv+nyo6cbP/2XxHS2uIgsLxjr+X4OkvT378f24pXIUJb4w60fqRy/sKlByDrP416PHR4JgPYGvvm7+xHo+hSNyquSF/LElgV7ubCexMabPJ15eOL9XUUhC+AZHC6qGtJXBfL4AumUcogyYQnRB4SkaNX8B3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIsK5YXWf0Axszuu2If7pi6KvWFwO7ibH/BSSbgFjfs=;
 b=f/zWclqlsmOzkL2u05TVxbEtTzHuRTLYJHsJk36WQ6fqOhQm2qr41zl4m7AIrwyXziPQWRUPrB76vpsaH7YTamtMWexK6k2bvnhgV9iJ+keipKOFwN/HFa47rGggQLQrKVEmJyUdUhwmKe8eB+uP0DC/Cq+TO3Tc5bIgX5FXU78=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5469.namprd13.prod.outlook.com (2603:10b6:510:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 15:04:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 15:04:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAL3gCAAALPgIAAEIkA
Date:   Wed, 7 Sep 2022 15:04:18 +0000
Message-ID: <9ddbc23661ab6527d73860a873391a3536451ee6.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
         <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
In-Reply-To: <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5469:EE_
x-ms-office365-filtering-correlation-id: 03011ae4-4a5d-47fe-efa4-08da90e23d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpVPOE8Qz/eL9ZDSuEeYcXQFjvdFpoW7MIqISYTsLdVYaYS39YY6uuFpz9kL/EM1QsbTxaDpOsVbvKsifaxhTdQCRHBb0eJCozbBU6jOQFUdsBOILGwDM5yxI87NvIDTrcxqonlelvohF73iNqycJQXN1+2JKNtpVv2vxVTGqTpC4TCE8GoUiAvQh8L4Ry2cnA4Hi1LrRV5XmN0gdEhcHsTyG2l4zvOC2wczCj2zV4KNEyAZx26IUABHLhx/WsuSJHj+Jvy3FbEYzFwAdFyRPlPomCWiEq2PbdtIeG5+VJ2JKwYMGOiGRoOay/lpeKVIZiRzBrp66jc/RnIX2p1+pRq/efvxBPgqFjqdv3oYMOICzSIy4EcF3hZN8ObJzUJoYysS80yQlp0vau+Kv3JtSCBh088IYVR9byHV9ni4a6Gi9/pDM89FN2Q8veFglOwC8gE8ZQgw6mEMm4K/POGV7h0kqpStY4e9GZLz283fu6neBEdhfQE4oxdrdlz819SwRNI7xvhPer15Cjh4hSrsQh+YA/+EFLaI4pISHY31ntm/SK6MpQEwJOA3yXxr3wUNf6nbloG0c/AMTMUPJ5gMxz3Dh2dyJ7GLFpiJRa72Ls0rUD6JY5U+2/8aJ/XWkglNcal69Qv6a3KrC/KDcSh9/FFd0ipmsOfyMJ++ZJ4iMsgTT9FRHmQBmKgv7PiL3fOmvNoWPVZ1afc8+xruvhHBestRfoy4klEzhtxEFCplx7lVr4sY34MPKZ8eRd1tMFm1LBKWvY6CT6An+Avka8GK0+7Mawxdee4wJFtFsTKfK2SwpaaGFGIp7BCXopiB4K0Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39840400004)(136003)(366004)(346002)(396003)(71200400001)(186003)(478600001)(6506007)(36756003)(2616005)(5660300002)(26005)(7416002)(86362001)(8936002)(41300700001)(6512007)(6486002)(38070700005)(8676002)(66946007)(110136005)(54906003)(83380400001)(122000001)(316002)(4326008)(66446008)(76116006)(2906002)(64756008)(38100700002)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZCtVdGlSUy8yOWxiRnRDdGlWYUpKMXBFRFhWRzdNbG1FQm9HbTd5RVJFVUxB?=
 =?utf-8?B?YkpIb25nZDVvWlVqTFhjaExaR3NnRlBwaHFKUzFxTGJ5b1o3ZTRIM1JEdzl4?=
 =?utf-8?B?UTVYRElrTUZ1VWpxYW5NaXk5ZU5hRzJWVVBhZGdvc2NVWTM0cjRqSmFydzlG?=
 =?utf-8?B?TXFodnFWS2poNTkzNzdiS29mVmYwVGV2THFOUVRUeEcrRW5oSzR2cDgvSGla?=
 =?utf-8?B?cStMTHVFVUczM0ZrejVmbnhCTWhrVng2ODVRL0FpNnVyVzM3c1Y0L0pLeU5B?=
 =?utf-8?B?Wm93N2hMdVBGQzNXYkx2VXNPWjVLRU1mNytXYjVIU29NNnhONzdpd0Q5RXh4?=
 =?utf-8?B?NGhMWnZyejNKUGFtcnVoWFc2czBQRlhvQjdzVlpmbkxpdjVWbVJtUXVoZlpW?=
 =?utf-8?B?VFUydW9FUmR0ZGJJNVRXR2YwakZBcmp5MVRYbFVXTllTSExRRVp6MHNUQnYx?=
 =?utf-8?B?R2N6d3JrL2Z5NVBPUG9DMUl1S1hKRzdaT3c2STY5eG1kbk9mU3o1NEFRdnVT?=
 =?utf-8?B?UFRhc2h5YUMzUktqa1NUVmphN2xDWHJnOG92S0lEak0wM3pKSWNhMU5UWnNt?=
 =?utf-8?B?VWk3QVFjbmp2N2JXblJxVi93WSsrTEErbnZFU1BhNVFodU1ORUVmZVVVeXA3?=
 =?utf-8?B?VzdvYVo2eXJkaGwvMm5YWWM2SlNVUnp4RmZxdnEyQmx6dmtiQmNmb3VKdTk1?=
 =?utf-8?B?SDVDZ0p4YVU5b0c0TmkrZ3B3ekd4cFdBelNXZG4xYUtVTjhnb3hFcWRBL3dZ?=
 =?utf-8?B?c3FkejVVbXNyLzd2Vk83RGtWUklLYzBzT05uZjJyUVpEMUd6Umw0dnE5T2FU?=
 =?utf-8?B?UjBrNldFMjBjL1o5MkdON0VKQnYyRXF2eVZrenFMUVArT05wcDkwWnVMek1w?=
 =?utf-8?B?WlZoSU4wb1BGSFEya3UvRVRrQ01QVEZ1ZGZIT2lKbHNsWCtmZ01sblR5ZkN5?=
 =?utf-8?B?ZXdma3orWmU5dUp4eFh1Y2hseDh0NzEzZUlHc3cwckxWa1laa2lwS0N1Y040?=
 =?utf-8?B?Q1pCRFdQUkNMU1pSbVg4dURPaCtGcXpuYldUakh6bkp0ZXVVd3hzc05PYkha?=
 =?utf-8?B?QXFJenlOMU9vczI5b2FJNDMrMklpUXpZSFlHWUZLeWdQaXhpSVR5ZE8zMEJG?=
 =?utf-8?B?c1cyWmdYNzBBR0pHUHozQjVWYlJySlI2OWVLVWJYdDNzVDE1YUhNSnNpZDVj?=
 =?utf-8?B?MEp5Z1hTL2RpZWRBRXU0ZW1QOHdXQy9PK0IrQXdOK2tuUkw1NzBlWUlQSDZl?=
 =?utf-8?B?dXRJU1ZvNDlZbWZVaFVnaXpBSEViVldiL21ZbDdndXArUGZEdzlpUHprM3hj?=
 =?utf-8?B?cXV4UXN0OFQyVnFoVWl5eWw3S3AyWWZ4Tjc4MU15dTBGUWkwOEZhdjRZYlI5?=
 =?utf-8?B?b0ZjVWoxUGhwNEZWL1h1R1FBalg4aDNoV3FxN0NNcHN0YVdNeVdLZHBBVk5y?=
 =?utf-8?B?bEFTRVJyS05oYmMrNmNvTUtHb3lFeE80YzhWTHRwRFhhVFdNU2o1aVc4YzRX?=
 =?utf-8?B?RW8vWE5yVy85ZTU0ZnJYanVybWZLb0kzbyt3RlFHc084UFdOZzlvUUU1TmlN?=
 =?utf-8?B?QU1UNTYxWFVacVgvSGxpMkcyREFsQiswZm5GWmJ0eGpQNEsvOXJmY0RVVFlE?=
 =?utf-8?B?ei9IRU42blF3dFpMcVNuVytmYlNLMEc1NkkvZ1FDb2cyZnNXTlNVOXVJYm84?=
 =?utf-8?B?a0JzSC9oMGJGQ1AwRWxVZjVvd1UvbzFQVzJXaHNwOGV4Y3BXNEt3bmttV1oz?=
 =?utf-8?B?OE1aYXFIRTVKSStQMm5RUjBTT2VCZTNvY2lCMHhSeUhqcGJzdGVVNmJkdkdX?=
 =?utf-8?B?QWFyTWdWSEFabklQRThSMGFSQ2R5Z3RMckhYTnNKQStpR3JUKzJlNW5uTTJK?=
 =?utf-8?B?LzVOQkJ6YkxwRkw4NWNOMk5kSE8zZTFwdEM1b3RwakF5VzFzbUJQdmdhOGFm?=
 =?utf-8?B?WHJ4U2FyaklTMUIrc0RKakZ1cDBXektSQzM3ZWZjY2FrbndETFl2ZjZPUGdM?=
 =?utf-8?B?Uk1iOFpCTGlVM04wUDRmZGNVeUk3ai84RlNvZlRxMFZOQ3JBRDh2L3dKVDJ1?=
 =?utf-8?B?bXB4TFJiNnRzdkpyKzhRQmVFNWFUTUltdmpNL0ppbGZSNHE4Q29PZ0hiOUdy?=
 =?utf-8?B?MkUyNTJXaW5aRkUwWG9OUWhuc1hGUlBhRllraUdXK2c1WkJoYjhCempNblpn?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C11DA9E2C5EE6D4EAB78D8E00151E50C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTA3IGF0IDEwOjA1IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDIyLTA5LTA3IGF0IDEzOjU1ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDIyLTA5LTA3IGF0IDA5OjEyIC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIFdlZCwgMjAyMi0wOS0wNyBhdCAwODo1MiAtMDQwMCwgSi4gQnJ1Y2UgRmll
bGRzIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIFNlcCAwNywgMjAyMiBhdCAwODo0NzoyMEFNIC0w
NDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIDIwMjItMDktMDcgYXQg
MjE6MzcgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFdlZCwgMDcgU2Vw
IDIwMjIsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiArVGhlIGNoYW5nZSB0byBc
ZklzdGF0eC5zdHhfaW5vX3ZlcnNpb25cZlAgaXMgbm90IGF0b21pYw0KPiA+ID4gPiA+ID4gPiB3
aXRoDQo+ID4gPiA+ID4gPiA+IHJlc3BlY3QgdG8gdGhlDQo+ID4gPiA+ID4gPiA+ICtvdGhlciBj
aGFuZ2VzIGluIHRoZSBpbm9kZS4gT24gYSB3cml0ZSwgZm9yIGluc3RhbmNlLA0KPiA+ID4gPiA+
ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gaV92ZXJzaW9uIGl0IHVzdWFsbHkNCj4gPiA+ID4gPiA+
ID4gK2luY3JlbWVudGVkIGJlZm9yZSB0aGUgZGF0YSBpcyBjb3BpZWQgaW50byB0aGUNCj4gPiA+
ID4gPiA+ID4gcGFnZWNhY2hlLg0KPiA+ID4gPiA+ID4gPiBUaGVyZWZvcmUgaXQgaXMNCj4gPiA+
ID4gPiA+ID4gK3Bvc3NpYmxlIHRvIHNlZSBhIG5ldyBpX3ZlcnNpb24gdmFsdWUgd2hpbGUgYSBy
ZWFkIHN0aWxsDQo+ID4gPiA+ID4gPiA+IHNob3dzIHRoZSBvbGQgZGF0YS4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gRG9lc24ndCB0aGF0IG1ha2UgdGhlIHZhbHVlIHVzZWxlc3M/DQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBObywgSSBkb24ndCB0aGluayBzby4gSXQn
cyBvbmx5IHJlYWxseSB1c2VmdWwgZm9yIGNvbXBhcmluZw0KPiA+ID4gPiA+IHRvIGFuDQo+ID4g
PiA+ID4gb2xkZXINCj4gPiA+ID4gPiBzYW1wbGUgYW55d2F5LiBJZiB5b3UgZG8gInN0YXR4OyBy
ZWFkOyBzdGF0eCIgYW5kIHRoZSB2YWx1ZQ0KPiA+ID4gPiA+IGhhc24ndA0KPiA+ID4gPiA+IGNo
YW5nZWQsIHRoZW4geW91IGtub3cgdGhhdCB0aGluZ3MgYXJlIHN0YWJsZS4gDQo+ID4gPiA+IA0K
PiA+ID4gPiBJIGRvbid0IHNlZSBob3cgdGhhdCBoZWxwcy7CoCBJdCdzIHN0aWxsIHBvc3NpYmxl
IHRvIGdldDoNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmVhZGVywqDCoMKgwqDCoMKgwqDCoMKgwqB3cml0ZXINCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAtLS0tLS3CoMKgwqDCoMKgwqDCoMKgwqDCoC0tLS0tLQ0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaV92ZXJzaW9uKysNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzdGF0eA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
YWQNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0eA0KPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdXBkYXRlIHBhZ2UgY2FjaGUNCj4gPiA+ID4gDQo+ID4gPiA+IHJpZ2h0Pw0KPiA+
ID4gPiANCj4gPiA+IA0KPiA+ID4gWWVhaCwgSSBzdXBwb3NlIHNvIC0tIHRoZSBzdGF0eCB3b3Vs
ZG4ndCBuZWNlc3NpdGF0ZSBhbnkgbG9ja2luZy4NCj4gPiA+IEluDQo+ID4gPiB0aGF0IGNhc2Us
IG1heWJlIHRoaXMgaXMgdXNlbGVzcyB0aGVuIG90aGVyIHRoYW4gZm9yIHRlc3RpbmcNCj4gPiA+
IHB1cnBvc2VzDQo+ID4gPiBhbmQgdXNlcmxhbmQgTkZTIHNlcnZlcnMuDQo+ID4gPiANCj4gPiA+
IFdvdWxkIGl0IGJlIGJldHRlciB0byBub3QgY29uc3VtZSBhIHN0YXR4IGZpZWxkIHdpdGggdGhp
cyBpZiBzbz8NCj4gPiA+IFdoYXQNCj4gPiA+IGNvdWxkIHdlIHVzZSBhcyBhbiBhbHRlcm5hdGUg
aW50ZXJmYWNlPyBpb2N0bD8gU29tZSBzb3J0IG9mDQo+ID4gPiBnbG9iYWwNCj4gPiA+IHZpcnR1
YWwgeGF0dHI/IEl0IGRvZXMgbmVlZCB0byBiZSBzb21ldGhpbmcgcGVyLWlub2RlLg0KPiA+IA0K
PiA+IEkgZG9uJ3Qgc2VlIGhvdyBhIG5vbi1hdG9taWMgY2hhbmdlIGF0dHJpYnV0ZSBpcyByZW1v
dGVseSB1c2VmdWwNCj4gPiBldmVuDQo+ID4gZm9yIE5GUy4NCj4gPiANCj4gPiBUaGUgbWFpbiBw
cm9ibGVtIGlzIG5vdCBzbyBtdWNoIHRoZSBhYm92ZSAoYWx0aG91Z2ggTkZTIGNsaWVudHMgYXJl
DQo+ID4gdnVsbmVyYWJsZSB0byB0aGF0IHRvbykgYnV0IHRoZSBiZWhhdmlvdXIgdy5yLnQuIGRp
cmVjdG9yeSBjaGFuZ2VzLg0KPiA+IA0KPiA+IElmIHRoZSBzZXJ2ZXIgY2FuJ3QgZ3VhcmFudGVl
IHRoYXQgZmlsZS9kaXJlY3RvcnkvLi4uIGNyZWF0aW9uIGFuZA0KPiA+IHVubGluayBhcmUgYXRv
bWljYWxseSByZWNvcmRlZCB3aXRoIGNoYW5nZSBhdHRyaWJ1dGUgdXBkYXRlcywgdGhlbg0KPiA+
IHRoZQ0KPiA+IGNsaWVudCBoYXMgdG8gYWx3YXlzIGFzc3VtZSB0aGF0IHRoZSBzZXJ2ZXIgaXMg
bHlpbmcsIGFuZCB0aGF0IGl0DQo+ID4gaGFzDQo+ID4gdG8gcmV2YWxpZGF0ZSBhbGwgaXRzIGNh
Y2hlcyBhbnl3YXkuIEN1ZSBlbmRsZXNzDQo+ID4gcmVhZGRpci9sb29rdXAvZ2V0YXR0cg0KPiA+
IHJlcXVlc3RzIGFmdGVyIGVhY2ggYW5kIGV2ZXJ5IGRpcmVjdG9yeSBtb2RpZmljYXRpb24gaW4g
b3JkZXIgdG8NCj4gPiBjaGVjaw0KPiA+IHRoYXQgc29tZSBvdGhlciBjbGllbnQgZGlkbid0IGFs
c28gc25lYWsgaW4gYSBjaGFuZ2Ugb2YgdGhlaXIgb3duLg0KPiA+IA0KPiANCj4gV2UgZ2VuZXJh
bGx5IGhvbGQgdGhlIHBhcmVudCBkaXIncyBpbm9kZS0+aV9yd3NlbSBleGNsdXNpdmVseSBvdmVy
DQo+IG1vc3QNCj4gaW1wb3J0YW50IGRpcmVjdG9yeSBjaGFuZ2VzLCBhbmQgdGhlIHRpbWVzL2lf
dmVyc2lvbiBhcmUgYWxzbyB1cGRhdGVkDQo+IHdoaWxlIGhvbGRpbmcgaXQuIFdoYXQgd2UgZG9u
J3QgZG8gaXMgc2VyaWFsaXplIHJlYWRzIG9mIHRoaXMgdmFsdWUNCj4gdnMuDQo+IHRoZSBpX3J3
c2VtLCBzbyB5b3UgY291bGQgc2VlIG5ldyBkaXJlY3RvcnkgY29udGVudHMgYWxvbmdzaWRlIGFu
IG9sZA0KPiBpX3ZlcnNpb24uIE1heWJlIHdlIHNob3VsZCBiZSB0YWtpbmcgaXQgZm9yIHJlYWQg
d2hlbiB3ZSBxdWVyeSBpdCBvbg0KPiBhDQo+IGRpcmVjdG9yeT8NCg0KU2VyaWFsaXNpbmcgcmVh
ZHMgaXMgbm90IHRoZSBwcm9ibGVtLiBUaGUgcHJvYmxlbSBpcyBlbnN1cmluZyB0aGF0DQprbmZz
ZCBpcyBhYmxlIHRvIHByb3ZpZGUgYW4gYXRvbWljIGNoYW5nZV9pbmZvNCBzdHJ1Y3R1cmUgd2hl
biB0aGUNCmNsaWVudCBtb2RpZmllcyB0aGUgZGlyZWN0b3J5Lg0KaS5lLiB0aGUgcmVxdWlyZW1l
bnQgaXMgdGhhdCBpZiB0aGUgZGlyZWN0b3J5IGNoYW5nZWQsIHRoZW4gdGhhdA0KbW9kaWZpY2F0
aW9uIGlzIGF0b21pY2FsbHkgYWNjb21wYW5pZWQgYnkgYW4gdXBkYXRlIG9mIHRoZSBjaGFuZ2UN
CmF0dHJpYnV0ZSB0aGF0IGNhbiBiZSByZXRyaWV2ZWQgYnkga25mc2QgYW5kIHBsYWNlZCBpbiB0
aGUgcmVwbHkgdG8gdGhlDQpjbGllbnQuDQoNCj4gQWNoaWV2aW5nIGF0b21pY2l0eSB3aXRoIGZp
bGUgd3JpdGVzIHRob3VnaCBpcyBhbm90aGVyIG1hdHRlcg0KPiBlbnRpcmVseS4NCj4gSSdtIG5v
dCBzdXJlIHRoYXQncyBldmVuIGRvYWJsZSBvciBob3cgdG8gYXBwcm9hY2ggaXQgaWYgc28uDQo+
IFN1Z2dlc3Rpb25zPw0KDQpUaGUgcHJvYmxlbSBvdXRsaW5lZCBieSBCcnVjZSBhYm92ZSBpc24n
dCBhIGJpZyBkZWFsLiBKdXN0IGNoZWNrIHRoZQ0KSV9WRVJTSU9OX1FVRVJJRUQgZmxhZyBhZnRl
ciB0aGUgJ3VwZGF0ZV9wYWdlX2NhY2hlJyBiaXQsIGFuZCBidW1wIHRoZQ0KaV92ZXJzaW9uIGlm
IHRoYXQncyB0aGUgY2FzZS4gVGhlIHJlYWwgcHJvYmxlbSBpcyB3aGF0IGhhcHBlbnMgaWYgeW91
DQp0aGVuIGNyYXNoIGR1cmluZyB3cml0ZWJhY2suLi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
