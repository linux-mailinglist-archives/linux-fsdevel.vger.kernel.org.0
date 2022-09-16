Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B5C5BB104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIPQRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIPQRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:17:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6465B6545
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663345049; x=1694881049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bxllxoygucAl2yNpl6HtHmgmmcbCHNwY2JG1YK8a+rg=;
  b=g/xW9E5bYCffJx2ofhBN1uxekWIpAbjfyYBapTnA7xavPQeOyL5X4+2Y
   fkfAQD1e6DuSBbBOgMkeXRQsl/Yf+YZm9UwjG0puwb91qvb8yvFr8FjZv
   3K2LXTKeIUcaqGiRbNzADgNZMU9ttVAbLeZ7dIULSaPcENaRlxuLsQO7m
   UGoGJwzYLC93cbTkkINbs7rQqHr4RJa0rTT1AgUx7e06CQeQPvgBsMfvV
   ffgGLfmQGzvKCxea+IxOoGb0N5nfhkPmPPT0NTcSGpO1nztWaHqg/XUfN
   kL/2aI5ups0BAVslePQfR8sR+W7ssqWe8SQDIIo7BAW8KIFnHrNVhQPXE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="282052436"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="282052436"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 09:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="613302503"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2022 09:17:22 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 09:17:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 09:17:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 09:17:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 09:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk/fG7sOG9qyumNAbZN7/d/VVJCarCXClLINJj8KECxvZqE2CaEMvyMHMUb2aSO0FrX0z6auzaSFT9/lWpgAVzpRtod4YG5vVB27PjF+aOM1cNNUEyJT40hJVUB97dQLbIaDLd3ZvAEmtllCVcj0MLUCGYLGKPCAb3wUp6gqACMW9EELIyjs49svW6pX7v3yPDA+ZRWt50iTcWgs1c1Qiwyp3UI1fZQwg9bBcQ5p9V/1OCm5d/Y/qseFkRWJ3y3KX4xbrOb7uFYlJjrpEuySyC6k9iESURgHdQB9bOGMgoPczShMhqUwk+J4TL37qWItTDV+HYoNfHtekyKsYzPR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxllxoygucAl2yNpl6HtHmgmmcbCHNwY2JG1YK8a+rg=;
 b=c3SVSJVOJL/SvuTEx9x2G2XN4vLYuNcR3RNRCi03UV7N2PvNvXTY9SEPsTc7fdPDZ3WOz7CHuxbpHt8YsagSrxUUGzubEoKC5TuN3SDdTHUYBhHXz3lRWAV2U32eUkMhTv5ymvtV2Z97co7aFG1tEO2Sh0zV3TcKqOIHOqOxmDTLv9QPeJIjNTCSGcmqLkkmA7mCCjiBHb3Xq118SJQtKIOaZzLCo5imsywJ6a8bX0g5inbDXOcpw1zKWshf2ieaLLd5hhVZ0txwDMgGpR/Z9km3d8vcigPFY5rF0eVZ3m9jlFvHHBk2+D/loD5bv5tHDmszAEPbkZdMi6uJOqTWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 16:17:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 16:17:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "chu, jane" <jane.chu@oracle.com>, Borislav Petkov <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Topic: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Index: AQHYyVOZuHnP7uLChkm+T/SiMC7uC63hFndwgAAc0YCAAQeswA==
Date:   Fri, 16 Sep 2022 16:17:19 +0000
Message-ID: <SJ1PR11MB6083C1CBA41CB53183600B0FFC489@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
 <SJ1PR11MB6083C1EC4FB338F25315B723FC499@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <cec5cd9a-a1de-fbfa-65f9-07336755b6b4@oracle.com>
