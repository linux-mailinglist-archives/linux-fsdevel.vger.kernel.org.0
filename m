Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB150839D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355180AbiDTInO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 04:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376814AbiDTInM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:43:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540B1FA7A
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650444025; x=1681980025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zNIUDEcWV5eq7iJ6dwVgZmFbDl0r/3zecTloCk4h1iQ=;
  b=RTI6yLBwSZTOBYumL9ScxeFowvKcLtjj0aIDmXRhVVmVsJZDr7pkHneL
   1n2WLuZyfK6d02gBA3gb80mWF13aPrzqlrKaK2yMNMK2go+dwF1npkiNo
   o2oBKq4slCMD7HBCKTu3ZZyP6Kep9l2XV+z7GL3t7HvqkhoYFJOxpleZz
   Vi8BHo3ZYzx9mkED1I8jVJnVE5xYH4IyhHDn8c3xAwCH6z7xuGO/wIf7o
   gHB3LE7GEb5lEeV/ANeeUHh5Z0JTSBvqxuqPFamol1qvchPb544pS5gSa
   Mu5MgkUElI2iixUuPwJeWT0o8+c6wIzs2Qmi5c9Z8ZT4m8hS/5192knpn
   A==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="302542466"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 16:40:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpoE15gLa0p+4Jcx3decYaCON1X/OTN2KpDKHtpjkWvoG2gvaU+oADfTD29FCdBJ899FaDc+Hle7DAYbwB8Bq8bYAWs0OK0uHRLuM2BvmRcYZOSxW4ORcx0mP0Ip6dHRvYnb4sMEVzs3KqU5LriL0Ga4Z6WSik8w6p7MJLG7F64SW5UgZ5yZ08zpu7vNRpcotYq60g6V/mFyRR9GHnFlFcGNApcFabMWLM7CyqRYVJRLDrp/TLrt5NmuMZuNuM+G/xIXHwynUX7Zj91YySZsAjUwFDsIBFbvfTKIPGpPhup8xHrKZi7B6XMMeGtcC9zhb1iS4WeWz8nqK+5kJDkgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNIUDEcWV5eq7iJ6dwVgZmFbDl0r/3zecTloCk4h1iQ=;
 b=Vd5nUUd0v9KTCy+u5LaKrtbrjl9rWfE6jSYSINUrwZXfrOFXUe+85J2wJEZoyd5qgC9TjLnUQ5/WZS6IfVLFmeVo3zlJ52okMwgzGGa0Aw9WOXIZ0f5sfARdqrlSyqc9Vhz6ReAmVIoeetp6EvL0bYgKTH2xy7tw4yT2qK8ARf2c/G98V12sJGfZDZRZPj5fUw8S+Lm0WPiakCiWNWihCf5IR6cv6s7tbgmhKYNy1/MzdRMLZqEmrqzAYprw+mnqW2YTpqixge+JpH17Dm6pmtNBhu6ARPXe+Ok/Swfd6THtvst04hRs0owrp1zezOZNdj75DSKpui/RSh/65lqFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNIUDEcWV5eq7iJ6dwVgZmFbDl0r/3zecTloCk4h1iQ=;
 b=c2uuC2+zXpGwp1STGKKteCsFG8ChKzzlfmKlKfgWpti6aF+40/lPXwcR+kBf9BxtPuP1702fzs44K4dKkTvbX6C5fIeBq+wv3mNGkpBroQ6krVBGoeSfjAjh5wxMK9Q9DCLBxEXy91EqfU3jXFz/fdXKD1pf59W+3V3w+yKdbCc=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by DM6PR04MB7051.namprd04.prod.outlook.com (2603:10b6:5:244::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:40:23 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 08:40:23 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/8] zonefs: Clear inode information flags on inode
 creation
Thread-Topic: [PATCH v2 1/8] zonefs: Clear inode information flags on inode
 creation
