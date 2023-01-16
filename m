Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9366BD1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjAPLqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 06:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAPLqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:46:12 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9C10FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 03:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673869571; x=1705405571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I3z+vJbZfwoTzdcIkaUlmP5TmRe6Xg0nJGCsgDN8vi4=;
  b=BIn51XicVMlU1EhTM3A70k29eqV/8rox5gktayPvVrj8lkVANMTlM3eH
   MGVOPYFgp5XvaBJqxZa16uUk+GuXnESJrstnxxmng/zlI7xbX724kk9pg
   j4JHk2ch4N/PZh5VvtSclxVsqucN/N7FFhRSUyibCOelFh7SdTTHSn/Ws
   /W0HiBug7RIfddxc9cBMiqC9v6u444qaL8Ahmlr8sY/Hc4mrod14IMbyk
   FaZ5RuDU2yefLUTwr3bzL+0IbMQIqHZIP8kNx8NVWtrqLH9Lr6vdCkO9k
   r/G6gNh6fYuDsjdxrJM9QJJwa2960s6vkkd3iI2KfrBsFsJXtT0exdz7Q
   g==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="332917326"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 19:46:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0nq4VmTZarwMFs89npxjmEMGW8+wN24DqU8zGtBWuBVLQBE3cByYjf8kBPSObYZIcqHEWwCK6+U67SrfewAELmoifZdQjB5I+/+Blx0iJ9+BnMWGATi6r/pKl5Ib5aIRu23Y8VHbD9M4L1UdV6g+lxv5gabFx+DbAHjOOZ4RPHIf8Nz8dGWOzPoRdsj35wci/c9Qbz/3znMG+YktsaXq9HC/o3OJ4qoMmcc6Wcg/1YyGhrqswldxt+d/G4z8x0AiewJdW23Dolxv2Pq+PRI0wOiUvVvTZ9I0+o7aKCJf4PFvjgSHQbrBIWo4ElFJylIKTsrRfRA7G06nIaXpCqnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3z+vJbZfwoTzdcIkaUlmP5TmRe6Xg0nJGCsgDN8vi4=;
 b=dljUo7pA4kGTkZXUmWAMhGNcs7kOlGmJUvly38Y+TboB5xAQ6mfFqoKx8YJX0BPcL6UoKGz+sVdiehQwbKFiy8t4yYm6tk0hFX/oKlVHkqW1Mof9aGUI4LH0zc4oo/7U0111aHuFd+OhXIQ5HIe3IJq9tUn6zySjOTfLeaYxAhJYduoGxI26ltyf2p/HMFaK9za160/JXlhVx4xWOZHZdZv3oiv+vy3AWuIDK9SmBD7KufXS7ndahYA1PKwuiZj0MqZpDZs36Ojk4DRD8z8aOmQk6satlGSvs8RQskEiIV8eFQu+3r1O7LWviwIlVBerEyCKGjeAEWTe/Z9/hNuD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3z+vJbZfwoTzdcIkaUlmP5TmRe6Xg0nJGCsgDN8vi4=;
 b=umh2GVxnxmYKQlXZMDxebbEIwrl3DXKmYDYSdByQx68kmza36RZj237gwcKa/WNsUxDOrUPZ2S9GE0Uu8RN2XBzNKo/ppdCE2DYhT3N7QrrcwsFkYYJg5DEP4Kqbvj1xqZF+fXVOKKsXhrWa07302WqHOxaq8skMvd737q+ibf4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6357.namprd04.prod.outlook.com (2603:10b6:a03:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 11:46:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 11:46:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 6/7] zonefs: Dynamically create file inodes when needed
