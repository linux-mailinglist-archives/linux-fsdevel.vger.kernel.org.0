Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC7730683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFNSBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFNSBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:01:32 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD99C7;
        Wed, 14 Jun 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686765691; x=1718301691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=B1A0loi2Iyxx3BEijlSgejiFuLufX0pq/2+YJp7CC1tE+67Y7r9hXCYG
   4fM5oOTgVaMg+5Hn4yfB5h3OWoQmeH4/wOfEx6aqTeIUrsDsOxFkiaG/0
   QYWrT/fUJ13yRGoPINqav5YTYmN7hx/XvcbqKiTnzsfEoP2EZxtqYxrzO
   ctGSJ1KZsaWu/Xi5x4O9Q1ClqM3w3Q4Vicc/uIsuFyGBDCpj7bb/jIs/e
   OxB91HUt59Q/KQIt4aAZJNNJUg2rt07+u+jWyojiY8oX0zU5lV55FG23v
   Ac+XlN+/9vMj26Ew9ROJn+eXuBOubN7bnl9Pdn8PS/owP97VoeZA+copT
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,243,1681142400"; 
   d="scan'208";a="347250428"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 02:01:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWFEXUNqhv+jvNOMLpYLEihtHjLzBBzy0tNz18noXUdjAsvEi36m23cp6PfuF7DF2vy5WUVd9UVEs14x4oqnHHLR8BYJ1F3xA5+iM5kdzamkWrsPkjj8bRmPEhkSI14s4YhvYSxQDQYJDaN57vpNGqZlxrTN7+nkQvKJ2kw9NxG9c/XtPP8liKecn26TiwYqC7Les/PyijbFXu37Yr/rETAKl5r60ADuiYgHxDLdRCOkwYXz6/9vAhg0GjJGlLiMeT/ha2p2N3oRKW3cKC7VQ9j3We85kNT1Dznr1WaHgOOFgOnE+t7bsYNVRbtO/VkYwx6beYa0+QQ046kzEgr0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=l3ivcNqW5Z+ItnMbX5xZat8wXu7qduKbTi1X5fwQG2WIaa2QI4NIva7q+3at8gqT3J4ocfxZmWh71XqPhgmMSsIfno4LYfqVkA5x537ytkTup9X+VenG6+ML20KIhoN9gytjp8LxSHJP+Zzn7bZCsMEXwYDFqA6NP/K1lLVQsc6KM76pwcpG9wtIAQO+3q+wFIqmlPKc83aU9qefoY58URggLvEidW+OUPi8iSM4A1PRZyAdCSphKr1R5zH1PZPyqfaQcXucjpc/8IvjTtkcfYHjPjw2zY3oakOsbzlEhdGZZFAZj0aCDTr+Q2zXSRG0n+4WM68PJaJnjbbS87F5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nsExw7kjraxNAtBaXa5WELQBFj9nzDbajvtx7NqEWHiXjG4OnEZq2ttAXCegalUxt6opWn5XkcvXdEujZf3sVBO9oTAAfvNGe7+Iy5ZG/EJOWryec2bJfIDf8kFSUL/EnQoxHRKAx0z3dVkjnMpfWI4Zdr/1ZIein3ZZaO29aBY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7797.namprd04.prod.outlook.com (2603:10b6:8:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 18:01:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 18:01:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/4] splice: simplify a conditional in copy_splice_read
