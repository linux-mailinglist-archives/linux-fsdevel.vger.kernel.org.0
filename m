Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217FD746C49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 10:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGDIsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGDIr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:47:59 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD0B115;
        Tue,  4 Jul 2023 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688460477; x=1719996477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=R+2z+sDSDikgtXavgdkbkQVWtEYVzsliJ6uZnm1UPuFizBzwMoU+SHJJ
   yghktfpI7jnQlEAyrTxqFWuMPWCHGVnhx+gMbekgEqgSBKXscLA2EhICt
   /Iy2o1nnmM4JfliK7pNANvjAqLLO3yqVAyqeOOjXQq0w4sXQSSoHVyW9L
   E9DU2CbJ0b00OmHta5DtWIUVk6HL858uxBXCJewXTovOsXgmcTPFONyXV
   /4i+KMsErYpsuJEJluxiQMsRrmTCIYD/kUs0nmRyvfogWPlulVYggfXbd
   yZS5iW4q3lOaZs0teMANQDllNS25h30GboiSULNCGnANpe5WWH5ooE5Xy
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="241839276"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 16:47:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIvQZ5q0EAucULMSnNXw+ny8P9z3XuDu6R2X3Su1ZAs2x2sM51wSR6id72snlkU0mWNou2fIOjJpTPnnPYvRovw/J1DR2VEGlNZIvqR7pNCc29Qx83vAsBlq7wfmKhoJK/23H65cjBmokeN0X3PZOfVnQTYLtSrtW4B4IwDf5TQputpkLsVeDx/1LorhlEuYA3quDBWrb91CaGMjB8IVP2CUdVc3s5iVuFdeu4Vdj4vkZY7mdrEIDDDkjWh7JX3hCgd0j+e6IeqSPsb6QCswiFYiQtwA6OLscEzgmT9D6Tkh2O1jTvRNu7drNUqijdFU+J/w91UKuX7RI7ab7C/Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=c+Zlr705h2hm2kQCjRxihE4zGX0P6sod+Lo40iRPFbF68URwmSNVU+AIAozz858mtWPfdvo4QGzRlFqJzy0yPRD6DsHGrQoIHl6E1CBi/cpYx5lIA1ClXdCgaEEcFZO2vf/8FYSy7ujGH3nGUNIBy2+rGVZ+b+iwnbit5ZVU6my22sI8xQNte7LQ1sAY+QOM9etQemgXR9m3toSTiSAdMG9qR2OffTr7BY4PYlMnKzGxypGbANIrl9dFJ67n7y5UFzOxlMsLji0+sWbnPOFyYDHyAge9QXtTqRMhKqhCwBX/MGhHDampuqiwrWyADrqEKhYHSC2ljiQbJDS/CbWVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Bem2YR2rIa7WGth2HPSTYPvZqjlfF5zsWwGtExhD3qvFy1I0wASwCmlI6gAnOdvRBYeAX5m27QVMltM23TN2HlKpFK+kgbLEq5TmSx+Tkz2OFva86smbxFjzzD6W2WYN2OCHmL6bBcfPmRfcRgIDngkc31FiK7ZRVD3Lcv0VDQY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8976.namprd04.prod.outlook.com (2603:10b6:510:2f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:47:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:47:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/23] btrfs: pass a flags argument to cow_file_range
Thread-Topic: [PATCH 01/23] btrfs: pass a flags argument to cow_file_range
Thread-Index: AQHZqdY41jaO6ohQVEa1x/R7FdiQe6+pVMSA
Date:   Tue, 4 Jul 2023 08:47:54 +0000
Message-ID: <1f07f973-a355-2164-fb8f-9bffc577c4b7@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-2-hch@lst.de>
In-Reply-To: <20230628153144.22834-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8976:EE_
x-ms-office365-filtering-correlation-id: fc17edff-07a7-41d8-9e5c-08db7c6b5ba8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5J7SAmQgHJ0klM8wDj9W99A1oR2cR5nb1vHoCBosHjrJb4/A7JOKuWF+riOGIKGpO8isAK1EcRzvm/FhKLepH2VJxMGFI2vMhqKH18f6ExExl0JuAc+IslUhRkVscHzuw6k5n0/zbmUVAUjVdNRNmetsqcEeg4hXS+w98LnP8OHCFBWqhK1X3k4lkL3HK9/dnJH+3a42/RhXitupL+HZOly9IR6kWoUB+m6wXpPXOYEpIJJMq1FU0i10yMxyrzicB3JTkmFibGk9/RTBocyg48WsDAuQysaSgpLA7/MJsCW2J9NEjk+jwY5cpxdf7rUgMZ0xopPr0WI4+lC608Usyto7P2KojL/rENXaK/aEa5uVgAOKcLQLitnSeWP0GW4jXumS9JAgOOZ/fqXdMDdcCczg5mvnFMuBpa6JxkZ4lEOG2hOnqPL1s+flpXQIalni5WxGU1y2K89X6M2Fmt5LQaQE3BEGtBNjI826rX1+xhgAEeEZIvdNqTbJ2jpCPo1kMKegAUJeeUAIpWcp2yJ2M0PMjPeqHYhJu8QtnAq9EUx2451YCXpmfgK3TEYZebqnyochv/w0ybq2dunf19uVTEelRUxmLeV/ehiSiOArNNmKSJbvugDmlHREqfkTqoiOd0QIJh1BqlzJrNkPsf9rynXNN8ucmJuf/yfT/ZrPfOzJVHyxpTNoZZPWO638u0bY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(38070700005)(19618925003)(2906002)(41300700001)(8936002)(8676002)(558084003)(36756003)(5660300002)(86362001)(31696002)(4270600006)(186003)(2616005)(31686004)(478600001)(6506007)(6512007)(71200400001)(82960400001)(76116006)(6486002)(91956017)(122000001)(316002)(66556008)(4326008)(64756008)(66446008)(66946007)(38100700002)(54906003)(66476007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmRxUThuRFdXTEcxT3pkUTdIQ1VwZEhSR3BDYlFxK2dNOVp5bElSTHFBZzVo?=
 =?utf-8?B?SjltOThTY3BrUi8yOGhxTVNoTkhSQjJXWFR1ckVjMHJ6ZkpMUzlrVVBma3Jj?=
 =?utf-8?B?Y3dnQzc3L0hZMlYzZzdnUVg3OXJEMmpJd0JsZWNYVEt4UGFZR05FaExkQWxK?=
 =?utf-8?B?SVlLYk4zT0dxcVE4dTUrS2hBYXExcmdzTWRvSGVDcUltb09jSEI2akg2Wkln?=
 =?utf-8?B?bk1SdkdwMTZuUmcxQ2VvZGFXeHRuUElOckp1WWZCeHNxVDNITUQxaUp5c0hI?=
 =?utf-8?B?eXUvR2RPd1lwSWoxcGR2Ym9LR1MyQnFtcVp6RkVCYXJUaGJTYWd6ekdObng5?=
 =?utf-8?B?L1B3MWtQbkxnZSttczlrRDlnM2QybGlpR1IySmZGcmxpV2tPRmppRTNIdndn?=
 =?utf-8?B?a1hjVGFZczZKWHJZWVQ3RVdwMk44QU9CZmk0b3Rna003Zk9laGV6VHJoZDhn?=
 =?utf-8?B?THlTZTU4SUFuSVNic3llMzNzbDlSdnoybGVSTEh4UEtOOFN2Mm1zcHZ5SGNi?=
 =?utf-8?B?UHEzOGQvNWgxTUphOWcxbDZuQWN0QXJwSHQzM05jUWMvWFR3RDl0OHMyMCtE?=
 =?utf-8?B?Mm02SVVGRTI4WUJHeVovWi9iTDlBeUxxM1poMTRjbWphem5WTWdRcXZjMHJh?=
 =?utf-8?B?RGlvbUk0TWMrVldldVY4OFErN2M0dElPa3d1SDFzVlhYTTZFV3QxaE5sNmFw?=
 =?utf-8?B?L0ZwMTcveUI5Vnd1d1hQS3hvM2cvNytRZHZtb0VwSG5rajdJNkxzT1hTTWp3?=
 =?utf-8?B?dldaZm42Zng0aWRlRTIrUmVYalhjeS9oZzY0RXF3bTRpQ0NzZlh5aWxNYzVk?=
 =?utf-8?B?TTRPNG82WHNvSVdDV1g4V1R2bGlKc2JUZC83Qk5CRlNhWE9VeW9qZDhJU3p4?=
 =?utf-8?B?QjdPV25CVEFqbmhXRFJ0YTl1SHZ3NlhKRmJkam5TSGsvY3B0QkRaMllpZFBW?=
 =?utf-8?B?bCsrZ1R3WFFxN1FEbnZwa3J0NmpNc2hjVElkQ0lmSHcwcnFYbFgvWFNsdXNC?=
 =?utf-8?B?QmlVU2hacWZicGxHTzVGT3RjbG1COTZWYWJ3ZjlrcGh3RGFBeDJoTkFYaDFw?=
 =?utf-8?B?L2xXTkZnR2RpcEVBVG1rNlp0a25OWXYwUkRKbXNkRWhzUW1UbXo0RWVJQ25t?=
 =?utf-8?B?c3dZWnBNQWhKbXo4QmRVcXBlTFJMdjNJZWJZNGh4OG1SY3JZZmZlbWFzbEVP?=
 =?utf-8?B?R05YMjZmL3dhKysyU0E2bHdLZHVhSmFKUVQxNU5tbUhIWUwxSklqVDFFNUFU?=
 =?utf-8?B?dUQ3NGJhWkh6U1d4VzdNN1Fzdm5QdDVQUXFYZmZiN1VhZHNTZngxclY2NTY1?=
 =?utf-8?B?M3ZBMkU4Y3F6WlNDUmltRkxUM1FoSEJXbmZLMFQwb2N6MENZbmg2MVRqWVN3?=
 =?utf-8?B?VVRGajFINmxsdWczcGdTZXlVb1h1RVRnV0d6anFINVdGN1YvNDNDMjJOWW5m?=
 =?utf-8?B?cWorQ2hjVW1MU2MrUDZYcEpKSUQ1RVFGZGJRVmNNQithUzlsdHZ0VEpYV0tV?=
 =?utf-8?B?WUs1TTNuYjhIbVpXRWh3UTFiMi9WcGFtRFBHSE1IOE80bkZmUWRuZlVkUGZP?=
 =?utf-8?B?RllGWW9LTHI0Q0VXSGd0MDhNS0pDM2Fjc1Y2TGl5K1RJc2dIMkliRnV3VnVp?=
 =?utf-8?B?SUtZekE0L2JTRHo0cytJUDFSVFNuR1Zpcjk4YmNqcytEMFNmTjVieUp0emFz?=
 =?utf-8?B?MjUra2gyWEZ4K2JzQjBDY3NKK1pGRUZmQnRscks0STBMZTBSS2RrWFRKcXJp?=
 =?utf-8?B?KzJqNDVpcmdDUlVnUkNtNStZU1RtTS9CeVdxQmFMVzZWVUNWcFh6QkFsODgv?=
 =?utf-8?B?azlJTkZKSlZ1THZUQmJxc3VFSWFmejNONWI0STlVYU0vY0xxUmZDUTJGSXNo?=
 =?utf-8?B?N0RUbDRkazBubDJYdVMrMkJEa1MzS0duWlViMCt5eWdTTWQweXhLMDNiZ1pn?=
 =?utf-8?B?SmdQQ2NtNjB3UVh5V0Y2T2NJV244MmpMQUdpcXh0WmdoUGgyeEJXS1NITkxr?=
 =?utf-8?B?Rk9wSjJkemJKTitLcTIrNXFrWStqejVrWkMvNWFuNEVKZHNMRnl5VE00Zzdl?=
 =?utf-8?B?ZTlJbTNDOFhUU0JkS1JBdTZlMDAvRk1jTDloT1Vidk0yOFFrZXYrSEgyZitu?=
 =?utf-8?B?OVZ6OFcveU5kM0hJeXg0Qk93SHBQNXRxTzZLVUJOb29oTVBvQWNKbGtRMWNw?=
 =?utf-8?B?eVJUMDdHekpQZE1IOExiZ0M3Ykt6RWkyQ3VEN2diOENLK2t6VUVnRkhQY1Iz?=
 =?utf-8?B?RnZZdE12OExhRm9NWXlhM1gxZytnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3CCE6E60CA75F4E9FB6AC9FEDEEF26B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qVXmI+Da4DL0SzFf+LsYbrOC0TJQ6OPOzHdquFT+wA09dUFHvnN0Hf/YKmVvx1KWsdBUWDm7TIG+5fo6tl9Lx3KfVUxY68Lq0YouSJrFn7BVKJRZgDCRgxYSoe1mR2pVPFvDKGDNTU1d0G5Ov1L1Gfj16eFFajJSLmXEDF9ZtqXSmcqLtLl8kJe+5XN2KSvJvjW2hShH+Q+m6B/sknYji6T4jGQiskig9SL+X+/SOti8R2s2W1bltG4Y/MHKN0xA7cWsV4jEvDSUXjCD/5kFEMS6HxH3lKKDZWeGex3z/p15Lb8GnKnemaqDU+LkLrS2n6V89tccSPQw7E5oZpmZVbWLpMZctXKLD8h4YaZbdCqSaCgwk+XlLvZGVD8zbuLEKfZczIH/fv8pRaBJIgMqA8FXqlF38i1H2Tk2EkMY0pxNmjj9l7AuO+QvRrTS6IegnCB16Uj65Y6xcAD/zxd/3aiKmcNkD8xRrodcym/gsqZ0vBi71UMpYkt13mPJTfV0q8GzBDkBk0b8rfte1MLAQTyy5OiBdB+DGIDr/qy/h4IPgF6SlwLOY1eRMWrhvCMdWHYnzg27msOEI3DaqCG5wsRnGgc3pgNzH8A3T9syPKO5Ns7fcyDft7VBKEpV78kgZNH7Hyb8qfv/AGGcr1f5ShP67SRoXLyd1D0dfVtqnmG801Qb77p+TW4FpEyki58OgBfYpFIvpo5fJ73DinADnWA3HEiWLnkbqCt8SPOnhm6Ty7WuIebmSkJNBvQAlUwDZ6NiojtyQOzzVv95lp6JPEO7ISoIY2Wx7G19e0jiE5ABbm3LoqUuOO9ynyni92rT9tzjpuiJBenuZwjonAGJIdsW7x2lmx5dzA4T1qCEChl5/NF3aflOdNaBqysaIs9gifyNHBSq68fkNYgKov37ZR2bu899SmtO6zc5+5itXws=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc17edff-07a7-41d8-9e5c-08db7c6b5ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:47:54.3759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07VOfVOiNVZhQ7SemoiBnlHo06lAE1tPx6yMDl9cECOdzwZoYtKQxk6NYWWiwAUVfF8xfU/nY9ukMrOeMCW7oD8vlCFKfPUbD1soWIOhz3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8976
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
