Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714262309C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgG1MOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:14:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9339 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1MOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595938479; x=1627474479;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=V54L3OTgPQl10S0ooLSFMa//GuMmXzcqZSE5NjpvqpMKx4WLrvFvfIxg
   580pH5WJkI2WIazOXPNVMTohL5B/AYMUfGRuBKjalcCl8P0h7e5WS/Bk7
   77QdZrsHrxioLwVpLSllSxviYXSz/swBMvNQTAA8o8yIZRlxE4X4EEn+j
   PaRr+dI+mhv0TH2TZGzuQyIZrBio5wGql8iTzKDV5/RBGDf3SDcQkN65y
   4gRLt8vbSfKr1qkuIVPOwn9r/1FSnaIvShahVH1eHHFI3GVTM6vILmfzO
   SOg9C6lCMesszwsUoq1S+i9uxslNSChCQW+4a1N6ylb8X6rpbEqdcl9Fl
   Q==;
IronPort-SDR: BLK3f0XNhDAUnhRPzdW1mQmMjrqqLsMN/ab+5HvZE7L7WFzELbqiZgHcJN+Y2bjR2jQWLt2yua
 hmlflKI7H0QxtWUXb3NTar59rd8PXF8sqAxYxQJt/b9Y0UyWxLvnEAJqbkR3IM3TUuj3kdotxT
 QxUh6T7QHe95VsHr5UoXjsIQyczBAB+EBe3T9SmMnZ7YmiwvBzHWFmEF6Uw0srOAe3vXOb+BA4
 4d0qiMq5Um9WmcBZhgQdev+zqldvr5h8zB5jKbf51+JWmxE2m2DYj0ZxgPWZbiYYsIuFpySd2G
 acA=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="252886155"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:14:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgsauyhfKuqVOf89vrHWvgsyvYiSFOHJfy0M6D32UO1zA84WmZbyhQgXgpVrgLgDoKcREqVSo5JivrqGa9fKd+bSZsIdjCjGjPQCLmWEi+GaoVvY2/Cr22ddFHVC3vZtHlxteG5XZ3qNvuZ+YVz893mrHojIsCjxPmk3nQ7MxQ71hVGo8HhSLuE79ROJ1JF6N/gyDQfXpo+2AZ3P7IaUkgP3gIKSvPDKijCu6T0XDu4WHoB6GYs6tRboga3VG8ZkFMbvEJIgp4NSuMiWdKVATvK3FzXdpSvvPVz6nrXvHsga5I5/lwhE88xOqZtFGYjMz0uMKgIYdsrAgXV1R+pyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=F1KcHDyeCPBjPEi1RdRlCQ4YHrTz9PlBDpLdOGU+nLWlbbR/4mm6nfux5410Uw6npvFCTn8dBP0eEpX4QWgDmKswxyLHVoEWf4zZvhg1HlUQNyK43zNMYIQxliyHPKg4nZO6QGZ25phBC61OB+hH3adKcXuMXoAj0KyPP/DYD5uyt0BdJAqilrAY1yiE8qRnnOCFjhapqH6EdMeFYP46Q2YAf3n47B8okwP/ULuOAW9zGOaTOLKcDwYPJdiE3187ZJd6ZtjBr55lUF/n+5kEq377/kuZKRm3heF9UnRQEMuP5/AEGKgRcWMNApCP8g8SZ/BYAVrSNcd8vhkPcLV8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HA2alPriwheUSnfwo/eXbvlTkwo+KYyp5QPbG7lElckKtcNxhE0QwY43ChrDf17Fu97DXtv1bFoIdSs7yx3I2YDWvDzvK82ivU2/7iFwmCIvybfCtYbnoO0XJKRTlAjDiUBR5wWBvnNzCH2QMAHEVhhi1B+QidqFQ4Ox4ODylrA=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB5867.namprd04.prod.outlook.com (2603:10b6:5:16d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 12:14:38 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:14:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Thread-Topic: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Thread-Index: AQHWYYz0isbVISn0jE6//aF+fzfB0w==
Date:   Tue, 28 Jul 2020 12:14:37 +0000
Message-ID: <DM5PR0401MB3591189756D9F697C2AA7B2A9B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b8db149-da06-42a9-d6c8-08d832efcc69
x-ms-traffictypediagnostic: DM6PR04MB5867:
x-microsoft-antispam-prvs: <DM6PR04MB586726A38B7750C421D0B0EB9B730@DM6PR04MB5867.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a98rQmdxzag0a3ZfN7UAKQR3PYpTwlI39ZYNwMzfDukD9K1iUQIMFXuBm9303o97qnXtWu1HVFKGjgWSlDZKfBiPv3rwm5wUF+WTYWDG3pOX0sB1fEOHI//VxWqKJuESlRk4JyBppyHOjTgYGlD8QeF2Co6jCbl1JSFcVBMHHGG1OiQBKvM8fx+SpcfHn3ulYdKXxBi+nrv/ZIaR3UYRKTtNtu9sNsr6Wo/hT6e/JxHFJygA5glMIQZiKqNqZPGn/Igwzx/d333iS59ZAZpWdWZmX3pQ9UARrh0muPGU+ZhoKNTBfTD6qD8tK+KmgACwAwNrbN17gna/smZBWaBj5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(86362001)(2906002)(54906003)(66946007)(66556008)(66476007)(91956017)(76116006)(6506007)(33656002)(186003)(71200400001)(110136005)(66446008)(64756008)(26005)(316002)(558084003)(19618925003)(7696005)(55016002)(52536014)(4326008)(8936002)(8676002)(4270600006)(478600001)(9686003)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HXsB407kDrwKmsGGPDb7cSZFONfxosDyg7eaNYJ8hmAl7ndXeG8YzORWFmP38+fafpsL5uD7lETfK7+KWyc2BzSsMx6+ov4HztnKASt952ucjpImA2SxwP1QMi1SScx+PsvCTy+0NbLGhPLAFiKuUN2k4BsjxBKc0Qwhk+cQ3a529zMZu+9zKb7lwUf2zZS7oM//feJGYxXLJ2NxVWIoQt7uKRUPl6fMy5EVHkFM0i3baFj4uYzjJasnsWd/dkvangh6DjO+NTsEu3GXUQg/HCtP9XyDBMuUUnGaCXybjB+jfSZdyfIJLLyPkY0MXsteayiU/b8SJSIRRsAQgIoc2McUH4fZqwMjG5npT6BJNjZvCFjF1VZOXqHiqa3uJsvMe7HEl8SW1rNuBwzg0BzZ93wCWIG28iaRRF3Gwrm3D+en9FXlEU7cYW8b9VyyE0TdrnI1shs+KmaB7K5NanEL03tcD2CdLHr3Gz0caqbN5b2tdGAczb9tgrjXfXp/BNxT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8db149-da06-42a9-d6c8-08d832efcc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:14:38.0046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNuyn7o5lf7ipY7254CqwyQkvEb9kmPt0NBrB6cRI9BM3jAWJmd6uZ58R3wDzUNmHxNefTNAOyQObtXpLJvLk7+8n8T+qKT8ZspHNS5bipU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5867
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
