Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7BD672EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 03:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjASCVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 21:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASCVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:21:10 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F74521E8;
        Wed, 18 Jan 2023 18:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674094869; x=1705630869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8xXfXcs4I/0dNQV95w17O5kDUdCj6JZsIfVMCXFO3WU=;
  b=HNxaEGMhqlTAtwyjARytrG54emXht4y/eM1HN8faIM6niyNRpv4DDYVR
   h1qgNE7HwylWFw9aRu71/eXswtibhBJxw1m7UQNq6rCF1eZy5gEs1bwTT
   XLdcgCjmsi0ATVDp9+y10HQN+kNNyrwpE7mrhl5mX/yrY+5vXeUZkwyGk
   NJv9z1oVgcdBSxdDlAxMpDoRQ4YHO+PKnQh/YyLK3fiWC9LU93GC/l4tJ
   Gq4mTcQd2xG+lHDrmdUqb0f75tL7C9YYyEmxb9/C7DsBwYlLGAD3Rtfto
   +PqEtJhJxLrPoVVe8GvVzVzpwL84Y+7duKM1Yz1khpyX2VIBozT0h/CQz
   g==;
X-IronPort-AV: E=Sophos;i="5.97,226,1669046400"; 
   d="scan'208";a="219514541"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2023 10:21:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndTpq28gPANe/AQIRRqmEnkdjueIB0ekRM5vnlCMTsnhl38pY4lRwVwwN4cBNyQ5p2gZ92O/Z5W6fGyuk0owtZjTiP2KroBgdXX3UVAIuiQVFZCoLJzWPkfUoQtoLV+zwtetsubhWj+whpEDbXdPxJAsxaKE5pfJ6s6Qelh7tjb8hgZDeAbzef46PBh7CXgjTYOnt+IJouojBBECnZ77dul8VPYJPXdmSGNk/LjnmbEOTA3rsWLuUoIJVD4LbXIVqVqU9wkurgm56zCLIrwWfF1qDAZdd4RTc8Fo60WF9CwlGJPsAlVAVEHmzmxUJ7qE84PGWil2l/9kV5ln6QMg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xXfXcs4I/0dNQV95w17O5kDUdCj6JZsIfVMCXFO3WU=;
 b=BXzibLV41kdeQsPkUOxVmUcLCmSARpK1cxU5pilTQm/HrGZ2Fr2Xi+1e94QIdFZspjs0uHaKPIA7KJPZrDZiVDtDQGc1mjoJws3Ef24Rn+XJqn59aK7U7HGuSqlcHrTI3wCePsYMnBVEbyG8fbFM+fsXGtoxJJAWxdgjWpdD2pnIyYWlyINDxEoeLGk7fqt0jpq0CeiZxHyiAB+Yv+cKcTGibDPlhAzrB82wgCbkReqGEfdAZmz3onWV7Fxhdo6nymaDXguyL7R2HtZThT2FalwHtmZKl0c4LwV+9MSAX7j7nOB7gW1545xqbcCjHeKy+96KtEbeMdNJBT4yX/dIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xXfXcs4I/0dNQV95w17O5kDUdCj6JZsIfVMCXFO3WU=;
 b=Oyy9MAnny0DwdyHO99Bq1lIPg+pEF7sa8xyn+ZSMSWKLOi+BNQcKeEspfMIzeiAY/GsCRCtqV7Itac3lro6RvdgQVO+YQL435MOy5sIBFRine66A6+r5OUGezAM+MK24Di4r+uCGrR0Y2by+TfOWr7po45FDW7/o+f7WDuPJO3Y=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB4305.namprd04.prod.outlook.com (2603:10b6:406:f9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Thu, 19 Jan 2023 02:20:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%7]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 02:20:59 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org >> linux-fsdevel" 
        <linux-fsdevel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Theodore Ts'o <tytso@mit.edu>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, an
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, an
 expansion plan for the storage stack test framework
