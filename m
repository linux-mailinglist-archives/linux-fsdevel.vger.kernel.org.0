Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63895775623
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjHIJIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHIJIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:08:22 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C141BD9
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691572101; x=1723108101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bYxT5k0cKWYO4vowpmia8i/01E4F2MG2rBxHWoQb6CY=;
  b=UJX6c0rV6yYcdPombiPj2fxUcivwBvV7+13mvn66YDaKKnu8aAccYg5u
   lSYB/+UF7XtzvquRewo7/+AoDuHzVz+QynGHQEX+Xv2GHEk6Wk9dgWSUL
   OzuLZvDJGWAzuG1Ng/wqen64adFEi9jTmE+1pgvzivtXcCb26tLqEWB3R
   qRKIGJf8ijBfUwhwBWgeOzelUSLVlkD+nVzo8ptZd/iwOFa4l0CN7AMLf
   z0k0KOJA3tguc687zuDu2H/WLVif5aWhqgiLQ6jVem8JKZ/dmeE/a6g0A
   ET+xjSpJIYg5dtQ49STZtZaPTnz19sep7JCQLHTQibQIC/nZUXzeNpN9m
   g==;
X-IronPort-AV: E=Sophos;i="6.01,158,1684771200"; 
   d="scan'208";a="240418708"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2023 17:08:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1s131ZJ4ynuz0PQrSPvKkIRcnUuviVr4rhSo3WwE1OMWAaYGELn0pMH452AVW0GCNIE+g/uo6e0JMVfsRR7NChi/I3FlZmrin+JhCF1g5TdN8byyNb5AKy9md7sr/n67EduEur0E/dVN4De5z1aTT20YdsS3ql4NH7hVwaN3Px1NZzQm/9Rf4wx/l8P+g7kuRpoQ5Vb+2lAvfjmrUfLc/0VLI3zUidpCEIAT5vgQV/6BVUkeXBQEzXv0cO/jLZGbyO06lTsWGg5Rtah8Z18NeGhUErxDe4AOmr27u8ZeMy89/4xTHDqvnKBpTQqYKVs2UNcORi0j+mtq8Ly3F/HxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYxT5k0cKWYO4vowpmia8i/01E4F2MG2rBxHWoQb6CY=;
 b=FfYUsY1qTmuw7/PR/3FsEPgqLbOX5RhidwL3ibwaFnxz08mYQVfC9vZQdfzp4K7CUnqEVI0q5W7Jcd4KUyMdPaUgvNZVWXczYhPL/EeF9WPA3DSJnLw0u+yJSONIAVPIlhApn/Ns2fj7nNmnqs+lR2aZoAmxOqWFX+4NF+VypKrDM7Dx+Bw9RG+zlJbgn5x43vXFlUWp1QRxvRkzBMY0eTWk+NnOXM6TsBmfL7NQ+uhDNoWIatmwAYen09cZVyX4JP/MEcQw9biDjCQe21jPFKq8r1k4N2colUCkmkiQaLWrGivHfBYo5gRWWPtRSnSoGoCteoX8HsOvF0FTSc2zIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYxT5k0cKWYO4vowpmia8i/01E4F2MG2rBxHWoQb6CY=;
 b=ArmQas+AAWYFrzmfBqQztlVAjWxcBZMF+1bKmhfgGDfI4iBM/I1by0Go8IuSw2UYj0b0jCqGYYxv2E9Ojmx/qRu5JRbf4zATKSNTifYrQho3Z/WfpLtj4H7KOnysgXQtLS+JnJxnPpDOVg5k9uSOFaEjuyLAXSRx6TDtaea7kwQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB7971.namprd04.prod.outlook.com (2603:10b6:610:f6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Wed, 9 Aug 2023 09:08:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 09:08:19 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zonefs: fix synchronous direct writes to sequential files
Thread-Topic: [PATCH] zonefs: fix synchronous direct writes to sequential
 files
Thread-Index: AQHZym4tDCNQvNzpIUiYoP2wGb2qCa/hrSAA
Date:   Wed, 9 Aug 2023 09:08:19 +0000
Message-ID: <vrxildteooj62kofwbjofygl3wnot7p5vf23fjohgxfphw6zgj@4jeykkfpgk6z>
References: <20230809030400.700093-1-dlemoal@kernel.org>
In-Reply-To: <20230809030400.700093-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB7971:EE_
x-ms-office365-filtering-correlation-id: 476d06a5-8703-4d50-02f1-08db98b82ca4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upuKch+Yn0+AQIjIgRiAUZkKx5KrjLXJRijkpX8Sn37JmWHanQnLdGH7dqf3vTy+Gy5A4nOphyoU+hdUAK8YZbkFjxsJcnu/okK9WC75WsAsAKseZhPL1m7tCaY6k0vI4pByopuK46t1FL5+pIuxYsZbt0NnEZ6p2hdhvHgLybRY+JD2NbG6anF+riHMHHLp+TiMgxOuylEpnb2mNm7M0GmzRQIPIa4f8rOvLY+fQBFRmlTlwu2r8OIi66DTkaKD2sVMITxfj54YyD4oXNb/E29fvJNMi9ZWppiVew/W5aTQ+LRyzg/XvSm/3pRuiScxm50+Q9R4OjHJgftLpzf77mBuT69mBOYopr/p1+1wjtp903iuEgugaImZkUyzg58jI4vtZrqT6q8oztDFxTGhIe4z/yMLk7Cnbkm6NkGWeq8GZB/VDyVJONx+4VjTAbp5GK8RZCQZSxhoB0J3CyFJcIeny+WB7rHSbcnHPj11Djzbg+Ihg3a37FIkwcVh9j7zEKEojiIyoXrMJB0CK9FcnSwtJe9wP5JCKkrJYUiUa5/W1MXI3Pep17R2EArQ7dWVmOLEP/JAcWYsnOH3y58mNu+noxzxnXxXopeLfCh0T1Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(186006)(1800799006)(478600001)(9686003)(6512007)(6486002)(966005)(54906003)(91956017)(6506007)(26005)(71200400001)(2906002)(4326008)(316002)(33716001)(76116006)(64756008)(41300700001)(66446008)(66946007)(6916009)(8676002)(5660300002)(66556008)(66476007)(8936002)(38100700002)(122000001)(44832011)(38070700005)(86362001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2mIHaaslDOJmYdvvRlfrxUNp060KuhDvVZgwLq4kldXeYeMuC4Xd0QknN8lt?=
 =?us-ascii?Q?IMjY5uT+uMyKELTR0+ZPqoChiRK3gE8kB77JJLH03nW5RXO6LXu6f2+joOvY?=
 =?us-ascii?Q?CEKjt764RWOWlvJT0DNWe9+vOLxeV99/6DomZ0uj8g27zHhcNGE07QbqsGqg?=
 =?us-ascii?Q?WxgbrGKzu7OcK3xZFKnICWChtvblRVk6GqBQ4x7K6EJmTrlTeylD7XL7SdiV?=
 =?us-ascii?Q?F3PPVepDwqXXwstekWYK+feF8I9UIVa2xv0TIgYBty6IaLgEzRkdd0T5/9xD?=
 =?us-ascii?Q?BPNFRvLJ4TXmTe30np8/k30bed6ocCyw4KfC8KpxejfLtUjBg9gVEMoHOHY9?=
 =?us-ascii?Q?ZCjUbMTEj8uooopvT9K/5o+CZkh/LIc7FCYtnhshf0Dcp6lDKr12gH/zcevh?=
 =?us-ascii?Q?Ta3XSoNVNyvjhKupvy3NaDbnmr9DF6R3QlJribmq8REXAEa16ewS0pnG5WOa?=
 =?us-ascii?Q?FEP18JRixTGWxo4lJkUG8zpiPNxYBks6Ttt463APq0jwTTTBMCZHyCVNFrq6?=
 =?us-ascii?Q?epRyv2RLBchD9+B0yBiKv2prvlhA0mL5ggaNc6VqXt3rL+Axe/XZREZLJEbY?=
 =?us-ascii?Q?CRxcm1yNk4b104a6DVT5v94ZRwVI6ZUGmZAkUwUEYUorOAQ+/WMB73tJ6kff?=
 =?us-ascii?Q?yTnDRl7Ywr0q9CNfRxSSmBcTmWCqIF8PKre2kDYYpZljmNwWKggsNYwkDqpX?=
 =?us-ascii?Q?xlkypCDVatuGRLTgZIkHn7oCqn9STNg9rnvLyubSwe3xtS60ILxtmd/CRsYl?=
 =?us-ascii?Q?HY3FPySMemQeGauCSzOf7XyWRdi48v4c4fc2biqXt3uVUC8s2tgZDKdFkFoz?=
 =?us-ascii?Q?w0ZPmj0cQy6S8SJFb1gc3ROCoIL0H+vCBUjoiXX4QeWWmqR4U9f1Ul0chPOA?=
 =?us-ascii?Q?R9s3ug7dnHrqmnJUglv99OMLCGZquYzPQu3Kv9KO0e/cu++9RGK/OhVGvmpW?=
 =?us-ascii?Q?zEApTX5epEVl4kt9m0ngOkf2xyOAxjKkY4yi61/SJ/RPeCA1dZlwcFay0vmz?=
 =?us-ascii?Q?l+HSojUoBP0oBIQiQn+Kwt6zrPHK6KkFDuBI/PqyMSmIMYI6ItypKG6O47zS?=
 =?us-ascii?Q?MPjVcliyH9yc1aNzpFHkFALjiKxcQrS0oHCpSYXSO903TEagNxfGFJIS5JOp?=
 =?us-ascii?Q?6w2HnmdFPnsRBheEfC9QqrPRHFEt+8xgFRSfjLhWMXKTwFFxBwof1Nj3dfWi?=
 =?us-ascii?Q?+3KQb2PDUQUJByxDtmDG+AFCLK8Soa7gakPx6LRVhQVkD0K98mmoq7bCLng3?=
 =?us-ascii?Q?1r4lY4aawTH07+HOMZkKvJVrE4HagxCGO8eSCPmxuI/onInY/BM76Vz5SNm+?=
 =?us-ascii?Q?VUAHZ0SIaCbBC9RhvEyWrxDS9y2tqcryTNGwRnW8xZ+P331fJ3XrC209VXUc?=
 =?us-ascii?Q?JufomrWSmd1H4Pr2NzB/6/Ni7u5augG5+1PswGGU6KZNw2KLbf24kT6uq9jE?=
 =?us-ascii?Q?Wbbo2t1LXwtMmkVXYIFHXJUaHDZfzQt0N8qYNR+dIpNQsrC66iU5Dc/HztmY?=
 =?us-ascii?Q?XSeWGmUjsuBO0SNyo06tsHqpCqXqryzwWmjVjfkvKwP94T45QAJANLTd0Tou?=
 =?us-ascii?Q?Na1jI/OvUP7iD+k2pFkoasLKNfJHca7OWqQqA3mZgzbzF5lg5D+q3wSkbyoG?=
 =?us-ascii?Q?xJ6yliKRYgVYP0NY5RGkAFk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC2F24E88F7A1243A9AC42C2DF77C5F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jLWzqmOHwo/2Yx6acIW2Ht2bHVUJZdsDw3dOsDzGzGB3Lkig9wrFsbo3uk7bvZ5uAMW8Dw9UIMZGIqan8axEFiVuia3iSZfpB/0qIsZ4JtACxu/6Q2L71wCe7QegboSamBX9gliP1WHo4XCLLUnirPIcYJZDrXym6/7yJcNFvFhnGJZNuYpAxIEWDlMZxgrZevO/n4jlDLJmaAm8TWHahpYfvWfTPUraI3yDZ+5jI6nj8Q+FF1gNpBmnXMftlFjxSoI4b7vb7bdYuwF6pK5o6PAXk8YCD2+r1HuxKxzoVnOZOAfwxIqaP9ODLgkyL0/B6pp+H4XLCVobNoYX6oYSaw3gtaStFdrv8Oj4/lRrFDGeiDcNj77PFiI1BDokm96gGhwbiKSuFNp0HNxu3nHqq/wD1cBKAYogJuDzZiH3NRt2TrqZEgw3ddIwnMBEGwR9uwo/X1wJHlALrL5ue1fvlSXei0pFfCfvbh7hBlALMwkT94jwnoqqpBvOTFYaqr/z+s3rVTafftYV/WfmBJQkldjDLzJEg5QheMt9ZlO+QplNU45n8UGyV/JDQ9ijNfA5+bxxpRz2QeS248CE9PkllkPmB52FC83jlvlKbEpxU479kWlI9xbbGe3IPbf+ndo75nddOaxXd3oW2HEZbG8eW5PaxT03kPZXngorn8hLcDDvsgtwuyAEOywIe0tZk9rRq6espaJBrZiBgjUaKKjJj8/HwHV+7Ff/iMQOxin8B08ApZCzd8CxcSHQNv/477NZcM+f9KHNspHZjqbzTqzunrEBBeHp8NxEd4HjBO5uamC1MTM3jWwOnfl33DFmS1SG8q69UHMHYAghn1sf3HGBJw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476d06a5-8703-4d50-02f1-08db98b82ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:08:19.2950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQJ1HpPjClNeMbrouSpH/Jy39FObreeD1rq0wum8uio25WMR2WPcbTiLPclcSlb6O+ig3HCTOh9+caZqz+Iuw3YTnm6my/IrxeFaMLVtCfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7971
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Aug 09, 2023 / 12:04, Damien Le Moal wrote:
> Commit 16d7fd3cfa72 ("zonefs: use iomap for synchronous direct writes")
> changes zonefs code from a self-built zone append BIO to using iomap for
> synchronous direct writes. This change relies on iomap submit BIO
> callback to change the write BIO built by iomap to a zone append BIO.
> However, this change overlloked the fact that a write BIO may be very

I found some typos in the commit message. I guess you forgot to run spell
checker. FYI, here I note the typos found.

s/overlloked/overlooked/

> large as it is split when issued. The change from a regular write to a
> zone append operation for the built BIO can result in a block layer
> warning as zone append BIO are not allowed to be split.
>
[...]
>=20
> Manually splitting the zone append BIO using bio_split_rw() can solve
> this issue but also requires issuing the fragment BIOs sunchronously

s/sunchronously/synchronously/

> with submit_bio_wait(), to avoid potential reordering of the zone append
> BIO fragments, which would lead to data corruption. That is, this
> solution is not better than using regular write BIOs which are subject
> to serialization using zone write locking at the IO scheduler level.
>=20
> Given this, fix the issue by removing zone append support and uisng

s/uisng/using/

> regular write BIOs for synchronous direct writes. This allows preseving

s/preserving/preserving/

> the use of iomap and having iidentical synchronous and asynchronous

s/iidentical/identical/

> sequential file write path. Zone append support will be reintroduced
> later through io_uring commands to ensure that the needed special
> handling is done correctly.
>=20
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I confirmed that this patch avoids the issue that I reported [*]. Thanks!

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[*] https://lore.kernel.org/linux-nvme/20230731114632.1429799-1-shinichiro.=
kawasaki@wdc.com/
