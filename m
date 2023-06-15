Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4C731B81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbjFOOjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFOOi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:38:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA8ECD;
        Thu, 15 Jun 2023 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686839938; x=1718375938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=iYc0JXBvuMbHmOJRg3L7QXhDiuvHU1htnBKkzZWsK0S/uAMJqX4IIPco
   JaoQYrrESdDp/qwXw2khM9OGdsSbvQJnDK3Bg4bQtIF8cIYu6ICvPLj7l
   aGltfnQ/gkhK1d8nUO8KfiFActxFxukU0CCtL7xHxfq8yiBDBkJ3qNLSF
   /puVt+8JBIrrbRBaHQ1PQfMglaKW9IiL+cpRDBVxZMzypmKb5llA6ipbn
   lI7A70VwwcjCtOAk/IxObWsNgQKD6V1Mb3sZsvbiUG8rNocdc+Qwb4JMa
   nE5xZqfFIF6Gh6CBBALaIlHqSjf9HKbNFkdFAIFblo3OvNlm2NkZ/fRRC
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,245,1681142400"; 
   d="scan'208";a="235888092"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 22:38:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7BxpDBa2uMFtbzxkD+2XQQCz8KNUwl/b+hPkofnKtIDxwjltPrfMIe2/FKmC+bq5OVA8A6h7Ki9bkYcpHVsY490yB209cMpuLVQT+nF1gP6UrPyKYshNlxrDt3EryMFshauYsuH+68/V9SEgBcxtyHgdqXTjf8kAERIe+pCu6lD9gXFE1FWA5/hWICOozRAtU8bsHSpG7bqBgxEwylMiWhsJfIGxznJ8T1AnO8QgW1GUdpekLzjHv5Pjup1N4650+Gk3ScmE8XHNhBzY117/qotgDy/sYfCYnYRS6vwlbU3h90R+TMyFP+aaFnFar2Rd73l42v9v/ZBvBpnCWF0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BmpIEmHvIQ1AT2eM+WSwPFy/8MiycT7NCmGrBGd/s2GdTi0/zbJQVXT7hEOOEIxQwuQyUsOzdBqK1ne+0eO1bN3D09Atgz5sKBF7Zp80hjs8rs7ZIoGA5QjRpIn4vmp9d7ywU5kzq8RH24EQQfhdr5MWqKTqo0fq63MePgVrLZQRtv18K5hNziM0huP9GJuyttupeGjeB2WimZPrZnY/qKHs3EK6i5mwyPMd+Viz5ItsaEo7GTQLIBH4SB9V3sOzn+PHFuv5fxE5m1JsLqESQhTg7Prd3+UUKkJHrH8SadkvodBkjFzrPrP6ILEQYektHt+LItSDfhASqR9U+asKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dHOUix2eoKOCLAtOsONjQ3pzyEAx5EGue9WIWqqjiSbHrVES9qAlC8GXUmExq4kpi/ZsOGsBvvxTWL4Ft5nBKQj0jOl9Bd4V6kcOojh6s2N6o+n0V03ClZFJ2YJbdWRzg7QbeS3S6T+n7Nf4G5x9c79G7xaabdJanQp+QxzmxQY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7156.namprd04.prod.outlook.com (2603:10b6:303:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 14:38:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 14:38:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/11] md-bitmap: rename read_page to read_file_page