Thread-Index: AQHZK5fyQKUFtoPftkeiJLNotrztl66lAiIA
Date:   Thu, 19 Jan 2023 02:20:58 +0000
Message-ID: <20230119022056.plpe5wejji6gl3fp@shindev>
References: <e24383ca-8ba8-3eb3-776c-047aba58173d@nvidia.com>
In-Reply-To: <e24383ca-8ba8-3eb3-776c-047aba58173d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN7PR04MB4305:EE_
x-ms-office365-filtering-correlation-id: 63fee9c3-1b1f-4509-4a59-08daf9c3cd8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 91cLSjZxDlyJbNr/xcnas/y/VKyOnpM7eRt4HmXmzYtUTVRHLkzUJg72rwLNuib5nFuegY+L8mW85EP3pTuPOjZ8g5G1r15eKEJLF+lm8dUIx/OrBDMruYh+lXrleinRIh9QzqK231ykzTvpUJWp0NSbN/XY3ru8rjDWoYnyxPej5WTcDhDS9Dm8MB1BKQvvpMACj42LwA4WSxuQMVPvx2SOhtW6Q49gRQ/HpAtQrEyk2Fw+VBDcFu5Gc1zY7gRLFh/FgoYIhIKDiNN5L5H57K5rfIIq7KHr/r3YDN8qPIQJzl+TkXKGlqm1tqaR/G7lVHyxJEXnbD9Y899Gk8gvwZcSOnMSV3KaVQH+2mAj2Fzp5VxT3x384+GDksou2cmTrSC6lWe3yX1R2aAFRtluk3sWCKEkoQUux8g36ZUj1V89Dh60QBd25uuF8AuSBXdJ9mjQVkS+IIHVBpNrecfDbZx+lSyvN5XCHL9JDjJFfdM7hdDw+hf9r2rPTelYAOmcjdnwumFxbPL/fFeuiIA9eDbJu2Wh5RSMkDa2oarvPdlNhfmCGenWUrLDDabYIKULmlgoCvowWM7Lskhq+utbq1+w61qJFr7oePcdJyM1PNUvdH4KVv28utp42CQGyoLIrDT/f4TFmeF7kY/LGYD3CMQQSdik9PxnVl0++szO/wdVXl6qRF5muYSKODNiKGUzyh+jo4eklY7ay6P5bEHXJZ4919mAEAgB/0rSHwvURAy+A2hxmLixfs6piTSj2Y81iJViyn5MnJvjj1NYj/KN4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(83380400001)(41300700001)(8936002)(54906003)(1076003)(316002)(91956017)(4326008)(66446008)(76116006)(8676002)(66556008)(6916009)(64756008)(66946007)(66476007)(82960400001)(38070700005)(38100700002)(33716001)(86362001)(44832011)(7416002)(2906002)(5660300002)(122000001)(71200400001)(6506007)(6512007)(9686003)(26005)(186003)(966005)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m5pHjb4qS4yWHCB48dWySdcGpIUPbKBPfGcKNYR1QxDdwldxzwTnktwr0I?=
 =?iso-8859-1?Q?XKSqwS2FhWazUfo3l1UDJZTzXXk+BCJp8v8iPfR53knl6KIrCzftDHXKDE?=
 =?iso-8859-1?Q?ui87oxcmCw3VNA7MTdqFIzPM+UwladUY4AHUQB4b5q3y4uj/PaDzcjiS5d?=
 =?iso-8859-1?Q?IuW7lZWFj5vssDzti5ZzBgFhxudCrEEBZwOOyOV0w2GLdjVOa45FVAd60d?=
 =?iso-8859-1?Q?BO+Cgqn/i9oRX8JwAHMqTMgio/zGVsP3BPUjrBTgL8WGyqvhzFutAyv4kN?=
 =?iso-8859-1?Q?DpHRHsxHCJWe2DnkxHfIYraQ4EmM6TvF6ZwW6EYp1I/r/Xmno9BxlPdIHw?=
 =?iso-8859-1?Q?EH1Fp7dDYXepjY9Vdz8QqNb17Jkegbbz3TReDUOqzln7xEslLuACdd67N0?=
 =?iso-8859-1?Q?UPv0e16g7NZ3KpM802UWZUMBVqWyrcAJIiQh3wJ27lvX1F94lluLXhtTtA?=
 =?iso-8859-1?Q?mKqO8dsqXwdSruyx8OVVqBtPfeVHf9XJQ8YJtwD0dlEelS+wDwFC00/90A?=
 =?iso-8859-1?Q?dsA5S7lDOBPmca4v4ekd4OZTy8WXOzFCOVcwGp1csNAhAcEmGxuNoZ9dsC?=
 =?iso-8859-1?Q?EMajcAFaFhDrznNT2XafdlZ2F+lkL8ryBYIQCEb+pl5j98mdsNlcOHre/G?=
 =?iso-8859-1?Q?GRW6ApEh3ziJph3iWJyVJF1wetKgtyMl+W786p3btXoWWCFEm2t1kGqopl?=
 =?iso-8859-1?Q?HHoy/9kZujQh6cKt4vQBk1EEk0jebOMCxejkUhLR7xPtv+Yiw+Z2NJoeDn?=
 =?iso-8859-1?Q?eWMG8AAL0hTRYmkVPA9A2YSbOTScYHlCFYWxQ9UJCPVyE/kLLeXpDfBu/A?=
 =?iso-8859-1?Q?e5YZ/fyhoWAlNraCDFhEw3ClbZGUGAewLRQC//UiqaNhr+exK8VlfKpusk?=
 =?iso-8859-1?Q?kQXt6he0/5V5riTlV2IcYsyQP4HqJ8c5bDIM1oocyUV2707hDWDLHFQ5Z6?=
 =?iso-8859-1?Q?+k31E7B54U3qGmG7RCdhbJALQ2yr4pcV8AXo6QU8spO2hF6tGBFuQTbBEv?=
 =?iso-8859-1?Q?gH+cqb8AoruGjQOTI9ijT+Wtvt48WPBkGlluzDBY+gl6fb3+Z0vx2l1j8j?=
 =?iso-8859-1?Q?HQrtJBts6EuCAdXn+t5F8IOPvmo2Zn9T7hfUCsky8sUiSl2sEGPR8x2qsU?=
 =?iso-8859-1?Q?bQP8L8yEWbBKDMeSqyfo7VyYev+7Xzeku3CRye6SCx4gnUhnHrKCnkqzvB?=
 =?iso-8859-1?Q?Re6pSoncb8TDT5Uq394gAae27zgIPrmVuAIfaK8Y4/0LRfHuA7t8LAH3KM?=
 =?iso-8859-1?Q?5H4pbh4ESjXZOkWLW1sGb/WPlChPkuXocos+A/h4DBHJ0ohYaiJoEqQAXz?=
 =?iso-8859-1?Q?2eZYFDb1E7xyHOSFoZNCrN4saZSSA3H9kdm5jpQXUiDIQYjx4UPRvQxO5a?=
 =?iso-8859-1?Q?sUUc3qGAB1s3gl12WIDTKMsBnS0/o6A2h7de7vgN9TKiSu6Rm4CDImxPfg?=
 =?iso-8859-1?Q?/z13HQfRxQsd26fD0VTFnPNHtKr/EDq7uMEr128EaFHZDCq8YF5jaRJlXA?=
 =?iso-8859-1?Q?rtUEEfjIZAVSABdrE9ne+3cC7eMHLjeRocum/AcudmndvOM9HjBmDXj515?=
 =?iso-8859-1?Q?LkNmCV9wdUy6sO0/Pcz97s8v8IKpMoOAr69IZLE3YOCBcIwC/xt7lXTk84?=
 =?iso-8859-1?Q?IX9Z0Uq9f+mcLlzomd56t9HIwoqGY3rkWEoK5dgNnuaZBy1Mdk7BedvZ/g?=
 =?iso-8859-1?Q?eRaS3zs8fHvfwodmTUs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <21C4C46D6B5FCF49AAC0C94BACC80191@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?ubKLDmGVwjOOmZsMHFLxuYJOps3Dupxv/LmXVOdTYIRQj6IuAlYJo7c6dc?=
 =?iso-8859-1?Q?xTxKDfFZsanS5CStpuvZOXiIvmh4sw85E9XA0JnsulF2GPFuXMTW7ABCBx?=
 =?iso-8859-1?Q?n6hGtWXn6CGRCeP1LstQ6GNT3MK7yoikH7yKFoSQUe6bnrUwvKjJUFyytf?=
 =?iso-8859-1?Q?hm3pm+BKKunwtZeopp9hxkMzb9h9KEOc4asryBoqhG4HjM1sRCpt9g6A+q?=
 =?iso-8859-1?Q?11eFhNJxviZQf86H8smqlP9gyaneEHcqT6XkNcKRlCSvQuILeMWhark4kd?=
 =?iso-8859-1?Q?NrXNeRUbqWlnLgTLUq6bF9BYjIcb3/Luw86gba0JgoVGNvpYvcA98HozAn?=
 =?iso-8859-1?Q?9ldzVFTYj/jfuc6lave4akzVRC6VQBnmMNfUA1orZIBGEOcRagEApGTW2D?=
 =?iso-8859-1?Q?SYLsoQcLygrPomkbJWLtYq0+I9WJbSqX4+HKL6mNGLrXQwfiiqERC7fx1d?=
 =?iso-8859-1?Q?UL3I927koiYpefPvmIR7Mg7+dindry42RXGyOHw2Rf2fXfQK6sZhjI6s4l?=
 =?iso-8859-1?Q?AwGa8P9JaPI2buBflLK2tVoUIqjGGVRvzFWiO19AoUMovd7Yng/ogU/0YS?=
 =?iso-8859-1?Q?RglEUxZIQsCoEp50G6LlnSfznIsZR462K55V0Pl8exS1vN1gnQyPjC8JfO?=
 =?iso-8859-1?Q?D5U/SbAb6JUMwbvlTAh8C46lTWvjUTD2qfTCwWYnhaSFBSVp/FlP1UBb4Y?=
 =?iso-8859-1?Q?cGPz9AJr7YfwywZsZawUHgElAWxtZ8bCVKkjoq0gkDxNHL3qmYjpVmz9fA?=
 =?iso-8859-1?Q?H2JKn6oDa/pkPZ3EhmGuxO34wY8nTS+Fufh4gx9k1S9oRKaFeUqlNvqITi?=
 =?iso-8859-1?Q?XI2PZQIZFUIt0cFXKFquzhaTlEHEHkMudUj6HbkDKvc3+HsUMtDi9rKdMG?=
 =?iso-8859-1?Q?quTF58NGRZd+kWKw3KWsOVa5qBkdFYY2ZWxXl60wruhzoCaZP5NqLCgZdL?=
 =?iso-8859-1?Q?01VVd6mDGJaNhaltHtNEpnADbud+IluX58HAXgWYBpMMNHlM0h8Yh3rjLM?=
 =?iso-8859-1?Q?G22uq72lf1T+bBOMKlu1XDhMsAmrW8dywmh1TzL3omSDHk/6TJn+ivlexZ?=
 =?iso-8859-1?Q?yWZ70m2iNDjFmzzsHeiyhWwQGbO7Pj5GJokwpPA9GkJGrgMlkMePmAhnuE?=
 =?iso-8859-1?Q?U01ckpM29zhbhDDyaIE2HB1aMvZ0MygfmR5zFmyneK1V2v4mkYr5y9efYH?=
 =?iso-8859-1?Q?N6mc7VGHkpw54fVivfFsFEcZU4tJheX8s/owVOTXPbHIUtxZHSmMiAO584?=
 =?iso-8859-1?Q?07W8w0PifsqWP7p1F4q9H870m55eZcwitAR4NpghUm1qHAjABKKs3sWLV/?=
 =?iso-8859-1?Q?WLbrD2aKbznd14pV3irMD2jl6g=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fee9c3-1b1f-4509-4a59-08daf9c3cd8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 02:20:58.8430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTfLdZ2esIRncGWFlVOlUO+neLEjMlFEpB6x+BFHChwnKdXiupwOlcKxYCIQ6DuDoPGrkOKfyQXgacu2IysOZLozvcvufGx/tO2dp5VnBFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4305
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CC+: Mike, dm-devel,