Thread-Topic: [PATCH 2/4] splice: simplify a conditional in copy_splice_read
Thread-Index: AQHZnskZFdxPvYhhREGr3SKFi9V0uK+KluiA
Date:   Wed, 14 Jun 2023 18:01:28 +0000
Message-ID: <f870906d-7510-399b-fa85-6bc1ac3c9123@wdc.com>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-3-hch@lst.de>
In-Reply-To: <20230614140341.521331-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7797:EE_
x-ms-office365-filtering-correlation-id: 79b2acde-77f6-4c4c-20ea-08db6d016083
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4bexHusQ1gnj/K9BRzeZV0ye1fB9Y4ptjR8fzy8KBIJC/R/UwkRFP7ogG+BJy6/Rx6+5IrmyBt115R/MvkCfwQBsvmCNAbEeygrl5Fsv0nK11kzE+ismiuLLe5DU0DLulpXHbqB7LUQO48D6Snz15wMDXvTuZabFjVsDeudp/HUtWKyg5QruzuR3sce3p8txzhokAzXcqBzQrIdm2I5vTKTmdKJXyFFBtmEHsO6K27HAguDAf8HdiQO9TDIoRfL5GiSSsWvtuvZHAjYyB5ooPt63622gEIIMuOh2vtC/M3SctoJTbrcdf2gA8yFJ3nXl0E3OTHWBGqBWh5ZPz57BDlZs2VtEPqZAG00kS3mkxQO3jbmA0xtL42fy9uv+p//5HSIvTgZTh1OQSWKWoaEkraeUs0+U0TqOdnVCDOUr49QF5ui6ooFvRI8sCOI0N7OB0J2ZnpPV/OGcFCKaImHJh6YgsaW/VG6DHCvn+8lVCBxQAhB4HlR9hilbdJaIQ32e4Pr6M6wNF9FSma07lpfslIoYU35CoMIjowf6JKsZlbqVG9ZXjhPuyO7aIFyK0ZQMxxWQ4XIV30xd9GiOnRp5fauDorLQvq1FQ7RH1JGp/PFaasDOllDmI5+Hxs9l+mtjFSCkEJobLTNaTfNqBMYtpGYIABEUktZNLfcKBXz7LrrIWdHkO3MWoHHBeKvzkIpv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6512007)(186003)(6506007)(4326008)(2906002)(66556008)(66446008)(76116006)(91956017)(66946007)(19618925003)(64756008)(66476007)(558084003)(31686004)(31696002)(4270600006)(2616005)(86362001)(36756003)(82960400001)(6486002)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(38070700005)(122000001)(110136005)(54906003)(71200400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVE5RHRCcm81eGdyUE05SXQwRGloNDBXSGRneFZPcyt4K2kyZDhtRGwrRWdx?=
 =?utf-8?B?c0xMd3FWSjlBdExyamtKc0NPQnV0NURLcHJqMzlmcVlzaTFaS0QzWU9kMVhZ?=
 =?utf-8?B?TkUwOS9HU01Ma0VtV0x2Sy96SnJhejdoNVVubzRwNjErNEsrTHRuUy8vRUtu?=
 =?utf-8?B?dUVEMmo1RTVReWVHYkg3NGtjZ1FmQTd3ZkprcnZLUWtrTnJnY0dMbVYwZmph?=
 =?utf-8?B?VzBhNkt5dWpicGcvcXJJam5IUEJ1MDJLdEw4RXBPdzU2bEpZeGpObjR2V0ZL?=
 =?utf-8?B?RlcrUjhJQUxOV0t2eDQ4cml0akhaOHp1cUJvVDF6Q01ZcXVDWU1laTVHKzBP?=
 =?utf-8?B?T1VIY2J3MWFSUlBBZ0ZpNnFPZzRrYnd6a3pBekRQNUNXd2FvMmp0NDQwOCs2?=
 =?utf-8?B?c0RRR0I2cnM5ZkZmTnljcys3MVgzV3RrYjB1Vlo4N1dsZmxVVy9QLzgwbTdO?=
 =?utf-8?B?ZzROMGNrTFZzamx0VW45T1Yzd0E5c0p3OURsTUZaOFA0NlR5Q2ttNHEvajJ1?=
 =?utf-8?B?Q3lLV0VaYk5aeDlFTmFacmgvRG1XeFNHbTBwdVRkbjVlVXVOYjhoT3l4b3ZX?=
 =?utf-8?B?bzR0UkZvRjd1ZndGWW11dDhlTldBOVRYK1NOMFBxVzFTMWY3bHNnV2thTDMy?=
 =?utf-8?B?enBRQnRpV3dKbUdwY1FxTm4rS0FscGg4OTlEOVFYbVRGaXNnRnJRbWtLcVNk?=
 =?utf-8?B?aWk0YUVtSzh3cU1GQ3RSKzhOTHp6S25zMGxFNXpRaXRqeEwxOTUxdHhBTTBG?=
 =?utf-8?B?U3dGR0xiY2x3OGtRWFJGdVB0ZEU3MEd0UExSd2tMTG1RMS8yV3Zyc0NTRGp3?=
 =?utf-8?B?Vm9Dc0F5ODNmVGRTeXR2VWZxS0Q1aGpiRE5Vbi9JeXpCKzFKRXZUU3JpdUxH?=
 =?utf-8?B?TGR5cjhlemVTTkNiYkhnWTFBZHAzMDFpUjlwaFNKdkZEOW03WldiSlJCenpL?=
 =?utf-8?B?SFZZQ1dLaFBxNVpRZVZvZGVJMUwwcDVSNDV1ckVCWDJvMUdEbTZ0d1V1aUpE?=
 =?utf-8?B?WmJiQnhOVkd0VnlkUnN6ZjZabWF1UkZMNXFQS3cvYjNYQ0ZnNTFJdmJreXhu?=
 =?utf-8?B?cHUyTXFDUDhsaTU3bG5GSjZ5RGFTVHljektpZ0o2YnFZNnIzdlhsTnExK05L?=
 =?utf-8?B?WEd3Z24rQ3owM25hRmlGaUpkZCtqeWhiaElzN0NkWVB2TnNBRmhHN1F3aWU3?=
 =?utf-8?B?YzVtelAzeXp1alFzd0hseG42c05wa0ZxR0U2SjQ3SmRKc2wvblJhOE1QL0Zm?=
 =?utf-8?B?RzVmT0lWOXlCeGo5MXRwc1lqSjZBRWJHY3FlaWNqVXMzWVlwWUhKUEptMk50?=
 =?utf-8?B?NG15Uit6dEhYdktCTXEvRlpjWE9TWUtCczJlN2VHRXFrdXNQZ2FuSnhWTHMz?=
 =?utf-8?B?enhvb3VzTzNsOS8vRGdRUjdIeVFUeGNRUy9EVEI5RVZSUFl0ZUZYbEhONzdk?=
 =?utf-8?B?T2w3UTJRZEdNVWhHZmliK3FORVhweFQwZUlOcnk2SGJBTWVmUklvM3ovczJM?=
 =?utf-8?B?OTYveW80S1lCZTN3NUNSZmFiSWZReUtWUFBBd3RETENOaHFkZ0xvWDFkb3F0?=
 =?utf-8?B?QUJ1aDRmWEtKZ1d2ODdaWjlyRHBDbUJVR2lIR0FONTVvSDhRS0FPcDNIcDQv?=
 =?utf-8?B?OERtL05KTGFPd1IzU25LcjRwMlhMUWlnWTNZZzFQUVZCcnJESmpjTnRuUGEw?=
 =?utf-8?B?QTl0ZjdaRU0vSkhFbGM5VDFrZG5CNVZ3U0FWdzFRZkZ3L1FhOWphT0Ivd2RH?=
 =?utf-8?B?dVErUFU1aXcxT2cvQzBXbEVTRVJPdkZEekE5cW9nYjhmbkJuVUNPR0ZuQ0tF?=
 =?utf-8?B?Q3p5eVBiYWdLaVpob2h6QTI1K1ErSkRYQVlpZ3RkTHVoNW9XamdKUnpZOWFE?=
 =?utf-8?B?TXFzejcxWUlHOVg1aW9LWlh3MFllbFMyY2xjQjh3Yld4OEZUcWppRzNNV1Ex?=
 =?utf-8?B?blBoam1TVWxZK3Yra2FLM0dsYkhYSFB6RElJWkVyLzAzRGdnZmtnd0VJQ2Zs?=
 =?utf-8?B?UFpvUjBRWml6a2dzL3ZkSVZYa2dXT0ZuSkVhdlJKcGFzdnBwaGJjTmZrWVpk?=
 =?utf-8?B?YTN3UTRnQWlVaUpSVHZiZ2RnNmNOL2ZMWXFiMitBNko1UGVzaThYdmFwdkt0?=
 =?utf-8?B?OWg4SG1hcUNLRC9yZmNidDdTb2J1Si9GWWttWk4yYXZHY3dIbGtxWEd2NWZY?=
 =?utf-8?B?R1B6ZkNkZGVjUmF0UlhneWFZeE5VYVNMWHlvcDdkVGtCRldLYVlTWTFGcXoy?=
 =?utf-8?B?VTNrZ1QyTHFWdXdvdlAyK0FrUHRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A0177557B964448A39E8226A56FDBBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ffMr/RB2rZgDU3SauZPxnOyp7RtbE3LY8ksXuhndOjkbUVI284bMD/MP4WpZuC5LYmnWgh85NwB+AS3TRv/g8PP0y5NrTeN/QxKjKCKVEzc0mQE5zanQDKdTO2xdlsviIm3G0MFGe92XD90Y72156axlEn5cvkSbEx/dFLddhbRMqr+QOfvavPfd6lfFLaYJa8UO8b8dm9sUuoJmb27gRJkqZ08rVSLBEjxwTq6OGrkrtCKYrsctxk8CLVFN6e6rEidd3XsL9cdIxEbkF9yFyS88peTSaOhi7ZVU595Yg+dRVKnpdhNFt2DkQ8yILwR67P9RmIHmzsxOFf0ObBzlU0Ac/3CjNEVhOmeiLQfgWJ88+8dENF26uhKR0oOboC8n/bh3GHtfptAmecr6lQ7GlhGjN/GlT6752y3fWwxMzhzYt7i3KFUFh/ip2TUBpAT+A6osqYLO22ehcmxpY2ZGJkM+cDypHUTn094wj6HxNJZ9dCFImnYxLonVbMffnZFAzJUcsrVrGis9T8ZmVRsaD5kqRjF7CATd4X+M5k0lZLwU1KHp5QQGdCvvsGNP1OuRePULSgOrBgpcMeP1ieKLcxV0JyXtCVG3r5tepesML6i9XNyIxPq1/rld0DXeQV/UucEFtHqKQVPdHUOCRr2qGGn2hSUhn8RUKE9Hfhw2hsiO9XNInua7eFL5nIMXZz4n1hc48QOsfJgqvvW/knE67tSVP9DB34ARinHGxYN+aXB5jr+D1sXO0GSby8o0NBdEe/jpFY+bkPkm4sayWO7GYrenlUdoH2Wsa9k4oo8bBxFyu1T/2cXYuXhamGw+/bJ2ykJv4JCCi/6PS20gZee+RcM4utwu0HuCFh7yW9EQujxl2m9RFFz8VxICfHbcI5O91Ch613epbRr3NzUjIqCF0A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b2acde-77f6-4c4c-20ea-08db6d016083
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 18:01:28.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mi1bUUf1kXqBCBr4c+6K6xSbm9uiDT9SqYbl4d4HWX1R5E57gHTcAkb/G4MuDs2f+JYriwuU3S9r2tl1kfcEAwPzeEp/YPTka9w3ht3Iw00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7797
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