In-Reply-To: <cec5cd9a-a1de-fbfa-65f9-07336755b6b4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4902:EE_
x-ms-office365-filtering-correlation-id: 10b62ba2-2969-45b5-c7af-08da97feee1a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTHJmt4BT+R7LHm9tWvDv8vkM4gt4EhWaNBY444fFp/ct3K8qFrfxF6CcB3N7XH6yRjDlFtB++2iMtxg1wr76mG0QDVCChBlko5Egw05W5NaOGAP0UOJm9OR6EDEzGCJDz9ubQSMx5wp+G64xypv42/WzdwfmfRCWRSkajhAjtqDlOjcLos2d32vRDMNHl2KUYx+c/0eIJNZF4L4ufwmMiJVVpyX2Di/rk7xCou5LhV0ECQqgrC55uBLb4AZMVn6Wpv4X7i41Ak2cEK/VnSw+KpwOJdgscHmwkfO319bHcW5B4eqlWHdXZUwkr+FyMj33ynk5snaWBN9QXPNE2gX/5jPVpcMV+Bx+M9t3s1tHuuUmRtwVPLDLTbMHyh6QdwSNEhqM+ofz/PQEN/3yuqpNVB7q5cIXqVckILLFFPOcwhg/2Or8sdoX6z1tdald7X0Nw92Z6sUK8+BUPjPuMLJqjyowkj+d282zNQ3sl9H9H6kurxgoxwqqdKwNSmVVip/hCav2IqoYIuCi+deI2lja9chXrsIggnDWNgTnBzgPPs4qCwISzMTFEVoKLAxsiH19ybd+5V/45NNHJp9pkg1Eh7Epdsuu2fWofBSr82Dl/fYBGcEgT+nHXkhowsTNnzG63Sr+RLiUbZ+ngCHsjOzznE3QL5sKjrT545Hg4zBaJnZ1ij8PGqLh1HyEl1sBA6OhInmmuue0GORq/A1AxO58JTKCQu5A8UdMiVCqxplfw4fL+RCRQJY+iQCE71mHf5N4Zcy4udRDre3aiH4QN2eUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(76116006)(82960400001)(122000001)(38100700002)(33656002)(86362001)(38070700005)(52536014)(4744005)(8936002)(41300700001)(7696005)(55016003)(478600001)(6506007)(54906003)(2906002)(26005)(9686003)(71200400001)(8676002)(316002)(110136005)(4326008)(186003)(64756008)(66556008)(66476007)(66946007)(66446008)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFY3Nk5mZUhBNW81Uy9WSEhidXJkVkZ0SzMxV2ErNFV5RlBJZ0xsVVhCMHJP?=
 =?utf-8?B?Y3Bqd1REbmtrTFlneGp5VHh3NDF6UWtkWDQ1RmIxN0Z4RncreEduWHNNcjhY?=
 =?utf-8?B?YjY2bVZ5WStCczNFOVNoNXRyUVpZWVZ4bHdXVktxRmpzUStFOGFjdGxtdVVn?=
 =?utf-8?B?TlFuSjhrYlpzeTAxdXBsRG1IdFZxYTJ1VEhrMHB4d1FJVlJTWm9zMXh0UHQ4?=
 =?utf-8?B?bWNqU0xxbkxxWUY2MTNqcFR5TVhUUWRwMHFpK3FFWkJaWlNqWEpFb2QveXpO?=
 =?utf-8?B?MDM1TmQybkE1NU5CcnZZM1RSVzZlMzZPaStDOHNMdzlnbk1jTk9yT1c1akpU?=
 =?utf-8?B?em9QUkNDSDFRdExnYTBNUFJtZ3MwRVdkUWZDMlU5RzhqOHBDVyttNWxWL1VJ?=
 =?utf-8?B?a0dkbFplVm5KYlJqSzBRM0dmNmE4NmhnVUNITk9IUU5aRHJJRWEvaGlDVWlG?=
 =?utf-8?B?UWx4SVp2c2dEVS9abGhWZlJPQ3dFL2tqNHFjeGdzRHd6V0dQSWd0NVZOWmky?=
 =?utf-8?B?UFhZZXB2TFJDK3JFTzNpNUF3dXhzZlNyV0NPK21FK1VQTEJZd2Y4Q05GT0tC?=
 =?utf-8?B?LzFCN2RjU0lzN3h6bUNpckdCWmZnWGt2em1IRXFYa2xCZ3hGL1FtVUdUSWZH?=
 =?utf-8?B?RjNmSEN0bVBJSXhNbElmbEVGNm1xR3Nsajl1dFhnRERPbkJNajNSUmVNYjd5?=
 =?utf-8?B?RnJKUm90ZkZRUkFEL2VicVQ0ektyVXhXWkI5LzlicVJqays4UHpaRG5MMVdM?=
 =?utf-8?B?SFhONm5CNzF3K24rUVBRTmZBN2JRS2VFY1U4V09mTlBDaU9sclBnWkZlZllp?=
 =?utf-8?B?UERHWHlUWk5sOUFSdTRQWUI3eHJ6cjZSTGVPdUdEcDNrb2lJS1Q3MEY1dGZq?=
 =?utf-8?B?TGNTUGkvVk4xMWRxbGJ1Y0hWZ2hsZ3ZUNVNkQ1MxMHBYLzRNcUF0Q3lOYzNa?=
 =?utf-8?B?MHlZMDkvdWZPQ1FuZXNTUUJaRWRncmkzLzRzSWI1TWo3amVUUndIcHpSUkpQ?=
 =?utf-8?B?aHJEcTZSR1k2b0sxTG81d1VpMllKYXZOai8xa0VBb01vaFE0Zll2QTlUWitY?=
 =?utf-8?B?a1JEdHhwZk1DMXIwMVBDNUNoRFF1WTZmSmNabHRvTlI4UzFxZzZzRFRCYjlZ?=
 =?utf-8?B?azJKa3oyRy9ybGh3N0NzdEpSbWptWmUwcXp3NElZVEgvdkpNcGp3NUFFNG43?=
 =?utf-8?B?NW9BVXpZWE1WUjJpRjRlWUE0cWtPNDJvVlp4YnRjR2xGTXl1Rm1HaFB6VWlJ?=
 =?utf-8?B?Rzl0SVZkd3l0MHA2bXdZQmNIUEFaUHdQYzh2ajhuWC9aU1J5cW54ajhjZW1s?=
 =?utf-8?B?MTNJV0M4Z2FSRWdPdUVtNFJ0V3Fqd0IyeUpUN0oyTTA3YWRJaFJwbkJxRDk0?=
 =?utf-8?B?MnR1N0FVVlhvM1hTSzNiR1dCSTlKU05JRUUxNGhNUDVWc1NnTjNGaDlGSXAv?=
 =?utf-8?B?S28yYzhoZTVpa0FZMllPU0lnUkxUOUhZaC8vcW1VQ1RVSmtwZTBmU0t6Mnc1?=
 =?utf-8?B?bUxtRG1zMlBzeTNNUjdtVWxPa0FMaU53cGlpMC9vNndPc2Z6UEMycHBuMXJp?=
 =?utf-8?B?S0RaTXVVT0hSSjVWVWZneWU2a2MyUklxZXZraWZVWStYZW51R3FjUDhpMVlm?=
 =?utf-8?B?ODZMVk5vaW9XdVQyM05TZDh0RDhLLzN0eTV6WVFTTUhmV2l3amtSTldHbUF0?=
 =?utf-8?B?aWwyRkdCWnE1WFFqSksvTGRZNS9Dc1FlbmEvOFBRemF6Mm5sZFNTbXEvbDBz?=
 =?utf-8?B?cXhvbUVoZTRLNGplalZYaFZ2bGdZc0JXejRxbjRXaytpVWVOVjRMZHh2cGF3?=
 =?utf-8?B?NXlxbUhjV2VvZHpodkRqb1dZazlFYjAxVWdpaE9Gb1BaWGZRSVpEYWNjakN5?=
 =?utf-8?B?QVdsYnBzMXdoWVVKZ052OFg0NVJrc01GemFrZDIzWFI5OW42SVQ2SU42ck9D?=
 =?utf-8?B?enpwTEU2c0dJaUlCSkpSTDB1Y09PcWFaZDlHV2VqYW1rZ2VPeWpSWXZvNGQ3?=
 =?utf-8?B?SGZxODhWdktKNVNPTHpRWWp1RTVGa0RvU2JpRE1haGhoMy9iaEdzZWpWOWJr?=
 =?utf-8?B?OVJhSUZiR2FINkRMcW1qTy9la2xpeUJhdXVBQ2txMmU1LzlVOVppalRybkxP?=
 =?utf-8?Q?CRfMi9W6k1psza0n9e4bC9f/W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b62ba2-2969-45b5-c7af-08da97feee1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 16:17:19.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kc9VwLWoPBTe+bFQTt7uxDKVeX9snGRKJtLwUOun6owCT7npw8hLMSM14XCDHyjfDErMkH7e9sPLq9pjlZ9zwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBXZXJlIHlvdSB1c2luZyBtYWR2aXNlIHRvIGluamVjdCBhbiBlcnJvciB0byBhIG1tYXAnZWQg
