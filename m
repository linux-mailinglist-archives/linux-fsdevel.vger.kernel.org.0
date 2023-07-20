Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE07375B0F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGTONn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGTONm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:13:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E02115;
        Thu, 20 Jul 2023 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689862420; x=1721398420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=XqkRn6k3UJfgFYhxdT5if1fdXMdj8uwS5Uc18onHTIFUrbba+FyF5kG7
   UreCYY+V/LEf359esoorQmvsuh9qoTFjO+Hh0yLRB3CaOnLdExOlKxeX/
   mBEX/ERJDxxfu48W5kVe6DTGkoiDHBrxbdKX85tT1jkZJ/HQBVRXIF/4V
   DtcCWsu6zm5Pab7G/ckGeuxkbmtoJiOVReVsTlnae5phAqDD7j21DqZPk
   HWB3RamWPHf2O2/KcMahOe7yjI7bT1tDNlqJwdvlLUKnaEBvHNQCw/3AR
   yCZecDocn8m2ndfzxnDJV+qCiUKomgkSU4VxsZFkLnWmUOGPhXM4e2KKa
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,219,1684771200"; 
   d="scan'208";a="238971251"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2023 22:13:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTBzRPXOhjOl/FxkNxhRLK/neD2bcYs82dqOiKgQvEbL2y2usuK10kJbx0Jmoyq70ce0fNWw5BL9Q8c5XS/dz3rlcsg4M8ZpDoflfIwPBW+yn3tbHvLWe+wufE+rRBJpBQZNv1yH3AgiDR4IjV5Cj7J4eVRWunPdalzUrwVKUw4rbcmHuPuLgghZSpjNdm9nzuGIt9lpT/9aMN5zuOMLK2dozwEQRz+620Rqcv0Ky1RuY/gfRXfQByukkaJ3d5vr75e9DD8amSwfD7Sw2cI/cTd0K9yWYHEBl60Suel5J10+BB97fKFuI0Lv1p4WWMs5CMqagQSEYW1VmeH6etYhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=AJmmjC5RStpZ8d/XxpqJnBxSVY5EK9D/POICs+FNENmvR4JJf5wTAVKqKqLCjeEfVACtlTEb0nxCI72OonRVUx5dFX93QDuHuv2jFKXZLIk1/GZSHmlJFWIWrkiOvIBXYL4pfCkHhlK5xdoD0OrijhtYZcpXTnzQAgpLeCYeZKtiv8APDL+b3ruKT2/Kdws0aVPHYSjCkLV91I6THQ473r8KRSa8nGj+LI9cuZ7NPXvT35ukNdrDsXr6p4z780eHTtIH1s2kdJxSfNif9TxEIcEQDFgDvvhM3xbS423A1ZbUF2P5aDHO5nOb61m0nRyoKQ/wnmIDF7aztCDxJ9adww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HDAMM4D+fV12w5gQ4J4kOCuPahcBneR7TSaqpkCHkPptXgUAsefsfQz6NYRoN9y+GEz+iCyN+3zY43XNz7mhMn0DiTxPCOpv/PpFYpUgcltFp+wL+TxbgBY9wS9GLsx1OvEcIWAvhrfGevry9m9xefgMLvzM/d8QKUFnv1cUiHc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7615.namprd04.prod.outlook.com (2603:10b6:a03:32b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 14:13:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 14:13:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] fs: rename and move block_page_mkwrite_return