Thread-Topic: [PATCH 05/11] md-bitmap: rename read_page to read_file_page
Thread-Index: AQHZn1W27CbVq9LPh0CBwDC23GT/Kq+L74uA
Date:   Thu, 15 Jun 2023 14:38:53 +0000
Message-ID: <9f665cc4-18c5-6092-cc09-79390599e37a@wdc.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-6-hch@lst.de>
In-Reply-To: <20230615064840.629492-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7156:EE_
x-ms-office365-filtering-correlation-id: 9f1e1681-e689-440c-c530-08db6dae3e15
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OP3iAIMGlJcCCf2nesrHH9j1zCPdbIC0h+f13rfVHQ4LOB6SIzkKsLI8ofv/eeOiTVlSNq/fQaQB9k9jVxGmELVw4jD+w7ZuDwa0Yqj8ErWPh22/IT5cmHKsmVuGRrEbw1Rnia4Rl1PEKLvdlfQcxtuAUuUst/hFIN+eytBczZ9uiRyMa4xxEgT44JvxWeYrlUKTOQCNRZUGdsLlReQZ//KjOFtrvQheH6SJPCAwSoyLew1rsCUDAaZKv11nqdjXLUiU1oa1JL1OCaOJUSkPCU0i8QjbUpRxaGoqbM2pSRnCHtrkViKtBNYHDueBfCZHBdFJETTBY2N5pIQOGaJtNGQa3deR1C8rwpSpPaife01cCmMwqPDstE1QwXyZHoBLIOHB1yx1OsjBwxzqS5NEiKZtQ1YfvQNlflsyLE5spTVZXo2m/yH278iqJPQK820gAYTngCSzoQbmqzoiXAAokfUgr42+4seuC2H6ie/Y1YoB27DWMG8Dv5wampENnmZ60YGVJN3QeEAcEzkwyv4YUdsbY/VCHdPrvxu1cMvK+RWhSPFlgxky5tb/7LanrxQKiAOJHjE+JpnwKCzC2TXfQt7pHDr5p/7pKUSGrmsr8Lcu7QRtSKIcMnGBZuxOzYXpNFDPPNE/UQo41GWUG4i8VBTjpqvJCUeQzIkzrO/Fe4yhPNBTvxG+0y8hnI/Qbo7h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(5660300002)(82960400001)(38100700002)(122000001)(2616005)(19618925003)(6506007)(186003)(2906002)(4270600006)(26005)(6512007)(38070700005)(478600001)(66446008)(64756008)(66556008)(66946007)(66476007)(558084003)(316002)(71200400001)(8936002)(6486002)(8676002)(41300700001)(86362001)(31696002)(36756003)(76116006)(91956017)(4326008)(31686004)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWhJV3BTMWZqYlJ1SXNFYUtvSVpBWXdoSEJnVkRVbUNuMXZCeG1RQThya3NT?=
 =?utf-8?B?ZFFmaG90MzYwbFNpaHlKTnZzQ0tERkxUc3QvOXJCRWI2VldMSmhHM3h5Qnlk?=
 =?utf-8?B?S0FYNUhYV3VRbXhOMGRKRU93cDQrWTg5dE9zOXdDdm9JckJnRW54aHJqdk5F?=
 =?utf-8?B?TDhibHNhK0ZWYksxMFdwbEUraUlxSFh4SzhXKytGY3ZtYVJPc1pCK2p3Rk9N?=
 =?utf-8?B?YVQrTmpSenUrTE5KaFU5VVRFR2hlZWpBRTdCZWFvbFNqVUlBU21VR3RpVytO?=
 =?utf-8?B?SldqdE5qKzJVdGhKR29lL0RLaTltRE1aVUp3SFhiUnU2aHJqQ1RmdU9CWjZS?=
 =?utf-8?B?VFBmeldxU0dkb1B6M3RjSVMxQ3VvY1FCWTliZHJ4b2Z5Tkl3U2hsbWRJbWlD?=
 =?utf-8?B?bXYrQ3BtKy9mOE44bzNTNmlYMmMzV0kwZ0txNkJ3ZWdieUViWTZaL1FIbzEv?=
 =?utf-8?B?VFJ0NG5mREp5UkhJOHVBU0NxS0xiT1c5bVE0RmN2bFZuM1V2Vi9IcEZGODFE?=
 =?utf-8?B?SzBScHdHNEdqQTJZZjcwVGZlTU5SdjVtY2ViYkRYQTdwWTdLTzN4UlVPWmtH?=
 =?utf-8?B?ZjhBWVJ0U2ZZaXBBd0hQb1QxZUZMajBsVGJZYjJiL3R0QVpGNmtDa1dIUzF2?=
 =?utf-8?B?dUhqakVPaDZMSGw3ZGNpb3RsL2NMYnBIaXlvdXRXN1d1REtTeVNSc1RBVkNm?=
 =?utf-8?B?cUw0alVqMEs2amFjdVRDZkwxMkczSHkyM1pPQUY2WkFZY1NISTV5NjA3eXQz?=
 =?utf-8?B?U1Qra3o4MEFsR24walRYZmVnaFZjYjdPVXd5V243a2Fsek9jS2FnYmx3cWNZ?=
 =?utf-8?B?SVNtVXNJQVgzRk5PbXkyWmVFZWRFN1BXMWlrdDBoVEJlbldMK0R0RmtCVnNx?=
 =?utf-8?B?Qm8vSzdWekVJTUFtenNrOHRlV05DUFdBMERWSWlDZmxQdDhjeUJSd0cwQ0JG?=
 =?utf-8?B?dU5iTGFRL0t1V1lONG52a3hpT0FvYmtNcjJmdmZBRVhka1cxVHBlY2crZk4x?=
 =?utf-8?B?Wk9obGtzNGkwRFRYT0FnU3Y2VTM3V2hIZUNrcGJkWkVrWXpraXA2a0VTSGtH?=
 =?utf-8?B?U0N3dlh6S0tFK2RVaUJTWXBlckVSeGRaM202N29UeE5SR2FxM3N4MXF2S29I?=
 =?utf-8?B?YkpmV3V1Y0loTHVzYW55RUFNOXRlNC85ZmdTTjlrTnJZb3lpMGJCQmhWNXVX?=
 =?utf-8?B?MTdsblJwY2RLbGVYbzh2M2M4WVFpYkNIVjVvOXVIWUplRXVKRGlFSWo5cjFL?=
 =?utf-8?B?dlZZWEx4Q1k5T2dVVmtJL04vWUxCMm5Tdy9ZTkd4S0kzTUx0RzJSOGJlUjlo?=
 =?utf-8?B?ZWMvbzI0OHBVd00vUGh4bkU2WEg4MDZkTzFDbUkzS2JQVlNZQ21qekJWSFdP?=
 =?utf-8?B?RWI4WEx3UFVPU3l6dWNFOG5zQUh6eit0bFBRazJWamIvOFhpR3dQOVNQYzBD?=
 =?utf-8?B?MzRJcW9SNC9lc2Z5QSticXZVODAyNmlZYmlybGNBSnFDaE1Wa2ZrREdWS1l5?=
 =?utf-8?B?RTdnY1dLTkN3WThRWkdNa2FrMTJtTG82blpZbzhSdjdHcjhoYWlZT28rS0dP?=
 =?utf-8?B?dUlaazhWclVubmZjenBQOGVycG1NU2VKOEJ0QXlDL1BRVFpQRlpNeTI0ekZP?=
 =?utf-8?B?bEMyUnp3dGpBdVhjdk8zRjRMd1dtczB2SFAyRnBJb0ZKeVl6V0ZlNDRxa0JU?=
 =?utf-8?B?SkpFNE1xWHFPZ3VPL1lSNHFzNmFJMHlldHU1YmQ3UU9jK0hBMWJCUERoZkdX?=
 =?utf-8?B?ZDBPR1BhWjNzUmx5Y1FTdVA3UXpzSGo2YU56ays3U2ZXUFRGTUE5UHlUMlgz?=
 =?utf-8?B?UEt2ZU4yTFNlMTNNVTZKN240NHZJeC9PaUlyNk1Nam5jTzdCZW1FSktjQ3RB?=
 =?utf-8?B?TXJzMG1kMDVQN3JVSWg3MWpaZUJVc3BhY1d3T0hxd09pbHp4L0dHUEVrTzJS?=
 =?utf-8?B?RGVsNTJnWXVmTVZyYklqVHRQaWxQWWYxWTJpNUZ2RlUwUW1zcUNYZ0pnN0R3?=
 =?utf-8?B?Vi9yNFRHYlBFWlU3cS9PS3dyNklWVEdvVWU2S2s4bSttaGliMlQ5WndBUWtK?=
 =?utf-8?B?YVhpWWxDaTh3OVpLSkduZ3N3Mzg1RmVZNXpRbzl1aHZiMnM0YmwyeWVzaFBS?=
 =?utf-8?B?alI4L2QyWmdBNDlxWm8rOWlLUGo1RHdLRTZJSGlEblhmT3BhY00yL2FrcllI?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA964298AE23EA4A8DB1BF94B13BC126@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5FjWOue2jd/fVyCxNUkhd+fmGBfrhqi8NeKtZwx1qXkC4G6tEFKtzHUWdlmRAuCParBvEWxdlyDL+zkYgRqKvqry/eqwO8tJBFot+limkvyEE1kNoAK6c7Gghecn7ZlDcWQ6xqHuKyVYgmUePHFV9WU4/022sKjmrWe9UI9IRo3RsWf1Ta8I2URN9aAZzGb029qQyaSRvfwgrphHcQNtu82eGuUJJtEHWIwpE/mIyxamrEsyMGOc7w2nBtUrFG3zwrIyeqlFJH39P8uLj364bTGjK55Sti/3K3k+oAtSDiFKtafd/TEoEPhseh2fUp0IR+rEYH+X1oKz3LlNyXRMHdTTKGJpL2wPeRy21B2UZfyJdAPg2GNiHXjDLrb+lXOEb8VIOGTgNXh7qy6WmFpF643NMd86m62DFy5OjAdzA8Uznnen2nWeu6zmISRWSRD4UryvmQ43qA966aLvgnW6MLeSQUzF0GnkPPk/FRwCOqOr6c6ew/fGQanlP04az2eW+azeLsK3iZXN3iWOZ1K6WWZ9MUzw0RDK08Sh6EF0dFJLjOKkV/qkS42j9eIBxWopdUz38XdMP1gF/XgtbzhzJSUVtf27cLJl+yXHCAMTzO3I/Yev60E4s/j0lozRKPVN9IJHoqUvEx2nbPWFdqEdUQi/YwfT113HLb1eIetdPm9GDvdcW2b++pI35xXJykPfpTyMwxAk/jBQQUFReTjg/T5EOdNgXf6raAwoI/pMB+lLJ8FtqhxKVaxI7UDcE9m8palKKOrpALnx0azGPSH20ntUdecLvZSycA5XBqQUcjLvUqLjiSoWrfDKT6EdY6kWHdxt1iUuj0rZRbxUPRH9vA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1e1681-e689-440c-c530-08db6dae3e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 14:38:53.5992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4vWa4bYPu4YoJesnC8CTsvfJWcRd+yvu5Op8pd+Z4YnrDkOflV8j7wsluUMf7k3kW+v2mEG6gTP0KUms399ZGOmj6Wi77bpFDpgZNCW8gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7156
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
