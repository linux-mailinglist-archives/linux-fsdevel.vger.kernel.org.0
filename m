Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9735B1175
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 02:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIHAmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 20:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIHAmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:42:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1838DA61C4;
        Wed,  7 Sep 2022 17:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMVk1MTHrFnxrplwHZc776FVkfY9uVj3z6n2XtvDxh7t8t+XFAbm5QTlBfIdLS/kRLPoI3k59UVTn/Ka0kz26GtdWEAT9HXiYKNHjoi2w5LO++cukDzxYhHrBg1g32KwoF8P+A2kYr4PoD/QpUEX5PiJeu7gSQxGHjnwnE1pG2dmnLVU66i7uEpsJtAT1jcgGyWEjp4Tz8e4jYooWw1xCStF3phSDwJzCrfsYflAbiJSv9V22XXTkY/n5hncdScmKlOfIEcdka0kEwHq87CubtVh7g1bMGIspi005fry4H3NsBI1l3cikLCRAs3ZxzYe9arQwGKtXkea5AqtKfC9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlnDQrCUasGeR+g2qmo1VAPD4DTUwD59+fFrxuHMBO4=;
 b=nzY7HJ9Uxigq87PzOIIxTmBDGc8dCuAlxvnWcQhuiOLsUpBaOVB8pVzFAvOVS1mQSn1cffrTOy4pLeK9jZH4dTw2CKv2melFGTYIb/cmsCTYcBl/rBYPsfuTOIQJcn4YlmZyb79dVjKg+KHRlsOlPk9n6zkRnSh3tWncpAlr17iE1ISDrMbURUfPuI0nNZ4ggfN4nQQJxn+Sxmu0UZ54npWDP+u1JWRLnWkMes+CYOteBkjgJWgKygPgjWlbqfBWGFqMXtbor4DLDv3AcsRSke1yIXeK+IaK9L/sECDYEibOErlJRqhfDTIyncHZTJjZ7t4a3DGbVmWx1bwx/fc9Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlnDQrCUasGeR+g2qmo1VAPD4DTUwD59+fFrxuHMBO4=;
 b=ODoKpfsdvQ/ZjO4dwVs365hjkXDgpcpHy9WxAtzGlIz3rqG+XJ5Y25ZIs4DbL67C0eirZacgRQ+KV11woioxAWQpbXCc4L+RA/o6uu265Snh9jT4sQK9jewQrqOi6GNds8tKZrcg9PmJaR+G8nPM/2sfQiOL9LMwzniaktBG++4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO1PR13MB4856.namprd13.prod.outlook.com (2603:10b6:303:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 8 Sep
 2022 00:41:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 00:41:58 +0000
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
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAL3gCAALG5AIAAAwUA
Date:   Thu, 8 Sep 2022 00:41:58 +0000
Message-ID: <9f8b9ee28dcc479ab6fb1105fc12ff190a9b5c48.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org> ,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name> ,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>    ,
 <20220907125211.GB17729@fieldses.org>  ,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>    ,
 <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
         <166259706887.30452.6749778447732126953@noble.neil.brown.name>
In-Reply-To: <166259706887.30452.6749778447732126953@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO1PR13MB4856:EE_
x-ms-office365-filtering-correlation-id: 309b48d1-d647-49f4-615d-08da9132efdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wt2A4OoR0R9alMcYdYdCcy6uoVHwu5qCJX8UPQkBSFmZJsy+2G8RjF31qhs42U3Qm5m6iAsrE8V+SdGCA+z3ERDVTqrPZsMU/zGRLFU+W9HFTVsafJQ0AeaE/hzbprlnEQoCrhSt2OgONdQ32txDrATfdOhLDZHFXJVriQCcVWOelm5xcwJajVr/7OtlCC1B8ENJ+5WVRvoLK0iMmEafdLIxP3OHboO4gaO3EfnKSqUZVNqNOGz0X8qiD+q+fWnTjJ0ssyPdvaWliOUzkxP1MfB0rHS8te1ZqWgfHT7JZHBt+RA9PDNO8GRGc4EUbc/xLt0sgxayTgX85+YlFEfRaMmgT5EpdJ+erUeUQKxMpIg7elAXqqHIN34SgxsIr5+mOHXLx454yrBo60E1NiqFRpIQHA7EfU6Or7OazHF6gngRcg7op8vfAtZCUwoMDXJMUtuEVboaQG1WDVTKTYiMJA9vcKRbY026AkGELZkrxruM2oiP7rH9KnMwPWW2FoMWqTrhEUbh+1MfwTIUlnoWxxyavt9GbslbKeStw3EPsvSnhWvx4zaUIMy3An8UzZYPwyw7BTrTFjuK9ACCqUtTX/ExraYbcHh48YLTn0j5FnL5zuPb+WXGaAef/GgxyUoD5winr7c6dPD65cOsGzVdlUG9bYOFT4OQ4x007Gs0mZUrSIVkaLAOea8EJDO4qspfteP/8nHnY8s7tkydPR8LaiMA4aT8ECtHN9eYEWLBiqjwQR3wmafadXWkWa8HJ2t6IyWb2wXuzm5C5RKUAtu2tW0BtSmE32R9BhL4CCBivsh/eU9bIV2sW1xXIOmXJyHp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(39850400004)(136003)(186003)(83380400001)(66556008)(71200400001)(6486002)(478600001)(4326008)(64756008)(8676002)(66476007)(66946007)(76116006)(2616005)(6512007)(36756003)(41300700001)(6506007)(26005)(86362001)(38100700002)(38070700005)(122000001)(66446008)(8936002)(316002)(6916009)(54906003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEpyZW81UWpBVVBlRVFCVEZDTXBNdFcxZnRLNGl1bmFHQmlVZzZQUUJwVndI?=
 =?utf-8?B?Rlp4d3NLYUhCVFAvTGE0WXBhdXB4aW1kTTNxZmNJVjNweCsyYWR5QU1sMFUz?=
 =?utf-8?B?SE8zeXlub2F4a1I0VXRVSFpqdmNWeXBvR0tXYmhZVCtyRUh1cmV3NWtqRzhi?=
 =?utf-8?B?UWl4cm5SODZ1ZmV6Z0kwbGc5NVdFUmdadXFsdWxOVVBicTlTV24yWWpSOGh2?=
 =?utf-8?B?TktVaC9Sd1BRRUt6S3JlMTR4NzMzWmk2dWtVQThjblR6Ly90dHRqbUwrSGN4?=
 =?utf-8?B?dXVWTEtyU3p1elk0T3RZRC9QVHlYQkEzT0FWZWI4WERneGVIMXphcmJDVFJW?=
 =?utf-8?B?djV1blNKQzlxU21LdXFoRUcvRmlGc1hFN0hyL01TZHlyVS9jNWpIaWp6QVNa?=
 =?utf-8?B?ejJZMEJBY0R6MEsrcUJLZzVacGlJSkRmemU0S0dUQ055RGZBMU92SE15ZndC?=
 =?utf-8?B?aUMveXhDUElQNFRXWjRGVHdMMEZhNURBeVFMaE90dEwrWURyYk1ZUEEySmZk?=
 =?utf-8?B?L2tzeFFmSEdabW1WM2g5U3dKRTBTcTBVU2JDTjBnQUlEYUVFdnB0a2Z4Z1dW?=
 =?utf-8?B?cXFhRVVQNDFQY3J0WGZBb3dVNGF3WEU2bGpNdS9PWWxjTmFRMjF4Z21CN0dT?=
 =?utf-8?B?Q1NWb0NxZGVFb3V6LzYyZDdDVnl2SnZvZ1NzRHQvb1BvRzB0blhQenp1WURn?=
 =?utf-8?B?WmY0QnN3eU5yNG16dzl1a2trRll1aUY1SW5xaTZkaFVVUStQbWcvWUh6RXlH?=
 =?utf-8?B?Unk5dDJBRnJudnNCa2pmOURIdTZsMkJ4YkNkRXl4dHhLemMvY0VkeFNtVEc0?=
 =?utf-8?B?dFFhcDdXcXVETTdhR2NFanRuQVBQdEJibnVXaTZPbko5T3NOZ2V2K1VaU1cz?=
 =?utf-8?B?SkpjZENRckp2bmVRNkcvRytsM3lLQlQzMHUydzlWL2xRM2xwSGRNaVl1di9z?=
 =?utf-8?B?cGN0QXNsZnRuVHVmRXpjeTVHKzJ5U0hUQlA3R3NoNS9VSnd3cHg4ekJSNGhX?=
 =?utf-8?B?WkV5TUtDRWpaa0UyYk52c29ndWxrLzVwR0FleWF3WXdKQ1l3bEJTaHRGcEtj?=
 =?utf-8?B?M0JqQWMwb2ZVWkZsYldaZWx2aHBicEJrOTNmdkYzUTh1M2QrUDR6YTJtMlpL?=
 =?utf-8?B?TWpicjJVL2NnMkF6WGlZU1c4YmhaNEd1Y2VGRlowdW1GUHRKYXFXb0NoL2xo?=
 =?utf-8?B?cjhZdVJLM3NFNUdUVE54T283UFF6aFFZY3VNVVl0Y3VHVHRaVVJ4blVRL3hD?=
 =?utf-8?B?RExwb2xiUlhYalFyOWtlanhsVmN1QWptWEJRYzNPalhMclpSR3hmQWV0aDZh?=
 =?utf-8?B?ZjluU01rRUJGa2x3UGpyN2hncDNTdzFzd25MdEMvc3pGUTcwcEE4ZkRkM1JC?=
 =?utf-8?B?Nys3V1MyRnhvK0k4cmpNVTRTa002TmFBVkdsSUVaaEEvMmpObTZBckh6RmN1?=
 =?utf-8?B?d0ErS2tHeUc5Ylc5TmVEUnhIeEwxOWhhbXNGOVM5aXB6eWZyekNpVkdxUGZh?=
 =?utf-8?B?Q2JTMnc4a05BSkJLVlpwc2QyOWZMREJPU3JTSTlMOWZDaVc0a3BkOGtNNWVZ?=
 =?utf-8?B?T2tQZjA3Slp6L0tITEpzN0piVlpuVXNtWkkzeFJKWkhabk1hNHNFL1BBQ2FF?=
 =?utf-8?B?b0FMbVEvSFkzVkVxQjU2NVdQS2s4U0w3NmZFS2NNQzRjS0Z6VkJ0Z3BXTlpG?=
 =?utf-8?B?UndwcExVcGoyZG5HeFRmRis2UEtFSHJMV3lMSld1dFQwZE5aTlNEd0tNSUQ2?=
 =?utf-8?B?K2s1Vzd2bkdqV2hBam42UmJTamtMMXJiSzY0MWI5Y1NGdmFUeUM1L29MZkxy?=
 =?utf-8?B?dXlJbURKNnlHbDB4aHhRK3ZMbk81eExJaUd2NXlMclRGQlo4ZG5FK2FnMEsw?=
 =?utf-8?B?ZzArTm5Fd2Z3emtpMUtpUFZJWW1BQzZ3c3FKZG1oZ2lnbG1tc0p6dE9UUXNt?=
 =?utf-8?B?RHdhUnIyaFk1VFVvSGZ6WDVoUDFiUko4ZVN6QU8yMjY0Zy9ZNmZoSmR4R1Jr?=
 =?utf-8?B?d3RRMnVraWpTTTc5bUFjWnRYc2lOWkNjaVN1clJQOXpJODVSYnFnTkh2OU1w?=
 =?utf-8?B?ZFlFOUx0RGZndW5ST2dSRnkrVWpRRG1qanFHRU9ScmtFNXVhSTM5K0t2d3ht?=
 =?utf-8?B?Qm8xQXFiT2U5czJYSTBGbWtvd3lzMDk3Y096bm1xL0xBOSt0K0ttRUV3RUc4?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEF6BF1228D61A438FDD8CCF21F04013@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTA4IGF0IDEwOjMxICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMDcgU2VwIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MjItMDktMDcgYXQgMDk6MTIgLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gT24gV2Vk
LCAyMDIyLTA5LTA3IGF0IDA4OjUyIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4g
PiA+IE9uIFdlZCwgU2VwIDA3LCAyMDIyIGF0IDA4OjQ3OjIwQU0gLTA0MDAsIEplZmYgTGF5dG9u
IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFdlZCwgMjAyMi0wOS0wNyBhdCAyMTozNyArMTAwMCwgTmVp
bEJyb3duIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gV2VkLCAwNyBTZXAgMjAyMiwgSmVmZiBMYXl0
b24gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ICtUaGUgY2hhbmdlIHRvIFxmSXN0YXR4LnN0eF9pbm9f
dmVyc2lvblxmUCBpcyBub3QgYXRvbWljDQo+ID4gPiA+ID4gPiA+IHdpdGgNCj4gPiA+ID4gPiA+
ID4gcmVzcGVjdCB0byB0aGUNCj4gPiA+ID4gPiA+ID4gK290aGVyIGNoYW5nZXMgaW4gdGhlIGlu
b2RlLiBPbiBhIHdyaXRlLCBmb3IgaW5zdGFuY2UsDQo+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4g
PiA+ID4gPiBpX3ZlcnNpb24gaXQgdXN1YWxseQ0KPiA+ID4gPiA+ID4gPiAraW5jcmVtZW50ZWQg
YmVmb3JlIHRoZSBkYXRhIGlzIGNvcGllZCBpbnRvIHRoZQ0KPiA+ID4gPiA+ID4gPiBwYWdlY2Fj
aGUuDQo+ID4gPiA+ID4gPiA+IFRoZXJlZm9yZSBpdCBpcw0KPiA+ID4gPiA+ID4gPiArcG9zc2li
bGUgdG8gc2VlIGEgbmV3IGlfdmVyc2lvbiB2YWx1ZSB3aGlsZSBhIHJlYWQgc3RpbGwNCj4gPiA+
ID4gPiA+ID4gc2hvd3MgdGhlIG9sZCBkYXRhLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBE
b2Vzbid0IHRoYXQgbWFrZSB0aGUgdmFsdWUgdXNlbGVzcz8NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IE5vLCBJIGRvbid0IHRoaW5rIHNvLiBJdCdzIG9ubHkgcmVhbGx5IHVz
ZWZ1bCBmb3IgY29tcGFyaW5nDQo+ID4gPiA+ID4gdG8gYW4NCj4gPiA+ID4gPiBvbGRlcg0KPiA+
ID4gPiA+IHNhbXBsZSBhbnl3YXkuIElmIHlvdSBkbyAic3RhdHg7IHJlYWQ7IHN0YXR4IiBhbmQg
dGhlIHZhbHVlDQo+ID4gPiA+ID4gaGFzbid0DQo+ID4gPiA+ID4gY2hhbmdlZCwgdGhlbiB5b3Ug
a25vdyB0aGF0IHRoaW5ncyBhcmUgc3RhYmxlLiANCj4gPiA+ID4gDQo+ID4gPiA+IEkgZG9uJ3Qg
c2VlIGhvdyB0aGF0IGhlbHBzLsKgIEl0J3Mgc3RpbGwgcG9zc2libGUgdG8gZ2V0Og0KPiA+ID4g
PiANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWFkZXLCoMKgwqDC
oMKgwqDCoMKgwqDCoHdyaXRlcg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC0tLS0tLcKgwqDCoMKgwqDCoMKgwqDCoMKgLS0tLS0tDQo+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpX3Zl
cnNpb24rKw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXR4DQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVhZA0KPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXR4DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1cGRhdGUg
cGFnZSBjYWNoZQ0KPiA+ID4gPiANCj4gPiA+ID4gcmlnaHQ/DQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBZZWFoLCBJIHN1cHBvc2Ugc28gLS0gdGhlIHN0YXR4IHdvdWxkbid0IG5lY2Vzc2l0YXRl
IGFueSBsb2NraW5nLg0KPiA+ID4gSW4NCj4gPiA+IHRoYXQgY2FzZSwgbWF5YmUgdGhpcyBpcyB1
c2VsZXNzIHRoZW4gb3RoZXIgdGhhbiBmb3IgdGVzdGluZw0KPiA+ID4gcHVycG9zZXMNCj4gPiA+
IGFuZCB1c2VybGFuZCBORlMgc2VydmVycy4NCj4gPiA+IA0KPiA+ID4gV291bGQgaXQgYmUgYmV0
dGVyIHRvIG5vdCBjb25zdW1lIGEgc3RhdHggZmllbGQgd2l0aCB0aGlzIGlmIHNvPw0KPiA+ID4g
V2hhdA0KPiA+ID4gY291bGQgd2UgdXNlIGFzIGFuIGFsdGVybmF0ZSBpbnRlcmZhY2U/IGlvY3Rs
PyBTb21lIHNvcnQgb2YNCj4gPiA+IGdsb2JhbA0KPiA+ID4gdmlydHVhbCB4YXR0cj8gSXQgZG9l
cyBuZWVkIHRvIGJlIHNvbWV0aGluZyBwZXItaW5vZGUuDQo+ID4gDQo+ID4gSSBkb24ndCBzZWUg
aG93IGEgbm9uLWF0b21pYyBjaGFuZ2UgYXR0cmlidXRlIGlzIHJlbW90ZWx5IHVzZWZ1bA0KPiA+
IGV2ZW4NCj4gPiBmb3IgTkZTLg0KPiA+IA0KPiA+IFRoZSBtYWluIHByb2JsZW0gaXMgbm90IHNv
IG11Y2ggdGhlIGFib3ZlIChhbHRob3VnaCBORlMgY2xpZW50cyBhcmUNCj4gPiB2dWxuZXJhYmxl
IHRvIHRoYXQgdG9vKSBidXQgdGhlIGJlaGF2aW91ciB3LnIudC4gZGlyZWN0b3J5IGNoYW5nZXMu
DQo+ID4gDQo+ID4gSWYgdGhlIHNlcnZlciBjYW4ndCBndWFyYW50ZWUgdGhhdCBmaWxlL2RpcmVj
dG9yeS8uLi4gY3JlYXRpb24gYW5kDQo+ID4gdW5saW5rIGFyZSBhdG9taWNhbGx5IHJlY29yZGVk
IHdpdGggY2hhbmdlIGF0dHJpYnV0ZSB1cGRhdGVzLCB0aGVuDQo+ID4gdGhlDQo+ID4gY2xpZW50
IGhhcyB0byBhbHdheXMgYXNzdW1lIHRoYXQgdGhlIHNlcnZlciBpcyBseWluZywgYW5kIHRoYXQg
aXQNCj4gPiBoYXMNCj4gPiB0byByZXZhbGlkYXRlIGFsbCBpdHMgY2FjaGVzIGFueXdheS4gQ3Vl
IGVuZGxlc3MNCj4gPiByZWFkZGlyL2xvb2t1cC9nZXRhdHRyDQo+ID4gcmVxdWVzdHMgYWZ0ZXIg
ZWFjaCBhbmQgZXZlcnkgZGlyZWN0b3J5IG1vZGlmaWNhdGlvbiBpbiBvcmRlciB0bw0KPiA+IGNo
ZWNrDQo+ID4gdGhhdCBzb21lIG90aGVyIGNsaWVudCBkaWRuJ3QgYWxzbyBzbmVhayBpbiBhIGNo
YW5nZSBvZiB0aGVpciBvd24uDQo+IA0KPiBORlMgcmUtZXhwb3J0IGRvZXNuJ3Qgc3VwcG9ydCBh
dG9taWMgY2hhbmdlIGF0dHJpYnV0ZXMgb24NCj4gZGlyZWN0b3JpZXMuDQo+IERvIHdlIHNlZSB0
aGUgZW5kbGVzcyByZXZhbGlkYXRlIHJlcXVlc3RzIGFmdGVyIGRpcmVjdG9yeQ0KPiBtb2RpZmlj
YXRpb24NCj4gaW4gdGhhdCBzaXR1YXRpb24/wqAgSnVzdCBjdXJpb3VzLg0KDQpXaHkgd291bGRu
J3QgTkZTIHJlLWV4cG9ydCBiZSBjYXBhYmxlIG9mIHN1cHBvcnRpbmcgYXRvbWljIGNoYW5nZQ0K
YXR0cmlidXRlcyBpbiB0aG9zZSBjYXNlcywgcHJvdmlkZWQgdGhhdCB0aGUgc2VydmVyIGRvZXM/
IEl0IHNlZW1zIHRvDQptZSB0aGF0IGlzIGp1c3QgYSBxdWVzdGlvbiBvZiBwcm92aWRpbmcgdGhl
IGNvcnJlY3QgaW5mb3JtYXRpb24gdy5yLnQuDQphdG9taWNpdHkgdG8ga25mc2QuDQoNCi4uLmJ1
dCB5ZXMsIGEgcXVpY2sgZ2xhbmNlIGF0IG5mczRfdXBkYXRlX2NoYW5nZWF0dHJfbG9ja2VkKCks
IGFuZCB3aGF0DQpoYXBwZW5zIHdoZW4gIWNpbmZvLT5hdG9taWMgc2hvdWxkIHRlbGwgeW91IGFs
bCB5b3UgbmVlZCB0byBrbm93Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
