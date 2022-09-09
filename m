Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1E5B2B53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 03:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIIBF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 21:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIIBFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:05:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2121.outbound.protection.outlook.com [40.107.93.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B7DA3D2C;
        Thu,  8 Sep 2022 18:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+odHuhedWVOFLeMUwTCcxzaFSrK7Ue5FRjslDmW0RkH9Qw/B52wup4W73eMpIYWcuwCq/MUoCG/C6pnOOrUKMc260waCW1tp8hT6wYpIyKbGWBXoYNadJ2tLeLP4/If1APhdPxEVl9r3hu6hJa4YW1+Pw3AVpJmD3hcHIT7c4aWXM8eWhRVjGD/zkIR/HQX7icqcU7H9gDV7XHdyeUqnQbANmvOpDRdpLR9oAnJPh9BMjqLFpFAxXjKcpk/8c0ADRPYLMw4wvTA+kNXl84JzSQGELuIHcWIOyOwTE2jh+OulFF06nH/NPc2wlYAWi6zJQgyNP9IZDyyaufZlNX/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSwIunfuCUG4mAJDMKFtgSPF49VuYKQ3ojRYLay+kRQ=;
 b=h9gbz9TuJ1YA1eXXaIko80JV9Ivx8E2Xlh8QIUH2M6Vp5bCDBRjzilrgiD3AgXyY9l8fgOhG0aJlKybRHHWn5qcbMLL04VGa8FNG9cWEkDy0c0/T+EwpSIdidS6DVUdKQh7rPw7XrQBz7UaBZsno97TCgcbNvTQ8ly9ucxX8Vs1GNk/KWs2YFzDEtffXJ09tlyncAlJB+BwAFvdqSCpwBS2DE4cwx6V3GJzAbURfY1XeOkJWVDYrGJZi+oMenzjPiSV2OEi407lRRd+kS94xIjC3D/4i8qOoNrXao7wnjLTIHK+bx6yDajCqZ2KAgDkiG3qRQIlIdnwoWjG9kbRgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSwIunfuCUG4mAJDMKFtgSPF49VuYKQ3ojRYLay+kRQ=;
 b=dLegjzZb0ut6+kA3+uB8adD9qMVv06BcXVgFCo/ZIsgFB+mPHWG1cdaDJujc7EjeSmDtMCe8AHmqe7pKW6MK7JW9ftuqX1mYmGjOSqms2Sm0cuPTaYtLpSacQMScY9IyCok0+zCgf+nja5XymbWPvzUtbDJJgLdIynCQxmg93EM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5083.namprd13.prod.outlook.com (2603:10b6:610:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 01:05:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Fri, 9 Sep 2022
 01:05:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
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
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAeIiAgAARsICAAA6CgIAAA+yA
Date:   Fri, 9 Sep 2022 01:05:15 +0000
Message-ID: <fc4c03e3de5f2896322645c2a520297187bb4111.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org> ,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name> ,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>    ,
 <20220907125211.GB17729@fieldses.org>  ,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>    ,
 <20220907135153.qvgibskeuz427abw@quack3>       ,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name> ,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>   ,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>    ,
 <166267775728.30452.17640919701924887771@noble.neil.brown.name>        ,
 <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>
         <166268467103.30452.1687952324107257676@noble.neil.brown.name>
In-Reply-To: <166268467103.30452.1687952324107257676@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB5083:EE_
x-ms-office365-filtering-correlation-id: d176182d-fecd-40e6-1a64-08da91ff5adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGeeSGgUbHBb7pGJQ2+O7CPFt8Qg73f9BgVObaRzl499mUoMi5mVWGYyXjGYjZIlgfgsAk3w+MUi7tQcQaC0Y3riZLn9bW3BQU+y12gYBU50iyZBEkOUNZmeoLh75id73BSS/TNk4JPwNmrt/h6uEM53USnaDXxzXgjjs0pCsPiuW/j4YdpxdfsKbR1KGiletsmIYb0W/XGq57L+f5c87tFLgVryVp2L+Zu1t0olbYGGyW8cTHNT3HQdjNtjL0wKQTVGE+HJFSxcAyiyNlCtn8tC4sBoR7M1d4DVjjiGJHvVSP0l57wBmn9IfrebL/QF9J7n+vIZU06qeFa7i45Aw5rtsLU0D5eVa5eBnYq7Zmq5d2dGb6j+tBUDZf5GJyxyWkhHhTY4b3BxszxJ4EPEw6p9D5X1hkNvFuEeHSPtSTz0Rrn0BMz3vXqDttt09HOwZnX/j9sIbPA7MoAU8Uy13HlP2CmlpZ4dmi44b6sxV6KusirZzS9FAYwgLSE5YqOJ9byw62ZaAa0mDXucnW11fNpVBqYQKwfCjkPFmALPSJooWhRXEBrHsrvq1T3UTgoHCU0bP2qOEc9SyN+e3ldSzOoZ2KnzNrBX+1+T1dcNsfRMZZTc1iQ/NIl7w9ks7M5N5NB9RCOKbIl9i/dW4FIjZ+775TN0Ki83sxvjVLFIvH7eqLcSoHNRILIGGKFih8W2stEPeQFMTpl1XnuXmore2LMsXRzHJ8xjdTzOtZkcaOSHAD0htxRulUHSFRN9i7BeX6406G9qhUGN9c/fCWKo0rvwWKsebLHdIfpKDwPDURYDCtROvf0G2nYXwKVUlRp4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(39850400004)(396003)(38070700005)(5660300002)(7416002)(2616005)(186003)(8936002)(8676002)(76116006)(41300700001)(478600001)(6486002)(83380400001)(66476007)(66946007)(66446008)(4326008)(66556008)(86362001)(64756008)(38100700002)(122000001)(6506007)(2906002)(26005)(6512007)(54906003)(6916009)(36756003)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckdXSkxSQjRFekdHV1FuV0JWaDgxQkNBcms4TFRlSlZNY1BQTXFOSjFua0Zi?=
 =?utf-8?B?VEdySzVLakROc3VOTmR1RkFsNmZSRXd2bEVPTFF6MkF3T2tjNlZza2txM2hZ?=
 =?utf-8?B?dWZNMWhPUUdCQk5Qc1B2S2tFUE9xZzlqYWF0bDlkTmNRR3hvaVVQdjAycU5y?=
 =?utf-8?B?ak0wVHgrV3NNb3BxalpHalFZMlppeWNpTTliR0JuSFIrREoxanFvK0ZDMDdH?=
 =?utf-8?B?K2pZMHltTEpaM2R6Zmp1YnBubGd3cHBpM05FM3Z4SnR2NWlVbmZWSnVNTTRH?=
 =?utf-8?B?MWRTbGZGNVFxajdoQXMveHlzZW9Ca1Rkam1Kd255YjFnNlpRLzRveGVrRFFV?=
 =?utf-8?B?MkVuYjZsUXNTQlE1aEJieEFhekhNS1VUVEhGek1YbFR1eVpQcGh3QzRWeER5?=
 =?utf-8?B?c2U5VCtjMDFKYXFKOGJuWk9mRWEwRDhiSWVmOEpIT0hMcUk1cE5FSHRuRmV4?=
 =?utf-8?B?c1NDOHJ5emFBbHpuUjdYMTZyQUNrU0p0MFJxMkIrcEFjbXVuZHlpZ3dnZ3Y2?=
 =?utf-8?B?RXkzdzZ5am5TaGRuVFhaSE1paG5BM0svbHZrMC92UEYwQ2VMRnVzM2lraURo?=
 =?utf-8?B?Ukp3c2hBUTYyL3h1MmJoay9WS0ZvZnBMRnlkRi9HekVPcC9NK2VsUm5JTHFr?=
 =?utf-8?B?cUpxb1VCTFE5Z2lPdVE5eTk1Um9PeEhhNGpVV3lEajBBWjN5QTZOV3lhSjBr?=
 =?utf-8?B?NENEVE8vbHE3d0dwbTNuMnMwdWV1ZE1xMHNuY1Y0SDV3ZE5xKy9lYWVLV08x?=
 =?utf-8?B?bDg4UUl5RkVYWHdpT0lRV2ZTMVdxc3A5cERhVVJ4ekkzUEpxTThIeUVhNSts?=
 =?utf-8?B?YlpxN1RKWTBwc3NFamw5OWlYbXZIcDJNQWhJS1lTVlRvb2FqZ1NlakQ0Qjdk?=
 =?utf-8?B?UVBQdVVnWFpmNFJzZG9iTDdNNm5LeVZydzVxWWxEWlcwbnUyZm5KU3VqYkRz?=
 =?utf-8?B?WmlWKzFMcHdLb0M0M2t6SG5yOGVKL0ZlUk5DeVJTcG8vUEx6UHNTcWYwb0dR?=
 =?utf-8?B?SFJSamozYm1wY2VDejNFeDdQdFR6bEVySUl3NEtiL3QzVDBYRDIxSWo4RUJl?=
 =?utf-8?B?SWFMOEJzV2xsQWlKNlZ6Q2RXR24wbkoxRXM4cEMrcUZrVnlWbUVEU0VsL3JS?=
 =?utf-8?B?RDdDa2VzUFk0Nksrc1luYXg0SFBIV1oxSHViTzArN3J2RjNFZTY0V3lsQmJk?=
 =?utf-8?B?VTZmRDRFQ1d2bE9mZW5yb2dXK0ZXTkkyTktHVmc3QWU3QTNoWVVqZ3V4VTBh?=
 =?utf-8?B?S1A0bGlkWmZWWDZjMllha1liVExVYnZ6NTNvTkh2aWhnL3pOakp1MitoaW9n?=
 =?utf-8?B?RzZUbXJqOG0zTm50WkFXaWNPZlRoOHdldHNTV2tINVMzaWI0YzFwRnJNc0NF?=
 =?utf-8?B?WnUrZng5ejNKL2pmc2xuSWJaaWZtdjVlYSs3NmZsSWRCRkdDdDZtampPbVEz?=
 =?utf-8?B?VjhEbU96NkE5VHNwZFU1RTF6M3paY1k2VHhraFQ4YUtNNGVCS3JZSjloMUNE?=
 =?utf-8?B?QlpvUTdxdGNhcVhEY3QydGxWZXNqcFRlNituWU5PbkxGaG9aZzNkTkgzSUp5?=
 =?utf-8?B?dXc3cnhpejZNZXFYVzFYT0tjSXExd2N0L0s3cFJmRU9yclVnMGtOb1A0OVRn?=
 =?utf-8?B?eCt2dnQ3aWIxaXg4QjNWcEY3aDJKOVA3SWkzRjA2aStWcGhCZDFteXR0eTZr?=
 =?utf-8?B?d3kyQ3hIRUs5ZURnZGIyQ09SRWVvTmxicnh5Um1rNm5Jc3d1b1JWRUY3Ri9L?=
 =?utf-8?B?Vmx6aldrb0MxZ0IzeUExT1ZMbWFSdExrK05SVHBDWWxvQ1NCMXpqbm05QXRp?=
 =?utf-8?B?NFVJUUVERFVFZERFdGpqMmJTOER0U1ZKM3h0eHRyZXo0V1NhcnZyWjR3RXB0?=
 =?utf-8?B?b21EU2xaMHNob2tKVXJoOHUwaStibVZaSWppNmptcmNJZ0FNUlNJVWxSNU5p?=
 =?utf-8?B?a3I3M2QrMkEwSjZUTVEzd2dEUzdlUnYvTGZBTldUbWlRa0FzYXp2MEZVWUZT?=
 =?utf-8?B?U1NMU245MVNVUUdoNjQvMWZ4T2wzK2pzMHE1STdEUFFzNVhnYi9GdCtRTlY4?=
 =?utf-8?B?cVNvTit5TkxIQm5CK29WRXJSNEhnd1dJTUlOUzNNby9lcXlVUnRkNTVPZU91?=
 =?utf-8?B?MEJ2eHhsMzZFNkFLRUcraXFhSmxnOVpCNlFoeWJyelBoL2phL2hKQlFoZ2NT?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF7D7694F1B385429128FA837B09884B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDEwOjUxICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IEZyaSwgMDkgU2VwIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBGcmksIDIw
MjItMDktMDkgYXQgMDg6NTUgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIEZyaSwg
MDkgU2VwIDIwMjIsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIDIwMjItMDkt
MDggYXQgMTE6MjEgLTA0MDAsIFRoZW9kb3JlIFRzJ28gd3JvdGU6DQo+ID4gPiA+ID4gT24gVGh1
LCBTZXAgMDgsIDIwMjIgYXQgMTA6MzM6MjZBTSArMDIwMCwgSmFuIEthcmEgd3JvdGU6DQo+ID4g
PiA+ID4gPiBJdCBib2lscyBkb3duIHRvIHRoZSBmYWN0IHRoYXQgd2UgZG9uJ3Qgd2FudCB0byBj
YWxsDQo+ID4gPiA+ID4gPiBtYXJrX2lub2RlX2RpcnR5KCkNCj4gPiA+ID4gPiA+IGZyb20gSU9D
Ql9OT1dBSVQgcGF0aCBiZWNhdXNlIGZvciBsb3RzIG9mIGZpbGVzeXN0ZW1zIHRoYXQNCj4gPiA+
ID4gPiA+IG1lYW5zIGpvdXJuYWwNCj4gPiA+ID4gPiA+IG9wZXJhdGlvbiBhbmQgdGhlcmUgYXJl
IGhpZ2ggY2hhbmNlcyB0aGF0IG1heSBibG9jay4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
UHJlc3VtYWJseSB3ZSBjb3VsZCB0cmVhdCBpbm9kZSBkaXJ0eWluZyBhZnRlciBpX3ZlcnNpb24N
Cj4gPiA+ID4gPiA+IGNoYW5nZQ0KPiA+ID4gPiA+ID4gc2ltaWxhcmx5DQo+ID4gPiA+ID4gPiB0
byBob3cgd2UgaGFuZGxlIHRpbWVzdGFtcCB1cGRhdGVzIHdpdGggbGF6eXRpbWUgbW91bnQNCj4g
PiA+ID4gPiA+IG9wdGlvbg0KPiA+ID4gPiA+ID4gKGkuZS4sIG5vdA0KPiA+ID4gPiA+ID4gZGly
dHkgdGhlIGlub2RlIGltbWVkaWF0ZWx5IGJ1dCBvbmx5IHdpdGggYSBkZWxheSkgYnV0IHRoZW4N
Cj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gdGltZSB3aW5kb3cNCj4gPiA+ID4gPiA+IGZv
ciBpX3ZlcnNpb24gaW5jb25zaXN0ZW5jaWVzIGR1ZSB0byBhIGNyYXNoIHdvdWxkIGJlIG11Y2gN
Cj4gPiA+ID4gPiA+IGxhcmdlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBQZXJoYXBzIHRoaXMg
aXMgYSByYWRpY2FsIHN1Z2dlc3Rpb24sIGJ1dCB0aGVyZSBzZWVtcyB0byBiZSBhDQo+ID4gPiA+
ID4gbG90DQo+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiB0aGUgcHJvYmxlbXMgd2hpY2ggYXJlIGR1
ZSB0byB0aGUgY29uY2VybiAid2hhdCBpZiB0aGUgZmlsZQ0KPiA+ID4gPiA+IHN5c3RlbQ0KPiA+
ID4gPiA+IGNyYXNoZXMiIChhbmQgc28gd2UgbmVlZCB0byB3b3JyeSBhYm91dCBtYWtpbmcgc3Vy
ZSB0aGF0IGFueQ0KPiA+ID4gPiA+IGluY3JlbWVudHMgdG8gaV92ZXJzaW9uIE1VU1QgYmUgcGVy
c2lzdGVkIGFmdGVyIGl0IGlzDQo+ID4gPiA+ID4gaW5jcmVtZW50ZWQpLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFdlbGwsIGlmIHdlIGFzc3VtZSB0aGF0IHVuY2xlYW4gc2h1dGRvd25zIGFyZSBy
YXJlLCB0aGVuDQo+ID4gPiA+ID4gcGVyaGFwcw0KPiA+ID4gPiA+IHdlDQo+ID4gPiA+ID4gc2hv
dWxkbid0IGJlIG9wdGltaXppbmcgZm9yIHRoYXQgY2FzZS7CoCBTby4uLi4gd2hhdCBpZiBhIGZp
bGUNCj4gPiA+ID4gPiBzeXN0ZW0NCj4gPiA+ID4gPiBoYWQgYSBjb3VudGVyIHdoaWNoIGdvdCBp
bmNyZW1lbnRlZCBlYWNoIHRpbWUgaXRzIGpvdXJuYWwgaXMNCj4gPiA+ID4gPiByZXBsYXllZA0K
PiA+ID4gPiA+IHJlcHJlc2VudGluZyBhbiB1bmNsZWFuIHNodXRkb3duLsKgIFRoYXQgc2hvdWxk
bid0IGhhcHBlbg0KPiA+ID4gPiA+IG9mdGVuLA0KPiA+ID4gPiA+IGJ1dCBpZg0KPiA+ID4gPiA+
IGl0IGRvZXMsIHRoZXJlIG1pZ2h0IGJlIGFueSBudW1iZXIgb2YgaV92ZXJzaW9uIHVwZGF0ZXMg
dGhhdA0KPiA+ID4gPiA+IG1heQ0KPiA+ID4gPiA+IGhhdmUNCj4gPiA+ID4gPiBnb3R0ZW4gbG9z
dC7CoCBTbyBpbiB0aGF0IGNhc2UsIHRoZSBORlMgY2xpZW50IHNob3VsZA0KPiA+ID4gPiA+IGlu
dmFsaWRhdGUNCj4gPiA+ID4gPiBhbGwgb2YNCj4gPiA+ID4gPiBpdHMgY2FjaGVzLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IElmIHRoZSBpX3ZlcnNpb24gZmllbGQgd2FzIGxhcmdlIGVub3VnaCwg
d2UgY291bGQganVzdCBwcmVmaXgNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiAidW5jbGVhbiBz
aHV0ZG93biBjb3VudGVyIiB3aXRoIHRoZSBleGlzdGluZyBpX3ZlcnNpb24gbnVtYmVyDQo+ID4g
PiA+ID4gd2hlbiBpdA0KPiA+ID4gPiA+IGlzIHNlbnQgb3ZlciB0aGUgTkZTIHByb3RvY29sIHRv
IHRoZSBjbGllbnQuwqAgQnV0IGlmIHRoYXQNCj4gPiA+ID4gPiBmaWVsZA0KPiA+ID4gPiA+IGlz
IHRvbw0KPiA+ID4gPiA+IHNtYWxsLCBhbmQgaWYgKGFzIEkgdW5kZXJzdGFuZCB0aGluZ3MpIE5G
UyBqdXN0IG5lZWRzIHRvIGtub3cNCj4gPiA+ID4gPiB3aGVuDQo+ID4gPiA+ID4gaV92ZXJzaW9u
IGlzIGRpZmZlcmVudCwgd2UgY291bGQganVzdCBzaW1wbHkgaGFzaCB0aGUNCj4gPiA+ID4gPiAi
dW5jbGVhbg0KPiA+ID4gPiA+IHNodHVkb3duIGNvdW50ZXIiIHdpdGggdGhlIGlub2RlJ3MgImlf
dmVyc2lvbiBjb3VudGVyIiwgYW5kDQo+ID4gPiA+ID4gbGV0DQo+ID4gPiA+ID4gdGhhdA0KPiA+
ID4gPiA+IGJlIHRoZSB2ZXJzaW9uIHdoaWNoIGlzIHNlbnQgZnJvbSB0aGUgTkZTIGNsaWVudCB0
byB0aGUNCj4gPiA+ID4gPiBzZXJ2ZXIuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSWYgd2UgY291
bGQgZG8gdGhhdCwgdGhlbiBpdCBkb2Vzbid0IGJlY29tZSBjcml0aWNhbCB0aGF0DQo+ID4gPiA+
ID4gZXZlcnkNCj4gPiA+ID4gPiBzaW5nbGUNCj4gPiA+ID4gPiBpX3ZlcnNpb24gYnVtcCBoYXMg
dG8gYmUgcGVyc2lzdGVkIHRvIGRpc2ssIGFuZCB3ZSBjb3VsZA0KPiA+ID4gPiA+IHRyZWF0IGl0
DQo+ID4gPiA+ID4gbGlrZQ0KPiA+ID4gPiA+IGEgbGF6eXRpbWUgdXBkYXRlOyBpdCdzIGd1YXJh
bnRlZWQgdG8gdXBkYXRlZCB3aGVuIHdlIGRvIGFuDQo+ID4gPiA+ID4gY2xlYW4NCj4gPiA+ID4g
PiB1bm1vdW50IG9mIHRoZSBmaWxlIHN5c3RlbSAoYW5kIHdoZW4gdGhlIGZpbGUgc3lzdGVtIGlz
DQo+ID4gPiA+ID4gZnJvemVuKSwNCj4gPiA+ID4gPiBidXQNCj4gPiA+ID4gPiBvbiBhIGNyYXNo
LCB0aGVyZSBpcyBubyBndWFyYW50ZWVlIHRoYXQgYWxsIGlfdmVyc2lvbiBidW1wcw0KPiA+ID4g
PiA+IHdpbGwNCj4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+IHBlcnNpc3RlZCwgYnV0IHdlIGRvIGhh
dmUgdGhpcyAidW5jbGVhbiBzaHV0ZG93biIgY291bnRlciB0bw0KPiA+ID4gPiA+IGRlYWwNCj4g
PiA+ID4gPiB3aXRoDQo+ID4gPiA+ID4gdGhhdCBjYXNlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IFdvdWxkIHRoaXMgbWFrZSBsaWZlIGVhc2llciBmb3IgZm9sa3M/DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLSBUZWQNCj4gPiA+
ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgY2hpbWluZyBpbiwgVGVkLiBUaGF0J3MgcGFydCBvZiB0
aGUgcHJvYmxlbSwgYnV0DQo+ID4gPiA+IHdlJ3JlDQo+ID4gPiA+IGFjdHVhbGx5IG5vdCB0b28g
d29ycmllZCBhYm91dCB0aGF0IGNhc2U6DQo+ID4gPiA+IA0KPiA+ID4gPiBuZnNkIG1peGVzIHRo
ZSBjdGltZSBpbiB3aXRoIGlfdmVyc2lvbiwgc28geW91J2QgaGF2ZSB0bw0KPiA+ID4gPiBjcmFz
aCtjbG9jaw0KPiA+ID4gPiBqdW1wIGJhY2t3YXJkIGJ5IGp1dXV1c3QgZW5vdWdoIHRvIGFsbG93
IHlvdSB0byBnZXQgdGhlDQo+ID4gPiA+IGlfdmVyc2lvbg0KPiA+ID4gPiBhbmQNCj4gPiA+ID4g
Y3RpbWUgaW50byBhIHN0YXRlIGl0IHdhcyBiZWZvcmUgdGhlIGNyYXNoLCBidXQgd2l0aCBkaWZm
ZXJlbnQNCj4gPiA+ID4gZGF0YS4NCj4gPiA+ID4gV2UncmUgYXNzdW1pbmcgdGhhdCB0aGF0IGlz
IGRpZmZpY3VsdCB0byBhY2hpZXZlIGluIHByYWN0aWNlLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhl
IGlzc3VlIHdpdGggYSByZWJvb3QgY291bnRlciAob3Igc2ltaWxhcikgaXMgdGhhdCBvbiBhbg0K
PiA+ID4gPiB1bmNsZWFuDQo+ID4gPiA+IGNyYXNoDQo+ID4gPiA+IHRoZSBORlMgY2xpZW50IHdv
dWxkIGVuZCB1cCBpbnZhbGlkYXRpbmcgZXZlcnkgaW5vZGUgaW4gdGhlDQo+ID4gPiA+IGNhY2hl
LA0KPiA+ID4gPiBhcw0KPiA+ID4gPiBhbGwgb2YgdGhlIGlfdmVyc2lvbnMgd291bGQgY2hhbmdl
LiBUaGF0J3MgcHJvYmFibHkgZXhjZXNzaXZlLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGJpZ2dl
ciBpc3N1ZSAoYXQgdGhlIG1vbWVudCkgaXMgYXRvbWljaXR5OiB3aGVuIHdlIGZldGNoIGFuDQo+
ID4gPiA+IGlfdmVyc2lvbiwgdGhlIG5hdHVyYWwgaW5jbGluYXRpb24gaXMgdG8gYXNzb2NpYXRl
IHRoYXQgd2l0aA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc3RhdGUNCj4gPiA+ID4gb2YgdGhlIGlu
b2RlIGF0IHNvbWUgcG9pbnQgaW4gdGltZSwgc28gd2UgbmVlZCB0aGlzIHRvIGJlDQo+ID4gPiA+
IHVwZGF0ZWQNCj4gPiA+ID4gYXRvbWljYWxseSB3aXRoIGNlcnRhaW4gb3RoZXIgYXR0cmlidXRl
cyBvZiB0aGUgaW5vZGUuIFRoYXQncw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gcGFydA0KPiA+ID4g
PiBJJ20gdHJ5aW5nIHRvIHNvcnQgdGhyb3VnaCBhdCB0aGUgbW9tZW50Lg0KPiA+ID4gDQo+ID4g
PiBJIGRvbid0IHRoaW5rIGF0b21pY2l0eSBtYXR0ZXJzIG5lYXJseSBhcyBtdWNoIGFzIG9yZGVy
aW5nLg0KPiA+ID4gDQo+ID4gPiBUaGUgaV92ZXJzaW9uIG11c3Qgbm90IGJlIHZpc2libGUgYmVm
b3JlIHRoZSBjaGFuZ2UgdGhhdCBpdA0KPiA+ID4gcmVmbGVjdHMuDQo+ID4gPiBJdCBpcyBPSyBm
b3IgaXQgdG8gYmUgYWZ0ZXIuwqAgRXZlbiBzZWNvbmRzIGFmdGVyIHdpdGhvdXQgZ3JlYXQNCj4g
PiA+IGNvc3QuwqANCj4gPiA+IEl0DQo+ID4gPiBpcyBiYWQgZm9yIGl0IHRvIGJlIGVhcmxpZXIu
wqAgQW55IHVubG9ja2VkIGdhcCBhZnRlciB0aGUNCj4gPiA+IGlfdmVyc2lvbg0KPiA+ID4gdXBk
YXRlIGFuZCBiZWZvcmUgdGhlIGNoYW5nZSBpcyB2aXNpYmxlIGNhbiByZXN1bHQgaW4gYSByYWNl
IGFuZA0KPiA+ID4gaW5jb3JyZWN0IGNhY2hpbmcuDQo+ID4gPiANCj4gPiA+IEV2ZW4gZm9yIGRp
cmVjdG9yeSB1cGRhdGVzIHdoZXJlIE5GU3Y0IHdhbnRzIGF0b21pYyBiZWZvcmUvYWZ0ZXINCj4g
PiA+IHZlcnNpb24NCj4gPiA+IG51bWJlcnMsIHRoZXkgZG9uJ3QgbmVlZCB0byBiZSBhdG9taWMg
dy5yLnQuIHRoZSBjaGFuZ2UgYmVpbmcNCj4gPiA+IHZpc2libGUuDQo+ID4gPiANCj4gPiA+IElm
IHRocmVlIGNvbmN1cnJlbnQgZmlsZSBjcmVhdGVzIGNhdXNlIHRoZSB2ZXJzaW9uIG51bWJlciB0
byBnbw0KPiA+ID4gZnJvbQ0KPiA+ID4gNA0KPiA+ID4gdG8gNywgdGhlbiBpdCBpcyBpbXBvcnRh
bnQgdGhhdCBvbmUgb3Agc2VlcyAiNCw1Iiwgb25lIHNlZXMgIjUsNiINCj4gPiA+IGFuZA0KPiA+
ID4gb25lIHNlZXMgIjYsNyIsIGJ1dCBpdCBkb2Vzbid0IG1hdHRlciBpZiBjb25jdXJyZW50IGxv
b2t1cHMgb25seQ0KPiA+ID4gc2VlDQo+ID4gPiB2ZXJzaW9uIDQgZXZlbiB3aGlsZSB0aGV5IGNh
biBzZWUgdGhlIG5ld2x5IGNyZWF0ZWQgbmFtZXMuDQo+ID4gPiANCj4gPiA+IEEgbG9uZ2VyIGdh
cCBpbmNyZWFzZXMgdGhlIHJpc2sgb2YgYW4gdW5uZWNlc3NhcnkgY2FjaGUgZmx1c2gsDQo+ID4g
PiBidXQgaXQNCj4gPiA+IGRvZXNuJ3QgbGVhZCB0byBpbmNvcnJlY3RuZXNzLg0KPiA+ID4gDQo+
ID4gDQo+ID4gSSdtIG5vdCByZWFsbHkgc3VyZSB3aGF0IHlvdSBtZWFuIHdoZW4geW91IHNheSB0
aGF0IGEgJ2xvbmdlciBnYXANCj4gPiBpbmNyZWFzZXMgdGhlIHJpc2sgb2YgYW4gdW5uZWNlc3Nh
cnkgY2FjaGUgZmx1c2gnLiBFaXRoZXIgdGhlDQo+ID4gY2hhbmdlDQo+ID4gYXR0cmlidXRlIHVw
ZGF0ZSBpcyBhdG9taWMgd2l0aCB0aGUgb3BlcmF0aW9uIGl0IGlzIHJlY29yZGluZywgb3INCj4g
PiBpdCBpcw0KPiA+IG5vdC4gSWYgdGhhdCB1cGRhdGUgaXMgcmVjb3JkZWQgaW4gdGhlIE5GUyBy
ZXBseSBhcyBub3QgYmVpbmcNCj4gPiBhdG9taWMsDQo+ID4gdGhlbiB0aGUgY2xpZW50IHdpbGwg
ZXZpY3QgYWxsIGNhY2hlZCBkYXRhIHRoYXQgaXMgYXNzb2NpYXRlZCB3aXRoDQo+ID4gdGhhdA0K
PiA+IGNoYW5nZSBhdHRyaWJ1dGUgYXQgc29tZSBwb2ludC4NCj4gPiANCj4gPiA+IFNvIEkgdGhp
bmsgd2Ugc2hvdWxkIHB1dCB0aGUgdmVyc2lvbiB1cGRhdGUgKmFmdGVyKiB0aGUgY2hhbmdlIGlz
DQo+ID4gPiB2aXNpYmxlLCBhbmQgbm90IHJlcXVpcmUgbG9ja2luZyAoYmV5b25kIGEgbWVtb3J5
IGJhcnJpZXIpIHdoZW4NCj4gPiA+IHJlYWRpbmcNCj4gPiA+IHRoZSB2ZXJzaW9uLiBJdCBzaG91
bGQgYmUgYXMgc29vbiBhZnRlciBhcyBwcmFjdGljYWwsIGJpdCBubw0KPiA+ID4gc29vbmVyLg0K
PiA+ID4gDQo+ID4gDQo+ID4gT3JkZXJpbmcgaXMgbm90IGEgc3VmZmljaWVudCBjb25kaXRpb24u
IFRoZSBndWFyYW50ZWUgbmVlZHMgdG8gYmUNCj4gPiB0aGF0DQo+ID4gYW55IGFwcGxpY2F0aW9u
IHRoYXQgcmVhZHMgdGhlIGNoYW5nZSBhdHRyaWJ1dGUsIHRoZW4gcmVhZHMgZmlsZQ0KPiA+IGRh
dGENCj4gPiBhbmQgdGhlbiByZWFkcyB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBhZ2FpbiB3aWxsIHNl
ZSB0aGUgMiBjaGFuZ2UNCj4gPiBhdHRyaWJ1dGUgdmFsdWVzIGFzIGJlaW5nIHRoZSBzYW1lICpp
ZiBhbmQgb25seSBpZiogdGhlcmUgd2VyZSBubw0KPiA+IGNoYW5nZXMgdG8gdGhlIGZpbGUgZGF0
YSBtYWRlIGFmdGVyIHRoZSByZWFkIGFuZCBiZWZvcmUgdGhlIHJlYWQgb2YNCj4gPiB0aGUNCj4g
PiBjaGFuZ2UgYXR0cmlidXRlLg0KPiANCj4gSSdtIHNheSB0aGF0IG9ubHkgdGhlICJvbmx5IGlm
IiBpcyBtYW5kYXRvcnkgLSBnZXR0aW5nIHRoYXQgd3JvbmcgaGFzDQo+IGENCj4gY29ycmVjdG5l
c3MgY29zdC4NCj4gQlVUIHRoZSAiaWYiIGlzIGxlc3MgY3JpdGljYWwuwqAgR2V0dGluZyB0aGF0
IHdyb25nIGhhcyBhIHBlcmZvcm1hbmNlDQo+IGNvc3QuwqAgV2Ugd2FudCB0byBnZXQgaXQgd3Jv
bmcgYXMgcmFyZWx5IGFzIHBvc3NpYmxlLCBidXQgdGhlcmUgaXMgYQ0KPiBwZXJmb3JtYW5jZSBj
b3N0IHRvIHRoZSB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0gaW4gcHJvdmlkaW5nDQo+IHBlcmZlY3Rp
b24sDQo+IGFuZCB0aGF0IG11c3QgYmUgYmFsYW5jZWQgd2l0aCB0aGUgcGVyZm9ybWFuY2UgY29z
dCB0byBORlMgb2YNCj4gcHJvdmlkaW5nDQo+IGltcGVyZmVjdCByZXN1bHRzLg0KPiANCkkgc3Ry
b25nbHkgZGlzYWdyZWUuDQoNCklmIHRoZSAyIGNoYW5nZSBhdHRyaWJ1dGUgdmFsdWVzIGFyZSBk
aWZmZXJlbnQsIHRoZW4gaXQgaXMgT0sgZm9yIHRoZQ0KZmlsZSBkYXRhIHRvIGJlIHRoZSBzYW1l
LCBidXQgaWYgdGhlIGZpbGUgZGF0YSBoYXMgY2hhbmdlZCwgdGhlbiB0aGUNCmNoYW5nZSBhdHRy
aWJ1dGVzIE1VU1QgZGlmZmVyLg0KDQpDb252ZXJzZWx5LCBpZiB0aGUgMiBjaGFuZ2UgYXR0cmli
dXRlcyBhcmUgdGhlIHNhbWUgdGhlbiBpdCBNVVNUIGJlIHRoZQ0KY2FzZSB0aGF0IHRoZSBmaWxl
IGRhdGEgZGlkIG5vdCBjaGFuZ2UuDQoNClNvIGl0IHJlYWxseSBuZWVkcyB0byBiZSBhbiAnaWYg
YW5kIG9ubHkgaWYnIGNhc2UuDQoNCj4gRm9yIE5GU3Y0LCB0aGlzIGlzIG9mIGxpbWl0ZWQgaW50
ZXJlc3QgZm9yIGZpbGVzLg0KPiBJZiB0aGUgY2xpZW50IGhhcyBhIGRlbGVnYXRpb24sIHRoZW4g
aXQgaXMgY2VydGFpbiB0aGF0IG5vIG90aGVyDQo+IGNsaWVudA0KPiBvciBzZXJ2ZXItc2lkZSBh
cHBsaWNhdGlvbiB3aWxsIGNoYW5nZSB0aGUgZmlsZSwgc28gaXQgZG9lc24ndCBuZWVkDQo+IHRv
DQo+IHBheSBtdWNoIGF0dGVudGlvbiB0byBjaGFuZ2UgaWRzLg0KPiBJZiB0aGUgY2xpZW50IGRv
ZXNuJ3QgaGF2ZSBhIGRlbGVnYXRpb24sIHRoZW4gaWYgdGhlcmUgaXMgYW55IGNoYW5nZQ0KPiB0
bw0KPiB0aGUgY2hhbmdlaWQsIHRoZSBjbGllbnQgY2Fubm90IGJlIGNlcnRhaW4gdGhhdCB0aGUg
Y2hhbmdlIHdhc24ndCBkdWUNCj4gdG8NCj4gc29tZSBvdGhlciBjbGllbnQsIHNvIGl0IG11c3Qg
cHVyZ2UgaXRzIGNhY2hlIG9uIGNsb3NlIG9yIGxvY2suwqAgU28NCj4gZmluZQ0KPiBkZXRhaWxz
IG9mIHRoZSBjaGFuZ2VpZCBhcmVuJ3QgaW50ZXJlc3RpbmcgKGFzIGxvbmcgYXMgd2UgaGF2ZSB0
aGUNCj4gIm9ubHkNCj4gaWYiKS4gDQo+IA0KPiBGb3IgZGlyZWN0b3JpZXMsIE5GU3Y0IGRvZXMg
d2FudCBwcmVjaXNlIGNoYW5nZWlkcywgYnV0IGRpcmVjdG9yeSBvcHMNCj4gbmVlZHMgdG8gYmUg
c3luYyBmb3IgTkZTIGFueXdheSwgc28gdGhlIGV4dHJhIGJ1cmRlbiBvbiB0aGUgZnMgaXMNCj4g
c21hbGwuDQo+IA0KPiANCj4gPiBUaGF0IGluY2x1ZGVzIHRoZSBjYXNlIHdoZXJlIGRhdGEgd2Fz
IHdyaXR0ZW4gYWZ0ZXIgdGhlIHJlYWQsIGFuZCBhDQo+ID4gY3Jhc2ggb2NjdXJyZWQgYWZ0ZXIg
aXQgd2FzIGNvbW1pdHRlZCB0byBzdGFibGUgc3RvcmFnZS4gSWYgeW91DQo+ID4gb25seQ0KPiA+
IHVwZGF0ZSB0aGUgdmVyc2lvbiBhZnRlciB0aGUgd3JpdHRlbiBkYXRhIGlzIHZpc2libGUsIHRo
ZW4gdGhlcmUgaXMNCj4gPiBhDQo+ID4gcG9zc2liaWxpdHkgdGhhdCB0aGUgY3Jhc2ggY291bGQg
b2NjdXIgYmVmb3JlIGFueSBjaGFuZ2UgYXR0cmlidXRlDQo+ID4gdXBkYXRlIGlzIGNvbW1pdHRl
ZCB0byBkaXNrLg0KPiANCj4gSSB0aGluayB3ZSBhbGwgYWdyZWUgdGhhdCBoYW5kbGluZyBhIGNy
YXNoIGlzIGhhcmQuwqAgSSB0aGluayB0aGF0DQo+IHNob3VsZCBiZSBhIHNlcGFyYXRlIGNvbnNp
ZGVyYXRpb24gdG8gaG93IGlfdmVyc2lvbiBpcyBoYW5kbGVkIGR1cmluZw0KPiBub3JtYWwgcnVu
bmluZy4NCj4gDQo+ID4gDQo+ID4gSU9XOiB0aGUgbWluaW1hbCBjb25kaXRpb24gbmVlZHMgdG8g
YmUgdGhhdCBmb3IgYWxsIGNhc2VzIGJlbG93LA0KPiA+IHRoZQ0KPiA+IGFwcGxpY2F0aW9uIHJl
YWRzICdzdGF0ZSBCJyBhcyBoYXZpbmcgb2NjdXJyZWQgaWYgYW55IGRhdGEgd2FzDQo+ID4gY29t
bWl0dGVkIHRvIGRpc2sgYmVmb3JlIHRoZSBjcmFzaC4NCj4gPiANCj4gPiBBcHBsaWNhdGlvbsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBG
aWxlc3lzdGVtDQo+ID4gPT09PT09PT09PT3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPT09PT09PT09PQ0KPiA+IHJlYWQgY2hhbmdlIGF0
dHIgPC0gJ3N0YXRlIEEnDQo+ID4gcmVhZCBkYXRhIDwtICdzdGF0ZSBBJw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgd3JpdGUgZGF0YSAtPiAnc3RhdGUgQicNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDxjcmFzaD4rPHJlYm9vdD4NCj4gPiByZWFkIGNoYW5nZSBhdHRyIDwtICdzdGF0
ZSBCJw0KPiANCj4gVGhlIGltcG9ydGFudCB0aGluZyBoZXJlIGlzIHRvIG5vdCBzZWUgJ3N0YXRl
IEEnLsKgIFNlZWluZyAnc3RhdGUgQycNCj4gc2hvdWxkIGJlIGFjY2VwdGFibGUuwqAgV29yc3Qg
Y2FzZSB3ZSBjb3VsZCBtZXJnZSBpbiB3YWxsLWNsb2NrIHRpbWUNCj4gb2YNCj4gc3lzdGVtIGJv
b3QsIGJ1dCB0aGUgZmlsZXN5c3RlbSBzaG91bGQgYmUgYWJsZSB0byBiZSBtb3JlIGhlbHBmdWwN
Cj4gdGhhbg0KPiB0aGF0Lg0KPiANCkFncmVlZC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=