Thread-Topic: [PATCH 2/6] fs: rename and move block_page_mkwrite_return
Thread-Index: AQHZuxM2OFGAxHSmQkCLf422VtaeGq/CspYA
Date:   Thu, 20 Jul 2023 14:13:34 +0000
Message-ID: <a2156f62-b1fa-1f84-20e8-56a857a15d8b@wdc.com>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-3-hch@lst.de>
In-Reply-To: <20230720140452.63817-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7615:EE_
x-ms-office365-filtering-correlation-id: a087a68f-a5f5-4266-a34a-08db892b8158
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRRG/hMddGCubCc4/Quh7Yz/vJAAp/7JbrAOEf8+StOy7towWW+0KZGOFyHJoOKfHlkDARiIlJoS9PtvqUjgT2f+RWjkFj1+mlj8OhHdz45Y0faJDPMdigKZt70kBvdYUingd532INlnnjcoPVcj2R0pcav0omypuIHAhBq1rXU5JZkBmjkifw8QuXaQR8ObI1q/Oes4+ZYLRzrB6WcYgkdpuAMzyCOquzYgDwtvDb4yU8GcUe+UACGnnV+PaL0gl7jcfN7FGWBs0Saxl1h9fLerDStHJdH8y4I01OfTDjWzCVcF6KcQm16pf3wpx1sYE9r7GGChndXsGXrx5UGwMSwMluPFCUZ2YRY+6G5r6zZSEN96RZiI7HWQRQvv8izZEPRFEb0+X2YrBx2yDVVXEp938HeAyFvoIc7lJ6NLQ/aHyAgp+qSpgDUzlpydW6o3J5A3foGtkDrb3roJd4ITFfmL1LI46+1ZAVDuJPpKS8NHkVLqB/t/SgESpE5eA53CEkLc2OEKqhKdw3q6BWgVqnm6hfooSjobrrZ5uAa6yBPxo5S4w/nzrWmAgloRf9jg4DJ9sAqeOeorE1lfgN+VjPMe8nixFuTcorZctautGsxjpbRwd95sH7ThJsjGbveypE6cwY6HzqoCwNSXCakdnc9ep0rL9BZRAFyWpaJZWrI1E6kgKJCaaBsZ3VV9Nlf4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(71200400001)(4270600006)(31686004)(4326008)(6512007)(316002)(41300700001)(26005)(6506007)(186003)(54906003)(110136005)(5660300002)(6486002)(66556008)(66446008)(66946007)(66476007)(64756008)(8676002)(7416002)(8936002)(91956017)(76116006)(478600001)(19618925003)(2616005)(2906002)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(36756003)(31696002)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmRaZGFhdmtRd1daNEtRMmoxUU5DbFh3Vm5uTkxDdkQwaFhGVGdoellwVmE1?=
 =?utf-8?B?UHp1b2pGekdvZXhKR3hvV2xMblYwY2hTZmoxcHd3UnhYK25GVVlVdThvL3pX?=
 =?utf-8?B?WFIxZDBKUldha0lTa0I0VHFwd0M3bmFmTVV0OGljemJvcG9PMmM5RVFwOVND?=
 =?utf-8?B?WTRkNk5DUnFkMmsxc1RYbnArNGFGNkpIWWZjMDFZdDBtY0dqd0J2U0N4M0dL?=
 =?utf-8?B?VmNuZmFpSmZ1N2NsamVTK2NVSDU4TW1yMU11OFVuUnA2TlNpT0JaWmNQVnVo?=
 =?utf-8?B?RUo0SVdGKzBKWXY4TFg1UjcrTStvR2txSGtsTjFwcVhHYU15QUlFNnYrRW80?=
 =?utf-8?B?bVBLMy9WS0RKakh3eXMxVE1la0NxcHQvWDdZUG40cTBkV3BEL1ZtdDdseWFu?=
 =?utf-8?B?eGJrTTJCU2xxYVlCdlg4YzJtYlBORTFUK2ZMZUZzeit3eWRpd295cTUzT1hM?=
 =?utf-8?B?ZndwQWROVklyK0lQNlJGZXM4UGZCWUdRQjdJam1ER2Qyd0xFVXZHQ2wyNCtF?=
 =?utf-8?B?YTJGK3JzNFZvRVlTaXk1aTdwZmVzWGY2SnNBT2tobDBIMHViV3Y3U0FIR2dh?=
 =?utf-8?B?RzV6V0FUY3NHSWF3MjZpLzhkNEtkaDE3Zk9EQUZyU3lueDVucU1WZ0ROaVVw?=
 =?utf-8?B?RloxT2dJV2pwUkdmbGdJcTBlQnk2Z3pFQ01mL2pGVWZtdDJ6azg5Z2V3OFpD?=
 =?utf-8?B?MEpJYmVaT2d3OUFoMTVMZnB0bFVlNVl0VjhDRGRZdDFiM1gxMzFydzdCMDFw?=
 =?utf-8?B?bHNtczRsbFpIQjM5dWVVVE96Z3FTTFRDWHJTbVVIbVVZMVprSnIvWlpwSDhR?=
 =?utf-8?B?TEs0UVUyQmhUdjRFUDFySEdoalI2czR2bzIzejcvNXRaL3YwY3NGUi9zWUNj?=
 =?utf-8?B?dkJXL1hjYzhwRGdYcklOOGJBNnhYY3liRC9pYlZZdFB6M3pzWDI1U2wyVmxY?=
 =?utf-8?B?MUVWalZhR3hTYUFKbUJaY2Y1aEh5RGZnaUh4clg1VG9rajFDU1h4bTZQV0VK?=
 =?utf-8?B?YUNMZjNRUTlJcWh4SEdLOC9jYXcxSnlzZmtEZ0lnOUl3Y3NWMVkwNTkzbHMy?=
 =?utf-8?B?Mk1sM0pqVVpqeVZFN3o0T05vUXlrSXJTZktOamhFTDh0WmQ3eXZmaDZvdXAr?=
 =?utf-8?B?d1d4Y2oraHdXVDdpUm9qa0hLc2dtYkJDZWpzL1VyZGs5emFMNzBiTVYzNkRv?=
 =?utf-8?B?dEZxNHdSOG1TRHRRNENZTjRSZnZITTlLMlB4ZDU1QU14Z2o4bnNZWWhXL2JX?=
 =?utf-8?B?MWFRc2xuNlNwdjVybXlwSTBqMkt0MS9xNHRYSFZXdXpScTdjU0hPMzlodHIy?=
 =?utf-8?B?T0x1UkF4aG9BZS90d215d2JSZzdBK05NZ09HdDdoa0NBS0EwRS9Ib2xDSTNl?=
 =?utf-8?B?K2ZFNUw1bi9DRnhCczlHV0xMZWg4UEhSRU1JNExUK2dWa3FIcCtSY1UzUzVG?=
 =?utf-8?B?b2IycERXMTNoV3RRbE1IVnVZSTVsOU1Cb3MxL0NOZ2h4M09IektpT2czWURV?=
 =?utf-8?B?Rk5PQytkVXRiQW9BeUp1RlFaUGg5a1FkV0NkdmNoMW8wOWYzMjh2Mm5kK0F2?=
 =?utf-8?B?N2VRZEUzdFFMU1B3djR1bzVNN1dKTTlBeDh0cm5pKzlncUtwRm1uck0rbkt0?=
 =?utf-8?B?ZFhRNk5DajA3bllqQWhueHlORWJtL1BTbDBGWFVhRmRPS1ZtSFRSRWxUd0RJ?=
 =?utf-8?B?MXRkanRCdUtJRURGSXB0SWtYcjRwd21SZm9CVnllRDZIQ21DZnVUaUVXMGNo?=
 =?utf-8?B?TVNvNjNuSC95a0h2K1IyTFNGZGxYR1NXTk1Cc0hnUjdoZjhseUdJa0ZYVll1?=
 =?utf-8?B?VmJzRmxCdmFMMU04TS9uVEEzcnNrek1TQXZKb1dLL0x4c0lIcGhLMi9makVI?=
 =?utf-8?B?YXl2ak04dE9VOE1jcElDQ2EyVmcwbWlXbjd6YkFGc0xjWWJmRjR4RTI2aDZS?=
 =?utf-8?B?S0czZnFXRUFXK0FSQSt2TitpTnREMzBXaGZsYXpLN3FXd0I2TFEwb3hqV0Mz?=
 =?utf-8?B?ckd4TUQ4cUgwZUN3d3dWQmtiL01XWXZ6bjI2RnBaZ09GVzNOVGtBNjQ3Y2Jj?=
 =?utf-8?B?a2NaamhQYU45NjJTTTU5TlV3YnowYkZ2M1dSeU4vNEx1NFdQcGRrZXNqQ3lT?=
 =?utf-8?B?d2Y3blp4YTAxNFVIcWFKT09NSUoyMEU5UHEwUzg0amdvblhySnZmaDlWWW1R?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FB6002F4DFED64C990ABA1FBBEAE142@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YXhUSUY2S253LzZSd1N3eExhUmwzcURGVjBGc1RJTGppSHltRk9jb1FabTMz?=
 =?utf-8?B?dXNXeUcwWVd5dCt4T2FjK2pmUm4zdklmT0REbkJ0RTVUQTdxZ0J1cmxrV3h1?=
 =?utf-8?B?bWlpR2RMMTRjMVAzSFdwOVVqTjdkOU5IdythZHdWRXg3Zjk3dnRlejBmL2c2?=
 =?utf-8?B?dzc5Z25vTWdTM0RUYUlMaCt2dGZXYi9BV0NnWXhpYTVPNDB0bGp2dU5xSzc0?=
 =?utf-8?B?bzVISTJMNzZtK1VjR05yVjFnNzlVVGVuRXBsamh6NUpyYmFSRUFobm1JQXpO?=
 =?utf-8?B?MHlIM2VibFhzRExCUDBreUhNUGREVjRxcTQ3N05RSWhPSUsveEJoTy9HQ3BW?=
 =?utf-8?B?SlJ0K3E4VFdCTjF6R1lvcXBPdnpCYk0yWnhwRDNoMzFrYm5KQmFFRzFWNUpI?=
 =?utf-8?B?Zksxb2IwbXhuSFlvdmxBZ0NaeGh5MVByV2EzOUx0YkpYWVV4L2pjaCtiWjlZ?=
 =?utf-8?B?UWR5Z0I2TjM0Q2kzbDdGTE01VEF4eHZIbnFnbnd3eFBOaldtWjVtTkVoZEJH?=
 =?utf-8?B?YUFqWkkweFNIbG5NZ1ZZQlJXN0djS2ZrYkJCTTR6NlU3UURsUHNiQVU0L0Nl?=
 =?utf-8?B?R3ZRQVpYMi9wcXBnQkdqd3ZCWUI0SURxTkl1UHp0RXNKS01KOVFxZ0N3TTBE?=
 =?utf-8?B?enJUSG44QW5zMzhpeDBrSklodVNvRUdRR1VrVjYwOGxVeTl1bHpobENnYjVQ?=
 =?utf-8?B?MGRZQ3Zmb1JVL1g0Qi85VHpLNlE4YnlEYXIxU0w4OUwxYWpLT2R6REVKM21w?=
 =?utf-8?B?WFA3MEJKdms5ZTFNU05hcDdWR2tzV1RsSnNRaUVxOHRaQkFQeTlLNFhIS1Jr?=
 =?utf-8?B?SGRCVTYzUytSQTF1WHdjR2VLOTdTcllRNWMvYi8vYk1iTDlReG4xVDhoeFRS?=
 =?utf-8?B?ZjFONVh3OFc1Wk1sa1pMeEs3SmdPVjV6ZTN4Qy9FZUxaRE0zalBTcXZJTUVC?=
 =?utf-8?B?NFJrWUhXcjB1OFFRNXM4aEhRcE9ZN3ZvY3FlYXd2Z0hVU1JMVXhHbXNjU3Rp?=
 =?utf-8?B?c2pPTUhSN3c3L3QwRy93QUNPQkJTOGJ0eVZZVXFoaFZLR1BobVBjTHhaOUtm?=
 =?utf-8?B?Z3E5cVpQNWsvMkc0dzJ2a0NFOTBicERpQktxdGZjN0tSU3pNNnluK0N5VGhJ?=
 =?utf-8?B?c2xWVmxVNzFsS3JxSjloVldUUnFGK21abmM3dW9EWkY5UlU2bjNNTElrTUtF?=
 =?utf-8?B?RHBsS1lEMDltcm9sRFVaYVltNlh0b2gzUHpJbElPVU03RkZMSTM5L0g5LzhM?=
 =?utf-8?B?cTN3UE9XR0UvNjk5RGlKcURSSWZrMUk2QnZRY2lSVG96cGR4cmpsUlN5RVBS?=
 =?utf-8?Q?gnt8SCmNHdJtlYFlQe4gPv2A/8fs6OTKpH?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a087a68f-a5f5-4266-a34a-08db892b8158
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:13:34.9584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGCKSx3FppaljI0QIwuwf1UFeI9QYV8b4C56AYgMuxus8buecCoZtuBRwBzk6Dj0UclhOQ0cVCgPexulU7ENtfEQ1Y/vab1o9lTTPp3nkQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7615
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
