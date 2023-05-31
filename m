Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401C7717E91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjEaLjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjEaLiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:54 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F1129;
        Wed, 31 May 2023 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533133; x=1717069133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=JqzxYsocjV6AwA/W+4JBFdwb8BJFY10GT0Td1DzUjVIEM3sXWVN5qCuU
   o2dRVWlzcK/AvqMYndHmtOgnGKPmcLtxUNNs47Sp1fMvstRA0IUwMWCoz
   62rGQq5VkTDJWaaH6crxfHfah3K4fXJamC903+4GIkeUfPSp+aU68wUDp
   2Q7rCfa893tn9+vfHR5UouJqWRG9hHkMqr7VvwBgDYcA207CGLK/gWBRT
   n6D3MPP6mt46guPqLrPwkEunYplhQBc0zISIbdRkU6wp9+vwZpy2bk548
   Vff8FoQeWsDd3gjxdlrn6aKYQo1MJU9TaODgMaBssXNiaPRHkISZtw2/0
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179112"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJgxDtQN+agXLWINILlINqIPTBnmz+uA+fm5vQLo79MlzFE0c/E+KRCYjAOMbqueluZPYm4R4NTeKxur/kqXu/MnN/lcZwzzY3ZXEGGbq0F8nGcziFqZBs03duouEeheHo7sfuigBNd8KZkvHHWp7hWroZc1Z1YoVpNh75Ajr++cvu/Xfq/EHFRoafz93H5M8+kp7KBPTekk7gsCDH+kMN99ySQHeTTYfDhm3VHjrIUryNRobKmo/mahKaajAGMECqgA0Ot3ilnEr7cwV3Iji4vb8p7iuzaZqK7+j4HbPjwrCOp1fqYmW5zjkt64iXfAnU0jmHTRVQs4G+E4JBwGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=AHdvR2cP4OQ77ZfhC4cYyTSLx8IoXuG5OL+uA/jEYUBo353l7qaGaBZRoVl4N8Cbz7E4sZzfRuhLHHhp69mVGBNcyXG0k5n7hxdceYAq8nbNmB79r7oFmV0ezVLNw3mEBR0SL230cotosy890+76F59Ud1yndcAZnQoe+LqGSN/w2dmpe8X70T5ygFwtKa6PyHM7AULc6ymzfMlYQQyjq786pzpXRVe24LBTTDYfS8P1joZdMs/vsbTWiYi9BluTST17vqXJg8hSBTWESFinJkET0YBLNN8f5o/fAnPaJT9wk/MWswsyoGcxQlHwd934Siu/zX5ExK2+/1sTBEH50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RPIwOCdELsg1s1L7ilYRS/ohr420TVXbrNFo1dojrRcnBnAd3BRXW46DPVySUxXS6aTPFcxYQcWTRUH/4CIbXgJH8TrGxjs0rI9TSsbLdZ2HsYW9sSeZnqPgVo0E31Clm9C6WCg/5dEI5DP+RT6+K62nwsYsJ+EFfKyoxzCmFjI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8194.namprd04.prod.outlook.com (2603:10b6:610:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 11:38:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 11:38:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/12] backing_dev: remove current->backing_dev_info
Thread-Topic: [PATCH 01/12] backing_dev: remove current->backing_dev_info
Thread-Index: AQHZk5Sm0zMWwTAv80inUECjbWZGKa90QcEA
Date:   Wed, 31 May 2023 11:38:47 +0000
Message-ID: <2d655208-edcf-dd4e-f9dc-69302dd7c7fa@wdc.com>
References: <20230531075026.480237-1-hch@lst.de>
 <20230531075026.480237-2-hch@lst.de>