Thread-Topic: [PATCH 6/7] zonefs: Dynamically create file inodes when needed
Thread-Index: AQHZJPSsIl+DO/BKyUWYVlx+/qlg0q6g9lOA
Date:   Mon, 16 Jan 2023 11:46:07 +0000
Message-ID: <18550dcc-41c9-f417-c0aa-b28bd5695ffc@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-7-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230110130830.246019-7-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6357:EE_
x-ms-office365-filtering-correlation-id: 225364de-c9f1-4002-f859-08daf7b741bd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qBIKT9CbuoIvaMPjDynKjfCQDkEByLYd9XzCG1BzbCINEdH+irSt1zpVNiszIRjLGySuSBb66dvjgGxkwiHRd7LLnX1hXWqeGMA7wy0BptDF+TRItfz6xB/jmbPaib9OmEWRWQFNaoX49+hzsiCwl47F2PwbeAspvsxzJSH0GlPfQ6lyv5WdMigjZqLiTOO4rRGmpOGCh8R5UW97jKxu+bEDG7nS1jx40BT77AA0y1BX0S6sLUb+4HxK2+B2SFKRN1ziik9rO2vXmKGuU30NH4u8WyOuLW92V8pIWG37WJpCVS38loezckWWnr4JI1/0rryZD2BM2S0bPfa2h3XKHydo1m9xwnbeEnNuZskxsuB1NbPkSnis6926U2Wa1o9Mrq1KeOUzVABhdwTNVenLyJfhkln/BMxsqLq7LpYbC0tzPUOyHvL6BfCGBE7rrD1SZDJ89uiklHUqVed4trpFBpeL/45kaAZ6ZgkIKq61GGK7vffbwNRLFnvtbB6B4/hKkAVtfS7fgQD5bpgYnLQCWgv0YmRyZXN13xu/enjs45ua/z1oUIBlX4pU8vBv3mEg1hERGMgkhkiBdbHgqUEi4CJhQ1HlVbMyOyOSnxPh4e+x9mjn5TMMA5BuooXOdiMK9t9Itccs2K8Y+aXZEF4twGpJSX8zyghmHmlfYgeQynpemDVVLWnP6QnI2FC0EilFzdq/8Q0ripnrfeMauJkQd08pgSsw+8ipze+fv9krBEQzrjuuRqBA2IjkyxMvSqrufhtW9qX7UCBrs2BymvnPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(38100700002)(122000001)(2906002)(82960400001)(53546011)(5660300002)(2616005)(38070700005)(86362001)(71200400001)(8936002)(26005)(6512007)(186003)(41300700001)(558084003)(316002)(31686004)(4326008)(66446008)(91956017)(8676002)(64756008)(66556008)(66476007)(478600001)(6486002)(31696002)(76116006)(66946007)(6506007)(36756003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2Z0L3hhTkk4SXJVL3Vadnp4QXJRU2VuRVhwV1krcEpHRkh0b245ZnJHWkxq?=
 =?utf-8?B?cEdOVW5XOFBxbjRYaTQ3dkppT0JoMUF3UDhhZm1mWUkxbG1SN2pqK3V2NUdJ?=
 =?utf-8?B?RDFBaGNIaFhGcUU0TXlma0xLUlJQdlhuUmlEOVBFSW9WZ0sybm1LY2ZRZ2NW?=
 =?utf-8?B?L3lqQ3kxQjBXTzIvWXVlS3A2SmpYRUhOZ0lrNXZSaDYyQjhKc0x2ZDgrOTZt?=
 =?utf-8?B?S2hHOFFVTWVwZk04MjE4THJpUmpwNVdORDlXZkxLMnRXUk5tSkpjWXR6U2c2?=
 =?utf-8?B?OUs2VENsN3pERkRENmJmNkpuNW5lR2FuZmUyUWZaWWVXdzIrZCtublh0NFph?=
 =?utf-8?B?bmFKYWFMQzluUnVlM3ltSlVlUmRsckEyVVQ4R1dNVk9sRFlTNUNDS0p0QkVs?=
 =?utf-8?B?MW9sa0dwOGNDcVlwS3djZE0zdzNqaFB4TDRhOElOMmJCLy9uKzF2Q21RazZ5?=
 =?utf-8?B?cWtScER3UzFWWjVUZkttdUxhazhPNWlCVkxjMzdVaXc0SXBIRElLRmNCN0t2?=
 =?utf-8?B?RXBVbDZyOUJ6Uml2c2wwS1hlNklwOGdsTUZsdGl0bGE1OHMwT0t6SEkwTUFC?=
 =?utf-8?B?Wm1vcnNkQ3pSbVJnNEN5SVozU2IzMEtETHNzSkFPMzJnRnM5NW50VitYTTFu?=
 =?utf-8?B?Y2N1U2RWYzh5cGtKM3F3SFBxWU1yL0JEaWZYckc1OUl2aVF2V0Q3L0NFTXBp?=
 =?utf-8?B?THoybUttb0NkR3NKNjVvVVRpVFBzaGt2WjhkMCtlWmRtSEpmWUk2cXoyTVlS?=
 =?utf-8?B?WmYreW9ybkdzQ1NEdDlsSFZ3a3BYY28zV0lVazRSYU8xOGN2b2lWZk1CUVZ0?=
 =?utf-8?B?bXg0QmlTNWhjQkJRRnpHRDZRclN1SFZkTjREZHNHQTB5bGFFbWErRjQrOTVr?=
 =?utf-8?B?WC9Jclk5R3ZzVFAxV3ZsK0N1cld3NldpdzRlVjRLSWsySUN3bndiUWlzUEhy?=
 =?utf-8?B?V0ZocklSSEJiUzZwWFRjbGxiaUJsNDRsRm1DaUdnb3J4VWlXY21HMGF2MjZP?=
 =?utf-8?B?bU4vWGNoUmwzR2xzT25tdkVHMFRDWnB3c3hLRU9kRzB2TmJJVVI0SlpXb3pZ?=
 =?utf-8?B?K2NjeThlK05JMmlkdGhGQWRrSklkbnF6MlYzSzBRbU5DNGZpdVpoM01GUTBt?=
 =?utf-8?B?TStaSnpONjAxWEdCVDQvQ0R1QTZVcCtyR2liVy85cnk4SHdpK2k5b1k3emdu?=
 =?utf-8?B?VnF2aFJsdnNTeTJhVkk5ZDgram1UZzJ4T0ZFdmRnVENkN1M2a3hDMERTajNw?=
 =?utf-8?B?dTdzYzRlL0JWYmErQmNNOEs5bXF2a3E3YmpzbmNaMUg1ZzVBOUFvajhlS0ly?=
 =?utf-8?B?VXFsMnpjckVEYm13NnhsZWNidnE2cW00ZmF5UW1CRXJkZE9WMmpxOEVRcFhF?=
 =?utf-8?B?aldpMm5TVGc0S1hNYmxRV0ZHLzBpRS9CSGFDSXBBaHpGZTVmVStrTkN0c3lM?=
 =?utf-8?B?bHplNm9jNlVZQjgvaTNNMktteldacnBOTW5lbHNXREpHVUViQ2FCb3ZsQW5Z?=
 =?utf-8?B?aEdYZ05sVlNVYlRYcm5WTTVFTThPcmYwTXlUSEVhRzhCZ0o0N1E3ZGhkRzlI?=
 =?utf-8?B?Ui82ZHFCc1orckFoeE9zTVRMNGJmdERmT29qYnFvZ0pWcUtoTGV1RlZsNjkv?=
 =?utf-8?B?SE1PbzNDeXNFZE01QkFXRmJ4bENVQ3dZZUpGMDN4bFhqUXEwZTZKUlJZdXBL?=
 =?utf-8?B?ZWpZVUxPL3Z2SkJRbGZIcUZSWUQrUUkzN0w3dUJvajJEOXRVMVBiWHNFY2RT?=
 =?utf-8?B?a05Sb3ozR3RuYzBmVWVtcEpvNE9TeG5sTytUU2M3RUV1ZkhqWStMUDNuR2w4?=
 =?utf-8?B?TCtrMHFuTEVIYkR2bGYxd0FNY3lsM3JhSFYrcHYreUU1dXhGTGY0MUREaWll?=
 =?utf-8?B?MVUyVFk4ajdRUkJmay9pSGpBd2N2dG5yU2JnY3kvcFdTYUJ4SDdXc29sL05S?=
 =?utf-8?B?RmNVYU9BdzlkMlJFV0VKMzV6QUFxekxrR0V0MWs0T0QxaXM4bXQxMFZPb2Zs?=
 =?utf-8?B?c2FBdzk3QW5pU2I5S0FNRjdFdWs3UUU5TEdyTkpZbEQ1VGlsdFM1dkFHakc1?=
 =?utf-8?B?Qy95ditaMkdnbUEwOE01bTFmNEpNQU41VENZU3hzU3pTN2Q3N284bUtPT3p4?=
 =?utf-8?B?MnBXQys2Wjgyd0ZCSVN3WmtxNm9ubUpUdm9DNmJubjJMUWt1b01IcEo4RXEv?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1802099E443FD40873D0EE943837B28@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sl4BiurUfK281QOhLb6kwto89XnDZVesGpzzywsbl0ZNd88mZzPLP1XC7ZPp//XQnQCLB/ZGkEYQp5zWAFXn85mlCOmFK+ejfyergKRJnC+Z8eBxfjUskvA65lXadQZNYQWzb0Ryi9WVddmndFKRLKRqxRG5h2uB4yoATCOHFfHoXarHzQ38iB66sBrDEzOjHRkA5F5ejLojJTlDqyc8+jy1P0PMI/3h5KGEavtcCg6CZr9i44hYiFA+aYNQb5UB4rsU4DsNKCOieuixqH+/5Vu0xQgp2q94NCEUF/tvBgaah5hLlB7ZBvDs0U4CGXtIHYJ4t5Kaot82hG0yBcczP7GIekWX+Wrwbpz0i4zlqXi3PrlYk5petLUI0O6fkTn2LNC3s4Jj4jyaHK4wZDA5/YKS6ul/YlMIqVSYu6dkLWcFiZJ7mFfHXrJ6XDYkryADLqPdNmeSNFwEJJWB550rFuRsSMnVf9acO0o10HCrj01jqOKEgS0teTV8eve4aU+qCe7ySE6WnD+1O+Dn+gfHhA7ynkZhxej/db1UO2lXLsElXEckCXVTj7MKnbHMHb7MP17bv4bC/oDrXWn86yXJELvLfq49ZjuxRNAN6XjEpCppkYNk8CHHbADkzhsCIeQuOIs/QH2O8yltbtaWWHE2QaX90GU72n6R00/hRhw5+FyJBbbBg6xdGIayLNmo7s4Uoz7uj3XPTdsXN6Axpn7JScJADBIF5mwry6J5LXZfAhDYJ197cEfX3qeC07NUA3paZMTzHnGADCIT6uuyap5Khey84NKyqF65aWF7xWXFO4Y=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225364de-c9f1-4002-f859-08daf7b741bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 11:46:08.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AOx/h1Mv4dAvgleLmzzwlxlrlyEzrihm1at8zyJkt+BJBbitAst5fzj75jGqxg7rRv8YqQyCfRueEqbi53utQjVWqz2t8Ftx22ROzZZvz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6357
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAuMDEuMjMgMTQ6MDgsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBJbXBsZW1lbnRhdGlv
biBvZiB0aGVzZSBmdW5jdGlvbnMgaXMgc2ltcGxlLCByZWx5aW5nIG9uIHRoZSBzdGF0aWMNCj4g
bmF0dXJlIG9mIHpvbmVmcyBkaXJlY3RvcmllcyBhbmQgZmlsZXMuIERpcmVjdG95IGlub2RlcyBh
cmUgbGlua2VkIHRvDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERpcmVjdG9yeSB+
Xg0KDQpPdGhlcndpc2UgbG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hp
cm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
