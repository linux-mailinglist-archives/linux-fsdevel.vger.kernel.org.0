Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36675AD385
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiIENPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiIENPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:15:23 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3B21267;
        Mon,  5 Sep 2022 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662383721; x=1693919721;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=czVkjIiov5bidj5X9RcXPCVHeClCSNPwBA6ExcvCCMU=;
  b=FVU59+MoQwgiRKA9IviPuSvKqtgrG1GP0vVe37BkXmHGDFG/g1LkaHeO
   kLfyI2Hd3hoLf+sftLPvCodPmG3qm88PMS6q82BhfFOqYDgel6WQaHbu/
   qjDYa8hVJPwQqqUUAh2jcBmCYWw7uFWAHHLnO97OrD/FH9w65dbVJwY73
   UZiyBk+RBzxrftaj8x1c/vAVZGum/hqNw3/UC7P3kAVj5W1WN5mEZ2K8y
   ztqlKgSEJj2NGeWPV7Cp7fl5yOfyVcWeA3+bXUGktPxpaBYr30Scf1p4r
   gSXsnaYtJqj3Zhh24Zktm4d0Q1H6fy0C/mq+sBP2+nr3wOnAMWn4Gu457
   g==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="314819068"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 21:15:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCEFOheyHwvYKVWdkDaOdvEXI90Ch6kM29if90lVm+k0MBDKSnftV6moFWQ7x9toUtPqsyANXbZTu+DmavZ+NjnLxe11lN9tphw27ItTkQtHHQUkwYJ1Zz2iRm5lf0ugHW6tnWePavNE7u32Ej8aTZsp9gbSzXauSYLbId//fohztVjoWNcGGCZhBAASRa6hCuyoEwjyTjBz0/zuhSAoWiJsWhy2d7o6Xd+Z3dKyTSVU4Nw3/WRaudt/Z7aEoLI+lRpPWa3lIZLI4p2JIgUNTfCbET0uQklAJogR9ZmxFz4vopoouI9Z0zevhrV7aHNH9cKiy54DnlWSG9nrBfGc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyJMjQqlZJF+dF9gNV5Hv+wTWNp8abrclhj5fPAZdUo=;
 b=oa46kwgtSbYIn2Ui1ZLzCxaJp7SIHpPCOdPIUMqIJf8amj22n413PvZicQoC/uEaKX1rAXAiBqj3jEIQ40fA6gP4TGnWmk3a2j7blQp/KEnBvdO33xSYtjKfwNcKTR0Yz5/1MpvdxaXixP32IkClW8w4B/CTwecLPIuIwgBkRYFyGmC1YdeRXTWwwwGNmrdOBlqc8HZzLcEVtBCaKsr+N0kPGkkhp1+/YpMZ1N/UV1jBPNAV/bZa0YlAYzWKKVpfxPMya7BqOEmAoxJjGAM7JiN5UQ5GtFwb1jeMrnEEtMLzZmkPytHVWQKVcNGjgZAHYlIthI3EYVmZpdASJAwzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyJMjQqlZJF+dF9gNV5Hv+wTWNp8abrclhj5fPAZdUo=;
 b=xlATfznAbAVVtTToCb+cD4ulvIZNIesdBkpj/MaqPsbM4XTK7cY8zEINr+3LBcRGn2gwgAjdcVYa7pP/y7lCWlINmO6l3bskkkEQryflRLJzI8IKebelE8UtteC6xGom4RLzKVAJwYv62aI2fLB/biHqhKu+8f3zughRw/yIDR4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4083.namprd04.prod.outlook.com (2603:10b6:406:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:15:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:15:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Topic: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Index: AQHYvdaJyAEeDCU+DUSQMj+EHyZpYA==
Date:   Mon, 5 Sep 2022 13:15:16 +0000
Message-ID: <PH0PR04MB74166908EB6DF6C586B5AC539B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cb0632d-b6a5-4a09-c8f3-08da8f40acc5
x-ms-traffictypediagnostic: BN7PR04MB4083:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsaYgIOAP/s/8kNnB+iV59+Z1W8yPfpS3C4yGpyuY481D/gaHC52JYBxdBiiKxk/rDJ2vI2qJpoH7l9hE8LDVaAwwBfurWYcZ6ONSQJ+FKqLoW/jQTOY9yOqDockX7RviXvG6pa5JV0vnbvQd+2hWg2Vt16VUbN8bCXlx/GPK7h7yewyEE252mN6KjLOGxUCxAOaevKR+v7N10HotSo9Y24r6AM+ANxs9nQ3VCsAFWiexXfPo3qwAMLb2PhcwDZypRxK5EGbS5NJAuk1pnOgFx7SX6YnIRyC151ontldfNLHg7eX0ofVF7pI7Ttc1EdiNNCsK3f1M2tLRWwTdz6d3o39FG13iAy1o80/wf7gf/Uk5QRwHvnaWzwHRhgEwjtPwAJEiBcRwlkvBbF5CuZTsKvvKeGhV41z/PO8plb1xGNt7+VN2H+eUw2Ed4Yk3lR8eCNvQTSz3GBXsJc4Y1AGAJqARy6FMosQ589h4VwX2qbw1zFttRbFsmVyJy6jxZtyykVHA0C7qjoGrGPlizRKMy41SP/VK4VkpHqx2+xryQFivuSz9aW9XdLk4D3KFhi1UAc3/2qbE1E5JuBm+Jp7RK/pQZcHBcjft2XNZzHR23dbTavxGfe7PoIDX/aioygrOnvMaQbhlCodWB6TEj96M2Ukaz17+8YamIfbQkXnTURXczwhVcs/yAHIEWHxvdnzLQ1chyjkrlKzqYdKM2sQ7HJFfQEG9xTbrDxSGGAy2mjl+5pdC+7LFSoGocntZA1eETVHsjfH0yKn7CiaCY/0hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(316002)(6506007)(53546011)(110136005)(9686003)(54906003)(7696005)(55016003)(7416002)(4744005)(38070700005)(8936002)(33656002)(5660300002)(52536014)(2906002)(478600001)(86362001)(4326008)(64756008)(82960400001)(66476007)(66446008)(8676002)(76116006)(91956017)(66556008)(66946007)(122000001)(41300700001)(71200400001)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VdE7t5aNk+wwm3hQm7aMZfOzlivcfzEuqZDwvzucSIwZJEIU+rCZtuDwXijc?=
 =?us-ascii?Q?DpKoUOvtfa3Fbtkl8uMxBG/SP4aKTdfXk6D5ckSbkFxb64yLecp2ivxLGoJ4?=
 =?us-ascii?Q?yVzGLy5rVigF+KkYVQhjq8482gpoxwa0AxUHdOMJdJ9PJHc+JawUb27lz8PU?=
 =?us-ascii?Q?7sHvYz/m2NXktS4KDwa3rvt/urNGSXg6AGBGLhpIkN66Bksu7faSELf3OJ7q?=
 =?us-ascii?Q?K18J3c/5h9CPC8nSzYpLeZTt9rD542EOpV9/GPwO9RBS5CSy21UHEkgFBXHM?=
 =?us-ascii?Q?tnz8qCEXpqpHjbG3Hc1Xn4qd7fDUY4J4np0zf0SapWTmyIAnF/1WOXmlLm3n?=
 =?us-ascii?Q?CQXVBB3Xw4Ttidlke0oAhynr5HuWKRY2smwEbacRAxW4dQ+TGQ4PzIfD/VuD?=
 =?us-ascii?Q?eL6pP8pxFtxjOC4s4LfUBymAKqmnhqPl2U8Aw8kgdhaBS6zjEvbSfK6O3QCO?=
 =?us-ascii?Q?rjHh5U+AY5H4qy0kM85zkZM/R8YsGSZVky7LVONRn6w7v9EUVV7GpIJujC81?=
 =?us-ascii?Q?vbkr8mpmVuowx/8epow/tGmF0dpxGbovaFrfFebwSmI0IjvbxRWPPWKGbYZw?=
 =?us-ascii?Q?o0XGxLkfm3zIUWbeaHudG6+sFvR7NkVJ8l4bqgxTbNwLr962yypGZLWtqa+n?=
 =?us-ascii?Q?BMUDERqMn/L6EWZGxcyzTcBSP9+kAsY8oDbB0H1KqMsOxQbHE5GhdKhRneAc?=
 =?us-ascii?Q?EpDVsbI9Ikx5hbn9Gr3vf3U6unBwIP9aY4j3yaC3NBqMU8SmhaW48SGxJOOl?=
 =?us-ascii?Q?2YxPsn3Cr8W16Ob+zsMip4ClMnYj+AnYqgUdHQPURIzJJ+6pmoQSsPrhVgfm?=
 =?us-ascii?Q?xfpYEwakW2WctxVazkpM5iC47tYGqgsNgxqsJdPwJS3pWj1ZTOCPDVtZoMdy?=
 =?us-ascii?Q?q6tODKyTIhfnY3VnFeaETq0F+t1C+LX6oVePaIfapPPJhs8DnZywAKvl3/bj?=
 =?us-ascii?Q?pC44PHsoNj3aDjefHyIh4h5cnqYnMJosE+0IfvTO0NLlTM72GwkzHc33Ouxy?=
 =?us-ascii?Q?iuaRypFGWUQUDfR5TuvtlUDqv19Q6Yj57tp0oZHKVdDUKxkLigkJXH/flZnX?=
 =?us-ascii?Q?w8qaUxFGm3zSNpIf20u8P1EA/r46sEqWDISfCGrLnAKQtPj6yNzjSkN5xJsO?=
 =?us-ascii?Q?kPgECX4kKRiO8EYSa8zg88CNs3ytEJBtfgYxNhs3GZxnjzTJC46/3ogXijdE?=
 =?us-ascii?Q?xJjf4Yd2heoThuwoGPlZTp56YGljgzEbltlxeyRMMKH7VG9Rgv8OHDCnE4NX?=
 =?us-ascii?Q?bq4Lphf3ox6fQGednVLuwgmD+hgt/dLYzF/ylpvqGb67C4UVX5bTi3xpbMs4?=
 =?us-ascii?Q?j81+fUgUQwlQtwzK+8vI0VUg1z4/E5RwC4ylFt53C/sWRyxZ0t1b6zV4MHwK?=
 =?us-ascii?Q?z+DqLoK/QHOYsiRv2lZgRL0OLzZuuDK31lNokQylJ/2Th9+7799Wfoyv9tDA?=
 =?us-ascii?Q?5d+wUQytjqIOGceBWxfbp/OrBYgApxVtaHepAvGjlpkiWbl+0EvgUK9+TbHI?=
 =?us-ascii?Q?1svqUbMjk0gC4UqXr4SfFvrCDxpN0dCYk5hscUH4fJ7VpjyP7NWlA64k9zjo?=
 =?us-ascii?Q?Fo/z511BFhrokNLllzdL9QdYLW1YYd5gV+VrLiiU90UX4F6oGqk6c31xoxKo?=
 =?us-ascii?Q?WtWFZrIy/cWrIBasyxCyXKX1UKX4sBtxhI2IH5Eu70nGo010VHL+56bF8jR+?=
 =?us-ascii?Q?+tqBLLOpPojQ6xAGrUCBa25HmpA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb0632d-b6a5-4a09-c8f3-08da8f40acc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 13:15:16.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPDpYtUbW+ozmLZSaKM6mxIE7a++P+TTgfCIooqCpAKA9zMNcs3QmFzc7/5tC5Lv091KDxboscqPBlBe3Ka2qROOvgr1TSZntv4X0Gftld8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4083
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.09.22 09:43, Christoph Hellwig wrote:=0A=
> -		if (btrfs_dev_is_sequential(dev, physical)) {=0A=
> -			u64 zone_start =3D round_down(physical,=0A=
> -						    dev->fs_info->zone_size);=0A=
> -=0A=
> -			bio->bi_iter.bi_sector =3D zone_start >> SECTOR_SHIFT;=0A=
> -		} else {=0A=
> -			bio->bi_opf &=3D ~REQ_OP_ZONE_APPEND;=0A=
> -			bio->bi_opf |=3D REQ_OP_WRITE;=0A=
> -		}=0A=
> +		ASSERT(btrfs_dev_is_sequential(dev, physical));=0A=
> +		bio->bi_iter.bi_sector =3D zone_start >> SECTOR_SHIFT;=0A=
=0A=
That ASSERT() will trigger on conventional zones, won't it?=0A=
