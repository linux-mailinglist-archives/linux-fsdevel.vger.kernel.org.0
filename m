Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACF5A391C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiH0RGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH0RGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:06:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447EB286E2;
        Sat, 27 Aug 2022 10:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auDGcjq12kFZoIw/qb7xb6EvhFfiEjc5T2zmPnQ/0Kb+lANfq7kE1I5sn4ZIz5qyLL80vkSfYJ9ogwdbjqEeLcGViClMwBgs1GUZHVfC8trC8qmBGLkPuzMhbDmO3rcUrXpNbn3fX+VTU1QiECWIld5SgjX90oT2EIDPWGEcY3WoyhVCUklpk8EAnWSyRDEzERLLdWgreT7doRiCIQP0Jk3ajByHSg+yNx/b80DwlhFzCxFL64PpHErhKc+b1HjjosbMML1wP8KgDFo0+qmN0hqvFTy4vkO0144/8uUbdmkfiUvWtud7d1aPRY3/masFzNWwZFqVKjjqSVCQVBf00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz5jjjcMDt9XUAjxENI2623qfC7iPhMxH71D6K7STvQ=;
 b=PCdzD29cPJeOeU13SJiUwjzHXKLWtxJD2/8fwW3w6xbMHYmSn57/TGyzxt4RNo7/+JFE6Q0FD+sp9YC9m1MTkfX7N8raeQY51ev81aILt6TrSqlHegnSDrKedjlOEH4f6wf46LAjj4law9CpP2I4YJoDtNusofKEragEDhDg0PYtA8F+YU0n8Db56xU9e5DLZDzivF4geAcI15nJ0nD/C3/XTnryGB5MMg1GIuFaYW8vqa5CnoNf3pHmYH6WJ0ZWRmOaC+hyBmaOUV6gcqUcaf6fZW1UP5yjj4gRtAAWHfutbTdYJTn/8uPiriGhtXwOFl0eJewZWjx++BstFOKo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz5jjjcMDt9XUAjxENI2623qfC7iPhMxH71D6K7STvQ=;
 b=F5IlP720n2+4Un5gWroWYQjjAuWmYgvVTjYTygeLwL2yCPVcTuy83ijiT4mCupcxhswAwo5PhK49w4r39ZW8X9PVkNbUIFULOmw0nf72baU0g00VGCCmh6pa4w2vYoVemOTqAxYBwpWoH4PXyz7Ge3DfMWbWDczCmnmcFA37184=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4039.namprd13.prod.outlook.com (2603:10b6:208:269::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.7; Sat, 27 Aug
 2022 17:06:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Sat, 27 Aug 2022
 17:06:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
Thread-Topic: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
Thread-Index: AQHYuZVsJRRF0PWz8kOHI52liC045q3CWXOAgAAJxgCAAFd9AIAAKpiAgAAEgoCAAAH2AIAAD82A
Date:   Sat, 27 Aug 2022 17:06:42 +0000
Message-ID: <3a939c44746e0ab98fb1274ffa33b82dcbc789d1.camel@hammerspace.com>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-5-jlayton@kernel.org>
         <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
         <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
         <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
         <Ywo8cWRcJUpLFMxJ@magnolia>
         <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
         <b13812a68310e49cc6fb649c2b1c25287712a8af.camel@kernel.org>
In-Reply-To: <b13812a68310e49cc6fb649c2b1c25287712a8af.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbb38f10-ced2-46b9-7765-08da884e8397
x-ms-traffictypediagnostic: MN2PR13MB4039:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfJNP3Wr38Qat9BDW4txZxH/keWu+iHyQfcSJZE+WnoTjWGqV3MePBnAiCokZEq8DwUH2Z8+Xjc3UcE0TebE6MHPTlpevIa0U95X59eHwyebWYPYeH2KLguQFpd04AXEiw8T1p77JoFxznR0FN+i/NuElDdkCwD9SoangtctTzkvg6O9wpir/axypyYFPcwp+ovPeJRnEbd5cyK7kCFFk5Qo5zT2yfDk/v81QbxO1ZIuQAZMgsjeI2r55fnBo4myb+FPuHIqsYO63UdFDL3XvGDKGUzOqHNiYaaamx6eTCEvLfQJVMxXkAeq+NAwpVDR7Bd5vzBOrx5qYxJSBybA+1gqbu4bgKVKXKUf5Pgo/N4XZTQLw1SzSJE0NuVYKfMqh9id71waOoykwAS6pS/hr0iI9OtOPREzsz/+scBDt+G8X9ZlS14Q9ZOQ9otExj3pjky2T6sY1eyLdPY0cllgVDTQHWgRgE9m9h8lvn+RzGl9D+0N2N2p68L8CT4QgdcH1sYIEyTo4u98KlilfUy1XSfg3roS/ULB8J9BtaNFxnj3O/IsCdHXSvvgou9IE3pUXMX8QUXD5k9MutEImTCfBEMGsyuiMYKBD2xtJfP6ryenqwZbQA9xrFTaW3o123GpkpOFAMaeHBnn5b6C3EG7hmbunwvpGoB+6Vif7Y6RZAvZEc6qqSuoFJIfJ7P+YN80ZFyPS3LAgBrS/xunEJFdylOVphBJi0/rlvRcRXIrm6WpU4ZmLNGEir9GRW1SuiCkbACdXveQgik7X3ceWQbRqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39840400004)(366004)(396003)(136003)(346002)(2616005)(36756003)(186003)(6486002)(83380400001)(6506007)(71200400001)(38100700002)(53546011)(26005)(41300700001)(478600001)(6512007)(5660300002)(7416002)(66446008)(4326008)(8676002)(64756008)(66476007)(66556008)(66946007)(15650500001)(110136005)(54906003)(76116006)(86362001)(316002)(2906002)(38070700005)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzVEVzc4c3M5bE0wR20xQ1ZCKzBXZllGZloyTFZTdHAwOXBKNWdBNnpRYnVr?=
 =?utf-8?B?SmovTkd0OHBSeEtiR0wybm5ZNkg4T3hnMG5nOTBXdkJOQi9BVXRQWlUwdzJn?=
 =?utf-8?B?U29VYmtDWWgyN201ZTBkbjgvTW1FalRQZTlrK1ZIRjdLVzBJTm5ETTdicGxj?=
 =?utf-8?B?VTgzYzM4K1hpRzgzbm5sL3RmNnliblFFb3pHemw5bXVJL09EWWZsdmErZ295?=
 =?utf-8?B?ZDN6RXdFazBqbEFpMU5Ra3RHUVVDaU55dW1YZERSUmN5a0tIOTkwdk5QaTZF?=
 =?utf-8?B?NGg4Y05qWXdQZ3hnenJYNzk2MW1vc3RWVDFudmIrVGVFOGk2c3NPTVpUMG1W?=
 =?utf-8?B?ckg5bHhxQ1NWRU9DVWQvc0dqR090cjdZS0NTN0hYZTkvb0U1NmNsejk1TDhG?=
 =?utf-8?B?LytFMUZRTklBUXB2MnNscVRweTlYeTgvcEt1dzgrdEF0TEd3SmYvMlZpWVQz?=
 =?utf-8?B?SjlES2x0aHBCek9MamxEa0ZrTjFXSzh0WWhDVm1xdFZLY2srN211VUNYRXBn?=
 =?utf-8?B?SDVHcHlXR3l6S096cDRaT2p1V3BPUVZMR1B2bWQ2K3FqdUg2cThCT3BRYmFk?=
 =?utf-8?B?YzVFb3VoSkxQNzFoYkRCRWxCMTZaY2pVSFVlL0dYQ09RdmdPUWkvdzk1Qyt1?=
 =?utf-8?B?RTYzZWNWTEpablBLMFgwQnpsRGplTzlmM3ZoWkUxdXVpb2N1b0VmN2ZxL2JE?=
 =?utf-8?B?U2k3R3lqeTB3d3lyK3lXQy9TbTIxQWw2MjZUbWVWU3BYUlB3bk9ibFBON0hk?=
 =?utf-8?B?QncwYkRXcmxGd1RlbXd0UDVTYVVDN1VvSWc4QllaYldQNHJObXRCRzZVVDQ3?=
 =?utf-8?B?QTVQeVpuQ0NqOVlDeWlKYlV1ZFpJdTJmVzVZc2NQc0puNkRmeG5sdHR5ZWNz?=
 =?utf-8?B?emJHS0ovb09GTXBlV1F3OWYrUFptU3NkOGRKZ1kwRXIxeUI2VnVCK0tVUTRP?=
 =?utf-8?B?UXlhUGwvSUNRRlJWSnY0Vi9kN3dCZVF5bGRMc1RTYlN1cEdCQzBaUmpjYnBk?=
 =?utf-8?B?d2x5MUVMWjd2NGozMHNTYmlmUUV4SHRVN3NqUjI3b21WRzgxU0tUdTFNTUJm?=
 =?utf-8?B?M1JONHUraEUyR1Q0WG85U0tENm5XRUpnbmxXUlBVcVMzMFlDSkUzK0Q1cXJZ?=
 =?utf-8?B?NVNEYTFWUjA0NzNMRkowTWhsVzVTQVF0SExRN2owL3BtOXF3QUdrdnI3aTdu?=
 =?utf-8?B?R2x6Z2lSbU5EbzA3bStJOWQzSTZWeEc2THpKSExRZVJxcVZZbDJqaXdhQ056?=
 =?utf-8?B?V1l6RWh3QnlLbmtHWGRuWDVHeVBPN3FmejRZSEx6M3JLdFNLNmdxMmZqVUFS?=
 =?utf-8?B?clVyUUFFK1VxZVd4UmQ0QzlFUURJeWtJZDVtSnl3OU1jSFJ1amI1YzhWeGFK?=
 =?utf-8?B?OC9kUS9Bbi9LU2xKSTA0QXMwSW9Zcm1qTGpoQmNjQUVEQVRZZVJBUDFkb3N2?=
 =?utf-8?B?VUMvQmZETWJtNE9wWVJMMDI1bEJBNTZnYlZENGs2MnpJVnFjWFNaZ3ZsV1Vy?=
 =?utf-8?B?dlVKSmU0NzVoWmRhcEhNNFpWRmdvWHpobmY2U1ZkR2FreGpkN2tFbHJzU0hp?=
 =?utf-8?B?bWFySXVUQlRESzM5OGxkdnM5UFVzYmdsTHBiL2xhTHhqRGU0MmtKT1EvSDMw?=
 =?utf-8?B?UmdGcnVBWjIzNXpqM215TUJoMUhKaURFT0dlR3VaQ29iaDFLZWx0NDJsaGUy?=
 =?utf-8?B?cWxXck50M3RDQkNsTnJidTNjL2ZZUVJMNWYwUFpDZ3RVOTVhTWdDTG1lSmNN?=
 =?utf-8?B?djJrUG1oU3BHNWxseERaZWExbXIvTDV6YmhBWm9LU29JUG0rcTNKaUZiSmxC?=
 =?utf-8?B?d01oMS8zTmg3K1F2S3dveFM0TGxjNU8zZDFob0NWcEQ3dkpiYlh0TWdNY3Fi?=
 =?utf-8?B?UXppMlhhSCtDRDE0bnlLODRlNDhqOEh6bjNZc0xwY3lHSm5MQWwxMHVmQjFS?=
 =?utf-8?B?WS9SN3c3ajNBMmpvaFFoVzBzSTVsZEF4V1VKNFR3eXpDNzhaL1BjeTk1ak44?=
 =?utf-8?B?UWNMd1NHVnlsTnlGc2tFOFVWdFZqeUJ1KzFiT00reHNGV3liSUNoeHlYeUNF?=
 =?utf-8?B?ZTNJNDJsQm1rRGJleENzVEJnM0tpNzBEYkV5dzFubmhnSWlMV0ltVnV0L1J5?=
 =?utf-8?B?NTE3aHJMQmVKdmZlQ1NJaUE2eXpIZ0Q2K0V0Qm9MRVZ1emRkck9rby9KRU10?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <425AF6394BCFA640A8C041F03CC21CC7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb38f10-ced2-46b9-7765-08da884e8397
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 17:06:42.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKr6PMdK5Rwai6tgFxCqP9LFa/l9PZLE4Ag2Og8PaAUEwXRgXiAEYNy5YZx8uZcIBD1cYPRHn6Jk/fwKM6ovdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU2F0LCAyMDIyLTA4LTI3IGF0IDEyOjEwIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gU2F0LCAyMDIyLTA4LTI3IGF0IDE2OjAzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gU2F0LCAyMDIyLTA4LTI3IGF0IDA4OjQ2IC0wNzAwLCBEYXJyaWNrIEouIFdvbmcg
d3JvdGU6DQo+ID4gPiBPbiBTYXQsIEF1ZyAyNywgMjAyMiBhdCAwOToxNDozMEFNIC0wNDAwLCBK
ZWZmIExheXRvbiB3cm90ZToNCj4gPiA+ID4gT24gU2F0LCAyMDIyLTA4LTI3IGF0IDExOjAxICsw
MzAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gPiA+ID4gPiBPbiBTYXQsIEF1ZyAyNywgMjAy
MiBhdCAxMDoyNiBBTSBBbWlyIEdvbGRzdGVpbg0KPiA+ID4gPiA+IDxhbWlyNzNpbEBnbWFpbC5j
b20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPbiBTYXQsIEF1ZyAyNywgMjAy
MiBhdCAxMjo0OSBBTSBKZWZmIExheXRvbg0KPiA+ID4gPiA+ID4gPGpsYXl0b25Aa2VybmVsLm9y
Zz4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiB4ZnMgd2lsbCB1cGRhdGUg
dGhlIGlfdmVyc2lvbiB3aGVuIHVwZGF0aW5nIG9ubHkgdGhlDQo+ID4gPiA+ID4gPiA+IGF0aW1l
DQo+ID4gPiA+ID4gPiA+IHZhbHVlLCB3aGljaA0KPiA+ID4gPiA+ID4gPiBpcyBub3QgZGVzaXJh
YmxlIGZvciBhbnkgb2YgdGhlIGN1cnJlbnQgY29uc3VtZXJzIG9mDQo+ID4gPiA+ID4gPiA+IGlf
dmVyc2lvbi4gRG9pbmcgc28NCj4gPiA+ID4gPiA+ID4gbGVhZHMgdG8gdW5uZWNlc3NhcnkgY2Fj
aGUgaW52YWxpZGF0aW9ucyBvbiBORlMgYW5kIGV4dHJhDQo+ID4gPiA+ID4gPiA+IG1lYXN1cmVt
ZW50DQo+ID4gPiA+ID4gPiA+IGFjdGl2aXR5IGluIElNQS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IEFkZCBhIG5ldyBYRlNfSUxPR19OT0lWRVIgZmxhZywgYW5kIHVzZSB0aGF0IHRv
IGluZGljYXRlDQo+ID4gPiA+ID4gPiA+IHRoYXQNCj4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+
ID4gPiA+IHRyYW5zYWN0aW9uIHNob3VsZCBub3QgdXBkYXRlIHRoZSBpX3ZlcnNpb24uIFNldCB0
aGF0DQo+ID4gPiA+ID4gPiA+IHZhbHVlDQo+ID4gPiA+ID4gPiA+IGluDQo+ID4gPiA+ID4gPiA+
IHhmc192bl91cGRhdGVfdGltZSBpZiB3ZSdyZSBvbmx5IHVwZGF0aW5nIHRoZSBhdGltZS4NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IENjOiBEYXZlIENoaW5uZXIgPGRhdmlkQGZyb21v
cmJpdC5jb20+DQo+ID4gPiA+ID4gPiA+IENjOiBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+DQo+
ID4gPiA+ID4gPiA+IENjOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29t
Pg0KPiA+ID4gPiA+ID4gPiBDYzogRGF2aWQgV3lzb2NoYW5za2kgPGR3eXNvY2hhQHJlZGhhdC5j
b20+DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtl
cm5lbC5vcmc+DQo+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiDCoGZzL3hmcy9saWJ4
ZnMveGZzX2xvZ19mb3JtYXQuaMKgIHzCoCAyICstDQo+ID4gPiA+ID4gPiA+IMKgZnMveGZzL2xp
Ynhmcy94ZnNfdHJhbnNfaW5vZGUuYyB8wqAgMiArLQ0KPiA+ID4gPiA+ID4gPiDCoGZzL3hmcy94
ZnNfaW9wcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDExICsrKysrKysrKy0tDQo+
ID4gPiA+ID4gPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gRGF2ZSBoYXMgTkFDSydlZCB0
aGlzIHBhdGNoLCBidXQgSSdtIHNlbmRpbmcgaXQgYXMgYSB3YXkNCj4gPiA+ID4gPiA+ID4gdG8N
Cj4gPiA+ID4gPiA+ID4gaWxsdXN0cmF0ZQ0KPiA+ID4gPiA+ID4gPiB0aGUgcHJvYmxlbS4gSSBz
dGlsbCB0aGluayB0aGlzIGFwcHJvYWNoIHNob3VsZCBhdCBsZWFzdA0KPiA+ID4gPiA+ID4gPiBm
aXgNCj4gPiA+ID4gPiA+ID4gdGhlIHdvcnN0DQo+ID4gPiA+ID4gPiA+IHByb2JsZW1zIHdpdGgg
YXRpbWUgdXBkYXRlcyBiZWluZyBjb3VudGVkLiBXZSBjYW4gbG9vayB0bw0KPiA+ID4gPiA+ID4g
PiBjYXJ2ZSBvdXQNCj4gPiA+ID4gPiA+ID4gb3RoZXIgInNwdXJpb3VzIiBpX3ZlcnNpb24gdXBk
YXRlcyBhcyB3ZSBpZGVudGlmeSB0aGVtLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gQUZBSUssICJzcHVyaW91cyIgaXMgb25seSBpbm9kZSBibG9ja3MgbWFwIGNo
YW5nZXMgZHVlIHRvDQo+ID4gPiA+ID4gPiB3cml0ZWJhY2sNCj4gPiA+ID4gPiA+IG9mIGRpcnR5
IHBhZ2VzLiBBbnlib2R5IGtub3cgYWJvdXQgb3RoZXIgY2FzZXM/DQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFJlZ2FyZGluZyBpbm9kZSBibG9ja3MgbWFwIGNoYW5nZXMsIGZpcnN0IG9mIGFs
bCwgSSBkb24ndA0KPiA+ID4gPiA+ID4gdGhpbmsNCj4gPiA+ID4gPiA+IHRoYXQgdGhlcmUgaXMN
Cj4gPiA+ID4gPiA+IGFueSBwcmFjdGljYWwgbG9zcyBmcm9tIGludmFsaWRhdGluZyBORlMgY2xp
ZW50IGNhY2hlIG9uDQo+ID4gPiA+ID4gPiBkaXJ0eQ0KPiA+ID4gPiA+ID4gZGF0YSB3cml0ZWJh
Y2ssDQo+ID4gPiA+ID4gPiBiZWNhdXNlIE5GUyBzZXJ2ZXIgc2hvdWxkIGJlIHNlcnZpbmcgY29s
ZCBkYXRhIG1vc3Qgb2YgdGhlDQo+ID4gPiA+ID4gPiB0aW1lLg0KPiA+ID4gPiA+ID4gSWYgdGhl
cmUgYXJlIGEgZmV3IHVubmVlZGVkIGNhY2hlIGludmFsaWRhdGlvbnMgdGhleSB3b3VsZA0KPiA+
ID4gPiA+ID4gb25seQ0KPiA+ID4gPiA+ID4gYmUgdGVtcG9yYXJ5Lg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gVW5sZXNzIHRoZXJlIGlzIGFuIGlzc3VlIHdpdGggYSB3cml0
ZXIgTkZTIGNsaWVudCB0aGF0DQo+ID4gPiA+ID4gaW52YWxpZGF0ZXMgaXRzDQo+ID4gPiA+ID4g
b3duIGF0dHJpYnV0ZQ0KPiA+ID4gPiA+IGNhY2hlcyBvbiBzZXJ2ZXIgZGF0YSB3cml0ZWJhY2s/
DQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgY2xpZW50IGp1c3QgbG9va3MgYXQg
dGhlIGZpbGUgYXR0cmlidXRlcyAob2Ygd2hpY2gNCj4gPiA+ID4gaV92ZXJzaW9uIGlzDQo+ID4g
PiA+IGJ1dA0KPiA+ID4gPiBvbmUpLCBhbmQgaWYgY2VydGFpbiBhdHRyaWJ1dGVzIGhhdmUgY2hh
bmdlZCAobXRpbWUsIGN0aW1lLA0KPiA+ID4gPiBpX3ZlcnNpb24sDQo+ID4gPiA+IGV0Yy4uLikg
dGhlbiBpdCBpbnZhbGlkYXRlcyBpdHMgY2FjaGUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiB0aGUg
Y2FzZSBvZiBibG9ja3MgbWFwIGNoYW5nZXMsIGNvdWxkIHRoYXQgbWVhbiBhIGRpZmZlcmVuY2UN
Cj4gPiA+ID4gaW4NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IG9ic2VydmFibGUgc3BhcnNlIHJlZ2lv
bnMgb2YgdGhlIGZpbGU/IElmIHNvLCB0aGVuIGEgUkVBRF9QTFVTDQo+ID4gPiA+IGJlZm9yZQ0K
PiA+ID4gPiB0aGUgY2hhbmdlIGFuZCBhIFJFQURfUExVUyBhZnRlciBjb3VsZCBnaXZlIGRpZmZl
cmVudCByZXN1bHRzLg0KPiA+ID4gPiBTaW5jZQ0KPiA+ID4gPiB0aGF0IGRpZmZlcmVuY2UgaXMg
b2JzZXJ2YWJsZSBieSB0aGUgY2xpZW50LCBJJ2QgdGhpbmsgd2UnZA0KPiA+ID4gPiB3YW50IHRv
DQo+ID4gPiA+IGJ1bXANCj4gPiA+ID4gaV92ZXJzaW9uIGZvciB0aGF0IGFueXdheS4NCj4gPiA+
IA0KPiA+ID4gSG93IC9pcy8gUkVBRF9QTFVTIHN1cHBvc2VkIHRvIGRldGVjdCBzcGFyc2UgcmVn
aW9ucywgYW55d2F5P8KgIEkNCj4gPiA+IGtub3cNCj4gPiA+IHRoYXQncyBiZWVuIHRoZSBzdWJq
ZWN0IG9mIHJlY2VudCBkZWJhdGUuwqAgQXQgbGVhc3QgYXMgZmFyIGFzIFhGUw0KPiA+ID4gaXMN
Cj4gPiA+IGNvbmNlcm5lZCwgYSBmaWxlIHJhbmdlIGNhbiBnbyBmcm9tIGhvbGUgLT4gZGVsYXll
ZCBhbGxvY2F0aW9uDQo+ID4gPiByZXNlcnZhdGlvbiAtPiB1bndyaXR0ZW4gZXh0ZW50IC0+IChh
Y3R1YWwgd3JpdGViYWNrKSAtPiB3cml0dGVuDQo+ID4gPiBleHRlbnQuDQo+ID4gPiBUaGUgZGFu
Y2UgYmVjYW1lIHJhdGhlciBtb3JlIGNvbXBsZXggd2hlbiB3ZSBhZGRlZCBDT1cuwqAgSWYgYW55
DQo+ID4gPiBvZg0KPiA+ID4gdGhhdA0KPiA+ID4gd2lsbCBtYWtlIGEgZGlmZmVyZW5jZSBmb3Ig
UkVBRF9QTFVTLCB0aGVuIHllcywgSSB0aGluayB5b3UnZA0KPiA+ID4gd2FudA0KPiA+ID4gZmls
ZQ0KPiA+ID4gd3JpdGViYWNrIGFjdGl2aXRpZXMgdG8gYnVtcCBpdmVyc2lvbiB0byBjYXVzZSBj
bGllbnQNCj4gPiA+IGludmFsaWRhdGlvbnMsDQo+ID4gPiBsaWtlIChJIHRoaW5rKSBEYXZlIHNh
aWQuDQo+ID4gPiANCj4gPiA+IFRoZSBmcy9pb21hcC8gaW1wbGVtZW50YXRpb24gb2YgU0VFS19E
QVRBL1NFRUtfSE9MRSByZXBvcnRzIGRhdGENCj4gPiA+IGZvcg0KPiA+ID4gd3JpdHRlbiBhbmQg
ZGVsYWxsb2MgZXh0ZW50czsgYW5kIGFuIHVud3JpdHRlbiBleHRlbnQgd2lsbCByZXBvcnQNCj4g
PiA+IGRhdGENCj4gPiA+IGZvciBhbnkgcGFnZWNhY2hlIGl0IGZpbmRzLg0KPiA+ID4gDQo+ID4g
DQo+ID4gUkVBRF9QTFVTIHNob3VsZCBuZXZlciByZXR1cm4gYW55dGhpbmcgZGlmZmVyZW50IHRo
YW4gYSByZWFkKCkNCj4gPiBzeXN0ZW0NCj4gPiBjYWxsIHdvdWxkIHJldHVybiBmb3IgYW55IGdp
dmVuIGFyZWEuIFRoZSB3YXkgaXQgcmVwb3J0cyBzcGFyc2UNCj4gPiByZWdpb25zDQo+ID4gdnMu
IGRhdGEgcmVnaW9ucyBpcyBwdXJlbHkgYW4gUlBDIGZvcm1hdHRpbmcgY29udmVuaWVuY2UuDQo+
ID4gDQo+ID4gVGhlIG9ubHkgcG9pbnQgdG8gbm90ZSBhYm91dCBORlMgUkVBRCBhbmQgUkVBRF9Q
TFVTIGlzIHRoYXQgYmVjYXVzZQ0KPiA+IHRoZQ0KPiA+IGNsaWVudCBpcyBmb3JjZWQgdG8gc2Vu
ZCBtdWx0aXBsZSBSUEMgY2FsbHMgaWYgdGhlIHVzZXIgaXMgdHJ5aW5nDQo+ID4gdG8NCj4gPiBy
ZWFkIGEgcmVnaW9uIHRoYXQgaXMgbGFyZ2VyIHRoYW4gdGhlICdyc2l6ZScgdmFsdWUsIGl0IGlz
IHBvc3NpYmxlDQo+ID4gdGhhdCB0aGVzZSBSRUFEL1JFQURfUExVUyBjYWxscyBtYXkgYmUgcHJv
Y2Vzc2VkIG91dCBvZiBvcmRlciwgYW5kDQo+ID4gc28NCj4gPiB0aGUgcmVzdWx0IG1heSBlbmQg
dXAgbG9va2luZyBkaWZmZXJlbnQgdGhhbiBpZiB5b3UgaGFkIGV4ZWN1dGVkIGENCj4gPiByZWFk
KCkgY2FsbCBmb3IgdGhlIGZ1bGwgcmVnaW9uIGRpcmVjdGx5IG9uIHRoZSBzZXJ2ZXIuDQo+ID4g
SG93ZXZlciBlYWNoIGluZGl2aWR1YWwgUkVBRCAvIFJFQURfUExVUyByZXBseSBzaG91bGQgbG9v
ayBhcyBpZg0KPiA+IHRoZQ0KPiA+IHVzZXIgaGFkIGNhbGxlZCByZWFkKCkgb24gdGhhdCByc2l6
ZS1zaXplZCBzZWN0aW9uIG9mIHRoZSBmaWxlLg0KPiA+ID4gPiANCj4gDQo+IFllYWgsIHRoaW5r
aW5nIGFib3V0IGl0IHNvbWUgbW9yZSwgc2ltcGx5IGNoYW5naW5nIHRoZSBibG9jaw0KPiBhbGxv
Y2F0aW9uDQo+IGlzIG5vdCBzb21ldGhpbmcgdGhhdCBzaG91bGQgYWZmZWN0IHRoZSBjdGltZSwg
c28gd2UgcHJvYmFibHkgZG9uJ3QNCj4gd2FudA0KPiB0byBidW1wIGlfdmVyc2lvbiBvbiBpdC4g
SXQncyBhbiBpbXBsaWNpdCBjaGFuZ2UsIElPVywgbm90IGFuDQo+IGV4cGxpY2l0DQo+IG9uZS4N
Cg0KQXMgeW91IHNheSwgaXQgaXMgdW5mb3J0dW5hdGUgdGhhdCBYRlMgZG9lcyB0aGlzLCBhbmQg
aXQgaXMgdW5mb3J0dW5hdGUNCnRoYXQgaXQgdGhlbiBjaGFuZ2VzIHRoZSBibG9ja3MgYWxsb2Nh
dGVkIGF0dHJpYnV0ZSBwb3N0LWZzeW5jKCksIHNpbmNlDQphbGwgdGhhdCBkb2VzIGNhdXNlIGNv
bmZ1c2lvbiBmb3IgY2VydGFpbiBhcHBsaWNhdGlvbnMuDQpIb3dldmVyIEkgYWdyZWUgMTAwJSB0
aGF0IHRoaXMgaXMgYW4gaW1wbGljaXQgY2hhbmdlIHRoYXQgaXMgZHJpdmVuIGJ5DQp0aGUgZmls
ZXN5c3RlbSBhbmQgbm90IHRoZSB1c2VyIGFwcGxpY2F0aW9uLiBIZW5jZSBpdCBpcyBub3QgYW4g
YWN0aW9uDQp0aGF0IG5lZWRzIHRvIGJlIHJlY29yZGVkIHdpdGggYSBjaGFuZ2UgYXR0cmlidXRl
IGJ1bXAuDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