In-Reply-To: <20230531075026.480237-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8194:EE_
x-ms-office365-filtering-correlation-id: f897ecbd-e4f4-41fe-f01f-08db61cb98f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXnu7JGlDYv7wQpGcWWLgWZpm/kmq/ea13vzenxdrA6GKd8AS2kOMBFDSxbspcB2ox7NZrCOKxDCJhDMlXP3FRJ0dtroUgZ1T82bpzqX0Tz1QHYsf0ry2WP455NM4ebvzmYs+KIJjnXTmi5/axEyeyuCTucLbhWAA2kUlxnV/LNPo97eXfScSBwsEhVHKhAt1jZ7857jOati8xfSSsVWVp44pW/6HVURRXVjuiyI9GAzcgs/4LHxpPEarzkN1ojxCYZVPzbeUMtCqiFMrr+Lm3SmZkD9xyoCQQTH93AfKUKf05bMFJ7Kkw1gUXnDa8Qm1ul5PdGGC5vZuGmXKBneGXVQO/RTrhu503eYSeEQDp/Ve4MANF8zpfEVanGBjFQHuhaGeHjymA+1MaCY01pH6HHXKTpmPI+O7UBZhUCL5k8onfwF9dZgyDjwWVnomLGlYXuegJJEy9e60q5N8muzP6375qE3LfiVqgUYT3abrfwDMdDaufjAX3ZfWT/2yIMhDvshz4aBUQaYDy5tAALgAgRSXgb/60Y9NfT5gX+fNQNuSWY2xPPexHKb698nWs8X33i5dhc3dhkbX5Y7GjnqRJFaumx1d+j+y+C7pxKqvoJZvTvOKFWHzFnnxxlpLgs+a1qJxL1t8xFZ2qcr9FCZP2XWUacLHOySzBN+sx+Xrqx2Bfvte1K4TN+sHGIY1igc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(2906002)(19618925003)(4270600006)(186003)(31686004)(6512007)(6506007)(5660300002)(82960400001)(8676002)(54906003)(8936002)(38100700002)(478600001)(122000001)(110136005)(2616005)(86362001)(31696002)(4326008)(38070700005)(6486002)(41300700001)(558084003)(66946007)(71200400001)(76116006)(316002)(66556008)(36756003)(7416002)(66476007)(91956017)(64756008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXdTRGZSMmlNM2lRc3ZGeWlpdGZBb0V2blBiZW5TUHpnTlZPeUNnTkIzK2RQ?=
 =?utf-8?B?c1NEVjBBOWZsTjVsVDVzajBGc3A1eUM0ekkyWDJKeEcxcjFlRHFGNkFmRTBV?=
 =?utf-8?B?WlgyMzNCeUtOeEFsRXE5WnBWa0VwRHBqbkFJenpBeXh5VEVDN0RiNGtaZmhZ?=
 =?utf-8?B?ZUdDS3ZObTFxNUhtVzV6Z2ZwUm9KaXJtRXh4emJySjNSSVRoNVJ1bjdPaE5G?=
 =?utf-8?B?NVJaNGRFL3NKMzVmOUtDa2d6M1Y2MDBsNUl6YXVpNmpxcHE4Y1B3cXFlODJs?=
 =?utf-8?B?cHZESEhxKzhQb3kxdXpxSGlpZlc2SlB5NytCWWNqbElIaXV0SEtrOTArTDY2?=
 =?utf-8?B?MWg0bHZvenFGRmRNKzJRRDBHZVlOOVZBZG9tcVRLSlhHUVVuR3dsUFdrbDdF?=
 =?utf-8?B?YndKR2Y1eW1rbTNoSTBBODBGS3ZLRGdYc3h1NWMyby9nczJQbjBYT1ZYY3Zs?=
 =?utf-8?B?WEJTSDZEVHdjSmo3TGE2WmJwRHVvUEUrZzZHY1owMFRBRzdRdU1GS09lV0JL?=
 =?utf-8?B?bHVSNGJ1N0hCVHMva2tKK3M5TW4zVWVySU1iTnBtei9qY3hFM3RycStwV3BL?=
 =?utf-8?B?VnhhRE53TUt2TjdscEV3QVlGY1M5NVJuYVZSSDlwMDRJeENwNnAxOFYwUURN?=
 =?utf-8?B?YkV5eWxWWi9OYTBUWTlzRkpBQ1BiOURab3NXdTZ5OHphSUVzS2ZnU1RoNjVV?=
 =?utf-8?B?blp4Y282Y1I4LzdjQ0xJUlpSRkowMDZxZTBzQXVBbUN4dkF6QW5ZWTE2eWZq?=
 =?utf-8?B?WDFqdURpSVU0Rmt2MWxwZ0Y3TU5ua2t4WjhpdVJpUE1RYUJsVW9od1plajhi?=
 =?utf-8?B?aGplMHdmeWRpV3IrMDRPdnF1RStxZG5BbjA4eCtpNE1BTDExZU9QZnVJZzE5?=
 =?utf-8?B?T0dGTi9vby9LQ202bFB4OGgrbXhVVUVhRE1oM1B1OTB3TWdsbVM4TzBjVmxC?=
 =?utf-8?B?KzRORnE1eGlXZ3VERmlmSG1xVit1WXVyT004WnZldW1wWFNYaUZjRFd2cDlq?=
 =?utf-8?B?T2dCSGJDMDE3bTVOU0VzcUg3aGlHRUU0KzJtd3hHMS9HK3JCNFh4RGh3THpy?=
 =?utf-8?B?T1h0K0E2ejMrQnVmc0MrZEFLdnhDcFNPaUt5SU5rOWxnRHdrK01yT1RiZnht?=
 =?utf-8?B?RTdEZEhDMW9uMlkyRThzNkNuOWtKV3lENWMyUmFicmw1WmtEWEVkZFpQR05w?=
 =?utf-8?B?aVdBMk41TVM2R3lwQitRdzVscXhaTjQwczZLM2htWkVrRjlqWTVNbkxnRnN4?=
 =?utf-8?B?OHVRVHpSS0Q4c3ZPU0l2V255ekxJSnlLQUdGQ0ZERXRIRk9ORFMxRk1sV1NR?=
 =?utf-8?B?RjJiV1JtUzRsbUk2dG8yS2czdzd1L0VDU2lxM3BUSG9lVUIzMTYwR2pPcndH?=
 =?utf-8?B?cngveW4zdlBCV3dYVG9IbVpPVzdxY01nUFdvOU14YURNV1BNbW0wbmt3dHFP?=
 =?utf-8?B?bTNFUkJwMFBNWmhQVThOOFV0QlJvS3pCOVkwY3A4T0ZEaElkZ3Y5SGc2alNK?=
 =?utf-8?B?NDlPZE1pWVpsTkRaMzhnU0NlMkpTUGd5eDVtM0NEdG4va3o5SnozWEMwSHVw?=
 =?utf-8?B?aHg1eGhQU0xCekxYK05FZi83RTVzS1dFMWFQL1ErSVhDczI3ZFlNVXBSVUFr?=
 =?utf-8?B?clIwMnhveitQWjdoc1hQbEpVNWh0b0pTajQ2NmM1dnl4UnpMTGJXSE4wZG5a?=
 =?utf-8?B?YTB5TDdVaW5UcFBuNlZUSzlHdHM3QVV3eHlJUlVlRFFXTDhmU3JMRmZLTTdm?=
 =?utf-8?B?TWsyMkNpNkFleGU4WUdIeWkvQ1cxcHRucnEvS3VvZUtEdVR2d1dVVkZwVlpj?=
 =?utf-8?B?Y0lCeHFyR0lYZGVBdDRFemFWR04rY3Z3UGZ0WmsvWTduTklTcHNqb05pRGRu?=
 =?utf-8?B?bGFyR01ncmFsaFJjSUcvdk1ZN2wxazVxNU04TEhmTHcyYjdrVEVyQ21NK2Np?=
 =?utf-8?B?S0ZjUXJiSFlxSFdqSGNnN3IwWXphcUMzS0VnTFY5emxSNzBOZk1QemdGc1F4?=
 =?utf-8?B?ZytkZjNKWUF0aE8yRFNCbXNqZmhpMFdudERDbFVOZkFGS0RvRmlVK2tOMW84?=
 =?utf-8?B?WjYwZmdXM2RLMzU1WGQ5dkMxVWd5Q0RyU3U0OU5yeENDTytndjFCOWJJbFdE?=
 =?utf-8?B?b1d3cWljWE9Sb2RuVlI2T3lBdFZ1YkxXTWN6dzdjTFlYaHBzZzY0NmpPUXhZ?=
 =?utf-8?B?dHM2TzVxL21oWXNjOUx3ekpFcEkxVXdzVVdCWG1uRWxLZU5Db2paSE44R3F1?=
 =?utf-8?B?RXBJY3hvNXFxbWFFV05FTytSR1NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E14B5B5F1B42034992E012A2F8CDD3E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TUJwaEJUbHM0RFVZMkQwZVZ3VExvNFIwTGpyd01YOTZMZDNYaDE5ejNMTW4w?=
 =?utf-8?B?UEJ1SjN3bWVZSVdhM1F4MFZCbkQvZGJqYnpBVUY2OWtaMUprbnhsYW9jWTRt?=
 =?utf-8?B?MVJ6WSt6VDNETjRMMVpSUGpsRCtQYUlxMUYwUkJySFhkOWVFVkhlM3d1K0gr?=
 =?utf-8?B?Y2h0Zkk4NEpoOUNUSHBES1NpM1ZsK1NZQnhVNHgvanZ5VFRyazdadFAyenFZ?=
 =?utf-8?B?UGlhd0FheVpjcHlvandHUjJlcC9FdndQdnA1SFM5R1luWTlYT3BQWXQ3cTZX?=
 =?utf-8?B?dDBrWnZteGkrNkpyNUtIbW1ITElxM0ExVlBhOWh5dlI3aG1UOG5qZTA4cGdE?=
 =?utf-8?B?YzJoaFZiOXVWbzJQSHdLL3g4cTl1bnU1S1VleG03U0ZiejhyK1d0OFZkMnZC?=
 =?utf-8?B?VTNocHJKZzRtU2VWVEJ6dmlpbkkwTEFnRFE3YnhHdWZwMSt1RkZucm56bndW?=
 =?utf-8?B?c2k2U1Z0ek93TWJCOHlQVCsreXU2WlFoejZtTUZsaDNjLzV5V3lzOHQ3bDFo?=
 =?utf-8?B?UXBvU1V1UVBDclRpUGZTTlhXdk02VzRhbjRKUDFIZ3FjeGNCU2JXWmJmT3Vt?=
 =?utf-8?B?d3lRQ01kUEJWZzNSdjJCSmJneThtVnBKQnFLTTAxbTQ4dnFLQ2dFczdIeXRC?=
 =?utf-8?B?a3A5VzZqblZOL2FMbS9seGhvY3FlT1ZnSUtVR2g5T3l3ZkNaVGcyOTN1aFlr?=
 =?utf-8?B?ZGZMaHRpWWpha2YrK2xCdkVLcWhSSitkZHh4L0ErL2pISWlvZ213aGhDems0?=
 =?utf-8?B?VHZYWk5CdVZObDFMRDFxa0FWM3ZzYkRqeTZxbTRIQ2tPV0JCV2p6SW1UTUxa?=
 =?utf-8?B?eDltV0hYbWNwSURsTzZqUEdsMGVuUWtoM250amYrQkhOMHdBcWpuN2xIWHk4?=
 =?utf-8?B?dHA3dUZMZjhtT3FKQ0V5dnVVNDJqRTJ4VHA5ZUtmZ0U3Rm9nS2ZnamtIZzZ1?=
 =?utf-8?B?U0NwMEVwRmkzY3A1dW9SSmthZHdzTjI3cGJERVNHZmszS1pRRlVTOVFna2VL?=
 =?utf-8?B?TTJpOVp0RnVxMFJSSmFEaHpIdlBBc0IwUEpZWElrYkwxMm5PY0wxMVNTeEVS?=
 =?utf-8?B?ZWZCZzlZMVVEN1M1TlJleHBBamhzcTR2M3hYcWNoR1RmQWdSSCt5NXlrbXZj?=
 =?utf-8?B?R2FQbS82YlVVVVN5Vy8xQ0pENGFMWWFJMVhMWGxaVDl2OHNnR2ZGT1pkRHpS?=
 =?utf-8?B?RzlDdUJzYW4za1BEUEZOaWE2dm9QRmNwWjhPSmhRak95WnF4TCtTOUhvL05K?=
 =?utf-8?B?akZGYVVWRUNlUWJ2a2wxaCtwMGFtazJOR3V3YVZRTE5UK0VnQXM0OVNGZkVK?=
 =?utf-8?B?dWVEVHZxRE85NEZKNVdwK01rMGNUV1k0QXdiWlQwRnpoKzlRMFp6a3JXY2wx?=
 =?utf-8?B?V0dua0Zra3ZzdDhlV1ZIb00zRkJud0NtNjNRMjMrTTJEZVB6V1E2Q1FDOUJx?=
 =?utf-8?B?em11WWlSblpKdnQ2bUw2K1FMRkhDQTlvSFJjYXVJSWRuZFZRNkdvT09hUDE1?=
 =?utf-8?B?VFhKNkdTbFBIWWlnUElsMW5McklMY0RtaERMcTN0WXJyQS9Ta1Y3bVZaME1G?=
 =?utf-8?B?bC9KN2RsYXVRMUNodm95SnArcjhCZUxHbmk4Q2tQZ05YRXVqRTJrcUlUZTB1?=
 =?utf-8?B?dXdweWxvNTcvTmZrN2JPc0srZ1ZXYzJxYml6MnBHdEMzWi9LZDR4V1BkVmNE?=
 =?utf-8?Q?yWR8+PhQzhDzm8J6TJqo?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f897ecbd-e4f4-41fe-f01f-08db61cb98f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 11:38:47.5061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHjy5wcv8PZUb2EcHuT3o65nnzukm30r8d4LC8USZm248vuOYpaoziBmgmgVehYsKbFioMe5R0JN3UCQnOPTdpqn4Yky9GmhIkWGRYqdhLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8194
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
