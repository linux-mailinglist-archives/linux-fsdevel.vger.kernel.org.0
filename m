Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3138F5AD69F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiIEPch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiIEPcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:32:03 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC8FB60;
        Mon,  5 Sep 2022 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662391857; x=1693927857;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WkX+OW0VHF6JXu7mSGRTQ5nWnXUoeIM8uzVeBnO7+48=;
  b=nuqJA+4QbEMLkNhlUVLk0gsgxuOY6tdd915li9+mm8YHJuLx9g+SHBr7
   sFgKt2Nh0HhbQvJvgx8iRgs2v1AH0ZRn2xIBWScqhur2Hk9hyD5ca3Ogs
   /TN5twvxz/+hUNKnLe15odcpIJFTRSXipzPWf4yiHwX+iF4hwZi1dVtCo
   13ka/+aZwY+5wKeBJaiBaG9vCXLlXgzB86c3B52GI0i6z5IbIcYjraQu7
   AiP8p98xuiB9P8U6hJX0iYeIyY2jLtQDfYiPOcD/rYN1H4s1avNim9EtA
   kR5wKLTrIGCTbucmma5B7sUy9b/C7ZS76hgyw/3ViwjJgF0tf17tMlfmc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="314826068"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 23:30:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Imb67zbOLqX9e6pI7RenWz6512xCnDz+HGOgW/vj+NQmMwgoJLCLMtN/UDsoh/HoNPGEJnNVtcrXrxC4Vp7QxRtQpoZuIQQRYCNs7uhc5QrAdQgQRfN24TR1idgjC5bvhVpj9DTZSKRz5cqMk91doSjqGyzN5H3uaOXLR/xLfRIAk4TcynzZLdj3jCVpDnUEfG4s2iYgk4PWoOky+zoBRUI39SEvcIQb0TvuL/YKPu5UhWbhmdKYyEPhY5Ds5FvG3EwvYBIV86c+TsKITnupKcQvTLPiocZmdK4Lj9PV4cscki51CWPYOTOuwtvAWBQToIhqUG5zAzAOuBG73q/evA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlYBNfaVVgjxXDxwYE57K7OshX48T5mJAcpg/ZhZeBk=;
 b=XelbzcCYgOy+srETHNgRIhLW0BC2ujvZdSlgY/XZooPq2cYFygONDyGZJYnIihBzr3GJ40L8bhpUAMD7+nDd5fBPc2bfvNxEGGAHS2Pn18I8ijnk5T6/+vcyiABQZlPsGiJNe1njYiA4K4I8jURzmmtRW0k2XHGiUHyR2GNX9VDm5iaoU7FzBYTKScJI+Lcs5oUYnBeiR9lGlkK2lq7/R/OzVvl0NsfWciITwty0ujm+HPFmOuMWpdgrkz2EPgPnZhBxYro07OmA+Lvt3vL/ikSqjQjlH3AAbfxtzhlK3DPC8qxETjWsRFFOWIDRr34nt2s9zEX48BdEYigIEf0Rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlYBNfaVVgjxXDxwYE57K7OshX48T5mJAcpg/ZhZeBk=;
 b=ImMmNLxaWCiEAanFDwTkfKqQrjAcrqub0Bdnz5FFV1gueUqqNsoqVuvx0C+hHmowzMuz4byi5vbobA7vHeAe7w0EUhnAdTaBdeDPQGKxuTeFgkD9Ghgtq3yEgIi+nTL5U/bsYSxmZ62a7uE+Jr5zv902xJFBpDIXJmUPEwlcwak=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7956.namprd04.prod.outlook.com (2603:10b6:610:fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 15:30:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 15:30:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Topic: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Index: AQHYvdaJyAEeDCU+DUSQMj+EHyZpYA==
Date:   Mon, 5 Sep 2022 15:30:53 +0000
Message-ID: <PH0PR04MB74166E3D3F9CBD8F8E5C16509B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-17-hch@lst.de>
 <PH0PR04MB74166908EB6DF6C586B5AC539B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220905142543.GA5262@lst.de>
 <PH0PR04MB7416B4597F2F3426A85295A49B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220905143951.GA6367@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0c45dc8-497a-46d8-1576-08da8f539ee0
x-ms-traffictypediagnostic: CH0PR04MB7956:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fuT9UJWT3nUQl2F2BUGy7309fSCadeGqdoQyv5lDMYR0h8aWNFIAhe+frHN6SbkGS4+z/9m+Qv6A6PHkp8zdgGKSi4Qr+hfOj69miLYb8SlWdBF7KmIozhlw/1/WQfjcN4q4V3thV8fYvAPutg98FRWYv6X4lfqk/oPRmzf+7CQQfYfpIXly307Zg0dGNek1WzDUccgdLXOqGpCSAp3B4mGN+sw/HGp/e8Ajv8Qt9yukDV4eEQG7QyUs3S4wnU3OlZPsfP2e1phLT7IJ6OPXDSJQYMf7vc6O7JhnrBlAHgf8z8Kk3aSizk6GLf7E9uA3R38QNHqb/4lRZOZ6xXZz+RkqRc+U6YcrIpNIOnUaqDmPf+bLHePiE4WHeOviW5pxt3G8hWPiEkntVFqwCttRmO+MRR/wNU3zPjSA8Sy5aUehj4dsLtdVaKW+2aWCkaRvPmNw0ByxQ9W9ffks5kVWbNlzTlssJ0EM9FaOb5Qi4pJ8vVwwZoCjf9e0C3yMFtwpnhrMVXg5lrBscl+FtUvz8mPX9VE8+OPUSNlOQ2J9mJDcbnqwUvZUti+pDiEMecfL1MjLu8uPMmobonVegTRDvJ6AEImLBFG1gMbMRyhxF5TfIPMNaEo1ibH4O4GY640jCOAI1AIIKDzWCOTKfLC0fQlI+gMSnFEBq3C85Fx2zdz+tfqjJ0gzWDdtDqdTqI8f3fbeY0uXUo+2MFBx06pzfUMWbeaIBfY+xswHc3wY2lQU+yL+8DcYnC7Q9I6WLaB6zvgk2ZxnIf/0p78AIgmwTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(9686003)(4744005)(186003)(2906002)(7416002)(66946007)(33656002)(5660300002)(53546011)(64756008)(4326008)(76116006)(8936002)(52536014)(316002)(6506007)(71200400001)(86362001)(66556008)(66446008)(38070700005)(66476007)(8676002)(122000001)(91956017)(7696005)(38100700002)(6916009)(82960400001)(41300700001)(54906003)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?es7fn5u+S5iNOd5Q/5Kay5DKzX+xmZZsS6q06ST5IhhAHsl86fhJ0x2YB4Es?=
 =?us-ascii?Q?pn3FgOBzh+WfaUQIWQM4lzQfihMSveHdMnw8MtnW5/4SD0oj+HwRnV4c1Y2D?=
 =?us-ascii?Q?og6x3Zpc/NJkdDKvY5CzJc4NS8OzSbFIiPYihajwrtSBM00P40RxZHeB8STo?=
 =?us-ascii?Q?FqHJJcA7peBv9fX3WO+RNd0SsHtt3obR8m3tha9zJp8BnfcO3U59inoRnk5/?=
 =?us-ascii?Q?FYZfbqrMLkbwCCItjPZ6PB53Pk5Awx/RA8gLV4ZMhmQjRpZU2VCX4BLWv1VB?=
 =?us-ascii?Q?vxO2VuB/Nut8xwrx96IYQETJFNroxMG1QSWhE5WEkAwjcetNNLBBlo1n4PKY?=
 =?us-ascii?Q?lBkcZmIl0kf7KhxLyt3D7a5HB/ooFQgzh1qlc6/goyC4cJ4HswTd5/kZxXKG?=
 =?us-ascii?Q?GUaajfNvtaxcdQmu0cAgxNxtU5U73iI9DF8Tj3cge0QDgTRgp9d0lQtFv4/C?=
 =?us-ascii?Q?xSCdRtsk6mxhR6tsueBMYO3vvCkIS1a7yPJ4ZtK/eCIi0vUZowA9Z4m9XEgv?=
 =?us-ascii?Q?RIsj1gDtxJjq9DZOZyFzMuDUxRLQ7zZvvvPR7iEGTh243Xpou6G1YMcUaHd8?=
 =?us-ascii?Q?q/Ioelo//+jb7FOyD5c+hQVG5lGfHuCV3f490Uc28Y8Oner5g3IABARrS/lQ?=
 =?us-ascii?Q?ZIFW/QKvamAsUQ8+EfyyTtbEyephAMFP05XyaFwL5Si28JKNAJ4E+fS+2r3z?=
 =?us-ascii?Q?daECGIN5puNA7rgGpcA2/5wbTHuj+hoJ/APsV76+aBAvonka8h7XwHsmbzHr?=
 =?us-ascii?Q?PC7LDM+tjLNrULDvhA/lY7FQi/446z6/Yt3Z9ucoVVrY7QWrtgeRwENf2LWI?=
 =?us-ascii?Q?WXhSC5RPquhHhIqYR2sSeJmIcI0uMNgIgBpG/BscvRIjmiTRF3sJjfVVaz/S?=
 =?us-ascii?Q?82rchX/BK4BiUhz/cH0pNXUvfYasNZFeHEya1pDX8mBD7u5N3q4IOwNRXtID?=
 =?us-ascii?Q?ZhIhBfAatQcIn6Fxgn+QrFzSGTA+0DA1NQo1P8m5PmN1Hv78WqAs3Yp6iZXw?=
 =?us-ascii?Q?PlcSvS2yu13apl/PtF32vIc0ed9O8CYUu/fuE7QWciI6Gwv+l1J7Rd579yqf?=
 =?us-ascii?Q?fykMxaSr6GV8CUU5NB6GbLy/PbVK9APsNBZ2qhT1a+6joW7IdCD0vKaljSlS?=
 =?us-ascii?Q?sirdFptU6QhxuwBtwE70t8hGKBzGXZAUhQWFO2RbvVuEqI6yCH4lGc8LGdd9?=
 =?us-ascii?Q?+C2IhKhMKd+UVbT+Ho39eNRWdCBESsNYH4S4anlD3LkGQPjgJtmbwj7t6bOG?=
 =?us-ascii?Q?izMB8KnFki/EZrBf5e2YKSFFHiK+eoA5lmG5vCmdqZdpGpiQMN/30vZdf0gI?=
 =?us-ascii?Q?mDf5nWmvfoiFcuXx6ydJSuLMM4SS6lkbjAg8o92wuLS+xajS/nqi7p/JkisR?=
 =?us-ascii?Q?dpTCF6WmGylbQhCi3u8pdJ5jmnSKmwT+LRXvkE8r/+rdubuywV03YhFAX9zR?=
 =?us-ascii?Q?hBOp9+3FuXmvbblSsH0zj3bkPAAuCRj5x+S2xfHz94d5l5eDAX4oEqRnlOay?=
 =?us-ascii?Q?fWdFzhLusEqXiRsHg9QTq93hLdik3FB/8A4kgZAqFFkJADnNqXJy9SXH7btm?=
 =?us-ascii?Q?bHdkmo1DRBHsBpQmw4YKgL1fIt07IMhPNyXnIjojBB0ePBr4Lc9pOyhzogaq?=
 =?us-ascii?Q?P7QJEBWp3Gz9l4En+YvvU5WzVehPw3hwYcBQpRPqFhITigxVPEWKXZISicjZ?=
 =?us-ascii?Q?Isk1r35WA7YkDQwbvszWaSLlkS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c45dc8-497a-46d8-1576-08da8f539ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 15:30:53.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ji1D9f23LeN8xriUg7mYMm4uZ24WEbGH4BAzE8omnVbgnjGmg7gsUcsiRXhSegQwCKC4yHruhlxmYdJdloT3SCgJ7Mu0FyKiaQzQ6pJwLM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7956
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.09.22 16:40, Christoph Hellwig wrote:=0A=
> On Mon, Sep 05, 2022 at 02:31:53PM +0000, Johannes Thumshirn wrote:=0A=
>> hmm I got that one triggered with fsx:=0A=
>>=0A=
>> + /home/johannes/src/fstests/ltp/fsx -d /mnt/test/test=0A=
> =0A=
> Odd.  Is this a raid stripe tree setup where one copy is using zone=0A=
> append and another isn't?  Because without that I can't see how=0A=
> this would happen.  If not cane you send me the reproducer including=0A=
> the mkfs line?=0A=
> =0A=
> =0A=
=0A=
OK it seems totally unrelated to your patchset and introduced by my patches=
.=0A=
Odd but not your problem, sorry for the noise=0A=
