Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C47B5186
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjJBLiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:38:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61AF93;
        Mon,  2 Oct 2023 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696246688; x=1727782688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=559geUwyZstXHJ9XfMUcLU/LCCPNje59KbIn5unmxJo=;
  b=Io2fMJYFLeQQCCG/t7Ql9z9fbPQGggqSfPpXOgWT+dSqSDmCp/KWt7/b
   c6bsfliER7lJl2hxt0UQbeKcl36yeCA6TIm4r/pOrb89nfKFC81RJ3Bao
   9XOhuvd0lgWwqfmAlbOI7h5eu5A67vU/2FrkIACU+PjTkt7aH7R+b1xGm
   L0TU9E9r2lixVysccC451j6Q9hxVkcU6pauQasRjD1B52BCeUDnwGbP8j
   VY2Ul9+vtX16iDCHVcmBQAnTH5sVotjLcTpIUGjokQiJK5QlGzsqsnqph
   4LWtrax2slelNfllPPRP7aokJo0NsePlkYiSDpQpwgxjlkbG0MGiDNnwq
   g==;
X-CSE-ConnectionGUID: TRz7nBFTRS+a964Kzm/OYQ==
X-CSE-MsgGUID: mbjHTY/DSp2GBqmvdVqYeg==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245787533"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 19:38:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+4Ux0vxYCN6tstqttlJcX97GDX4dyoRaP85X0ZYuQZ1Q8FpFZCx0nQ7lWztQuUU40AIXJOCNs6i9XdJmzngECTGpdSYaj0bt43P1+TaEk6veyM8e6NgrmisNKXxfGWFEoqlTCNUfaWOGwXZihoyZBswDqjXSfa4jacDIszD8NJlcf7f7YUCjnb6QWaUSbqZPOCGbUldiSIA9Sscq6hsDQLmcSzEpozgRoZ0doleLw3MKMogpZ3dilSD4HZITosSecBhkHrW2Nyx6iYl9BLSvx4kWN/xqPIcCJWZJ+UvrKFW7sjMu+pYYuHDGbY4xF7hyY7tlgJVsFrnkER05bT+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=559geUwyZstXHJ9XfMUcLU/LCCPNje59KbIn5unmxJo=;
 b=RzZTSbcCYcfbd6Z9uNSWRQQ7qLnoNXCOw0dFPg7VLyH9YftIIL8S489vEgtN2Oaqspil5EHMV/PeEbwCSDGCT5yK5bPzgdwLlWIumDl054K+8PhLAdav8HY33jwncgehEaPV3Ne7gyc/2fyz1GFkEqWyS6nhaM8Wi46apxhNivf/sIYIM6YdFG2ZkNLMItSnprGlnIkiibrtqcw4B/WhElEGKmeFUZ2jVVWbDCLri6W1CNiskdwEOvEnIOftavuCw16MuScuK/jM/dNSYN3Hs3wixw0g3/Y5TPdcmMtjorfypxtLCzhKfdFysxlCl0nVtPGImELPd+gcO/eInxRTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=559geUwyZstXHJ9XfMUcLU/LCCPNje59KbIn5unmxJo=;
 b=TOmh5ZjTdo1WphdChLQZAqcU9zL/zY7DPaZQbe1LowArHRt93ZBYUcTIUtUUcEF+okYjSe9pyEKQu/kk93X3SIIj1KKvp4AywRONkPsz6Ln5s6XM3lV6twUb4ZvPVTGjRY7YCU9dU5HrZKY2mFBlu81uCicQiHcHPAH6Y78+Rck=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7027.namprd04.prod.outlook.com (2603:10b6:a03:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.21; Mon, 2 Oct
 2023 11:38:04 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 11:38:04 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Topic: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Index: AQHZ9STkFfj1sZp8ZEmkxmgvdKgC9w==
Date:   Mon, 2 Oct 2023 11:38:03 +0000
Message-ID: <ZRqrl7+oopXnn8r5@x1-carbon>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7027:EE_
x-ms-office365-filtering-correlation-id: 29deb5e4-59c5-40d9-c5fa-08dbc33c0a22
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKf7p4ycP16mjvUp1PWb/510Cp24jtol8ik1R8iHEOCnzvJiDmQdX/gurRqP1YOE8r6U6eNDU0AnZosiiRpTuakaVNrXTrKXJQzWxoSmtXBZYDHyJRYHWtHevuJlluKpoBDR0bMJg0ogpGLnQzpfC+qPXuXRGpbQh/oelbiHE5kPiQ0g/4/+lp6GFF5ndubxMcEkJnPhhB6zlVS0dgrT+sl6TM/Qz2djQ5OBsgi1tyW7W5dFSXOv2JEkT9brWc+8chPTivQ/UnRAzZS7F5+6eB+aZWtCpqBCmLEn5Cnb/Gq9VimCQeJwrMd09uREyePKrOjFtLhMGF8XwjXJXJ2GXBr40gmETg+jWTrPwGJIl0RMNYI2MEXgcvFnK2q0hzNBgQJp4GRVoabDcl1A2dZ9sSTVnxGEDIoyAqH41/QbbDLfT8YIMy5QdZRqhbg7WvFU324PxnKFccj1ovkPqgMuNaHI80TfVtdeD3jjGWux6pcVX+l0l0d/WZYURMXz9ea1AbhXWp1cjzroAM5ZmA6rrp0+8lPdFg/obixDiRBPqBCR/n2/80+Bx6a5FWiPfDI7Th59xpDhPbff5KtfehDlWIydqa7Fwyr5ZXQCVtzkvZ+arCy2YRDyWIrcod3FnwTSBdBH0DA+Mf7CarSvHpDW3cSwRHRQoX9iHA3jq4IZ/M4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(6512007)(71200400001)(6506007)(83380400001)(82960400001)(38070700005)(122000001)(38100700002)(86362001)(33716001)(26005)(66556008)(66476007)(66446008)(66946007)(316002)(54906003)(64756008)(6916009)(91956017)(76116006)(41300700001)(2906002)(4326008)(5660300002)(8936002)(8676002)(6486002)(966005)(478600001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g1VkhCx4lmECcGhGa8z+Yk2V8kiRM3bOtxVrkUzHtkxBTJUZ+5ovisvO2O/X?=
 =?us-ascii?Q?p00JGOIhUpxsgApq/TMJkENYhFDnw3IlOXUIZS24mzHAqdPokac7DMNETCcH?=
 =?us-ascii?Q?OWHsPkXxZVatSfKOZVbzElglQo9aQx0/Hw1Hskw2K7Sg1SznnfI2Rd7l/pEX?=
 =?us-ascii?Q?MWIbKZkBF9qHH41faKcjkvrwllVF9O7251zzJGSlaXhpd0WQcfqNoI+Ur0/6?=
 =?us-ascii?Q?4/qwka0HRIusVh07xAihi9Co4oyofZ0hcqYTsKeCU7958Y2lds12HSLCUY85?=
 =?us-ascii?Q?2lvyJ2TCH+thaf2QVPscD4VpqykknchdITfRLqLy4NuRZoxMhHgiEAfsag4M?=
 =?us-ascii?Q?pnNdvfEBn14ZxL8VI/cKLVq9nQTKxt/4j4Tk7HI4jjB7nf+9lKED6jsQGQ7r?=
 =?us-ascii?Q?kZN3ovlt7miff4DDOPoDtd1mMfLrF07EV2/A8TmND7BXfkUUbGiaA6sZ3X1+?=
 =?us-ascii?Q?e6w1EVGD/xiHbmhCzwujs0q6qMx45/FIuMuYeZp80l0lCtFHRtTjUskHaqRN?=
 =?us-ascii?Q?xhtfsIg8bUPXgJS/vEGmdUDh/YRH/jniMw0iN/5nnAGmGRCD69DLGcFbGRLA?=
 =?us-ascii?Q?Sr6EiGKDwM3EoWfLr3uM/r/viz62+VYbAp9OZlTNGOKB293JdMSjATcYK1Gm?=
 =?us-ascii?Q?yc/SSOtstfUiY78TFF0bNpvKOD0K4UoTfmWUy+4P2noC2QmyT75LF39hk50+?=
 =?us-ascii?Q?X3RiW9coMWzO5LCwSWyIofPeR64KCnLOMKJbswygYmf6EcPen89L3MiuLa2D?=
 =?us-ascii?Q?xPC2ZeXBldfDCkEhLVKW/Mp3ehuAWSb+MgcPVyvdei6MJcN8BQKj2JkLTieE?=
 =?us-ascii?Q?IT51l0T329NkdzNLHzlNX0C4Vm4Piu0A5VUaW5uBtgJ7jQxTNuesG7AwlYwv?=
 =?us-ascii?Q?eUuhmWZmfatNft7nTXA/GOZEJbIlG5JtJNSkKeq6fq5YwuxscdB8AdCi6w55?=
 =?us-ascii?Q?NQK6cEwwoTGIgHXSErv03iClPhry4CpSi2Fp3Ru2n91gyKWYUTW8GMONfYMH?=
 =?us-ascii?Q?i1fuMxQizS87PdwuBNmNpGLdBkIEjALr3htjK+qxG8CXwYde1Ig1zkZAy66s?=
 =?us-ascii?Q?kjypkazaXVSuS5BTPNbWggvf/OkD01bqegHzgD40A2XpVQT2SmHRpPwpUnTq?=
 =?us-ascii?Q?PrZlz0dRnp5ru+gtUTxpx2ylDQ3RrFgSNZFW407fRWYJhpe+hop4YTrXI64T?=
 =?us-ascii?Q?Nr1/a/nSnv+i48yKwZeX99iQhPov1yG2GsqgWu/XqNTRjhmRLGIL5n0VbdpV?=
 =?us-ascii?Q?k3VH+aUjXzHT41A8c5nDIvFQYzoPOrbfppxAKVEWkxDYd4ScvZ7qdioMnFbA?=
 =?us-ascii?Q?qNNgl6ta8AIf8c0B2GJW6iTFihQXbsnjjA/KPtnTiQ9soAn8DwuN+xIjT1JF?=
 =?us-ascii?Q?sytUDHE5KzEvJDzYvW7wM9mT/cEn+cr4ARpJnaB7jS1J+C1/nfvsZ4/swik2?=
 =?us-ascii?Q?xhBpC6A42ubK5LIfK9P5ynfkNV6O9WTPvVvusOQy4YbmN6tJtyWTma3CKPQF?=
 =?us-ascii?Q?nPK/a2UpeQ+LiqX77/JI/OJYTInkJOH5Z9v4et6MuYrTxqDH3Pr7ZBBDd+yT?=
 =?us-ascii?Q?HhqCMhCS0qOzwxzvzJ7cUXdfPgVoPcpBVD3Ykrm7QMSNLL4lHTZEOyDoPV6V?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBC83B73247D5844890B3049E0132F2B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: feAcvEbJBi/FTmDXbCTofb+vtom+JiFmpjnY0BbzZEmreVGqB5TOda/1+j4uK8fmww/n7DBzBxRNO5xAU0/wNEi3TQQPTMZjzrDseAx4fvweG/lwuClvTe4h1N7ZroLkqKUjBH3IV4FIw7NnQuvlSN5x+jlS9LYlzZK+PDcn7PhfrU1jitBroFTeD8vegZCaW/kzZflc8VloDpIuWGibYWWsI5GwjAHI0gvWknVrQcHH7CrJCS13rQAGrlT6SkI4Q8O3WcNkcW+UUrv5fuPmmdJwKCA1RbQFRwEya8T5QUa9T1zfnKtUoop6WUVJE6MTHKAdmJce3qLfGJP7r736QPn7RW5j2VZ3C3/NpCYnVhxH+pxOYLF/zX1buJjD+VjB+RhcNa2tCtjHV2yiYnZzqP+Sbsqgx49p/6YLOXLRIgHMx5jPobe8L1wUavPgDR2RXcf1Qd1CO+3eRYKhJEDlCYmzL6E5FrqNhzhRQ+I48YwpDqPoHAomXechEpBEQtKxrIEhW/68pz5zuBCBW6nA4qx/Rgpdv0/IVOki3fvteV5QTYpxx7zeTQ+1/FOx7h53qGx1AyT8N2GjTvTn4xRwGmyL0jAKAJPA5U/GGlASz11pYnUN+bw5gFXJTtC3Ii1l6vzNNYP66HYrOcBI9xREmpwK8dP8ujk1Sn4e8XJZ4xzPH3gjpMqCXeX0tGz9DwHnMvX4ql6xm+eRvmO1fGC0L6UmukCH9U0vNDoIrzLkylETB+Jw7MaGpeTNsvfDtOlH4Or1fEowz19wdYWj/lY2ywcrkdn1DX6FPph7lGAFv6v0Rq4P1oInp7VrQVUkra7LFXt5dUzNh4VYPDzgho8rYjLzmQS2ohIK8aGWDigiW6T4qKIDEaseZZUIyDMUebsFUWPg5fEJ1jS/aRaEb3eQ3g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29deb5e4-59c5-40d9-c5fa-08dbc33c0a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:38:03.8490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dReuB8zSRHGQDtEn5/yJg7vkrFPAAMWKiX+SkUUOpKSZy/RNwv8VE/jnzBCLTu2PSPA+FC+wzx0uwwppDjKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:14:10PM -0400, Martin K. Petersen wrote:
>=20
> Hi Bart!
>=20
> > Zoned UFS vendors need the data temperature information. Hence this
> > patch series that restores write hint information in F2FS and in the
> > block layer. The SCSI disk (sd) driver is modified such that it passes
> > write hint information to SCSI devices via the GROUP NUMBER field.
>=20
> I don't have any particular problems with your implementation, although
> I'm still trying to wrap my head around how to make this coexist with my
> I/O hinting series. But I guess there's probably not going to be a big
> overlap between devices that support both features.

Hello Bart, Martin,

I don't know which user facing API Martin's I/O hinting series is intending
to use.

However, while discussing this series at ALPSS, we did ask ourselves why th=
is
series is not reusing the already existing block layer API for providing I/=
O
hints:
https://github.com/torvalds/linux/blob/v6.6-rc4/include/uapi/linux/ioprio.h=
#L83-L103

We can have 1023 possible I/O hints, and so far we are only using 7, which
means that there are 1016 possible hints left.
This also enables you to define more than the 4 previous temperature hints
(extreme, long, medium, short), if so desired.

There is also support in fio for these I/O hints:
https://github.com/axboe/fio/blob/master/HOWTO.rst?plain=3D1#L2294-L2302

When this new I/O hint API has added, there was no other I/O hint API
in the kernel (since the old fcntl() F_GET_FILE_RW_HINT / F_SET_FILE_RW_HIN=
T
API had already been removed when this new API was added).

So there should probably be a good argument why we would want to introduce
yet another API for providing I/O hints, instead of extending the I/O hint
API that we already have in the kernel right now.
(Especially since it seems fairly easy to modify your patches to reuse the
existing API.)


Kind regards,
Niklas=
