Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33D731B45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbjFOO0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjFOO0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:26:07 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A401FFA;
        Thu, 15 Jun 2023 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686839166; x=1718375166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qxobAva7Bx9XJUs248o40JSBfmsMuuzmTvGDZi5rlPspriGgOfXad7us
   3VeJQlR5t5tBO5t3Y6rQiY131MY9r1Of0tjIblem3fowSeZRgjpBU/we2
   8MyYCxe8YHgbkmSgBpLCilYNp3kMZ+EwpmqeRPpAwj9zjH8Rxda/Cw09F
   nE/nAfaeqjtJKK+2JuoCR/96X49sFhz/9a3Nl58cbfcrD3oj2dbam0t93
   2Oh2Z8sQPtnhmrVb6FXbmYX9aNGH11Vgm0E3U5nzetn9E0FUj31vD+wxr
   ptjRqd3RwqnJ20Oghn1UvowVeyTXTmSrFKoL93zLrhB60i0vrbQ1ce7n2
   g==;
X-IronPort-AV: E=Sophos;i="6.00,245,1681142400"; 
   d="scan'208";a="235887242"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 22:26:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr4mhTuDc/V1aIIw8jlUbYJcPr8U+wscZNPr0O/IwLp/8vMdvgXJkkADRW9JPv9gMI/P7LE7GBK4lCu9eNnNSAHEMOIRo3ZQ49+dFdjAmvDW7M5U6w//6rJXNAkEn0k28CPf2lU3GgU/xtWvZzk6WcoepugTh/IOKAL4xyn12iqWqK000jeOoQj99XJi+/YsLPeFlp61eYkX45ptHHPb3SO2s/gqpobB4EXLFYTpW+NGMicePfs0V0qnO1cUiH/wzv6SsgI19uPYH2tIYPwDn+IH4Kc0ZzbRUDd/Kzuic+mVFqpuj+XNcZwZps6veLVcqDZ9cSDQE2YWuJs/Sb0izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Qoel6XwodChNWsa4HK9aB472lAJdwUL6465cgBFfdwcNRjPDVo748zMtzGZADNvqkzdJDLmQYCOZ9qHXuoigJ9ruSLGbB7AMeyjlfFwdBMTSfgrsDF2DHdNIgyPy0rpp4UQkfhUpEzy05WPJ5vy0PX07sj92tHZLB0SFoMiO1rVrU1WLRkJ6tV9R1bHD+lSla68qj0EDC9eftnwbqUbciR5ze0CdX2/zi0sVFavX0i5TwNE2TSVeLK2BIgYa1J03GNVy5+yCdSTBYmnihnGR4Xrzyr10XjTs5dbviLOIAEkmiIwCDAdgkGZEz9MN6TTTR8HhJ5QCZze4P8+EiiM4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RfE+0KyoNOQWPnUnUaoC64jYuK9MhM1KWXmmZZY5kTNUxVXIcHkY8ooo7Ltip7YYIOrGXT9x8eZrvQCksZWV5h1HwvFYSZxEm2NE6V8C2mklVGDGLapRsdl2XuLGLgo/lIbhKogMxDyHI2bB17m5zN3BW4yjRXGTac5qh44k5sM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7170.namprd04.prod.outlook.com (2603:10b6:303:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 14:26:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 14:26:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 04/11] md-bitmap: split file writes into a separate helper
Thread-Topic: [PATCH 04/11] md-bitmap: split file writes into a separate
 helper
