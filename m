Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA646CFEE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjC3IqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 04:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjC3IqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:46:10 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0760C7DB2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 01:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680165956; x=1711701956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=NRgjuTTOFGkKl5w5FqihEElI2dldAoM9h6LbCw1A5P0BAsKiIAtEhbsv
   KnrdJPKlkHve9IPqqaosl5FwFREwpE+AAcmL0Z9RoPDCxIb7URFfHjKiV
   BVtoJR1pklPn4pK0XUS395Uimr7UBdxdykPUibk0+drdKtJcMqoKWuWyB
   rJZE0fbMU06/uAdIgE7r3Yk26u7AOQ+GuniIOiI992a/2zFzG6chpjWnL
   U0qu9chVWot7ud7b11tI+9CJAsNa0DgnLVC2CwYwswfSq2jCjX6HFBbNg
   nv+tbaJ7Sw+rA8nCrhBpMmh7zb+pEJJsoGMyNu6cCIuo/m3F0eUtX+T8D
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="226864551"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:45:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYFKehdwHONwv0kgO6weWHod2EsMaPh8Wxgs9XhoyB0IY6jsHGIFKNSFeadW0k6VwoeBQXRyOo07adRZy4+/zNU0fhWb06Pn3dXh/ZzeLNAr3+C5bOHlcm/ewp+jlX4uQcNjz8M+KBuceRdUYmQ/NiyefglP+vvZ+Mdo1xhEXgo7JocTudu0RMYr7Z5OmIXhN4OC4AzCIp5e8bZESp8k5OEHIjnINSJ/MoJxSausyf9g7sWr5XsLHulhqLqrqFzg4a8sd7ibeluuSFni7LtFTjHAODjpAN3+dPzh9ReM97BqDjk5K0E/Dauta/QVdkqqmHQyoz+sce7JQb15NZoVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UFRcpo5iDZKnmAjkEpmPV6gWMjx/Myms4E5dmyurFbWK/MhjgfBhYOzAoXIMtKzVpAvmy4RMEGU6K+/CD6mx9gY/vxtR0UrxnwdEhKZamIwwn5HPGMdwS/u+vz74NrnKPX8aQscmxC4LJGl7X2q4oQRqrzXoKCI5L2ty6q46zCBhVYnhdvCtEhHnOx2dTKdFW2eYg0s6eFYzPUaKAa6W+vzmLW/5BQ6JlgaO3HODAIm60qDEE5v1fLf5sQp+TEBK1BxSaed6m/qLoHVEMB9og+JEz4I/Abd1MNqz7P6XXVa961K/rT6vGCk7uxIQTPYv6YO1QkSK/ZPAM4EmmP3B4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=G/J1KBd1je9SF4Q4JiUIYIcP0QZVA37k3qz4iDYap/VsZgZej3bi58R49CJLVhmuuXmlzL98WFsCkpCr3Y3e88J5fb/hDe134chKxkhBSJ/d0+eGMZlCUHPOYPIXm3f5/GqbdC+7/T6y/5Bq84F5jXG7aeeoV6NXIEQOvWN4MSw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7346.namprd04.prod.outlook.com (2603:10b6:303:65::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 08:45:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%6]) with mapi id 15.20.6254.020; Thu, 30 Mar 2023
 08:45:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] zonefs: Fix data corruption and error return
