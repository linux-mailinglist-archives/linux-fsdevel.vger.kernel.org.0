Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2452729C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 17:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIUPSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 11:18:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2812 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgIUPSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:18:39 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 11:18:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600701519; x=1632237519;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=knUB9738apTtTuC2y9d1IOvPKjiwEZ2BT2TUdQgqzHQ=;
  b=Mnq/rYSMJLIqF6hxEKdtb9noeV/0rtHH8j4UiIs0gSx2GDShMjdxhaFS
   zYt0Vwl04kbLF3RioDdE6jLH1K32+0+F113aUPYWbabtTpJxQcgYAXhfo
   YL5qxo+0q932HBDeRZZeoijjP4lp8DPMDBIOApIvg2ljY8iyRHeGXEUhK
   iVv8RudQD0dx+TCF+nK75ld2/jClFuJE8CNNw+meEGiIF//dn5jQc2zjE
   Sh61mGf32dbkylE2r9QvMc5i60ao1gnLZ1UbDudKHftSfxQIvCXq0QIM1
   UMGN2WlJDXn/ADFFCOb9RSWQw2QMms4dZi5OhaVI8tirvICvdO9h/zUUf
   w==;
IronPort-SDR: uTx47fB0m7KbXDCzkAJkOGiQRwzsn/b07i/6lf7xKyhvr2P6zA83DAiefTleSamhablaYEu6/w
 qWudRdo8kFARNk2rr0SHL7DEeTG9VMR6hmMcRbsXB4EfotZDqCqc5SpnPf6X1+I/24J3ow1tWG
 +TUzhWhbq6FujHhfcJwGlH2F1jqFDOzMYsp0bgTkDKuvHnr5A0bKN2gE2exDqRVrte+GJVtAtI
 aoQIg903om21WVXv9WgbPESrWCuVLRKwwVqzWWD8sj64Y+5OBxZ+Q6djJVLrWN5Ya+W1g5fxLw
 /tI=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="152269215"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 23:11:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK0IRQYRqEo3ms0txb3ftOnSpnnRsq/FP3u4IG/SGpPebVTfqtrKCliCxb1CfMUNPKl4BQ63w954Vpn9H62Ixf8VqWMnYnuXH6Z/994VypOmTVqjMpjhDni1HkD13WpEwd6xqhZqJbb0UScNwcYZOEtPNHHvY+Ba4+jSv2pDlZ+Md5rRMcLotdKKzu6l0f3s1XD8L9Uq5kIn4ygnQhILUI4CaIBNUGgJX0cnUgs3y4fDbmQZP5uiMeV7TqdozKTmwZCCZaJ6hJ014d/F3XFOgxg99xmYfBy2d+El09u9oHVYaxnQHMd9SaiR7ihrfUXup+l/gGf3uRc3WSxoWX8KEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faA4wDuFMtaBOoqgnHVmy+E486Na+XXxL7+eYB3UEg0=;
 b=ibbMkretzpCCP78fKayGsVm1Jl79LKrM/kCf81ySqsSKyFH4Nk3SFN1iQk9hpnv8jkiYKgly9lCkbZKy/z+12KN9WQ6VJbNQMHOJmvpIDss36iDxi3DgmL77+WjHu2SGpvuEw6/1YsqH7068eoAz/L8QWPItxBVPA4qS9hn5dh8zfUVjXyfZlVVRwE1GyROKFzcbcmrLT4Z2nL5bF2no/UBR3lvA2tw0EWugNnPDCZyVtwvToh51cv63yyCdAsj6evRT5llFo+5Jx3QWyFWrrffpfkZwgS5HrvypmS6psw/05vwfZt0b/FXiO8VBTuqMBT4ZIMdi14mdF91paCUgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faA4wDuFMtaBOoqgnHVmy+E486Na+XXxL7+eYB3UEg0=;
 b=Q8mZlIO1C2Io+LWsh/nKuk0WaD63uiUbJG7UiMiaDsaiG9EWklE5Jxm0ocf8SZgeQiU7VkwvZ1AZjmBn0zg38SBZB5OV5q8B35qu83jX6B5Z0wk5KCpStZbLeW45cTo964DSwcx5dFTKmCvHN2d10Vp4bwNEOT20gxTMm6dxDgE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3965.namprd04.prod.outlook.com
 (2603:10b6:805:44::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 15:11:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 15:11:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "dsterba@suse.com" <dsterba@suse.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Thread-Topic: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Thread-Index: AQHWkCW/teRQg9jabkG78BEGNqxiQA==
Date:   Mon, 21 Sep 2020 15:11:29 +0000
Message-ID: <SN4PR0401MB359881A296E056FB5B02DCC39B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-5-rgoldwyn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5edc0f65-8a4f-4095-20ec-08d85e409e56
x-ms-traffictypediagnostic: SN6PR04MB3965:
x-microsoft-antispam-prvs: <SN6PR04MB39651D4B6DD671BBA9B8246D9B3A0@SN6PR04MB3965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YXU5Ys6jcNGF35P6e6jty53o4sIcyEML8huRqCW+xrkLMRf1zLfoEG3bJL3dsftVtM4JAL5s9n84t2Sa7DtivNSofA0NRk4LmtwZDokEeP1Cp6NuemO+Ug1PUt7Ec2u4EACk/4fXd6Mgnca/gH5w7Pl53cSJpIJ+KEyqe/a/bcYd5CNVOK5MHJ0Am9kBygpd7vjzRPL9Ja0Gt5v+S4wzbX5TIi+EliFO303bEMlei8MhLVEtKHGvCAfs/814vfY05NW0KUsra5a3+fje+SuuvYTa/HRjh+J9Ymn+Jq8nnjpWiSIdUrLArdBKIqQ52FPhdTvo+iAIHBS62ZTi85hqf/Cocnlm92qNM6dDQDZYDX6K82MvCbLALNYtVmAWj++K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(66446008)(76116006)(110136005)(91956017)(9686003)(64756008)(316002)(53546011)(6506007)(4744005)(52536014)(478600001)(66556008)(54906003)(66946007)(8676002)(66476007)(83380400001)(2906002)(186003)(55016002)(86362001)(7696005)(33656002)(71200400001)(4326008)(26005)(5660300002)(8936002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6FoKafZk6OnSyWAQZkJiYEEsh7Pqw3sjiufto01IxnyMHdIhyWYFsyM3BVi21OzOIkLKFbIoXjq28hkE60Yf7hTy2nUclSu1r6lAq9mz9CpGOVxymjfHlb4ri92MGYUpN13hnAxJUXo0Gv7YIK49XHiIFIOFBL89bGWRjB5lYiLp9av41Wvnfyg05gUiGw2sFVn7Ac5lMpIadGG5g4e1POmDDupL7r4jxiHpSA4V9fwO8X6tBJgP6nv81ykcjeE3ibcKtCPUEuZQSWoTnseZYbCZ1qFnwvLTrfE2EMi70uKo7lUkAZWTJO6A8kbbfYxa08rC5lPK6ZTn99CVVsM9xDEhj5OUa1LqA5w1IUhYiEwj55k+DLvuaXS44WR7afEO3TFwYXhK8nr4tDYHQfzx6FIRubvamID4KS9FE7T2jVuEy9GrOA+RsnyaOTgDXVQD4FCs0xHZnsXq9v2bl/7PKTi3AUbBmRl76QD1FW1MC/CmD14nzqNn6mQMMC4vc2DsAeQM41fdKN5+tgL/eP0yWVWd9ynFBOW1lnas5Z8YcY96+wnS2jtaUht3YkvECHIgbq6FhQhXNBlp1VwNoBKd/gfj340unCl9i5yBRX0FTlnNDZOn6d7IA72OLkqlYFS1XqHRJNKHKUDt1v9xpuRMIw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edc0f65-8a4f-4095-20ec-08d85e409e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 15:11:29.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYKVKVu/1ytoLURyyP9l6IS1KPMRr4al8tVEIPsVVEPuQpOFRLeLpZ8B+K9J/fR9bCbm2vlMWAiT33dlIg6HfcRIKUJ0GaH/GeviUW2j+uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/2020 16:44, Goldwyn Rodrigues wrote:=0A=
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>=0A=
> =0A=
> iomap complete routine can deadlock with btrfs_fallocate because of the=
=0A=
> call to generic_write_sync().=0A=
> =0A=
> P0                      P1=0A=
> inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)=0A=
> __iomap_dio_rw()        inode_lock()=0A=
>                         <block>=0A=
> <submits IO>=0A=
> <completes IO>=0A=
> inode_unlock()=0A=
>                         <gets inode_lock()>=0A=
>                         inode_dio_wait()=0A=
> iomap_dio_complete()=0A=
>   generic_write_sync()=0A=
>     btrfs_file_fsync()=0A=
>       inode_lock()=0A=
>       <deadlock>=0A=
> =0A=
> inode_dio_end() is used to notify the end of DIO data in order=0A=
> to synchronize with truncate. Call inode_dio_end() before calling=0A=
> generic_write_sync(), so filesystems can lock i_rwsem during a sync.=0A=
> =0A=
> ---=0A=
>  fs/iomap/direct-io.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
=0A=
Missing S-o-b as well.=0A=
