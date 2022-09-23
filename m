Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29CD5E7C1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiIWNoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 09:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiIWNoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:44:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2117.outbound.protection.outlook.com [40.107.243.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A864139F44;
        Fri, 23 Sep 2022 06:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bChZAANCcS6n1GQbws0rX2hO8jjfIiO5tO5P7Y/P/UoM5chXP2eLlxluWZuXdtRek48pva2vNZWph18aePaNVEEoBiLsvooHHmhk9wHxzytj8xyunL/Gf1scvJicq0oFLN6XtkExNVvG/fjX67EZvEwiahj1AMcTBAmWEakRTiY8tXAo0r8LqFJPPsDgCdfHmG878Inx54Xw5mn5nculTCOHtHWS5NSHZ3LQIEftLFU0Ao7owWM6Zfs477VL9S7YOKUWGOOhg/SacWtzqe1YaieCQn2NZiVjHP5ygztkZOHAM7LsGfYrnbdpz3yBdWvFqBMKb70BWvC0QuWheiU1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trjjDsGTMyaOppxmQ21/iRx8GlxFho4+6y7BguKmi/E=;
 b=dk9WxC54ezytt3p4OOvvT0J8/C4AJ+gZqX7sJNx/IGeYd7NdFd3Jvmh7PcfTVLx2pjA1mnMj6WJ1qfncgtHnyoBIzE0s+kXzU2jETglvG9Tn76GaJpz+SSvHVM4CdqLHjhpkEUL9doKKfcyvlleSvlpYsTQ2iKsIGsaqterf7YDEGSL8XkW+zOZXOdM+hWzFrqyC5eQnkCEZXGGeyKrFluT71YkjRRsi58JdEKWWWDDHhg7LVMKxaTAKQ4ywggIYtbkfjDMjqsgQyLaguXzPJiDlE9SNLZ4FPjmClowlV1GwAUxa2R7yLkjTJUBtH45HzQd6280F/Gd4Ml8z+8IltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trjjDsGTMyaOppxmQ21/iRx8GlxFho4+6y7BguKmi/E=;
 b=e+EtRgcvNKSQvfPLyTQuuQHTO158GbSlmes8fVUVlJZlYWM9gaAABRFicVHXL62AAFb6FrfnpzaTfIpKZFMhuhEBtuzcVLWJEICrRx3N3s+t1SLhGj+Q/2GLHb2krlcyJZPBG39hak3SFdDSLIyt5lA7d3+CLw/HlK/ifj+P0F0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM8PR13MB5143.namprd13.prod.outlook.com (2603:10b6:8:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.8; Fri, 23 Sep 2022 13:44:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::93e4:42a1:96af:575e]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::93e4:42a1:96af:575e%7]) with mapi id 15.20.5676.009; Fri, 23 Sep 2022
 13:44:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jack@suse.cz" <jack@suse.cz>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
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
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAAzmAgAAdFoCAAAvtAIAADJkAgANYaoCAApXgAIAAn+4AgAQd8ACAABFGgIAAGxkAgAARzACAAAYwgIAADquAgAAGDQCAADHXgIAAjpcAgABOzoCAADwjAIADto4AgADfUACAALlzgIAAqj+AgADjjgCAALDXAIAAup8AgADTfYCAAKeNAIAA5MiAgAA/cYA=
Date:   Fri, 23 Sep 2022 13:44:05 +0000
Message-ID: <2d41c08e1fd96d55c794c3b4cd43a51a0494bfcf.camel@hammerspace.com>
References: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
         <20220918235344.GH3600936@dread.disaster.area>
         <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
         <20220920001645.GN3600936@dread.disaster.area>
         <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
         <20220921000032.GR3600936@dread.disaster.area>
         <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
         <20220921214124.GS3600936@dread.disaster.area>
         <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>
         <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>
         <20220923095653.5c63i2jgv52j3zqp@quack3>