Thread-Topic: [PATCH v2 0/2] zonefs: Fix data corruption and error return
Thread-Index: AQHZYqqQI9LsIRi+9UWgfUdAVmBte68TArkA
Date:   Thu, 30 Mar 2023 08:45:51 +0000
Message-ID: <74e8bca1-a09d-fe6b-36bf-f9030612601e@wdc.com>
References: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7346:EE_
x-ms-office365-filtering-correlation-id: 0aecd628-ec25-4685-7e77-08db30fb2ac4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VXAWRXNIS2WKSJtKrFYBJEI9OddeuG7/MYqhkLZ5/vY7Zl54YaODARRvUSzv2KkPBp+d5Vpvn9hv5hG10jMOJJqm8y23sE2crPqadZDy4bN3jjJDKP82Etj5R6SHfKT1eQzmro5/FddRVUwZr1JTfJzy+O2Nk12smxlkUmBA7w82/PyjQC2XNcb6WvrFUJzmcKRwHSw5lozajEOBoshyTqHBNkm77W9j5qCLPoqsSMCvhiTqlu1FZspn24VOVczjt4zTfBC0spG3Dc6FC0nh6yCCRgGPIX0tIRlil74gjnFBfDuTzducttbrUqUBSDm0JXKK8KUqFI/cHMO1MutDqbkSqPh/DfmpcktHtvyFXsgCLeQJRNoVr8Ls9R8IUwi6Iig52bAqSB3bmCbsnS4ZSiyMTvnK6nzIUbpCr/2moMnevyG2AGS+jS8qBCiBbtcvexESHTNIsQoq492Ut0HJKns2HFsybnB6OjAobkWQPoTLrzFJLL4Fa4exhKrnoeCV2poBF3HZRd2d7PtMI20yEvh83n3I2Nm207cF+7wsbdky9Xhs7SCrLiDuYuT2Y5mu+CVQmLX7VvaRI+GyV4Xy45JmxG2rcGm183ZtWune1gMLtSWJfbpN+OV0PyQGrTegbm2XXPKVQoEE+xMWpMSCF6INICTDePGaz/A17DJFTx/kq7Gh958XpR0LSWR/Ml8r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(31696002)(66946007)(82960400001)(54906003)(110136005)(76116006)(64756008)(66446008)(66556008)(71200400001)(66476007)(8676002)(4326008)(91956017)(316002)(26005)(186003)(478600001)(6506007)(4270600006)(41300700001)(2616005)(31686004)(6512007)(6486002)(86362001)(558084003)(36756003)(2906002)(19618925003)(122000001)(8936002)(5660300002)(38100700002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnhlWGlFUkpVcFFaeUl5MEYvaXNmMlkydDlTNGYyRHY4NEluZlVxZ2xVaTFM?=
 =?utf-8?B?RTNyOE1VWXRYeFpqUERERnZFdDVIaDVzMXdCd3RkSmNlVUREeUprU0pBWVpR?=
 =?utf-8?B?LzlKK2RKREZudFBNU0paT0MrVG5ES2RFNzNnU2s3SnlBWWpzdVlqOHJ3NThO?=
 =?utf-8?B?bnZkdFpaL2hMVzZNZXliZmwxZkF4Sm0vSzRQamlCenppTVhPRUM4d0FYbksy?=
 =?utf-8?B?QzJWMlBjbWdHeGwwNVcxazV1UnFGSFV2NFU0ajBrb3ZhYVNHWlBSVGlGRm9F?=
 =?utf-8?B?Q3l6eUxld29nSzlaSXg4WFJ1MitCTXdxT2NIWElhbEliTHFxU1JOWHJhVitH?=
 =?utf-8?B?cWVyTFJWWjYzNVUwU3V0WWJGcHZsbHhvTnhLRVZzNGhoUFpFQ3pmQlNMRHRz?=
 =?utf-8?B?RllVNzdMaEdTUEk3ODVzQzJaMlRjRUJTK2dCVmRiSzlmLzFIYVFXbGt4Q1ZF?=
 =?utf-8?B?cjVCNlI1V1R2cWl2eWZBVVYwUm9TZXZ0dkRHUGl2RHJiYnRkZmZ5azdTUDZ4?=
 =?utf-8?B?ckZMeElIUnVRZDZBY0tnK05UTFpvVGM4WmJuUlFOWEdubXNwMHNLZ3VnUVdt?=
 =?utf-8?B?WW1IalBjZUJ4RDBaaGQvRFZpbnBkZCtuU3dGdmhuYnAzQzJuTFcyY21iZG5k?=
 =?utf-8?B?MzZVU1YzdU01Tzd0WUZVSStxZlk5amxSeDlDOWpwNjhkR2RpNHA5anNKYU1V?=
 =?utf-8?B?Zit4RFVJaDdNYVY3a3JBMGlSNmdvNVZlNm9PWUljWDBTV09KWXM4b3UrZC9n?=
 =?utf-8?B?N0MxbnRNVEczVXpQM2QxRTRRWTRCdjhjemZYT00wUmZrQ2x0SE01ZURrZlpG?=
 =?utf-8?B?SDBuK1VUdUdGU0lIV0k0Ly9OK3V2ME1EQlA0NnZFbW02VU5uMStvOHBmNXVk?=
 =?utf-8?B?L1pYbk9PMDdEdjVOSmI4WFl0SHR2ank3bzNqK0N2TjRnVFZ6RjZ1OGYwVUVT?=
 =?utf-8?B?enppTmM0MHdTUU5VaGRwaDB4QTRxSy9WTGZXbk14VVF1TkVPajl1b0FyRVd0?=
 =?utf-8?B?NXNUejVIWURsUVVvNEN1ZEhpbEJFdHE1NXdPR2F1NWF3R2lUSElMZi91cnh6?=
 =?utf-8?B?S2RLMkVickFKTUE5bVN4VDZPb2txREJ2VmJJLzU1OTBpS1VTd1ZEWStvSmZs?=
 =?utf-8?B?SENvWG1aU1pqU3lyMlRHWGtEVXdqdzh0Vi84SHprUW1DenFucTlaOTBZc25n?=
 =?utf-8?B?NWNndk95L2hZODVCNndHOG1FQ21PUHcwdE45aERUTHlSL3FRZStWblVTd0VP?=
 =?utf-8?B?TW9FRTRoNDFpbzBGZDM5V05UN2pvWlR1YWRiaWdMdUNDRk1RZkxlUkh5YlZz?=
 =?utf-8?B?M2JtRXZ5WjBkaVVkZVdsc3BLYUFxcHpja1haWnFCSi9YbnFzNTlaeDFZUGdG?=
 =?utf-8?B?emdFYmlRL09oMnA1MFRlZnFPOVhZSVVVWmlRRFpqdXJnV01nd3BsbXkzNktU?=
 =?utf-8?B?VUREWkkzN3ZIbHdPeHVZaDR4QVh5dG9GbWJ5eVdTbFp3eTFaNk56VzJ6enZl?=
 =?utf-8?B?ejdtYlNib1oyMzRQaW9qdVo2bGJXbVIremhtdktDSkZkSWIyRTV0NEFjS1JJ?=
 =?utf-8?B?b1NEWjdGWHV1a0FvczRxZ0V3RW5tRWpXVVd4eEhMQjhtbGgyaExsSXlsS2JY?=
 =?utf-8?B?N1AvWjI2Y0FZajJUWlZDMldBbHM4dWFzaUxEUlJmVzI4aGZoZU8waW16Wmkz?=
 =?utf-8?B?SHo5Yzh4dThMaU5sWVYrYVNBSzJydHduWkpFdFRKbXpMbmF2dElOcnUwMTlT?=
 =?utf-8?B?MWluV3pOZkJnVHdrYzJJU1lrOVJCcWhBcm1MQTgvUk1uTzkxZkQzM0M1YkRJ?=
 =?utf-8?B?eG5CSzl1eUhBOGNBbzQ5eTFMQldHSTBJTkFZeVJHc09nNVdDZ0lGMXQyRDVW?=
 =?utf-8?B?RFlpWWhYMFJWeVlTdzBiamxVOUdnZy83Y3Vkdis0WWpSVlVUa3kzQ0RsWXN3?=
 =?utf-8?B?Q3B2TVN2OEZ5UTVqVEhYUjdNRnNwQ2xxOHMrczVDVXc4UmJwZm1HMWI4dkdp?=
 =?utf-8?B?a3JQVjVHd1BxOUJpZS9aSFg2cXdnSFF0TjBjMGs1bFN0eGxPL0hDYlJpbFJ1?=
 =?utf-8?B?NEY5T2hYYmNBV2FxK0F6c0phZnVUS1hIUWdOZnN2VTRLNEt0bXNGSHkwb2ZD?=
 =?utf-8?B?SXZhVWlNd1djK0sxVDVSbjgyeXkyNGdJbERXSWM4ZzFER25Td0lhV2U5WHk1?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6D3EBA936547547B33C0203A09122D1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j2X7tP/sl3JGSlP9maVgTZ0Y2zpimcBGey5hIcqMnIrxNmB3sUSq1tuZKlPh8TlYrH8kqjJEpj9zF1QIpEw0Wcbugjf/JYJwcgXqOCrUTLByEw7TdByO1iLlXuwgmPIBfP1xFslOF59dArrFhA27L5Fo21G+fxIVjuZg3F4neBmh5HXCh17nDfYvL5CWz7PTwFTBjrZPkmUFjQAKWC0f6xzqsKDKWSei+nTFGGhVVb0ceGy48OsvzgoUXHFdC46lEsD8nPXShb95m4rStuJ/d4p3WuSAAk4WD152AzkH4Fof0qRcgJA/pwAemnfxEWlXw+mvVgs8Qer+2XzPu1vdG0PHmurdKHXIf1f2fGGnzZg3Sl6XQMjl1mMAzvXvtJXgkTYmQsnxjbmRDWGh21kbif5jYobAYMDYIMr4ebJquzHvNZfo2JAap2QkPNsxazZ+CMis08KL1ctBuD0099sSlELImdaduaOvZTjDBzKYSgBEBwdO8tc+5RY3KXXVMABbqWmdGIQIbl64aZwlNv0lJt4X9AJNNUfoKCOcnvQk9XZIGE/BhT5L42bt/W0e1ufUjIZVal/QwjCAF+lIOJ97X66DHQOx40RTmej9qAJqABuJfd2aWwTPpVNUS5I6xehG8/9Yc44kyBtbaBpTrpfFxSPTdLzXGE3bP7KkpJwqTfbVSahZnO4Wv/QgebLhhoeg7BYfR6XuBmFqzFvn47j+YbMOFm/4LjmQGXEjElYGGvfPwWVRYpEp2TmTWqAGXuK1caR3uoolReSHbADvNf6TQkO9jnq9Oz1SBJraapkxue0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aecd628-ec25-4685-7e77-08db30fb2ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 08:45:51.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuueC32MCTUifY5dK03G8svJnUmrNL+v1kNJo8bO+9HMDXSeEc7mpoZeyXlYBXu8WNOgxScyM+fXJTwJZZpREwjfQZ158QHXPkjaKuMorzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7346
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