Thread-Index: AQHZn1WrRnv7GpF0C06vNFseVVFEy6+L6/QA
Date:   Thu, 15 Jun 2023 14:26:03 +0000
Message-ID: <9ff0a425-832a-d0c4-608e-4795cd1c6f9d@wdc.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-5-hch@lst.de>
In-Reply-To: <20230615064840.629492-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7170:EE_
x-ms-office365-filtering-correlation-id: 9e0fb5eb-2d55-41af-f057-08db6dac72d7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaU8pbw3c45tXOPuxun9hQdCQTpjTc4XJD6PgMPdOGg44Jt2Xdu0NROGkQpLrUVxWOS3Rsv32fMtd01xa9Sv2SKiTOWzOp6bDbmmYlSD1DBrXxuJtZVurO1CylQm17AyRptrRv3KRlf/hsxZHHcp51rbEpi1DEggu6OT/yT0/53SFtEey5LeR2sfRFIiWnkHMfoPjvKQVpFjwaZDuW7JdnPMxHHuWdRIYH0bWh5sLb365LXjXKlMMcrtyrz7QpbvUosc5xYPa19zy1dxpfF9mxNc0tW0StNTAO27YGDk/HmZGPXJFa+G+/rYO1Oq2Lse6XReQeSq96gIQ2xAoM4ySd3nhYOps4PwimtGchpfysvHT5xBeJUl+D2XEQVrwmnMTsjel4Jii+3B1zEcaYgC46aGN2w95zmkVvOzXTFTsk3sljpGPdXO2McT8jZEnYZgjRmNHTAc2lotMjjuiEseM0zmSaCM0ewZVGPfjnNkXXcnN07O6T0Rqa5V1890zPdgRcwWE51k5EJWXNBcnInkCscjw4eS9nPerkh5uTN4GKra8geZLiKpBpOu6FjiJKgst6QugCWZW43PFiYT/MpB/zhwLEMRhBdooiDe2S+zTpk5WilQtVcj6qmdXAsMeY2f/Q37B3oV5r2EBqLDVcRtqPQ+irIWDVYeijUWNjAnm3GAU6PRSF4sy1wB7mclV3fn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(4270600006)(2906002)(26005)(6512007)(186003)(2616005)(19618925003)(76116006)(66476007)(64756008)(66446008)(66556008)(66946007)(71200400001)(91956017)(31686004)(82960400001)(4326008)(41300700001)(8936002)(8676002)(6486002)(316002)(110136005)(54906003)(31696002)(86362001)(558084003)(36756003)(38100700002)(478600001)(122000001)(38070700005)(6506007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWlBeFIyaENSbTNsa0FTT0w4NUNOUEZLV2kveVppaWh0dWduM2U4QWNMTk53?=
 =?utf-8?B?cWd0aWdJRFNzdDJmTWpaTXhSWXVJNERueGcrL1Y2RzhXYTMxYU0zQjcrVmFp?=
 =?utf-8?B?aHBpcEh2cjRUd0VjSjl3MkVyYTFkL29tYTVycks4ME9uZy95QkloQ0E1NXhF?=
 =?utf-8?B?cURTdmNCRzNZYlIvaTdLdE1BQ28vUjhkSnZCN1ZXUGkwem1raTlEck1ycGNy?=
 =?utf-8?B?TWIzOVFzKytiMHd5YW5TL2VtTWRRRk1JR2pEaHoyOWZaVHJ3OUQyY0JQK1d3?=
 =?utf-8?B?em9vWGtnQURKVUZkemF0UmFYdU9KYXIraWJiWnJJQnRxQW5hSjdjc1Rkenly?=
 =?utf-8?B?dmM4Ulh3TWI0UEJnczE5aFJsZDJjR2NSeDUrQWhDaHZwcTVyWDNTNDlxeGh2?=
 =?utf-8?B?K3hCOU01OUNnZExCVVFUb3cwcFhDMzgzSmF4S2NYeml1RVM3QklsVy9Yd21Q?=
 =?utf-8?B?eFVrd2Exc0dNSlBWcVNTKzRlRGYwU2pQRmRqNXN4Nk5MalVya0JKMVJYZlJ6?=
 =?utf-8?B?eHpHMm0zZEV3SHFGZmZQVXZ6bGVabEU1Tjl1RnR2bnhzeTVpV3pwYkNlOGRY?=
 =?utf-8?B?aFV3a1Z4amZVZGQwNGxnSmpBdGRqUkRIS29XN0IxcWhoOTFKTCtXTEQxT1dj?=
 =?utf-8?B?bzlqQ2ZhSG5OT1lMQjY1MklJRWxhd3JSVnN3bjhTNGdlbUpocXRBQlN6Zlpv?=
 =?utf-8?B?TUNQTWdxQk1hRmhsTU9GMGZyRkJKM0xEZFl6VUZTb2NJZENqVU5YZU5VN1Jt?=
 =?utf-8?B?anJodzl2Zmp3MW5QOVVFMWdib25QeXlGdEhHUWZTeDM3Ykt3bzR6eEIwbFp6?=
 =?utf-8?B?NnhzUVVoaUd2Vjllc3pLRk1RWk5YUzhlMFhVS3JweU4zSkNZMEZRUEJSNFY5?=
 =?utf-8?B?SS9TRUlIaHFWVXQwMHppZi9pRVpjcmRFSXJKdGExZXAvcmZ0cDQ3bWh6VC9U?=
 =?utf-8?B?bU0yQkRQS0NxNDBUTnIyLytYTkhMaFJKV2JYT2NMQ3FQNkVJWEd1enM2emJ0?=
 =?utf-8?B?dTNjYmFTb0FwZ1pwWi8rZFNsZVY3dUNUWWxjaXFhNjdkU215eE5BSTUreE5Q?=
 =?utf-8?B?dEpOT21adUd1YWk0L25rOURBd0N3M09MMDJ3MzFIMHQ2eXVISGhlRmcycktL?=
 =?utf-8?B?QWVicWlZRkdCVUxITkh2dUEwdVJ1bE5TU2pIMkRVbitCbzVYVWNuZ3lYZjVI?=
 =?utf-8?B?OUF2VVVRa2lwbVhUSnpvZ0xKK3Z6cUJwRDlzaERpeGVHeDh4SlV1MFA5NHF4?=
 =?utf-8?B?cFNXSW5JSXIrdmlxRGF1RHc5V0lLRWl3cVBhUmdMZlkxci8xYnBibGVYQWVo?=
 =?utf-8?B?MFI0b0U5MTRaOEt6MjBCZ05ESFE5S1RwdVBhT2hRRmRzMDNkS1MrbG5NQjhQ?=
 =?utf-8?B?VE5PMDRieHNxaitjajA0OWdRZWplVVpIRWFIc3l3U0VFWmpDWERSUlVmMUZN?=
 =?utf-8?B?OVZXUjQ0bTloMzcwTWdUeU1VZGlpMjlUN2FKb29SRFkrTDkvTUJUS3ZzME1q?=
 =?utf-8?B?cUp0azV1SkE3dHY1K081Y2RNRVI2Mm5iK0p2TkZUUUJJUDUwVExsM2dqaERC?=
 =?utf-8?B?cHRHN1ZNbERvQmFrMk8valdPb3lnRW4yQ2ZvU3pCdDBoNkVGRWRXOG1KRWZz?=
 =?utf-8?B?QkRWU2NUSnBGWWpWS0pMZGtzSk1vUnJJQ3B4c0s3bFFmcW4rVXErVVhuZXQ3?=
 =?utf-8?B?a2dtTW1DY1RTMy9IQ1U2S2k1R1NuSDNMNm9UVUZWVy82TGlvRWhtSW9IRUpL?=
 =?utf-8?B?MjZGZFZpK2ZPWlg2OENuNzJOaDhnTXVFa1VFbFdaR2ZreVpqRzBLV1NFalJW?=
 =?utf-8?B?SkNCQlhNZks1Nm0vdG1DYmZ2S3ZLRksyeld2ajhXSW5UMVJyRW5yd2NTdlpt?=
 =?utf-8?B?VGF3dGg3QTk1YWl5eFphRzYvcVVrMEEzUXAzVEI3MitzR09CVnJRdk5VQ1Yz?=
 =?utf-8?B?WTFJVTh2ME1ncjZWOVdna3FOYm1WZGh4cC9kZ0hrSTU1QjFwbHkxUGMzTUkx?=
 =?utf-8?B?ZXNIVDRHTXhQajJtYjBKSXdyNVZ3L3N6SExvbDRJakNqaTFIWHhQUE1nM256?=
 =?utf-8?B?RkhrZGZpNVJBQlo0QzROTHpOSHVOKzZ0YnFSeTJmenRIa3kvcCtzOEd4U041?=
 =?utf-8?B?dHV1dlZxU01ZUGJJMHdrRXJDVk1sc3E1RHROVHF0amdLR2prcEtyNHZXK0I4?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A04F758A621CE4A89800041BFD92959@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WJKWDcwj6mpHivCscYiToNfp+5+lgaSNWfIH66ANOzssCQSQtmhBuEpRLn/b/Lc5e5SAXkuziWkUG1OO5wy1kKQyzvvDK9RYxZxJzrT3wmVzc/g5ZsEz1G5s+385NpKwEo669b0aj3O3yk44tnM6DXZ8yW6WMOlmvUGlR4aKkPmOnEMUQQGpR5o8Ngox8j7fd0wjU4+k/mCAlXcfll9gBBSAJTUpbQqOiHvhiplE/vPym3XGKPMac9E+xoXTj93/t6VTlwO626I2Q7t6puaLcv2HefxVPVdKu+CPhzwTbWZHgAcY4umPfriDismy7haX6+IIr1pKRt8re2b/aUgZV07a8rnm826Gk3s+Sgtn4tem2ShPivNWcziQz2q1sZl35pURs/o3lUUCDKP2GkwOq6q/tPUxqUb3S7+PUJtn1eZF0ZB/bTG/LtyfX65EKjkls9ro0V1s30tbUgS2x3Xsr07KURK50t9+kaMgllEVipjkYVrHUK41jdA8SjJew1k765G0/RmovO2pxN0J8dOBJ9a6Vfrp8tRwGbzbrMbAM31T5t0Qv5WFzVQtFa6RCmj14oWH+1ztcZfCCRGbi2ZYdXI8sMU9SGuF22kCefMo7RGoS6ByvCBuVT1qYjo5E4F8HBENIfsq8CFjcCYWUOnfe7S+QWqLdo1uNe1cJjjDOq+OaCCFRHiU5RQ29GerLk8bcV/ODRYojwH9uoC4JbtIajEfUPcgZrBxUNtLMcDZ31mu24umQ8shveaBRZgkwV+xVohT6k4WEjvuNzHCCEn1I3GbW9WNxh7sJM80lbGA9/KpxeqlZoNlZc8fIoJWV+zoD7J/lBkPzhzScbMLo47jow==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0fb5eb-2d55-41af-f057-08db6dac72d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 14:26:03.1001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKN1z82qVwT6sShDUPMN5KSniIydjD+p30mBlWq4dVUgwHTwgxs/UGNscsCck6TolNF4EmEZZWf+KIelzdFlajgoQoG7mkWSJQNKdgwHAgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7170
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