In-Reply-To: <20220923095653.5c63i2jgv52j3zqp@quack3>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM8PR13MB5143:EE_
x-ms-office365-filtering-correlation-id: 3d7a560f-9338-43ae-4aa8-08da9d69aef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7C1JKMqH3i3fX80oE7Ch4phDNADAO10CfIdmEmHokW3+MwkcUXQAELY6ny2x+dPK39vAZ3673T39fgYodWfvC7Ar+UMrUlW5692SQRmQK9NzKULqPKkazhQwdqm+3gCo02NEeL6yNTeERIsMBFf0lUzZfai8ieOn1RQWQCABX/uVjtrHMTRuQrL+i0NUJDB/MmxCe7Govo8VZXbmO3GWupyEIt9EoC0xlCG83HhiuvL64RHee3yupII9hInSxJLwVS9Fu0bUfm6CBgqWKoNsFmx/Qe0aCAwiI09VG0xHvB4IDd8py+U/KtqQN4cI9IJ6WLKw4B72a6RWDUGkar50Qa+i5SGYBXg6f6TPj33GCffq0+d0aeopMQaqrAnx8XH4vIfJWJe2MQVpMqM0ZlZdCNd3qU84e1MJLe1ohnn3gBn16M+0xi09UAAi9V/8iSECImllOU5hnMaOxADWT+3546AxvbAdjXR9gyUgHaz1SG2Ayp/zqVZRtFxHwFR7e1Ktq+kNwa/0lxrHct3YZm2sz6f2/eBv/jp5oobaHsPt4rhBOVj32WNJAVhnIRkCripF9aoVJUP3vXG5qqMDzMrW6loaX14QZ6PDxGzW9SglC17G2b7sXz9k69Z9x0tTear9j9wp8CtW6MSPHu+rruwvkiIFBkpLhTjZrDVbkrQTaTKfg71hRdyKnzG0F/3kUobMVTGW0+Q9aBc1NsUpUOIUMHd49gTnvQ2ZF+iYahAL8wC3vEa8IvX/nGMqM3c1zeNuKAP6zu6rSi2/7NEfctEGCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39840400004)(346002)(451199015)(6486002)(66946007)(4326008)(66556008)(64756008)(8676002)(478600001)(66446008)(76116006)(71200400001)(66476007)(8936002)(2906002)(38100700002)(122000001)(186003)(26005)(7416002)(5660300002)(83380400001)(6512007)(2616005)(41300700001)(6506007)(36756003)(110136005)(54906003)(316002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUovc3JUNVJIbHY2RnM2VU1uZlRzTjdrMlZjTS9TQnN2OHB2MXZQMEZiMjlX?=
 =?utf-8?B?a0REVGlCL05SVFFCMDFrRUsvK0Z6ZXZzMDRUc1p3bmJLcnM3L3VkaXF5NmZO?=
 =?utf-8?B?bHFxVlVpTkZHanRhbzEvaHRDaHNDTlZFQnFnbkg5S2l2T0ZTVERCb29zbEIw?=
 =?utf-8?B?UStwVDlZTG1KMWUwYytTRlc2cGNxWTBOMmpFZjBiclducmxnODRzeWRsTjZB?=
 =?utf-8?B?aGtvbExBaWY5RVFZQ0tucFJsVWdYNEpnWmREZ01xcnVBWjh3VzhMZE5nM2Er?=
 =?utf-8?B?VEJMTURrMWQ2WXR1dnBtVFA0cHlOWGdudjJQNEx0TmhmVGx1TmMyL2xKY3lv?=
 =?utf-8?B?aW5oc1FDYjF4b1ZibzJ3ZHExbythYngxSWtVSEJzT0ZPUDVGU3hDMk0zaVVR?=
 =?utf-8?B?RFd2NnF3c3dKR1I5WjlEcyt4azA3NFdLY3hLL2FuZlJFTjlUNUpFbDFaNHFn?=
 =?utf-8?B?L011MXU2U0hjVVRkam05aEhtS1I0VE1xVjl4VkFjK3N1VDhJTk1KY3ZhdWh0?=
 =?utf-8?B?RlpUZEJvUmRjUzdsQ00zdXQwd2RSQjJkSXVJaERHRjlMa1k2ZXhsWnp5TzEz?=
 =?utf-8?B?RHFneVlqcWY1UU93Uk5CN2NIRm1lWW5lSVNZWmdKcXVIb3VTTzV1aWVvbFEy?=
 =?utf-8?B?bnV5dkU3TmNwTTNQTVZydEVxK0FHOFJSU2k1U1JLUGZaTVE1dmVrdS9sWnlR?=
 =?utf-8?B?UUVuYW9PRndnazhhdkVpeTV0RmhHRzVkUllTdHQxcXNYS0NnMnJLNzEyK3Yz?=
 =?utf-8?B?K1pLZ3N6RFZYOVdFbExFVWx6U0RMUUxrMVhnb2xJNmlRSXRrdVR1UHdRQWNn?=
 =?utf-8?B?RDRrT2wzMlZhY3hyY1pOY3NzMm45NHBPUCtNL2lsck9xTldUZlpyaXA5SDNj?=
 =?utf-8?B?NVNNUGdtYi9ocjU4TGdXTEJiZTJ0bVZYeUg3WjNZSGFWb0QrcWF5QWhhc25u?=
 =?utf-8?B?NGVLeWV1YktQNndZcTlGZTR3VlNmTzdPQlk2ejR0ZkNTVlpGM2N4dXVad1gz?=
 =?utf-8?B?TkVVV1c4OTZzUHUvbWtFK3lxOXFaTTU2ZSsrOVUxS0NOSjAvNTU0b0NEUG8w?=
 =?utf-8?B?ZklBWENVbFRFUmxhQlJ1SExsd1JyYUtjQU9samgrNythNEQyVnNWTWpOdk9H?=
 =?utf-8?B?NWlMY2xtVDBxTklqUDdoN3BQbHc3bmFhN2pBTlpDUG5mSWtUYW9mSVNWSHFO?=
 =?utf-8?B?Nk1OeHBqRlRkQ09kNFNjSWM1ck9hYk9xdnFUVENsbmcwcFJwUTRPMVBQbnNo?=
 =?utf-8?B?WVZZZC9TUHdlRmFjL1V2Sllpbm9ZUTJ5QytiSEExelFIcGZtbmJUM2RIdFd5?=
 =?utf-8?B?VWI3MFB0Z1BJZmgrWEs0bEVJaDZXN29NSHJGYzhaSHhMcFd5aEVod0dwZ1E3?=
 =?utf-8?B?SzdycVNLZit3SUV5UUEyUUhtRGN1NmdrQ0Zja2RYZEZ3SlZabzhNNHpiU1pW?=
 =?utf-8?B?V1lSSlJFNFRKWE5JUmI0Z21zbFVpNmVQSVgraE9scjF0UjJLZlovajJBOXNh?=
 =?utf-8?B?cE9WOE9iQXJhVXRrdUtQR2doVEh5bFFMaElPQTRrcmY3SENvQnZyS2oxZjdu?=
 =?utf-8?B?Qk9UclNENFcyZDJYbzJvcWpvd0JUVDExOEFTc0dxQkdOUDlzcVF3VTI2MWpu?=
 =?utf-8?B?aGRYY2ZRRDJsdlVIRHVPU1grNjgyU01IOUlPZEdOTGZZOGx5US8xaUN2SEV3?=
 =?utf-8?B?ajAvTTZPOWVnYlNGVFgyVE9Ed3lKUGNYUmJoVHoyQ2MyWlVJTm5LcWZYRXVX?=
 =?utf-8?B?OXFnZVhVZHFQTGlFNndxOTd5R21STngzK09LbVRUWkVUR0dweVhBWWppN3hx?=
 =?utf-8?B?VENiYmJId3JRSDBHRUpSUEFlSjdNZ3NQWGRtdmpLKzFCWkc0Vk9HTktVZjV0?=
 =?utf-8?B?SlpmK3czT2JZZnNESHh6aWd2Yit6ZnVXdlFKSVJNb1lWbStTRndmcjhlQklC?=
 =?utf-8?B?NnVvSzZsYzZQc0Z6dW1jYzY0dU5ORzlqbjNtUzI3ekZlMTJkTGVHVEpJRnE5?=
 =?utf-8?B?ekpCQUVnaU1ORmZNK1NDQ2ZNSU9QRzFnQkZnTllSM0E0SHpHeVdaclljRXV0?=
 =?utf-8?B?MjlSc1c4WnhrSlRJZ0h4dnlQR25LQkY0WUpHdzJLOEJ2UnNhWjd4SkJ4RWk3?=
 =?utf-8?B?VlNPbmdndzN6c0swcm9ENkhyeDRQMlRwcmgxU2x0Y3gzbnNIOFJ5NXJOdm1B?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC231563EBEA0D4D937A7E89D4BA6B94@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7a560f-9338-43ae-4aa8-08da9d69aef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 13:44:05.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i85Qg2Taee1vgZ8xu70XYijtLt3G9sYfflagSa7Ty3eEygjTVm/H4Zfwxs0EtiIkbaemMGPONu06/qEFnoyWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTIzIGF0IDExOjU2ICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gT24g
VGh1IDIyLTA5LTIyIDE2OjE4OjAyLCBKZWZmIExheXRvbiB3cm90ZToNCj4gPiBPbiBUaHUsIDIw
MjItMDktMjIgYXQgMDY6MTggLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gT24gVGh1
LCAyMDIyLTA5LTIyIGF0IDA3OjQxICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+ID4gPiA+
IGUuZy4gVGhlIE5GUyBzZXJ2ZXIgY2FuIHRyYWNrIHRoZSBpX3ZlcnNpb24gdmFsdWVzIHdoZW4g
dGhlDQo+ID4gPiA+IE5GU0QNCj4gPiA+ID4gc3luY3MvY29tbWl0cyBhIGdpdmVuIGlub2RlLiBU
aGUgbmZzZCBjYW4gc2FtcGxlIGlfdmVyc2lvbiBpdA0KPiA+ID4gPiB3aGVuDQo+ID4gPiA+IGNh
bGxzIC0+Y29tbWl0X21ldGFkYXRhIG9yIGZsdXNoZWQgZGF0YSBvbiB0aGUgaW5vZGUsIGFuZCB0
aGVuDQo+ID4gPiA+IHdoZW4NCj4gPiA+ID4gaXQgcGVla3MgYXQgaV92ZXJzaW9uIHdoZW4gZ2F0
aGVyaW5nIHBvc3Qtb3AgYXR0cnMgKG9yIGFueQ0KPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiBnZXRh
dHRyIG9wKSBpdCBjYW4gZGVjaWRlIHRoYXQgdGhlcmUgaXMgdG9vIG11Y2ggaW4tbWVtb3J5DQo+
ID4gPiA+IGNoYW5nZQ0KPiA+ID4gPiAoZS5nLiAxMCwwMDAgY291bnRzIHNpbmNlIGxhc3Qgc3lu
YykgYW5kIHN5bmMgdGhlIGlub2RlLg0KPiA+ID4gPiANCj4gPiA+ID4gaS5lLiB0aGUgTkZTIHNl
cnZlciBjYW4gdHJpdmlhbGx5IGNhcCB0aGUgbWF4aW11bSBudW1iZXIgb2YNCj4gPiA+ID4gdW5j
b21taXR0ZWQgTkZTIGNoYW5nZSBhdHRyIGJ1bXBzIGl0IGFsbG93cyB0byBidWlsZCB1cCBpbg0K
PiA+ID4gPiBtZW1vcnkuDQo+ID4gPiA+IEF0IHRoYXQgcG9pbnQsIHRoZSBORlMgc2VydmVyIGhh
cyBhIGJvdW5kICJtYXhpbXVtIHdyaXRlIGNvdW50Ig0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+IGNh
biBiZSB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggdGhlIHhhdHRyIGJhc2VkIGNyYXNoIGNvdW50
ZXINCj4gPiA+ID4gdG8NCj4gPiA+ID4gZGV0ZXJtaW5lIGhvdyB0aGUgY2hhbmdlX2F0dHIgaXMg
YnVtcGVkIGJ5IHRoZSBjcmFzaCBjb3VudGVyLg0KPiA+ID4gDQo+ID4gPiBXZWxsLCBub3QgInRy
aXZpYWxseSIuIFRoaXMgaXMgdGhlIGJpdCB3aGVyZSB3ZSBoYXZlIHRvIGdyb3cNCj4gPiA+IHN0
cnVjdA0KPiA+ID4gaW5vZGUgKG9yIHRoZSBmcy1zcGVjaWZpYyBpbm9kZSksIGFzIHdlJ2xsIG5l
ZWQgdG8ga25vdyB3aGF0IHRoZQ0KPiA+ID4gbGF0ZXN0DQo+ID4gPiBvbi1kaXNrIHZhbHVlIGlz
IGZvciB0aGUgaW5vZGUuDQo+ID4gPiANCj4gPiA+IEknbSBsZWFuaW5nIHRvd2FyZCBkb2luZyB0
aGlzIG9uIHRoZSBxdWVyeSBzaWRlLiBCYXNpY2FsbHksIHdoZW4NCj4gPiA+IG5mc2QNCj4gPiA+
IGdvZXMgdG8gcXVlcnkgdGhlIGlfdmVyc2lvbiwgaXQnbGwgY2hlY2sgdGhlIGRlbHRhIGJldHdl
ZW4gdGhlDQo+ID4gPiBjdXJyZW50DQo+ID4gPiB2ZXJzaW9uIGFuZCB0aGUgbGF0ZXN0IG9uZSBv
biBkaXNrLiBJZiBpdCdzIGJpZ2dlciB0aGFuIFggdGhlbg0KPiA+ID4gd2UnZCBqdXN0DQo+ID4g
PiByZXR1cm4gTkZTNEVSUl9ERUxBWSB0byB0aGUgY2xpZW50Lg0KPiA+ID4gDQo+ID4gPiBJZiB0
aGUgZGVsdGEgaXMgPlgvMiwgbWF5YmUgaXQgY2FuIGtpY2sgb2ZmIGEgd29ya3F1ZXVlIGpvYiBv
cg0KPiA+ID4gc29tZXRoaW5nDQo+ID4gPiB0aGF0IGNhbGxzIHdyaXRlX2lub2RlIHdpdGggV0Jf
U1lOQ19BTEwgdG8gdHJ5IHRvIGdldCB0aGUgdGhpbmcNCj4gPiA+IG9udG8gdGhlDQo+ID4gPiBw
bGF0dGVyIEFTQVAuDQo+ID4gDQo+ID4gU3RpbGwgbG9va2luZyBhdCB0aGlzIGJpdCB0b28uIFBy
b2JhYmx5IHdlIGNhbiBqdXN0IGtpY2sgb2ZmIGENCj4gPiBXQl9TWU5DX05PTkUgZmlsZW1hcF9m
ZGF0YXdyaXRlIGF0IHRoYXQgcG9pbnQgYW5kIGhvcGUgZm9yIHRoZQ0KPiA+IGJlc3Q/DQo+IA0K
PiAiSG9wZSIgaXMgbm90IGEgZ3JlYXQgYXNzdXJhbmNlIHJlZ2FyZGluZyBkYXRhIGludGVncml0
eSA7KSBBbnl3YXksDQo+IGl0DQo+IGRlcGVuZHMgb24gaG93IHlvdSBpbWFnaW5lIHRoZSAiaV92
ZXJzaW9uIG9uIGRpc2siIGlzIGdvaW5nIHRvIGJlDQo+IG1haW50YWluZWQuIEl0IGNvdWxkIGJl
IG1haW50YWluZWQgYnkgTkZTRCBpbnNpZGUNCj4gY29tbWl0X2lub2RlX21ldGFkYXRhKCkgLQ0K
PiBmZXRjaCBjdXJyZW50IGlfdmVyc2lvbiB2YWx1ZSBiZWZvcmUgYXNraW5nIGZpbGVzeXN0ZW0g
Zm9yIHRoZSBzeW5jDQo+IGFuZCBieSB0aGUNCj4gdGltZSBjb21taXRfbWV0YWRhdGEoKSByZXR1
cm5zIHdlIGtub3cgdGhhdCB2YWx1ZSBpcyBvbiBkaXNrLiBJZiB3ZQ0KPiBkZXRlY3QgdGhlDQo+
IGN1cnJlbnQgLSBvbl9kaXNrIGlzID4gWC8yLCB3ZSBjYWxsIGNvbW1pdF9pbm9kZV9tZXRhZGF0
YSgpIGFuZCB3ZQ0KPiBhcmUNCj4gZG9uZS4gSXQgaXMgbm90IGV2ZW4gKnRoYXQqIGV4cGVuc2l2
ZSBiZWNhdXNlIHVzdWFsbHkgZmlsZXN5c3RlbXMNCj4gb3B0aW1pemUNCj4gYXdheSB1bm5lY2Vz
c2FyeSBJTyB3aGVuIHRoZSBpbm9kZSBkaWRuJ3QgY2hhbmdlIHNpbmNlIGxhc3QgdGltZSBpdA0K
PiBnb3QNCj4gc3luY2VkLg0KPiANCg0KTm90ZSB0aGF0IHRoZXNlIGFwcHJvYWNoZXMgcmVxdWly
aW5nIDNyZCBwYXJ0eSBoZWxwIGluIG9yZGVyIHRvIHRyYWNrDQppX3ZlcnNpb24gaW50ZWdyaXR5
IGFjcm9zcyBmaWxlc3lzdGVtIGNyYXNoZXMgYWxsIG1ha2UgdGhlIGlkZWEgb2YNCmFkZGluZyBp
X3ZlcnNpb24gdG8gc3RhdHgoKSBhIG5vLWdvLg0KDQpJdCBpcyBvbmUgdGhpbmcgZm9yIGtuZnNk
IHRvIGFkZCBzcGVjaWFsaXNlZCBtYWNoaW5lcnkgZm9yIGludGVncml0eQ0KY2hlY2tpbmcsIGJ1
dCBpZiBhbGwgYXBwbGljYXRpb25zIG5lZWQgdG8gZG8gc28sIHRoZW4gdGhleSBhcmUgaGlnaGx5
DQp1bmxpa2VseSB0byB3YW50IHRvIGFkb3B0IHRoaXMgYXR0cmlidXRlLg0KDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
