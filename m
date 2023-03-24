Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCB56C862D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 20:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCXTuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCXTuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:50:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A01816C;
        Fri, 24 Mar 2023 12:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejJodp5Dfmob7fGXSRG6aQF6aLRJDydiPj4dfY5mg4vDRz8Zi+U/SXrXdWrN+Xdv2HMTrfKRLZpsj41tA4nfIxzIK0HE7o5hGXMdFH8z5DNGZQhHwdWs4WuF5gAS5XRSou+Wn5M6eQIywBtqUGNkxTYa3PQjvwpgG6yXDTrA3/ejmJ0udik0DqJSWQM6JAVa6pNyYF6ihXw8gcIpRZkuJEwH0tnGJNnFjO0hFA8XnNIP10NkuhkkQvbNlPoIGg/qLVicb9jov+odWLbdYXLFCk7KCffs2vC+8Mp1dI6RHAI81+Ocref8by2tufZgaFMtf1KuO/fcXsSoS/AkR+31pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNAItSyEmikMBul8vf3l4MKr/QxxZjaxucQoO+p8TKk=;
 b=kZVQiWggX2OlgyxmYts8W3mXSbEqwKuD0Lzxs2/m51yaZh+6yCwuMWi0/AuNTDjPCwsZM843scz7L2Q9CYUUy0YY/lwvbz/kHLRch3xbxe41iLw5tQCX9YIePftD9xUZL/0SHpTJfe783Yj0OD5uYB1qzy9Ej+i0juLWHnYfctQfSSJW67FjNiRePAHKXdtrbPw3cVE/psSlTu9rzbZeDFY+ylmuTgnIsufO3WwyN9qJtdzdDSllf7sK0jugEM/7Ova1Qo+9SvS/CkqZndFk2ePOicmv8F24dBoxyCnosUtoyax27gMv8EmRryFWMQxJSCX/LbP8+bvNP/KmIjNQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNAItSyEmikMBul8vf3l4MKr/QxxZjaxucQoO+p8TKk=;
 b=buWfbj2wLPPNraDSy9+M2NZanC3swDfUEm5ploMGe/7qwSzR472FKusd8QZIe23DIA9jwpZJgipzKQxSBPBUJOno2OiSnNKgcBfCh19fdHinCMgIkD1xQVsdV81phPBt9B6DO3QQSdP9/kmAH0UI8pnZSuXwdScoCiYRQ7PedXs=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by SN7PR19MB4797.namprd19.prod.outlook.com (2603:10b6:806:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Fri, 24 Mar
 2023 19:50:13 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Fri, 24 Mar 2023
 19:50:13 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>
CC:     Dharmendra Singh <dsingh@ddn.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonYo+gt+cSL6UOMGg0a/H7o1A==
Date:   Fri, 24 Mar 2023 19:50:12 +0000
Message-ID: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|SN7PR19MB4797:EE_
x-ms-office365-filtering-correlation-id: 8e6f2a06-92f0-455c-5127-08db2ca0fb81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHoxe/hgKqdn1AefyGYTGn5g0BH7vT/TW03/ohLrP5krjFAikN2i80w9xStk+KbQoWlt+Mg6SnAjCAudg2DeF6j+kjFHsnwRSIeJwqwDhVB1lCR7xB6EjBU9I0yASSzVKj1+fC86nY83sZabYwKePUKVXoyJdnDRxuL5Uba/vX9/rJkAvgktGT6c4W0+elbCJp4sIYXO+oLRlCgxTQZIjjGK8CPNZD4WmArFOO0hNOI3zwJWNtTgFRui31KO/xNBFX1wtHCE4aTSL5p5BEC0bR5Oy8Ua60QBuF8iOp4HynjzB56BbHaHP+MvY8UHe8wtVcHJG32XdH9Xk49D+p1dIqTsSINT1423S17yX4i5BUcGAHVMkKOgrH7l9mg59tvNOJH4zcbdQRV7YfOfuUH12mFg+PbtKc05XYS6dnCMtSO2dA7mAoEdyl4jJFBlLYNZhqPG/GFhcIkTS9BYd5ousIXevcs4o9JkLrAxHJwpcQF9TznqMSc0RJiOTZaP4lc3ALwi07nFJp8WOJ8Ijvc837oaaTnzDI8HOBQTGXb9Y1vGJc7jhT5fwg0lynRAKEEsHG3XvB8xEzXkgWL+KkcV0MR42vpnYsy1FMVpbK+pH/nZSqyeyXy5fji1T0nxXbvGLCYZCYMgdDG4vw/ZYgAYqXz5gE8BW8WQPZl10YfaV7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39850400004)(136003)(396003)(346002)(451199021)(2616005)(110136005)(122000001)(36756003)(66446008)(54906003)(6506007)(66946007)(64756008)(8676002)(478600001)(38100700002)(41300700001)(2906002)(76116006)(8936002)(83380400001)(6486002)(4326008)(966005)(38070700005)(66476007)(316002)(186003)(71200400001)(31696002)(86362001)(66556008)(6512007)(31686004)(5660300002)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVJ1MDdGSFpHNXV2S2NheHNqbVN1VEM3d0NFSmVLV2ZHTExrbEhaSmdaeDJy?=
 =?utf-8?B?WnE5VHNUNzk4VUsrVjZMMmZCZGxNU1VMV3NJNkJIOEJ4K05uY2UzNURoU2w5?=
 =?utf-8?B?ajcvaS93Qy9ycVVCQmlpYWUzTytYdzU2eEVubDhxN1ZOcTFIOTRnWjA1Y0F2?=
 =?utf-8?B?dnlhQlF2Z3JIODd3Ri9ld2RPV3crblRXMzQ2OGEralZJYytWQ29ka3pGVHpw?=
 =?utf-8?B?WXB3V3lEV3JSd052eGZMdzJDMDF4OGh3NEErUTEzV0IvU3gwWmEvVW1UTkZj?=
 =?utf-8?B?UWdEeUkweEJQVCt3M1M1VFhKU1F3a3Iyci9mSWxvSG5EbEdkSnJRK1hsZUF4?=
 =?utf-8?B?T1lOYTdmTEdqT01FQzY2OGVNTW8vOXZzNVkwRmJFdnRoVlMvZ0I5VWcxK054?=
 =?utf-8?B?Uk4zazVuS2FXRzI5WTN0WC8xb29PalZYVzdBaWY5NUs2YTRTN3BpbVBHZDhQ?=
 =?utf-8?B?REM0WTFUWHZ0dXlFY1FEdzZ1R0N0QzdiM1dYT2RsekNJS1JHeFdGTDlQUTVn?=
 =?utf-8?B?Y20xVnZhcjN2UjRacmpxb2hRQmZFQUpKRWJGQXQ0NFdrcWVueDltTXUrSUxB?=
 =?utf-8?B?NUNZZ3RBL1BhWGtuOVFGRjMwTnRTL0l1YzZCQ0dtV1hQMkJ6UHB5U3BYS2hs?=
 =?utf-8?B?UWx2c0x0NTVhMVpWZE5XSTRHRUdDNHN1NTJueXBuZ0x5a0xzYzJsbmp0MENq?=
 =?utf-8?B?ZUZDTWpWN3ZtS3A0eElsZjRLQjBmMSs1c1E5cm1RSDJBM2hRdnl5dWh3Wkc0?=
 =?utf-8?B?azI1cGNSVXIvQlRrZWZ3MENZQk1ieHNsd0VldnlCL21PQXZ4QW5KY2tCMU1Y?=
 =?utf-8?B?dTJwNjByc3Z3d0VNSCt6b096dExadTZkTm90M2FjY0NmOEl4QkdCamNyZnpa?=
 =?utf-8?B?MkxzcjlhOHZTeCtiTFFBbGFIdnZlSUVOYmxrZ3NUa1hkaDk0MjNkdUpMWW5X?=
 =?utf-8?B?QlVucHFxMDZmSDI1NVBMd3NRTUtpS0oxWEpQTzJ0ZkFpNUtJeXZmaFZYYmhy?=
 =?utf-8?B?WDFXdDA1SFVsQ2JxWk94cXBEMXJlaWx5K3ZFWVQ3UXU4a1U4aTdDdW4yeTBY?=
 =?utf-8?B?Z3M2RXpBZ0N5N08vWTZpMkExV0hLeUE2N1hYUVdIYURqSmlzanNnNDFibVcx?=
 =?utf-8?B?TEp1RFd1K3NiZVNQdXBNS1FrSEtRVnFwalZjbjFQWGJZQStZSEZnS2NGa3RG?=
 =?utf-8?B?VUtsazdZTmREUjZxcnUyUG1rb25DNjlEaDduSGtLNG44VFgyM1pNY2dGcjc1?=
 =?utf-8?B?WUIwZ21qSDRtaFA2SGhJaUVWQXZSTU1vSE1hV0l2RDNBSjhvK0hGK0FGLzlr?=
 =?utf-8?B?MG9WcEtCTFdDQjAxei9HaXg4TGh6K2toSGdjTVREQnJhcnlzdTFFbUtRV3hl?=
 =?utf-8?B?bWI4RjZGdTRiOEVPV3Fva0dGM3A5VUtlYlZyeXFHVjFMcmhLZUgxUkFEVXhn?=
 =?utf-8?B?K0p3ejFpNU5lTlNrdTBoSG9rK1kvRzhqakNTSWZXM1JvNktyT0g5RXFUYzgz?=
 =?utf-8?B?cWZWYk5veHpPbFhCZ3VlRUZFU0xmSlQ2YzBMalQ4allDSS9haHRwSXc3MDc5?=
 =?utf-8?B?VXlvUXdwUjZ3eU1VMDBjd3RrVjliOGlqNkI1MVlOMzBpQWpqckMwZkZ1Mjhn?=
 =?utf-8?B?dWtwYURLeHYwdjAwZ2x3UW5KdTQ4enZva05FS3pNc1VHQVNDbWlKK0lYMy92?=
 =?utf-8?B?QXRYemt0YnNhcFNOY2tjZFdLVktHa0FDZUxvR1NZQWFscXVreHJSN2FIYk0x?=
 =?utf-8?B?eW5ZcTM3L29kbUVhWWpWd01ua1M4VDVkTW1yTEw0Q2xDQUxQNThlME1PTzNl?=
 =?utf-8?B?MHFBalhlWDY5RlMrdWRZejd4c3ZIc0JkZlNIRjcwUXVXY0JvWGpwWk4xTmRW?=
 =?utf-8?B?ajEyNmZRbUxjbVljNXdJQmdJaEVMbFFFa2JkV3lnOFBqUUVkMWc5U2p4cXVG?=
 =?utf-8?B?a0VUQjhPUXJjci9OTmxkVWxhS2FFeEthNzJZQ0ErTW1TUzhZOXZmVks1aWFa?=
 =?utf-8?B?VVhPZjZnMWZKMXd5cjFGQUNpVmh1TVBHVHFadGEvazRQQzhLVWZ3YjJKN1Fv?=
 =?utf-8?B?WDd1VmMyK0dENWpkMDlralY3RkY1Tm1saDBJVmNrdjUrRFE0SzNKVnRkUW1W?=
 =?utf-8?B?ekxZK2NndzVVeTVwVDY2V09wbCtNRDF0eGJZWVJmR3ptcjhhRGJPMnFhc0RC?=
 =?utf-8?Q?FXObVDG7lXZc+t7KqoRFAbI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B861D93088B6A46BD717083052DDA63@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6f2a06-92f0-455c-5127-08db2ca0fb81
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 19:50:12.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XWiQxS/gKnWDl/a/H+IWgf077u2ey3nnCdwv5qZYAvFZPtqpQB1Zf3hgNhN2wlD2hCukRzrZNdciB/Y93U2RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4797
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW5nbywgUGV0ZXIsDQoNCkkgd291bGQgbGlrZSB0byBhc2sgaG93IHRvIHdha2UgdXAgZnJvbSBh
IHdhaXRxIG9uIHRoZSBzYW1lIGNvcmUuIEkgaGF2ZSANCnRyaWVkIF9fd2FrZV91cF9zeW5jKCkv
V0ZfU1lOQywgYnV0IEkgZG8gbm90IHNlZSBhbnkgZWZmZWN0Lg0KDQpJJ20gY3VycmVudGx5IHdv
cmtpbmcgb24gZnVzZS91cmluZyBjb21tdW5pY2F0aW9uIHBhdGNoZXMsIGJlc2lkZXMgdXJpbmcg
DQpjb21tdW5pY2F0aW9uIHRoZXJlIGlzIGFsc28gYSBxdWV1ZSBwZXIgY29yZS4gQmFzaWMgYm9u
bmllKysgYmVuY2htYXJrcyANCndpdGggYSB6ZXJvIGZpbGUgc2l6ZSB0byBqdXN0IGNyZWF0ZS9y
ZWFkKDApL2RlbGV0ZSBzaG93IGEgfjN4IElPUHMgDQpkaWZmZXJlbmNlIGJldHdlZW4gQ1BVIGJv
dW5kIGJvbm5pZSsrIGFuZCB1bmJvdW5kIC0gaS5lLiB3aXRoIHRoZXNlIA0KcGF0Y2hlcyBpdCBf
bm90XyBmdXNlLWRhZW1vbiB0aGF0IG5lZWRzIHRvIGJlIGJvdW5kLCBidXQgdGhlIGFwcGxpY2F0
aW9uIA0KZG9pbmcgSU8gdG8gdGhlIGZpbGUgc3lzdGVtLiBXZSBiYXNpY2FsbHkgaGF2ZQ0KDQpi
b25uaWUgLT4gdmZzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoYXBwL3ZmcykNCiAg
IGZ1c2VfcmVxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoYXBwL2Z1c2Uua28p
DQogICBxaWQgPSB0YXNrX2NwdShjdXJyZW50KSAgICAgICAgICAgICAgICAgIChhcHAvZnVzZS5r
bykNCiAgICAgcmluZyhxaWQpIC8gU1FFIGNvbXBsZXRpb24gKGZ1c2Uua28pICAgKGFwcC9mdXNl
LmtvL3VyaW5nKQ0KICAgICAgIHdhaXRfZXZlbnQocmVxLT53YWl0cSwgLi4uKSAgICAgICAgICAo
YXBwL2Z1c2Uua28pDQogICAgICAgW2FwcCB3YWl0XQ0KICAgICAgICAgZGFlbW9uIHJpbmcgLyBo
YW5kbGUgQ1FFICAgICAgICAgICAoZGFlbW9uKQ0KICAgICAgICAgICBzZW5kLWJhY2sgcmVzdWx0
IGFzIFNRRSAgICAgICAgICAoZGFlbW9uL3VyaW5nKQ0KICAgICAgICAgICAgIGZ1c2VfcmVxdWVz
dF9lbmQgICAgICAgICAgICAgICAoZGFlbW9uL3VyaW5nL2Z1c2Uua28pDQogICAgICAgICAgIHdh
a2VfdXAoKSAgLS0tPiByYW5kb20gY29yZSAgICAgIChkYWVtb24vdXJpbmcvZnVzZS5rbykNCiAg
ICAgICBbYXBwIHdha2V1cC9mdXNlL3Zmcy9zeXNjYWxsIHJldHVybl0NCmJvbm5pZSA9PT4gZGlm
ZmVyZW50IGNvcmUNCg0KDQoxKSBib3VuZA0KDQpbcm9vdEBpbWVzcnYxIH5dIyBudW1hY3RsIC0t
bG9jYWxhbGxvYyAtLXBoeXNjcHViaW5kPTAgYm9ubmllKysgLXEgLXggMSANCi1zMCAgLWQgL3Nj
cmF0Y2gvZGVzdC8gLW4gMjA6MToxOjIwIC1yIDAgLXUgMCB8IGJvbl9jc3YydHh0DQogICAgICAg
ICAgICAgICAgICAgICAtLS0tLS1TZXF1ZW50aWFsIENyZWF0ZS0tLS0tLSAtLS0tLS0tLVJhbmRv
bSANCkNyZWF0ZS0tLS0tLS0tDQogICAgICAgICAgICAgICAgICAgICAtQ3JlYXRlLS0gLS1SZWFk
LS0tIC1EZWxldGUtLSAtQ3JlYXRlLS0gLS1SZWFkLS0tIA0KLURlbGV0ZS0tDQogICAgICAgZmls
ZXM6bWF4Om1pbiAgL3NlYyAlQ1AgIC9zZWMgJUNQICAvc2VjICVDUCAgL3NlYyAlQ1AgIC9zZWMg
JUNQIA0KL3NlYyAlQ1ANCmltZXNydjEgICAyMDoxOjE6MjAgIDYyMjkgIDI4IDExMjg5ICA0MSAx
Mjc4NSAgMjQgIDY2MTUgIDI4ICA3NzY5ICA0MCANCjEwMDIwICAyNQ0KTGF0ZW5jeSAgICAgICAg
ICAgICAgIDQxMXVzICAgICA4MjR1cyAgICAgODE2dXMgICAgIDI5OHVzICAgMTA0NzN1cyANCjIw
MG1zDQoNCg0KMikgbm90IGJvdW5kDQoNCltyb290QGltZXNydjEgfl0jIGJvbm5pZSsrIC1xIC14
IDEgLXMwICAtZCAvc2NyYXRjaC9kZXN0LyAtbiAyMDoxOjE6MjAgDQotciAwIC11IDAgfCBib25f
Y3N2MnR4dA0KICAgICAgICAgICAgICAgICAgICAgLS0tLS0tU2VxdWVudGlhbCBDcmVhdGUtLS0t
LS0gLS0tLS0tLS1SYW5kb20gDQpDcmVhdGUtLS0tLS0tLQ0KICAgICAgICAgICAgICAgICAgICAg
LUNyZWF0ZS0tIC0tUmVhZC0tLSAtRGVsZXRlLS0gLUNyZWF0ZS0tIC0tUmVhZC0tLSANCi1EZWxl
dGUtLQ0KICAgICAgIGZpbGVzOm1heDptaW4gIC9zZWMgJUNQICAvc2VjICVDUCAgL3NlYyAlQ1Ag
IC9zZWMgJUNQICAvc2VjICVDUCANCi9zZWMgJUNQDQppbWVzcnYxICAgMjA6MToxOjIwICAyMDY0
ICAzMyAgMjkyMyAgNDMgIDQ1NTYgIDI4ICAyMDYxICAzMyAgMjE4NiAgNDIgDQo0MjQ1ICAzMA0K
TGF0ZW5jeSAgICAgICAgICAgICAgIDg1MHVzICAgIDM5MTR1cyAgICAyNDk2dXMgICAgIDczOHVz
ICAgICA3NTh1cyANCjY0Njl1cw0KDQoNCldpdGggbGVzcyBmaWxlcyB0aGUgZGlmZmVyZW5jZSBi
ZWNvbWVzIGEgYml0IHNtYWxsZXIsIGJ1dCBpcyBzdGlsbCB2ZXJ5IA0KdmlzaWJsZS4gQmVzaWRl
cyBjYWNoZSBsaW5lIGJvdW5jaW5nLCBJJ20gc3VyZSB0aGF0IENQVSBmcmVxdWVuY3kgYW5kIA0K
Qy1zdGF0ZXMgd2lsbCBtYXR0ZXIgLSBJIGNvdWxkIHR1bmUgdGhhdCBpdCBpbiB0aGUgbGFiLCBi
dXQgaW4gdGhlIGVuZCBJIA0Kd2FudCB0byB0ZXN0IHdoYXQgdXNlcnMgZG8gKEkgaGFkIHJlY2Vu
dGx5IGNoZWNrZWQgd2l0aCBsYXJnZSBIUEMgY2VudGVyIA0KLSBGb3JzY2h1bmdzemVudHJ1bSBK
dWVsaWNoIC0gdGhlaXIgSFBDIGNvbXB1dGUgbm9kZXMgYXJlIG5vdCB0dW5lZCB1cCwgDQp0byBz
YXZlIGVuZXJneSkuDQpBbHNvLCBpbiBvcmRlciB0byByZWFsbHkgdHVuZSBkb3duIGxhdGVuY2ll
cywgSSB3YW50IHdhbnQgdG8gYWRkIGEgDQpzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zOjp1cmluZ19j
bWRfaW9wb2xsIHRocmVhZCwgd2hpY2ggd2lsbCBzcGluIGZvciBhIA0Kc2hvcnQgdGltZSBhbmQg
YXZvaWQgbW9zdCBvZiBrZXJuZWwvdXNlcnNwYWNlIGNvbW11bmljYXRpb24uIElmIA0KYXBwbGlj
YXRpb25zICh3aXRoIG4tbnRocmVhZHMgPCBuLWNvcmVzKSB0aGVuIGdldCBzY2hlZHVsZWQgb24g
ZGlmZmVyZW50IA0KY29yZSBkaWZmZXJuZW50IHJpbmdzIHdpbGwgYmUgdXNlZCwgcmVzdWx0IGlu
DQpuLXRocmVhZHMtc3Bpbm5pbmcgPiBuLXRocmVhZHMtYXBwbGljYXRpb24NCg0KDQpUaGVyZSB3
YXMgYWxyZWFkeSBhIHJlbGF0ZWQgdGhyZWFkIGFib3V0IGZ1c2UgYmVmb3JlDQoNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMTYzODc4MDQwNS0zODAyNi0xLWdpdC1zZW5kLWVtYWlsLXF1
aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20vDQoNCldpdGggdGhlIGZ1c2UtdXJpbmcgcGF0Y2hlcyB0
aGF0IHBhcnQgaXMgYmFzaWNhbGx5IHNvbHZlZCAtIHRoZSB3YWl0cSANCnRoYXQgdGhhdCB0aHJl
YWQgaXMgYWJvdXQgaXMgbm90IHVzZWQgYW55bW9yZS4gQnV0IGFzIHBlciBhYm92ZSwgDQpyZW1h
aW5pbmcgaXMgdGhlIHdhaXRxIG9mIHRoZSBpbmNvbWluZyB3b3JrcSAobm90IG1lbnRpb25lZCBp
biB0aGUgDQp0aHJlYWQgYWJvdmUpLiBBcyBJIHdyb3RlLCBJIGhhdmUgdHJpZWQNCl9fd2FrZV91
cF9zeW5jKCh4KSwgVEFTS19OT1JNQUwpLCBidXQgaXQgZG9lcyBub3QgbWFrZSBhIGRpZmZlcmVu
Y2UgZm9yIA0KbWUgLSBzaW1pbGFyIHRvIE1pa2xvcycgdGVzdGluZyBiZWZvcmUuIEkgaGF2ZSBh
bHNvIHRyaWVkIHN0cnVjdCANCmNvbXBsZXRpb24gLyBzd2FpdCAtIGRvZXMgbm90IG1ha2UgYSBk
aWZmZXJlbmNlIGVpdGhlci4NCkkgY2FuIHNlZSB0YXNrX3N0cnVjdCBoYXMgd2FrZV9jcHUsIGJ1
dCB0aGVyZSBkb2Vzbid0IHNlZW0gdG8gYmUgYSBnb29kIA0KaW50ZXJmYWNlIHRvIHNldCBpdC4N
Cg0KQW55IGlkZWFzPw0KDQoNClRoYW5rcywNCkJlcm5kDQoNCg0KDQoNCg0KDQo=