Hi Chaitanya, thanks for bringing this up! I definitely want to join and le=
arn
from the discussions. Here I note my comments about them.

On Jan 18, 2023 / 23:52, Chaitanya Kulkarni wrote:
[...]
> For storage track, I would like to propose a session dedicated to
> blktests. It is a great opportunity for the storage developers to gather
> and have a discussion about:-
>=20
> 1. Current status of the blktests framework.

In the session, I can talk shortly about recent blktests improvements and
failure cases.

> 2. Any new/missing features that we want to add in the blktests.

A feature I wish is to mark dangerous test cases which cause system crash, =
in
similar way as fstests does. I think they should be skipped by default not =
to
confuse new blktests users.

I remember that dmesg logging was discussed at the last LSFMMBPF, but it is=
 not
yet implemented. It may worth revisit.

> 3. Any new kernel features that could be used to make testing easier?
> 4. DM/MD Testcases.

I took a liberty to add Mike and dm-devel to CC. Recently, a patch was post=
ed to
add 'dm' test category [1]. I hope it will help DM/MD developers to add mor=
e
tests in the category. I would like to discuss if it is a good start, or if
anything is missing in blktests to support DM/MD testing.

[1] https://lore.kernel.org/linux-block/20221230065424.19998-1-yukuai1@huaw=
eicloud.com/#t

>=20
> E.g. Implementing new features in the null_blk.c in order to have device
> independent complete test coverage. (e.g. adding discard command for
> null_blk or any other specific REQ_OP). Discussion about having any new
> tracepoint events in the block layer.
>=20
> 4. Any new test cases/categories which are lacking in the blktests
> framework.

One thing in my mind is character device. From recent discussions [2][3], i=
t
looks worth adding some basic test cases for NVME character devices and SG
devices.

[2] https://lore.kernel.org/linux-block/20221221103441.3216600-1-mcgrof@ker=
nel.org/
[3] https://lore.kernel.org/linux-scsi/Y77J%2Fw0gf2nIDMd%2F@x1-carbon/

--=20
Shin'ichiro Kawasaki=