Thread-Index: AQHYVGAASoYt5dxFAE+Bn3ECEp5GYKz4e8sA
Date:   Wed, 20 Apr 2022 08:40:23 +0000
Message-ID: <20220420084022.GA26051@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c617ca86-13df-4015-af82-08da22a968e6
x-ms-traffictypediagnostic: DM6PR04MB7051:EE_
x-microsoft-antispam-prvs: <DM6PR04MB70512A9BDAFC0D7238DA84B7EBF59@DM6PR04MB7051.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsBHY+Xf2fa5A66HoGGOQ9EEfS3Ekm71G7iSiLT45rJ4sMHkLVIOayPGCV/6Q/GMPTe4vG4rovWLB2TVxp4YK3W4S5FXSb8wZtkWU8eST7RMMSJn0+zaULG1H2UBPdpEfLZ+EsxjMRFsXFOxVZgNFTYTFXnTuhYMUr3n4SEFumQ+fyPLnSWVxG8BT4vtJW1ufo9/rfRaY1U+IgD+xejUp5tFoUDWDavngH0zIRSWLvnv3Ho84WkLCkgBGgSmtHachk3cRsDzpsM9l8Jir1xTFSpxfJQayt6DiaJWl3YGmh4MtZ3d5b7D8sTScp0h290ycSmDy3x5QCIHdSXwTrRKqr/LpC+vxnblJuOVRdnogJ4bY+RnHqW6yKv6uQweu/6UCdyCfchiA10nkb9BHoWvW9iI0aF0/LayPJQxIlEGkl7aceKNgcRGhrNxA6jiOhft8U8BNnekvYp7rhlKIzx/sbFbXuSpSeAPQCAJovRtExTXkcVQ2J5SW8cGKLsmODuCbGRr+DiYWiWFrauWvJhbxtMUm8xyYHKxITIWEQWiozAh+3lQseJlxqJK9GlBDLyU0WQ+jRdxcaa8pHHhlsV7sDlfw2R49QjAEqBbxuq1y3mW59JeSH3tSZnIwaJh7Iz24Wqtcn/0fO1LV+wBEStZ+axz6O6TReUkW7WYndoxiOJZ708pyldLFJCWKrpBCJ0wY9sxpG7qug1PwqS2GCGh5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6862004)(66946007)(508600001)(91956017)(66476007)(66446008)(64756008)(4326008)(8936002)(33656002)(5660300002)(66556008)(4744005)(1076003)(6486002)(71200400001)(33716001)(186003)(86362001)(2906002)(8676002)(76116006)(122000001)(82960400001)(54906003)(316002)(83380400001)(6506007)(38100700002)(26005)(6512007)(9686003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X5Wet9NoDlB07iAH1/VUezCS9UoFppaKp5pm6w7ZyjGjNLASgF5Rg/WGsKsk?=
 =?us-ascii?Q?FU/DRvpq3ztYJVm10cujRYEFXEc2ONYMxL271NC/elSCkbKsbYeE9m0aV5uy?=
 =?us-ascii?Q?Uh+sDNLbMXdevjZsYpZPnt+w2BUjAHHuMwo/V/YRSKmeUWZ1N1+yorYVduOg?=
 =?us-ascii?Q?ZdRiDDJL36ly9jOPX2iXe5I1eU69blzCoKsaE7RcA+hdmWOs+vm5y1LmKKui?=
 =?us-ascii?Q?G4nwzuBKLLqTLJXxX4T5riKKLsfsJqf3u1Tr6iZM0U3zQUrKVkctjBvxGy8q?=
 =?us-ascii?Q?IC8vRlrEkz0nP5c0l6Zr0Qm+99xjUYktoL6BrlbETKWeCnl6MfexkG2iILLF?=
 =?us-ascii?Q?Jd1791Of2sp2J4EKedt82abk0ojwhGtJTTtl0+em3rs9V5alrBk7Gg6oZB7f?=
 =?us-ascii?Q?Tj5HgPooI5LOHODF2tWrAOZKR8qgJDXbAHz3PcFQKgQRdvP9mjjuZGzUgTbM?=
 =?us-ascii?Q?xVYVZxa65u5vqehAuK5G2Q+D1/ZSanLfDeCO5A2i48/2Y82hXMfkRujUsmik?=
 =?us-ascii?Q?G/eB9nQFe9t23kAfgLEAsE9j2SjAjmu5lHvmHgTNNR/J72acG1CcXzV0/9ED?=
 =?us-ascii?Q?3zKZ1offz0VPBJuheVDImsw9M3kEHIIZVTn2i2QaSxnDGmfpUDkAFnh1OGfx?=
 =?us-ascii?Q?wbT9/rMiz7c2fCCTgiDBG0niq5D6cdkCs0DPCYVkeSJmlRhpuBOzDi41sNUg?=
 =?us-ascii?Q?GKCdlEMfYiKbpysu5NnZXhEB3kKn7VEaz1evhHJAY6bgBQXpvXlJ6ZrhVE7N?=
 =?us-ascii?Q?jf3DPcQaw28+vz/ep/VsNpMHRg8RszdlP3g7/7m9kJaDPq+LxEUeUweaAv3k?=
 =?us-ascii?Q?Ql0FMaw69yam9GbjDCPO5YCsrsgLoGmwglSz19qPdkcAKnZ2U8DR4j0VaCAm?=
 =?us-ascii?Q?DH/VRSZG7cH8MwxZwbvXjaRp8ZPgPZRP5ntKtoYRtwsfGFEMUkDXgsO3M6rW?=
 =?us-ascii?Q?Np/8hh+TaQHBZjiulo6NUgJ71qwMNqNwLgc+gAefMZIATasq8vEvff7gRZ+Z?=
 =?us-ascii?Q?hXr7Ix4zRTX4hTQLwFRl/p+0RYeYye+MQaE5FUi7/+TALB2YTOc5acRXg7tP?=
 =?us-ascii?Q?TvPCYHNCnLbz6kWUNRxIeYtrR3JpL9sSUaesQNDs8vjjU6hSiFbNd4zHBFba?=
 =?us-ascii?Q?yaN2l1/T6UO0hioMGole/jg/Rxy2+reI6HIvtDqsnGpMxx1n1ZIaN+Gs4k+j?=
 =?us-ascii?Q?IJufUOU9VtSCOUPOlPwbApbkCzWBDzkyvGMi9Tx+fY2PbGSkxXZypbPbLGr8?=
 =?us-ascii?Q?QdE8Saizgcpv07Wi9eB4fCMyPN7hPckEsPQ1iaLh3w6XvPSLlrjXoH1kmega?=
 =?us-ascii?Q?vn9GVCgL/ryWocadnPU3r48Sc9CpyG0cq8XQTjAVcHnkO6+7NWKWeDRjpKjt?=
 =?us-ascii?Q?5hOjnEjLGjZeus8OYz+PtG7QKDqSXnRwEqaCH3ww1TY0D3pbrRA8N2zBlsdC?=
 =?us-ascii?Q?IMpQlf3ZL8XZs1DSzd0ZybnT3alTE/+VJbae/2c3+vwkwm0BGQQ5b0OBrbKi?=
 =?us-ascii?Q?Jr25qisyl8OTIeryExNPwxyrZTEiZo9ds04G0kLjfvYWbpLfRZAPfx87DlAM?=
 =?us-ascii?Q?mdjFNeFDo/kMGqxD9ky/oeWBTi86wPSAC23Oy3XfY1YKrneVce6DXf8FxZ6N?=
 =?us-ascii?Q?Hh59NMi2svKW3q44pyFirGiXUcNa4PnaUN0USSkyiepW2GNQPVoV7e0sDRPA?=
 =?us-ascii?Q?td8e3t9jEM1fvhKGsCuWYO6P5GFN7rwcZoWEtTAsGpv6t7XZbMSv5Nuo+opq?=
 =?us-ascii?Q?nH5o59Eel6SdWNWSLkG61dW/xApAtik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0A80A5FC4A15E429AE2606FFA6155EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c617ca86-13df-4015-af82-08da22a968e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 08:40:23.0487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jy108esMUPh6z7WhvdZBhq1Djfx8VzvgCrtn0XFh2w0IeCMMbKVQj+ihC/IT6Cu8fTvnRGc8FU8P1oGQe/Tacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7051
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:35:38AM +0900, Damien Le Moal wrote:
> Ensure that the i_flags field of struct zonefs_inode_info is cleared to
> 0 when initializing a zone file inode, avoiding seeing the flag
> ZONEFS_ZONE_OPEN being incorrectly set.
>=20
> Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Looks good to me,
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>=
