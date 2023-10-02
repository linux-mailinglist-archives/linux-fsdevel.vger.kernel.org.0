Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106117B53C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 15:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbjJBNLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjJBNLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:11:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A8793;
        Mon,  2 Oct 2023 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696252299; x=1727788299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oVbu2A+ZYu0AkfQh7wAJl3n2HnjHKPHRXQ52rWpAHWg=;
  b=ZdntjlypbsZNs8idBaX1uQ/l5IXTi3Hc0teWYrfRBGEsaNTR9Ur6zi1c
   jXJjXyVotPZGsAYCKMkyo99EEHMmJwz22a9xJJolubI86NWHtSqRw9fzn
   7Lj7B0gLfa54de8N+3AR2HUzFcwrWJzh/rUmbm35orybdUSLj9XpzqoSD
   TyzyoGfmy/nADZjO/8HqGJHwd/Oby1CIiSjg++MJQEigsItkYOPyRSTL2
   fWlPHW4zU5C6j1TH+6ZO9UW2GKGYCDQ0bblM7ptZzPdsT0ns4hYRMc2q4
   GKNDtQspp1mRY+8GEMboW2y1srL+NlMJhUuS0VguMUBzP9LiZamQp66J2
   g==;
X-CSE-ConnectionGUID: UGcE0ncBRn6MRnyV32fI2A==
X-CSE-MsgGUID: ulHelxmtTG6TybDV3te+0A==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="350850743"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 21:11:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaxbaLP+j8AikdFpk6crmQeHfl5qrFW8Ya/64X0mLMO81ftSV8XNROUCrjOfGWTUx2yFLn2zEQGnQ1bF/ws0DDryRIZcJFh4wbufIoELjOj3ra8f+2T4iVf241yvy9dArLZhEWXrYptrwd3W8Zqx0zfGxnjHQWN/ZQ+Ru3C0UdDPNUGpHaiLBbPDRBF7xMsxw3ulslSx0uAH3xJWscNEXKnclqj0vAGjLZE0Hm0B5tvvSXSOT7yw8iTY14XA6KrHvqcj3BA93P8BACGDZanAPxDYn/FJ/RkZC97PaPo7TMkTRFPx4H08HUr3DrUTwOjtN16S6OgcARicSvavAUheQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/KKDlGnb7i6gza9TEl0BpNx36q/BWgZp5hI1ot3xoA=;
 b=TF3qz3Cgrycvp9bRZcEtQoNeUtM74GJbX6fu2FbQfjkLGkuwQRbc7gHVtBhXzXunQiyXgY0iMe9YOw4a+5EidxHUea5Cv9+wcJJSOf+uNNfUDzjCmcQLA/CPXhLt/sv5w8e161L2acw6jc6VOyZ6SEyK/M9S5HFiV0ZkBBPaIdF2X9k45i+aO8mFC0/NnX+3HunqulVS2KPJ6cThRGHk483FijBbxh0nkcql/BA7MOsslFBqZZs+RTrbMldP4IQqON5nxH1B3KdRNPhX11MRcgZb/Zqjo7bxPkFokTwWJMyWmpUZCBv5hbthZuPlA0lmJFC84tdvvN6w5h5F7l2RMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/KKDlGnb7i6gza9TEl0BpNx36q/BWgZp5hI1ot3xoA=;
 b=dz0zkcVM8/zvP7krtAdPe9xwxQ8HJE1QRhHMEf1qEBFK9aG8+G56V+m5YwN9aFPI+sXzwnxzNBjFCQYOtXCEHoCNdFj5qzz+hWF5JxseY+CpAnUiMtarmCeLBPq15z17CketExz+/iQqoMF+IeHPk/0rZMfbzSuSpAj7C9wmKpI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7476.namprd04.prod.outlook.com (2603:10b6:303:ac::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.20; Mon, 2 Oct 2023 13:11:36 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 13:11:36 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: RE: [PATCH 07/13] sd: Translate data lifetime information
Thread-Topic: [PATCH 07/13] sd: Translate data lifetime information
Thread-Index: AQHZ6/b2O0pJa8U0g0Ktylc/jkGdmrA2ifHw
Date:   Mon, 2 Oct 2023 13:11:35 +0000
Message-ID: <DM6PR04MB6575B74B6F5526C9860A56F1FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-8-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-8-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7476:EE_
x-ms-office365-filtering-correlation-id: 8e6e702a-fc1f-4fd7-f0ca-08dbc3491b3c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSTENIOS1rIJLcHlrAgGjOZMp3clVCZEtaCC+Sk34KizAs94SO3R4PJJ8b5SoDnL4brxH0cPUQ2I8QNhkgmWCqUql9e1ex4JtYHS6kj3gcsFXltQsuoDkW1g3bwZ91Ws2xmXtflZEkFHqIh9+LrYZOfX7H5nlgjGSeyphnuhWJ3bmP1ltpZEx3G8YjjBvlGhA7gQWE6THV5rjfGLRPzwo190DWBt43Ao3LLmbp5xR0LTK1TSdITWmgrabIyeuAaSsqORkOSkSLodRnrnHHP6FxxjtpgDz0xzXAg8QtlE14DsaJtY/IVQDjErQz6o9g5Z6BqS678LZvZjoXCP21JmH/f496FuvP2WHUWc2FmHDG9FRwC7FY2J4IgRk8JsT5acCjaOn16LXcfVSUpYp1qWScuTOLPS1XXsVEraFOQ5anC4XHKkk4cM2cGYRPhhsrVqouAbb4p7JcGMaCnI1CFcNiT0mXnsKQDzRNJrsi0md4bNmeFuIlSMhlM3o5SKrdYgWTJcTUeWFJQC3cUhrP9AGYnWJncN6xw38TQXuGYDIvm9Z6W8CGol/Ect7kuZOvZXqCIV0/R89NSRKpPrCtPx0PfvARkZIeNu7BQ4eSvbBdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(55016003)(38100700002)(82960400001)(38070700005)(122000001)(33656002)(86362001)(83380400001)(316002)(54906003)(64756008)(4326008)(8676002)(52536014)(5660300002)(41300700001)(66476007)(66446008)(66556008)(8936002)(110136005)(76116006)(66946007)(2906002)(6506007)(7696005)(71200400001)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q5IJLQfi6ieRBrLJEgpnPxzeoN/2yW+p8jJtbanME48LCpMR7x+SdPuCHxMc?=
 =?us-ascii?Q?jRrdw3A/pnUgrBqEpT0djSA0gSOMBxLExVG0ITGNDYaGivJ0fkjaJiRKOpHa?=
 =?us-ascii?Q?1VednvnaHitBwI573I7bl5QAVD+M4EiEH0lwCnX8Psl6Cc7f5n59yd5pOdpg?=
 =?us-ascii?Q?nRCFe+QqD1juPJUh/OOsK2X5S77sYgnHpFTbPXvcI/YGUeymJG/FMlfgwq+U?=
 =?us-ascii?Q?X7/RIYdFsFv9EnKoYHOruTSHocq6T8Z2JLpXIKdl3FuFNblkI6oX867Gwocm?=
 =?us-ascii?Q?pkeejhppd7WIU/ctyGKuonotdrXXVaCmV+GeHMYHYugsklpIPwJF0UpD871u?=
 =?us-ascii?Q?/7OoNO5z2vMNHKqcJLiG182MH8VAhkPsGJYDeymIMlzCi4NDSEIGQKbS/IcS?=
 =?us-ascii?Q?ju06B18ibfSS8QBkIxinHBItMGbMlQxxgdnxJTU3WJLReT1V8a56U6hbSbLg?=
 =?us-ascii?Q?52GwHNQDgIcVf35UBeqg4gh4GIf5wMPLOFuRcjrmGvYJB/vXtrNMsrjZHzoD?=
 =?us-ascii?Q?eVSryZPXXayTzEbiIWLRBIzbkNEf/NXXnySU4rbHVdQJviQS0thTZm9TvxCz?=
 =?us-ascii?Q?755Q9t8dYmJUZ4FibJqbSzoAOVbsWYdNswL/HYMgbWmTzkw0qUgcKXX2lV33?=
 =?us-ascii?Q?UE0oGFV60MEoc42QsQo0+N3tay1ybKU2jEA3AVTUR8te0Rm5YD12VEw+bG2p?=
 =?us-ascii?Q?NMOQ2eIiAeGtThcPr54zVedcYtMJML8/LtfPeqp6rKMUZDJsMvWjWb2Qz5ym?=
 =?us-ascii?Q?YdjNuthIPmhUGTZN3RQpNghrtBxcQxvWyoUI5splD+r19WEOpe7QMnI6Dziv?=
 =?us-ascii?Q?yzwBDUrEBaBoVCn1mTe2Y9AC+E0lbg9RFRONHz5ZwUtRlqeUd5+ZoACMmCLy?=
 =?us-ascii?Q?Yap3RQjgviz8EQqMBJDpA2yA1DTinulxrAGhe2RyUacA0sqUrlVFjIIdvHK1?=
 =?us-ascii?Q?HoZuaDVzbrHSCWYSiQRBdK0+2Bh2UfwlNMtv42ECGoOLHlYBpD6D8h6ON9H7?=
 =?us-ascii?Q?CxgL8B+rPC7l3G+gQWzbdzMBO0b28zu9Fn2govT9OhstQFSc3zQ7Ch0Ab5ZX?=
 =?us-ascii?Q?zckYIKPkm37Oc0ycst56IiO2PajXkh+rEiygpzpierDcZmvCmzEFPsJzYGTW?=
 =?us-ascii?Q?tsUPwV6ypb5TlIuTxVWijmJEwRg6W0E6XzDJ/4dmzxOvWCSOAucWdj1dZzOK?=
 =?us-ascii?Q?mt6K6Yuhtj5UtFvCMtdJsYAYJrnh3MATMdjWXpdWst++zmDGS+b/BLlWnZIi?=
 =?us-ascii?Q?PpOA7pCu0Dsh73dsTVMssWNbj0c+37uGMkk3q3/D7iFJTmyx63rswnsfb+J3?=
 =?us-ascii?Q?LbkwL0/mtFHuPnEwZPzR9jVVm7BrnOWSz8mzXHjICN7Rr3RdFkr08R3Xd3Nw?=
 =?us-ascii?Q?ckVNTCg4GKJgn52emEgAo0ZrXvsERyJibGct8ea8OGt9yP1CUi/IzMvQ+qWJ?=
 =?us-ascii?Q?C1tiJ3shhQltQ8iosCf5h1G6YOPwF2Utv3/4Ls0xMlnvyoqVreqVMpd3yyfY?=
 =?us-ascii?Q?Ie7Ll+gqO/w9pa+4i5MhHhcSUBT/vjxnFXkU6CVeYNLBTCcg08HK7h/3a0h8?=
 =?us-ascii?Q?rEV5URnlPnC7X4tehtLoTvUVh+C3cmcYz3JDRzvH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sGHFCfa1s454hhoLz8+cleKN6XLjJ6s7FuJDcK/ACTYxeJUumdHH/PwLFPK7?=
 =?us-ascii?Q?RhDDnj3Trs5ziKjIfRldFEKQS/UAPheBPi/NIEMyluc3S5AmJtzptQyfHoBG?=
 =?us-ascii?Q?s2qGOHcjz3TkM+PSJxrHsvc/DGImlgqACXbDFmu6tX52yJ9foGxrSLassHI/?=
 =?us-ascii?Q?v8oHoC26o5qHSiiGYsbCNqPKrgwzfqur1rB8VkG/OuW+tOSeR6O0NcNGB5gN?=
 =?us-ascii?Q?Pvh1GEoNIGvQM3jcqMoJaCmbx2IbISZcTLvq9PZmxlEKJpU3qVypEf+kAf5f?=
 =?us-ascii?Q?QAUTQKnSFFYZ995lGqZfLnCugoCgBePPp7eKVxaDDJp7po6vDWWsIGVXcX2O?=
 =?us-ascii?Q?Pphp6+h7dEkR5A2bn5q8Aqmf88+QgJrt+oBb16wNtoOfWZXD+Qb+CusC8lps?=
 =?us-ascii?Q?sfeffkcX9juYqZD+tmp1HY5XwnXTCbOltUc82yXYu/9IQ0Vbn+/hbyIs77zr?=
 =?us-ascii?Q?yvrJOdRUQrEI6dHjNqGyKQ1AexaZpspZZP1z1+fC0gXYsGHk4VOzLugWO+IZ?=
 =?us-ascii?Q?TDFH06SqeUMu/xFaw2CyKOwiwjL6hikaSGMNN57a9zjDL6zfg0n7D63loIrc?=
 =?us-ascii?Q?GgwTdIioNvjkU4+Mld5BrIYnlMONMP/nDWRVkHaUoi/rWMtVeTTHa/VqIHY8?=
 =?us-ascii?Q?7Rs7b3Yx9I1Ke0d1kfhd469Q6+rU+L1OvX9I9p67dS3p6e1i36PSeNDZG8OK?=
 =?us-ascii?Q?14xqcJse7C8Fj+R0i+LxrgBRLgJtz1JXkKWnf+b+XUwRaF7KNhy369IkMlDi?=
 =?us-ascii?Q?gik+z0lo8di9NMtlVRqpbh/iBrF0Q0Dt1bv/l/nBmHUdR4S6DJNASyhEvT0x?=
 =?us-ascii?Q?ATMV6IxkyaZn4BngG0vcquGL3F07X9kAPqGHLIuXDXSDp5X14tVLVt5HlKnn?=
 =?us-ascii?Q?cwKp04OAZdIb3PNQgw3fd76ZhVOsDt3+7pFEEUsPQ6M5kKBnkltJL3hrRPCk?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6e702a-fc1f-4fd7-f0ca-08dbc3491b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 13:11:36.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmPjuKsbth/HQ4diLiXIl6xSbG8NO6LXraYq6ZcnV8RiXBryPNmLSP6lMjSYDFztbtGG1MaCzyAZN7qwKh/Qfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7476
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>=20
> Recently T10 standardized SBC constrained streams. This mechanism enables
> passing data lifetime information to SCSI devices in the group number
> field. Add support for translating write hint information into a
> permanent stream number in the sd driver.
>=20
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/sd.c | 65 ++++++++++++++++++++++++++++++++++++++++++++-
> --
>  drivers/scsi/sd.h |  1 +
>  2 files changed, 63 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 879edbc1a065..7bbc58cd99d1 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1001,12 +1001,38 @@ static blk_status_t sd_setup_flush_cmnd(struct
> scsi_cmnd *cmd)
>         return BLK_STS_OK;
>  }
>=20
> +/**
> + * sd_group_number() - Compute the GROUP NUMBER field
> + * @cmd: SCSI command for which to compute the value of the six-bit
> GROUP NUMBER
> + *     field.
> + *
> + * From "SBC-5 Constrained Streams with Data Lifetimes"
> + * (https://www.t10.org/cgi-bin/ac.pl?t=3Dd&f=3D23-024r3.pdf):
> + * 0: no relative lifetime.
> + * 1: shortest relative lifetime.
> + * 2: second shortest relative lifetime.
> + * 3 - 0x3d: intermediate relative lifetimes.
> + * 0x3e: second longest relative lifetime.
> + * 0x3f: longest relative lifetime.
> + */
> +static u8 sd_group_number(struct scsi_cmnd *cmd)
> +{
> +       const struct request *rq =3D scsi_cmd_to_rq(cmd);
> +       struct scsi_disk *sdkp =3D scsi_disk(rq->q->disk);
> +       const int max_gn =3D min_t(u16, sdkp->permanent_stream_count, 0x3=
f);
> +
> +       if (!sdkp->rscs || rq->write_hint =3D=3D WRITE_LIFE_NOT_SET)
> +               return 0;
> +       return min(rq->write_hint - WRITE_LIFE_NONE, max_gn);
> +}
> +
>  static blk_status_t sd_setup_rw32_cmnd(struct scsi_cmnd *cmd, bool write=
,
>                                        sector_t lba, unsigned int nr_bloc=
ks,
>                                        unsigned char flags, unsigned int =
dld)
>  {
>         cmd->cmd_len =3D SD_EXT_CDB_SIZE;
>         cmd->cmnd[0]  =3D VARIABLE_LENGTH_CMD;
> +       cmd->cmnd[6]  =3D sd_group_number(cmd);
>         cmd->cmnd[7]  =3D 0x18; /* Additional CDB len */
>         cmd->cmnd[9]  =3D write ? WRITE_32 : READ_32;
>         cmd->cmnd[10] =3D flags;
> @@ -1025,7 +1051,7 @@ static blk_status_t sd_setup_rw16_cmnd(struct
> scsi_cmnd *cmd, bool write,
>         cmd->cmd_len  =3D 16;
>         cmd->cmnd[0]  =3D write ? WRITE_16 : READ_16;
>         cmd->cmnd[1]  =3D flags | ((dld >> 2) & 0x01);
> -       cmd->cmnd[14] =3D (dld & 0x03) << 6;
> +       cmd->cmnd[14] =3D ((dld & 0x03) << 6) | sd_group_number(cmd);
>         cmd->cmnd[15] =3D 0;
>         put_unaligned_be64(lba, &cmd->cmnd[2]);
>         put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
> @@ -1040,7 +1066,7 @@ static blk_status_t sd_setup_rw10_cmnd(struct
> scsi_cmnd *cmd, bool write,
>         cmd->cmd_len =3D 10;
>         cmd->cmnd[0] =3D write ? WRITE_10 : READ_10;
>         cmd->cmnd[1] =3D flags;
> -       cmd->cmnd[6] =3D 0;
> +       cmd->cmnd[6] =3D sd_group_number(cmd);
>         cmd->cmnd[9] =3D 0;
>         put_unaligned_be32(lba, &cmd->cmnd[2]);
>         put_unaligned_be16(nr_blocks, &cmd->cmnd[7]);
> @@ -1177,7 +1203,8 @@ static blk_status_t
> sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>                 ret =3D sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>                                          protect | fua, dld);
>         } else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
> -                  sdp->use_10_for_rw || protect) {
> +                  sdp->use_10_for_rw || protect ||
> +                  rq->write_hint !=3D WRITE_LIFE_NOT_SET) {
Is this a typo?

>                 ret =3D sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
>                                          protect | fua);
>         } else {
> @@ -2912,6 +2939,37 @@ sd_read_cache_type(struct scsi_disk *sdkp,
> unsigned char *buffer)
>         sdkp->DPOFUA =3D 0;
>  }
>=20
> +static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buff=
er)
> +{
> +       struct scsi_device *sdp =3D sdkp->device;
> +       const struct scsi_io_group_descriptor *desc, *start, *end;
> +       struct scsi_sense_hdr sshdr;
> +       struct scsi_mode_data data;
> +       int res;
> +
> +       res =3D scsi_mode_sense(sdp, /*dbd=3D*/0x8, /*modepage=3D*/0x0a,
> +                             /*subpage=3D*/0x05, buffer, SD_BUF_SIZE,
> +                             SD_TIMEOUT, sdkp->max_retries, &data, &sshd=
r);
> +       if (res < 0)
> +               return;
> +       start =3D (void *)buffer + data.header_length + 16;
> +       end =3D (void *)buffer + ((data.header_length + data.length)
> +                               & ~(sizeof(*end) - 1));
> +       /*
> +        * From "SBC-5 Constrained Streams with Data Lifetimes": Device s=
evers
> +        * should assign the lowest numbered stream identifiers to perman=
ent
> +        * streams.
> +        */
> +       for (desc =3D start; desc < end; desc++)
> +               if (!desc->st_enble)
> +                       break;
I don't see how you can conclude that the stream is permanent,
without reading the perm bit from the stream status descriptor.

> +       sdkp->permanent_stream_count =3D desc - start;
> +       if (sdkp->rscs && sdkp->permanent_stream_count < 2)
> +               sdev_printk(KERN_INFO, sdp,
> +                           "Unexpected: RSCS has been set and the perman=
ent stream
> count is %u\n",
> +                           sdkp->permanent_stream_count);
> +}
> +
>  /*
>   * The ATO bit indicates whether the DIF application tag is available
>   * for use by the operating system.
> @@ -3395,6 +3453,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
>=20
>                 sd_read_write_protect_flag(sdkp, buffer);
>                 sd_read_cache_type(sdkp, buffer);
> +               sd_read_io_hints(sdkp, buffer);
>                 sd_read_app_tag_own(sdkp, buffer);
>                 sd_read_write_same(sdkp, buffer);
>                 sd_read_security(sdkp, buffer);
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index 84685168b6e0..1863de5ebae4 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -125,6 +125,7 @@ struct scsi_disk {
>         unsigned int    physical_block_size;
>         unsigned int    max_medium_access_timeouts;
>         unsigned int    medium_access_timed_out;
> +       u16             permanent_stream_count; /* maximum number of stre=
ams
> */
This comment is a bit misleading:
The Block Limits Extension VPD page has a "maximum number of streams" field=
.
Maybe avoid the unnecessary confusion?

Thanks,
Avri

>         u8              media_present;
>         u8              write_prot;
>         u8              protection_type;/* Data Integrity Field */