YWRkcmVzcz8NCj4gb3IgYSBkaWZmZXJlbnQgdG9vbD8gIERvIHlvdSBzdGlsbCBoYXZlIHRoZSB0
ZXN0IGRvY3VtZW50ZWQNCj4gc29tZXdoZXJlPw0KDQpJIHdhcyBpbmplY3Rpbmcgd2l0aCBBQ1BJ
L0VJTkogKHNvIHR3ZWFraW5nIHNvbWUgRUNDIGJpdHMgaW4gbWVtb3J5IHRvIGNyZWF0ZQ0KYSBy
ZWFsIHVuY29ycmVjdGFibGUgZXJyb3IpLiBUaGlzIHdhcyBhIGxvbmcgdGltZSBiYWNrIHdoZW4g
SSB3YXMganVzdCB0cnlpbmcgdG8NCmdldCBiYXNpYyByZWNvdmVyeSBmcm9tIHVzZXJtb2RlIGFj
Y2VzcyB0byBwb2lzb24gd29ya2luZyByZWxpYWJseS4gU28gSSBqdXN0DQpub3RlZCB0aGUgd29y
a2Fyb3VuZCAoIm1ha2U7IHN5bmM7IHJ1bl90ZXN0IikgdG8ga2VlcCBtYWtpbmcgcHJvZ3Jlc3Mu
DQoNCkhhbmRsaW5nIHBvaXNvbiBpbiB0aGUgcGFnZSBjYWNoZSBoYXMgYmVlbiBvbiBteSBUT0RP
IGxpc3QgZm9yIGEgbG9uZyB0aW1lLg0KU29tZWRheSBpdCB3aWxsIG1ha2UgaXQgdG8gdGhlIHRv
cC4NCg0KPiBBbmQsIGFzaWRlIGZyb20gdmVyaWZ5aW5nIGV2ZXJ5IHdyaXRlIHdpdGggYSByZWFk
IHByaW9yIHRvIHN5bmMsDQo+IGFueSBzdWdnZXN0aW9uIHRvIG1pbmltaXplIHRoZSB3aW5kb3cg
b2Ygc3VjaCBjb3JydXB0aW9uPw0KDQpUaGVyZSdzIG5vIGNoZWFwIHNvbHV0aW9uLiBBcyB5b3Ug
cG9pbnQgb3V0IHRoZSBiZXN0IHRoYXQgY2FuIGJlIGRvbmUNCmlzIHRvIHJlZHVjZSB0aGUgd2lu
ZG93IChzaW5jZSBiaXRzIG1heSBnZXQgZmxpcHBlZCBhZnRlciB5b3UgcGVyZm9ybQ0KeW91ciBj
aGVjayBidXQgYmVmb3JlIERNUyB0byBzdG9yYWdlKS4NCg0KLVRvbnkNCg0K
